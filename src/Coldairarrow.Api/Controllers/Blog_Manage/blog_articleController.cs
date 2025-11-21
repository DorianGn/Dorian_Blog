using Coldairarrow.Business.Blog_Manage;
using Coldairarrow.Entity.Blog_Manage;
using Coldairarrow.Util;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Coldairarrow.Api.Controllers.Blog_Manage
{
    [Route("/Blog_Manage/[controller]/[action]")]
    public class blog_articleController : BaseApiController
    {
        #region DI

        public blog_articleController(Iblog_articleBusiness blog_articleBus)
        {
            _blog_articleBus = blog_articleBus;
        }

        Iblog_articleBusiness _blog_articleBus { get; }

        #endregion

        #region 获取

        [HttpPost]
        public async Task<PageResult<blog_article>> GetDataList(PageInput<ConditionDTO> input)
        {
            return await _blog_articleBus.GetDataListAsync(input);
        }

        [HttpPost]
        public async Task<blog_article> GetTheData(IdInputDTO input)
        {
            return await _blog_articleBus.GetTheDataAsync(input.id);
        }

        #endregion

        #region 提交

        [HttpPost]
        public async Task SaveData(blog_article data)
        {
            if (data.Id.IsNullOrEmpty())
            {
                InitEntity(data);

                await _blog_articleBus.AddDataAsync(data);
            }
            else
            {
                await _blog_articleBus.UpdateDataAsync(data);
            }
        }

        [HttpPost]
        public async Task DeleteData(List<string> ids)
        {
            await _blog_articleBus.DeleteDataAsync(ids);
        }

        #endregion
    }
}