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
    public class blog_commentController : BaseApiController
    {
        #region DI

        public blog_commentController(Iblog_commentBusiness blog_commentBus)
        {
            _blog_commentBus = blog_commentBus;
        }

        Iblog_commentBusiness _blog_commentBus { get; }

        #endregion

        #region 获取

        [HttpPost]
        public async Task<PageResult<Blog_CommentDTO>> GetDataList(PageInput<Entity.DTO.Blog_Manage.ConditionDTO> input)
        {
            return await _blog_commentBus.GetDataListAsync(input);
        }

        [HttpPost]
        public async Task<blog_comment> GetTheData(IdInputDTO input)
        {
            return await _blog_commentBus.GetTheDataAsync(input.id);
        }

        #endregion

        #region 提交

        [HttpPost]
        public async Task SaveData(blog_comment data)
        {
            if (data.Id.IsNullOrEmpty())
            {
                InitEntity(data);

                await _blog_commentBus.AddDataAsync(data);
            }
            else
            {
                await _blog_commentBus.UpdateDataAsync(data);
            }
        }

        [HttpPost]
        public async Task DeleteData(List<string> ids)
        {
            await _blog_commentBus.DeleteDataAsync(ids);
        }

        #endregion
    }
}