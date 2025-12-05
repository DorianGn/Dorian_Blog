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
 * 发表评论
 */
export function addComment (data) {
  return request({
    url: '/Blog_Manage/blog_comment/SaveData',
    method: 'post',
    data: {
      ArticleId: data.articleId,
      Content: data.content,
      ParentId: data.parentId || null,
      ReplyToUserId: data.replyToUserId || null,
      Status: 1,
      LikeCount: 0
    }
  })
}

/**
 * 删除评论（只能删除自己的）
 */
export function deleteComment (id) {
  return request({
    url: '/Blog_Manage/blog_comment/DeleteData',
    method: 'post',
    data: { ids: [id] }
  })
}
