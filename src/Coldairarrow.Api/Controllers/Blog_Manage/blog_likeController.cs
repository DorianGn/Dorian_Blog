using Coldairarrow.Business.Blog_Manage;
using Coldairarrow.Entity.Blog_Manage;
using Coldairarrow.Entity.DTO.Blog_Manage;
using Coldairarrow.IBusiness;
using Coldairarrow.Util;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.DependencyInjection;
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

        /// <summary>
        /// 检查当前用户是否已点赞某文章
        /// </summary>
        [HttpPost]
        public async Task<AjaxResult<blog_like>> CheckLikeStatus(IdInputDTO input)
        {
            var op = HttpContext.RequestServices.GetService<IOperator>();
            if (op?.UserId.IsNullOrEmpty() == true)
            {
                return new AjaxResult<blog_like> { Success = false, Msg = "请先登录" };
            }

            var like = await _blog_likeBus.CheckUserLikeAsync(input.id, op.UserId);
            return new AjaxResult<blog_like> { Success = true, Data = like };
        }

        #endregion

        #region 提交

        /// <summary>
        /// 点赞文章（需要登录）
        /// </summary>
        [HttpPost]
        public async Task<AjaxResult> LikeArticle(IdInputDTO input)
        {
            var op = HttpContext.RequestServices.GetService<IOperator>();
            if (op?.UserId.IsNullOrEmpty() == true)
            {
                return new AjaxResult { Success = false, Msg = "请先登录" };
            }

            return await _blog_likeBus.LikeArticleAsync(input.id, op.UserId);
        }

        /// <summary>
        /// 取消点赞（需要登录，只能取消自己的点赞）
        /// </summary>
        [HttpPost]
        public async Task<AjaxResult> UnlikeArticle(IdInputDTO input)
        {
            var op = HttpContext.RequestServices.GetService<IOperator>();
            if (op?.UserId.IsNullOrEmpty() == true)
            {
                return new AjaxResult { Success = false, Msg = "请先登录" };
            }

            return await _blog_likeBus.UnlikeArticleAsync(input.id, op.UserId);
        }

        /// <summary>
        /// 保存点赞数据（管理端使用）
        /// </summary>
        [HttpPost]
        public async Task SaveData(blog_like data)
        {
            if (data.Id.IsNullOrEmpty())
            {
                InitEntity(data);
                // 设置UserId为当前用户
                var op = HttpContext.RequestServices.GetService<IOperator>();
                if (!op?.UserId.IsNullOrEmpty() == true)
                {
                    data.UserId = op.UserId;
                }

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
