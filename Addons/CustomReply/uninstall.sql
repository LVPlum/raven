DELETE FROM `uctoo_attribute` WHERE model_id = (SELECT id FROM uctoo_model WHERE `name`='custom_reply_mult' ORDER BY id DESC LIMIT 1);
DELETE FROM `uctoo_model` WHERE `name`='custom_reply_mult' ORDER BY id DESC LIMIT 1;
DROP TABLE IF EXISTS `uctoo_custom_reply_mult`;

DELETE FROM `uctoo_attribute` WHERE model_id = (SELECT id FROM uctoo_model WHERE `name`='custom_reply_news' ORDER BY id DESC LIMIT 1);
DELETE FROM `uctoo_model` WHERE `name`='custom_reply_news' ORDER BY id DESC LIMIT 1;
DROP TABLE IF EXISTS `uctoo_custom_reply_news`;

DELETE FROM `uctoo_attribute` WHERE model_id = (SELECT id FROM uctoo_model WHERE `name`='custom_reply_text' ORDER BY id DESC LIMIT 1);
DELETE FROM `uctoo_model` WHERE `name`='custom_reply_text' ORDER BY id DESC LIMIT 1;
DROP TABLE IF EXISTS `uctoo_custom_reply_text`;