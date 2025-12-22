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
    public class blog_articleBusiness : BaseBusiness<blog_article>, Iblog_articleBusiness, ITransientDependency
    {
        public blog_articleBusiness(IDbAccessor db)
            : base(db)
        {
        }

        #region 外部接口

        public async Task<PageResult<Blog_ArticleDTO>> GetDataListAsync(PageInput<Entity.DTO.Blog_Manage.ConditionDTO> input)
        {
            var query = from article in GetIQueryable()
                        join category in Db.GetIQueryable<blog_category>() on article.CategoryId equals category.Id into categoryGroup
                        from cat in categoryGroup.DefaultIfEmpty()
                        join user in Db.GetIQueryable<Base_User>() on article.AuthorId equals user.Id into userGroup
                        from userGroupDe in userGroup.DefaultIfEmpty()
                        select new Blog_ArticleDTO
                        {
                            Id = article.Id,
                            Title = article.Title,
                            Summary = article.Summary,
                            Content = article.Content,
                            CoverImage = article.CoverImage,
                            CategoryId = article.CategoryId,
                            CategoryName = cat != null ? cat.Name : "未分类",
                            AuthorId = article.AuthorId,
                            AuthorName = userGroupDe != null ? (string.IsNullOrEmpty(userGroupDe.RealName) ? userGroupDe.UserName : userGroupDe.RealName) : "佚名",
                            AuthorAvatar = userGroupDe != null ? userGroupDe.Avatar : null,
                            Status = article.Status,
                            IsTop = article.IsTop,
                            IsRecommend = article.IsRecommend,
                            AllowComment = article.AllowComment,
                            ViewCount = article.ViewCount,
                            LikeCount = article.LikeCount,
                            PublishTime = article.PublishTime,
                            IsDeleted = article.IsDeleted,
                            CreatedTime = article.CreatedTime,
                            CreatorId = article.CreatorId,
                            UpdatedTime = article.UpdatedTime,
                            UpdaterId = article.UpdaterId
                        };
            var search = input.Search;
            //筛选
            if(!search.Condition.IsNullOrEmpty() && !search.Keyword.IsNullOrEmpty())
            {
                switch (search.Condition)
                {
                    case "Title":query = query.Where(x => x.Title.Contains(search.Keyword));break;
                    case "Summary": query = query.Where(x => x.Summary.Contains(search.Keyword)); break;
                    case "Content": query = query.Where(x => x.Content.Contains(search.Keyword)); break;
                    case "CategoryName": query = query.Where(x => x.CategoryName.Contains(search.Keyword)); break;
                    case "AuthorName": query = query.Where(x => x.AuthorName.Contains(search.Keyword)); break;
                    default:break;
                }
            }
            if (search.Status.HasValue)
            {
                query = query.Where(x => x.Status == search.Status.Value);
            }
            if (search.IsTop.HasValue)
            {
                query = query.Where(x => x.IsTop == search.IsTop.Value);
            }
            if (search.IsRecommend.HasValue)
            {
                query = query.Where(x => x.IsRecommend == search.IsRecommend.Value);
            }
            if (search.AllowComment.HasValue)
            {
                query = query.Where(x => x.AllowComment == search.AllowComment.Value);
            }
            // 按分类ID筛选
            if (!search.CategoryId.IsNullOrEmpty())
            {
                query = query.Where(x => x.CategoryId == search.CategoryId);
            }
            return await query.GetPageResultAsync(input);
        }

        public async Task<blog_article> GetTheDataAsync(string id)
        {
            return await GetEntityAsync(id);
        }

        public async Task<Blog_ArticleDTO> GetArticleDetailAsync(string id)
        {
            var query = from article in GetIQueryable().Where(x => x.Id == id)
                        join category in Db.GetIQueryable<blog_category>() on article.CategoryId equals category.Id into categoryGroup
                        from cat in categoryGroup.DefaultIfEmpty()
                        join user in Db.GetIQueryable<Base_User>() on article.AuthorId equals user.Id into userGroup
                        from userGroupDe in userGroup.DefaultIfEmpty()
                        select new Blog_ArticleDTO
                        {
                            Id = article.Id,
                            Title = article.Title,
                            Summary = article.Summary,
                            Content = article.Content,
                            CoverImage = article.CoverImage,
                            CategoryId = article.CategoryId,
                            CategoryName = cat != null ? cat.Name : "未分类",
                            AuthorId = article.AuthorId,
                            AuthorName = userGroupDe != null ? (string.IsNullOrEmpty(userGroupDe.RealName) ? userGroupDe.UserName : userGroupDe.RealName) : "佚名",
                            AuthorAvatar = userGroupDe != null ? userGroupDe.Avatar : null,
                            Status = article.Status,
                            IsTop = article.IsTop,
                            IsRecommend = article.IsRecommend,
                            AllowComment = article.AllowComment,
                            ViewCount = article.ViewCount,
                            LikeCount = article.LikeCount,
                            CommentCount = article.CommentCount,
                            PublishTime = article.PublishTime,
                            IsDeleted = article.IsDeleted,
                            CreatedTime = article.CreatedTime,
                            CreatorId = article.CreatorId,
                            UpdatedTime = article.UpdatedTime,
                            UpdaterId = article.UpdaterId
                        };
            return await query.FirstOrDefaultAsync();
        }

        public async Task AddDataAsync(blog_article data)
        {
            data.CreatedTime = DateTime.Now;
            await InsertAsync(data);
        }

        public async Task UpdateDataAsync(blog_article data)
        {
            await UpdateAsync(data);
        }

        public async Task DeleteDataAsync(List<string> ids)
        {
            await DeleteAsync(ids);
        }

        public async Task<int> IncrementViewCountAsync(string id)
        {
            var article = await GetEntityAsync(id);
            if (article != null)
            {
                article.ViewCount = article.ViewCount + 1;
                await UpdateAsync(article);
                return article.ViewCount;
            }
            return 0;
        }

        #endregion

        #region 私有成员

        #endregion
    }
}