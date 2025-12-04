<template>
  <a-modal :title="title" width="50%" :visible="visible" :confirmLoading="loading" @ok="handleSubmit"
    :bodyStyle="{ maxHeight: '70vh', overflowY: 'auto' }" @cancel="handleCancel" :maskClosable="false"
    :destroyOnClose="true">

    <template slot="footer">
      <a-button @click="handleCancel">取消</a-button>
      <a-button type="primary" :loading="loading" @click="handleSubmit">确定
      </a-button>
    </template>

    <a-spin :spinning="loading">
      <a-form-model ref="form" :model="entity" :rules="rules" v-bind="layout">
        
        <a-divider orientation="left">
          <span style="font-size: 14px; font-weight: 500;">
            <a-icon type="info-circle" style="margin-right: 8px; color: #1890ff;" />
            基本信息
          </span>
        </a-divider>
        <a-form-model-item label="分类名称" prop="Name">
          <a-input 
            v-model="entity.Name" 
            autocomplete="off" 
            placeholder="请输入分类名称,2-50个字符"
            allow-clear>
            <a-icon slot="prefix" type="tag" style="color: rgba(0,0,0,.25)" />
          </a-input>
        </a-form-model-item>
        <a-form-model-item label="分类描述" prop="Description">
          <a-textarea 
            v-model="entity.Description" 
            autocomplete="off" 
            placeholder="请输入分类描述,最多200个字符"
            :auto-size="{ minRows: 3, maxRows: 5 }"
            allow-clear
            :maxLength="200"
            show-count />
        </a-form-model-item>
        <a-divider orientation="left">
          <span style="font-size: 14px; font-weight: 500;">
            <a-icon type="picture" style="margin-right: 8px; color: #1890ff;" />
            外观设置
          </span>
        </a-divider>
        <a-form-model-item label="分类图标" prop="Icon">
          <div style="display: flex; align-items: center; gap: 12px;">
            <div v-if="entity.Icon" style="
              padding: 12px;
              border: 2px solid #1890ff;
              border-radius: 8px;
              background: #e6f7ff;
              display: inline-flex;
              align-items: center;
              justify-content: center;
            ">
              <a-icon :type="entity.Icon" :style="{ fontSize: '32px', color: '#1890ff' }" />
            </div>
            <div v-else style="
              padding: 12px;
              border: 2px dashed #d9d9d9;
              border-radius: 8px;
              background: #fafafa;
              display: inline-flex;
              align-items: center;
              justify-content: center;
              width: 56px;
              height: 56px;
            ">
              <a-icon type="question" :style="{ fontSize: '32px', color: '#d9d9d9' }" />
            </div>
            
            <a-button type="primary" @click="showIconSelector = !showIconSelector">
              <a-icon :type="showIconSelector ? 'up' : 'down'" />
              {{ showIconSelector ? '收起图标库' : '选择图标' }}
            </a-button>
            
            <a-button v-if="entity.Icon" @click="entity.Icon = ''" type="dashed">
              <a-icon type="close" />
              清除
            </a-button>
          </div>
          
          <div v-show="showIconSelector" style="margin-top: 12px;">
            <icon-selector v-model="entity.Icon" @change="handleIconChange" />
          </div>
        </a-form-model-item>
        <a-form-model-item label="排序号" prop="SortIndex">
          <a-input-number 
            v-model="entity.SortIndex" 
            placeholder="请输入排序号"
            :min="0"
            :max="9999"
            style="width: 100%"
            allow-clear />
          <div style="color: #999; font-size: 12px; margin-top: 4px;">
            <a-icon type="info-circle" /> 数字越小，分类显示越靠前
          </div>
        </a-form-model-item>
        <a-divider orientation="left">
          <span style="font-size: 14px; font-weight: 500;">
            <a-icon type="setting" style="margin-right: 8px; color: #1890ff;" />
            其他设置
          </span>
        </a-divider>
        <a-form-model-item label="文章数量" prop="ArticleCount" v-if="entity.Id">
          <a-input 
            v-model="entity.ArticleCount" 
            autocomplete="off" 
            disabled
            style="color: #1890ff; font-weight: 500;">
            <a-icon slot="prefix" type="file-text" style="color: rgba(0,0,0,.25)" />
          </a-input>
          <div style="color: #999; font-size: 12px; margin-top: 4px;">
            <a-icon type="info-circle" /> 文章数量由系统自动统计，不可手动修改
          </div>
        </a-form-model-item>
        <a-form-model-item label="状态" prop="Status">
          <a-radio-group v-model="entity.Status" button-style="solid">
            <a-radio-button :value="1">
              <a-icon type="check-circle" />
              启用
            </a-radio-button>
            <a-radio-button :value="0">
              <a-icon type="close-circle" />
              禁用
            </a-radio-button>
          </a-radio-group>
          <div style="color: #999; font-size: 12px; margin-top: 4px;">
            <a-icon type="info-circle" /> 禁用后该分类将不在前台显示
          </div>
        </a-form-model-item>
        <a-form-model-item label="是否删除" prop="IsDeleted" v-if="entity.Id">
          <a-radio-group v-model="entity.IsDeleted" button-style="solid">
            <a-radio-button :value="0">
              <a-icon type="check" />
              否
            </a-radio-button>
            <a-radio-button :value="1">
              <a-icon type="delete" />
              是
            </a-radio-button>
          </a-radio-group>
        </a-form-model-item>
      </a-form-model>
    </a-spin>
  </a-modal>
</template>

<script>
import IconSelector from '@/components/IconSelector'

export default {
  components: {
    IconSelector
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
      showIconSelector: false, 
      rules: {
        Name: [
          { required: true, message: '请输入分类名称', trigger: 'blur' },
          { min: 2, max: 50, message: '长度在 2 到 50 个字符', trigger: 'blur' }
        ],
        Description: [
          { max: 200, message: '长度不能超过 200 个字符', trigger: 'blur' }
        ],
        Icon: [
          { max: 100, message: '长度不能超过 100 个字符', trigger: 'blur' }
        ],
        SortIndex: [
          { required: true, message: '请输入排序号', trigger: 'blur' },
          { pattern: /^[0-9]*$/, message: '请输入数字', trigger: 'blur' }
        ],
        Status: [
          { required: true, message: '请选择状态', trigger: 'change' }
        ],
        ArticleCount: [
          { pattern: /^[0-9]*$/, message: '请输入数字', trigger: 'blur' }
        ],
        IsDeleted: [
          { required: true, message: '请选择是否删除', trigger: 'change' }
        ]
      },
      title: ''
    }
  },
  methods: {
    init() {
      this.visible = true
      this.entity = {
        Status: 1,
        IsDeleted: 0,
        SortIndex:0
      }
      this.showIconSelector = false
      this.$nextTick(() => {
        this.$refs['form'].clearValidate()
      })
    },
    openForm(id, title) {
      this.init()
      this.title = title
      if (id) {
        this.loading = true
        this.$http.post('/Blog_Manage/blog_category/GetTheData', { id: id }).then(resJson => {
          this.loading = false

          this.entity = resJson.Data
        })
      }
    },
    handleIconChange(icon) {
      this.entity.Icon = icon
      this.showIconSelector = false
    },
    handleCancel() {
      this.visible = false
      this.showIconSelector = false
    },
    handleSubmit() {
      this.$refs['form'].validate(valid => {
        if (!valid) {
          return
        }
        this.loading = true
        this.$http.post('/Blog_Manage/blog_category/SaveData', this.entity).then(resJson => {
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
    }
  }
}
</script>
