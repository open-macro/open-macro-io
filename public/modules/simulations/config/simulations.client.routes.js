'use strict';

// Setting up route
angular.module('simulations').config(['$stateProvider',
	function($stateProvider) {
		// Simulation state routing
		$stateProvider.
		state('listSimulations', {
			url: '/simulations',
			templateUrl: 'modules/simulations/views/list-simulations.client.view.html'
		}).
		state('createSimulation', {
			url: '/models/create',
			templateUrl: 'modules/simulations/views/create-simulation.client.view.html'
		}).
		state('viewSimulation', {
			url: '/simulations/:simulationId',
			templateUrl: 'modules/simulations/views/view-simulation.client.view.html'
		}).
		state('analyzeSimulation', {
			url: '/simulations/:simulationId/analyze',
			templateUrl: 'modules/simulations/views/analyze-simulation.client.view.html'
		}).
		state('editParamsSimulation', {
		url: '/simulations/:simulationId/edit/parameters',
		templateUrl: 'modules/simulations/views/edit-params-simulation.client.view.html'
		}).
		state('editShocksSimulation', {
			url: '/simulations/:simulationId/edit/shocks',
			templateUrl: 'modules/simulations/views/edit-shocks-simulation.client.view.html'
		}).
		state('runSimulation', {
			url: '/simulations/:simulationId/run',
			templateUrl: 'modules/simulations/views/run-simulation.client.view.html'
		});
	}
]);
