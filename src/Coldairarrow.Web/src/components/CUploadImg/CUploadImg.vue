<template>
  <div class="clearfix">
    <a-upload :customRequest="handleCustomRequest" :beforeUpload="beforeUpload" listType="picture-card"
      :fileList="fileList" @preview="handlePreview" @change="handleChange" accept="image/*" :multiple="this.multiple()">
      <div v-if="fileList.length < maxCount">
        <a-icon type="plus" />
        <div class="ant-upload-text">选择</div>
      </div>
    </a-upload>
    <a-modal :visible="previewVisible" :footer="null" @cancel="handleCancel">
      <img alt="example" style="width: 100%" :src="previewImage" />
    </a-modal>
  </div>
</template>

<script>
import TypeHelper from '@/utils/helper/TypeHelper'
import TokenCache from '@/utils/cache/TokenCache'
const uuid = require('uuid')

export default {
  props: {
    value: {},
    maxCount: {
      type: Number,
      default: 1
    }
  },
  data() {
    return {
      previewVisible: false,
      previewImage: '',
      fileList: [],
      internelValue: null,  //改为 null
      headers: { Authorization: 'Bearer ' + TokenCache.getToken() },
      imgbbApiKey: '024fbd3f3b8fd1a23d15f803fbaa823b'
    }
  },
  mounted() {
    this.refresh(this.value)
  },
  watch: {
    value(val) {
      // 内部触发事件不处理,仅回传数据
      if (val === this.internelValue) {
        return
      }
      //不直接修改 prop，传参给 refresh
      this.refresh(val)
    }
  },
  methods: {
    multiple() {
      return this.maxCount > 1
    },

    checkType(val) {
      if (this.maxCount == 1 && TypeHelper.isArray(val)) {
        throw 'maxCount=1时model不能为Array'
      }
      if (this.maxCount > 1 && !TypeHelper.isArray(val)) {
        throw 'maxCount>1时model必须为Array<String>'
      }
    },

    //使用传入的参数 val，而不是 this.value
    refresh(val) {
      if (this.maxCount < 1) {
        throw 'maxCount必须>=1'
      }

      //使用局部变量
      let currentValue = val

      // 初始化默认值
      if (currentValue === null || currentValue === undefined) {
        currentValue = this.maxCount === 1 ? '' : []
      }

      this.checkType(currentValue)

      //使用 currentValue 而不是 this.value
      if (currentValue) {
        const urls = []
        if (TypeHelper.isString(currentValue)) {
          urls.push(currentValue)
        } else if (TypeHelper.isArray(currentValue)) {
          urls.push(...currentValue)
        } else {
          throw 'value必须为字符串或数组'
        }

        this.fileList = urls
          .filter(x => x)
          .map(x => {
            return { name: x, uid: uuid.v4(), status: 'done', url: x }
          })
      } else {
        this.fileList = []
      }
    },

    //添加 return false 阻止自动上传
    beforeUpload(file) {
      const isImage = file.type.startsWith('image/')
      if (!isImage) {
        this.$message.error('只能上传图片文件！')
        return false
      }

      const isLt32M = file.size / 1024 / 1024 < 32
      if (!isLt32M) {
        this.$message.error('图片大小不能超过32MB！')
        return false
      }

      //返回 false 阻止自动上传
      return false
    },

    // 自定义上传（不会被触发，但需要定义）
    handleCustomRequest(options) {
      // 这个方法不会被触发，但需要定义防止报错
    },

    handleCancel() {
      this.previewVisible = false
    },

    handlePreview(file) {
      if (file.originFileObj) {
        const reader = new FileReader()
        reader.readAsDataURL(file.originFileObj)
        reader.onload = () => {
          this.previewImage = reader.result
          this.previewVisible = true
        }
      } else {
        this.previewImage = file.url || file.thumbUrl
        this.previewVisible = true
      }
    },

    handleChange({ file, fileList }) {
      this.fileList = fileList

      // 移除文件时更新 value
      if (file.status === 'removed') {
        const urls = this.fileList
          .filter(x => x.status === 'done')
          .map(x => x.url)

        const newValue = this.maxCount === 1 ? (urls[0] || '') : urls
        this.internelValue = newValue
        this.$emit('input', newValue)
      }
    },

    async uploadAllFiles() {
      const filesToUpload = this.fileList.filter(x => !x.url && x.originFileObj)
      if (filesToUpload.length === 0) {
        return this.getCurrentValue()
      }

      try {
        // 并行上传所有图片
        const uploadPromises = filesToUpload.map(fileItem =>
          this.uploadSingleFile(fileItem)
        )
        const results = await Promise.all(uploadPromises)
        // 更新 fileList 中的 URL
        results.forEach(({ uid, url }) => {
          const fileItem = this.fileList.find(x => x.uid === uid)
          if (fileItem) {
            fileItem.url = url
            fileItem.status = 'done'
          }
        })

        // 返回最终的 URL
        return this.getCurrentValue()
      } catch (error) {
        this.$message.error('图片上传失败：' + error.message)
        throw error
      }
    },

    // 上传单个文件到 ImgBB
    uploadSingleFile(fileItem) {
      return new Promise((resolve, reject) => {
        if (!fileItem || !fileItem.originFileObj) {
          reject(new Error('无效的文件对象'))
          return
        }
        const file = fileItem.originFileObj
        // 读取文件为 Base64
        const reader = new FileReader()
        reader.readAsDataURL(file)

        reader.onload = () => {
          const base64String = reader.result.split(',')[1]

          // 构造表单数据
          const formData = new FormData()
          formData.append('key', this.imgbbApiKey)
          formData.append('image', base64String)
          formData.append('name', file.name)
          // 上传到 ImgBB
          fetch('https://api.imgbb.com/1/upload', {
            method: 'POST',
            body: formData
          })
            .then(response => response.json())
            .then(result => {
              console.log('ImgBB 响应:', result)

              if (result.success) {
                const imageUrl = result.data.url
                resolve({ uid: fileItem.uid, url: imageUrl })
              } else {
                const errorMsg = result.error && result.error.message
                  ? result.error.message
                  : '上传失败'
                this.$message.error(errorMsg)
                reject(new Error(errorMsg))
              }
            })
            .catch(error => {
              this.$message.error('上传失败：' + error.message)
              reject(error)
            })
        }

        reader.onerror = (error) => {
          this.$message.error('文件读取失败：' + error.message)
          reject(error)
        }
      })
    },

    // 获取当前值（所有已上传的图片URL）
    getCurrentValue() {
      const urls = this.fileList
        .filter(x => x.status === 'done' && x.url)
        .map(x => x.url)

      const newValue = this.maxCount === 1 ? (urls[0] || '') : urls
      this.internelValue = newValue
      this.$emit('input', newValue)

      console.log('getCurrentValue 返回:', newValue)
      return newValue
    }
  }
}
</script>

<style>
.ant-upload-select-picture-card i {
  font-size: 32px;
  color: #999;
}

.ant-upload-select-picture-card .ant-upload-text {
  margin-top: 8px;
  color: #666;
}
</style>
