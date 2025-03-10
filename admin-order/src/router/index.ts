import { createRouter, createWebHistory, RouteRecordRaw } from "vue-router";
import store from "../store";

const routes: Array<RouteRecordRaw> = [
  {
    path: "/",
    name: "layout",
    component: () => import("@/layout/index.vue"),
    redirect: "/home",
    children: [
      {
        path: "/home",
        name: "home",
        meta: { title: "首页推荐", icon: "Star" },
        component: () => import("@/views/home/index.vue"),
        children: [
          {
            path: "/home/addRecommend",
            name: "addRecommend",
            meta: { title: "新增推荐" },
            component: () => import("@/views/home/add.vue"),
          },
        ],
      },
      {
        path: "/type",
        name: "type",
        meta: { title: "类目管理", icon: "Connection" },
        component: () => import("@/views/type/index.vue"),
        children: [
          {
            path: "/type/addType",
            name: "addType",
            meta: { title: "新增类目" },
            component: () => import("@/views/type/add.vue"),
          },
        ],
      },
      {
        path: "/product",
        name: "product",
        meta: { title: "商品管理", icon: "MilkTea" },
        component: () => import("@/views/product/index.vue"),
        children: [
          {
            path: "/product/addProduct",
            name: "addProduct",
            meta: { title: "新增商品" },
            component: () => import("@/views/product/add.vue"),
          },
        ],
      },
      {
        path: "/order",
        name: "order",
        meta: { title: "订单管理", icon: "Operation" },
        component: () => import("@/views/order/index.vue"),
      },
      {
        path: "/service",
        name: "service",
        meta: { title: "客服", icon: "ChatDotSquare" },
        component: () => import("@/views/service/index.vue"),
      },
      {
        path: "/setting",
        name: "setting",
        meta: { title: "店铺设置", icon: "DataAnalysis" },
        component: () => import("@/views/setting/index.vue"),
      },
    ],
  },
  {
    path: "/login",
    name: "login",
    meta: { title: "登录" },
    component: () => import("@/layout/login.vue"),
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

router.beforeEach((to, _from, next) => {
  document.title = (to.meta.title as string) || "HEYIKOU商家后台管理系统";
  if (to.path === "/login") {
    next();
  } else {
    const token = store.getters.token;
    if (!token) {
      next("/login");
    } else {
      next();
    }
  }
});

export default router;
