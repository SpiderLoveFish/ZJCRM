/****** Object:  Table [dbo].[tool_batch]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[tool_batch](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[batch_type] [varchar](50) NULL,
	[o_dep_id] [int] NULL,
	[o_dep] [varchar](250) NULL,
	[o_emp_id] [int] NULL,
	[o_emp] [varchar](250) NULL,
	[c_dep_id] [int] NULL,
	[c_dep] [varchar](250) NULL,
	[c_emp_id] [int] NULL,
	[c_emp] [varchar](250) NULL,
	[b_count] [int] NULL,
	[create_id] [int] NULL,
	[create_name] [varchar](250) NULL,
	[create_date] [datetime] NULL,
 CONSTRAINT [PK_tool_batch] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[sys_role_emp]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[sys_role_emp](
	[RoleID] [int] NOT NULL,
	[empID] [int] NOT NULL
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[Sys_role]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[Sys_role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](255) NULL,
	[RoleDscript] [varchar](255) NULL,
	[RoleSort] [int] NULL,
	[CreateID] [int] NULL,
	[CreateDate] [datetime] NULL,
	[UpdateID] [int] NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_Sys_role] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

SET IDENTITY_INSERT [dbo].[Sys_role] ON
INSERT [dbo].[Sys_role] ([RoleID], [RoleName], [RoleDscript], [RoleSort], [CreateID], [CreateDate], [UpdateID], [UpdateDate]) VALUES (1, N'系统管理员', N'拥有全部权限', 999, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Sys_role] OFF

GO


/****** Object:  Table [dbo].[Sys_online]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[Sys_online](
	[UserID] [int] NULL,
	[UserName] [varchar](50) NULL,
	[LastLogTime] [datetime] NULL
) ON [PRIMARY]
INSERT [dbo].[Sys_online] ([UserID], [UserName], [LastLogTime]) VALUES (1, N'超级管理员', CAST(0x0000A41600A7AC84 AS DateTime))

GO


/****** Object:  Table [dbo].[Sys_Menu]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[Sys_Menu](
	[Menu_id] [int] IDENTITY(1,1) NOT NULL,
	[Menu_name] [varchar](255) NULL,
	[parentid] [int] NULL,
	[parentname] [varchar](255) NULL,
	[App_id] [int] NULL,
	[Menu_url] [varchar](255) NULL,
	[Menu_icon] [varchar](50) NULL,
	[Menu_handler] [varchar](50) NULL,
	[Menu_order] [int] NULL,
	[Menu_type] [varchar](50) NULL,
 CONSTRAINT [PK_Sys_Menu] PRIMARY KEY CLUSTERED 
(
	[Menu_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


SET IDENTITY_INSERT [dbo].[Sys_Menu] ON
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (1, N'个人工作', 0, N'无', 1, N'', N'images/icon/37.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (2, N'我的便签', 1, N'个人工作', 1, N'personal/personal/notes.aspx', N'images/icon/33.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (3, N'客户管理', 0, N'无', 2, N'', N'images/icon/37.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (4, N'客户列表', 3, N'客户管理', 2, N'crm/Customer/customer.aspx', N'images/icon/61.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (5, N'联系人管理', 3, N'客户管理', 2, N'crm/Customer/customer_contact.aspx', N'images/icon/38.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (6, N'跟进管理', 3, N'客户管理', 2, N'crm/Customer/customer_follow.aspx', N'images/icon/3.png', NULL, 30, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (7, N'日程安排', 1, N'个人工作', 1, N'personal/personal/Calendar.aspx', N'images/icon/29.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (8, N'邮箱', 0, N'无', -1, N'', N'images/icon/48.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (9, N'收件箱', 8, N'邮箱', 1, N'', N'images/icon/47.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (10, N'草稿箱', 8, N'邮箱', 1, N'', N'images/icon/48.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (11, N'已发送', 8, N'邮箱', 1, N'', N'images/icon/43.png', NULL, 30, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (12, N'信息中心', 0, N'无', 1, N'', N'images/icon/56.png', NULL, 30, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (13, N'新闻', 12, N'信息中心', 1, N'personal/message/news.aspx', N'images/icon/57.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (14, N'公告', 12, N'信息中心', 1, N'personal/message/notice.aspx', N'images/icon/58.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (15, N'论坛', -1, N'信息中心', 1, N'', N'images/icon/62.png', NULL, 30, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (16, N'知识库', -1, N'信息中心', 1, N'', N'images/icon/68.png', NULL, 40, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (17, N'人事架构', 0, N'无', 3, N'', N'images/icon/37.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (18, N'人事资料', -1, N'无', 3, N'', N'images/icon/37.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (19, N'人事培训', -1, N'无', 3, N'', N'images/icon/37.png', NULL, 30, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (20, N'人事报表', 0, N'无', -1, N'', N'images/icon/37.png', NULL, 40, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (21, N'组织架构', 17, N'人事架构', 3, N'hr/hr_department.aspx', N'images/icon/67.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (22, N'职务管理', 17, N'人事架构', 3, N'hr/hr_position.aspx', N'images/icon/68.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (23, N'岗位管理', 17, N'人事架构', 3, N'hr/hr_post.aspx', N'images/icon/49.png', NULL, 30, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (24, N'员工管理', 17, N'人事架构', 3, N'hr/hr_employee.aspx', N'images/icon/37.png', NULL, 40, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (25, N'人事异动', -1, N'人事资料', 3, N'', N'images/icon/43.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (26, N'劳动合同', 19, N'人事资料', 3, N'hr/hr_contract.aspx', N'images/icon/24.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (27, N'社保管理', -1, N'人事资料', 3, N'', N'images/icon/29.png', NULL, 30, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (28, N'培训记录', -1, N'人事培训', 3, N'', N'images/icon/24.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (29, N'讲师团队', -1, N'人事培训', 3, N'', N'images/icon/38.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (30, N'系统管理', 0, N'无', 6, N'', N'images/icon/77.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (31, N'角色授权', 30, N'系统管理', 6, N'System/Sys_role.aspx', N'images/icon/70.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (32, N'日志管理', 30, N'系统管理', 6, N'system/sys_log.aspx', N'images/icon/51.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (33, N'合同订单', 0, N'无', 2, N'', N'images/icon/5.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (34, N'订单管理', 33, N'销售管理', 2, N'crm/sale/Order.aspx', N'images/icon/27.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (35, N'合同管理', 33, N'销售管理', 2, N'crm/sale/contract.aspx', N'images/icon/22.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (36, N'收款管理', 45, N'财务管理', 2, N'crm/finance/receive.aspx', N'images/icon/39.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (37, N'开票管理', 45, N'财务管理', 2, N'crm/finance/invoice.aspx', N'images/icon/28.png', NULL, 30, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (38, N'产品管理', 0, N'无', 2, N'', N'images/icon/67.png', NULL, 40, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (39, N'产品列表', 38, N'产品管理', 2, N'crm/Product/product.aspx', N'images/icon/67.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (40, N'数据年报', 0, N'无', 5, N'', N'images/icon/53.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (41, N'客户统计年报', 40, N'CRM报表中心', 5, N'reportform/crm/CRM_report_year.aspx', N'images/icon/53.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (42, N'跟进统计年报', 40, N'CRM报表中心', 5, N'reportform/crm/Follow_report_year.aspx', N'images/icon/54.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (43, N'参数配置', 30, N'系统管理', 6, N'system/Param_SysParam.aspx', N'images/icon/77.png', NULL, 30, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (44, N'产品类别', 38, N'产品管理', 2, N'crm/Product/product_category.aspx', N'images/icon/82.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (45, N'财务管理', 0, N'无', 2, N'', N'images/icon/56.png', NULL, 30, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (46, N'CRM回收站', 0, N'无', 4, N'', N'images/icon/12.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (47, N'客户回收', 46, N'CRM回收站', 4, N'toolbar/recycle/crm/customer.aspx', N'images/icon/94.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (48, N'联系人回收', 46, N'CRM回收站', -1, N'toolbar/recycle/crm/contact.aspx', N'images/icon/37.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (49, N'跟进回收', 46, N'CRM回收站', -1, N'toolbar/recycle/crm/follow.aspx', N'images/icon/3.png', NULL, 30, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (50, N'订单回收', 46, N'CRM回收站', -1, N'toolbar/recycle/crm/order.aspx', N'images/icon/27.png', NULL, 40, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (51, N'合同回收', 46, N'CRM回收站', -1, N'toolbar/recycle/crm/contract.aspx', N'images/icon/22.png', NULL, 50, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (52, N'收款单回收', 46, N'CRM回收站', -1, N'toolbar/recycle/crm/receive.aspx', N'images/icon/39.png', NULL, 60, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (53, N'发票回收', 46, N'CRM回收站', -1, N'toolbar/recycle/crm/invoice.aspx', N'images/icon/28.png', NULL, 70, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (54, N'产品类别回收', 46, N'CRM回收站', -1, N'toolbar/recycle/crm/product_category.aspx', N'images/icon/81.png', NULL, 80, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (55, N'产品回收', 46, N'CRM回收站', -1, N'toolbar/recycle/crm/product.aspx', N'images/icon/67.png', NULL, 90, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (56, N'收款流水', 45, N'财务管理', 2, N'crm/finance/receive_list.aspx', N'images/icon/26.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (57, N'发票列表', 45, N'财务管理', 2, N'crm/finance/invoice_list.aspx', N'images/icon/24.png', NULL, 40, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (58, N'批量操作', 0, N'无', 4, N'', N'images/icon/37.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (59, N'按钮管理', 60, N'配置信息', 6, N'system/sys_button.aspx', N'images/icon/85.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (60, N'配置信息', 0, N'无', -1, N'', N'images/icon/37.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (61, N'系统信息', 61, N'配置信息', 6, N'system/sys_info.aspx', N'images/icon/49.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (62, N'应收与未收', 45, N'财务管理', 2, N'crm/finance/receiveanduncollected.aspx', N'/images/icon/54.png', NULL, 50, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (63, N'同比与环比', 0, N'无', 5, N'', N'images/icon/59.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (64, N'【客户】新增', 63, N'同比与环比', 5, N'reportform/Compared/customer_add.aspx', N'images/icon/37.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (65, N'【客户】类型', 63, N'同比与环比', 5, N'reportform/Compared/customer_type.aspx', N'images/icon/33.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (66, N'【客户】级别', 63, N'同比与环比', 5, N'reportform/Compared/customer_level.aspx', N'images/icon/82.png', NULL, 30, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (67, N'【客户】来源', 63, N'同比与环比', 5, N'reportform/Compared/customer_source.aspx', N'images/icon/83.png', NULL, 40, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (68, N'【客户】跟进', 63, N'同比与环比', 5, N'reportform/Compared/customer_follow.aspx', N'images/icon/81.png', NULL, 50, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (69, N'【员工】客户新增', 63, N'同比与环比', 5, N'reportform/Compared/emp_customer_add.aspx', N'images/icon/37.png', NULL, 60, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (70, N'【员工】客户跟进', 63, N'同比与环比', 5, N'reportform/Compared/emp_customer_follow.aspx', N'images/icon/38.png', NULL, 70, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (71, N'【员工】客户成交', 63, N'同比与环比', 5, N'reportform/Compared/emp_customer_contract.aspx', N'images/icon/94.png', NULL, 80, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (72, N'员工分析', 0, N'无', 5, N'', N'images/icon/93.png', NULL, 30, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (73, N'【员工】客户新增统计', 72, N'员工分析', 5, N'reportform/emp/customer_add.aspx', N'images/icon/37.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (74, N'【员工】客户跟进统计', 72, N'员工分析', 5, N'reportform/emp/customer_follow.aspx', N'images/icon/38.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (75, N'【员工】客户成交统计', 72, N'员工分析', 5, N'reportform/emp/customer_contract.aspx', N'images/icon/94.png', NULL, 30, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (76, N'目录管理', 60, N'配置信息', 6, N'system/sys_menu.aspx', N'images/icon/81.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (77, N'收件箱', 77, N'邮件', -1, N'personal/Mail/Mail_inbox.aspx', N'images/icon/39.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (78, N'已发送', 77, N'邮件', -1, N'personal/Mail/mail_send.aspx', N'images/icon/40.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (79, N'垃圾箱', 77, N'邮件', -1, N'personal/Mail/mail_dustbin.aspx', N'images/icon/4.png', NULL, 30, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (80, N'批量转客户', 58, N'人事管理回收站', 4, N'toolbar/batch/batch.aspx', N'images/icon/64.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (81, N'职务回收', 58, N'人事管理回收站', -1, N'toolbar/Recycle/HR/hr_position.aspx', N'images/icon/68.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (82, N'岗位回收', 58, N'人事管理回收站', -1, N'toolbar/Recycle/HR/hr_post.aspx', N'images/icon/49.png', NULL, 30, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (83, N'员工回收', 58, N'人事管理回收站', -1, N'toolbar/Recycle/HR/hr_employee.aspx', N'images/icon/37.png', NULL, 40, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (84, N'城市管理', 30, N'系统管理', 6, N'system/Param_City.aspx', N'images/icon/64.png', NULL, 40, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (85, N'系统信息', 0, N'无', 6, N'', N'images/icon/77.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (86, N'系统信息', 85, N'系统信息', 6, N'system/sys_info.aspx', N'images/icon/77.png', NULL, 10, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (87, N'版本信息', 85, N'系统信息', 6, N'system/sys_version.aspx', N'images/icon/78.png', NULL, 20, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (88, N'销售漏斗', 0, N'无', 5, N'', N'../images/icon/4.png', NULL, 15, N'sys')
INSERT [dbo].[Sys_Menu] ([Menu_id], [Menu_name], [parentid], [parentname], [App_id], [Menu_url], [Menu_icon], [Menu_handler], [Menu_order], [Menu_type]) VALUES (89, N'销售漏斗', 88, N'销售漏斗', 5, N'reportform/funnel/CRM_Report_funnel.aspx', N'../images/icon/4.png', NULL, 20, N'sys')
SET IDENTITY_INSERT [dbo].[Sys_Menu] OFF

/****** Object:  Table [dbo].[Sys_log_Err]    Script Date: 01/05/2015 16:17:29 ******/CREATE TABLE [dbo].[Sys_log_Err](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Err_typeid] [int] NULL,
	[Err_type] [varchar](250) NULL,
	[Err_time] [datetime] NULL,
	[Err_url] [varchar](500) NULL,
	[Err_message] [varchar](max) NULL,
	[Err_source] [varchar](500) NULL,
	[Err_trace] [varchar](max) NULL,
	[Err_emp_id] [int] NULL,
	[Err_emp_name] [varchar](250) NULL,
	[Err_ip] [varchar](250) NULL,
 CONSTRAINT [PK_Sys_log_Err] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[Sys_log]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[Sys_log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[EventType] [varchar](250) NULL,
	[EventID] [varchar](50) NULL,
	[EventTitle] [varchar](250) NULL,
	[Original_txt] [varchar](4000) NULL,
	[Current_txt] [varchar](4000) NULL,
	[UserID] [int] NULL,
	[UserName] [varchar](50) NULL,
	[IPStreet] [varchar](50) NULL,
	[EventDate] [datetime] NULL,
 CONSTRAINT [PK_Sys_log] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[sys_info]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[sys_info](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[sys_key] [varchar](50) NULL,
	[sys_value] [varchar](max) NULL,
 CONSTRAINT [PK_sys_info] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


SET IDENTITY_INSERT [dbo].[sys_info] ON
INSERT [dbo].[sys_info] ([id], [sys_key], [sys_value]) VALUES (1, N'sys_guid', NEWID())
INSERT [dbo].[sys_info] ([id], [sys_key], [sys_value]) VALUES (2, N'sys_name', N'小黄豆软件集团')
INSERT [dbo].[sys_info] ([id], [sys_key], [sys_value]) VALUES (3, N'sys_lo', N'images/logo/logo.png')
INSERT [dbo].[sys_info] ([id], [sys_key], [sys_value]) VALUES (4, N'sys_version', N'v1.16.0.1')
INSERT [dbo].[sys_info] ([id], [sys_key], [sys_value]) VALUES (5, N'sys_vinfo', NULL)
SET IDENTITY_INSERT [dbo].[sys_info] OFF

/****** Object:  Table [dbo].[Sys_data_authority]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[Sys_data_authority](
	[Role_id] [int] NULL,
	[option_id] [int] NULL,
	[Sys_option] [varchar](250) NULL,
	[Sys_view] [int] NULL,
	[Sys_add] [int] NULL,
	[Sys_edit] [int] NULL,
	[Sys_del] [int] NULL,
	[Create_id] [int] NULL,
	[Create_date] [datetime] NULL
) ON [PRIMARY]


GO


INSERT [dbo].[Sys_data_authority] ([Role_id], [option_id], [Sys_option], [Sys_view], [Sys_add], [Sys_edit], [Sys_del], [Create_id], [Create_date]) VALUES (1, 1, N'客户管理', 4, 4, 4, 4, NULL, NULL)
INSERT [dbo].[Sys_data_authority] ([Role_id], [option_id], [Sys_option], [Sys_view], [Sys_add], [Sys_edit], [Sys_del], [Create_id], [Create_date]) VALUES (1, 2, N'跟进管理', 4, 4, 4, 4, NULL, NULL)
INSERT [dbo].[Sys_data_authority] ([Role_id], [option_id], [Sys_option], [Sys_view], [Sys_add], [Sys_edit], [Sys_del], [Create_id], [Create_date]) VALUES (1, 3, N'订单管理', 4, 4, 4, 4, NULL, NULL)
INSERT [dbo].[Sys_data_authority] ([Role_id], [option_id], [Sys_option], [Sys_view], [Sys_add], [Sys_edit], [Sys_del], [Create_id], [Create_date]) VALUES (1, 4, N'合同管理', 4, 4, 4, 4, NULL, NULL)
/****** Object:  Table [dbo].[Sys_Button]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[Sys_Button](
	[Btn_id] [int] IDENTITY(1,1) NOT NULL,
	[Btn_name] [varchar](255) NULL,
	[Btn_icon] [varchar](50) NULL,
	[Btn_handler] [varchar](255) NULL,
	[Menu_id] [int] NULL,
	[Menu_name] [varchar](255) NULL,
	[Btn_order] [int] NULL,
 CONSTRAINT [PK_Sys_Button] PRIMARY KEY CLUSTERED 
(
	[Btn_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


SET IDENTITY_INSERT [dbo].[Sys_Button] ON
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (1, N'新增', N'images/icon/11.png', N'add()', 76, N'目录管理', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (2, N'修改', N'images/icon/33.png', N'edit()', 76, N'目录管理', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (3, N'删除', N'images/icon/12.png', N'del()', 76, N'目录管理', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (4, N'新增', N'images/icon/11.png', N'add()', 59, N'按钮管理', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (5, N'修改', N'images/icon/33.png', N'edit()', 59, N'按钮管理', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (6, N'删除', N'images/icon/12.png', N'del()', 59, N'按钮管理', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (7, N'批量新增', N'images/icon/69.png', N'batch()', 59, N'按钮管理', 40)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (11, N'新增', N'images/icon/11.png', N'add()', 14, N'公告', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (12, N'修改', N'images/icon/33.png', N'edit()', 14, N'公告', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (13, N'删除', N'images/icon/12.png', N'del()', 14, N'公告', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (14, N'删除', N'images/icon/12.png', N'del()', 4, N'客户列表', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (15, N'新增', N'images/icon/11.png', N'add()', 4, N'客户列表', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (16, N'修改', N'images/icon/33.png', N'edit()', 4, N'客户列表', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (17, N'新增跟进', N'images/icon/11.png', N'addfollow()', 6, N'跟进管理', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (18, N'修改跟进', N'images/icon/33.png', N'editfollow()', 6, N'跟进管理', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (19, N'删除跟进', N'images/icon/12.png', N'delfollow()', 6, N'跟进管理', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (20, N'删除', N'images/icon/12.png', N'del()', 21, N'组织架构', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (21, N'新增', N'images/icon/11.png', N'add()', 21, N'组织架构', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (22, N'修改', N'images/icon/33.png', N'edit()', 21, N'组织架构', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (23, N'新增', N'images/icon/11.png', N'add()', 22, N'职务管理', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (24, N'修改', N'images/icon/33.png', N'edit()', 22, N'职务管理', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (25, N'删除', N'images/icon/12.png', N'del()', 22, N'职务管理', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (26, N'删除', N'images/icon/12.png', N'del()', 23, N'岗位管理', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (27, N'修改', N'images/icon/33.png', N'edit()', 23, N'岗位管理', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (28, N'新增', N'images/icon/11.png', N'add()', 23, N'岗位管理', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (29, N'新增', N'images/icon/11.png', N'add()', 24, N'员工管理', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (30, N'删除', N'images/icon/12.png', N'del()', 24, N'员工管理', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (31, N'修改', N'images/icon/33.png', N'edit()', 24, N'员工管理', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (32, N'新增', N'images/icon/11.png', N'add()', 31, N'角色授权', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (33, N'删除', N'images/icon/12.png', N'del()', 31, N'角色授权', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (34, N'修改', N'images/icon/33.png', N'edit()', 31, N'角色授权', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (35, N'操作权限', N'images/icon/91.png', N'authorized()', 31, N'角色授权', 40)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (36, N'包含人员', N'images/icon/37.png', N'role_emp()', 31, N'角色授权', 60)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (37, N'数据权限', N'images/icon/92.png', N'data_authorized()', 31, N'角色授权', 50)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (38, N'新增', N'images/icon/11.png', N'add()', 5, N'联系人管理', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (39, N'修改', N'images/icon/33.png', N'edit()', 5, N'联系人管理', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (40, N'删除', N'images/icon/12.png', N'del()', 5, N'联系人管理', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (41, N'删除', N'images/icon/12.png', N'del()', 34, N'订单管理', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (42, N'新增', N'images/icon/11.png', N'add()', 34, N'订单管理', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (43, N'修改', N'images/icon/33.png', N'edit()', 34, N'订单管理', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (44, N'修改', N'images/icon/33.png', N'edit()', 35, N'合同管理', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (45, N'新增', N'images/icon/11.png', N'add()', 35, N'合同管理', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (46, N'删除', N'images/icon/12.png', N'del()', 35, N'合同管理', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (47, N'新增', N'images/icon/11.png', N'add()', 36, N'收款管理', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (48, N'删除', N'images/icon/12.png', N'del()', 36, N'收款管理', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (49, N'修改', N'images/icon/33.png', N'edit()', 36, N'收款管理', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (50, N'新增', N'images/icon/11.png', N'add()', 37, N'开票管理', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (51, N'删除', N'images/icon/12.png', N'del()', 37, N'开票管理', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (52, N'修改', N'images/icon/33.png', N'edit()', 37, N'开票管理', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (53, N'修改', N'images/icon/33.png', N'edit()', 44, N'产品类别', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (54, N'删除', N'images/icon/12.png', N'del()', 44, N'产品类别', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (55, N'新增', N'images/icon/11.png', N'add()', 44, N'产品类别', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (56, N'新增', N'images/icon/11.png', N'add()', 39, N'产品列表', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (57, N'修改', N'images/icon/33.png', N'edit()', 39, N'产品列表', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (58, N'删除', N'images/icon/12.png', N'del()', 39, N'产品列表', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (59, N'恢复', N'images/icon/2.png', N'regain()', 47, N'客户回收', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (60, N'彻底删除', N'images/icon/50.png', N'del()', 47, N'客户回收', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (61, N'恢复', N'images/icon/2.png', N'regain()', 48, N'联系人回收', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (62, N'彻底删除', N'images/icon/50.png', N'del()', 48, N'联系人回收', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (63, N'恢复', N'images/icon/2.png', N'regain()', 49, N'跟进回收', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (64, N'彻底删除', N'images/icon/50.png', N'del()', 49, N'跟进回收', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (65, N'恢复', N'images/icon/2.png', N'regain()', 50, N'订单回收', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (66, N'彻底删除', N'images/icon/50.png', N'del()', 50, N'订单回收', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (67, N'恢复', N'images/icon/2.png', N'regain()', 51, N'合同回收', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (68, N'彻底删除', N'images/icon/50.png', N'del()', 51, N'合同回收', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (69, N'恢复', N'images/icon/2.png', N'regain()', 52, N'收款单回收', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (70, N'彻底删除', N'images/icon/50.png', N'del()', 52, N'收款单回收', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (71, N'恢复', N'images/icon/2.png', N'regain()', 53, N'发票回收', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (72, N'彻底删除', N'images/icon/50.png', N'del()', 53, N'发票回收', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (73, N'恢复', N'images/icon/2.png', N'regain()', 54, N'产品类别回收', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (74, N'彻底删除', N'images/icon/50.png', N'del()', 54, N'产品类别回收', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (75, N'恢复', N'images/icon/2.png', N'regain()', 55, N'产品回收', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (76, N'彻底删除', N'images/icon/50.png', N'del()', 55, N'产品回收', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (77, N'批量转客户', N'images/icon/2.png', N'batch_cus()', 80, N'组织架构回收', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (78, N'批量转订单', N'images/icon/50.png', N'batch_order()', 80, N'组织架构回收', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (79, N'恢复', N'images/icon/2.png', N'regain()', 81, N'职务回收', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (80, N'彻底删除', N'images/icon/50.png', N'del()', 81, N'职务回收', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (81, N'恢复', N'images/icon/2.png', N'regain()', 82, N'岗位回收', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (82, N'彻底删除', N'images/icon/50.png', N'del()', 82, N'岗位回收', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (83, N'恢复', N'images/icon/2.png', N'regain()', 83, N'员工回收', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (84, N'彻底删除', N'images/icon/50.png', N'del()', 83, N'员工回收', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (85, N'修改', N'images/icon/33.png', N'edit()', 43, N'参数配置', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (86, N'删除', N'images/icon/12.png', N'del()', 43, N'参数配置', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (87, N'新增', N'images/icon/11.png', N'add()', 43, N'参数配置', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (88, N'新增', N'images/icon/11.png', N'add()', 84, N'城市管理', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (89, N'修改', N'images/icon/33.png', N'edit()', 84, N'城市管理', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (90, N'删除', N'images/icon/12.png', N'del()', 84, N'城市管理', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (92, N'修改密码', N'images/icon/36.png', N'changepwd()', 24, N'员工管理', 40)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (93, N'新增', N'images/icon/11.png', N'add()', 13, N'新闻', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (94, N'修改', N'images/icon/33.png', N'edit()', 13, N'新闻', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (95, N'删除', N'images/icon/12.png', N'del()', 13, N'新闻', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (96, N'新增', N'images/icon/11.png', N'add()', -1, N'客户列表', 10)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (97, N'删除', N'images/icon/12.png', N'del()', -1, N'客户列表', 30)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (98, N'修改', N'images/icon/33.png', N'edit()', -1, N'客户列表', 20)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (99, N'导入', N'images/icon/4.png', N'toimport()', 4, N'客户列表', 40)
INSERT [dbo].[Sys_Button] ([Btn_id], [Btn_name], [Btn_icon], [Btn_handler], [Menu_id], [Menu_name], [Btn_order]) VALUES (100, N'导出', N'images/icon/43.png', N'toexport()', 4, N'客户列表', 50)
SET IDENTITY_INSERT [dbo].[Sys_Button] OFF
/****** Object:  Table [dbo].[Sys_authority]    Script Date: 01/05/2015 16:17:29 ******/

CREATE TABLE [dbo].[Sys_authority](
	[Role_id] [int] NOT NULL,
	[App_ids] [varchar](250) NULL,
	[Menu_ids] [varchar](250) NULL,
	[Button_ids] [varchar](250) NULL,
	[Create_id] [int] NULL,
	[Create_date] [datetime] NULL
) ON [PRIMARY]

GO


INSERT [dbo].[Sys_authority] ([Role_id], [App_ids], [Menu_ids], [Button_ids], [Create_id], [Create_date]) VALUES (1, N'a1,', N'm1,m2,m7,m12,m13,m14,', N',,,b93,b94,b95,b11,b12,b13,', NULL, NULL)
INSERT [dbo].[Sys_authority] ([Role_id], [App_ids], [Menu_ids], [Button_ids], [Create_id], [Create_date]) VALUES (1, N'a3,', N'm17,m21,m22,m23,m24,', N',,,b21,b22,b20,b23,b24,b25,b28,b27,b26,b29,b31,b30,b92,', NULL, NULL)
INSERT [dbo].[Sys_authority] ([Role_id], [App_ids], [Menu_ids], [Button_ids], [Create_id], [Create_date]) VALUES (1, N'a6,', N'm30,m31,m32,m43,m84,m60,m59,m76,', N',,,b32,b34,b33,b35,b37,b36,b87,b85,b86,b88,b89,b90,b4,b5,b6,b7,b1,b2,b3,', NULL, NULL)
INSERT [dbo].[Sys_authority] ([Role_id], [App_ids], [Menu_ids], [Button_ids], [Create_id], [Create_date]) VALUES (1, N'a2,', N'm3,m4,m5,m6,m33,m34,m35,m38,m39,m44,m45,m36,m37,m56,m57,m62,', N',,,b91,b15,b16,b14,b38,b39,b40,b17,b18,b19,b42,b43,b41,b45,b44,b46,b56,b57,b58,b55,b53,b54,b47,b49,b48,b50,b52,b51,', NULL, NULL)
INSERT [dbo].[Sys_authority] ([Role_id], [App_ids], [Menu_ids], [Button_ids], [Create_id], [Create_date]) VALUES (1, N'a4,', N'm46,m47,m48,m49,m50,m51,m52,m53,m54,m55,m58,m80,m81,m82,m83,', N',,,b59,b60,b61,b62,b63,b64,b65,b66,b67,b68,b69,b70,b71,b72,b73,b74,b75,b76,b77,b78,b79,b80,b81,b82,b83,b84,', NULL, NULL)
INSERT [dbo].[Sys_authority] ([Role_id], [App_ids], [Menu_ids], [Button_ids], [Create_id], [Create_date]) VALUES (1, N'a5,', N'm40,m41,m42,m63,m64,m65,m66,m67,m68,m69,m70,m71,m72,m73,m74,m75,', N',,,', NULL, NULL)

/****** Object:  Table [dbo].[Sys_App]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[Sys_App](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[App_name] [varchar](100) NULL,
	[App_order] [int] NULL,
	[App_url] [varchar](250) NULL,
	[App_handler] [varchar](250) NULL,
	[App_type] [varchar](50) NULL,
	[App_icon] [varchar](250) NULL,
 CONSTRAINT [PK_Sys_App] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


SET IDENTITY_INSERT [dbo].[Sys_App] ON
INSERT [dbo].[Sys_App] ([id], [App_name], [App_order], [App_url], [App_handler], [App_type], [App_icon]) VALUES (1, N'个人办公', 10, NULL, NULL, NULL, N'images/icon/62.png')
INSERT [dbo].[Sys_App] ([id], [App_name], [App_order], [App_url], [App_handler], [App_type], [App_icon]) VALUES (2, N'CRM客户管理', 20, NULL, NULL, NULL, N'images/icon/85.png')
INSERT [dbo].[Sys_App] ([id], [App_name], [App_order], [App_url], [App_handler], [App_type], [App_icon]) VALUES (3, N'人事管理', 30, NULL, NULL, NULL, N'images/icon/37.png')
INSERT [dbo].[Sys_App] ([id], [App_name], [App_order], [App_url], [App_handler], [App_type], [App_icon]) VALUES (4, N'实用工具', 40, NULL, NULL, NULL, N'images/icon/71.png')
INSERT [dbo].[Sys_App] ([id], [App_name], [App_order], [App_url], [App_handler], [App_type], [App_icon]) VALUES (5, N'报表分析', 50, NULL, NULL, NULL, N'images/icon/54.png')
INSERT [dbo].[Sys_App] ([id], [App_name], [App_order], [App_url], [App_handler], [App_type], [App_icon]) VALUES (6, N'系统管理', 60, NULL, NULL, NULL, N'images/icon/77.png')
SET IDENTITY_INSERT [dbo].[Sys_App] OFF

/****** Object:  Table [dbo].[public_notice]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[public_notice](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[notice_title] [varchar](250) NULL,
	[notice_content] [varchar](max) NULL,
	[create_id] [int] NULL,
	[create_name] [varchar](250) NULL,
	[dep_id] [int] NULL,
	[dep_name] [varchar](250) NULL,
	[notice_time] [datetime] NULL,
 CONSTRAINT [PK_public_notice] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[public_news]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[public_news](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[news_title] [varchar](250) NULL,
	[news_content] [varchar](max) NULL,
	[create_id] [int] NULL,
	[create_name] [varchar](250) NULL,
	[dep_id] [int] NULL,
	[dep_name] [varchar](250) NULL,
	[news_time] [datetime] NULL,
	[isDelete] [int] NULL,
	[Delete_time] [datetime] NULL,
 CONSTRAINT [PK_public_news] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[Personal_notes]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[Personal_notes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[emp_id] [int] NULL,
	[emp_name] [varchar](250) NULL,
	[note_content] [varchar](max) NULL,
	[note_color] [varchar](250) NULL,
	[xyz] [varchar](250) NULL,
	[note_time] [datetime] NULL,
 CONSTRAINT [PK_Personal_notes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[Personal_Calendar]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[Personal_Calendar](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[emp_id] [int] NULL,
	[emp_name] [varchar](250) NULL,
	[companyid] [int] NULL,
	[Subject] [varchar](max) NULL,
	[Location] [varchar](max) NULL,
	[MasterId] [int] NULL,
	[Description] [varchar](max) NULL,
	[CalendarType] [tinyint] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[IsAllDayEvent] [bit] NULL,
	[HasAttachment] [bit] NULL,
	[Category] [varchar](max) NULL,
	[InstanceType] [tinyint] NULL,
	[Attendees] [varchar](max) NULL,
	[AttendeeNames] [varchar](max) NULL,
	[OtherAttendee] [varchar](max) NULL,
	[UPAccount] [varchar](250) NULL,
	[UPName] [varchar](250) NULL,
	[UPTime] [datetime] NULL,
	[RecurringRule] [varchar](max) NULL,
 CONSTRAINT [PK_Personal_Calendar] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[Param_SysParam_Type]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[Param_SysParam_Type](
	[id] [int] NOT NULL,
	[params_name] [varchar](250) NULL,
	[params_order] [int] NULL,
	[isDelete] [int] NULL,
	[Delete_time] [datetime] NULL
) ON [PRIMARY]

INSERT [dbo].[Param_SysParam_Type] ([id], [params_name], [params_order], [isDelete], [Delete_time]) VALUES (8, N'客户行业', 10, NULL, NULL)
INSERT [dbo].[Param_SysParam_Type] ([id], [params_name], [params_order], [isDelete], [Delete_time]) VALUES (1, N'客户类型', 20, NULL, NULL)
INSERT [dbo].[Param_SysParam_Type] ([id], [params_name], [params_order], [isDelete], [Delete_time]) VALUES (2, N'客户级别', 30, NULL, NULL)
INSERT [dbo].[Param_SysParam_Type] ([id], [params_name], [params_order], [isDelete], [Delete_time]) VALUES (3, N'客户来源', 40, NULL, NULL)
INSERT [dbo].[Param_SysParam_Type] ([id], [params_name], [params_order], [isDelete], [Delete_time]) VALUES (4, N'跟进方式', 50, NULL, NULL)
INSERT [dbo].[Param_SysParam_Type] ([id], [params_name], [params_order], [isDelete], [Delete_time]) VALUES (5, N'支付方式', 60, NULL, NULL)
INSERT [dbo].[Param_SysParam_Type] ([id], [params_name], [params_order], [isDelete], [Delete_time]) VALUES (6, N'订单状态', 70, NULL, NULL)
INSERT [dbo].[Param_SysParam_Type] ([id], [params_name], [params_order], [isDelete], [Delete_time]) VALUES (7, N'发票类型', 80, NULL, NULL)

/****** Object:  Table [dbo].[Param_SysParam]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[Param_SysParam](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[parentid] [int] NULL,
	[params_name] [varchar](250) NULL,
	[params_order] [int] NULL,
	[Create_id] [int] NULL,
	[Create_date] [datetime] NULL,
	[Update_id] [int] NULL,
	[Update_date] [datetime] NULL,
 CONSTRAINT [PK_Param_SysParam] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[Param_City]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[Param_City](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[parentid] [int] NULL,
	[City] [varchar](250) NULL,
	[City_order] [int] NULL,
	[Create_id] [int] NULL,
	[Create_date] [datetime] NULL,
	[Update_id] [int] NULL,
	[Update_date] [datetime] NULL,
 CONSTRAINT [PK_Param_City] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


GO


SET IDENTITY_INSERT [dbo].[Param_City] ON
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (1, 0, N'北京', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (2, 0, N'上海', 2, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (3, 0, N'天津', 3, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (4, 0, N' 重庆', 4, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (5, 0, N' 黑龙江', 5, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (6, 0, N'吉林', 6, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (7, 0, N'辽宁', 7, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (8, 0, N'内蒙古', 8, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (9, 0, N'宁夏', 9, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (10, 0, N'新疆', 10, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (11, 0, N'青海', 11, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (12, 0, N'甘肃', 12, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (13, 0, N'陕西', 13, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (14, 0, N'河北', 14, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (15, 0, N'河南', 15, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (16, 0, N'山东', 16, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (17, 0, N'山西', 17, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (18, 0, N'湖北', 18, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (19, 0, N'湖南', 19, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (20, 0, N'安徽', 20, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (21, 0, N'江苏', 21, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (22, 0, N' 浙江', 22, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (23, 0, N'江西', 23, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (24, 0, N'广东', 24, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (25, 0, N'广西', 25, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (26, 0, N'福建', 26, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (27, 0, N'四川', 27, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (28, 0, N'云南', 28, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (29, 0, N'贵州', 29, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (30, 0, N'西藏', 30, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (31, 0, N'海南', 31, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (32, 0, N'香港', 32, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (33, 0, N'澳门', 33, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (34, 0, N'台湾', 34, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (35, 1, N'东城区', 35, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (36, 1, N'西城区', 36, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (37, 1, N'宣武区', 37, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (38, 1, N'崇文区', 38, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (39, 1, N'朝阳区', 39, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (40, 1, N'海淀区', 40, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (41, 1, N'丰台区', 41, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (42, 1, N'石景山区', 42, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (43, 1, N'门头沟区', 43, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (44, 1, N'昌平区', 44, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (45, 1, N'大兴区', 45, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (46, 1, N'怀柔区', 46, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (47, 1, N'密云县', 47, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (48, 1, N'平谷区', 48, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (49, 1, N'顺义区', 49, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (50, 1, N'通州区', 50, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (51, 1, N'延庆县', 51, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (52, 1, N'房山区', 52, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (53, 2, N'黄浦区', 53, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (54, 2, N'南市区', 54, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (55, 2, N'卢湾区', 55, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (56, 2, N'徐汇区', 56, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (57, 2, N'长宁区', 57, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (58, 2, N'静安区', 58, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (59, 2, N'普陀区', 59, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (60, 2, N'金山区', 60, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (61, 2, N'闸北区', 61, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (62, 2, N'虹口区', 62, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (63, 2, N'杨浦区', 63, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (64, 2, N'宝山区', 64, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (65, 2, N'闵行区', 65, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (66, 2, N'嘉定区', 66, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (67, 2, N'松江区', 67, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (68, 2, N'浦东新区', 68, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (69, 2, N'青浦县', 69, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (70, 2, N'奉贤县', 70, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (71, 2, N'南汇县', 71, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (72, 2, N'崇明县', 72, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (73, 3, N'和平区', 73, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (74, 3, N'河东区', 74, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (75, 3, N'河西区', 75, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (76, 3, N'河北区', 76, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (77, 3, N'南开区', 77, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (78, 3, N'红桥区', 78, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (79, 3, N'塘沽区', 79, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (80, 3, N'汉沽区', 80, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (81, 3, N'大港区', 81, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (82, 3, N'东丽区', 82, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (83, 3, N'西青区', 83, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (84, 3, N'津南区', 84, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (85, 3, N'北辰区', 85, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (86, 3, N' 武清区', 86, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (87, 3, N'宝坻区', 87, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (88, 3, N'蓟 县', 88, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (89, 3, N'宁河县', 89, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (90, 3, N'静海县', 90, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (91, 4, N'永川市', 91, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (92, 4, N'黔江区', 92, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (93, 4, N'涪陵区', 93, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (94, 4, N'万洲区', 94, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (95, 4, N'渝中区', 95, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (96, 4, N'大渡口区', 96, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (97, 4, N'江北区', 97, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (98, 4, N'沙坪坝区', 98, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (99, 4, N'九龙坡区', 99, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (100, 4, N'南岸区', 100, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (101, 4, N'北碚区', 101, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (102, 4, N' 万盛区', 102, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (103, 4, N'双桥区', 103, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (104, 4, N'渝北区', 104, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (105, 4, N'巴南区', 105, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (106, 4, N'长寿区', 106, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (107, 5, N'哈尔滨', 107, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (108, 5, N'齐齐哈尔', 108, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (109, 5, N'牡丹江', 109, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (110, 5, N'鹤岗', 110, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (111, 5, N'双鸭山', 111, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (112, 5, N'鸡西', 112, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (113, 5, N'大庆', 113, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (114, 5, N'伊春', 114, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (115, 5, N'佳木斯', 115, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (116, 5, N'七台河', 116, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (117, 5, N'黑河', 117, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (118, 5, N'绥化', 118, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (119, 5, N'大兴安岭地区', 119, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (120, 6, N'长春', 120, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (121, 6, N'吉林', 121, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (122, 6, N'四平', 122, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (123, 6, N'辽源', 123, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (124, 6, N'通化', 124, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (125, 6, N'白山', 125, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (126, 6, N'松原', 126, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (127, 6, N'白城', 127, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (128, 6, N'延边朝鲜族自治州', 128, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (129, 6, N'高新', 129, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (130, 6, N'延吉', 130, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (131, 6, N'梅河口', 131, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (132, 7, N'沈阳', 132, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (133, 7, N'大连', 133, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (134, 7, N'锦州', 134, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (135, 7, N'鞍山', 135, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (136, 7, N'抚顺', 136, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (137, 7, N'本溪', 137, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (138, 7, N'丹东', 138, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (139, 7, N'葫芦岛', 139, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (140, 7, N'营口', 140, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (141, 7, N'盘锦', 141, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (142, 7, N'阜新', 142, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (143, 7, N'辽阳', 143, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (144, 7, N'铁岭', 144, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (145, 7, N'朝阳', 145, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (146, 7, N'瓦房店', 146, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (147, 8, N'呼和浩特', 147, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (148, 8, N'包头', 148, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (149, 8, N'乌海', 149, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (150, 8, N'赤峰', 150, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (151, 8, N'通辽', 151, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (152, 8, N'鄂尔多斯', 152, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (153, 8, N'乌兰察布盟', 153, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (154, 8, N'锡林郭勒盟', 154, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (155, 8, N'巴彦淖尔盟', 155, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (156, 8, N'阿拉善盟', 156, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (157, 8, N'兴安盟', 157, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (158, 8, N'巴彦淖尔', 158, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (159, 8, N'呼伦贝尔', 159, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (160, 8, N'集宁', 160, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (161, 8, N' 乌兰浩特', 161, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (162, 8, N'锡林浩特', 162, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (163, 9, N'银川', 163, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (164, 9, N'石嘴山', 164, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (165, 9, N'吴忠', 165, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (166, 9, N'固原', 166, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (167, 10, N'乌鲁木齐', 167, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (168, 10, N'克拉玛依', 168, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (169, 10, N'吐鲁番地区', 169, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (170, 10, N'哈密地区', 170, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (171, 10, N'和田地区', 171, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (172, 10, N'阿克苏地区', 172, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (173, 10, N'喀什地区', 173, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (174, 10, N'克孜勒苏柯尔克孜自治州', 174, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (175, 10, N'巴音郭楞蒙古自治州', 175, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (176, 10, N'昌吉回族自治州', 176, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (177, 10, N'博尔塔拉蒙古自治州', 177, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (178, 10, N'伊犁哈萨克自治州', 178, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (179, 10, N'阿克苏', 179, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (180, 10, N'昌吉', 180, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (181, 10, N'哈密', 181, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (182, 10, N'和田', 182, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (183, 10, N'喀什', 183, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (184, 10, N'克拉马依', 184, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (185, 10, N'库尔勒', 185, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (186, 10, N'石河子', 186, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (187, 10, N'吐鲁番', 187, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (188, 10, N' 乌市', 188, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (189, 10, N'奎屯', 189, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (190, 10, N'伊犁', 190, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (191, 10, N'伊宁', 191, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (192, 11, N'西宁', 192, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (193, 11, N'海东地区', 193, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (194, 11, N' 海北藏族自治州', 194, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (195, 11, N'黄南藏族自治州', 195, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (196, 11, N'海南藏族自治州', 196, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (197, 11, N'果洛藏族自治州', 197, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (198, 11, N'玉树藏族自治州', 198, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (199, 11, N'海西蒙古族藏族自治州', 199, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (200, 11, N'格尔木', 200, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (201, 12, N'兰州', 201, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (202, 12, N'天水', 202, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (203, 12, N'金昌', 203, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (204, 12, N'白银', 204, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (205, 12, N'嘉峪关', 205, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (206, 12, N'武 威 ', 206, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (207, 12, N'张掖', 207, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (208, 12, N'平凉', 208, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (209, 12, N'酒泉', 209, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (210, 12, N'庆阳', 210, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (211, 12, N'定西地区', 211, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (212, 12, N'陇南地区', 212, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (213, 12, N'甘南藏族自治州', 213, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (214, 12, N'临夏回族自治州', 214, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (215, 12, N'嘉峪', 215, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (216, 12, N'武威', 216, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (217, 13, N'西安', 217, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (218, 13, N'宝鸡', 218, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (219, 13, N'延安', 219, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (220, 13, N'铜川', 220, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (221, 13, N'咸阳', 221, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (222, 13, N'渭南', 222, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (223, 13, N'汉中', 223, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (224, 13, N'榆林', 224, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (225, 13, N'安康', 225, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (226, 13, N'商洛', 226, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (227, 13, N'韩城', 227, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (228, 14, N'石家庄', 228, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (229, 14, N'保定', 229, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (230, 14, N'唐山', 230, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (231, 14, N'秦皇岛', 231, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (232, 14, N'邯郸', 232, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (233, 14, N'邢台', 233, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (234, 14, N'张家口', 234, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (235, 14, N'承德', 235, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (236, 14, N'沧州', 236, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (237, 14, N'廊坊', 237, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (238, 14, N'衡水', 238, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (239, 14, N'霸州', 239, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (240, 14, N'青县', 240, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (241, 14, N'任丘', 241, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (242, 14, N'涿州', 242, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (243, 15, N'郑州', 243, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (244, 15, N'洛阳', 244, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (245, 15, N'开封', 245, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (246, 15, N'平顶山', 246, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (247, 15, N'焦作', 247, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (248, 15, N'鹤壁', 248, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (249, 15, N'新乡', 249, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (250, 15, N'安阳', 250, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (251, 15, N'濮阳', 251, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (252, 15, N'许昌', 252, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (253, 15, N'漯河', 253, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (254, 15, N'三门峡', 254, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (255, 15, N'南阳', 255, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (256, 15, N'商丘', 256, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (257, 15, N'信阳', 257, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (258, 15, N'周口', 258, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (259, 15, N'驻马店', 259, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (260, 16, N'济南', 260, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (261, 16, N'青岛', 261, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (262, 16, N'烟台', 262, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (263, 16, N'淄博', 263, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (264, 16, N'枣庄', 264, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (265, 16, N'东营', 265, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (266, 16, N'潍坊', 266, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (267, 16, N'威海', 267, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (268, 16, N'济宁', 268, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (269, 16, N'泰安', 269, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (270, 16, N'日照', 270, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (271, 16, N'莱芜', 271, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (272, 16, N'德州', 272, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (273, 16, N'临沂', 273, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (274, 16, N'聊城', 274, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (275, 16, N'滨州', 275, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (276, 16, N'菏泽', 276, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (277, 16, N'高密', 277, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (278, 16, N'荷泽', 278, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (279, 16, N'淮坊', 279, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (280, 16, N'即墨', 280, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (281, 16, N'胶南', 281, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (282, 16, N'莱州', 282, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (283, 16, N'林沂', 283, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (284, 16, N'临忻', 284, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (285, 16, N'龙口', 285, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (286, 16, N'蓬莱', 286, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (287, 16, N'青州', 287, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (288, 16, N'乳山', 288, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (289, 16, N'寿光', 289, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (290, 16, N'滕州', 290, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (291, 16, N'文登', 291, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (292, 16, N'招远', 292, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (293, 17, N'太原', 293, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (294, 17, N'大同', 294, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (295, 17, N'朔州', 295, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (296, 17, N'阳泉', 296, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (297, 17, N'长治', 297, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (298, 17, N'晋城', 298, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (299, 17, N'忻州', 299, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (300, 17, N'晋中', 300, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (301, 17, N'临汾', 301, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (302, 17, N'运城', 302, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (303, 17, N'吕梁地区', 303, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (304, 17, N'河津', 304, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (305, 17, N'侯马', 305, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (306, 17, N'孝义', 306, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (307, 17, N'榆次', 307, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (308, 18, N'武汉', 308, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (309, 18, N'黄石', 309, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (310, 18, N'襄樊', 310, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (311, 18, N'十堰', 311, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (312, 18, N'荆州', 312, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (313, 18, N'宜昌', 313, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (314, 18, N'荆门', 314, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (315, 18, N'鄂州', 315, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (316, 18, N'孝感', 316, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (317, 18, N'黄冈', 317, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (318, 18, N'咸宁', 318, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (319, 18, N'随州', 319, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (320, 18, N'恩施土家族苗族自治州', 320, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (321, 18, N'安陆', 321, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (322, 18, N'恩施', 322, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (323, 18, N'汉口', 323, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (324, 18, N'汉阳', 324, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (325, 18, N'潜江', 325, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (326, 18, N'仙桃', 326, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (327, 18, N'株州', 327, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (328, 19, N'长沙', 328, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (329, 19, N'株洲', 329, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (330, 19, N'湘潭', 330, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (331, 19, N'衡阳', 331, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (332, 19, N'邵阳', 332, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (333, 19, N'岳阳', 333, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (334, 19, N'常德', 334, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (335, 19, N'张家界', 335, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (336, 19, N'益阳', 336, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (337, 19, N'郴州', 337, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (338, 19, N'永州', 338, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (339, 19, N'怀化', 339, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (340, 19, N'娄底', 340, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (341, 19, N'湘西土家族苗族自治州', 341, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (342, 19, N'株州', 342, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (343, 19, N'邵东', 343, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (344, 20, N'合肥', 344, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (345, 20, N'芜湖', 345, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (346, 20, N'蚌埠', 346, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (347, 20, N'淮南', 347, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (348, 20, N'马鞍山', 348, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (349, 20, N'淮北', 349, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (350, 20, N'铜陵', 350, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (351, 20, N'安庆', 351, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (352, 20, N'黄山', 352, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (353, 20, N'滁州', 353, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (354, 20, N'阜阳', 354, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (355, 20, N'宿州', 355, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (356, 20, N'巢湖', 356, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (357, 20, N'六安', 357, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (358, 20, N'亳州', 358, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (359, 20, N'池州', 359, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (360, 20, N'宣城', 360, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (361, 20, N'蒙城', 361, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (362, 20, N'宁国', 362, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (363, 20, N'桐城', 363, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (364, 21, N'南京', 364, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (365, 21, N'徐州', 365, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (366, 21, N'连云港', 366, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (367, 21, N'淮安', 367, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (368, 21, N'宿迁', 368, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (369, 21, N'盐城', 369, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (370, 21, N'扬州', 370, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (371, 21, N'泰州', 371, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (372, 21, N'南通', 372, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (373, 21, N'镇江', 373, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (374, 21, N'常州', 374, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (375, 21, N'无锡', 375, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (376, 21, N'苏州', 376, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (377, 21, N'常熟', 377, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (378, 21, N'丹阳', 378, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (379, 21, N'海门', 379, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (380, 21, N'江都', 380, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (381, 21, N'江阴', 381, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (382, 21, N'靖江', 382, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (383, 21, N'昆山', 383, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (384, 21, N'溧阳', 384, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (385, 21, N'太仓', 385, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (386, 21, N'泰州华', 386, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (387, 21, N'吴江', 387, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (388, 21, N'吴县', 388, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (389, 21, N'宜兴', 389, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (390, 21, N'张家港', 390, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (391, 22, N'杭州', 391, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (392, 22, N'宁波', 392, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (393, 22, N'温州', 393, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (394, 22, N'嘉兴', 394, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (395, 22, N'湖州', 395, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (396, 22, N'绍兴', 396, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (397, 22, N'金华', 397, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (398, 22, N'衢州', 398, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (399, 22, N'舟山', 399, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (400, 22, N'台州', 400, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (401, 22, N'丽水', 401, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (402, 22, N'慈溪', 402, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (403, 22, N'东阳', 403, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (404, 22, N'奉化', 404, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (405, 22, N'乐清', 405, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (406, 22, N'临安', 406, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (407, 22, N'临海', 407, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (408, 22, N'平湖', 408, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (409, 22, N'瑞安', 409, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (410, 22, N'上虞', 410, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (411, 22, N'嵊州', 411, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (412, 22, N'温岭', 412, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (413, 22, N'义乌', 413, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (414, 22, N'永康', 414, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (415, 22, N'余姚', 415, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (416, 22, N'诸暨', 416, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (417, 22, N'新昌', 417, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (418, 23, N'南昌', 418, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (419, 23, N'景德镇', 419, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (420, 23, N'萍乡', 420, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (421, 23, N'新余', 421, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (422, 23, N'九江', 422, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (423, 23, N'鹰潭', 423, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (424, 23, N'赣州', 424, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (425, 23, N'吉安', 425, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (426, 23, N'宜春', 426, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (427, 23, N'抚州', 427, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (428, 23, N'上饶', 428, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (429, 23, N'高安', 429, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (430, 24, N'广州', 430, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (431, 24, N'深圳', 431, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (432, 24, N'珠海', 432, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (433, 24, N'汕头', 433, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (434, 24, N'韶关', 434, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (435, 24, N'河源', 435, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (436, 24, N'梅州', 436, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (437, 24, N'惠州', 437, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (438, 24, N'汕尾', 438, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (439, 24, N'东莞', 439, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (440, 24, N'中山', 440, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (441, 24, N'江门', 441, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (442, 24, N'佛山', 442, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (443, 24, N'阳江', 443, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (444, 24, N'湛江', 444, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (445, 24, N'茂名', 445, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (446, 24, N'肇庆', 446, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (447, 24, N'清远', 447, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (448, 24, N'潮州', 448, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (449, 24, N'揭阳', 449, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (450, 24, N'云浮', 450, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (451, 24, N'花都', 451, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (452, 24, N'开平', 452, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (453, 24, N'南海', 453, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (454, 24, N'顺德', 454, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (455, 24, N'台山', 455, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (456, 24, N'增城', 456, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (457, 24, N'市梅', 457, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (458, 25, N'南宁', 458, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (459, 25, N'柳州', 459, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (460, 25, N'桂林', 460, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (461, 25, N'梧州', 461, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (462, 25, N'北海', 462, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (463, 25, N'防城港', 463, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (464, 25, N'钦州', 464, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (465, 25, N'贵港', 465, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (466, 25, N'玉林', 466, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (467, 25, N'百色', 467, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (468, 25, N'贺州', 468, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (469, 25, N'河池', 469, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (470, 25, N'来宾', 470, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (471, 25, N'崇左', 471, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (472, 26, N'福州', 472, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (473, 26, N'厦门', 473, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (474, 26, N'三明', 474, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (475, 26, N'莆田', 475, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (476, 26, N'泉州', 476, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (477, 26, N'漳州', 477, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (478, 26, N'南平', 478, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (479, 26, N'龙岩', 479, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (480, 26, N'宁德', 480, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (481, 26, N'福清', 481, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (482, 26, N'建瓯', 482, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (483, 26, N'晋江', 483, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (484, 26, N'南安', 484, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (485, 26, N'邵武', 485, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (486, 26, N'石狮', 486, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (487, 26, N'仙游', 487, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (488, 27, N'成都', 488, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (489, 27, N'自贡', 489, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (490, 27, N'攀枝花', 490, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (491, 27, N'泸州', 491, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (492, 27, N'德阳', 492, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (493, 27, N'绵阳', 493, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (494, 27, N'广元', 494, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (495, 27, N'遂宁', 495, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (496, 27, N'内江', 496, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (497, 27, N'乐山', 497, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (498, 27, N'南充', 498, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (499, 27, N'宜宾', 499, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (500, 27, N'广安', 500, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (501, 27, N'达州', 501, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (502, 27, N'巴中', 502, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (503, 27, N'雅安', 503, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (504, 27, N'眉山', 504, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (505, 27, N'资阳', 505, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (506, 27, N'阿坝藏族羌族自治州', 506, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (507, 27, N'甘孜藏族自治州', 507, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (508, 27, N'凉山彝族自治州', 508, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (509, 27, N'广汉', 509, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (510, 27, N'锦阳', 510, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (511, 27, N'西昌', 511, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (512, 28, N'昆明', 512, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (513, 28, N'曲靖', 513, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (514, 28, N'玉溪', 514, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (515, 28, N'保山', 515, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (516, 28, N'昭通', 516, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (517, 28, N'思茅地区', 517, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (518, 28, N'临沧地区', 518, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (519, 28, N'丽江', 519, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (520, 28, N' 文山壮族苗族自治州', 520, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (521, 28, N'红河哈尼族彝族自治州', 521, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (522, 28, N'西双版纳傣族自治州', 522, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (523, 28, N'楚雄彝族自治州', 523, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (524, 28, N'大理白族自治州', 524, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (525, 28, N'德宏傣族景颇族自治州', 525, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (526, 28, N'怒江傈傈族自治州', 526, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (527, 28, N'迪庆藏族自治州', 527, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (528, 28, N'大理', 528, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (529, 29, N'贵阳', 529, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (530, 29, N'六盘水', 530, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (531, 29, N'遵义', 531, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (532, 29, N'安顺', 532, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (533, 29, N'铜仁地区', 533, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (534, 29, N'毕节地区', 534, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (535, 29, N'黔西南布依族苗族自治州', 535, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (536, 29, N'黔东南苗族侗族自治州', 536, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (537, 29, N'黔南布依族苗族自治州', 537, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (538, 29, N'都匀', 538, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (539, 29, N'贵恙', 539, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (540, 29, N'凯里', 540, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (541, 29, N'铜仁', 541, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (542, 30, N'拉萨', 542, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (543, 30, N'那曲地区', 543, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (544, 30, N'昌都地区', 544, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (545, 30, N'山南地区', 545, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (546, 30, N'日喀则地区', 546, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (547, 30, N'阿里地区', 547, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (548, 30, N'林芝地区', 548, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (549, 31, N'海口', 549, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (550, 31, N'三亚', 550, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (551, 34, N'台北', 551, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (552, 34, N'高雄', 552, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (553, 34, N'台中', 553, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (554, 34, N'台南', 554, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (555, 34, N'基隆', 555, NULL, NULL, NULL, NULL)
INSERT [dbo].[Param_City] ([id], [parentid], [City], [City_order], [Create_id], [Create_date], [Update_id], [Update_date]) VALUES (556, 34, N'新竹', 556, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Param_City] OFF
/****** Object:  Table [dbo].[hr_post]    Script Date: 01/05/2015 16:17:29 ******/

CREATE TABLE [dbo].[hr_post](
	[post_id] [int] IDENTITY(1,1) NOT NULL,
	[post_name] [varchar](255) NULL,
	[position_id] [int] NULL,
	[position_name] [varchar](255) NULL,
	[position_order] [int] NULL,
	[dep_id] [int] NULL,
	[depname] [varchar](255) NULL,
	[emp_id] [int] NULL,
	[emp_name] [varchar](255) NULL,
	[default_post] [int] NULL,
	[note] [varchar](max) NULL,
	[post_descript] [varchar](max) NULL,
	[isDelete] [int] NULL,
	[Delete_time] [datetime] NULL,
 CONSTRAINT [PK_hr_post] PRIMARY KEY CLUSTERED 
(
	[post_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[hr_position]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[hr_position](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[position_name] [varchar](250) NULL,
	[position_order] [int] NULL,
	[position_level] [varchar](50) NULL,
	[create_id] [int] NULL,
	[create_date] [datetime] NULL,
	[isDelete] [int] NULL,
	[Delete_time] [datetime] NULL,
 CONSTRAINT [PK_hr_position] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[hr_employee]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[hr_employee](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[uid] [varchar](50) NULL,
	[pwd] [varchar](50) NULL,
	[name] [varchar](50) NULL,
	[idcard] [varchar](50) NULL,
	[birthday] [varchar](50) NULL,
	[d_id] [int] NULL,
	[dname] [varchar](50) NULL,
	[postid] [int] NULL,
	[post] [varchar](250) NULL,
	[email] [varchar](50) NULL,
	[sex] [varchar](50) NULL,
	[tel] [varchar](50) NULL,
	[status] [varchar](50) NULL,
	[zhiwuid] [int] NULL,
	[zhiwu] [varchar](50) NULL,
	[sort] [int] NULL,
	[EntryDate] [varchar](50) NULL,
	[address] [varchar](255) NULL,
	[remarks] [varchar](255) NULL,
	[education] [varchar](50) NULL,
	[level] [varchar](50) NULL,
	[professional] [varchar](50) NULL,
	[schools] [varchar](50) NULL,
	[title] [varchar](50) NULL,
	[isDelete] [int] NULL,
	[Delete_time] [datetime] NULL,
	[portal] [varchar](250) NULL,
	[theme] [varchar](250) NULL,
	[canlogin] [int] NULL,
 CONSTRAINT [PK_hr_employee] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


GO


SET IDENTITY_INSERT [dbo].[hr_employee] ON
INSERT [dbo].[hr_employee] ([ID], [uid], [pwd], [name], [idcard], [birthday], [d_id], [dname], [postid], [post], [email], [sex], [tel], [status], [zhiwuid], [zhiwu], [sort], [EntryDate], [address], [remarks], [education], [level], [professional], [schools], [title], [isDelete], [Delete_time], [portal], [theme], [canlogin]) VALUES (1, N'admin', N'E10ADC3949BA59ABBE56E057F20F883E', N'超级管理员', NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[hr_employee] OFF

/****** Object:  Table [dbo].[hr_department]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[hr_department](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[d_name] [varchar](50) NULL,
	[parentid] [int] NULL,
	[parentname] [varchar](50) NULL,
	[d_type] [varchar](50) NULL,
	[d_icon] [varchar](50) NULL,
	[d_fuzeren] [varchar](50) NULL,
	[d_tel] [varchar](50) NULL,
	[d_fax] [varchar](50) NULL,
	[d_add] [varchar](255) NULL,
	[d_email] [varchar](50) NULL,
	[d_miaoshu] [varchar](255) NULL,
	[d_order] [int] NULL,
	[isDelete] [int] NULL,
	[Delete_time] [datetime] NULL,
 CONSTRAINT [PK_hr_department] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


SET IDENTITY_INSERT [dbo].[hr_department] ON
INSERT [dbo].[hr_department] ([id], [d_name], [parentid], [parentname], [d_type], [d_icon], [d_fuzeren], [d_tel], [d_fax], [d_add], [d_email], [d_miaoshu], [d_order], [isDelete], [Delete_time]) VALUES (1, N'小黄豆软件', 0, N'无', N'公司', N'images/icon/61.png', N'黄润伟', N'13467644655', N'', N'湖南省长沙市白沙路70号', N'250476029@qq.com', N'', 10, NULL, NULL)
SET IDENTITY_INSERT [dbo].[hr_department] OFF

/****** Object:  Table [dbo].[CRM_receive]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[CRM_receive](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Customer_id] [int] NULL,
	[Customer_name] [varchar](250) NULL,
	[Receive_num] [varchar](250) NULL,
	[Pay_type_id] [int] NULL,
	[Pay_type] [varchar](250) NULL,
	[Receive_amount] [float] NULL,
	[Receive_date] [datetime] NULL,
	[C_depid] [int] NULL,
	[C_depname] [varchar](250) NULL,
	[C_empid] [int] NULL,
	[C_empname] [varchar](250) NULL,
	[create_id] [int] NULL,
	[create_name] [varchar](250) NULL,
	[create_date] [datetime] NULL,
	[companyid] [int] NULL,
	[order_id] [int] NULL,
	[remarks] [varchar](max) NULL,
	[isDelete] [int] NULL,
	[Delete_time] [datetime] NULL,
	[receive_direction_id] [int] NULL,
	[receive_direction_name] [varchar](250) NULL,
	[receive_type_id] [int] NULL,
	[receive_type_name] [varchar](250) NULL,
	[receive_real] [float] NULL,
 CONSTRAINT [PK_CRM_receive] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[CRM_product_category]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[CRM_product_category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[product_category] [varchar](250) NULL,
	[parentid] [int] NULL,
	[product_icon] [varchar](250) NULL,
	[isDelete] [int] NULL,
	[Delete_id] [int] NULL,
	[Delete_time] [datetime] NULL,
 CONSTRAINT [PK_CRM_product_category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[CRM_product]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[CRM_product](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[product_name] [varchar](250) NULL,
	[category_id] [int] NULL,
	[category_name] [varchar](250) NULL,
	[specifications] [varchar](250) NULL,
	[status] [varchar](250) NULL,
	[unit] [varchar](250) NULL,
	[remarks] [varchar](max) NULL,
	[price] [float] NULL,
	[isDelete] [int] NULL,
	[Delete_time] [datetime] NULL,
 CONSTRAINT [PK_CRM_product] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[CRM_order_details]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[CRM_order_details](
	[order_id] [int] NULL,
	[product_id] [int] NULL,
	[product_name] [varchar](250) NULL,
	[price] [float] NULL,
	[quantity] [int] NULL,
	[unit] [varchar](250) NULL,
	[amount] [float] NULL
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[CRM_order]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[CRM_order](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Serialnumber] [varchar](250) NULL,
	[Customer_id] [int] NULL,
	[Customer_name] [varchar](250) NULL,
	[Order_date] [datetime] NULL,
	[pay_type_id] [int] NULL,
	[pay_type] [varchar](250) NULL,
	[Order_details] [varchar](max) NULL,
	[Order_status_id] [int] NULL,
	[Order_status] [varchar](250) NULL,
	[Order_amount] [float] NULL,
	[create_id] [int] NULL,
	[create_date] [datetime] NULL,
	[C_dep_id] [int] NULL,
	[C_dep_name] [varchar](250) NULL,
	[C_emp_id] [int] NULL,
	[C_emp_name] [varchar](250) NULL,
	[F_dep_id] [int] NULL,
	[F_dep_name] [varchar](250) NULL,
	[F_emp_id] [int] NULL,
	[F_emp_name] [varchar](250) NULL,
	[receive_money] [float] NULL,
	[arrears_money] [float] NULL,
	[invoice_money] [float] NULL,
	[arrears_invoice] [float] NULL,
	[isDelete] [int] NULL,
	[Delete_time] [datetime] NULL,
 CONSTRAINT [PK_CRM_order] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[CRM_invoice]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[CRM_invoice](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Customer_id] [int] NULL,
	[Customer_name] [varchar](250) NULL,
	[invoice_num] [varchar](250) NULL,
	[invoice_type_id] [int] NULL,
	[invoice_type] [varchar](250) NULL,
	[invoice_amount] [float] NULL,
	[invoice_content] [varchar](max) NULL,
	[invoice_date] [datetime] NULL,
	[C_depid] [int] NULL,
	[C_depname] [varchar](250) NULL,
	[C_empid] [int] NULL,
	[C_empname] [varchar](250) NULL,
	[create_id] [int] NULL,
	[create_name] [varchar](250) NULL,
	[create_date] [datetime] NULL,
	[order_id] [int] NULL,
	[isDelete] [int] NULL,
	[Delete_time] [datetime] NULL,
 CONSTRAINT [PK_CRM_invoice] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



/****** Object:  Table [dbo].[CRM_Follow]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[CRM_Follow](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Customer_id] [int] NULL,
	[Customer_name] [varchar](250) NULL,
	[Follow] [varchar](max) NULL,
	[Follow_date] [datetime] NULL,
	[Follow_Type_id] [int] NULL,
	[Follow_Type] [varchar](250) NULL,
	[department_id] [int] NULL,
	[department_name] [varchar](250) NULL,
	[employee_id] [int] NULL,
	[employee_name] [varchar](250) NULL,
	[isDelete] [int] NULL,
	[Delete_time] [datetime] NULL,
 CONSTRAINT [PK_CRM_Follow] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



/****** Object:  Table [dbo].[CRM_Customer]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[CRM_Customer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Serialnumber] [varchar](250) NULL,
	[Customer] [varchar](250) NULL,
	[address] [varchar](250) NULL,
	[tel] [varchar](250) NULL,
	[fax] [varchar](250) NULL,
	[site] [varchar](250) NULL,
	[industry_id] [int] NULL,
	[industry] [varchar](250) NULL,
	[Provinces_id] [int] NULL,
	[Provinces] [varchar](250) NULL,
	[City_id] [int] NULL,
	[City] [varchar](250) NULL,
	[CustomerType_id] [int] NULL,
	[CustomerType] [varchar](250) NULL,
	[CustomerLevel_id] [int] NULL,
	[CustomerLevel] [varchar](250) NULL,
	[CustomerSource_id] [int] NULL,
	[CustomerSource] [varchar](250) NULL,
	[DesCripe] [varchar](4000) NULL,
	[Remarks] [varchar](4000) NULL,
	[Department_id] [int] NULL,
	[Department] [varchar](250) NULL,
	[Employee_id] [int] NULL,
	[Employee] [varchar](250) NULL,
	[privatecustomer] [varchar](50) NULL,
	[lastfollow] [datetime] NULL,
	[Create_id] [int] NULL,
	[Create_name] [varchar](250) NULL,
	[Create_date] [datetime] NULL,
	[isDelete] [int] NULL,
	[Delete_time] [datetime] NULL,
 CONSTRAINT [PK_CRM_Customer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



/****** Object:  Table [dbo].[CRM_contract_attachment]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[CRM_contract_attachment](
	[contract_id] [int] NULL,
	[page_id] [varchar](250) NULL,
	[file_id] [varchar](250) NULL,
	[file_name] [varchar](250) NULL,
	[real_name] [varchar](250) NULL,
	[file_size] [int] NULL,
	[create_id] [int] NULL,
	[create_name] [varchar](250) NULL,
	[create_date] [datetime] NULL
) ON [PRIMARY]

GO



/****** Object:  Table [dbo].[CRM_contract]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[CRM_contract](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Contract_name] [varchar](250) NULL,
	[Serialnumber] [varchar](250) NULL,
	[Customer_id] [int] NULL,
	[Customer_name] [varchar](250) NULL,
	[C_depid] [int] NULL,
	[C_depname] [varchar](250) NULL,
	[C_empid] [int] NULL,
	[C_empname] [varchar](250) NULL,
	[Contract_amount] [float] NULL,
	[Pay_cycle] [int] NULL,
	[Start_date] [varchar](250) NULL,
	[End_date] [varchar](250) NULL,
	[Sign_date] [varchar](250) NULL,
	[Customer_Contractor] [varchar](250) NULL,
	[Our_Contractor_depid] [int] NULL,
	[Our_Contractor_depname] [varchar](250) NULL,
	[Our_Contractor_id] [int] NULL,
	[Our_Contractor_name] [varchar](250) NULL,
	[Creater_id] [int] NULL,
	[Creater_name] [varchar](250) NULL,
	[Create_time] [datetime] NULL,
	[Main_Content] [varchar](max) NULL,
	[Remarks] [varchar](max) NULL,
	[File_serialnumber] [varchar](250) NULL,
	[isDelete] [int] NULL,
	[Delete_time] [datetime] NULL,
 CONSTRAINT [PK_CRM_contract] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[CRM_Contact]    Script Date: 01/05/2015 16:17:29 ******/
CREATE TABLE [dbo].[CRM_Contact](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[C_name] [varchar](250) NULL,
	[C_sex] [varchar](250) NULL,
	[C_department] [varchar](250) NULL,
	[C_position] [varchar](250) NULL,
	[C_birthday] [varchar](250) NULL,
	[C_tel] [varchar](250) NULL,
	[C_fax] [varchar](250) NULL,
	[C_email] [varchar](250) NULL,
	[C_mob] [varchar](250) NULL,
	[C_QQ] [varchar](250) NULL,
	[C_add] [varchar](250) NULL,
	[C_hobby] [varchar](250) NULL,
	[C_remarks] [varchar](max) NULL,
	[C_customerid] [int] NULL,
	[C_customername] [varchar](250) NULL,
	[C_createId] [int] NULL,
	[C_createDate] [datetime] NULL,
	[isDelete] [int] NULL,
	[Delete_time] [datetime] NULL,
 CONSTRAINT [PK_CRM_Contact] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO




