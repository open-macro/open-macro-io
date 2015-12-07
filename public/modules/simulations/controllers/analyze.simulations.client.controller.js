'use strict';

// M controller
angular.module('simulations').controller('AnalyzeSimulationController',
    ['$scope', '$http', '$mdDialog', '$stateParams', '$location', '$anchorScroll', '$mdToast', 'Authentication', 'Simulations',
        function ($scope, $http, $mdDialog, $stateParams, $location, $anchorScroll, $mdToast, Authentication, Simulations) {

            $scope.authentication = Authentication;

            /// set selected tab index... this should be refactored and less inside out
            $scope.selectedIndex = 4;

            $scope.graphs = undefined;
            $scope.visibleGraphKeys = [];
            $scope.visibleGraphs = [];
            $scope.visibleSimulations = [];

            var descriptions = {};
            var defaultGraphCount = 6;

            var successCallback = function() {

                /// setup breadcrumbs for the loaded simulation
                $scope.breadcrumbs = [
                    { title: 'Simulations', link: '/#!/' },
                    { title: $scope.simulation.name, link: '/#!/simulations/' + $scope.simulation._id }
                ];

                /// load other simulations created with the same model to facilitate the compare function
                $scope.comparableSimulations = Simulations.query({'model': $scope.simulation.model._id });

                $scope.visibleGraphKeys = $scope.simulation.visibleGraphKeys;

                /// build key value pairs for access to descriptions of each variable
                angular.forEach($scope.simulation.model.endovars, function(endovar){
                    descriptions[endovar.name] = endovar.description;
                });

                $http.get('/output/json/' + $scope.simulation._id)
                    .success(function(output){processOutput(output, $scope.simulation);})
                    .error(failureCallback);

            };

            var processOutput = function(output, simulation){

                var color =  (simulation._id === $scope.simulation._id) ? 'orange' : 'blue';

                /// load initial simulation
                if ($scope.graphs === undefined){
                    $scope.graphs = {};
                    angular.forEach(output, function(value, key){
                        var data = {};
                        data[simulation.name] = {'id':simulation.name, 'values':value, 'color':color};
                        $scope.graphs[key] = {'name':key, 'data':data, 'description':descriptions[key]};
                    });
                } else {
                    ///// adding a simulation to compare values
                    for (var key in $scope.graphs){
                        if ($scope.graphs.hasOwnProperty(key)){
                            var value = output[key];
                            $scope.graphs[key].data[simulation.name] = {'id':simulation.name, 'values':value, 'color':color};
                        }
                    }
                }

                updateVisibleGraphs();

            };

            var updateVisibleGraphs = function() {

                if ($scope.visibleGraphKeys.length === 0){
                    var count = 0;
                    for (var key in $scope.graphs){
                        if ($scope.graphs.hasOwnProperty(key) && count < defaultGraphCount){
                            $scope.visibleGraphKeys.push($scope.graphs[key].name);
                            count++;
                        }
                    }
                }

                $scope.visibleGraphs = [];
                for (var j=0; j < $scope.visibleGraphKeys.length; j++){
                    $scope.visibleGraphs.push($scope.graphs[$scope.visibleGraphKeys[j]]);
                }

            };

            var persistVisibleGraphs = function() {
                var simulation = $scope.simulation;

                var obj = {
                    '_id': $scope.simulation._id,
                    'visibleGraphKeys': $scope.visibleGraphKeys
                };

                Simulations.update(
                    obj,
                    function () {},
                    function (errorResponse) {
                        console.log(errorResponse.data.message);
                        $scope.toast('Unable to save simulation.');
                    });
            };


            var failureCallback = function() {
                $scope.toast('Simulation has not been run successfully.');
            };

            $scope.findSimulation = function() {
                $scope.simulation = Simulations.get(
                    {simulationId: $stateParams.simulationId},
                    successCallback,
                    failureCallback
                );
            };

            $scope.addGraph = function(variable) {
                if ($scope.visibleGraphKeys.indexOf(variable.name) === -1){
                    $scope.visibleGraphKeys.unshift(variable.name);
                    updateVisibleGraphs();
                    persistVisibleGraphs();
                } else {
                    $scope.toast('Graph has already been added.');
                }
            };

            $scope.compareSimulation = function(simulation) {
                /// hack to force graphs to update
                $scope.visibleGraphs = [];
                $http.get('/output/json/' + simulation._id)
                    .success(function(output){processOutput(output, simulation);})
                    .error(failureCallback);
            };

            $scope.toast = function(message){
                $mdToast.show( $mdToast.simple()
                    .content(message)
                    .position('top right')
                    .hideDelay(3000)
                );
            };

        }]);


