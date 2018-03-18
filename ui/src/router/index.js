import Vue from 'vue'
import Router from 'vue-router'
import Ffxiv from '@/components/Ffxiv'

Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Ffxiv',
      component: Ffxiv
    }
  ]
})
