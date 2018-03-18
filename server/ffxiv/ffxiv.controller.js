const Service = require('./ffxiv.service');
const service = Service();

module.exports = {
    getItemsForRecipe
};

async function getItemsForRecipe(req, res) {
    const whatIWantToMake = req.body;
    const recipes = await Promise.all(_.map(whatIWantToMake, async thing => await service.getRecipe(thing.name, thing.quantity || 1)));
    const mats = combineRecipe(recipes);

    res.send(200).json(mats);

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
}
