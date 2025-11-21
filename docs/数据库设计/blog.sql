/*
 Navicat Premium Dump SQL

 Source Server         : work
 Source Server Type    : MySQL
 Source Server Version : 80012 (8.0.12)
 Source Host           : localhost:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 80012 (8.0.12)
 File Encoding         : 65001

 Date: 21/11/2025 16:04:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for base_action
-- ----------------------------
DROP TABLE IF EXISTS `base_action`;
CREATE TABLE `base_action`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreatorId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人Id',
  `Deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '否已删除',
  `ParentId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父级Id',
  `Type` int(11) NOT NULL COMMENT '类型,菜单=0,页面=1,权限=2',
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限名/菜单名',
  `Url` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '菜单地址',
  `Value` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限值',
  `NeedAction` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否需要权限(仅页面有效)',
  `Icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `Sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of base_action
-- ----------------------------
INSERT INTO `base_action` VALUES ('1178957405992521728', '2019-10-01 16:58:44', NULL, 0, NULL, 0, '系统管理', '', NULL, 1, 'setting', 1);
INSERT INTO `base_action` VALUES ('1178957553778823168', '2019-10-01 16:59:19', NULL, 0, '1178957405992521728', 1, '权限管理', '/Base_Manage/Base_Action/List', NULL, 1, NULL, 20);
INSERT INTO `base_action` VALUES ('1179018395304071168', '2019-10-01 21:01:05', NULL, 0, '1178957405992521728', 1, '密钥管理', '/Base_Manage/Base_AppSecret/List', NULL, 1, NULL, 15);
INSERT INTO `base_action` VALUES ('1182652266117599232', '2019-10-11 21:40:47', NULL, 0, '1178957405992521728', 1, '用户管理', '/Base_Manage/Base_User/List', NULL, 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1182652367447789568', '2019-10-11 21:41:11', NULL, 0, '1178957405992521728', 1, '角色管理', '/Base_Manage/Base_Role/List', NULL, 1, NULL, 5);
INSERT INTO `base_action` VALUES ('1182652433302556672', '2019-10-11 21:41:27', NULL, 0, '1178957405992521728', 1, '部门管理', '/Base_Manage/Base_Department/List', NULL, 1, NULL, 10);
INSERT INTO `base_action` VALUES ('1188801057778569216', '2019-10-28 20:53:53', NULL, 0, '1182652367447789568', 2, '增', NULL, 'Base_Role.Add', 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1188801057778569217', '2019-10-28 20:53:53', NULL, 0, '1182652367447789568', 2, '改', NULL, 'Base_Role.Edit', 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1188801057778569218', '2019-10-28 20:53:53', NULL, 0, '1182652367447789568', 2, '删', NULL, 'Base_Role.Delete', 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1188801109783744512', '2019-10-28 20:54:06', NULL, 0, '1182652433302556672', 2, '增', NULL, 'Base_Department.Add', 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1188801109783744513', '2019-10-28 20:54:06', NULL, 0, '1182652433302556672', 2, '改', NULL, 'Base_Department.Edit', 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1188801109783744514', '2019-10-28 20:54:06', NULL, 0, '1182652433302556672', 2, '删', NULL, 'Base_Department.Delete', 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1188801273885888512', '2019-10-28 20:54:45', NULL, 0, '1179018395304071168', 2, '增', NULL, 'Base_AppSecret.Add', 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1188801273885888513', '2019-10-28 20:54:45', NULL, 0, '1179018395304071168', 2, '改', NULL, 'Base_AppSecret.Edit', 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1188801273885888514', '2019-10-28 20:54:45', NULL, 0, '1179018395304071168', 2, '删', NULL, 'Base_AppSecret.Delete', 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1188801341661646848', '2019-10-28 20:55:01', NULL, 0, '1178957553778823168', 2, '增', NULL, 'Base_Action.Add', 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1188801341661646849', '2019-10-28 20:55:01', NULL, 0, '1178957553778823168', 2, '改', NULL, 'Base_Action.Edit', 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1188801341661646850', '2019-10-28 20:55:01', NULL, 0, '1178957553778823168', 2, '删', NULL, 'Base_Action.Delete', 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1193158266167758848', '2019-11-09 21:27:53', 'Admin', 0, NULL, 0, '首页', NULL, NULL, 1, 'home', 0);
INSERT INTO `base_action` VALUES ('1193158630615027712', '2019-11-09 21:29:20', 'Admin', 0, '1193158266167758848', 1, '项目介绍', '/Home/Introduce', NULL, 0, NULL, 0);
INSERT INTO `base_action` VALUES ('1193158780011941888', '2019-11-09 21:29:55', 'Admin', 0, '1193158266167758848', 1, '数据统计', '/Home/Statis', NULL, 0, NULL, 0);
INSERT INTO `base_action` VALUES ('1251792477787000832', '2020-04-19 16:39:19', NULL, 0, '1182652266117599232', 2, '增', NULL, 'Base_User.Add', 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1251792477787000833', '2020-04-19 16:39:19', NULL, 0, '1182652266117599232', 2, '改', NULL, 'Base_User.Edit', 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1251792477787000834', '2020-04-19 16:39:19', NULL, 0, '1182652266117599232', 2, '删', NULL, 'Base_User.Delete', 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1251792721769664512', '2020-04-19 16:40:17', 'Admin', 0, '1178957405992521728', 1, '操作日志', '/Base_Manage/Base_UserLog/List', NULL, 0, NULL, 23);
INSERT INTO `base_action` VALUES ('1991741581203345408', '2025-11-21 13:32:52', 'Admin', 0, NULL, 0, '博客管理', NULL, NULL, 1, 'file-text', 0);
INSERT INTO `base_action` VALUES ('1991768912332591104', '2025-11-21 15:21:29', 'Admin', 0, '1991741581203345408', 1, '文章管理', '/Blog_Manage/blog_article/List', NULL, 1, NULL, 0);

-- ----------------------------
-- Table structure for base_appsecret
-- ----------------------------
DROP TABLE IF EXISTS `base_appsecret`;
CREATE TABLE `base_appsecret`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '自然主键',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreatorId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人Id',
  `Deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '否已删除',
  `AppId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '应用Id',
  `AppSecret` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '应用密钥',
  `AppName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '应用名',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用密钥表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of base_appsecret
-- ----------------------------
INSERT INTO `base_appsecret` VALUES ('1172497995938271232', '2019-09-13 21:11:20', 'Admin', 0, 'PcAdmin', 'wtMaiTRPTT3hrf5e', '后台AppId');
INSERT INTO `base_appsecret` VALUES ('1173937877642383360', '2019-09-17 20:32:55', 'Admin', 0, 'AppAdmin', 'IVh9LLSVFcoQPQ5K', 'APP密钥');

-- ----------------------------
-- Table structure for base_buildtest
-- ----------------------------
DROP TABLE IF EXISTS `base_buildtest`;
CREATE TABLE `base_buildtest`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '自然主键',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreatorId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人Id',
  `Deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '否已删除',
  `Column1` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列1',
  `Column2` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列2',
  `Column3` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列3',
  `Column4` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列4',
  `Column5` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列5',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '生成测试表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of base_buildtest
-- ----------------------------

-- ----------------------------
-- Table structure for base_dblink
-- ----------------------------
DROP TABLE IF EXISTS `base_dblink`;
CREATE TABLE `base_dblink`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '自然主键',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreatorId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人Id',
  `Deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '否已删除',
  `LinkName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '连接名',
  `ConnectionStr` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '连接字符串',
  `DbType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库类型',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据库连接表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of base_dblink
-- ----------------------------
INSERT INTO `base_dblink` VALUES ('1183373232498020352', '2019-10-13 21:25:39', 'Admin', 0, 'work', 'server=localhost;port=3306;database=blog;user=root;password=123456;', 'MySql');

-- ----------------------------
-- Table structure for base_department
-- ----------------------------
DROP TABLE IF EXISTS `base_department`;
CREATE TABLE `base_department`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreatorId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人Id',
  `Deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '否已删除',
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名',
  `ParentId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上级部门Id',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of base_department
-- ----------------------------
INSERT INTO `base_department` VALUES ('1181175685528424448', '2019-10-07 19:53:23', NULL, 0, '总公司', NULL);
INSERT INTO `base_department` VALUES ('1181175803631636480', '2019-10-07 19:53:51', NULL, 0, '事业部', '1181175685528424448');
INSERT INTO `base_department` VALUES ('1181175865409540096', '2019-10-07 19:54:06', NULL, 0, '业务部', '1181175685528424448');

-- ----------------------------
-- Table structure for base_role
-- ----------------------------
DROP TABLE IF EXISTS `base_role`;
CREATE TABLE `base_role`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreatorId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人Id',
  `Deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '否已删除',
  `RoleName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of base_role
-- ----------------------------
INSERT INTO `base_role` VALUES ('1180486275199668224', '2019-10-05 22:13:55', NULL, 0, '超级管理员');
INSERT INTO `base_role` VALUES ('1990974945336758272', '2025-11-19 10:46:32', 'Admin', 0, '一级管理员');
INSERT INTO `base_role` VALUES ('1990975039104618496', '2025-11-19 10:46:55', 'Admin', 0, '用户');
INSERT INTO `base_role` VALUES ('1991712451162279936', '2025-11-21 11:37:07', 'Admin', 0, '游客');

-- ----------------------------
-- Table structure for base_roleaction
-- ----------------------------
DROP TABLE IF EXISTS `base_roleaction`;
CREATE TABLE `base_roleaction`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreatorId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人Id',
  `Deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '否已删除',
  `RoleId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户Id',
  `ActionId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限Id',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of base_roleaction
-- ----------------------------
INSERT INTO `base_roleaction` VALUES ('1188801858282459136', '2019-10-28 20:57:04', NULL, 0, '1180486275199668224', '1182654049414025216');
INSERT INTO `base_roleaction` VALUES ('1188801858282459137', '2019-10-28 20:57:04', NULL, 0, '1180486275199668224', '1182654208411701248');
INSERT INTO `base_roleaction` VALUES ('1188801858282459138', '2019-10-28 20:57:04', NULL, 0, '1180486275199668224', '1183370665412005888');
INSERT INTO `base_roleaction` VALUES ('1990974945542279168', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1193158266167758848');
INSERT INTO `base_roleaction` VALUES ('1990974945542279169', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1193158630615027712');
INSERT INTO `base_roleaction` VALUES ('1990974945542279170', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1193158780011941888');
INSERT INTO `base_roleaction` VALUES ('1990974945542279171', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1178957405992521728');
INSERT INTO `base_roleaction` VALUES ('1990974945542279172', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1182652266117599232');
INSERT INTO `base_roleaction` VALUES ('1990974945542279173', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1182652367447789568');
INSERT INTO `base_roleaction` VALUES ('1990974945542279174', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1182652433302556672');
INSERT INTO `base_roleaction` VALUES ('1990974945542279175', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1179018395304071168');
INSERT INTO `base_roleaction` VALUES ('1990974945542279176', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1178957553778823168');
INSERT INTO `base_roleaction` VALUES ('1990974945542279177', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1251792721769664512');
INSERT INTO `base_roleaction` VALUES ('1990974945542279178', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1251792477787000832');
INSERT INTO `base_roleaction` VALUES ('1990974945542279179', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1251792477787000833');
INSERT INTO `base_roleaction` VALUES ('1990974945542279180', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1188801057778569216');
INSERT INTO `base_roleaction` VALUES ('1990974945542279181', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1188801057778569217');
INSERT INTO `base_roleaction` VALUES ('1990974945542279182', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1188801109783744512');
INSERT INTO `base_roleaction` VALUES ('1990974945542279183', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1188801109783744513');
INSERT INTO `base_roleaction` VALUES ('1990974945542279184', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1188801273885888512');
INSERT INTO `base_roleaction` VALUES ('1990974945542279185', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1188801273885888513');
INSERT INTO `base_roleaction` VALUES ('1990974945542279186', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1188801341661646848');
INSERT INTO `base_roleaction` VALUES ('1990974945542279187', '2025-11-19 10:46:32', NULL, 0, '1990974945336758272', '1188801341661646849');
INSERT INTO `base_roleaction` VALUES ('1991712497400287232', '2025-11-21 11:37:18', NULL, 0, '1990975039104618496', '1193158266167758848');
INSERT INTO `base_roleaction` VALUES ('1991712497400287233', '2025-11-21 11:37:18', NULL, 0, '1990975039104618496', '1193158630615027712');
INSERT INTO `base_roleaction` VALUES ('1991712497400287234', '2025-11-21 11:37:18', NULL, 0, '1990975039104618496', '1193158780011941888');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb5662c69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000001');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb58b3c69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000002');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb5915c69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000003');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb5966c69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000004');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb59b8c69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000005');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb5a06c69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000006');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb5a56c69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000011');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb5aa5c69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000012');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb5af3c69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000013');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb5b43c69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000021');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb5b92c69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000022');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb5be1c69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000023');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb5c30c69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000031');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb5c7fc69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000032');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb5ccdc69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000033');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb5d1bc69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000041');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb5d6ac69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000042');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb5db8c69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000051');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb5e07c69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000052');
INSERT INTO `base_roleaction` VALUES ('ra_ecdb5e56c69f11f081da00e04c8df293', '2025-11-21 14:04:24', 'Admin', 0, '1180486275199668224', '1991741600000000053');

-- ----------------------------
-- Table structure for base_user
-- ----------------------------
DROP TABLE IF EXISTS `base_user`;
CREATE TABLE `base_user`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreatorId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人Id',
  `Deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '否已删除',
  `UserName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `Password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `RealName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `Sex` int(11) NULL DEFAULT 0 COMMENT '性别(1为男，0为女)',
  `Birthday` date NULL DEFAULT NULL COMMENT '出生日期',
  `DepartmentId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门Id',
  `UserType` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '用户身份',
  `Email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `Phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `Introduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个人介绍',
  `LastLoginTime` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `LastLoginIP` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后登录IP',
  `Status` int(255) NULL DEFAULT 0 COMMENT '状态',
  `Avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of base_user
-- ----------------------------
INSERT INTO `base_user` VALUES ('1181928860648738816', '2019-10-09 21:46:14', NULL, 0, 'xiaohua', 'e10adc3949ba59abbe56e057f20f883e', '小花', 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 1, NULL);
INSERT INTO `base_user` VALUES ('1183363221872971776', '2019-10-13 20:45:52', 'Admin', 0, 'aa', NULL, 'aaa', 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 1, NULL);
INSERT INTO `base_user` VALUES ('1990964509132460032', '2025-11-19 10:05:04', NULL, 0, 'fff', '670b14728ad9902aecba32e22fa4f6bd', '发发发', 0, NULL, NULL, 0, '3458719294@qq.com', NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `base_user` VALUES ('1990981464736403456', '2025-11-19 11:12:27', NULL, 0, 'sss', '670b14728ad9902aecba32e22fa4f6bd', '0000', 1, NULL, NULL, 0, '3458719294@qq.com', NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `base_user` VALUES ('Admin', '2019-09-13 21:10:03', 'Admin', 0, 'Admin', '670b14728ad9902aecba32e22fa4f6bd', '超级管理员', 1, '2019-09-13', NULL, 0, NULL, NULL, NULL, NULL, NULL, 1, NULL);

-- ----------------------------
-- Table structure for base_userlog
-- ----------------------------
DROP TABLE IF EXISTS `base_userlog`;
CREATE TABLE `base_userlog`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '自然主键',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreatorId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人Id',
  `CreatorRealName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
  `LogType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志类型',
  `LogContent` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '日志内容',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of base_userlog
-- ----------------------------
INSERT INTO `base_userlog` VALUES ('1990974806735982592', '2025-11-19 10:45:59', 'Admin', '超级管理员', '系统角色管理', '删除角色:部门管理员');
INSERT INTO `base_userlog` VALUES ('1990974806857617408', '2025-11-19 10:45:59', 'Admin', '超级管理员', '系统角色管理', '删除角色:部门管理员');
INSERT INTO `base_userlog` VALUES ('1990974945638748160', '2025-11-19 10:46:32', 'Admin', '超级管理员', '系统角色管理', '添加角色:一级管理员');
INSERT INTO `base_userlog` VALUES ('1990975039381442560', '2025-11-19 10:46:55', 'Admin', '超级管理员', '系统角色管理', '添加角色:用户');
INSERT INTO `base_userlog` VALUES ('1990975072659050496', '2025-11-19 10:47:03', 'Admin', '超级管理员', '系统角色管理', '添加角色:学生');
INSERT INTO `base_userlog` VALUES ('1990975096918904832', '2025-11-19 10:47:08', 'Admin', '超级管理员', '系统角色管理', '添加角色:教师');
INSERT INTO `base_userlog` VALUES ('1990977707281747968', '2025-11-19 10:57:31', 'Admin', '超级管理员', '系统用户管理', '修改用户:发发发');
INSERT INTO `base_userlog` VALUES ('1990977707298525184', '2025-11-19 10:57:31', 'Admin', '超级管理员', '系统用户管理', '修改用户:发发发');
INSERT INTO `base_userlog` VALUES ('1990977761497321472', '2025-11-19 10:57:44', 'Admin', '超级管理员', '系统用户管理', '修改用户:小花');
INSERT INTO `base_userlog` VALUES ('1990977761765756928', '2025-11-19 10:57:44', 'Admin', '超级管理员', '系统用户管理', '修改用户:小花');
INSERT INTO `base_userlog` VALUES ('1990977793076236288', '2025-11-19 10:57:51', 'Admin', '超级管理员', '系统用户管理', '修改用户:aaa');
INSERT INTO `base_userlog` VALUES ('1990977793181093888', '2025-11-19 10:57:51', 'Admin', '超级管理员', '系统用户管理', '修改用户:aaa');
INSERT INTO `base_userlog` VALUES ('1990982508933550080', '2025-11-19 11:16:35', 'Admin', '超级管理员', '系统角色管理', '修改角色:用户');
INSERT INTO `base_userlog` VALUES ('1990982509067767808', '2025-11-19 11:16:35', 'Admin', '超级管理员', '系统角色管理', '修改角色:用户');
INSERT INTO `base_userlog` VALUES ('1990982579452383232', '2025-11-19 11:16:52', '1990981464736403456', NULL, '系统角色管理', '修改角色:用户');
INSERT INTO `base_userlog` VALUES ('1990982579557240832', '2025-11-19 11:16:52', '1990981464736403456', NULL, '系统角色管理', '修改角色:用户');
INSERT INTO `base_userlog` VALUES ('1991425455881719808', '2025-11-20 16:36:42', 'Admin', '超级管理员', '系统用户管理', '修改用户:0000');
INSERT INTO `base_userlog` VALUES ('1991425456032714752', '2025-11-20 16:36:42', 'Admin', '超级管理员', '系统用户管理', '修改用户:0000');
INSERT INTO `base_userlog` VALUES ('1991425547971858432', '2025-11-20 16:37:04', 'Admin', '超级管理员', '部门管理', '修改部门名:总公司');
INSERT INTO `base_userlog` VALUES ('1991425686606188544', '2025-11-20 16:37:37', 'Admin', '超级管理员', '部门管理', '修改部门名:事业部');
INSERT INTO `base_userlog` VALUES ('1991425735071371264', '2025-11-20 16:37:49', 'Admin', '超级管理员', '部门管理', '修改部门名:业务部');
INSERT INTO `base_userlog` VALUES ('1991712346585698304', '2025-11-21 11:36:42', 'Admin', '超级管理员', '系统角色管理', '删除角色:学生');
INSERT INTO `base_userlog` VALUES ('1991712346724110336', '2025-11-21 11:36:42', 'Admin', '超级管理员', '系统角色管理', '删除角色:学生');
INSERT INTO `base_userlog` VALUES ('1991712354340966400', '2025-11-21 11:36:44', 'Admin', '超级管理员', '系统角色管理', '删除角色:教师');
INSERT INTO `base_userlog` VALUES ('1991712354416463872', '2025-11-21 11:36:44', 'Admin', '超级管理员', '系统角色管理', '删除角色:教师');
INSERT INTO `base_userlog` VALUES ('1991712451690762240', '2025-11-21 11:37:07', 'Admin', '超级管理员', '系统角色管理', '添加角色:游客');
INSERT INTO `base_userlog` VALUES ('1991712497442230272', '2025-11-21 11:37:18', 'Admin', '超级管理员', '系统角色管理', '修改角色:用户');
INSERT INTO `base_userlog` VALUES ('1991712497660334080', '2025-11-21 11:37:18', 'Admin', '超级管理员', '系统角色管理', '修改角色:用户');

-- ----------------------------
-- Table structure for base_userrole
-- ----------------------------
DROP TABLE IF EXISTS `base_userrole`;
CREATE TABLE `base_userrole`  (
  `Id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreatorId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人Id',
  `Deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '否已删除',
  `UserId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户Id',
  `RoleId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色Id',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of base_userrole
-- ----------------------------
INSERT INTO `base_userrole` VALUES ('1181927367719784448', '2019-10-09 21:40:18', NULL, 0, '1181922344629702656', '1180819481383931904');
INSERT INTO `base_userrole` VALUES ('1181927367719784449', '2019-10-09 21:40:18', NULL, 0, '1181922344629702656', '1180486275199668224');
INSERT INTO `base_userrole` VALUES ('1181927783786352640', '2019-10-09 21:41:57', NULL, 0, '1181927783727632384', '1180819481383931904');
INSERT INTO `base_userrole` VALUES ('1990977707202056192', '2025-11-19 10:57:31', NULL, 0, '1990964509132460032', '1990975039104618496');
INSERT INTO `base_userrole` VALUES ('1990977761476349952', '2025-11-19 10:57:44', NULL, 0, '1181928860648738816', '1990975072537415680');
INSERT INTO `base_userrole` VALUES ('1990977793067847680', '2025-11-19 10:57:51', NULL, 0, '1183363221872971776', '1990975096713383936');
INSERT INTO `base_userrole` VALUES ('1991425455583924224', '2025-11-20 16:36:42', NULL, 0, '1990981464736403456', '1990975039104618496');

-- ----------------------------
-- Table structure for blog_article
-- ----------------------------
DROP TABLE IF EXISTS `blog_article`;
CREATE TABLE `blog_article`  (
  `Id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键',
  `Title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章标题',
  `Summary` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文章摘要',
  `Content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章内容(富文本HTML)',
  `CoverImage` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面图片URL',
  `CategoryId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类ID',
  `AuthorId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '作者ID(关联Base_User.Id)',
  `Status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '文章状态(0=草稿,1=已发布,2=已隐藏)',
  `IsTop` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否置顶(0=否,1=是)',
  `IsRecommend` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否推荐(0=否,1=是)',
  `AllowComment` tinyint(4) NOT NULL DEFAULT 1 COMMENT '是否允许评论(0=否,1=是)',
  `ViewCount` int(11) NOT NULL DEFAULT 0 COMMENT '阅读量',
  `LikeCount` int(11) NOT NULL DEFAULT 0 COMMENT '点赞数',
  `CommentCount` int(11) NOT NULL DEFAULT 0 COMMENT '评论数',
  `PublishTime` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `IsDeleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除(0=否,1=是)',
  `CreatedTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreatorId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人ID',
  `UpdatedTime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `UpdaterId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '更新人ID',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `idx_category`(`CategoryId` ASC) USING BTREE,
  INDEX `idx_author`(`AuthorId` ASC) USING BTREE,
  INDEX `idx_status`(`Status` ASC) USING BTREE,
  INDEX `idx_publishtime`(`PublishTime` DESC) USING BTREE,
  INDEX `idx_istop_status`(`IsTop` DESC, `Status` ASC) USING BTREE,
  FULLTEXT INDEX `ft_title_content`(`Title`, `Content`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文章表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of blog_article
-- ----------------------------

-- ----------------------------
-- Table structure for blog_articletag
-- ----------------------------
DROP TABLE IF EXISTS `blog_articletag`;
CREATE TABLE `blog_articletag`  (
  `Id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键',
  `ArticleId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章ID',
  `TagId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标签ID',
  `CreatedTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `uk_article_tag`(`ArticleId` ASC, `TagId` ASC) USING BTREE COMMENT '文章-标签联合唯一索引',
  INDEX `idx_article`(`ArticleId` ASC) USING BTREE,
  INDEX `idx_tag`(`TagId` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文章标签关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of blog_articletag
-- ----------------------------

-- ----------------------------
-- Table structure for blog_banner
-- ----------------------------
DROP TABLE IF EXISTS `blog_banner`;
CREATE TABLE `blog_banner`  (
  `Id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键',
  `Title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '轮播图标题',
  `ImageUrl` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片URL',
  `LinkUrl` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '链接地址(点击跳转)',
  `LinkType` tinyint(4) NOT NULL DEFAULT 0 COMMENT '链接类型(0=无链接,1=内部链接,2=外部链接)',
  `Description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `SortIndex` int(11) NOT NULL DEFAULT 0 COMMENT '排序号(越小越靠前)',
  `Status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态(0=禁用,1=启用)',
  `IsDeleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除(0=否,1=是)',
  `CreatedTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreatorId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人ID',
  `UpdatedTime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `UpdaterId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '更新人ID',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `idx_status_sort`(`Status` ASC, `SortIndex` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '轮播图表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of blog_banner
-- ----------------------------
INSERT INTO `blog_banner` VALUES ('ban001', '欢迎来到我的博客', '/images/banner1.jpg', '', 0, '欢迎来到我的个人博客，这里记录我的技术成长之路', 1, 1, 0, '2025-11-21 14:01:19', 'Admin', NULL, NULL);
INSERT INTO `blog_banner` VALUES ('ban002', '技术分享', '/images/banner2.jpg', '', 0, '分享前端、后端开发经验', 2, 1, 0, '2025-11-21 14:01:19', 'Admin', NULL, NULL);

-- ----------------------------
-- Table structure for blog_category
-- ----------------------------
DROP TABLE IF EXISTS `blog_category`;
CREATE TABLE `blog_category`  (
  `Id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键',
  `Name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类名称',
  `Description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类描述',
  `Icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类图标',
  `SortIndex` int(11) NOT NULL DEFAULT 0 COMMENT '排序号(越小越靠前)',
  `Status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态(0=禁用,1=启用)',
  `ArticleCount` int(11) NOT NULL DEFAULT 0 COMMENT '该分类下的文章数量',
  `IsDeleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除(0=否,1=是)',
  `CreatedTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreatorId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人Id',
  `UpdatedTime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `UpdaterId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '更新人Id',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `idx_status`(`Status` ASC) USING BTREE,
  INDEX `idx_sortindex`(`SortIndex` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文章分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of blog_category
-- ----------------------------
INSERT INTO `blog_category` VALUES ('cat001', '技术分享', '技术类文章，分享编程经验与技术心得', 'icon-code', 1, 1, 0, 0, '2025-11-21 14:00:59', 'Admin', NULL, NULL);
INSERT INTO `blog_category` VALUES ('cat002', '生活随笔', '记录生活点滴，分享生活感悟', 'icon-edit', 2, 1, 0, 0, '2025-11-21 14:00:59', 'Admin', NULL, NULL);
INSERT INTO `blog_category` VALUES ('cat003', '学习笔记', '学习过程中的笔记与总结', 'icon-book', 3, 1, 0, 0, '2025-11-21 14:00:59', 'Admin', NULL, NULL);
INSERT INTO `blog_category` VALUES ('cat004', '项目实战', '实际项目开发经验分享', 'icon-project', 4, 1, 0, 0, '2025-11-21 14:00:59', 'Admin', NULL, NULL);
INSERT INTO `blog_category` VALUES ('cat005', '工具推荐', '好用的开发工具与软件推荐', 'icon-tool', 5, 1, 0, 0, '2025-11-21 14:00:59', 'Admin', NULL, NULL);

-- ----------------------------
-- Table structure for blog_comment
-- ----------------------------
DROP TABLE IF EXISTS `blog_comment`;
CREATE TABLE `blog_comment`  (
  `Id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键',
  `ArticleId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章ID',
  `UserId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论用户ID(关联Base_User.Id)',
  `Content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `ParentId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '父评论ID(NULL表示一级评论)',
  `ReplyToUserId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '回复的目标用户ID(@用户)',
  `LikeCount` int(11) NOT NULL DEFAULT 0 COMMENT '点赞数',
  `Status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态(0=已删除,1=正常,2=已屏蔽)',
  `IsDeleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除(0=否,1=是)',
  `CreatedTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
  `UpdatedTime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `idx_article`(`ArticleId` ASC) USING BTREE,
  INDEX `idx_user`(`UserId` ASC) USING BTREE,
  INDEX `idx_parent`(`ParentId` ASC) USING BTREE,
  INDEX `idx_createdtime`(`CreatedTime` DESC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of blog_comment
-- ----------------------------

-- ----------------------------
-- Table structure for blog_like
-- ----------------------------
DROP TABLE IF EXISTS `blog_like`;
CREATE TABLE `blog_like`  (
  `Id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键',
  `ArticleId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章ID',
  `UserId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '点赞用户ID(关联Base_User.Id)',
  `CreatedTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '点赞时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `uk_article_user`(`ArticleId` ASC, `UserId` ASC) USING BTREE COMMENT '同一用户只能对同一文章点赞一次',
  INDEX `idx_article`(`ArticleId` ASC) USING BTREE,
  INDEX `idx_user`(`UserId` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '点赞表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of blog_like
-- ----------------------------

-- ----------------------------
-- Table structure for blog_setting
-- ----------------------------
DROP TABLE IF EXISTS `blog_setting`;
CREATE TABLE `blog_setting`  (
  `Id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键',
  `SettingKey` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置键',
  `SettingValue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '配置值',
  `Description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '配置说明',
  `UpdatedTime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `UpdaterId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '更新人ID',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `uk_key`(`SettingKey` ASC) USING BTREE COMMENT '配置键唯一'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统设置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of blog_setting
-- ----------------------------
INSERT INTO `blog_setting` VALUES ('set001', 'BlogName', '我的个人博客', '博客名称', '2025-11-21 14:01:12', 'Admin');
INSERT INTO `blog_setting` VALUES ('set002', 'BlogDescription', '记录技术与生活的点点滴滴', '博客描述', '2025-11-21 14:01:12', 'Admin');
INSERT INTO `blog_setting` VALUES ('set003', 'BlogKeywords', 'Vue.js,.NET Core,技术博客,个人博客', '博客关键词(SEO)', '2025-11-21 14:01:12', 'Admin');
INSERT INTO `blog_setting` VALUES ('set004', 'BlogLogo', '/images/logo.png', '博客Logo', '2025-11-21 14:01:12', 'Admin');
INSERT INTO `blog_setting` VALUES ('set005', 'Copyright', '© 2025 MyBlog. All Rights Reserved.', '版权信息', '2025-11-21 14:01:12', 'Admin');
INSERT INTO `blog_setting` VALUES ('set006', 'ContactEmail', 'admin@example.com', '联系邮箱', '2025-11-21 14:01:12', 'Admin');
INSERT INTO `blog_setting` VALUES ('set007', 'ICP', '', 'ICP备案号', '2025-11-21 14:01:12', 'Admin');
INSERT INTO `blog_setting` VALUES ('set008', 'AboutMe', '这是一个记录技术成长的个人博客', '关于我', '2025-11-21 14:01:12', 'Admin');
INSERT INTO `blog_setting` VALUES ('set009', 'GitHub', 'https://github.com/yourusername', 'GitHub地址', '2025-11-21 14:01:12', 'Admin');
INSERT INTO `blog_setting` VALUES ('set010', 'ArticlePageSize', '10', '文章列表每页显示数量', '2025-11-21 14:01:12', 'Admin');

-- ----------------------------
-- Table structure for blog_tag
-- ----------------------------
DROP TABLE IF EXISTS `blog_tag`;
CREATE TABLE `blog_tag`  (
  `Id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键',
  `Name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标签名称',
  `Color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标签颜色(HEX色值,如#1890ff)',
  `ArticleCount` int(11) NOT NULL DEFAULT 0 COMMENT '该标签下的文章数量',
  `IsDeleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除(0=否,1=是)',
  `CreatedTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `CreatorId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人Id',
  `UpdatedTime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `UpdaterId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '更新人Id',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`Name` ASC) USING BTREE COMMENT '标签名称唯一'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文章标签表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of blog_tag
-- ----------------------------
INSERT INTO `blog_tag` VALUES ('tag001', 'Vue.js', '#42b883', 0, 0, '2025-11-21 14:01:05', 'Admin', NULL, NULL);
INSERT INTO `blog_tag` VALUES ('tag002', '.NET Core', '#512bd4', 0, 0, '2025-11-21 14:01:05', 'Admin', NULL, NULL);
INSERT INTO `blog_tag` VALUES ('tag003', 'MySQL', '#00758f', 0, 0, '2025-11-21 14:01:05', 'Admin', NULL, NULL);
INSERT INTO `blog_tag` VALUES ('tag004', '前端开发', '#1890ff', 0, 0, '2025-11-21 14:01:05', 'Admin', NULL, NULL);
INSERT INTO `blog_tag` VALUES ('tag005', '后端开发', '#52c41a', 0, 0, '2025-11-21 14:01:05', 'Admin', NULL, NULL);
INSERT INTO `blog_tag` VALUES ('tag006', 'JavaScript', '#f7df1e', 0, 0, '2025-11-21 14:01:05', 'Admin', NULL, NULL);
INSERT INTO `blog_tag` VALUES ('tag007', 'C#', '#239120', 0, 0, '2025-11-21 14:01:05', 'Admin', NULL, NULL);
INSERT INTO `blog_tag` VALUES ('tag008', '数据库', '#336791', 0, 0, '2025-11-21 14:01:05', 'Admin', NULL, NULL);
INSERT INTO `blog_tag` VALUES ('tag009', 'Docker', '#2496ed', 0, 0, '2025-11-21 14:01:05', 'Admin', NULL, NULL);
INSERT INTO `blog_tag` VALUES ('tag010', 'Git', '#f05032', 0, 0, '2025-11-21 14:01:05', 'Admin', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
