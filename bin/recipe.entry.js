const R = require('request-promise');
const log = require('../server/services/log');
const _ = require('lodash');
const Service = require('../server/ffxiv/ffxiv.service');
const service = Service();

const whatIWantToMake = [{
    name: 'True Linen Robe of Healing',
}, {
    name: 'True Linen Breeches of Healing'
}, {
    name: 'Slothskin Belt of Healing'
}, {
    name: 'Silvergrace Ring of Healing',
    quantity: 2
}, {
    name: 'Black Willow Armillae of Healing'
}];

init();

async function init() {
    // get item by name
    const recipes = await Promise.all(_.map(whatIWantToMake, async thing => await service.getRecipe(thing.name, thing.quantity || 1)));
    const mats = combineRecipe(recipes);

    log.info(JSON.stringify(mats, null, 4));
    //
    process.exit(0);
}

function combineRecipe(recipes) {
    const fullRecipe = {};
    _.each(recipes, recipe => {
        return _.reduce(recipe, (acc, val, key) => {
            if(acc[key]) acc[key] += val;
            else acc[key] = val;
            return acc;
        }, fullRecipe)
    });

    return _.map(fullRecipe, (val, key) => {
        return {
            name: key,
            quantity: val
        };
    });
}

