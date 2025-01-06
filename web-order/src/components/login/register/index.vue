<template>
  <view class="register-container">
    <uni-forms
      ref="loginFormRef"
      :modelValue="form"
      :rules="rules"
      style="width: 350px"
    >
      <uni-forms-item class="form-item" label="账号" name="account">
        <uni-easyinput v-model="form.account" placeholder="请输入账号" />
      </uni-forms-item>
      <uni-forms-item class="form-item" label="手机号" name="phone">
        <uni-easyinput
          v-model="form.phone"
          type="number"
          placeholder="请输入手机号"
          maxlength="11"
        />
      </uni-forms-item>

      <uni-forms-item class="form-item" label="验证码" name="code">
        <view class="code-wrapper">
          <uni-easyinput
            style="flex: 7"
            v-model="form.code"
            type="number"
            placeholder="请输入验证码"
            maxlength="6"
          />
          <button
            class="code-btn"
            :disabled="codeDisabled"
            size="mini"
            @click="getCode"
          >
            {{ codeText }}
          </button>
        </view>
      </uni-forms-item>

      <uni-forms-item class="form-item" label="密码" name="password">
        <uni-easyinput
          v-model="form.password"
          type="password"
          placeholder="请输入密码"
        />
      </uni-forms-item>
    </uni-forms>
    <button class="submit-btn" :disabled="!canSubmit" @click="handleSubmit">
      注册
    </button>
  </view>
</template>

<script>
export default {
  data() {
    return {
      form: {
        phone: "",
        code: "",
        password: "",
      },
      rules: {
        account: { rules: [{ required: true, errorMessage: "请输入账号" }] },
        phone: {
          rules: [
            { required: true, errorMessage: "请输入手机号" },
            {
              minLength: 11,
              maxLength: 11,
              errorMessage: "请输入正确的手机号",
            },
          ],
        },
        code: { rules: [{ required: true, errorMessage: "请输入验证码" }] },
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
      codeText: "获取验证码",
      codeDisabled: false,
      countdown: 60,
    };
  },
  computed: {
    canSubmit() {
      return this.form.phone && this.form.code && this.form.password;
    },
  },
  methods: {
    // 获取验证码
    async getCode() {
      if (!this.form.phone || this.form.phone.length !== 11) {
        uni.showToast({
          title: "请输入正确的手机号",
          icon: "none",
        });
        return;
      }

      // TODO: 调用获取验证码接口

      this.startCountdown();
    },

    // 开始倒计时
    startCountdown() {
      this.codeDisabled = true;
      this.codeText = `${this.countdown}s后重新获取`;

      const timer = setInterval(() => {
        this.countdown--;
        this.codeText = `${this.countdown}s后重新获取`;

        if (this.countdown <= 0) {
          clearInterval(timer);
          this.codeText = "获取验证码";
          this.codeDisabled = false;
          this.countdown = 60;
        }
      }, 1000);
    },

    // 提交注册
    async handleSubmit() {
      this.$refs.loginFormRef.validate().then(async (form) => {
        try {
          const res = await this.$api.register({
            account: form.account,
            phone: form.phone,
            code: form.code,
            password: form.password,
          });

          if (res.code === 200) {
            uni.showToast({
              title: "注册成功",
              icon: "success",
            });
            setTimeout(() => {
              uni.navigateBack();
            }, 1500);
          } else {
            uni.showToast({
              title: res.msg || "注册失败",
              icon: "none",
            });
          }
        } catch (error) {
          uni.showToast({
            title: error.message || "注册失败",
            icon: "none",
          });
        }
      });
    },
  },
};
</script>

<style lang="scss" scoped>
.register-container {
  padding: 40rpx;

  .form-item {
    margin-bottom: 40rpx;

    .label {
      display: block;
      margin-bottom: 20rpx;
      font-size: 28rpx;
      color: #333;
    }
  }
  .code-wrapper {
    display: flex;
    gap: 20rpx;
    .code-input {
      flex: 1;
    }

    .code-btn {
      flex: 0.4;
      font-size: 24rpx;
      color: #fff;
      background-color: $color;
      border-radius: 8rpx;
      padding: 0 20rpx;
      height: 80rpx;
      line-height: 80rpx;
      white-space: nowrap;

      &[disabled] {
        opacity: 0.6;
      }
    }
  }
  .submit-btn {
    margin-top: 60rpx;
    background-color: $color;
    color: #fff;
    font-size: 32rpx;
    height: 88rpx;
    line-height: 88rpx;
    border-radius: 44rpx;

    &[disabled] {
      opacity: 0.6;
    }
  }
}
</style>
