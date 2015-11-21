'use strict';

// Setting up route
angular.module('models').config(['$stateProvider',
	function($stateProvider) {
		// Articles state routing
		$stateProvider.
		state('listModels', {
			url: '/models',
			templateUrl: 'modules/models/views/list-models.client.view.html'
		}).
		state('createModel', {
			url: '/models/create',
			templateUrl: 'modules/models/views/create-model.client.view.html'
		}).
		state('viewModel', {
			url: '/models/:ModelId',
			templateUrl: 'modules/models/views/view-model.client.view.html'
		}).
		state('editModel', {
			url: '/models/:modelId/edit',
			templateUrl: 'modules/models/views/edit-model.client.view.html'
		});
	}
]);
