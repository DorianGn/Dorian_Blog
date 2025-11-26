using Coldairarrow.Entity.Blog_Manage;
using Coldairarrow.Util;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Coldairarrow.Business.Blog_Manage
{
    public interface Iblog_categoryBusiness
    {
        Task<PageResult<blog_category>> GetDataListAsync(PageInput<ConditionDTO> input);
        Task<blog_category> GetTheDataAsync(string id);
        Task AddDataAsync(blog_category data);
        Task UpdateDataAsync(blog_category data);
        Task DeleteDataAsync(List<string> ids);
    }
}