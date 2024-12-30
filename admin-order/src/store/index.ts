import { createStore } from "vuex";
import { setStore, getStore, removeStore } from "../utils/auth";
import { login, getInfo } from "../http/api/user";

const store = createStore({
  state: {
    token: getStore("token") || "",
    userInfo: getStore("userInfo") || {},
  },
  getters: {
    token: (state) => state.token,
    userInfo: (state) => state.userInfo,
  },
  mutations: {
    SET_TOKEN(state, token) {
      state.token = token;
      setStore("token", token);
    },
    SET_USER_INFO(state, userInfo) {
      state.userInfo = userInfo;
      setStore("userInfo", userInfo);
    },
  },
  actions: {
    Login({ commit }, userInfo) {
      return new Promise((resolve, reject) => {
        login(userInfo)
          .then((res: any) => {
            commit("SET_TOKEN", res.res.token);
            commit("SET_USER_INFO", res.res.info);
            resolve(res);
          })
          .catch((error) => {
            reject(error);
          });
      });
    },
    LoginOut({ commit }) {
      return new Promise<void>((resolve, reject) => {
        commit("SET_TOKEN", "");
        commit("SET_USER_INFO", {});
        removeStore("token");
        removeStore("userInfo");
        resolve();
      });
    },
    UserInfo({ commit }) {
      return new Promise((resolve, reject) => {
        getInfo()
          .then((res) => {
            commit("SET_USER_INFO", res.res);
            resolve(res);
          })
          .catch((err) => {
            reject(err);
          });
      });
    },
  },
  modules: {},
});

export default store;
