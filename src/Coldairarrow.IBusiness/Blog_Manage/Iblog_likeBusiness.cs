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
    }
}