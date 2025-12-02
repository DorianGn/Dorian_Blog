using Coldairarrow.Entity.Blog_Manage;
using Coldairarrow.Util;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Coldairarrow.Business.Blog_Manage
{
    public interface Iblog_tagBusiness
    {
        Task<PageResult<blog_tag>> GetDataListAsync(PageInput<ConditionDTO> input);
        Task<blog_tag> GetTheDataAsync(string id);
        Task AddDataAsync(blog_tag data);
        Task UpdateDataAsync(blog_tag data);
        Task DeleteDataAsync(List<string> ids);
    }
}