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

        #endregion

        #region 私有成员

        #endregion
    }
}


