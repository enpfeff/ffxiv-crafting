const _ = require('lodash');

// ------------------------------------------------------------------
//	Config
// ------------------------------------------------------------------

const DUSKLIGHT_PRICE = 11000;

crafts = {
	'Pork Kukani': {
		craft: {
			dusklightAethersand: {price: DUSKLIGHT_PRICE, sourced: true},
			koshuPork: {price: 16000},
			OrientalSoySauce: {price: 4787},
			CookingSake: {price: 1000},
			JhammelGinger: {price: 2800}
		},
		itemsPerCraft: 3,
		marketValuePerItem: 14000,
		analyze: true
	},

	'Infusions': {
		craft: {
			crescentSpringWater: {price: 585},
			alaMhiganSaltCrystals: {price: 2100},
			chickweed: {price: 800},
			dusklightAethersand: {price: DUSKLIGHT_PRICE, sourced: true}
		},
		itemsPerCraft: 3,
		marketValuePerItem: 9000,
		analyze: true
	},

	'Persimmon Leaf Sushi': {
		craft: {
			koshuStickyRice: {price: 1350},
			riceVinegar: {price: 3000},
			persimmonLeaf: {price: 250},
			ivorySole: {price: 10000},
			motleyBeakFish: {price: 2500},
			dusklightAethersand: {price: DUSKLIGHT_PRICE, sourced: true}		
		},
		itemsPerCraft: 3,
		marketValuePerItem: 13500,
		analyze: true
	}
};

// ------------------------------------------------------------------
//	Main
// ------------------------------------------------------------------
_.each(crafts, (craftDetails, craftName) => {
	if(!_.isUndefined(craftDetails.analyze) && craftDetails.analyze) 
		return analytics(craftDetails, craftName);
});

// ------------------------------------------------------------------
//	Funtions
// ------------------------------------------------------------------
function analytics(craftDetails, craftName) {
	console.log(`------------------------------------------------------------------`);
	console.log(`\n\t${craftName}\n`);
	console.log(`------------------------------------------------------------------\n`);

	const marketValuePerItem = craftDetails.marketValuePerItem;
	const itemsPerCraft = craftDetails.itemsPerCraft;

	console.log(`\t--- Just Crafting ---\n`);
	const wholesalePerCraft = _.reduce(craftDetails.craft, (result, details) => result += details.price, 0);
	analyzeOne(wholesalePerCraft);

	console.log(`\n\t--- With Sourced Materials ---\n`);
	const wholesalePerCraftSourced = _.reduce(craftDetails.craft, (result, details) => {
		if(!_.isUndefined(details.sourced) && details.sourced) return result;
		result += details.price;
		return result;
	}, 0);

	analyzeOne(wholesalePerCraftSourced);
	console.log('\n\n');

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
		console.log(`\twholesale/Craft:\t ${toFormatCurrancy(wholesalePerCraft)}`);
		console.log(`\twholesale/Item:\t\t ${toFormatCurrancy(wholsalePerItem)}`);
		console.log(`\tmarket value/Craft:\t ${toFormatCurrancy(marketPerCraft)}`);
		console.log(`\tearnings/craft:\t\t ${toFormatCurrancy(earningsPerCraft)}`);
		console.log(`\tROI:\t\t\t ${ROI.toFixed(2)}%`);
	}

}


// ------------------------------------------------------------------
//	Helper shit
// ------------------------------------------------------------------

function toFormatCurrancy(number) {
	return `$${number.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,')}`
}