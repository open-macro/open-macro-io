'use strict';

var path = require('path');


module.exports = function(app) {
    // Load request handlers
    var users = require(path.resolve('app', 'controllers', 'users.server.controller.js'));
    var output = require(path.resolve('app', 'controllers', 'output.server.controller.js'));
    var simulations = require(path.resolve('app', 'controllers', 'simulations.server.controller.js'));

	// Computes Routes
	app.route('/output/:simulationId')
		.get(users.requiresLogin, output.exportPlotVars);

	app.route('/output/json/:simulationId')
		.get(users.requiresLogin, output.exportJSONPlotVars);

	// Finish by binding the Compute middleware
	app.param('simulationId', simulations.simulationByID);
};
