'use strict';

// M controller
angular.module('simulations').controller('AnalyzeSimulationController',
    ['$scope', '$http', '$mdDialog', '$stateParams', '$location', '$anchorScroll', 'Authentication', 'Simulations', 'AnalyzeState',
	function($scope, $http, $mdDialog, $stateParams, $location, $anchorScroll, Authentication, Simulations, AnalyzeState) {

		$scope.authentication = Authentication;

		$scope.selectedIndex = 4;

		if ($stateParams.simulationId === undefined) { $location.path('/simulations'); }

		$scope.per_row = 3;

		$scope.findOne = function () {
			$scope.simulation = Simulations.get({
				simulationId: $stateParams.simulationId
			}, function () {
				$scope.genRender(6, $scope.per_row);

				var i;
				$scope.grouped_sims = Simulations.query({}, function(){
					for(i = 0; i < $scope.grouped_sims.length; i++){
						if($scope.simulation.model.name === $scope.grouped_sims[i].model){
							$scope.all_sims = $scope.grouped_sims[i].simulations;
						}
					}
				});

				$scope.curSim = $scope.simulation._id;

				AnalyzeState.per_row = 3;
				AnalyzeState.active_vars = $scope.active_vars;
				AnalyzeState.json_data = $scope.json_data;
				AnalyzeState.data_columns = $scope.data_columns;
				AnalyzeState.all_vars = $scope.all_vars;
				AnalyzeState.sim_descriptions = $scope.sim_descriptions;

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

		/* Creates a new graph object */
		$scope.invalidSim = function(ev) {
			$mdDialog.show({
				templateUrl: '/modules/simulations/views/invalid-graph.client.view.html',
				targetEvent: ev
			});
		};

		/* Global variable that holds the name of the next variable to be created */
		$scope.active_var = '';

		/* Global list that holds all active variable names */
		$scope.active_vars = [];

		/* Tells the system to listen for another graph type */
		$scope.createGraph = function(curvar){
			if ($scope.active_vars.indexOf(curvar) === -1) { // curvar is not plotted yet
				//console.log('havent plotted that yet');	
				$scope.active_vars.push(curvar);	
				$scope.genVars($scope.per_row);
				$mdDialog.cancel();		
			} 
		};


		$scope.getColumn = function(input_str, color, id_num){
			return 	{'id':input_str,
				'type':'line','color': color};
		};

		$scope.vars = [];
		$scope.all_vars = [];
		$scope.json_data = [];
		$scope.data_columns = [];
		$scope.sim_descriptions = {};

		/* Only called once when user clicks to "Analyze" tab */
		$scope.renderGraphs = function(total_num, row_num){
			$http.get('/output/json/' + $stateParams.simulationId.toString()).success(function(raw_data) {
				//console.log($scope.curSim);
				if($scope.simulation._id !== $scope.curSim){
					$scope.legend_on = true;
				}else{
					$scope.legend_on = false;
				}

				//console.log($scope.legend_on);

				var cur_row = [];
				var cur_obj = {};
				var graph_list = [];

				var i = 0;
				for(var curvar in raw_data) {

					cur_obj = {
						'name': curvar,
						'idnum': i
					};

					if($scope.active_vars.length < total_num || curvar in $scope.active_vars){
						if (i !== 0) {
							if (i % row_num === 0) {
								$scope.vars.push(cur_row);
								cur_row = [];
							}
						}

						if($scope.active_vars.length < total_num ){
							$scope.active_vars.push(curvar);
						}

						cur_row.push(cur_obj);
					}
					i++;
					$scope.all_vars.push(cur_obj);

					var raw_len = raw_data[curvar].length;

					for (var p = 0; p < raw_len; p++) {
						graph_list.push({
							'x': p
						});
						graph_list[p][$scope.simulation.name] = raw_data[curvar][p];
					}

					$scope.json_data[curvar] =  graph_list;
					$scope.data_columns[curvar] = [$scope.getColumn($scope.simulation.name, 'brown', 1)];
					graph_list = [];
				}

				$scope.vars.push(cur_row);
			}).error(function(data, status, headers, config){
				$scope.invalidSim();
			});
		};


		/* Might not ever be used!! */
		$scope.concatGraphs = function(simulation){
			if($scope.simulation._id === simulation._id){
				$scope.renderGraphs($scope.active_vars.length, $scope.per_row);
			}else{
				$http.get('/output/json/' + simulation._id.toString()).success(function(raw_data) {
					var raw_len = 0;
					var temp = [];

					for(var curvar in raw_data) {
						temp = [];
						raw_len = raw_data[curvar].length;
						for(var p = 0; p < raw_len; p++) {
							temp.push({
								'x': p
							});
							temp[p][$scope.simulation.name] = $scope.json_data[curvar][p][$scope.simulation.name];
							temp[p][simulation.name] = raw_data[curvar][p];
						}

						$scope.json_data[curvar] = temp;
						$scope.data_columns[curvar] = [{'id': $scope.simulation.name,
							'type':'line', 'show-legend': true, 'color': 'brown'}, $scope.getColumn(simulation.name, 'green', 2)];
					}
				}).error(function(data, status, headers, config){
					$scope.invalidSim();
				});
		}
	};

		$scope.genVars = function(row_num){
			$scope.vars = [];
			var cur_row = [];
			var cur_obj = {};

			for(var i = 0; i < $scope.active_vars.length; i++) {
				cur_obj = {
					'name': $scope.active_vars[i],
					'idnum': i
				};

				if (i !== 0) {
					if (i % row_num === 0) {
						$scope.vars.push(cur_row);
						cur_row = [];
					}
				}

				cur_row.push(cur_obj);
			}

			$scope.vars.unshift(cur_row);
		};

		$scope.genRender = function(total_num, row_num){
			if($scope.sim_descriptions !== {}){
				var param = {};
				for(var i in $scope.simulation.model.endovars){
					param = $scope.simulation.model.endovars[i];
					$scope.sim_descriptions[param.name] = {
						'latex' : param.latex,
						'description' : param.description
					};
				}
			}

			if($scope.vars.length === 0)
			{
				$scope.renderGraphs(total_num, row_num);
			}else{
				$scope.genVars($scope.per_row);
			}
		};
}]);


