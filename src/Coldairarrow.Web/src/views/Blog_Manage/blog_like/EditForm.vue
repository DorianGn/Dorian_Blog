<template>
  <a-modal :title="title" width="40%" :visible="visible" :confirmLoading="loading" @ok="handleSubmit"
    :bodyStyle="{ maxHeight: '70vh', overflowY: 'auto' }" @cancel="() => { this.visible = false }">
    <a-spin :spinning="loading">
      <a-form-model ref="form" :model="entity" :rules="rules" v-bind="layout">
        <a-form-model-item label="文章" prop="ArticleId">
          <a-select v-model="entity.ArticleId" autocomplete="off" placeholder="请选择文章">
             <a-select-option v-for="article in articleOptions" :key="article.Id" :value="article.Id">
                {{ article.Title }}
              </a-select-option>  
          </a-select>
        </a-form-model-item>
        <a-form-model-item label="用户" prop="UserId">
          <a-select v-model="entity.UserId" autocomplete="off" placeholder="请选择用户">
              <a-select-option v-for="user in userList" :key="user.Id" :value="user.Id">
                  {{ user.UserName }}
                </a-select-option>
          </a-select>
        </a-form-model-item>
        <!-- <a-form-model-item label="点赞时间" prop="CreatedTime">
          <a-input v-model="entity.CreatedTime" autocomplete="off" />
        </a-form-model-item> -->
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
      entity: {},
      articleOptions: [],
      userList:[],
      rules: {
        ArticleId: [{ required: true, message: '请选择文章', trigger: 'change' }],
        UserId: [{ required: true, message: '请选择用户', trigger: 'change' }]
      },
      title: ''
    }
  },
  mounted() {
    this.loadArticles()
    this.loadUsers()
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
        this.$http.post('/Blog_Manage/blog_like/GetTheData', { id: id }).then(resJson => {
          this.loading = false
          this.entity = resJson.Data
        })
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
          this.articleOptions = res.Data
        } else {
          console.error('加载文章失败:', res.Msg)
        }
      } catch (error) {
        console.error('加载文章列表失败:', error)
      }
    },
    async loadUsers() {
      try {
        const res = await this.$http.post('/Base_Manage/Base_User/GetDataList', {
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
          this.userList = res.Data.filter(item => item.UserType === 4 || item.UserType === 0) 
        } else {
          console.error('加载用户失败:', res.Msg)
        }
      } catch (error) {
        console.error('加载用户列表失败:', error)
      }
    },
    handleSubmit() {
      this.$refs['form'].validate(valid => {
        if (!valid) {
          return
        }
        this.loading = true
        this.$http.post('/Blog_Manage/blog_like/SaveData', this.entity).then(resJson => {
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
