<template>
  <view v-if="isLogin" class="container">
    <view class="info-wrap">
      <view class="avatar">
        <image mode="aspectFill" :src="imageUrl(userInfo.avatar)"></image>
      </view>
      <view class="name">{{ userInfo.name }}</view>
    </view>
    <view class="btn-wrap">
      <view class="btn" v-for="item in list" :key="item.title">
        <view class="t-icon" :class="item.icon"></view>
        <view class="title">{{ item.title }}</view>
      </view>
    </view>
  </view>
  <not-login-in v-else />
</template>

<script>
import { mapGetters } from "vuex";
import NotLoginIn from "@/components/login/notLoginIn.vue";
import { imageUrl } from "../../utils";
export default {
  components: { NotLoginIn },
  computed: {
    ...mapGetters(["isLogin", "userInfo"]),
  },
  data() {
    return {
      user: { avatar: "../../static/icon/wode.png", name: "周杰伦" },
      list: [
        { title: "个人资料", icon: "t-icon-gerenziliao" },
        { title: "联系客服", icon: "t-icon-kefu" },
        { title: "收货地址", icon: "t-icon-dizhi" },
        { title: "社群福利", icon: "t-icon-fuli" },
        { title: "加盟申请", icon: "t-icon-jiameng" },
        { title: "我的徽章", icon: "t-icon-huizhang" },
        { title: "礼品卡", icon: "t-icon-lipinka" },
        { title: "礼券兑换", icon: "t-icon-liquan" },
      ],
    };
  },
  methods: {
    imageUrl,
  },
};
</script>
<style lang="scss" scoped>
.container {
  overflow: hidden;
}
.info-wrap {
  height: 35vh;
  display: flex;
  justify-content: flex-end;
  flex-direction: column;
  align-items: center;
  background-color: #e4ebff;

  .avatar {
    height: 150rpx;
    width: 150rpx;
    image {
      height: 100%;
      width: 100%;
      border-radius: 50%;
    }
  }
  .name {
    font-size: 34rpx;
    font-weight: 600;
    padding: 40rpx;
  }
}
.btn-wrap {
  display: flex;
  flex-wrap: wrap;
  padding: 10rpx 0;

  .btn {
    width: 25%;
    display: flex;
    align-items: center;
    flex-direction: column;
    .t-icon {
      margin-top: 20rpx;
      width: 60rpx;
      height: 60rpx;
      display: inline-block;
    }
    .title {
      padding: 10rpx 0 20rpx 0;
    }
  }
}
</style>
<style></style>
