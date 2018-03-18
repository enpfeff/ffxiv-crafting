/**
 * Created by enpfeff on 8/7/17.
 */
const _ = require('lodash');
const RoiService = require('../server/services/roi.service');
const crafts = require('./roiInput.config');
const P = require('bluebird');
const log = require('../server/services/log');

// ------------------------------------------------------------------
//	Main
// ------------------------------------------------------------------
const models = _.chain(crafts)
    .map(RoiService)
    .flatten()
    .compact()
    .value();

if(process.env.INSERT === 'true') {
    const connection = require('../server/services/mongoConnection.service');

    return connection()
        .then(() => {
            return P.map(models, (model) => model.save())
                .then(() => log.info(`Saving ROI data complete`));
        })
        .then(() => process.exit(0))
        .catch(e => {
            log.error(e);
            process.exit(1);
        });

}