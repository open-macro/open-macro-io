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
