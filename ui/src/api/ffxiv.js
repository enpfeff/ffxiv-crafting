const axios = require('axios');

module.exports = service;

function service() {
  return {
    getRecipes
  };

  function getRecipes(recipes) {
    return axios({method: 'GET', url: `http://localhost:3000/recipe`, params: { recipes }})
  }
}
