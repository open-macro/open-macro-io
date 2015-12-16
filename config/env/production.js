'use strict';

module.exports = {
    db: {
        uri: process.env.MONGODB_URI_PROD,
        options: {
            user: process.env.MONGODB_USER_PROD,
            pass: process.env.MONGODB_PASSWORD_PROD
        }
    },
    log: {
        format: 'combined',
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
                'public/lib/socket.i/o-client/socket.io.js',
                'public/lib/angular-socket-io/socket.min.js',
                'http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML',
                'public/lib/angular-mathjax/angular-mathjax.js'
            ]
        },
        css: 'public/dist/application.min.css',
        js: 'public/dist/application.min.js'
    },
    mailer: {
        from: process.env.MAILER_FROM || 'MAILER_FROM',
        options: {
            service: process.env.MAILER_SERVICE_PROVIDER || 'MAILER_SERVICE_PROVIDER',
            auth: {
                user: process.env.MAILER_EMAIL_ID || 'MAILER_EMAIL_ID',
                pass: process.env.MAILER_PASSWORD || 'MAILER_PASSWORD'
            }
        }
    }
};
