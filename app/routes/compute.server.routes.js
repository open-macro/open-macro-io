'use strict';

var path = require('path');

module.exports = function(app) {
    // Load request handlers
    var users = require(path.resolve('app', 'controllers', 'users.server.controller.js'));
	var compute = require(path.resolve('app', 'controllers', 'compute.server.controller.js'));
	var simulations = require(path.resolve('app', 'controllers', 'simulations.server.controller.js'));

	// Computes Routes
	app.route('/compute/:simulationId')
		.post(users.requiresLogin, compute.compute);

	// Finish by binding the Compute middleware
	app.param('simulationId', simulations.simulationByID);
};
