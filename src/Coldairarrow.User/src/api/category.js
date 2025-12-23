import request from '@/utils/request'

/**
 * 获取分类列表
 */
export function getCategoryList () {
  return request({
    url: '/Blog_Manage/blog_category/GetDataList',
    method: 'post',
    data: {
      PageIndex: 1,
      PageRows: 100,
      SortField: 'SortIndex',
      SortType: 'asc',
      Search: { Status: 1 }
    }
  })
}

/**
 * 获取分类详情
 */
export function getCategoryDetail (id) {
  return request({
    url: '/Blog_Manage/blog_category/GetTheData',
    method: 'post',
    data: { id }
  })
}
