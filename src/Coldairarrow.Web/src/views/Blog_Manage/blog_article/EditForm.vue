<template>
  <a-modal 
    :title="title" 
    width="60%" 
    :visible="visible" 
    :confirmLoading="loading" 
    @ok="handleSubmit"
    @cancel="() => { this.visible = false }" 
    :bodyStyle="{ maxHeight: '75vh', overflowY: 'auto', padding: '24px' }">
    <a-spin :spinning="loading">
      <a-form-model ref="form" :model="entity" :rules="rules">
        
        <!-- 基本信息 -->
        <a-divider orientation="left">
          <span style="font-size: 16px; font-weight: 500;">
            <a-icon type="file-text" style="margin-right: 8px;" />
            基本信息
          </span>
        </a-divider>
        
        <a-row :gutter="16">
          <a-col :span="24">
            <a-form-model-item label="文章标题" prop="Title" :label-col="{ span: 3 }" :wrapper-col="{ span: 20 }">
              <a-input 
                v-model="entity.Title" 
                placeholder="请输入文章标题" 
                allow-clear
                :maxLength="100">
                <a-icon slot="prefix" type="edit" style="color: rgba(0,0,0,.25)" />
              </a-input>
            </a-form-model-item>
          </a-col>
        </a-row>
        <a-row :gutter="16">
          <a-col :span="24">
            <a-form-model-item label="文章摘要" prop="Summary" :label-col="{ span: 3 }" :wrapper-col="{ span: 20 }">
              <a-textarea 
                v-model="entity.Summary" 
                placeholder="请输入文章摘要（选填）" 
                :rows="3" 
                allow-clear
                :maxLength="500"
                show-count />
            </a-form-model-item>
          </a-col>
        </a-row>
        <a-row :gutter="16">
          <a-col :span="24">
            <a-form-model-item label="文章内容" prop="Content" :label-col="{ span: 3 }" :wrapper-col="{ span: 20 }">
              <WangEditor v-model="entity.Content" />
            </a-form-model-item>
          </a-col>
        </a-row>
        <a-row :gutter="16">
          <a-col :span="24">
            <a-form-model-item label="封面图片" prop="CoverImage" :label-col="{ span: 3 }" :wrapper-col="{ span: 20 }">
              <c-upload-img 
                ref="coverImageUpload" 
                v-model="entity.CoverImage" 
                :maxCount="1" 
                placeholder="请上传封面图片（选填）" />
            </a-form-model-item>
          </a-col>
        </a-row>
        <a-row :gutter="16">
          <a-col :span="12">
            <a-form-model-item label="文章分类" prop="CategoryId" :label-col="{ span: 6 }" :wrapper-col="{ span: 17 }">
              <a-select 
                v-model="entity.CategoryId" 
                placeholder="请选择文章分类" 
                show-search 
                :filter-option="filterOption">
                <a-icon slot="suffixIcon" type="folder" />
                <a-select-option v-for="category in categoryList" :key="category.Id" :value="category.Id">
                  {{ category.Name }}
                </a-select-option>
              </a-select>
            </a-form-model-item>
          </a-col>
          
          <a-col :span="12">
            <a-form-model-item label="文章作者" prop="AuthorId" :label-col="{ span: 6 }" :wrapper-col="{ span: 17 }">
              <a-select 
                v-model="entity.AuthorId" 
                placeholder="请选择作者" 
                show-search 
                :filter-option="filterOption">
                <a-icon slot="suffixIcon" type="user" />
                <a-select-option v-for="user in userList" :key="user.Id" :value="user.Id">
                  {{ user.UserName }}
                </a-select-option>
              </a-select>
            </a-form-model-item>
          </a-col>
        </a-row>
        <!-- 发布设置 -->
        <a-divider orientation="left">
          <span style="font-size: 16px; font-weight: 500;">
            <a-icon type="setting" style="margin-right: 8px;" />
            发布设置
          </span>
        </a-divider>
        <a-row :gutter="16">
          <a-col :span="12">
            <a-form-model-item label="文章状态" prop="Status" :label-col="{ span: 6 }" :wrapper-col="{ span: 17 }">
              <a-select v-model="entity.Status" placeholder="请选择文章状态">
                <a-select-option :value="0">
                  <a-tag color="orange">草稿</a-tag>
                </a-select-option>
                <a-select-option :value="1">
                  <a-tag color="green">已发布</a-tag>
                </a-select-option>
                <a-select-option :value="2">
                  <a-tag color="red">已隐藏</a-tag>
                </a-select-option>
              </a-select>
            </a-form-model-item>
          </a-col>
          
          <a-col :span="12">
            <a-form-model-item label="发布时间" prop="PublishTime" :label-col="{ span: 6 }" :wrapper-col="{ span: 17 }">
              <a-date-picker 
                v-model="publishTimeValue" 
                show-time 
                format="YYYY-MM-DD HH:mm:ss" 
                style="width: 100%"
                placeholder="请选择发布时间（选填）">
                <a-icon slot="suffixIcon" type="clock-circle" />
              </a-date-picker>
            </a-form-model-item>
          </a-col>
        </a-row>
        <a-row :gutter="16">
          <a-col :span="12">
            <a-form-model-item label="是否置顶" prop="IsTop" :label-col="{ span: 6 }" :wrapper-col="{ span: 17 }">
              <a-switch 
                :checked="entity.IsTop === 1"
                @change="(checked) => entity.IsTop = checked ? 1 : 0"
                checked-children="开" 
                un-checked-children="关">
                <a-icon slot="checkedChildren" type="pushpin" />
                <a-icon slot="unCheckedChildren" type="pushpin" />
              </a-switch>
              <span style="margin-left: 12px; color: #f5222d;" v-if="entity.IsTop === 1">
                <a-icon type="fire" /> 已置顶
              </span>
              <span style="margin-left: 12px; color: #999;" v-else>
                未置顶
              </span>
            </a-form-model-item>
          </a-col>
          <a-col :span="12">
            <a-form-model-item label="是否推荐" prop="IsRecommend" :label-col="{ span: 6 }" :wrapper-col="{ span: 17 }">
              <a-switch 
                :checked="entity.IsRecommend === 1"
                @change="(checked) => entity.IsRecommend = checked ? 1 : 0"
                checked-children="开" 
                un-checked-children="关">
                <a-icon slot="checkedChildren" type="star" />
                <a-icon slot="unCheckedChildren" type="star" />
              </a-switch>
              <span style="margin-left: 12px; color: #1890ff;" v-if="entity.IsRecommend === 1">
                <a-icon type="star" theme="filled" /> 已推荐
              </span>
              <span style="margin-left: 12px; color: #999;" v-else>
                未推荐
              </span>
            </a-form-model-item>
          </a-col>
        </a-row>
        <a-row :gutter="16">
          <a-col :span="12">
            <a-form-model-item label="允许评论" prop="AllowComment" :label-col="{ span: 6 }" :wrapper-col="{ span: 17 }">
              <a-switch 
                :checked="entity.AllowComment === 1"
                @change="(checked) => entity.AllowComment = checked ? 1 : 0"
                checked-children="开" 
                un-checked-children="关">
                <a-icon slot="checkedChildren" type="message" />
                <a-icon slot="unCheckedChildren" type="message" />
              </a-switch>
              <span style="margin-left: 12px; color: #52c41a;" v-if="entity.AllowComment === 1">
                <a-icon type="check-circle" /> 允许评论
              </span>
              <span style="margin-left: 12px; color: #999;" v-else>
                <a-icon type="close-circle" /> 禁止评论
              </span>
            </a-form-model-item>
          </a-col>
          <a-col :span="12">
            <a-form-model-item label="是否删除" prop="IsDeleted" :label-col="{ span: 6 }" :wrapper-col="{ span: 17 }">
              <a-switch 
                :checked="entity.IsDeleted === 1"
                @change="(checked) => entity.IsDeleted = checked ? 1 : 0"
                checked-children="是" 
                un-checked-children="否">
                <a-icon slot="checkedChildren" type="delete" />
                <a-icon slot="unCheckedChildren" type="check" />
              </a-switch>
              <span style="margin-left: 12px; color: #f5222d;" v-if="entity.IsDeleted === 1">
                <a-icon type="exclamation-circle" /> 已删除
              </span>
              <span style="margin-left: 12px; color: #52c41a;" v-else>
                <a-icon type="check-circle" /> 正常
              </span>
            </a-form-model-item>
          </a-col>
        </a-row>
        <!-- 数据统计 -->
        <a-divider orientation="left">
          <span style="font-size: 16px; font-weight: 500;">
            <a-icon type="bar-chart" style="margin-right: 8px;" />
            数据统计
          </span>
        </a-divider>
        <a-row :gutter="16">
          <a-col :span="8">
            <a-form-model-item label="阅读量" prop="ViewCount" :label-col="{ span: 9 }" :wrapper-col="{ span: 14 }">
              <a-input-number 
                v-model="entity.ViewCount" 
                :min="0" 
                style="width: 100%" 
                placeholder="阅读量">
                <a-icon slot="prefix" type="eye" style="color: #1890ff;" />
              </a-input-number>
            </a-form-model-item>
          </a-col>
          <a-col :span="8">
            <a-form-model-item label="点赞数" prop="LikeCount" :label-col="{ span: 9 }" :wrapper-col="{ span: 14 }">
              <a-input-number 
                v-model="entity.LikeCount" 
                :min="0" 
                style="width: 100%" 
                placeholder="点赞数">
                <a-icon slot="prefix" type="like" style="color: #f5222d;" />
              </a-input-number>
            </a-form-model-item>
          </a-col>
          <a-col :span="8">
            <a-form-model-item label="评论数" prop="CommentCount" :label-col="{ span: 9 }" :wrapper-col="{ span: 14 }">
              <a-input-number 
                v-model="entity.CommentCount" 
                :min="0" 
                style="width: 100%" 
                placeholder="评论数">
                <a-icon slot="prefix" type="message" style="color: #52c41a;" />
              </a-input-number>
            </a-form-model-item>
          </a-col>
        </a-row>
        
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
