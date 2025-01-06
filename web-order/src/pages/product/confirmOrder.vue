<template>
  <view class="container">
    <view class="address">
      <view class="head">
        <view class="item" :class="{ active: bag.orderType === 1 }"
          >到店取</view
        >
        <view class="item" :class="{ active: bag.orderType === 2 }"
          >外卖配送</view
        >
      </view>
      <view class="content" v-if="bag.orderType === 1">
        <view class="name">{{ shangjiaData.name }}</view>
        <view class="dist">
          <uni-icons type="location" size="16"></uni-icons>
          <text>距离你 {{ shangjiaData.distance }} km</text>
        </view>
      </view>
      <view class="content" v-else>
        <view class="name">{{ shangjiaData.name }}</view>
        <view class="dist">
          <uni-icons type="location" size="16"></uni-icons>
          <text>距离你 {{ shangjiaData.distance }} km</text>
        </view>
      </view>
    </view>
    <view class="product">
      <view class="item" v-for="item in bag.list" :key="item.id">
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
      <view class="total">小计￥{{ bag.amount }}</view>
    </view>
    <view class="info">
      <view class="title">支付方式</view>
      <view class="list">
        <radio-group @change="radioChange">
          <label class="item" v-for="item in payTypes" :key="item.value">
            <view>{{ item }}</view>
            <view>
              <radio :value="item.value" checked="true" color="#999" />
            </view>
          </label>
        </radio-group>
      </view>
    </view>
    <view class="info">
      <view class="item">
        <view>预留号码</view>
        <input
          class="uni-input"
          type="tel"
          :value="phone"
          @input="inputPhone"
          placeholder="请填写手机号码"
        />
      </view>
      <view class="item">
        <view>订单备注</view>
        <input
          class="uni-input"
          type="text"
          :value="remark"
          @input="inputRemark"
          placeholder="请在这里写下您的备注"
        />
      </view>
    </view>
    <view class="confirm-wrap">
      <view class="text">待支付 ￥{{ bag.amount }}</view>
      <view class="btn" @click="handleAddOrder">支付</view>
    </view>
  </view>
</template>

<script>
import { mapGetters } from "vuex";
import { imageUrl } from "../../utils";
export default {
  computed: {
    ...mapGetters(["isLogin", "userInfo"]),
  },
  data() {
    return {
      bag: { list: [] },
      shangjiaData: { distance: 11.5, minimum: 25, name: "商家名" },
      payTypes: ["微信支付"],
      phone: "13566223355",
      remark: "",
    };
  },
  methods: {
    imageUrl,
    radioChange() {},
    inputPhone(e) {
      this.phone = e.detail.value;
    },
    inputRemark(e) {
      this.remark = e.detail.value;
    },
    handleAddOrder() {
      let data = {
        orderType: this.bag.orderType,
        amount: this.bag.amount,
        product: this.bag.list,
        dealNum: this.bag.list.length,
        phone: this.phone,
        remark: this.remark,
        userId: this.userInfo.id,
      };
      this.$api.addOrder(data).then((res) => {
        getApp().globalData.shoppingBag.amount = 0;
        getApp().globalData.shoppingBag.list = [];
        uni.showToast({ title: res.msg });
        uni.redirectTo({ url: `/pages/orderList/detail?id=${res.res.id}` });
      });
    },
  },
  onLoad() {
    if (!this.isLogin) uni.redirectTo({ url: "/components/login/index" });
    this.bag = getApp().globalData.shoppingBag;
  },
};
</script>
<style lang="scss" scoped>
.container {
  background-color: $bg-color;
  padding: 20rpx;
  height: 100vh;
}
.address {
  background-color: #fff;
  margin-bottom: 20rpx;
  .head {
    font-weight: 600;
    display: flex;
    .item {
      width: 50%;
      text-align: center;
      background-color: #d3d3d3;
      color: $light;
      padding: 20rpx 0;
    }
    .active {
      background-color: #fff;
      color: #000;
    }
  }
  .content {
    padding: 30rpx;
  }
}
.product {
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
  .uni-input {
    text-align: end;
  }
}
.confirm-wrap {
  position: absolute;
  left: 0;
  bottom: 0;
  padding: 30rpx 0;
  width: 100vw;
  background-color: #fff;
  display: flex;
  align-items: center;
  justify-content: space-between;
  .text {
    margin: 0 30rpx;
    font-size: 36rpx;
    font-weight: 600;
  }
  .btn {
    margin: 0 30rpx;
    padding: 20rpx 60rpx;
    border-radius: 20rpx;
    color: #fff;
    background-color: $color;
  }
}
</style>
