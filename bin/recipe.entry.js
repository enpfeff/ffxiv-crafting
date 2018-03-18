const R = require('request-promise');
const log = require('../server/services/log');
const _ = require('lodash');
const Service = require('../server/ffxiv/ffxiv.service');
const service = Service();

const whatIWantToMake = [{
    name: 'Slothskin Belt of Scouting',
    quantity: 2
}, {
    name: 'Slothskin Belt of Aiming',
    quantity: 1
}];

init();

async function init() {
    // get item by name
    const recipes = await Promise.all(_.map(whatIWantToMake, async thing => await service.getRecipe(thing.name, thing.quantity)));
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
    return fullRecipe;
}

