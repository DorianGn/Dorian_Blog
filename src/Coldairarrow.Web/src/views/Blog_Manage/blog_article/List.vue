<template>
  <a-card :bordered="false">
    <div class="table-operator" style="margin-bottom: 16px;">
      <div style="display: inline-block;">
        <a-button type="primary" icon="plus" @click="hanldleAdd()">新建</a-button>
        <a-button type="danger" icon="delete" @click="handleDelete(selectedRowKeys)" :disabled="!hasSelected()"
          :loading="loading" style="margin-left: 8px;">
          删除
        </a-button>
        <a-button icon="redo" @click="getDataList()" style="margin-left: 8px;">刷新</a-button>
        <span v-if="hasSelected()" style="margin-left: 16px; color: #1890ff;">
          已选择 {{ selectedRowKeys.length }} 项
        </span>
      </div>
    </div>

    <div class="table-page-search-wrapper"
      style="background: #f5f5f5; padding: 16px; border-radius: 4px; margin-bottom: 16px;">
      <a-form layout="inline">
        <a-row :gutter="16">
          <a-col :xxl="8" :xl="10" :lg="12" :md="24" :sm="24">
            <a-form-item label="关键字查询" style="width: 100%;">
              <a-input-group compact>
                <a-select v-model="queryParam.condition" placeholder="请选择" style="width: 30%">
                  <a-select-option value="Title">文章标题</a-select-option>
                  <a-select-option value="Summary">文章摘要</a-select-option>
                  <a-select-option value="Content">文章内容</a-select-option>
                  <a-select-option value="CategoryName">分类名称</a-select-option>
                  <a-select-option value="AuthorName">作者名称</a-select-option>
                </a-select>
                <a-input v-model="queryParam.keyword" placeholder="请输入查询关键字" allow-clear style="width: 65%"
                  @pressEnter="handleSearch" />
              </a-input-group>
            </a-form-item>
          </a-col>
          <a-col :xxl="3" :xl="4" :lg="6" :md="8" :sm="12">
            <a-form-item label="状态" style="width: 100%;">
              <a-select allowClear v-model="queryParam.status" placeholder="全部" style="width: 100%">
                <a-select-option :value="0">草稿</a-select-option>
                <a-select-option :value="1">已发布</a-select-option>
                <a-select-option :value="2">已隐藏</a-select-option>
              </a-select>
            </a-form-item>
          </a-col>

          <a-col :xxl="3" :xl="4" :lg="6" :md="8" :sm="12">
            <a-form-item label="置顶" style="width: 100%;">
              <a-select allowClear v-model="queryParam.isTop" placeholder="全部" style="width: 100%">
                <a-select-option :value="0">否</a-select-option>
                <a-select-option :value="1">是</a-select-option>
              </a-select>
            </a-form-item>
          </a-col>

          <a-col :xxl="3" :xl="4" :lg="6" :md="8" :sm="12">
            <a-form-item label="推荐" style="width: 100%;">
              <a-select allowClear v-model="queryParam.isRecommend" placeholder="全部" style="width: 100%">
                <a-select-option :value="0">否</a-select-option>
                <a-select-option :value="1">是</a-select-option>
              </a-select>
            </a-form-item>
          </a-col>
          <a-col :xxl="3" :xl="4" :lg="6" :md="8" :sm="12">
            <a-form-item label="评论" style="width: 100%;">
              <a-select allowClear v-model="queryParam.allowComment" placeholder="全部" style="width: 100%">
                <a-select-option :value="0">否</a-select-option>
                <a-select-option :value="1">是</a-select-option>
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
      :loading="loading" @change="handleTableChange" :scroll="{ x: 2000, y: 600 }"
      :rowSelection="{ selectedRowKeys: selectedRowKeys, onChange: onSelectChange }" :bordered="true" size="middle"
      :locale="{ emptyText: '暂无数据' }">

      <span slot="coverImage" slot-scope="text, record">
        <img v-if="text" :src="getImageUrl(text, record.UpdatedTime)" alt="封面"
          style="max-width: 100px; max-height: 60px; object-fit: cover; border-radius: 4px;" loading="lazy" />
        <span v-else style="color: #999;">无封面</span>
      </span>

      <span slot="status" slot-scope="text">
        <a-tag v-if="text === 0" color="orange">草稿</a-tag>
        <a-tag v-else-if="text === 1" color="green">已发布</a-tag>
        <a-tag v-else-if="text === 2" color="red">已隐藏</a-tag>
        <span v-else>-</span>
      </span>

      <span slot="isTop" slot-scope="text">
        <a-tag v-if="text === 1" color="orange">是</a-tag>
        <a-tag v-else color="cyan">否</a-tag>
      </span>

      <span slot="isRecommend" slot-scope="text">
        <a-tag v-if="text === 1" color="blue">是</a-tag>
        <a-tag v-else color="geekblue">否</a-tag>
      </span>

      <span slot="allowComment" slot-scope="text">
        <a-tag v-if="text === 1" color="cyan"> 是</a-tag>
        <a-tag v-else color="purple">否</a-tag>
      </span>

      <span slot="isDeleted" slot-scope="text">
        <a-tag v-if="text === 1" color="red">是</a-tag>
        <a-tag v-else color="green">否</a-tag>
      </span>

      <span slot="viewCount" slot-scope="text">
        <span style="color: #1890ff;">{{ text || 0 }}</span>
      </span>
      <span slot="likeCount" slot-scope="text">
        <span style="color: #f5222d;">{{ text || 0 }}</span>
      </span>
      <span slot="commentCount" slot-scope="text">
        <span style="color: #52c41a;">{{ text || 0 }}</span>
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
              <a-icon type="check-circle" style="color: #52c41a;" />
              发布文章
            </a-menu-item>
            <a-menu-item v-if="record.Status === 1" @click="handleQuickUpdate(record.Id, { Status: 0 })">
              <a-icon type="file-text" style="color: #faad14;" />
              转为草稿
            </a-menu-item>
            <a-menu-item v-if="record.Status !== 2" @click="handleQuickUpdate(record.Id, { Status: 2 })">
              <a-icon type="eye-invisible" style="color: #f5222d;" />
              隐藏文章
            </a-menu-item>

            <a-menu-divider />

            <a-menu-item @click="handleQuickUpdate(record.Id, { IsTop: record.IsTop === 1 ? 0 : 1 })">
              <a-icon :type="record.IsTop === 1 ? 'pushpin' : 'pushpin'"
                :style="{ color: record.IsTop === 1 ? '#999' : '#f5222d' }" />
              {{ record.IsTop === 1 ? '取消置顶' : '设为置顶' }}
            </a-menu-item>

            <a-menu-item @click="handleQuickUpdate(record.Id, { IsRecommend: record.IsRecommend === 1 ? 0 : 1 })">
              <a-icon type="star" :style="{ color: record.IsRecommend === 1 ? '#999' : '#1890ff' }" />
              {{ record.IsRecommend === 1 ? '取消推荐' : '设为推荐' }}
            </a-menu-item>

            <a-menu-item @click="handleQuickUpdate(record.Id, { AllowComment: record.AllowComment === 1 ? 0 : 1 })">
              <a-icon type="message" :style="{ color: record.AllowComment === 1 ? '#999' : '#52c41a' }" />
              {{ record.AllowComment === 1 ? '禁止评论' : '允许评论' }}
            </a-menu-item>

            <a-menu-divider />

            <a-menu-item @click="handleDelete([record.Id])">
              <a-icon type="delete" style="color: #f5222d;" />
              删除文章
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
    width: 80,
    fixed: 'left',
    align: 'center',
    customRender: (text, record, index) => index + 1
  },
  {
    title: '文章标题',
    dataIndex: 'Title',
    width: 285,
    fixed: 'left',
    ellipsis: true
  },
  {
    title: '文章摘要',
    dataIndex: 'Summary',
    width: 200,
    ellipsis: true,
    customRender: (text) => {
      if (!text) return '-'
      return text.length > 50 ? text.substring(0, 50) + '...' : text
    }
  },
  {
    title: '文章内容',
    dataIndex: 'Content',
    width: 300,
    ellipsis: true,
    customRender: (text) => {
      if (!text) return '-'
      const plainText = text.replace(/<[^>]+>/g, '')
      return plainText.length > 100 ? plainText.substring(0, 100) + '...' : plainText
    }
  },
  {
    title: '封面图片',
    dataIndex: 'CoverImage',
    width: 120,
    align: 'center',
    scopedSlots: { customRender: 'coverImage' }
  },
  {
    title: '分类',
    dataIndex: 'CategoryName',
    width: 100,
    align: 'center',
    ellipsis: true
  },
  {
    title: '作者',
    dataIndex: 'AuthorName',
    align: 'center',
    width: 100,
    ellipsis: true
  },
  {
    title: '文章状态',
    dataIndex: 'Status',
    align: 'center',
    width: 100,
    align: 'center',
    scopedSlots: { customRender: 'status' }
  },
  {
    title: '置顶',
    dataIndex: 'IsTop',
    align: 'center',
    width: 80,
    align: 'center',
    scopedSlots: { customRender: 'isTop' }
  },
  {
    title: '推荐',
    dataIndex: 'IsRecommend',
    width: 80,
    align: 'center',
    scopedSlots: { customRender: 'isRecommend' }
  },
  {
    title: '评论',
    dataIndex: 'AllowComment',
    width: 80,
    align: 'center',
    scopedSlots: { customRender: 'allowComment' }
  },
  {
    title: '阅读量',
    dataIndex: 'ViewCount',
    width: 100,
    align: 'center',
    scopedSlots: { customRender: 'viewCount' }
  },
  {
    title: '点赞数',
    dataIndex: 'LikeCount',
    width: 100,
    align: 'center',
    scopedSlots: { customRender: 'likeCount' }
  },
  {
    title: '评论数',
    dataIndex: 'CommentCount',
    width: 100,
    align: 'center',
    scopedSlots: { customRender: 'commentCount' }
  },
  {
    title: '发布时间',
    dataIndex: 'PublishTime',
    width: 160,
    align: 'center',
    customRender: (text) => {
      if (!text) return '-'
      return text.replace(/\.\d{3}$/, '')
    }
  },
  {
    title: '是否删除',
    dataIndex: 'IsDeleted',
    width: 100,
    align: 'center',
    scopedSlots: { customRender: 'isDeleted' }
  },
  {
    title: '操作',
    dataIndex: 'action',
    scopedSlots: { customRender: 'action' },
    width: 150,
    align: 'center'
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
    handleSearch() {
      this.pagination.current = 1
      this.getDataList()
    },
    handleReset() {
      this.queryParam = { condition: 'Title' }
      this.pagination.current = 1
      this.getDataList()
    },
    getImageUrl(url, updatedTime) {
      if (!url) return ''

      if (!updatedTime) {
        return url
      }

      try {
        let timeStr = updatedTime.replace(/\.\d{3}$/, '').replace(' ', 'T')
        let timestamp = new Date(timeStr).getTime()

        if (isNaN(timestamp)) {
          timestamp = updatedTime.split('').reduce((hash, char) => {
            return ((hash << 5) - hash) + char.charCodeAt(0)
          }, 0)
        }

        return `${url}?v=${Math.abs(timestamp)}`
      } catch (e) {
        console.error('时间解析错误:', e, updatedTime)
        return url
      }
    },
    handleQuickUpdate(id, updateData) {
      const thisObj = this
      this.loading = true
      this.$http.post('/Blog_Manage/blog_article/GetTheData', { id: id }).then(resJson => {
        if (resJson.Success) {
          const fullData = { ...resJson.Data, ...updateData }
          thisObj.$http.post('/Blog_Manage/blog_article/SaveData', fullData).then(saveRes => {
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
      this.$refs.editForm.openForm(null, '添加文章')
    },
    handleEdit(id) {
      this.$refs.editForm.openForm(id, '编辑文章')
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