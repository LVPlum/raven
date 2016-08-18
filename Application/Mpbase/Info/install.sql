
-- ----------------------------
-- Table structure for uctoo_member_public
-- ----------------------------
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

INSERT INTO `uctoo_menu` (`title`, `pid`, `sort`, `url`, `hide`, `tip`, `group`, `is_dev`, `icon`) VALUES
( '基础设置', 0, 0, 'Mpbase/index', 1, '', '', 0, '');

set @tmp_id=0;
select @tmp_id:= id from `ocenter_menu` where title = '基础设置';

INSERT INTO `uctoo_menu` ( `title`, `pid`, `sort`, `url`, `hide`, `tip`, `group`, `is_dev`) VALUES
( '编辑公众号', @tmp_id, 0, 'Mpbase/editMp', 1, '', '公众号', 0, ''),
( '公众号管理', @tmp_id, 0, 'Mpbase/index', 0, '', '公众号', 0, ''),
( '管理基本设置', @tmp_id, 0, 'Mpbase/config', 0, '', '公众号', 0, ''),
( '编辑自定义菜单', @tmp_id, 0, 'Admin/Custommenu/add', 1, '', '公众号', 0, ''),
( '自定义菜单管理', @tmp_id, 0, 'Admin/Custommenu/index', 0, '', '公众号', 0, ''),
( '自定义菜单操作', @tmp_id, 0, 'Admin/Custommenu/operate', 1, '', '公众号', 0, '');

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
