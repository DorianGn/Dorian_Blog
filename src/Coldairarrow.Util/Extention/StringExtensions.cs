using System.Linq;

namespace Coldairarrow.Api.Extentions
{
    // 在项目中创建一个扩展类
    public static class StringExtensions
    {
        /// <summary>
        /// 将 snake_case 转换为 PascalCase
        /// 例如: blog_article -> Blog_Article
        /// </summary>
        public static string ToPascalCase(string tableName)
        {
            if (string.IsNullOrEmpty(tableName))
                return tableName;

            string[] words = tableName.Split('_');

            // 将每个单词的首字母大写
            for (int i = 0; i < words.Length; i++)
            {
                if (!string.IsNullOrEmpty(words[i]))
                {
                    words[i] = char.ToUpper(words[i][0]) + words[i].Substring(1).ToLower();
                }
            }

            // 拼接所有单词，用下划线连接
            return string.Join("_", words);
        }

        /// <summary>
        /// 将 snake_case 转换为纯 PascalCase（无下划线）
        /// 例如: blog_article -> BlogArticle
        /// </summary>
        public static string ToPascalCaseNoDash(this string str)
        {
            if (string.IsNullOrEmpty(str))
                return str;

            var parts = str.Split('_');

            var result = string.Join("", parts.Select(part =>
                string.IsNullOrEmpty(part)
                    ? part
                    : char.ToUpper(part[0]) + part.Substring(1).ToLower()
            ));

            return result;
        }
    }

}
