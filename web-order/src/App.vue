<script>
export default {
  onLaunch: function () {
    console.log("App Launch");
  },
  onShow: function () {
    console.log("App Show");
  },
  onHide: function () {
    console.log("App Hide");
  },
  globalData: {
    shoppingBag: {
      orderType: 1, //1-到店点餐，2-外卖配送
      amount: 0,
      list: [],
    },
  },
};
</script>

<style>
/*每个页面公共css */
/* @import url("@/static/icon/iconfont.css"); */
@import url("@/static/icon/iconfont-weapp-icon.css");
</style>
