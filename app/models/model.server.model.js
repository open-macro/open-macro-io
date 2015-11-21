'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var deepPopulate = require('mongoose-deep-populate');


/**
 * Endovar Schema
 */
var EndovarSchema = new Schema({
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
    }
});

var EquationSchema = new Schema({
    created: {
        type: Date,
        default: Date.now
    },
    name: {
        type: String,
        required: true,
        trim: true
    },
    latex: {
        type: String,
        required: true,
        trim: true
    },
    description: {
        type: String,
        required: true,
        trim: true
    }
});

/**
 * Parameter Schema
 */
var ParameterSchema = new Schema({
    created: {
        type: Date,
        default: Date.now
    },
    name: {
        type: String,
        required: true,
        trim: true
    },
    latex: {
        type: String,
        required: true,
        trim: true
    },
    notes: {
        type: String,
        trim: true
    },
    description: {
        type: String,
        required: true,
        trim: true
    },
    default_value: {
        type: String,
        required: true,
        trim: true
    },
    value: {
        type: String,
        trim: true
    },

    equations: [EquationSchema]

});

ParameterSchema.plugin(deepPopulate, {});

mongoose.model('Parameter', ParameterSchema);


/**
 * Exovar Schema
 */
var ExovarSchema = new Schema({
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
    initial_value: {
        type: String,
        required: true,
        trim: true
    }
});


//var Endovar = mongoose.model('Endovar', EndovarSchema);

/**
 * Model Schema
 */
var ModelSchema = new Schema({
    created: {
        type: Date,
        default: Date.now
    },
    name: {
        type: String,
        required: true,
        trim: true
    },
    pdf: {
        type: String,
        required: true,
        trim: true
    },
    description: {
        type: String,
        required: true,
        trim: true
    },
    short_name: {
        type: String,
        required: true,
        trim: true
    },
    endovars: [EndovarSchema],
    exovars: [ExovarSchema],
    params_deep: [ParameterSchema],
    params_init: [ParameterSchema],
    equations: [EquationSchema]
});

/**
 * Statics
 */
ModelSchema.statics.load = function (id, cb) {
    this.findOne({
        _id: id
    }).exec(cb);
};

mongoose.model('Model', ModelSchema);
