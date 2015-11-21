'use strict';

module.exports = {
    db: {
        uri: process.env.MONGODB_URI_DEV,
        options: {
            user: process.env.MONGODB_USER_DEV,
            pass: process.env.MONGODB_PASSWORD_DEV
        }
    },
    log: {
        format: 'dev',
        options: {
            //stream: 'access.log'
        }
    },
    app: {
        title: 'Open Macro (dev)'
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
