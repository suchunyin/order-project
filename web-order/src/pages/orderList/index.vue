<template>
  <scroll-view v-if="isLogin" scroll-y class="container">
    <navigator
      :url="`/pages/orderList/detail?id=${item.id}`"
      class="item"
      v-for="item in list"
      :key="item.id"
    >
      <view class="top">
        <view class="type">{{ item.orderType == 1 ? "自提" : "外卖" }}</view>
        <view class="dealNum">{{ item.dealNum }} 个商品</view>
      </view>
      <view class="product">
        <view class="img-inner">
          <image
            mode="aspectFill"
            :src="imageUrl(item.product[0].image)"
          ></image>
        </view>
        <view class="info">
          <view class="name">{{ item.product[0].name }}</view>
          <view class="num">×{{ item.product[0].num }}</view>
        </view>
        <view class="amount">￥{{ item.amount }}</view>
      </view>
    </navigator>
  </scroll-view>
  <not-login-in v-else />
</template>

<script>
import { mapGetters } from "vuex";
import { imageUrl } from "../../utils";
import NotLoginIn from "@/components/login/notLoginIn.vue";
export default {
  components: { NotLoginIn },
  computed: {
    ...mapGetters(["isLogin", "userInfo"]),
  },
  data() {
    return {
      list: [
        {
          id: "11",
          type: 1,
          dealNum: 2,
          amount: 46,
          product: [{ name: "珍珠奶茶", img: "../../static/1.png", num: 2 }],
        },
        {
          id: "11",
          type: 1,
          dealNum: 2,
          amount: 46,
          product: [{ name: "珍珠奶茶", img: "../../static/1.png", num: 2 }],
        },
        {
          id: "11",
          type: 1,
          dealNum: 2,
          amount: 46,
          product: [{ name: "珍珠奶茶", img: "../../static/1.png", num: 2 }],
        },
        {
          id: "11",
          type: 1,
          dealNum: 2,
          amount: 46,
          product: [{ name: "珍珠奶茶", img: "../../static/1.png", num: 2 }],
        },
        {
          id: "11",
          type: 1,
          dealNum: 2,
          amount: 46,
          product: [{ name: "珍珠奶茶", img: "../../static/1.png", num: 2 }],
        },
        {
          id: "11",
          type: 1,
          dealNum: 2,
          amount: 46,
          product: [{ name: "珍珠奶茶", img: "../../static/1.png", num: 2 }],
        },
        {
          id: "11",
          type: 1,
          dealNum: 2,
          amount: 46,
          product: [{ name: "珍珠奶茶", img: "../../static/1.png", num: 2 }],
        },
      ],
    };
  },
  methods: {
    imageUrl,
    getOrderList() {
      this.$api.getOrderList({ id: this.userInfo.id }).then((res) => {
        this.list = res.res;
      });
    },
  },
  onShow() {
    if (this.isLogin) this.getOrderList();
  },
};
</script>

<style lang="scss" scoped>
.container {
  height: 100vh;
  font-size: 26rpx;
  background-color: $bg-color;
  .item {
    height: 210rpx;
    display: flex;
    flex-direction: column;
    margin: 20rpx;
    background-color: #fff;
    .top {
      width: 100%;
      display: flex;
      justify-content: space-between;
      .type {
        padding: 10rpx 20rpx;
        background-color: $color;
        color: #fff;
      }

      .dealNum {
        padding: 10rpx 20rpx;
        color: $light;
      }
    }

    .product {
      width: 100%;
      height: 160rpx;
      display: flex;
      padding: 20rpx;
      .img-inner {
        width: 20%;
        image {
          width: 130rpx;
          height: 130rpx;
          border-radius: 10rpx;
        }
      }

      .info {
        width: 60%;
        display: flex;
        justify-content: space-between;
        flex-direction: column;
        .name {
          font-size: 36rpx;
          font-weight: 600;
        }

        .num {
          color: $light;
          padding-bottom: 20rpx;
        }
      }
      .amount {
        width: 20%;
        text-align: center;
        font-size: 36rpx;
        font-weight: 600;
      }
    }
  }
}
</style>
