using Coldairarrow.Entity.Base_Manage;
using Coldairarrow.Entity.Blog_Manage;
using Coldairarrow.Entity.DTO.Blog_Manage;
using Coldairarrow.Util;
using EFCore.Sharding;
using LinqKit;
using Microsoft.EntityFrameworkCore;
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
                            ArticleTitle = articles != null ? articles.Title:"文章已删除",
                            UserId = comment.UserId,
                            UserName = users != null ? users.UserName : "用户已注销",
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
            if(!search.Condition.IsNullOrEmpty() && !search.Keyword.IsNullOrEmpty())
            {
                switch (search.Condition)
                {
                    case "ArticleTitle":query = query.Where(x => x.ArticleTitle.Contains(search.Keyword));break;
                    case "UserName": query = query.Where(x => x.UserName.Contains(search.Keyword));break;
                    case "Content": query = query.Where(x => x.Content.Contains(search.Keyword));break;
                    case "ParentContent": query = query.Where(x => x.ParentContent.Contains(search.Keyword));break;
                    case "ReplyToUserName": query = query.Where(x => x.ReplyToUserName.Contains(search.Keyword));break;
                }
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

        #endregion

        #region 私有成员

        #endregion
    }
}