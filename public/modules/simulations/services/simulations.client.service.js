'use strict';

// Models service used for communicating with the models REST endpoints
angular.module('simulations').factory('Simulations', ['$resource',
	function($resource) {
		return $resource(
			'simulations/:simulationId',
			{ simulationId: '@_id' },
			{ update: { method: 'PUT' } }
		);
	}
]).factory('SimulationState', ['$http', 'Socket',
	function($http, Socket) {
		return function() {
			return {
				runSimulation: function (simulationId, success, error, updates, completion, info) {

					Socket.on('compute.' + simulationId, function (data) {
						/// on:close:0 is our termination messages
						if (data === 'on:close:0') {
							completion();
							info('Success');
						} else if (data.indexOf('on:close:') !== -1) {
							info('Error');
							updates('[ERROR] octave cp returned: ' + data + '\n');
						} else {
							updates(data);
						}
					});

					$http.post('/compute/' + simulationId, {}).
						success(success).error(error);
				}
			};
		};
	}
]).factory('AnalyzeState', ['$http',
	function($http) {
		return {
			/* active_vars:[AnalyzeState.active_vars],
			per_row : [AnalyzeState.per_row],
			json_data : [AnalyzeState.json_data],
			data_columns : [AnalyzeState.data_columns],
			all_vars : [AnalyzeState.all_vars],
			sim_descriptions : [AnalyzeState.sim_descriptions] */
		};
	}
]);
