# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.7.10)
# Database: jfinalbbs
# Generation Time: 2016-01-19 01:48:21 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table admin_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_user`;

CREATE TABLE `admin_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL COMMENT '��̨�û���',
  `password` varchar(45) NOT NULL COMMENT '��̨����(123456)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

LOCK TABLES `admin_user` WRITE;
/*!40000 ALTER TABLE `admin_user` DISABLE KEYS */;

INSERT INTO `admin_user` (`id`, `username`, `password`)
VALUES
	(1,'admin','e10adc3949ba59abbe56e057f20f883e');

/*!40000 ALTER TABLE `admin_user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table collect
# ------------------------------------------------------------

CREATE TABLE `collect` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tid` varchar(32) NOT NULL COMMENT '�ղػ���id',
  `author_id` varchar(32) NOT NULL COMMENT '�û�id',
  `in_time` datetime NOT NULL COMMENT '¼��ʱ��',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;



# Dump of table label
# ------------------------------------------------------------

DROP TABLE IF EXISTS `label`;

CREATE TABLE `label` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `in_time` datetime NOT NULL,
  `topic_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

LOCK TABLES `label` WRITE;
/*!40000 ALTER TABLE `label` DISABLE KEYS */;

INSERT INTO `label` (`id`, `name`, `in_time`, `topic_count`)
VALUES
	(1,'Java','2015-10-13 22:38:27',3),
	(3,'�������','2015-10-13 22:39:23',2),
	(6,'Freemarker','2015-10-13 22:40:22',1),
	(7,'Jfinal','2015-10-13 22:40:50',1),
	(11,'jfinalbbs','2015-10-15 18:10:24',1),
	(12,'����','2015-10-15 18:10:51',1),
	(13,'΢��','2015-10-15 18:14:38',1),
	(14,'���߷���','2015-10-15 18:15:00',1),
	(19,'�༭��','2015-10-15 18:15:01',1);

/*!40000 ALTER TABLE `label` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table label_topic_id
# ------------------------------------------------------------

CREATE TABLE `label_topic_id` (
  `tid` varchar(32) NOT NULL,
  `lid` int(11) NOT NULL,
  KEY `fk_label_id` (`lid`),
  KEY `fk_topic_id` (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;



# Dump of table link
# ------------------------------------------------------------

DROP TABLE IF EXISTS `link`;

CREATE TABLE `link` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL COMMENT '��������',
  `url` varchar(255) NOT NULL COMMENT '������ַ',
  `display_index` int(11) NOT NULL COMMENT '��������',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

LOCK TABLES `link` WRITE;
/*!40000 ALTER TABLE `link` DISABLE KEYS */;

INSERT INTO `link` (`id`, `name`, `url`, `display_index`)
VALUES
	(1,'JFinalbbs','http://jfinalbbs.com/',1);

/*!40000 ALTER TABLE `link` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mission
# ------------------------------------------------------------

CREATE TABLE `mission` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `score` int(11) NOT NULL COMMENT 'ǩ�������û���',
  `author_id` varchar(32) NOT NULL COMMENT '�û�id',
  `in_time` datetime NOT NULL COMMENT '¼��ʱ��',
  `day` int(11) NOT NULL DEFAULT '0' COMMENT '����ǩ������',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;



# Dump of table notification
# ------------------------------------------------------------

CREATE TABLE `notification` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `message` varchar(255) NOT NULL COMMENT '��Ϣ����',
  `read` int(11) NOT NULL COMMENT '�Ƿ��Ѷ���0Ĭ�� 1�Ѷ�',
  `from_author_id` varchar(32) NOT NULL COMMENT '��Դ�û�id',
  `author_id` varchar(32) NOT NULL COMMENT 'Ŀ���û�id',
  `tid` varchar(32) DEFAULT NULL COMMENT '����id',
  `rid` varchar(32) DEFAULT NULL COMMENT '�ظ�id',
  `in_time` datetime NOT NULL COMMENT '¼��ʱ��',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;



# Dump of table reply
# ------------------------------------------------------------

CREATE TABLE `reply` (
  `id` varchar(32) NOT NULL DEFAULT '',
  `tid` varchar(32) NOT NULL COMMENT '����id',
  `content` longtext NOT NULL COMMENT '�ظ�����',
  `in_time` datetime NOT NULL COMMENT '¼��ʱ��',
  `author_id` varchar(32) NOT NULL COMMENT '��ǰ�ظ��û�id',
  `best` int(11) NOT NULL DEFAULT '0' COMMENT '����Ϊ��Ѵ� 0Ĭ�ϣ�1����',
  `isdelete` int(11) NOT NULL DEFAULT '0' COMMENT '�Ƿ�ɾ��0 Ĭ�� 1ɾ��',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;



# Dump of table section
# ------------------------------------------------------------

DROP TABLE IF EXISTS `section`;

CREATE TABLE `section` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL COMMENT '�������',
  `tab` varchar(45) NOT NULL COMMENT '����ǩ',
  `show_status` int(11) NOT NULL DEFAULT '1' COMMENT '�Ƿ���ʾ��0����ʾ1��ʾ',
  `display_index` int(11) NOT NULL COMMENT '�������',
  `default_show` int(11) NOT NULL DEFAULT '0' COMMENT 'Ĭ����ʾģ�� 0Ĭ�ϣ�1��ʾ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

LOCK TABLES `section` WRITE;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;

INSERT INTO `section` (`id`, `name`, `tab`, `show_status`, `display_index`, `default_show`)
VALUES
	(1,'�ʴ�','ask',1,4,0),
	(2,'����','blog',1,5,0),
	(7,'��Ѷ','news',1,2,0),
	(8,'��ˮ','gs',1,1,0),
	(9,'����','share',1,3,1),
	(10,'����','used',1,99,0),
	(11,'��Ƹ','job',1,99,0),
	(12,'˽��','privatejob',1,99,0);

/*!40000 ALTER TABLE `section` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table topic
# ------------------------------------------------------------

CREATE TABLE `topic` (
  `id` varchar(32) NOT NULL DEFAULT '',
  `s_id` int(11) NOT NULL COMMENT '���id',
  `title` varchar(255) NOT NULL COMMENT '�������',
  `content` longtext NOT NULL COMMENT '��������',
  `in_time` datetime NOT NULL COMMENT '¼��ʱ��',
  `modify_time` datetime DEFAULT NULL COMMENT '�޸�ʱ��',
  `last_reply_time` datetime DEFAULT NULL COMMENT '���ظ�����ʱ�䣬��������',
  `last_reply_author_id` varchar(32) DEFAULT NULL COMMENT '���ظ�������û�id',
  `view` int(11) NOT NULL COMMENT '�����',
  `author_id` varchar(32) NOT NULL COMMENT '��������id',
  `reposted` int(11) NOT NULL DEFAULT '0' COMMENT '1��ת�� 0��ԭ��',
  `original_url` varchar(255) DEFAULT NULL COMMENT 'ԭ������',
  `top` int(11) NOT NULL DEFAULT '0' COMMENT '1�ö� 0Ĭ��',
  `good` int(11) NOT NULL DEFAULT '0' COMMENT '1���� 0Ĭ��',
  `show_status` int(11) NOT NULL DEFAULT '1' COMMENT '1��ʾ0����ʾ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;



# Dump of table user
# ------------------------------------------------------------

CREATE TABLE `user` (
  `id` varchar(32) NOT NULL,
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '�ǳ�',
  `score` int(11) NOT NULL COMMENT '����',
  `token` varchar(255) NOT NULL DEFAULT '' COMMENT '�û�Ψһ��ʶ�����ڿͻ��˺���ҳ����cookie',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT 'ͷ��',
  `mission` date NOT NULL COMMENT 'ǩ������',
  `in_time` datetime NOT NULL COMMENT '¼��ʱ��',
  `email` varchar(255) DEFAULT '' COMMENT '����',
  `password` varchar(255) NOT NULL DEFAULT '' COMMENT '����',
  `url` varchar(255) DEFAULT NULL COMMENT '������ҳ',
  `signature` varchar(1000) DEFAULT NULL COMMENT '����ǩ��',
  `qq_open_id` varchar(255) DEFAULT NULL COMMENT 'qq��¼Ψһ��ʶ',
  `qq_avatar` varchar(255) DEFAULT NULL COMMENT 'qqͷ��',
  `qq_nickname` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'qq�ǳ�',
  `sina_open_id` varchar(255) DEFAULT NULL COMMENT '����΢����¼Ψһ��ʶ',
  `sina_avatar` varchar(255) DEFAULT NULL COMMENT '����΢��ͷ��',
  `sina_nickname` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '����΢���ǳ�',
  PRIMARY KEY (`id`),
  UNIQUE KEY `TOKEN_UNIQUE` (`token`),
  UNIQUE KEY `EMAIL_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;



# Dump of table valicode
# ------------------------------------------------------------

CREATE TABLE `valicode` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(32) NOT NULL COMMENT '��֤��',
  `in_time` datetime NOT NULL COMMENT '¼��ʱ��',
  `status` int(11) NOT NULL COMMENT '0δʹ��  1��ʹ��',
  `type` varchar(45) NOT NULL COMMENT '��֤�����ͣ����磺�һ�����',
  `expire_time` datetime NOT NULL COMMENT '����ʱ��',
  `target` varchar(255) NOT NULL COMMENT '����Ŀ�꣬�������',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
