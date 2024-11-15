/// <reference types="vite/client" />
declare module "*.vue" {
  import { Component } from "vue";
  const component: Component;
  export default component;
}
declare module "vuex" {
  export * from 'vuex/types/index.d.ts'
  export * from 'vuex/types/helpers.d.ts'
  export * from 'vuex/types/logger.d.ts'
  export * from 'vuex/types/vue.d.ts'
}