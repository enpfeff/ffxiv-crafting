<template>
  <div>
    Hi {{name}}
    <button v-on:click="getRecipe()">Get Recipe</button>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  data,
  methods: methods(),
  mounted
}

function mounted() {
  const ffxivService = require('../api/ffxiv')();

  return ffxivService.getRecipes([{name: 'Slothskin Belt of Aiming'}])
    .then(res => console.log(res));
}

function methods () {
  return {
    getRecipe
  };

  function getRecipe () {
    console.log('Hi')
  }
}

function data () {
  return {
    name: 'Ian'
  };
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
