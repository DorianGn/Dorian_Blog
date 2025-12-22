using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Coldairarrow.Business.Blog_Manage
{
    public interface IBlog_StatisticsBusiness
    {
        Task<BlogStatisticsDTO> GetStatisticsAsync();
        Task<UserStatisticsDTO> GetUserStatisticsAsync(string userId);
    }

    /// <summary>
    /// 用户统计数据DTO
    /// </summary>
    public class UserStatisticsDTO
    {
        /// <summary>
        /// 用户发布的文章数
        /// </summary>
        public int ArticleCount { get; set; }

        /// <summary>
        /// 用户发布的评论数
        /// </summary>
        public int CommentCount { get; set; }

        /// <summary>
        /// 用户文章获得的点赞数
        /// </summary>
        public int LikeCount { get; set; }
    }

    /// <summary>
    /// 博客统计数据DTO
    /// </summary>
    public class BlogStatisticsDTO
    {
        /// <summary>
        /// 文章总数
        /// </summary>
        public int ArticleCount { get; set; }

        /// <summary>
        /// 评论总数
        /// </summary>
        public int CommentCount { get; set; }

        /// <summary>
        /// 点赞总数
        /// </summary>
        public int LikeCount { get; set; }

        /// <summary>
        /// 用户总数
        /// </summary>
        public int UserCount { get; set; }

        /// <summary>
        /// 总阅读量
        /// </summary>
        public int TotalViews { get; set; }

        /// <summary>
        /// 分类总数
        /// </summary>
        public int CategoryCount { get; set; }

        /// <summary>
        /// 今日新增文章
        /// </summary>
        public int TodayArticleCount { get; set; }

        /// <summary>
        /// 今日新增评论
        /// </summary>
        public int TodayCommentCount { get; set; }

        /// <summary>
        /// 今日新增点赞
        /// </summary>
        public int TodayLikeCount { get; set; }

        /// <summary>
        /// 本周新增文章
        /// </summary>
        public int WeekArticleCount { get; set; }

        /// <summary>
        /// 本月新增文章
        /// </summary>
        public int MonthArticleCount { get; set; }

        /// <summary>
        /// 今日新增文章列表
        /// </summary>
        public List<ArticleBriefDTO> TodayArticles { get; set; }

        /// <summary>
        /// 本周热门文章（按访问量）
        /// </summary>
        public List<ArticleBriefDTO> WeekHotArticles { get; set; }

        /// <summary>
        /// 本月热门文章（按访问量）
        /// </summary>
        public List<ArticleBriefDTO> MonthHotArticles { get; set; }

        /// <summary>
        /// 点赞最多的文章
        /// </summary>
        public List<ArticleBriefDTO> MostLikedArticles { get; set; }

        /// <summary>
        /// 访问量最高的文章
        /// </summary>
        public List<ArticleBriefDTO> MostViewedArticles { get; set; }

        /// <summary>
        /// 评论最多的文章
        /// </summary>
        public List<ArticleBriefDTO> MostCommentedArticles { get; set; }
    }

    /// <summary>
    /// 文章简要信息DTO
    /// </summary>
    public class ArticleBriefDTO
    {
        public string Id { get; set; }
        public string Title { get; set; }
        public string AuthorName { get; set; }
        public int ViewCount { get; set; }
        public int LikeCount { get; set; }
        public int CommentCount { get; set; }
        public DateTime? CreatedTime { get; set; }
        public string CategoryName { get; set; }
    }
}
