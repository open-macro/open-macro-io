
'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
	cp = require('child_process'),
	Simulation = mongoose.model('Simulation'),
	_ = require('lodash'),
	fs = require('fs.extra'),
	async = require('async'),
	swig = require('swig');


exports.exportJSONPlotVars = function(req, res) {

	var simulationId = req.simulation.id;
	console.log('creating outputs for:' + simulationId);
	var simulation_path = 'run/simulations/' + simulationId;

	var options = {
		root: simulation_path,
		dotfiles: 'deny',
		headers: {
			'x-timestamp': Date.now(),
			'x-sent': true
		}
	};

	var spawn = cp.spawn,
		plot = spawn(
			'python',
			['convertOutput.py', simulationId],
			{'cwd':'utils'});

	plot.stdout.on('data', function (data) {
		console.log('stdout: ' + data);
	});

	plot.stderr.on('data', function (data) {
		console.log('stderr: ' + data);
	});

	plot.on('close', function (code) {

		console.log('child process exited with code ' + code);

		var fileName = 'plot_vars.json';
		res.sendFile(fileName, options,  function (err) {
			if (err) {
				console.log(err);
				res.status(err.status).end();
			}
			else { console.log('Sent:', fileName); }
		});

	});

};

exports.exportPlotVars = function(req, res) {

	var simulationId = req.simulation.id;
	console.log('creating outputs for:' + simulationId);
	var simulation_path = 'run/simulations/' + simulationId.toString();

	var spawn = cp.spawn,
		plot = spawn(
			'python',
			['convertOutput.py', req.simulation.id],
			{'cwd':'utils'});

	plot.stdout.on('data', function (data) {
		console.log('stdout: ' + data);
	});

	plot.stderr.on('data', function (data) {
		console.log('stderr: ' + data);
	});

	plot.on('close', function (code) {

		console.log('child process exited with code ' + code);

		var options = {
			root: simulation_path,
			dotfiles: 'deny',
			headers: {
				'x-timestamp': Date.now(),
				'x-sent': true
			}
		};

		var fileName = 'plot_vars.csv';
		res.attachment(fileName);
		res.sendFile(fileName, options, function (err) {
			if (err) {
				console.log(err);
				res.status(err.status).end();
			}
			else { console.log('Sent:', fileName); }
		});

	});

};
