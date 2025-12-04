<template>
  <a-card :bordered="false">
    <div class="table-operator">
        <a-button type="primary" icon="plus" @click="hanldleAdd()">新建</a-button>
        <a-button type="danger" icon="delete" @click="handleDelete(selectedRowKeys)" :disabled="!hasSelected()"
          :loading="loading" style="margin-left: 8px;">删除</a-button>
        <a-button  icon="redo" style="margin-left: 8px;" @click="getDataList()">刷新</a-button>
        <span v-if="hasSelected()" style="margin-left: 16px; color: #1890ff;">
          已选择 {{ selectedRowKeys.length }} 项
        </span>
    </div>

    <div class="table-page-search-wrapper"
      style="background: #f5f5f5; padding: 16px; border-radius: 4px; margin-bottom: 16px;">
      <a-form layout="inline">
        <a-row :gutter="16">
          <a-col :xxl="8" :xl="10" :lg="12" :md="24" :sm="24">
            <a-form-item label="关键字查询" style="width: 100%;">
              <a-input-group compact>
                <a-select allowClear v-model="queryParam.condition" placeholder="请选择" style="width: 30%;">
                  <a-select-option value="ArticleTitle">文章</a-select-option>
                  <a-select-option value="UserName">用户</a-select-option>
                </a-select>
                <a-input style="width: 70%;" allow-clear v-model="queryParam.keyword" placeholder="请输入查询关键字"
                  @pressEnter="handleSearch" />
              </a-input-group>
            </a-form-item>
          </a-col>
          <a-col :xxl="8" :xl="8" :lg="12" :md="24" :sm="24">
            <a-form-item label="点赞时间" style="width: 100%;">
              <a-range-picker v-model="dateRange" format="YYYY-MM-DD" :placeholder="['开始日期', '结束日期']"
                style="width: 100%" @change="handleDateChange" />
            </a-form-item>
          </a-col>
          <a-col :xxl="4" :xl="4" :lg="6" :md="12" :sm="12">
            <a-form-item label=" " :colon="false">
              <a-button type="primary" icon="search" @click="handleSearch">
                查询
              </a-button>
              <a-button icon="reload" @click="handleReset" style="margin-left: 2px;">
                重置
              </a-button>
            </a-form-item>
          </a-col>
        </a-row>
      </a-form>
    </div>

    <a-table ref="table" :columns="columns" :rowKey="row => row.Id" :dataSource="data" :pagination="pagination"
      :loading="loading" @change="handleTableChange"
      :rowSelection="{ selectedRowKeys: selectedRowKeys, onChange: onSelectChange }" :bordered="true" size="middle"
      :locale="{ emptyText: '暂无数据' }">
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
  { title: '序号', dataIndex: 'Id', align:'center', width: '5%', customRender: (text, record, index) => index + 1 },
  { title: '文章', dataIndex: 'ArticleTitle', width: '20%' },
  { title: '用户', dataIndex: 'UserName',align:'center', width: '10%' },
  {
    title: '点赞时间', dataIndex: 'CreatedTime', width: '15%', align:'center', customRender: (text) => {
      if (!text) return '-'
      return text.replace(/\.\d{3}$/, '')
    }
  },
  { title: '操作', dataIndex: 'action', align:'center', scopedSlots: { customRender: 'action' } }
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
      selectedRowKeys: [],
      dateRange: []
    }
  },
  methods: {
    handleSearch() {
      this.pagination.current = 1
      this.getDataList()
    },
    handleReset() {
      this.queryParam = { condition: 'Title' }
      this.pagination.current = 1
      this.getDataList()
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
        .post('/Blog_Manage/blog_like/GetDataList', {
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
    handleDateChange(dates, dateStrings) {
      if (dates && dates.length === 2) {
        this.queryParam.startTime = dateStrings[0] + ' 00:00:00'
        this.queryParam.endTime = dateStrings[1] + ' 23:59:59'
      } else {
        delete this.queryParam.startTime
        delete this.queryParam.endTime
      }
    },
    onSelectChange(selectedRowKeys) {
      this.selectedRowKeys = selectedRowKeys
    },
    hasSelected() {
      return this.selectedRowKeys.length > 0
    },
    hanldleAdd() {
      this.$refs.editForm.openForm(null, '新建点赞')
    },
    handleEdit(id) {
      this.$refs.editForm.openForm(id, '编辑点赞')
    },
    handleSearch() {
      this.pagination.current = 1
      this.getDataList()
    },
    handleReset() {
      this.queryParam = {}
      this.dateRange = []
      this.pagination.current = 1
      this.getDataList()
    },
    handleDelete(ids) {
      var thisObj = this
      this.$confirm({
        title: '确认删除吗?',
        onOk() {
          return new Promise((resolve, reject) => {
            thisObj.$http.post('/Blog_Manage/blog_like/DeleteData', ids).then(resJson => {
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