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
    public class blog_commentBusiness : BaseBusiness<blog_comment>, Iblog_commentBusiness, ITransientDependency
    {
        public blog_commentBusiness(IDbAccessor db)
            : base(db)
        {
        }

        #region 外部接口

        public async Task<PageResult<Blog_CommentDTO>> GetDataListAsync(PageInput<Entity.DTO.Blog_Manage.ConditionDTO> input)
        {
            var query = from comment in GetIQueryable()
                        join article in Db.GetIQueryable<blog_article>() on comment.ArticleId equals article.Id into articleGroup
                        from articles in articleGroup.DefaultIfEmpty()
                        join user in Db.GetIQueryable<Base_User>() on comment.UserId equals user.Id into userGroup
                        from users in userGroup.DefaultIfEmpty()
                        join parentComment in GetIQueryable() on comment.ParentId equals parentComment.Id into parentGroup
                        from parents in parentGroup.DefaultIfEmpty()
                        join replyToUser in Db.GetIQueryable<Base_User>() on comment.ReplyToUserId equals replyToUser.Id into replyToUserGroup
                        from replyUser in replyToUserGroup.DefaultIfEmpty()
                        select new Blog_CommentDTO
                        {
                            Id = comment.Id,
                            ArticleId = comment.ArticleId,
                            ArticleTitle = articles != null ? articles.Title : "文章已删除",
                            UserId = comment.UserId,
                            UserName = users != null ? users.UserName : "用户已注销",
                            UserAvatar = users != null ? users.Avatar : null,
                            Content = comment.Content,
                            ParentId = comment.ParentId,
                            ParentContent = parents != null ? parents.Content : null,
                            ReplyToUserId = comment.ReplyToUserId,
                            ReplyToUserName = replyUser != null ? replyUser.UserName : null,
                            LikeCount = comment.LikeCount,
                            Status = comment.Status,
                            IsDeleted = comment.IsDeleted,
                            CreatedTime = comment.CreatedTime,
                            UpdatedTime = comment.UpdatedTime
                        };
            var search = input.Search;
            if (!search.Condition.IsNullOrEmpty() && !search.Keyword.IsNullOrEmpty())
            {
                switch (search.Condition)
                {
                    case "ArticleTitle": query = query.Where(x => x.ArticleTitle.Contains(search.Keyword)); break;
                    case "UserName": query = query.Where(x => x.UserName.Contains(search.Keyword)); break;
                    case "Content": query = query.Where(x => x.Content.Contains(search.Keyword)); break;
                    case "ParentContent": query = query.Where(x => x.ParentContent.Contains(search.Keyword)); break;
                    case "ReplyToUserName": query = query.Where(x => x.ReplyToUserName.Contains(search.Keyword)); break;
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
            if (search.isDeleted.HasValue)
            {
                query = query.Where(x => x.IsDeleted == search.isDeleted);
            }
            if (search.Status.HasValue)
            {
                query = query.Where(x => x.Status == search.Status);
            }
            return await query.GetPageResultAsync(input);
        }

        public async Task<blog_comment> GetTheDataAsync(string id)
        {
            return await GetEntityAsync(id);
        }

        public async Task AddDataAsync(blog_comment data)
        {
            await InsertAsync(data);
        }

        public async Task UpdateDataAsync(blog_comment data)
        {
            await UpdateAsync(data);
        }

        public async Task DeleteDataAsync(List<string> ids)
        {
            await DeleteAsync(ids);
        }

        /// <summary>
        /// 发表评论并更新文章评论数
        /// </summary>
        public async Task<AjaxResult> AddCommentAsync(blog_comment data, string userId)
        {
            // 设置评论信息
            data.Id = IdHelper.GetId();
            data.UserId = userId;
            data.CreatedTime = DateTime.Now;
            data.Status = 1; // 正常状态
            data.IsDeleted = 0;
            data.LikeCount = 0;

            await InsertAsync(data);

            // 更新文章评论数
            var article = await Db.GetIQueryable<blog_article>()
                .Where(x => x.Id == data.ArticleId)
                .FirstOrDefaultAsync();
            if (article != null)
            {
                article.CommentCount = (article.CommentCount) + 1;
                await Db.UpdateAsync(article);
            }

            return new AjaxResult<string> { Success = true, Msg = "评论成功", Data = data.Id };
        }

        /// <summary>
        /// 删除评论（验证权限）并更新文章评论数
        /// </summary>
        public async Task<AjaxResult> DeleteCommentAsync(string commentId, string userId)
        {
            // 获取评论
            var comment = await GetEntityAsync(commentId);
            if (comment == null)
            {
                return new AjaxResult { Success = false, Msg = "评论不存在" };
            }

            // 验证是否为本人操作
            if (comment.UserId != userId)
            {
                return new AjaxResult { Success = false, Msg = "无权删除他人的评论" };
            }

            // 删除评论
            await DeleteAsync(commentId);

            // 更新文章评论数
            var article = await Db.GetIQueryable<blog_article>()
                .Where(x => x.Id == comment.ArticleId)
                .FirstOrDefaultAsync();
            if (article != null && article.CommentCount > 0)
            {
                article.CommentCount = article.CommentCount - 1;
                await Db.UpdateAsync(article);
            }

            return new AjaxResult { Success = true, Msg = "删除成功" };
        }

        #endregion

        #region 私有成员

        #endregion
    }
}
