'use strict';

// Init the application configuration module for AngularJS application
var ApplicationConfiguration = (function() {
	// Init module configuration options
	var applicationModuleName = 'mean';
	var applicationModuleVendorDependencies =
		['ngResource', 'ngAnimate', 'ui.router', 'ngMaterial','angularFileUpload', 'ng-mfb', 'gridshore.c3js.chart','btford.socket-io'];

	// Add a new vertical module
	var registerModule = function(moduleName, dependencies) {
		// Create angular module
		angular.module(moduleName, dependencies || []);

		// Add the module to the AngularJS configuration file
		angular.module(applicationModuleName).requires.push(moduleName);
	};

	return {
		applicationModuleName: applicationModuleName,
		applicationModuleVendorDependencies: applicationModuleVendorDependencies,
		registerModule: registerModule
	};
})();

'use strict';

//Start by defining the main module and adding the module dependencies
angular.module(ApplicationConfiguration.applicationModuleName, ApplicationConfiguration.applicationModuleVendorDependencies);

// Setting HTML5 Location Mode
angular.module(ApplicationConfiguration.applicationModuleName).config(['$locationProvider', '$mdThemingProvider',
	function($locationProvider, $mdThemingProvider) {
		$locationProvider.hashPrefix('!');

		$mdThemingProvider.theme('default')
			.primaryPalette('green')
			.accentPalette('brown', {
				'default': '300' // use shade 200 for default
			});
	}
]);

//Then define the init function for starting up the application
angular.element(document).ready(function() {
	//Fixing facebook bug with redirect
	if (window.location.hash === '#_=_') window.location.hash = '#!';

	//Then init the app
	angular.bootstrap(document, [ApplicationConfiguration.applicationModuleName]);
});

'use strict';

// Use Application configuration module to register a new module
ApplicationConfiguration.registerModule('core');

'use strict';

// Use Application configuration module to register a new module
ApplicationConfiguration.registerModule('models');

'use strict';

// Use Application configuration module to register a new module
ApplicationConfiguration.registerModule('simulations');

'use strict';

// Use Application configuration module to register a new module
ApplicationConfiguration.registerModule('users');
'use strict';

// Setting up route
angular.module('core').config(['$stateProvider', '$urlRouterProvider',
	function($stateProvider, $urlRouterProvider) {
		// Redirect to home view when route not found
		$urlRouterProvider.otherwise('/');

		// Home state routing
		$stateProvider.
		state('home', {
			url: '/',
			templateUrl: 'modules/core/views/home.client.view.html'
		});
	}
]);

'use strict';

angular.module('core').controller('HeaderController', ['$scope', 'Authentication', '$location', '$mdSidenav', '$http', '$mdDialog',
	function($scope, Authentication, $location, $mdSidenav, $http, $mdDialog) {
		$scope.authentication = Authentication;
		$scope.isCollapsed = false;
		$scope.isSignin = $location.path() === '/signin';


		$scope.goHome = function() {
			$location.path('/');
		};

		$scope.editProfile = function() {
			$mdSidenav('right').toggle();
			$location.path('/settings/profile');
		};

		$scope.updatePword = function() {
			$mdSidenav('right').toggle();
			$location.path('/settings/password');
		};

		$scope.toggleRight = function() {
			$mdSidenav('right').toggle();
		};

		$scope.signout = function() {
			$mdSidenav('right').close();

			$http.get('/auth/signout').success(function(response) {
				$scope.authentication.user =null;
				$location.path('/');

			}).error(function(response) {
				$scope.error = response.message;
			});
		};

		$scope.toggleCollapsibleMenu = function() {
			$scope.isCollapsed = !$scope.isCollapsed;
		};

		// Collapsing the menu after navigation
		$scope.$on('$stateChangeSuccess', function() {
			$scope.isSignin = $location.path() === '/signin';
			$scope.isCollapsed = false;

		});

	}
]);

'use strict';

angular.module('core').controller('HomeController', ['$scope', 'Authentication', '$location',
	function($scope, Authentication, $location) {
		$scope.authentication = Authentication;

		$scope.$on('$stateChangeSuccess', function() {
			// Redirect users signed in to simulations page should they try to access homepage
			if ($scope.authentication.user) $location.path('/simulations');
		});
	}
]);

'use strict';

angular.module('core').directive('omHeader', function() {
	return {
		templateUrl: function(elem, attr) {
			return '/modules/core/views/user-header.client.view.html';
		}
	};
});

'use strict';

//Menu service used for managing  menus
angular.module('core').service('Menus', [

	function() {
		// Define a set of default roles
		this.defaultRoles = ['*'];

		// Define the menus object
		this.menus = {};

		// A private function for rendering decision 
		var shouldRender = function(user) {
			if (user) {
				if (!!~this.roles.indexOf('*')) {
					return true;
				} else {
					for (var userRoleIndex in user.roles) {
						for (var roleIndex in this.roles) {
							if (this.roles[roleIndex] === user.roles[userRoleIndex]) {
								return true;
							}
						}
					}
				}
			} else {
				return this.isPublic;
			}

			return false;
		};

		// Validate menu existance
		this.validateMenuExistance = function(menuId) {
			if (menuId && menuId.length) {
				if (this.menus[menuId]) {
					return true;
				} else {
					throw new Error('Menu does not exists');
				}
			} else {
				throw new Error('MenuId was not provided');
			}

			return false;
		};

		// Get the menu object by menu id
		this.getMenu = function(menuId) {
			// Validate that the menu exists
			this.validateMenuExistance(menuId);

			// Return the menu object
			return this.menus[menuId];
		};

		// Add new menu object by menu id
		this.addMenu = function(menuId, isPublic, roles) {
			// Create the new menu
			this.menus[menuId] = {
				isPublic: isPublic || false,
				roles: roles || this.defaultRoles,
				items: [],
				shouldRender: shouldRender
			};

			// Return the menu object
			return this.menus[menuId];
		};

		// Remove existing menu object by menu id
		this.removeMenu = function(menuId) {
			// Validate that the menu exists
			this.validateMenuExistance(menuId);

			// Return the menu object
			delete this.menus[menuId];
		};

		// Add menu item object
		this.addMenuItem = function(menuId, menuItemTitle, menuItemURL, menuItemType, menuItemUIRoute, isPublic, roles, position) {
			// Validate that the menu exists
			this.validateMenuExistance(menuId);

			// Push new menu item
			this.menus[menuId].items.push({
				title: menuItemTitle,
				link: menuItemURL,
				menuItemType: menuItemType || 'item',
				menuItemClass: menuItemType,
				uiRoute: menuItemUIRoute || ('/' + menuItemURL),
				isPublic: ((isPublic === null || typeof isPublic === 'undefined') ? this.menus[menuId].isPublic : isPublic),
				roles: ((roles === null || typeof roles === 'undefined') ? this.menus[menuId].roles : roles),
				position: position || 0,
				items: [],
				shouldRender: shouldRender
			});

			// Return the menu object
			return this.menus[menuId];
		};

		// Add submenu item object
		this.addSubMenuItem = function(menuId, rootMenuItemURL, menuItemTitle, menuItemURL, menuItemUIRoute, isPublic, roles, position) {
			// Validate that the menu exists
			this.validateMenuExistance(menuId);

			// Search for menu item
			for (var itemIndex in this.menus[menuId].items) {
				if (this.menus[menuId].items[itemIndex].link === rootMenuItemURL) {
					// Push new submenu item
					this.menus[menuId].items[itemIndex].items.push({
						title: menuItemTitle,
						link: menuItemURL,
						uiRoute: menuItemUIRoute || ('/' + menuItemURL),
						isPublic: ((isPublic === null || typeof isPublic === 'undefined') ? this.menus[menuId].items[itemIndex].isPublic : isPublic),
						roles: ((roles === null || typeof roles === 'undefined') ? this.menus[menuId].items[itemIndex].roles : roles),
						position: position || 0,
						shouldRender: shouldRender
					});
				}
			}

			// Return the menu object
			return this.menus[menuId];
		};

		// Remove existing menu object by menu id
		this.removeMenuItem = function(menuId, menuItemURL) {
			// Validate that the menu exists
			this.validateMenuExistance(menuId);

			// Search for menu item to remove
			for (var itemIndex in this.menus[menuId].items) {
				if (this.menus[menuId].items[itemIndex].link === menuItemURL) {
					this.menus[menuId].items.splice(itemIndex, 1);
				}
			}

			// Return the menu object
			return this.menus[menuId];
		};

		// Remove existing menu object by menu id
		this.removeSubMenuItem = function(menuId, submenuItemURL) {
			// Validate that the menu exists
			this.validateMenuExistance(menuId);

			// Search for menu item to remove
			for (var itemIndex in this.menus[menuId].items) {
				for (var subitemIndex in this.menus[menuId].items[itemIndex].items) {
					if (this.menus[menuId].items[itemIndex].items[subitemIndex].link === submenuItemURL) {
						this.menus[menuId].items[itemIndex].items.splice(subitemIndex, 1);
					}
				}
			}

			// Return the menu object
			return this.menus[menuId];
		};

		//Adding the topbar menu
		this.addMenu('topbar');
	}
]);
/**
 * Created by dayj on 4/20/15.
 */
'use strict';

/// tell jslint that io is global and shouldn't be assigned in this file
/* global io: false */

//socket factory that provides the socket service
angular.module('core').factory('Socket', ['socketFactory',
	function(socketFactory) {
		return socketFactory({
			prefix: '',
			//ioSocket: io.connect('http://localhost:3000')
			ioSocket: io.connect('/')
		});
	}
]);

'use strict';

// Configuring the Models module
angular.module('models').run([function() {

	}
]);

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

'use strict';

// M controller
angular.module('models').controller('ModelsController', ['$scope', '$stateParams', '$location', 'Authentication', 'Models',
	function($scope, $stateParams, $location, Authentication, Models) {
		$scope.authentication = Authentication;

		$scope.goToCreate = function() {
			$location.path('models/create');
		};

		// Create new Model
		$scope.create = function() {
			// Create new Model object

			var modelJSON = JSON.parse($scope.modelJSON);

			var model = new Models(modelJSON);

			// Redirect after save
			model.$save(function(response) {
				$location.path('models');

				// Clear form fields
				$scope.modelJSON = '';
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Remove existing Model
		$scope.remove = function(model) {
			if (model) {
				model.$remove();

				for (var i in $scope.models) {
					if ($scope.models[i] === model) {
						$scope.models.splice(i, 1);
					}
				}
			} else {
				$scope.model.$remove(function() {
					$location.path('models');
				});
			}
		};

		// Update existing Article
		$scope.update = function() {
			var model = $scope.model;

			model.$update(function() {
				$location.path('models/' + model._id);
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Find a list of Models
		$scope.find = function() {
			$scope.models = Models.query();
		};

		// Find existing Article
		$scope.findOne = function() {
			$scope.model = Models.get({
				modelId: $stateParams.modelId
			});
			console.log($scope.model);
		};

	}
]);

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

'use strict';

// Configuring the Models module
angular.module('simulations').run([function() {

	}
]);

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

'use strict';

// M controller
angular.module('simulations').controller('AnalyzeSimulationController', ['$scope', '$http', '$mdDialog', '$stateParams', '$location', '$anchorScroll', 'Authentication', 'Simulations',
	'AnalyzeState',
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
			$scope.active_vars.push(curvar);
			$scope.genVars($scope.per_row);
			$mdDialog.cancel();
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

		$scope.renderGraphs = function(total_num, row_num){
			$http.get('/output/json/' + $stateParams.simulationId.toString()).success(function(raw_data) {
				console.log($scope.curSim);
				if($scope.simulation._id !== $scope.curSim){
					$scope.legend_on = true;
				}else{
					$scope.legend_on = false;
				}

				console.log($scope.legend_on);

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

			for(var i = 0; i < $scope.active_vars.length; i++){
				console.log($scope.active_vars[i]);
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

				cur_row.unshift(cur_obj);
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



'use strict';

// M controller
angular.module('simulations').controller('SimulationController', ['$scope', '$stateParams', '$location', 'Authentication', 'Simulations', '$anchorScroll',
	function($scope, $stateParams, $location, Authentication, Simulations, $anchorScroll) {

		$scope.authentication = Authentication;

		$scope.selectedIndex = 0;

		if ($stateParams.simulationId === undefined) { $location.path('/simulations'); }

		$scope.findOne = function () {
			$scope.simulation = Simulations.get({
				simulationId: $stateParams.simulationId
			}, function () {
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
			var old = $location.hash();
			$location.hash(anch);
			$anchorScroll();
			$location.hash(old);
		};
	}
]);

'use strict';

// M controller
angular.module('simulations').controller('ListSimulationsController', ['$scope', '$http', '$mdDialog', '$stateParams', '$location', 'Authentication', 'Simulations', '$anchorScroll', 'Models',
	function($scope, $http, $mdDialog, $stateParams, $location, Authentication, Simulations, $anchorScroll, Models) {

		$scope.authentication = Authentication;

		$scope.selectedIndex = 0;

		$scope.goToAnchor = function (anch) {

			$location.hash(anch);
			$anchorScroll();

		};

		$scope.breadcrumbs = [
			{
				title:'Simulations',
				link: '/#!/'
			}];

		// Create new Simulation
		$scope.create = function () {
			// Create new Simulation object

			var simulation = new Simulations({
				name:  this.simulation.name,
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
			$http.delete('/simulations/' + simulation._id).
				success(function (data, status, headers, config) {
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
				'_id':        simulation._id,
				'parameters': simulation.parameters,
				'shocks':     simulation.shocks
			};

			Simulations.update(obj,
				function () {}, function (errorResponse) {
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

'use strict';

// M controller
angular.module('simulations').controller('ParametersSimulationController', ['$scope', '$http', '$mdDialog', '$stateParams', '$location', 'Authentication', 'Simulations', 'Models', 'Socket', '$anchorScroll',
	function($scope, $http, $mdDialog, $stateParams, $location, Authentication, Simulations, Models, Socket, $anchorScroll) {

		$scope.authentication = Authentication;

		$scope.selectedIndex = 1;

		if ($stateParams.simulationId === undefined) { $location.path('/simulations'); }

		// Update existing Simulation
		$scope.update = function () {
			var simulation = $scope.simulation;

			var obj = {
				'_id':        simulation._id,
				'parameters': simulation.parameters,
				'dsf' : simulation.dsf
			};

			Simulations.update(
				obj,
				function () {},
				function (errorResponse) {
					console.log(errorResponse.data.message);
					$scope.error = errorResponse.data.message;
				});
		};

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

			$scope.editingDSF = false;
		};

		$scope.editParam = function (parameter){
			$scope.selectedParameter = parameter;
			$scope.editingDSF = false;
		};

		$scope.useDefaultValue = function() {
			$scope.selectedParameter.value = $scope.selectedParameter.default_value;
		};

		$scope.toggleDSF = function() {
			$scope.editingDSF = !$scope.editingDSF;
			$scope.selectedParameter = null;
		};

		$scope.goToRun = function() {
			var path = '/simulations/' + $scope.simulation._id + '/run';
			$location.path(path);
		};

		$scope.$on('$destroy', function() {
			// Call update for parameters when client navigates AWAY from page
			$scope.update();
		});

	}
]);

'use strict';

// M controller
angular.module('simulations').controller('RunSimulationController', ['$scope', '$stateParams', '$location', '$anchorScroll', 'Authentication', 'SimulationState', 'Simulations',
	function($scope, $stateParams, $location, $anchorScroll, Authentication, SimulationState, Simulations) {

		$scope.authentication = Authentication;

		$scope.selectedIndex = 3;

		if ($stateParams.simulationId === undefined) { $location.path('/simulations'); }

		$scope.output = '';
		$scope.canExport = false;

		// Update existing Simulation
		$scope.update = function () {
			var simulation = $scope.simulation;

			var obj = {
				'_id':        simulation._id,
				'log': simulation.log
			};

			console.log('@ obj ', obj);
			console.log('@ sim log ', simulation.log);

			Simulations.update(
				obj,
				function () {},
				function (errorResponse) {
					console.log(errorResponse.data.message);
					$scope.error = errorResponse.data.message;
				});
		};

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


		$scope.runSimulation = function() {
			console.log('pushing new log!');
			$scope.simulation.log.push({
				date: Date.now(),
				status: 'Running',
				info: ''
			});

			SimulationState().runSimulation(
				$stateParams.simulationId,
				function(data, status, headers, config){
					// success function
				},
				function(data, status, headers, config){
					// error function
					/// TODO: handle error
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
				function(text) {
					// info function
					//$scope.simulation.log[$scope.simulation.log.length - 1].info += text;
					$scope.simulation.log[$scope.simulation.log.length - 1].status = text;
					console.log('updating status in sim\'s log');
					$scope.update();
				});
		};
}]);



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

'use strict';
/* global MathJax: false */

// Models service used for communicating with the models REST endpoints
angular.module('simulations').directive('landingPage', function() {
	return {
		templateUrl: function(elem, attr) {
			return '/modules/simulations/models/'+attr.modelName+'.model.template.html';
		}
	};
}).directive('omtHeader', function() {
	return {
		transclude:true,
		templateUrl: function(elem, attr) {
			return 'modules/core/views/header.client.view.html';
		}
	};
}).directive('omTabbar', ['$location', function($location) {
	return {
		transclude:true,
		link: function (scope, element, attrs) {
			var tabs = [
				'/simulations/%s',
				'/simulations/%s/edit/parameters',
				'/simulations/%s/edit/shocks',
				'/simulations/%s/run',
				'/simulations/%s/analyze'
			];
			scope.changeTab = function (simulationId, idx){
				$location.path(tabs[idx].replace('%s', simulationId));
			};

		},
		templateUrl: function(elem, attr) {
			return 'modules/simulations/views/tabbar.client.view.html';
		}
	};
}]).directive('mathjaxBind', function() {
		return {
			restrict: 'A',
			controller: ['$scope', '$element', '$attrs',
				function($scope, $element, $attrs) {
					$scope.$watch($attrs.mathjaxBind, function(texExpression) {
							console.log('mathjax-bind');
							var texScript = angular.element('<script type="math/tex">')
								.html(texExpression ? texExpression :  '');
							$element.html('');
							$element.append(texScript);
							MathJax.Hub.Queue(['Reprocess', MathJax.Hub, $element[0]]);
					});
				}]
		};
	}).directive('mathjax',function(){
	return {
		restrict: 'EA',
		link: function(scope, element, attrs) {
			MathJax.Hub.Queue(['Typeset',MathJax.Hub]);
		}
	};
}).directive('omSidebar', ['$window', function($window) {

	var link =function (scope, element, attrs) {
		/* global $: false */
		element = $(element[0]);
		/// 141 is the combined height of the header and toolbar
		element.height($($window).height() - 112);
		element.addClass('om-sidebar');

	};

	return {
		restrict: 'EA',
		link: link
	};

}]).directive('omToolbarlessHeight', ['$window', function($window) {

		var link =function (scope, element, attrs) {
			/* global $: false */
			element = $(element[0]);
			/// 64 is the height of just the header
			element.height($($window).height() - 64);
			//element.addClass('om-sidebar');

		};

		return {
			restrict: 'EA',
			link: link
		};

	}]).directive('omFillHeight', ['$window', function($window) {

	var link =function (scope, element, attrs) {
		/* global $: false */
		element = $(element[0]);
		/// 141 is the combined height of the header and toolbar
		element.height($($window).height() - 140);
		//element.addClass('om-sidebar');

	};

	return {
		restrict: 'EA',
		link: link
	};

}]).filter('capitalize', function() {
	return function(input, all) {
		return (!!input) ? input.replace(/([^\W_]+[^\s-]*) */g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();}) : '';
	};
});

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

'use strict';

// Config HTTP Error Handling
angular.module('users').config(['$httpProvider',
	function($httpProvider) {
		// Set the httpProvider "not authorized" interceptor
		$httpProvider.interceptors.push(['$q', '$location', 'Authentication',
			function($q, $location, Authentication) {
				return {
					responseError: function(rejection) {
						switch (rejection.status) {
							case 401:
								// Deauthenticate the global user
								Authentication.user = null;

								// Redirect to signin page
								$location.path('signin');
								break;
							case 403:
								// Add unauthorized behaviour 
								break;
						}

						return $q.reject(rejection);
					}
				};
			}
		]);
	}
]);
'use strict';

// Setting up route
angular.module('users').config(['$stateProvider',
	function($stateProvider) {
		// Users state routing
		$stateProvider.
		state('profile', {
			url: '/settings/profile',
			templateUrl: 'modules/users/views/settings/edit-profile.client.view.html'
		}).
		state('password', {
			url: '/settings/password',
			templateUrl: 'modules/users/views/settings/change-password.client.view.html'
		}).
		state('signup', {
			url: '/signup',
			templateUrl: 'modules/users/views/authentication/signup.client.view.html'
		}).
		state('signin', {
			url: '/signin',
			templateUrl: 'modules/users/views/authentication/signin.client.view.html'
		}).
		state('forgot', {
			url: '/password/forgot',
			templateUrl: 'modules/users/views/password/forgot-password.client.view.html'
		}).
		state('reset-invalid', {
			url: '/password/reset/invalid',
			templateUrl: 'modules/users/views/password/reset-password-invalid.client.view.html'
		}).
		state('reset-success', {
			url: '/password/reset/success',
			templateUrl: 'modules/users/views/password/reset-password-success.client.view.html'
		}).
		state('reset', {
			url: '/password/reset/:token',
			templateUrl: 'modules/users/views/password/reset-password.client.view.html'
		});
	}
]);

'use strict';

angular.module('users').controller('AuthenticationController', ['$scope', '$http', '$location', 'Authentication',
	function($scope, $http, $location, Authentication, $mdDialog) {
		$scope.authentication = Authentication;

		// If user is signed in then redirect back home
		if ($scope.authentication.user) $location.path('/');

		$scope.signup = function() {
			$http.post('/auth/signup', $scope.credentials).success(function(response) {
				// If successful we assign the response to the global user model
				$scope.authentication.user = response;

				// And redirect to the index page
				$location.path('/simulations');
			}).error(function(response) {
				$scope.error = response.message;
			});
		};

		$scope.signin = function() {
			$http.post('/auth/signin', $scope.credentials).success(function(response) {
				// If successful we assign the response to the global user model
				$scope.authentication.user = response;

				// And redirect to the index page
				$location.path('/simulations');
			}).error(function(response) {
				$scope.error = response.message;
			});
		};
	}
]);


'use strict';

angular.module('users').controller('PasswordController', ['$scope', '$stateParams', '$http', '$location', 'Authentication',
	function($scope, $stateParams, $http, $location, Authentication) {
		$scope.authentication = Authentication;

		//If user is signed in then redirect back home
		if ($scope.authentication.user) $location.path('/');

		// Submit forgotten password account id
		$scope.askForPasswordReset = function() {
			$scope.success = $scope.error = null;

			$http.post('/auth/forgot', $scope.credentials).success(function(response) {
				// Show user success message and clear form
				$scope.credentials = null;
				$scope.success = response.message;

			}).error(function(response) {
				// Show user error message and clear form
				$scope.credentials = null;
				$scope.error = response.message;
			});
		};

		// Change user password
		$scope.resetUserPassword = function() {
			$scope.success = $scope.error = null;

			$http.post('/auth/reset/' + $stateParams.token, $scope.passwordDetails).success(function(response) {
				// If successful show success message and clear form
				$scope.passwordDetails = null;

				// Attach user profile
				Authentication.user = response;

				// And redirect to the index page
				$location.path('/password/reset/success');
			}).error(function(response) {
				$scope.error = response.message;
			});
		};
	}
]);
'use strict';

angular.module('users').controller('SettingsController', ['$scope', '$http', '$location', 'Users', 'Authentication',
	function($scope, $http, $location, Users, Authentication) {
		$scope.foo = true;
		$scope.user = Authentication.user;

		// If user is not signed in then redirect back home
		if (!$scope.user) $location.path('/');

		// Check if there are additional accounts
		$scope.hasConnectedAdditionalSocialAccounts = function(provider) {
			for (var i in $scope.user.additionalProvidersData) {
				return true;
			}

			return false;
		};

		// Check if provider is already in use with current user
		$scope.isConnectedSocialAccount = function(provider) {
			return $scope.user.provider === provider || ($scope.user.additionalProvidersData && $scope.user.additionalProvidersData[provider]);
		};

		// Remove a user social account
		$scope.removeUserSocialAccount = function(provider) {
			$scope.success = $scope.error = null;

			$http.delete('/users/accounts', {
				params: {
					provider: provider
				}
			}).success(function(response) {
				// If successful show success message and clear form
				$scope.success = true;
				$scope.user = Authentication.user = response;
			}).error(function(response) {
				$scope.error = response.message;
			});
		};

		// Update a user profile
		$scope.updateUserProfile = function(isValid) {
			if (isValid) {
				$scope.success = $scope.error = null;
				var user = new Users($scope.user);

				user.$update(function(response) {
					$scope.success = true;
					Authentication.user = response;
				}, function(response) {
					$scope.error = response.data.message;
				});
			} else {
				$scope.submitted = true;
			}
		};

		// Change user password
		$scope.changeUserPassword = function() {
			$scope.success = $scope.error = null;

			$http.post('/users/password', $scope.passwordDetails).success(function(response) {
				// If successful show success message and clear form
				$scope.success = true;
				$scope.passwordDetails = null;
			}).error(function(response) {
				$scope.error = response.message;
			});
		};
	}
]);

'use strict';

// Authentication service for user variables
angular.module('users').factory('Authentication', ['$window', function($window) {
	var auth = {
		user: $window.user
	};
	
	return auth;
}]);

'use strict';

// Users service used for communicating with the users REST endpoint
angular.module('users').factory('Users', ['$resource',
	function($resource) {
		return $resource('users', {}, {
			update: {
				method: 'PUT'
			}
		});
	}
]);