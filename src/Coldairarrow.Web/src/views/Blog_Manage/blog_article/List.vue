<template>
  <a-card :bordered="false">
    <div class="table-operator">
      <a-button type="primary" icon="plus" @click="hanldleAdd()">新建</a-button>
      <a-button type="primary" icon="minus" @click="handleDelete(selectedRowKeys)" :disabled="!hasSelected()"
        :loading="loading">删除</a-button>
      <a-button type="primary" icon="redo" @click="getDataList()">刷新</a-button>
    </div>

    <div class="table-page-search-wrapper">
      <a-form layout="inline">
        <a-row :gutter="10">
          <a-col :md="4" :sm="24">
            <a-form-item label="查询类别">
              <a-select allowClear v-model="queryParam.condition">
                <a-select-option key="Title">文章标题</a-select-option>
                <a-select-option key="Summary">文章摘要</a-select-option>
                <a-select-option key="Content">文章内容</a-select-option>
                <a-select-option key="CoverImage">封面图片</a-select-option>
                <a-select-option key="CategoryId">分类</a-select-option>
                <a-select-option key="AuthorId">作者</a-select-option>
                <a-select-option key="UpdaterId">更新人</a-select-option>
              </a-select>
            </a-form-item>
          </a-col>
          <a-col :md="4" :sm="24">
            <a-form-item>
              <a-input v-model="queryParam.keyword" placeholder="关键字" />
            </a-form-item>
          </a-col>
          <a-col :md="6" :sm="24">
            <a-button type="primary" @click="() => { this.pagination.current = 1; this.getDataList() }">查询</a-button>
            <a-button style="margin-left: 8px" @click="() => (queryParam = {})">重置</a-button>
          </a-col>
        </a-row>
      </a-form>
    </div>

    <a-table ref="table" :columns="columns" :rowKey="row => row.Id" :dataSource="data" :pagination="pagination"
      :loading="loading" @change="handleTableChange" :scroll="{x:2000,y:600}"
      :rowSelection="{ selectedRowKeys: selectedRowKeys, onChange: onSelectChange }" :bordered="true" size="small">
      <span slot="action" slot-scope="text, record">
        <template>
          <a @click="handleEdit(record.Id)">编辑</a>
          <a-divider type="vertical" />
          <a @click="handleDelete([record.Id])">删除</a>
        </template>
      </span>
    </a-table>

    <edit-form ref="editForm" @success="getDataList"></edit-form>
  </a-card>
</template>

<script>
import EditForm from './EditForm'

const columns = [
  { title: '序号', dataIndex: 'Id', width: '10%' },
  { title: '文章标题', dataIndex: 'Title', width: '20%' },
  { title: '文章摘要', dataIndex: 'Summary', width: '20%' },
  { title: '文章内容', dataIndex: 'Content', width: '40%' },
  { title: '封面图片', dataIndex: 'CoverImage', width: '15%' },
  { title: '分类', dataIndex: 'CategoryId', width: '12%' },
  { title: '作者', dataIndex: 'AuthorId', width: '12%' },
  {
    title: '文章状态', dataIndex: 'Status', width: '14%', customRender: (text) => {
      const statusMap = { 0: '草稿', 1: '已发布', 2: '已隐藏' }
      return statusMap[text]
    }
  },
  {
    title: '是否置顶', dataIndex: 'IsTop', width: '14%', customRender: (text) => {
      const statusMap = { 0: '否', 1: '是' }
      return statusMap[text]
    }
  },
  {
    title: '是否推荐', dataIndex: 'IsRecommend', width: '14%', customRender: (text) => {
      const statusMap = { 0: '否', 1: '是' }
      return statusMap[text]
    }
  },
  {
    title: '是否允许评论', dataIndex: 'AllowComment', width: '14%', customRender: (text) => {
      const statusMap = { 0: '否', 1: '是' }
      return statusMap[text]
    }
  },
  { title: '阅读量', dataIndex: 'ViewCount', width: '12%' },
  { title: '点赞数', dataIndex: 'LikeCount', width: '12%' },
  { title: '评论数', dataIndex: 'CommentCount', width: '12%' },
  { title: '发布时间', dataIndex: 'PublishTime', width: '20%' },
  {
    title: '是否删除', dataIndex: 'IsDeleted', width: '14%', customRender: (text) => {
      const statusMap = { 0: '否', 1: '是' }
      return statusMap[text]
    }
  },
  { title: '创建时间', dataIndex: 'CreatedTime', width: '20%' },
  { title: '更新时间', dataIndex: 'UpdatedTime', width: '20%' },
  { title: '更新人', dataIndex: 'UpdaterId', width: '10%' },
  { title: '操作', dataIndex: 'action', scopedSlots: { customRender: 'action' }, width: '15%' }
]

export default {
  components: {
    EditForm
  },
  mounted() {
    this.getDataList()
  },
  data() {
    return {
      data: [],
      pagination: {
        current: 1,
        pageSize: 10,
        showTotal: (total, range) => `总数:${total} 当前:${range[0]}-${range[1]}`
      },
      filters: {},
      sorter: { field: 'Id', order: 'asc' },
      loading: false,
      columns,
      queryParam: {},
      selectedRowKeys: []
    }
  },
  methods: {
    handleTableChange(pagination, filters, sorter) {
      this.pagination = { ...pagination }
      this.filters = { ...filters }
      this.sorter = { ...sorter }
      this.getDataList()
    },
    getDataList() {
      this.selectedRowKeys = []

      this.loading = true
      this.$http
        .post('/Blog_Manage/blog_article/GetDataList', {
          PageIndex: this.pagination.current,
          PageRows: this.pagination.pageSize,
          SortField: this.sorter.field || 'Id',
          SortType: this.sorter.order,
          Search: this.queryParam,
          ...this.filters
        })
        .then(resJson => {
          this.loading = false
          this.data = resJson.Data
          const pagination = { ...this.pagination }
          pagination.total = resJson.Total
          this.pagination = pagination
        })
    },
    onSelectChange(selectedRowKeys) {
      this.selectedRowKeys = selectedRowKeys
    },
    hasSelected() {
      return this.selectedRowKeys.length > 0
    },
    hanldleAdd() {
      this.$refs.editForm.openForm(null,'添加文章')
    },
    handleEdit(id) {
      this.$refs.editForm.openForm(id,'编辑文章')
    },
    handleDelete(ids) {
      var thisObj = this
      this.$confirm({
        title: '确认删除吗?',
        onOk() {
          return new Promise((resolve, reject) => {
            thisObj.$http.post('/Blog_Manage/blog_article/DeleteData', ids).then(resJson => {
              resolve()

              if (resJson.Success) {
                thisObj.$message.success('操作成功!')

                thisObj.getDataList()
              } else {
                thisObj.$message.error(resJson.Msg)
              }
            })
          })
        }
      })
    }
  }
}
</script>