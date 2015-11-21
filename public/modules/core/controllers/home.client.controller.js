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
