'use strict';

// M controller
angular.module('models').controller('ModelsController', ['$scope', '$stateParams', '$location', 'Authentication', 'Models',
	function($scope, $stateParams, $location, Authentication, Models) {
		$scope.authentication = Authentication;

		$scope.goToCreate = function() {
			$location.path('models/create');
		};

		// Create new Model
		$scope.create = function() {
			// Create new Model object

			var modelJSON = JSON.parse($scope.modelJSON);

			var model = new Models(modelJSON);

			// Redirect after save
			model.$save(function(response) {
				$location.path('models');

				// Clear form fields
				$scope.modelJSON = '';
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Remove existing Model
		$scope.remove = function(model) {
			if (model) {
				model.$remove();

				for (var i in $scope.models) {
					if ($scope.models[i] === model) {
						$scope.models.splice(i, 1);
					}
				}
			} else {
				$scope.model.$remove(function() {
					$location.path('models');
				});
			}
		};

		// Update existing Article
		$scope.update = function() {
			var model = $scope.model;

			model.$update(function() {
				$location.path('models/' + model._id);
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Find a list of Models
		$scope.find = function() {
			$scope.models = Models.query();
		};

		// Find existing Article
		$scope.findOne = function() {
			$scope.model = Models.get({
				modelId: $stateParams.modelId
			});
			console.log($scope.model);
		};

	}
]);
