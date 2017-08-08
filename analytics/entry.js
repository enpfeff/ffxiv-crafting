/**
 * Created by enpfeff on 8/7/17.
 */
const _ = require('lodash');
const RoiService = require('./services/roi.service');
const crafts = require('./input.config');

// ------------------------------------------------------------------
//	Main
// ------------------------------------------------------------------
_.each(crafts, RoiService.analytics);