<template>
  <a-card :bordered="false">
    <div class="table-operator" style="margin-bottom: 16px;">
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
                  <a-select-option value="Name">分类名称</a-select-option>
                  <a-select-option value="Description">分类描述</a-select-option>
                </a-select>
                <a-input v-model="queryParam.keyword" allow-clear style="width: 70%;" @pressEnter="handleSearch"
                  placeholder="请输入查询关键字" />
              </a-input-group>
            </a-form-item>
          </a-col>

          <a-col :xl="4" :lg="4" :md="12" :sm="12">
            <a-form-item label="状态" style="width: 100%;">
              <a-select allowClear v-model="queryParam.Status" placeholder="全部" style="width: 100%;">
                <a-select-option :value="1">启用</a-select-option>
                <a-select-option :value="0">禁用</a-select-option>
              </a-select>
            </a-form-item>
          </a-col>
          <a-col :xxl="4" :xl="4" :lg="6" :md="12" :sm="12">
            <a-form-item label="是否删除" style="width: 100%;">
              <a-select allowClear v-model="queryParam.isDeleted" placeholder="全部" style="width: 100%;">
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

      <span slot="icon" slot-scope="text, record">
        <div style="display: flex; align-items: center; gap: 8px;">
          <div v-if="record.Icon" style="
            width: 40px;
            height: 40px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
          ">
            <a-icon :type="record.Icon" :style="{ fontSize: '24px', color: '#fff' }" />
          </div>
          <div v-else style="
            width: 40px;
            height: 40px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: #f5f5f5;
            border: 2px dashed #d9d9d9;
            border-radius: 8px;
          ">
            <a-icon type="question" :style="{ fontSize: '20px', color: '#bfbfbf' }" />
          </div>
          <span style="color: #666; font-size: 12px;">{{ record.Icon || '未设置' }}</span>
        </div>
      </span>

      <span slot="status" slot-scope="text">
        <a-tag v-if="text === 1" color="green">启用</a-tag>
        <a-tag v-else color="red">禁用</a-tag>
      </span>

      <span slot="isDeleted" slot-scope="text">
        <a-tag v-if="text === 1" color="red">是</a-tag>
        <a-tag v-else color="green">否</a-tag>
      </span>

      <span slot="articleCount" slot-scope="text">
        <span style="color: #1890ff;">{{ text || 0 }}</span>
      </span>

      <span slot="action" slot-scope="text, record">
        <a @click="handleEdit(record.Id)">编辑</a>
        <a-divider type="vertical" />
        <a-dropdown>
          <a class="ant-dropdown-link" @click="e => e.preventDefault()">
            更多 <a-icon type="down" />
          </a>
          <a-menu slot="overlay">
            <a-menu-item v-if="record.Status !== 1" @click="handleQuickUpdate(record.Id, { Status: 1 })">
              <a-icon type="check-circle" style="color: #52c41a;" />启用分类
            </a-menu-item>
            <a-menu-item v-if="record.Status === 1" @click="handleQuickUpdate(record.Id, { Status: 0 })">
              <a-icon type="close-circle" style="color: #f5222d;" />
              禁用分类
            </a-menu-item>
            <a-menu-divider />
            <a-menu-item @click="handleDelete([record.Id])">
              <a-icon type="delete" style="color: #f5222d;" />删除分类
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
  { title: '序号', dataIndex: 'Id', width: '5%', align: 'center', customRender: (text, record, index) => index + 1 },
  { title: '分类名称', dataIndex: 'Name', align: 'center', width: '10%', ellipsis: true },
  { title: '分类描述', dataIndex: 'Description', width: '20%', ellipsis: true },
  { title: '分类图标', dataIndex: 'Icon', width: '15%', align: 'center', scopedSlots: { customRender: 'icon' } },
  { title: '排序号', dataIndex: 'SortIndex', align: 'center', width: '10%' },
  { title: '状态', dataIndex: 'Status', align: 'center', width: '10%', scopedSlots: { customRender: 'status' } },
  { title: '文章数量', dataIndex: 'ArticleCount', align: 'center', width: '10%', scopedSlots: { customRender: 'articleCount' } },
  { title: '是否删除', dataIndex: 'IsDeleted', width: '10%', align: 'center', scopedSlots: { customRender: 'isDeleted' } },
  { title: '操作', dataIndex: 'action', align: 'center',width:'10%', scopedSlots: { customRender: 'action' } }
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
    handleQuickUpdate(id, updateData) {
      const thisObj = this
      this.loading = true
      this.$http.post('/Blog_Manage/blog_category/GetTheData', { id: id }).then(resJson => {
        if (resJson.Success) {
          const fullData = { ...resJson.Data, ...updateData }
          thisObj.$http.post('/Blog_Manage/blog_category/SaveData', fullData).then(saveRes => {
            thisObj.loading = false
            if (saveRes.Success) {
              thisObj.$message.success('操作成功!')
              thisObj.getDataList()
            } else {
              thisObj.$message.error(saveRes.Msg)
            }
          }).catch(() => {
            thisObj.loading = false
          })
        } else {
          thisObj.loading = false
          thisObj.$message.error(resJson.Msg)
        }
      }).catch(() => {
        thisObj.loading = false
      })
    },
    handleSearch() {
      this.pagination.current = 1
      this.getDataList()
    },
    handleReset() {
      this.queryParam = { condition: 'Name' }
      this.pagination.current = 1
      this.getDataList()
    },
    getDataList() {
      this.selectedRowKeys = []

      this.loading = true
      this.$http
        .post('/Blog_Manage/blog_category/GetDataList', {
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
      this.$refs.editForm.openForm(null, '新建分类')
    },
    handleEdit(id) {
      this.$refs.editForm.openForm(id, '编辑分类')
    },
    handleDelete(ids) {
      var thisObj = this
      this.$confirm({
        title: '确认删除吗?',
        onOk() {
          return new Promise((resolve, reject) => {
            thisObj.$http.post('/Blog_Manage/blog_category/DeleteData', ids).then(resJson => {
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
