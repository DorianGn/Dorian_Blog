using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Coldairarrow.Entity.DTO.Blog_Manage
{
    public class Blog_ArticleDTO
    {
        public String Id { get; set; }
        public String Title { get; set; }
        public String Summary { get; set; }
        public String Content { get; set; }
        public String CoverImage
        {
            get; set;
        }
        public String CategoryId
        {
            get; set;
        }
        public String CategoryName
        {
            get;
            set;
        }  // 分类名称
        public String AuthorId { get; set; }
        public String AuthorName { get; set; }
        public String AuthorAvatar { get; set; }
        public Int32 Status { get; set; }
        public Int32 IsTop { get; set; }
        public Int32 IsRecommend
        {
            get; set;
        }
        public Int32 AllowComment
        {
            get;
            set;
        }
        public Int32 ViewCount { get; set; }
        public Int32 LikeCount { get; set; }
        public Int32 CommentCount
        {
            get;
            set;
        }
        public DateTime? PublishTime
        {
            get;
            set;
        }
        public Int32 IsDeleted { get; set; }
        public DateTime CreatedTime
        {
            get;
            set;
        }
        public String CreatorId
        {
            get; set;
        }
        public DateTime? UpdatedTime
        {
            get;
            set;
        }
        public String UpdaterId
        {
            get; set;
        }
    }
}
