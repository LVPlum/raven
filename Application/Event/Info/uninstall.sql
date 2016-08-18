DROP TABLE IF EXISTS `uctoo_event`;
DROP TABLE IF EXISTS `uctoo_event_attend`;
DROP TABLE IF EXISTS `uctoo_event_type`;
/*删除menu相关数据*/
set @tmp_id=0;
select @tmp_id:= id from `uctoo_menu` where `title` = '活动';
delete from `uctoo_menu` where  `id` = @tmp_id or (`pid` = @tmp_id  and `pid` !=0);
delete from `uctoo_menu` where  `title` = '活动';

delete from `uctoo_menu` where  `url` like 'Event/%';