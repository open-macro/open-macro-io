'use strict';

module.exports = {
    db: {
        uri: 'mongodb://localhost/mean-test',
        options: {
            user: '',
            pass: ''
        }
    },
    port: 3001,
    log: {
        format: 'dev',
        options: {
            //stream: 'access.log'
        }
    },
    app: {
        title: 'MEAN.JS - Test Environment'
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
