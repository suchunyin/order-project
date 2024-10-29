# order-project

## 前言
本项目是一个前后端分离项目，开发一个奶茶、点餐类型微信小程序的项目，含有到店取餐和外卖等

## 技术栈
--前端：uni-app+vue2
--后端：nodejs+express+mysql+sequelize

## 运行
见order-server/README.md, web-order/README.md

### 注意！！！
电脑上必须安装了mysql，并且mysql的相关配置如下才能进行正常运行。
```
    host:'localhost',
    user:'root',
    password:'root',
```
## 实现功能
前端：
商品展示、加入购物袋、订单结算、订单展示、订单详情
后端：
商品分类列表(增删改查)、商品列表(增删改查)、订单列表(增删改查)

## 项目结构
```
├─order-server            // 后端目录
│  ├─resource             // 图片服务
│  │  ├─product
│  │  ├─type
│  │  └─user
│  ├─router               // 后端接口
│  │  ├─order             // 订单接口
│  │  ├─product           // 商品接口
│  │  └─user              // 用户接口
│  ├─router_handler       // 封装数据库，sequelize模型
│  └─utils                // 后端公共方法
├─web-order               // 前端目录
│   ├─public
│   └─src
│       ├─api             // 封装请求
│       ├─components      // 全局公用组件
│       ├─pages           // 前端页面
│       │  ├─home
│       │  ├─mine
│       │  ├─orderList
│       │  └─product
│       ├─static          // 静态文件
│       │  └─icon
│       └─utils           // 前端公共方法
└─order.sql
```