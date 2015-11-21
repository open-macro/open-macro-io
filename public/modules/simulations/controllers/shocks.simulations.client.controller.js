'use strict';

// M controller
angular.module('simulations').controller('ShocksSimulationController', ['$scope', '$http', '$mdDialog', '$stateParams', '$location', 'Authentication', 'Simulations', 'Models', 'Socket', '$anchorScroll',
	function($scope, $http, $mdDialog, $stateParams, $location, Authentication, Simulations, Models, Socket, $anchorScroll) {
		$scope.authentication = Authentication;

		$scope.selectedIndex = 2;

		if ($stateParams.simulationId === undefined) { $location.path('/simulations'); }

		$scope.isShocksNew = false;

		// Global variable for allowing simulations to be deleted
		$scope.editable = false;

		$scope.ToggleEdit = function () {
			$scope.editable = !$scope.editable;
		};


		// Update existing Simulation
		$scope.update = function () {
			var simulation = $scope.simulation;

			var obj = {
				'_id':        simulation._id,
				'shocks':     simulation.shocks
			};

			Simulations.update(
				obj,
				function () {},
				function (errorResponse) {
					console.log(errorResponse.data.message);
					$scope.error = errorResponse.data.message;
				});
		};


		// Find existing Article
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
		};

		$scope.goToAnchor = function (anch) {
			console.log(anch);
			$location.hash(anch);
			$anchorScroll();
		};

		$scope.editShock = function (shock) {
			$scope.selectedShock = shock;
		};

		$scope.addPeriods = function (shock, num) {
			var values = [];
			// hard limit of 10 since client could change num in call
			for (var i = 0; i < num && i < 10; i++) {
				values.push(0);
			}
			Array.prototype.push.apply(shock.periods, values);
		};

		$scope.addRange = function (shock) {
			shock.ranges.push({
				start: 0,
				end:   0,
				value: 0
			});
		};

		$scope.goToRun = function() {
			var path = '/simulations/' + $scope.simulation._id + '/run';
			$location.path(path);
		};

		$scope.$on('$destroy', function() {
			// Call update for shocks when client navigates AWAY from page
			$scope.update();
		});

        $scope.handlePaste = function(index, $event){
            var pastedValue = $event.originalEvent.clipboardData.getData("text/plain");
            var components = pastedValue.split('\t');
            if (components.length > 1){
                $event.preventDefault();
                for (var i=index, j=0;
                     i < $scope.selectedShock.periods.length && j < components.length;
                     i++, j++){
                    var val = parseFloat(components[j]);
                    if (!isNaN(val)){
                        $scope.selectedShock.periods[i] = val;
                    }
                }
            }
        };

	}
]).filter('hasShockName', function () {
	return function (items, name) {
		if (items === undefined || name === undefined) {
			return [];
		}

		var filtered = [];
		for (var i = 0; i < items.length; i++) {
			if (items[i].name === name) {
				filtered.push(items[i]);
			}
		}
		return filtered;
	};
});
