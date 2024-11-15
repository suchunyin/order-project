import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import { resolve } from "path";

// https://vite.dev/config/
export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      "@": resolve(__dirname, "src"),
    },
  },
  css: {
    preprocessorOptions: {
      scss: {
        additionalData: '@import "./src/style/index.scss";',
        charset: false,
      },
    },
  },
  server: {
    host: "127.0.0.1",
    port: 6003,
    open: true,
    proxy: {
      "/api": {
        target: "http://127.0.0.1:3009",
        changeOrigin: true,
        // rewrite: (path) => path.replace("/api", ""),
      },
      "/image": {
        target: "http://127.0.0.1:3009",
        changeOrigin: true,
        // rewrite: (path) => path.replace("/image", ""),
      },
    },
  },
});
