'use strict';

var fs = require('fs');
var http = require('http');
var https = require('https');
var path = require('path');
var bodyParser = require('body-parser');
var compression = require('compression');
var consolidate = require('consolidate');
var cookieParser = require('cookie-parser');
var express = require('express');
var flash = require('connect-flash');
var helmet = require('helmet');
var logger = require('./logger');
var methodOverride = require('method-override');
var morgan = require('morgan');
var session = require('express-session');
var socketio = require('socket.io');
var passport = require('passport');
var mongoStore = require('connect-mongo')({
    session: session
});
var config = require('./config');


module.exports = function(db) {
    // Initialize express app
    var app = express();

    // Globbing model files
    config.getGlobbedFiles('./app/models/**/*.js').forEach(function(modelPath) {
        require(path.resolve(modelPath));
    });

    // Setting application local variables
    app.locals.title = config.app.title;
    app.locals.description = config.app.description;
    app.locals.keywords = config.app.keywords;
    //app.locals.facebookAppId = config.facebook.clientID;
    app.locals.jsFiles = config.getJavaScriptAssets();
    app.locals.cssFiles = config.getCSSAssets();

    // Passing the request url to environment locals
    app.use(function(req, res, next) {
        res.locals.url = req.protocol + '://' + req.headers.host + req.url;
        next();
    });

    // Should be placed before express.static
    app.use(compression({
        // only compress files for the following content types
        filter: function(req, res) {
            return (/json|text|javascript|css/).test(res.getHeader('Content-Type'));
        },
        // zlib option for compression level
        level: 3
    }));

    // Showing stack errors
    app.set('showStackError', true);

    // Set swig as the template engine
    app.engine('server.view.html', consolidate[config.templateEngine]);

    // Set views path and view engine
    app.set('view engine', 'server.view.html');
    app.set('views', './app/views');

    // Enable logger (morgan)
    app.use(morgan(logger.getLogFormat(), logger.getLogOptions()));

    // Environment dependent middleware
    if (process.env.NODE_ENV === 'development') {
        // Disable views cache
        app.set('view cache', false);
    } else if (process.env.NODE_ENV === 'production') {
        app.locals.cache = 'memory';
    }

    // Request body parsing middleware should be above methodOverride
    app.use(bodyParser.urlencoded({
        extended: true
    }));
    app.use(bodyParser.json());
    app.use(methodOverride());

    // Use helmet to secure Express headers
    app.use(helmet.xframe());
    app.use(helmet.xssFilter());
    app.use(helmet.nosniff());
    app.use(helmet.ienoopen());
    app.disable('x-powered-by');

    // Setting the app router and static folder
    app.use(express.static(path.resolve('./public')));

    // CookieParser should be above session
    app.use(cookieParser());

    // Express MongoDB session storage
    app.use(session({
        saveUninitialized: true,
        resave: true,
        secret: config.sessionSecret,
        store: new mongoStore({
            db: db.connection.db,
            collection: config.sessionCollection
        }),
        cookie: config.sessionCookie,
        name: config.sessionName
    }));

    // use passport session
    app.use(passport.initialize());
    app.use(passport.session());

    // connect flash for flash messages
    app.use(flash());

    // Globbing routing files
    config.getGlobbedFiles('./app/routes/**/*.js').forEach(function(routePath) {
        require(path.resolve(routePath))(app);
    });

    // Error handling middleware
    app.use(function(err, req, res, next) {
        if (!err) return next();

        console.error(err.stack);

        if (process.env.NODE_ENV === 'development') {
            res.status(500)
                .render('500', {
                    error: err.stack
                });
        } else {
            res.status(500)
                .render('500', {
                    error: ''
                });
        }
    });

    // Assume 404 if no handler has caught this
    app.use(function(req, res) {
        res.status(404).render('404', {
            url: req.originalUrl,
            error: 'Not Found'
        });
    });


    if (process.env.NODE_ENV === 'secure') {
        // Load SSL key and certificate
        var privateKey = fs.readFileSync('./config/sslcerts/key.pem', 'utf8');
        var certificate = fs.readFileSync('./config/sslcerts/cert.pem', 'utf8');

        // Create HTTPS Server
        var httpsServer = https.createServer({
            key: privateKey,
            cert: certificate
        }, app);

        app.set('socketio', socketio.listen(httpsServer));
        app.set('server', httpsServer);

        // Return HTTPS server instance
        return httpsServer;
    }

    // setup socketio
    var server = http.createServer(app);
    var io = socketio.listen(server);
    app.set('socketio', io);
    app.set('server', server);

    // Return Express server instance
    return app;
};
