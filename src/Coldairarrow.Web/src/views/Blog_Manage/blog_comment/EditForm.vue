<template>
  <a-modal :title="title" width="70%" :visible="visible" :confirmLoading="loading" @ok="handleSubmit"
    :bodyStyle="{ maxHeight: '70vh', overflowY: 'auto' }" @cancel="() => { this.visible = false }">
    <a-spin :spinning="loading">
      <a-form-model ref="form" :model="entity" :rules="rules" v-bind="layout">
        <a-form-model-item label="文章" prop="ArticleId">
          <a-select v-model="entity.ArticleId" autocomplete="off" placeholder="请选择文章">
            <a-select-option v-for="article in articleList" :key="article.Id" :value="article.Id">
              {{ article.Title }}
            </a-select-option>
          </a-select>
        </a-form-model-item>
        <a-form-model-item label="评论用户" prop="UserId">
          <a-select v-model="entity.UserId" autocomplete="off" placeholder="请选择用户">
            <a-select-option v-for="user in userList" :key="user.Id" :value="user.Id">
              {{ user.UserName }}
            </a-select-option>
          </a-select>
        </a-form-model-item>
        <a-form-model-item label="评论内容" prop="Content">
          <WangEditor v-model="entity.Content" autocomplete="off" />
        </a-form-model-item>
        <a-form-model-item label="父评论" prop="ParentId">
          <a-select v-model="entity.ParentId" autocomplete="off" @change="handleParentCommentChange" allowClear
            showSearch placeholder="请选择父评论（不选则为顶级评论）">
            <a-select-option v-for="comment in commentList" :key="comment.Id" :value="comment.Id">
              {{ comment.Content }}
            </a-select-option>
          </a-select>
        </a-form-model-item>
        <a-form-model-item label="回复的目标用户" prop="ReplyToUserId">
          <a-select v-model="entity.ReplyToUserId" autocomplete="off" placeholder="请选择回复的目标用户">
            <a-select-option v-for="user in userList" :key="user.Id" :value="user.Id">
              {{ user.UserName }}
            </a-select-option>
          </a-select>
        </a-form-model-item>
        <a-form-model-item label="点赞数" prop="LikeCount">
          <a-input v-model="entity.LikeCount" autocomplete="off" placeholder="请输入点赞数" />
        </a-form-model-item>
        <a-form-model-item label="状态" prop="Status">
          <a-select v-model="entity.Status" autocomplete="off" placeholder="请选择状态">
            <a-select-option value="0">已删除</a-select-option>
            <a-select-option value="1">正常</a-select-option>
            <a-select-option value="2">已屏蔽</a-select-option>
          </a-select>
        </a-form-model-item>
        <a-form-model-item label="是否删除" prop="IsDeleted">
          <a-select v-model="entity.IsDeleted" autocomplete="off" placeholder="请选择是否删除">
            <a-select-option value="0">否</a-select-option>
            <a-select-option value="1">是</a-select-option>
          </a-select>
        </a-form-model-item>
      </a-form-model>
    </a-spin>
  </a-modal>
</template>

<script>
import WangEditor from '@/components/WangEditor/WangEditor'

export default {
  components: {
    WangEditor
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
        Content: [{ required: true, message: '请输入评论内容', trigger: 'blur' }],
        ParentId: [{ required: false, message: '请选择父评论', trigger: 'change' }],
        ReplyToUserId: [{ required: false, message: '请选择回复的目标用户', trigger: 'change' }],
        Status: [{ required: false, message: '请选择状态', trigger: 'change' }],
        IsDeleted: [{ required: false, message: '请选择是否删除', trigger: 'change' }],
        ArticleId: [{ required: true, message: '请选择文章', trigger: 'change' }],
        UserId: [{ required: true, message: '请选择评论用户', trigger: 'change' }],
        LikeCount: [{ required: false, message: '请输入点赞数', trigger: 'blur' }],
        UserId: [{ required: true, message: '请选择评论用户', trigger: 'change' }],
        ArticleId: [{ required: true, message: '请选择文章', trigger: 'change' }],
        Content: [{ required: true, message: '请输入评论内容', trigger: 'blur' }],
      },
      title: '',
      userList: [],
      articleList: [],
      commentList: []
    }
  },
  mounted() {
    this.loadUser();
    this.loadArticles();
    this.loadComment();
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
        this.$http.post('/Blog_Manage/blog_comment/GetTheData', { id: id }).then(resJson => {
          this.loading = false

          this.entity = resJson.Data
        })
      }
    },
    handleParentCommentChange(value) {
      if (value) {
        const parentComment = this.commentList.find(c => c.Id === value)
        if (parentComment) {
          this.entity.ReplyToUserId = parentComment.UserId
        }
      } else {
        this.entity.ReplyToUserId = null
      }
    },

    async loadComment() {
      try {
        const res = await this.$http.post('/Blog_Manage/blog_comment/GetDataList', {
          PageIndex: 1,
          PageRows: 9999,
          SortField: 'Id',
          SortType: 'asc',
          Search: {
            all: false,
            keyword: '',
            articleId: ''
          }
        })
        if (res.Success && res.Data) {
          this.commentList = res.Data
        } else {
          this.$message.error('加载文章失败:', res.Msg)
        }
      } catch (error) {
        this.$message.error('加载文章列表失败:', error)
      }
    },
    async loadArticles() {
      try {
        const res = await this.$http.post('/Blog_Manage/blog_article/GetDataList', {
          PageIndex: 1,
          PageRows: 9999,
          SortField: 'Id',
          SortType: 'asc',
          Search: {
            all: false,
            keyword: '',
            userId: ''
          }
        })
        if (res.Success && res.Data) {
          this.articleList = res.Data
        } else {
          this.$message.error('加载文章失败:', res.Msg)
        }
      } catch (error) {
        this.$message.error('加载文章列表失败:', error)
      }
    },
    async loadUser() {
      try {
        const res = await this.$http.post('/Base_Manage/Base_User/GetDataList', {
          PageIndex: 1,
          PageSize: 9999,
          SortField: 'Id',
          SortType: 'asc',
          Search: {
            all: true
          }
        });
        if (res.Success && res.Data) {
          this.userList = res.Data.filter(item => item.UserType === 4 || item.UserType === 0);
        } else {
          this.$message.error('加载用户失败:', res.Msg)
        }
      } catch (error) {
        this.$message.error('加载用户列表失败:', error)
      }
    },
    handleSubmit() {
      this.$refs['form'].validate(valid => {
        if (!valid) {
          return
        }
        this.loading = true
        this.$http.post('/Blog_Manage/blog_comment/SaveData', this.entity).then(resJson => {
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
