SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

DROP TABLE  IF EXISTS `uctoo_action`;
CREATE TABLE IF NOT EXISTS `uctoo_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '行为唯一标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` char(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` text NOT NULL COMMENT '行为规则',
  `log` text NOT NULL COMMENT '日志规则',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `module` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统行为表' AUTO_INCREMENT=1 ;


INSERT INTO `uctoo_action` ( `name`, `title`, `remark`, `rule`, `log`, `type`, `status`, `update_time`, `module`) VALUES
( 'reg', '用户注册', '用户注册', '', '', 1, 1, 1426070545, ''),
( 'input_password', '输入密码', '记录输入密码的次数。', '', '', 1, 1, 1426122119, ''),
( 'user_login', '用户登录', '积分+10，每天一次', 'a:1:{i:0;a:5:{s:5:"table";s:6:"member";s:5:"field";s:1:"1";s:4:"rule";s:2:"10";s:5:"cycle";s:2:"24";s:3:"max";s:1:"1";}}', '[user|get_nickname]在[time|time_format]登录了账号', 1, 1, 1428397656, ''),
( 'update_config', '更新配置', '新增或修改或删除配置', '', '', 1, 1, 1383294988, ''),
( 'update_model', '更新模型', '新增或修改模型', '', '', 1, 1, 1383295057, ''),
( 'update_attribute', '更新属性', '新增或更新或删除属性', '', '', 1, 1, 1383295963, ''),
( 'update_channel', '更新导航', '新增或修改或删除导航', '', '', 1, 1, 1383296301, ''),
( 'update_menu', '更新菜单', '新增或修改或删除菜单', '', '', 1, 1, 1383296392, ''),
( 'update_category', '更新分类', '新增或修改或删除分类', '', '', 1, 1, 1383296765, '');

DROP TABLE  IF EXISTS `uctoo_action_limit`;
CREATE TABLE IF NOT EXISTS `uctoo_action_limit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  `frequency` int(11) NOT NULL,
  `time_number` int(11) NOT NULL,
  `time_unit` varchar(50) NOT NULL,
  `punish` text NOT NULL,
  `if_message` tinyint(4) NOT NULL,
  `message_content` text NOT NULL,
  `action_list` text NOT NULL,
  `status` tinyint(4) NOT NULL,
  `create_time` int(11) NOT NULL,
  `module` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

INSERT INTO `uctoo_action_limit` ( `title`, `name`, `frequency`, `time_number`, `time_unit`, `punish`, `if_message`, `message_content`, `action_list`, `status`, `create_time`, `module`) VALUES
( 'reg', '注册限制', 1, 1, 'minute', 'warning', 0, '', '[reg]', 1, 0, ''),
( 'input_password', '输密码', 3, 1, 'minute', 'warning', 0, '', '[input_password]', 1, 0, '');



DROP TABLE  IF EXISTS `uctoo_action_log`;
CREATE TABLE IF NOT EXISTS `uctoo_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '行为id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `action_ip` bigint(20) NOT NULL COMMENT '执行行为者ip',
  `model` varchar(50) NOT NULL DEFAULT '' COMMENT '触发行为的表',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`),
  KEY `action_ip_ix` (`action_ip`),
  KEY `action_id_ix` (`action_id`),
  KEY `user_id_ix` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='行为日志表' AUTO_INCREMENT=1 ;

DROP TABLE  IF EXISTS `uctoo_addons`;
CREATE TABLE IF NOT EXISTS `uctoo_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL COMMENT '插件名或标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '中文名',
  `description` text COMMENT '插件描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `config` text COMMENT '配置',
  `author` varchar(40) DEFAULT '' COMMENT '作者',
  `version` varchar(20) DEFAULT '' COMMENT '版本号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `has_adminlist` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台列表',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='插件表' AUTO_INCREMENT=7 ;

INSERT INTO `uctoo_addons` ( `name`, `title`, `description`, `status`, `config`, `author`, `version`, `create_time`, `has_adminlist`) VALUES
( 'SiteStat', '站点统计信息', '统计站点的基础信息', 1, '{"title":"\\u7cfb\\u7edf\\u4fe1\\u606f","width":"1","display":"1","status":"0"}', 'thinkphp', '0.1', 1379512015, 0),
( 'SystemInfo', '系统环境信息', '用于显示一些服务器的信息', 1, '{"title":"\\u7cfb\\u7edf\\u4fe1\\u606f","width":"6","display":"1"}', 'thinkphp', '0.1', 1420609113, 0),
( 'DevTeam', '开发团队信息', '开发团队成员信息', 1, '{"title":"ThinkOX\\u5f00\\u53d1\\u56e2\\u961f","width":"6","display":"1"}', 'thinkphp', '0.1', 1420609089, 0),
( 'SyncLogin', '同步登陆', '同步登陆', 1, '{"type":null,"meta":"","bind":"0","QqKEY":"","QqSecret":"","SinaKEY":"","SinaSecret":""}', 'xjw129xjt', '0.1', 1406598876, 0),
( 'LocalComment', '本地评论', '本地评论插件，不依赖社会化评论平台', 1, '{"can_guest_comment":"1"}', 'caipeichao', '0.1', 1399440324, 0),
( 'Keyword', '关键词', '关键词数据管理和微信关键词消息处理行为插件', '1', '{\"random\":\"1\"}', 'UCToo', '0.1', '1429325806', '1'),
( 'Welcome', '欢迎语', '用户关注公众号时发送的欢迎信息，支持文本，图片，图文的信息', '1', '{\"type\":\"1\",\"keyword\":\"\",\"title\":\"\",\"description\":\"\",\"pic_url\":\"\",\"url\":\"\"}', 'UCToo', '0.1', '1429585560', '0'),
('Weicj', '微场景', '微场景为产品、品牌以及事件的展示搭建了一个舞台，通过图片和音乐渲染氛围展示想传达的内容，并引导客户。可与其他插件配合使用以达到更好的营销效果。', '1', 'null', 'UCToo', '0.1', '1430374002', '0'),
('Ucuser', '微会员', '微会员管理和微信公众号粉丝初始化行为', '1', '{\"random\":\"1\"}', 'UCToo', '0.1', '1430793843', '1'),
('ToMobile', '转向手机页面', '转向手机页面，切换到手机页面', '1', '{\"to_mobile_type\":\"2\",\"js_to_mobile_type\":\"1\",\"js_url\":\"m.flutesing.com\",\"js_replace_url\":\"127.0.0.1|www.flutesing.com|flutesing.com\",\"mobile_theme\":\"mobile\"}', 'flutesing<www.flutesing.com>', '2014.5.25', '1431066151', '0'),
('Jssdk', '微信JSSDK演示案例', '微信开放平台JSSDK演示案例合辑', '1', 'null', 'uctoo', '0.1', '1431657126', '0');

DROP TABLE  IF EXISTS `uctoo_attachment`;
CREATE TABLE IF NOT EXISTS `uctoo_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '附件显示名',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件类型',
  `source` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '资源ID',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联记录ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '附件大小',
  `dir` int(12) unsigned NOT NULL DEFAULT '0' COMMENT '上级目录ID',
  `sort` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_record_status` (`record_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件表' AUTO_INCREMENT=1 ;


-- ----------------------------
-- Table structure for uctoo_attribute
-- ----------------------------
DROP TABLE IF EXISTS `uctoo_attribute`;
CREATE TABLE `uctoo_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '字段名',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '字段注释',
  `field` varchar(100) NOT NULL DEFAULT '' COMMENT '字段定义',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '数据类型',
  `value` varchar(100) NOT NULL DEFAULT '' COMMENT '字段默认值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '参数',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型id',
  `is_must` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否必填',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `validate_rule` varchar(255) NOT NULL,
  `validate_time` tinyint(1) unsigned NOT NULL,
  `error_info` varchar(100) NOT NULL,
  `validate_type` varchar(25) NOT NULL,
  `auto_rule` varchar(100) NOT NULL,
  `auto_time` tinyint(1) unsigned NOT NULL,
  `auto_type` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=174 DEFAULT CHARSET=utf8 COMMENT='模型属性表';

DROP TABLE  IF EXISTS `uctoo_auth_extend`;
CREATE TABLE IF NOT EXISTS `uctoo_auth_extend` (
  `group_id` mediumint(10) unsigned NOT NULL COMMENT '用户id',
  `extend_id` mediumint(8) unsigned NOT NULL COMMENT '扩展表中数据的id',
  `type` tinyint(1) unsigned NOT NULL COMMENT '扩展类型标识 1:栏目分类权限;2:模型权限',
  UNIQUE KEY `group_extend_type` (`group_id`,`extend_id`,`type`),
  KEY `uid` (`group_id`),
  KEY `group_id` (`extend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组与分类的对应关系表';


INSERT INTO `uctoo_auth_extend` (`group_id`, `extend_id`, `type`) VALUES
(1, 1, 1),
(1, 1, 2),
(1, 2, 1),
(1, 2, 2),
(1, 3, 1),
(1, 3, 2),
(1, 4, 1),
(1, 37, 1);

DROP TABLE  IF EXISTS `uctoo_auth_group`;
CREATE TABLE IF NOT EXISTS `uctoo_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL COMMENT '组类型',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` text NOT NULL COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;



INSERT INTO `uctoo_auth_group` (`id`, `module`, `type`, `title`, `description`, `status`, `rules`) VALUES
(1, 'admin', 1, '普通用户', '', 1, ',1,235,236,237,246,253,254,286,321,370,371,373,374,376,378,380,381,382,383,384,387,388,389'),
(2, 'admin', 1, '公众号粉丝组', '公众号粉丝', 1, ''),
(3, 'admin', 1, '公众号管理用户组', '', 1, ',368,369,235,236,237,246,253,254,281,286,321,370,377,379,1,313,315,316,322,371,373,376,378,380,381,382,383,384');

DROP TABLE  IF EXISTS `uctoo_auth_group_access`;
CREATE TABLE IF NOT EXISTS `uctoo_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



INSERT INTO `uctoo_auth_group_access` (`uid`, `group_id`) VALUES
(1, 1);


DROP TABLE  IF EXISTS `uctoo_auth_rule`;
CREATE TABLE IF NOT EXISTS `uctoo_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-主菜单',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=338 ;


INSERT INTO `uctoo_auth_rule` (`id`, `module`, `type`, `name`, `title`, `status`, `condition`) VALUES
(1, 'admin', 2, 'Admin/Index/index', '首页', 1, ''),
(2, 'admin', 2, 'Admin/Article/mydocument', '资讯', -1, ''),
(3, 'admin', 2, 'Admin/User/index', '用户', 1, ''),
(4, 'admin', 2, 'Admin/Addons/index', '插件', 1, ''),
(5, 'admin', 2, 'Admin/Config/group', '系统', 1, ''),
(7, 'admin', 1, 'Admin/article/add', '新增', -1, ''),
(8, 'admin', 1, 'Admin/article/edit', '编辑', -1, ''),
(9, 'admin', 1, 'Admin/article/setStatus', '改变状态', -1, ''),
(10, 'admin', 1, 'Admin/article/update', '保存', -1, ''),
(11, 'admin', 1, 'Admin/article/autoSave', '保存草稿', -1, ''),
(12, 'admin', 1, 'Admin/article/move', '移动', -1, ''),
(13, 'admin', 1, 'Admin/article/copy', '复制', -1, ''),
(14, 'admin', 1, 'Admin/article/paste', '粘贴', -1, ''),
(15, 'admin', 1, 'Admin/article/permit', '还原', -1, ''),
(16, 'admin', 1, 'Admin/article/clear', '清空', -1, ''),
(17, 'admin', 1, 'Admin/article/index', '文档列表', -1, ''),
(18, 'admin', 1, 'Admin/article/recycle', '回收站', -1, ''),
(19, 'admin', 1, 'Admin/User/addaction', '新增用户行为', 1, ''),
(20, 'admin', 1, 'Admin/User/editaction', '编辑用户行为', 1, ''),
(21, 'admin', 1, 'Admin/User/saveAction', '保存用户行为', 1, ''),
(22, 'admin', 1, 'Admin/User/setStatus', '变更行为状态', 1, ''),
(23, 'admin', 1, 'Admin/User/changeStatus?method=forbidUser', '禁用会员', 1, ''),
(24, 'admin', 1, 'Admin/User/changeStatus?method=resumeUser', '启用会员', 1, ''),
(25, 'admin', 1, 'Admin/User/changeStatus?method=deleteUser', '删除会员', 1, ''),
(26, 'admin', 1, 'Admin/User/index', '用户信息', 1, ''),
(27, 'admin', 1, 'Admin/User/action', '用户行为', 1, ''),
(28, 'admin', 1, 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', 1, ''),
(29, 'admin', 1, 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', 1, ''),
(30, 'admin', 1, 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', 1, ''),
(31, 'admin', 1, 'Admin/AuthManager/createGroup', '新增', 1, ''),
(32, 'admin', 1, 'Admin/AuthManager/editGroup', '编辑', 1, ''),
(33, 'admin', 1, 'Admin/AuthManager/writeGroup', '保存用户组', 1, ''),
(34, 'admin', 1, 'Admin/AuthManager/group', '授权', 1, ''),
(35, 'admin', 1, 'Admin/AuthManager/access', '访问授权', 1, ''),
(36, 'admin', 1, 'Admin/AuthManager/user', '成员授权', 1, ''),
(37, 'admin', 1, 'Admin/AuthManager/removeFromGroup', '解除授权', 1, ''),
(38, 'admin', 1, 'Admin/AuthManager/addToGroup', '保存成员授权', 1, ''),
(39, 'admin', 1, 'Admin/AuthManager/category', '分类授权', 1, ''),
(40, 'admin', 1, 'Admin/AuthManager/addToCategory', '保存分类授权', 1, ''),
(41, 'admin', 1, 'Admin/AuthManager/index', '权限管理', 1, ''),
(42, 'admin', 1, 'Admin/Addons/create', '创建', 1, ''),
(43, 'admin', 1, 'Admin/Addons/checkForm', '检测创建', 1, ''),
(44, 'admin', 1, 'Admin/Addons/preview', '预览', 1, ''),
(45, 'admin', 1, 'Admin/Addons/build', '快速生成插件', 1, ''),
(46, 'admin', 1, 'Admin/Addons/config', '设置', 1, ''),
(47, 'admin', 1, 'Admin/Addons/disable', '禁用', 1, ''),
(48, 'admin', 1, 'Admin/Addons/enable', '启用', 1, ''),
(49, 'admin', 1, 'Admin/Addons/install', '安装', 1, ''),
(50, 'admin', 1, 'Admin/Addons/uninstall', '卸载', 1, ''),
(51, 'admin', 1, 'Admin/Addons/saveconfig', '更新配置', 1, ''),
(52, 'admin', 1, 'Admin/Addons/adminList', '插件后台列表', 1, ''),
(53, 'admin', 1, 'Admin/Addons/execute', 'URL方式访问插件', 1, ''),
(54, 'admin', 1, 'Admin/Addons/index', '插件管理', 1, ''),
(55, 'admin', 1, 'Admin/Addons/hooks', '钩子管理', 1, ''),
(56, 'admin', 1, 'Admin/model/add', '新增', -1, ''),
(57, 'admin', 1, 'Admin/model/edit', '编辑', -1, ''),
(58, 'admin', 1, 'Admin/model/setStatus', '改变状态', -1, ''),
(59, 'admin', 1, 'Admin/model/update', '保存数据', -1, ''),
(60, 'admin', 1, 'Admin/Model/index', '模型管理', -1, ''),
(61, 'admin', 1, 'Admin/Config/edit', '编辑', 1, ''),
(62, 'admin', 1, 'Admin/Config/del', '删除', 1, ''),
(63, 'admin', 1, 'Admin/Config/add', '新增', 1, ''),
(64, 'admin', 1, 'Admin/Config/save', '保存', 1, ''),
(65, 'admin', 1, 'Admin/Config/group', '网站设置', 1, ''),
(66, 'admin', 1, 'Admin/Config/index', '配置管理', 1, ''),
(67, 'admin', 1, 'Admin/Channel/add', '新增', 1, ''),
(68, 'admin', 1, 'Admin/Channel/edit', '编辑', 1, ''),
(69, 'admin', 1, 'Admin/Channel/del', '删除', 1, ''),
(70, 'admin', 1, 'Admin/Channel/index', '导航管理', 1, ''),
(71, 'admin', 1, 'Admin/Category/edit', '编辑', 1, ''),
(72, 'admin', 1, 'Admin/Category/add', '新增', 1, ''),
(73, 'admin', 1, 'Admin/Category/remove', '删除', 1, ''),
(74, 'admin', 1, 'Admin/Category/index', '分类管理', 1, ''),
(75, 'admin', 1, 'Admin/file/upload', '上传控件', -1, ''),
(76, 'admin', 1, 'Admin/file/uploadPicture', '上传图片', -1, ''),
(77, 'admin', 1, 'Admin/file/download', '下载', -1, ''),
(94, 'admin', 1, 'Admin/AuthManager/modelauth', '模型授权', 1, ''),
(79, 'admin', 1, 'Admin/article/batchOperate', '导入', -1, ''),
(80, 'admin', 1, 'Admin/Database/index?type=export', '备份数据库', 1, ''),
(81, 'admin', 1, 'Admin/Database/index?type=import', '还原数据库', 1, ''),
(82, 'admin', 1, 'Admin/Database/export', '备份', 1, ''),
(83, 'admin', 1, 'Admin/Database/optimize', '优化表', 1, ''),
(84, 'admin', 1, 'Admin/Database/repair', '修复表', 1, ''),
(86, 'admin', 1, 'Admin/Database/import', '恢复', 1, ''),
(87, 'admin', 1, 'Admin/Database/del', '删除', 1, ''),
(88, 'admin', 1, 'Admin/User/add', '新增用户', 1, ''),
(89, 'admin', 1, 'Admin/Attribute/index', '属性管理', -1, ''),
(90, 'admin', 1, 'Admin/Attribute/add', '新增', -1, ''),
(91, 'admin', 1, 'Admin/Attribute/edit', '编辑', -1, ''),
(92, 'admin', 1, 'Admin/Attribute/setStatus', '改变状态', -1, ''),
(93, 'admin', 1, 'Admin/Attribute/update', '保存数据', -1, ''),
(95, 'admin', 1, 'Admin/AuthManager/addToModel', '保存模型授权', 1, ''),
(96, 'admin', 1, 'Admin/Category/move', '移动', -1, ''),
(97, 'admin', 1, 'Admin/Category/merge', '合并', -1, ''),
(98, 'admin', 1, 'Admin/Config/menu', '后台菜单管理', -1, ''),
(99, 'admin', 1, 'Admin/Article/mydocument', '内容', -1, ''),
(100, 'admin', 1, 'Admin/Menu/index', '菜单管理', 1, ''),
(101, 'admin', 1, 'Admin/other', '其他', -1, ''),
(102, 'admin', 1, 'Admin/Menu/add', '新增', 1, ''),
(103, 'admin', 1, 'Admin/Menu/edit', '编辑', 1, ''),
(104, 'admin', 1, 'Admin/Think/lists?model=article', '文章管理', -1, ''),
(105, 'admin', 1, 'Admin/Think/lists?model=download', '下载管理', 1, ''),
(106, 'admin', 1, 'Admin/Think/lists?model=config', '配置管理', 1, ''),
(107, 'admin', 1, 'Admin/Action/actionlog', '行为日志', 1, ''),
(108, 'admin', 1, 'Admin/User/updatePassword', '修改密码', 1, ''),
(109, 'admin', 1, 'Admin/User/updateNickname', '修改昵称', 1, ''),
(110, 'admin', 1, 'Admin/action/edit', '查看行为日志', 1, ''),
(205, 'admin', 1, 'Admin/think/add', '新增数据', 1, ''),
(111, 'admin', 2, 'Admin/article/index', '文档列表', -1, ''),
(112, 'admin', 2, 'Admin/article/add', '新增', -1, ''),
(113, 'admin', 2, 'Admin/article/edit', '编辑', -1, ''),
(114, 'admin', 2, 'Admin/article/setStatus', '改变状态', -1, ''),
(115, 'admin', 2, 'Admin/article/update', '保存', -1, ''),
(116, 'admin', 2, 'Admin/article/autoSave', '保存草稿', -1, ''),
(117, 'admin', 2, 'Admin/article/move', '移动', -1, ''),
(118, 'admin', 2, 'Admin/article/copy', '复制', -1, ''),
(119, 'admin', 2, 'Admin/article/paste', '粘贴', -1, ''),
(120, 'admin', 2, 'Admin/article/batchOperate', '导入', -1, ''),
(121, 'admin', 2, 'Admin/article/recycle', '回收站', -1, ''),
(122, 'admin', 2, 'Admin/article/permit', '还原', -1, ''),
(123, 'admin', 2, 'Admin/article/clear', '清空', -1, ''),
(124, 'admin', 2, 'Admin/User/add', '新增用户', -1, ''),
(125, 'admin', 2, 'Admin/User/action', '用户行为', -1, ''),
(126, 'admin', 2, 'Admin/User/addAction', '新增用户行为', -1, ''),
(127, 'admin', 2, 'Admin/User/editAction', '编辑用户行为', -1, ''),
(128, 'admin', 2, 'Admin/User/saveAction', '保存用户行为', -1, ''),
(129, 'admin', 2, 'Admin/User/setStatus', '变更行为状态', -1, ''),
(130, 'admin', 2, 'Admin/User/changeStatus?method=forbidUser', '禁用会员', -1, ''),
(131, 'admin', 2, 'Admin/User/changeStatus?method=resumeUser', '启用会员', -1, ''),
(132, 'admin', 2, 'Admin/User/changeStatus?method=deleteUser', '删除会员', -1, ''),
(133, 'admin', 2, 'Admin/AuthManager/index', '权限管理', -1, ''),
(134, 'admin', 2, 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', -1, ''),
(135, 'admin', 2, 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', -1, ''),
(136, 'admin', 2, 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', -1, ''),
(137, 'admin', 2, 'Admin/AuthManager/createGroup', '新增', -1, ''),
(138, 'admin', 2, 'Admin/AuthManager/editGroup', '编辑', -1, ''),
(139, 'admin', 2, 'Admin/AuthManager/writeGroup', '保存用户组', -1, ''),
(140, 'admin', 2, 'Admin/AuthManager/group', '授权', -1, ''),
(141, 'admin', 2, 'Admin/AuthManager/access', '访问授权', -1, ''),
(142, 'admin', 2, 'Admin/AuthManager/user', '成员授权', -1, ''),
(143, 'admin', 2, 'Admin/AuthManager/removeFromGroup', '解除授权', -1, ''),
(144, 'admin', 2, 'Admin/AuthManager/addToGroup', '保存成员授权', -1, ''),
(145, 'admin', 2, 'Admin/AuthManager/category', '分类授权', -1, ''),
(146, 'admin', 2, 'Admin/AuthManager/addToCategory', '保存分类授权', -1, ''),
(147, 'admin', 2, 'Admin/AuthManager/modelauth', '模型授权', -1, ''),
(148, 'admin', 2, 'Admin/AuthManager/addToModel', '保存模型授权', -1, ''),
(149, 'admin', 2, 'Admin/Addons/create', '创建', -1, ''),
(150, 'admin', 2, 'Admin/Addons/checkForm', '检测创建', -1, ''),
(151, 'admin', 2, 'Admin/Addons/preview', '预览', -1, ''),
(152, 'admin', 2, 'Admin/Addons/build', '快速生成插件', -1, ''),
(153, 'admin', 2, 'Admin/Addons/config', '设置', -1, ''),
(154, 'admin', 2, 'Admin/Addons/disable', '禁用', -1, ''),
(155, 'admin', 2, 'Admin/Addons/enable', '启用', -1, ''),
(156, 'admin', 2, 'Admin/Addons/install', '安装', -1, ''),
(157, 'admin', 2, 'Admin/Addons/uninstall', '卸载', -1, ''),
(158, 'admin', 2, 'Admin/Addons/saveconfig', '更新配置', -1, ''),
(159, 'admin', 2, 'Admin/Addons/adminList', '插件后台列表', -1, ''),
(160, 'admin', 2, 'Admin/Addons/execute', 'URL方式访问插件', -1, ''),
(161, 'admin', 2, 'Admin/Addons/hooks', '钩子管理', -1, ''),
(162, 'admin', 2, 'Admin/Model/index', '模型管理', -1, ''),
(163, 'admin', 2, 'Admin/model/add', '新增', -1, ''),
(164, 'admin', 2, 'Admin/model/edit', '编辑', -1, ''),
(165, 'admin', 2, 'Admin/model/setStatus', '改变状态', -1, ''),
(166, 'admin', 2, 'Admin/model/update', '保存数据', -1, ''),
(167, 'admin', 2, 'Admin/Attribute/index', '属性管理', -1, ''),
(168, 'admin', 2, 'Admin/Attribute/add', '新增', -1, ''),
(169, 'admin', 2, 'Admin/Attribute/edit', '编辑', -1, ''),
(170, 'admin', 2, 'Admin/Attribute/setStatus', '改变状态', -1, ''),
(171, 'admin', 2, 'Admin/Attribute/update', '保存数据', -1, ''),
(172, 'admin', 2, 'Admin/Config/index', '配置管理', -1, ''),
(173, 'admin', 2, 'Admin/Config/edit', '编辑', -1, ''),
(174, 'admin', 2, 'Admin/Config/del', '删除', -1, ''),
(175, 'admin', 2, 'Admin/Config/add', '新增', -1, ''),
(176, 'admin', 2, 'Admin/Config/save', '保存', -1, ''),
(177, 'admin', 2, 'Admin/Menu/index', '菜单管理', -1, ''),
(178, 'admin', 2, 'Admin/Channel/index', '导航管理', -1, ''),
(179, 'admin', 2, 'Admin/Channel/add', '新增', -1, ''),
(180, 'admin', 2, 'Admin/Channel/edit', '编辑', -1, ''),
(181, 'admin', 2, 'Admin/Channel/del', '删除', -1, ''),
(182, 'admin', 2, 'Admin/Category/index', '分类管理', -1, ''),
(183, 'admin', 2, 'Admin/Category/edit', '编辑', -1, ''),
(184, 'admin', 2, 'Admin/Category/add', '新增', -1, ''),
(185, 'admin', 2, 'Admin/Category/remove', '删除', -1, ''),
(186, 'admin', 2, 'Admin/Category/move', '移动', -1, ''),
(187, 'admin', 2, 'Admin/Category/merge', '合并', -1, ''),
(188, 'admin', 2, 'Admin/Database/index?type=export', '备份数据库', -1, ''),
(189, 'admin', 2, 'Admin/Database/export', '备份', -1, ''),
(190, 'admin', 2, 'Admin/Database/optimize', '优化表', -1, ''),
(191, 'admin', 2, 'Admin/Database/repair', '修复表', -1, ''),
(192, 'admin', 2, 'Admin/Database/index?type=import', '还原数据库', -1, ''),
(193, 'admin', 2, 'Admin/Database/import', '恢复', -1, ''),
(194, 'admin', 2, 'Admin/Database/del', '删除', -1, ''),
(195, 'admin', 2, 'Admin/other', '其他', -1, ''),
(196, 'admin', 2, 'Admin/Menu/add', '新增', -1, ''),
(197, 'admin', 2, 'Admin/Menu/edit', '编辑', -1, ''),
(198, 'admin', 2, 'Admin/Think/lists?model=article', '应用', -1, ''),
(199, 'admin', 2, 'Admin/Think/lists?model=download', '下载管理', -1, ''),
(200, 'admin', 2, 'Admin/Think/lists?model=config', '应用', -1, ''),
(201, 'admin', 2, 'Admin/Action/actionlog', '行为日志', -1, ''),
(202, 'admin', 2, 'Admin/User/updatePassword', '修改密码', -1, ''),
(203, 'admin', 2, 'Admin/User/updateNickname', '修改昵称', -1, ''),
(204, 'admin', 2, 'Admin/action/edit', '查看行为日志', -1, ''),
(206, 'admin', 1, 'Admin/think/edit', '编辑数据', 1, ''),
(207, 'admin', 1, 'Admin/Menu/import', '导入', 1, ''),
(208, 'admin', 1, 'Admin/Model/generate', '生成', -1, ''),
(209, 'admin', 1, 'Admin/Addons/addHook', '新增钩子', 1, ''),
(210, 'admin', 1, 'Admin/Addons/edithook', '编辑钩子', 1, ''),
(211, 'admin', 1, 'Admin/Article/sort', '文档排序', -1, ''),
(212, 'admin', 1, 'Admin/Config/sort', '排序', 1, ''),
(213, 'admin', 1, 'Admin/Menu/sort', '排序', 1, ''),
(214, 'admin', 1, 'Admin/Channel/sort', '排序', 1, ''),
(215, 'admin', 1, 'Admin/Category/operate/type/move', '移动', 1, ''),
(216, 'admin', 1, 'Admin/Category/operate/type/merge', '合并', 1, ''),
(217, 'admin', 1, 'Admin/Forum/forum', '板块管理', -1, ''),
(218, 'admin', 1, 'Admin/Forum/post', '帖子管理', -1, ''),
(219, 'admin', 1, 'Admin/Forum/editForum', '编辑／发表帖子', -1, ''),
(220, 'admin', 1, 'Admin/Forum/editPost', 'edit pots', -1, ''),
(221, 'admin', 2, 'Admin//Admin/Forum/index', '讨论区', -1, ''),
(222, 'admin', 2, 'Admin//Admin/Weibo/index', '微博', -1, ''),
(223, 'admin', 1, 'Admin/Forum/sortForum', '排序', -1, ''),
(224, 'admin', 1, 'Admin/SEO/editRule', '新增、编辑', 1, ''),
(225, 'admin', 1, 'Admin/SEO/sortRule', '排序', 1, ''),
(226, 'admin', 1, 'Admin/SEO/index', '规则管理', 1, ''),
(227, 'admin', 1, 'Admin/Forum/editReply', '新增 编辑', -1, ''),
(228, 'admin', 1, 'Admin/Weibo/editComment', '编辑回复', 1, ''),
(229, 'admin', 1, 'Admin/Weibo/editWeibo', '编辑微博', 1, ''),
(230, 'admin', 1, 'Admin/SEO/ruleTrash', '规则回收站', 1, ''),
(231, 'admin', 1, 'Admin/Rank/userList', '查看用户', 1, ''),
(232, 'admin', 1, 'Admin/Rank/userRankList', '用户头衔列表', 1, ''),
(233, 'admin', 1, 'Admin/Rank/userAddRank', '关联新头衔', 1, ''),
(234, 'admin', 1, 'Admin/Rank/userChangeRank', '编辑头衔关联', 1, ''),
(235, 'admin', 1, 'Admin/Issue/add', '编辑专辑', 1, ''),
(236, 'admin', 1, 'Admin/Issue/issue', '专辑管理', 1, ''),
(237, 'admin', 1, 'Admin/Issue/operate', '专辑操作', 1, ''),
(238, 'admin', 1, 'Admin/Weibo/weibo', '微博管理', 1, ''),
(239, 'admin', 1, 'Admin/Rank/index', '头衔列表', 1, ''),
(240, 'admin', 1, 'Admin/Forum/forumTrash', '板块回收站', -1, ''),
(241, 'admin', 1, 'Admin/Weibo/weiboTrash', '微博回收站', 1, ''),
(242, 'admin', 1, 'Admin/Rank/editRank', '添加头衔', 1, ''),
(243, 'admin', 1, 'Admin/Weibo/comment', '回复管理', 1, ''),
(244, 'admin', 1, 'Admin/Forum/postTrash', '帖子回收站', -1, ''),
(245, 'admin', 1, 'Admin/Weibo/commentTrash', '回复回收站', 1, ''),
(246, 'admin', 1, 'Admin/Issue/issueTrash', '专辑回收站', 1, ''),
(247, 'admin', 1, 'Admin//Admin/Forum/reply', '回复管理', -1, ''),
(248, 'admin', 1, 'Admin/Forum/replyTrash', '回复回收站', -1, ''),
(249, 'admin', 2, 'Admin/Forum/index', '贴吧', -1, ''),
(250, 'admin', 2, 'Admin/Weibo/weibo', '微博', 1, ''),
(251, 'admin', 2, 'Admin/SEO/index', 'SEO', -1, ''),
(252, 'admin', 2, 'Admin/Rank/index', '头衔', -1, ''),
(253, 'admin', 2, 'Admin/Issue/issue', '专辑', 1, ''),
(254, 'admin', 1, 'Admin/Issue/contents', '内容管理', 1, ''),
(255, 'admin', 1, 'Admin/User/profile', '扩展资料', 1, ''),
(256, 'admin', 1, 'Admin/User/editProfile', '添加、编辑分组', 1, ''),
(257, 'admin', 1, 'Admin/User/sortProfile', '分组排序', 1, ''),
(258, 'admin', 1, 'Admin/User/field', '字段列表', 1, ''),
(259, 'admin', 1, 'Admin/User/editFieldSetting', '添加、编辑字段', 1, ''),
(260, 'admin', 1, 'Admin/User/sortField', '字段排序', 1, ''),
(261, 'admin', 1, 'Admin/Update/quick', '全部补丁', 1, ''),
(262, 'admin', 1, 'Admin/Update/addpack', '新增补丁', 1, ''),
(263, 'admin', 1, 'Admin/User/expandinfo_select', '用户扩展资料列表', 1, ''),
(264, 'admin', 1, 'Admin/User/expandinfo_details', '扩展资料详情', 1, ''),
(265, 'admin', 1, 'Admin/Shop/shopLog', '商城信息记录', -1, ''),
(266, 'admin', 1, 'Admin/Shop/setStatus', '商品分类状态设置', -1, ''),
(267, 'admin', 1, 'Admin/Shop/setGoodsStatus', '商品状态设置', -1, ''),
(268, 'admin', 1, 'Admin/Shop/operate', '商品分类操作', -1, ''),
(269, 'admin', 1, 'Admin/Shop/add', '商品分类添加', -1, ''),
(270, 'admin', 1, 'Admin/Shop/goodsEdit', '添加、编辑商品', -1, ''),
(271, 'admin', 1, 'Admin/Shop/hotSellConfig', '热销商品阀值配置', -1, ''),
(272, 'admin', 1, 'Admin/Shop/setNew', '设置新品', -1, ''),
(273, 'admin', 1, 'Admin/EventType/index', '活动分类管理', -1, ''),
(274, 'admin', 1, 'Admin/Event/event', '内容管理', -1, ''),
(275, 'admin', 1, 'Admin/EventType/eventTypeTrash', '活动分类回收站', -1, ''),
(276, 'admin', 1, 'Admin/Event/verify', '内容审核', -1, ''),
(277, 'admin', 1, 'Admin/Event/contentTrash', '内容回收站', -1, ''),
(278, 'admin', 1, 'Admin/Rank/rankVerify', '待审核用户头衔', 1, ''),
(279, 'admin', 1, 'Admin/Rank/rankVerifyFailure', '被驳回的头衔申请', 1, ''),
(280, 'admin', 1, 'Admin/Weibo/config', '微博设置', 1, ''),
(281, 'admin', 1, 'Admin/Issue/verify', '内容审核', 1, ''),
(282, 'admin', 1, 'Admin/Shop/goodsList', '商品列表', -1, ''),
(283, 'admin', 1, 'Admin/Shop/shopCategory', '商品分类配置', -1, ''),
(284, 'admin', 1, 'Admin/Shop/categoryTrash', '商品分类回收站', -1, ''),
(285, 'admin', 1, 'Admin/Shop/verify', '待发货交易', -1, ''),
(286, 'admin', 1, 'Admin/Issue/contentTrash', '内容回收站', 1, ''),
(287, 'admin', 1, 'Admin/Shop/goodsBuySuccess', '交易成功记录', -1, ''),
(288, 'admin', 1, 'Admin/Shop/goodsTrash', '商品回收站', -1, ''),
(289, 'admin', 1, 'Admin/Shop/toxMoneyConfig', '货币配置', -1, ''),
(290, 'admin', 2, 'Admin/Shop/shopCategory', '商城', -1, ''),
(291, 'admin', 2, 'Admin/EventType/index', '活动', -1, ''),
(337, 'Weibo', 1, 'manageTopic', '管理话题', 1, ''),
(297, 'Home', 1, 'deleteLocalComment', '删除本地评论', 1, ''),
(336, 'Weibo', 1, 'beTopicAdmin', '抢先成为话题主持人', 1, ''),
(335, 'Weibo', 1, 'setWeiboTop', '微博置顶', 1, ''),
(334, 'Weibo', 1, 'deleteWeibo', '删除微博', 1, ''),
(333, 'Weibo', 1, 'sendWeibo', '发微博', 1, ''),
(313, 'admin', 1, 'Admin/module/install', '模块安装', 1, ''),
(315, 'admin', 1, 'Admin/module/lists', '模块管理', 1, ''),
(316, 'admin', 1, 'Admin/module/uninstall', '卸载模块', 1, ''),
(317, 'admin', 1, 'Admin/AuthManager/addNode', '新增权限节点', 1, ''),
(318, 'admin', 1, 'Admin/AuthManager/accessUser', '前台权限管理', 1, ''),
(319, 'admin', 1, 'Admin/User/changeGroup', '转移用户组', 1, ''),
(320, 'admin', 1, 'Admin/AuthManager/deleteNode', '删除权限节点', 1, ''),
(321, 'admin', 1, 'Admin/Issue/config', '专辑设置', 1, ''),
(322, 'admin', 2, 'Admin/module/lists', '云平台', 1, ''),
('338', 'admin', '1', 'Admin/UserConfig/index', '用户注册配置', '1', ''),
('339', 'admin', '1', 'Admin/User/scoreList', '积分类型列表', '1', ''),
('340', 'admin', '1', 'Admin/user/editScoreType', '新增/编辑类型', '1', ''),
('341', 'admin', '1', 'Admin/user/recharge', '充值积分', '1', ''),
('342', 'admin', '1', 'Admin/Authorize/ssoSetting', '单点登录配置', '1', ''),
('343', 'admin', '1', 'Admin/Authorize/ssolist', '应用列表', '1', ''),
('344', 'admin', '1', 'Admin/authorize/editssoapp', '新增/编辑应用', '1', ''),
('345', 'admin', '1', 'Admin/ActionLimit/limitList', '行为限制列表', '1', ''),
('346', 'admin', '1', 'Admin/ActionLimit/editLimit', '新增/编辑行为限制', '1', ''),
('347', 'admin', '1', 'Admin/Role/index', '角色列表', '1', ''),
('348', 'admin', '1', 'Admin/Role/editRole', '编辑角色', '1', ''),
('349', 'admin', '1', 'Admin/Role/setStatus', '启用、禁用、删除角色', '1', ''),
('350', 'admin', '1', 'Admin/Role/sort', '角色排序', '1', ''),
('351', 'admin', '1', 'Admin/Role/configScore', '默认积分配置', '1', ''),
('352', 'admin', '1', 'Admin/Role/configAuth', '默认权限配置', '1', ''),
('353', 'admin', '1', 'Admin/Role/configAvatar', '默认头像配置', '1', ''),
('354', 'admin', '1', 'Admin/Role/configRank', '默认头衔配置', '1', ''),
('355', 'admin', '1', 'Admin/Role/configField', '默认字段管理', '1', ''),
('356', 'admin', '1', 'Admin/Role/group', '角色分组', '1', ''),
('357', 'admin', '1', 'Admin/Role/editGroup', '编辑分组', '1', ''),
('358', 'admin', '1', 'Admin/Role/deleteGroup', '删除分组', '1', ''),
('359', 'admin', '1', 'Admin/Role/config', '角色基本信息配置', '1', ''),
('360', 'admin', '1', 'Admin/Role/userList', '用户列表', '1', ''),
('361', 'admin', '1', 'Admin/Role/setUserStatus', '设置用户状态', '1', ''),
('362', 'admin', '1', 'Admin/Role/setUserAudit', '审核用户', '1', ''),
('363', 'admin', '1', 'Admin/Role/changeRole', '迁移用户', '1', ''),
('364', 'admin', '1', 'Admin/Role/uploadPicture', '上传默认头像', '1', ''),
('365', 'admin', '2', 'Admin/authorize/ssoSetting', '授权', '1', ''),
('366', 'admin', '2', 'Admin/Role/index', '角色', '1', ''),
('367', 'admin', '2', 'Admin/ActionLimit/limitList', '安全', '1', ''),
('378', 'admin', '1', 'Admin/Mpbase/del', '删除公众号', '1', ''),
('377', 'admin', '1', 'Admin/Mpbase/delMp', '删除公众号', '-1', ''),
('370', 'admin', '1', 'Admin/Issue/setIssueContentStatus', '设置专辑状态', '-1', ''),
('371', 'admin', '2', 'Admin/Mpbase/index', '基础设置', '1', ''),
('372', 'admin', '1', 'Admin/Mpbase/editMp', '编辑公众号', '-1', ''),
('373', 'admin', '1', 'Admin/Mpbase/index', '公众号管理', '1', ''),
('374', 'admin', '1', 'Admin/Mpbase/config', '管理基本设置', '1', ''),
('375', 'admin', '1', 'Admin/Mpbase/doEditMp', '操作编辑公众号', '-1', ''),
('376', 'admin', '1', 'Admin/Mpbase/edit', '编辑公众号', '1', ''),
('379', 'admin', '1', 'Admin/Mpbase/changePublic', '切换公众号', '-1', ''),
('380', 'admin', '1', 'Admin/Mpbase/change', '切换公众号', '1', ''),
('381', 'admin', '1', 'Admin/Custommenu/operate', '自定义菜单操作', '1', ''),
('382', 'admin', '1', 'Admin/Custommenu/index', '自定义菜单管理', '1', ''),
('383', 'admin', '1', 'Admin/Custommenu/add', '编辑自定义菜单', '1', ''),
('384', 'admin', '1', 'Admin/Keyword/index', '关键词管理', '1', ''),
('385', 'Issue', '1', 'addIssueContent', '专辑投稿权限', '1', ''),
('386', 'Issue', '1', 'editIssueContent', '编辑专辑内容（管理）', '1', ''),
('387', 'admin', '1', 'Admin/Ucuser/index', '微会员信息', '1', ''),
('388', 'admin', '1', 'Admin/Weicja/index', '微场景', '1', ''),
('389', 'admin', '2', 'Admin/Ucuser/index', '微会员', '1', '');

DROP TABLE  IF EXISTS `uctoo_avatar`;
CREATE TABLE IF NOT EXISTS `uctoo_avatar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `path` varchar(200) NOT NULL,
  `create_time` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `is_temp` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


DROP TABLE  IF EXISTS `uctoo_channel`;
CREATE TABLE IF NOT EXISTS `uctoo_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级频道ID',
  `title` char(30) NOT NULL COMMENT '频道标题',
  `url` char(100) NOT NULL COMMENT '频道连接',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '导航排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `target` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '新窗口打开',
  `color` varchar(30) NOT NULL,
  `band_color` varchar(30) NOT NULL,
  `band_text` varchar(30) NOT NULL,
  `icon` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;


INSERT INTO `uctoo_channel` (`id`, `pid`, `title`, `url`, `sort`, `create_time`, `update_time`, `status`, `target`, `color`, `band_color`, `band_text`, `icon`) VALUES
(1, 0, '首页', 'Home/Index/index', 0, 1379475111, 1421055116, 1, 0, '', '', '', 'home'),
(2, 0, '会员展示', 'People/index/index', 3, 1421054845, 1421134856, 1, 0, '', '', '', 'group');

DROP TABLE  IF EXISTS `uctoo_config`;
CREATE TABLE IF NOT EXISTS `uctoo_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text NOT NULL COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=42 ;


INSERT INTO `uctoo_config` (`id`, `name`, `type`, `title`, `group`, `extra`, `remark`, `create_time`, `update_time`, `status`, `value`, `sort`) VALUES
(1, 'WEB_SITE_CLOSE', 4, '关闭站点', 1, '0:关闭,1:开启', '站点关闭后其他用户不能访问，管理员可以正常访问', 1378898976, 1379235296, 1, '1', 1),
(2 ,  'SITE_LOGO',  '7',  '网站LOGO',  '1',  '',  '网站的logo设置，建议尺寸156*50',  '1388332311',  '1388501500',  '1',  '',  '3'),
(3, 'CONFIG_TYPE_LIST', 3, '配置类型列表', 4, '', '主要用于数据解析和页面表单的生成', 1378898976, 1379235348, 1, '0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举', 8),
(4, 'WEB_SITE_ICP', 1, '网站备案号', 1, '', '设置在网站底部显示的备案号，如“沪ICP备12007941号-2', 1378900335, 1379235859, 1, '粤ICP备XX号', 12),
(5, 'CONFIG_GROUP_LIST', 3, '配置分组', 4, '', '配置分组', 1379228036, 1384418383, 1, '1:基本\r\n2:内容\r\n3:用户\r\n4:系统\r\n5:邮件', 15),
(6, 'HOOKS_TYPE', 3, '钩子的类型', 4, '', '类型 1-用于扩展显示内容，2-用于扩展业务处理', 1379313397, 1379313407, 1, '1:视图\r\n2:控制器', 17),
(7, 'AUTH_CONFIG', 3, 'Auth配置', 4, '', '自定义Auth.class.php类配置', 1379409310, 1379409564, 1, 'AUTH_ON:1\r\nAUTH_TYPE:2', 20),
(9, 'LIST_ROWS', 0, '后台每页记录数', 2, '', '后台数据每页显示记录数', 1379503896, 1380427745, 1, '10', 24),
(10, 'USER_ALLOW_REGISTER', 4, '是否允许用户注册', 3, '0:关闭注册\r\n1:允许注册', '是否开放用户注册', 1379504487, 1379504580, 1, '1', 12),
(11, 'CODEMIRROR_THEME', 4, '预览插件的CodeMirror主题', 4, '3024-day:3024 day\r\n3024-night:3024 night\r\nambiance:ambiance\r\nbase16-dark:base16 dark\r\nbase16-light:base16 light\r\nblackboard:blackboard\r\ncobalt:cobalt\r\neclipse:eclipse\r\nelegant:elegant\r\nerlang-dark:erlang-dark\r\nlesser-dark:lesser-dark\r\nmidnight:midnight', '详情见CodeMirror官网', 1379814385, 1384740813, 1, 'ambiance', 13),
(12, 'DATA_BACKUP_PATH', 1, '数据库备份根路径', 4, '', '路径必须以 / 结尾', 1381482411, 1381482411, 1, './Data/', 16),
(13, 'DATA_BACKUP_PART_SIZE', 0, '数据库备份卷大小', 4, '', '该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M', 1381482488, 1381729564, 1, '20971520', 18),
(14, 'DATA_BACKUP_COMPRESS', 4, '数据库备份文件是否启用压缩', 4, '0:不压缩\r\n1:启用压缩', '压缩备份文件需要PHP环境支持gzopen,gzwrite函数', 1381713345, 1381729544, 1, '1', 22),
(15, 'DATA_BACKUP_COMPRESS_LEVEL', 4, '数据库备份文件压缩级别', 4, '1:普通\r\n4:一般\r\n9:最高', '数据库备份文件的压缩级别，该配置在开启压缩时生效', 1381713408, 1381713408, 1, '9', 25),
(16, 'DEVELOP_MODE', 4, '开启开发者模式', 4, '0:关闭\r\n1:开启', '是否开启开发者模式', 1383105995, 1383291877, 1, '1', 26),
(17, 'ALLOW_VISIT', 3, '不受限控制器方法', 0, '', '', 1386644047, 1386644741, 1, '0:article/draftbox\r\n1:article/mydocument\r\n2:Category/tree\r\n3:Index/verify\r\n4:file/upload\r\n5:file/download\r\n6:user/updatePassword\r\n7:user/updateNickname\r\n8:user/submitPassword\r\n9:user/submitNickname\r\n10:file/uploadpicture', 2),
(18, 'DENY_VISIT', 3, '超管专限控制器方法', 0, '', '仅超级管理员可访问的控制器方法', 1386644141, 1386644659, 1, '0:Addons/addhook\r\n1:Addons/edithook\r\n2:Addons/delhook\r\n3:Addons/updateHook\r\n4:Admin/getMenus\r\n5:Admin/recordList\r\n6:AuthManager/updateRules\r\n7:AuthManager/tree', 3),
(19, 'ADMIN_ALLOW_IP', 2, '后台允许访问IP', 4, '', '多个用逗号分隔，如果不配置表示不限制IP访问', 1387165454, 1387165553, 1, '', 27),
(20, 'SHOW_PAGE_TRACE', 4, '是否显示页面Trace', 4, '0:关闭\r\n1:开启', '是否显示页面Trace信息', 1387165685, 1387165685, 1, '0', 7),
(21, 'WEB_SITE', 1, '网站名称', 1, '', '用于邮件,短信,站内信显示', 1388332311, 1388501500, 1, 'UCToo开源微信应用开发平台', 3),
(22, 'MAIL_TYPE', 4, '邮件类型', 5, '1:SMTP 模块发送\r\n2:mail() 函数发送', '如果您选择了采用服务器内置的 Mail 服务，您不需要填写下面的内容', 1388332882, 1388931416, 1, '1', 0),
(23, 'MAIL_SMTP_HOST', 1, 'SMTP 服务器', 5, '', 'SMTP服务器', 1388332932, 1388332932, 1, '', 0),
(24, 'MAIL_SMTP_PORT', 0, 'SMTP服务器端口', 5, '', '默认25', 1388332975, 1388332975, 1, '25', 0),
(25, 'MAIL_SMTP_USER', 1, 'SMTP服务器用户名', 5, '', '填写完整用户名', 1388333010, 1388333010, 1, '', 0),
(26, 'MAIL_SMTP_PASS', 6, 'SMTP服务器密码', 5, '', '填写您的密码', 1388333057, 1389187088, 1, '', 0),
(27, 'MAIL_USER_PASS', 5, '密码找回模板', 0, '', '支持HTML代码', 1388583989, 1388672614, 1, '密码找回111223333555111', 0),
(28, 'PIC_FILE_PATH', 1, '图片文件保存根目录', 4, '', '图片文件保存根目录./目录/', 1388673255, 1388673255, 1, './Uploads/', 0),
(29, 'COUNT_DAY', 0, '后台首页统计用户增长天数', 0, '', '默认统计最近半个月的用户数增长情况', 1420791945, 1420876261, 1, '15', 0),
(30, 'MAIL_USER_REG', 5, '注册邮件模板', 3, '', '支持HTML代码', 1388337307, 1389532335, 1, '<a href="http://3spp.cn" target="_blank">点击进入</a><span style="color:#E53333;">当您收到这封邮件，表明您已注册成功，以上为您的用户名和密码。。。。祝您生活愉快····</span>', 55),
(31, 'USER_NAME_BAOLIU', 1, '保留用户名', 3, '', '禁止注册用户名,用" , "号隔开', 1388845937, 1388845937, 1, '管理员,测试,admin,垃圾', 0),
(33, 'VERIFY_OPEN', 8, '验证码配置', 4, 'reg:注册显示\r\nlogin:登陆显示\r\nreset:找回密码', '验证码配置', 1388500332, 1405561711, 1, '', 0),
(34, 'VERIFY_TYPE', 4, '验证码类型', 4, '1:中文\r\n2:英文\r\n3:数字\r\n4:英文+数字', '验证码类型', 1388500873, 1405561731, 1, '4', 0),
(35, 'NO_BODY_TLE', 2, '空白说明', 2, '', '空白说明', 1392216444, 1392981305, 1, '呵呵，暂时没有内容哦！！', 0),
(36, 'USER_RESPASS', 5, '密码找回模板', 3, '', '密码找回文本', 1396191234, 1396191234, 1, '<span style="color:#009900;">请点击以下链接找回密码，如无反应，请将链接地址复制到浏览器中打开(下次登录前有效)</span>', 0),
(37, 'COUNT_CODE', 2, '统计代码', 1, '', '用于统计网站访问量的第三方代码，推荐CNZZ统计', 1403058890, 1403058890, 1, '', 4),
(38, 'AFTER_LOGIN_JUMP_URL', 2, '登陆后跳转的Url', 1, '', '支持形如weibo/index/index的ThinkPhp路由写法，支持普通的url写法', 1407145718, 1407154887, 1, 'Home/index/index', 7),
(40, 'URL_MODEL', 4, 'URL模式', 4, '1:PATHINFO模式\r\n2:REWRITE模式(开启伪静态)\r\n3:兼容模式', '选择Rewrite模式则开启伪静态，默认建议开启兼容模式', 1421027546, 1421027676, 1, '3', 0),
(41, 'DEFUALT_HOME_URL', 1, '默认首页Url', 1, '', '支持形如weibo/index/index的ThinkPhp路由写法，支持普通的url写法，不填则显示默认聚合首页', 1417509438, 1417509501, 1, '', 0),
(39, 'MAIL_SMTP_SECURE', 1, 'SMTP安全协议', 5, '', '不填写不使用安全协议，可填写ssl和tls两种安全协议。', 1426735670, 1426735709, 1, 'ssl', '6'),
(42, '_USERCONFIG_REG_SWITCH', 0, '', 0, '', '', 1427094903, 1427094903, 1, 'username', 0);

--
-- 表的结构 `uctoo_custom_menu`
--
CREATE TABLE IF NOT EXISTS `uctoo_custom_menu` (
`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
`sort`  tinyint(4) NULL   DEFAULT 0 COMMENT '排序号',
`pid`  int(10) NULL  DEFAULT 0 COMMENT '一级菜单',
`title`  varchar(50) NOT NULL  COMMENT '菜单名',
`keyword`  varchar(100) NULL  COMMENT '关联关键词',
`url`  varchar(255) NULL   COMMENT '关联URL',
`token`  varchar(255) NOT NULL  COMMENT 'Token',
`type`  varchar(30) NOT NULL  DEFAULT 'click' COMMENT '类型',
`status` tinyint(11) NOT NULL,
PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci CHECKSUM=0 ROW_FORMAT=DYNAMIC DELAY_KEY_WRITE=0;


DROP TABLE  IF EXISTS `uctoo_field`;
CREATE TABLE IF NOT EXISTS `uctoo_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` INT( 11 ) NOT NULL ,
  `uid` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `field_data` varchar(1000) NOT NULL,
  `createTime` int(11) NOT NULL,
  `changeTime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


DROP TABLE  IF EXISTS `uctoo_field_group`;
CREATE TABLE IF NOT EXISTS `uctoo_field_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_name` varchar(25) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `createTime` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  `visiable` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

INSERT INTO `uctoo_field_group` (`id`, `profile_name`, `status`, `createTime`, `sort`, `visiable`) VALUES
(1, '个人资料', 1, 1403847366, 0, 1),
(2, '开发者资料', 1, 1423537648, 0, 0),
(3, '开源中国资料', 1, 1423538446, 0, 0);

DROP TABLE  IF EXISTS `uctoo_field_setting`;
CREATE TABLE IF NOT EXISTS `uctoo_field_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field_name` varchar(25) NOT NULL,
  `profile_group_id` int(11) NOT NULL,
  `visiable` tinyint(4) NOT NULL DEFAULT '1',
  `required` tinyint(4) NOT NULL DEFAULT '0',
  `sort` int(11) NOT NULL,
  `form_type` varchar(25) NOT NULL,
  `form_default_value` varchar(200) NOT NULL,
  `validation` varchar(25) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `createTime` int(11) NOT NULL,
  `child_form_type` varchar(25) NOT NULL,
  `input_tips` varchar(100) NOT NULL COMMENT '输入提示',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

INSERT INTO `uctoo_field_setting` (`id`, `field_name`, `profile_group_id`, `visiable`, `required`, `sort`, `form_type`, `form_default_value`, `validation`, `status`, `createTime`, `child_form_type`, `input_tips`) VALUES
(1, 'qq', 1, 1, 1, 0, 'input', '', '', 1, 1409045825, 'string', ''),
(2, '生日', 1, 1, 1, 0, 'time', '', '', 1, 1423537409, '', ''),
(3, '擅长语言', 2, 1, 1, 0, 'select', 'Java|C++|Python|php|object c|ruby', '', 1, 1423537693, '', ''),
(4, '承接项目', 2, 1, 1, 0, 'radio', '是|否', '', 1, 1423537733, '', ''),
(5, '简介', 2, 1, 1, 0, 'textarea', '', '', 1, 1423537770, '', '简单介绍入行以来的工作经验，项目经验'),
(6, '其他技能', 2, 1, 1, 0, 'checkbox', 'PhotoShop|Flash', '', 1, 1423537834, '', ''),
(7, '昵称', 3, 1, 1, 0, 'input', '', '', 1, 1423704462, 'string', 'OSC账号昵称');


DROP TABLE  IF EXISTS `uctoo_file`;
CREATE TABLE IF NOT EXISTS `uctoo_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` char(20) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` char(30) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(5) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(40) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `location` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文件保存位置',
  `create_time` int(10) unsigned NOT NULL COMMENT '上传时间',
  `driver` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_md5` (`md5`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='文件表' AUTO_INCREMENT=1 ;

DROP TABLE  IF EXISTS `uctoo_follow`;
CREATE TABLE IF NOT EXISTS `uctoo_follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `follow_who` int(11) NOT NULL COMMENT '关注谁',
  `who_follow` int(11) NOT NULL COMMENT '谁关注',
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='关注表' AUTO_INCREMENT=1 ;



DROP TABLE  IF EXISTS `uctoo_hooks`;
CREATE TABLE IF NOT EXISTS `uctoo_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text NOT NULL COMMENT '描述',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `addons` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子挂载的插件 ''，''分割',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=38 ;

INSERT INTO `uctoo_hooks` (`name`, `description`, `type`, `update_time`, `addons`) VALUES
( 'pageHeader', '页面header钩子，一般用于加载插件CSS文件和代码', 1, 0, ''),
( 'pageFooter', '页面footer钩子，一般用于加载插件JS文件和JS代码', 1, 0, 'SuperLinks'),
( 'adminEditor', '后台内容编辑页编辑器', 1, 1378982734, 'EditorForAdmin'),
( 'AdminIndex', '首页小格子个性化显示', 1, 1382596073, 'SiteStat,SyncLogin,DevTeam,SystemInfo'),
( 'topicComment', '评论提交方式扩展钩子。', 1, 1380163518, ''),
( 'app_begin', '应用开始', 2, 1384481614, 'Iswaf'),
( 'checkIn', '签到', 1, 1395371353, ''),
( 'Rank', '签到排名钩子', 1, 1395387442, 'Rank_checkin'),
( 'support', '赞', 1, 1398264759, ''),
( 'localComment', '本地评论插件', 1, 1399440321, 'LocalComment'),
( 'weiboType', '微博类型', 1, 1409121894, ''),
( 'repost', '转发钩子', 1, 1403668286, ''),
( 'syncLogin', '第三方登陆位置', 1, 1403700579, 'SyncLogin'),
( 'syncMeta', '第三方登陆meta接口', 1, 1403700633, 'SyncLogin'),
( 'J_China_City', '每个系统都需要的一个中国省市区三级联动插件。', 1, 1403841931, 'ChinaCity'),
( 'Advs', '广告位插件', 1, 1406687667, ''),
( 'imageSlider', '图片轮播钩子', 1, 1407144022, ''),
( 'friendLink', '友情链接插件', 1, 1407156413, 'SuperLinks'),
( 'beforeSendWeibo', '在发微博之前预处理微博', 2, 1408084504, 'InsertFile'),
( 'beforeSendRepost', '转发微博前的预处理钩子', 2, 1408085689, ''),
( 'parseWeiboContent', '解析微博内容钩子', 2, 1409121261, ''),
( 'userConfig', '用户配置页面钩子', 1, 1417137557, 'SyncLogin'),
( 'weiboSide', '微博侧边钩子', 1, 1417063425, 'Retopic'),
( 'personalMenus', '顶部导航栏个人下拉菜单', 1, 1417146501, ''),
( 'dealPicture', '上传图片处理', 2, 1417139975, ''),
( 'ucenterSideMenu', '用户中心左侧菜单', 1, 1417161205, ''),
( 'weixin', '微信插件默认处理的钩子', '2', '1428547125', ''),
( 'keyword', '关键词', '2', '1430792771', 'Keyword'),
( 'init_ucuser', '初始化粉丝信息', '2', '1430793836', 'Ucuser'),
( 'afterTop', '顶部导航之后的钩子，调用公告等', 1, 1429671392, '');

DROP TABLE  IF EXISTS `uctoo_local_comment`;
CREATE TABLE IF NOT EXISTS `uctoo_local_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `app` text NOT NULL,
  `mod` text NOT NULL,
  `row_id` int(11) NOT NULL,
  `parse` int(11) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `create_time` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


-- ----------------------------
-- Table structure for uctoo_keyword
-- ----------------------------
DROP TABLE IF EXISTS `uctoo_keyword`;
CREATE TABLE `uctoo_keyword` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mp_id` int(10) NOT NULL COMMENT '公众号ID',
  `keyword` varchar(100) NOT NULL COMMENT '关键词',
  `token` varchar(100) NOT NULL COMMENT 'Token',
  `addon` varchar(255) NOT NULL COMMENT '关键词所属插件',
  `model` varchar(100) NOT NULL COMMENT '数据模型',
  `aim_id` int(10) unsigned NOT NULL COMMENT '插件表里的ID值',
  `cover` int(10) unsigned NOT NULL COMMENT '封面图片',
  `url` varchar(255) DEFAULT NULL COMMENT '跳转url',
  `cTime` int(10) NOT NULL COMMENT '创建时间',
  `keyword_length` int(10) unsigned DEFAULT '0' COMMENT '关键词长度',
  `keyword_type` tinyint(2) DEFAULT '0' COMMENT '匹配类型',
  `extra_text` text COMMENT '文本扩展',
  `extra_int` int(10) DEFAULT NULL COMMENT '数字扩展',
  `request_count` int(10) NOT NULL DEFAULT '0' COMMENT '请求数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `keyword_public` (`keyword`,`mp_id`)
) ENGINE=MyISAM AUTO_INCREMENT=457 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uctoo_keyword
-- ----------------------------
INSERT INTO `uctoo_keyword` VALUES ('514', '107', '微场景', 'gh_1dd1d1321b7c', 'Weicj', 'Weicj', '3', '1425366290', '4', '0', 'custom_reply_news', '0', '0');
INSERT INTO `uctoo_keyword` VALUES ('516', '107', 'jssdk', 'gh_1dd1d1321b7c', 'Jssdk', '', '0', '1425366959', '36', '0', 'custom_reply_news', '0', '0');
INSERT INTO `uctoo_keyword` VALUES ('517', '107', '微会员', 'gh_1dd1d1321b7c', 'Ucuser', '', '0', '1425368595', '9', '0', '', '0', '0');
INSERT INTO `uctoo_keyword` VALUES ('520', '107', '123', 'gh_1dd1d1321b7c', 'Welcome', 'CustomReply', '3', '0', '0', '0', null, null, '0');


DROP TABLE  IF EXISTS `uctoo_member`;
CREATE TABLE IF NOT EXISTS `uctoo_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `nickname` char(32) NOT NULL DEFAULT '' COMMENT '昵称',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日',
  `qq` char(10) NOT NULL DEFAULT '' COMMENT 'qq号',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员状态',
  `last_login_role` int( 11 ) NOT NULL,
  `show_role` int( 11 ) NOT NULL COMMENT  '个人主页显示角色',
  `signature` text NOT NULL,
  `pos_province` int(11) NOT NULL,
  `pos_city` int(11) NOT NULL,
  `pos_district` int(11) NOT NULL,
  `pos_community` int(11) NOT NULL,
  `token` varchar(200) DEFAULT NULL COMMENT '当前登录公众号',
  `score1` float DEFAULT '0' COMMENT '用户积分',
  `score2` float DEFAULT '0' COMMENT 'score2',
  `score3` float DEFAULT '0' COMMENT 'score3',
  `score4` float DEFAULT '0' COMMENT 'score4',
  PRIMARY KEY (`uid`),
  KEY `status` (`status`),
  KEY `name` (`nickname`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='会员表' AUTO_INCREMENT=100 ;

DROP TABLE IF EXISTS `uctoo_member_public`;
CREATE TABLE `uctoo_member_public` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(10) NOT NULL COMMENT '用户ID',
  `public_name` varchar(50) NOT NULL COMMENT '公众号名称',
  `public_id` varchar(100) NOT NULL COMMENT '公众号原始id',
  `wechat` varchar(100) NOT NULL COMMENT '微信号',
  `interface_url` varchar(255) NOT NULL COMMENT '接口地址',
  `headface_url` varchar(255) NOT NULL COMMENT '公众号头像',
  `area` varchar(50) NOT NULL COMMENT '地区',
  `addon_config` text NOT NULL COMMENT '插件配置',
  `addon_status` text NOT NULL COMMENT '插件状态',
  `token` varchar(100) NOT NULL COMMENT 'Token',
  `type` char(10) NOT NULL DEFAULT '0' COMMENT '公众号类型',
  `appid` varchar(255) NOT NULL COMMENT 'AppID',
  `secret` varchar(255) NOT NULL COMMENT 'AppSecret',
  `status` tinyint(4) NOT NULL COMMENT '2：未审核，1:启用，0：禁用，-1：删除',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '等级',
  `encodingaeskey` varchar(255) NOT NULL COMMENT 'EncodingAESKey',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=107 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uctoo_member_public
-- ----------------------------
INSERT INTO `uctoo_member_public` VALUES ('107', '1', 'UCToo', 'gh_1dd1d1321b7c', 'UCToo_com', '', '', '', '', '', '', '3', '', '', '1', '0', '');

DROP TABLE  IF EXISTS `uctoo_menu`;
CREATE TABLE IF NOT EXISTS `uctoo_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  `icon` varchar(20) NOT NULL COMMENT '导航图标',
  `module` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=116 ;

INSERT INTO `uctoo_menu` (`id`, `title`, `pid`, `sort`, `url`, `hide`, `tip`, `group`, `is_dev`, `icon`) VALUES
(1, '首页', 0, 1, 'Index/index', 0, '', '', 0, 'home'),
(2, '用户', 0, 2, 'User/index', 0, '', '', 0, 'user'),
(3, '用户信息', 2, 0, 'User/index', 0, '', '用户管理', 0, ''),
(4, '用户行为', 2, 0, 'User/action', 0, '', '行为管理', 0, ''),
(5, '新增用户行为', 4, 0, 'User/addaction', 0, '', '', 0, ''),
(6, '编辑用户行为', 4, 0, 'User/editaction', 0, '', '', 0, ''),
(7, '保存用户行为', 4, 0, 'User/saveAction', 0, '"用户->用户行为"保存编辑和新增的用户行为', '', 0, ''),
(8, '变更行为状态', 4, 0, 'User/setStatus', 0, '"用户->用户行为"中的启用,禁用和删除权限', '', 0, ''),
(9, '禁用会员', 4, 0, 'User/changeStatus?method=forbidUser', 0, '"用户->用户信息"中的禁用', '', 0, ''),
(10, '启用会员', 4, 0, 'User/changeStatus?method=resumeUser', 0, '"用户->用户信息"中的启用', '', 0, ''),
(11, '删除会员', 4, 0, 'User/changeStatus?method=deleteUser', 0, '"用户->用户信息"中的删除', '', 0, ''),
(12, '权限管理', 2, 0, 'AuthManager/index', 0, '', '权限管理', 0, ''),
(13, '删除', 12, 0, 'AuthManager/changeStatus?method=deleteGroup', 0, '删除用户组', '', 0, ''),
(14, '禁用', 12, 0, 'AuthManager/changeStatus?method=forbidGroup', 0, '禁用用户组', '', 0, ''),
(15, '恢复', 12, 0, 'AuthManager/changeStatus?method=resumeGroup', 0, '恢复已禁用的用户组', '', 0, ''),
(16, '新增', 12, 0, 'AuthManager/createGroup', 0, '创建新的用户组', '', 0, ''),
(17, '编辑', 12, 0, 'AuthManager/editGroup', 0, '编辑用户组名称和描述', '', 0, ''),
(18, '保存用户组', 12, 0, 'AuthManager/writeGroup', 0, '新增和编辑用户组的"保存"按钮', '', 0, ''),
(19, '授权', 12, 0, 'AuthManager/group', 0, '"后台 \\ 用户 \\ 用户信息"列表页的"授权"操作按钮,用于设置用户所属用户组', '', 0, ''),
(20, '访问授权', 12, 0, 'AuthManager/access', 0, '"后台 \\ 用户 \\ 权限管理"列表页的"访问授权"操作按钮', '', 0, ''),
(21, '成员授权', 12, 0, 'AuthManager/user', 0, '"后台 \\ 用户 \\ 权限管理"列表页的"成员授权"操作按钮', '', 0, ''),
(22, '解除授权', 12, 0, 'AuthManager/removeFromGroup', 0, '"成员授权"列表页内的解除授权操作按钮', '', 0, ''),
(23, '保存成员授权', 12, 0, 'AuthManager/addToGroup', 0, '"用户信息"列表页"授权"时的"保存"按钮和"成员授权"里右上角的"添加"按钮)', '', 0, ''),
(24, '分类授权', 12, 0, 'AuthManager/category', 0, '"后台 \\ 用户 \\ 权限管理"列表页的"分类授权"操作按钮', '', 0, ''),
(25, '保存分类授权', 12, 0, 'AuthManager/addToCategory', 0, '"分类授权"页面的"保存"按钮', '', 0, ''),
(26, '模型授权', 12, 0, 'AuthManager/modelauth', 0, '"后台 \\ 用户 \\ 权限管理"列表页的"模型授权"操作按钮', '', 0, ''),
(27, '保存模型授权', 12, 0, 'AuthManager/addToModel', 0, '"分类授权"页面的"保存"按钮', '', 0, ''),
(28, '新增权限节点', 12, 0, 'AuthManager/addNode', 1, '', '', 1, ''),
(29, '前台权限管理', 12, 0, 'AuthManager/accessUser', 1, '', '权限管理', 0, ''),
(30, '删除权限节点', 12, 0, 'AuthManager/deleteNode', 1, '', '', 0, ''),
(31, '行为日志', 2, 0, 'Action/actionlog', 0, '', '行为管理', 0, ''),
(32, '查看行为日志', 31, 0, 'action/edit', 1, '', '', 0, ''),
(33, '修改密码', 2, 0, 'User/updatePassword', 1, '', '', 0, ''),
(34, '修改昵称', 2, 0, 'User/updateNickname', 1, '', '', 0, ''),
(35, '查看用户', 2, 0, 'Rank/userList', 0, '', '头衔管理', 0, ''),
(36, '用户头衔列表', 35, 0, 'Rank/userRankList', 1, '', '', 0, ''),
(37, '关联新头衔', 35, 0, 'Rank/userAddRank', 1, '', '', 0, ''),
(38, '编辑头衔关联', 35, 0, 'Rank/userChangeRank', 1, '', '', 0, ''),
(39, '扩展资料', 2, 0, 'Admin/User/profile', 0, '', '用户管理', 0, ''),
(40, '添加、编辑分组', 39, 0, 'Admin/User/editProfile', 0, '', '', 0, ''),
(41, '分组排序', 39, 0, 'Admin/User/sortProfile', 0, '', '', 0, ''),
(42, '字段列表', 39, 0, 'Admin/User/field', 0, '', '', 0, ''),
(43, '添加、编辑字段', 39, 0, 'Admin/User/editFieldSetting', 0, '', '', 0, ''),
(44, '字段排序', 39, 0, 'Admin/User/sortField', 0, '', '', 0, ''),
(45, '用户扩展资料列表', 2, 0, 'Admin/User/expandinfo_select', 0, '', '用户管理', 0, ''),
(46, '扩展资料详情', 45, 0, 'User/expandinfo_details', 0, '', '', 0, ''),
(47, '待审核用户头衔', 2, 0, 'Rank/rankVerify', 0, '', '头衔管理', 0, ''),
(48, '被驳回的头衔申请', 2, 0, 'Rank/rankVerifyFailure', 0, '', '头衔管理', 0, ''),
(49, '转移用户组', 2, 0, 'User/changeGroup', 1, '批量转移用户组', '', 0, ''),
(50, '用户注册配置', 2, 0, 'UserConfig/index', 0, '', '注册配置', 0, ''),
(51, '积分类型列表', 2, 0, 'User/scoreList', 0, '', '行为管理', 0, ''),
(52, '新增/编辑类型', 2, 0, 'user/editScoreType', 1, '', '行为管理', 0, ''),
(53, '充值积分', 2, 0, 'user/recharge', 1, '', '', 0, '用户管理'),
(54, '头衔列表', 2, 10, 'Rank/index', 0, '', '头衔管理', 0, ''),
(55, '添加头衔', 2, 2, 'Rank/editRank', 1, '', '头衔管理', 0, ''),
(56, '插件', 0, 5, 'Addons/index', 0, '', '', 0, 'cogs'),
(57, '插件管理', 56, 1, 'Addons/index', 0, '', '扩展', 0, ''),
(58, '钩子管理', 56, 2, 'Addons/hooks', 0, '', '扩展', 0, ''),
(59, '创建', 57, 0, 'Addons/create', 0, '服务器上创建插件结构向导', '', 0, ''),
(60, '检测创建', 57, 0, 'Addons/checkForm', 0, '检测插件是否可以创建', '', 0, ''),
(61, '预览', 57, 0, 'Addons/preview', 0, '预览插件定义类文件', '', 0, ''),
(62, '快速生成插件', 57, 0, 'Addons/build', 0, '开始生成插件结构', '', 0, ''),
(64, '设置', 57, 0, 'Addons/config', 0, '设置插件配置', '', 0, ''),
(65, '禁用', 57, 0, 'Addons/disable', 0, '禁用插件', '', 0, ''),
(66, '启用', 57, 0, 'Addons/enable', 0, '启用插件', '', 0, ''),
(67, '安装', 57, 0, 'Addons/install', 0, '安装插件', '', 0, ''),
(68, '卸载', 57, 0, 'Addons/uninstall', 0, '卸载插件', '', 0, ''),
(69, '更新配置', 57, 0, 'Addons/saveconfig', 0, '更新插件配置处理', '', 0, ''),
(70, '插件后台列表', 57, 0, 'Addons/adminList', 0, '', '', 0, ''),
(71, 'URL方式访问插件', 57, 0, 'Addons/execute', 0, '控制是否有权限通过url访问插件控制器方法', '', 0, ''),
(72, '新增钩子', 58, 0, 'Addons/addHook', 0, '', '', 0, ''),
(73, '编辑钩子', 58, 0, 'Addons/edithook', 0, '', '', 0, ''),
(74, '系统', 0, 6, 'Config/group', 0, '', '', 0, 'windows'),
(75, '网站设置', 74, 1, 'Config/group', 0, '', '系统设置', 0, ''),
(76, '配置管理', 74, 4, 'Config/index', 0, '', '系统设置', 0, ''),
(77, '编辑', 76, 0, 'Config/edit', 0, '新增编辑和保存配置', '', 0, ''),
(78, '删除', 76, 0, 'Config/del', 0, '删除配置', '', 0, ''),
(79, '新增', 76, 0, 'Config/add', 0, '新增配置', '', 0, ''),
(80, '保存', 76, 0, 'Config/save', 0, '保存配置', '', 0, ''),
(81, '排序', 76, 0, 'Config/sort', 1, '', '', 0, ''),
(82, '菜单管理', 2, 5, 'Menu/index', 0, '', '权限管理', 0, ''),
(83, '新增', 82, 0, 'Menu/add', 0, '', '系统设置', 0, ''),
(84, '编辑', 82, 0, 'Menu/edit', 0, '', '', 0, ''),
(85, '导入', 82, 0, 'Menu/import', 0, '', '', 0, ''),
(86, '排序', 82, 0, 'Menu/sort', 1, '', '', 0, ''),
(87, '导航管理', 74, 6, 'Channel/index', 0, '', '系统设置', 0, ''),
(88, '新增', 87, 0, 'Channel/add', 0, '', '', 0, ''),
(89, '编辑', 87, 0, 'Channel/edit', 0, '', '', 0, ''),
(90, '删除', 87, 0, 'Channel/del', 0, '', '', 0, ''),
(91, '排序', 87, 0, 'Channel/sort', 1, '', '', 0, ''),
(92, '备份数据库', 74, 20, 'Database/index?type=export', 0, '', '数据备份', 0, ''),
(93, '备份', 92, 0, 'Database/export', 0, '备份数据库', '', 0, ''),
(94, '优化表', 92, 0, 'Database/optimize', 0, '优化数据表', '', 0, ''),
(95, '修复表', 92, 0, 'Database/repair', 0, '修复数据表', '', 0, ''),
(96, '还原数据库', 74, 0, 'Database/index?type=import', 0, '', '数据备份', 0, ''),
(97, '恢复', 96, 0, 'Database/import', 0, '数据库恢复', '', 0, ''),
(98, '删除', 96, 0, 'Database/del', 0, '删除备份文件', '', 0, ''),
(99, 'SEO规则管理', 74, 0, 'SEO/index', 0, '', 'SEO规则', 0, ''),
(100, '新增、编辑', 99, 0, 'SEO/editRule', 0, '', '', 0, ''),
(101, '排序', 99, 0, 'SEO/sortRule', 1, '', '', 0, ''),
(102, 'SEO规则回收站', 74, 0, 'SEO/ruleTrash', 0, '', 'SEO规则', 0, ''),
(103, '全部补丁', 74, 0, 'Admin/Update/quick', 0, '', '升级补丁', 0, ''),
(104, '新增补丁', 74, 0, 'Admin/Update/addpack', 1, '', '升级补丁', 0, ''),
(105, '云市场', 0, 5, 'module/lists', 1, '', '', 0, 'cloud'),
(106, '模块安装', 105, 0, 'module/install', 1, '', '云市场', 0, ''),
(107, '模块管理', 105, 0, 'module/lists', 0, '', '云市场', 0, ''),
(108, '卸载模块', 105, 0, 'module/uninstall', 1, '', '云市场', 0, ''),
(109, '授权', 0, 3, 'authorize/ssoSetting', 0, '', '', 0, 'lock'),
(110, '单点登录配置', 109, 0, 'Authorize/ssoSetting', 0, '', '单点登录', 0, ''),
(111, '应用列表', 109, 0, 'Authorize/ssolist', 0, '', '单点登录', 0, ''),
(112, '新增/编辑应用', 109, 0, 'authorize/editssoapp', 1, '', '单点登录', 0, ''),
(113, '安全', 0, 4, 'ActionLimit/limitList', 0, '', '', 0, 'shield'),
(114, '行为限制列表', 113, 0, 'ActionLimit/limitList', 0, '', '行为限制', 0, ''),
(115, '新增/编辑行为限制', 113, 0, 'ActionLimit/editLimit', 1, '', '行为限制', 0, ''),
(116, '角色', 0, 3, 'Role/index', 0, '', '', 0, 'group'),
(117, '角色列表', 116, 0, 'Role/index', 0, '', '角色管理', 0, ''),
(118, '编辑角色', 116, 0, 'Role/editRole', 1, '', '', 0, ''),
(119, '启用、禁用、删除角色', 116, 0, 'Role/setStatus', 1, '', '', 0, ''),
(120, '角色排序', 116, 0, 'Role/sort', 1, '', '', 0, ''),
(121, '默认积分配置', 117, 0, 'Role/configScore', 1, '', '', 0, ''),
(122, '默认权限配置', 117, 0, 'Role/configAuth', 1, '', '', 0, ''),
(123, '默认头像配置', 117, 0, 'Role/configAvatar', 1, '', '', 0, ''),
(124, '默认头衔配置', 117, 0, 'Role/configRank', 1, '', '', 0, ''),
(125, '默认字段管理', 117, 0, 'Role/configField', 1, '', '', 0, ''),
(126, '角色分组', 116, 0, 'Role/group', 0, '', '角色管理', 0, ''),
(127, '编辑分组', 126, 0, 'Role/editGroup', 1, '', '', 0, ''),
(128, '删除分组', 126, 0, 'Role/deleteGroup', 1, '', '', 0, ''),
(129, '角色基本信息配置', 116, 0, 'Role/config', 1, '', '角色管理', 0, ''),
(130, '用户列表', 116, 0, 'Role/userList', 0, '', '角色用户管理', 0, ''),
(131, '设置用户状态', 130, 0, 'Role/setUserStatus', 1, '', '', 0, ''),
(132, '审核用户', 130, 0, 'Role/setUserAudit', 1, '', '', 0, ''),
(133, '迁移用户', 130, 0, 'Role/changeRole', 1, '', '', 0, ''),
(134, '上传默认头像', 123, 0, 'Role/uploadPicture', 1, '', '', 0, ''),
(135, '基础设置', 0, 0, 'Mpbase/index', 1, '', '', 0, ''),
(136, '编辑公众号', 135, 0, 'Mpbase/editMp', 1, '', '公众号', 0, ''),
(137, '公众号管理', 135, 0, 'Mpbase/index', 0, '', '公众号', 0, ''),
(138, '管理基本设置', 135, 0, 'Mpbase/config', 0, '', '公众号', 0, ''),
(139, '编辑自定义菜单', 135, 0, 'Admin/Custommenu/add', 1, '', '公众号', 0, ''),
(140, '自定义菜单管理', 135, 0, 'Admin/Custommenu/index', 0, '', '公众号', 0, ''),
(141, '自定义菜单操作', 135, 0, 'Admin/Custommenu/operate', 1, '', '公众号', 0, ''),
(142, '关键词管理', 135, 3, 'Keyword/index', 0, '', '公众号', 0, ''),
(143, '切换公众号', '135', '0', 'Mpbase/change', '1', '', '公众号', '0', ''),
(144, '删除公众号', '135', '0', 'Mpbase/del', '1', '', '公众号', '0', ''),
(145, '微场景', '135', '4', 'Admin/Weicja/index', '0', '', '公众号', '0', ''),
(146, '微会员', '0', '10', 'Ucuser/index', '1', '', '', '0', ''),
(147, '微会员信息', '146', '0', 'Ucuser/index', '0', '', '微会员管理', '0', ''),
(148, '类型管理', 116, 0, 'Invite/index', 0, '', '邀请注册管理', 0, ''),
(149, '邀请码管理', 116, 0, 'Invite/invite', 0, '', '邀请注册管理', 0, ''),
(150, '基础配置', 116, 0, 'Invite/config', 0, '', '邀请注册管理', 0, ''),
(151, '兑换记录', 116, 0, 'Invite/buyLog', 0, '', '邀请注册管理', 0, ''),
(152, '邀请记录', 116, 0, 'Invite/inviteLog', 0, '', '邀请注册管理', 0, ''),
(153, '用户信息', 116, 0, 'Invite/userInfo', 0, '', '邀请注册管理', 0, ''),
(154, '编辑邀请注册类型', 148, 0, 'Invite/edit', 1, '', '', 0, ''),
(155, '删除邀请', 148, 0, 'Invite/setStatus', 1, '', '', 0, ''),
(156, '删除邀请码', 149, 0, 'Invite/delete', 1, '', '', 0, ''),
(157, '生成邀请码', 149, 0, 'Invite/createCode', 1, '', '', 0, ''),
(158, '删除无用邀请码', 149, 0, 'Invite/deleteTrue', 1, '', '', 0, ''),
(159, '导出cvs', 149, 0, 'Invite/cvs', 1, '', '', 0, ''),
(160, '用户信息编辑', 153, 0, 'Invite/editUserInfo', 1, '', '', 0, ''),
(161, '删除日志', 31, 0, 'Action/remove', 1, '', '', 0, ''),
(162, '清空日志', 31, 0, 'Action/clear', 1, '', '', 0, ''),
(163, '设置积分状态', 51, 0, 'User/setTypeStatus', 1, '', '', 0, ''),
(164, '删除积分类型', 51, 0, 'User/delType', 1, '', '', 0, ''),
(165, '充值积分', 53, 0, 'User/getNickname', 1, '', '', 0, ''),
(166, '删除菜单', 82, 0, 'Menu/del', 1, '', '', 0, ''),
(167, '设置开发者模式可见', 82, 0, 'Menu/toogleDev', 1, '', '', 0, ''),
(168, '设置显示隐藏', 82, 0, 'Menu/toogleHide', 1, '', '', 0, ''),
(169, '行为限制启用、禁用、删除', 114, 0, 'ActionLimit/setLimitStatus', 1, '', '', 0, ''),
(170, '启用、禁用、删除、回收站还原', 99, 0, 'SEO/setRuleStatus', 1, '', '', 0, ''),
(171, '回收站彻底删除', 102, 0, 'SEO/doClear', 1, '', '', 0, ''),
(172, '初始化无角色用户', 130, 0, 'Role/initUnhaveUser', 1, '', '', 0, ''),
(173, '删除钩子', 58, 0, 'Addons/delHook', 0, '', '', 0, ''),
(174, '使用补丁', 103, 0, 'Update/usePack', 1, '', '', 0, ''),
(175, '查看补丁', 103, 0, 'Update/view', 1, '', '', 0, ''),
(176, '删除补丁', 103, 0, 'Update/delPack', 1, '', '', 0, ''),
(177, '标签列表', 2, 0, 'UserTag/userTag', 0, '', '用户标签管理', 0, ''),
(178, '添加分类、标签', 177, 0, 'UserTag/add', 1, '', '', 0, ''),
(179, '设置分类、标签状态', 177, 0, 'UserTag/setStatus', 1, '', '', 0, ''),
(180, '分类、标签回收站', 177, 0, 'UserTag/tagTrash', 1, '', '', 0, ''),
(181, '测底删除回收站内容', 177, 0, 'UserTag/userTagClear', 1, '', '', 0, ''),
(182, '可拥有标签配置', 116, 0, 'role/configusertag', 1, '', '', 0, ''),
(183, '编辑模块', 107, 0, 'Module/edit', 1, '', '模块管理', 0, ''),
(184, '网站信息', 74, 0, 'Config/website', 0, '', '系统设置', 0, ''),
(185, '主题管理', 105, 0, 'Theme/tpls', 0, '', '云市场', 0, ''),
(186, '使用主题', 105, 0, 'Theme/setTheme', 1, '', '云市场', 0, ''),
(187, '查看主题', 105, 0, 'Theme/lookTheme', 1, '', '云市场', 0, ''),
(188, '主题打包下载', 105, 0, 'Theme/packageDownload', 1, '', '云市场', 0, ''),
(189, '卸载删除主题', 105, 0, 'Theme/delete', 1, '', '云市场', 0, ''),
(190, '上传安装主题', 105, 0, 'Theme/add', 1, '', '云市场', 0, '');


DROP TABLE  IF EXISTS `uctoo_message`;
CREATE TABLE IF NOT EXISTS `uctoo_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_uid` int(11) NOT NULL,
  `to_uid` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `create_time` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT '0系统消息,1用户消息,2应用消息',
  `is_read` tinyint(4) NOT NULL,
  `last_toast` int(11) NOT NULL,
  `url` varchar(400) NOT NULL,
  `talk_id` int(11) NOT NULL,
  `appname` varchar(30) NOT NULL,
  `apptype` varchar(30) NOT NULL,
  `source_id` int(11) NOT NULL,
  `find_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='thinkox新增消息表' AUTO_INCREMENT=1 ;


-- ----------------------------
-- Table structure for uctoo_model
-- ----------------------------
DROP TABLE IF EXISTS `uctoo_model`;
CREATE TABLE `uctoo_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '模型标识',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '继承的模型',
  `relation` varchar(30) NOT NULL DEFAULT '' COMMENT '继承与被继承模型的关联字段',
  `need_pk` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '新建表时是否需要主键字段',
  `field_sort` text NOT NULL COMMENT '表单字段排序',
  `field_group` varchar(255) NOT NULL DEFAULT '1:基础' COMMENT '字段分组',
  `attribute_list` text NOT NULL COMMENT '属性列表（表的字段）',
  `template_list` varchar(100) NOT NULL DEFAULT '' COMMENT '列表模板',
  `template_add` varchar(100) NOT NULL DEFAULT '' COMMENT '新增模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑模板',
  `list_grid` text NOT NULL COMMENT '列表定义',
  `list_row` smallint(2) unsigned NOT NULL DEFAULT '10' COMMENT '列表数据长度',
  `search_key` varchar(50) NOT NULL DEFAULT '' COMMENT '默认搜索字段',
  `search_list` varchar(255) NOT NULL DEFAULT '' COMMENT '高级搜索的字段',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `engine_type` varchar(25) NOT NULL DEFAULT 'MyISAM' COMMENT '数据库引擎',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 COMMENT='文档模型表';


DROP TABLE  IF EXISTS `uctoo_module`;
CREATE TABLE IF NOT EXISTS `uctoo_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL COMMENT '模块名',
  `alias` varchar(30) NOT NULL COMMENT '中文名',
  `version` varchar(20) NOT NULL COMMENT '版本号',
  `is_com` tinyint(4) NOT NULL COMMENT '是否商业版',
  `show_nav` tinyint(4) NOT NULL COMMENT '是否显示在导航栏中',
  `summary` varchar(200) NOT NULL COMMENT '简介',
  `developer` varchar(50) NOT NULL COMMENT '开发者',
  `website` varchar(200) NOT NULL COMMENT '网址',
  `entry` varchar(50) NOT NULL COMMENT '前台入口',
  `is_setup` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否已安装',
  `sort` int(11) NOT NULL COMMENT '模块排序',
  `icon` varchar(20) NOT NULL,
  `can_uninstall` tinyint(4) NOT NULL,
  `admin_entry` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `name_2` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='模块管理表' AUTO_INCREMENT=1 ;


DROP TABLE  IF EXISTS `uctoo_picture`;
CREATE TABLE IF NOT EXISTS `uctoo_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `type` varchar(50) NOT NULL,
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE  IF EXISTS `uctoo_rank`;
CREATE TABLE IF NOT EXISTS `uctoo_rank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '上传者id',
  `title` varchar(50) NOT NULL,
  `logo` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `types` tinyint(2) NOT NULL DEFAULT '1' COMMENT '前台是否可申请',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE  IF EXISTS `uctoo_rank_user`;
CREATE TABLE IF NOT EXISTS `uctoo_rank_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `rank_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `is_show` tinyint(4) NOT NULL COMMENT '是否显示在昵称右侧（必须有图片才可）',
  `create_time` int(11) NOT NULL,
  `status` tinyint(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


-- ----------------------------
-- Table structure for uctoo_role
-- ----------------------------
DROP TABLE IF EXISTS `uctoo_role`;
CREATE TABLE `uctoo_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL COMMENT '角色组id',
  `name` varchar(25) NOT NULL COMMENT '英文标识',
  `title` varchar(25) NOT NULL COMMENT '中文标题',
  `description` varchar(500) NOT NULL COMMENT '描述',
  `user_groups` varchar(200) NOT NULL COMMENT '默认用户组ids',
  `invite` tinyint(4) NOT NULL COMMENT '预留字段(类型：是否需要邀请注册等)',
  `audit` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否需要审核',
  `sort` int(10) NOT NULL DEFAULT '0',
  `status` tinyint(2) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of uctoo_role
-- ----------------------------
INSERT INTO `uctoo_role` VALUES ('1', '0', 'default', '普通用户', '普通用户', '1', '0', '0', '0', '1', '1426841173', '1426841173');
INSERT INTO `uctoo_role` VALUES ('2', '0', 'mpop', '公众号管理员', '微信公众号管理员', '1,3', '0', '0', '0', '1', '1426841843', '1427064318');
INSERT INTO `uctoo_role` VALUES ('3', '0', 'mpfans', '公众号粉丝', '公众号粉丝', '2', '0', '0', '0', '1', '1435036639', '1435039721');

-- ----------------------------
-- Table structure for uctoo_role_config
-- ----------------------------
DROP TABLE IF EXISTS `uctoo_role_config`;
CREATE TABLE `uctoo_role_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL COMMENT '标识',
  `category` varchar(25) NOT NULL COMMENT '归类标识',
  `value` text NOT NULL COMMENT '配置值',
  `data` text NOT NULL COMMENT '该配置的其它值',
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='角色配置表';

-- ----------------------------
-- Records of uctoo_role_config
-- ----------------------------
INSERT INTO `uctoo_role_config` VALUES ('1', '1', 'rank', '', '1', '{\"reason\":\"\\u666e\\u901a\\u7528\\u6237(\\u89d2\\u8272)\\u9ed8\\u8ba4\\u62e5\\u6709\\u8be5\\u5934\\u8854\\uff01\"}', '1427077924');
INSERT INTO `uctoo_role_config` VALUES ('2', '1', 'expend_field', 'expend_field', '1,2,3,4,5,6,7', '', '1427077951');
INSERT INTO `uctoo_role_config` VALUES ('3', '1', 'register_expend_field', 'expend_field', '1,3', '', '1427359220');
INSERT INTO `uctoo_role_config` VALUES ('4', '2', 'rank', '', '1', '{\"reason\":\"\\u516c\\u4f17\\u53f7\\u7ba1\\u7406\\u5458(\\u89d2\\u8272)\\u9ed8\\u8ba4\\u62e5\\u6709\\u8be5\\u5934\\u8854\\uff01\"}', '1427077993');
INSERT INTO `uctoo_role_config` VALUES ('5', '2', 'expend_field', 'expend_field', '1,2,3,4,5,6,7', '', '1427078002');
INSERT INTO `uctoo_role_config` VALUES ('6', '2', 'register_expend_field', 'expend_field', '1,3', '', '1427359196');

-- ----------------------------
-- Table structure for uctoo_role_group
-- ----------------------------
DROP TABLE IF EXISTS `uctoo_role_group`;
CREATE TABLE `uctoo_role_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(25) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='角色分组';

DROP TABLE  IF EXISTS `uctoo_seo_rule`;
CREATE TABLE IF NOT EXISTS `uctoo_seo_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `app` varchar(40) NOT NULL,
  `controller` varchar(40) NOT NULL,
  `action` varchar(40) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `seo_keywords` text NOT NULL,
  `seo_description` text NOT NULL,
  `seo_title` text NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;



INSERT INTO `uctoo_seo_rule` (`id`, `title`, `app`, `controller`, `action`, `status`, `seo_keywords`, `seo_description`, `seo_title`, `sort`) VALUES
(1, '整站标题', '', '', '', 1, '', '', 'UCToo', 7),
(2, '论坛版块页', 'forum', 'index', 'forum', -1, '{$forum.title} ', '{$forum.title} ', '{$forum.title} —— UCToo开源社区', 2),
(3, 'UCToo首页', '', 'Index', 'index', 1, 'UCToo', 'UCToo首页', 'UCToo开源微信应用社区', 5),
(4, '微博详情页', '', 'Index', 'weiboDetail', 1, '{$weibo.title|op_t},UCToo,oc,微博', '{$weibo.content|op_t}\r\n', '{$weibo.content|op_t}——UCToo微博', 6),
(5, '用户中心', 'Ucenter', 'index', 'index', 1, '{$user_info.nickname|op_t},UCToo', '{$user_info.username|op_t}的个人主页', '{$user_info.nickname|op_t}的个人主页', 3),
(6, '会员页面', 'people', 'index', 'index', 1, '会员', '会员', '会员', 4),
(7, '论坛帖子详情页', 'forum', 'index', 'detail', -1, '{$post.title|op_t},论坛,UCToo', '{$post.title|op_t}', '{$post.title|op_t} —— UCToo论坛', 1),
(8, '商城首页', 'shop', 'index', 'index', -1, '商城,积分', '积分商城', '商城首页——UCToo', 0),
(9, '商城商品详情页', 'shop', 'index', 'goodsdetail', -1, '{$content.goods_name|op_t},商城', '{$content.goods_name|op_t}', '{$content.goods_name|op_t}——UCToo商城', 0),
(10, '资讯首页', 'blog', 'index', 'index', -1, '资讯首页', '资讯首页\r\n', '资讯——UCToo', 0),
(11, '资讯列表页', 'blog', 'article', 'lists', -1, '{$category.title|op_t}', '{$category.title|op_t}', '{$category.title|op_t}', 0),
(12, '资讯文章页', 'blog', 'article', 'detail', -1, '{$info.title|op_t}', '{$info.title|op_t}', '{$info.title|op_t}——UCToo', 0),
(13, '活动首页', 'event', 'index', 'index', -1, '活动', '活动首页', '活动首页——UCToo', 0),
(14, '活动详情页', 'event', 'index', 'detail', -1, '{$content.title|op_t}', '{$content.title|op_t}', '{$content.title|op_t}——UCToo', 0),
(15, '专辑首页', 'issue', 'index', 'index', -1, '专辑', '专辑首页', '专辑首页——UCToo', 0),
(16, '专辑详情页', 'issue', 'index', 'issuecontentdetail', -1, '{$content.title|op_t}', '{$content.title|op_t}', '{$content.title|op_t}——UCToo', 0);

DROP TABLE  IF EXISTS `uctoo_super_links`;
CREATE TABLE IF NOT EXISTS `uctoo_super_links` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` int(1) NOT NULL DEFAULT '1' COMMENT '类别（1：图片，2：普通）',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '站点名称',
  `cover_id` int(10) NOT NULL COMMENT '图片ID',
  `link` char(140) NOT NULL DEFAULT '' COMMENT '链接地址',
  `level` int(3) unsigned NOT NULL DEFAULT '0' COMMENT '优先级',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态（0：禁用，1：正常）',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='友情连接表' AUTO_INCREMENT=5 ;




DROP TABLE  IF EXISTS `uctoo_support`;
CREATE TABLE IF NOT EXISTS `uctoo_support` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appname` varchar(20) NOT NULL COMMENT '应用名',
  `row` int(11) NOT NULL COMMENT '应用标识',
  `uid` int(11) NOT NULL COMMENT '用户',
  `create_time` int(11) NOT NULL COMMENT '发布时间',
  `table` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='支持的表' AUTO_INCREMENT=1 ;

DROP TABLE  IF EXISTS `uctoo_sync_login`;
CREATE TABLE IF NOT EXISTS `uctoo_sync_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `type_uid` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `oauth_token` varchar(255) NOT NULL,
  `oauth_token_secret` varchar(255) NOT NULL,
  `is_sync` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


DROP TABLE  IF EXISTS `uctoo_talk`;
CREATE TABLE IF NOT EXISTS `uctoo_talk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` int(11) NOT NULL,
  `uids` varchar(100) NOT NULL,
  `appname` varchar(30) NOT NULL,
  `apptype` varchar(30) NOT NULL,
  `source_id` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `source_title` varchar(100) NOT NULL,
  `source_content` text NOT NULL,
  `source_url` varchar(200) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `message_id` int(11) NOT NULL,
  `other_uid` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='会话表' AUTO_INCREMENT=1 ;

DROP TABLE  IF EXISTS `uctoo_talk_message`;
CREATE TABLE IF NOT EXISTS `uctoo_talk_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(500) NOT NULL,
  `uid` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `talk_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='聊天消息表' AUTO_INCREMENT=1 ;


DROP TABLE  IF EXISTS `uctoo_talk_message_push`;
CREATE TABLE IF NOT EXISTS `uctoo_talk_message_push` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `source_id` int(11) NOT NULL COMMENT '来源消息id',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `status` tinyint(4) NOT NULL,
  `talk_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk COMMENT='状态，0为未提示，1为未点击，-1为已点击' AUTO_INCREMENT=1 ;

DROP TABLE  IF EXISTS `uctoo_talk_push`;
CREATE TABLE IF NOT EXISTS `uctoo_talk_push` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '接收推送的用户id',
  `source_id` int(11) NOT NULL COMMENT '来源id',
  `create_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '状态，0为未提示，1为未点击，-1为已点击',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='对话推送表' AUTO_INCREMENT=1 ;

DROP TABLE  IF EXISTS `uctoo_ucenter_admin`;
CREATE TABLE IF NOT EXISTS `uctoo_ucenter_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `member_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员用户ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '管理员状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='管理员表' AUTO_INCREMENT=1 ;

DROP TABLE  IF EXISTS `uctoo_ucenter_member`;
CREATE TABLE IF NOT EXISTS `uctoo_ucenter_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(32) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(64) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL COMMENT '用户手机',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '用户状态',
  `type` tinyint(4) NOT NULL COMMENT '1为用户名注册，2为邮箱注册，3为手机注册',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='用户表' AUTO_INCREMENT=100 ;

DROP TABLE  IF EXISTS `uctoo_ucenter_user_link`;
CREATE TABLE IF NOT EXISTS `uctoo_ucenter_user_link` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `uc_uid` int(10) unsigned NOT NULL COMMENT 'Ucenter用户ID',
  `uc_username` char(16) NOT NULL COMMENT 'Ucenter用户名',
   PRIMARY KEY (`uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Ucenter用户关联表' AUTO_INCREMENT=1 ;


DROP TABLE  IF EXISTS `uctoo_ucenter_setting`;
CREATE TABLE IF NOT EXISTS `uctoo_ucenter_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '设置ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型（1-用户配置）',
  `value` text NOT NULL COMMENT '配置数据',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='设置表' AUTO_INCREMENT=1 ;

DROP TABLE  IF EXISTS `uctoo_ucuser`;
CREATE TABLE IF NOT EXISTS `uctoo_ucuser` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `mp_id` int(10) NOT NULL COMMENT '公众号ID',
  `subscribe` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否订阅了公众号',
  `openid` varchar(255) NOT NULL COMMENT 'OpenId用户的标识，对当前公众号唯一',
  `nickname` char(16) NOT NULL DEFAULT '' COMMENT '昵称',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL COMMENT '用户手机',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '用户的性别，值为1时是男性，值为2时是女性，值为0时是未知',
  `city` int(11) NOT NULL COMMENT '城市',
  `country` int(11) NOT NULL COMMENT '国家',
  `province` int(11) NOT NULL COMMENT '省份',
  `language` varchar(50) NOT NULL DEFAULT 'zh_CN' COMMENT '语言',
  `headimgurl` varchar(255) NOT NULL COMMENT '头像',
  `subscribe_time` int(10) NOT NULL COMMENT '关注时间',
  `unionid` int(10) DEFAULT NULL COMMENT '只有在用户将公众号绑定到微信开放平台帐号后，才会出现该字段',
  `remark` text DEFAULT NULL  COMMENT '公众号运营者对粉丝的备注，公众号运营者可在微信公众平台用户管理界面对粉丝添加备注',
  `groupid` int(10) DEFAULT NULL COMMENT '用户所在的分组ID',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日',
  `qq` char(10) NOT NULL DEFAULT '' COMMENT 'qq号',
  `weibo` varchar(100) NOT NULL DEFAULT '' COMMENT '微博',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录状态，0未登录，1登录',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员状态，-1禁用，0未验证，1未同步微信资料，2已同步微信，3等待验证',
  `last_login_role` INT( 11 ) NOT NULL,
  `show_role` INT( 11 ) NOT NULL COMMENT  '个人主页显示角色',
  `signature` text NOT NULL,
  `score1` float DEFAULT NULL COMMENT '用户积分',
  `score2` float DEFAULT NULL COMMENT 'score2',
  `score3` float DEFAULT NULL COMMENT 'score3',
  `score4` float DEFAULT NULL COMMENT 'score4',
  PRIMARY KEY (`uid`),
  KEY `status` (`status`),
  KEY `openid` (`openid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='微会员表' AUTO_INCREMENT=100 ;


DROP TABLE  IF EXISTS `uctoo_url`;
CREATE TABLE IF NOT EXISTS `uctoo_url` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '链接唯一标识',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `short` char(100) NOT NULL DEFAULT '' COMMENT '短网址',
  `status` tinyint(2) NOT NULL DEFAULT '2' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_url` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='链接表' AUTO_INCREMENT=1 ;


DROP TABLE  IF EXISTS `uctoo_user_token`;
CREATE TABLE IF NOT EXISTS `uctoo_user_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE  IF EXISTS `uctoo_verify`;
CREATE TABLE IF NOT EXISTS `uctoo_verify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `account` varchar(255) NOT NULL,
  `type` varchar(20) NOT NULL,
  `verify` varchar(50) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE  IF EXISTS `uctoo_ucenter_score_type`;
CREATE TABLE IF NOT EXISTS `uctoo_ucenter_score_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `unit` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

INSERT INTO `uctoo_ucenter_score_type` (`id`, `title`, `status`, `unit`) VALUES
(1, '积分', 1, '分'),
(2, '威望', 1, '点'),
(3, '贡献', 1, '点'),
(4, '余额', 1, '元');


DROP TABLE IF EXISTS `uctoo_user_config`;
CREATE TABLE IF NOT EXISTS `uctoo_user_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `role_id` int(11) NOT NULL DEFAULT '0',
  `model` varchar(30) NOT NULL,
  `value` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='用户配置信息表' AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `uctoo_user_tag`;
CREATE TABLE IF NOT EXISTS `uctoo_user_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(25) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `pid` int(11) NOT NULL,
  `sort` tinyint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='标签分类表' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `uctoo_user_tag`
--

INSERT INTO `uctoo_user_tag` (`id`, `title`, `status`, `pid`, `sort`) VALUES
(1, '默认', 1, 0, 0),
(2, '开发者', 1, 1, 0),
(3, '站长', 1, 1, 0);

-- --------------------------------------------------------

--
-- 表的结构 `uctoo_user_tag_link`
--

DROP TABLE IF EXISTS `uctoo_user_tag_link`;
CREATE TABLE IF NOT EXISTS `uctoo_user_tag_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `tags` varchar(200) NOT NULL COMMENT '标签ids',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='用户标签关联表' AUTO_INCREMENT=1 ;
DROP TABLE IF EXISTS `uctoo_sso_app`;
CREATE TABLE IF NOT EXISTS `uctoo_sso_app` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `url` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `create_time` int(11) NOT NULL,
  `config` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `uctoo_role_config`;
CREATE TABLE IF NOT EXISTS `uctoo_role_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL COMMENT '标识',
  `category` varchar(25) NOT NULL COMMENT '归类标识',
  `value` text NOT NULL COMMENT '配置值',
  `data` text NOT NULL COMMENT '该配置的其它值',
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='角色配置表' AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `uctoo_role_group`;
CREATE TABLE IF NOT EXISTS `uctoo_role_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(25) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='角色分组' AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `uctoo_user_role`;
CREATE TABLE IF NOT EXISTS `uctoo_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '2：未审核，1:启用，0：禁用，-1：删除',
  `step` varchar(50) NOT NULL COMMENT '记录当前执行步骤',
  `init` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否初始化',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='用户角色关联' AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `uctoo_role`;
CREATE TABLE IF NOT EXISTS `uctoo_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL COMMENT '角色组id',
  `name` varchar(25) NOT NULL COMMENT '英文标识',
  `title` varchar(25) NOT NULL COMMENT '中文标题',
  `description` varchar(500) NOT NULL COMMENT '描述',
  `user_groups` varchar(200) NOT NULL COMMENT '默认用户组ids',
  `invite` tinyint(4) NOT NULL COMMENT '预留字段(类型：是否需要邀请注册等)',
  `audit` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否需要审核',
  `sort` int(10) NOT NULL DEFAULT '0',
  `status` tinyint(2) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='角色表' AUTO_INCREMENT=1 ;

-- ----------------------------
-- Table structure for uctoo_verify
-- ----------------------------
DROP TABLE IF EXISTS `uctoo_verify`;
CREATE TABLE `uctoo_verify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `account` varchar(255) NOT NULL,
  `type` varchar(20) NOT NULL,
  `verify` varchar(50) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uctoo_verify
-- ----------------------------
-- ----------------------------
-- Table structure for uctoo_weicj
-- ----------------------------
DROP TABLE IF EXISTS `uctoo_weicj`;
CREATE TABLE `uctoo_weicj` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `url` varchar(255) NOT NULL COMMENT '自定义回复的url',
  `keyword_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '关键词类型',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `intro` text NOT NULL COMMENT '封面简介',
  `pic3` int(10) unsigned NOT NULL COMMENT '场景图三',
  `cover` int(10) unsigned NOT NULL COMMENT '封面图片',
  `pic2` int(10) unsigned NOT NULL COMMENT '场景图二',
  `mp_id` int(10) NOT NULL COMMENT '公众号ID',
  `pic1` int(10) unsigned NOT NULL COMMENT '场景图一',
  `pic4` int(10) unsigned NOT NULL COMMENT '场景图四',
  `pic5` int(10) unsigned NOT NULL COMMENT '场景图五',
  `pic6` int(10) unsigned NOT NULL COMMENT '场景图六',
  `clickpic` int(10) unsigned NOT NULL COMMENT '场景跳转图',
  `andio` int(10) unsigned NOT NULL COMMENT '背景音乐',
  `cjurl` varchar(255) NOT NULL DEFAULT 'http://' COMMENT '场景跳转URL',
  `audio2` varchar(255) NOT NULL COMMENT '背景音乐（网络地址）',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

INSERT INTO `uctoo_weicj` VALUES ('3', 'http://test.uctoo.com/index.php?s=/home/addons/execute/Weicj/Weicj/index/id/3/mp_id/107.html', '0', '微场景', '微场景演示', '21', '27', '20', '107', '18', '25', '24', '23', '26', '0', 'http://test.uctoo.com/index.php?s=/issue/index/index.html', 'http://mh.ccjoy.com/reg/reg1/images/sound.mp3');

-- ----------------------------
-- Table structure for uctoo_weixin_log
-- ----------------------------
DROP TABLE IF EXISTS `uctoo_weixin_log`;
CREATE TABLE `uctoo_weixin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cTime` int(11) DEFAULT NULL,
  `cTime_format` varchar(30) DEFAULT NULL,
  `data` text,
  `data_post` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7213 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
-- ----------------------------
-- Table structure for uctoo_welcome
-- ----------------------------
DROP TABLE IF EXISTS `uctoo_welcome`;
CREATE TABLE `uctoo_welcome` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `keyword` varchar(100) NOT NULL COMMENT '关键词',
  `keyword_type` tinyint(2) DEFAULT NULL COMMENT '关键词类型',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `intro` text COMMENT '简介',
  `cate_id` int(10) unsigned DEFAULT '0' COMMENT '所属类别',
  `cover` int(10) unsigned DEFAULT NULL COMMENT '封面图片',
  `content` text NOT NULL COMMENT '内容',
  `cTime` int(10) DEFAULT NULL COMMENT '发布时间',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序号',
  `view_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览数',
  `token` varchar(255) NOT NULL COMMENT 'Token',
  `url` varchar(255) DEFAULT NULL COMMENT '跳转url',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
DROP TABLE IF EXISTS `uctoo_invite`;
CREATE TABLE IF NOT EXISTS `uctoo_invite` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PRIMARY_KEY',
  `invite_type` int(11) NOT NULL COMMENT '邀请类型id',
  `code` varchar(25) NOT NULL COMMENT '邀请码',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `can_num` int(10) NOT NULL COMMENT '可以注册用户（含升级）',
  `already_num` int(10) NOT NULL COMMENT '已经注册用户（含升级）',
  `end_time` int(11) NOT NULL COMMENT '有效期至',
  `status` tinyint(2) NOT NULL COMMENT '0：已用完，1：还可注册，2：用户取消邀请，-1：管理员删除',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='邀请码表' AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `uctoo_invite_buy_log`;
CREATE TABLE IF NOT EXISTS `uctoo_invite_buy_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PRIMARY_KEY',
  `invite_type` int(11) NOT NULL COMMENT '邀请类型id',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `num` int(10) NOT NULL COMMENT '可邀请名额',
  `content` varchar(200) NOT NULL COMMENT '记录信息',
  `create_time` int(11) NOT NULL COMMENT '创建时间（做频率用）',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='用户购买邀请名额记录' AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `uctoo_invite_log`;
CREATE TABLE IF NOT EXISTS `uctoo_invite_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PRIMARY_KEY',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `inviter_id` int(11) NOT NULL COMMENT '邀请人id',
  `invite_id` int(11) NOT NULL COMMENT '邀请码id',
  `content` varchar(200) NOT NULL COMMENT '记录内容',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='邀请注册成功记录表' AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `uctoo_invite_type`;
CREATE TABLE IF NOT EXISTS `uctoo_invite_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PRIMARY_KEY',
  `title` varchar(25) NOT NULL COMMENT '标题',
  `length` int(10) NOT NULL DEFAULT '11' COMMENT '验证码长度',
  `time` varchar(50) NOT NULL COMMENT '有效时长，带单位的时间',
  `cycle_num` int(10) NOT NULL COMMENT '周期内可购买个数',
  `cycle_time` varchar(50) NOT NULL COMMENT '周期时长，带单位的时间',
  `roles` varchar(50) NOT NULL COMMENT '绑定角色ids',
  `auth_groups` varchar(50) NOT NULL COMMENT '允许购买的用户组ids',
  `pay_score` int(10) NOT NULL COMMENT '购买消耗积分',
  `pay_score_type` int(11) NOT NULL COMMENT '购买消耗积分类型',
  `income_score` int(10) NOT NULL COMMENT '每邀请成功一个用户，邀请者增加积分',
  `income_score_type` int(11) NOT NULL COMMENT '邀请成功后增加积分类型id',
  `is_follow` tinyint(2) NOT NULL COMMENT '邀请成功后是否互相关注',
  `status` tinyint(2) NOT NULL,
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='邀请注册码类型表' AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `uctoo_invite_user_info`;
CREATE TABLE IF NOT EXISTS `uctoo_invite_user_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PRIMARY_KEY',
  `invite_type` int(11) NOT NULL COMMENT '邀请类型id',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `num` int(11) NOT NULL COMMENT '可邀请名额',
  `already_num` int(11) NOT NULL COMMENT '已邀请名额',
  `success_num` int(11) NOT NULL COMMENT '成功邀请名额',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='邀请注册用户信息' AUTO_INCREMENT=1 ;


