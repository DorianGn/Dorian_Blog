<template>
  <a-modal :title="title" width="70%" :visible="visible" :confirmLoading="loading" @ok="handleSubmit"
    @cancel="() => { this.visible = false }" :bodyStyle="{ maxHeight: '65vh', overflowY: 'auto' }">
    <a-spin :spinning="loading">
      <a-form-model ref="form" :model="entity" :rules="rules" v-bind="layout">
        <a-form-model-item label="文章标题" prop="Title">
          <a-input v-model="entity.Title" autocomplete="off" />
        </a-form-model-item>
        <a-form-model-item label="文章摘要" prop="Summary">
          <a-input v-model="entity.Summary" autocomplete="off" />
        </a-form-model-item>
        <a-form-model-item label="文章内容" prop="Content">
          <WangEditor v-model="entity.Content" autocomplete="off" />
        </a-form-model-item>
        <a-form-model-item label="封面图片" prop="CoverImage">
          <a-input v-model="entity.CoverImage" autocomplete="off" />
        </a-form-model-item>
        <a-form-model-item label="分类" prop="CategoryId">
          <a-input v-model="entity.CategoryId" autocomplete="off" />
        </a-form-model-item>
        <a-form-model-item label="作者" prop="AuthorId">
          <a-input v-model="entity.AuthorId" autocomplete="off" />
        </a-form-model-item>
        <a-form-model-item label="文章状态" prop="Status">
          <a-select v-model="entity.Status" placeholder="请选择文章装填">
            <a-select-option :value="0">草稿 </a-select-option>
            <a-select-option :value="1">已发布 </a-select-option>
            <a-select-option :value="2">已隐藏 </a-select-option>
          </a-select>
        </a-form-model-item>
        <a-form-model-item label="是否置顶" prop="IsTop">
          <a-select v-model="entity.IsTop" placeholder="请选择是否置顶">
            <a-select-option :value="0">否 </a-select-option>
            <a-select-option :value="1">是 </a-select-option>
          </a-select>
        </a-form-model-item>
        <a-form-model-item label="是否推荐" prop="IsRecommend">
          <a-select v-model="entity.IsRecommend" placeholder="请选择是否推荐">
            <a-select-option :value="0">否 </a-select-option>
            <a-select-option :value="1">是 </a-select-option>
          </a-select>
        </a-form-model-item>
        <a-form-model-item label="是否允许评论" prop="AllowComment">
          <a-select v-model="entity.AllowComment" placeholder="请选择是否允许评论">
            <a-select-option :value="0">否 </a-select-option>
            <a-select-option :value="1">是 </a-select-option>
          </a-select>
        </a-form-model-item>
        <a-form-model-item label="阅读量" prop="ViewCount">
          <a-input v-model="entity.ViewCount" autocomplete="off" />
        </a-form-model-item>
        <a-form-model-item label="点赞数" prop="LikeCount">
          <a-input v-model="entity.LikeCount" autocomplete="off" />
        </a-form-model-item>
        <a-form-model-item label="评论数" prop="CommentCount">
          <a-input v-model="entity.CommentCount" autocomplete="off" />
        </a-form-model-item>
        <a-form-model-item label="发布时间" prop="PublishTime">
          <a-input v-model="entity.PublishTime" autocomplete="off" />
        </a-form-model-item>
        <a-form-model-item label="是否删除" prop="IsDeleted">
          <a-select v-model="entity.IsDeleted" placeholder="请选择是否删除">
            <a-select-option :value="0">否 </a-select-option>
            <a-select-option :value="1">是 </a-select-option>
          </a-select>
        </a-form-model-item>
        <a-form-model-item label="创建时间" prop="CreatedTime">
          <a-input v-model="entity.CreatedTime" autocomplete="off" />
        </a-form-model-item>
        <a-form-model-item label="更新时间" prop="UpdatedTime">
          <a-input v-model="entity.UpdatedTime" autocomplete="off" />
        </a-form-model-item>
        <a-form-model-item label="更新人ID" prop="UpdaterId">
          <a-input v-model="entity.UpdaterId" autocomplete="off" />
        </a-form-model-item>
      </a-form-model>
    </a-spin>
  </a-modal>
</template>

<script>
import WangEditor from '@/components/WangEditor/WangEditor'
export default {
  components: { WangEditor },
  data() {
    return {
      layout: {
        labelCol: { span: 5 },
        wrapperCol: { span: 18 }
      },
      visible: false,
      loading: false,
      entity: {},
      rules: {},
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
        this.$http.post('/Blog_Manage/blog_article/GetTheData', { id: id }).then(resJson => {
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
        this.$http.post('/Blog_Manage/blog_article/SaveData', this.entity).then(resJson => {
          this.loading = false
          if (resJson.Success) {
            this.$message.success('操作成功!')
            this.visible = false
            this.$emit('success')
            this.parentObj.getDataList()
          } else {
            this.$message.error(resJson.Msg)
          }
        })
      })
    }
  }
}
</script>
