import request from '@/utils/request'

/**
 * 点赞文章
 */
export function likeArticle (articleId) {
  return request({
    url: '/Blog_Manage/blog_like/SaveData',
    method: 'post',
    data: { ArticleId: articleId }
  })
}

/**
 * 取消点赞
 */
export function unlikeArticle (likeId) {
  return request({
    url: '/Blog_Manage/blog_like/DeleteData',
    method: 'post',
    data: { ids: [likeId] }
  })
}

/**
 * 检查是否已点赞
 */
export function checkLikeStatus (articleId) {
  return request({
    url: '/Blog_Manage/blog_like/GetDataList',
    method: 'post',
    data: {
      PageIndex: 1,
      PageRows: 1,
      Search: { ArticleId: articleId }
    }
  })
}
