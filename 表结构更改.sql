--修改员工表
ALTER TABLE hr_employee ADD rqlx VARCHAR(50)

--修改客户表
ALTER TABLE dbo.CRM_Customer ADD [Towns_id] INT
ALTER TABLE dbo.CRM_Customer ADD [Towns] VARCHAR(250)
ALTER TABLE dbo.CRM_Customer ADD [Community_id] INT
ALTER TABLE dbo.CRM_Customer ADD [Community] VARCHAR(250)
ALTER TABLE dbo.CRM_Customer ADD [BNo] VARCHAR(50)
ALTER TABLE dbo.CRM_Customer ADD [RNo] VARCHAR(50)
ALTER TABLE dbo.CRM_Customer ADD [Gender] VARCHAR(50)
ALTER TABLE dbo.CRM_Customer ADD [Jfrq] VARCHAR(50)
ALTER TABLE dbo.CRM_Customer ADD [Zxrq] VARCHAR(50)
ALTER TABLE dbo.CRM_Customer ADD [Jhrq1] VARCHAR(50)
ALTER TABLE dbo.CRM_Customer ADD [Jhrq2] VARCHAR(50)
ALTER TABLE dbo.CRM_Customer ADD [Fwyt] VARCHAR(50)
ALTER TABLE dbo.CRM_Customer ADD [Fwmj] VARCHAR(50)
ALTER TABLE dbo.CRM_Customer ADD [Fwhx_id] INT
ALTER TABLE dbo.CRM_Customer ADD [Fwhx] VARCHAR(50)
ALTER TABLE dbo.CRM_Customer ADD [Zxjd_id] INT
ALTER TABLE dbo.CRM_Customer ADD [Zxjd] VARCHAR(50)
ALTER TABLE dbo.CRM_Customer ADD [Zxfg_id] INT
ALTER TABLE dbo.CRM_Customer ADD [Zxfg] VARCHAR(50)
ALTER TABLE dbo.CRM_Customer ADD [Dpt_id_sg] INT
ALTER TABLE dbo.CRM_Customer ADD [Dpt_sg] VARCHAR(50)
ALTER TABLE dbo.CRM_Customer ADD [Emp_id_sg] INT
ALTER TABLE dbo.CRM_Customer ADD [Emp_sg] VARCHAR(50)
ALTER TABLE dbo.CRM_Customer ADD [Emp_id_sj] INT
ALTER TABLE dbo.CRM_Customer ADD [Emp_sj] VARCHAR(50)
ALTER TABLE dbo.CRM_Customer ADD [Dpt_id_sj] INT
ALTER TABLE dbo.CRM_Customer ADD [Dpt_sj] VARCHAR(50)
GO

--基础参数表
UPDATE dbo.Param_SysParam_Type SET params_name='客户职业' WHERE id=8
INSERT INTO dbo.Param_SysParam_Type (id,params_name,params_order)VALUES(9,'房屋户型',48)
INSERT INTO dbo.Param_SysParam_Type (id,params_name,params_order)VALUES(10,'装修风格',47)
INSERT INTO dbo.Param_SysParam_Type (id,params_name,params_order)VALUES(11,'装修进度',45)
INSERT INTO dbo.Param_SysParam_Type (id,params_name,params_order)VALUES(12,'维修类别',49)
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('4','电话','20')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('4','邮件','20')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('9','单身公寓','20')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('10','现代前卫','20')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('10','现代简约','30')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('11','未开工','20')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('11','结构改造','30')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('11','瓦工','40')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('8','公务员','20')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('8','自由职业','30')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('8','小店老板','40')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('1','潜在客户','20')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('1','意向客户','30')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('1','签单客户','40')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('1','流失客户','40')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('2','1-5万','20')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('2','5-10万','30')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('3','客户介绍','20')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('3','QQ联系','30')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('3','主动上门','40')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('4','记录','40')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('4','QQ','20')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('5','现金','20')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('6','签单','20')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('7','普票','20')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('7','增值税','20')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('12','水电','10')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('12','木工','20')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('12','瓦工','30')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('12','油漆','40')
INSERT INTO dbo.Param_SysParam (parentid,params_name,params_order)VALUES('12','其他','50')



GO

--增加菜单
INSERT INTO dbo.Sys_Menu (Menu_name,parentid,parentname,App_id,Menu_url,Menu_icon,Menu_handler,Menu_order,Menu_type)
VALUES  ('维修管理', -- Menu_name - varchar(255)
         0, -- parentid - int
         '无', -- parentname - varchar(255)
         2, -- App_id - int
         '', -- Menu_url - varchar(255)
         'images/icon/37.png', -- Menu_icon - varchar(50)
         NULL, -- Menu_handler - varchar(50)
         10, -- Menu_order - int
         'sys'  -- Menu_type - varchar(50)
         )
INSERT INTO dbo.Sys_Menu (Menu_name,parentid,parentname,App_id,Menu_url,Menu_icon,Menu_handler,Menu_order,Menu_type)
VALUES  ('维修列表', -- Menu_name - varchar(255)
         90, -- parentid - int
         '维护管理', -- parentname - varchar(255)
         2, -- App_id - int
         'CRM/Repair/Repair.aspx', -- Menu_url - varchar(255)
         'images/icon/71.png', -- Menu_icon - varchar(50)
         NULL, -- Menu_handler - varchar(50)
         10, -- Menu_order - int
         'sys'  -- Menu_type - varchar(50)
         )

INSERT INTO dbo.Sys_Button (Btn_name,Btn_icon,Btn_handler,Menu_id,Menu_name,Btn_order)
VALUES ('新增','images/icon/11.png','add()','91','维修列表','10')
INSERT INTO dbo.Sys_Button (Btn_name,Btn_icon,Btn_handler,Menu_id,Menu_name,Btn_order)
VALUES ('修改','images/icon/33.png','edit()','91','维修列表','20')
INSERT INTO dbo.Sys_Button (Btn_name,Btn_icon,Btn_handler,Menu_id,Menu_name,Btn_order)
VALUES ('处理','images/icon/50.png','manage()','91','维修列表','30')
INSERT INTO dbo.Sys_Button (Btn_name,Btn_icon,Btn_handler,Menu_id,Menu_name,Btn_order)
VALUES ('删除','images/icon/12.png','del()','91','维修列表','40')

GO

--增加维修表
IF(OBJECT_ID('CRM_Repair')>0)
	DROP TABLE dbo.CRM_Repair
CREATE TABLE dbo.CRM_Repair(
	RepairID INT NOT NULL IDENTITY(1,1),
	Sfkh CHAR(2),
	Khbh INT,
	Khmc VARCHAR(50),
	Khdh VARCHAR(50),
	Khyx VARCHAR(50),
	Khdz VARCHAR(250),
	Khxq VARCHAR(250),
	Khxb VARCHAR(50),
	Wxrq SMALLDATETIME,
	Wxsj VARCHAR(50),
	WxlbID INT,
	Wxyy VARCHAR(500),
	Clrq SMALLDATETIME,
	Wcrq SMALLDATETIME,
	Wczt VARCHAR(50),
	Fzxs DECIMAL(18,2),
	WxEmpID INT,
	GdEmpID INT,
	Hfxx VARCHAR(500),
	Pjxx VARCHAR(500),
	InEmpID INT,
	InDate DATETIME,
	EditEmpID INT,
	EditDate DATETIME,
	ClEmpID INT,
	ClDate DATETIME,
	IsDel CHAR(1),
	DelEmpID INT,
	DelDate DATETIME
	PRIMARY KEY (RepairID)
)

GO

--增加维修跟进表
IF(OBJECT_ID('CRM_Repair_Follow')>0)
	DROP TABLE dbo.CRM_Repair_Follow
CREATE TABLE dbo.CRM_Repair_Follow(
	FollowID INT NOT NULL IDENTITY(1,1),
	RepairID INT,
	FollowTypeID INT,
	FollowContent VARCHAR(250),
	InEmpID INT,
	InDate DATETIME,
	IsLastIn CHAR(1),
	EditEmpID INT,
	EditDate DATETIME,
	IsLastEdit CHAR(1),
	IsDel CHAR(1),
	DelEmpID INT,
	DelDate DATETIME
	PRIMARY KEY (FollowID)
)

GO

--资料管理
INSERT INTO dbo.Sys_App (App_name,App_order,App_url,App_handler,App_type,App_icon)
VALUES  ('资料管理', -- App_name - varchar(100)
         55, -- App_order - int
         NULL, -- App_url - varchar(250)
         NULL, -- App_handler - varchar(250)
         NULL, -- App_type - varchar(50)
         'images/icon/39.png'  -- App_icon - varchar(250)
         )
GO

--积分管理
INSERT INTO dbo.Sys_App (App_name,App_order,App_url,App_handler,App_type,App_icon)
VALUES  ('积分管理', -- App_name - varchar(100)
         58, -- App_order - int
         NULL, -- App_url - varchar(250)
         NULL, -- App_handler - varchar(250)
         NULL, -- App_type - varchar(50)
         'images/icon/26.png'  -- App_icon - varchar(250)
         )

INSERT INTO dbo.Sys_Menu (Menu_name,parentid,parentname,App_id,Menu_url,Menu_icon,Menu_handler,Menu_order,Menu_type)
VALUES  ('积分管理', -- Menu_name - varchar(255)
         0, -- parentid - int
         '无', -- parentname - varchar(255)
         8, -- App_id - int
         '', -- Menu_url - varchar(255)
         'images/icon/37.png', -- Menu_icon - varchar(50)
         NULL, -- Menu_handler - varchar(50)
         10, -- Menu_order - int
         'sys'  -- Menu_type - varchar(50)
         )
INSERT INTO dbo.Sys_Menu (Menu_name,parentid,parentname,App_id,Menu_url,Menu_icon,Menu_handler,Menu_order,Menu_type)
VALUES  ('客户积分', -- Menu_name - varchar(255)
         92, -- parentid - int
         '积分管理', -- parentname - varchar(255)
         8, -- App_id - int
         'CRM/Jifen/Jifen_kh.aspx', -- Menu_url - varchar(255)
         'images/icon/37.png', -- Menu_icon - varchar(50)
         NULL, -- Menu_handler - varchar(50)
         10, -- Menu_order - int
         'sys'  -- Menu_type - varchar(50)
         )
INSERT INTO dbo.Sys_Menu (Menu_name,parentid,parentname,App_id,Menu_url,Menu_icon,Menu_handler,Menu_order,Menu_type)
VALUES  ('员工积分', -- Menu_name - varchar(255)
         92, -- parentid - int
         '积分管理', -- parentname - varchar(255)
         8, -- App_id - int
         'CRM/Jifen/Jifen_yg.aspx', -- Menu_url - varchar(255)
         'images/icon/38.png', -- Menu_icon - varchar(50)
         NULL, -- Menu_handler - varchar(50)
         20, -- Menu_order - int
         'sys'  -- Menu_type - varchar(50)
         )

INSERT INTO dbo.Sys_Button (Btn_name,Btn_icon,Btn_handler,Menu_id,Menu_name,Btn_order)
VALUES ('发放积分','images/icon/11.png','add()','93','客户积分','10')
INSERT INTO dbo.Sys_Button (Btn_name,Btn_icon,Btn_handler,Menu_id,Menu_name,Btn_order)
VALUES ('使用积分','images/icon/85.png','add1()','93','客户积分','20')
INSERT INTO dbo.Sys_Button (Btn_name,Btn_icon,Btn_handler,Menu_id,Menu_name,Btn_order)
VALUES ('修改积分','images/icon/33.png','edit()','94','客户积分','30')
INSERT INTO dbo.Sys_Button (Btn_name,Btn_icon,Btn_handler,Menu_id,Menu_name,Btn_order)
VALUES ('删除积分','images/icon/12.png','del()','94','客户积分','40')
GO

--增加积分表
IF(OBJECT_ID('CRM_Jifen')>0)
	DROP TABLE dbo.CRM_Jifen
CREATE TABLE dbo.CRM_Jifen(
	JfID INT NOT NULL IDENTITY(1,1),
	Jflx INT,
	ID INT,
	Jf INT,
	Sfkh CHAR(1),
	Content VARCHAR(250),
	InEmpID INT,
	InDate DATETIME,
	EditEmpID INT,
	EditDate DATETIME,
	IsDel CHAR(1),
	DelEmpID INT,
	DelDate DATETIME
	PRIMARY KEY (JfID)
)

GO

--数据分页查询过程
CREATE PROCEDURE [dbo].[usp_GetPagerData] (
	@recordTotal INT OUTPUT,            --输出记录总数
    @viewName VARCHAR(800),        --表名
    @fieldName VARCHAR(800) = '*',        --查询字段
    @keyName VARCHAR(200) = 'ID',            --索引字段
    @pageSize INT = 30,                    --每页记录数
    @pageNo INT =1,                    --当前页
    @orderString VARCHAR(200),        --排序条件
    @whereString VARCHAR(800) = '1=1'        --WHERE条件
)
AS
BEGIN
	DECLARE @beginRow INT
	DECLARE @endRow INT
	DECLARE @tempLimit VARCHAR(200)
	DECLARE @tempCount NVARCHAR(1000)
	DECLARE @tempMain VARCHAR(1000)

	SET @beginRow = (@pageNo - 1) * @pageSize + 1
	SET @endRow = @pageNo * @pageSize
	SET @tempLimit = 'rows BETWEEN ' + CAST(@beginRow AS VARCHAR) +' AND '+CAST(@endRow AS VARCHAR)

	--输出参数为总记录数
	SET @tempCount = 'SELECT @recordTotal = COUNT(*) FROM (SELECT '+@keyName+' FROM '+@viewName+' WHERE '+@whereString+') AS my_temp'
	EXECUTE sp_executesql @tempCount,N'@recordTotal INT OUTPUT',@recordTotal OUTPUT

	--主查询返回结果集
	SET @tempMain = '
		SELECT * FROM (
			SELECT ROW_NUMBER() OVER (ORDER BY '+@orderString+') AS rows,'+@fieldName+' 
			FROM '+@viewName+' 
			WHERE '+@whereString+') AS main_temp 
		WHERE '+@tempLimit
     
	PRINT @tempMain
	EXECUTE (@tempMain)
END
GO
--维修单信息
CREATE VIEW [dbo].[v_Repair]
AS
SELECT A.RepairID,A.Sfkh,A.Khbh,A.Khmc,A.Khdh,A.Khyx,A.Khdz,A.Khxq,A.Khxb,CONVERT(VARCHAR(10),A.Wxrq,120) AS Wxrq,
	A.Wxsj,A.WxlbID,B.params_name AS Wxlb,A.Wxyy,A.IsDel,
	CONVERT(VARCHAR(10),A.Clrq,120) AS Clrq,CONVERT(VARCHAR(10),A.Wcrq,120) AS Wcrq,A.Wczt,A.Fzxs,A.Hfxx,A.Pjxx,
	A.WxEmpID,F.name AS WxEmpName,A.GdEmpID,G.name AS GdEmpName,
	A.InEmpID,C.name AS InEmpName,CONVERT(VARCHAR(20),A.InDate,120) AS InDate,
	A.EditEmpID,D.name AS EditEmpName,CONVERT(VARCHAR(20),A.EditDate,120) AS EditDate,
	A.ClEmpID,H.name AS ClEmpName,CONVERT(VARCHAR(20),A.ClDate,120) AS ClDate,
	A.DelEmpID,E.name AS DelEmpName,CONVERT(VARCHAR(20),A.DelDate,120) AS DelDate,
	CASE WHEN ISNULL(Wczt,'未完成')='未完成' THEN DATEDIFF(DAY,A.InDate,CONVERT(VARCHAR(10),GETDATE(),120)) ELSE 0 END AS Wwts,
	DATEDIFF(DAY,ISNULL(CONVERT(VARCHAR(10),J.InDate,120),CONVERT(VARCHAR(10),A.InDate,120)),CONVERT(VARCHAR(10),GETDATE(),120)) AS Wgts
FROM dbo.CRM_Repair A
LEFT JOIN dbo.Param_SysParam B ON A.WxlbID=B.ID
LEFT JOIN dbo.hr_employee C ON A.InEmpID=C.ID
LEFT JOIN dbo.hr_employee D ON A.EditEmpID=D.ID
LEFT JOIN dbo.hr_employee E ON A.DelEmpID=E.ID
LEFT JOIN dbo.hr_employee F ON A.WxEmpID=F.ID
LEFT JOIN dbo.hr_employee G ON A.GdEmpID=G.ID
LEFT JOIN dbo.hr_employee H ON A.ClEmpID=H.ID
LEFT JOIN dbo.CRM_Repair_Follow J ON A.RepairID=J.RepairID AND J.IsLastIn='Y'
GO

--客户积分汇总
ALTER VIEW [dbo].[v_Jifen_Kh]
AS
SELECT a.ID,a.Customer AS Name,a.Tel,a.Gender AS Sex,ISNULL(b.Jf,0) AS Jf,ISNULL(b.Jf1,0) AS Jf1,ISNULL(-b.Jf2,0) AS Jf2,
	a.Provinces+a.City+a.Towns+a.Community AS Khdz
FROM dbo.CRM_Customer a
LEFT JOIN (
	SELECT a.ID,a.Jf1-ISNULL(b.Jf2,0) AS Jf,a.Jf1,b.Jf2 FROM (
		SELECT ID,SUM(Jf) AS Jf1 FROM dbo.CRM_Jifen
		WHERE Sfkh='Y' AND Jflx=0 AND IsDel='N'
		GROUP BY ID) a
	LEFT JOIN (
		SELECT ID,SUM(Jf) AS Jf2 FROM dbo.CRM_Jifen
		WHERE Sfkh='Y' AND Jflx=1 AND IsDel='N'
		GROUP BY ID) b ON a.ID=b.ID
) b ON a.ID=b.ID
GO
--员工积分汇总
CREATE VIEW [dbo].[v_Jifen_Yg]
AS
SELECT a.ID,a.Name,a.Tel,a.Sex,ISNULL(b.Jf,0) AS Jf,ISNULL(b.Jf1,0) AS Jf1,ISNULL(-b.Jf2,0) AS Jf2
FROM dbo.hr_employee a
LEFT JOIN (
	SELECT a.ID,a.Jf1-ISNULL(b.Jf2,0) AS Jf,a.Jf1,b.Jf2 FROM (
		SELECT ID,SUM(Jf) AS Jf1 FROM dbo.CRM_Jifen
		WHERE Sfkh='N' AND Jflx=0 AND IsDel='N'
		GROUP BY ID) a
	LEFT JOIN (
		SELECT ID,SUM(Jf) AS Jf2 FROM dbo.CRM_Jifen
		WHERE Sfkh='N' AND Jflx=1 AND IsDel='N'
		GROUP BY ID) b ON a.ID=b.ID
) b ON a.ID=b.ID
WHERE a.d_id<>'0'
GO
--客户积分明细
CREATE VIEW [dbo].[v_Jifen_Kh_Mx]
AS
SELECT a.JfID,a.ID,CASE WHEN a.Jflx=0 THEN '发放积分' ELSE '使用积分' END AS Jflx,
CASE WHEN a.Jflx=0 THEN a.Jf ELSE -a.Jf END AS Jf,a.Content,
	a.InEmpID,b.name AS InEmpName,CONVERT(CHAR(16),a.InDate,120) AS InDate
FROM dbo.CRM_Jifen a
LEFT JOIN dbo.hr_employee b ON a.InEmpID=b.id
WHERE a.Sfkh='Y' AND a.IsDel='N'
GO
--员工积分明细
CREATE VIEW [dbo].[v_Jifen_Yg_Mx]
AS
SELECT a.JfID,a.ID,CASE WHEN a.Jflx=0 THEN '发放积分' ELSE '使用积分' END AS Jflx,
CASE WHEN a.Jflx=0 THEN a.Jf ELSE -a.Jf END AS Jf,a.Content,
	a.InEmpID,b.name AS InEmpName,CONVERT(CHAR(16),a.InDate,120) AS InDate
FROM dbo.CRM_Jifen a
LEFT JOIN dbo.hr_employee b ON a.InEmpID=b.id
WHERE a.Sfkh='N' AND a.IsDel='N'
GO

--屏蔽客户导入功能
UPDATE dbo.Sys_Button SET Menu_id=-1 WHERE Btn_id=99

--产品中增加选样、网址
ALTER TABLE dbo.CRM_product ADD t_content NVARCHAR(max)
ALTER TABLE dbo.CRM_product ADD url VARCHAR(500)

--产品中增加二维码打印功能
INSERT INTO dbo.Sys_Button (Btn_name,Btn_icon,Btn_handler,Menu_id,Menu_name,Btn_order)
VALUES  ('打印', -- Btn_name - varchar(255)
         'images/icon/79.png', -- Btn_icon - varchar(50)
         'prt()', -- Btn_handler - varchar(255)
         39, -- Menu_id - int
         '产品列表', -- Menu_name - varchar(255)
         40  -- Btn_order - int
         )
--产品管理放入资料管理中
UPDATE dbo.Sys_Menu SET App_id=7 
WHERE Menu_id IN (38,39,44)
GO
/************资料管理************/
--修正产品管理菜单排序
UPDATE dbo.Sys_Menu set Menu_order='10' WHERE Menu_id=38
--增加菜单
INSERT INTO dbo.Sys_Menu (Menu_name,parentid,parentname,App_id,Menu_url,Menu_icon,Menu_handler,Menu_order,Menu_type)
VALUES  ('资料管理', -- Menu_name - varchar(255)
         0, -- parentid - int
         '无', -- parentname - varchar(255)
         7, -- App_id - int
         '', -- Menu_url - varchar(255)
         'images/icon/37.png', -- Menu_icon - varchar(50)
         NULL, -- Menu_handler - varchar(50)
         20, -- Menu_order - int
         'sys'  -- Menu_type - varchar(50)
         )
INSERT INTO dbo.Sys_Menu (Menu_name,parentid,parentname,App_id,Menu_url,Menu_icon,Menu_handler,Menu_order,Menu_type)
VALUES  ('资料类别', -- Menu_name - varchar(255)
         95, -- parentid - int
         '资料管理', -- parentname - varchar(255)
         7, -- App_id - int
         'CRM/DataShare/public_data_category.aspx', -- Menu_url - varchar(255)
         'images/icon/82.png', -- Menu_icon - varchar(50)
         NULL, -- Menu_handler - varchar(50)
         10, -- Menu_order - int
         'sys'  -- Menu_type - varchar(50)
         )
INSERT INTO dbo.Sys_Menu (Menu_name,parentid,parentname,App_id,Menu_url,Menu_icon,Menu_handler,Menu_order,Menu_type)
VALUES  ('资料列表', -- Menu_name - varchar(255)
         95, -- parentid - int
         '资料管理', -- parentname - varchar(255)
         7, -- App_id - int
         'CRM/DataShare/public_data.aspx', -- Menu_url - varchar(255)
         'images/icon/39.png', -- Menu_icon - varchar(50)
         NULL, -- Menu_handler - varchar(50)
         20, -- Menu_order - int
         'sys'  -- Menu_type - varchar(50)
         )
--新建资料类别表
CREATE TABLE dbo.public_data_category
(
[id] [int] NOT NULL IDENTITY(1, 1),
[category] [varchar] (250),
[parentid] [int] NULL,
[icon] [varchar] (250),
[isDelete] [int] NULL,
[Delete_id] [int] NULL,
[Delete_time] [datetime] NULL,
[orderid] [int] NULL
PRIMARY KEY (id)
)
GO
CREATE TABLE dbo.public_data
(
[id] [int] NOT NULL IDENTITY(1, 1),
[category_id] [int],
[category_name] [varchar] (250),
[title] [nvarchar] (250),
[t_content] [nvarchar] (max),
[create_id] [int],
[create_name] [varchar] (250),
[create_time] [datetime],
[isDelete] [int],
[Delete_time] [datetime],
[orderid] [int] NULL
PRIMARY KEY (id))
GO

/************系统帮助************/

--增加菜单
CREATE TABLE dbo.sys_reginfo
(
[MNum] [varchar] (500) NOT NULL,
[MInDate] [datetime],
[RNum] [varchar] (500)
PRIMARY KEY (MNum)
)
GO
INSERT INTO dbo.Sys_Menu (Menu_name,parentid,parentname,App_id,Menu_url,Menu_icon,Menu_handler,Menu_order,Menu_type)
VALUES  ('系统帮助', -- Menu_name - varchar(255)
         0, -- parentid - int
         '无', -- parentname - varchar(255)
         7, -- App_id - int
         '', -- Menu_url - varchar(255)
         'images/icon/37.png', -- Menu_icon - varchar(50)
         NULL, -- Menu_handler - varchar(50)
         30, -- Menu_order - int
         'sys'  -- Menu_type - varchar(50)
         )
INSERT INTO dbo.Sys_Menu (Menu_name,parentid,parentname,App_id,Menu_url,Menu_icon,Menu_handler,Menu_order,Menu_type)
VALUES  ('帮助目录', -- Menu_name - varchar(255)
         98, -- parentid - int
         '系统帮助', -- parentname - varchar(255)
         7, -- App_id - int
         'CRM/Help/help_category.aspx', -- Menu_url - varchar(255)
         'images/icon/82.png', -- Menu_icon - varchar(50)
         NULL, -- Menu_handler - varchar(50)
         10, -- Menu_order - int
         'sys'  -- Menu_type - varchar(50)
         )
INSERT INTO dbo.Sys_Menu (Menu_name,parentid,parentname,App_id,Menu_url,Menu_icon,Menu_handler,Menu_order,Menu_type)
VALUES  ('帮助列表', -- Menu_name - varchar(255)
         98, -- parentid - int
         '系统帮助', -- parentname - varchar(255)
         7, -- App_id - int
         'CRM/Help/help.aspx', -- Menu_url - varchar(255)
         'images/icon/51.png', -- Menu_icon - varchar(50)
         NULL, -- Menu_handler - varchar(50)
         20, -- Menu_order - int
         'sys'  -- Menu_type - varchar(50)
         )
GO
INSERT INTO dbo.Sys_Button (Btn_name,Btn_icon,Btn_handler,Menu_id,Menu_name,Btn_order)
VALUES ('新增','images/icon/11.png','add()','98','系统帮助','10')
INSERT INTO dbo.Sys_Button (Btn_name,Btn_icon,Btn_handler,Menu_id,Menu_name,Btn_order)
VALUES ('修改','images/icon/33.png','edit()','98','系统帮助','20')
INSERT INTO dbo.Sys_Button (Btn_name,Btn_icon,Btn_handler,Menu_id,Menu_name,Btn_order)
VALUES ('删除','images/icon/12.png','del()','98','系统帮助','30')
GO

--新建帮助类别表
CREATE TABLE dbo.public_help_category
(
[id] [int] NOT NULL IDENTITY(1, 1),
[category] [varchar] (250),
[parentid] [int] NULL,
[icon] [varchar] (250),
[isDelete] [int] NULL,
[Delete_id] [int] NULL,
[Delete_time] [datetime] NULL,
[orderid] [int] NULL
PRIMARY KEY (id)
)
GO
CREATE TABLE dbo.public_help
(
[id] [int] NOT NULL IDENTITY(1, 1),
[category_id] [int],
[category_name] [varchar] (250),
[title] [nvarchar] (250),
[t_content] [nvarchar] (max),
[create_id] [int],
[create_name] [varchar] (250),
[create_time] [datetime],
[isDelete] [int],
[Delete_time] [datetime],
[orderid] [int] NULL
PRIMARY KEY (id))
GO

--修改CRM回收站为实用工具
UPDATE dbo.Sys_Menu SET Menu_name='实用工具' WHERE Menu_id=46
UPDATE dbo.Sys_Menu SET Menu_name='二维码生成',Menu_url='View/QrCode_Generate.aspx'  WHERE Menu_id=47
--修改资料管理菜单
UPDATE dbo.Sys_Menu SET Menu_url='CRM/DataShare/public_data_category.aspx'  WHERE Menu_id=96
UPDATE dbo.Sys_Menu SET Menu_url='CRM/DataShare/public_data.aspx'  WHERE Menu_id=97

--建立系统帮助视图
CREATE VIEW V_public_help_category
AS
SELECT * FROM XCZS.dbo.public_help_category
GO
CREATE VIEW V_public_help
AS
SELECT * FROM XCZS.dbo.public_help
GO
--建立资料共享视图
CREATE VIEW V_public_data_category
AS
SELECT * FROM XCZS.dbo.public_data_category
GO
CREATE VIEW V_public_data
AS
SELECT * FROM XCZS.dbo.public_data
GO
--增加共享资料菜单
INSERT INTO dbo.Sys_Menu (Menu_id,Menu_name,parentid,parentname,App_id,Menu_url,Menu_icon,Menu_handler,Menu_order,Menu_type)
VALUES  (110, -- Menu_id - int
         '共享资料', -- Menu_name - varchar(255)
         95, -- parentid - int
         '资料管理', -- parentname - varchar(255)
         7, -- App_id - int
         'CRM/DataShare/public_data_share.aspx', -- Menu_url - varchar(255)
         'images/icon/40.png', -- Menu_icon - varchar(50)
         NULL, -- Menu_handler - varchar(50)
         30, -- Menu_order - int
         'sys'  -- Menu_type - varchar(50)
         )
--收藏功能
INSERT INTO dbo.Param_SysParam_Type (id,params_name,params_order,isDelete,Delete_time)
VALUES  (13, -- id - int
         '收藏类别', -- params_name - varchar(250)
         51, -- params_order - int
         NULL, -- isDelete - int
         NULL  -- Delete_time - datetime
         )
INSERT INTO dbo.Sys_Menu (Menu_id,Menu_name,parentid,parentname,App_id,Menu_url,Menu_icon,Menu_handler,Menu_order,Menu_type)
VALUES  (120, -- Menu_id - int
		 '用户收藏', -- Menu_name - varchar(255)
         0, -- parentid - int
         '无', -- parentname - varchar(255)
         7, -- App_id - int
         '', -- Menu_url - varchar(255)
         'images/icon/41.png', -- Menu_icon - varchar(50)
         NULL, -- Menu_handler - varchar(50)
         30, -- Menu_order - int
         'sys'  -- Menu_type - varchar(50)
         )
INSERT INTO dbo.Sys_Menu (Menu_id,Menu_name,parentid,parentname,App_id,Menu_url,Menu_icon,Menu_handler,Menu_order,Menu_type)
VALUES  (121, -- Menu_id - int
		 '收藏列表', -- Menu_name - varchar(255)
         120, -- parentid - int
         '用户收藏', -- parentname - varchar(255)
         7, -- App_id - int
         'CRM/Favorites/Favorites.aspx', -- Menu_url - varchar(255)
         'images/icon/42.png', -- Menu_icon - varchar(50)
         NULL, -- Menu_handler - varchar(50)
         10, -- Menu_order - int
         'sys'  -- Menu_type - varchar(50)
         )
INSERT INTO dbo.Sys_Button (Btn_name,Btn_icon,Btn_handler,Menu_id,Menu_name,Btn_order)
VALUES ('新增','images/icon/11.png','add()','121','收藏列表','10')
INSERT INTO dbo.Sys_Button (Btn_name,Btn_icon,Btn_handler,Menu_id,Menu_name,Btn_order)
VALUES ('修改','images/icon/33.png','edit()','121','收藏列表','20')
INSERT INTO dbo.Sys_Button (Btn_name,Btn_icon,Btn_handler,Menu_id,Menu_name,Btn_order)
VALUES ('置为公共','images/icon/50.png','process()','121','收藏列表','30')
INSERT INTO dbo.Sys_Button (Btn_name,Btn_icon,Btn_handler,Menu_id,Menu_name,Btn_order)
VALUES ('删除','images/icon/12.png','del()','121','收藏列表','40')

--增加收藏表结构
IF(OBJECT_ID('CRM_Favorites')>0)
	DROP TABLE dbo.CRM_Favorites
CREATE TABLE dbo.CRM_Favorites(
	ID INT NOT NULL IDENTITY(1,1),
	Name VARCHAR(100),
	Url VARCHAR(100),
	Content VARCHAR(250),
	PicUrl VARCHAR(100),
	IsShowPic CHAR(1),
	CategoryID INT,
	IsPublic CHAR(1),
	OrderID INT,
	InEmpID INT,
	InDate DATETIME,
	EditEmpID INT,
	EditDate DATETIME,
	IsDel CHAR(1),
	DelEmpID INT,
	DelDate DATETIME
	PRIMARY KEY (ID)
)
GO
IF(OBJECT_ID('v_CRM_Favorites')>0)
	DROP VIEW dbo.v_CRM_Favorites
GO
CREATE VIEW [dbo].[v_CRM_Favorites]
AS
SELECT A.ID,A.Name,A.Url,A.Content,A.PicUrl,A.CategoryID,
	CASE WHEN A.IsShowPic='Y' THEN '是' ELSE '否' END AS IsShowPicName,A.IsShowPic,
	CASE WHEN A.IsPublic='Y' THEN '是' ELSE '否' END AS IsPublicName,A.IsPublic,
	A.OrderID,B.params_name AS CategoryName,A.IsDel,
	A.InEmpID,C.name AS InEmpName,CONVERT(VARCHAR(20),A.InDate,120) AS InDate,
	A.EditEmpID,D.name AS EditEmpName,CONVERT(VARCHAR(20),A.EditDate,120) AS EditDate,
	A.DelEmpID,E.name AS DelEmpName,CONVERT(VARCHAR(20),A.DelDate,120) AS DelDate
FROM dbo.CRM_Favorites A
LEFT JOIN dbo.Param_SysParam B ON A.CategoryID=B.ID
LEFT JOIN dbo.hr_employee C ON A.InEmpID=C.ID
LEFT JOIN dbo.hr_employee D ON A.EditEmpID=D.ID
LEFT JOIN dbo.hr_employee E ON A.DelEmpID=E.ID
GO

--建立用户收藏视图
CREATE VIEW v_CRM_Favorites_Share
AS
SELECT * FROM XCZS.dbo.v_CRM_Favorites
GO
--更新共享资料菜单URL
UPDATE dbo.Sys_Menu
SET Menu_url='CRM/DataShare/Favorites_Adv_View.aspx'
WHERE Menu_id=110

SELECT * FROM dbo.v_CRM_Favorites

--增加楼盘管理菜单
UPDATE dbo.Sys_Menu SET Menu_icon='images/icon/37.png' WHERE Menu_id=4
INSERT INTO dbo.Sys_Menu (Menu_id,Menu_name,parentid,parentname,App_id,Menu_url,Menu_icon,Menu_handler,Menu_order,
                           Menu_type)
VALUES  (130, -- Menu_id - int
         '楼盘管理', -- Menu_name - varchar(255)
         3, -- parentid - int
         '客户管理', -- parentname - varchar(255)
         2, -- App_id - int
         'crm/Building/Building.aspx', -- Menu_url - varchar(255)
         'images/icon/61.png', -- Menu_icon - varchar(50)
         NULL, -- Menu_handler - varchar(50)
         40, -- Menu_order - int
         'sys'  -- Menu_type - varchar(50)
         )

DROP TABLE dbo.CRM_Building
CREATE TABLE [dbo].[CRM_Building]
(
[ID] SMALLINT NOT NULL IDENTITY(1, 1),
[ProvincesID] SMALLINT,
[Provinces] NVARCHAR(50),
[CityID] SMALLINT,
[City] NVARCHAR(50),
[TownsID] SMALLINT,
[Towns] NVARCHAR(50),
[Name] NVARCHAR(50),
[Address] NVARCHAR(500),
[Jzlb] NVARCHAR(50),
[Rjl] VARCHAR(10),
[Lhl] VARCHAR(10),
[Kpsj] NVARCHAR(50),
[Wygs] NVARCHAR(50),
[Wydh] NVARCHAR(50),
[Wyf] NVARCHAR(50),
[Sldh] NVARCHAR(50),
[Kfs] NVARCHAR(50),
[Jtzk] NVARCHAR(500),
[Jj] NVARCHAR(50),
[Remark] NVARCHAR(500),
[InEmpID] SMALLINT,
[InDate] DATETIME,
[EditEmpID] SMALLINT,
[EditDate] DATETIME,
[IsDel] CHAR(1),
[DelEmpID] SMALLINT,
[DelDate] DATETIME
PRIMARY KEY ([ID])
)

INSERT INTO dbo.CRM_Building (ProvincesID,Provinces,CityID,City,TownsID,Towns,Name,Address,Jzlb,Rjl,Lhl,Kpsj,Wygs,Wydh,
                               Wyf,Sldh,Kfs,Jtzk,Jj,Remark,InEmpID,InDate,EditEmpID,EditDate,IsDel,DelEmpID,DelDate)
VALUES  (1, -- ProvincesID - smallint
         N'江苏省', -- Provinces - nvarchar(50)
         0, -- CityID - smallint
         N'昆山市', -- City - nvarchar(50)
         0, -- TownsID - smallint
         N'开发区', -- Towns - nvarchar(50)
         N'世茂东一号', -- Name - nvarchar(50)
         N'江苏省昆山市前进路333号', -- Address - nvarchar(500)
         N'小高层 高层', -- Jzlb - nvarchar(50)
         '2.5', -- Rjl - varchar(10)
         '35%', -- Lhl - varchar(10)
         N'一期2010年5月，二期2014年7月', -- Kpsj - nvarchar(50)
         N'世茂物业', -- Wygs - nvarchar(50)
         N'57875555', -- Wydh - nvarchar(50)
         N'1.9元/平方米 月', -- Wyf - nvarchar(50)
         N'38888888', -- Sldh - nvarchar(50)
         N'世茂集团', -- Kfs - nvarchar(50)
         N'7路、8路世茂广场下', -- Jtzk - nvarchar(500)
         N'8000元/平方米', -- Jj - nvarchar(50)
         N'重点发展小区', -- Remark - nvarchar(500)
         0, -- InEmpID - smallint
         '2015-08-03 14:13:19', -- InDate - datetime
         0, -- EditEmpID - smallint
         '2015-08-03 14:13:19', -- EditDate - datetime
         'N', -- IsDel - char(1)
         0, -- DelEmpID - smallint
         '2015-08-03 14:13:19'  -- DelDate - datetime
         )

SELECT * FROM dbo.CRM_Building