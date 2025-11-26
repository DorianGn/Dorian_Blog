<template>
  <div class="login-container">
    <div class="login-wrapper">
      <!-- 左侧图片 -->
      <div class="login-left">
        <div class="banner-img-wrapper">
          <img src="@/assets/login_bg.png" alt="登陆" class="banner-img" />
          <div class="banner-title">
            <h2>
              <span class="text-blue">Blog</span>
              <span class="text-purple">管理系统</span>
            </h2>
          </div>
        </div>
      </div>

      <!-- 右侧表单 -->
      <div class="login-right">
        <a-spin :spinning="loginLoading || registerLoading">
          <div class="form-container">
            <div class="form-title">
              <h1>欢迎登陆...</h1>
              <p>WELCOME TO LOGIN</p>
            </div>

            <a-form id="formLogin" class="user-layout-login" ref="formLogin" :form="form" @submit.prevent="handleSubmit"
              autocomplete="off">
              <!-- 用户名 -->
              <a-form-item>
                <a-input size="large" type="text" placeholder="请输入用户名" autocomplete="username"
                  v-decorator="['userName', { rules: [{ required: true, message: '请输入用户名' }],validateTrigger:'blur' }]">
                  <a-icon slot="prefix" type="user" :style="{ color: 'rgba(0,0,0,.25)' }" />
                </a-input>
              </a-form-item>

              <!-- 密码 -->
              <a-form-item>
                <a-input size="large" type="password" autocomplete="current-password" placeholder="请输入密码"
                  v-decorator="['password', { rules: [{ required: true, message: '请输入密码' }],validateTrigger:'blur' }]">
                  <a-icon slot="prefix" type="lock" :style="{ color: 'rgba(0,0,0,.25)' }" />
                </a-input>
              </a-form-item>
              <!-- 验证码 -->
              <a-form-item>
                <a-input size="large" type="text" autocomplete="current-password" placeholder="请输入验证码" v-decorator="['captcha', {
                  rules: [
                    { required: true, message: '请输入验证码' },
                    { validator: validateCaptcha }
                  ],validateTrigger:'blur'
                }]">
                  <a-icon slot="prefix" type="safety-certificate" :style="{ color: 'rgba(0,0,0,.25)' }" />
                  <Cache slot="suffix" ref="captcha" />
                </a-input>
              </a-form-item>

              <!-- 记住用户名 -->
              <!-- <a-form-item>
                <a-checkbox v-decorator="['savePwd', { valuePropName: 'checked' }]">记住用户名</a-checkbox>
              </a-form-item> -->

              <!-- 登录按钮 -->
              <a-form-item style="margin-top:24px">
                <a-button size="large" htmlType="submit" :loading="loginLoading" class="login-button">登录</a-button>
              </a-form-item>
            </a-form>
          </div>
        </a-spin>
      </div>
    </div>
  </div>
</template>


<script>
import TokenCache from '@/utils/cache/TokenCache'
import Cache from '@/components/Captcha/index.vue'

export default {
  components: {
    Cache
  },
  data() {
    return {
      loginLoading: false,
      registerLoading: false,
      customActiveKey: 'tab1',
      form: this.$form.createForm(this),
      verifyCodeLoading: false,
      verifyCodeCountDown: 0,
      verifyCodeTimer: null
    }
  },
  mounted() {
    const userName = localStorage.getItem('userName')
    if (userName) {
      this.form.setFieldsValue({ userName, savePwd: true })
    }
  },
  beforeDestroy() {
    // 组件销毁时清除定时器
    if (this.verifyCodeTimer) {
      clearInterval(this.verifyCodeTimer)
    }
  },
  methods: {
    // handleTabClick (key) {
    //   this.customActiveKey = key

    //   // 清除验证码倒计时
    //   if (this.verifyCodeTimer) {
    //     clearInterval(this.verifyCodeTimer)
    //     this.verifyCodeCountDown = 0
    //     this.verifyCodeTimer = null
    //   }

    //   // 切换标签页时清除表单验证错误
    //   if (key === 'tab1') {
    //     // 清除注册相关字段
    //     this.form.resetFields(['regUserName', 'email', 'verifyCode', 'regPassword', 'confirmPassword'])
    //   } else {
    //     // 清除登录相关字段
    //     this.form.resetFields(['userName', 'password'])
    //   }
    // },

    validateCaptcha(rule, value, callback) {
      if (!value) {
        callback()
        return
      }

      if (this.$refs.captcha && !this.$refs.captcha.verify(value)) {
        callback('验证码错误')
      } else {
        callback()
      }
    },
    handleSubmit(e) {
      e.preventDefault()
      if (this.customActiveKey === 'tab1') {
        this.handleLogin()
      } else {
        this.handleRegister()
      }
    },
    handleLogin() {
      this.form.validateFields(['userName', 'password', 'captcha'], (errors, values) => {
        if (errors) {
          this.$message.error('校验失败，请检查输入项')
          return
        }
        const submitValues = this.form.getFieldsValue()
        this.loginLoading = true
        const loginData = {
          userName: submitValues['userName'],
          password: submitValues['password']
        }
        this.$http.post('/Base_Manage/Home/SubmitLogin', loginData)
          .then(resJson => {
            if (resJson.Success) {
              TokenCache.setToken(resJson.Data)

              if (submitValues['savePwd']) {
                localStorage.setItem('userName', submitValues['userName'])
              } else {
                localStorage.removeItem('userName')
              }

              this.$message.success('登录成功')
              this.$router.push({ path: '/' })
            } else {
              this.$message.error(resJson.Msg || '登录失败')
              this.$refs.captcha.refreshCode()
              this.form.setFieldsValue({ captcha: '' })
            }
          })
          .catch(error => {
            this.$message.error('登录失败，请检查网络连接')
            console.error('登录错误:', error)
            this.$refs.captcha.refreshCode()
            this.form.setFieldsValue({ captcha: '' })
          })
          .finally(() => {
            this.loginLoading = false
          })
      })
    },
    // handleRegister() {
    //   const registerFields = [
    //     'regUserName',
    //     'email',
    //     'verifyCode',
    //     'regPassword',
    //     'confirmPassword'
    //   ]
    //   this.form.validateFields(registerFields, (errors, values) => {
    //     if (errors) return
    //     const submitValues = this.form.getFieldsValue()
    //     this.registerLoading = true
    //     const registerData = {
    //       userName: submitValues['regUserName'],
    //       email: submitValues['email'],
    //       verifyCode: submitValues['verifyCode'],
    //       password: submitValues['regPassword']
    //     }
    //     this.$http.post('/Base_Manage/Base_User/Register', registerData)
    //       .then(resJson => {
    //         if (resJson.Success) {
    //           this.$message.success('注册成功，请登录')
    //           this.customActiveKey = 'tab1'
    //           // 清空表单
    //           this.form.resetFields()
    //           // 清除验证码倒计时
    //           if (this.verifyCodeTimer) {
    //             clearInterval(this.verifyCodeTimer)
    //             this.verifyCodeCountDown = 0
    //             this.verifyCodeTimer = null
    //           }
    //         } else {
    //           this.$message.error(resJson.Msg || '注册失败')
    //         }
    //       })
    //       .catch(error => {
    //         this.$message.error('注册失败，请检查网络连接')
    //         console.error('注册错误:', error)
    //       })
    //       .finally(() => {
    //         this.registerLoading = false
    //       })
    //   })
    // },
    // sendVerifyCode() {
    //   this.form.validateFields(['email'], err => {
    //     if (err) return
    //     const email = this.form.getFieldValue('email')
    //     if (!email) {
    //       this.$message.error('请先输入邮箱地址')
    //       return
    //     }
    //     this.verifyCodeLoading = true
    //     this.$http.post('/Base_Manage/Base_User/SendVerifyCode', {
    //       email: email,
    //       type: 'register'
    //     })
    //       .then(response => {
    //         if (response.Success) {
    //           this.$message.success('验证码已发送到您的邮箱，请查收')
    //           this.startVerifyCodeCountDown()
    //         } else {
    //           this.$message.error(response.Msg || '验证码发送失败')
    //         }
    //       })
    //       .catch(error => {
    //         this.$message.error('验证码发送失败，请检查网络连接')
    //         console.error('发送验证码错误:', error)
    //       })
    //       .finally(() => {
    //         this.verifyCodeLoading = false
    //       })
    //   })
    // },
    // startVerifyCodeCountDown() {
    //   this.verifyCodeCountDown = 60

    //   if (this.verifyCodeTimer) {
    //     clearInterval(this.verifyCodeTimer)
    //   }
    //   this.verifyCodeTimer = setInterval(() => {
    //     this.verifyCodeCountDown--

    //     if (this.verifyCodeCountDown <= 0) {
    //       clearInterval(this.verifyCodeTimer)
    //       this.verifyCodeTimer = null
    //     }
    //   }, 1000)
    // },
    /**
     * 验证两次密码是否一致
     */
    // validatePasswordMatch(rule, value, callback) {
    //   const regPassword = this.form.getFieldValue('regPassword')

    //   if (value && value !== regPassword) {
    //     callback('两次输入的密码不一致')
    //   } else {
    //     callback()
    //   }
    // }
  }
}
</script>

<style lang="less" scoped>
.login-container {
  width: 100%;
  min-height: 100vh;
  background: #f0f2f5;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0;
}

.login-wrapper {
  width: 100%;
  height: 100vh;
  display: flex;
  background: white;
  overflow: hidden;

  @media (max-width: 768px) {
    flex-direction: column;
    height: auto;
  }
}

.login-left {
  flex: 1;
  overflow: hidden;

  @media (max-width: 768px) {
    display: none;
  }
}

.banner-img-wrapper {
  width: 100%;
  height: 100%;
  position: relative;
}

.banner-title {
  position: absolute; // 关键：绝对定位
  top: 40px;
  left: 40px;
  z-index: 10;

  h2 {
    margin: 0;
    font-size: 25px;
    font-weight: bold;
    letter-spacing: 1px;

    .text-blue {
      color: #1843b9; // 深蓝色
    }

    .text-purple {
      color: #6d2daa; // 深紫色
    }
  }
}

.banner-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.login-right {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
  background: #f0f5f8;
  ;

  @media (max-width: 768px) {
    padding: 20px;
  }
}

.form-container {
  width: 100%;
  max-width: 800px;
  min-width: 400px;
}

.form-title {
  text-align: left;
  margin-bottom: 30px;

  h1 {
    margin: 0;
    font-size: 24px;
    font-weight: 700;
    color: #1a1a1a;
    letter-spacing: 2px;
    font-family: "Microsoft YaHei", "PingFang SC", sans-serif;
  }

  p {
    margin: 0;
    font-size: 13px;
    color: #999;
    border-bottom: 2px solid #1843b9;
    display: inline-block;
    padding-bottom: 3px;
  }
}

.user-layout-login {
  :deep(.ant-form-item) {
    margin-bottom: 24px;
  }

  :deep(.ant-input-affix-wrapper) {
    .ant-input {
      width: 100%;
      border-radius: 4px;
      font-size: 16px;

      &::placeholder {
        color: #bfbfbf;
        font-size: 16px;
      }
    }

    .ant-input-prefix {
      font-size: 16px;
      margin-right: 50px;
    }

    .ant-input-suffix {
      font-size: 16px;
      margin-left: 12px;
    }
  }
}

.login-button {
  width: 100%;
  height: 40px;
  font-size: 16px;
  border-radius: 4px;
  color: white;
  background-color: #1843b9;
}
</style>