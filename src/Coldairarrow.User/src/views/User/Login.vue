<template>
  <div class="container" :class="{ 'sign-up-mode': isSignUpMode }">
    <div class="forms-container">
      <div class="signin-signup">
        <!-- 登录表单 -->
        <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="sign-in-form"
          @submit.native.prevent="handleLogin">
          <b>{{ appTitle }}</b>
          <h2 class="title">欢迎登录</h2>

          <el-form-item prop="userName">
            <div class="input-field">
              <i class="el-icon-user"></i>
              <input v-model="loginForm.userName" type="text" placeholder="请输入用户名">
            </div>
          </el-form-item>

          <el-form-item prop="password">
            <div class="input-field">
              <i class="el-icon-lock"></i>
              <input v-model="loginForm.password" type="password" placeholder="请输入密码">
            </div>
          </el-form-item>
          <el-form-item prop="captcha">
            <div class="input-field input-field-captcha">
              <i class="el-icon-key"></i>
              <input v-model="loginForm.captcha" type="text" placeholder="请输入验证码" maxlength="4" @keyup.enter="handleLogin">
              <Captcha ref="captchaRef" />
            </div>
          </el-form-item>

          <el-button type="primary" class="btn solid" :loading="loading" @click="handleLogin">
            登录
          </el-button>
        </el-form>

        <!-- 注册表单 -->
        <el-form ref="registerForm" :model="registerForm" :rules="registerRules" class="sign-up-form"
          @submit.native.prevent="handleRegister">
          <b>{{ appTitle }}</b>
          <h2 class="title">立即注册</h2>
          <el-form-item prop="userName">
            <div class="input-field">
              <i class="el-icon-user"></i>
              <input v-model="registerForm.userName" type="text" placeholder="请输入用户名">
            </div>
          </el-form-item>

          <el-form-item prop="email">
            <div class="input-field">
              <i class="el-icon-message"></i>
              <input v-model="registerForm.email" type="text" placeholder="请输入邮箱">
            </div>
          </el-form-item>

          <el-form-item prop="code">
            <div class="input-field input-field-code">
              <i class="el-icon-key"></i>
              <input v-model="registerForm.code" type="text" placeholder="请输入验证码" maxlength="8">
              <button v-if="!isCounting" type="button" class="code-btn" @click="sendVerifyCode">
                获取验证码
              </button>
              <div v-else class="countdown-btn">
                {{ countdown }}s
              </div>
            </div>
          </el-form-item>

          <el-form-item prop="password">
            <div class="input-field">
              <i class="el-icon-lock"></i>
              <input v-model="registerForm.password" type="password" placeholder="请输入密码">
            </div>
          </el-form-item>

          <el-button type="primary" class="btn solid" @click="handleRegister">
            注册
          </el-button>
        </el-form>
      </div>
    </div>

    <!-- 左右切换面板 -->
    <div class="panels-container">
      <!-- 左侧面板 - 注册引导 -->
      <div class="panel left-panel">
        <div class="content">
          <h3>还没有账号？</h3>
          <p>
            如果您还没有账号<br>
            请使用邮箱注册<br>
            即可快速创建账号
          </p>
          <button class="btn transparent" @click="toggleMode">
            立即注册
          </button>
        </div>
        <img src="@/assets/images/b.svg" class="image" alt="注册">
      </div>

      <!-- 右侧面板 - 登录引导 -->
      <div class="panel right-panel">
        <div class="content">
          <h3>已有账号？</h3>
          <p>
            如果您已有账号<br>
            请使用用户名和密码登录<br>
            开始使用系统
          </p>
          <button class="btn transparent" @click="toggleMode">
            返回登录
          </button>
        </div>
        <img src="@/assets/images/n.svg" class="image" alt="登录">
      </div>
    </div>
  </div>
</template>

<script>
import { isUsername, isPassword } from '@/utils/validate'
import request from '@/utils/request'
import Captcha from '@/components/Captcha/index.vue'

export default {
  name: 'LoginPage',
  components: {
    Captcha
  },
  data() {
    const validateUsername = (rule, value, callback) => {
      if (!value) {
        callback(new Error('请输入用户名'))
      } else if (!isUsername(value)) {
        callback(new Error('用户名为4-16位字母数字下划线'))
      } else {
        callback()
      }
    }
    const validatePassword = (rule, value, callback) => {
      if (!value) {
        callback(new Error('请输入密码'))
      } else if (!isPassword(value)) {
        callback(new Error('密码长度为6-20位'))
      } else {
        callback()
      }
    }
    const validateEmail = (rule, value, callback) => {
      if (!value) {
        callback(new Error('请输入邮箱'))
      } else if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(value)) {
        callback(new Error('请输入正确的邮箱格式'))
      } else {
        callback()
      }
    }
    return {
      appTitle: process.env.VUE_APP_TITLE || 'Home-school communication',
      isSignUpMode: false,
      loading: false,
      loginForm: {
        userName: '',
        password: '',
        captcha: ''
      },
      loginRules: {
        userName: [{ required: true, trigger: 'blur', validator: validateUsername }],
        password: [{ required: true, trigger: 'blur', validator: validatePassword }],
        captcha: [{ required: true, message: '请输入验证码', trigger: 'blur' }]
      },
      registerForm: {
        userName: '',
        email: '',
        code: '',
        password: ''
      },
      registerRules: {
        userName: [{ required: true, trigger: 'blur', validator: validateUsername }],
        email: [{ required: true, trigger: 'blur', validator: validateEmail }],
        code: [{ required: true, message: '请输入验证码', trigger: 'blur' }],
        password: [{ required: true, trigger: 'blur', validator: validatePassword }]
      },
      // 验证码倒计时
      isCounting: false,
      countdown: 60,
      countdownTimer: null
    }
  },
  mounted(){
    if (this.$route.query.mode === 'register') {
      this.isSignUpMode = true
    }
  },

  beforeDestroy() {
    if (this.countdownTimer) {
      clearInterval(this.countdownTimer)
    }
  },
  methods: {
    // 切换登录/注册模式
    toggleMode() {
      this.isSignUpMode = !this.isSignUpMode
      // 清空表单
      this.$refs.loginForm && this.$refs.loginForm.resetFields()
      this.$refs.registerForm && this.$refs.registerForm.resetFields()
      // 重置倒计时
      if (this.countdownTimer) {
        clearInterval(this.countdownTimer)
        this.isCounting = false
        this.countdown = 60
      }
    },

    // 登录
    handleLogin() {
      this.$refs.loginForm.validate(async valid => {
        if (!valid) return

        // 验证验证码
        if (!this.$refs.captchaRef.verify(this.loginForm.captcha)) {
          this.$message.error('验证码错误')
          this.$refs.captchaRef.refreshCode()
          this.loginForm.captcha = ''
          return
        }

        this.loading = true
        try {
          await this.$store.dispatch('user/login', this.loginForm)
          await this.$store.dispatch('user/getUserInfo')

          this.$message.success('登录成功')

          const redirect = this.$route.query.redirect || '/'
          this.$router.push(redirect)
        } catch (error) {
          // 错误消息已在 request 拦截器中统一处理
          this.$refs.captchaRef.refreshCode()
          this.loginForm.captcha = ''
        } finally {
          this.loading = false
        }
      })
    },

    sendVerifyCode() {
      this.$refs.registerForm.validateField('email', async error => {
        if (error) return
        try {
          const response = await request({
            url: '/Base_Manage/Base_User/SendVerifyCode',
            method: 'post',
            data: {
              email: this.registerForm.email,
              type: 'register'
            }
          })
          if (response.Success) {
            this.$message.success('验证码已发送到您的邮箱，请查收')
            this.startCountdown()
          } else {
            this.$message.error(response.Msg || '验证码发送失败')
          }
        } catch (error) {
          this.$message.error('验证码发送失败，请检查网络连接')
          console.error('发送验证码错误:', error)
        }
      })
    },

    // 开始倒计时
    startCountdown() {
      this.isCounting = true
      this.countdown = 60
      this.countdownTimer = setInterval(() => {
        this.countdown--
        if (this.countdown <= 0) {
          clearInterval(this.countdownTimer)
          this.isCounting = false
          this.countdown = 60
        }
      }, 1000)
    },

     handleRegister() {
      this.$refs.registerForm.validate(async valid => {
        if (!valid) return
        try {
          const response = await request({
            url: '/Base_Manage/Base_User/Register',
            method: 'post',
            data: {
              userName: this.registerForm.userName,
              email: this.registerForm.email,
              code: this.registerForm.code,
              password: this.registerForm.password
            }
          })
          if (response.Success) {
            this.$message.success('注册成功，请登录')
            this.isSignUpMode = false
            this.$refs.registerForm.resetFields()
            
            if (this.countdownTimer) {
              clearInterval(this.countdownTimer)
              this.isCounting = false
              this.countdown = 60
            }
          } else {
            this.$message.error(response.Msg || '注册失败')
          }
        } catch (error) {
        }
      })
    }
  }
}
</script>


<style lang="scss" scoped>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

.container {
  position: relative;
  width: 100%;
  min-height: 100vh;
  background-color: #fff;
  overflow: hidden;

  &::before {
    content: '';
    position: absolute;
    width: 2000px;
    height: 2000px;
    border-radius: 50%;
    background: linear-gradient(145deg, #4481eb, #04befe);
    top: -10%;
    right: 48%;
    transform: translateY(-50%);
    z-index: 6;
    transition: 1.8s ease-in-out;
  }

  &.sign-up-mode::before {
    transform: translate(100%, -50%);
    right: 52%;
  }

  &.sign-up-mode .signin-signup {
    left: 25%;
  }

  &.sign-up-mode .sign-in-form {
    z-index: 1;
    opacity: 0;
  }

  &.sign-up-mode .sign-up-form {
    z-index: 2;
    opacity: 1;
  }

  &.sign-up-mode .left-panel {
    pointer-events: none;

    .image,
    .content {
      transform: translateX(-800px);
    }
  }

  &.sign-up-mode .right-panel {
    pointer-events: all;

    .image,
    .content {
      transform: translateX(0);
    }
  }
}

.forms-container {
  position: absolute;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
}

.signin-signup {
  position: absolute;
  top: 50%;
  left: 75%;
  transform: translate(-50%, -50%);
  width: 50%;
  display: grid;
  grid-template-columns: 1fr;
  z-index: 5;
  transition: 1s 0.7s ease-in-out;
}

.sign-in-form,
.sign-up-form {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  padding: 0 5rem;
  overflow: hidden;
  grid-column: 1 / 2;
  grid-row: 1 / 2;
  transition: 0.2s 0.7s ease-in-out;

  b {
    font-size: 14px;
    color: #666;
    margin-bottom: 10px;
  }
}

.sign-in-form {
  z-index: 2;
}

.sign-up-form {
  z-index: 1;
  opacity: 0;
}

.title {
  font-size: 2.2rem;
  color: #444;
  margin-bottom: 30px;
}

/* 隐藏Element UI的默认样式 */
::v-deep .el-form-item {
  margin-bottom: 20px;
  width: 100%;

  .el-form-item__content {
    line-height: normal;
  }

  .el-form-item__error {
    position: relative;
    top: 2px;
    text-align: center;
    margin-left: 20%;
    max-width: 380px;
    background: rgba(255, 107, 107, 0.1);
    border-radius: 4px;
    font-size: 12px;
  }
}

.input-field {
  max-width: 380px;
  margin-left: 20%;
  width: 100%;
  height: 55px;
  background-color: #f0f0f0;
  border-radius: 55px;
  display: grid;
  grid-template-columns: 15% 85%;
  padding: 0 0.4rem;

  i {
    text-align: center;
    line-height: 55px;
    color: #acacac;
    font-size: 1.1rem;
  }

  input {
    background: none;
    outline: none;
    border: none;
    line-height: 1;
    font-weight: 400;
    font-size: 1.1rem;
    color: #333;

    &::placeholder {
      color: #aaa;
      font-weight: 400;
    }
  }
}

.btn {
  width: 150px;
  height: 49px;
  border: none;
  outline: none;
  border-radius: 49px;
  cursor: pointer;
  background-color: #5995fd;
  color: #fff;
  text-transform: uppercase;
  font-weight: 600;
  margin: 10px 0;
  transition: 0.5s;

  &:hover {
    background-color: #4d84e2;
  }

  &.solid {
    width: 150px;
    margin-top: 20px;
  }

  &.transparent {
    margin: 0;
    background: none;
    border: 2px solid #fff;
    width: 130px;
    height: 41px;
    font-weight: 600;
    font-size: 0.8rem;

    &:hover {
      background: rgba(255, 255, 255, 0.1);
    }
  }
}

.input-field-code {
  display: grid !important;
  grid-template-columns: 15% 1fr auto !important;
  align-items: center;
  padding-right: 8px !important;
  i {
    text-align: center;
    line-height: 55px;
    color: #acacac;
    font-size: 1.1rem;
    margin: 0;
  }
  input {
    background: none;
    outline: none;
    border: none;
    line-height: 1;
    font-weight: 400;
    font-size: 1.1rem;
    color: #333;
    &::placeholder {
      color: #aaa;
      font-weight: 400;
    }
  }
}

.input-field-captcha {
  display: grid !important;
  grid-template-columns: 15% 1fr auto !important;
  align-items: center;
  padding-right: 8px !important;
  i {
    text-align: center;
    line-height: 55px;
    color: #acacac;
    font-size: 1.1rem;
    margin: 0;
  }
  input {
    background: none;
    outline: none;
    border: none;
    line-height: 1;
    font-weight: 400;
    font-size: 1.1rem;
    color: #333;
    &::placeholder {
      color: #aaa;
      font-weight: 400;
    }
  }
}
.code-btn,
.countdown-btn {
  flex-shrink: 0;
  padding: 8px 16px;
  height: 38px;
  border: none;
  border-radius: 20px;
  font-size: 13px;
  white-space: nowrap;
  margin-left: 8px;
}
.code-btn {
  background-color: #5995fd;
  color: #fff;
  cursor: pointer;
  transition: 0.3s;
  &:hover {
    background-color: #4d84e2;
  }
}
.countdown-btn {
  background-color: #f0f0f0;
  color: #666;
  cursor: not-allowed;
  display: flex;
  align-items: center;
  justify-content: center;
}
.panels-container {
  position: absolute;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  display: grid;
  grid-template-columns: repeat(2, 1fr);
}

.panel {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  justify-content: space-around;
  text-align: center;
  z-index: 7;
  padding: 3rem 17% 2rem 12%;

  .content {
    color: #fff;
    transition: 0.9s 0.6s ease-in-out;

    h3 {
      font-weight: 600;
      line-height: 1;
      font-size: 1.5rem;
      margin-bottom: 10px;
    }

    p {
      font-size: 0.95rem;
      padding: 0.7rem 0;
      line-height: 1.8;
    }
  }

  .image {
    width: 100%;
    max-width: 400px;
    transition: 1.1s 0.4s ease-in-out;
  }
}

.left-panel {
  pointer-events: all;
}

.right-panel {
  padding: 3rem 12% 2rem 17%;
  pointer-events: none;

  .content,
  .image {
    transform: translateX(800px);
  }
}

/* 响应式设计 */
@media (max-width: 870px) {
  .container::before {
    width: 1500px;
    height: 1500px;
    left: 30%;
    bottom: 68%;
    transform: translateX(-50%);
    right: initial;
    top: initial;
    transition: 2s ease-in-out;
  }

  .signin-signup {
    width: 100%;
    left: 50%;
    top: 95%;
    transform: translate(-50%, -100%);
    transition: 1s 0.8s ease-in-out;
  }

  .container.sign-up-mode::before {
    transform: translate(-50%, 100%);
    bottom: 32%;
    right: initial;
  }

  .container.sign-up-mode .signin-signup {
    left: 50%;
  }

  .panels-container {
    grid-template-columns: 1fr;
    grid-template-rows: 1fr 2fr 1fr;
  }

  .panel {
    flex-direction: row;
    justify-content: space-around;
    align-items: center;
    padding: 2.5rem 8%;

    .content {
      padding-right: 15%;
      transition: 0.9s 0.8s ease-in-out;

      h3 {
        font-size: 1.2rem;
      }

      p {
        font-size: 0.7rem;
      }
    }

    .image {
      width: 200px;
      transition: 0.9s 0.6s ease-in-out;
    }
  }

  .left-panel {
    grid-row: 1 / 2;
  }

  .right-panel {
    grid-row: 3 / 4;
    padding: 2.5rem 8%;

    .content,
    .image {
      transform: translateY(300px);
    }
  }

  .container.sign-up-mode .left-panel {

    .content,
    .image {
      transform: translateY(-300px);
    }
  }

  .container.sign-up-mode .right-panel {

    .content,
    .image {
      transform: translateY(0);
    }
  }

  .sign-in-form,
  .sign-up-form {
    padding: 0 1.5rem;
  }
}

@media (max-width: 570px) {

  .sign-in-form,
  .sign-up-form {
    padding: 0 1rem;
  }

  .input-field {
    max-width: 100%;
  }

  .panel .image {
    display: none;
  }
}
</style>
