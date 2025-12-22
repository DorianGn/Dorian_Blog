using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Coldairarrow.Entity.DTO.Blog_Manage
{
    public class ConditionDTO
    {
        // 原有的通用查询字段
        public string Condition
        {
            get; set;
        }
        public string Keyword { get; set; }

        public int? Status { get; set; }
        public int? IsTop { get; set; }
        public int? IsRecommend
        {
            get; set;
        }
        public int? AllowComment
        {
            get; set;
        }
        public int? isDeleted { set; get; }
        public DateTime CreatedTime { set; get; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }

        // 点赞和评论筛选字段
        public string ArticleId { get; set; }
        public string UserId { get; set; }
        public string CategoryId { get; set; }
    }
}
