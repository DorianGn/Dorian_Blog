using Coldairarrow.Entity.Blog_Manage;
using Coldairarrow.Entity.DTO.Blog_Manage;
using Coldairarrow.Util;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Coldairarrow.Business.Blog_Manage
{
    public interface Iblog_commentBusiness
    {
        Task<PageResult<Blog_CommentDTO>> GetDataListAsync(PageInput<Entity.DTO.Blog_Manage.ConditionDTO> input);
        Task<blog_comment> GetTheDataAsync(string id);
        Task AddDataAsync(blog_comment data);
        Task UpdateDataAsync(blog_comment data);
        Task DeleteDataAsync(List<string> ids);

        /// <summary>
        /// 发表评论并更新文章评论数
        /// </summary>
        Task<AjaxResult> AddCommentAsync(blog_comment data, string userId);

        /// <summary>
        /// 删除评论（验证权限）并更新文章评论数
        /// </summary>
        Task<AjaxResult> DeleteCommentAsync(string commentId, string userId);
    }
}
