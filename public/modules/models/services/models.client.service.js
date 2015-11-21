'use strict';

// Models service used for communicating with the models REST endpoints
angular.module('models').factory('Models', ['$resource',
	function($resource) {
		return $resource('models/:modelId', {
			modelId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
	}
]);
