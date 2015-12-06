'use strict';

module.exports = {
    app: {
        title: 'Open Macro',
        description: 'Macroeconomic policy analysis in the cloud',
        keywords: 'openmacro, open, macro, economics, will clark'
    },
    port: process.env.PORT || 3000,
    templateEngine: 'swig',
    sessionSecret: process.env.SESSION_SECRET,
    // The name of the MongoDB collection to store sessions in
    sessionCollection: 'sessions',
    // The session cookie settings
    sessionCookie: {
        path: '/',
        httpOnly: true,
        // If secure is set to true then it will cause the cookie to be set
        // only when SSL-enabled (HTTPS) is used, and otherwise it won't
        // set a cookie. 'true' is recommended yet it requires the above
        // mentioned pre-requisite.
        secure: false,
        // Only set the maxAge to null if the cookie shouldn't be expired
        // at all. The cookie will expunge when the browser is closed.
        maxAge: null
        // To set the cookie in a specific domain uncomment the following
        // setting:
        //domain: 'openmacro.io'
    },
    // The session cookie name
    sessionName: 'connect.sid',
    log: {
        // Can specify one of 'combined', 'common', 'dev', 'short', 'tiny'
        format: 'combined',
        // Stream defaults to process.stdout
        // Uncomment to enable logging to a log on the file system
        options: {
            stream: 'access.log'
        }
    },
    assets: {
        lib: {
            css: [
                'https://ajax.googleapis.com/ajax/libs/angular_material/0.11.2/angular-material.min.css',
                'public/lib/ng-mfb/mfb/src/mfb.min.css',
                'public/lib/c3/c3.min.css'
            ],
            js: [
                'http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js',
                'https://ajax.googleapis.com/ajax/libs/angularjs/1.3.15/angular.min.js',
                'https://ajax.googleapis.com/ajax/libs/angularjs/1.3.15/angular-animate.min.js',
                'https://ajax.googleapis.com/ajax/libs/angularjs/1.3.15/angular-aria.min.js',
                'https://ajax.googleapis.com/ajax/libs/angular_material/0.11.2/angular-material.min.js',
                'public/lib/angular-resource/angular-resource.min.js',
                'public/lib/angular-ui-router/release/angular-ui-router.js',
                'public/lib/angular-ui-utils/ui-utils.js',
                'public/lib/ng-file-upload/angular-file-upload-shim.min.js',
                'public/lib/ng-file-upload/angular-file-upload.min.js',
                'public/lib/ng-mfb/src/mfb-directive.js',
                'public/lib/c3/c3.min.js',
                'public/lib/d3/d3.min.js',
                'public/lib/c3-angular/c3js-directive.js',
                'public/lib/socket.io-client/socket.io.js',
                'public/lib/angular-socket-io/socket.min.js',
                'http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML',
                'public/lib/angular-mathjax/angular-mathjax.js'
            ]
        },
        css: [
            'public/modules/**/css/*.css'
        ],
        js: [
            'public/config.js',
            'public/application.js',
            'public/modules/*/*.js',
            'public/modules/*/*[!tests]*/*.js'
        ],
        tests: [
            'public/lib/angular-mocks/angular-mocks.js',
            'public/modules/*/tests/*.js'
        ]
    }
};
