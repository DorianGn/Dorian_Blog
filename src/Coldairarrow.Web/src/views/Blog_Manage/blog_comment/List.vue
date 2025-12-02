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
              <a-select allowClear v-model="queryParam.condition" placeholder="请选择">
                <a-select-option value="ArticleTitle">文章</a-select-option>
                <a-select-option value="UserName">评论用户</a-select-option>
                <a-select-option value="Content">评论内容</a-select-option>
                <a-select-option value="ParentContent">父评论</a-select-option>
                <a-select-option value="ReplyToUserName">回复的目标用户</a-select-option>
              </a-select>
            </a-form-item>
          </a-col>
          <a-col :md="4" :sm="24">
            <a-form-item>
              <a-input v-model="queryParam.keyword" placeholder="关键字" />
            </a-form-item>
          </a-col>
          <a-col :md="4" :sm="24">
            <a-form-item label="状态">
              <a-select allowClear v-model="queryParam.status" placeholder="请选择状态">
                <a-select-option :value="0">已删除</a-select-option>
                <a-select-option :value="1">正常</a-select-option>
                <a-select-option :value="2">已屏蔽</a-select-option>
              </a-select>
            </a-form-item>
          </a-col>
          <a-col :md="4" :sm="24">
            <a-form-item label="是否删除">
              <a-select allowClear v-model="queryParam.isDeleted" placeholder="请选择">
                <a-select-option :value="false">否</a-select-option>
                <a-select-option :value="true">是</a-select-option>
              </a-select>
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
      :loading="loading" @change="handleTableChange"
      :rowSelection="{ selectedRowKeys: selectedRowKeys, onChange: onSelectChange }" :bordered="true" size="small">
            
      <span slot="parentContent" slot-scope="text">
        <a-tooltip v-if="text" :title="stripHtml(text)">
          <div class="content-preview">{{ stripHtml(text) }}</div>
        </a-tooltip>
        <span v-else>-</span>
      </span>
      <span slot="content" slot-scope="text">
        <a-tooltip v-if="text" :title="stripHtml(text)">
          <div class="content-preview">{{ stripHtml(text) }}</div>
        </a-tooltip>
        <span v-else>-</span>
      </span>
      
      <span slot="status" slot-scope="text">
        <a-tag :color="getStatusColor(text)">{{ getStatusText(text) }}</a-tag>
      </span>
      
      <span slot="isDeleted" slot-scope="text">
        <a-tag :color="text ? 'red' : 'green'">{{ text ? '是' : '否' }}</a-tag>
      </span>
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
  { title: '序号', dataIndex: 'Id', width: '5%', customRender: (text, record, index) => index + 1 },
  { title: '文章', dataIndex: 'ArticleTitle', width: '10%' },
  { title: '评论用户', dataIndex: 'UserName', width: '10%' },
  { title: '评论内容', dataIndex: 'Content', width: '10%',scopedSlots: { customRender: 'content' } },
  { title: '父评论', dataIndex: 'ParentContent', width: '10%',scopedSlots: { customRender: 'parentContent' } },
  { title: '回复的目标用户', dataIndex: 'ReplyToUserName', width: '10%' },
  { title: '点赞数', dataIndex: 'LikeCount', width: '10%' },
  {
    title: '状态', dataIndex: 'Status', width: '10%', scopedSlots: { customRender: 'status' }
  },
  { title: '是否删除', dataIndex: 'IsDeleted', width: '10%', scopedSlots: { customRender: 'isDeleted' } },
  { title: '操作', dataIndex: 'action', scopedSlots: { customRender: 'action' } }
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
      sorter: { field: 'Id', order: 'desc' },
      loading: false,
      columns,
      queryParam: {},
      selectedRowKeys: []
    }
  },
  methods: {
    getStatusColor(status) {
      const colorMap = { 0: 'red', 1: 'green', 2: 'orange' }
      return colorMap[status] || 'default'
    },
    getStatusText(status) {
      const statusMap = { 0: '已删除', 1: '正常', 2: '已屏蔽' }
      return statusMap[status] || '未知'
    },
    stripHtml(html) {
      if (!html) return ''
      const tmp = document.createElement('div')
      tmp.innerHTML = html
      const text = tmp.textContent || tmp.innerText || ''
      return text.length > 50 ? text.substring(0, 50) + '...' : text
    }, 
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
        .post('/Blog_Manage/blog_comment/GetDataList', {
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
      this.$refs.editForm.openForm(null, '新建评论')
    },
    handleEdit(id) {
      this.$refs.editForm.openForm(id, '编辑评论')
    },
    handleDelete(ids) {
      var thisObj = this
      this.$confirm({
        title: '确认删除吗?',
        onOk() {
          return new Promise((resolve, reject) => {
            thisObj.$http.post('/Blog_Manage/blog_comment/DeleteData', ids).then(resJson => {
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