<template>
  <a-modal :title="title" width="70%" :visible="visible" :confirmLoading="loading" @ok="handleSubmit"
    @cancel="() => { this.visible = false }" :bodyStyle="{ maxHeight: '70vh', overflowY: 'auto' }">
    <a-spin :spinning="loading">
      <a-form-model ref="form" :model="entity" :rules="rules" v-bind="layout">
        <a-form-model-item label="文章标题" prop="Title">
          <a-input v-model="entity.Title" autocomplete="off" placeholder="请输入文章标题" />
        </a-form-model-item>
        <a-form-model-item label="文章摘要" prop="Summary">
          <a-textarea v-model="entity.Summary" autocomplete="off" placeholder="请输入文章摘要" :rows="3" />
        </a-form-model-item>
        <a-form-model-item label="文章内容" prop="Content">
          <WangEditor v-model="entity.Content" autocomplete="off" />
        </a-form-model-item>
        <a-form-model-item label="封面图片" prop="CoverImage">
          <c-upload-img ref="coverImageUpload" v-model="entity.CoverImage" :maxCount="1" autocomplete="off"
            placeholder="请上传图片" />
        </a-form-model-item>
        <a-form-model-item label="分类" prop="CategoryId">
          <a-select v-model="entity.CategoryId" placeholder="请选择文章分类" show-search :filter-option="filterOption">
            <a-select-option v-for="category in categoryList" :key="category.Id" :value="category.Id">
              {{ category.Name }}
            </a-select-option>
          </a-select>
        </a-form-model-item>
        <a-form-model-item label="作者" prop="AuthorId">
          <a-select v-model="entity.AuthorId" placeholder="请选择作者" show-search :filter-option="filterOption">
            <a-select-option v-for="user in userList" :key="user.Id" :value="user.Id">
              {{ user.UserName }}
            </a-select-option>
          </a-select>
        </a-form-model-item>
        <a-form-model-item label="文章状态" prop="Status">
          <a-select v-model="entity.Status" placeholder="请选择文章状态">
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
          <a-input-number v-model="entity.ViewCount" :min="0" style="width: 100%" placeholder="请输入阅读量" />
        </a-form-model-item>
        <a-form-model-item label="点赞数" prop="LikeCount">
          <a-input-number v-model="entity.LikeCount" :min="0" style="width: 100%" placeholder="请输入点赞数" />
        </a-form-model-item>
        <a-form-model-item label="评论数" prop="CommentCount">
          <a-input-number v-model="entity.CommentCount" :min="0" style="width: 100%" placeholder="请输入评论数" />
        </a-form-model-item>
        <a-form-model-item label="发布时间" prop="PublishTime">
          <a-date-picker v-model="publishTimeValue" show-time format="YYYY-MM-DD HH:mm:ss" style="width: 100%"
            placeholder="请选择发布时间" />
        </a-form-model-item>
        <a-form-model-item label="是否删除" prop="IsDeleted">
          <a-select v-model="entity.IsDeleted" placeholder="请选择是否删除">
            <a-select-option :value="0">否 </a-select-option>
            <a-select-option :value="1">是 </a-select-option>
          </a-select>
        </a-form-model-item>
      </a-form-model>
    </a-spin>
  </a-modal>
</template>

<script>
import WangEditor from '@/components/WangEditor/WangEditor'
import CUploadImg from '@/components/CUploadImg/CUploadImg'
import moment from 'moment'
export default {
  components: { WangEditor, CUploadImg },
  data() {
    return {
      layout: {
        labelCol: { span: 5 },
        wrapperCol: { span: 18 }
      },
      publishTimeValue: null,
      visible: false,
      loading: false,
      entity: {},
      categoryList: [], // 分类列表
      userList: [], // 用户列表
      rules: {
        Title: [
          { required: true, message: '请输入文章标题', trigger: 'blur' },
          { min: 2, max: 100, message: '标题长度在 2 到 100 个字符', trigger: 'blur' }
        ],
        Summary: [
          { required: false, message: '请输入文章摘要', trigger: 'blur' },
          { max: 500, message: '摘要长度不能超过 500 个字符', trigger: 'blur' }
        ],
        Content: [
          { required: true, message: '请输入文章内容', trigger: 'blur' }
        ],
        CoverImage: [
          { required: false, message: '请输入封面图片URL', trigger: 'blur' },
          { type: 'url', message: '请输入正确的URL格式', trigger: 'blur' }
        ],
        CategoryId: [
          { required: true, message: '请选择文章分类', trigger: 'change' }
        ],
        AuthorId: [
          { required: true, message: '请选择作者', trigger: 'change' }
        ],
        Status: [
          { required: true, message: '请选择文章状态', trigger: 'change', type: 'number' }
        ],
        IsTop: [
          { required: true, message: '请选择是否置顶', trigger: 'change', type: 'number' }
        ],
        IsRecommend: [
          { required: true, message: '请选择是否推荐', trigger: 'change', type: 'number' }
        ],
        AllowComment: [
          { required: true, message: '请选择是否允许评论', trigger: 'change', type: 'number' }
        ],
        ViewCount: [
          { required: false, type: 'number', message: '请输入正确的数字', trigger: 'blur' }
        ],
        LikeCount: [
          { required: false, type: 'number', message: '请输入正确的数字', trigger: 'blur' }
        ],
        CommentCount: [
          { required: false, type: 'number', message: '请输入正确的数字', trigger: 'blur' }
        ],
        PublishTime: [
          { required: false, message: '请选择发布时间', trigger: 'change' }
        ],
        IsDeleted: [
          { required: false, message: '请选择是否删除', trigger: 'change', type: 'number' }
        ]
      },
      title: ''
    }
  },
  watch: {
    publishTimeValue(val) {
      this.entity.PublishTime = val ? val.format('YYYY-MM-DD HH:mm:ss') : null
    }
  },
  mounted() {
    // 页面加载时获取分类和用户列表
    this.loadCategories()
    this.loadUsers()
  },
  methods: {
    // 下拉选择框搜索过滤
    filterOption(input, option) {
      return (
        option.componentOptions.children[0].text.toLowerCase().indexOf(input.toLowerCase()) >= 0
      )
    },
    // 加载分类列表
    async loadCategories() {
      try {
        const res = await this.$http.post('/Blog_Manage/blog_category/GetDataList', {
          PageIndex: 1,
          PageRows: 9999,
          SortField: 'SortIndex',
          SortType: 'asc',
        })
        if (res.Success && res.Data) {
          this.categoryList = res.Data.filter(item => item.Status === 1 && item.IsDeleted === 0)
        } else {
          console.error('加载分类失败:', res.Msg)
        }
      } catch (error) {
        console.error('加载分类列表失败:', error)
      }
    },
    // 加载用户列表
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
          this.userList = res.Data.filter(item => item.UserType === 4)
        } else {
          console.error('加载用户失败:', res.Msg)
        }
      } catch (error) {
        console.error('加载用户列表失败:', error)
      }
    },
    init() {
      this.visible = true
      this.entity = {
        Title: '',
      }
      this.publishTimeValue = null
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

          if (this.entity.PublishTime) {
            this.publishTimeValue = moment(this.entity.PublishTime)
          } else {
            this.publishTimeValue = null
          }
          this.$nextTick(() => {
            if (this.$refs.coverImageUpload && this.entity.CoverImage) {
              this.$refs.coverImageUpload.refresh(this.entity.CoverImage)
            }
          })
        }).catch(error => {
          this.loading = false
          this.$message.error('获取数据失败：' + error.message)
        })
      }
    },
    handleSubmit() {
      this.$refs['form'].validate(async (valid) => {
        if (!valid) {
          this.$message.warning('请检查表单填写是否正确')
          return
        }
        this.loading = true
        try {
          // 2. 上传封面图片
          const coverImageUrl = await this.$refs.coverImageUpload.uploadAllFiles()
          this.entity.CoverImage = coverImageUrl
          // 3. 提交表单数据
          const resJson = await this.$http.post('/Blog_Manage/blog_article/SaveData', this.entity)

          this.loading = false
          if (resJson.Success) {
            this.$message.success('操作成功!', 3)
            this.visible = false
            this.$emit('success')
            if (this.parentObj && this.parentObj.getDataList) {
              this.parentObj.getDataList()
            }
          } else {
            this.$message.error(resJson.Msg, 3)
          }
        } catch (error) {
          this.loading = false
          this.$message.error('操作失败：' + error.message, 3)
        }
      })
    }
  }
}
</script>
