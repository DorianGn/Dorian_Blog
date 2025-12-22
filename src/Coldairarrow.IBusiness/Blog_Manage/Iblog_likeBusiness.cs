using Coldairarrow.Entity.Blog_Manage;
using Coldairarrow.Entity.DTO.Blog_Manage;
using Coldairarrow.Util;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Coldairarrow.Business.Blog_Manage
{
    public interface Iblog_likeBusiness
    {
        Task<PageResult<Blog_LikeDTO>> GetDataListAsync(PageInput<Entity.DTO.Blog_Manage.ConditionDTO> input);
        Task<blog_like> GetTheDataAsync(string id);
        Task AddDataAsync(blog_like data);
        Task UpdateDataAsync(blog_like data);
        Task DeleteDataAsync(List<string> ids);

        /// <summary>
        /// 检查用户是否已点赞某文章
        /// </summary>
        Task<blog_like> CheckUserLikeAsync(string articleId, string userId);

        /// <summary>
        /// 添加点赞并更新文章计数
        /// </summary>
        Task<AjaxResult> LikeArticleAsync(string articleId, string userId);

        /// <summary>
        /// 取消点赞并更新文章计数
        /// </summary>
        Task<AjaxResult> UnlikeArticleAsync(string likeId, string userId);
    }
}
