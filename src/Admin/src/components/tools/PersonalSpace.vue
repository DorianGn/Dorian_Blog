<template>
  <div class="user-profile-container">
    <div class="profile-wrapper">
      <a-row :gutter="60">
        <!-- 左侧：头像和用户信息 -->
        <a-col :xs="24" :sm="24" :md="8">
          <div class="user-info-section">
            <!-- 头像 -->
            <div class="avatar-wrapper">
              <a-avatar :size="160" :src="userInfo.avatar" icon="user" />
            </div>

            <!-- 用户名 -->
            <div class="username">{{ userInfo.userName }}</div>

            <!-- 注册日期 -->
            <div class="register-date">
              注册日期：{{ userInfo.registerDate }}
            </div>

            <!-- 操作按钮 -->
            <div class="action-buttons">
              <a-button @click="handleChangePassword">修改密码</a-button>
              <a-button type="primary" ghost @click="handleUploadAvatar">
                修改头像
              </a-button>
            </div>
          </div>
        </a-col>

        <!-- 右侧：编辑表单 -->
        <a-col :xs="24" :sm="24" :md="16">
          <div class="form-section">
            <a-form :form="form" :label-col="{ span: 4 }" :wrapper-col="{ span: 20 }">
              <!-- 账号 -->
              <a-form-item label="账号">
                <a-input
                  v-decorator="['account', { initialValue: userInfo.userName }]"
                  placeholder="账号"
                  disabled
                />
              </a-form-item>

              <!-- 姓名 -->
              <a-form-item label="姓名">
                <a-input
                  v-decorator="[
                    'realName',
                    {
                      initialValue: userInfo.realName,
                      rules: [{ required: true, message: '请输入姓名' }]
                    }
                  ]"
                  placeholder="请输入姓名"
                />
              </a-form-item>

              <!-- 性别 -->
              <a-form-item label="性别">
                <a-select
                  v-decorator="['sex', { initialValue: userInfo.sex }]"
                  placeholder="请选择性别"
                >
                  <a-select-option value="男">男</a-select-option>
                  <a-select-option value="女">女</a-select-option>
                </a-select>
              </a-form-item>

              <!-- 备注 -->
              <a-form-item label="备注">
                <a-textarea
                  v-decorator="['remark', { initialValue: userInfo.remark }]"
                  placeholder="请输入备注"
                  :rows="4"
                />
              </a-form-item>

              <!-- 保存按钮 -->
              <a-form-item :wrapper-col="{ span: 20, offset: 4 }">
                <a-button type="primary" @click="handleSubmit" :loading="loading">
                  保存
                </a-button>
              </a-form-item>
            </a-form>
          </div>
        </a-col>
      </a-row>
    </div>

    <!-- 修改密码弹窗组件 -->
    <change-pwd-modal ref="changePwdModal" @success="handlePasswordSuccess" />

    <!-- 修改头像弹窗 -->
    <a-modal
      title="修改头像"
      :visible="avatarModalVisible"
      @ok="handleAvatarSubmit"
      @cancel="avatarModalVisible = false"
      okText="确定"
      cancelText="取消"
    >
      <div class="upload-avatar-wrapper">
        <a-upload
          name="avatar"
          list-type="picture-card"
          class="avatar-uploader"
          :show-upload-list="false"
          :before-upload="beforeUpload"
          :customRequest="customUpload"
        >
          <img v-if="imageUrl" :src="imageUrl" alt="avatar" style="width: 100%" />
          <div v-else>
            <a-icon :type="uploadLoading ? 'loading' : 'plus'" />
            <div class="ant-upload-text">上传头像</div>
          </div>
        </a-upload>
      </div>
    </a-modal>
  </div>
</template>

<script>
import ChangePwdModal from '@/components/tools/ChangePwdForm.vue'

export default {
  name: 'UserProfile',
  components: {
    ChangePwdModal
  },
  data() {
    return {
      form: this.$form.createForm(this),
      loading: false,
      avatarModalVisible: false,
      uploadLoading: false,
      imageUrl: '',
      userInfo: {
        userName: 'zhangshuai',
        realName: '张帅',
        sex: '男',
        remark: '备注',
        registerDate: '2025-07-23 10:15:26',
        avatar: 'https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png'
      }
    }
  },
  mounted() {
    this.getUserInfo()
  },
  methods: {
    // 获取用户信息
    getUserInfo() {
      // 调用后端接口获取用户信息
      // this.$http.get('/Base_Manage/Home/GetUserInfo').then(resJson => {
      //   if (resJson.Success) {
      //     this.userInfo = resJson.Data
      //   }
      // })
      console.log('获取用户信息')
    },

    // 提交表单
    handleSubmit() {
      this.form.validateFields((err, values) => {
        if (err) return

        this.loading = true
        console.log('提交的数据：', values)

        // 调用后端接口
        this.$http.post('/Base_Manage/Home/SaveUserInfo', values)
          .then(resJson => {
            if (resJson.Success) {
              this.$message.success('保存成功')
              this.getUserInfo()
            } else {
              this.$message.error(resJson.Msg || '保存失败')
            }
          })
          .catch(err => {
            this.$message.error('网络错误，请稍后重试')
          })
          .finally(() => {
            this.loading = false
          })
      })
    },

    // 打开修改密码弹窗
    handleChangePassword() {
      this.$refs.changePwdModal.open()
    },

    // 修改密码成功回调
    handlePasswordSuccess() {
      console.log('密码修改成功')
      // 可以在这里执行其他操作，比如退出登录
    },

    // 打开上传头像弹窗
    handleUploadAvatar() {
      this.avatarModalVisible = true
      this.imageUrl = this.userInfo.avatar
    },

    // 上传前验证
    beforeUpload(file) {
      const isJpgOrPng = file.type === 'image/jpeg' || file.type === 'image/png'
      if (!isJpgOrPng) {
        this.$message.error('只能上传 JPG/PNG 格式的图片')
        return false
      }
      const isLt2M = file.size / 1024 / 1024 < 2
      if (!isLt2M) {
        this.$message.error('图片大小不能超过 2MB')
        return false
      }
      return true
    },

    // 自定义上传
    customUpload({ file }) {
      this.uploadLoading = true
      
      // 方法1：转为 base64 预览
      this.getBase64(file, imageUrl => {
        this.imageUrl = imageUrl
        this.uploadLoading = false
      })

      // 方法2：上传到服务器（推荐）
      // const formData = new FormData()
      // formData.append('file', file)
      // this.$http.post('/Base_Manage/Home/UploadAvatar', formData)
      //   .then(resJson => {
      //     if (resJson.Success) {
      //       this.imageUrl = resJson.Data.url
      //     } else {
      //       this.$message.error(resJson.Msg || '上传失败')
      //     }
      //   })
      //   .finally(() => {
      //     this.uploadLoading = false
      //   })
    },

    // 提交头像
    handleAvatarSubmit() {
      if (!this.imageUrl) {
        this.$message.warning('请先上传头像')
        return
      }

      // 调用后端接口
      this.$http.post('/Base_Manage/Home/SaveAvatar', { avatar: this.imageUrl })
        .then(resJson => {
          if (resJson.Success) {
            this.$message.success('头像修改成功')
            this.userInfo.avatar = this.imageUrl
            this.avatarModalVisible = false
          } else {
            this.$message.error(resJson.Msg || '头像修改失败')
          }
        })
    },

    // 将文件转为 base64
    getBase64(img, callback) {
      const reader = new FileReader()
      reader.addEventListener('load', () => callback(reader.result))
      reader.readAsDataURL(img)
    }
  }
}
</script>

<style lang="less" scoped>
.user-profile-container {
  min-height: 100vh;
  background: #f0f2f5;
  padding: 40px 20px;
}

.profile-wrapper {
  max-width: 1200px;
  margin: 0 auto;
  background: white;
  padding: 40px;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

// 左侧用户信息
.user-info-section {
  text-align: center;
  padding: 20px;

  .avatar-wrapper {
    margin-bottom: 20px;

    :deep(.ant-avatar) {
      border: 3px solid #f0f0f0;
    }
  }

  .username {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin-bottom: 12px;
  }

  .register-date {
    font-size: 14px;
    color: #999;
    margin-bottom: 30px;
  }

  .action-buttons {
    display: flex;
    gap: 12px;
    justify-content: center;

    .ant-btn {
      flex: 1;
    }
  }
}

// 右侧表单
.form-section {
  padding: 20px 40px;

  :deep(.ant-form-item-label) {
    text-align: right;
    font-weight: 500;
  }

  :deep(.ant-input),
  :deep(.ant-select),
  :deep(.ant-input-textarea) {
    border-radius: 4px;
  }

  :deep(.ant-btn-primary) {
    width: 120px;
    height: 40px;
    font-size: 16px;
  }
}

// 上传头像样式
.upload-avatar-wrapper {
  display: flex;
  justify-content: center;
  padding: 20px;

  :deep(.avatar-uploader) {
    .ant-upload {
      width: 200px;
      height: 200px;
    }
  }
}

// 响应式
@media (max-width: 768px) {
  .profile-wrapper {
    padding: 20px;
  }

  .form-section {
    padding: 20px 0;
  }

  .user-info-section {
    margin-bottom: 20px;
  }
}
</style>
