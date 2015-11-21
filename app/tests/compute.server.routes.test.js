'use strict';

var should = require('should'),
	request = require('supertest'),
	app = require('../../server'),
	mongoose = require('mongoose'),
	User = mongoose.model('User'),
	Compute = mongoose.model('Compute'),
	agent = request.agent(app);

/**
 * Globals
 */
var credentials, user, compute;

/**
 * Compute routes tests
 */
describe('Compute CRUD tests', function() {
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

		// Save a user to the test db and create new Compute
		user.save(function() {
			compute = {
				name: 'Compute Name'
			};

			done();
		});
	});

	it('should be able to save Compute instance if logged in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Compute
				agent.post('/computes')
					.send(compute)
					.expect(200)
					.end(function(computeSaveErr, computeSaveRes) {
						// Handle Compute save error
						if (computeSaveErr) done(computeSaveErr);

						// Get a list of Computes
						agent.get('/computes')
							.end(function(computesGetErr, computesGetRes) {
								// Handle Compute save error
								if (computesGetErr) done(computesGetErr);

								// Get Computes list
								var computes = computesGetRes.body;

								// Set assertions
								(computes[0].user._id).should.equal(userId);
								(computes[0].name).should.match('Compute Name');

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should not be able to save Compute instance if not logged in', function(done) {
		agent.post('/computes')
			.send(compute)
			.expect(401)
			.end(function(computeSaveErr, computeSaveRes) {
				// Call the assertion callback
				done(computeSaveErr);
			});
	});

	it('should not be able to save Compute instance if no name is provided', function(done) {
		// Invalidate name field
		compute.name = '';

		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Compute
				agent.post('/computes')
					.send(compute)
					.expect(400)
					.end(function(computeSaveErr, computeSaveRes) {
						// Set message assertion
						(computeSaveRes.body.message).should.match('Please fill Compute name');
						
						// Handle Compute save error
						done(computeSaveErr);
					});
			});
	});

	it('should be able to update Compute instance if signed in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Compute
				agent.post('/computes')
					.send(compute)
					.expect(200)
					.end(function(computeSaveErr, computeSaveRes) {
						// Handle Compute save error
						if (computeSaveErr) done(computeSaveErr);

						// Update Compute name
						compute.name = 'WHY YOU GOTTA BE SO MEAN?';

						// Update existing Compute
						agent.put('/computes/' + computeSaveRes.body._id)
							.send(compute)
							.expect(200)
							.end(function(computeUpdateErr, computeUpdateRes) {
								// Handle Compute update error
								if (computeUpdateErr) done(computeUpdateErr);

								// Set assertions
								(computeUpdateRes.body._id).should.equal(computeSaveRes.body._id);
								(computeUpdateRes.body.name).should.match('WHY YOU GOTTA BE SO MEAN?');

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should be able to get a list of Computes if not signed in', function(done) {
		// Create new Compute model instance
		var computeObj = new Compute(compute);

		// Save the Compute
		computeObj.save(function() {
			// Request Computes
			request(app).get('/computes')
				.end(function(req, res) {
					// Set assertion
					res.body.should.be.an.Array.with.lengthOf(1);

					// Call the assertion callback
					done();
				});

		});
	});


	it('should be able to get a single Compute if not signed in', function(done) {
		// Create new Compute model instance
		var computeObj = new Compute(compute);

		// Save the Compute
		computeObj.save(function() {
			request(app).get('/computes/' + computeObj._id)
				.end(function(req, res) {
					// Set assertion
					res.body.should.be.an.Object.with.property('name', compute.name);

					// Call the assertion callback
					done();
				});
		});
	});

	it('should be able to delete Compute instance if signed in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Compute
				agent.post('/computes')
					.send(compute)
					.expect(200)
					.end(function(computeSaveErr, computeSaveRes) {
						// Handle Compute save error
						if (computeSaveErr) done(computeSaveErr);

						// Delete existing Compute
						agent.delete('/computes/' + computeSaveRes.body._id)
							.send(compute)
							.expect(200)
							.end(function(computeDeleteErr, computeDeleteRes) {
								// Handle Compute error error
								if (computeDeleteErr) done(computeDeleteErr);

								// Set assertions
								(computeDeleteRes.body._id).should.equal(computeSaveRes.body._id);

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should not be able to delete Compute instance if not signed in', function(done) {
		// Set Compute user 
		compute.user = user;

		// Create new Compute model instance
		var computeObj = new Compute(compute);

		// Save the Compute
		computeObj.save(function() {
			// Try deleting Compute
			request(app).delete('/computes/' + computeObj._id)
			.expect(401)
			.end(function(computeDeleteErr, computeDeleteRes) {
				// Set message assertion
				(computeDeleteRes.body.message).should.match('User is not logged in');

				// Handle Compute error error
				done(computeDeleteErr);
			});

		});
	});

	afterEach(function(done) {
		User.remove().exec();
		Compute.remove().exec();
		done();
	});
});