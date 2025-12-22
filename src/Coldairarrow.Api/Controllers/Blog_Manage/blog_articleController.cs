using Coldairarrow.Business.Blog_Manage;
using Coldairarrow.Entity.Blog_Manage;
using Coldairarrow.Entity.DTO.Blog_Manage;
using Coldairarrow.Util;
using Microsoft.AspNetCore.Authorization;
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
        [AllowAnonymous]
        public async Task<PageResult<Blog_ArticleDTO>> GetDataList(PageInput<Entity.DTO.Blog_Manage.ConditionDTO> input)
        {
            return await _blog_articleBus.GetDataListAsync(input);
        }

        [HttpPost]
        [AllowAnonymous]
        public async Task<Blog_ArticleDTO> GetTheData(IdInputDTO input)
        {
            return await _blog_articleBus.GetArticleDetailAsync(input.id);
        }

        /// <summary>
        /// 增加文章阅读量
        /// </summary>
        [HttpPost]
        [AllowAnonymous]
        public async Task<AjaxResult<int>> IncrementViewCount(IdInputDTO input)
        {
            var viewCount = await _blog_articleBus.IncrementViewCountAsync(input.id);
            return new AjaxResult<int> { Success = true, Data = viewCount };
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
                UpdateEntity(data);

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