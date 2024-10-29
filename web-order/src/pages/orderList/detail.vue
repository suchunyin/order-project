<template>
  <view class="container">
    <view class="state">
      <view class="title">下单成功！取餐码{{ order.code }}</view>
      <view class="tips">请前往自提点取餐</view>
      <view class="btn" @click="handleDelete">取消订单</view>
    </view>
    <view class="content">
      <view class="name">{{ shangjiaData.name }}</view>
      <view class="dist">
        <uni-icons type="location" size="16"></uni-icons>
        <text>距离你 {{ shangjiaData.distance }} km</text>
      </view>
    </view>
    <view class="product">
      <view class="item" v-for="item in order.product" :key="item.id">
        <view class="left">
          <image mode="aspectFill" :src="imageUrl(item.image)"></image>
        </view>
        <view class="right">
          <view class="name">{{ item.name }}</view>
          <view class="attribute">{{ item.attribute }}</view>
          <view class="num">×{{ item.num }}</view>
        </view>
        <view class="price">￥{{ item.num * item.price }}</view>
      </view>
      <view class="total">小计￥{{ order.amount }}</view>
    </view>
    <view class="info">
      <view class="item">
        <view>预留号码</view>
        <view class="right">{{ order.phone }}</view>
      </view>
      <view class="item">
        <view>订单备注</view>
        <view class="right">{{ order.remark || "无" }}</view>
      </view>
      <view class="item">
        <view>下单时间</view>
        <view class="right">{{ order.createdTime }}</view>
      </view>
    </view>
  </view>
</template>
<script>
import moment from "moment";
import { imageUrl } from "../../utils";
export default {
  data() {
    return {
      order: {},
      shangjiaData: { distance: 11.5, minimum: 25, name: "商家名" },
    };
  },
  methods: {
    imageUrl,
    async getInfo(id) {
      const res = await this.$api.getOrderInfo(id);
      this.order = res.res;
      this.order.createdTime = moment(this.order.createdAt).format(
        "YYYY-MM-DD hh:mm:ss"
      );
    },
    handleDelete() {
      uni.showModal({
        title: "提示",
        content: "确定要取消订单吗？",
        success: async (res) => {
          if (res.confirm) {
            await this.$api.deleteOrder({ id: this.order.id });
            uni.navigateBack();
          }
        },
      });
    },
  },
  onLoad(v) {
    this.getInfo(v.id);
  },
};
</script>
<style lang="scss" scoped>
.container {
  background-color: $bg-color;
  padding: 20rpx;
  height: 100vh;
}
.state {
  margin-top: 20rpx;
  padding: 20rpx;
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
  .title {
    font-size: 50rpx;
    font-weight: 600;
    margin-bottom: 15rpx;
  }
  .btn {
    margin-top: 20rpx;
    color: #797979;
    padding: 10rpx 30rpx;
    background-color: #f8f8f8;
    border-radius: 30rpx;
  }
}
.content {
  margin-top: 20rpx;
  background-color: #fff;
  padding: 20rpx;
}
.product {
  margin-top: 20rpx;
  width: 100%;
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
      display: flex;
      align-content: space-around;
      flex-direction: column;
      .name {
        font-size: 32rpx;
        font-weight: 600;
      }

      .attribute,
      .num {
        color: $light;
        font-size: 28rpx;
        font-weight: 400;
      }
    }
    .price {
      font-size: 32rpx;
      font-weight: 600;
      height: 80%;
      margin: 20rpx;
    }
  }
  .total {
    font-size: 36rpx;
    font-weight: 600;
    padding: 40rpx;
    text-align: end;
    border: 1px solid #ddd;
  }
}
.info {
  margin-top: 20rpx;
  background-color: #fff;
  padding: 20rpx;
  .title {
    padding-bottom: 20rpx;
    border-bottom: 1px solid #ddd;
  }
  .item {
    padding: 20rpx 0;
    display: flex;
    justify-content: space-between;
  }
  .right {
    text-align: end;
  }
}
</style>
