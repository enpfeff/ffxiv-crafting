const _ = require('lodash');
const log = require('../services/log');
const R = require('request-promise');
const elasticlunr = require('elasticlunr');
module.exports = FxivService;

function FxivService(endpoint) {
    log.info('Initializing FFXIV service');
    endpoint = endpoint || 'https://api.xivdb.com';

    let map = null;
    let recipesById = null;
    let index = null;

    // just initialize the service with things
    getMap().then(() => log.info('FFXIV map created'));

    return {
        getRecipe,
        search
    };

    async function search(query) {
        const index = await getIndex();
        const result = index.search(query, { expand: true });
        return _.map(result, res => {
            return recipesById[res.ref];
        });
    }

    async function getRecipe(name, multipler = 1) {
        name = name.toLowerCase();
        const map = await getMap();
        const id = map[name];

        if (!id) return log.error(`No name with ${name}`);

        const composedRecipe = await composeRecipe(await get(id));
        return massageData(composedRecipe);

        async function get(id) {
            const options = {
                method: 'GET',
                url: `${endpoint}/recipe/${id}`,
                json: true
            };

            let response;
            try {
                response = await R(options);
            } catch (e) {
                log.error(e);
            }

            log.info(`Found recipe ${id}`);
            return response;
        }


        async function composeRecipe(ffxivDbRes) {
            const map = await getMap();
            return await composeATree(ffxivDbRes.tree);

            async function composeATree(tree) {
                return Promise.all(_.map(tree, async treeItem => {
                    const composed = {
                        name: treeItem.name,
                        quantity: treeItem.quantity
                    };

                    if (treeItem.synths) composed.recipe = await composeATree(_.first(_.values(treeItem.synths)).tree);
                    else if (map[treeItem.name.toLowerCase()]) {
                        const response = await get(map[treeItem.name.toLowerCase()]);
                        composed.recipe = await composeATree(response.tree);
                    }

                    return composed;
                }));
            }
        }

        function massageData(recipe, recipeObj = {}) {
            return reduce(recipeObj);

            function reduce(recipeObj) {
                return _.reduce(recipe, (acc, item) => {
                    if (item.recipe) massageData(item.recipe, acc);

                    if (_.isUndefined(acc[item.name])) acc[item.name] = item.quantity * multipler;
                    else acc[item.name] += (item.quantity * multipler);

                    return acc;
                }, recipeObj);
            }
        }

    }

    async function getIndex() {
        if(_.isNull(index)) await getMap();
        return index;
    }

    async function getMap() {
        if (_.isNull(map)) return await requestMap();
        return map;

        async function requestMap() {
            const options = {
                method: 'GET',
                url: `${endpoint}/recipe`,
                qs: {
                    columns: ['name', 'id'].join(',')
                },
                json: true
            };

            let response;
            try {
                response = await R(options);
            } catch (e) {
                log.error(e);
            }

            index = elasticlunr(function() {
                this.addField('id');
                this.addField('name');
            });

            recipesById = {};
            map = {};
            _.each(response, (item) => {
                map[item.name.toLowerCase()] = item.id;
                recipesById[item.id] = item.name;
                index.addDoc(item);
            });

            return map;
        }

    }
}