# order-project

## 前言
本项目是一个前后端分离项目，开发一个奶茶、点餐类型微信小程序的项目，含有到店取餐和外卖等

## 技术栈
-前端：uni-app+vue2
--页面结构(H5,CSS3,原生JS)
--框架(基于Vue脚手架:vue-cli)进行搭建
-后端：nodejs+express+mysql+sequelize

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
│  │  ├─order.js          // 订单接口
│  │  ├─product.js        // 商品接口
│  │  └─user.js           // 用户接口
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
└─order.sql               // 数据库文件
```

## 项目预览
![](/screenshots/2024-10-29%20175102.png)
![](/screenshots/2024-10-29%20182810.png)
![](/screenshots/20241029_180528.mp4)

## toDo
外卖下单接口
首页接口
用户信息接口
收货地址新增页面、增删改接口