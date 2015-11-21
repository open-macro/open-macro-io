'use strict';

var path = require('path');


module.exports = function(app) {
    // Load request handlers
    var core = require(path.resolve('app', 'controllers', 'core.server.controller.js'));

	app.route('/').get(core.index);
};
