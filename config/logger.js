'use strict';

var fs = require('fs');
var morgan = require('morgan');
var config = require('./config');


module.exports = {

	getLogFormat: function() {
		return config.log.format;
	},

	getLogOptions: function() {
		var options = {};

		try {
			if ('stream' in config.log.options) {
				options = {
					stream: fs.createWriteStream(process.cwd() + '/' + config.log.options.stream, {flags: 'a'})
				};
			}
		} catch (e) {
			options = {};
		}

		return options;
	}

};
