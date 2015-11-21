'use strict';

var should = require('should'),
	request = require('supertest'),
	app = require('../../server'),
	mongoose = require('mongoose'),
	User = mongoose.model('User'),
	Model = mongoose.model('Model'),
	agent = request.agent(app);

/**
 * Globals
 */
var credentials, user, model;

/**
 * Model routes tests
 */
describe('Model CRUD tests', function() {
	beforeEach(function(done) {
		// Create user credentials
		credentials = {
			username: 'username',
			password: 'password'
		};

		// Create a new user
		user = new User({
			firstName: 'Full',
			lastName: 'Name',
			displayName: 'Full Name',
			email: 'test@test.com',
			username: credentials.username,
			password: credentials.password,
			provider: 'local'
		});

		// Save a user to the test db and create new model
		user.save(function() {
			model = {
				title: 'Model Title',
				content: 'Model Content'
			};

			done();
		});
	});

	it('should be able to save an model if logged in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new model
				agent.post('/models')
					.send(model)
					.expect(200)
					.end(function(modelSaveErr, modelSaveRes) {
						// Handle model save error
						if (modelSaveErr) done(modelSaveErr);

						// Get a list of models
						agent.get('/models')
							.end(function(modelsGetErr, modelsGetRes) {
								// Handle model save error
								if (modelsGetErr) done(modelsGetErr);

								// Get models list
								var models = modelsGetRes.body;

								// Set assertions
								(models[0].user._id).should.equal(userId);
								(models[0].title).should.match('Model Title');

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should not be able to save an model if not logged in', function(done) {
		agent.post('/models')
			.send(model)
			.expect(401)
			.end(function(modelSaveErr, modelSaveRes) {
				// Call the assertion callback
				done(modelSaveErr);
			});
	});

	it('should not be able to save an model if no title is provided', function(done) {
		// Invalidate title field
		model.title = '';

		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new model
				agent.post('/models')
					.send(model)
					.expect(400)
					.end(function(modelSaveErr, modelSaveRes) {
						// Set message assertion
						(modelSaveRes.body.message).should.match('Title cannot be blank');

						// Handle model save error
						done(modelSaveErr);
					});
			});
	});

	it('should be able to update an model if signed in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new model
				agent.post('/models')
					.send(model)
					.expect(200)
					.end(function(modelSaveErr, modelSaveRes) {
						// Handle model save error
						if (modelSaveErr) done(modelSaveErr);

						// Update model title
						model.title = 'WHY YOU GOTTA BE SO MEAN?';

						// Update an existing model
						agent.put('/models/' + modelSaveRes.body._id)
							.send(model)
							.expect(200)
							.end(function(modelUpdateErr, modelUpdateRes) {
								// Handle model update error
								if (modelUpdateErr) done(modelUpdateErr);

								// Set assertions
								(modelUpdateRes.body._id).should.equal(modelSaveRes.body._id);
								(modelUpdateRes.body.title).should.match('WHY YOU GOTTA BE SO MEAN?');

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should be able to get a list of models if not signed in', function(done) {
		// Create new model model instance
		var modelObj = new Model(model);

		// Save the model
		modelObj.save(function() {
			// Request models
			request(app).get('/models')
				.end(function(req, res) {
					// Set assertion
					res.body.should.be.an.Array.with.lengthOf(1);

					// Call the assertion callback
					done();
				});

		});
	});


	it('should be able to get a single model if not signed in', function(done) {
		// Create new model model instance
		var modelObj = new Model(model);

		// Save the model
		modelObj.save(function() {
			request(app).get('/models/' + modelObj._id)
				.end(function(req, res) {
					// Set assertion
					res.body.should.be.an.Object.with.property('title', model.title);

					// Call the assertion callback
					done();
				});
		});
	});

	it('should return proper error for single model which doesnt exist, if not signed in', function(done) {
		request(app).get('/models/test')
			.end(function(req, res) {
				// Set assertion
				res.body.should.be.an.Object.with.property('message', 'Model is invalid');

				// Call the assertion callback
				done();
			});
	});

	it('should be able to delete an model if signed in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new model
				agent.post('/models')
					.send(model)
					.expect(200)
					.end(function(modelSaveErr, modelSaveRes) {
						// Handle model save error
						if (modelSaveErr) done(modelSaveErr);

						// Delete an existing model
						agent.delete('/models/' + modelSaveRes.body._id)
							.send(model)
							.expect(200)
							.end(function(modelDeleteErr, modelDeleteRes) {
								// Handle model error error
								if (modelDeleteErr) done(modelDeleteErr);

								// Set assertions
								(modelDeleteRes.body._id).should.equal(modelSaveRes.body._id);

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should not be able to delete an model if not signed in', function(done) {
		// Set model user
		model.user = user;

		// Create new model model instance
		var modelObj = new Model(model);

		// Save the model
		modelObj.save(function() {
			// Try deleting model
			request(app).delete('/models/' + modelObj._id)
			.expect(401)
			.end(function(modelDeleteErr, modelDeleteRes) {
				// Set message assertion
				(modelDeleteRes.body.message).should.match('User is not logged in');

				// Handle model error error
				done(modelDeleteErr);
			});

		});
	});

	afterEach(function(done) {
		User.remove().exec(function() {
			Model.remove().exec(done);
		});
	});
});
