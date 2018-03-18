const Service = require('./ffxiv.service');
const service = Service();
const _ = require('lodash');

module.exports = {
    getItemsForRecipe,
    search
};

async function search(req, res) {
    const query = req.query.query;
    const result = await service.search(query);
    res.json(result);
}

async function getItemsForRecipe(req, res) {
    const whatIWantToMake = _.castArray(_.map(req.query.recipes, JSON.parse));
    const recipes = await Promise.all(_.map(whatIWantToMake, async thing => await service.getRecipe(thing.name, thing.quantity || 1)));
    const mats = combineRecipe(recipes);

    res.json(mats);

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
}
