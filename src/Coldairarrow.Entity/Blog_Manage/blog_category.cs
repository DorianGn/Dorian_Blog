using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Coldairarrow.Entity.Blog_Manage
{
    /// <summary>
    /// 文章分类表
    /// </summary>
    [Table("blog_category")]
    public class blog_category
    {

        /// <summary>
        /// 主键
        /// </summary>
        [Key, Column(Order = 1)]
        public String Id { get; set; }

        /// <summary>
        /// 分类名称
        /// </summary>
        public String Name { get; set; }

        /// <summary>
        /// 分类描述
        /// </summary>
        public String Description { get; set; }

        /// <summary>
        /// 分类图标
        /// </summary>
        public String Icon { get; set; }

        /// <summary>
        /// 排序号(越小越靠前)
        /// </summary>
        public Int32 SortIndex { get; set; }

        /// <summary>
        /// 状态(0=禁用,1=启用)
        /// </summary>
        public Int32 Status { get; set; }

        /// <summary>
        /// 该分类下的文章数量
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