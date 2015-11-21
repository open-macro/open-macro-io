/**
 * Created by dayj on 3/30/15.
 */
'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
  Schema = mongoose.Schema;


/**
 * Shock Schema
 */
var ShockSchema = new Schema({
  created: {
    type: Date,
    default: Date.now
  },
  name: {
    type: String,
    required: true,
    trim: true
  },
	units: {
		type: String,
		required: true,
		trim: true
	},
	description: {
		type: String,
		required: true,
		trim: true
	},
  periods: [Number],
	ranges: [{
		start: {
			type: Number,
			required: true
		},
		end: {
			type: Number,
			required: true
		},
		value: {
			type: Number,
			required: true
		}
	}]
});


/**
* Statics
*/
ShockSchema.statics.load = function(id, cb) {
  this.findOne({
    _id: id
  }).exec(cb);
};

mongoose.model('Shock', ShockSchema);
