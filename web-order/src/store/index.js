import Vue from "vue";
import Vuex from "vuex";
import api from "@/api/index";

const setStore = (key, data) => {
  uni.setStorageSync(key, JSON.stringify(data));
};
const getStore = (key) => {
  return JSON.parse(uni.getStorageSync(key) || '""');
};

Vue.use(Vuex);
const store = new Vuex.Store({
  state: {
    token: getStore("token") || "",
    userInfo: getStore("userInfo") || {},
  },
  getters: {
    isLogin: (state) => !!state.token,
    token: (state) => state.token,
    userInfo: (state) => state.userInfo,
  },
  mutations: {
    setToken(state, token) {
      state.token = token;
      setStore("token", token);
    },
    setUserInfo(state, userInfo) {
      state.userInfo = userInfo;
      setStore("userInfo", userInfo);
    },
  },
  actions: {
    Login({ commit }, data) {
      return new Promise((resolve, reject) => {
        api
          .login(data)
          .then((res) => {
            commit("setToken", res.res.token);
            commit("setUserInfo", res.res.info);
            resolve(res);
          })
          .catch((err) => {
            reject(err);
          });
      });
    },
    Logout({ commit }) {
      return new Promise((resolve, reject) => {
        commit("setToken", "");
        commit("setUserInfo", {});
        uni.removeStorageSync("token");
        uni.removeStorageSync("userInfo");
        resolve(res);
      });
    },
  },
});

export default store;
