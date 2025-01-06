# order-project

## 前言
本项目是一个前后端分离项目，开发一个奶茶、点餐类型微信小程序的项目，含有到店取餐和外卖等，包含微信小程序、商家后台管理系统、后端服务。

## 技术栈
-前端-微信小程序：`uni-app + vue2`
--页面结构(H5,CSS3,原生JS)
--框架(基于Vue脚手架:vue-cli)进行搭建

-前端-管理系统：`vue3 + ts + elementPlus`
--页面结构(使用elementPlus UI组件库和SCSS/SASS语法)
--框架(基于Vite搭建vue3项目)

-后端：`nodejs + express + mysql + sequelize`

## 运行
见`order-server/README.md`, `web-order/README.md`, `admin-order/README.md`

### 注意！！！
电脑上必须安装了mysql，并且mysql的相关配置如下才能进行正常运行。
```
    host:'localhost',
    user:'root',
    password:'root',
```
## 实现功能
前端-小程序：
    用户登录注册、商品展示、加入购物袋、订单结算、订单展示、订单详情

前端-管理系统：
    店铺登录、店铺设置、首页推荐管理、发布推荐、类目管理、发布类目、商品管理、发布商品、订单管理、订单详情
        实现上传图片公共组件、使用vue-router页面路由管理，封装axios请求、用户信息状态管理(VUEX + localStorage)

后端：
    用户登录、店铺信息接口、上传图片、首页推荐列表(增删改查)、商品分类列表(增删改查)、商品列表(增删改查)、订单列表(增删改查)
        用户登录验证token(express-jwt)

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
├─web-order               // 前端微信小程序目录
│   ├─public
│   └─src
│       ├─api             // 封装请求
│       ├─components      // 全局公用组件
│       ├─pages           // 小程序页面
│       │  ├─home
│       │  ├─mine
│       │  ├─orderList
│       │  └─product
│       ├─static          // 静态文件
│       │  └─icon
│       └─utils           // 小程序公共方法
├─admin-order             // 前端管理系统目录
│   ├─public
│   └─src
│       ├─assets          // 静态文件
│       ├─components      // 全局公用组件
│       ├─http            // 封装axios请求
│       │  └─api          // 接口方法
│       ├─layout          // 页面布局
│       ├─router          // 路由配置
│       ├─store           // vuex存储配置
│       ├─style           // 全局样式
│       └─views           // 页面
│          ├─home
│          ├─order
│          ├─product
│          ├─service
│          ├─setting
│          └─type
└─order.sql               // 数据库文件
```

## 项目预览
见`/screenshots`文件夹
![](/screenshots/2024-10-29%20175102.png)
![](/screenshots/2024-10-29%20182810.png)
![](/screenshots/20241029_180528.mp4)

## toDo
小程序
    外卖下单接口
    首页接口
    用户信息接口
    收货地址新增页面、增删改接口
管理系统
    商品表单验证