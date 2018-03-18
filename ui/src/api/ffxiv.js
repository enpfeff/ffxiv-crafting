const axios = require('axios');
const env = require('env');
module.exports = service;

function service() {
  return {
    getRecipes,
    searchRecipes
  };

  function searchRecipes(query) {
    return axios({method: 'GET', url: `${env.API}/recipe/search`, params: { query }});
  }

  function getRecipes(recipes) {
    return axios({method: 'GET', url: `${env.API}/recipe`, params: { recipes }})
  }
}
