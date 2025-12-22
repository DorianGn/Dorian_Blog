using Coldairarrow.Business.Blog_Manage;
using Coldairarrow.Util;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace Coldairarrow.Api.Controllers.Blog_Manage
{
    [Route("/Blog_Manage/[controller]/[action]")]
    public class Blog_StatisticsController : BaseApiController
    {
        private readonly IBlog_StatisticsBusiness _statisticsBus;

        public Blog_StatisticsController(IBlog_StatisticsBusiness statisticsBus)
        {
            _statisticsBus = statisticsBus;
        }

        /// <summary>
        /// 获取博客统计数据
        /// </summary>
        [HttpPost]
        public async Task<AjaxResult<BlogStatisticsDTO>> GetStatistics()
        {
            var data = await _statisticsBus.GetStatisticsAsync();
            return new AjaxResult<BlogStatisticsDTO> { Success = true, Data = data };
        }

        /// <summary>
        /// 获取用户统计数据
        /// </summary>
        [HttpPost]
        public async Task<AjaxResult<UserStatisticsDTO>> GetUserStatistics(string userId)
        {
            var data = await _statisticsBus.GetUserStatisticsAsync(userId);
            return new AjaxResult<UserStatisticsDTO> { Success = true, Data = data };
        }
    }
}
