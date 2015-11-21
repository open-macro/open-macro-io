'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
	Schema = mongoose.Schema;

/**
 * Compute Schema
 */
var ComputeSchema = new Schema({
	name: {
		type: String,
		default: '',
		required: 'Please fill Compute name',
		trim: true
	},
	created: {
		type: Date,
		default: Date.now
	},
	user: {
		type: Schema.ObjectId,
		ref: 'User'
	}
});

mongoose.model('Compute', ComputeSchema);