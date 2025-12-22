using Coldairarrow.Entity.Base_Manage;
using Coldairarrow.Entity.Blog_Manage;
using Coldairarrow.Util;
using EFCore.Sharding;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Coldairarrow.Business.Blog_Manage
{
    public class Blog_StatisticsBusiness : IBlog_StatisticsBusiness, ITransientDependency
    {
        private readonly IDbAccessor _db;

        public Blog_StatisticsBusiness(IDbAccessor db)
        {
            _db = db;
        }

        public async Task<BlogStatisticsDTO> GetStatisticsAsync()
        {
            var today = DateTime.Today;
            var weekStart = today.AddDays(-(int)today.DayOfWeek);
            var monthStart = new DateTime(today.Year, today.Month, 1);

            // 文章统计
            var articleQuery = _db.GetIQueryable<blog_article>();
            var articleCount = await articleQuery.CountAsync();
            var totalViews = await articleQuery.SumAsync(x => x.ViewCount);
            var todayArticleCount = await articleQuery.Where(x => x.CreatedTime >= today).CountAsync();
            var weekArticleCount = await articleQuery.Where(x => x.CreatedTime >= weekStart).CountAsync();
            var monthArticleCount = await articleQuery.Where(x => x.CreatedTime >= monthStart).CountAsync();

            // 评论统计
            var commentQuery = _db.GetIQueryable<blog_comment>();
            var commentCount = await commentQuery.CountAsync();
            var todayCommentCount = await commentQuery.Where(x => x.CreatedTime >= today).CountAsync();

            // 点赞统计
            var likeQuery = _db.GetIQueryable<blog_like>();
            var likeCount = await likeQuery.CountAsync();
            var todayLikeCount = await likeQuery.Where(x => x.CreatedTime >= today).CountAsync();

            // 用户统计
            var userCount = await _db.GetIQueryable<Base_User>().CountAsync();

            // 分类统计
            var categoryCount = await _db.GetIQueryable<blog_category>().CountAsync();

            // 获取分类和用户信息用于关联查询
            var categories = await _db.GetIQueryable<blog_category>().ToListAsync();
            var users = await _db.GetIQueryable<Base_User>().ToListAsync();

            // 今日新增文章列表
            var todayArticles = await GetArticleBriefList(
                articleQuery.Where(x => x.CreatedTime >= today).OrderByDescending(x => x.CreatedTime),
                categories, users, 5);

            // 本周热门文章（按访问量）
            var weekHotArticles = await GetArticleBriefList(
                articleQuery.Where(x => x.CreatedTime >= weekStart).OrderByDescending(x => x.ViewCount),
                categories, users, 5);

            // 本月热门文章（按访问量）
            var monthHotArticles = await GetArticleBriefList(
                articleQuery.Where(x => x.CreatedTime >= monthStart).OrderByDescending(x => x.ViewCount),
                categories, users, 5);

            // 点赞最多的文章
            var mostLikedArticles = await GetArticleBriefList(
                articleQuery.OrderByDescending(x => x.LikeCount),
                categories, users, 5);

            // 访问量最高的文章
            var mostViewedArticles = await GetArticleBriefList(
                articleQuery.OrderByDescending(x => x.ViewCount),
                categories, users, 5);

            // 评论最多的文章
            var mostCommentedArticles = await GetArticleBriefList(
                articleQuery.OrderByDescending(x => x.CommentCount),
                categories, users, 5);

            return new BlogStatisticsDTO
            {
                ArticleCount = articleCount,
                CommentCount = commentCount,
                LikeCount = likeCount,
                UserCount = userCount,
                TotalViews = totalViews,
                CategoryCount = categoryCount,
                TodayArticleCount = todayArticleCount,
                TodayCommentCount = todayCommentCount,
                TodayLikeCount = todayLikeCount,
                WeekArticleCount = weekArticleCount,
                MonthArticleCount = monthArticleCount,
                TodayArticles = todayArticles,
                WeekHotArticles = weekHotArticles,
                MonthHotArticles = monthHotArticles,
                MostLikedArticles = mostLikedArticles,
                MostViewedArticles = mostViewedArticles,
                MostCommentedArticles = mostCommentedArticles
            };
        }

        public async Task<UserStatisticsDTO> GetUserStatisticsAsync(string userId)
        {
            // 用户发布的文章数
            var articleCount = await _db.GetIQueryable<blog_article>()
                .Where(x => x.AuthorId == userId)
                .CountAsync();

            // 用户发布的评论数
            var commentCount = await _db.GetIQueryable<blog_comment>()
                .Where(x => x.UserId == userId)
                .CountAsync();

            // 用户文章获得的点赞总数
            var likeCount = await _db.GetIQueryable<blog_article>()
                .Where(x => x.AuthorId == userId)
                .SumAsync(x => x.LikeCount);

            return new UserStatisticsDTO
            {
                ArticleCount = articleCount,
                CommentCount = commentCount,
                LikeCount = likeCount
            };
        }

        private async Task<List<ArticleBriefDTO>> GetArticleBriefList(
            IQueryable<blog_article> query,
            List<blog_category> categories,
            List<Base_User> users,
            int take)
        {
            var articles = await query.Take(take).ToListAsync();
            return articles.Select(a => new ArticleBriefDTO
            {
                Id = a.Id,
                Title = a.Title,
                AuthorName = users.FirstOrDefault(u => u.Id == a.AuthorId)?.UserName ?? "未知",
                ViewCount = a.ViewCount,
                LikeCount = a.LikeCount,
                CommentCount = a.CommentCount,
                CreatedTime = a.CreatedTime,
                CategoryName = categories.FirstOrDefault(c => c.Id == a.CategoryId)?.Name ?? "未分类"
            }).ToList();
        }
    }
}
