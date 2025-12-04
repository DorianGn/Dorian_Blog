<template>
  <a-modal :title="title" width="50%" :visible="visible" :confirmLoading="loading" @ok="handleSubmit"
    :bodyStyle="{ maxHeight: '70vh', overflowY: 'auto' }" @cancel="() => { this.visible = false }" :maskClosable="false"
    :destroyOnClose="true">
    <template slot="footer">
      <a-button @click="handleCancel">取消</a-button>
      <a-button type="primary" :loading="loading" @click="handleSubmit">确定</a-button>
    </template>
    <a-spin :spinning="loading">
      <a-form-model ref="form" :model="entity" :rules="rules" v-bind="layout" style="padding: 20px 0;">
        <a-form-model-item label="标签名称" prop="Name">
          <a-input v-model="entity.Name" autocomplete="off" placeholder="请输入标签名称" :maxLength="20" allowClear />
        </a-form-model-item>

        <a-form-model-item label="标签颜色" prop="Color">
          <div style="display: flex; align-items: center; gap: 10px;">
            <a-input v-model="entity.Color" autocomplete="off" placeholder="请选择或输入颜色值" style="flex: 1" allowClear />
            <a-popover trigger="click" v-model="colorPickerVisible" placement="bottomRight"
              overlayClassName="color-picker-popover">
              <div slot="content">
                <sketch-picker v-model="colorValue" @input="handleColorChange" />
              </div>
              <a-tooltip title="点击选择颜色">
                <div :style="{
                  width: '40px',
                  height: '32px',
                  backgroundColor: entity.Color || '#1890ff',
                  cursor: 'pointer',
                  border: '1px solid #d9d9d9',
                  borderRadius: '4px',
                  boxShadow: '0 2px 4px rgba(0,0,0,0.1)',
                  transition: 'all 0.3s'
                }" class="color-block"></div>
              </a-tooltip>
            </a-popover>
          </div>
          <div style="color: #999; font-size: 12px; margin-top: 4px;">
            <a-icon type="info-circle" /> 选择一个有代表性的颜色，将在标签展示时使用
          </div>
        </a-form-model-item>

        <a-form-model-item label="文章数量" prop="ArticleCount">
          <a-input v-model="entity.ArticleCount" autocomplete="off" placeholder="请输入该标签下的文章数量" type="number" :min="0" />
          <div style="color: #999; font-size: 12px; margin-top: 4px;">
            <a-icon type="info-circle" /> 输入使用该标签的文章数量
          </div>
        </a-form-model-item>
        <a-form-model-item label="是否删除" prop="IsDeleted">
          <a-select v-model="entity.IsDeleted" autocomplete="off" placeholder="请选择是否删除">
            <a-select-option :value="0">否</a-select-option>
            <a-select-option :value="1">是</a-select-option>
          </a-select>
        </a-form-model-item>
      </a-form-model>
    </a-spin>
  </a-modal>
</template>

<script>
import { Sketch } from 'vue-color'

export default {
  components: {
    'sketch-picker': Sketch
  },
  data() {
    return {
      layout: {
        labelCol: { span: 5 },
        wrapperCol: { span: 18 }
      },
      visible: false,
      loading: false,
      entity: {},
      rules: {
        Name: [
          { required: true, message: '请输入标签名称', trigger: 'blur' },
          { min: 1, max: 20, message: '标签名称长度在 1 到 20 个字符', trigger: 'blur' }
        ],
        Color: [{ required: true, message: '请选择标签颜色', trigger: 'blur' }],
        ArticleCount: [{ required: true, message: '请输入该标签下的文章数量', trigger: 'blur' }]
      },
      title: '',
      colorPickerVisible: false,
      colorValue: {
        hex: '#1890ff'
      }
    }
  },
  methods: {
    init() {
      this.visible = true
      this.entity = {}
      this.colorPickerVisible = false
      this.$nextTick(() => {
        this.$refs['form'].clearValidate()
      })
    },
    openForm(id, title) {
      this.init()
      this.title = title
      if (id) {
        this.loading = true
        this.$http.post('/Blog_Manage/blog_tag/GetTheData', { id: id }).then(resJson => {
          this.loading = false
          this.entity = resJson.Data
          if (this.entity.Color) {
            this.colorValue = { hex: this.entity.Color }
          }
        })
      }
    },
    handleColorChange(color) {
      this.entity.Color = color.hex
    },
    handleCancel() {
      this.visible = false
      this.$refs['form'].resetFields()
    },
    handleColorChange(color) {
      this.entity.Color = color.hex
    },
    handleSubmit() {
      this.$refs['form'].validate(valid => {
        if (!valid) {
          return
        }
        this.loading = true
        this.$http.post('/Blog_Manage/blog_tag/SaveData', this.entity).then(resJson => {
          this.loading = false
          if (resJson.Success) {
            this.$message.success('操作成功!')
            this.visible = false
            this.$emit('success')
          } else {
            this.$message.error(resJson.Msg)
          }
        })
      })
    },
  }
}
</script>
<style scoped>
.color-block:hover {
  transform: scale(1.05);
  box-shadow: 0 4px 8px rgba(0,0,0,0.15) !important;
}
</style>
<style>
.color-picker-popover .ant-popover-inner-content {
  padding: 0;
}
</style>

