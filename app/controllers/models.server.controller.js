'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
	errorHandler = require('./errors.server.controller'),
	Model = mongoose.model('Model'),
	_ = require('lodash');


var parse = function(obj, schema){
	var retVal = [];
	for (var key in obj){
		if (obj.hasOwnProperty(key)) {
			retVal.push(schema(obj, key));
		}
	}
	return retVal;
};

var parseEndovars = function(body) {
	return parse(body.endovars, function (obj, key) {
		return {
				name:key,
				units:obj[key].units,
				description:obj[key].description
			};
	});
};

var parseExovars = function(body) {
	return parse(body.exovars, function (obj, key) {
		return {
				name:key,
				units:obj[key].units,
				description:obj[key].description,
				initial_value:obj[key].initial_val
			};
	});
};

var parseEquations = function(body) {
	return parse(body.equations, function (obj, key) {
		return {
				name:key,
				latex:obj[key].latex,
				description:obj[key].description
			};
	});
};

var translateEquations = function(rawEquations, equations){
	var retVal = [];
	rawEquations = JSON.parse(rawEquations);
	for (var i=0; i < rawEquations.length; i++){
		var j = rawEquations[i];
		var eq = equations[j];
		retVal.push(eq);
	}
	return retVal;
};

var newParam = function(obj, key, equations){
	return {
			name:key,
			latex:obj[key].latex,
			notes:obj[key].notes,
			default_value:obj[key].default_val,
			description: obj[key].description,
			equations:translateEquations(obj[key].eqn_list, equations)
		};
};

var parseParamsDeep = function(body, equations) {
	return parse(body.params_deep, function (obj, key) {
		return newParam(obj, key, equations);
	});
};

var parseParamsInit = function(body, equations) {
	return parse(body.params_init, function (obj, key) {
		return newParam(obj, key, equations);
	});
};


/**
 * Create a model
 */
exports.create = function(req, res) {

	var equations = parseEquations(req.body);

	//console.log(endovars);
	var parsedVars = {
		endovars:parseEndovars(req.body),
		exovars:parseExovars(req.body),
		equations:equations,
		params_deep:parseParamsDeep(req.body, equations),
		params_init:parseParamsInit(req.body, equations)
	};

	var model = _.extend(req.body, parsedVars);

	model = new Model(model);
	model.user = req.user;

	model.save(function(err) {
		if (err) {
			console.log('Error' + err);
			console.log(errorHandler.getErrorMessage(err));
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.json(model);
		}
	});

};

/**
 * Show the current model
 */
exports.read = function(req, res) {
	res.json(req.model);
};

/**
 * Update a model
 */
exports.update = function(req, res) {
	var model = req.model;

	model = _.extend(model, req.body);

	model.save(function(err) {
		if (err) {
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.json(model);
		}
	});
};

/**
 * Delete a model
 */
exports.delete = function(req, res) {

	var model = req.model;

	model.remove(function(err) {
		if (err) {
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.json(model);
		}
	});
};

/**
 * List of Models
 */
exports.list = function(req, res) {
	Model.find().sort('-created')
		.populate('params_init', 'name')
		.exec(function(err, models) {
		if (err) {
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.json(models);
		}
	});
};

/**
 * Model middleware
 */
exports.modelByID = function(req, res, next, id) {

	if (!mongoose.Types.ObjectId.isValid(id)) {
		return res.status(400).send({
			message: 'Model is invalid'
		});
	}

	Model.findById(id).exec(function(err, model) {
		if (err) return next(err);
		if (!model) {
			return res.status(404).send({
				message: 'Model not found'
			});
		}
		req.model = model;
		next();
	});
};

/**
 * Model authorization middleware
 */
exports.hasAuthorization = function(req, res, next) {
	if (req.model.user.id !== req.user.id) {
		return res.status(403).send({
			message: 'User is not authorized'
		});
	}
	next();
};
