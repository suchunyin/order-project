<template>
  <view>
    <view class="main">
      <view class="img-wrap">
        <!-- <view class="btn" :style="{ top: backBtnTop }" @click="handleBack">
          <view class="t-icon t-icon-fanhui"></view>
        </view> -->
        <image mode="aspectFill" :src="imageUrl(product.image)"></image>
      </view>
      <view class="info-wrap">
        <view class="name">{{ product.name }}</view>
        <view class="desc">{{ product.describe }}</view>
      </view>
      <view class="select-wrap">
        <view
          class="select"
          v-for="(attItem, attIndex) in product.attribute"
          :key="attItem.name"
        >
          <view class="title">{{ attItem.name }}</view>
          <view class="checkbox">
            <view
              class="check-item"
              v-for="(item, index) in attItem.items"
              :key="index"
              @click="handleCheckChange(item, attIndex)"
              :class="{ checked: checkedArr[attIndex] === item }"
            >
              {{ item }}
            </view>
          </view>
        </view>
      </view>
    </view>
    <view class="confirm-wrap">
      <view class="info">
        <view class="left">
          <view class="price">￥{{ addProduct.price * addProduct.num }}</view>
          <view class="attribute">{{ checkedArr.join("/") }}</view>
        </view>
        <view class="right">
          <view
            class="t-icon t-icon-jian"
            @click="
              addProduct.num =
                addProduct.num > 1 ? addProduct.num - 1 : addProduct.num
            "
          ></view>
          <view class="num">{{ addProduct.num }}</view>
          <view class="t-icon t-icon-jia" @click="addProduct.num += 1"></view>
        </view>
      </view>
      <view class="btn" @click="handleAdd">加入购物袋</view>
    </view>
  </view>
</template>

<script>
import { imageUrl } from "../../utils";
export default {
  data() {
    return {
      backBtnTop: null,
      product: {},
      checkedArr: [],
      addProduct: { num: 1 },
    };
  },
  methods: {
    imageUrl,
    getBackBtnTop() {
      let menuInfo = uni.getMenuButtonBoundingClientRect();
      this.backBtnTop = menuInfo.top + "px";
    },
    handleBack() {
      uni.navigateBack();
    },
    handleCheckChange(check, index) {
      this.$set(this.checkedArr, index, check);
      this.priceMatch(this.checkedArr[0]);
    },
    priceMatch(str) {
      let find = this.product.price.find((v) => v.size == str);
      this.addProduct.price = find.price;
    },
    handleAdd() {
      let add = {
        id: this.product.id,
        name: this.product.name,
        image: this.product.image,
        attribute: this.checkedArr.join("/"),
        ...this.addProduct,
      };
      getApp().globalData.shoppingBag.amount +=
        this.addProduct.price * this.addProduct.num;
      getApp().globalData.shoppingBag.list.push(add);
      this.handleBack();
    },
  },
  onLoad({ item }) {
    this.product = JSON.parse(decodeURIComponent(item));
    this.product.attribute.forEach((element) => {
      this.checkedArr.push(element.items[0]);
    });
    this.priceMatch(this.checkedArr[0]);
    this.getBackBtnTop();
  },
};
</script>

<style lang="scss" scoped>
.main {
  height: calc(100vh - 13vh - 40rpx);
  overflow-y: auto;
}
.img-wrap {
  width: 100vw;
  height: 40vh;
  .btn {
    position: absolute;
    left: 40rpx;
    background-color: $light;
    border-radius: 50%;
    width: 20px;
    height: 20px;
  }
  image {
    height: 100%;
    width: 100%;
  }
}
.info-wrap {
  .name {
    padding: 0 20rpx;
    margin-top: 20rpx;
    font-size: 38rpx;
    font-weight: 600;
  }
  .desc {
    padding: 20rpx;
    white-space: pre-wrap;
  }
}
.select-wrap {
  .select {
    .title {
      margin-top: 20rpx;
      font-weight: 600;
      padding: 0 20rpx;
    }

    .checkbox {
      display: flex;
      .check-item {
        background-color: $bg-color;
        padding: 10rpx 20rpx;
        margin: 20rpx;
        border-radius: 10rpx;
      }
      .checked {
        background-color: $color;
        color: #fff;
      }
    }
  }
}
.confirm-wrap {
  display: flex;
  align-items: center;
  flex-direction: column;
  position: absolute;
  width: 100%;
  height: 13vh;
  bottom: 40rpx;
  border-top: 1rpx solid #9e9e9e;
  .info {
    display: flex;
    justify-content: space-between;
    width: 100%;
    .left {
      padding: 20rpx;
      .price {
        font-weight: 600;
        font-size: 38rpx;
      }
      .attribute {
        color: $light;
      }
    }
    .right {
      padding: 20rpx;
      font-weight: 600;
      display: flex;
      align-items: center;
      .num {
        padding: 0 20rpx;
      }
    }
  }
  .btn {
    width: 80%;
    padding: 20rpx;
    color: #fff;
    background-color: $color;
    text-align: center;
    border-radius: 20rpx;
  }
}
</style>
