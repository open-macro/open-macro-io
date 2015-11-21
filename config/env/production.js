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
