/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50721
 Source Host           : localhost
 Source Database       : guns

 Target Server Type    : MySQL
 Target Server Version : 50721
 File Encoding         : utf-8

 Date: 12/19/2019 17:57:31 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `database_info`
-- ----------------------------
DROP TABLE IF EXISTS `database_info`;
CREATE TABLE `database_info` (
  `db_id` bigint(20) NOT NULL COMMENT '主键id',
  `db_name` varchar(255) NOT NULL COMMENT '数据库名称（英文名称）',
  `jdbc_driver` varchar(255) NOT NULL COMMENT 'jdbc的驱动类型',
  `user_name` varchar(255) NOT NULL COMMENT '数据库连接的账号',
  `password` varchar(255) NOT NULL COMMENT '数据库连接密码',
  `jdbc_url` varchar(2000) NOT NULL COMMENT 'jdbc的url',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注，摘要',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`db_id`) USING BTREE,
  UNIQUE KEY `NAME_UNIQUE` (`db_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='数据库信息表';

-- ----------------------------
--  Records of `database_info`
-- ----------------------------
BEGIN;
INSERT INTO `database_info` VALUES ('1207596691992494081', 'master', 'com.mysql.cj.jdbc.Driver', 'root', '', 'jdbc:mysql://127.0.0.1:3306/guns?autoReconnect=true&useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=CONVERT_TO_NULL&useSSL=false&serverTimezone=CTT', '主数据源，项目启动数据源！', '2019-12-19 17:41:02');
COMMIT;

-- ----------------------------
--  Table structure for `oauth_user_info`
-- ----------------------------
DROP TABLE IF EXISTS `oauth_user_info`;
CREATE TABLE `oauth_user_info` (
  `oauth_id` bigint(20) NOT NULL COMMENT '主键id',
  `user_id` bigint(20) NOT NULL COMMENT '用户主键id',
  `nick_name` varchar(255) DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(500) DEFAULT NULL COMMENT '头像',
  `blog` varchar(255) DEFAULT NULL COMMENT '用户网址',
  `company` varchar(255) DEFAULT NULL COMMENT '所在公司',
  `location` varchar(255) DEFAULT NULL COMMENT '位置',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `remark` varchar(255) DEFAULT NULL COMMENT '用户备注（各平台中的用户个人介绍）',
  `gender` int(11) DEFAULT NULL COMMENT '性别，1-男，0-女',
  `source` varchar(255) DEFAULT NULL COMMENT '用户来源',
  `token` varchar(255) DEFAULT NULL COMMENT '用户授权的token',
  `uuid` varchar(255) DEFAULT NULL COMMENT '第三方平台的用户唯一di',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新用户',
  PRIMARY KEY (`oauth_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='第三方用户信息表';

-- ----------------------------
--  Table structure for `sys_config`
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(200) NOT NULL COMMENT '名称',
  `code` varchar(200) NOT NULL COMMENT '属性编码标识',
  `dict_flag` char(1) NOT NULL COMMENT '是否是字典中的值',
  `dict_type_id` bigint(20) DEFAULT NULL COMMENT '字典类型的编码',
  `value` varchar(200) NOT NULL COMMENT '属性值，如果是字典中的类型，则为dict的code',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='参数配置';

-- ----------------------------
--  Records of `sys_config`
-- ----------------------------
BEGIN;
INSERT INTO `sys_config` VALUES ('1143324237579165697', '验证码开关', 'GUNS_KAPTCHA_OPEN', 'Y', '1106120265689055233', 'DISABLE', '是否开启验证码', '2019-06-24 12:46:43', '1', '2019-06-25 09:04:42', '1'), ('1143386834613694465', '阿里云短信的keyId', 'GUNS_SMS_ACCESSKEY_ID', 'N', null, 'xxxkey', '阿里云短信的密钥key', '2019-06-25 13:13:59', '1', '2019-06-25 13:19:21', '1'), ('1143386953933254657', '阿里云短信的secret', 'GUNS_SMS_ACCESSKEY_SECRET', 'N', null, 'xxxsecret', '阿里云短信的secret', '2019-06-25 13:14:28', '1', null, null), ('1143387023449649154', '阿里云短信的签名', 'GUNS_SMS_SIGN_NAME', 'N', null, 'xxxsign', '阿里云短信的签名', '2019-06-25 13:14:44', '1', null, null), ('1143387131109044225', '阿里云短信登录的模板号', 'GUNS_SMS_LOGIN_TEMPLATE_CODE', 'N', null, 'SMS_XXXXXX', '阿里云短信登录的模板号', '2019-06-25 13:15:10', '1', null, null), ('1143387225019510785', '验证码短信失效时间', 'GUNS_SMS_INVALIDATE_MINUTES', 'N', null, '2', '验证码短信失效时间', '2019-06-25 13:15:32', '1', null, null), ('1143468689664876546', '管理系统名称', 'GUNS_SYSTEM_NAME', 'N', null, 'PERF管理平台', '管理系统名称', '2019-06-25 18:39:15', '1', null, null), ('1143468867767607297', '默认系统密码', 'GUNS_DEFAULT_PASSWORD', 'N', null, '111111', '默认系统密码', '2019-06-25 18:39:57', '1', null, null), ('1143469008025133058', 'OAuth2登录用户的账号标识', 'GUNS_OAUTH2_PREFIX', 'N', null, 'oauth2', 'OAuth2登录用户的账号标识', '2019-06-25 18:40:31', '1', null, null), ('1145207130463191041', '顶部导航条是否开启', 'GUNS_DEFAULT_ADVERT', 'Y', '1106120265689055233', 'ENABLE', '顶部Guns广告是否开启', '2019-06-30 13:47:11', '1', '2019-06-30 13:47:20', '1'), ('1145915627211370498', 'Guns发布的编号', 'GUNS_SYSTEM_RELEASE_VERSION', 'N', null, '20191029', '用于防止浏览器缓存相关的js和css', '2019-07-02 12:42:30', '1', null, null), ('1145915627211370499', '文件上传路径', 'GUNS_FILE_UPLOAD_PATH', 'N', null, '/Users/stylefeng/tmp/gunsTempFiles/', '文件上传默认目录', '2019-08-30 09:10:40', '1', null, null), ('1145915627211370500', 'BPMN文件上传路径', 'GUNS_BPMN_FILE_UPLOAD_PATH', 'N', null, '/Users/stylefeng/tmp/gunsTempFiles/', '工作流文件上传默认目录', '2019-08-30 09:10:40', '1', null, null), ('1145915627211370501', '获取系统地密钥过期时间', 'GUNS_JWT_SECRET_EXPIRE', 'N', null, '86400', '获取系统地密钥过期时间（单位：秒），默认1天', '2019-10-16 23:02:39', '1', null, null), ('1145915627211370502', '获取token的header标识', 'GUNS_TOKEN_HEADER_NAME', 'N', null, 'Authorization', '获取token的header标识', '2019-10-16 23:02:39', '1', null, null), ('1145915627211370503', '获取租户是否开启的标识', 'GUNS_TENANT_OPEN', 'Y', '1106120265689055233', 'DISABLE', '获取租户是否开启的标识，默认是关的', '2019-10-16 23:02:39', '1', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `sys_dept`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL COMMENT '主键id',
  `pid` bigint(20) DEFAULT '0' COMMENT '父部门id',
  `pids` varchar(512) DEFAULT '' COMMENT '父级ids',
  `simple_name` varchar(45) DEFAULT NULL COMMENT '简称',
  `full_name` varchar(255) DEFAULT NULL COMMENT '全称',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `version` int(11) DEFAULT NULL COMMENT '版本（乐观锁保留字段）',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建人',
  `update_user` bigint(20) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='部门表';

-- ----------------------------
--  Records of `sys_dept`
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` VALUES ('24', '0', '[0],', '总公司', '总公司', '', null, '1', null, null, null, null), ('25', '24', '[0],[24],', '开发部', '开发部', '', null, '2', null, null, null, null), ('26', '24', '[0],[24],', '运营部', '运营部', '', null, '3', null, null, null, null), ('27', '24', '[0],[24],', '战略部', '战略部', '', null, '4', null, null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `sys_dict`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `dict_id` bigint(20) NOT NULL COMMENT '字典id',
  `dict_type_id` bigint(20) NOT NULL COMMENT '所属字典类型的id',
  `code` varchar(50) NOT NULL COMMENT '字典编码',
  `name` varchar(255) NOT NULL COMMENT '字典名称',
  `parent_id` bigint(20) NOT NULL COMMENT '上级代码id',
  `parent_ids` varchar(255) DEFAULT NULL COMMENT '所有上级id',
  `status` varchar(10) NOT NULL DEFAULT 'ENABLE' COMMENT '状态（字典）',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `description` varchar(1000) DEFAULT NULL COMMENT '字典的描述',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建人',
  `update_user` bigint(20) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`dict_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='基础字典';

-- ----------------------------
--  Records of `sys_dict`
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict` VALUES ('1106120532442595330', '1106120208097067009', 'M', '男', '0', '[0]', 'ENABLE', null, '', '2019-03-14 17:11:00', null, '1', null), ('1106120574163337218', '1106120208097067009', 'F', '女', '0', '[0]', 'ENABLE', null, '', '2019-03-14 17:11:10', null, '1', null), ('1106120645697191938', '1106120265689055233', 'ENABLE', '启用', '0', '[0]', 'ENABLE', null, '', '2019-03-14 17:11:27', null, '1', null), ('1106120699468169217', '1106120265689055233', 'DISABLE', '禁用', '0', '[0]', 'ENABLE', null, '', '2019-03-14 17:11:40', null, '1', null), ('1106120784318939137', '1106120322450571266', 'ENABLE', '启用', '0', '[0]', 'ENABLE', null, '', '2019-03-14 17:12:00', null, '1', null), ('1106120825993543682', '1106120322450571266', 'FREEZE', '冻结', '0', '[0]', 'ENABLE', '1', '', '2019-03-14 17:12:10', '2019-03-16 10:56:36', '1', '1'), ('1106120875872206849', '1106120322450571266', 'DELETED', '已删除', '0', '[0]', 'ENABLE', '-1221', '', '2019-03-14 17:12:22', '2019-03-16 10:56:53', '1', '1'), ('1106120935070613505', '1106120388036902914', 'Y', '删除', '0', '[0]', 'ENABLE', '23333', '', '2019-03-14 17:12:36', '2019-03-16 10:58:53', '1', '1'), ('1106120968910258177', '1106120388036902914', 'N', '未删除', '0', '[0]', 'ENABLE', '1212211221', '', '2019-03-14 17:12:44', '2019-03-16 10:59:03', '1', '1'), ('1149218674746355713', '1149217131989069826', 'BASE_SYSTEM', '系统管理', '0', '[0]', 'ENABLE', '1', '系统管理平台', '2019-07-11 15:27:38', '2019-07-11 20:27:14', '1', '1'), ('1160533174626959361', '1160532704105742337', '00101', '办公审批', '0', '[0]', 'ENABLE', '10', '', '2019-08-11 20:47:25', null, '1', null), ('1160533264645111810', '1160532704105742337', '00102', '行政审批', '0', '[0]', 'ENABLE', '20', '', '2019-08-11 20:47:47', null, '1', null), ('1160533377727741954', '1160532775455047681', 'KEY_LEAVE', '请假流程标识', '0', '[0]', 'ENABLE', '10', '', '2019-08-11 20:48:14', null, '1', null), ('1160533455343337474', '1160532775455047681', 'KEY_FINANCE', '财务流程标识', '0', '[0]', 'ENABLE', '20', '', '2019-08-11 20:48:32', null, '1', null), ('1160533574843252737', '1160532886713155585', '00401', '事假', '0', '[0]', 'ENABLE', '10', '', '2019-08-11 20:49:01', null, '1', null), ('1160533625615302658', '1160532886713155585', '00402', '婚假', '0', '[0]', 'ENABLE', '20', '', '2019-08-11 20:49:13', null, '1', null), ('1160533707215486977', '1160532886713155585', '00403', '产假', '0', '[0]', 'ENABLE', '30', '', '2019-08-11 20:49:32', null, '1', null), ('1160533765403066370', '1160532886713155585', '00404', '病假', '0', '[0]', 'ENABLE', '40', '', '2019-08-11 20:49:46', null, '1', null), ('1160533863834992641', '1160532886713155585', '00405', '公假', '0', '[0]', 'ENABLE', '50', '', '2019-08-11 20:50:09', null, '1', null), ('1160533945309347841', '1160532886713155585', '00406', '年假', '0', '[0]', 'ENABLE', '60', '', '2019-08-11 20:50:29', null, '1', null), ('1160534007389241346', '1160532886713155585', '00407', '其他', '0', '[0]', 'ENABLE', '70', '', '2019-08-11 20:50:44', null, '1', null);
COMMIT;

-- ----------------------------
--  Table structure for `sys_dict_type`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `dict_type_id` bigint(20) NOT NULL COMMENT '字典类型id',
  `code` varchar(255) NOT NULL COMMENT '字典类型编码',
  `name` varchar(255) NOT NULL COMMENT '字典类型名称',
  `description` varchar(1000) DEFAULT NULL COMMENT '字典描述',
  `system_flag` char(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '是否是系统字典，Y-是，N-否',
  `status` varchar(10) NOT NULL DEFAULT 'ENABLE' COMMENT '状态(字典)',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_time` datetime DEFAULT NULL COMMENT '添加时间',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`dict_type_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='字典类型表';

-- ----------------------------
--  Records of `sys_dict_type`
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_type` VALUES ('1106120208097067009', 'SEX', '性别', '', 'Y', 'ENABLE', '4', '2019-03-14 17:09:43', '1', null, null), ('1106120265689055233', 'STATUS', '状态', '', 'Y', 'ENABLE', '3', '2019-03-14 17:09:57', '1', null, null), ('1106120322450571266', 'ACCOUNT_STATUS', '账号状态', '', 'Y', 'ENABLE', '40', '2019-03-14 17:10:10', '1', '2019-08-11 20:46:38', '1'), ('1106120388036902914', 'DEL_FLAG', '是否删除', '', 'Y', 'ENABLE', '2', '2019-03-14 17:10:26', '1', '2019-03-27 16:26:31', '1'), ('1149217131989069826', 'SYSTEM_TYPE', '系统分类', '系统所有分类的维护', 'Y', 'ENABLE', '50', '2019-07-11 15:21:30', '1', '2019-08-11 20:46:47', '1'), ('1160532704105742337', 'FLOW_CATEGARY', '工作流分类', '工作流分类', 'Y', 'ENABLE', '60', '2019-08-11 20:45:33', '1', null, null), ('1160532775455047681', 'FLOW_KEY', '工作流标识', '工作流标识', 'Y', 'ENABLE', '70', '2019-08-11 20:45:50', '1', null, null), ('1160532886713155585', 'LEAVE_TYPE', '请假类型', '请假类型', 'Y', 'ENABLE', '80', '2019-08-11 20:46:17', '1', '2019-08-11 20:46:23', '1');
COMMIT;

-- ----------------------------
--  Table structure for `sys_file_info`
-- ----------------------------
DROP TABLE IF EXISTS `sys_file_info`;
CREATE TABLE `sys_file_info` (
  `file_id` varchar(50) NOT NULL COMMENT '主键id',
  `file_bucket` varchar(100) DEFAULT NULL COMMENT '文件仓库（oss仓库）',
  `file_name` varchar(100) NOT NULL COMMENT '文件名称',
  `file_suffix` varchar(50) DEFAULT NULL COMMENT '文件后缀',
  `file_size_kb` bigint(20) DEFAULT NULL COMMENT '文件大小kb',
  `final_name` varchar(100) NOT NULL COMMENT '文件唯一标识id',
  `file_path` varchar(1000) DEFAULT NULL COMMENT '存储路径',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建用户',
  `update_user` bigint(20) DEFAULT NULL COMMENT '修改用户',
  PRIMARY KEY (`file_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文件信息表';

-- ----------------------------
--  Records of `sys_file_info`
-- ----------------------------
BEGIN;
INSERT INTO `sys_file_info` VALUES ('1167385745179131905', null, '请假流程.bpmn20.xml', 'xml', '6', '1167385745179131905.xml', '/Users/stylefeng/tmp/gunsTempFiles/1167385745179131905.xml', '2019-08-30 18:37:05', null, '1', null);
COMMIT;

-- ----------------------------
--  Table structure for `sys_login_log`
-- ----------------------------
DROP TABLE IF EXISTS `sys_login_log`;
CREATE TABLE `sys_login_log` (
  `login_log_id` bigint(20) NOT NULL COMMENT '主键',
  `log_name` varchar(255) DEFAULT NULL COMMENT '日志名称',
  `user_id` bigint(20) DEFAULT NULL COMMENT '管理员id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `succeed` varchar(255) DEFAULT NULL COMMENT '是否执行成功',
  `message` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '具体消息',
  `ip_address` varchar(255) DEFAULT NULL COMMENT '登录ip',
  PRIMARY KEY (`login_log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='登录记录';

-- ----------------------------
--  Records of `sys_login_log`
-- ----------------------------
BEGIN;
INSERT INTO `sys_login_log` VALUES ('1207567903690723329', '登录日志', '1', '2019-12-19 15:46:38', '成功', null, '0:0:0:0:0:0:0:1'), ('1207570981181587458', '登录日志', '1', '2019-12-19 15:58:52', '成功', null, '0:0:0:0:0:0:0:1'), ('1207572034614628353', '登录日志', '1', '2019-12-19 16:03:03', '成功', null, '0:0:0:0:0:0:0:1'), ('1207572640494424065', '退出日志', '1', '2019-12-19 16:05:28', '成功', null, '0:0:0:0:0:0:0:1'), ('1207573002949382146', '登录日志', '1', '2019-12-19 16:06:54', '成功', null, '0:0:0:0:0:0:0:1'), ('1207576685288247298', '登录日志', '1', '2019-12-19 16:21:32', '成功', null, '0:0:0:0:0:0:0:1'), ('1207581250481958914', '登录日志', '1', '2019-12-19 16:39:41', '成功', null, '0:0:0:0:0:0:0:1'), ('1207585435902423042', '登录日志', '1', '2019-12-19 16:56:18', '成功', null, '0:0:0:0:0:0:0:1'), ('1207585907174453250', '登录日志', '1', '2019-12-19 16:58:11', '成功', null, '0:0:0:0:0:0:0:1'), ('1207587572573163522', '登录日志', '1', '2019-12-19 17:04:48', '成功', null, '0:0:0:0:0:0:0:1'), ('1207589531308929025', '登录日志', '1', '2019-12-19 17:12:35', '成功', null, '0:0:0:0:0:0:0:1'), ('1207591643904352258', '登录日志', '1', '2019-12-19 17:20:59', '成功', null, '0:0:0:0:0:0:0:1'), ('1207593244241051649', '登录日志', '1', '2019-12-19 17:27:20', '成功', null, '0:0:0:0:0:0:0:1'), ('1207595636730793985', '登录日志', '1', '2019-12-19 17:36:50', '成功', null, '0:0:0:0:0:0:0:1'), ('1207595637624180737', '登录日志', '1', '2019-12-19 17:36:51', '成功', null, '0:0:0:0:0:0:0:1'), ('1207596750544977921', '登录日志', '1', '2019-12-19 17:41:16', '成功', null, '0:0:0:0:0:0:0:1'), ('1207596751610331138', '登录日志', '1', '2019-12-19 17:41:16', '成功', null, '0:0:0:0:0:0:0:1');
COMMIT;

-- ----------------------------
--  Table structure for `sys_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL COMMENT '主键id',
  `code` varchar(255) DEFAULT NULL COMMENT '菜单编号',
  `pcode` varchar(255) DEFAULT NULL COMMENT '菜单父编号',
  `pcodes` varchar(255) DEFAULT NULL COMMENT '当前菜单的所有父菜单编号',
  `name` varchar(255) DEFAULT NULL COMMENT '菜单名称',
  `icon` varchar(255) DEFAULT NULL COMMENT '菜单图标',
  `url` varchar(255) DEFAULT NULL COMMENT 'url地址',
  `sort` int(65) DEFAULT NULL COMMENT '菜单排序号',
  `levels` int(65) DEFAULT NULL COMMENT '菜单层级',
  `menu_flag` varchar(32) DEFAULT NULL COMMENT '是否是菜单(字典)',
  `description` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` varchar(32) DEFAULT 'ENABLE' COMMENT '菜单状态(字典)',
  `new_page_flag` varchar(32) DEFAULT NULL COMMENT '是否打开新页面的标识(字典)',
  `open_flag` varchar(32) DEFAULT NULL COMMENT '是否打开(字典)',
  `system_type` varchar(100) DEFAULT NULL COMMENT '系统分类(字典)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建人',
  `update_user` bigint(20) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='菜单表';

-- ----------------------------
--  Records of `sys_menu`
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` VALUES ('105', 'system', '0', '[0],', '系统管理', 'layui-icon layui-icon-set', '#', '20', '1', 'Y', null, 'ENABLE', null, '1', 'BASE_SYSTEM', null, '2019-03-29 16:32:27', null, '1'), ('106', 'mgr', 'system', '[0],[system],', '用户管理', '', '/mgr', '10', '2', 'Y', null, 'ENABLE', null, '0', 'BASE_SYSTEM', null, '2019-06-30 13:48:07', null, '1'), ('107', 'mgr_add', 'mgr', '[0],[system],[mgr],', '添加用户', null, '/mgr/add', '1', '3', 'N', null, 'ENABLE', null, '0', 'BASE_SYSTEM', null, '2019-06-30 13:48:07', null, '1'), ('108', 'mgr_edit', 'mgr', '[0],[system],[mgr],', '修改用户', null, '/mgr/edit', '2', '3', 'N', null, 'ENABLE', null, '0', 'BASE_SYSTEM', null, '2019-06-30 13:48:07', null, '1'), ('109', 'mgr_delete', 'mgr', '[0],[system],[mgr],', '删除用户', null, '/mgr/delete', '3', '3', 'N', null, 'ENABLE', null, '0', 'BASE_SYSTEM', null, '2019-06-30 13:48:07', null, '1'), ('110', 'mgr_reset', 'mgr', '[0],[system],[mgr],', '重置密码', null, '/mgr/reset', '4', '3', 'N', null, 'ENABLE', null, '0', 'BASE_SYSTEM', null, '2019-06-30 13:48:07', null, '1'), ('111', 'mgr_freeze', 'mgr', '[0],[system],[mgr],', '冻结用户', null, '/mgr/freeze', '5', '3', 'N', null, 'ENABLE', null, '0', 'BASE_SYSTEM', null, '2019-06-30 13:48:07', null, '1'), ('112', 'mgr_unfreeze', 'mgr', '[0],[system],[mgr],', '解除冻结用户', null, '/mgr/unfreeze', '6', '3', 'N', null, 'ENABLE', null, '0', 'BASE_SYSTEM', null, '2019-06-30 13:48:07', null, '1'), ('113', 'mgr_setRole', 'mgr', '[0],[system],[mgr],', '分配角色', null, '/mgr/setRole', '7', '3', 'N', null, 'ENABLE', null, '0', 'BASE_SYSTEM', null, '2019-06-30 13:48:07', null, '1'), ('114', 'role', 'system', '[0],[system],', '角色管理', '', '/role', '20', '2', 'Y', null, 'ENABLE', null, '0', 'BASE_SYSTEM', null, '2019-06-30 13:48:12', null, '1'), ('115', 'role_add', 'role', '[0],[system],[role],', '添加角色', null, '/role/add', '1', '3', 'N', null, 'ENABLE', null, '0', 'BASE_SYSTEM', null, '2019-06-30 13:48:12', null, '1'), ('116', 'role_edit', 'role', '[0],[system],[role],', '修改角色', null, '/role/edit', '2', '3', 'N', null, 'ENABLE', null, '0', 'BASE_SYSTEM', null, '2019-06-30 13:48:12', null, '1'), ('117', 'role_remove', 'role', '[0],[system],[role],', '删除角色', null, '/role/remove', '3', '3', 'N', null, 'ENABLE', null, '0', 'BASE_SYSTEM', null, '2019-06-30 13:48:12', null, '1'), ('118', 'role_setAuthority', 'role', '[0],[system],[role],', '配置权限', null, '/role/setAuthority', '4', '3', 'N', null, 'ENABLE', null, '0', 'BASE_SYSTEM', null, '2019-06-30 13:48:12', null, '1'), ('119', 'menu', 'system', '[0],[system],', '菜单管理', '', '/menu', '50', '2', 'Y', null, 'ENABLE', null, '0', 'BASE_SYSTEM', null, '2019-06-30 13:48:25', null, '1'), ('120', 'menu_add', 'menu', '[0],[system],[menu],', '添加菜单', null, '/menu/add', '1', '3', 'N', null, 'ENABLE', null, '0', 'BASE_SYSTEM', null, '2019-06-30 13:48:25', null, '1'), ('121', 'menu_edit', 'menu', '[0],[system],[menu],', '修改菜单', null, '/menu/edit', '2', '3', 'N', null, 'ENABLE', null, '0', 'BASE_SYSTEM', null, '2019-06-30 13:48:25', null, '1'), ('122', 'menu_remove', 'menu', '[0],[system],[menu],', '删除菜单', null, '/menu/remove', '3', '3', 'N', null, 'ENABLE', null, '0', 'BASE_SYSTEM', null, '2019-06-30 13:48:25', null, '1'), ('128', 'log', 'system', '[0],[system],', '业务日志', '', '/log', '70', '2', 'Y', null, 'ENABLE', null, '0', 'BASE_SYSTEM', null, '2019-06-30 13:48:39', null, '1'), ('130', 'druid', 'system', '[0],[system],', '监控管理', '', '/druid', '80', '2', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:50:06', null, '1'), ('131', 'dept', 'system', '[0],[system],', '部门管理', '', '/dept', '30', '2', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:48:53', null, '1'), ('132', 'dict', 'system', '[0],[system],', '字典管理', '', '/dictType', '40', '2', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:49:04', null, '1'), ('133', 'loginLog', 'system', '[0],[system],', '登录日志', '', '/loginLog', '60', '2', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:49:29', null, '1'), ('134', 'log_clean', 'log', '[0],[system],[log],', '清空日志', null, '/log/delLog', '3', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:48:39', null, '1'), ('135', 'dept_add', 'dept', '[0],[system],[dept],', '添加部门', null, '/dept/add', '1', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:48:53', null, '1'), ('136', 'dept_update', 'dept', '[0],[system],[dept],', '修改部门', null, '/dept/update', '1', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:48:53', null, '1'), ('137', 'dept_delete', 'dept', '[0],[system],[dept],', '删除部门', null, '/dept/delete', '1', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:48:53', null, '1'), ('138', 'dict_add', 'dict', '[0],[system],[dict],', '添加字典', null, '/dictType/addItem', '1', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:49:04', null, '1'), ('139', 'dict_update', 'dict', '[0],[system],[dict],', '修改字典', null, '/dictType/editItem', '1', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:49:04', null, '1'), ('140', 'dict_delete', 'dict', '[0],[system],[dict],', '删除字典', null, '/dictType/delete', '1', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:49:04', null, '1'), ('141', 'notice', 'system', '[0],[system],', '通知管理', '', '/notice', '90', '2', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:49:44', null, '1'), ('142', 'notice_add', 'notice', '[0],[system],[notice],', '添加通知', null, '/notice/add', '1', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:49:44', null, '1'), ('143', 'notice_update', 'notice', '[0],[system],[notice],', '修改通知', null, '/notice/update', '2', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:49:44', null, '1'), ('144', 'notice_delete', 'notice', '[0],[system],[notice],', '删除通知', null, '/notice/delete', '3', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:49:44', null, '1'), ('145', 'sys_message', 'dashboard', '[0],[dashboard],', '消息通知', 'layui-icon layui-icon-tips', '/system/notice', '30', '2', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-04-08 22:49:39', null, '1'), ('149', 'api_mgr', 'dev_tools', '[0],[dev_tools],', '接口文档', 'fa-leaf', '/swagger-ui.html', '30', '2', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-15 18:13:00', null, '1'), ('150', 'to_menu_edit', 'menu', '[0],[system],[menu],', '菜单编辑跳转', '', '/menu/menu_edit', '4', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:48:25', null, '1'), ('151', 'menu_list', 'menu', '[0],[system],[menu],', '菜单列表', '', '/menu/list', '5', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:48:25', null, '1'), ('152', 'to_dept_update', 'dept', '[0],[system],[dept],', '修改部门跳转', '', '/dept/dept_update', '4', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:48:53', null, '1'), ('153', 'dept_list', 'dept', '[0],[system],[dept],', '部门列表', '', '/dept/list', '5', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:48:53', null, '1'), ('154', 'dept_detail', 'dept', '[0],[system],[dept],', '部门详情', '', '/dept/detail', '6', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:48:53', null, '1'), ('155', 'to_dict_edit', 'dict', '[0],[system],[dict],', '修改菜单跳转', '', '/dict/dict_edit', '4', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:49:04', null, '1'), ('156', 'dict_list', 'dict', '[0],[system],[dict],', '字典列表', '', '/dict/list', '5', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:49:04', null, '1'), ('157', 'dict_detail', 'dict', '[0],[system],[dict],', '字典详情', '', '/dict/detail', '6', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:49:04', null, '1'), ('158', 'log_list', 'log', '[0],[system],[log],', '日志列表', '', '/log/list', '2', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:48:39', null, '1'), ('159', 'log_detail', 'log', '[0],[system],[log],', '日志详情', '', '/log/detail', '3', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:48:39', null, '1'), ('160', 'del_login_log', 'loginLog', '[0],[system],[loginLog],', '清空登录日志', '', '/loginLog/delLoginLog', '1', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:49:29', null, '1'), ('161', 'login_log_list', 'loginLog', '[0],[system],[loginLog],', '登录日志列表', '', '/loginLog/list', '2', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:49:29', null, '1'), ('162', 'to_role_edit', 'role', '[0],[system],[role],', '修改角色跳转', '', '/role/role_edit', '5', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:48:12', null, '1'), ('163', 'to_role_assign', 'role', '[0],[system],[role],', '角色分配跳转', '', '/role/role_assign', '6', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:48:12', null, '1'), ('164', 'role_list', 'role', '[0],[system],[role],', '角色列表', '', '/role/list', '7', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:48:12', null, '1'), ('165', 'to_assign_role', 'mgr', '[0],[system],[mgr],', '分配角色跳转', '', '/mgr/role_assign', '8', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:48:07', null, '1'), ('166', 'to_user_edit', 'mgr', '[0],[system],[mgr],', '编辑用户跳转', '', '/mgr/user_edit', '9', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:48:07', null, '1'), ('167', 'mgr_list', 'mgr', '[0],[system],[mgr],', '用户列表', '', '/mgr/list', '10', '3', 'N', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-06-30 13:48:07', null, '1'), ('171', 'dev_tools', '0', '[0],', '开发管理', 'layui-icon layui-icon-code-circle', '#', '30', '1', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-05-11 13:40:27', null, '1'), ('172', 'dashboard', '0', '[0],', '主控面板', 'layui-icon layui-icon-home', '#', '10', '1', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', null, '2019-04-08 22:48:15', null, '1'), ('1110777136265838594', 'demos_show', 'dev_tools', '[0],[dev_tools],', '模板页面', 'layui-icon layui-icon-template', '#', '40', '2', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', '2019-03-27 13:34:41', '2019-06-15 18:13:11', '1', '1'), ('1110777366856089602', 'excel_import', 'demos_show', '[0],[dev_tools],[demos_show],', 'excel导入', '', '/excel/import', '10', '3', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', '2019-03-27 13:35:36', '2019-06-15 18:13:11', '1', '1'), ('1110777491464667137', 'excel_export', 'demos_show', '[0],[dev_tools],[demos_show],', 'excel导出', '', '/excel/export', '20', '3', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', '2019-03-27 13:36:06', '2019-06-15 18:13:11', '1', '1'), ('1110787391943098370', 'advanced_form', 'demos_show', '[0],[dev_tools],[demos_show],', '高级表单', '', '/egForm', '30', '3', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', '2019-03-27 14:15:26', '2019-06-15 18:13:11', '1', '1'), ('1110839216310329346', 'pdf_view', 'demos_show', '[0],[dev_tools],[demos_show],', '文档预览', '', '/loadPdfFile', '40', '3', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', '2019-03-27 17:41:22', '2019-06-15 18:13:11', '1', '1'), ('1111545968697860098', 'console', 'dashboard', '[0],[dashboard],', '项目介绍', '', '/system/console', '10', '2', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', '2019-03-29 16:29:45', '2019-04-09 20:57:08', '1', '1'), ('1111546189892870145', 'console2', 'dashboard', '[0],[dashboard],', '统计报表', '', '/system/console2', '20', '2', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', '2019-03-29 16:30:38', '2019-04-08 22:49:48', '1', '1'), ('1127085735660421122', 'code_generate', 'dev_tools', '[0],[dev_tools],', '代码生成', '', '/gen', '20', '2', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', '2019-05-11 13:39:14', '2019-06-15 18:12:45', '1', '1'), ('1139826657964593154', 'meta_data', 'dev_tools', '[0],[dev_tools],', '系统配置', '', '#', '10', '2', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', '2019-06-15 17:27:07', '2019-06-15 18:12:35', '1', '1'), ('1139827152854716418', 'data_source', 'meta_data', '[0],[dev_tools],[meta_data],', '数据源管理', '', '/databaseInfo', '10', '3', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', '2019-06-15 17:29:05', '2019-06-15 18:12:35', '1', '1'), ('1142957882422112257', 'SYS_CONFIG', 'meta_data', '[0],[dev_tools],[meta_data],', '参数配置', 'fa-star', '/sysConfig', '5', '3', 'Y', '', 'ENABLE', '', '', 'BASE_SYSTEM', '2019-06-24 08:49:28', '2019-06-24 08:57:34', '1', '1'), ('1142957882422112258', 'SYS_CONFIG_ADD', 'SYS_CONFIG', '[0],[dev_tools],[meta_data],[SYS_CONFIG],', '参数配置添加', 'fa-star', '', '999', '4', 'N', '', 'ENABLE', '', '', 'BASE_SYSTEM', '2019-06-24 08:49:28', '2019-06-24 08:57:34', '1', '1'), ('1142957882422112259', 'SYS_CONFIG_EDIT', 'SYS_CONFIG', '[0],[dev_tools],[meta_data],[SYS_CONFIG],', '参数配置修改', 'fa-star', '', '999', '4', 'N', '', 'ENABLE', '', '', 'BASE_SYSTEM', '2019-06-24 08:49:28', '2019-06-24 08:57:34', '1', '1'), ('1142957882426306562', 'SYS_CONFIG_DELETE', 'SYS_CONFIG', '[0],[dev_tools],[meta_data],[SYS_CONFIG],', '参数配置删除', 'fa-star', '', '999', '4', 'N', '', 'ENABLE', '', '', 'BASE_SYSTEM', '2019-06-24 08:49:28', '2019-06-24 08:57:34', '1', '1'), ('1144441072852684801', 'SYS_POSITION', 'system', '[0],[system],', '职位管理', 'fa-star', '/position', '35', '2', 'Y', '', 'ENABLE', '', '', 'BASE_SYSTEM', '2019-06-28 11:03:09', '2019-06-28 11:06:42', '1', '1'), ('1144441072852684802', 'SYS_POSITION_ADD', 'SYS_POSITION', '[0],[system],[SYS_POSITION],', '职位表添加', 'fa-star', '', '999', '3', 'N', '', 'ENABLE', '', '', 'BASE_SYSTEM', '2019-06-28 11:03:09', '2019-06-28 11:06:42', '1', '1'), ('1144441072852684803', 'SYS_POSITION_EDIT', 'SYS_POSITION', '[0],[system],[SYS_POSITION],', '职位表修改', 'fa-star', '', '999', '3', 'N', '', 'ENABLE', '', '', 'BASE_SYSTEM', '2019-06-28 11:03:09', '2019-06-28 11:06:42', '1', '1'), ('1144441072852684804', 'SYS_POSITION_DELETE', 'SYS_POSITION', '[0],[system],[SYS_POSITION],', '职位表删除', 'fa-star', '', '999', '3', 'N', '', 'ENABLE', '', '', 'BASE_SYSTEM', '2019-06-28 11:03:09', '2019-06-28 11:06:42', '1', '1'), ('1149955324929765378', 'system_info', 'dashboard', '[0],[dashboard],', '系统监控', 'layui-icon-star-fill', '/system/systemInfo', '40', '2', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', '2019-07-13 16:14:49', null, '1', null), ('1207590224476385281', 'P_ALL', '0', '[0],', '业务管理', 'layui-icon-template-1', '#', '500', '1', 'Y', null, 'ENABLE', null, null, 'BASE_SYSTEM', '2019-12-19 17:15:20', '2019-12-19 17:15:36', '1', '1'), ('1207594906754105346', 'PROJECT', 'P_ALL', '[0],[P_ALL],', '项目管理', 'fa-star', '/project', '999', '2', 'Y', '', 'ENABLE', '', '', 'BASE_SYSTEM', '2019-12-19 17:33:56', '2019-12-19 17:38:52', '1', '1'), ('1207594906754105347', 'PROJECT_ADD', 'PROJECT', '[0],[P_ALL],[PROJECT],', '空表名添加', 'fa-star', '', '999', '3', 'N', '', 'ENABLE', '', '', 'BASE_SYSTEM', '2019-12-19 17:33:56', '2019-12-19 17:38:52', '1', '1'), ('1207594906754105348', 'PROJECT_EDIT', 'PROJECT', '[0],[P_ALL],[PROJECT],', '空表名修改', 'fa-star', '', '999', '3', 'N', '', 'ENABLE', '', '', 'BASE_SYSTEM', '2019-12-19 17:33:56', '2019-12-19 17:38:52', '1', '1'), ('1207594906754105349', 'PROJECT_DELETE', 'PROJECT', '[0],[P_ALL],[PROJECT],', '空表名删除', 'fa-star', '', '999', '3', 'N', '', 'ENABLE', '', '', 'BASE_SYSTEM', '2019-12-19 17:33:56', '2019-12-19 17:38:52', '1', '1');
COMMIT;

-- ----------------------------
--  Table structure for `sys_notice`
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
  `notice_id` bigint(20) NOT NULL COMMENT '主键',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '内容',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='通知表';

-- ----------------------------
--  Records of `sys_notice`
-- ----------------------------
BEGIN;
INSERT INTO `sys_notice` VALUES ('8', 'perf-manager', '<p>hello all!</p>', '2017-05-10 19:28:57', '1', '2019-12-19 15:49:32', '1');
COMMIT;

-- ----------------------------
--  Table structure for `sys_operation_log`
-- ----------------------------
DROP TABLE IF EXISTS `sys_operation_log`;
CREATE TABLE `sys_operation_log` (
  `operation_log_id` bigint(20) NOT NULL COMMENT '主键',
  `log_type` varchar(32) DEFAULT NULL COMMENT '日志类型(字典)',
  `log_name` varchar(255) DEFAULT NULL COMMENT '日志名称',
  `user_id` bigint(65) DEFAULT NULL COMMENT '用户id',
  `class_name` varchar(255) DEFAULT NULL COMMENT '类名称',
  `method` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '方法名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `succeed` varchar(32) DEFAULT NULL COMMENT '是否成功(字典)',
  `message` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '备注',
  PRIMARY KEY (`operation_log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='操作日志';

-- ----------------------------
--  Records of `sys_operation_log`
-- ----------------------------
BEGIN;
INSERT INTO `sys_operation_log` VALUES ('1189120665279750145', '业务日志', '清空业务日志', '1', 'cn.stylefeng.guns.sys.modular.system.controller.LogController', 'delLog', '2019-10-29 18:03:54', '成功', '主键id=null'), ('1189120674465275906', '业务日志', '清空登录日志', '1', 'cn.stylefeng.guns.sys.modular.system.controller.LoginLogController', 'delLog', '2019-10-29 18:03:56', '成功', '主键id=null'), ('1207568331824304130', '业务日志', '删除角色', '1', 'cn.stylefeng.guns.sys.modular.system.controller.RoleController', 'remove', '2019-12-19 15:48:20', '成功', '角色名称=第三方登录'), ('1207568531427037186', '业务日志', '删除通知', '1', 'cn.stylefeng.guns.sys.modular.system.controller.NoticeController', 'delete', '2019-12-19 15:49:08', '成功', '标题=欢迎'), ('1207568632027418625', '业务日志', '修改通知', '1', 'cn.stylefeng.guns.sys.modular.system.controller.NoticeController', 'update', '2019-12-19 15:49:32', '成功', '标题=perf-manager;;;'), ('1207577576712065026', '异常日志', '', '1', null, null, '2019-12-19 16:25:05', '失败', 'RequestEmptyException()\n'), ('1207577598547611649', '异常日志', '', '1', null, null, '2019-12-19 16:25:10', '失败', 'RequestEmptyException()\n'), ('1207577663299276801', '异常日志', '', '1', null, null, '2019-12-19 16:25:25', '失败', 'RequestEmptyException()\n'), ('1207577700448227330', '业务日志', '菜单新增', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'add', '2019-12-19 16:25:34', '成功', '菜单名称=项目管理'), ('1207578305669517314', '业务日志', '配置权限', '1', 'cn.stylefeng.guns.sys.modular.system.controller.RoleController', 'setAuthority', '2019-12-19 16:27:58', '成功', '角色名称=超级管理员,资源名称=系统管理,用户管理,添加用户,修改用户,删除用户,重置密码,冻结用户,解除冻结用户,分配角色,分配角色跳转,编辑用户跳转,用户列表,角色管理,添加角色,修改角色,删除角色,配置权限,修改角色跳转,角色分配跳转,角色列表,菜单管理,添加菜单,修改菜单,删除菜单,菜单编辑跳转,菜单列表,业务日志,清空日志,日志列表,日志详情,监控管理,部门管理,添加部门,修改部门,删除部门,修改部门跳转,部门列表,部门详情,字典管理,添加字典,修改字典,删除字典,修改菜单跳转,字典列表,字典详情,登录日志,清空登录日志,登录日志列表,通知管理,添加通知,修改通知,删除通知,职位管理,职位表添加,职位表修改,职位表删除,开发管理,接口文档,模板页面,excel导入,excel导出,高级表单,文档预览,代码生成,系统配置,数据源管理,参数配置,参数配置添加,参数配置修改,参数配置删除,主控面板,消息通知,项目介绍,统计报表,系统监控,空表名,空表名添加,空表名修改,空表名删除,项目管理'), ('1207578877315403778', '业务日志', '修改菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'edit', '2019-12-19 16:30:15', '成功', '菜单名称=空表名;;;字段名称:菜单图标,旧值:fa-star,新值:layui-icon-template-1;;;字段名称:null,旧值:Y,新值:N'), ('1207578960488452098', '业务日志', '配置权限', '1', 'cn.stylefeng.guns.sys.modular.system.controller.RoleController', 'setAuthority', '2019-12-19 16:30:35', '成功', '角色名称=超级管理员,资源名称=系统管理,用户管理,添加用户,修改用户,删除用户,重置密码,冻结用户,解除冻结用户,分配角色,分配角色跳转,编辑用户跳转,用户列表,角色管理,添加角色,修改角色,删除角色,配置权限,修改角色跳转,角色分配跳转,角色列表,菜单管理,添加菜单,修改菜单,删除菜单,菜单编辑跳转,菜单列表,业务日志,清空日志,日志列表,日志详情,监控管理,部门管理,添加部门,修改部门,删除部门,修改部门跳转,部门列表,部门详情,字典管理,添加字典,修改字典,删除字典,修改菜单跳转,字典列表,字典详情,登录日志,清空登录日志,登录日志列表,通知管理,添加通知,修改通知,删除通知,职位管理,职位表添加,职位表修改,职位表删除,开发管理,接口文档,模板页面,excel导入,excel导出,高级表单,文档预览,代码生成,系统配置,数据源管理,参数配置,参数配置添加,参数配置修改,参数配置删除,主控面板,消息通知,项目介绍,统计报表,系统监控,项目管理,空表名,空表名添加,空表名修改,空表名删除'), ('1207579405642518530', '业务日志', '修改菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'edit', '2019-12-19 16:32:21', '成功', '菜单名称=项目管理;;;字段名称:url地址,旧值:/projects,新值:#'), ('1207579418883936257', '异常日志', '', '1', null, null, '2019-12-19 16:32:24', '失败', 'me.zhyd.oauth.exception.AuthException: Parameter incomplete\n	at me.zhyd.oauth.request.AuthDefaultRequest.<init>(AuthDefaultRequest.java:36)\n	at me.zhyd.oauth.request.AuthQqRequest.<init>(AuthQqRequest.java:28)\n	at cn.stylefeng.guns.sys.modular.third.factory.OAuthRequestFactory.getAuthRequest(OAuthRequestFactory.java:99)\n	at cn.stylefeng.guns.sys.modular.third.controller.OAuthController.renderAuth(OAuthController.java:46)\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:189)\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:102)\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:895)\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:800)\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1038)\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:942)\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1005)\n	at org.springframework.web.servlet.FrameworkServlet.doGet(FrameworkServlet.java:897)\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:634)\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:882)\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:741)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:101)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at cn.stylefeng.roses.core.xss.XssFilter.doFilter(XssFilter.java:31)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:124)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:320)\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:127)\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:91)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:119)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:170)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at cn.stylefeng.guns.sys.core.auth.filter.JwtAuthorizationTokenFilter.doFilterInternal(JwtAuthorizationTokenFilter.java:114)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.web.filter.CorsFilter.doFilterInternal(CorsFilter.java:96)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:74)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:357)\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:270)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:92)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:93)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:200)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:199)\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:490)\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:139)\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74)\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:408)\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66)\n	at org.apache.coyote.AbstractProtocolTConnectionHandler.process(AbstractProtocol.java:791)\n	at org.apache.tomcat.util.net.NioEndpointTSocketProcessor.doRun(NioEndpoint.java:1417)\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n	at java.util.concurrent.ThreadPoolExecutorTWorker.run(ThreadPoolExecutor.java:624)\n	at org.apache.tomcat.util.threads.TaskThreadTWrappingRunnable.run(TaskThread.java:61)\n	at java.lang.Thread.run(Thread.java:748)\n'), ('1207579560051625986', '业务日志', '修改菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'edit', '2019-12-19 16:32:58', '成功', '菜单名称=空表名;;;字段名称:null,旧值:N,新值:Y'), ('1207579806160801793', '业务日志', '修改菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'edit', '2019-12-19 16:33:56', '成功', '菜单名称=空表名添加;;;字段名称:url地址,旧值:,新值:/tProject/add'), ('1207579880391593985', '业务日志', '配置权限', '1', 'cn.stylefeng.guns.sys.modular.system.controller.RoleController', 'setAuthority', '2019-12-19 16:34:14', '成功', '角色名称=超级管理员,资源名称=系统管理,用户管理,添加用户,修改用户,删除用户,重置密码,冻结用户,解除冻结用户,分配角色,分配角色跳转,编辑用户跳转,用户列表,角色管理,添加角色,修改角色,删除角色,配置权限,修改角色跳转,角色分配跳转,角色列表,菜单管理,添加菜单,修改菜单,删除菜单,菜单编辑跳转,菜单列表,业务日志,清空日志,日志列表,日志详情,监控管理,部门管理,添加部门,修改部门,删除部门,修改部门跳转,部门列表,部门详情,字典管理,添加字典,修改字典,删除字典,修改菜单跳转,字典列表,字典详情,登录日志,清空登录日志,登录日志列表,通知管理,添加通知,修改通知,删除通知,职位管理,职位表添加,职位表修改,职位表删除,开发管理,接口文档,模板页面,excel导入,excel导出,高级表单,文档预览,代码生成,系统配置,数据源管理,参数配置,参数配置添加,参数配置修改,参数配置删除,主控面板,消息通知,项目介绍,统计报表,系统监控,项目管理,空表名,空表名修改,空表名删除,空表名添加'), ('1207580043159949314', '业务日志', '删除菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'remove', '2019-12-19 16:34:53', '成功', '菜单名称=空表名添加'), ('1207580207668940801', '业务日志', '修改菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'edit', '2019-12-19 16:35:32', '成功', '菜单名称=项目管理;;;字段名称:菜单名称,旧值:空表名,新值:项目管理'), ('1207581701524828161', '业务日志', '修改菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'edit', '2019-12-19 16:41:28', '成功', '菜单名称=项目管理;;;字段名称:菜单编号,旧值:TP_ROJECT,新值:tProject'), ('1207586185336500225', '业务日志', '删除菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'remove', '2019-12-19 16:59:17', '成功', '菜单名称=项目管理'), ('1207587835291783169', '业务日志', '删除菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'remove', '2019-12-19 17:05:50', '成功', '菜单名称=项目管理'), ('1207587928111730689', '业务日志', '配置权限', '1', 'cn.stylefeng.guns.sys.modular.system.controller.RoleController', 'setAuthority', '2019-12-19 17:06:13', '成功', '角色名称=超级管理员,资源名称=系统管理,用户管理,添加用户,修改用户,删除用户,重置密码,冻结用户,解除冻结用户,分配角色,分配角色跳转,编辑用户跳转,用户列表,角色管理,添加角色,修改角色,删除角色,配置权限,修改角色跳转,角色分配跳转,角色列表,菜单管理,添加菜单,修改菜单,删除菜单,菜单编辑跳转,菜单列表,业务日志,清空日志,日志列表,日志详情,监控管理,部门管理,添加部门,修改部门,删除部门,修改部门跳转,部门列表,部门详情,字典管理,添加字典,修改字典,删除字典,修改菜单跳转,字典列表,字典详情,登录日志,清空登录日志,登录日志列表,通知管理,添加通知,修改通知,删除通知,职位管理,职位表添加,职位表修改,职位表删除,开发管理,接口文档,模板页面,excel导入,excel导出,高级表单,文档预览,代码生成,系统配置,数据源管理,参数配置,参数配置添加,参数配置修改,参数配置删除,主控面板,消息通知,项目介绍,统计报表,系统监控,空表名,空表名添加,空表名修改,空表名删除'), ('1207588255141613570', '业务日志', '修改菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'edit', '2019-12-19 17:07:31', '成功', '菜单名称=空表名;;;字段名称:url地址,旧值:/project,新值:/project/project'), ('1207588602073468930', '业务日志', '修改菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'edit', '2019-12-19 17:08:53', '成功', '菜单名称=空表名;;;字段名称:菜单编号,旧值:PROJECT,新值:project'), ('1207589130731933698', '业务日志', '修改菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'edit', '2019-12-19 17:10:59', '成功', '菜单名称=空表名;;;字段名称:url地址,旧值:/project/project,新值:/project'), ('1207589161509736449', '业务日志', '修改菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'edit', '2019-12-19 17:11:07', '成功', '菜单名称=空表名;;;'), ('1207589252308029441', '业务日志', '修改菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'edit', '2019-12-19 17:11:28', '成功', '菜单名称=空表名;;;字段名称:菜单编号,旧值:project,新值:PROJECT'), ('1207590224598020097', '业务日志', '菜单新增', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'add', '2019-12-19 17:15:20', '成功', '菜单名称=业务管理'), ('1207590293061644289', '业务日志', '修改菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'edit', '2019-12-19 17:15:36', '成功', '菜单名称=业务管理;;;字段名称:菜单排序号,旧值:5,新值:500'), ('1207590511014457346', '业务日志', '修改菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'edit', '2019-12-19 17:16:28', '成功', '菜单名称=项目管理;;;字段名称:菜单名称,旧值:空表名,新值:项目管理;;;字段名称:菜单图标,旧值:fa-star,新值:layui-icon-template-1'), ('1207590562277240833', '业务日志', '配置权限', '1', 'cn.stylefeng.guns.sys.modular.system.controller.RoleController', 'setAuthority', '2019-12-19 17:16:41', '成功', '角色名称=超级管理员,资源名称=系统管理,用户管理,添加用户,修改用户,删除用户,重置密码,冻结用户,解除冻结用户,分配角色,分配角色跳转,编辑用户跳转,用户列表,角色管理,添加角色,修改角色,删除角色,配置权限,修改角色跳转,角色分配跳转,角色列表,菜单管理,添加菜单,修改菜单,删除菜单,菜单编辑跳转,菜单列表,业务日志,清空日志,日志列表,日志详情,监控管理,部门管理,添加部门,修改部门,删除部门,修改部门跳转,部门列表,部门详情,字典管理,添加字典,修改字典,删除字典,修改菜单跳转,字典列表,字典详情,登录日志,清空登录日志,登录日志列表,通知管理,添加通知,修改通知,删除通知,职位管理,职位表添加,职位表修改,职位表删除,开发管理,接口文档,模板页面,excel导入,excel导出,高级表单,文档预览,代码生成,系统配置,数据源管理,参数配置,参数配置添加,参数配置修改,参数配置删除,主控面板,消息通知,项目介绍,统计报表,系统监控,业务管理,项目管理,空表名添加,空表名修改,空表名删除'), ('1207592016329187330', '业务日志', '修改菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'edit', '2019-12-19 17:22:27', '成功', '菜单名称=项目管理;;;'), ('1207593817287835649', '业务日志', '删除菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'remove', '2019-12-19 17:29:37', '成功', '菜单名称=项目管理'), ('1207595734831370242', '业务日志', '修改菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'edit', '2019-12-19 17:37:14', '成功', '菜单名称=空表名;;;'), ('1207595772710129665', '业务日志', '配置权限', '1', 'cn.stylefeng.guns.sys.modular.system.controller.RoleController', 'setAuthority', '2019-12-19 17:37:23', '成功', '角色名称=超级管理员,资源名称=系统管理,用户管理,添加用户,修改用户,删除用户,重置密码,冻结用户,解除冻结用户,分配角色,分配角色跳转,编辑用户跳转,用户列表,角色管理,添加角色,修改角色,删除角色,配置权限,修改角色跳转,角色分配跳转,角色列表,菜单管理,添加菜单,修改菜单,删除菜单,菜单编辑跳转,菜单列表,业务日志,清空日志,日志列表,日志详情,监控管理,部门管理,添加部门,修改部门,删除部门,修改部门跳转,部门列表,部门详情,字典管理,添加字典,修改字典,删除字典,修改菜单跳转,字典列表,字典详情,登录日志,清空登录日志,登录日志列表,通知管理,添加通知,修改通知,删除通知,职位管理,职位表添加,职位表修改,职位表删除,开发管理,接口文档,模板页面,excel导入,excel导出,高级表单,文档预览,代码生成,系统配置,数据源管理,参数配置,参数配置添加,参数配置修改,参数配置删除,主控面板,消息通知,项目介绍,统计报表,系统监控,业务管理,空表名,空表名添加,空表名修改,空表名删除'), ('1207596148117114881', '业务日志', '修改菜单', '1', 'cn.stylefeng.guns.sys.modular.system.controller.MenuController', 'edit', '2019-12-19 17:38:52', '成功', '菜单名称=项目管理;;;字段名称:菜单名称,旧值:空表名,新值:项目管理'), ('1207596789212266498', '异常日志', '', '1', null, null, '2019-12-19 17:41:25', '失败', 'org.springframework.dao.DataIntegrityViolationException: \n### Error updating database.  Cause: java.sql.SQLException: Field \'sale_id\' doesn\'t have a default value\n### The error may exist in cn/stylefeng/guns/modular/project/mapper/ProjectMapper.java (best guess)\n### The error may involve cn.stylefeng.guns.modular.project.mapper.ProjectMapper.insert-Inline\n### The error occurred while setting parameters\n### SQL: INSERT INTO t_project  ( project_name,   create_time )  VALUES  ( ?,   ? )\n### Cause: java.sql.SQLException: Field \'sale_id\' doesn\'t have a default value\n; Field \'sale_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'sale_id\' doesn\'t have a default value\n	at org.springframework.jdbc.support.SQLErrorCodeSQLExceptionTranslator.doTranslate(SQLErrorCodeSQLExceptionTranslator.java:246)\n	at org.springframework.jdbc.support.AbstractFallbackSQLExceptionTranslator.translate(AbstractFallbackSQLExceptionTranslator.java:72)\n	at org.mybatis.spring.MyBatisExceptionTranslator.translateExceptionIfPossible(MyBatisExceptionTranslator.java:73)\n	at cn.stylefeng.roses.core.mutidatasource.mybatis.OptionalSqlSessionTemplateTSqlSessionInterceptor.invoke(OptionalSqlSessionTemplate.java:348)\n	at com.sun.proxy.TProxy86.insert(Unknown Source)\n	at cn.stylefeng.roses.core.mutidatasource.mybatis.OptionalSqlSessionTemplate.insert(OptionalSqlSessionTemplate.java:203)\n	at com.baomidou.mybatisplus.core.override.MybatisMapperMethod.execute(MybatisMapperMethod.java:64)\n	at com.baomidou.mybatisplus.core.override.MybatisMapperProxy.invoke(MybatisMapperProxy.java:61)\n	at com.sun.proxy.TProxy110.insert(Unknown Source)\n	at com.baomidou.mybatisplus.extension.service.impl.ServiceImpl.save(ServiceImpl.java:105)\n	at cn.stylefeng.guns.modular.project.service.impl.ProjectServiceImpl.add(ProjectServiceImpl.java:33)\n	at cn.stylefeng.guns.modular.project.service.impl.ProjectServiceImplTTFastClassBySpringCGLIBTT3d86e865.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:749)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\n	at com.alibaba.druid.support.spring.stat.DruidStatInterceptor.invoke(DruidStatInterceptor.java:73)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\n	at cn.stylefeng.guns.modular.project.service.impl.ProjectServiceImplTTEnhancerBySpringCGLIBTT4f0bda88.add(<generated>)\n	at cn.stylefeng.guns.modular.project.controller.ProjectController.addItem(ProjectController.java:72)\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:189)\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:102)\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:895)\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:800)\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1038)\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:942)\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1005)\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:908)\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:660)\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:882)\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:741)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:101)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at cn.stylefeng.roses.core.xss.XssFilter.doFilter(XssFilter.java:31)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:124)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:320)\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:127)\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:91)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:119)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:170)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at cn.stylefeng.guns.sys.core.auth.filter.JwtAuthorizationTokenFilter.doFilterInternal(JwtAuthorizationTokenFilter.java:114)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.web.filter.CorsFilter.doFilterInternal(CorsFilter.java:96)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:74)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.springframework.security.web.FilterChainProxyTVirtualFilterChain.doFilter(FilterChainProxy.java:334)\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:357)\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:270)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:92)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:93)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:200)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:199)\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:490)\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:139)\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74)\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:408)\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66)\n	at org.apache.coyote.AbstractProtocolTConnectionHandler.process(AbstractProtocol.java:791)\n	at org.apache.tomcat.util.net.NioEndpointTSocketProcessor.doRun(NioEndpoint.java:1417)\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n	at java.util.concurrent.ThreadPoolExecutorTWorker.run(ThreadPoolExecutor.java:624)\n	at org.apache.tomcat.util.threads.TaskThreadTWrappingRunnable.run(TaskThread.java:61)\n	at java.lang.Thread.run(Thread.java:748)\nCaused by: java.sql.SQLException: Field \'sale_id\' doesn\'t have a default value\n	at com.mysql.cj.jdbc.exceptions.SQLError.createSQLException(SQLError.java:127)\n	at com.mysql.cj.jdbc.exceptions.SQLError.createSQLException(SQLError.java:95)\n	at com.mysql.cj.jdbc.exceptions.SQLExceptionsMapping.translateException(SQLExceptionsMapping.java:122)\n	at com.mysql.cj.jdbc.ClientPreparedStatement.executeInternal(ClientPreparedStatement.java:960)\n	at com.mysql.cj.jdbc.ClientPreparedStatement.execute(ClientPreparedStatement.java:388)\n	at com.alibaba.druid.filter.FilterChainImpl.preparedStatement_execute(FilterChainImpl.java:3461)\n	at com.alibaba.druid.filter.FilterEventAdapter.preparedStatement_execute(FilterEventAdapter.java:440)\n	at com.alibaba.druid.filter.FilterChainImpl.preparedStatement_execute(FilterChainImpl.java:3459)\n	at com.alibaba.druid.wall.WallFilter.preparedStatement_execute(WallFilter.java:627)\n	at com.alibaba.druid.filter.FilterChainImpl.preparedStatement_execute(FilterChainImpl.java:3459)\n	at com.alibaba.druid.proxy.jdbc.PreparedStatementProxyImpl.execute(PreparedStatementProxyImpl.java:167)\n	at com.alibaba.druid.pool.DruidPooledPreparedStatement.execute(DruidPooledPreparedStatement.java:497)\n	at sun.reflect.GeneratedMethodAccessor107.invoke(Unknown Source)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at org.apache.ibatis.logging.jdbc.PreparedStatementLogger.invoke(PreparedStatementLogger.java:59)\n	at com.sun.proxy.TProxy160.execute(Unknown Source)\n	at org.apache.ibatis.executor.statement.PreparedStatementHandler.update(PreparedStatementHandler.java:47)\n	at org.apache.ibatis.executor.statement.RoutingStatementHandler.update(RoutingStatementHandler.java:74)\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at org.apache.ibatis.plugin.Plugin.invoke(Plugin.java:63)\n	at com.sun.proxy.TProxy158.update(Unknown Source)\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at org.apache.ibatis.plugin.Plugin.invoke(Plugin.java:63)\n	at com.sun.proxy.TProxy158.update(Unknown Source)\n	at org.apache.ibatis.executor.SimpleExecutor.doUpdate(SimpleExecutor.java:50)\n	at org.apache.ibatis.executor.BaseExecutor.update(BaseExecutor.java:117)\n	at org.apache.ibatis.executor.CachingExecutor.update(CachingExecutor.java:76)\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at org.apache.ibatis.plugin.Invocation.proceed(Invocation.java:49)\n	at com.baomidou.mybatisplus.extension.plugins.OptimisticLockerInterceptor.intercept(OptimisticLockerInterceptor.java:74)\n	at org.apache.ibatis.plugin.Plugin.invoke(Plugin.java:61)\n	at com.sun.proxy.TProxy157.update(Unknown Source)\n	at org.apache.ibatis.session.defaults.DefaultSqlSession.update(DefaultSqlSession.java:198)\n	at org.apache.ibatis.session.defaults.DefaultSqlSession.insert(DefaultSqlSession.java:185)\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at cn.stylefeng.roses.core.mutidatasource.mybatis.OptionalSqlSessionTemplateTSqlSessionInterceptor.invoke(OptionalSqlSessionTemplate.java:335)\n	... 113 more\n');
COMMIT;

-- ----------------------------
--  Table structure for `sys_position`
-- ----------------------------
DROP TABLE IF EXISTS `sys_position`;
CREATE TABLE `sys_position` (
  `position_id` bigint(20) NOT NULL COMMENT '主键id',
  `name` varchar(50) NOT NULL COMMENT '职位名称',
  `code` varchar(64) NOT NULL COMMENT '职位编码',
  `sort` int(11) NOT NULL COMMENT '顺序',
  `status` varchar(100) NOT NULL DEFAULT 'ENABLE' COMMENT '状态(字典)',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建者',
  PRIMARY KEY (`position_id`) USING BTREE,
  UNIQUE KEY `CODE_UNI` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='职位表';

-- ----------------------------
--  Records of `sys_position`
-- ----------------------------
BEGIN;
INSERT INTO `sys_position` VALUES ('1', '董事长', 'President', '1', 'ENABLE', null, '2019-06-27 18:14:43', '1', null, null), ('2', '总经理', 'GM', '2', 'ENABLE', null, '2019-06-27 18:14:43', '1', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `sys_relation`
-- ----------------------------
DROP TABLE IF EXISTS `sys_relation`;
CREATE TABLE `sys_relation` (
  `relation_id` bigint(20) NOT NULL COMMENT '主键',
  `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单id',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`relation_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色和菜单关联表';

-- ----------------------------
--  Records of `sys_relation`
-- ----------------------------
BEGIN;
INSERT INTO `sys_relation` VALUES ('1207595771053379585', '105', '1'), ('1207595771065962498', '106', '1'), ('1207595771070156801', '107', '1'), ('1207595771082739713', '108', '1'), ('1207595771091128321', '109', '1'), ('1207595771103711234', '110', '1'), ('1207595771112099842', '111', '1'), ('1207595771120488449', '112', '1'), ('1207595771128877057', '113', '1'), ('1207595771137265665', '165', '1'), ('1207595771149848577', '166', '1'), ('1207595771158237186', '167', '1'), ('1207595771166625793', '114', '1'), ('1207595771179208705', '115', '1'), ('1207595771187597313', '116', '1'), ('1207595771191791617', '117', '1'), ('1207595771200180225', '118', '1'), ('1207595771208568834', '162', '1'), ('1207595771216957442', '163', '1'), ('1207595771225346049', '164', '1'), ('1207595771233734657', '119', '1'), ('1207595771242123266', '120', '1'), ('1207595771250511874', '121', '1'), ('1207595771258900482', '122', '1'), ('1207595771267289089', '150', '1'), ('1207595771275677698', '151', '1'), ('1207595771284066306', '128', '1'), ('1207595771288260609', '134', '1'), ('1207595771296649218', '158', '1'), ('1207595771305037826', '159', '1'), ('1207595771313426434', '130', '1'), ('1207595771321815041', '131', '1'), ('1207595771330203650', '135', '1'), ('1207595771338592258', '136', '1'), ('1207595771346980866', '137', '1'), ('1207595771351175170', '152', '1'), ('1207595771359563778', '153', '1'), ('1207595771367952386', '154', '1'), ('1207595771380535297', '132', '1'), ('1207595771388923905', '138', '1'), ('1207595771397312514', '139', '1'), ('1207595771418284034', '140', '1'), ('1207595771426672641', '155', '1'), ('1207595771435061249', '156', '1'), ('1207595771443449858', '157', '1'), ('1207595771451838466', '133', '1'), ('1207595771464421378', '160', '1'), ('1207595771472809985', '161', '1'), ('1207595771477004290', '141', '1'), ('1207595771485392898', '142', '1'), ('1207595771493781505', '143', '1'), ('1207595771502170113', '144', '1'), ('1207595771510558721', '1144441072852684801', '1'), ('1207595771518947329', '1144441072852684802', '1'), ('1207595771527335938', '1144441072852684803', '1'), ('1207595771535724545', '1144441072852684804', '1'), ('1207595771544113154', '171', '1'), ('1207595771552501762', '149', '1'), ('1207595771560890369', '1110777136265838594', '1'), ('1207595771569278978', '1110777366856089602', '1'), ('1207595771577667586', '1110777491464667137', '1'), ('1207595771581861890', '1110787391943098370', '1'), ('1207595771594444801', '1110839216310329346', '1'), ('1207595771602833410', '1127085735660421122', '1'), ('1207595771611222017', '1139826657964593154', '1'), ('1207595771619610626', '1139827152854716418', '1'), ('1207595771627999233', '1142957882422112257', '1'), ('1207595771636387842', '1142957882422112258', '1'), ('1207595771644776450', '1142957882422112259', '1'), ('1207595771653165058', '1142957882426306562', '1'), ('1207595771665747970', '172', '1'), ('1207595771674136577', '145', '1'), ('1207595771682525186', '1111545968697860098', '1'), ('1207595771690913793', '1111546189892870145', '1'), ('1207595771699302401', '1149955324929765378', '1'), ('1207595771707691010', '1207590224476385281', '1'), ('1207595771716079618', '1207594906754105346', '1'), ('1207595771724468226', '1207594906754105347', '1'), ('1207595771732856833', '1207594906754105348', '1'), ('1207595771741245441', '1207594906754105349', '1');
COMMIT;

-- ----------------------------
--  Table structure for `sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL COMMENT '主键id',
  `pid` bigint(20) DEFAULT NULL COMMENT '父角色id',
  `name` varchar(255) DEFAULT NULL COMMENT '角色名称',
  `description` varchar(255) DEFAULT NULL COMMENT '提示',
  `sort` int(11) DEFAULT NULL COMMENT '序号',
  `version` int(11) DEFAULT NULL COMMENT '乐观锁',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建用户',
  `update_user` bigint(20) DEFAULT NULL COMMENT '修改用户',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色表';

-- ----------------------------
--  Records of `sys_role`
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` VALUES ('1', '0', '超级管理员', 'administrator', '1', '1', null, null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL COMMENT '主键id',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `account` varchar(45) DEFAULT NULL COMMENT '账号',
  `password` varchar(45) DEFAULT NULL COMMENT '密码',
  `salt` varchar(45) DEFAULT NULL COMMENT 'md5密码盐',
  `name` varchar(45) DEFAULT NULL COMMENT '名字',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `sex` varchar(32) DEFAULT NULL COMMENT '性别(字典)',
  `email` varchar(45) DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(45) DEFAULT NULL COMMENT '电话',
  `role_id` varchar(255) DEFAULT NULL COMMENT '角色id(多个逗号隔开)',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门id(多个逗号隔开)',
  `status` varchar(32) DEFAULT NULL COMMENT '状态(字典)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  `version` int(11) DEFAULT NULL COMMENT '乐观锁',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='管理员表';

-- ----------------------------
--  Records of `sys_user`
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES ('1', '1124606971782160385', 'admin', '5a7a1613f8283685a90da4bd72407693', 'abcdef', 'stylefeng', '2018-11-16 00:00:00', 'M', 'sn93@qq.com', '18200000000', '1', '25', 'ENABLE', '2016-01-29 08:49:53', null, '2019-12-19 15:48:07', '24', '25');
COMMIT;

-- ----------------------------
--  Table structure for `sys_user_pos`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_pos`;
CREATE TABLE `sys_user_pos` (
  `user_pos_id` bigint(20) NOT NULL COMMENT '主键id',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `pos_id` bigint(20) NOT NULL COMMENT '职位id',
  PRIMARY KEY (`user_pos_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户职位关联表';

-- ----------------------------
--  Records of `sys_user_pos`
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_pos` VALUES ('1144495219551617025', '1', '1');
COMMIT;

-- ----------------------------
--  Table structure for `t_project`
-- ----------------------------
DROP TABLE IF EXISTS `t_project`;
CREATE TABLE `t_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_name` varchar(255) NOT NULL,
  `project_status` tinyint(1) NOT NULL DEFAULT '0',
  `sale_id` int(11) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `creator_name` varchar(255) DEFAULT NULL,
  `is_del` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `t_project`
-- ----------------------------
BEGIN;
INSERT INTO `t_project` VALUES ('1', 't1', '0', '1', null, null, null, '1', '0');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
