<template>
  <div class="login-page">
    <div class="login-container">
      <div class="login-card">
        <h2 class="login-title">欢迎登录</h2>
        <p class="login-subtitle">{{ appTitle }}</p>

        <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="login-form">
          <el-form-item prop="userName">
            <el-input v-model="loginForm.userName" placeholder="用户名" prefix-icon="el-icon-user" size="large"
              @keyup.enter.native="handleLogin">
            </el-input>
          </el-form-item>

          <el-form-item prop="password">
            <el-input v-model="loginForm.password" type="password" placeholder="密码" prefix-icon="el-icon-lock"
              size="large" show-password @keyup.enter.native="handleLogin">
            </el-input>
          </el-form-item>

          <el-form-item>
            <el-button type="primary" size="large" :loading="loading" style="width: 100%" @click="handleLogin">
              登录
            </el-button>
          </el-form-item>
        </el-form>

        <div class="login-footer">
          <span>还没有账号？</span>
          <router-link to="/register">立即注册</router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { isUsername, isPassword } from '@/utils/validate'

export default {
  name: 'LoginPage',
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

    return {
      appTitle: process.env.VUE_APP_TITLE,
      loginForm: {
        userName: '',
        password: ''
      },
      loginRules: {
        userName: [{ required: true, trigger: 'blur', validator: validateUsername }],
        password: [{ required: true, trigger: 'blur', validator: validatePassword }]
      },
      loading: false
    }
  },
  methods: {
    handleLogin() {
      this.$refs.loginForm.validate(async valid => {
        if (!valid) return

        this.loading = true
        try {
          await this.$store.dispatch('user/login', this.loginForm)
          await this.$store.dispatch('user/getUserInfo')

          this.$message.success('登录成功')

          // 跳转到redirect参数指定的页面，或首页
          const redirect = this.$route.query.redirect || '/'
          this.$router.push(redirect)
        } catch (error) {
          this.$message.error(error.message || '登录失败')
        } finally {
          this.loading = false
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.login-page {
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
}

.login-container {
  width: 100%;
  max-width: 400px;
}

.login-card {
  background: #fff;
  border-radius: 8px;
  padding: 40px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);

  .login-title {
    font-size: 28px;
    font-weight: bold;
    text-align: center;
    color: #333;
    margin-bottom: 8px;
  }

  .login-subtitle {
    text-align: center;
    color: #999;
    margin-bottom: 30px;
  }

  .login-form {
    margin-top: 20px;
  }

  .login-footer {
    text-align: center;
    font-size: 14px;
    color: #666;
    margin-top: 20px;

    a {
      color: #409eff;
      text-decoration: none;
      margin-left: 5px;

      &:hover {
        text-decoration: underline;
      }
    }
  }
}
</style>
