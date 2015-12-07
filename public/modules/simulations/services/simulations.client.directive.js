'use strict';
/* global MathJax: false */

// Models service used for communicating with the models REST endpoints
angular.module('simulations').directive('landingPage', function() {
	return {
		templateUrl: function(elem, attr) {
			return '/modules/simulations/models/' + attr.modelName + '.model.template.html';
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
}).filter('capitalize', function() {
	return function(input, all) {
		return (!!input) ? input.replace(/([^\W_]+[^\s-]*) */g,
            function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();}) : '';
	};
});
