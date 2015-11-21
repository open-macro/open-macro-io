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
function shocksToStrings(shocks) {

    if (shocks === undefined) {
        console.log('shocks is undefined cannot toString');
    }

    var return_obj = {
        shocks: []
    };

    // iterate over shocks from simulation
    for (var i = 0; i < shocks.length; i++) {
        var shock = shocks[i];
        // for each shock, create 6 'shocks' needed for shocks.mod
        // (shock_0, _1, _2, and _neg equivalents) and push each of
        // them onto the return object. This object will be passed
        // into swig.renderFile to be used with the swig template
        // for shocks.
        var name0 = 'e_' + shock.name + '0',
            name1 = 'e_' + shock.name + '1',
            name2 = 'e_' + shock.name + '2',
            name0neg = 'e_' + shock.name + '0_neg',
            name1neg = 'e_' + shock.name + '1_neg',
            name2neg = 'e_' + shock.name + '2_neg';

        var periods0 = '', periods0neg = '';
        var values0 = '', values0neg = '';
        var periods1 = '', periods1neg = '';
        var values1 = '', values1neg = '';
        var periods2 = '', periods2neg = '';
        var values2 = '', values2neg = '';

        for (var j = 0; j < shock.periods.length; j++) {
            periods0 += (j+1).toString() + ' ';
            periods0neg += (j+1).toString() + ' ';

            if (shock.periods[j] < 0) {
                values0 += '0 ';
                values0neg += Math.abs(shock.periods[j]).toString() + ' ';
            } else {
                values0 += shock.periods[j].toString() + ' ';
                values0neg += '0 ';
            }
        }

        for (var jj = shock.periods.length; jj < 30; jj++) {
            var endSpace;
            if (jj === 29) {
                endSpace = '';
            } else {
                endSpace = ' ';
            }
            periods0 += (jj + 1).toString() + endSpace;
            periods0neg += (jj + 1).toString() + endSpace;
            values0 += '0' + endSpace;
            values0neg += '0' + endSpace;
        }

        if (shock.ranges.length > 0) {
            if (shock.ranges[0].value < 0) {
                periods1 += '0:0';
                values1 += '0';
                periods1neg += shock.ranges[0].start.toString() + ':' + shock.ranges[0].end.toString();
                values1neg += Math.abs(shock.ranges[0].value).toString();
            } else {
                periods1 += shock.ranges[0].start.toString() + ':' + shock.ranges[0].end.toString();
                values1 += Math.abs(shock.ranges[0].value).toString();
                periods1neg += '0:0';
                values1neg += '0';
            }
        } else {
            periods1 += '0:0';
            values1 += '0';
            periods1neg += '0:0';
            values1neg += '0';
        }

        if (shock.ranges.length > 1) {
            if (shock.ranges[1].value < 0) {
                periods2 += '0:0';
                values2 += '0';
                periods2neg += shock.ranges[1].start.toString() + ':' + shock.ranges[1].end.toString();
                values2neg += Math.abs(shock.ranges[1].value).toString();
            } else {
                periods2 += shock.ranges[1].start.toString() + ':' + shock.ranges[1].end.toString();
                values2 += Math.abs(shock.ranges[1].value).toString();
                periods2neg += '0:0';
                values2neg += '0';
            }
        } else {
            periods2 += '0:0';
            values2 += '0';
            periods2neg += '0:0';
            values2neg += '0';
        }

        return_obj.shocks.push({
            name: name0,
            periods: periods0,
            values: values0
        });

        return_obj.shocks.push({
            name: name1,
            periods: periods1,
            values: values1
        });

        return_obj.shocks.push({
            name: name2,
            periods: periods2,
            values: values2
        });

        return_obj.shocks.push({
            name: name0neg,
            periods: periods0neg,
            values: values0neg
        });

        return_obj.shocks.push({
            name: name1neg,
            periods: periods1neg,
            values: values1neg
        });

        return_obj.shocks.push({
            name: name2neg,
            periods: periods2neg,
            values: values2neg
        });
    }

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
    var simulation_path = 'run/simulations/' + simulation.id.toString();
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
            var shocks = shocksToStrings(simulation.shocks);
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

    var simulation_path = 'run/simulations/' + simulation.id.toString();
    console.log('Begin to compute simulation: ' + simulation.id);

    writeVariables(simulation.model, simulation, function(error, results) {

        for (var i in results) console.log(results[i]);

        /// @TODO: handle error
        if (error) {
            console.log('Error: ', error);
            res.status(err.status).end();

        }
        else {
            // Production environment on Ubuntu does not require the
            // path to Dynare, but Mac OS X development machines do
            var octave;

            if (process.env.NODE_ENV === 'development') {
                var dynarePath = process.env.DYNARE_PATH || '';
                octave = cp.spawn(
                    'octave',
                    ['-p', dynarePath.toString(), '-q', 'run_model.m'],
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
