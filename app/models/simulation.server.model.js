'use strict';

/**
 *
 * Module dependencies.
 */
var mongoose = require('mongoose'),
    Parameter = mongoose.model('Parameter'),
    Shock = mongoose.model('Shock'),
    Schema = mongoose.Schema;


var deepPopulate = require('mongoose-deep-populate');

/**
 *
 * Simulation Schema
 */
var SimulationSchema = new Schema({
    created: {
        type: Date,
        default: Date.now
    },
    modified: {
        type: Date,
        default: Date.now
    },
    name: {
        type: String,
        required: true,
        trim: true
    },
    model: {
        type: Schema.ObjectId,
        required: true,
        ref: 'Model'
    },
    description: {
        type: String,
        trim: true
    },
    user: {
        type: Schema.ObjectId,
        ref: 'User'
    },
    dsf: {
        type: String,
        required: true,
        default: '1,0,0'
    },
    visibleGraphKeys: [String],
    running: {
        type: Boolean,
        required: true,
        default: false
    },
    log: [{
        date: {
            type: Date,
            default: Date.now
        },
        status: {
            type: String,
            default: 'running'
        },
        info: {
            type: String,
            default: ''
        }
    }],
    parameters: [Parameter.schema],
    shocks: [Shock.schema]
});

SimulationSchema.plugin(deepPopulate, {});

/**
 *
 * Statics
 */
SimulationSchema.statics.load = function (id, cb) {
    this.findOne({
        _id: id
    }).populate('user', 'name username').exec(cb);
};

mongoose.model('Simulation', SimulationSchema);
