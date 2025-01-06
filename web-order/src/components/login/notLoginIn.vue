<template>
  <view class="container">
    未登录，请先登录
    <button class="btn" type="primary" size="mini" @click="handleLogin">
      去登录
    </button>
  </view>
</template>

<script>
export default {
  data() {
    return {};
  },
  methods: {
    handleLogin() {
      uni.navigateTo({
        url: "/components/login/index",
      });
    },
  },
};
</script>

<style lang="scss" scoped>
.container {
  width: 100vw;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  .btn {
    margin: 30rpx;
    background-color: $color;
  }
}
</style>
