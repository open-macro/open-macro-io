'use strict';

var path = require('path');


module.exports = function(app) {
    // Load request handlers
    var users = require(path.resolve('app', 'controllers', 'users.server.controller.js'));
    var models = require(path.resolve('app', 'controllers', 'models.server.controller.js'));

	// Model Routes
	app.route('/models')
		.get(models.list);

	app.route('/models/:modelId')
		.get(models.read);

	// Finish by binding the model middleware
	app.param('modelId', models.modelByID);
};
