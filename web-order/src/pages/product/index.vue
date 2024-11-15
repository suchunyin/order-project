<template>
  <view class="main-container">
    <view class="header" :style="[headerStyle]">
      <uni-search-bar
        class="top-wrap"
        radius="100"
        placeholder="搜索商品"
        clearButton="auto"
        cancelButton="none"
        @confirm="search"
      />
    </view>
    <view class="title-wrap">
      <uni-section
        class="title"
        title="商家名"
        :sub-title="`商家距离你 ${data.distance} km`"
        padding="0 0 5px 10px"
        titleFontSize="36rpx"
        subTitleFontSize="28rpx"
      >
        <template v-slot:decoration>
          <view class="icon">
            <uni-icons type="star" size="20"></uni-icons>
            <uni-icons type="location" size="16"></uni-icons>
          </view>
        </template>
        <template v-slot:right>
          <view class="right">
            {{ shoppingBag.orderType === 2 ? "外卖配送" : "到店点餐" }}
          </view>
        </template>
      </uni-section>
    </view>
    <view class="product-wrap" v-show="list.length > 0">
      <view class="tab">
        <view
          class="tab-item"
          v-for="item in list"
          :key="item.id"
          :class="{ active: currentTab === item.id }"
          @click="handleTabChange(item)"
        >
          <template slot="body">
            <image :src="imageUrl(item.image)"></image>
          </template>
          <template slot="footer">{{ item.name }} </template>
        </view>
      </view>
      <scroll-view
        class="content"
        scroll-y
        :scroll-into-view="scrollJumb"
        @scroll="handleScroll"
        :style="{ height: viewScroll.height + 'px' }"
      >
        <view
          class="content-item"
          :id="'item' + item.id"
          v-for="item in list"
          :key="item.id"
        >
          <uni-section
            class="title"
            :id="item.id + ''"
            :title="item.name"
            padding="0 0 5px 10px"
          >
          </uni-section>
          <view
            class="card"
            v-for="product in item.productList"
            :key="product.id"
            @click="handleClick(product)"
          >
            <view class="left">
              <image mode="aspectFill" :src="imageUrl(product.image)"></image>
            </view>
            <view class="right">
              <view class="name">{{ product.name }}</view>
              <view class="desc">{{ product.describe }}</view>
              <view class="bottom">
                <view class="price"
                  >￥{{ product.defaultPrice }}
                  <text>起</text>
                </view>
                <view class="btn" @click="handleClick(product)">选规格</view>
              </view>
            </view>
          </view>
        </view>
      </scroll-view>
    </view>
    <shopping-bag-popup
      ref="popup"
      v-if="bagShow"
      :bottom="popupBottom"
      @close="handleClosePopup"
      @bagChange="getShoppinigBag"
    ></shopping-bag-popup>
    <view class="bag-wrap">
      <view class="left" @click="handleShowPopup">
        <view class="t-icon t-icon-gouwu"></view>
        <view class="text">合计 ￥{{ shoppingBag.amount }}</view>
      </view>
      <view
        class="confirm"
        v-if="shoppingBag.amount < data.minimum && shoppingBag.orderType === 2"
      >
        差￥{{ data.minimum - shoppingBag.amount }}起送
      </view>
      <navigator
        v-else
        class="confirm active"
        url="/pages/product/confirmOrder"
        :style="{
          'pointer-events': shoppingBag.amount > 0 ? 'initial' : 'none',
        }"
      >
        去结算
      </navigator>
    </view>
  </view>
</template>

<script>
import shoppingBagPopup from "@/components/shoppingBagPopup.vue";
import { getElement, imageUrl } from "../../utils";
import { onBackPress } from "@dcloudio/uni-app";

export default {
  components: { shoppingBagPopup },
  data() {
    return {
      headerStyle: {},
      currentTab: null,
      scrollJumb: null,
      viewScroll: null, //商品列表位置
      data: { distance: 11.5, minimum: 25 },
      list: [],
      shoppingBag: {},
      bagShow: false,
      popupBottom: 0, //购物袋弹窗位置
    };
  },
  methods: {
    imageUrl,
    async getList() {
      const res = await this.$api.getProductList();
      this.list = res.res;
      this.currentTab = this.list[0].id;
    },
    handleTabChange(item) {
      this.scrollJumb = "#item" + item.id;
      this.currentTab = item.id;
    },
    /**
     * handleScroll 滚动时设置tab切换
     * e 滚动事件
     */
    handleScroll(e) {
      let scrollDetail = e.detail;
      uni
        .createSelectorQuery()
        .selectAll(".content-item")
        .boundingClientRect((res) => {
          const moveUp = res.find((item) => {
            return (
              item.top > this.viewScroll.top - 10 &&
              item.top < this.viewScroll.top + 30
            );
          });
          if (moveUp)
            this.$nextTick(() => {
              // 判断该分类显示至滚动元素顶部，tab切换至该分类
              this.currentTab = moveUp.id.slice(4);
            });
          const moveDownIndex = res.findIndex((item) => {
            return (
              item.top > this.viewScroll.height + this.viewScroll.top &&
              scrollDetail.deltaY > 0
            );
          });
          if (moveDownIndex > 0 && !moveUp)
            // 判断该分类不显示且上一分类显示部分时，tab切换至上一分类
            this.$nextTick(() => {
              this.currentTab = res[moveDownIndex - 1].id.slice(4);
            });
        })
        .exec();
    },
    handleClick(item) {
      uni.navigateTo({
        url:
          "/pages/product/detail?item=" +
          encodeURIComponent(JSON.stringify(item)),
      });
    },
    handleShowPopup() {
      if (this.shoppingBag.amount == 0) return;

      if (!this.bagShow) this.bagShow = true;
      else this.handleClosePopup();
    },

    handleClosePopup(empty) {
      // shoppingBag没有商品时直接关闭，有商品时关闭滑动动画退出
      this.$refs.popup.closeTranslate();
      setTimeout(
        () => {
          this.bagShow = false;
        },
        empty ? 0 : 300
      );
    },
    getShoppinigBag() {
      this.shoppingBag = getApp().globalData.shoppingBag;
      if (this.shoppingBag.amount === 0) this.bagShow = false;
    },
  },
  onLoad() {
    this.getList();

    // 设置顶部搜索栏位置高度
    let menuInfo = uni.getMenuButtonBoundingClientRect();
    this.headerStyle = {
      paddingTop: menuInfo.top + "px",
      height: menuInfo.height + "px",
      lineHeight: menuInfo.height + "px",
    };
  },
  onShow() {
    this.getShoppinigBag();
  },
  async onReady() {
    // 设置滚动区域高度、购物袋弹窗位置
    this.viewScroll = await getElement(".content");
    let header = await getElement(".header");
    let title = await getElement(".title-wrap");
    let { height } = await getElement(".bag-wrap");
    this.popupBottom = height;
    this.viewScroll.height -= header.height + title.height + height;
  },
};
</script>

<style lang="scss" scoped>
::v-deep .uni-searchbar {
  width: 70%;
  padding: 0 10px;
}
.title-wrap {
  .title {
    ::v-deep .uni-section__content-title {
      font-weight: 600;
    }
    .icon {
      display: flex;
      justify-content: space-around;
      flex-direction: column;
      align-items: flex-end;
      padding-right: 10rpx;
    }
    .right {
      font-weight: 600;
      font-size: 36rpx;
      color: $light;
    }
  }
}

.product-wrap {
  display: flex;
  .tab {
    width: 200rpx;
    background-color: #f3f3f3;
    .tab-item {
      display: flex;
      flex-direction: column;
      align-items: center;
      padding: 10rpx;
      text-align: center;
      font-size: 25rpx;
      image {
        height: 60rpx;
        width: 60rpx;
      }
    }
    .active {
      background-color: #f4d3a187;
    }
  }

  .content {
    width: 100%;
    height: 100vh;
    background-color: #7f7575;
    .content-item {
    }
    .card {
      position: relative;
      height: 200rpx;
      padding: 20rpx;
      background-color: #fff;
      display: flex;

      .left {
        width: 35%;
        height: 180rpx;
        image {
          height: 100%;
          width: 100%;
        }
      }
      .right {
        width: 75%;
        padding-left: 20rpx;
        font-size: 36rpx;
        font-weight: 600;
        display: flex;
        align-content: space-around;
        flex-direction: column;
        .name {
        }
        .desc {
          font-size: 30rpx;
          font-weight: 400;
          overflow: hidden;
          text-overflow: ellipsis;
          display: -webkit-box;
          -webkit-line-clamp: 2;
          -webkit-box-orient: vertical;
        }
        .bottom {
          display: flex;
          justify-content: space-between;
          padding-top: 20rpx;
          .price {
            text {
              font-size: 32rpx;
              font-weight: 400;
            }
          }
          .btn {
            padding: 0 20rpx;
            border-radius: 20rpx;
            font-size: 30rpx;
            font-weight: 400;
            color: #fff;
            background-color: $color;
          }
        }
      }
    }
  }
}

.bag-wrap {
  display: flex;
  justify-content: space-between;
  position: absolute;
  width: 100%;
  bottom: 0rpx;
  background-color: #fff;

  .left {
    margin: 20rpx;
    display: flex;
    align-items: center;
    .t-icon {
      width: 80rpx;
      height: 80rpx;
    }
    .text {
      font-size: 36rpx;
      font-weight: 600;
      padding-left: 20rpx;
    }
  }
  .confirm {
    margin: 20rpx;
    padding: 20rpx;
    border-radius: 20rpx;
    width: 200rpx;
    text-align: center;
    color: $light;
    background-color: $bg-color;
  }
  .active {
    color: #fff;
    background-color: $color;
  }
}
</style>
