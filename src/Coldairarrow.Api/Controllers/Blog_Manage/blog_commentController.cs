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

        /// <summary>
        /// 发表评论（需要登录）
        /// </summary>
        [HttpPost]
        public async Task<AjaxResult> AddComment(blog_comment data)
        {
            var op = HttpContext.RequestServices.GetService<IOperator>();
            if (op?.UserId.IsNullOrEmpty() == true)
            {
                return new AjaxResult { Success = false, Msg = "请先登录" };
            }

            return await _blog_commentBus.AddCommentAsync(data, op.UserId);
        }

        /// <summary>
        /// 删除评论（需要登录，只能删除自己的评论）
        /// </summary>
        [HttpPost]
        public async Task<AjaxResult> DeleteComment(IdInputDTO input)
        {
            var op = HttpContext.RequestServices.GetService<IOperator>();
            if (op?.UserId.IsNullOrEmpty() == true)
            {
                return new AjaxResult { Success = false, Msg = "请先登录" };
            }

            return await _blog_commentBus.DeleteCommentAsync(input.id, op.UserId);
        }

        /// <summary>
        /// 保存评论数据（管理端使用）
        /// </summary>
        [HttpPost]
        public async Task SaveData(blog_comment data)
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

                await _blog_commentBus.AddDataAsync(data);
            }
            else
            {
                UpdateEntity(data);
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
