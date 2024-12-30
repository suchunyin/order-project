<script setup lang="ts">
import { login } from "@/http/api/user";
import { ElMessage, FormInstance } from "element-plus";
import { ref, reactive, toRefs, onMounted } from "vue";
import { useRouter } from "vue-router";
import { useStore } from "vuex";
let form = reactive({
  account: "",
  password: "",
});
const rules = {
  account: [{ required: true, message: "请输入账号", trigger: "blur" }],
  password: [
    { required: true, message: "请输入密码", trigger: "blur" },
    { min: 6, max: 20, message: "长度在 6 到 20 个字符", trigger: "blur" },
  ],
};
const loginFormRef = ref<FormInstance>();
const store = useStore();
const router = useRouter();
let loading = ref(false);
const handleLogin = () => {
  loading.value = true;
  loginFormRef.value.validate((valid) => {
    if (valid) {
      store
        .dispatch("Login", form)
        .then((res) => {
          ElMessage.success(res.msg || "登录成功");
          router.push("/");
          loading.value = false;
        })
        .catch(() => {
          loading.value = false;
        });
    } else {
      loading.value = false;
    }
  });
};
</script>

<template>
  <div class="bg-container">
    <div class="login-wrapper">
      <el-form
        ref="loginFormRef"
        :model="form"
        :rules="rules"
        style="width: 350px"
        @keyup.enter="handleLogin"
      >
        <el-form-item prop="account" label="账号">
          <el-input v-model="form.account" placeholder="请输入账号"></el-input>
        </el-form-item>
        <el-form-item prop="password" label="密码">
          <el-input
            v-model="form.password"
            type="password"
            show-password
            placeholder="请输入密码"
          ></el-input>
        </el-form-item>
      </el-form>
      <el-button
        type="primary"
        style="width: 150px"
        :loading="loading"
        @click="handleLogin"
        >登 录</el-button
      >
    </div>
  </div>
</template>

<style lang="scss" scoped>
.bg-container {
  background-color: #f5f5f5;
  height: 100%;
  width: 100%;
}
.login-wrapper {
  background-color: #fff;
  width: 400px;
  height: 200px;
  margin: 0 auto;
  padding: 20px;
  border-radius: 20px;
  border: 1px solid #eee;
  position: relative;
  top: 50%;
  transform: translateY(-50%);
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
</style>
