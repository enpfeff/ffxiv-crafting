const _ = require('lodash');
const log = require('./log');
const Roi = require('../models/roi.model');

// ------------------------------------------------------------------
//	Main
// ------------------------------------------------------------------
module.exports = analytics;


function analytics(craftDetails) {
    if(_.isUndefined(craftDetails.analyze) || !craftDetails.analyze) return;

    const ret = [];

	log.info(`------------------------------------------------------------------`);
	log.info(`\t${craftDetails.name}`);
	log.info(`------------------------------------------------------------------`);

	const marketValuePerItem = craftDetails.marketValuePerItem;
	const itemsPerCraft = craftDetails.itemsPerCraft;

	log.info(`\t--- Just Crafting ---`);
	const wholesalePerCraft = _.reduce(craftDetails.craft, (result, details) => result += details.price, 0);
	let rois = analyzeOne(wholesalePerCraft, craftDetails.craft, false);
	ret.push(rois);

	log.info(`\t--- With Sourced Materials ---`);
	const wholesalePerCraftSourced = _.reduce(craftDetails.craft, (result, details) => {
		if(!_.isUndefined(details.sourced) && details.sourced) return result;
		result += details.price;
		return result;
	}, 0);

    rois = analyzeOne(wholesalePerCraftSourced, craftDetails.craft, true);
	ret.push(rois);

	return ret;

	function analyzeOne(wholesalePerCraft, recipe, sourced) {
		// how much is a craft worth?
		const marketPerCraft = marketValuePerItem * itemsPerCraft;
		// how much does a craft cost/item?
		const wholsalePerItem = (wholesalePerCraft / itemsPerCraft);
		// how much do we make per craft
		const earningsPerCraft = (marketPerCraft - wholesalePerCraft);
		// ROI = (profit/initialCost * 100%)
		const ROI = (((marketValuePerItem - wholsalePerItem) / wholsalePerItem) * 100);

		// ------------------------------------------------------------------
		//	Print out
		// ------------------------------------------------------------------
		log.info(`\twholesale/Craft:\t ${toFormatCurrancy(wholesalePerCraft)}`);
		log.info(`\twholesale/Item:\t\t ${toFormatCurrancy(wholsalePerItem)}`);
		log.info(`\tmarket value/Craft:\t ${toFormatCurrancy(marketPerCraft)}`);
		log.info(`\tearnings/craft:\t\t ${toFormatCurrancy(earningsPerCraft)}`);
		log.info(`\tROI:\t\t\t ${ROI.toFixed(2)}%`);

		return new Roi({
            name: craftDetails.name,
            time: new Date(),
            recipe: _.map(recipe, (details, name) => {
                return {
                	name,
					price: details.price,
					sourced: !_.isUndefined(details.sourced) && details.sourced
                };
            }),
            values: {
                roi: ROI,
                earningsPerCraft,
                marketPerCraft,
                wholsalePerItem,
                wholesalePerCraft
            },
            meta: {
                sourced
            }
        });
	}
}


// ------------------------------------------------------------------
//	Helper shit
// ------------------------------------------------------------------

function toFormatCurrancy(number) {
	return `$${number.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,')}`
}