const router = require('express-promise-router')();
const controller = require('./ffxiv.controller');

module.exports = routes;

function routes(app) {
    router.get('/', controller.getItemsForRecipe);

    app.use('/recipe', router);
}