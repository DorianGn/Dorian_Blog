using Coldairarrow.Business.Blog_Manage;
using Coldairarrow.Entity.Blog_Manage;
using Coldairarrow.Util;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Coldairarrow.Api.Controllers.Blog_Manage
{
    [Route("/Blog_Manage/[controller]/[action]")]
    public class blog_categoryController : BaseApiController
    {
        #region DI

        public blog_categoryController(Iblog_categoryBusiness blog_categoryBus)
        {
            _blog_categoryBus = blog_categoryBus;
        }

        Iblog_categoryBusiness _blog_categoryBus { get; }

        #endregion

        #region 获取

        [HttpPost]
        public async Task<PageResult<blog_category>> GetDataList(PageInput<ConditionDTO> input)
        {
            return await _blog_categoryBus.GetDataListAsync(input);
        }

        [HttpPost]
        public async Task<blog_category> GetTheData(IdInputDTO input)
        {
            return await _blog_categoryBus.GetTheDataAsync(input.id);
        }

        #endregion

        #region 提交

        [HttpPost]
        public async Task SaveData(blog_category data)
        {
            if (data.Id.IsNullOrEmpty())
            {
                InitEntity(data);

                await _blog_categoryBus.AddDataAsync(data);
            }
            else
            {
                await _blog_categoryBus.UpdateDataAsync(data);
            }
        }

        [HttpPost]
        public async Task DeleteData(List<string> ids)
        {
            await _blog_categoryBus.DeleteDataAsync(ids);
        }

        #endregion
    }
}