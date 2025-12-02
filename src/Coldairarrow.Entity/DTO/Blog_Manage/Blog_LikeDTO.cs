using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Coldairarrow.Entity.DTO.Blog_Manage
{
    public class Blog_LikeDTO
    {
        public string Id { get; set; }
        public string ArticleId { get; set; }
        public string ArticleTitle { get; set; }
        public string UserId { get; set; }
        public string UserName { get; set; }
        public DateTime CreatedTime { get; set; }
        
    }
}
