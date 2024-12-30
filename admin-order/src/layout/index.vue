<script setup lang="ts">
import { ref, reactive, toRefs, onMounted, computed, watch } from "vue";
import { RouteRecordRaw, useRoute, useRouter } from "vue-router";
import { useStore } from "vuex";

let menu = ref([] as any);
let router = useRouter();
let route = useRoute();
const store = useStore();
const userInfo = computed(() => store.state.userInfo);
let activeMenu = ref<string>();
let breadList = ref<RouteRecordRaw[]>([]);
let key = computed(() => route.fullPath);

onMounted(() => {
  activeMenu.value = route.fullPath;
  menu.value = router.options.routes[0].children;
  breadList.value = route.matched.filter(
    (item) => item.meta && item.meta.title
  );
});
watch(route, (to, from) => {
  activeMenu.value = to.matched.find(
    (item) => item.meta && item.meta.icon
  )?.path;
  breadList.value = to.matched.filter((item) => item.meta && item.meta.title);
});
const handleLogOut = () => {
  store.dispatch("LoginOut").then(() => {
    router.push("/login");
  });
};
</script>

<template>
  <div class="layout">
    <el-container class="container">
      <el-aside class="aside" width="200px">
        <div class="info">
          <img :src="userInfo.avatar" alt="" />
          <span class="name">{{ userInfo.name }}</span>
          <el-button size="small" @click="handleLogOut">退出登录</el-button>
        </div>
        <el-menu :default-active="activeMenu" class="menu" router>
          <el-menu-item
            v-for="item in menu"
            :key="item.path"
            :index="item.path"
            :route="item"
          >
            <el-icon><component :is="item.meta.icon" /></el-icon>
            <span>{{ item.meta.title }}</span>
          </el-menu-item>
        </el-menu>
      </el-aside>
      <el-main class="main">
        <el-breadcrumb separator="/">
          <el-breadcrumb-item
            v-for="item in breadList"
            :key="item.path"
            :to="item.path"
          >
            {{ item.meta?.title }}
          </el-breadcrumb-item>
        </el-breadcrumb>
        <router-view :key="key" />
      </el-main>
    </el-container>
  </div>
</template>

<style lang="scss" scoped>
.layout {
  height: 100%;
  .container {
    height: 100%;
  }
}
.aside {
  height: 100%;
  background-color: #fff;
  .info {
    height: 30%;
    @include flex-center;
    flex-direction: column;
    img {
      width: 50px;
      height: 50px;
    }
    .name {
      margin: 10px;
      font-size: 18px;
      font-weight: 600;
    }
  }
  .menu {
    height: 70%;
    .el-menu-item {
      font-size: 18px;
    }
  }
}
.main {
  width: 100%;
  background-color: #ebeaea;
  overflow: hidden;
}
</style>
