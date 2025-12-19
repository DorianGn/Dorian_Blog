<template>
  <div class="profile-page">
    <div class="page-header">
      <h1 class="page-title">个人中心</h1>
    </div>

    <div class="main-container">
      <div class="profile-layout">
        <!-- 左侧菜单 -->
        <div class="profile-menu">
          <div
            v-for="item in menuItems"
            :key="item.key"
            class="menu-item"
            :class="{ active: activeTab === item.key }"
            @click="activeTab = item.key">
            <i :class="item.icon"></i>
            <span>{{ item.label }}</span>
          </div>
        </div>

        <!-- 右侧内容 -->
        <div class="profile-content">
          <!-- 基本资料 -->
          <div v-show="activeTab === 'info'" class="content-section">
            <h3 class="section-title">基本资料</h3>
            <el-form ref="infoForm" :model="infoForm" :rules="infoRules" label-width="80px">
              <el-form-item label="头像">
                <div class="avatar-uploader">
                  <div class="avatar-preview" :class="{ uploading: uploading }" @click="triggerUpload">
                    <img v-if="infoForm.Avatar" :src="infoForm.Avatar" alt="头像">
                    <i v-else class="el-icon-plus"></i>
                    <div class="avatar-overlay">
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
                  <p class="avatar-tip">点击更换头像，支持 jpg、png 格式</p>
                </div>
              </el-form-item>

              <el-form-item label="用户名">
                <el-input v-model="infoForm.UserName" disabled></el-input>
              </el-form-item>

              <el-form-item label="姓名" prop="RealName">
                <el-input v-model="infoForm.RealName" placeholder="请输入姓名"></el-input>
              </el-form-item>

              <el-form-item label="性别">
                <el-radio-group v-model="infoForm.Sex">
                  <el-radio :label="1">男</el-radio>
                  <el-radio :label="0">女</el-radio>
                </el-radio-group>
              </el-form-item>

              <el-form-item label="生日">
                <el-date-picker
                  v-model="infoForm.Birthday"
                  type="date"
                  placeholder="选择生日"
                  value-format="yyyy-MM-dd"
                  style="width: 100%">
                </el-date-picker>
              </el-form-item>

              <el-form-item label="邮箱" prop="Email">
                <el-input v-model="infoForm.Email" placeholder="请输入邮箱"></el-input>
              </el-form-item>

              <el-form-item label="手机号" prop="Phone">
                <el-input v-model="infoForm.Phone" placeholder="请输入手机号"></el-input>
              </el-form-item>

              <el-form-item label="个人简介">
                <el-input
                  v-model="infoForm.Introduction"
                  type="textarea"
                  :rows="3"
                  placeholder="介绍一下自己吧"
                  maxlength="200"
                  show-word-limit>
                </el-input>
              </el-form-item>

              <el-form-item>
                <el-button type="primary" :loading="savingInfo" @click="saveInfo">
                  保存修改
                </el-button>
              </el-form-item>
            </el-form>
          </div>

          <!-- 修改密码 -->
          <div v-show="activeTab === 'password'" class="content-section">
            <h3 class="section-title">修改密码</h3>
            <el-form
              ref="passwordForm"
              :model="passwordForm"
              :rules="passwordRules"
              label-width="100px"
              style="max-width: 400px">
              <el-form-item label="当前密码" prop="oldPassword">
                <el-input
                  v-model="passwordForm.oldPassword"
                  type="password"
                  placeholder="请输入当前密码"
                  show-password>
                </el-input>
              </el-form-item>

              <el-form-item label="新密码" prop="newPassword">
                <el-input
                  v-model="passwordForm.newPassword"
                  type="password"
                  placeholder="请输入新密码"
                  show-password>
                </el-input>
              </el-form-item>

              <el-form-item label="确认新密码" prop="confirmPassword">
                <el-input
                  v-model="passwordForm.confirmPassword"
                  type="password"
                  placeholder="请再次输入新密码"
                  show-password>
                </el-input>
              </el-form-item>

              <el-form-item>
                <el-button type="primary" :loading="savingPwd" @click="savePassword">
                  修改密码
                </el-button>
              </el-form-item>
            </el-form>
          </div>

          <!-- 账号安全 -->
          <div v-show="activeTab === 'security'" class="content-section">
            <h3 class="section-title">账号安全</h3>
            <div class="security-list">
              <div class="security-item">
                <div class="security-info">
                  <div class="security-label">登录密码</div>
                  <div class="security-desc">定期更换密码可以提高账号安全性</div>
                </div>
                <el-button size="small" @click="activeTab = 'password'">修改</el-button>
              </div>
              <div class="security-item">
                <div class="security-info">
                  <div class="security-label">绑定邮箱</div>
                  <div class="security-desc">{{ infoForm.Email || '未绑定' }}</div>
                </div>
                <el-button size="small" @click="activeTab = 'info'">修改</el-button>
              </div>
              <div class="security-item">
                <div class="security-info">
                  <div class="security-label">绑定手机</div>
                  <div class="security-desc">{{ infoForm.Phone || '未绑定' }}</div>
                </div>
                <el-button size="small" @click="activeTab = 'info'">修改</el-button>
              </div>
              <div class="security-item">
                <div class="security-info">
                  <div class="security-label">上次登录</div>
                  <div class="security-desc">
                    {{ infoForm.LastLoginTime ? formatDate(infoForm.LastLoginTime) : '未知' }}
                    {{ infoForm.LastLoginIP ? `(${infoForm.LastLoginIP})` : '' }}
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { updateUserInfo, changePassword } from '@/api/user'

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
        { key: 'security', label: '账号安全', icon: 'el-icon-shield' }
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
      uploading: false
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
        }
      }
    }
  },
  methods: {
    triggerUpload() {
      this.$refs.fileInput.click()
    },

    async handleFileChange(e) {
      const file = e.target.files[0]
      if (!file) return

      // 验证文件类型
      if (!file.type.startsWith('image/')) {
        this.$message.error('请选择图片文件')
        return
      }

      // 验证文件大小 (2MB)
      if (file.size > 2 * 1024 * 1024) {
        this.$message.error('图片大小不能超过2MB')
        return
      }

      this.uploading = true
      try {
        const url = await this.uploadToImgBB(file)
        if (url) {
          this.infoForm.Avatar = url
          this.$message.success('头像上传成功')
        }
      } catch (error) {
        console.error('上传头像失败:', error)
        this.$message.error('上传失败，请重试')
      } finally {
        this.uploading = false
      }

      // 清空 input
      e.target.value = ''
    },

    // 上传图片到 ImgBB
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
        this.$message.success('保存成功')
        // 刷新用户信息
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
        this.$message.success('密码修改成功')
        this.$refs.passwordForm.resetFields()
      } catch (error) {
        console.error('修改密码失败:', error)
      } finally {
        this.savingPwd = false
      }
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
.profile-page {
  min-height: 100vh;
  background: #fafafa;
}

.page-header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 60px 20px;
  text-align: center;
  color: #fff;

  .page-title {
    font-size: 32px;
    font-weight: 500;
  }
}

.main-container {
  max-width: 1000px;
  margin: 0 auto;
  padding: 30px 20px;
}

.profile-layout {
  display: flex;
  gap: 24px;
  background: #fff;
  border-radius: 8px;
  overflow: hidden;
  min-height: 500px;
}

// 左侧菜单
.profile-menu {
  width: 200px;
  background: #f9f9f9;
  padding: 20px 0;
  flex-shrink: 0;

  .menu-item {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 14px 24px;
    cursor: pointer;
    color: #666;
    transition: all 0.2s;

    i {
      font-size: 18px;
    }

    &:hover {
      color: #667eea;
      background: #f0f0f0;
    }

    &.active {
      color: #667eea;
      background: #fff;
      border-right: 3px solid #667eea;
    }
  }
}

// 右侧内容
.profile-content {
  flex: 1;
  padding: 30px;
}

.content-section {
  .section-title {
    font-size: 18px;
    font-weight: 500;
    color: #333;
    margin-bottom: 24px;
    padding-bottom: 12px;
    border-bottom: 1px solid #eee;
  }
}

// 头像上传
.avatar-uploader {
  .avatar-preview {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    background: #f5f5f5;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    position: relative;
    overflow: hidden;
    border: 2px dashed #ddd;
    transition: all 0.2s;

    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .el-icon-plus {
      font-size: 28px;
      color: #999;
    }

    .avatar-overlay {
      position: absolute;
      inset: 0;
      background: rgba(0, 0, 0, 0.5);
      display: flex;
      align-items: center;
      justify-content: center;
      opacity: 0;
      transition: opacity 0.2s;

      i {
        font-size: 24px;
        color: #fff;
      }
    }

    &:hover {
      border-color: #667eea;

      .avatar-overlay {
        opacity: 1;
      }
    }

    &.uploading {
      pointer-events: none;

      .avatar-overlay {
        opacity: 1;
        background: rgba(0, 0, 0, 0.6);
      }

      .el-icon-loading {
        animation: rotating 1s linear infinite;
      }
    }
  }

  .avatar-tip {
    margin-top: 10px;
    font-size: 12px;
    color: #999;
  }
}

@keyframes rotating {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

// 安全设置
.security-list {
  .security-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 20px 0;
    border-bottom: 1px solid #f0f0f0;

    &:last-child {
      border-bottom: none;
    }
  }

  .security-info {
    .security-label {
      font-size: 15px;
      color: #333;
      margin-bottom: 6px;
    }

    .security-desc {
      font-size: 13px;
      color: #999;
    }
  }
}

// 响应式
@media (max-width: 768px) {
  .page-header {
    padding: 40px 20px;

    .page-title {
      font-size: 24px;
    }
  }

  .profile-layout {
    flex-direction: column;
  }

  .profile-menu {
    width: 100%;
    display: flex;
    overflow-x: auto;
    padding: 0;

    .menu-item {
      padding: 16px 20px;
      white-space: nowrap;
      border-right: none;

      &.active {
        border-right: none;
        border-bottom: 3px solid #667eea;
      }
    }
  }

  .profile-content {
    padding: 20px;
  }
}
</style>
