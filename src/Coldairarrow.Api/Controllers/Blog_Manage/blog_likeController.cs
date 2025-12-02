using Coldairarrow.Business.Blog_Manage;
using Coldairarrow.Entity.Blog_Manage;
using Coldairarrow.Entity.DTO.Blog_Manage;
using Coldairarrow.Util;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Coldairarrow.Api.Controllers.Blog_Manage
{
    [Route("/Blog_Manage/[controller]/[action]")]
    public class blog_likeController : BaseApiController
    {
        #region DI

        public blog_likeController(Iblog_likeBusiness blog_likeBus)
        {
            _blog_likeBus = blog_likeBus;
        }

        Iblog_likeBusiness _blog_likeBus { get; }

        #endregion

        #region 获取

        [HttpPost]
        public async Task<PageResult<Blog_LikeDTO>> GetDataList(PageInput<Entity.DTO.Blog_Manage.ConditionDTO> input)
        {
            return await _blog_likeBus.GetDataListAsync(input);
        }

        [HttpPost]
        public async Task<blog_like> GetTheData(IdInputDTO input)
        {
            return await _blog_likeBus.GetTheDataAsync(input.id);
        }

        #endregion

        #region 提交

        [HttpPost]
        public async Task SaveData(blog_like data)
        {
            if (data.Id.IsNullOrEmpty())
            {
                InitEntity(data);

                await _blog_likeBus.AddDataAsync(data);
            }
            else
            {
                await _blog_likeBus.UpdateDataAsync(data);
            }
        }

        [HttpPost]
        public async Task DeleteData(List<string> ids)
        {
            await _blog_likeBus.DeleteDataAsync(ids);
        }

        #endregion
    }
}