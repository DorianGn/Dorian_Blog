using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Coldairarrow.Entity.Blog_Manage
{
    /// <summary>
    /// 文章标签表
    /// </summary>
    [Table("blog_tag")]
    public class blog_tag
    {

        /// <summary>
        /// 主键
        /// </summary>
        [Key, Column(Order = 1)]
        public String Id { get; set; }

        /// <summary>
        /// 标签名称
        /// </summary>
        public String Name { get; set; }

        /// <summary>
        /// 标签颜色(HEX色值,如#1890ff)
        /// </summary>
        public String Color { get; set; }

        /// <summary>
        /// 该标签下的文章数量
        /// </summary>
        public Int32 ArticleCount { get; set; }

        /// <summary>
        /// 是否删除(0=否,1=是)
        /// </summary>
        public Int32 IsDeleted { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreatedTime { get; set; }

        /// <summary>
        /// 创建人Id
        /// </summary>
        public String CreatorId { get; set; }

        /// <summary>
        /// 更新时间
        /// </summary>
        public DateTime? UpdatedTime { get; set; }

        /// <summary>
        /// 更新人Id
        /// </summary>
        public String UpdaterId { get; set; }

    }
}