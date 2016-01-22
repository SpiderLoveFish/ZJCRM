IF(OBJECT_ID('f_admin_user')>0)
	DROP TABLE dbo.f_admin_user
	CREATE TABLE f_admin_user
	(
		 id INT IDENTITY(1,1),
		 username varchar(45) NOT NULL,
		 f_password varchar(45) NOT NULL
		PRIMARY KEY (id)       
	)
INSERT INTO  f_admin_user  ( username, f_password)
VALUES
	('admin','e10adc3949ba59abbe56e057f20f883e');--123456

 IF(OBJECT_ID('f_collect')>0)
	DROP TABLE dbo.f_collect
	CREATE TABLE f_collect
	(
		 id INT IDENTITY(1,1),
		 tid varchar(32) NOT NULL,
		 author_id varchar(32) NOT NULL,
		 in_time DATETIME 
		PRIMARY KEY (id)       
	)

IF(OBJECT_ID('f_label')>0)
	DROP TABLE dbo.f_label
	CREATE TABLE f_label
	(
		 id INT IDENTITY(1,1),
		 name varchar(255) NOT NULL,	
		 in_time DATETIME ,
		  topic_count int NOT NULL  DEFAULT (0)
		PRIMARY KEY (id)       
	)

	IF(OBJECT_ID('f_label_topic_id')>0)
	DROP TABLE dbo.f_label_topic_id
	CREATE TABLE f_label_topic_id
	(
		 tid varchar(32) NOT NULL,
		 lid int NOT NULL 
		PRIMARY KEY (tid,lid)       
	)
	
 IF(OBJECT_ID('f_mission')>0)
	DROP TABLE dbo.f_mission
	CREATE TABLE f_mission
	(
		 id INT IDENTITY(1,1),
		 score INT NOT NULL,
		 author_id varchar(32) NOT NULL,
		 in_time DATETIME ,
		 f_day INT DEFAULT (0)
		PRIMARY KEY (id)       
	)  

 IF(OBJECT_ID('f_notification')>0)
	DROP TABLE dbo.f_notification
	CREATE TABLE f_notification
	(
		 id INT IDENTITY(1,1),
		 f_message varchar(255) NOT NULL,
		 f_read  int NOT NULL,
		 from_author_id varchar(32) NOT null,
		 author_id varchar(32) NOT null,
		 tid  varchar(32) NOT null,
		 rid  varchar(32) NOT null,
		 in_time DATETIME  
		PRIMARY KEY (id)       
	) 


	
 IF(OBJECT_ID('f_reply')>0)
	DROP TABLE dbo.f_reply
	CREATE TABLE f_reply
	(
		 id INT DEFAULT '',
		 tid varchar(32) NOT NULL,
		 content  TEXT NOT NULL,
		 in_time DATETIME NOT null,
		 author_id varchar(32) NOT null,
		 best  int NOT null,
		  isdelete  int NOT null 
		PRIMARY KEY (id)       
	) 

	 IF(OBJECT_ID('f_section')>0)
	DROP TABLE dbo.f_section
	CREATE TABLE f_section
	(
		 id INT IDENTITY(1,1),
		 name varchar(45) NOT NULL,
		 tab  varchar(45) NOT NULL,
		 show_status INT NOT null,
		 display_index INT  NOT null,
		 default_show  int NOT null DEFAULT (0) 
		PRIMARY KEY (id)       
	) 
  IF(OBJECT_ID('f_topic')>0)
	DROP TABLE dbo.f_topic
	CREATE TABLE f_topic
	(
		 id varchar(32) DEFAULT (''),
		 s_id INT NOT NULL,
		 title  varchar(255) NOT NULL,
		 content TEXT NOT null,
		 in_time DATETIME  NOT null,
		 modify_time  DATETIME NOT null  ,
		 last_reply_time  DATETIME NOT null  ,
		 last_reply_author_id VARCHAR(32),
		 f_view int	,
		 author_id varchar(32),
		 reposted int DEFAULT(0),
		 original_url varchar(255),
		 f_top INT,
		 good INT,
		 show_status INT DEFAULT (1)
		PRIMARY KEY (id)       
	) 

	 IF(OBJECT_ID('f_user')>0)
	DROP TABLE dbo.f_user
	CREATE TABLE f_user
	(
		 id varchar(32) DEFAULT (''),
		 nickname varchar(50) NOT NULL,
		 score  int NOT NULL,
		 token varchar(255) NOT null,
		 avatar varchar(255)  NOT null,
		 mission  DATETIME NOT null  ,
		 in_time  DATETIME NOT null  ,
		 email VARCHAR(100),
		 f_password varchar(255)	,
		 url varchar(32) 
		PRIMARY KEY (id)       
	) 