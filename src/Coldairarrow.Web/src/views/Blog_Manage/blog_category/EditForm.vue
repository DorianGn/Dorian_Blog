<template>
  <a-modal :title="title" width="50%" :visible="visible" :confirmLoading="loading" @ok="handleSubmit"
    :bodyStyle="{ maxHeight: '70vh', overflowY: 'auto' }" @cancel="() => { this.visible = false }">
    <a-spin :spinning="loading">
      <a-form-model ref="form" :model="entity" :rules="rules" v-bind="layout">
        <a-form-model-item label="分类名称" prop="Name">
          <a-input v-model="entity.Name" autocomplete="off" placeholder="请输入标签名称" />
        </a-form-model-item>
        <a-form-model-item label="分类描述" prop="Description">
          <a-input v-model="entity.Description" autocomplete="off" placeholder="请输入分类描述" />
        </a-form-model-item>
        <a-form-model-item label="分类图标" prop="Icon">
          <icon-selector v-model="entity.Icon" @change="(icon) => { entity.Icon = icon }" />
        </a-form-model-item>
        <a-form-model-item label="排序号" prop="SortIndex">
          <a-input v-model="entity.SortIndex" autocomplete="off" placeholder="请输入排序号" />
        </a-form-model-item>
        <a-form-model-item label="文章数量" prop="ArticleCount">
          <a-input v-model="entity.ArticleCount" autocomplete="off" placeholder="请输入文章数量" />
        </a-form-model-item>
        <a-form-model-item label="状态" prop="Status">
          <a-select v-model="entity.Status" autocomplete="off" placeholder="请选择是否删除">
            <a-select-option :value="0">禁用</a-select-option>
            <a-select-option :value="1">启用</a-select-option>
          </a-select>
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
      rules: {
        Name: [
          { required: true, message: '请输入分类名称', trigger: 'blur'},
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
      this.entity = {}
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
