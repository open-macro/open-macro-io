'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
	errorHandler = require('./errors.server.controller'),
    rmdir = require('rmdir'),
	Simulation = mongoose.model('Simulation'),
	Model = mongoose.model('Model'),
	Shock = mongoose.model('Shock'),
	Parameter = mongoose.model('Parameter'),
	_ = require('lodash');


/**
 * Create a simulation
 */
exports.create = function(req, res) {

	var simulation = new Simulation(req.body);
	simulation.user = req.user;

	Simulation.deepPopulate(simulation, 'model', function(err, simulation){
		var all_paramVals = [];
		var all_params = simulation.model.params_init.concat(simulation.model.params_deep);

		for(var i = 0; i < all_params.length; i++){
			all_paramVals.push({
				name: all_params[i].name,
				latex: all_params[i].latex,
				notes: all_params[i].notes,
				description: all_params[i].description,
				default_value: all_params[i].default_value,
				value: all_params[i].default_value,
				equations : all_params[i].equations
			});
		}

		simulation.parameters = all_paramVals;

		// Init initial shocks from model
		var all_shockVals = [];
		var all_shocks = simulation.model.exovars;

		for (var k = 0; k < all_shocks.length; k++) {
			all_shockVals.push({
				name: all_shocks[k].name,
				units: all_shocks[k].units,
				description: all_shocks[k].description,
				periods: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				ranges: [{
					start: 0,
					end: 0,
					value: 0
				}]
			});
		}

		simulation.shocks = all_shockVals;
		simulation.log = [];

		simulation.save(function(err) {
			if (err) {
				console.log(errorHandler.getErrorMessage(err));
				return res.status(400).send({
					message: errorHandler.getErrorMessage(err)
				});
			} else {
				res.json(simulation);
			}

		});
	});
};

/**
 * Show the current simulation
 */
exports.read = function(req, res) {
	res.json(req.simulation);
};

/**
 * Update a simulation
 */
exports.update = function(req, res) {

	var simulation = req.simulation;

	simulation = _.extend(simulation, req.body);

	simulation.save(function(err) {
		if (err) {
			console.log('@ err ', err);
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.json(simulation);
		}
	});
};

/**
 * Delete an simulation
 */
exports.delete = function(req, res) {

	var simulation = req.simulation;

	simulation.remove(function(err) {
		if (err) {
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.json(simulation);
			rmdir('./run/simulations/' + simulation.id.toString(), function (err, dirs, files ){
				if(!err){
					console.log('All Files from ' + simulation.name+'-'+simulation.id.toString() + ' Removed');
				}
			});
		}
	});
};

/**
 * List of Simulations
 */
exports.list = function(req, res) {
	Simulation.find({'user' : req.user.id}).sort('-created')
		.populate('user', 'displayName')
		.populate('model', 'name')
		.exec(function(err, simulations) {
		if (err) {
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			var grouped = _.chain(simulations).groupBy(function(simulation){
				return simulation.model.name;
			}).map(function(sims, model) {
				return {
					model:model,
					simulations:sims
				};
			}).value();
			res.json(grouped);
		}
	});
};

/**
 * Simulation middleware
 */
exports.simulationByID = function(req, res, next, id) {

	if (!mongoose.Types.ObjectId.isValid(id)) {
		return res.status(400).send({
			message: 'Simulation is invalid'
		});
	}

	Simulation.findById(id)
		.populate('user', 'displayName')
		.exec(function(err, simulation) {
			if (err) return next(err);
			if (!simulation) {
				return res.status(404).send({
					message: 'Simulation not found'
				});
			}

			simulation.deepPopulate('model', function (err, simulation) {
				req.simulation = simulation;
				next();
			});

	});
};

/**
 * Simulation authorization middleware
 */
exports.hasAuthorization = function(req, res, next) {
	if (req.simulation.user.id !== req.user.id) {
		return res.status(403).send({
			message: 'User is not authorized'
		});
	}
	next();
};
