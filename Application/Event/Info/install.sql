SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

DROP TABLE IF EXISTS `uctoo_event`;
CREATE TABLE IF NOT EXISTS `uctoo_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '发起人',
  `title` varchar(255) NOT NULL COMMENT '活动名称',
  `sldomain` varchar(50) NOT NULL COMMENT '二级镜像域名',
  `sponsor` varchar(255) NOT NULL COMMENT '主办方',
  `explain` text NOT NULL COMMENT '详细内容',
  `sTime` int(11) NOT NULL COMMENT '活动开始时间',
  `eTime` int(11) NOT NULL COMMENT '活动结束时间',
  `province` int(11) NOT NULL,
  `city` int(11) NOT NULL,
  `district` int(11) NOT NULL,
  `community` int(11) NOT NULL,
  `longitude` varchar(20) NOT NULL COMMENT '经度',
  `latitude` varchar(20) NOT NULL COMMENT '纬度',
  `map` varchar(60) NOT NULL COMMENT '坐标',
  `address` varchar(255) NOT NULL COMMENT '详细地址',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `limitCount` int(11) NOT NULL COMMENT '限制人数',
  `cover_id` int(11) NOT NULL COMMENT '封面ID',
  `deadline` int(11) NOT NULL,
  `attentionCount` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `view_count` int(11) NOT NULL,
  `reply_count` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `signCount` int(11) NOT NULL,
  `is_recommend` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

DROP TABLE IF EXISTS `uctoo_event_attend`;
CREATE TABLE IF NOT EXISTS `uctoo_event_attend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `mp_id` int(10) NOT NULL COMMENT '公众号ID',
  `openid` varchar(100) NOT NULL COMMENT 'OpenId用户的标识，对当前公众号唯一',
  `event_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` bigint(20) NOT NULL,
  `creat_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '0为报名，1为参加',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `uctoo_event_type`;
CREATE TABLE IF NOT EXISTS `uctoo_event_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `allow_post` tinyint(4) NOT NULL,
  `pid` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `uctoo_event_type` (`id`, `title`, `create_time`, `update_time`, `status`, `allow_post`, `pid`, `sort`) VALUES
(1, '慈善活动', 1403859500, 1403859485, 1, 0, 0, 0),
(2, '公益活动', 1403859511, 1403859502, 1, 0, 0, 0);




/* menu 插入 */

INSERT INTO `uctoo_menu` (`title`, `pid`, `sort`, `url`, `hide`, `tip`, `group`, `is_dev`, `icon`) VALUES
( '活动', 0, 22, 'Event/index', 1, '', '', 0,'');

set @tmp_id=0;
select @tmp_id:= id from `uctoo_menu` where title = '活动';

INSERT INTO `uctoo_menu` (`title`, `pid`, `sort`, `url`, `hide`, `tip`, `group`, `is_dev`, `icon`) VALUES
('活动分类管理', @tmp_id, 0, 'Event/index', 0, '', '活动分类管理', 0, ''),
('内容管理', @tmp_id, 0, 'Event/event', 0, '', '内容管理', 0, ''),
('活动分类回收站', @tmp_id, 0, 'Event/eventTypeTrash', 0, '', '活动分类管理', 0, ''),
('内容审核', @tmp_id, 0, 'Event/verify', 1, '', '内容管理', 0, ''),
('内容回收站', @tmp_id, 0, 'Event/contentTrash', 0, '', '内容管理', 0, ''),
('活动设置', @tmp_id, 0, 'Event/config', 0, '', '设置', 0, ''),
('编辑活动', @tmp_id, 0, 'Event/add', 1, '', '', 0, '');

Delete from `uctoo_action` where module = 'Event';
Delete from `uctoo_action_limit` where module = 'Event';
Delete from `uctoo_auth_rule` where module = 'Event';

INSERT INTO `uctoo_action` (`name`, `title`, `remark`, `rule`, `log`, `type`, `status`, `update_time`, `module`) VALUES
('edit_event', '编辑活动', '用户发布、编辑活动', 'N;', '', 2, 1, 1428479582, 'Event');

INSERT INTO `uctoo_action_limit` (`title`, `name`, `frequency`, `time_number`, `time_unit`, `punish`, `if_message`, `message_content`, `action_list`, `status`, `create_time`, `module`) VALUES
('edit_event', '编辑活动', 1, 1, 'minute', 'warning', 1, '操作太频繁！', '[edit_event]', 1, 0, 'Event');

INSERT INTO `uctoo_auth_rule` (`module`, `type`, `name`, `title`, `status`, `condition`) VALUES
('Event', 1, 'Event/Index/edit', '编辑活动', 1, '');
