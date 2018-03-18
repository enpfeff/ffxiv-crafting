<template>
  <v-app dark>
    <v-toolbar app>
      <v-toolbar-title>Stormblood Recipe</v-toolbar-title>
    </v-toolbar>
    <v-content>
      <v-container fluid>
        <router-view></router-view>
      </v-container>
    </v-content>
  </v-app>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
#app {}
</style>
