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

 Date: 22/12/2025 09:42:25
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
INSERT INTO `base_action` VALUES ('1182652367447789568', '2019-10-11 21:41:11', NULL, 0, '1178957405992521728', 1, '角色权限', '/Base_Manage/Base_Role/List', NULL, 1, NULL, 5);
INSERT INTO `base_action` VALUES ('1182652433302556672', '2019-10-11 21:41:27', NULL, 0, '1178957405992521728', 1, '部门管理', '/Base_Manage/Base_Department/List', NULL, 1, NULL, 10);
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
INSERT INTO `base_action` VALUES ('1993528900084305920', '2025-11-26 11:55:02', 'Admin', 0, '1991741581203345408', 1, '分类管理', '/Blog_Manage/blog_category/List', NULL, 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1993851610786172928', '2025-11-27 09:17:23', NULL, 0, '1182652367447789568', 2, '增', NULL, 'Base_Role.Add', 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1993851610786172929', '2025-11-27 09:17:23', NULL, 0, '1182652367447789568', 2, '改', NULL, 'Base_Role.Edit', 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1993851610786172930', '2025-11-27 09:17:23', NULL, 0, '1182652367447789568', 2, '删', NULL, 'Base_Role.Delete', 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1995371171746418688', '2025-12-01 13:55:34', 'Admin', 0, '1991741581203345408', 1, '标签管理', '/Blog_Manage/blog_tag/List', NULL, 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1995700587437494272', '2025-12-02 11:44:33', 'Admin', 0, '1991741581203345408', 1, '点赞管理', '/Blog_Manage/blog_like/List', NULL, 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1995742553084792832', '2025-12-02 14:31:18', 'Admin', 0, '1991741581203345408', 1, '评论管理', '/Blog_Manage/blog_comment/List', NULL, 1, NULL, 0);
INSERT INTO `base_action` VALUES ('1996118982221893632', '2025-12-03 15:27:06', NULL, 0, '1993528900084305920', 2, '编辑文章数量', NULL, 'EditCount', 1, NULL, 0);
INSERT INTO `base_action` VALUES ('2001927048083279872', '2025-12-19 16:06:17', 'Admin', 0, NULL, 0, '轮播图管理', NULL, NULL, 1, 'picture', 0);

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
INSERT INTO `base_appsecret` VALUES ('1996789247025090560', '2025-12-05 11:50:30', 'Admin', 0, 'PcUser', 'summerA486@', '用户端');

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
INSERT INTO `base_role` VALUES ('1990975039104618496', '2025-11-19 10:46:55', 'Admin', 0, '权限-用户');
INSERT INTO `base_role` VALUES ('1991712451162279936', '2025-11-21 11:37:07', 'Admin', 0, '权限-游客');
INSERT INTO `base_role` VALUES ('1993617296907571200', '2025-11-26 17:46:18', 'Admin', 0, '权限-作者');

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
INSERT INTO `base_roleaction` VALUES ('1995766810590318592', '2025-12-02 16:07:42', NULL, 0, '1993617296907571200', '1193158266167758848');
INSERT INTO `base_roleaction` VALUES ('1995766810590318593', '2025-12-02 16:07:42', NULL, 0, '1993617296907571200', '1193158630615027712');
INSERT INTO `base_roleaction` VALUES ('1995766810590318594', '2025-12-02 16:07:42', NULL, 0, '1993617296907571200', '1193158780011941888');
INSERT INTO `base_roleaction` VALUES ('1995766884577841152', '2025-12-02 16:07:59', NULL, 0, '1990975039104618496', '1193158266167758848');
INSERT INTO `base_roleaction` VALUES ('1995766884577841153', '2025-12-02 16:07:59', NULL, 0, '1990975039104618496', '1193158630615027712');
INSERT INTO `base_roleaction` VALUES ('1995766884577841154', '2025-12-02 16:07:59', NULL, 0, '1990975039104618496', '1193158780011941888');
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
INSERT INTO `base_user` VALUES ('1995766124326686720', '2025-12-02 16:04:58', 'Admin', 0, '作者1', 'c6f057b86584942e415435ffb1fa93d4', '作者1', 0, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `base_user` VALUES ('1995766248624885760', '2025-12-02 16:05:28', 'Admin', 0, '作者2', 'c6f057b86584942e415435ffb1fa93d4', '作者2', 1, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `base_user` VALUES ('1995766378090467328', '2025-12-02 16:05:59', 'Admin', 0, '读者1', 'c6f057b86584942e415435ffb1fa93d4', '读者1', 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `base_user` VALUES ('1995766458172313600', '2025-12-02 16:06:18', 'Admin', 0, '读者2', 'c6f057b86584942e415435ffb1fa93d4', '读者2', 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `base_user` VALUES ('1998628768746311680', '2025-12-10 13:40:06', NULL, 0, 'ssaf', '670b14728ad9902aecba32e22fa4f6bd', NULL, 0, NULL, NULL, 0, 'zhansfai@163.com', NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `base_user` VALUES ('2001942489778360320', '2025-12-19 17:07:39', 'Admin', 0, '', NULL, '张飞', 1, '2025-12-16', NULL, 0, 'zhansfai@163.com', '19735226701', '.......................................................', NULL, NULL, 0, 'https://i.ibb.co/7xrs7Lxz/20250804111512-15-jpg.jpg');
INSERT INTO `base_user` VALUES ('2001943595220733952', '2025-12-19 17:12:02', 'Admin', 0, '', NULL, '', 1, NULL, NULL, 0, '', '', '', NULL, NULL, 0, 'https://i.ibb.co/7xrs7Lxz/20250804111512-15-jpg.jpg');
INSERT INTO `base_user` VALUES ('Admin', '0001-01-01 00:00:00', NULL, 0, 'Admin', '670b14728ad9902aecba32e22fa4f6bd', '超级管理员', 1, '2019-09-13', NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL);

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
INSERT INTO `base_userlog` VALUES ('1993617298056810496', '2025-11-26 17:46:18', 'Admin', '超级管理员', '系统角色管理', '添加角色:作者');
INSERT INTO `base_userlog` VALUES ('1993617332143919104', '2025-11-26 17:46:26', 'Admin', '超级管理员', '系统用户管理', '修改用户:小花');
INSERT INTO `base_userlog` VALUES ('1993617332311691264', '2025-11-26 17:46:26', 'Admin', '超级管理员', '系统用户管理', '修改用户:小花');
INSERT INTO `base_userlog` VALUES ('1993851337288192000', '2025-11-27 09:16:17', 'Admin', '超级管理员', '系统用户管理', '修改用户:小花');
INSERT INTO `base_userlog` VALUES ('1993851337493712896', '2025-11-27 09:16:17', 'Admin', '超级管理员', '系统用户管理', '修改用户:小花');
INSERT INTO `base_userlog` VALUES ('1993851423724408832', '2025-11-27 09:16:38', 'Admin', '超级管理员', '系统用户管理', '修改用户:aaa');
INSERT INTO `base_userlog` VALUES ('1993851423896375296', '2025-11-27 09:16:38', 'Admin', '超级管理员', '系统用户管理', '修改用户:aaa');
INSERT INTO `base_userlog` VALUES ('1995766125001969664', '2025-12-02 16:04:58', 'Admin', '超级管理员', '系统用户管理', '添加用户:作者1');
INSERT INTO `base_userlog` VALUES ('1995766125274599424', '2025-12-02 16:04:58', 'Admin', '超级管理员', '系统用户管理', '添加用户:作者1');
INSERT INTO `base_userlog` VALUES ('1995766248717160448', '2025-12-02 16:05:28', 'Admin', '超级管理员', '系统用户管理', '添加用户:作者2');
INSERT INTO `base_userlog` VALUES ('1995766248851378176', '2025-12-02 16:05:28', 'Admin', '超级管理员', '系统用户管理', '添加用户:作者2');
INSERT INTO `base_userlog` VALUES ('1995766281818607616', '2025-12-02 16:05:36', 'Admin', '超级管理员', '系统用户管理', '删除用户:小花');
INSERT INTO `base_userlog` VALUES ('1995766281856356352', '2025-12-02 16:05:36', 'Admin', '超级管理员', '系统用户管理', '删除用户:小花');
INSERT INTO `base_userlog` VALUES ('1995766293860454400', '2025-12-02 16:05:39', 'Admin', '超级管理员', '系统用户管理', '删除用户:aaa');
INSERT INTO `base_userlog` VALUES ('1995766293931757568', '2025-12-02 16:05:39', 'Admin', '超级管理员', '系统用户管理', '删除用户:aaa');
INSERT INTO `base_userlog` VALUES ('1995766302119038976', '2025-12-02 16:05:41', 'Admin', '超级管理员', '系统用户管理', '删除用户:发发发');
INSERT INTO `base_userlog` VALUES ('1995766302186147840', '2025-12-02 16:05:41', 'Admin', '超级管理员', '系统用户管理', '删除用户:发发发');
INSERT INTO `base_userlog` VALUES ('1995766310901911552', '2025-12-02 16:05:43', 'Admin', '超级管理员', '系统用户管理', '删除用户:0000');
INSERT INTO `base_userlog` VALUES ('1995766310973214720', '2025-12-02 16:05:43', 'Admin', '超级管理员', '系统用户管理', '删除用户:0000');
INSERT INTO `base_userlog` VALUES ('1995766378149187584', '2025-12-02 16:05:59', 'Admin', '超级管理员', '系统用户管理', '添加用户:读者1');
INSERT INTO `base_userlog` VALUES ('1995766378321154048', '2025-12-02 16:05:59', 'Admin', '超级管理员', '系统用户管理', '添加用户:读者1');
INSERT INTO `base_userlog` VALUES ('1995766458205868032', '2025-12-02 16:06:18', 'Admin', '超级管理员', '系统用户管理', '添加用户:读者2');
INSERT INTO `base_userlog` VALUES ('1995766458403000320', '2025-12-02 16:06:18', 'Admin', '超级管理员', '系统用户管理', '添加用户:读者2');
INSERT INTO `base_userlog` VALUES ('1995766510198460416', '2025-12-02 16:06:30', 'Admin', '超级管理员', '系统用户管理', '修改用户:读者2');
INSERT INTO `base_userlog` VALUES ('1995766510236209152', '2025-12-02 16:06:30', 'Admin', '超级管理员', '系统用户管理', '修改用户:读者2');
INSERT INTO `base_userlog` VALUES ('1995766718177218560', '2025-12-02 16:07:20', 'Admin', '超级管理员', '系统用户管理', '修改用户:作者1');
INSERT INTO `base_userlog` VALUES ('1995766718521151488', '2025-12-02 16:07:20', 'Admin', '超级管理员', '系统用户管理', '修改用户:作者1');
INSERT INTO `base_userlog` VALUES ('1995766810657427456', '2025-12-02 16:07:42', 'Admin', '超级管理员', '系统角色管理', '修改角色:权限-作者');
INSERT INTO `base_userlog` VALUES ('1995766810690981888', '2025-12-02 16:07:42', 'Admin', '超级管理员', '系统角色管理', '修改角色:权限-作者');
INSERT INTO `base_userlog` VALUES ('1995766843461079040', '2025-12-02 16:07:50', 'Admin', '超级管理员', '系统角色管理', '修改角色:权限-游客');
INSERT INTO `base_userlog` VALUES ('1995766843519799296', '2025-12-02 16:07:50', 'Admin', '超级管理员', '系统角色管理', '修改角色:权限-游客');
INSERT INTO `base_userlog` VALUES ('1995766884590424064', '2025-12-02 16:07:59', 'Admin', '超级管理员', '系统角色管理', '修改角色:权限-用户');
INSERT INTO `base_userlog` VALUES ('1995766884691087360', '2025-12-02 16:08:00', 'Admin', '超级管理员', '系统角色管理', '修改角色:权限-用户');
INSERT INTO `base_userlog` VALUES ('1995767847363547136', '2025-12-02 16:11:49', 'Admin', '超级管理员', '系统用户管理', '修改用户:作者2');
INSERT INTO `base_userlog` VALUES ('1995767847841697792', '2025-12-02 16:11:49', 'Admin', '超级管理员', '系统用户管理', '修改用户:作者2');
INSERT INTO `base_userlog` VALUES ('1995767893773520896', '2025-12-02 16:12:00', 'Admin', '超级管理员', '系统用户管理', '修改用户:超级管理员');
INSERT INTO `base_userlog` VALUES ('1995767893874184192', '2025-12-02 16:12:00', 'Admin', '超级管理员', '系统用户管理', '修改用户:超级管理员');
INSERT INTO `base_userlog` VALUES ('1995767912853409792', '2025-12-02 16:12:05', 'Admin', '超级管理员', '系统用户管理', '修改用户:超级管理员');
INSERT INTO `base_userlog` VALUES ('1995767912958267392', '2025-12-02 16:12:05', 'Admin', '超级管理员', '系统用户管理', '修改用户:超级管理员');
INSERT INTO `base_userlog` VALUES ('1996789248031723520', '2025-12-05 11:50:30', 'Admin', '超级管理员', '接口密钥管理', '添加应用Id:PcUser');
INSERT INTO `base_userlog` VALUES ('1996789285159702528', '2025-12-05 11:50:39', 'Admin', '超级管理员', '接口密钥管理', '修改应用Id:PcUser');
INSERT INTO `base_userlog` VALUES ('1998629697117753344', '2025-12-10 13:43:47', 'Admin', '超级管理员', '系统用户管理', '删除用户:');
INSERT INTO `base_userlog` VALUES ('1998629697281331200', '2025-12-10 13:43:47', 'Admin', '超级管理员', '系统用户管理', '删除用户:');
INSERT INTO `base_userlog` VALUES ('1998629709553864704', '2025-12-10 13:43:50', 'Admin', '超级管理员', '系统用户管理', '删除用户:');
INSERT INTO `base_userlog` VALUES ('1998629709662916608', '2025-12-10 13:43:50', 'Admin', '超级管理员', '系统用户管理', '删除用户:');
INSERT INTO `base_userlog` VALUES ('1998629719334981632', '2025-12-10 13:43:52', 'Admin', '超级管理员', '系统用户管理', '删除用户:');
INSERT INTO `base_userlog` VALUES ('1998629719431450624', '2025-12-10 13:43:53', 'Admin', '超级管理员', '系统用户管理', '删除用户:');
INSERT INTO `base_userlog` VALUES ('2001942491841957888', '2025-12-19 17:07:39', 'Admin', '超级管理员', '系统用户管理', '添加用户:张飞');
INSERT INTO `base_userlog` VALUES ('2001942492949254144', '2025-12-19 17:07:39', 'Admin', '超级管理员', '系统用户管理', '添加用户:张飞');
INSERT INTO `base_userlog` VALUES ('2001943595258482688', '2025-12-19 17:12:02', 'Admin', '超级管理员', '系统用户管理', '添加用户:');
INSERT INTO `base_userlog` VALUES ('2001943595656941568', '2025-12-19 17:12:02', 'Admin', '超级管理员', '系统用户管理', '添加用户:');
INSERT INTO `base_userlog` VALUES ('2001944444651180032', '2025-12-19 17:15:25', 'Admin', '超级管理员', '系统用户管理', '修改用户:超级管理员');
INSERT INTO `base_userlog` VALUES ('2001944444722483200', '2025-12-19 17:15:25', 'Admin', '超级管理员', '系统用户管理', '修改用户:超级管理员');

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
INSERT INTO `base_userrole` VALUES ('1991425455583924224', '2025-11-20 16:36:42', NULL, 0, '1990981464736403456', '1990975039104618496');
INSERT INTO `base_userrole` VALUES ('1993851337091059712', '2025-11-27 09:16:17', NULL, 0, '1181928860648738816', '1993617296907571200');
INSERT INTO `base_userrole` VALUES ('1993851423716020224', '2025-11-27 09:16:38', NULL, 0, '1183363221872971776', '1993617296907571200');
INSERT INTO `base_userrole` VALUES ('1995766378136604672', '2025-12-02 16:05:59', NULL, 0, '1995766378090467328', '1990975039104618496');
INSERT INTO `base_userrole` VALUES ('1995766510185877504', '2025-12-02 16:06:30', NULL, 0, '1995766458172313600', '1990975039104618496');
INSERT INTO `base_userrole` VALUES ('1995766718156247040', '2025-12-02 16:07:20', NULL, 0, '1995766124326686720', '1993617296907571200');
INSERT INTO `base_userrole` VALUES ('1995767847355158528', '2025-12-02 16:11:49', NULL, 0, '1995766248624885760', '1993617296907571200');
INSERT INTO `base_userrole` VALUES ('1998596061110734848', '2025-12-10 11:30:08', NULL, 0, '1998596059558842368', '1990975039104618496');
INSERT INTO `base_userrole` VALUES ('1998602627474001920', '2025-12-10 11:56:13', NULL, 0, '1998602626312179712', '1990975039104618496');
INSERT INTO `base_userrole` VALUES ('1998602832923594752', '2025-12-10 11:57:02', NULL, 0, '1998602832747433984', '1990975039104618496');
INSERT INTO `base_userrole` VALUES ('1998629220980363264', '2025-12-10 13:41:54', NULL, 0, '1998628768746311680', '1990975039104618496');

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
  `Status` int(4) NOT NULL DEFAULT 0 COMMENT '文章状态(0=草稿,1=已发布,2=已隐藏)',
  `IsTop` int(4) NOT NULL DEFAULT 0 COMMENT '是否置顶(0=否,1=是)',
  `IsRecommend` int(4) NOT NULL DEFAULT 0 COMMENT '是否推荐(0=否,1=是)',
  `AllowComment` int(4) NOT NULL DEFAULT 1 COMMENT '是否允许评论(0=否,1=是)',
  `ViewCount` int(11) NOT NULL DEFAULT 0 COMMENT '阅读量',
  `LikeCount` int(11) NOT NULL DEFAULT 0 COMMENT '点赞数',
  `CommentCount` int(11) NOT NULL DEFAULT 0 COMMENT '评论数',
  `PublishTime` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `IsDeleted` int(4) NOT NULL DEFAULT 0 COMMENT '是否删除(0=否,1=是)',
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
INSERT INTO `blog_article` VALUES ('1993518537196441600', '发送', '方法反反复复反反复复', '<p>少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞少时诵诗书双宿双飞</p>', 'https://i.ibb.co/DyrSwdf/t044626d4ce5cc5e2aa-jpg.jpg', 'cat002', '1995766124326686720', 0, 1, 0, 1, 0, 0, 0, '2025-11-26 11:19:34', 0, '0001-01-01 00:00:00', 'Admin', '2025-12-04 14:01:18', 'Admin');
INSERT INTO `blog_article` VALUES ('art001', 'Vue.js 3.0 核心特性详解', '深入解析Vue.js 3.0的Composition API、响应式系统、性能优化等核心特性，帮助开发者快速掌握Vue3的精髓。', '深入解析Vue.js 3.0的Composition API、响应式系统、性能优化等核心特性，帮助开发者快速掌握Vue3的精髓。', 'https://i.ibb.co/3mCJc34z/t044626d4ce5cc5e2aa-jpg.jpg', 'cat001', '1995766248624885760', 0, 1, 1, 0, 1580, 128, 45, '2025-11-26 16:49:55', 0, '2025-11-15 10:00:00', 'Admin', '2025-12-02 16:19:45', 'Admin');
INSERT INTO `blog_article` VALUES ('art002', '.NET Core 微服务架构实战', '基于.NET Core构建微服务架构的完整实战教程，涵盖服务拆分、服务通信、服务治理等核心内容。', '<h1>.NET Core 微服务架构实战</h1>\n<h2>项目背景</h2>\n<p>随着业务的快速发展，单体应用已经无法满足需求，本文将介绍如何使用.NET Core构建微服务架构...</p>\n<h2>技术选型</h2>\n<ul>\n<li>API网关: Ocelot</li>\n<li>服务注册与发现: Consul</li>\n<li>服务通信: gRPC</li>\n<li>消息队列: RabbitMQ</li>\n<li>分布式缓存: Redis</li>\n</ul>\n<h2>服务拆分</h2>\n<p>按照DDD领域驱动设计思想，将系统拆分为以下服务...</p>', 'https://i.ibb.co/4wd95pXP/e-KYR1wbj-Xx-jpg.jpg', 'cat004', '1995766124326686720', 1, 1, 1, 1, 2340, 215, 68, '2025-11-25 16:47:17', 0, '2025-11-10 14:00:00', 'Admin', '2025-12-02 16:19:50', 'Admin');
INSERT INTO `blog_article` VALUES ('art003', '我的编程之路：从入门到放弃再到坚持', '回顾自己学习编程的心路历程，分享遇到的困难、突破的喜悦，以及对未来的期待。', '<h1>我的编程之路</h1>\r\n<h2>初识编程</h2>\r\n<p>记得第一次接触编程是在大学时期，那时候对着黑色的命令行窗口，敲下第一行代码：<code>console.log(\"Hello World\")</code></p>\r\n<h2>遇到的困难</h2>\r\n<p>学习过程中遇到过很多困难，比如指针、递归、算法等概念一开始完全看不懂...</p>\r\n<h2>突破与成长</h2>\r\n<p>经过不断的学习和实践，逐渐找到了学习方法，也开始享受编程带来的乐趣...</p>\r\n<h2>未来展望</h2>\r\n<p>希望能够在技术的道路上走得更远，也希望能够帮助更多的人...</p>', 'https://i.ibb.co/3mCJc34z/t044626d4ce5cc5e2aa-jpg.jpg', 'cat002', '1995766124326686720', 1, 0, 1, 1, 856, 92, 28, '2025-11-12 09:45:00', 0, '2025-11-12 09:30:00', '1181928860648738816', '2025-12-03 10:22:02', 'Admin');
INSERT INTO `blog_article` VALUES ('art004', 'MySQL 性能优化实战：从慢查询到索引优化', '详细讲解MySQL性能优化的各种技巧，包括慢查询分析、索引设计、SQL优化等实战经验。', '<h1>MySQL 性能优化实战</h1>\r\n<h2>一、慢查询分析</h2>\r\n<p>通过开启慢查询日志，找出系统中执行缓慢的SQL语句...</p>\r\n<pre><code>\r\n-- 开启慢查询日志\r\nSET GLOBAL slow_query_log = \'ON\';\r\nSET GLOBAL long_query_time = 2;\r\n</code></pre>\r\n<h2>二、索引优化</h2>\r\n<p>合理的索引设计是提升查询性能的关键...</p>\r\n<ul>\r\n<li>选择合适的索引类型</li>\r\n<li>避免索引失效</li>\r\n<li>覆盖索引的使用</li>\r\n</ul>\r\n<h2>三、SQL优化</h2>\r\n<p>优化SQL语句的编写方式，提升查询效率...</p>', 'https://i.ibb.co/3mCJc34z/t044626d4ce5cc5e2aa-jpg.jpg', 'cat001', '1181928860648738816', 1, 0, 1, 1, 1890, 167, 52, '2025-11-08 16:10:00', 0, '2025-11-08 16:00:00', 'Admin', '2025-11-16 11:30:00', 'Admin');
INSERT INTO `blog_article` VALUES ('art005', 'Git 版本控制最佳实践', '总结Git使用过程中的最佳实践，包括分支管理、提交规范、冲突解决等实用技巧。', '<h1>Git 版本控制最佳实践</h1>\r\n<h2>分支管理策略</h2>\r\n<p>采用Git Flow工作流，规范团队协作...</p>\r\n<ul>\r\n<li>master: 主分支，保持稳定</li>\r\n<li>develop: 开发分支</li>\r\n<li>feature: 功能分支</li>\r\n<li>hotfix: 热修复分支</li>\r\n</ul>\r\n<h2>提交规范</h2>\r\n<pre><code>\r\nfeat: 新增功能\r\nfix: 修复bug\r\ndocs: 文档更新\r\nstyle: 代码格式调整\r\nrefactor: 代码重构\r\n</code></pre>\r\n<h2>常用命令</h2>\r\n<p>整理了Git使用过程中的常用命令...</p>', 'https://i.ibb.co/3mCJc34z/t044626d4ce5cc5e2aa-jpg.jpg', 'cat005', '1181928860648738816', 1, 0, 1, 1, 1245, 103, 34, '2025-11-14 11:20:00', 0, '2025-11-14 11:00:00', '1990964509132460032', '2025-11-26 11:27:31', 'Admin');
INSERT INTO `blog_article` VALUES ('art006', 'TypeScript 从入门到精通', '系统学习TypeScript的类型系统、高级特性、实战应用，帮助JavaScript开发者快速掌握TypeScript。', '<h1>TypeScript 从入门到精通</h1>\r\n<h2>为什么选择TypeScript</h2>\r\n<p>TypeScript为JavaScript添加了类型系统，带来了更好的开发体验...</p>\r\n<h2>基础类型</h2>\r\n<pre><code>\r\nlet isDone: boolean = false\r\nlet count: number = 10\r\nlet name: string = \"TypeScript\"\r\nlet list: number[] = [1, 2, 3]\r\n</code></pre>\r\n<h2>高级类型</h2>\r\n<p>泛型、联合类型、交叉类型等高级特性...</p>\r\n<h2>实战应用</h2>\r\n<p>在Vue 3项目中使用TypeScript的最佳实践...</p>', 'https://i.ibb.co/3mCJc34z/t044626d4ce5cc5e2aa-jpg.jpg', 'cat003', '1181928860648738816', 1, 0, 1, 1, 1678, 145, 41, '2025-11-13 13:40:00', 0, '2025-11-13 13:20:00', 'Admin', '2025-11-26 11:27:29', 'Admin');
INSERT INTO `blog_article` VALUES ('art007', 'Docker 容器化部署实战指南', '详解Docker的核心概念、镜像制作、容器编排，以及在生产环境中的最佳实践。', '<h1>Docker 容器化部署实战</h1>\r\n<h2>Docker基础</h2>\r\n<p>Docker是一个开源的容器化平台...</p>\r\n<h2>Dockerfile编写</h2>\r\n<pre><code>\r\nFROM node:16-alpine\r\nWORKDIR /app\r\nCOPY package*.json ./\r\nRUN npm install\r\nCOPY . .\r\nEXPOSE 3000\r\nCMD [\"npm\", \"start\"]\r\n</code></pre>\r\n<h2>Docker Compose</h2>\r\n<p>使用Docker Compose编排多容器应用...</p>\r\n<h2>生产环境部署</h2>\r\n<p>Docker在生产环境中的使用注意事项...</p>', 'https://i.ibb.co/3mCJc34z/t044626d4ce5cc5e2aa-jpg.jpg', 'cat004', '1181928860648738816', 1, 0, 1, 1, 2015, 189, 56, '2025-11-09 15:30:00', 0, '2025-11-09 15:00:00', '1990981464736403456', '2025-11-17 09:45:00', 'Admin');
INSERT INTO `blog_article` VALUES ('art008', '读《代码整洁之道》有感', '阅读《Clean Code》后的思考与总结，分享如何写出更整洁、更易维护的代码。', '<h1>读《代码整洁之道》有感</h1>\r\n<h2>什么是整洁代码</h2>\r\n<p>整洁代码应该是优雅的、高效的、易读的...</p>\r\n<h2>命名的艺术</h2>\r\n<p>好的命名能够让代码自解释，减少注释的需要...</p>\r\n<h2>函数设计</h2>\r\n<ul>\r\n<li>单一职责原则</li>\r\n<li>参数数量控制</li>\r\n<li>避免副作用</li>\r\n</ul>\r\n<h2>实践建议</h2>\r\n<p>在日常开发中如何应用这些原则...</p>', 'https://i.ibb.co/3mCJc34z/t044626d4ce5cc5e2aa-jpg.jpg', 'cat003', '1181928860648738816', 1, 0, 0, 1, 723, 68, 19, '2025-11-11 10:15:00', 0, '2025-11-11 10:00:00', '1183363221872971776', '2025-11-26 11:27:41', 'Admin');
INSERT INTO `blog_article` VALUES ('art009', '周末爬山记：远离城市的喧嚣', '记录周末爬山的经历，分享大自然带来的宁静与思考。', '<h1>周末爬山记</h1>\r\n<h2>出发前的准备</h2>\r\n<p>早上六点起床，准备好装备和干粮，开始了这次爬山之旅...</p>\r\n<h2>登山过程</h2>\r\n<p>山路蜿蜒曲折，沿途风景秀丽，空气清新...</p>\r\n<h2>山顶的风景</h2>\r\n<p>终于登上山顶，眼前豁然开朗，远处的城市尽收眼底...</p>\r\n<h2>感悟</h2>\r\n<p>这次爬山让我明白，生活不仅仅是工作和代码，也需要偶尔停下来，享受大自然的美好...</p>', 'https://i.ibb.co/3mCJc34z/t044626d4ce5cc5e2aa-jpg.jpg', 'cat002', '1181928860648738816', 1, 0, 0, 1, 435, 42, 12, '2025-11-17 20:30:00', 0, '2025-11-17 20:00:00', '1181928860648738816', '2025-11-26 11:27:42', 'Admin');
INSERT INTO `blog_article` VALUES ('art010', 'Redis 缓存设计与实践', '深入探讨Redis在实际项目中的应用，包括缓存设计模式、数据结构选择、性能优化等。', '<h1>Redis 缓存设计与实践</h1>\r\n<h2>缓存设计模式</h2>\r\n<p>常见的缓存设计模式及其应用场景...</p>\r\n<ul>\r\n<li>Cache Aside Pattern</li>\r\n<li>Read Through</li>\r\n<li>Write Through</li>\r\n<li>Write Behind</li>\r\n</ul>\r\n<h2>Redis数据结构</h2>\r\n<p>不同数据结构的特点和使用场景...</p>\r\n<h2>缓存穿透与雪崩</h2>\r\n<p>如何解决缓存穿透、缓存击穿、缓存雪崩等问题...</p>\r\n<h2>实战案例</h2>\r\n<p>在电商项目中使用Redis的实际案例...</p>', 'https://i.ibb.co/3mCJc34z/t044626d4ce5cc5e2aa-jpg.jpg', 'cat001', '1181928860648738816', 1, 0, 1, 1, 1950, 176, 48, '2025-11-07 14:50:00', 0, '2025-11-07 14:30:00', 'Admin', '2025-11-19 16:20:00', 'Admin');
INSERT INTO `blog_article` VALUES ('art011', '提升效率的20个VS Code插件推荐', '精选20个实用的VS Code插件，帮助开发者提升开发效率，优化编码体验。', '<h1>提升效率的VS Code插件推荐</h1>\r\n<h2>代码编辑类</h2>\r\n<ul>\r\n<li>Prettier - 代码格式化</li>\r\n<li>ESLint - 代码检查</li>\r\n<li>IntelliCode - AI代码补全</li>\r\n</ul>\r\n<h2>Git工具类</h2>\r\n<ul>\r\n<li>GitLens - Git增强工具</li>\r\n<li>Git Graph - Git可视化</li>\r\n</ul>\r\n<h2>主题美化类</h2>\r\n<ul>\r\n<li>One Dark Pro - 护眼主题</li>\r\n<li>Material Icon Theme - 图标主题</li>\r\n</ul>\r\n<h2>其他实用插件</h2>\r\n<p>还有很多优秀的插件等待发现...</p>', 'https://i.ibb.co/3mCJc34z/t044626d4ce5cc5e2aa-jpg.jpg', 'cat005', '1181928860648738816', 1, 0, 1, 1, 1567, 134, 39, '2025-11-16 09:20:00', 0, '2025-11-16 09:00:00', '1990964509132460032', '2025-11-26 11:27:46', 'Admin');
INSERT INTO `blog_article` VALUES ('art012', '前端性能优化实战：从理论到实践', '全面讲解前端性能优化的各个方面，包括加载优化、渲染优化、代码优化等实战技巧。', '<h1>前端性能优化实战</h1>\r\n<h2>性能指标</h2>\r\n<p>了解FCP、LCP、FID、CLS等核心性能指标...</p>\r\n<h2>加载优化</h2>\r\n<ul>\r\n<li>资源压缩与合并</li>\r\n<li>图片懒加载</li>\r\n<li>代码分割</li>\r\n<li>CDN加速</li>\r\n</ul>\r\n<h2>渲染优化</h2>\r\n<p>优化浏览器渲染过程，提升页面流畅度...</p>\r\n<h2>代码优化</h2>\r\n<p>JavaScript和CSS的优化技巧...</p>\r\n<h2>实战案例</h2>\r\n<p>某电商网站的性能优化实战经验...</p>', 'https://i.ibb.co/3mCJc34z/t044626d4ce5cc5e2aa-jpg.jpg', 'cat004', '1995766248624885760', 1, 1, 1, 1, 2180, 198, 63, '2025-11-06 11:40:00', 0, '2025-11-06 11:20:00', 'Admin', '2025-12-02 18:00:04', 'Admin');

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
  `Status` int(4) NOT NULL DEFAULT 1 COMMENT '状态(0=禁用,1=启用)',
  `ArticleCount` int(11) NOT NULL DEFAULT 0 COMMENT '该分类下的文章数量',
  `IsDeleted` int(4) NOT NULL DEFAULT 0 COMMENT '是否删除(0=否,1=是)',
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
INSERT INTO `blog_category` VALUES ('cat001', '技术分享', '技术类文章，分享编程经验与技术心得', 'vertical-left', 1, 0, 200, 1, '2025-11-21 14:00:59', 'Admin', NULL, NULL);
INSERT INTO `blog_category` VALUES ('cat002', '生活随笔', '记录生活点滴，分享生活感悟', 'right-circle', 2, 0, 0, 0, '2025-11-21 14:00:59', 'Admin', NULL, NULL);
INSERT INTO `blog_category` VALUES ('cat003', '学习笔记', '学习过程中的笔记与总结', 'check-square', 3, 1, 0, 0, '2025-11-21 14:00:59', 'Admin', NULL, NULL);
INSERT INTO `blog_category` VALUES ('cat004', '项目实战', '实际项目开发经验分享', 'minus-circle', 4, 1, 0, 0, '2025-11-21 14:00:59', 'Admin', NULL, NULL);
INSERT INTO `blog_category` VALUES ('cat005', '工具推荐', '好用的开发工具与软件推荐', 'diff', 5, 1, 0, 0, '2025-11-21 14:00:59', 'Admin', NULL, NULL);

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
  `Status` int(4) NOT NULL DEFAULT 1 COMMENT '状态(0=已删除,1=正常,2=已屏蔽)',
  `IsDeleted` int(4) NOT NULL DEFAULT 0 COMMENT '是否删除(0=否,1=是)',
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
INSERT INTO `blog_comment` VALUES ('1995757183781834752', 'art001', '1995766458172313600', '<p>方法反反复复</p>', '', '1995766248624885760', 2, 1, 0, '2025-12-02 15:29:27', NULL);
INSERT INTO `blog_comment` VALUES ('1995758779370573824', 'art001', '1995766124326686720', '<p>粉色粉色发</p>', '1995757183781834752', '1995766458172313600', 3, 1, 0, '2025-12-02 15:35:47', NULL);
INSERT INTO `blog_comment` VALUES ('1996414647061712896', 'art001', '1995766124326686720', '<p>评论1</p>', '1995757183781834752', '1995766458172313600', 0, 1, 0, '2025-12-04 11:01:58', NULL);
INSERT INTO `blog_comment` VALUES ('1996414956769120256', 'art002', '1995766124326686720', '<p>父评论1</p>', NULL, '1995766124326686720', 0, 1, 0, '2025-12-04 11:03:12', NULL);
INSERT INTO `blog_comment` VALUES ('1996427810373111808', 'art002', '1995766248624885760', '<p>子评论1</p>', '1996414956769120256', '1995766378090467328', 0, 1, 0, '2025-12-04 11:54:16', NULL);
INSERT INTO `blog_comment` VALUES ('1996458433636732928', 'art001', '1995766378090467328', '<blockquote>fefga</blockquote>', '1995758779370573824', '1995766124326686720', 0, 1, 0, '2025-12-04 13:55:58', NULL);

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
INSERT INTO `blog_like` VALUES ('1995731349981368320', 'art006', '1995766124326686720', '2025-12-02 13:46:47');
INSERT INTO `blog_like` VALUES ('1995731777489997824', '1993518537196441600', '1995766248624885760', '2025-12-02 13:48:29');
INSERT INTO `blog_like` VALUES ('1995734717177008128', 'art002', '1995766248624885760', '2025-12-02 14:00:10');
INSERT INTO `blog_like` VALUES ('1995740081691824128', 'art005', '1995766378090467328', '2025-10-17 14:21:29');

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
  `IsDeleted` int(4) NOT NULL DEFAULT 0 COMMENT '是否删除(0=否,1=是)',
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
INSERT INTO `blog_tag` VALUES ('1996132944707588096', 'ss', '#9013FE', 0, 1, '2025-12-03 16:22:35', 'Admin', NULL, NULL);
INSERT INTO `blog_tag` VALUES ('1996136096194367488', 'ffs', '#8B572A', 2, 0, '2025-12-03 16:35:06', 'Admin', NULL, NULL);
INSERT INTO `blog_tag` VALUES ('tag001', 'Vue.js', '#E7DF20', 0, 1, '2025-11-21 14:01:05', 'Admin', NULL, NULL);
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
