import request from '@/utils/request'

/**
 * 获取文章列表
 */
export function getArticleList (params) {
  return request({
    url: '/Blog_Manage/blog_article/GetDataList',
    method: 'post',
    data: {
      PageIndex: params.pageIndex || 1,
      PageRows: params.pageRows || 10,
      SortType: params.sortType || 'desc',
      Search: {
        Condition: params.condition || '',
        Keyword: params.keyword || '',
        Status: 1, // 只获取已发布的文章
        IsTop: params.isTop,
        IsRecommend: params.isRecommend,
        CategoryId: params.categoryId
      }
    }
  })
}

/**
 * 获取文章详情
 */
export function getArticleDetail (id) {
  return request({
    url: '/Blog_Manage/blog_article/GetTheData',
    method: 'post',
    data: { id }
  })
}

/**
 * 获取热门文章（按阅读量排序）
 */
export function getHotArticles (limit = 5) {
  return request({
    url: '/Blog_Manage/blog_article/GetDataList',
    method: 'post',
    data: {
      PageIndex: 1,
      PageRows: limit,
      SortType: 'desc',
      Search: { Status: 1 }
    }
  })
}

/**
 * 获取推荐文章
 */
export function getRecommendArticles (limit = 5) {
  return request({
    url: '/Blog_Manage/blog_article/GetDataList',
    method: 'post',
    data: {
      PageIndex: 1,
      PageRows: limit,
      SortType: 'desc',
      Search: {
        Status: 1,
        IsRecommend: 1
      }
    }
  })
}

/**
 * 获取置顶文章
 */
export function getTopArticles () {
  return request({
    url: '/Blog_Manage/blog_article/GetDataList',
    method: 'post',
    data: {
      PageIndex: 1,
      PageRows: 3,
      SortType: 'desc',
      Search: {
        Status: 1,
        IsTop: 1
      }
    }
  })
}

/**
 * 搜索文章
 */
export function searchArticles (keyword, pageIndex = 1, pageRows = 10) {
  return request({
    url: '/Blog_Manage/blog_article/GetDataList',
    method: 'post',
    data: {
      PageIndex: pageIndex,
      PageRows: pageRows,
      SortType: 'desc',
      Search: {
        Condition: 'Title',
        Keyword: keyword,
        Status: 1
      }
    }
  })
}

/**
 * 增加文章阅读量
 */
export function incrementViewCount (id) {
  return request({
    url: '/Blog_Manage/blog_article/IncrementViewCount',
    method: 'post',
    data: { id }
  })
}
