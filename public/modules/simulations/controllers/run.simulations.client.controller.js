'use strict';

// M controller
angular.module('simulations').controller('RunSimulationController', ['$scope', '$stateParams', '$location', '$anchorScroll', 'Authentication', 'SimulationState', 'Simulations',
    function ($scope, $stateParams, $location, $anchorScroll, Authentication, SimulationState, Simulations) {

        $scope.authentication = Authentication;
        $scope.simulationState = SimulationState;

        $scope.selectedIndex = 3;

        if ($stateParams.simulationId === undefined) {
            $location.path('/simulations');
        }

        $scope.output = '';
        $scope.canExport = false;

        // Update existing Simulation
        $scope.update = function () {
            var simulation = $scope.simulation;

            var obj = {
                '_id': simulation._id,
                'log': simulation.log
            };

            console.log('@ obj ', obj);
            console.log('@ sim log ', simulation.log);

            Simulations.update(
                obj,
                function () {
                },
                function (errorResponse) {
                    console.log(errorResponse.data.message);
                    $scope.error = errorResponse.data.message;
                });
        };

        $scope.findOne = function () {
            $scope.simulation = Simulations.get({
                simulationId: $stateParams.simulationId
            }, function () {
                $scope.breadcrumbs = [
                    {
                        title: 'Simulations',
                        link: '/#!/'
                    },
                    {
                        title: $scope.simulation.name,
                        link: '/#!/simulations/' + $scope.simulation._id
                    }];
            });
        };


        $scope.runSimulation = function () {

            var threshold = new Date(new Date().getTime() - (5 * 60 * 1000));
            for (var i=0; i < $scope.simulation.log.length; i++){
                var log = $scope.simulation.log[i];
                if (log.status === 'Running'){
                    /// if there is a running simulation elsewhere return
                    if (log.date > threshold) return;
                    /// otherwise we can just update the state to error because
                    /// some unknown error occurred.
                    log.status = 'Error';
                }
            }

            console.log('pushing new log!');
            $scope.simulation.log.push({
                date: Date.now(),
                status: 'Running',
                info: ''
            });

            $scope.simulationState().runSimulation(
                $stateParams.simulationId,
                function (data, status, headers, config) {
                    // success function
                    console.log(data);
                },
                function (data, status, headers, config) {
                    // error function
                    console.log(data);
                },
                function (data) {
                    $scope.output += data;
                    var old = $location.hash();
                    $location.hash('bottom');
                    $anchorScroll();
                    $location.hash(old);
                },
                function () {
                    // completion
                    $scope.canExport = true;
                    var old = $location.hash();
                    $location.hash('bottom');
                    $anchorScroll();
                    $location.hash(old);
                },
                function (text) {
                    // info function
                    //$scope.simulation.log[$scope.simulation.log.length - 1].info += text;
                    $scope.simulation.log[$scope.simulation.log.length - 1].status = text;
                    console.log('updating status in sim\'s log');
                    $scope.update();
                });
        };
    }
]);


