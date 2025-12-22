using Coldairarrow.Entity.Base_Manage;
using Coldairarrow.Entity.Blog_Manage;
using Coldairarrow.Entity.DTO.Blog_Manage;
using Coldairarrow.Util;
using EFCore.Sharding;
using LinqKit;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Threading.Tasks;

namespace Coldairarrow.Business.Blog_Manage
{
    public class blog_likeBusiness : BaseBusiness<blog_like>, Iblog_likeBusiness, ITransientDependency
    {
        public blog_likeBusiness(IDbAccessor db)
            : base(db)
        {
        }

        #region 外部接口

        public async Task<PageResult<Blog_LikeDTO>> GetDataListAsync(PageInput<Entity.DTO.Blog_Manage.ConditionDTO> input)
        {
            var query = from like in GetIQueryable()
                        join article in Db.GetIQueryable<blog_article>() on like.ArticleId equals article.Id into articleGroup
                        from articles in articleGroup.DefaultIfEmpty()
                        join user in Db.GetIQueryable<Base_User>() on like.UserId equals user.Id into userGroup
                        from users in userGroup.DefaultIfEmpty()
                        select new Blog_LikeDTO
                        {
                            Id = like.Id,
                            ArticleId = like.ArticleId,
                            ArticleTitle = articles.Title,
                            UserId = like.UserId,
                            UserName = users.UserName,
                            CreatedTime = like.CreatedTime,
                        };
            var search = input.Search;
            if (!search.Condition.IsNullOrEmpty() && !search.Keyword.IsNullOrEmpty())
            {
                switch (search.Condition)
                {
                    case "ArticleTitle": query = query.Where(x => x.ArticleTitle.Contains(search.Keyword)); break;
                    case "UserName": query = query.Where(x => x.UserName.Contains(search.Keyword)); break;
                    default: break;
                }
            }
            // 按文章ID筛选
            if (!search.ArticleId.IsNullOrEmpty())
            {
                query = query.Where(x => x.ArticleId == search.ArticleId);
            }
            // 按用户ID筛选
            if (!search.UserId.IsNullOrEmpty())
            {
                query = query.Where(x => x.UserId == search.UserId);
            }
            if (!search.StartTime.IsNullOrEmpty())
            {
                var startTime = DateTime.Parse(search.StartTime);
                query = query.Where(x => x.CreatedTime >= startTime);
            }
            if (!search.EndTime.IsNullOrEmpty())
            {
                var endTime = DateTime.Parse(search.EndTime);
                query = query.Where(x => x.CreatedTime <= endTime);
            }
            return await query.GetPageResultAsync(input);
        }

        public async Task<blog_like> GetTheDataAsync(string id)
        {
            return await GetEntityAsync(id);
        }

        public async Task AddDataAsync(blog_like data)
        {
            await InsertAsync(data);
        }

        public async Task UpdateDataAsync(blog_like data)
        {
            await UpdateAsync(data);
        }

        public async Task DeleteDataAsync(List<string> ids)
        {
            await DeleteAsync(ids);
        }

        /// <summary>
        /// 检查用户是否已点赞某文章
        /// </summary>
        public async Task<blog_like> CheckUserLikeAsync(string articleId, string userId)
        {
            return await GetIQueryable()
                .Where(x => x.ArticleId == articleId && x.UserId == userId)
                .FirstOrDefaultAsync();
        }

        /// <summary>
        /// 添加点赞并更新文章计数
        /// </summary>
        public async Task<AjaxResult> LikeArticleAsync(string articleId, string userId)
        {
            // 检查是否已点赞
            var existingLike = await CheckUserLikeAsync(articleId, userId);
            if (existingLike != null)
            {
                return new AjaxResult { Success = false, Msg = "您已经点赞过该文章" };
            }

            // 添加点赞记录
            var like = new blog_like
            {
                Id = IdHelper.GetId(),
                ArticleId = articleId,
                UserId = userId,
                CreatedTime = DateTime.Now
            };

            await InsertAsync(like);

            // 更新文章点赞数
            var article = await Db.GetIQueryable<blog_article>()
                .Where(x => x.Id == articleId)
                .FirstOrDefaultAsync();
            if (article != null)
            {
                article.LikeCount = article.LikeCount + 1;
                await Db.UpdateAsync(article);
            }

            return new AjaxResult<string> { Success = true, Msg = "点赞成功", Data = like.Id };
        }

        /// <summary>
        /// 取消点赞并更新文章计数
        /// </summary>
        public async Task<AjaxResult> UnlikeArticleAsync(string likeId, string userId)
        {
            // 获取点赞记录
            var like = await GetEntityAsync(likeId);
            if (like == null)
            {
                return new AjaxResult { Success = false, Msg = "点赞记录不存在" };
            }

            // 验证是否为本人操作
            if (like.UserId != userId)
            {
                return new AjaxResult { Success = false, Msg = "无权取消他人的点赞" };
            }

            // 删除点赞记录
            await DeleteAsync(likeId);

            // 更新文章点赞数
            var article = await Db.GetIQueryable<blog_article>()
                .Where(x => x.Id == like.ArticleId)
                .FirstOrDefaultAsync();
            if (article != null && article.LikeCount > 0)
            {
                article.LikeCount = article.LikeCount - 1;
                await Db.UpdateAsync(article);
            }

            return new AjaxResult { Success = true, Msg = "取消点赞成功" };
        }

        #endregion

        #region 私有成员

        #endregion
    }
}
