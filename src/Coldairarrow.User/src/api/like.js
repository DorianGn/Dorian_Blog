import request from '@/utils/request'

/**
 * 点赞文章（需要登录）
 */
export function likeArticle (articleId) {
  return request({
    url: '/Blog_Manage/blog_like/LikeArticle',
    method: 'post',
    data: { id: articleId }
  })
}

/**
 * 取消点赞（需要登录，只能取消自己的点赞）
 */
export function unlikeArticle (likeId) {
  return request({
    url: '/Blog_Manage/blog_like/UnlikeArticle',
    method: 'post',
    data: { id: likeId }
  })
}

/**
 * 检查当前用户是否已点赞某文章（需要登录）
 */
export function checkLikeStatus (articleId) {
  return request({
    url: '/Blog_Manage/blog_like/CheckLikeStatus',
    method: 'post',
    data: { id: articleId }
  })
}
