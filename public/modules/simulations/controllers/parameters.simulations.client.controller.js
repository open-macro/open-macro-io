'use strict';

// M controller
angular.module('simulations').controller('ParametersSimulationController', ['$scope', '$http', '$mdDialog', '$stateParams', '$location', 'Authentication', 'Simulations', 'Models', 'Socket', '$anchorScroll',
	function($scope, $http, $mdDialog, $stateParams, $location, Authentication, Simulations, Models, Socket, $anchorScroll) {

		$scope.authentication = Authentication;

		$scope.selectedIndex = 1;

		if ($stateParams.simulationId === undefined) { $location.path('/simulations'); }

		// Update existing Simulation
		$scope.update = function () {
			var simulation = $scope.simulation;

			var obj = {
				'_id':        simulation._id,
				'parameters': simulation.parameters,
				'dsf' : simulation.dsf
			};

			Simulations.update(
				obj,
				function () {},
				function (errorResponse) {
					console.log(errorResponse.data.message);
					$scope.error = errorResponse.data.message;
				});
		};

		$scope.findOne = function () {
			$scope.simulation = Simulations.get({
				simulationId: $stateParams.simulationId
			}, function() {
				$scope.breadcrumbs = [
					{
						title:'Simulations',
						link: '/#!/'
					},
					{
						title:$scope.simulation.name,
						link: '/#!/simulations/' + $scope.simulation._id
					}];
			});

			$scope.editingDSF = false;
		};

		$scope.editParam = function (parameter){
			$scope.selectedParameter = parameter;
			$scope.editingDSF = false;
		};

		$scope.useDefaultValue = function() {
			$scope.selectedParameter.value = $scope.selectedParameter.default_value;
		};

		$scope.toggleDSF = function() {
			$scope.editingDSF = !$scope.editingDSF;
			$scope.selectedParameter = null;
		};

		$scope.goToRun = function() {
			var path = '/simulations/' + $scope.simulation._id + '/run';
			$location.path(path);
		};

		$scope.$on('$destroy', function() {
			// Call update for parameters when client navigates AWAY from page
			$scope.update();
		});

	}
]);
