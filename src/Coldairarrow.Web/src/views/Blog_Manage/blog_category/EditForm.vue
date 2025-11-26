<template>
  <a-modal :title="title" width="50%" :visible="visible" :confirmLoading="loading" @ok="handleSubmit"
  :bodyStyle="{ maxHeight: '70vh', overflowY: 'auto' }"
    @cancel="() => { this.visible = false }" >
    <a-spin :spinning="loading">
      <a-form-model ref="form" :model="entity" :rules="rules" v-bind="layout">
        <a-form-model-item label="分类名称" prop="Name">
          <a-input v-model="entity.Name" autocomplete="off" />
        </a-form-model-item>
        <a-form-model-item label="分类描述" prop="Description">
          <a-input v-model="entity.Description" autocomplete="off" />
        </a-form-model-item>
        <a-form-model-item label="分类图标" prop="Icon">
          <a-input v-model="entity.Icon" autocomplete="off" />
        </a-form-model-item>
        <a-form-model-item label="排序号" prop="SortIndex">
          <a-input v-model="entity.SortIndex" autocomplete="off" />
        </a-form-model-item>
        <a-form-model-item label="状态" prop="Status">
          <a-select v-model="entity.Status" autocomplete="off">
            <a-select-option :value="0">禁用</a-select-option>
            <a-select-option :value="1">启用</a-select-option>
          </a-select>
        </a-form-model-item>
        <a-form-model-item label="文章数量" prop="ArticleCount">
          <a-input v-model="entity.ArticleCount" autocomplete="off" />
        </a-form-model-item>
        <a-form-model-item label="是否删除" prop="IsDeleted">
          <a-select v-model="entity.IsDeleted" autocomplete="off">
            <a-select-option :value="0">否</a-select-option>
            <a-select-option :value="1">是</a-select-option>
          </a-select>
        </a-form-model-item>
      </a-form-model>
    </a-spin>
  </a-modal>
</template>

<script>

export default {
  data() {
    return {
      layout: {
        labelCol: { span: 5 },
        wrapperCol: { span: 18 }
      },
      visible: false,
      loading: false,
      entity: {
        Status: '1',
        IsDeleted: '0'
      },
      rules: {},
      title: ''
    }
  },
  methods: {
    init() {
      this.visible = true
      this.entity = {
        Status: '1',
        IsDeleted: '0'
      }
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
