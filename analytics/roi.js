const _ = require('lodash');
const crafts = require('./input.config');
const log = require('./services/log');

// ------------------------------------------------------------------
//	Main
// ------------------------------------------------------------------
_.each(crafts, analytics);

// ------------------------------------------------------------------
//	Funtions
// ------------------------------------------------------------------
function analytics(craftDetails) {
    if(_.isUndefined(craftDetails.analyze) || !craftDetails.analyze) return;

	log.info(`------------------------------------------------------------------`);
	log.info(`\t${craftDetails.name}`);
	log.info(`------------------------------------------------------------------`);

	const marketValuePerItem = craftDetails.marketValuePerItem;
	const itemsPerCraft = craftDetails.itemsPerCraft;

	log.info(`\t--- Just Crafting ---`);
	const wholesalePerCraft = _.reduce(craftDetails.craft, (result, details) => result += details.price, 0);
	analyzeOne(wholesalePerCraft);

	log.info(`\t--- With Sourced Materials ---`);
	const wholesalePerCraftSourced = _.reduce(craftDetails.craft, (result, details) => {
		if(!_.isUndefined(details.sourced) && details.sourced) return result;
		result += details.price;
		return result;
	}, 0);

	analyzeOne(wholesalePerCraftSourced);
	function analyzeOne(wholesalePerCraft) {
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

		return {
		    roi: ROI,
            earningsPerCraft,
            marketPerCraft,
            wholsalePerItem,
            wholesalePerCraft
        };
	}

}


// ------------------------------------------------------------------
//	Helper shit
// ------------------------------------------------------------------

function toFormatCurrancy(number) {
	return `$${number.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,')}`
}