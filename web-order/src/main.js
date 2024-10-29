import Vue from 'vue'
import App from './App'
import './uni.promisify.adaptor'

import api from './api/index'
Vue.prototype.$api = api;

Vue.config.productionTip = false

App.mpType = 'app'

const app = new Vue({
  ...App
})
app.$mount()
