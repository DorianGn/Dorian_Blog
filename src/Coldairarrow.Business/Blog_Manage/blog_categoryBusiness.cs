using Coldairarrow.Entity.Blog_Manage;
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
    public class blog_categoryBusiness : BaseBusiness<blog_category>, Iblog_categoryBusiness, ITransientDependency
    {
        public blog_categoryBusiness(IDbAccessor db)
            : base(db)
        {
        }

        #region 外部接口
        public async Task<PageResult<blog_category>> GetDataListAsync(PageInput<Entity.DTO.Blog_Manage.ConditionDTO> input)
        {
            var q = GetIQueryable();
            var where = LinqHelper.True<blog_category>();
            var search = input.Search;

            //筛选
            if (!search.Condition.IsNullOrEmpty() && !search.Keyword.IsNullOrEmpty())
            {
                var newWhere = DynamicExpressionParser.ParseLambda<blog_category, bool>(
                    ParsingConfig.Default, false, $@"{search.Condition}.Contains(@0)", search.Keyword);
                where = where.And(newWhere);
            }
            if (search.isDeleted.HasValue)
            {
                q = q.Where(x => x.IsDeleted == search.isDeleted.Value);
            }

            if (search.Status.HasValue)
            {
                q = q.Where(x => x.Status == search.Status.Value);
            }

            return await q.Where(where).GetPageResultAsync(input);
        }

        public async Task<blog_category> GetTheDataAsync(string id)
        {
            return await GetEntityAsync(id);
        }

        public async Task AddDataAsync(blog_category data)
        {
            await InsertAsync(data);
        }

        public async Task UpdateDataAsync(blog_category data)
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