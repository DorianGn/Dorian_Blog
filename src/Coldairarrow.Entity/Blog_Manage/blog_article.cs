using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Coldairarrow.Entity.Blog_Manage
{
    /// <summary>
    /// 文章表
    /// </summary>
    [Table("blog_article")]
    public class blog_article
    {

        /// <summary>
        /// 主键
        /// </summary>
        [Key, Column(Order = 1)]
        public String Id { get; set; }

        /// <summary>
        /// 文章标题
        /// </summary>
        public String Title { get; set; }

        /// <summary>
        /// 文章摘要
        /// </summary>
        public String Summary { get; set; }

        /// <summary>
        /// 文章内容(富文本HTML)
        /// </summary>
        public String Content { get; set; }

        /// <summary>
        /// 封面图片URL
        /// </summary>
        public String CoverImage { get; set; }

        /// <summary>
        /// 分类ID
        /// </summary>
        public String CategoryId { get; set; }

        /// <summary>
        /// 作者ID(关联Base_User.Id)
        /// </summary>
        public String AuthorId { get; set; }

        /// <summary>
        /// 文章状态(0=草稿,1=已发布,2=已隐藏)
        /// </summary>
        public Int32 Status { get; set; }

        /// <summary>
        /// 是否置顶(0=否,1=是)
        /// </summary>
        public Int32 IsTop { get; set; }

        /// <summary>
        /// 是否推荐(0=否,1=是)
        /// </summary>
        public Int32 IsRecommend { get; set; }

        /// <summary>
        /// 是否允许评论(0=否,1=是)
        /// </summary>
        public Int32 AllowComment { get; set; }

        /// <summary>
        /// 阅读量
        /// </summary>
        public Int32 ViewCount { get; set; }

        /// <summary>
        /// 点赞数
        /// </summary>
        public Int32 LikeCount { get; set; }

        /// <summary>
        /// 评论数
        /// </summary>
        public Int32 CommentCount { get; set; }

        /// <summary>
        /// 发布时间
        /// </summary>
        public DateTime? PublishTime { get; set; }

        /// <summary>
        /// 是否删除(0=否,1=是)
        /// </summary>
        public Int32 IsDeleted { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreatedTime { get; set; }

        /// <summary>
        /// 创建人ID
        /// </summary>
        public String CreatorId { get; set; }

        /// <summary>
        /// 更新时间
        /// </summary>
        public DateTime? UpdatedTime { get; set; }

        /// <summary>
        /// 更新人ID
        /// </summary>
        public String UpdaterId { get; set; }

    }
}