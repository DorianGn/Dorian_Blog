<template>
  <a-modal :title="title" width="50%" :visible="visible" :confirmLoading="loading" @ok="handleSubmit"
    :bodyStyle="{ maxHeight: '70vh', overflowY: 'auto' }" @cancel="handleCancel">
    <a-spin :spinning="loading">
      <a-form-model ref="form" :model="entity" :rules="rules" v-bind="layout">
        <a-form-model-item label="文章" prop="ArticleId">
          <a-select v-model="entity.ArticleId" autocomplete="off" showSearch :filterOption="filterArticle"
            placeholder="请选择文章">
            <a-select-option v-for="article in articleList" :key="article.Id" :value="article.Id">
              <a-tooltip :title="article.Title">
                {{ article.Title }}
              </a-tooltip>
            </a-select-option>
          </a-select>
        </a-form-model-item>

        <a-form-model-item label="评论用户" prop="UserId">
          <a-select v-model="entity.UserId" autocomplete="off" showSearch :filterOption="filterUser"
            placeholder="请选择用户">
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
            showSearch :filterOption="filterComment" placeholder="请选择父评论（不选则为顶级评论）">
            <a-select-option v-for="comment in parentCommentList" :key="comment.Id" :value="comment.Id">
              <a-tooltip :title="stripHtml(comment.Content)" placement="right">
                <span class="comment-option">
                  {{ formatCommentOption(comment) }}
                </span>
              </a-tooltip>
            </a-select-option>
          </a-select>
        </a-form-model-item>

        <a-form-model-item label="回复的目标用户" prop="ReplyToUserId">
          <a-select v-model="entity.ReplyToUserId" autocomplete="off" showSearch :filterOption="filterUser" allowClear
            placeholder="请选择回复的目标用户">
            <a-select-option v-for="user in userList" :key="user.Id" :value="user.Id">
              {{ user.UserName }}
            </a-select-option>
          </a-select>
        </a-form-model-item>

        <a-form-model-item label="点赞数" prop="LikeCount">
          <a-input-number v-model="entity.LikeCount" :min="0" :max="999999" style="width: 100%" placeholder="请输入点赞数" />
        </a-form-model-item>

        <a-form-model-item label="状态" prop="Status">
          <a-select v-model="entity.Status" autocomplete="off" placeholder="请选择状态">
            <a-select-option :value="0">
              <a-tag color="red">已删除</a-tag>
            </a-select-option>
            <a-select-option :value="1">
              <a-tag color="green">正常</a-tag>
            </a-select-option>
            <a-select-option :value="2">
              <a-tag color="orange">已屏蔽</a-tag>
            </a-select-option>
          </a-select>
        </a-form-model-item>

        <a-form-model-item label="是否删除" prop="IsDeleted">
          <a-radio-group v-model="entity.IsDeleted">
            <a-radio :value="0">否</a-radio>
            <a-radio :value="1">是</a-radio>
          </a-radio-group>
        </a-form-model-item>
      </a-form-model>
    </a-spin>
  </a-modal>
</template>

<script>
import WangEditor from '@/components/WangEditor/WangEditor'

export default {
  name: 'CommentEditForm',
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
      entity: {
        ArticleId: undefined,
        UserId: undefined,
        Content: '',
        ParentId: undefined,
        ReplyToUserId: undefined,
        LikeCount: 0,
        Status: 1,
        IsDeleted: 0
      },
      rules: {
        ArticleId: [{ required: true, message: '请选择文章', trigger: 'change' }],
        UserId: [{ required: true, message: '请选择评论用户', trigger: 'change' }],
        Content: [{ required: true, message: '请输入评论内容', trigger: 'blur' }],
        LikeCount: [
          { required: false, message: '请输入点赞数', trigger: 'blur' },
          { type: 'number', message: '点赞数必须为数字', trigger: 'blur' }
        ],
        Status: [{ required: true, message: '请选择状态', trigger: 'change' }],
        IsDeleted: [{ required: true, message: '请选择是否删除', trigger: 'change' }]
      },
      title: '',
      userList: [],
      articleList: [],
      commentList: []
    }
  },
  computed: {
    // 过滤掉当前编辑的评论，避免选择自己作为父评论
    parentCommentList() {
      return this.commentList.filter(comment => {
        if (!this.entity.Id) return true
        return comment.Id !== this.entity.Id
      })
    }
  },
  mounted() {
    this.loadStaticData()
  },
  methods: {
    // 并行加载所有静态数据
    async loadStaticData() {
      try {
        await Promise.all([
          this.loadUsers(),
          this.loadArticles(),
          this.loadComments()
        ])
      } catch (error) {
        console.error('加载数据失败:', error)
        this.$message.error('加载数据失败，请刷新页面重试')
      }
    },

    // 加载用户列表
    async loadUsers() {
      try {
        const res = await this.$http.post('/Base_Manage/Base_User/GetDataList', {
          PageIndex: 1,
          PageSize: 9999,
          SortField: 'Id',
          SortType: 'asc',
          Search: { all: true }
        })
        if (res.Success && res.Data) {
          this.userList = res.Data.filter(item => item.UserType === 4 || item.UserType === 0)
        } else {
          throw new Error(res.Msg || '加载用户失败')
        }
      } catch (error) {
        console.error('加载用户列表失败:', error)
        throw error
      }
    },

    // 加载文章列表
    async loadArticles() {
      try {
        const res = await this.$http.post('/Blog_Manage/blog_article/GetDataList', {
          PageIndex: 1,
          PageRows: 9999,
          SortField: 'Id',
          SortType: 'asc',
          Search: {}
        })
        if (res.Success && res.Data) {
          this.articleList = res.Data
        } else {
          throw new Error(res.Msg || '加载文章失败')
        }
      } catch (error) {
        console.error('加载文章列表失败:', error)
        throw error
      }
    },

    // 加载评论列表
    async loadComments() {
      try {
        const res = await this.$http.post('/Blog_Manage/blog_comment/GetDataList', {
          PageIndex: 1,
          PageRows: 9999,
          SortField: 'Id',
          SortType: 'asc',
          Search: {}
        })
        if (res.Success && res.Data) {
          this.commentList = res.Data
        } else {
          throw new Error(res.Msg || '加载评论失败')
        }
      } catch (error) {
        console.error('加载评论列表失败:', error)
        throw error
      }
    },

    // 初始化表单
    init() {
      this.visible = true
      this.entity = {
        ArticleId: undefined,
        UserId: undefined,
        Content: '',
        ParentId: undefined,
        ReplyToUserId: undefined,
        LikeCount: 0,
        Status: 1,
        IsDeleted: 0
      }
      this.$nextTick(() => {
        this.$refs['form'] && this.$refs['form'].clearValidate()
      })
    },

    // 打开表单
    openForm(id, title) {
      this.init()
      this.title = title
      if (id) {
        this.loadCommentData(id)
      }
    },

    // 加载评论数据
    async loadCommentData(id) {
      this.loading = true
      try {
        const res = await this.$http.post('/Blog_Manage/blog_comment/GetTheData', { id })
        if (res.Success && res.Data) {
          this.entity = {
            ...this.entity,
            ...res.Data
          }
        } else {
          this.$message.error(res.Msg || '加载评论数据失败')
        }
      } catch (error) {
        console.error('加载评论数据失败:', error)
        this.$message.error('加载评论数据失败')
      } finally {
        this.loading = false
      }
    },

    // 处理父评论改变
    handleParentCommentChange(value) {
      if (value) {
        const parentComment = this.commentList.find(c => c.Id === value)
        if (parentComment) {
          this.entity.ReplyToUserId = parentComment.UserId
        }
      } else {
        this.entity.ReplyToUserId = undefined
      }
    },

    // 取消
    handleCancel() {
      this.visible = false
      this.$refs['form'] && this.$refs['form'].clearValidate()
    },

    // 提交表单
    handleSubmit() {
      this.$refs['form'].validate(async valid => {
        if (!valid) return

        this.loading = true
        try {
          const res = await this.$http.post('/Blog_Manage/blog_comment/SaveData', this.entity)
          if (res.Success) {
            this.$message.success('操作成功!')
            this.visible = false
            this.$emit('success')
          } else {
            this.$message.error(res.Msg || '操作失败')
          }
        } catch (error) {
          console.error('保存失败:', error)
          this.$message.error('保存失败，请重试')
        } finally {
          this.loading = false
        }
      })
    },

    // 格式化评论选项显示
    formatCommentOption(comment) {
      const content = this.stripHtml(comment.Content)
      const maxLength = 50
      return content.length > maxLength
        ? content.substring(0, maxLength) + '...'
        : content
    },

    // 去除 HTML 标签
    stripHtml(html) {
      if (!html) return ''
      const tmp = document.createElement('div')
      tmp.innerHTML = html
      return tmp.textContent || tmp.innerText || ''
    },

    // 评论搜索过滤
    filterComment(input, option) {
      const text = option.componentOptions.children[0].elm.innerText || ''
      return text.toLowerCase().includes(input.toLowerCase())
    },

    // 用户搜索过滤
    filterUser(input, option) {
      const text = option.componentOptions.children[0].text || ''
      return text.toLowerCase().includes(input.toLowerCase())
    },

    // 文章搜索过滤
    filterArticle(input, option) {
      const text = option.componentOptions.children[0].children[0].text || ''
      return text.toLowerCase().includes(input.toLowerCase())
    }
  }
}
</script>

<style scoped>
.comment-option {
  display: inline-block;
  max-width: 100%;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
</style>
