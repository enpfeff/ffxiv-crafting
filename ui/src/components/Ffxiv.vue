<template>
  <v-layout row>
    <v-flex xs6 class="pr-5">
      <h1>Add your recipes Below</h1>
      <v-text-field label="Recipe" v-model="recipe"></v-text-field>
      <v-btn @click="addRecipe()">Add Recipe</v-btn>
    </v-flex>
    <v-flex xs6 class="">
      <h1>Recipes to get</h1>
      <div v-if="recipes.length === 0">
        No Recipes, add them on the left.
      </div>
      <v-list v-else one-line>
        <template v-for="(item, index) in recipes">
          <v-list-tile>
            <v-list-tile-content>
              <v-list-tile-title v-html="item"></v-list-tile-title>
            </v-list-tile-content>
            <v-list-tile-action @click="removeRecipe()">
              <v-btn icon ripple>
                <v-icon color="grey lighten-1">delete</v-icon>
              </v-btn>
            </v-list-tile-action>
          </v-list-tile>
        </template>
      </v-list>
      <v-btn :disabled="recipes.length === 0" @click="getRecipe()">Get Required Items</v-btn>
    </v-flex>
  </v-layout>
</template>

<script>
export default {
  name: 'Ffxiv',
  data,
  methods: {
    addRecipe() {
      this.recipes.push(this.recipe);
      this.recipe = '';
    },

    removeRecipe() {

    }
  }
}

function data() {
  return {
    recipe: '',
    recipes: []
  };
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
