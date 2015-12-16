/**
 * Created by Christopher on 4/23/15.
 */
angular.module('mathjax', []).
	directive('mathjax', function() {
		return function(scope, el, attrs, ctrl) {
			scope.$watch(attrs.mathjax, function() {
				MathJax.Hub.Queue(['Typeset', MathJax.Hub, el[0]]);
			});
		};
	});
