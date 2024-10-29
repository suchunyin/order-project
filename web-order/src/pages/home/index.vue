<template>
  <view class="main-container">
    <swiper
      indicator-dots
      autoplay
      circular
      indicator-color="#00ffff"
      indicator-active-color="#adff2f"
      class="swiper-wrap"
    >
      <swiper-item v-for="item in list.top" :key="item.id">
        <image mode="aspectFill" :src="item.cover"></image>
      </swiper-item>
    </swiper>
    <view class="operate-wrap">
      <view class="item" @click="handleClick(1)">
        <view class="t-icon t-icon-daodianqu"></view>
        <text>到店点餐</text>
      </view>
      <view class="item" @click="handleClick(2)">
        <view class="t-icon t-icon-waimai"></view>
        <text>外卖配送</text>
      </view>
    </view>
    <view class="bottom-wrap">
      <view class="item" v-for="item in list.bottom" :key="item.id">
        <image mode="aspectFill" :src="item.cover"></image>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      list: {
        top: [
          { id: "1", cover: "../../static/1.png" },
          { id: "1", cover: "../../static/1.png" },
          { id: "1", cover: "../../static/1.png" },
        ],
        bottom: [
          { id: "1", cover: "../../static/2.png" },
          { id: "1", cover: "../../static/2.png" },
          { id: "1", cover: "../../static/2.png" },
        ],
      },
    };
  },
  methods: {
    // imageUrl,
    handleClick(type) {
      getApp().globalData.shoppingBag.orderType = type;
      uni.switchTab({ url: "/pages/product/index" });
    },
  },
};
</script>

<style lang="scss" scoped>
::v-deep .wx-swiper-dot {
  width: 40rpx;
  height: 10rpx;
  border-radius: 10rpx;
}
::v-deep .wx-swiper-dots-horizontal {
  left: 100rpx;
}
.main-container {
  background-color: $bg-color;
  position: absolute;
  width: 100%;
  height: 100%;

  .swiper-wrap {
    width: 100%;
    height: 800rpx;
    swiper-item {
      image {
        height: 100%;
        width: 100%;
      }
    }
  }

  .operate-wrap {
    height: 260rpx;
    display: flex;
    justify-content: space-around;
    align-items: center;
    padding: 20rpx;

    .item {
      width: 50%;
      height: 100%;
      margin: 20rpx;
      background-color: #fff;
      border-radius: 20rpx;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: space-evenly;
      .t-icon {
        width: 130rpx;
        height: 130rpx;
      }

      text {
        font-size: 40rpx;
        font-weight: 600;
      }
    }
  }
  .bottom-wrap {
    height: calc(100vh - 800rpx - 260rpx);
    padding: 20rpx;
    .item {
      height: 200rpx;
      width: 100%;
      & + .item {
        padding-top: 20rpx;
      }
      image {
        width: 100%;
        height: 100%;
        border-radius: 10rpx;
      }
    }
  }
}
</style>
