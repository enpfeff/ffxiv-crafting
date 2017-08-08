/**
 * Created by enpfeff on 8/7/17.
 */
/**
 * @summary Logger
 * @module Log
 * @memberof Utils
 * @since 2/12/16
 */

'use strict';

const _ = require('lodash');
const winston = require('winston');
const C = require('./constants');

const loglevel = C.LOG_LEVEL;
//By default we log to STDOUT (the Console)
let transports = [
    new (winston.transports.Console)({level: loglevel, colorize: true, timestamp: true})
];

if (C.LOG_TO_FILE) {
    //If logging to file, don't also log to console.
    transports.push(new (winston.transports.File)({
        level: loglevel,
        filename: C.LOG_FILE,
        colorize: true,
        timestamp: true,
        maxsize: Math.pow(10, 8),            //100mb
        tailable: true,
        maxFiles: 100,
        json: false
    }));
}

const logger = new (winston.Logger)({
    transports: transports
});

// we need an access point for morgan (route logging)
logger.stream = {
    write: function (message, encoding) {
        logger.info(message);
    }
};


function log(level, message) {
    if (_.isUndefined(message)) {
        message = level;
        level = 'verbose';
    }

    logger.log(level, message);
}


module.exports = log;
module.exports.stream = logger.stream;

// I'm sick of doing "log('<VERBOSITY>', ...)", so let's add some method wrappers
module.exports.error = _.partial(log, 'error');
module.exports.warn = _.partial(log, 'warn');
module.exports.info = _.partial(log, 'info');
module.exports.verbose = _.partial(log, 'verbose');
module.exports.debug = _.partial(log, 'debug');
module.exports.trace = _.partial(log, 'debug');
module.exports.log = log;