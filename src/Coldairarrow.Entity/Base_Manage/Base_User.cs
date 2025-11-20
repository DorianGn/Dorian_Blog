using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Coldairarrow.Entity.Base_Manage
{
    /// <summary>
    /// 系统用户表
    /// </summary>
    [Table("Base_User")]
    public class Base_User
    {

        /// <summary>
        /// 主键
        /// </summary>
        [Key, Column(Order = 1)]
        public String Id { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateTime { get; set; }

        /// <summary>
        /// 创建人Id
        /// </summary>
        public String CreatorId { get; set; }

        /// <summary>
        /// 否已删除
        /// </summary>
        public Boolean Deleted { get; set; }

        /// <summary>
        /// 用户名
        /// </summary>
        public String UserName { get; set; }

        /// <summary>
        /// 密码
        /// </summary>
        public String Password { get; set; }

        /// <summary>
        /// 姓名
        /// </summary>
        public String RealName { get; set; }

        /// <summary>
        /// 性别
        /// </summary>
        public Sex Sex { get; set; }

        /// <summary>
        /// 出生日期
        /// </summary>
        public DateTime? Birthday { get; set; }

        /// <summary>
        /// 所属部门Id
        /// </summary>
        public String DepartmentId { get; set; }
        /// <summary>
        /// 头像URL
        /// </summary>
        public string Avatar { get; set; }

        /// <summary>
        /// 邮箱
        /// </summary>
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Introduction { get; set; }
        public UserType UserType { get; set; }
        public DateTime? LastLoginTime { get; set; }
        public string LastLoginIP { get; set; }
        public int Status { get; set; }
    }

    public enum Sex
    {
        [Description("男人")]
        Man = 1,

        [Description("女人")]
        Woman = 0
    }
    public enum UserType
    {
        User = 0,
        Student = 1,      
        Teacher = 2,
        InstitutionAdmin = 3,
        Admin = 4,        
    }
}