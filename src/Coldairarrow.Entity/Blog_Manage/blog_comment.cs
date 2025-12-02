using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Coldairarrow.Entity.Blog_Manage
{
    /// <summary>
    /// 评论表
    /// </summary>
    [Table("blog_comment")]
    public class blog_comment
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
        /// 评论用户ID(关联Base_User.Id)
        /// </summary>
        public String UserId { get; set; }

        /// <summary>
        /// 评论内容
        /// </summary>
        public String Content { get; set; }

        /// <summary>
        /// 父评论ID(NULL表示一级评论)
        /// </summary>
        public String ParentId { get; set; }

        /// <summary>
        /// 回复的目标用户ID(@用户)
        /// </summary>
        public String ReplyToUserId { get; set; }

        /// <summary>
        /// 点赞数
        /// </summary>
        public Int32 LikeCount { get; set; }

        /// <summary>
        /// 状态(0=已删除,1=正常,2=已屏蔽)
        /// </summary>
        public Int32 Status { get; set; }

        /// <summary>
        /// 是否删除(0=否,1=是)
        /// </summary>
        public Int32 IsDeleted { get; set; }

        /// <summary>
        /// 评论时间
        /// </summary>
        public DateTime CreatedTime { get; set; }

        /// <summary>
        /// 更新时间
        /// </summary>
        public DateTime? UpdatedTime { get; set; }

    }
}