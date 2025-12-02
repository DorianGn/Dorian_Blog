using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Coldairarrow.Entity.DTO.Blog_Manage
{
    public class Blog_CommentDTO
    {
        public String Id { get; set; }
        public String ArticleId { get; set; }
        public string ArticleTitle { get; set; }
        public String UserId { get; set; }
        public string UserName { get; set; }
        public String Content { get; set; }
        public String ParentId { get; set; }
        public string ParentContent { get; set; }
        public String ReplyToUserId { get; set; }
        public string ReplyToUserName { get; set; }
        public Int32 LikeCount { get; set; }
        public Int32 Status { get; set; }
        public Int32 IsDeleted { get; set; }
        public DateTime CreatedTime { get; set; }
        public DateTime? UpdatedTime { get; set; }
    }
}
