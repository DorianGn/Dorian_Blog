import request from '@/utils/request'

/**
 * 获取文章评论列表
 */
export function getCommentList (articleId, pageIndex = 1, pageRows = 50) {
  return request({
    url: '/Blog_Manage/blog_comment/GetDataList',
    method: 'post',
    data: {
      PageIndex: pageIndex,
      PageRows: pageRows,
      SortField: 'CreatedTime',
      SortType: 'asc',
      Search: {
        ArticleId: articleId,
        Status: 1 // 只获取正常评论
      }
    }
  })
}

/**
 * 发表评论（需要登录）
 */
export function addComment (data) {
  return request({
    url: '/Blog_Manage/blog_comment/AddComment',
    method: 'post',
    data: {
      ArticleId: data.articleId,
      Content: data.content,
      ParentId: data.parentId || null,
      ReplyToUserId: data.replyToUserId || null
    }
  })
}

/**
 * 删除评论（需要登录，只能删除自己的评论）
 */
export function deleteComment (id) {
  return request({
    url: '/Blog_Manage/blog_comment/DeleteComment',
    method: 'post',
    data: { id: id }
  })
}
