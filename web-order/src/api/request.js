import store from "../store";
const request = (params) => {
  uni.showLoading({ title: "加载中" });
  return new Promise((resolve, reject) => {
    wx.request({
      ...params,
      header: { Authorization: "Bearer " + store.state.token },
      success: (res) => {
        uni.hideLoading();
        if (res.statusCode == 200) resolve(res.data);
        else {
          uni.showToast({
            title: res.data.msg || "请求失败",
            icon: "error",
          });
          reject(res);
        }
      },
      fail: (err) => {
        uni.hideLoading();
        reject(err);
      },
    });
  });
};

export default request;
