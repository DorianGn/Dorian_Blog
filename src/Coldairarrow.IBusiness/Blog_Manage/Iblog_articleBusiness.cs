using Coldairarrow.Entity.Blog_Manage;
using Coldairarrow.Entity.DTO.Blog_Manage;
using Coldairarrow.Util;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Coldairarrow.Business.Blog_Manage
{
    public interface Iblog_articleBusiness
    {
        Task<PageResult<Blog_ArticleDTO>> GetDataListAsync(PageInput<Entity.DTO.Blog_Manage.ConditionDTO> input);
        Task<blog_article> GetTheDataAsync(string id);
        Task<Blog_ArticleDTO> GetArticleDetailAsync(string id);
        Task AddDataAsync(blog_article data);
        Task UpdateDataAsync(blog_article data);
        Task DeleteDataAsync(List<string> ids);
        Task<int> IncrementViewCountAsync(string id);
    }
}