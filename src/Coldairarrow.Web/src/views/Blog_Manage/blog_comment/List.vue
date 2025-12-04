<template>
  <a-card :bordered="false">
    <div class="table-operator">
      <a-button type="primary" icon="plus" @click="hanldleAdd()">新建</a-button>
      <a-button type="danger" icon="delete" @click="handleDelete(selectedRowKeys)" :disabled="!hasSelected()"
        :loading="loading" style="margin-left: 8px;">删除</a-button>
      <a-button style="margin-left: 8px;" icon="redo" @click="getDataList()">刷新</a-button>
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
              <a-select allowClear v-model="queryParam.condition" placeholder="请选择" style="width: 30%;">
                <a-select-option value="ArticleTitle">文章</a-select-option>
                <a-select-option value="UserName">评论用户</a-select-option>
                <a-select-option value="Content">评论内容</a-select-option>
                <a-select-option value="ParentContent">父评论</a-select-option>
                <a-select-option value="ReplyToUserName">回复的目标用户</a-select-option>
              </a-select>
              <a-input v-model="queryParam.keyword" placeholder="关键字" style="width: 70%;" />
            </a-form-item>
          </a-col>
          <a-col :xxl="3" :xl="4" :lg="6" :md="8" :sm="12">
            <a-form-item label="状态">
              <a-select allowClear v-model="queryParam.status" placeholder="全部">
                <a-select-option :value="0">已删除</a-select-option>
                <a-select-option :value="1">正常</a-select-option>
                <a-select-option :value="2">已屏蔽</a-select-option>
              </a-select>
            </a-form-item>
          </a-col>
          <a-col :xxl="3" :xl="4" :lg="6" :md="8" :sm="12">
            <a-form-item label="是否删除">
              <a-select allowClear v-model="queryParam.isDeleted" placeholder="全部">
                <a-select-option :value="false">否</a-select-option>
                <a-select-option :value="true">是</a-select-option>
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

    <a-table ref="table" :columns="columns" :rowKey="row => row.Id" :dataSource="treeData" :rowClassName="rowClassName"
      :childrenColumnName="'children'" :pagination="pagination" :loading="loading" @change="handleTableChange"
      :defaultExpandAllRows="false" :expandedRowKeys="expandedRowKeys" @expand="handleExpand"
      :rowSelection="{ selectedRowKeys: selectedRowKeys, onChange: onSelectChange }" :bordered="true" size="middle"
      :locale="{ emptyText: '暂无数据' }" :expandIcon="() => null" :indexSize="0">

      <span slot="indexRender" slot-scope="text, record, index">
        <div class="index-cell">
          <span v-if="record.children && record.children.length > 0" class="expand-icon" @click.stop="toggleExpand(record.Id)">
            <a-icon :type="expandedRowKeys.includes(record.Id) ? 'minus-square' : 'plus-square'" />
          </span>
          <span v-else class="expand-icon-placeholder"></span>
          <span :class="{'child-index': record.ParentId}">{{ index + 1 }}</span>
        </div>
      </span>

      <span slot="userName" slot-scope="text, record">
        <span v-if="record.ParentId" class="child-user">
          <a-icon type="enter" class="reply-icon" />
          {{ text }}
        </span>
        <span v-else class="parent-user">{{ text }}</span>
      </span>

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
        <a-tag v-if="text === 1" color="red">是</a-tag>
        <a-tag v-else color="green">否</a-tag>
      </span>
      <span slot="action" slot-scope="text, record">
        <template>
          <a v-if="record.children && record.children.length > 0" @click="toggleExpand(record.Id)">
            {{ expandedRowKeys.includes(record.Id) ? '收起' : '展开' }}
          </a>
          <a-divider v-if="record.children && record.children.length > 0" type="vertical" />

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
  { title: '序号', dataIndex: 'Id', align: 'center', width: '5%', scopedSlots: { customRender: 'indexRender' } },
  { title: '文章', dataIndex: 'ArticleTitle', width: '10%' },
  { title: '评论用户', dataIndex: 'UserName', align: 'center', width: '10%',scopedSlots: { customRender: 'userName' } },
  { title: '评论内容', dataIndex: 'Content', width: '10%', scopedSlots: { customRender: 'content' } },
  { title: '父评论', dataIndex: 'ParentContent', width: '10%', scopedSlots: { customRender: 'parentContent' } },
  { title: '回复的目标用户', dataIndex: 'ReplyToUserName', align: 'center', width: '10%' },
  { title: '点赞数', dataIndex: 'LikeCount', align: 'center', width: '10%' },
  { title: '状态', dataIndex: 'Status', width: '10%', align: 'center', scopedSlots: { customRender: 'status' } },
  { title: '是否删除', dataIndex: 'IsDeleted', width: '10%', align: 'center', scopedSlots: { customRender: 'isDeleted' } },
  { title: '操作', dataIndex: 'action', align: 'center', scopedSlots: { customRender: 'action' }, width: '20%' }
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
      treeData: [],
      expandedRowKeys: [],
      pagination: {
        current: 1,
        pageSize: 10,
        showSizeChanger: true,
        showQuickJumper: true,
        pageSizeOptions: ['10', '20', '50', '100'],
        showTotal: (total, range) => `共 ${total} 条记录 第 ${range[0]}-${range[1]} 条`
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
    rowClassName(record) {
      return record.ParentId ? 'child-comment-row' : 'parent-comment-row'
    },
    getRowIndex(record) {
      const index = this.data.findIndex(item => item.Id === record.Id)
      return index !== -1 ? index + 1 : '-'
    },
    convertToTree(list) {
      if (!list || list.length === 0) return []

      const map = {}
      const roots = []

      // 第一步：创建映射
      list.forEach(item => {
        map[item.Id] = { ...item, children: [] }
      })

      // 第二步：建立父子关系
      list.forEach(item => {
        const node = map[item.Id]

        // 判断是否有父评论
        // ParentId 为空字符串、null、undefined、'0' 或 0 都视为顶级评论
        if (item.ParentId &&
          item.ParentId !== '' &&
          item.ParentId !== '0' &&
          item.ParentId !== 0 &&
          map[item.ParentId]) {
          // 有父评论，添加到父节点的 children
          map[item.ParentId].children.push(node)
        } else {
          // 没有父评论，作为顶级评论
          roots.push(node)
        }
      })
      // 第三步：清理空 children
      const cleanChildren = (nodes) => {
        nodes.forEach(node => {
          if (node.children && node.children.length > 0) {
            cleanChildren(node.children)
          } else {
            delete node.children
          }
        })
      }
      cleanChildren(roots)
      return roots
    },
    handleExpand(expanded, record) {
      if (expanded) {
        if (!this.expandedRowKeys.includes(record.Id)) {
          this.expandedRowKeys.push(record.Id)
        }
      } else {
        this.expandedRowKeys = this.expandedRowKeys.filter(key => key !== record.Id)
      }
    },

    // 手动切换展开状态
    toggleExpand(id) {
      const index = this.expandedRowKeys.indexOf(id)
      if (index > -1) {
        // 已展开，则收起
        this.expandedRowKeys.splice(index, 1)
      } else {
        // 未展开，则展开
        this.expandedRowKeys.push(id)
      }
    },
    handleSearch() {
      this.pagination.current = 1
      this.getDataList()
    },

    handleReset() {
      this.queryParam = {}
      this.pagination.current = 1
      this.getDataList()
    },

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
      this.pagination = { ...this.pagination, ...pagination }
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
          this.treeData = this.convertToTree(resJson.Data)

          const pagination = { ...this.pagination }
          pagination.total = resJson.Total
          this.pagination = pagination
        })
        .catch(error => {
          this.loading = false
          console.error('请求失败:', error)
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
<style scoped>
.content-preview {
  max-width: 200px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
/* 序号列布局 */
.index-cell {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}
/* 展开图标 */
.expand-icon {
  cursor: pointer;
  color: #1890ff;
  font-size: 16px;
  display: inline-flex;
  align-items: center;
}
.expand-icon:hover {
  color: #40a9ff;
}
.expand-icon-placeholder {
  display: inline-block;
  width: 16px;
}
/* 子评论序号样式 */
.child-index {
  color: #1890ff;
  font-weight: 500;
}
/* 子评论内容样式 */
.child-content {
  color: #595959;
  font-style: italic;
}
/* 父评论行样式 */
::v-deep .parent-comment-row {
  background-color: #ffffff;
}
::v-deep .parent-comment-row:hover {
  background-color: #fafafa !important;
}
/* 子评论行样式 */
::v-deep .child-comment-row {
  background-color: #f0f5ff !important;
  border-left: 3px solid #1890ff;
}
::v-deep .child-comment-row:hover {
  background-color: #d6e4ff !important;
}
/* 子评论用户名样式 */
.child-user {
  color: #1890ff;
  font-weight: 500;
}
.parent-user {
  color: #262626;
  font-weight: 500;
}
/* 回复图标 */
.reply-icon {
  margin-right: 6px;
  font-size: 14px;
}
/* 展开链接样式 */
.expand-link {
  color: #1890ff;
  font-weight: 500;
  display: inline-flex;
  align-items: center;
  gap: 4px;
}
.expand-link:hover {
  color: #40a9ff;
}
</style>