'use strict';

angular.module('core').directive('omHeader', function() {
	return {
		templateUrl: function(elem, attr) {
			return '/modules/core/views/user-header.client.view.html';
		}
	};
});
