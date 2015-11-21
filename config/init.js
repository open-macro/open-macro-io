'use strict';

var path = require('path');
var glob = require('glob');
var chalk = require('chalk');


module.exports = function() {
    /**
     * The env-check function checks that an environment file is
     * present and that the proper (i.e. needed) variables are
     * set.
     *
     * Note: we do not terminate the application if the required
     * variables are not provided, merely warn the console.
     */
    require('dotenv').load({silent: true});
    require(path.resolve('scripts', 'env-check.js'));

    /**
     * Given the Node environment previously, check that there is a
     * configuration file for that environment in 'config/env'
     * Otherwise, default to development.
     */
    var envFile = process.env.NODE_ENV + '.js';
    var files = glob.sync(path.resolve('config', 'env', envFile), {
        strict: true,
        nocase: true
    });

    if (!files.length) {
        console.warn(chalk.yellow('Defaulting to development environment'));
        process.env.NODE_ENV = 'development';
    }
};
