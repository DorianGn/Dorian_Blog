using Coldairarrow.Business.Blog_Manage;
using Coldairarrow.Entity.Blog_Manage;
using Coldairarrow.Util;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Coldairarrow.Api.Controllers.Blog_Manage
{
    [Route("/Blog_Manage/[controller]/[action]")]
    public class blog_tagController : BaseApiController
    {
        #region DI

        public blog_tagController(Iblog_tagBusiness blog_tagBus)
        {
            _blog_tagBus = blog_tagBus;
        }

        Iblog_tagBusiness _blog_tagBus { get; }

        #endregion

        #region 获取

        [HttpPost]
        public async Task<PageResult<blog_tag>> GetDataList(PageInput<ConditionDTO> input)
        {
            return await _blog_tagBus.GetDataListAsync(input);
        }

        [HttpPost]
        public async Task<blog_tag> GetTheData(IdInputDTO input)
        {
            return await _blog_tagBus.GetTheDataAsync(input.id);
        }

        #endregion

        #region 提交

        [HttpPost]
        public async Task SaveData(blog_tag data)
        {
            if (data.Id.IsNullOrEmpty())
            {
                InitEntity(data);

                await _blog_tagBus.AddDataAsync(data);
            }
            else
            {
                await _blog_tagBus.UpdateDataAsync(data);
            }
        }

        [HttpPost]
        public async Task DeleteData(List<string> ids)
        {
            await _blog_tagBus.DeleteDataAsync(ids);
        }

        #endregion
    }
}