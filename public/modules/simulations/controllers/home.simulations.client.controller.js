'use strict';

// M controller
angular.module('simulations').controller('SimulationController', ['$scope', '$stateParams', '$location', 'Authentication', 'Simulations', '$anchorScroll',
	function($scope, $stateParams, $location, Authentication, Simulations, $anchorScroll) {

		$scope.authentication = Authentication;

		$scope.selectedIndex = 0;

		if ($stateParams.simulationId === undefined) { $location.path('/simulations'); }

		$scope.findOne = function () {
			$scope.simulation = Simulations.get({
				simulationId: $stateParams.simulationId
			}, function () {
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
		};

		$scope.goToAnchor = function (anch) {
			var old = $location.hash();
			$location.hash(anch);
			$anchorScroll();
			$location.hash(old);
		};
	}
]);
