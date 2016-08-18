CREATE TABLE IF NOT EXISTS `uctoo_welcome` (
`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
`keyword`  varchar(100) NOT NULL  COMMENT '关键词',
`keyword_type`  tinyint(2) NULL  COMMENT '关键词类型',
`title`  varchar(255) NOT NULL  COMMENT '标题',
`intro`  text NULL  COMMENT '简介',
`cate_id`  int(10) UNSIGNED NULL  DEFAULT 0 COMMENT '所属类别',
`cover`  int(10) UNSIGNED NULL  COMMENT '封面图片',
`content`  text NOT NULL  COMMENT '内容',
`cTime`  int(10) NULL  COMMENT '发布时间',
`sort`  int(10) UNSIGNED NOT NULL  DEFAULT 0 COMMENT '排序号',
`view_count`  int(10) UNSIGNED NOT NULL  DEFAULT 0 COMMENT '浏览数',
`token`  varchar(255) NOT NULL  COMMENT 'Token',
`url`  varchar(255) NOT NULL  COMMENT 'URL',
PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci CHECKSUM=0 ROW_FORMAT=DYNAMIC DELAY_KEY_WRITE=0;
