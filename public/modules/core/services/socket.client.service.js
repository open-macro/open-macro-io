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
