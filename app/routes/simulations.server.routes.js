'use strict';

var path = require('path');


module.exports = function(app) {
    // Load request handlers
    var users = require(path.resolve('app', 'controllers', 'users.server.controller.js'));
    var simulations = require(path.resolve('app', 'controllers', 'simulations.server.controller'));

    // Simulation Routes
	app.route('/simulations')
		.get(users.requiresLogin, simulations.list)
		.post(users.requiresLogin, simulations.create);

	app.route('/simulations/:simulationId')
		.get(simulations.read)
		.put(users.requiresLogin, simulations.update)
		.delete(users.requiresLogin, simulations.delete);

	// Finish by binding the model middleware
	app.param('simulationId', simulations.simulationByID);

};
