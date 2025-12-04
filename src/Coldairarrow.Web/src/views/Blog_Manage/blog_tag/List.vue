<template>
  <a-card :bordered="false">
    <div class="table-operator">
      <a-button type="primary" icon="plus" @click="hanldleAdd()">新建</a-button>
      <a-button type="danger" icon="delete" @click="handleDelete(selectedRowKeys)" :disabled="!hasSelected()"
        :loading="loading" style="margin-left: 8px;">删除</a-button>
      <a-button icon="redo" style="margin-left: 8px;" @click="getDataList()">刷新</a-button>
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
                  <a-select-option value="Name">标签名称</a-select-option>
                  <a-select-option value="Color">标签颜色</a-select-option>
                </a-select>
                <a-input style="width: 70%;" allow-clear v-model="queryParam.keyword" placeholder="请输入查询关键字"
                  @pressEnter="handleSearch" />
              </a-input-group>
            </a-form-item>
          </a-col>
          <a-col :xxl="4" :xl="4" :lg="4" :md="12" :sm="24">
            <a-form-item label="是否删除" style="width: 100%;">
              <a-select allowClear v-model="queryParam.isDeleted" style="width: 100%;" placeholder="全部">
                <a-select-option :value="1">是</a-select-option>
                <a-select-option :value="0">否</a-select-option>
              </a-select>
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
      <span slot="color" slot-scope="text">
        <div style="display: flex; align-items: center; gap: 8px;">
          <div :style="{
            width: '32px',
            height: '32px',
            backgroundColor: text || '#f0f0f0',
            borderRadius: '4px',
            border: '1px solid #d9d9d9'
          }"></div>
          <a-tag :color="text">{{ text || '未设置' }}</a-tag>
        </div>
      </span>
      <span slot="articleCount" slot-scope="text">
        <span style="color: #1890ff;">{{ text || 0 }}</span>
      </span>
      <span slot="isDeleted" slot-scope="text">
        <a-tag v-if="text === 1" color="red">是</a-tag>
        <a-tag v-else color="green">否</a-tag>
      </span>
      <span slot="action" slot-scope="text, record">
        <a @click="handleEdit(record.Id)">编辑</a>
        <a-divider type="vertical" />
        <a-dropdown>
          <a class="ant-dropdown-link" @click="e => e.preventDefault()">
            更多 <a-icon type="down" />
          </a>
          <a-menu slot="overlay">
            <a-menu-item @click="handleViewDetail(record)">
              <a-icon type="eye" style="color: #1890ff;" />
              查看详情
            </a-menu-item>
            <a-menu-item v-if="record.ArticleCount > 0" @click="handleViewArticles(record)">
              <a-icon type="file-text" style="color: #52c41a;" />
              查看文章 ({{ record.ArticleCount }})
            </a-menu-item>
            <a-menu-divider />
            <a-menu-item @click="handleDelete([record.Id])">
              <a-icon type="delete" style="color: #f5222d;" />
              删除标签
            </a-menu-item>
          </a-menu>
        </a-dropdown>
      </span>
    </a-table>

    <edit-form ref="editForm" @success="getDataList"></edit-form>
  </a-card>
</template>

<script>
import EditForm from './EditForm'

const columns = [
  {
    title: '序号',
    dataIndex: 'Id',
    width: '5%',
    align: 'center',
    customRender: (text, record, index) => index + 1
  },
  {
    title: '标签名称',
    dataIndex: 'Name',
    align: 'center',
    width: '10%',
    ellipsis: true
  },
  {
    title: '标签颜色',
    dataIndex: 'Color',
    width: '15%',
    align: 'center',
    scopedSlots: { customRender: 'color' }
  },
  {
    title: '文章数量',
    dataIndex: 'ArticleCount',
    width: '10%',
    align: 'center',
    scopedSlots: { customRender: 'articleCount' }
  },
  {
    title: '是否删除',
    dataIndex: 'IsDeleted',
    width: '10%',
    align: 'center',
    scopedSlots: { customRender: 'isDeleted' }
  },
  {
    title: '操作',
    dataIndex: 'action',
    align: 'center',
    scopedSlots: { customRender: 'action' }
  }
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
        showSizeChanger: true,
        showQuickJumper: true,
        pageSizeOptions: ['10', '20', '50', '100'],
        showTotal: (total, range) => `共 ${total} 条记录 第 ${range[0]}-${range[1]} 条`
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
        .post('/Blog_Manage/blog_tag/GetDataList', {
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
    handleSearch() {
      this.pagination.current = 1
      this.getDataList()
    },
    hasSelected() {
      return this.selectedRowKeys.length > 0
    },
    hanldleAdd() {
      this.$refs.editForm.openForm(null, '新建表单')
    },
    handleEdit(id) {
      this.$refs.editForm.openForm(id, '编辑表单')
    },
    handleDelete(ids) {
      var thisObj = this
      this.$confirm({
        title: '确认删除吗?',
        onOk() {
          return new Promise((resolve, reject) => {
            thisObj.$http.post('/Blog_Manage/blog_tag/DeleteData', ids).then(resJson => {
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
    },
    handleViewDetail(record) {
      this.$info({
        title: '标签详情',
        width: 500,
        content: (
          <div style="padding: 10px;">
            <p><strong>标签名称：</strong>{record.Name}</p>
            <p><strong>标签颜色：</strong>
              <a-tag color={record.Color}>{record.Color}</a-tag>
            </p>
            <p><strong>文章数量：</strong>{record.ArticleCount || 0}</p>
            <p><strong>是否删除：</strong>{record.IsDeleted === 1 ? '是' : '否'}</p>
          </div>
        ),
        onOk() { }
      })
    },
    handleViewArticles(record) {
      // 跳转到文章列表页面，并筛选该标签的文章
      this.$message.info(`查看标签"${record.Name}"的相关文章（功能待实现）`)
      // 实际项目中可以这样跳转：
      // this.$router.push({ path: '/article/list', query: { tagId: record.Id } })
    },
    handleDelete(ids) {
      var thisObj = this
      this.$confirm({
        title: '确认删除吗?',
        content: `即将删除 ${ids.length} 条数据，此操作不可恢复`,
        okText: '确认',
        okType: 'danger',
        cancelText: '取消',
        onOk() {
          return new Promise((resolve, reject) => {
            thisObj.$http.post('/Blog_Manage/blog_tag/DeleteData', ids).then(resJson => {
              resolve()
              if (resJson.Success) {
                thisObj.$message.success('操作成功!')
                thisObj.getDataList()
              } else {
                thisObj.$message.error(resJson.Msg)
              }
            }).catch(() => {
              reject()
            })
          })
        }
      })
    }
  }
}
</script>