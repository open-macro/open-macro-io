'use strict';

var path = require('path');


module.exports = function(app) {
    // Load request handlers
    var users = require(path.resolve('app', 'controllers', 'users.server.controller.js'));
    var models = require(path.resolve('app', 'controllers', 'models.server.controller.js'));

	// Model Routes
	app.route('/models')
		.get(models.list)
		.post(users.requiresLogin, models.create);

	app.route('/models/:modelId')
		.get(models.read)
		.put(users.requiresLogin, models.update)
		.delete(users.requiresLogin, models.delete);

	// Finish by binding the model middleware
	app.param('modelId', models.modelByID);
};
