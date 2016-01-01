'use strict';

var cp = require('child_process');
var fs = require('fs.extra');
var _ = require('lodash');
var async = require('async');
var mongoose = require('mongoose');
var ncp = require('ncp');
var Simulation = mongoose.model('Simulation');
var swig = require('swig');


// translate from the db model for shocks into the string
// representations needed for the swig template
function writeShocks(shocks) {

    /// A shock has a name property that is used as a component of its variable name
    /// "name": "a",
    ///
    /// Shock ranges are specified as an array. For the time being there will not be more
    /// than two ranges specified. These shock ranges will be written as variables 1 and 2
    ///
    /// "ranges": [
    ///   {
    ///       "start": 0,
    ///       "end": 0,
    ///       "value": 0,
    ///   }
    /// ],
    ///
    /// Variable e_{{shock.name}}0 is represented by an array of valu
    /// "periods": [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
    ///

    /// return value used by swig template
    /// each object in return object array will have name, periods, and values string values
    var return_obj = { shocks: [] };

    console.log(shocks);

    /// bail if shocks is undefined, which should yield an octave error
    if (shocks === undefined) return return_obj;

    // iterate over shocks from simulation
    for (var i = 0; i < shocks.length; i++) {

        var shock = shocks[i];
        /// for each shock, create 6 return_obj entries needed for {{simulation.short_name}}_shocks.mod
        var pos = [], neg = [], periods = [];
        for (var j=0; j < shock.periods.length; j++){
            var value = shock.periods[j];
            value = _.isFinite(value) ? value : 0;
            periods.push(j+1);
            pos.push(value < 0 ? 0 : value);
            neg.push(value < 0 ? Math.abs(value) : 0);
        }
        periods = periods.join(' ');
        return_obj.shocks.push({ name: 'e_' + shock.name + '0', periods:periods, values:pos.join(' ') });
        return_obj.shocks.push({ name: 'e_' + shock.name + '0_neg', periods:periods, values:neg.join(' ') });

        for (var k=0; k < 2; k++){
            var start = 0, end = 0, range_value = 0;
            if (k < shock.ranges.length){
                var range = shock.ranges[k];
                start = _.isFinite(range.start) ? range.start : 0;
                end = _.isFinite(range.end) ? range.end : 0;
                range_value = range.value;
            }

            var r_variable_id = k + 1,
                r_periods = start + ':' + end,
                r_pos = range_value < 0 ? 0 : range_value,
                r_neg = range_value < 0 ? Math.abs(range_value) : 0;

            return_obj.shocks.push({ name: 'e_' + shock.name + r_variable_id, periods:r_periods, values:r_pos });
            return_obj.shocks.push({ name: 'e_' + shock.name + r_variable_id + '_neg', periods:r_periods, values:r_neg });
        }
    }

    console.log(return_obj);

    return return_obj;
}

/**
 *
 * @param template_path
 * @param destination
 * @param obj
 * @param callback
 */
var writeVariableFile = function(template_path, destination, obj, callback){
    swig.renderFile(template_path, obj, function (error, output) {
        if (error) { callback(error, 'Failed to render template: ' + template_path); }
        else {
            fs.writeFile(destination, output, function (error) {
                callback(error, 'Writing variable file: ' + destination);
            });
        }
    });
};

/**
 *
 * @param model
 * @param simulation
 * @param cb
 */
var writeVariables = function (model, simulation, cb) {

    var model_definition_path = 'run/definitions/' + model.short_name;
    var simulation_path = 'run/simulations/' + simulation.id;
    var set_params_template_path = 'run/templates/set_params.m.html';
    var shocks_template_path = 'run/templates/shocks.mod.html';
    var set_macro_vars_template_path = 'run/templates/set_macro_vars.mod.html';
    var set_params_path = simulation_path + '/set_params_exp.m';
    var shocks_path = simulation_path + '/' + model.short_name + '_shocks.mod';
    var set_macro_vars_path = simulation_path + '/set_macro_vars.mod';

    console.log('-----' + simulation.dsf + '------');

    var set_macro_var_components = simulation.dsf.split(','); // this should really be cleaner!!
    var set_macro_vars = {
        exogenous: set_macro_var_components[0],
        endogenous_domestic : set_macro_var_components[1],
        endogenous_commercial : set_macro_var_components[2]
    };

    async.series([
        function (callback) {
            /// ensure that model definition directory exists
            fs.exists(model_definition_path, function (exists) {
                var error = exists ? null : new Error('Model definition path does not exist: ' + model_definition_path);
                callback(error, 'Verified model definition path.');
            });
        },
        function (callback) {
            /// ensure that simulation directory has been created
            /// from model definition directory
            fs.exists(simulation_path, function (exists) {
                if (exists) callback(null, 'Verified simulation path.');
                else {
                    ncp.ncp(model_definition_path, simulation_path, function (error) {
                        callback(error, 'Copied model definition to simulation path.');
                    });
                }
            });
        },
        function (callback) {
            /// write shocks.mod file
            var shocks = writeShocks(simulation.shocks);
            writeVariableFile(shocks_template_path, shocks_path, shocks, callback);
        },
        function (callback) {
            /// write set_macro_vars.mod file
            writeVariableFile(set_macro_vars_template_path, set_macro_vars_path, set_macro_vars, callback);
        },
        function (callback) {
            /// write set_params.m file
            writeVariableFile(set_params_template_path, set_params_path, simulation, callback);
        }
    ], cb);

};


exports.compute = function(req, res) {

    var socketio = req.app.get('socketio');
    var simulation = req.simulation;

    var simulation_path = 'run/simulations/' + simulation.id;
    console.log('Begin to compute simulation: ' + simulation.id);

    writeVariables(simulation.model, simulation, function(error, results) {

        if (error) {
            console.log('Error: ', error);
            res.status(error.status).end();
        }
        else {
            // Production environment on Ubuntu does not require the
            // path to Dynare, but Mac OS X development machines do
            var octave;

            if (process.env.NODE_ENV === 'development') {
                var dynarePath = process.env.DYNARE_PATH || '';
                octave = cp.spawn(
                    'octave',
                    ['-p', dynarePath, '-q', 'run_model.m'],
                    {'cwd': simulation_path});
            } else {
                octave = cp.spawn(
                    'octave',
                    ['-q', 'run_model.m'],
                    {'cwd': simulation_path});
            }

            octave.on('error', function(err) {
                console.log('octave spawn error: ', err);
            });

            octave.stdout.on('data', function (data) {

                console.log('stdout: ' + data);
                socketio.sockets.emit('compute.' + req.simulation.id, data.toString());

            });

            octave.stderr.on('data', function (data) {

                socketio.sockets.emit('compute.' + req.simulation.id, data.toString());
                console.log('stderr: ' + data);

            });

            octave.on('close', function (code) {

                socketio.sockets.emit('compute.' + req.simulation.id, 'on:close:'+ code);
                console.log('child process exited with code ' + code);

            });

            res.send({message:'Started octave.'});

        }
    });
};
