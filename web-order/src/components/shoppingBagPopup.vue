<template>
  <view class="container">
    <view
      class="mask"
      :style="{ bottom: bottom + 'px' }"
      @click="handlleMaskClick"
    ></view>
    <view :animation="animationData" class="popup">
      <view class="item" v-for="(item, index) in list" :key="item.id">
        <view class="left">
          <image mode="aspectFill" :src="imageUrl(item.image)"></image>
        </view>
        <view class="right">
          <view class="name">{{ item.name }}</view>
          <view class="attribute">{{ item.attribute }}</view>
          <view class="bottom">
            <view class="price">￥{{ item.price }}</view>
            <view class="change">
              <view
                class="t-icon t-icon-jian"
                @click="handleNumChange(index, -1)"
              ></view>
              <view class="num">{{ item.num }}</view>
              <view
                class="t-icon t-icon-jia"
                @click="handleNumChange(index, 1)"
              ></view>
            </view>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import { imageUrl } from "../utils";
export default {
  props: {
    bottom: Number,
  },
  data() {
    return {
      animationData: {},
      list: [],
    };
  },
  methods: {
    imageUrl,

    // 滑入滑出动画
    showTranslate() {
      let animation = uni.createAnimation({ duration: 300 });
      this.animation = animation;
      animation.translateY(-this.bottom).step();
      this.animationData = animation.export();
    },
    closeTranslate() {
      this.animation.translateY(this.bottom).step();
      this.animationData = this.animation.export();
    },
    handlleMaskClick() {
      this.$emit("close");
    },
    handleNumChange(index, num) {
      this.list[index].num += num;
      getApp().globalData.shoppingBag.amount +=
        this.list[index].price * num;
      if (this.list[index].num === 0) {
        this.list.splice(index, 1);
        if (this.list.length === 0) this.$emit("close", true);
      }
      // getApp().globalData.shoppingBag.list = this.list;
      // this.$emit("bagChange");
    },
  },
  mounted() {
    this.list = getApp().globalData.shoppingBag.list;
    console.log(this.list);
    
    this.showTranslate();
  },
  beforeDestroy() {},
};
</script>
<style lang="scss" scoped>
.mask {
  position: absolute;
  width: 100%;
  height: 100vh;
  background-color: rgba(0, 0, 0, 0.5);
}
.popup {
  position: absolute;
  width: 100%;
  bottom: 0;
  background-color: #fff;

  .item {
    display: flex;
    align-items: center;
    width: 100%;
    height: 150rpx;
    padding: 20rpx 0;

    .left {
      padding-left: 20rpx;
      height: 120rpx;
      image {
        width: 120rpx;
        height: 120rpx;
        border-radius: 20rpx;
      }
    }

    .right {
      width: 75%;
      padding-left: 20rpx;
      font-size: 32rpx;
      font-weight: 600;
      display: flex;
      align-content: space-around;
      flex-direction: column;
      .name {
      }

      .attribute {
        color: $light;
        font-size: 28rpx;
        font-weight: 400;
      }

      .bottom {
        display: flex;
        justify-content: space-between;
        padding-top: 10rpx;

        .price {
        }

        .change {
          display: flex;
          align-items: center;
          .t-icon.t-icon-jian {
          }

          .num {
            padding: 0 20rpx;
          }

          .t-icon.t-icon-jia {
          }
        }
      }
    }
  }
}
</style>
