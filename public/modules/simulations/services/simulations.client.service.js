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

                    /// remove all previous listeners to prevent the output from being printed
                    /// multiple times.
                    Socket.removeAllListeners();

					Socket.on('compute.' + simulationId, function (data) {
						/// on:close:0 is our termination messages
                        console.log(data);
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
]);
