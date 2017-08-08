/**
 * Created by enpfeff on 8/7/17.
 */
/**
 * @module what-tools
 * @since 10/16/16
 * @author Ian Pfeffer
 */
"use strict";

const C = require('./constants');
const P = require('bluebird');
const _ = require('lodash');
const mongoose = require('mongoose');
const log = require('./log');

mongoose.Promise = P;

let connected = false;

const mongooseConnectionoOpts = {
    useMongoClient: true,
    socketTimeoutMS: 0,
    keepAlive: true,
    reconnectTries: 30,
    sslValidate: false
};


function init(mongoUrl) {
    // for child processes to log
    let logger = log;
    const MONGO_URL = _.isUndefined(mongoUrl) ? C.MONGO_URL : mongoUrl;

    logger.info(`[Mongoose] Connecting to ${MONGO_URL}`);
    return mongoose.connect(MONGO_URL, mongooseConnectionoOpts)

}

module.exports = init;
