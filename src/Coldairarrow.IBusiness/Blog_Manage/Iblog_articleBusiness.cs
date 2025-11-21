using Coldairarrow.Entity.Blog_Manage;
using Coldairarrow.Util;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Coldairarrow.Business.Blog_Manage
{
    public interface Iblog_articleBusiness
    {
        Task<PageResult<blog_article>> GetDataListAsync(PageInput<ConditionDTO> input);
        Task<blog_article> GetTheDataAsync(string id);
        Task AddDataAsync(blog_article data);
        Task UpdateDataAsync(blog_article data);
        Task DeleteDataAsync(List<string> ids);
    }
}