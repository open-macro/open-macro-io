'use strict';

(function() {
	// Models Controller Spec
	describe('Models Controller Tests', function() {
		// Initialize global variables
		var ModelsController,
			scope,
			$httpBackend,
			$stateParams,
			$location;

		// The $resource service augments the response object with methods for updating and deleting the resource.
		// If we were to use the standard toEqual matcher, our tests would fail because the test values would not match
		// the responses exactly. To solve the problem, we define a new toEqualData Jasmine matcher.
		// When the toEqualData matcher compares two objects, it takes only object properties into
		// account and ignores methods.
		beforeEach(function() {
			jasmine.addMatchers({
				toEqualData: function(util, customEqualityTesters) {
					return {
						compare: function(actual, expected) {
							return {
								pass: angular.equals(actual, expected)
							};
						}
					};
				}
			});
		});

		// Then we can start by loading the main application module
		beforeEach(module(ApplicationConfiguration.applicationModuleName));

		// The injector ignores leading and trailing underscores here (i.e. _$httpBackend_).
		// This allows us to inject a service but then attach it to a variable
		// with the same name as the service.
		beforeEach(inject(function($controller, $rootScope, _$location_, _$stateParams_, _$httpBackend_) {
			// Set a new global scope
			scope = $rootScope.$new();

			// Point global variables to injected services
			$stateParams = _$stateParams_;
			$httpBackend = _$httpBackend_;
			$location = _$location_;

			// Initialize the Models controller.
			ModelsController = $controller('ModelsController', {
				$scope: scope
			});
		}));

		it('$scope.find() should create an array with at least one model object fetched from XHR', inject(function(Models) {
			// Create sample model using the Models service
			var sampleModel = new Models({
				title: 'An Model about MEAN',
				content: 'MEAN rocks!'
			});

			// Create a sample models array that includes the new model
			var sampleModels = [sampleModel];

			// Set GET response
			$httpBackend.expectGET('models').respond(sampleModels);

			// Run controller functionality
			scope.find();
			$httpBackend.flush();

			// Test scope value
			expect(scope.models).toEqualData(sampleModels);
		}));

		it('$scope.findOne() should create an array with one model object fetched from XHR using a modelId URL parameter', inject(function(Models) {
			// Define a sample model object
			var sampleModel = new Models({
				title: 'An Model about MEAN',
				content: 'MEAN rocks!'
			});

			// Set the URL parameter
			$stateParams.modelId = '525a8422f6d0f87f0e407a33';

			// Set GET response
			$httpBackend.expectGET(/models\/([0-9a-fA-F]{24})$/).respond(sampleModel);

			// Run controller functionality
			scope.findOne();
			$httpBackend.flush();

			// Test scope value
			expect(scope.model).toEqualData(sampleModel);
		}));

		it('$scope.create() with valid form data should send a POST request with the form input values and then locate to new object URL', inject(function(Models) {
			// Create a sample model object
			var sampleModelPostData = new Models({
				title: 'An Model about MEAN',
				content: 'MEAN rocks!'
			});

			// Create a sample model response
			var sampleModelResponse = new Models({
				_id: '525cf20451979dea2c000001',
				title: 'An Model about MEAN',
				content: 'MEAN rocks!'
			});

			// Fixture mock form input values
			scope.title = 'An Model about MEAN';
			scope.content = 'MEAN rocks!';

			// Set POST response
			$httpBackend.expectPOST('models', sampleModelPostData).respond(sampleModelResponse);

			// Run controller functionality
			scope.create();
			$httpBackend.flush();

			// Test form inputs are reset
			expect(scope.title).toEqual('');
			expect(scope.content).toEqual('');

			// Test URL redirection after the model was created
			expect($location.path()).toBe('/models/' + sampleModelResponse._id);
		}));

		it('$scope.update() should update a valid model', inject(function(Models) {
			// Define a sample model put data
			var sampleModelPutData = new Models({
				_id: '525cf20451979dea2c000001',
				title: 'An Model about MEAN',
				content: 'MEAN Rocks!'
			});

			// Mock model in scope
			scope.model = sampleModelPutData;

			// Set PUT response
			$httpBackend.expectPUT(/models\/([0-9a-fA-F]{24})$/).respond();

			// Run controller functionality
			scope.update();
			$httpBackend.flush();

			// Test URL location to new object
			expect($location.path()).toBe('/models/' + sampleModelPutData._id);
		}));

		it('$scope.remove() should send a DELETE request with a valid modelId and remove the model from the scope', inject(function(Models) {
			// Create new model object
			var sampleModel = new Models({
				_id: '525a8422f6d0f87f0e407a33'
			});

			// Create new models array and include the model
			scope.models = [sampleModel];

			// Set expected DELETE response
			$httpBackend.expectDELETE(/models\/([0-9a-fA-F]{24})$/).respond(204);

			// Run controller functionality
			scope.remove(sampleModel);
			$httpBackend.flush();

			// Test array after successful delete
			expect(scope.models.length).toBe(0);
		}));
	});
}());
