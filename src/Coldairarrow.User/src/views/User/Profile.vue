<template>
  <div class="profile-container">
    <!-- 背景动态效果 -->
    <div class="background-animation">
      <div class="background-image"></div>
      <div class="particles-container">
        <div class="particle" v-for="n in 30" :key="n"
             :style="{
               left: Math.random() * 100 + '%',
               top: Math.random() * 100 + '%',
               animationDelay: Math.random() * 20 + 's',
               animationDuration: (Math.random() * 10 + 10) + 's'
             }">
        </div>
      </div>
    </div>

    <!-- 页面头部 -->
    <section class="page-header">
      <div class="header-content glass-card">
        <div class="user-profile-header">
          <div class="avatar-section">
            <div class="avatar-wrapper" @click="triggerUpload">
              <img v-if="infoForm.Avatar" :src="infoForm.Avatar" alt="头像" class="avatar-img">
              <div v-else class="avatar-placeholder">
                <i class="el-icon-user"></i>
              </div>
              <div class="avatar-overlay" :class="{ uploading: uploading }">
                <i v-if="uploading" class="el-icon-loading"></i>
                <i v-else class="el-icon-camera"></i>
              </div>
            </div>
            <input
              ref="fileInput"
              type="file"
              accept="image/*"
              style="display: none"
              :disabled="uploading"
              @change="handleFileChange">
          </div>
          <div class="user-info-brief">
            <h1 class="username">{{ infoForm.RealName || infoForm.UserName || '用户' }}</h1>
            <p class="user-intro">{{ infoForm.Introduction || '这个人很懒，什么都没写~' }}</p>
            <div class="user-stats">
              <div class="stat-item">
                <span class="stat-value">{{ userStats.articles }}</span>
                <span class="stat-label">文章</span>
              </div>
              <div class="stat-item">
                <span class="stat-value">{{ userStats.comments }}</span>
                <span class="stat-label">评论</span>
              </div>
              <div class="stat-item">
                <span class="stat-value">{{ userStats.likes }}</span>
                <span class="stat-label">获赞</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 主要内容 -->
    <main class="main-content">
      <div class="content-layout">
        <!-- 左侧菜单 -->
        <aside class="profile-sidebar">
          <div class="sidebar-card glass-card">
            <div class="menu-list">
              <div
                v-for="item in menuItems"
                :key="item.key"
                class="menu-item"
                :class="{ active: activeTab === item.key }"
                @click="activeTab = item.key">
                <i :class="item.icon"></i>
                <span>{{ item.label }}</span>
                <i class="el-icon-arrow-right arrow"></i>
              </div>
            </div>
          </div>
        </aside>

        <!-- 右侧内容 -->
        <div class="profile-main">
          <!-- 基本资料 -->
          <div v-show="activeTab === 'info'" class="content-section glass-card">
            <div class="section-header">
              <h3 class="section-title">
                <i class="el-icon-user"></i>
                基本资料
              </h3>
            </div>
            <el-form ref="infoForm" :model="infoForm" :rules="infoRules" label-width="100px" class="profile-form">
              <el-form-item label="用户名">
                <el-input v-model="infoForm.UserName" disabled prefix-icon="el-icon-user"></el-input>
              </el-form-item>

              <el-form-item label="姓名" prop="RealName">
                <el-input v-model="infoForm.RealName" placeholder="请输入姓名" prefix-icon="el-icon-postcard"></el-input>
              </el-form-item>

              <el-form-item label="性别">
                <el-radio-group v-model="infoForm.Sex" class="sex-radio">
                  <el-radio :label="1">
                    <i class="el-icon-male"></i> 男
                  </el-radio>
                  <el-radio :label="0">
                    <i class="el-icon-female"></i> 女
                  </el-radio>
                </el-radio-group>
              </el-form-item>

              <el-form-item label="生日">
                <el-date-picker
                  v-model="infoForm.Birthday"
                  type="date"
                  placeholder="选择生日"
                  value-format="yyyy-MM-dd"
                  prefix-icon="el-icon-cake"
                  style="width: 100%">
                </el-date-picker>
              </el-form-item>

              <el-form-item label="邮箱" prop="Email">
                <el-input v-model="infoForm.Email" placeholder="请输入邮箱" prefix-icon="el-icon-message"></el-input>
              </el-form-item>

              <el-form-item label="手机号" prop="Phone">
                <el-input v-model="infoForm.Phone" placeholder="请输入手机号" prefix-icon="el-icon-phone"></el-input>
              </el-form-item>

              <el-form-item label="个人简介">
                <el-input
                  v-model="infoForm.Introduction"
                  type="textarea"
                  :rows="4"
                  placeholder="介绍一下自己吧"
                  maxlength="200"
                  show-word-limit>
                </el-input>
              </el-form-item>

              <el-form-item>
                <button type="button" class="save-btn" :disabled="savingInfo" @click="saveInfo">
                  <i v-if="savingInfo" class="el-icon-loading"></i>
                  <i v-else class="el-icon-check"></i>
                  <span>{{ savingInfo ? '保存中...' : '保存修改' }}</span>
                </button>
              </el-form-item>
            </el-form>
          </div>

          <!-- 修改密码 -->
          <div v-show="activeTab === 'password'" class="content-section glass-card">
            <div class="section-header">
              <h3 class="section-title">
                <i class="el-icon-lock"></i>
                修改密码
              </h3>
            </div>
            <el-form
              ref="passwordForm"
              :model="passwordForm"
              :rules="passwordRules"
              label-width="100px"
              class="profile-form password-form">
              <el-form-item label="当前密码" prop="oldPassword">
                <el-input
                  v-model="passwordForm.oldPassword"
                  type="password"
                  placeholder="请输入当前密码"
                  prefix-icon="el-icon-lock"
                  show-password>
                </el-input>
              </el-form-item>

              <el-form-item label="新密码" prop="newPassword">
                <el-input
                  v-model="passwordForm.newPassword"
                  type="password"
                  placeholder="请输入新密码(6-20位)"
                  prefix-icon="el-icon-key"
                  show-password>
                </el-input>
              </el-form-item>

              <el-form-item label="确认密码" prop="confirmPassword">
                <el-input
                  v-model="passwordForm.confirmPassword"
                  type="password"
                  placeholder="请再次输入新密码"
                  prefix-icon="el-icon-key"
                  show-password>
                </el-input>
              </el-form-item>

              <el-form-item>
                <button type="button" class="save-btn" :disabled="savingPwd" @click="savePassword">
                  <i v-if="savingPwd" class="el-icon-loading"></i>
                  <i v-else class="el-icon-check"></i>
                  <span>{{ savingPwd ? '修改中...' : '修改密码' }}</span>
                </button>
              </el-form-item>
            </el-form>
          </div>

          <!-- 账号安全 -->
          <div v-show="activeTab === 'security'" class="content-section glass-card">
            <div class="section-header">
              <h3 class="section-title">
                <i class="el-icon-warning-outline"></i>
                账号安全
              </h3>
            </div>
            <div class="security-list">
              <div class="security-item">
                <div class="security-icon">
                  <i class="el-icon-lock"></i>
                </div>
                <div class="security-info">
                  <div class="security-label">登录密码</div>
                  <div class="security-desc">定期更换密码可以提高账号安全性</div>
                </div>
                <button class="action-btn" @click="activeTab = 'password'">
                  修改
                </button>
              </div>
              <div class="security-item">
                <div class="security-icon">
                  <i class="el-icon-message"></i>
                </div>
                <div class="security-info">
                  <div class="security-label">绑定邮箱</div>
                  <div class="security-desc">
                    <span v-if="infoForm.Email" class="bound">{{ maskEmail(infoForm.Email) }}</span>
                    <span v-else class="unbound">未绑定</span>
                  </div>
                </div>
                <button class="action-btn" @click="activeTab = 'info'">
                  {{ infoForm.Email ? '修改' : '绑定' }}
                </button>
              </div>
              <div class="security-item">
                <div class="security-icon">
                  <i class="el-icon-phone"></i>
                </div>
                <div class="security-info">
                  <div class="security-label">绑定手机</div>
                  <div class="security-desc">
                    <span v-if="infoForm.Phone" class="bound">{{ maskPhone(infoForm.Phone) }}</span>
                    <span v-else class="unbound">未绑定</span>
                  </div>
                </div>
                <button class="action-btn" @click="activeTab = 'info'">
                  {{ infoForm.Phone ? '修改' : '绑定' }}
                </button>
              </div>
              <div class="security-item">
                <div class="security-icon">
                  <i class="el-icon-time"></i>
                </div>
                <div class="security-info">
                  <div class="security-label">上次登录</div>
                  <div class="security-desc">
                    {{ infoForm.LastLoginTime ? formatDate(infoForm.LastLoginTime) : '未知' }}
                    <span v-if="infoForm.LastLoginIP" class="login-ip">{{ infoForm.LastLoginIP }}</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>

    <!-- 底部 -->
    <footer class="blog-footer">
      <div class="footer-content glass-card">
        <div class="footer-left">
          <div class="footer-logo">
            <i class="el-icon-s-home"></i>
            <span>OnlyBlog</span>
          </div>
          <p class="footer-text">&copy; 2025 All rights reserved.</p>
        </div>

        <div class="footer-links">
          <router-link to="/" class="footer-link">首页</router-link>
          <router-link to="/articles" class="footer-link">文章</router-link>
          <router-link to="/archive" class="footer-link">归档</router-link>
          <router-link to="/about" class="footer-link">关于</router-link>
        </div>
      </div>
    </footer>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { updateUserInfo, changePassword, getUserStatistics } from '@/api/user'

// ImgBB API Key
const IMGBB_API_KEY = '024fbd3f3b8fd1a23d15f803fbaa823b'

export default {
  name: 'ProfilePage',
  data() {
    const validateConfirmPassword = (rule, value, callback) => {
      if (value !== this.passwordForm.newPassword) {
        callback(new Error('两次输入的密码不一致'))
      } else {
        callback()
      }
    }
    return {
      activeTab: 'info',
      menuItems: [
        { key: 'info', label: '基本资料', icon: 'el-icon-user' },
        { key: 'password', label: '修改密码', icon: 'el-icon-lock' },
        { key: 'security', label: '账号安全', icon: 'el-icon-warning-outline' }
      ],
      infoForm: {
        Id: '',
        UserName: '',
        RealName: '',
        Sex: 1,
        Birthday: '',
        Email: '',
        Phone: '',
        Avatar: '',
        Introduction: '',
        LastLoginTime: '',
        LastLoginIP: ''
      },
      infoRules: {
        Email: [
          { type: 'email', message: '请输入正确的邮箱格式', trigger: 'blur' }
        ],
        Phone: [
          { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号', trigger: 'blur' }
        ]
      },
      passwordForm: {
        oldPassword: '',
        newPassword: '',
        confirmPassword: ''
      },
      passwordRules: {
        oldPassword: [
          { required: true, message: '请输入当前密码', trigger: 'blur' }
        ],
        newPassword: [
          { required: true, message: '请输入新密码', trigger: 'blur' },
          { min: 6, max: 20, message: '密码长度为6-20位', trigger: 'blur' }
        ],
        confirmPassword: [
          { required: true, message: '请再次输入新密码', trigger: 'blur' },
          { validator: validateConfirmPassword, trigger: 'blur' }
        ]
      },
      savingInfo: false,
      savingPwd: false,
      uploading: false,
      userStats: {
        articles: 0,
        comments: 0,
        likes: 0
      },
      Math: Math
    }
  },
  computed: {
    ...mapGetters('user', ['userInfo'])
  },
  watch: {
    userInfo: {
      immediate: true,
      handler(val) {
        if (val) {
          this.infoForm = { ...this.infoForm, ...val }
          this.loadUserStatistics(val.Id)
        }
      }
    }
  },
  methods: {
    async loadUserStatistics(userId) {
      if (!userId) return
      try {
        const res = await getUserStatistics(userId)
        if (res.Success && res.Data) {
          this.userStats = {
            articles: res.Data.ArticleCount || 0,
            comments: res.Data.CommentCount || 0,
            likes: res.Data.LikeCount || 0
          }
        }
      } catch (error) {
        console.error('获取用户统计数据失败:', error)
      }
    },

    triggerUpload() {
      this.$refs.fileInput.click()
    },

    async handleFileChange(e) {
      const file = e.target.files[0]
      if (!file) return

      if (!file.type.startsWith('image/')) {
        this.$message.error('请选择图片文件')
        return
      }

      if (file.size > 2 * 1024 * 1024) {
        this.$message.error('图片大小不能超过2MB')
        return
      }

      this.uploading = true
      try {
        const url = await this.uploadToImgBB(file)
        if (url) {
          this.infoForm.Avatar = url
          this.$message({ message: '头像上传成功，请保存', type: 'success', duration: 1500 })
        }
      } catch (error) {
        console.error('上传头像失败:', error)
        this.$message.error('上传失败，请重试')
      } finally {
        this.uploading = false
      }

      e.target.value = ''
    },

    uploadToImgBB(file) {
      return new Promise((resolve, reject) => {
        const reader = new FileReader()
        reader.readAsDataURL(file)

        reader.onload = () => {
          const base64String = reader.result.split(',')[1]

          const formData = new FormData()
          formData.append('key', IMGBB_API_KEY)
          formData.append('image', base64String)
          formData.append('name', file.name)

          fetch('https://api.imgbb.com/1/upload', {
            method: 'POST',
            body: formData
          })
            .then(response => response.json())
            .then(result => {
              if (result.success) {
                resolve(result.data.url)
              } else {
                reject(new Error(result.error?.message || '上传失败'))
              }
            })
            .catch(reject)
        }

        reader.onerror = reject
      })
    },

    async saveInfo() {
      try {
        await this.$refs.infoForm.validate()
      } catch {
        return
      }

      this.savingInfo = true
      try {
        await updateUserInfo({
          Id: this.infoForm.Id,
          UserName: this.infoForm.UserName,
          RealName: this.infoForm.RealName,
          Sex: this.infoForm.Sex,
          Birthday: this.infoForm.Birthday,
          Email: this.infoForm.Email,
          Phone: this.infoForm.Phone,
          Avatar: this.infoForm.Avatar,
          Introduction: this.infoForm.Introduction
        })
        this.$message({ message: '保存成功', type: 'success', duration: 1500 })
        this.$store.dispatch('user/getUserInfo')
      } catch (error) {
        console.error('保存失败:', error)
      } finally {
        this.savingInfo = false
      }
    },

    async savePassword() {
      try {
        await this.$refs.passwordForm.validate()
      } catch {
        return
      }

      this.savingPwd = true
      try {
        await changePassword({
          oldPassword: this.passwordForm.oldPassword,
          newPassword: this.passwordForm.newPassword
        })
        this.$message({ message: '密码修改成功', type: 'success', duration: 1500 })
        this.$refs.passwordForm.resetFields()
      } catch (error) {
        console.error('修改密码失败:', error)
      } finally {
        this.savingPwd = false
      }
    },

    maskEmail(email) {
      if (!email) return ''
      const [name, domain] = email.split('@')
      if (name.length <= 2) return email
      return name.substring(0, 2) + '***@' + domain
    },

    maskPhone(phone) {
      if (!phone) return ''
      return phone.substring(0, 3) + '****' + phone.substring(7)
    },

    formatDate(date) {
      if (!date) return ''
      const d = new Date(date)
      const year = d.getFullYear()
      const month = String(d.getMonth() + 1).padStart(2, '0')
      const day = String(d.getDate()).padStart(2, '0')
      const hour = String(d.getHours()).padStart(2, '0')
      const minute = String(d.getMinutes()).padStart(2, '0')
      return `${year}-${month}-${day} ${hour}:${minute}`
    }
  }
}
</script>

<style lang="scss" scoped>
// 样式变量
$primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
$glass-bg: rgba(255, 255, 255, 0.7);
$glass-border: rgba(102, 126, 234, 0.15);
$glass-shadow: 0 8px 32px rgba(102, 126, 234, 0.1);
$text-primary: rgba(51, 51, 51, 0.9);
$text-secondary: rgba(102, 102, 102, 0.8);
$text-muted: rgba(153, 153, 153, 0.7);

// 玻璃态样式
.glass-card {
  background: $glass-bg;
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid $glass-border;
  box-shadow: $glass-shadow;
  border-radius: 16px;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.profile-container {
  min-height: 100vh;
  background: #ffffff;
  position: relative;
  overflow-x: hidden;
}

// 背景动画
.background-animation {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  pointer-events: none;
  z-index: 0;

  .background-image {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.03) 0%, rgba(118, 75, 162, 0.03) 100%);
    z-index: 1;
  }

  .particles-container {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    z-index: 2;

    .particle {
      position: absolute;
      width: 4px;
      height: 4px;
      background: radial-gradient(circle, rgba(102, 126, 234, 0.5) 0%, transparent 70%);
      border-radius: 50%;
      animation: float-particle linear infinite;

      &:nth-child(2n) {
        width: 3px;
        height: 3px;
      }
    }
  }
}

// 页面头部
.page-header {
  position: relative;
  z-index: 10;
  padding: 110px 40px 40px;

  .header-content {
    max-width: 1000px;
    margin: 0 auto;
    padding: 40px;
  }

  .user-profile-header {
    display: flex;
    align-items: center;
    gap: 40px;
  }

  .avatar-section {
    flex-shrink: 0;

    .avatar-wrapper {
      width: 120px;
      height: 120px;
      border-radius: 50%;
      position: relative;
      cursor: pointer;
      overflow: hidden;
      border: 4px solid rgba(102, 126, 234, 0.2);
      transition: all 0.3s;

      &:hover {
        border-color: #667eea;

        .avatar-overlay {
          opacity: 1;
        }
      }

      .avatar-img {
        width: 100%;
        height: 100%;
        object-fit: cover;
      }

      .avatar-placeholder {
        width: 100%;
        height: 100%;
        background: $primary-gradient;
        display: flex;
        align-items: center;
        justify-content: center;

        i {
          font-size: 48px;
          color: white;
        }
      }

      .avatar-overlay {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(0, 0, 0, 0.5);
        display: flex;
        align-items: center;
        justify-content: center;
        opacity: 0;
        transition: opacity 0.3s;

        i {
          font-size: 28px;
          color: white;
        }

        &.uploading {
          opacity: 1;

          i {
            animation: rotate 1s linear infinite;
          }
        }
      }
    }
  }

  .user-info-brief {
    flex: 1;

    .username {
      font-size: 28px;
      font-weight: 700;
      color: $text-primary;
      margin-bottom: 8px;
    }

    .user-intro {
      font-size: 14px;
      color: $text-secondary;
      margin-bottom: 24px;
      line-height: 1.6;
    }

    .user-stats {
      display: flex;
      gap: 48px;

      .stat-item {
        text-align: center;

        .stat-value {
          display: block;
          font-size: 24px;
          font-weight: 700;
          color: $text-primary;
          margin-bottom: 4px;
        }

        .stat-label {
          font-size: 13px;
          color: $text-muted;
        }
      }
    }
  }
}

// 主要内容
.main-content {
  position: relative;
  z-index: 10;
  padding: 0 40px 60px;
}

.content-layout {
  max-width: 1000px;
  margin: 0 auto;
  display: flex;
  gap: 32px;
}

// 侧边栏
.profile-sidebar {
  width: 240px;
  flex-shrink: 0;

  .sidebar-card {
    padding: 16px;
    position: sticky;
    top: 100px;
  }

  .menu-list {
    .menu-item {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 14px 16px;
      border-radius: 10px;
      cursor: pointer;
      color: $text-secondary;
      transition: all 0.3s;

      i:first-child {
        font-size: 18px;
      }

      span {
        flex: 1;
        font-size: 15px;
      }

      .arrow {
        font-size: 12px;
        opacity: 0;
        transform: translateX(-4px);
        transition: all 0.3s;
      }

      &:hover {
        background: rgba(102, 126, 234, 0.08);
        color: #667eea;

        .arrow {
          opacity: 0.5;
          transform: translateX(0);
        }
      }

      &.active {
        background: $primary-gradient;
        color: white;

        .arrow {
          opacity: 1;
          transform: translateX(0);
        }
      }
    }
  }
}

// 主内容区
.profile-main {
  flex: 1;
  min-width: 0;
}

.content-section {
  padding: 32px;

  .section-header {
    margin-bottom: 32px;
    padding-bottom: 16px;
    border-bottom: 1px solid rgba(0, 0, 0, 0.06);

    .section-title {
      font-size: 18px;
      font-weight: 600;
      color: $text-primary;
      display: flex;
      align-items: center;
      gap: 10px;

      i {
        color: #667eea;
        font-size: 20px;
      }
    }
  }
}

// 表单样式
.profile-form {
  max-width: 500px;

  ::v-deep .el-form-item__label {
    color: $text-secondary;
    font-weight: 500;
  }

  ::v-deep .el-input__inner {
    border-radius: 10px;
    border-color: $glass-border;
    transition: all 0.3s;

    &:focus {
      border-color: #667eea;
      box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
    }
  }

  ::v-deep .el-textarea__inner {
    border-radius: 10px;
    border-color: $glass-border;
    transition: all 0.3s;

    &:focus {
      border-color: #667eea;
      box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
    }
  }

  ::v-deep .el-radio__input.is-checked .el-radio__inner {
    background: #667eea;
    border-color: #667eea;
  }

  ::v-deep .el-radio__input.is-checked + .el-radio__label {
    color: #667eea;
  }

  .sex-radio {
    ::v-deep .el-radio {
      margin-right: 30px;
    }
  }

  .save-btn {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 12px 32px;
    background: $primary-gradient;
    color: white;
    border: none;
    border-radius: 10px;
    font-size: 15px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.3s;

    &:hover:not(:disabled) {
      transform: translateY(-2px);
      box-shadow: 0 8px 24px rgba(102, 126, 234, 0.4);
    }

    &:disabled {
      opacity: 0.7;
      cursor: not-allowed;
    }

    i {
      font-size: 16px;
    }
  }
}

.password-form {
  max-width: 400px;
}

// 安全设置
.security-list {
  .security-item {
    display: flex;
    align-items: center;
    gap: 20px;
    padding: 24px 0;
    border-bottom: 1px solid rgba(0, 0, 0, 0.04);

    &:last-child {
      border-bottom: none;
    }

    .security-icon {
      width: 48px;
      height: 48px;
      background: rgba(102, 126, 234, 0.1);
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;

      i {
        font-size: 22px;
        color: #667eea;
      }
    }

    .security-info {
      flex: 1;

      .security-label {
        font-size: 15px;
        font-weight: 500;
        color: $text-primary;
        margin-bottom: 4px;
      }

      .security-desc {
        font-size: 13px;
        color: $text-muted;

        .bound {
          color: #67c23a;
        }

        .unbound {
          color: #f56c6c;
        }

        .login-ip {
          margin-left: 8px;
          padding: 2px 8px;
          background: rgba(0, 0, 0, 0.04);
          border-radius: 4px;
          font-size: 12px;
        }
      }
    }

    .action-btn {
      padding: 8px 20px;
      background: rgba(102, 126, 234, 0.1);
      color: #667eea;
      border: none;
      border-radius: 8px;
      font-size: 14px;
      cursor: pointer;
      transition: all 0.3s;

      &:hover {
        background: #667eea;
        color: white;
      }
    }
  }
}

// 底部
.blog-footer {
  padding: 40px;
  margin-top: 40px;
  position: relative;
  z-index: 10;

  .footer-content {
    max-width: 1000px;
    margin: 0 auto;
    padding: 24px 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .footer-left {
    .footer-logo {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 18px;
      font-weight: 600;
      color: $text-primary;
      margin-bottom: 8px;

      i {
        font-size: 20px;
        color: #667eea;
      }
    }

    .footer-text {
      font-size: 14px;
      color: $text-secondary;
      margin: 0;
    }
  }

  .footer-links {
    display: flex;
    gap: 32px;

    .footer-link {
      font-size: 14px;
      color: $text-secondary;
      text-decoration: none;
      transition: color 0.3s ease;

      &:hover {
        color: #667eea;
      }
    }
  }
}

// 动画
@keyframes float-particle {
  0% {
    transform: translateY(100vh) translateX(0px);
    opacity: 0;
  }
  10% {
    opacity: 1;
  }
  90% {
    opacity: 1;
  }
  100% {
    transform: translateY(-100px) translateX(50px);
    opacity: 0;
  }
}

@keyframes rotate {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

// 响应式设计
@media (max-width: 900px) {
  .content-layout {
    flex-direction: column;
  }

  .profile-sidebar {
    width: 100%;

    .sidebar-card {
      position: static;
    }

    .menu-list {
      display: flex;
      overflow-x: auto;
      gap: 8px;

      .menu-item {
        flex-shrink: 0;
        padding: 12px 20px;

        .arrow {
          display: none;
        }
      }
    }
  }
}

@media (max-width: 768px) {
  .page-header {
    padding: 90px 20px 30px;

    .header-content {
      padding: 24px;
    }

    .user-profile-header {
      flex-direction: column;
      text-align: center;
      gap: 24px;
    }

    .user-info-brief {
      .user-stats {
        justify-content: center;
      }
    }
  }

  .main-content {
    padding: 0 20px 40px;
  }

  .content-section {
    padding: 24px;
  }

  .profile-form {
    max-width: 100%;

    ::v-deep .el-form-item__label {
      float: none;
      text-align: left;
    }
  }

  .security-list .security-item {
    flex-wrap: wrap;
    gap: 16px;

    .action-btn {
      width: 100%;
      text-align: center;
    }
  }

  .footer-content {
    padding: 24px 20px;
    flex-direction: column;
    gap: 20px;
    text-align: center;
  }
}
</style>
