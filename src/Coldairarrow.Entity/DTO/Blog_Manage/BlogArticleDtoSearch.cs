using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Coldairarrow.Entity.DTO.Blog_Manage
{
    public class BlogArticleDtoSearch
    {
        public string CategoryId { set; get; }
        public string Title { get; set; }
        public string Summary { get; set; }
        public string AuthorId { get; set; }
        public int Status { get; set; }
        public int IsTop { get; set; }
        public int IsRecommend { get; set; }
        public int AllowComment { get; set; }
        public int IsDeleted { get; set; }
    }
}
