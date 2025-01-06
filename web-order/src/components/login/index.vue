<template>
  <view class="bg-container">
    <view class="login-wrapper">
      <uni-forms
        ref="loginFormRef"
        :modelValue="form"
        :rules="rules"
        style="width: 350px"
      >
        <uni-forms-item v-if="isPhoneLogin" name="phone" label="手机号">
          <uni-easyinput
            v-model="form.phone"
            placeholder="请输入手机号"
          ></uni-easyinput>
        </uni-forms-item>
        <uni-forms-item v-else name="account" label="账号">
          <uni-easyinput
            v-model="form.account"
            placeholder="请输入账号"
          ></uni-easyinput>
        </uni-forms-item>
        <uni-forms-item name="password" label="密码">
          <uni-easyinput
            v-model="form.password"
            type="password"
            placeholder="请输入密码"
          ></uni-easyinput>
        </uni-forms-item>
      </uni-forms>
      <button type="primary" size="mini" class="login-btn" @click="handleLogin">
        登 录
      </button>
      <view class="other-wrapper">
        <view v-if="!isPhoneLogin" @click="isPhoneLogin = true" class="other">
          手机号登录
        </view>
        <view v-else class="other" @click="isPhoneLogin = false">账号登录</view>
        |
        <navigator url="/components/login/register/index" class="register">
          注册
        </navigator>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      form: {
        phone: "",
        account: "",
        password: "",
      },
      rules: {
        account: { rules: [{ required: true, errorMessage: "请输入账号" }] },
        password: {
          rules: [
            { required: true, errorMessage: "请输入密码" },
            {
              minLength: 6,
              maxLength: 20,
              errorMessage: "长度在 6 到 20 个字符",
            },
          ],
        },
      },
      isPhoneLogin: false,
    };
  },
  methods: {
    handleLogin() {
      this.$refs.loginFormRef.validate().then((form) => {
        if (this.isPhoneLogin) delete form.account;
        else delete form.phone;
        this.$store.dispatch("Login", form).then((res) => {
          uni.showToast({ title: "登录成功", icon: "success" });
          uni.navigateBack();
        });
      });
    },
  },
};
</script>

<style lang="scss" scoped>
.bg-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 50vh;
}
.login-wrapper {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 100%;
  .login-btn {
    width: 300rpx;
    background-color: $color;
  }
  .other-wrapper {
    display: flex;
    align-items: flex-end;
    margin: 20rpx;
    gap: 20rpx;
  }
  .other,
  .register {
    color: #777;
    font-size: 24rpx;
  }
}
.uni-easyinput {
  width: 100%;
}
</style>
