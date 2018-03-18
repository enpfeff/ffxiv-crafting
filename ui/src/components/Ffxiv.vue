<template>
  <v-layout column>
    <v-layout row>
      <v-flex xs6 class="pr-5">
        <h1>Add your recipes Below</h1>
        <v-container fluid>
          <v-layout>
            <v-flex>
              <v-select label="Search" autocomplete
                :loading="loadingSearch"
                :items="items"
                cache-items
                required
                :search-input.sync="search"
                @change="addRecipe"
                v-model="select"
              ></v-select>
            </v-flex>
          </v-layout>
        </v-container>
      </v-flex>
      <v-flex xs6 class="">
        <h1>Recipes to get</h1>
        <div v-if="recipes.length === 0">
          No Recipes, add them on the left.
        </div>
        <v-list v-else>
          <template v-for="(item, index) in recipes">
            <v-list-tile>
              <v-list-tile-content>
                <v-list-tile-title v-html="item.name"></v-list-tile-title>
              </v-list-tile-content>
              <v-list-tile-action @click="removeRecipe(item)">
                <v-btn icon ripple>
                  <v-icon color="grey lighten-1">delete</v-icon>
                </v-btn>
              </v-list-tile-action>
            </v-list-tile>
          </template>
        </v-list>
        <v-btn :disabled="recipes.length === 0" @click="getRecipe()">Get Mats</v-btn>
      </v-flex>
    </v-layout>

    <div class="mx-auto" v-if="loading">
      <v-progress-circular :indeterminate="true" :size="60" color="deep-orange lighten-2"></v-progress-circular>
    </div>

    <v-layout v-if="mats !== null" column class="pt-5">
      <h1>Mats</h1>
      <v-list>
        <template v-for="(item, index) in mats">
          <v-list-tile>
            <v-list-tile-action>
              <v-checkbox v-model="item.complete"></v-checkbox>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title>{{item.quantity + 'x - ' + item.name}}</v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
        </template>
      </v-list>
    </v-layout>
  </v-layout>

</template>

<script>
import Service from '@/api/ffxiv'
import _ from 'lodash';
const ffxivService = Service();

export default {
  name: 'Ffxiv',
  data,
  watch: {
    search(val) {
      val && this.findRecipes(val);
    }
  },
  methods: {
    addRecipe(val) {
      if(_.isObject(val)) return;
      this.recipes.push({name: val});
      this.select = null;
    },

    removeRecipe(item) {
      this.recipes.splice(this.recipes.indexOf(item), 1);
    },

    getRecipe() {
      this.loading = true;
      this.mats = null;
      return ffxivService.getRecipes(this.recipes)
        .then(response => this.mats = response.data)
        .catch(e => {})
        .finally(() => this.loading = false);
    },

    findRecipes: _.debounce(function(val) {
      this.loadingSearch = true;
      return ffxivService.searchRecipes(val)
        .then(response => this.items = response.data)
        .finally(() => this.loadingSearch = false);
    }, 300)
  }
}

function data() {
  return {
    recipes: [],
    mats: null,
    loading: false,
    loadingSearch: false,
    search: null,
    items: [],
    selectValue: null,
    select: null,
    delay: 300
  };
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
