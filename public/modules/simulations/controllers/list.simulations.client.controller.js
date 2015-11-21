'use strict';

// M controller
angular.module('simulations').controller('ListSimulationsController', ['$scope', '$http', '$mdDialog', '$stateParams', '$location', 'Authentication', 'Simulations', '$anchorScroll', 'Models',
    function ($scope, $http, $mdDialog, $stateParams, $location, Authentication, Simulations, $anchorScroll, Models) {

        $scope.authentication = Authentication;

        $scope.selectedIndex = 0;

        $scope.goToAnchor = function (anch) {

            $location.hash(anch);
            $anchorScroll();

        };

        $scope.breadcrumbs = [
            {
                title: 'Simulations',
                link: '/#!/'
            }];

        // Create new Simulation
        $scope.create = function () {
            // Create new Simulation object

            var simulation = new Simulations({
                name: this.simulation.name,
                model: this.simulation.model
            });

            // Redirect after save
            simulation.$save(function (response) {

                $location.path('simulations/' + response._id);

            }, function (errorResponse) {
                console.log(errorResponse.data.message);
                $scope.error = errorResponse.data.message;
            });

            $mdDialog.cancel();

        };

        // Remove existing Simulation
        $scope.remove = function (simulation) {
            // this callback will be called asynchronously
            // when the response is available
            for (var group in $scope.groupedSimulations) {
                for (var sim in $scope.groupedSimulations[group].simulations) {
                    if (simulation === $scope.groupedSimulations[group].simulations[sim]) {
                        $scope.groupedSimulations[group].simulations.splice(sim, 1);
                        if ($scope.groupedSimulations[group].simulations.length === 0) {
                            $scope.groupedSimulations.splice(group, 1);
                        }
                    }
                }
            }
            $http.delete('/simulations/' + simulation._id).
            success(function (data, status, headers, config) {
            }).
            error(function (data, status, headers, config) {
                console.log(status);
                // called asynchronously if an error occurs
                // or server returns response with an error status.
            });
        };

        // Update existing Simulation
        $scope.update = function () {
            var simulation = $scope.simulation;

            var obj = {
                '_id': simulation._id,
                'parameters': simulation.parameters,
                'shocks': simulation.shocks
            };

            Simulations.update(obj,
                function () {
                }, function (errorResponse) {
                    console.log(errorResponse.data.message);
                    $scope.error = errorResponse.data.message;
                });
        };


        // Find a list of Simulations
        $scope.find = function () {
            $scope.groupedSimulations = Simulations.query();
        };


        $scope.findModels = function () {
            $scope.models = Models.query();
        };

        $scope.newSimulation = function (ev) {
            $mdDialog.show({
                templateUrl: '/modules/simulations/views/create-simulation.client.view.html',
                targetEvent: ev
            });
        };
    }
]);
