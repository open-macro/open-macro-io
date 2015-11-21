'use strict';

var fs = require('fs');
var chalk = require('chalk');


/**
 * Please create an .env file in the project's root directory
 * and provide these config vars at a minimum
 */
var environmentFile = '.env';
var environment = [
    'NODE_ENV',
    'SESSION_SECRET',
    'MONGODB_URI_DEV',
    'MONGODB_USER_DEV',
    'MONGODB_PASSWORD_DEV',
    'MONGODB_URI_PROD',
    'MONGODB_USER_PROD',
    'MONGODB_PASSWORD_PROD'
];

fs.open(environmentFile, 'r', function (error, fd) {
    if (error) {
        console.error(chalk.red('Error: unable to open .env file in root directory'));
    }

    environment.forEach(function (evar) {
        if (!process.env[evar]) {
            console.warn(chalk.yellow("Warning: the environment variable is not set '" + evar +"'"));
        }
    });
});
