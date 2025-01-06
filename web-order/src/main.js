import Vue from "vue";
import App from "./App";
import "./uni.promisify.adaptor";
import store from "./store/index";

import api from "./api/index";
Vue.prototype.$api = api;

Vue.config.productionTip = false;

App.mpType = "app";

const app = new Vue({
  ...App,
  store,
});
app.$mount();
