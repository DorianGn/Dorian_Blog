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
    public class blog_tagBusiness : BaseBusiness<blog_tag>, Iblog_tagBusiness, ITransientDependency
    {
        public blog_tagBusiness(IDbAccessor db)
            : base(db)
        {
        }

        #region 外部接口

        public async Task<PageResult<blog_tag>> GetDataListAsync(PageInput<ConditionDTO> input)
        {
            var q = GetIQueryable();
            var where = LinqHelper.True<blog_tag>();
            var search = input.Search;

            //筛选
            if (!search.Condition.IsNullOrEmpty() && !search.Keyword.IsNullOrEmpty())
            {
                var newWhere = DynamicExpressionParser.ParseLambda<blog_tag, bool>(
                    ParsingConfig.Default, false, $@"{search.Condition}.Contains(@0)", search.Keyword);
                where = where.And(newWhere);
            }
            if (search.isDeleted.HasValue)
            {
                where = where.And(x => x.IsDeleted == search.isDeleted);
            }

            return await q.Where(where).GetPageResultAsync(input);
        }

        public async Task<blog_tag> GetTheDataAsync(string id)
        {
            return await GetEntityAsync(id);
        }

        public async Task AddDataAsync(blog_tag data)
        {
            await InsertAsync(data);
        }

        public async Task UpdateDataAsync(blog_tag data)
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