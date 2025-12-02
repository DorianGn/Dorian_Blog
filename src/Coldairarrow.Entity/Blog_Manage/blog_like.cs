using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Coldairarrow.Entity.Blog_Manage
{
    /// <summary>
    /// 点赞表
    /// </summary>
    [Table("blog_like")]
    public class blog_like
    {

        /// <summary>
        /// 主键
        /// </summary>
        [Key, Column(Order = 1)]
        public String Id { get; set; }

        /// <summary>
        /// 文章ID
        /// </summary>
        public String ArticleId { get; set; }

        /// <summary>
        /// 点赞用户ID(关联Base_User.Id)
        /// </summary>
        public String UserId { get; set; }

        /// <summary>
        /// 点赞时间
        /// </summary>
        public DateTime CreatedTime { get; set; }

    }
}