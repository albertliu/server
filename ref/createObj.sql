USE [elearning]
GO
--收缩数据库日志文件：
use master
ALTER DATABASE elearning SET RECOVERY SIMPLE
DBCC SHRINKDATABASE(elearning)
DBCC SHRINKFILE(2)
ALTER DATABASE elearning SET RECOVERY FULL
--sp_change_users_login 'update_one','sqlrw','sqlrw'
--De0penl99O53!4N#~9.
--set datefirst 1  --将星期一设为第一天

select * from dictionaryDoc where kind like '%material%' order by kind, ID
select * from dictionaryDoc where kind like '%schedule%' order by kind, ID
select * from dictionaryDoc where kind like '%online%' order by kind, ID
select * from dictionaryDoc where item like '%预备%' order by kind, ID
--delete from dictionaryDoc where mID=1298
insert into dictionaryDoc(ID,item,kind,description,memo) values('0','公开','servicePrivate','','')
insert into dictionaryDoc(ID,item,kind,description,memo) values('1','私有','servicePrivate','','')
insert into dictionaryDoc(ID,item,kind,description,memo) values('2','报账','accountKind','','')
insert into dictionaryDoc(ID,item,kind,description,memo) values('3','台胞证','IDkind','','')
insert into dictionaryDoc(ID,item,kind,description,memo) values('5','其他','IDkind','','')
insert into dictionaryDoc(ID,item,kind,description,memo) values('6','六','week','','')
insert into dictionaryDoc(ID,item,kind,description,memo) values('8','社保证明','material','student_social','')
insert into dictionaryDoc(ID,item,kind,description,memo) values('0','个人','fromKind','','')
update dictionaryDoc set item='实操' where mID=1297
update dictionaryDoc set item='线上' where mID=1291
update dictionaryDoc set item='研究生及以上' where mID=242
update dictionaryDoc set item='本科或同等学历' where mID=241
update dictionaryDoc set item='专科或同等学历' where mID=240
update dictionaryDoc set item='中专或同等学历' where mID=239
update dictionaryDoc set item='高中或同等学历' where mID=238
delete from dictionaryDoc where mID=243

--questionType
-- JOB
-- dailywork: exec plan_dailyCheck  run at 0:01:00 every day

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- table
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

--第三方题库数据
CREATE TABLE [dbo].[questionOther](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[questionID] [varchar](50) NULL,
	[knowPointID] [varchar](50) NULL,
	[kindID] [int] NULL,
	[questionName] [nvarchar](2000) NOT NULL,
	[answer] [varchar](200) NULL,
	[A] [nvarchar](200) NULL,
	[B] [nvarchar](200) NULL,
	[C] [nvarchar](200) NULL,
	[D] [nvarchar](200) NULL,
	[E] [nvarchar](200) NULL,
	[F] [nvarchar](200) NULL,
	[id_A] [varchar](200) NULL,
	[id_B] [varchar](200) NULL,
	[id_C] [varchar](200) NULL,
	[id_D] [varchar](200) NULL,
	[id_E] [varchar](200) NULL,
	[id_F] [varchar](200) NULL,
	[status] [int] DEFAULT ((0)),
	[memo] [nvarchar](500) NULL,
	[mark] [varchar](50) NULL,
	[regDate] [datetime] DEFAULT (getdate())
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[deptInfo_model](
	[deptID] [int] IDENTITY(1,1) NOT NULL,
	[pID] [int] NULL,
	[deptName] [nvarchar](100) NULL,
	[kindID] [int] NULL DEFAULT ((0)),
	[linker] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[address] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[dept_status] [int] NULL DEFAULT ((0)),
	[memo] [nvarchar](500) NULL,
	[host] [varchar](50) NULL,
	[regDate] [datetime] NULL DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[unitInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[unitName] [nvarchar](100) NOT NULL,
	[taxNo] [varchar](50) NULL,
	[saler] [varchar](50) NULL,
	[kindID] [int] NULL DEFAULT ((0)),	--school/person
	[linker] [nvarchar](500) NULL,
	[phone] [nvarchar](100) NULL,
	[address] [nvarchar](100) NULL,
	[email] [nvarchar](200) NULL,
	[status] [int] NULL DEFAULT ((0)),
	[checker] [varchar](50) NULL,
	[association] [nvarchar](50) NULL,
	[memo] [nvarchar](2000) NULL,
	[host] [varchar](50) NULL,
	[regDate] [datetime] NULL DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[roleUserList_model](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[roleID] [varchar](50) NOT NULL,
	[userID] [varchar](50) NOT NULL,
	[status] [int] NULL DEFAULT ((0)),
	[scopeID] [int] NULL DEFAULT ((0)),
	[host] [varchar](50) NULL DEFAULT (''),
	[regDate] [smalldatetime] NULL DEFAULT (getdate()),
	[registerID] [varchar](50) NULL,
 CONSTRAINT [PK_roleUserList_model] PRIMARY KEY CLUSTERED 
(
	[roleID] ASC,
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[import_question_memo](
	[questionID] [varchar](50) NULL,
	[memo] [nvarchar](500) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[userInfo_model](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[userNo] [varchar](50) NOT NULL,
	[userName] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[realName] [nvarchar](50) NOT NULL,
	[kindID] [int] NULL DEFAULT ((0)),
	[status] [int] NULL DEFAULT ((0)),
	[phone] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[limitedDate] [smalldatetime] NULL,
	[mark] [int] NULL,
	[memo] [nvarchar](500) NULL,
	[host] [varchar](50) NOT NULL DEFAULT (''),
	[regDate] [smalldatetime] NULL DEFAULT (getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[permissionInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[permissionID] [varchar](50) NOT NULL,
	[permissionName] [nvarchar](50) NOT NULL,
	[owner] [int] NULL  DEFAULT ((0)),	--0 公共  1 系统专有  2 公司专有
	[scope] [int] NOT NULL  DEFAULT ((0)),
	[description] [nvarchar](50) NULL,
	[status] [int] NULL  DEFAULT ((0)),
	[mark] [char](1) NULL,
	[host] [varchar](50) NOT NULL DEFAULT (''),
	[regDate] [smalldatetime] NULL DEFAULT (getdate()),
	[registerID] [varchar](50) NULL,
 CONSTRAINT [PK_permissionInfo] PRIMARY KEY CLUSTERED 
(
	[permissionID] ASC,
	[host] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE TABLE [dbo].[roleInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[roleID] [varchar](50) NOT NULL,
	[roleName] [varchar](50) NOT NULL,
	[owner] [int] NULL DEFAULT ((0)),	--0 公共  1 系统专有  2 公司专有
	[description] [varchar](500) NULL,
	[status] [int] NULL DEFAULT ((0)),
	[host] [varchar](50) NOT NULL DEFAULT (''),
	[regDate] [smalldatetime] NULL DEFAULT (getdate()),
	[registerID] [varchar](50) NULL,
 CONSTRAINT [PK_roleInfo] PRIMARY KEY CLUSTERED 
(
	[roleID] ASC,
	[host] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[rolePermissionList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[roleID] [varchar](50) NOT NULL,
	[permissionID] [varchar](50) NOT NULL,
	[owner] [int] NULL DEFAULT ((0)),
	[status] [int] NULL DEFAULT ((0)),
	[host] [varchar](50) NULL DEFAULT (''),
	[regDate] [smalldatetime] NULL DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[returnReceiptList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[receiptDate] [smalldatetime] NULL,
	[userName] [varchar](50) NOT NULL,
	[kindID] [varchar](50) NOT NULL,
	[refID] [varchar](50) NOT NULL,
	[host] [varchar](50) NULL
) ON [PRIMARY]

GO

-- 证书项目
CREATE TABLE [dbo].[certificateInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[certID] [varchar](50) NOT NULL,
	[certName] [varchar](50) NOT NULL,
	[shortName] [varchar](50) NOT NULL,
	[kindID] [int] NULL default(0),		--certKind 0 公共项目  1 专属项目
	[type] [int] NULL default(0),		--certType 0 外部认证  1 内部认证
	[agencyID] [varchar](50) NULL,		--颁发机构
	[status] [int] NULL default(0),		--statusEffect
	[term] [int] NULL default(0),		--有效期（年）
	[host] [varchar](50) NOT NULL,		--专属项目所有者
	[memo] [varchar](500) NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

-- 课程
CREATE TABLE [dbo].[courseInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[certID] [varchar](50) NULL,
	[courseID] [varchar](50) NOT NULL,
	[courseName] [varchar](50) NOT NULL,
	[kindID] [int] NULL DEFAULT ((0)),		--certKind 0 公共项目  1 专属项目
	[hours] [int] NULL DEFAULT ((0)),
	[status] [int] NULL DEFAULT ((0)),
	[deadline] [int] NULL default(20),		--高于此数不可退课（%）
	[deadday] [int] NULL default(20),		--高于此数不可退课（天）
	[period] [int] NULL default(90),		--高于此数强制结束课程（天）
	[periodExt] [int] NULL default(360),	--最短培训周期（天）
	[completionPass] [int] NULL default(100),		--达到于此数可结业（%）
	[host] [varchar](50) NOT NULL,			--专属项目所有者
	[memo] [varchar](500) NULL,
	[regDate] [datetime] NULL DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

-- 第三方培训项目发布
CREATE TABLE [dbo].[projectInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[projectID] [varchar](50) NOT NULL,
	[projectName] [varchar](50) NOT NULL,
	[certID] [varchar](50) NOT NULL,
	[kindID] [int] NULL default(0),		--certKind 0 公共项目  1 专属项目
	[object] [varchar](50) NULL,		--培训对象
	[address] [varchar](200) NULL,		--培训地点
	[deadline] [smalldatetime] NULL,	--截止日期
	[status] [int] NULL default(0),		--statusIssue
	[phone] [varchar](50) NULL,		--培训对象
	[email] [varchar](50) NULL,		--培训对象
	[payKind] [int] NULL default(0),		--payKind 0 个人  1 团体
	[payGroup] [int] NULL default(0),		--团体开票的形式 payGroup 0 公司  1 部门
	[price] [int] NULL default(0),		--
	[host] [varchar](50) NOT NULL,		--专属项目所有者
	[memo] [varchar](2000) NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

-- 证书文本
CREATE TABLE [dbo].[diplomaInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[diplomaID] [varchar](50) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[certID] [varchar](50) NULL,
	[status] [int] NULL default(0),		--statusEffect
	[score] decimal(18,1) NULL default(0),	
	[term] [int] NULL default(0),		--有效期（年）
	[startDate] [smallDatetime] NULL,
	[endDate] [smallDatetime] NULL,
	[filename] [varchar](50) NOT NULL,	--电子文档
	[issued] [int] NULL default(0),		--statusNo  0 否 1 是 已发放
	[issueDate] [Datetime] NULL,		--发放日期
	[issueType] [int] NULL default(0),	--issueType 发放方式  0 代领 1 本人领取  2 放弃
	[issuer] [varchar](50) NULL,		--发放人
	[host] [varchar](50) NOT NULL,		
	[memo] [varchar](500) NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO


-- 题库
-- status: statusEffect
CREATE TABLE [dbo].[questionInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	questionID [varchar](50) NOT NULL,
	[questionName] [nvarchar](2000) NOT NULL,
	[kindID] [int] NULL,
	[courseID] [varchar](50) NULL,
	[knowPointID] [varchar](50) NULL,
	[answer] [varchar](50) NULL,
	[A] [nvarchar](200) NULL,
	[B] [nvarchar](200) NULL,
	[C] [nvarchar](200) NULL,
	[D] [nvarchar](200) NULL,
	[E] [nvarchar](200) NULL,
	[status] [int] NULL default(0),
	[memo] [varchar](500) NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

-- 公司课程目录
-- status: planStatus
CREATE TABLE [dbo].[hostCourseList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	courseID [varchar](50) NOT NULL,
	[host] [varchar](50) NOT NULL,
	[kindID] [int] NULL,
	[status] [int] NULL default(0),
	[memo] [varchar](500) NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

-- 公司教师
CREATE TABLE [dbo].[hostTeacherList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	courseID [varchar](50) NOT NULL,
	[host] [varchar](50) NOT NULL,
	[teacher] [int] NULL,
	[status] [int] NULL default(0),
	[memo] [varchar](500) NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

-- status: planStatus
CREATE TABLE [dbo].[studentCertList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[certID] [varchar](50) NOT NULL,
	[kindID] [int] NULL default(0),
	[status] [int] NULL default(0),
	[diplomaID] [varchar](50) NULL,
	[examScore] decimal(18,1) NULL default(0),	//模拟考试最好成绩
	[examTimes] [int] NULL default(0),	//模拟考试次数
	[memo] [varchar](500) NULL,
	[host] [varchar](50) NOT NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

-- status: planStatus
-- refID:[studentCertList].ID, if refID=0 then the course is choosed by student directly.
CREATE TABLE [dbo].[studentCourseList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[courseID] [varchar](50) NOT NULL,
	[refID] [int] NULL default(0),	
	[kindID] [int] NULL default(0),
	[status] [int] NULL default(0),
	[hours] [int] NULL default(0),
	[hoursSpend] [int] NULL default(0),
	[examScore] decimal(18,1) NULL default(0),	//模拟考试最好成绩
	[startDate] [datetime] NULL,
	[endDate] [datetime] NULL,
	[host] [varchar](50) NULL,
	[memo] [varchar](500) NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

-- status: planStatus
-- refID: studentCourseList.ID
-- completion: 完成度%
CREATE TABLE [dbo].[studentLessonList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[lessonID] [varchar](50) NOT NULL,
	[refID] [int] NULL default(0),
	[kindID] [int] NULL default(0),
	[status] [int] NULL default(0),
	[hours] [int] NULL default(0),
	[completion] [int] NULL default(0),
	[startDate] [datetime] NULL,
	[memo] [varchar](500) NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

-- 试卷
-- status: planStatus
-- kindID:dictionaryDoc.examKind 0 机考  1 线下考试
-- 证书编号certID与课程编号courseID都有（证书与课程共用同一个试卷）；
-- 只有证书编号：该考试只为证书所有；
-- 只有课程编号：该考试只为课程所有。
CREATE TABLE [dbo].[examInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[examID] [varchar](50) NOT NULL,
	[examName] [varchar](100) NOT NULL,
	[certID] [varchar](50) NULL,
	[courseID] [varchar](50) NULL,
	[kindID] [int] NULL default(0),
	[scoreTotal] [int] NULL default(100),
	[scorePass] [int] NULL default(60),
	[minutes] [int] NULL default(90),
	[status] [int] NULL default(0),
	[memo] [varchar](500) NULL,
	[regDate] [datetime] NULL,
	[registerID] [varchar](50) NULL
) ON [PRIMARY]
GO

-- status: planStatus
-- refID: studentLessonList.ID
-- proportion: 视频在课程中占据的课时比重
CREATE TABLE [dbo].[studentVideoList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[videoID] [varchar](50) NOT NULL,
	[refID] [int] NULL default(0),
	[kindID] [int] NULL default(0),
	[status] [int] NULL default(0),
	[proportion] [int] NULL default(0),
	[minutes] [int] NULL default(0),
	[maxTime] [int] NULL default(0),
	[lastTime] [int] NULL default(0),
	[startDate] [datetime] NULL,
	[lastDate] [datetime] NULL,
	[memo] [varchar](500) NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

-- status: planStatus
-- refID: studentLessonList.ID
-- proportion: 课件在课程中占据的课时比重
CREATE TABLE [dbo].[studentCoursewareList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[coursewareID] [varchar](50) NOT NULL,
	[refID] [int] NULL default(0),
	[kindID] [int] NULL default(0),
	[status] [int] NULL default(0),
	[proportion] [int] NULL default(0),
	[pages] [int] NULL default(0),
	[maxPage] [int] NULL default(0),
	[lastPage] [int] NULL default(0),
	[startDate] [datetime] NULL,
	[lastDate] [datetime] NULL,
	[memo] [varchar](500) NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

-- 学员试卷
-- status: examStatus	0 准备中  1 已开始  2 已交卷
-- kindID:dictionaryDoc.examKind 0 认证 1 课程
-- refID: when kingID=0 then [studentCertList].ID; when kindID=1 then [studentCourseList].ID
CREATE TABLE [dbo].[studentExamList](
	[paperID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[examID] [varchar](50) NOT NULL,
	[refID] [int] NULL default(0),
	[kindID] [int] NULL default(0),
	[status] [int] NULL default(0),
	[minutes] [int] NULL default(0),		--考试总时长（分钟）
	[secondRest] [int] NULL default(0),		--剩余秒数
	[scoreTotal] [int] NULL,				--总分
	[scorePass] [int] NULL,					--及格线
	[score] decimal(18,1) NULL default(0),	--学员得分
	[startDate] [datetime] NULL,			--开始时间
	[endDate] [datetime] NULL,				--交卷时间
	[lastDate] [datetime] NULL,				--最后答题时间
	[memo] [varchar](500) NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

-- 学员试题
-- status: planStatus
-- kindID:dictionaryDoc.questionType
-- refID: [studentQuestionList].ID
CREATE TABLE [dbo].[studentQuestionList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[questionID] [varchar](50) NOT NULL,
	[refID] [int] NULL default(0),
	[kindID] [int] NULL default(0),
	[status] [int] NULL default(0),
	[scorePer] decimal(18,1) NULL default(0),
	[score] decimal(18,1) NULL default(0),
	[myAnswer] [varchar](50) NULL,
	[memo] [varchar](500) NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

-- 学员反馈
-- status: dealStatus
-- kindID:dictionaryDoc.feedback
-- emergency:0 一般  1 紧急
-- refID:studentMessageInfo.ID
CREATE TABLE [dbo].[studentFeedbackInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[item] [nvarchar](4000) NULL,
	[refID] [int] NULL default(0),
	[kindID] [int] NULL default(0),
	[status] [int] NULL default(0),
	[emergency] [int] NULL default(0),
	[mobile] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[readDate] [datetime] NULL,
	[readerID] [varchar](50) NULL,
	[dealDate] [datetime] NULL,
	[dealerID] [varchar](50) NULL,
	[host] [varchar](50) NULL,
	[memo] [nvarchar](4000) NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

-- 学员反馈
-- status: readStatus 0 未读  1 已读  2 撤销
-- kindID:dictionaryDoc.message
-- emergency:0 一般  1 紧急
-- refID:studentFeedbackInfo.ID
CREATE TABLE [dbo].[studentMessageInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[item] [nvarchar](4000) NULL,
	[refID] [int] NULL default(0),
	[kindID] [int] NULL default(0),
	[status] [int] NULL default(0),
	[emergency] [int] NULL default(0),
	[readDate] [datetime] NULL,
	[host] [varchar](50) NULL,
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--课程所需材料列表
--kindID: material
--mark:0 认证项目  1 培训项目
--step:检查阶段 0 选课前  1 考试前  2 发证书前
CREATE TABLE [dbo].[certNeedMaterial](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[kindID] [int] NOT NULL default(0),
	[certID] [varchar](50) NOT NULL,
	[mark] [int] NULL default(0),
	[step] [int] NULL default(0)
) ON [PRIMARY]

--学生提交材料列表
--kindID: material
--type:0 电子  1 纸质
CREATE TABLE [dbo].[studentMaterials](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[kindID] [int] NOT NULL default(0),
	[filename] [varchar](50) NULL,
	[type] [int] NULL default(0),
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

--学生报名材料列表
--kindID: material
--status: 0 正常 1 通知  2 响应  3 确认 
--asker:质疑   answer:响应   closer:确认
CREATE TABLE [dbo].[studentMaterialsAsk](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[refID] [int] NOT NULL,
	[kindID] [int] NOT NULL default(0),
	[status] [int] NOT NULL default(0),		--statusAsk
	[askerID] [varchar](50) NULL,
	[askDate] [datetime] NULL,
	[answerID] [varchar](50) NULL,
	[answerDate] [datetime] NULL,
	[closerID] [varchar](50) NULL,
	[closerDate] [datetime] NULL
) ON [PRIMARY]

--学生报名课程专项材料
--每门课程只有一个专项材料
CREATE TABLE [dbo].[studentCourseMaterials](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[courseID] [varchar](50) NOT NULL,
	[filename] [varchar](50) NULL,
	[item] [varchar](50) NULL,		--material name
	[kindID] [int] NOT NULL default(0),
	[type] [int] NULL default(0),
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

--通用附件
CREATE TABLE [dbo].[materialInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[refID] [varchar](50) NOT NULL,		--参照标识
	[kind] [varchar](50) NOT NULL,		--类别
	[filename] [varchar](50) NULL,		--文件完整路径
	[type] [int] NULL default(0),
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--自动序列号
CREATE TABLE [dbo].[autoCode](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[kind] [varchar](50) NOT NULL,
	[mark] [varchar](50) NOT NULL,
	[lastNo] [int] NOT NULL DEFAULT ((0)),
	[lastCode] [varchar](50) NULL,
	[lastYear] [varchar](50) NULL DEFAULT ((0)),
	[useYear] [int] NULL DEFAULT ((0)),
	[split] [varchar](50) NULL DEFAULT ('-'),
	[long] [int] NULL,
	[memo] [varchar](50) NULL,
	[host] [varchar](50) NULL
) ON [PRIMARY]

GO

--证书生成列表
--每次批量生成证书将记录批次
CREATE TABLE [dbo].[generateDiplomaInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[certID] [varchar](50) NOT NULL,
	[qty] [int] NOT NULL default(0),
	[host] [varchar](50) NULL,
	[firstID] [varchar](50) NULL,
	[lastID] [varchar](50) NULL,
	[filename] [varchar](500) NULL,
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

--证书发放列表
--每次批量发放证书将记录批次
CREATE TABLE [dbo].[issueDiplomaInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[qty] [int] NOT NULL,
	[host] [varchar](50) NULL,
	[IDList] [varchar](4000) NULL,
	[issueType] [int] NULL,
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL,
	[registerID] [varchar](50) NULL
) ON [PRIMARY]


--上传学员报名列表
--每次批量生成报名记录
CREATE TABLE [dbo].[generateStudentInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[item] [varchar](100) NOT NULL,
	[qty] [int] NOT NULL default(0),
	[host] [varchar](50) NULL,
	[filename] [varchar](500) NULL,
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--上传学员成绩列表（附证书编号）
--每次批量生成成绩记录
CREATE TABLE [dbo].[generateScoreInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[item] [varchar](100) NOT NULL,
	[certID] [varchar](50) NOT NULL,
	[qty] [int] NOT NULL default(0),
	[host] [varchar](50) NULL,
	[filename] [varchar](500) NULL,
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--批量上传学员材料
--每次批量生成成绩记录
CREATE TABLE [dbo].[generateMaterialInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[qty] [int] NOT NULL default(0),
	[kindID] [varchar](50) NULL,
	[host] [varchar](50) NULL,
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--批量上传学员材料明细
CREATE TABLE [dbo].[generateMaterialDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[batchID] [int] NOT NULL default(0),
	[filename] [varchar](100) NULL
) ON [PRIMARY]

GO

--短信发送记录
CREATE TABLE [dbo].[log_sendsms](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NULL,
	[mobile] [varchar](50) NULL,
	[message] [nvarchar](500) NULL,
	[kind] [varchar](50) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--学员服务记录
CREATE TABLE [dbo].[studentServiceInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NULL,
	[mobile] [varchar](50) NULL,		--联系渠道（电话号码）
	[item] [nvarchar](4000) NULL,		--服务内容
	[refID] [int] NULL default(0),		--studentCourseList.ID
	[vID] [int] NULL default(0),		--dictionaryDoc.ID where kind='material'
	[kindID] [int] NULL default(0),		--资源类别:serviceKind:0 个人  1 学校
	[type] [int] NULL default(0),		--服务形式:serviceType:0 短信  1 电话  2 现场  9 其他
	[status] [int] NULL default(0),		--statusService: 0 已经完成  1 继续跟进  2 等待反馈
	[private] [int] NULL default(0),	--0 公开  1 私有
	[backDate] [datetime] NULL,			--反馈日期
	[feedback] [nvarchar](500) NULL,	--反馈内容
	[serviceDate] [datetime] NULL default(getDate()),
	[host] [varchar](50) NULL,
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--班级信息
CREATE TABLE [dbo].[classInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[classID] [varchar](50) NOT NULL,
	[certID] [varchar](50) NULL,		--
	[projectID] [varchar](50) NULL,		--
	[adviserID] [varchar](50) NULL,		--班主任
	[kindID] [int] NULL default(0),		--服务类别:serviceKind:0 通知  1 回访  2 咨询  9 其他
	[status] [int] NULL default(0),		--planStatus: 0 准备  1 进行  2 结束
	[dateStart] [datetime] NULL,		--开课日期
	[dateEnd] [datetime] NULL,			--结束日期
	[classroom] [nvarchar](500) NULL,	--教室
	[host] [varchar](50) NULL,
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--收费信息
CREATE TABLE [dbo].[payInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[invoice] [varchar](50) NULL,		--发票号
	[projectID] [varchar](50) NULL,		--
	[title] [nvarchar](100) NULL,		--抬头
	[amount] decimal(18,2) NULL default(0),		--发票金额
	[kindID] [int] NULL default(0),		--类别:payKind:0 个人  1 团体
	[type] [int] NULL default(0),		--支付方式:payType:0 现金  1 支付宝  2 微信  3 银行转账  9 其他
	[status] [int] NULL default(0),		--statusPay: 0 未支付  1 已支付  2 已退款
	[deptID] [int] NULL default(0),		--部门开票
	[datePay] [datetime] NULL,			--付款日期
	[dateInvoice] [smalldatetime] NULL,		--开票日期
	[dateInvoicePick] [smalldatetime] NULL,		--发票领取日期
	[dateRefund] [smalldatetime] NULL,		--退款日期
	[refunderID] [varchar](50) NULL,		--退款操作人
	[checkDate] [smalldatetime] NULL,	--确认日期
	[checkerID] [varchar](50) NULL,		--确认人
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--收费明细
CREATE TABLE [dbo].[payDetailInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[payID] int NOT NULL,		--payInfo.ID
	[enterID] int NOT NULL,		--studentCourseList.ID
	[price] decimal(18,2) NULL default(0),		--金额
	[status] [int] NULL default(0),		--statusEffect
	[payID_old] int NULL default(0),	
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--加油站标识对照表
CREATE TABLE [dbo].[deptRefrence](
	[deptID] int NOT NULL,		--deptInfo.deptID
	[refID] [varchar](50) NOT NULL,		--from SPC
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate())
) ON [PRIMARY]

GO

--批量生成准考证信息
CREATE TABLE [dbo].[generatePasscardInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[classID] [varchar](50) NULL,
	[certID] [varchar](50) NULL,
	[title] [nvarchar](100) NOT NULL,
	[qty] [int] NULL,
	[startNo] [int] NULL,
	[startDate] [smalldatetime] NULL,
	[startTime] [varchar](100) NULL,
	[address] [nvarchar](100) NULL,
	[notes] [nvarchar](500) NULL,
	[send] [int] NULL,
	[sendDate] [smalldatetime] NULL,
	[sender] [varchar](50) NULL,
	[sendScore] [int] NULL,
	[sendScoreDate] [smalldatetime] NULL,
	[senderScore] [varchar](50) NULL,
	[status] [int] NULL default (0),
	[filename] [varchar](500) NULL,
	[filescore] [varchar](500) NULL,
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--准考证
CREATE TABLE [dbo].[passcardInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[refID] [int] NOT NULL,
	[enterID] [int] NOT NULL,
	[passNo] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[score] [int] NULL default(0),
	[resit] [int] NULL default(0),
	[status] [int] NULL default(0),  --examResult:0 未考 1 合格 2 不合格
	[memo] [varchar](50) NULL,
	[regDate] [smalldatetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--批量申报考生信息
CREATE TABLE [dbo].[generateApplyInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[courseID] [varchar](50) NOT NULL,		--
	[applyID] [varchar](50) NULL,		--申报批号
	[title] [nvarchar](100) NOT NULL,
	[startDate] [smalldatetime] NULL,
	[address] [nvarchar](100) NULL,
	[notes] [nvarchar](500) NULL,
	[send] [int] NULL,
	[sendDate] [smalldatetime] NULL,
	[sender] [varchar](50) NULL,
	[sendScore] [int] NULL,
	[sendScoreDate] [smalldatetime] NULL,
	[senderScore] [varchar](50) NULL,
	[status] [int] NULL default (0),
	[filename] [varchar](500) NULL,
	[filescore] [varchar](500) NULL,
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--申报
CREATE TABLE [dbo].[applyInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[refID] [int] NOT NULL,
	[enterID] [int] NOT NULL,
	[applyNo] [varchar](50) NULL,
	[score] [int] NULL default(0),  
	[score1] [int] NULL default(0),
	[score2] [int] NULL default(0),
	[resit] [int] NULL default(0),
	[statusApply] [int] NULL default(0),  --statusApply:0 待考  1 通过 2 未通过
	[status] [int] NULL default(0),  --examResult:0 未考 1 合格 2 不合格 3 缺考
	[memo] [varchar](50) NULL,
	[regDate] [smalldatetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--准考证
CREATE TABLE [dbo].[firemanEnterInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[enterID] [int] NOT NULL,
	[area] [varchar](50) NULL,				--户口所在地
	[address] [varchar](100) NULL,			--详细地址
	[employDate] [smalldatetime] NULL,		--参加工作时间
	[university] [varchar](100) NULL,		--所在学校
	[gradeDate] [smalldatetime] NULL,		--毕业时间
	[profession] [varchar](50) NULL,		--专业名称
	[area_now] [varchar](50) NULL,			--常住地市
	[kind1] [int] NULL default(0),			--人员属性
	[kind2] [int] NULL default(0),			--政治面貌
	[kind3] [int] NULL default(0),			--学校类型
	[kind4] [int] NULL default(0),			--职业方向
	[kind5] [int] NULL default(0),			--职业等级
	[kind6] [int] NULL default(0),			--鉴定分类
	[kind7] [int] NULL default(0),			--满足资格所属类
	[kind8] [int] NULL default(0),			--相关职业
	[kind9] [int] NULL default(0),			--申报资格
	[kind10] [int] NULL default(0),			--从事职业
	[kind11] [int] NULL default(0),			--在职情况
	[kind12] [int] NULL default(0),			--学历
	[materials] [varchar](200) NULL,
	[memo] [varchar](500) NULL,
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO


--购物车
CREATE TABLE [dbo].[cartBill](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[refID] [int] NULL,
	[kindID] [varchar](50) NOT NULL,
	[status] [int] NULL,
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--某个试卷已组卷试题
CREATE TABLE [dbo].[studentQuestionUsed](
	[questionID] [varchar](50) NOT NULL,
	[refID] [int] NULL,		--paperID
	[kindID] [int] NULL,
	[status] [int] NULL,	--0 未做  1 正确  2 错误
	[answer] [varchar](50) NULL,
	[myAnswer] [varchar](50) NULL,
	[times] [int] NULL default(0)
) ON [PRIMARY]

GO

--课表
CREATE TABLE [dbo].[schedule](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[courseID] [varchar](50) NOT NULL,
	[seq] [int] NULL default(0),
	[kindID] [int] NULL default(0),		--0 理论  1 实训  2 复习
	[typeID] [int] NULL default(0),		--0 上午  1 下午  2 晚上
	[hours] [int] NULL default(0),		--课时
	[period] [varchar](50) NOT NULL,	--时段
	[item] [nvarchar](100) NULL,
	[status] [int] NULL default(0),
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--课表
CREATE TABLE [dbo].[classSchedule](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[classID] [varchar](50) NOT NULL,
	[courseID] [varchar](50) NOT NULL,
	[seq] [int] NULL default(0),
	[kindID] [int] NULL default(0),		--scheduleKind: 0 理论  1 实训
	[typeID] [int] NULL default(0),		--scheduleType: 0 上午  1 下午
	[online] [int] NULL default(0),		--online: 0 线下  1 在线
	[hours] [int] NULL default(0),		--课时
	[period] [varchar](50) NOT NULL,	--时段
	[theDate] [datetime] NULL,
	[theWeek] [int] NULL default(0),
	[status] [int] NULL default(0),
	[item] [nvarchar](100) NULL,
	[address] [nvarchar](100) NULL,
	[teacher] [varchar](50) NULL,
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--教师信息
CREATE TABLE [dbo].[teacherInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[teacherID] [varchar](50) NOT NULL,
	[teacherName] [varchar](50) NOT NULL,
	[partner] [int] NULL default(0),	--合作标记
	[status] [int] NULL,
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--教师信息
CREATE TABLE [dbo].[courseTeacherList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[teacherID] [varchar](50) NOT NULL,
	[courseID] [varchar](50) NOT NULL,
	[type0] [int] NULL default(0),	--理论
	[type1] [int] NULL default(0),	--实训
	[status] [int] NULL,
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--合作单位信息
CREATE TABLE [dbo].[partnerInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[partnerID] [varchar](50) NOT NULL,
	[partnerName] [varchar](50) NOT NULL,
	[kindID] [int] NULL default(0),	
	[typeID] [int] NULL default(0),	
	[status] [int] NULL default(0),
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL default('admin.')
) ON [PRIMARY]

GO

--提示照片、签名的消息
CREATE TABLE [dbo].[log_attention](
	[ID] int IDENTITY(1,1) NOT NULL,
	[refID] [varchar](50) NOT NULL,		--username or enterID
	[kindID] [int] NULL default(0),	    --0 photo  1 signature
	[status] [int] NULL default(1),		--1 call 2 reply 3 close
	[replyDate] [datetime],
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL default('admin.')
) ON [PRIMARY]

GO

--提示照片、签名的批次消息
CREATE TABLE [dbo].[log_generateAttention](
	[ID] int IDENTITY(1,1) NOT NULL,
	[kindID] [int] NULL default(0),	    --0 photo  1 signature
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL default('admin.')
) ON [PRIMARY]
GO

--发票信息
CREATE TABLE [dbo].[invoiceInfo](
	[ID] int IDENTITY(1,1) NOT NULL,
	[kind] [nvarchar](50),	    --发票种类
	[invCode] [varchar](50) NULL,	--发票代码
	[invID] [varchar](50) NULL,		--发票号码
	[taxNo] [varchar](50) NULL,	--税号
	[taxUnit] [varchar](50) NULL,		--发票抬头
	[invDate] [datetime] NULL,  --导入日期
	[item] [nvarchar](50) NULL,  --项目
	[amount] decimal(18,2) NULL default(0),		--发票金额
	[cancel] [int] NULL default(0),	    --0 有效  1 作废
	[cancelDate] [datetime] NULL,  --作废日期
	[payType] [nvarchar](50) NULL,  --支付方式
	[payStatus] [int] NULL default(0),	    --支付状态 0 已付  1 应收
	[operator] [nvarchar](50) NULL,  --开票人
	[memo] [nvarchar](500) NULL,
	[checkDate] [datetime] NULL,  --收款确认日期
	[checker] [nvarchar](50) NULL,  --收款确认人
	[regDate] [datetime] NULL default(getDate()),  --导入日期
	[registerID] [varchar](50) NULL default('admin.')	--导入人
) ON [PRIMARY]
GO

--诺诺返回信息
CREATE TABLE [dbo].[autoPayInfo](
	[ID] int IDENTITY(1,1) NOT NULL,
	[kind] [int] NULL DEFAULT (0),	    --类别: 0 pay, 1 invoice, 2 refund
	[enterID] [int] NULL DEFAULT (0),
	[amount] [decimal](18, 2) default(0),		--金额
	[payStatus] [int] NULL DEFAULT (0),	--0--待支付 1--已支付 2--支付失败 3--关闭 4--退款中 5--退款成功 6--退款失败
	[payTime] [datetime] NULL,  --日期
	[payType] [varchar](50) NULL,		--支付类型 WECHAT/ALIPAY
	[subject] [nvarchar](500) NULL,  --项目
	[customerTaxnum] [varchar](50) NULL,  --税号
	[taxUnit] [varchar](50) NULL,		--发票抬头
	[orderNo] [varchar](50) NULL,  --诺诺订单号
	[outOrderNo] [varchar](50) NULL,  --支付订单号/发票号
	[userId] [varchar](50) NULL,  --
	[phone] [varchar](50) NULL,  --
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate())
) ON [PRIMARY]
GO

--诺诺接口返回原始信息
CREATE TABLE [dbo].[autoPayReturn](
	[ID] int IDENTITY(1,1) NOT NULL,
	[kind] [varchar](50) NULL,
	[memo] [nvarchar](4000) NULL,
	[regDate] [datetime] NULL default(getDate())
) ON [PRIMARY]
GO

--看视频刷脸标识记录
CREATE TABLE [dbo].[log_set_shotNow](
	[ID] int IDENTITY(1,1) NOT NULL,
	[refID] int NULL,
	[shotTime] int NULL,
	[shoted] int NULL,
	[regDate] [datetime] NULL default(getDate())
) ON [PRIMARY]
GO

--指定销售、公司、集团的特殊价格
--kind: sales/host/company
CREATE TABLE [dbo].[coursePrice](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[courseID] [varchar](50) NOT NULL,
	[price] [decimal](18, 2) NULL,
	[kind] [varchar](50) NOT NULL,
	[item] [varchar](50) NOT NULL,
	[status] [int] NULL
) ON [PRIMARY]

GO

--学员来源信息
CREATE TABLE [dbo].[sourceInfo](
	[ID] int IDENTITY(1,1) NOT NULL,
	[source] nvarchar(50) NOT NULL,	
	[status] [int] NULL default(0),
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL default('admin.')
) ON [PRIMARY]
GO

--用户可以查看的班级
--mark: A generateApply   B classInfo
CREATE TABLE [dbo].[user_class_list](
	[ID] int IDENTITY(1,1) NOT NULL,
	[username] varchar(50) NOT NULL,
	[classID] int NOT NULL,	--mark: A generateApply.ID   B classInfo.ID
	[mark] varchar(50) NOT NULL default('A'),
	[status] [int] NULL default(0),
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL default('admin.')
) ON [PRIMARY]
GO

--参考视频
CREATE TABLE [dbo].[help_videoInfo](
	[ID] int IDENTITY(1,1) NOT NULL,
	[title] nvarchar(50) NOT NULL,
	[seconds] int NULL,	
	[vod] [varchar](500) NULL,
	[status] [int] NULL default(0)
) ON [PRIMARY]
GO

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- function
----------------------------------------------------------------------------------------------------

-- CREATE DATE: 2017-06-08
-- 登录：0. 成功 1. not found 2. passwd error 3.diabled 4.expired
-- USE CASE: select * from dbo.studentLogin('zzz','xx','xx')
ALTER FUNCTION [dbo].[studentLogin]
(	
	@username varchar(50),@passwd varchar(50),@host varchar(50)
)
RETURNS
@Table_Var TABLE 
(
	e int,msg varchar(50), userID int,username varchar(50),name varchar(50),hostName varchar(50),newCourse int
) 
--with encryption
AS
BEGIN
	declare @e int, @msg varchar(50),@userID int,@name varchar(50),@status int,@passwd0 varchar(50),@user varchar(50),@hostName varchar(100),@newCourse int
	select @e=0,@msg='登录成功',@userID=0,@name='',@username=@username,@hostName=hostName,@newCourse=0 from hostInfo where hostNo=@host
	
	if exists(select 1 from studentInfo where username=@username)	-- and host=@host
	begin
		select @userID=userID,@user=userName,@name=name,@passwd0=password,@status=user_status,@newCourse=dbo.getStudentCurrCourseCount(username) from studentInfo where username=@username
		if @user <> @username
			select @e=1,@msg='该用户不存在, 请注册。'	--防止SQL注入
		if @passwd <> @passwd0
			select @e=2,@msg='密码错误。'
		if @status = 1
			select @e=3,@msg='账号已被禁用。'
		if @status = 2
			select @e=4,@msg='密码已过期，请重新设置密码。'
	end
	else
		select @e=1,@msg='该用户不存在。'
	insert into @Table_Var(e,msg,userID,username,name,hostName,newCourse) values(@e,@msg,@userID,@username,@name,@hostName,@newCourse)
	RETURN
END
GO

-- CREATE DATE: 2020-05-01
-- 登录：0. 成功 1. not found 2. passwd error 3.diabled 4.expired
-- USE CASE: select * from dbo.userLogin('zzz','xx','xx')
ALTER FUNCTION [dbo].[userLogin]
(	
	@username varchar(50),@password varchar(50),@host varchar(50)
)
RETURNS
@Table_Var TABLE 
(
	e int,msg varchar(50), userID int,username varchar(50),realName nvarchar(50),hostName varchar(50),hostKind int,deptID int,teacher int
) 
--with encryption
AS
BEGIN
	declare @e int, @msg varchar(50),@userID int,@realName nvarchar(50),@status int,@passwd0 varchar(50),@user varchar(50),@userNo varchar(50),@hostName varchar(100),@hostKind int,@deptID int,@teacher int
	select @e=0,@msg='登录成功',@userID=0,@realName=''
	select @hostName=hostName,@hostKind=kindID from hostInfo where hostNo=@host
	
	if exists(select 1 from userInfo where userNo=@username and (host='' or host=@host))
	begin
		select @userID=userID,@userNo=userNo,@user=userName,@realName=realName,@passwd0=password,@status=status,@deptID=deptID from userInfo where userNo=@username and (host='' or host=@host)
		if @userNo <> @username
			select @e=1,@msg='该用户不存在。'	--防止SQL注入
		if @password <> @passwd0
			select @e=2,@msg='密码错误。'
		if @status = 1
			select @e=3,@msg='账号已被禁用。'
		if @status = 2
			select @e=4,@msg='密码已过期，请重新设置密码。'
		select @teacher=dbo.userHasRole(@user,'teacher')
	end
	else
		select @e=1,@msg='该用户不存在。'
	insert into @Table_Var(e,msg,userID,username,realName,hostName,hostKind,deptID,teacher) values(@e,@msg,@userID,iif(@user='samra.','amra.',@user),@realName,@hostName,@hostKind,@deptID,@teacher)
	RETURN
END
GO

-- CREATE DATE: 2020-05-08
-- 获取学员已选证书项目
-- status:0 准备  1 学习中  2 结束
-- USE CASE: select * from dbo.[getStudentCertList]('120107196604032113')
CREATE FUNCTION [dbo].[getStudentCertList]
(	
	@username varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT * from v_studentCertList where username=@username
)
GO

-- CREATE DATE: 2020-05-08
-- 获取学员可选证书项目（去除已选项目及其他公司专属项目）
-- status:0 准备  1 学习中  2 结束
-- 已取得证书在过期前60天不可再选
-- USE CASE: select * from dbo.[getStudentCertRestList]('120107196604032113')
ALTER FUNCTION [dbo].[getStudentCertRestList]
(	
	@username varchar(50)
)
RETURNS @tab TABLE (ID int, certID varchar(50),certName varchar(100),mark int,reexamine int)
AS
BEGIN
	declare @kindID int,@host varchar(50),@deptID varchar(20),@c555 int
	select @kindID=kindID, @host=host, @deptID=dept1 from studentInfo where username=@username
	select @c555=c555 from deptInfo where deptID=@deptID
	select @deptID=isnull(@deptID,'')

	if @kindID=0	--系统内员工
	begin
		INSERT INTO @tab
		SELECT * FROM
		(
			SELECT a.ID,a.certID,a.certName,0 as mark,a.reexamine from v_certificateInfo a, projectInfo b where a.certID=b.certID and b.host=@host and b.status=1 and (dbo.pf_inStrArray(b.dept,',',@deptID)=1 or @deptID='') 	--已开课外部认证项目
			union
			SELECT ID,certID,certName,0 as mark,reexamine from v_certificateInfo where host=@host and status=0 and kindID=0 and type=1 and (mark=0 or mark=1)	--所有内部认证项目（公共）
			union
			SELECT a.ID,a.certID,a.certName,0,a.reexamine from v_certificateInfo a, studentInfo b where a.status=0 and a.kindID=1 and b.username=@username and a.host=b.host and (a.mark=0 or a.mark=1)	--所有认证项目（专属）
		) x where certID not in (select certID from v_studentCertList where username=@username and status<2 and diplomaID='' union select certID from v_diplomaInfo where username=@username and status=0 and datediff(d,getDate(),endDate)>180)
		union
		SELECT * FROM
		(
			select ID,courseID,courseName,1 as mark,re from v_courseInfo where status=0 and kindID=0 and certID='' and (mark=0 or mark=1)	--所有非认证项目（公共）
			union
			SELECT a.ID,a.courseID,a.courseName,1,a.re from v_courseInfo a, studentInfo b where a.status=0 and a.kindID=1 and a.certID='' and b.username=@username and a.host=b.host and (a.mark=0 or a.mark=1)	--所有非认证项目（专属）
		) y where courseID not in (select courseID from v_studentCourseList where username=@username and status<2)
	end
	else	--系统外员工
	begin
		INSERT INTO @tab
		SELECT * FROM
		(
			SELECT ID,certID,certName,0 as mark,reexamine from v_certificateInfo where host=@host and status=0 and kindID=0 and type=1 and (mark=0 or mark=2)
			union
			SELECT a.ID,a.certID,a.certName,0,a.reexamine from v_certificateInfo a, studentInfo b where a.status=0 and a.kindID=1 and b.username=@username and a.host=b.host and (a.mark=0 or a.mark=2)
		) x where certID not in (select certID from v_studentCertList where username=@username and status<2 and diplomaID='' union select certID from v_diplomaInfo where username=@username and status=0 and datediff(d,getDate(),endDate)>90)
		union
		SELECT * FROM
		(
			select ID,courseID,courseName,1 as mark,re from v_courseInfo where status=0 and kindID=0 and certID='' and (mark=0 or mark=2)
			union
			SELECT a.ID,a.courseID,a.courseName,1,a.re from v_courseInfo a, studentInfo b where a.status=0 and a.kindID=1 and a.certID='' and b.username=@username and a.host=b.host and (a.mark=0 or a.mark=2)
		) y where courseID not in (select courseID from v_studentCourseList where username=@username and status<2)
	end

	if exists(select 1 from studentInfo where username=@username and age>=60) and exists(select 1 from @tab where certID='C5')
	begin	
		if exists(select 1 from studentInfo where username=@username and age>=60)
			delete from @tab where certID='C5'	--不得超过60岁
		else
			if @c555=0
				update @tab set certName=certName + '(超过60岁的不得从事建筑类工作)' where certID='C5'	--超过60岁且不在预批范围的给予提示
	end
	RETURN
END
GO

-- CREATE DATE: 2020-05-08
-- 获取某个认证项目的所有课程列表
-- USE CASE: select * from dbo.[getCourseListByCertID]('C001')
CREATE FUNCTION [dbo].[getCourseListByCertID]
(	
	@certID varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT * from v_courseInfo where certID=@certID
)
GO

-- CREATE DATE: 2020-05-08
-- 获取某个学员所选认证项目的所有课程列表
-- USE CASE: select * from dbo.[getStudentCertCourseList]('120107196604032113')
ALTER FUNCTION [dbo].[getStudentCertCourseList]
(	
	@username varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT a.*,b.status as certStatus from v_studentCourseList a, v_studentCertList b where a.refID=b.ID and b.username=@username
)
GO

-- CREATE DATE: 2020-05-08
-- 获取某个学员的所有课程列表
-- USE CASE: select * from dbo.[getStudentCourseList]('120107196604032113')
CREATE FUNCTION [dbo].[getStudentCourseList]
(	
	@username varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT * from v_studentCourseList where username=@username
)
GO


-- CREATE DATE: 2020-05-08
-- 获取学员某个课程的课节列表
-- USE CASE: select * from dbo.[getStudentLessonList](1)
CREATE FUNCTION [dbo].[getStudentLessonList]
(	
	@refID int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT * from v_studentLessonList where refID=@refID
)
GO

-- CREATE DATE: 2020-05-08
-- 获取学员某个课程的课节列表
-- USE CASE: select * from dbo.[getStudentLessonListByUser]('120107196604032113')
ALTER FUNCTION [dbo].[getStudentLessonListByUser]
(	
	@username varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT top 100 percent a.*,dbo.getMissingItemsByCertID(b.ID) as missingItems from v_studentLessonList a, studentCourseList b where a.refID=b.ID and b.username=@username order by b.courseID,a.seq
)
GO

-- CREATE DATE: 2020-05-08
-- 获取学员某个课程的课节信息
-- USE CASE: select * from dbo.[getStudentLesson](1)
ALTER FUNCTION [dbo].[getStudentLesson]
(	
	@ID int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT top 100 percent * from v_studentLessonList where ID=@ID order by seq
)
GO

-- CREATE DATE: 2020-05-08
-- 获取石化公司一级部门列表
-- USE CASE: select * from dbo.[getDept1List](1)
CREATE FUNCTION [dbo].[getDept1List]()
RETURNS TABLE 
AS
RETURN 
(
	select top 100 percent * from (select deptID,deptName from deptInfo where host='spc' and kindID=0 and pID=8 and dept_status=0 union select 99,'系统外单位') a order by deptID 
)
GO

-- CREATE DATE: 2020-05-08
-- 获取一级部门列表
-- USE CASE: select * from dbo.[getHostDeptList]('spc')
CREATE FUNCTION [dbo].[getHostDeptList]
(	
	@host varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	select top 100 percent deptID,deptName from deptInfo where pID=(select deptID from deptInfo where pID=0 and host=@host) and kindID=0 and dept_status=0 order by deptID
)
GO

-- CREATE DATE: 2020-05-08
-- 获取学员某个课节的视频
-- USE CASE: select * from dbo.[getStudentVideo](1)
CREATE FUNCTION [dbo].[getStudentVideo]
(	
	@refID int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT * from v_studentVideoList where refID=@refID
)
GO

-- CREATE DATE: 2020-05-08
-- 获取学员某个课节的视频
-- USE CASE: select * from dbo.[getStudentCourseware](1)
CREATE FUNCTION [dbo].[getStudentCourseware]
(	
	@refID int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT * from v_studentCoursewareList where refID=@refID
)
GO

-- CREATE DATE: 2020-05-08
-- 获取某个教师的课程项目
-- @username: 以某个demo学员的名义
-- USE CASE: select * from dbo.[getCourseListByTeacher]('120107196604032113')
CREATE FUNCTION [dbo].[getCourseListByTeacher]
(	
	@teacher varchar(50), @username varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT a.* from v_studentCourseList a, courseTeacherList b where a.certID=b.courseID and a.username=@username and b.teacherID=@teacher
)
GO

--CREATE Date:2020-05-19
--根据给定的学员证书项目，计算其完成度
CREATE FUNCTION [dbo].[getCertCompletion](@ID int)
RETURNS decimal(18,2)
AS
BEGIN
	declare @re decimal(18,2)
	select @re = 0
	select @re = avg(completion) from v_studentCourseList where refID=@ID 

	return @re
END

--CREATE Date:2020-05-19
--根据给定的学员证书项目，计算其是否允许退课
--报名超过一定期限，或完成课时进度达到一定值，或已付费，不能直接删除
--0 允许 1 不允许
ALTER FUNCTION [dbo].[getCertCancelAllow](@ID int)
RETURNS int
AS
BEGIN
	declare @re int,@i int,@j int,@pay int
	select @re = 0,@i=0,@j=0,@pay=0
	select @i = max(datediff(d,regDate,getDate())-deadday), @j=max(completion-deadline), @pay=max(pay_status) from v_studentCourseList where refID=@ID 
	if @i>0 or @j>0 or @pay>0
		set @re=1
	return @re
END

--CREATE Date:2020-05-11
--根据给定的学员课节，计算其完成度
ALTER FUNCTION [dbo].[getLessonCompletion](@ID int)
RETURNS decimal(18,2)
AS
BEGIN
	declare @re decimal(18,2)
	select @re = 0.00
	select @re = (case when sum(a.re)>97 then 100 else sum(a.re) end) from(
		select sum(maxTime*proportion * 1.00/60.0/(case when minutes=0 then 100 else minutes end)) as re from studentVideoList where refID=@ID 
		union
		select sum(maxPage * proportion * 1.00/(case when pages=0 then 100 else pages end)) from studentCoursewareList where refID=@ID 
	) a

	return @re
END

--CREATE Date:2020-05-11
--根据给定的学员课程，计算其完成度
ALTER FUNCTION [dbo].[getCourseCompletion](@ID int)
RETURNS decimal(18,2)
AS
BEGIN
	declare @re decimal(18,2)
	select @re = 0
	select @re = avg(completion) from v_studentLessonList where refID=@ID 

	return isnull((case when @re>97 then 100 else @re end),0)
END

--CREATE Date:2020-05-11
--根据给定的学员课程ID，查找其模拟考试试卷ID
--先找课程相关证书的考试，如果没有则找课程本身的考试。
ALTER FUNCTION [dbo].[getCoursePaperID](@enterID int, @refID int)
RETURNS varchar(4000)
AS
BEGIN
	declare @re nvarchar(max), @p int, @item nvarchar(50),@score decimal(18, 2),@i int
	select @re = '',@i=0
	--select @re = paperID from studentExamList where refID=(case when @enterID>0 then @enterID else @refID end) 
	declare rc cursor for select a.paperID,isnull(b.memo,'') item,isnull(a.score,0) from studentExamList a, examInfo b where a.examID=b.examID and a.kind=0 and a.refID=(case when @enterID>0 then @enterID else @refID end)
	open rc
	fetch next from rc into @p,@item,@score
	While @@fetch_status=0 
	Begin 
		select @re = @re + '{"paperID":' + cast(@p as varchar) + ',"item":"' + @item + '","examScore":"' + cast(@score as varchar) + '分","pkind":0, "examID":""},'
		select @i=@i+1
		fetch next from rc into @p,@item,@score
	End
	Close rc 
	Deallocate rc
	
	if @i > 0
	begin
		-- 添加错题集
		select @re = @re + '{"paperID":' + cast(@enterID as varchar) + ',"item":"错题集","examScore":"' + cast(count(*) as varchar) + '题","pkind":1, "examID":""},' from studentQuestionWrong where enterID=@enterID

		-- 添加总题库
		declare @courseID varchar(50), @certID varchar(50), @pp varchar(50), @kindID int, @qty1 varchar(50), @qty2 varchar(50), @qty3 varchar(50)
		select @courseID=a.courseID, @certID=b.certID from studentCourseList a, courseInfo b where a.courseID=b.courseID and a.ID=@enterID
		declare rc cursor for select cast(count(*) as varchar), isnull(sum(iif(a.kindID=1,1,0)),0), isnull(sum(iif(a.kindID=2,1,0)),0), isnull(sum(iif(a.kindID=3,1,0)),0), d.examID, d.kindID from questionInfo a, (select distinct knowPointID, b.examID, b.kindID from examInfo b, examRuleInfo c where b.examID=c.examID and b.courseID=@courseID) d 
			where a.knowPointID=d.knowPointID and a.status=0
			group by d.examID, d.kindID
		open rc
		fetch next from rc into @pp,@qty1,@qty2,@qty3,@item,@kindID
		While @@fetch_status=0 
		Begin 
			select @re = @re + '{"paperID":' + cast(@enterID as varchar) + ',"item":"' + iif(@kindID=0,'应知','应会') + '总题库","examScore":"' + @pp + '题","pkind":2, "examID":"' + @item + '","qty1":' + @qty1 + ',"qty2":' + @qty2 + ',"qty3":' + @qty3 + '},'
			fetch next from rc into @pp,@qty1,@qty2,@qty3,@item,@kindID
		End
		Close rc 
		Deallocate rc

		-- 添加收藏夹
		select @re = @re + '{"paperID":' + cast(@enterID as varchar) + ',"item":"收藏夹","examScore":"' + cast(count(*) as varchar) + '题","pkind":3, "examID":""},' from studentQuestionMark where enterID=@enterID

		-- 添加章节练习
		if exists(select top 1 1 from questionInfo a, (select distinct knowPointID, b.examID, b.kindID from examInfo b, examRuleInfo c where b.examID=c.examID and b.courseID=@courseID) d where a.knowPointID=d.knowPointID and a.status=0 and a.chapterID>0)
		begin
			select @re = @re + '{"paperID":' + cast(@enterID as varchar) + ',"item":"章节练习","examScore":"' + cast(count(*) as varchar) + '题","pkind":4, "examID":"","list":[' from questionInfo a, (select distinct knowPointID, b.examID, b.kindID from examInfo b, examRuleInfo c where b.examID=c.examID and b.courseID=@courseID) d where a.knowPointID=d.knowPointID and a.status=0 and a.chapterID>0
			declare rc cursor for select cast(count(*) as varchar), a.chapterID from questionInfo a, (select distinct c.knowPointID, b.examID, b.kindID from examInfo b, examRuleInfo c where b.examID=c.examID and b.courseID=@courseID) d where a.knowPointID=d.knowPointID and a.status=0 and a.chapterID>0
				group by a.chapterID
			open rc
			fetch next from rc into @qty1,@kindID
			While @@fetch_status=0 
			Begin
				select @pp = lessonName from lessonInfo where courseID=@courseID and lessonID='N' + cast(@kindID as varchar)
				select @re = @re + '{"item":"' + @pp + '","qty":' + @qty1 + ',"chapterID":' + cast(@kindID as varchar) + '},'
				fetch next from rc into @qty1,@kindID
			End
			Close rc 
			Deallocate rc
			select @re = left(@re,len(@re)-1) + ']},'
		end
	end

	if @re>''
		select @re = '[' + left(@re,len(@re)-1) + ']'
	return @re
END
GO

--CREATE Date:2025-07-05
--根据给定的学员课程ID，查找其课程包含的帮助视频
ALTER FUNCTION [dbo].[getCourseHelps](@enterID int)
RETURNS varchar(4000)
AS
BEGIN
	declare @re nvarchar(max), @p int, @item nvarchar(100),@i int, @certID varchar(50), @vod varchar(500)
	select @re = '',@i=0
	declare rc cursor for select a.ID,isnull(a.title,'') title,a.vod from [dbo].[help_videoInfo] a, studentCourseList b, courseInfo c where b.ID=@enterID and b.courseID=c.courseID and a.certID=c.certID and a.status=0 order by a.seq
	open rc
	fetch next from rc into @p,@item,@vod
	While @@fetch_status=0 
	Begin 
		select @re = @re + '{"ID":' + cast(@p as varchar) + ',"title":"' + @item + '","vod":"' + @vod + '"},'
		select @i=@i+1
		fetch next from rc into @p,@item,@vod
	End
	Close rc 
	Deallocate rc

	if @re>''
		select @re = '[' + left(@re,len(@re)-1) + ']'
	return @re
END
GO

-- =============================================
-- CREATE DATE: 2025-01-09
-- 获取考试信息  pkind:0 模拟/正式考试  1 错题集  2 总题库  3 收藏夹  4 章节练习
-- USE CASE: exec getStudentExamInfo
-- =============================================
ALTER PROCEDURE [dbo].[getStudentExamInfo] 
	@paperID int, @pkind int, @examID varchar(50), @username varchar(50), @kind int
AS
BEGIN
	declare @answerQty int
	declare @num int, @n int
	select @n = 0, @num=0
	--模拟/正式考试
	if @pkind = 0
	begin
		select @answerQty=count(*) from studentQuestionList where refID=@paperID and myAnswer is not null
		select *,dbo.getOnlineExamStatus(paperID) as startExamMsg, 0 as pkind, @examID as examID, 0 as lastNum, @username as username,[dbo].[getExamQuestionQty](examID) as questionQty,@answerQty as answerQty, [dbo].[getMockAllow](iif(kind=0,refID,0)) as allowMockMsg, @kind as kind1 from v_studentExamList where paperID=@paperID
	end
	--错题集
	if @pkind = 1
	begin
		select @n=count(*) from v_studentQuestionWrong where enterID=@paperID
		select @paperID as paperID, 0 as status, '' as missingItems, 0 as kind, 0 as kindID, 0 as mark, 0 as score, 1 as pkind, '' as startExamMsg, @examID as examID, 0 as lastNum, @username as username, @n as questionQty, 0 as answerQty, '' as allowMockMsg, @kind as kind1
	end
	--总题库
	if @pkind = 2
	begin
		select @num = num from studentTotalExamPlace where username=@username and examID=@examID and kind=@kind
		select @n=count(*) from questionInfo where [knowPointID] in(select [knowPointID] from examRuleInfo where examID=@examID) and status=0 and kindID=@kind
		--防止最大题目超出所有题目数量
		select @num=iif(@num>=@n-1,@n-1,@num)
		select @paperID as paperID, 0 as status, '' as missingItems, 0 as kind, 0 as kindID, 0 as mark, 0 as score, 2 as pkind, '' as startExamMsg, @examID as examID, isnull(@num,0) as lastNum, @username as username, @n as questionQty, 0 as answerQty, '' as allowMockMsg, @kind as kind1
	end
	--收藏夹
	if @pkind = 3
	begin
		select @num = num from studentTotalExamPlace where examID=@paperID and kind=4
		select @n=count(*) from [dbo].[studentQuestionMark] where enterID=@paperID
		select @paperID as paperID, 0 as status, '' as missingItems, 0 as kind, 0 as kindID, 0 as mark, 0 as score, 3 as pkind, '' as startExamMsg, @examID as examID, isnull(@num,0) as lastNum, @username as username, @n as questionQty, 0 as answerQty, '' as allowMockMsg, @kind as kind1
	end
	--章节练习
	if @pkind = 4
	begin
		declare @courseID varchar(50)
		select @courseID=a.courseID from studentCourseList a, courseInfo b where a.courseID=b.courseID and a.ID=@paperID
		select @n=count(*) from questionInfo a, (select distinct knowPointID, b.examID, b.kindID from examInfo b, examRuleInfo c where b.examID=c.examID and b.courseID=@courseID) d where a.knowPointID=d.knowPointID and a.status=0 and a.chapterID=@kind
		select @paperID as paperID, 0 as status, '' as missingItems, 0 as kind, 0 as kindID, 0 as mark, 0 as score, 4 as pkind, '' as startExamMsg, @examID as examID, 0 as lastNum, @username as username, @n as questionQty, 0 as answerQty, '' as allowMockMsg, @kind as kind1
	end
END
GO

-- CREATE DATE: 2020-05-13
-- 获取指定kind的字典列表
-- USE CASE: select * from dbo.[getDictionaryList]('feedback')
ALTER FUNCTION [dbo].[getDictionaryList]
(	
	@kind varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT top 100 percent ID,item from dictionaryDoc where kind=@kind
)
GO

--CREATE Date:2020-05-16
--返回学员新消息数量
CREATE FUNCTION [dbo].[getStudentNewMessageCount](@username varchar(50))
RETURNS int
AS
BEGIN
	declare @re int
	select @re = 0
	select @re = count(*) from studentMessageInfo where username=@username and status=0
	return @re
END

--CREATE Date:2020-05-18
--返回学员未完成课程数量
CREATE FUNCTION [dbo].[getStudentCurrCourseCount](@username varchar(50))
RETURNS int
AS
BEGIN
	declare @re int
	select @re = 0
	select @re = count(*) from studentCourseList where username=@username and status<2
	return @re
END

--CREATE Date:2020-05-18
--返回学员某个证书项目的最新证书编号
ALTER FUNCTION [dbo].[getStudentLastDiplomaByCertID](@username varchar(50),@certID varchar(50))
RETURNS varchar(50)
AS
BEGIN
	declare @re varchar(50)
	select @re = ''
	select top 1 @re = diplomaID from diplomaInfo where username=@username and certID=@certID order by ID desc
	return @re
END

-- 按指定符号分割字符串，返回分割后的元素个数
-- 方法很简单，就是看字符串中存在多少个分隔符号，然后再加一，就是要求的结果。
ALTER function [dbo].[pf_getStrArrayLength]
(
	@str varchar(5000),  --要分割的字符串
	@split varchar(10)  --分隔符号
)
returns int
as
begin
	declare @location int
	declare @start int
	declare @length int
	set @str=ltrim(rtrim(@str))
	set @location=charindex(@split,@str)
	set @length=(case when @str>'' then 1 else 0 end)
	while @location<>0
	begin
		set @start=@location+1
		set @location=charindex(@split,@str,@start)
		set @length=@length+1
	end
	return @length
end

-- 按指定符号分割字符串，返回分割后指定索引的第几个元素，象数组一样方便
ALTER function [dbo].[pf_getStrArrayOfIndex]
(
	@str varchar(5000),  --要分割的字符串
	@split varchar(10),  --分隔符号
	@index int --取第几个元素,从0开始
)
returns varchar(5000)
as
begin
	declare @location int
	declare @start int
	declare @next int
	declare @seed int
	set @index = @index + 1
	set @str=ltrim(rtrim(@str))
	set @start=1
	set @next=1
	set @seed=len(@split)

	--如果第一个字符就是分隔符，则将其删除
	if left(@str,1)=@split
		set @str = right(@str,len(@str)-1)

	set @location=charindex(@split,@str)
	while @location<>0 and @index>@next
	begin
		set @start=@location+@seed
		set @location=charindex(@split,@str,@start)
		set @next=@next+1
	end
	if @location =0 
		select @location =len(@str)+1 

	--这儿存在两种情况：1、字符串不存在分隔符号 2、字符串中存在分隔符号，跳出while循环后，@location为0，那默认为字符串后边有一个分隔符号。
	return substring(@str,@start,@location-@start)
end


-- CREATE DATE: 2014-07-27
-- Description:	根据用户名查询是否有指定的权限，如果返回0表示没有该权限，大于0表示有权限
-- Use case: select dbo.userHasPermission('desk1','store|formula')
-- UPDATE: 2017-05-28 @permissionID支持多个权限组成的字符串（用|分隔）。
-- =============================================
ALTER FUNCTION [dbo].[userHasPermission] 
(
	@userID varchar(50), @permissionID varchar(50)
)
RETURNS int
--WITH ENCRYPTION
AS
BEGIN
	DECLARE @Result int, @k1 int, @k2 int, @k3 int, @m int, @i int, @p varchar(50)
	select @m = dbo.pf_getStrArrayLength(@permissionID,'|'), @k1=0,@k2=0,@k3=0,@i=0,@p=''
	while @i < @m
	begin
		select @p = dbo.pf_getStrArrayOfIndex(@permissionID,'|',@i)
		-- 查找用户的所有角色包含的权限
		select @k1=@k1+isnull(count(*),0) from v_userRolePermissionList where username=@userID and permissionID=@p
		-- 查找用户直接分配的权限
		select @k2=@k2+isnull(count(*),0) from userPermissionList a,permissionInfo b where a.permissionID=b.permissionID and a.username=@userID and a.permissionID=@p and a.status=0
		-- 查找授权得到的权限
		select @k3=@k3+isnull(count(*),0) from grantInfo a,permissionInfo b where a.grantItem=b.permissionID and a.userID=@userID and grantItem=@p and a.status=0 and a.kind='permission'
		set @i = @i + 1
	end
	set @Result = @k1 + @k2 + @k3
	-- 如果要求权限为空，则任何人都有权限。
	if @permissionID = ''
		set @Result = 1
	RETURN @Result
END

-- CREATE DATE: 2017-09-30
-- Description:	根据用户名查询是否有指定的角色，如果返回0表示没有，大于0表示有
-- Use case: select dbo.userHasRole('desk1','store|formula')
-- UPDATE: 2017-05-28 @roleID支持多个权限组成的字符串（用|分隔）。
-- =============================================
CREATE FUNCTION [dbo].[userHasRole] 
(
	@userID varchar(50), @roleID varchar(50)
)
RETURNS int
--WITH ENCRYPTION
AS
BEGIN
	DECLARE @Result int, @k1 int, @m int, @i int, @p varchar(50)
	select @m = dbo.pf_getStrArrayLength(@roleID,'|'), @k1=0,@i=0,@p=''
	while @i < @m
	begin
		select @p = dbo.pf_getStrArrayOfIndex(@roleID,'|',@i)
		-- 查找用户的所有角色
		select @k1=@k1+isnull(count(*),0) from roleUserList where username=@userID and roleID=@p
		set @i = @i + 1
	end
	set @Result = @k1
	RETURN @Result
END

-- CREATE DATE: 2014-10-17
-- 根据给定的用户，返回其所有权限
-- USE CASE: select * from dbo.getPermissionListByUser('admin.')
ALTER FUNCTION [dbo].[getPermissionListByUser]
(	
	@userName varchar(50)
)
RETURNS
@Table_Var TABLE 
(
	permissionID varchar(50),permissionName varchar(50),description varchar(50)
)
AS
BEGIN
	insert into @Table_Var
		-- 直接分配给用户的权限
		select a.permissionID,b.permissionName,isnull(b.description,'') from userPermissionList a, permissionInfo b where a.permissionID=b.permissionID and a.userName=@userName and a.host=b.host and a.status=0
		-- 由角色分配给用户的权限
		union
		select a.permissionID,b.permissionName,isnull(b.description,'') from rolePermissionList a, permissionInfo b, roleUserList c where a.permissionID=b.permissionID and a.host=b.host and a.roleID=c.roleID and a.host=c.host and c.userName=@userName and a.status=0
		-- 他人授权给用户的权限
		union
		select a.grantItem,b.permissionName,isnull(b.description,'') from grantInfo a, permissionInfo b where a.grantItem=b.permissionID and a.grantMan=@userName and a.host=b.host and a.status=0
	RETURN
END

GO

-- CREATE DATE: 2014-10-17
-- 根据给定的用户和课程，返回其所欠缺的材料
-- mark:0 认证项目  1 培训项目
-- step:检查阶段 0 选课前  1 考试前  2 发证书前
-- USE CASE: select * from dbo.getStudentMaterialsOmit('admin.')
ALTER FUNCTION [dbo].[getStudentMaterialsOmit]
(	
	@username varchar(50),@certID varchar(50),@mark int,@step int
)
RETURNS
@Table_Var TABLE 
(
	status int, msg nvarchar(500)
)
AS
BEGIN
	declare @status int, @msg nvarchar(500), @item nvarchar(500),@host varchar(50),@dept1 int,@dept2 int,@education int,@phone varchar(50),@unit varchar(100),@dept varchar(50),@address varchar(100),@job varchar(50),@mobile varchar(50)
	select @status=0, @msg='',@host=host,@dept1=dept1,@dept2=dept2,@education=education,@mobile=mobile,@phone=phone,@address=address,@unit=unit,@dept=dept,@job=job from studentInfo where username=@username
	if exists(select kindID from certNeedMaterial where certID=@certID and mark=@mark and step=@step and kindID not in(select kindID from studentMaterials where username=@username))
	begin
		declare rc cursor for select b.item from certNeedMaterial a, dictionaryDoc b where a.kindID=b.ID and b.kind='material' and certID=@certID and mark=@mark and step=@step and kindID not in(select kindID from studentMaterials where username=@username)
		open rc
		fetch next from rc into @item
		While @@fetch_status=0 
		Begin 
			select @status = @status + 1, @msg = @msg + @item + ', '
			fetch next from rc into @item
		End
		Close rc 
		Deallocate rc
	end
	if @host='spc' and @dept1 in(2,3,4,6)
	begin
		if @dept2 is null or @dept2 = 0
			select @status = @status + 1, @msg = @msg + '二级部门(加油站), '
	end
	if @host='znxf'
	begin
		if @unit is null or @unit = ''
			select @status = @status + 1, @msg = @msg + '单位名称, '
		--if @dept is null or @dept = ''
		--	select @status = @status + 1, @msg = @msg + '部门, '
	end
	if @job is null or @job = ''
		select @status = @status + 1, @msg = @msg + '岗位, '

	if @msg > ''
		set @msg = '请先提交资料：' + left(@msg,len(@msg)-1)
	insert into @Table_Var(status,msg) values(@status,@msg)
	RETURN
END
GO

-- CREATE DATE: 2015-04-06
-- 根据给定的用户，返回其没有的权限
-- USE CASE: select * from dbo.getWantPermissionListByUser('admin.')
CREATE FUNCTION [dbo].[getWantPermissionListByUser]
(	
	@userName varchar(50)
)
RETURNS
@Table_Var TABLE 
(
	permissionID varchar(50),permissionName varchar(50),description varchar(50)
)
AS
BEGIN
	declare @host varchar(50)
	select @host = host from userInfo where username=@userName
	-- 先列出所有权限
	--1.普通权限
	insert into @Table_Var
		select permissionID,permissionName,isnull(description,'') from permissionInfo where host=@host and status=0
	-- 删除已分配给用户的权限
		update @Table_Var set permissionID='' from @Table_Var a, (select permissionID from dbo.getPermissionListByUser(@userName)) b where a.permissionID=b.permissionID
		delete from @Table_Var where permissionID=''

	RETURN
END

GO

-- 根据父节点ID获取部门tree数据
-- select dbo.getDeptJson(8)
ALTER FUNCTION dbo.getDeptJson(@ID int)
returns varchar(8000)
as
begin
	declare @result varchar(8000)
	declare @tab table(id int, host int default(0), hostChildren int default(0))
	;with ChildrenCTE(ID)
	AS
	(
		select deptID from deptInfo where pID=@ID and dept_status<9
		union all
		select deptID from deptInfo inner join ChildrenCTE on ChildrenCTE.ID=deptInfo.pID and deptInfo.dept_status<9
	)
	insert into @tab(id) select @ID as ID union select ID from ChildrenCTE

	select @result = '[' + stuff((
		select
			',{id:' + cast(deptID as varchar(50))
			+ ',text:"' + deptName + (case when kindID=1 then ' *' else '' end) + '"'
			+ ',pID:"' + cast(pID as varchar(50)) + '"'
			+ ',kindID:"' + cast(kindID as varchar(50)) + '"'
			+ '}'
		from deptInfo t1, @tab t2 where t1.deptID=t2.id order by t1.pID,t1.kindID,t2.ID
		for xml path(''), type
	).value('.','varchar(max)'),1,1,'') + ']'

	return @result
end

-- 根据父节点ID获取部门tree数据
-- select * from dbo.getDeptTreeByPID(8)
ALTER FUNCTION [dbo].[getDeptTreeByPID](@ID int)
RETURNS
@Table_Var TABLE 
(
	id int, [text] varchar(500), pID int, kindID int, regDate varchar(20)
)
AS
begin
	declare @result varchar(max)
	declare @tab table(id int, host int default(0), hostChildren int default(0))
	;with ChildrenCTE(ID)
	AS
	(
		select deptID from deptInfo where pID=@ID and dept_status<9
		union all
		select deptID from deptInfo inner join ChildrenCTE on ChildrenCTE.ID=deptInfo.pID and deptInfo.dept_status<9
	)
	insert into @tab(id) select @ID as ID union select ID from ChildrenCTE

	insert into @Table_Var select t1.deptID,t1.deptName + (case when t1.kindID=1 then ' *' else '' end) + '(' + convert(varchar(10),regDate,23) + ')',t1.pID,t1.kindID,convert(varchar(10),regDate,23) from deptInfo t1, @tab t2 where t1.deptID=t2.id order by t1.pID,t1.kindID,t2.ID

	return 
end


--CREATE Date:2020-06-15
--根据给定部门名称，返回部门代码
ALTER FUNCTION [dbo].[getDeptIDbyName](@deptname nvarchar(50), @host varchar(50))
RETURNS varchar(50)
AS
BEGIN
	declare @re varchar(50)
	select @re = ''
	select @re = deptID from deptInfo where deptname=@deptname and host=@host
	return @re
END

--CREATE Date:2020-06-20
--根据给定语句，确定where条件的拼接字符串（以and方式）
CREATE FUNCTION [dbo].[getWhereStatement](@where nvarchar(2000), @item nvarchar(1000))
RETURNS varchar(2000)
AS
BEGIN
	if @where = ''
		select @where = ' where ' + @item
	else
		select @where = @where + ' and ' + @item
	return @where
END

--CREATE Date:2020-06-20
--根据给定语句，确定group条件的拼接字符串（以,方式）
CREATE FUNCTION [dbo].[getGroupStatement](@group nvarchar(2000), @item nvarchar(1000))
RETURNS varchar(2000)
AS
BEGIN
	if @group = ''
		select @group = ' group by ' + @item
	else
		select @group = @group + ',' + @item
	return @group
END

--CREATE Date:2020-06-20
--根据给定语句，确定order by条件的拼接字符串（以,方式）
CREATE FUNCTION [dbo].[getOrderStatement](@order nvarchar(2000), @item nvarchar(1000))
RETURNS varchar(2000)
AS
BEGIN
	if @order = ''
		select @order = ' order by ' + @item
	else
		select @order = @order + ',' + @item
	return @order
END

--CREATE Date:2020-07-16
--根据给定学员的课程，确定其通过条件
ALTER FUNCTION [dbo].[getPassCondition](@ID int)
RETURNS varchar(100)
AS
BEGIN
	declare @re varchar(100),@refID int,@type int,@c varchar(50)
	select @refID=refID,@c=b.completionPass from studentCourseList a, courseInfo b where a.ID=@ID and a.courseID=b.courseID
	if @refID>0
	begin
		select @type=type from v_studentCertList where ID=@refID
		select @c=scorePass from studentExamList where refID=@ID
		if @type=0
			select @re='线下考试合格'
		else
			select @re='考试成绩达' + @c + '分'
	end
	else
		select @re= '完成率达' + @c + '%'

	return @re
END
GO

-- Create date: 2014-08-10
-- Last Update: 2015-04-10
-- Description:	根据给定回执类型、引用标识和用户名称查询回执数量
-- 如果@userID=''，表示查询所有接收人回执数量
-- =============================================
-- Use case:select dbo.getReturnLog('task','2','desk1')
CREATE FUNCTION [dbo].[getReturnLog] 
(
	@kindID varchar(50),@refID varchar(50),@userID varchar(50)
)
RETURNS int
AS
BEGIN
	DECLARE @Result int
	if @userID>''
		select @Result=count(*) from returnReceiptList where kindID=@kindID and refID=@refID and userName=@userID
	else
		select @Result=count(*) from returnReceiptList where kindID=@kindID and refID=@refID
	RETURN isnull(@Result,0)
END

-- Create date: 2020-10-30
-- Description:	根据给定类型、引用标识, 查询已阅读人数
-- =============================================
-- Use case:select dbo.getReaderCount('project',3)
CREATE FUNCTION [dbo].[getReaderCount] 
(
	@kindID varchar(50),@refID varchar(50)
)
RETURNS int
AS
BEGIN
	DECLARE @Result int
	select @Result=count(*) from returnReceiptList where kindID=@kindID and refID=@refID
	RETURN isnull(@Result,0)
END

-- Create date: 2020-11-08
-- Description:	根据给定招生通知编号, 查询已报名及已确认人数
-- =============================================
-- Use case:select dbo.getProjectCount('p-20-001')
ALTER FUNCTION [dbo].[getProjectCount] 
(
	@projectID varchar(50),@deptID int
)
RETURNS varchar(50)
AS
BEGIN
	DECLARE @Result varchar(50)
	if @deptID>0
		select @Result=cast(sum(case when checked=1 then 1 else 0 end) as varchar(50)) + '/' + cast(sum(case when checked=2 then 1 else 0 end) as varchar(50)) + '/' + cast(sum(case when 1=1 then 1 else 0 end) as varchar(50)) from v_studentCourseList where projectID=@projectID and dept1=@deptID
	else
		select @Result=cast(sum(case when checked=1 then 1 else 0 end) as varchar(50)) + '/' + cast(sum(case when checked=2 then 1 else 0 end) as varchar(50)) + '/' + cast(sum(case when 1=1 then 1 else 0 end) as varchar(50)) from studentCourseList where projectID=@projectID
	RETURN isnull(@Result,'0/0/0')
END

-- Create date: 2020-11-08
-- Description:	根据给定招生通知编号, 查询不合格图片通知数量
-- =============================================
-- Use case:select dbo.getProjectBadPhotoCount('p-20-001')
ALTER FUNCTION [dbo].[getProjectBadPhotoCount] 
(
	@projectID varchar(50),@deptID int
)
RETURNS varchar(50)
AS
BEGIN
	DECLARE @Result varchar(500), @sql nvarchar(4000)
	if @deptID>0
		select @Result=cast(sum((case when status0>2 then 1 else 0 end) + (case when status1>2 then 1 else 0 end) + (case when status2>2 then 1 else 0 end) + (case when status3>2 then 1 else 0 end) + (case when status4>2 then 1 else 0 end)) as varchar(50)) + '/' + cast(sum((case when status0>1 then 1 else 0 end) + (case when status1>1 then 1 else 0 end) + (case when status2>1 then 1 else 0 end) + (case when status3>1 then 1 else 0 end) + (case when status4>1 then 1 else 0 end)) as varchar(50)) + '/' + cast(sum((case when status0>0 then 1 else 0 end) + (case when status1>0 then 1 else 0 end) + (case when status2>0 then 1 else 0 end) + (case when status3>0 then 1 else 0 end) + (case when status4>0 then 1 else 0 end)) as varchar(50)) from v_studentCourseList where projectID=@projectID and dept1=@deptID
	else
		select @Result=cast(sum((case when status0>2 then 1 else 0 end) + (case when status1>2 then 1 else 0 end) + (case when status2>2 then 1 else 0 end) + (case when status3>2 then 1 else 0 end) + (case when status4>2 then 1 else 0 end)) as varchar(50)) + '/' + cast(sum((case when status0>1 then 1 else 0 end) + (case when status1>1 then 1 else 0 end) + (case when status2>1 then 1 else 0 end) + (case when status3>1 then 1 else 0 end) + (case when status4>1 then 1 else 0 end)) as varchar(50)) + '/' + cast(sum((case when status0>0 then 1 else 0 end) + (case when status1>0 then 1 else 0 end) + (case when status2>0 then 1 else 0 end) + (case when status3>0 then 1 else 0 end) + (case when status4>0 then 1 else 0 end)) as varchar(50)) from v_studentCourseList where projectID=@projectID
	RETURN isnull(@Result,'0/0/0')
END
GO

-- Create date: 2020-11-08
-- Description:	根据给定招生通知编号, 查询已提交人数
-- =============================================
-- Use case:select dbo.getProjectSubmitCount('p-20-001')
CREATE FUNCTION [dbo].[getProjectSubmitCount] 
(
	@projectID varchar(50),@deptID int
)
RETURNS varchar(50)
AS
BEGIN
	DECLARE @Result varchar(50)
	if @deptID>0
		select @Result=cast(sum(case when submited=1 then 1 else 0 end) as varchar(50)) + '/' + cast(sum(case when submited=2 then 1 else 0 end) as varchar(50)) + '/' + cast(sum(case when checked=1 then 1 else 0 end) as varchar(50)) from v_studentCourseList where projectID=@projectID and dept1=@deptID
	else
		select @Result=cast(sum(case when submited=1 then 1 else 0 end) as varchar(50)) + '/' + cast(sum(case when submited=2 then 1 else 0 end) as varchar(50)) + '/' + cast(sum(case when checked=1 then 1 else 0 end) as varchar(50)) from v_studentCourseList where projectID=@projectID
	RETURN isnull(@Result,'0/0/0')
END
GO

--CREATE Date:2020-11-13
--根据给定参数，返回附件路径
CREATE FUNCTION [dbo].[getMaterailFile](@refID varchar(50), @kind varchar(50))
RETURNS varchar(200)
AS
BEGIN
	declare @re varchar(200)
	select @re = ''
	select @re = filename from materialInfo where refID=@refID and kind=@kind
	return @re
END
GO

-- 按指定符号分割字符串，判断给定的字符是否在里面，如果数组为空或发现目标字符串，返回1，否则0
CREATE function [dbo].[pf_inStrArray]
(
	@str varchar(5000),  --要分割的字符串
	@split varchar(10),  --分隔符号
	@f varchar(500) --要查找的字符串
)
returns int
as
begin
	declare @re int
	select @re=0, @str=@split + ltrim(rtrim(@str)) + @split, @f=@split + ltrim(rtrim(@f)) + @split
	if len(@str)>0
		select @re = charindex(@f,@str)
	else
		select @re = 1
	return (case when @re>0 then 1 else 0 end)
end

-- 判断指定学员是否为某招生批次里的人，是返回1，否则0
CREATE function [dbo].[isStudentInProject]
(
	@stu varchar(50),  --学员身份证
	@projectID varchar(50) --要查找的批次号
)
returns int
as
begin
	declare @re int
	select @re=0
	if exists(select 1 from studentCourseList where username=@stu and projectID=@projectID)
		select @re = 1
	return @re
end
GO

-- 返回指定课程的费用
-- kind: host
-- key: 
ALTER function [dbo].[getCoursePrice]
(
	@courseID varchar(50),
	@kind varchar(50),
	@key varchar(50)
)
returns int
as
begin
	declare @re int
	select @re = (case when b.price >0 then b.price else a.price end) from courseInfo a left outer join coursePrice b on a.courseID=b.courseID and b.kind=@kind and b.item=@key where a.courseID=@courseID
	return isnull(@re,0)
end
GO

-- 返回指定批次的费用
-- 如果有sales，则取coursePrice中规定的价格 
ALTER function [dbo].[getProjectPrice]
(
	@projectID varchar(50),
	@sales varchar(50)
)
returns int
as
begin
	declare @re int
	if @sales>''
		select @re=[dbo].[getCoursePrice](courseID,'sales',@sales) from projectInfo where projectID=@projectID
	else
		select @re=price from projectInfo where projectID=@projectID
	return isnull(@re,0)
end
GO

-- 返回指定单位的课程
ALTER function [dbo].[getHostCourseList]
(
	@host varchar(50)
)
RETURNS @tab TABLE (courseID varchar(50),courseName varchar(100))
as
begin
	declare @kind int
	select @kind=kindID from hostInfo where hostNo=@host
	if @kind = 0
		insert into @tab(courseID,courseName) select courseID,shortName from v_courseInfo where status=0 and type=0 order by shortName
	else
		insert into @tab(courseID,courseName) select b.courseID,b.shortName from hostCourseList a, v_courseInfo b where a.courseID=b.certID and a.host=@host order by shortName
	
	RETURN
end
GO

-- 返回指定教师可选的课程
ALTER function [dbo].[getTeacherCourseList]
(
	@teacherID varchar(50)
)
RETURNS @tab TABLE (certID varchar(50),certName varchar(100))
as
begin
	declare @kind int,@host varchar(50)
	select @host=isnull(host,'') from teacherInfo where teacherID=@teacherID
	select @kind=isnull(kindID,0) from hostInfo where hostNo=@host
	if isnull(@kind,0) = 0
		insert into @tab(certID,certName) select certID,shortName from certificateInfo where status=0 and type=0 and certID not in(select courseID from courseTeacherList where teacherID=@teacherID) order by shortName
	else
		insert into @tab(certID,certName) select b.certID,b.shortName from hostCourseList a, certificateInfo b where a.courseID=b.certID and a.host=@host and b.certID not in(select courseID from courseTeacherList where teacherID=@teacherID) order by shortName
	
	RETURN
end
GO

-- CREATE DATE: 2020-05-08
-- 获取学员可选招生项目（去除已选项目）
-- USE CASE: select * from dbo.[getStudentProjectRestList]('120107196604032113')
ALTER FUNCTION [dbo].[getStudentProjectRestList]
(	
	@username varchar(50)
)
RETURNS @tab TABLE (projectID varchar(50),projectName varchar(100))
AS
BEGIN
	declare @kindID int,@host varchar(50),@deptID int
	select @kindID=kindID, @host=host, @deptID=isnull(dept1,0) from studentInfo where username=@username

	if @kindID=0	--系统内员工
	begin
		INSERT INTO @tab
		SELECT projectID,projectName FROM
		(
			SELECT projectID,projectName,a.certID from v_certificateInfo a, projectInfo b where a.certID=b.certID and b.host=@host and b.status=1 and (dbo.pf_inStrArray(b.dept,',',@deptID)=1 or @deptID=0) 	
			--已开课外部认证项目
		) x where certID not in (select certID from v_studentCertList where username=@username and status<2 union select certID from diplomaInfo where username=@username and status=0 and datediff(d,getDate(),endDate)>180) 
		--有该项目未学完的报名或有该项目认证90天内未到期的将禁止报名
	end
	else	--系统外员工，可选所有本公司外部有效项目
	begin
		INSERT INTO @tab
		SELECT projectID,projectName FROM
		(
			SELECT projectID,projectName,a.certID from v_certificateInfo a, projectInfo b where a.certID=b.certID and b.host=@host and b.status=1 and @deptID>0 	
			--已开课外部认证项目
		) x where certID not in (select certID from v_studentCertList where username=@username and status<2 union select certID from diplomaInfo where username=@username and status=0 and datediff(d,getDate(),endDate)>180) 
		--有该项目未学完的报名或有该项目认证90天内未到期的将禁止报名
	end

	RETURN
END
GO

-- CREATE DATE: 2020-05-08
-- 获取学员可选招生项目（去除已选项目）
-- USE CASE: select * from dbo.[getClassListByProject]('P20-001')
ALTER FUNCTION [dbo].[getClassListByProject]
(	
	@projectID varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT ID as batchID,classID,className,status,classNameMemo,classIDName,pre from v_classInfo where dbo.pf_inStrArray(projectID,',',@projectID)=1
)
GO

-- CREATE DATE: 2020-05-08
-- 获取学员参考部门\电话
-- USE CASE: select * from dbo.[getDeptRefrence]('120107196604032113')
ALTER FUNCTION [dbo].[getDeptRefrence]
(	
	@username varchar(50)
)
RETURNS @tab TABLE (companyID int,dept1 int, dept2 int, mobile varchar(100),education varchar(50),job varchar(50),memo varchar(50))
AS
BEGIN
	declare @dept1 int, @dept2 int, @companyID int, @mobile varchar(100), @job varchar(100), @education varchar(100),@memo varchar(50)

	select top 1 @dept2=dept2,@dept1=dept1,@mobile=isnull(mobile,''),@education=isnull(edu,0),@job=isnull(job,''),@memo=isnull(memo,'') from ref_student_spc where username=@username and DATEDIFF(d,regDate,getDate())<31 order by classID desc
	--select @dept1=pID from deptInfo where deptID=@dept2
	select @companyID=pID from deptInfo where deptID=@dept1
	if @companyID is null
	begin
		--select @dept1=@dept2,@dept2=null
		select @companyID=pID from deptInfo where deptID=@dept1
	end
	
	if @companyID>0
		insert into @tab(companyID,dept1,dept2,mobile,education,job,memo) values(@companyID,@dept1,@dept2,@mobile,@education,@job,@memo)
	RETURN
END
GO

-- CREATE DATE: 2020-05-08
-- 根据预报名情况，判断所选课程是否有误。只在C1,C16,C17三者间校验。
-- USE CASE: select dbo.[getClassRefrence]('120107196604032113','C21053')
CREATE FUNCTION [dbo].[getClassRefrence]
(	
	@username varchar(50),@classID varchar(50)
)
RETURNS varchar(50)
AS
BEGIN
	declare @re varchar(50),@certID varchar(50),@certID1 varchar(50),@className varchar(50)
	select @re = '',@certID=certID from classInfo where classID=@classID

	if @certID='C1' or @certID='C16' or @certID='C17'
	begin
		select @className=b.className,@certID1=b.certID from ref_student_spc a, classInfo b where a.classID=b.id and a.username=@username and DATEDIFF(d,a.regDate,getDate())<31 and b.certID in('C1','C16','C17')
		if @certID <> @certID1
			select @re = @className
	end

	RETURN isnull(@re,'')
END
GO

-- CREATE DATE: 2020-05-08
-- 根据预报名情况，判断所选课程是否有误。只在C1,C16,C17三者间校验。
-- USE CASE: select * from dbo.[getProjectRefrence]('P21053')
CREATE FUNCTION [dbo].[getProjectRefrence]
(	
	@projectID varchar(50)
)
RETURNS @tab TABLE (username varchar(50),name varchar(50),courseName1 varchar(50),courseName2 varchar(50))
AS
BEGIN
	declare @re varchar(50),@host varchar(50),@regDate varchar(50),@dept varchar(50)
	select @re = '',@host=host,@regDate=regDate,@dept=dept from v_projectInfo where projectID=@projectID

	insert into @tab
	select username,name, min(courseName) as courseName1, max(courseName) as courseName2 from v_studentCourseList where checked<2 and status<2 and projectID in(
	select projectID from v_projectInfo where host=@host and dept=@dept and certID in('C1','C16','C17') and datediff(d,regDate,@regDate) between -5 and 5)
	group by username,name having count(*)>1

	RETURN
END
GO

-- CREATE DATE: 2020-05-08
-- 获取给定项目给定学员参考表中的序号
-- USE CASE: select * from dbo.[getDeptRefrenceNo]('120107196604032113','P-21-003')
CREATE FUNCTION [dbo].[getDeptRefrenceNo]
(	
	@username varchar(50),@projectID varchar(50)
)
RETURNS @tab TABLE (ID int)
AS
BEGIN
	declare @ID int
	select @ID=0
	select @ID=ID from ref_student_spc where username=@username and projectID=@projectID
	insert into @tab values(@ID)	
	RETURN
END
GO

-- CREATE DATE: 2020-05-08
-- 获取给定报名表对应的学员须知
-- USE CASE: select * from dbo.[getNeed2knowByEnterID](1)
ALTER FUNCTION [dbo].[getNeed2knowByEnterID]
(	
	@enterID int
)
RETURNS @tab TABLE (username varchar(50),name varchar(50),courseName varchar(50),SNo varchar(50),host varchar(50),missingItems varchar(500),timetable varchar(500),adviserName varchar(50),phone varchar(50),classroom varchar(50),certID varchar(50))
AS
BEGIN
	insert into @tab select username,name,a.courseName,SNo,a.host,[dbo].[getMissingItems](@enterID),isnull(b.timetable,''),isnull(b.adviserName,''),isnull(b.phone,''),isnull(b.classroom,''),a.certID from v_studentCourseList a left outer join v_classInfo b on a.classID=b.classID where a.ID=@enterID	
	RETURN
END
GO

--CREATE Date:2020-11-13
--根据给定参数，返回报名表缺失的项目
ALTER FUNCTION [dbo].[getMissingItems](@enterID int)
RETURNS varchar(500)
AS
BEGIN
	declare @ID int,@missingItems varchar(500),@host varchar(50),@certID varchar(50),@username varchar(50),@education int,@phone varchar(50),@unit varchar(100),@dept varchar(50),@address varchar(100),@reexamine int,@currDiplomaID varchar(50),@courseName varchar(50),@job varchar(50),@mobile varchar(50),@projectID varchar(50)
	select @missingItems='',@host=host,@username=username,@certID=certID,@reexamine=reexamine,@currDiplomaID=currDiplomaID,@courseName=courseName,@projectID=projectID from v_studentCourseList where ID=@enterID
	select @education=education,@mobile=mobile,@phone=phone,@address=address,@unit=unit,@dept=dept,@job=job from studentInfo where username=@username
	
	if @projectID > ''
	begin
		if @certID = 'C20' or @certID = 'C20A' or @certID = 'C21'
		begin
			--消防员需要提供额外证明
			declare @kind6 int, @kind12 int
			--select @kind6=kind6,@kind12=kind12 from firemanEnterInfo where enterID=@enterID
			--select @missingItems = @missingItems + (case when photo_filename='' then ',照片' else '' end)
			--	 + (case when IDa_filename='' then ',身份证正面' else '' end)
			--	 + (case when IDb_filename='' then ',身份证反面' else '' end)
				 --+ (case when edu_filename='' then ',学历证明' else '' end)
				 --+ (case when CHESICC_filename='' and @kind12<4 then ',学信网截图' else '' end)	--大专以上需要学信网证明
				 --+ (case when employe_filename='' then ',工作证明' else '' end)
				 --+ (case when job_filename='' and @kind6=1 then ',职业资格证书' else '' end)
			--	from v_studentInfo where username=@username

		end
		else
		begin
			if @education=0
				select @missingItems = @missingItems + ',学历'
			--if @phone='' or @phone is null
			--	select @missingItems = @missingItems + ',单位电话'
			--if @address='' or @address is null
			--	select @missingItems = @missingItems + ',单位地址'
			if @job='' or @job is null
				select @missingItems = @missingItems + ',工作岗位'
			--if @host='znxf' and (@dept='' or @dept is null)
			--	select @missingItems = @missingItems + ',工作部门'
			--复审证书
			--if @reexamine=1 and (@currDiplomaID='' or @currDiplomaID is null)	
				--select @missingItems = @missingItems + ', ' + @courseName + '证书编号'
		end

		if @mobile='' or @mobile is null
			select @missingItems = @missingItems + ',手机号码'
		--if @host='znxf' and (@unit='' or @unit is null)
			--select @missingItems = @missingItems + ',单位名称'

		if @missingItems > ''
			select @missingItems = right(@missingItems,len(@missingItems)-1)
	end

	if @projectID = '' and @certID in('C3','C4','C5','C6','C7','C8')
	begin
		if @job='' or @job is null
			select @missingItems = @missingItems + ',工作岗位'
	end

	return isnull(@missingItems,'')
END
GO

--CREATE Date:2020-11-13
--根据给定参数，返回报名表缺失的项目
ALTER FUNCTION [dbo].[getMissingItemsByCertID](@ID int)
RETURNS varchar(500)
AS
BEGIN
	declare @missingItems varchar(500)
	select @missingItems=[dbo].[getMissingItems](ID) from studentCourseList where ID=@ID
	return isnull(@missingItems,'')
END
GO

--CREATE Date:2020-11-13
--根据给定身份证，获取其缺失的复训报名表中的证书编号
ALTER FUNCTION [dbo].[getReexamineDiploma](@username varchar(50))
RETURNS @tab TABLE (enterID int,item varchar(100))
AS
BEGIN
	--未结束的课程、复训、没有填写证书编号
	insert into @tab
	select ID,'参加复审的'+courseName+'证书编号' from v_studentCourseList where username=@username and reexamine=1 and currDiplomaID='' and status<2
	return
END
GO

--CREATE Date:2021-07-18
--根据给班级，获取退费名单
CREATE FUNCTION [dbo].[getRefundListByClass](@classID varchar(50),@price int)
RETURNS TABLE 
AS
RETURN 
(
	select row_number() over(order by dept2Name) as ID,(case when dept2Name>'' then dept2Name else dept1Name end) as deptName,username,name,@price as price from v_studentCourseList where classID=@classID
)
GO

--CREATE Date:2020-11-13
--根据给班级，获取名单
--@row: 左右分两栏时每页的行数，@top 表头行数 第一页有表头，其他页没有。@row=0 不分栏
ALTER FUNCTION [dbo].[getStudentListInClass](@classID varchar(50),@row int,@top int)
RETURNS @tab TABLE (ID int,SNo varchar(50),name varchar(50),ID1 varchar(50),SNo1 varchar(50),name1 varchar(50))
AS
BEGIN
	if @row=0
		insert into @tab select row_number() over(order by SNo) as ID,SNo,name,0,'','' from v_studentCourseList where classID=@classID
	else
	begin
		--分两栏数据
		declare @tab1 TABLE(ID int,SNo varchar(50),name varchar(50))
		declare @ID int,@name varchar(50),@m int,@i int,@p int,@SNo varchar(50)
		insert into @tab1 select row_number() over(order by SNo) as ID,SNo,name from v_studentCourseList where classID=@classID
		select @m=count(*),@i=0,@p=0 from @tab1
		While @p<@m 
		Begin 
			if @i<@row-@top
				select @i=@i+1
			else
			begin
				select @p=@p+@row-@top,@top=0,@i=1
			end
			select @p = @p + 1
			insert into @tab(ID,SNo,name,ID1,SNo1,name1) select a.ID,a.SNo,a.name,@p+@row-@top,'','' from @tab1 a where a.ID=@p
		End
		update @tab set ID1=isnull(b.ID,''),SNo1=isnull(b.SNo,''),name1=isnull(b.name,'') from @tab a left outer join @tab1 b on a.ID1=b.ID
		update @tab set ID1='' where ID1=0
	end
	return
END
GO

--CREATE Date:2020-11-13
--根据给日期，返回指定格式
--@mark: 0 年月日
CREATE FUNCTION [dbo].[fn_formatDate](@date varchar(20),@mark int)
RETURNS varchar(50)
AS
BEGIN
	declare @re varchar(50)
	if @mark=0
		select @re=left(@date,4) + '年' + substring(@date,6,2) + '月' + right(@date,2) + '日'
	return isnull(@re,'')
END
GO

--CREATE Date:2021-07-10
--根据给定参数，返回其拥有的班级列表
--公司，部门，项目
ALTER FUNCTION [dbo].[getClassListByDept](
	@host varchar(50), @deptID varchar(50), @certID varchar(50)
)
RETURNS @tab TABLE (classID varchar(50),className varchar(50),statusName varchar(50),qty int)
AS
BEGIN
	declare @sql nvarchar(2000), @s varchar(500)
	if @certID > ''
	begin
		if @deptID > '0'	--有部门的，按照部门查询
			insert into @tab select classID,className,statusName,qty from v_classInfo where certID=@certID and ID in(select classID from ref_student_spc where dept1=@deptID  group by classID)
		else	-- 没有部门，按照公司查询
			insert into @tab select classID,className,statusName,qty from v_classInfo where certID=@certID and ID in(select a.classID from ref_student_spc a, deptInfo b where a.dept1=b.deptID and b.host=@host group by a.classID)
	end
	else
	begin
		if @deptID > '0'	--有部门的，按照部门查询
			insert into @tab select classID,className,statusName,qty from v_classInfo where ID in(select classID from ref_student_spc where dept1=@deptID  group by classID)
		else	-- 没有部门，按照公司查询
			insert into @tab select classID,className,statusName,qty from v_classInfo where ID in(select a.classID from ref_student_spc a, deptInfo b where a.dept1=b.deptID and b.host=@host group by a.classID)
	end
	
	return
END
GO

--CREATE Date:2021-07-10
--根据给定参数，返回其拥有的批次列表
--公司，部门，项目
ALTER FUNCTION [dbo].[getProjectListByDept](
	@host varchar(50), @deptID varchar(50), @certID varchar(50)
)
RETURNS @tab TABLE (projectID varchar(50),projectName varchar(50),status int,statusName varchar(50))
AS
BEGIN
	declare @sql nvarchar(2000), @s varchar(500)
	if @certID > ''
	begin
		if @deptID > '0'	--有部门的，按照部门查询
			insert into @tab select projectID,projectName,status,statusName from v_projectInfo where host=@host and certID=@certID and status>0 and (dept='' or [dbo].[pf_inStrArray](dept,',',@deptID)=1) and hide=0
		else	-- 没有部门，按照公司查询
			insert into @tab select projectID,projectName,status,statusName from v_projectInfo where host=@host and certID=@certID and status>0 and hide=0
	end
	else
	begin
		if @deptID > '0'	--有部门的，按照部门查询
			insert into @tab select projectID,projectName,status,statusName from v_projectInfo where host=@host and status>0 and (dept='' or [dbo].[pf_inStrArray](dept,',',@deptID)=1) and hide=0
		else	-- 没有部门，按照公司查询
			insert into @tab select projectID,projectName,status,statusName from v_projectInfo where host=@host and status>0 and hide=0
	end
	
	return
END
GO

--获取班级名单：预报名名单(mark:0)+额外名单(mark:1)，预报名表中区分是否实际报名(submited:0/1)
ALTER FUNCTION getStudentListByClass 
(	
	@classID varchar(50),@host varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	select name,username,ID,enterID,stationName,education,job,mobile,expireDate,invoice,memo,submited,submitDate,submiter,submiterName,classID,dept1,deptName,checked,checkDate,checker,checkerName,SNo,0 as mark from v_ref_student_spc where classID=@classID
	 UNION
	select name,username,cast(right(SNo,len(SNo)-CHARINDEX('-',SNo)) as int) as ID,ID as enterID,(case when host='znxf' then unit when host='spc' and kindID=1 then dept1Name else dept2Name end) as dept2Name,educationName,job,mobile,'' as expireDate,'' as invoice,'' as memo,submited,submitDate,submiter,submiterName,classID,dept1,dept1Name,checked,checkDate,checker,checkerName,SNo,1 as mark from v_studentCourseList where classID=@classID and host=@host and username not in
	(select username from ref_student_spc a, classInfo b where a.classID=b.ID and b.classID=@classID)
)
GO

--获取某个公司参加的项目列表
ALTER FUNCTION getCertListByHost
(	
	@host varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	--select d.certID,d.shortName from ref_student_spc a, deptInfo b, classInfo c, certificateInfo d where a.dept1=b.deptID and b.host=@host and a.classID=c.ID and c.certID=d.certID group by d.certID,d.shortName
	select certID,shortName from v_studentCertList where host=@host and type=0 group by certID,shortName
)
GO

--获取某个学员待考试项目列表
ALTER FUNCTION getExamListByUsername
(	
	@username varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	--在线考试
	select a.paperID,b.kindID,'在线' as kindName,a.status,a.statusName,b.certName,b.startDate,a.minutes,b.endDate,b.address,c.username,d.name from v_studentExamList a, v_passcardInfo b, studentCourseList c, studentInfo d where a.refID=b.ID and b.enterID=c.ID and c.username=d.username and b.kindID=1 and b.startDate>=convert(varchar(20),getDate(),23) and b.passNo>'' and b.username=@username

	--学校线下考试
	union
	select 0,0,'线下',0,'准备',b.certName,b.startDate,0,b.endDate,b.address,c.username,d.name from v_passcardInfo b, studentCourseList c, studentInfo d where b.enterID=c.ID and c.username=d.username and b.kindID=0 and b.startDate>=convert(varchar(20),getDate(),23) and b.passNo>'' and b.username=@username

	--第三方线下考试
	union
	select 0,0,'线下',0,'准备',b.courseName,b.examDate,0,'',b.address,c.username,d.name from v_applyInfo b, studentCourseList c, studentInfo d where b.enterID=c.ID and c.username=d.username and b.examDate>=convert(varchar(20),getDate(),23) and b.username=@username
)
GO

--判断某个线上考试的状态
ALTER FUNCTION getOnlineExamStatus
(	
	@examID int
)
RETURNS varchar(100) 
AS
BEGIN
	declare @re varchar(100)
	--在线考试
	if exists(select 1 from studentExamList where paperID=@examID and kind=1)
	begin
		select @re = ''
		--检查其是否到达开考时间
		if exists(select 1 from v_passcardInfo a, studentExamList b where a.ID=b.refID and b.paperID=@examID and a.startDate>convert(varchar(16),getDate(),20))
			select @re='考试尚未开始。'
		--检查其是否到达结束时间(未登录过）
		if @re = '' and exists(select 1 from v_passcardInfo a, studentExamList b where a.ID=b.refID and b.paperID=@examID and a.endDate<convert(varchar(16),getDate(),20) and b.status=0)
			select @re='考试已结束。'
	end
	return isnull(@re,'')
END
GO

--获取某个销售相关班级列表
CREATE FUNCTION getClassListBySaler
(	
	@fromID varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	select classID from v_studentCourseList where fromID=@fromID group by classID
)
GO

--CREATE Date:2021-07-10
--根据给定参数，返回可用教师的列表
--freePoint: 给定日期区间内空余时间百分比
ALTER FUNCTION [dbo].[getFreeTeacherList](
	@startDate varchar(50), @classID varchar(50), @mark varchar(50)
)
RETURNS @tab TABLE (teacherID varchar(50),teacherName varchar(50),freePoint int)
AS
BEGIN
	declare @days int,@endDate varchar(50),@host varchar(50), @courseID varchar(50)
	
	if @mark='A'
		select @startDate = startDate, @courseID=courseID,@host=host from generateApplyInfo where ID=@classID
	if @mark='B'
		select @startDate = (case when @startDate='' then dateStart else @startDate end), @courseID=courseID,@host=isnull(host,'') from classInfo where ID=@classID
	select @days=ceiling(count(*)/2.0) from schedule where courseID=@courseID
	select @endDate=dateadd(d,@days,@startDate)
	if @host='ding' or @host='znxf'
		select @host=''	--ding使用智能消防学校的资源

	--导入所有有资格的教师
	insert into @tab(teacherID,teacherName,freePoint) select teacherID,teacherName,@days from v_courseTeacherList a, courseInfo b where a.courseID=b.certID and a.host=@host and b.courseID=@courseID
	--计算其间已排课天数
	--update @tab set freePoint=freePoint-isnull(c.days,0) from @tab d left outer join (select teacher,count(*) as days from classSchedule a, @tab b where a.teacher=b.teacherID and a.online=0 and a.theDate between @startDate and @endDate group by a.teacher,a.theDate) c on d.teacherID=c.teacher
	--update @tab set freePoint=(case when @days>0 then freePoint*100/@days else 100 end)
	--delete from @tab where freePoint=0

	return
END
GO

-- CREATE DATE: 2020-05-08
-- 获取某个人在某个班级里的交互消息列表（学员或老师）
-- type:0 student 1 teacher
-- USE CASE: select * from dbo.[getFeedbackClassList](1)
ALTER FUNCTION [dbo].[getFeedbackClassList]
(	
	@username varchar(50), @classID varchar(50), @type int
)
RETURNS @tab TABLE (ID int,username varchar(50),title varchar(50),classID varchar(50),item varchar(4000),readerID varchar(50),readerName varchar(50),refID int,type int,regDate varchar(50),cancelAllow int)
AS
BEGIN
	insert into @tab 
		select ID,username,title,classID,item,readerID,'',refID,type,regDate,0 from v_studentFeedbackInfo where username=@username and classID=@classID	--自己的发言
		union 
		select ID,username,title,classID,item,readerID,'',refID,type,regDate,0 from v_studentFeedbackInfo where readerID=@username and classID=@classID	--发送给自己的发言

	if @type = 0	--student
		insert into @tab
			select ID,username,title,classID,item,readerID,'',refID,type,regDate,0 from v_studentFeedbackInfo where classID=@classID and type=1 and readerID=''	--老师给所有人的发言
	else	--teacher
		insert into @tab
			select ID,username,title,classID,item,readerID,'',refID,type,regDate,0 from v_studentFeedbackInfo where classID=@classID and type=0	--所有学生的发言
			union 
			select ID,username,title,classID,item,readerID,'',refID,type,regDate,0 from v_studentFeedbackInfo where username<>@username and classID=@classID and type=1	--其他老师的发言
	
	--自己的发言标记为'我'
	update @tab set title='我' where username=@username
	--针对某个学生的发言标记'@'
	update @tab set item='@' + b.name + ' ' + item from @tab a, studentInfo b where a.readerID=b.username and a.username=@username and readerID>''
	update @tab set cancelAllow=(case when username=@username and datediff(S,regDate,getDate())<300 then 1 else 0 end)

	RETURN
END
GO

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- procedure
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

-- CREATE DATE: 2020-05-05
-- 根据给定的参数，更新学员密码，并写日志
-- return:0 成功  1 用户不存在  2 用户禁用  3 邮箱错误  9 其他
-- USE CASE: exec updateStudentPassword 1,'xxxx'...
ALTER PROCEDURE [dbo].[updateStudentPassword]
	@username varchar(50),@password varchar(50),@mobile varchar(50),@host varchar(50),@ip varchar(50),@registerID varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @logMemo varchar(500),@event varchar(50),@re int
	select @logMemo = '',@event='修改密码', @re=0	--0 success

	if exists(select 1 from studentInfo where username=@username)	-- 新纪录
	begin
		if exists(select 1 from studentInfo where username=@username and mobile=@mobile)
			if exists(select 1 from studentInfo where username=@username and mobile=@mobile and user_status=0)
				update studentInfo set password=@password where username=@username
			else
			begin
				set @re =  3   --error: the email is wrong.
			end
		else
		begin
			set @re =  3   --error: the email is wrong.
		end
	end
	else
	begin
		set @re = 1   --error: the user not exist.
	end
	-- 写操作日志
	if @re = 0
		exec writeOpLog @host,@event,'student',@registerID,@username,@username
	return @re
END

-- =============================================
-- CREATE DATE: 2020-05-04
-- 记录学员登录信息
-- student:0 学员  1 用户
-- USE CASE: exec writeStudentLoginLog 'zzz','xx','xx'
-- =============================================
ALTER PROCEDURE [dbo].[writeStudentLoginLog] 
	@username varchar(50),@ip varchar(50),@host varchar(50),@student int,@memo varchar(500)
AS
BEGIN
	insert into studentLoginLog(username,ip,host,kindID,student,memo) values(@username,@ip,@host,0,@student,@memo)
END

GO

-- =============================================
-- CREATE DATE: 2020-05-04
-- 记录学员登出信息
-- USE CASE: exec writeStudentLogoutLog 'zzz'
-- =============================================
ALTER PROCEDURE [dbo].[writeStudentLogoutLog] 
	@username varchar(50),@student int
AS
BEGIN
	insert into studentLoginLog(username,kindID,student) values(@username,1,@student)
END

GO

-- CREATE DATE: 2020-05-01
-- 根据给定的参数，添加或者更新用户数据，并写日志
-- @mark:0 new user; 1 update user
-- return: 0 success; other error:1 the user already exist  2 the user not exist  3 the companyID wrong.
-- USE CASE: exec updatestudentInfo 1,'xxxx'...
ALTER PROCEDURE [dbo].[updateStudentInfo]
	@mark int,@username varchar(50),@name nvarchar(50),@password varchar(50),@kindID int,@companyID varchar(50),@dept1 varchar(50),@dept1Name nvarchar(100),@dept2 varchar(50),@dept3 varchar(50),@job varchar(50),@linker varchar(50),@job_status varchar(50),@mobile nvarchar(50),@phone nvarchar(50),@email nvarchar(50),@address nvarchar(100),@limitDate varchar(50),@education varchar(50),@unit nvarchar(100),@tax varchar(50),@dept nvarchar(100),@ethnicity nvarchar(50),@IDaddress nvarchar(100),@bureau nvarchar(50),@IDdateStart varchar(50),@IDdateEnd varchar(50),@experience nvarchar(500),@fromID varchar(50),@fromKind varchar(50),@memo nvarchar(500),@host varchar(50),@registerID varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @logMemo varchar(500),@event varchar(50),@userID int,@re int
	select @logMemo = '',@dept1Name=REPLACE(@dept1Name,' ',''), @tax= UPPER(replace(dbo.whenull(@tax,''),' ','')), @address=REPLACE(dbo.whenull(@address,''),' ',''), @re=0	--0 success
	if @limitDate = '' or @limitDate = 'null' or @limitDate= 'undefined'
		set @limitDate = null
	if @dept1 = '' or @dept1 = 'null' or @dept1= 'undefined' or @dept1= '0'
		set @dept1 = null
	if @dept2 = '' or @dept2 = 'null' or @dept2= 'undefined' or @dept2= '0'
		set @dept2 = null
	if @dept3 = '' or @dept3 = 'null' or @dept3= 'undefined' or @dept3= '0'
		set @dept3 = null
	if @password = '' or @password = 'null' or @password= 'undefined'
		select @password = item,@kindID=0 from dictionaryDoc where kind='studentPasswd'
	if @unit = '' or @unit = 'null' or @unit= 'undefined'
		set @unit = null
	if @dept = '' or @dept = 'null' or @dept= 'undefined'
		set @dept = null
	if @IDdateStart = '' or @IDdateStart = 'null' or @IDdateStart= 'undefined' or ISDATE(@IDdateStart)=0
		set @IDdateStart = null
	if @IDdateEnd = '' or @IDdateEnd = 'null' or @IDdateEnd= 'undefined' or ISDATE(@IDdateEnd)=0
		set @IDdateEnd = null
	if @fromID = '' or @fromID = 'null' or @fromID= 'undefined'
		set @fromID = null
	if @companyID>0 and not exists(select 1 from hostInfo where hostNo=@host and kindID=1)
		select @host=host,@linker=(case when @linker>'' then @linker else linker end),@address=(case when @address>'' then @address else address end),@phone=(case when @phone>'' then @phone else phone end) from deptInfo where deptID=@companyID
	if @education = '' or @education = 'null' or @education= 'undefined'
		set @education = 0
	if @ethnicity = '' or @ethnicity = 'null' or @ethnicity= 'undefined'
		set @ethnicity = '汉'
	if @fromID>''
		select @fromKind=kindID from unitInfo where saler=@fromID and unitName=@unit

	if @mark=0	-- 新纪录
	begin
		if exists(select 1 from studentInfo where username=@username)
			set @re =  1   --error: the user already exist.
		if @companyID=0
			set @re =  3   --error: the companyID wrong.
		if @re = 0
		begin
			if @tax>''
				select @unit=unitName, @address=address from unitInfo where taxNo=@tax
			else if @unit>''
				select @tax=taxNo, @address=address from unitInfo where unitName=@unit
			else if @host='shm'
				select @unit=a.unitName,@tax=a.taxNo, @address=a.address from unitInfo a, deptInfo b where b.host='shm' and b.deptID=@dept1 and a.unitName=b.deptName
			else if @host='spc' and @kindID=0
				select @unit=a.unitName,@tax=a.taxNo, @address=a.address from unitInfo a, deptInfo b where b.host='spc' and b.deptID=8 and a.unitName=b.deptName
			exec setUnitTaxConfirm @unit,@tax,@address,'',''
			insert into studentInfo(host,userName,name,password,kindID,companyID,dept1,dept2,dept3,job,job_status,mobile,phone,email,address,education,unit,tax,dept,ethnicity,IDaddress,bureau,IDdateStart,IDdateEnd,experience,memo,birthday,sex,age,linker,fromID,fromKind,registerID) 
				values(@host,upper(@username),@name,@password,@kindID,@companyID,@dept1,@dept2,@dept3,@job,@job_status,@mobile,@phone,@email,@address,@education,@unit,@tax,@dept,@ethnicity,@IDaddress,@bureau,@IDdateStart,@IDdateEnd,@experience,@memo,substring(@username,7,8),dbo.getSexfromID(@username),dbo.getAgefromID(@username),@linker,@fromID,@fromKind,@registerID)
			select @userID=userID from studentInfo where username=@username
			select @event = '新增'
			exec writeEventTrace @host,@registerID,'user',@username,0,'登记',@username
		end
	end
	else
	begin
		if not exists(select 1 from studentInfo where username=@username)
			set @re = 2   --error: the user not exist.
		else
		begin
			declare @kindID0 int,@host0 varchar(50),@companyID0 int
			select @kindID0=kindID,@host0=host,@companyID0=companyID from studentInfo where username=@username
			--更换公司后修改host
			--if(@companyID0<>@companyID)
			if(@companyID>0 and (@host='znxf' or @host='spc'))
				select @host=host from deptInfo where deptID=@companyID

			--如果有密码输入，保存新密码，否则保持原来密码.
			insert into [log_update_studentInfo] select *,@registerID,getDate() from studentInfo where username=@username
			update studentInfo set kindID=@kindID,password=(case when @password>'' then @password else password end),companyID=@companyID,host=@host,dept1=@dept1,dept2=@dept2,dept3=@dept3,job=@job,job_status=@job_status,name=@name,mobile=@mobile,phone=@phone,email=@email,address=@address,limitDate=@limitDate,education=@education,unit=@unit,tax=@tax,dept=@dept,@linker=(case when @linker>'' then @linker else linker end)
			,ethnicity=(case when @ethnicity='' then ethnicity else @ethnicity end),IDaddress=(case when @IDaddress='' then IDaddress else @IDaddress end),bureau=(case when @bureau='' then bureau else @bureau end),IDdateStart=(case when @IDdateStart is null then IDdateStart else @IDdateStart end),IDdateEnd=(case when @IDdateStart is not null then @IDdateEnd else IDdateEnd end),experience=@experience,fromID=@fromID,fromKind=@fromKind,memo=@memo where username=@username
			select @event = '修改'
			--如果由系统内变更为系统外，检查是否已经选了那些系统内课程(非第三方课程)，如果有则删除
			if @kindID=1 and @kindID0=0 and exists(select 1 from v_studentCourseList where username=@username and mark=1)
			begin
				delete from studentCourseList where ID in(select ID from v_studentCourseList where username=@username and mark=1 and type=1)
				delete from studentCertList where ID in(select ID from v_studentCertList where username=@username and mark=1 and type=1)
			end
			--如果更换了公司，则近期的报名、证书也要修改
			/*
			if @host<>@host0
			begin
				update studentCertList set host=@host where username=@username and datediff(d,regDate,getDate())<60
				update studentCourseList set host=@host where username=@username and datediff(d,regDate,getDate())<60
				update diplomaInfo set host=@host where username=@username and datediff(d,regDate,getDate())<60
			end
			*/
		end
	end

	if @re = 0
	begin
		-- 保存系统外单位信息，并检查是否有新增单位
		if @kindID=1 and len(@dept1Name)>3
		begin
			if exists(select 1 from deptInfo where deptName=@dept1Name and dept_status=0 and host=@host)
				select @dept1=deptID from deptInfo where deptName=@dept1Name and dept_status=0 and host=@host
			else
				exec @dept1 = autoAddDept @companyID,@dept1Name,@kindID,@host,@username
			update studentInfo set dept1=@dept1 where username=@username
		end
		-- 写操作日志
		exec writeOpLog @host,@event,'student',@registerID,@username,@username
	end
	return @re
END
GO

-- CREATE DATE: 2021-11-15
-- 根据给定的参数，添加新用户数据（非身份证用户），并写日志
-- return: 0 success; other error:1 the user already exist  2 the user not exist  3 the companyID wrong.
-- USE CASE: exec updatestudentInfoTai 1,'xxxx'...
ALTER PROCEDURE [dbo].[updateStudentInfoTai]
	@username varchar(50),@name nvarchar(50),@sex int,@birthday varchar(50),@kindID int,@companyID varchar(50),@dept1 varchar(50),@dept1Name nvarchar(100),@dept2 varchar(50),@dept3 varchar(50),@job varchar(50),@linker varchar(50),@job_status varchar(50),@mobile nvarchar(50),@phone nvarchar(50),@email nvarchar(50),@address nvarchar(100),@limitDate varchar(50),@education int,@unit nvarchar(100),@tax varchar(50),@dept nvarchar(100),@ethnicity nvarchar(50),@IDaddress nvarchar(100),@bureau nvarchar(50),@IDdateStart varchar(50),@IDdateEnd varchar(50),@experience nvarchar(500),@fromID varchar(50),@fromKind varchar(50),@memo nvarchar(500),@host varchar(50),@registerID varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @logMemo varchar(500),@event varchar(50),@userID int,@age int,@birthday0 varchar(50),@re int
	select @logMemo = '',@dept1Name=REPLACE(@dept1Name,' ',''), @re=0	--0 success
	if @limitDate = '' or @limitDate = 'null' or @limitDate= 'undefined'
		set @limitDate = null
	if @dept1 = '' or @dept1 = 'null' or @dept1= 'undefined' or @dept1= '0'
		set @dept1 = null
	if @dept2 = '' or @dept2 = 'null' or @dept2= 'undefined' or @dept2= '0'
		set @dept2 = null
	if @dept3 = '' or @dept3 = 'null' or @dept3= 'undefined' or @dept3= '0'
		set @dept3 = null
	if @unit = '' or @unit = 'null' or @unit= 'undefined'
		set @unit = null
	if @dept = '' or @dept = 'null' or @dept= 'undefined'
		set @dept = null
	if @IDdateStart = '' or @IDdateStart = 'null' or @IDdateStart= 'undefined' or ISDATE(@IDdateStart)=0
		set @IDdateStart = null
	if @IDdateEnd = '' or @IDdateEnd = 'null' or @IDdateEnd= 'undefined' or ISDATE(@IDdateEnd)=0
		set @IDdateEnd = null
	if @linker = '' or @linker = 'null' or @linker= 'undefined'
		set @linker = null
	if @fromID = '' or @fromID = 'null' or @fromID= 'undefined'
		set @fromID = null
	if @birthday > ''
	begin
		select @birthday0 = replace(@birthday,'-','')
		select @age = (year(getDate())*10000 + month(getDate())*100 + day(getDate()) - substring(@birthday0,1,4)*10000 - substring(@birthday0,5,2)*100 - substring(@birthday0,9,2))/10000
	end
	if @companyID>0
		select @host=host,@linker=(case when @linker>'' then @linker else linker end),@address=(case when @address>'' then @address else address end),@phone=(case when @phone>'' then @phone else phone end) from deptInfo where deptID=@companyID
	if @companyID=0
		set @re =  3   --error: the companyID wrong.

	if exists(select 1 from studentInfo where username=@username)
		update studentInfo set host=@host,name=@name,kindID=@kindID,companyID=@companyID,dept1=@dept1,dept2=@dept2,dept3=@dept3,job=@job,job_status=@job_status,mobile=@mobile,phone=@phone,email=@email,address=@address,education=@education,unit=@unit,tax=@tax,dept=@dept,ethnicity=@ethnicity,IDaddress=@IDaddress,bureau=@bureau,IDdateStart=@IDdateStart,IDdateEnd=@IDdateEnd,experience=@experience,memo=@memo,birthday=@birthday,sex=@sex,age=@age,fromID=@fromID,fromKind=@fromKind where username=@username
	else
		if @re = 0
		begin
			if @tax>''
				select @unit=unitName, @address=address from unitInfo where taxNo=@tax and checker>''
			else if @unit>''
				select @tax=taxNo, @address=address from unitInfo where unitName=@unit and checker>''
			exec setUnitTaxConfirm @unit,@tax,@address,'',''
			insert into studentInfo(host,userName,name,kindID,companyID,dept1,dept2,dept3,job,job_status,mobile,phone,email,address,education,unit,tax,dept,ethnicity,IDaddress,bureau,IDdateStart,IDdateEnd,experience,memo,birthday,sex,age,linker,fromID,fromKind,registerID) 
				values(@host,upper(@username),@name,@kindID,@companyID,@dept1,@dept2,@dept3,@job,@job_status,@mobile,@phone,@email,@address,@education,@unit,@tax,@dept,@ethnicity,@IDaddress,@bureau,@IDdateStart,@IDdateEnd,@experience,@memo,@birthday,@sex,@age,@linker,@fromID,@fromKind,@registerID)
			select @userID=userID from studentInfo where username=@username
			select @event = '新增'
			exec writeEventTrace @host,@registerID,'user',@username,0,'登记',@username
		end

	if @re = 0
	begin
		-- 保存系统外单位信息，并检查是否有新增单位
		if @kindID=1 and len(@dept1Name)>3
		begin
			if exists(select 1 from deptInfo where deptName=@dept1Name and dept_status=0 and host=@host)
				select @dept1=deptID from deptInfo where deptName=@dept1Name and dept_status=0 and host=@host
			else
				exec @dept1 = autoAddDept @companyID,@dept1Name,@kindID,@host,@username
			update studentInfo set dept1=@dept1 where username=@username
		end
		-- 写操作日志
		exec writeOpLog @host,@event,'student',@registerID,@username,@username
	end
	return @re
END

GO


-- =============================================
-- CREATE Date: 2020-05-08
-- Description:	学员选择给定的证书项目，将添加到数据库并同时添加相关的课程。
-- mark: 0 证书项目  1 培训项目（只有课程）
-- url: subdomain
-- 公共证书项目报名时，不生成课程、课件和试卷，等编班后再分配
-- Use Case:	exec addStudentCert '310....' 
-- =============================================
ALTER PROCEDURE [dbo].[addStudentCert] 
	@username varchar(50),@mark int,@certID varchar(50),@reexamine int,@currDiplomaID varchar(50),@currDiplomaDate varchar(50),@fromID varchar(50),@url varchar(500)
AS
BEGIN
	DECLARE @logMemo varchar(500),@event varchar(50),@refID int,@host varchar(50),@dept1 int,@dept2 int,@kind int,@payNow int,@title nvarchar(500),@type int,@projectID varchar(50),@ID int,@classID varchar(50),@payID int,@price int,@checked int,@checkDate varchar(20),@checker varchar(50),@SNo int,@courseID varchar(50)
	declare @re int, @msg nvarchar(50), @source nvarchar(50),@fromKind int
	if @currDiplomaDate='' or @currDiplomaDate='null' set @currDiplomaDate=null
	if @currDiplomaID='' or @currDiplomaID='null' set @currDiplomaID=null
	select @fromID=dbo.whenull(@fromID,null), @ID=0, @username=upper(@username), @source=null
	--@fromID如果没有.后缀，添加上去。
	select @event='在线报名',@refID=0,@re=0,@host=iif(@url>'',@url,host),@checked=0,@SNo=0,@dept1=dept1,@dept2=dept2,@payNow=0,@title='',@fromID=iif(charindex('.',@fromID)>0,@fromID,iif(@fromID>'',@fromID+'.',@fromID)),@fromKind=fromKind from studentInfo where username=@username
	if @host='spc'
	begin
		if exists(select 1 from deptInfo where deptID=@dept2)
		begin
			select @kind=accountKind, @payNow=payNow, @title=title from deptInfo where deptID=@dept2
			if @kind=2
				select @title=item from dictionaryDoc where kind='SPCtitle'	--报账类型的部门，选取石化公司统一开票信息
		end
	end
	select @type=type, @fromID=iif(@fromID='arma.','amra.',@fromID) from certificateInfo where certID=@certID
	if @type=0	--非石化项目
	begin
		select top 1 @projectID = projectID,@price=[dbo].[getProjectPrice](projectID,@fromID) from projectInfo where host=@host and status=1 and certID=@certID and reexamine=@reexamine order by projectID desc -- and (dept='' or [dbo].[pf_inStrArray](dept,',',@dept1)=1)
		if @projectID is null
			select @re = 2, @msg = '没有找到合适的项目，不能报名。'
	end
	select @courseID=courseID from courseInfo where certID=@certID and reexamine=@reexamine
	--select @classID=classID from classInfo where dbo.pf_inStrArray(projectID,',',@projectID)=1 and status=0

	if @host<>'znxf'	--公司人员如果在预报名名单里，自动确认
	begin
		if exists(select 1 from ref_student_spc a, projectInfo b where a.projectID=b.projectID and a.username=@username and b.certID=@certID and datediff(d,a.regDate,getDate())<10)
			select @checked = 1,@checkDate=getDate(),@checker='system.',@SNo=a.ID from ref_student_spc a, projectInfo b where a.projectID=b.projectID and a.username=@username and b.certID=@certID and datediff(d,a.regDate,getDate())<60
	end

	if exists(select 1 from certificateInfo where certID=@certID)
		set @mark = 0
	else
		set @mark = 1

	if (@mark=0 and not exists(select 1 from studentCertList where certID=@certID and username=@username and diplomaID is null and status<2)) or (@mark=1 and not exists(select 1 from studentCourseList where courseID=@certID and username=@username and status<2))	--未结束的课程以及结课但未发证书的
	begin
		if @mark=0
		begin
			if @reexamine=1 and datediff(d,getDate(),@currDiplomaDate)<3
				select @re = 2, @msg = '应复训日期临近，无法满足申报要求。'
			else
			begin
				select @source=title from hostInfo where hostNo=@host and @host<>'znxf'
				--添加证书项目
				insert into studentCertList(username,certID,reexamine,host,registerID,memo) values(@username,@certID,@reexamine,@host,@username,@url)
				select @refID=max(ID) from studentCertList where registerID=@username and certID=@certID
				select @type=type from v_studentCertList where ID=@refID
				--合作单位或石化内部项目，设为未付费、后付费
				if @host not in('znxf','spc','shm') or @type=1
					select @payNow = 1
				declare @saler varchar(50)
				exec [setStudentSaler] @username, @fromID, @saler output

				--添加课程  石化内部项目，设为不签名
				insert into studentCourseList(username,courseID,refID,payNow,title,price,type,signatureType,hours,closeDate,projectID,classID,SNo,reexamine,checked,checkDate,checker,currDiplomaID,currDiplomaDate,fromID,fromKind,source,host,registerID) select @username,courseID,@refID,@payNow,@title,@price,@type,iif(@type=1,0,1),hours,dateadd(d,period,getDate()),@projectID,@classID,@SNo,@reexamine,@checked,@checkDate,@checker,@currDiplomaID,@currDiplomaDate,@saler,@fromKind,@source,@host,@username from courseInfo where courseID=@courseID
				select @ID=max(ID) from studentCourseList where refID=@refID

				if @type=1	--公司内部项目
				begin
					--添加课表
					insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,b.ID,a.hours,@username from lessonInfo a, studentCourseList b where a.courseID=b.courseID and b.ID=@ID and a.status=0
	
					--添加课件
					insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,@username from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0

					--添加视频
					insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,@username from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0

					--添加考试，题目暂不生成
					if exists(select 1 from  examInfo where courseID=@courseID)
						insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,mark) select @username,examID,@ID,minutes,minutes*60,scoreTotal,scorePass,kindID,@mark from examInfo where (courseID=@courseID or (courseID is null and certID=@certID)) and status=0 order by ID
					else
						insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,mark) select @username,examID,@ID,minutes,minutes*60,scoreTotal,scorePass,kindID,@mark from examInfo where certID=@certID and status=0 order by ID
				end
			end
		end
	
		if @mark=1
		begin
			--添加课程
			insert into studentCourseList(username,courseID,refID,type,hours,closeDate,projectID,classID,SNo,checked,checkDate,checker,host,registerID) select @username,@certID,@refID,1,hours,dateadd(d,period,getDate()),@projectID,@classID,@SNo,@checked,@checkDate,@checker,@host,@username from courseInfo where courseID=@certID and reexamine=@reexamine
			select @refID=max(ID) from studentCourseList where registerID=@username
			select @ID=@refID

			--添加课表
			insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,@refID,hours,@username from lessonInfo where courseID=@certID and status=0
	
			--添加课件
			insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,@username from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@refID and a.status=0

			--添加视频
			insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,@username from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@refID and a.status=0

			--添加考试，题目暂不生成
			insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,mark) select @username,examID,@refID,minutes,minutes*60,scoreTotal,scorePass,kindID,@mark from examInfo where courseID=@certID and status=0
		end

		--添加付款记录
		--exec updatePayInfo 0,'',@projectID,'',0,0,0,'','','',@username,'','system.',@payID output

		--添加付款明细
		--insert into payDetailInfo(payID,enterID,price,memo,registerID) values (@payID,@ID,@price,'','system.')
		--exec updatePayAmount @payID

		--写日志
		select @logMemo=@certID + ':' + @fromID
		exec writeOpLog '',@event,'addStudentCert',@username,@logMemo,@ID
	end
	else
		select @re = 1, @msg = '已有相同证书项目，不能重复报名。'
	select @ID as enterID, isnull(@re,0) as status, isnull(@msg,'') as msg
END
GO


-- CREATE Date: 2025-08-16
-- 给定username，fromID，判断该学员应该属于哪个销售员。如果已有销售，则返回原有的销售，否则将该学员标记为新的销售
-- USE CASE: exec [setStudentSaler] '1230000','xxxx.'
ALTER PROCEDURE [dbo].[setStudentSaler] 
	@username varchar(50),@fromID varchar(50), @saler varchar(50) output
--WITH ENCRYPTION
AS
BEGIN
	--select @saler = isnull(fromID,'') from studentInfo where username=@username

	--if @saler='' and @fromID>''
	--begin
	--	update studentInfo set fromID=@fromID where username=@username
	--	set @saler=@fromID
	--end
	set @saler=@fromID
END
GO

--test
exec addnewStudentCert '120107196604032113','C001' 

truncate table studentCertList
truncate table studentCourseList
truncate table studentLessonList
truncate table studentCoursewareList
truncate table studentVideoList
truncate table studentExamList

select * from studentCertList
select * from studentCourseList
select * from studentLessonList
select * from studentCoursewareList
select * from studentVideoList
select * from studentExamList
--end test


-- =============================================
-- CREATE Date: 2020-05-08
-- Description:	学员选择给定的证书项目，将其删除并同时删除相关的课程。
-- mark: 0 证书项目  1 培训项目（只有课程）
-- Use Case:	exec delStudentCert '310....' 
-- =============================================
ALTER PROCEDURE [dbo].[delStudentCert] 
	@ID int,@mark int
AS
BEGIN
	DECLARE @logMemo nvarchar(500),@event varchar(50),@re int,@refID int,@username varchar(50),@host varchar(50)
	select @event='移除所选证书项目',@refID=0,@re=0
	if @mark = 0
	begin
		select @username=username,@host=host from studentCertList where ID=@ID
		select @refID=ID,@logMemo=courseID + ':' + @username from studentCourseList where refID=@ID

		--删除试题
		delete from studentQuestionList where refID in(select paperID from studentExamList where refID=@refID)

		--删除考试
		delete from studentExamList where refID=@refID

		--删除视频
		delete from studentVideoList where refID in(select ID from studentLessonList where refID=@refID)

		--删除课件
		delete from studentCoursewareList where refID in(select ID from studentLessonList where refID=@refID)

		--删除课表
		delete from studentLessonList where refID=@refID
		--删除课程
		delete from studentCourseList where ID=@refID
		--删除证书项目
		delete from studentCertList where ID=@ID
	end
	if @mark = 1
	begin
		select @username=username,@host=host from studentCourseList where ID=@ID
		select @logMemo=courseID + ':' + @username from studentCourseList where refID=@ID

		--删除试题
		delete from studentQuestionList where refID in(select paperID from studentExamList where refID=@ID and mark=@mark)

		--删除考试
		delete from studentExamList where refID=@ID and mark=@mark

		--删除视频
		delete from studentVideoList where refID in(select ID from studentLessonList where refID=@ID)

		--删除课件
		delete from studentCoursewareList where refID in(select ID from studentLessonList where refID=@ID)

		--删除课表
		delete from studentLessonList where refID=@ID
		--删除课程
		delete from studentCourseList where ID=@ID
		--删除证书项目
		delete from studentCertList where ID=@ID
	end

	-- 写操作日志
	exec writeOpLog '',@event,'delStudentCert',@username,@logMemo,@ID

	return @re
END
GO

-- =============================================
-- CREATE Date: 2020-05-09
-- Description:	根据给定的数据，更新学员播放视频的进度。
-- shoted: 0 正常记录  1 清零shotTime
-- 返回是否要检测的信息：0 不检测  1 检测
-- Use Case:	exec update_video_currentTime 1,530
-- =============================================
ALTER PROCEDURE [dbo].[update_video_currentTime] 
	@ID int, @currentTime int, @shoted int
AS
BEGIN
	declare @refID int, @shotTime int, @shotNow int, @n int, @agencyID int, @check_pass int
	select @n = 60 * 25  --(10秒通讯一次)20分钟拍照一次
	select @refID=refID,@shotTime=iif(@shoted=1,0,shotTime+iif(@currentTime>maxTime and shotNow=0,@currentTime-maxTime,0)),@shotNow=shotNow from studentVideoList where ID=@ID
	select @check_pass=check_pass from studentCourseList where ID=(select max(refID) from studentLessonList where ID=@refID)
	select @agencyID=agencyID from v_courseInfo where courseID in(select courseID from studentCourseList where ID in(select refID from studentLessonList where ID=@refID))

	select @shotNow = iif(@shotTime>=@n or (@shotNow=1 and @shoted=0), 1, 0)
	--安监项目且非免签的要拍照，其他不需要
	select @shotNow = iif(@agencyID=1 and @check_pass=0,@shotNow,0)
	update studentVideoList set maxTime=(case when @currentTime>maxTime and @shotNow=0 then @currentTime else maxTime end),lastTime=iif(@shotNow=0,@currentTime,lastTime),shotTime=@shotTime,shotNow=@shotNow where ID=@ID
	if @shotNow=0
		exec update_lesson_completion @refID
	return @shotNow
END
GO

-- =============================================
-- CREATE Date: 2020-05-09
-- Description:	根据给定的数据，更新学员翻看课件的进度。
-- Use Case:	exec update_courseware_currentPage 1,5
-- =============================================
ALTER PROCEDURE [dbo].[update_courseware_currentPage] 
	@ID int, @currentPage int
AS
BEGIN
	declare @refID int
	update studentCoursewareList set maxPage=(case when @currentPage>maxPage then @currentPage else maxPage end),lastPage=@currentPage where ID=@ID
	select @refID=refID from studentCoursewareList where ID=@ID
	exec update_lesson_completion @refID
	return 0
END

GO

-- =============================================
-- CREATE Date: 2020-05-11
-- Description:	更新指定课节的进度。
-- Use Case:	exec update_lesson_completion 1
-- =============================================
ALTER PROCEDURE [dbo].[update_lesson_completion] 
	@ID int
AS
BEGIN
	declare @c int, @refID int,@username varchar(50),@host varchar(50),@courseName varchar(50),@item nvarchar(500)
	select @refID = refID from studentLessonList where ID=@ID
	select @c = sum(a.tot) from(
		select avg(maxTime*proportion/60/(case when minutes=0 then 100 else minutes end)) as tot from studentVideoList where refID=@ID 
		union
		select avg(maxPage * proportion/(case when pages=0 then 100 else pages end)) from studentCoursewareList where refID=@ID 
	) a
	update studentLessonList set completion=@c where ID=@ID
	if exists(select 1 from studentCourseList where ID=@refID and status=0)
		update studentCourseList set status=1, startDate=getDate() where ID=@refID
	if exists(select 1 from v_studentCourseList where ID=@refID and refID=0 and completion>=completionPass and status<2)
	begin
		update studentCourseList set status=2, endDate=getDate() where ID=@refID
		--发送消息  kindID：0 回复 1 通知
		select @item ='恭喜您已经完成"' + courseName + '"课程的学习。',@host=host,@username=username from v_studentCourseList where ID=@refID
		exec sendSysMessage @username,1,@item,@host,'system.'
	end
	return 0
END

GO


-- =============================================
-- CREATE Date: 2020-05-10
-- Description:	根据给定的上传文件数据，更新相关的信息。
-- kind:0 学生上传资料  1 其他资料
-- Use Case:	exec setUploadSingleFileLink 'student_photo','11111','\ss\ss\ss.jpg'
-- =============================================
ALTER PROCEDURE [dbo].[setUploadSingleFileLink] 
	@upID varchar(50), @key varchar(50), @file varchar(200), @fsize int, @multiple int, @registerID varchar(50)
AS
BEGIN
	declare @re int, @kindID int, @i int, @ID int, @refID int, @event varchar(50)
	select @re = 0, @i=0, @file=replace(@file,'\','/')
	if exists(select ID from dictionaryDoc where kind='material' and memo=@upID)
	begin
		if(@key=substring(@file,charindex('/',@file,20)+1,len(@key)))
		begin
			select @kindID=ID,@event='上传'+item from dictionaryDoc where kind='material' and memo=@upID
			if exists(select 1 from studentInfo where username=@key)
			begin
				delete from studentMaterials where username=@key and kindID=@kindID
				insert into studentMaterials(kindID,username,filename,type,size,registerID) values(@kindID,@key,@file,0,@fsize,@registerID)
				select @ID=a.ID,@refID=b.ID from studentMaterialsAsk a, studentCourseList b where a.refID=b.ID and b.username=@key and a.kindID=@kindID and a.status=1
				if @ID>0
				begin
					update studentMaterialsAsk set status=2,answerID=@registerID,answerDate=getDate() where ID=@ID
					--更新service记录
					update studentServiceInfo set status=1,backDate=getDate(),feedback='已提交新图片' where refID=@refID and vID=@kindID
				end
				--如果是上传图片，检查一下是否有催缴通知
				if @upID='student_photo' and exists(select 1 from log_attention where kindID=0 and refID=@key and status=1)
					exec [replyAttention] @key, 0
				-- 记录照片大小
				if @upID='student_photo'
					update studentInfo set photo_size = @fsize where username=@key
			end
			else
				if [dbo].[fn_validateIDCard](@key) = 1
					select @re = 2	--查无此人
				else
					select @re=1	--身份证号码错误
		end
		else
			select @re = 3	--身份证与文件名不符
	end
	else
	begin
		if @upID = 'course_video'	--课程视频
		begin
			update videoInfo set filename=@file where videoID=@key
			select @i=1
		end
		if @upID = 'course_courseware'	--课件
		begin
			update coursewareInfo set filename=@file where coursewareID=@key
			select @i=1
		end
		if @upID = 'student_diploma'	--学员证书
		begin
			update diplomaInfo set filename=@file where diplomaID=@key
			select @i=1, @event='上传学员证书'
		end
		if @upID = 'host_logo'	--公司logo
		begin
			update hostInfo set logo=@file where hostNo=@key
			select @i=1
		end
		if @upID = 'host_QR'	--公司学员登录二维码
		begin
			update hostInfo set QR=@file where hostNo=@key
			select @i=1
		end
		if @upID = 'student_list'	--学员报名表
		begin
			--update generateStudentInfo set filename=@file where ID=@key
			update classInfo set filename=@file where ID=@key
			select @i=1, @event='上传学员报名表'
		end
		if @upID = 'score_list'	--学员成绩单
		begin
			update generatePasscardInfo set filescore=@file where ID=@key
			select @i=1, @event='上传学员成绩单'
		end
		if @upID = 'ref_student_list'	--学员预报名表
		begin
			update classInfo set filename=@file where ID=@key
			select @i=1, @event='上传学员预报名表'
		end
		if @upID = 'apply_list'	--申报结果
		begin
			update generateApplyInfo set filename=@file where ID=@key
			select @i=1, @event='上传申报结果'
		end
		if @upID = 'apply_score_list'	--申报成绩和证书
		begin
			update generateApplyInfo set filescore=@file where ID=@key
			select @i=1, @event='上传申报成绩和证书'
		end
		if @upID = 'apply_resit_list'	--申报补考名单
		begin
			update generateApplyInfo set memo=isnull(memo,'') + '补考名单导入' + convert(varchar(20),getDate(),23) where ID=@key
			select @i=1, @event='上传申报补考名单'
		end
		if @upID = 'student_letter_signature'	--承诺书签名
		begin
			update studentCourseList set signature=@file,signatureDate=getDate() where ID=@key
			select @i=1, @event='上传承诺书签名'
			--检查一下是否有催缴通知
			if exists(select 1 from log_attention where kindID=1 and refID=@key and status=1)
				exec [replyAttention] @key, 1
		end
		if @i = 0 and @upID = 'invoice_pdf'	--发票 上传后标记为已开票，开票日期为当天
		begin
			update studentCourseList set file5=@file,needInvoice=2,dateInvoice=getDate() where ID=@key  
			--update payInfo set dateInvoice=getDate() where ID=(select payID from payDetailInfo where enterID=@key)
			select @i=1, @event='上传发票'
		end
		if @i = 0 and @upID like 'question_image%'	--题目图片
		begin
			if @upID = 'question_image'
				update questionInfo set [image]=@file where ID=@key
			if @upID = 'question_imageA'
				update questionInfo set imageA=@file where ID=@key
			if @upID = 'question_imageB'
				update questionInfo set imageB=@file where ID=@key
			if @upID = 'question_imageC'
				update questionInfo set imageC=@file where ID=@key
			if @upID = 'question_imageD'
				update questionInfo set imageD=@file where ID=@key
			if @upID = 'question_imageE'
				update questionInfo set imageE=@file where ID=@key
			if @upID = 'question_imageF'
				update questionInfo set imageF=@file where ID=@key
			select @i=1, @event='题目图片'
		end
		--if @upID = 'project_brochure'	--招生简章
		if @i=0
		begin
			if exists(select 1 from materialInfo where refID=@key and kind=@upID)
				delete from materialInfo where refID=@key and kind=@upID
			insert into materialInfo(refID,kind,filename,registerID) values(@key,@upID,@file,@registerID)
			select @i=1
		end
	end
	-- 写操作日志
	exec writeOpLog '',@event,'',@registerID,'',@key

	--批量上传填写记录
	if @multiple > 0 and @re=0
		insert into generateMaterialDetail(batchID,filename) values(@multiple,@file)
	return @re
END
GO

/*
-- =============================================
-- CREATE Date: 2020-05-10
-- Description:	根据给定的试卷编号，为学员生成考试题目。
-- mark:0 如果已有题目，不再生成  1 强制生成新题目
-- Use Case:	exec addQuestions4StudentExam 1,1
-- =============================================
ALTER PROCEDURE [dbo].[addQuestions4StudentExam] 
	@paperID int, @mark int
AS
BEGIN
	declare @examID varchar(50),@kp varchar(50),@type int, @qty int,@scorePer decimal(18, 2),@sql nvarchar(1000), @n int,@q int
	select @examID=examID from studentExamList where paperID=@paperID
	select @n = count(*) from studentQuestionList where refID=@paperID

	if @n=0 or @mark=1
	begin
		delete from studentQuestionList where refID=@paperID		--remove old records firstly
		--initial exam paper status.
		update studentExamList set secondRest=minutes*60,startDate=null,endDate=null,status=0,lastDate=null where paperID=@paperID
		--read exam rule, and execute it one by one.
		declare rc cursor for select knowPointID,typeID,qty,scorePer from examRuleInfo where examID=@examID and status=0 order by seq
		open rc
		fetch next from rc into @kp,@type,@qty,@scorePer
		While @@fetch_status=0 
		Begin 
			--组卷时参照该试卷已使用过的题目情况，抽取使用次数较少的题目
			set @sql='insert into studentQuestionList(questionID,refID,kindID,scorePer,answer) select top ' + cast(@qty as varchar) + ' a.questionID,' + cast(@paperID as varchar) + ',a.kindID,' + cast(@scorePer as varchar) + ',a.answer from questionInfo a left outer join studentQuestionUsed b on a.questionID=b.questionID and b.refID=' + cast(@paperID as varchar) + ' where a.knowPointID=''' + @kp + ''' and a.kindID=' + cast(@type as varchar) + ' and a.status=0 order by b.times,newid()'
			if exists(select 1 from v_studentQuestionList where refID=@paperID and knowPointID=@kp and kindID=@type)	--防止重复生成题目
			begin
				insert into look_exam_question_overflow(questionID,refID,kindID,knowPointID) select questionID,refID,kindID,@kp from studentQuestionList where refID=@paperID and kindID=@type
				delete from studentQuestionList where ID in(select ID from v_studentQuestionList where refID=@paperID and knowPointID=@kp and kindID=@type)
			end
			EXEC sp_executesql @sql		--随机获取题目

			if exists(select 1 from v_studentQuestionList where refID=@paperID and knowPointID=@kp and kindID=@type group by questionID having count(*)>1)	--检查重复题目
			begin
				delete from studentQuestionList where ID in(select ID from v_studentQuestionList where refID=@paperID and knowPointID=@kp and kindID=@type)
				EXEC sp_executesql @sql		--随机获取题目
			end

			fetch next from rc into @kp,@type,@qty,@scorePer
		End
		Close rc 
		Deallocate rc

		--将新抽取的题目写入到已使用题目列表中
		update studentQuestionUsed set times=times+1 from studentQuestionList b where studentQuestionUsed.questionID=b.questionID and studentQuestionUsed.refID=b.refID and studentQuestionUsed.refID=@paperID
		insert into studentQuestionUsed(questionID,refID,kindID,status,answer) select questionID,refID,kindID,0,answer from studentQuestionList where refID=@paperID and questionID not in(select questionID from studentQuestionUsed where refID=@paperID)
	end
	return 0
END
GO*/

-- =============================================
-- CREATE Date: 2020-05-10
-- Description:	根据给定的试卷编号，为学员生成考试题目。
-- mark:0 如果已有题目，不再生成  1 强制生成新题目
-- pkind:0 模拟/正式考试  1 错题集  2 总题库  3 收藏夹  4 章节练习
-- kindID: when pkind=2  questionInfo.kindID   when pkind=4  questionInfo.chapterID
-- paperID: pkind 0 - paperID; pkind>0 - enterID
-- onlyWrong: 0 all  1 only wrong answer of 判断题
-- Use Case:	exec addQuestions4StudentExam 1,1
-- =============================================
ALTER PROCEDURE [dbo].[addQuestions4StudentExam] 
	@paperID int, @mark int, @pkind int, @examID varchar(50), @kindID int, @page int, @pageSize int, @onlyWrong int
AS
BEGIN
	declare @kp varchar(50),@type int, @qty int,@scorePer decimal(18, 2),@sql nvarchar(1000), @n int,@q int,@memo varchar(500)
	declare @courseID varchar(50), @certID varchar(50)
	select @mark = dbo.whenull(@mark,0), @page=dbo.whenull(@page,0), @pageSize=dbo.whenull(@pageSize,0),@memo='',@qty=0,@n=0
	create table #temp(ID int,questionID varchar(50),kindID int,scorePer decimal(18,2),score decimal(18,2),answer varchar(50),myAnswer varchar(50),questionName nvarchar(2000),A nvarchar(200),B nvarchar(200),C nvarchar(200),D nvarchar(200),E nvarchar(200),F nvarchar(200),image varchar(200),imageA varchar(200),imageB varchar(200),imageC varchar(200),imageD varchar(200),imageE varchar(200),imageF varchar(200),knowPointID varchar(50),kindName varchar(50),memo nvarchar(2000))
	if @examID=''
		select @examID=examID from studentExamList where paperID=@paperID
	
	if @pkind=0
	begin
		select @qty = count(*) from studentQuestionList where refID=@paperID
		select @n=sum(qty) from examRuleInfo where examID=@examID and status=0
	end

	-- 模拟/正式考试
	if @pkind=0 and (@n<>@qty or @mark=1)
	begin
		delete from studentQuestionList where refID=@paperID		--remove old records firstly
		--initial exam paper status.
		update studentExamList set secondRest=minutes*60,startDate=null,endDate=null,status=0,lastDate=null where paperID=@paperID
		--read exam rule, and execute it one by one.
		declare rc cursor for select knowPointID,typeID,qty,scorePer from examRuleInfo where examID=@examID and status=0 order by seq
		open rc
		fetch next from rc into @kp,@type,@qty,@scorePer
		While @@fetch_status=0 
		Begin 
			--组卷时参照该试卷已使用过的题目情况，抽取使用次数较少的题目
			set @sql='insert into studentQuestionList(questionID,refID,kindID,scorePer,answer) select top ' + cast(@qty as varchar) + ' a.questionID,' + cast(@paperID as varchar) + ',a.kindID,' + cast(@scorePer as varchar) + ',a.answer from questionInfo a left outer join studentQuestionUsed b on a.questionID=b.questionID and b.refID=' + cast(@paperID as varchar) + ' where a.knowPointID=''' + @kp + ''' and a.kindID=' + cast(@type as varchar) + ' and a.status=0 order by b.times,newid()'
			/**
			if exists(select 1 from v_studentQuestionList where refID=@paperID and knowPointID=@kp and kindID=@type)	--防止重复生成题目
			begin
				insert into look_exam_question_overflow(questionID,refID,kindID,knowPointID) select questionID,refID,kindID,@kp from studentQuestionList where refID=@paperID and kindID=@type
				delete from studentQuestionList where ID in(select ID from v_studentQuestionList where refID=@paperID and knowPointID=@kp and kindID=@type)
			end
			**/
			EXEC sp_executesql @sql		--随机获取题目
			select @memo=@memo + @kp+'/'+cast(@type as varchar)+'/'+cast(@qty as varchar) + '; '
			/**
			if exists(select 1 from v_studentQuestionList where refID=@paperID and knowPointID=@kp and kindID=@type group by questionID having count(*)>1)	--检查重复题目
			begin
				delete from studentQuestionList where ID in(select ID from v_studentQuestionList where refID=@paperID and knowPointID=@kp and kindID=@type)
				EXEC sp_executesql @sql		--随机获取题目
			end
			**/
			fetch next from rc into @kp,@type,@qty,@scorePer
		End
		Close rc 
		Deallocate rc

		--将新抽取的题目写入到已使用题目列表中
		update studentQuestionUsed set times=times+1 from studentQuestionList b where studentQuestionUsed.questionID=b.questionID and studentQuestionUsed.refID=b.refID and studentQuestionUsed.refID=@paperID
		insert into studentQuestionUsed(questionID,refID,kindID,status,answer) select questionID,refID,kindID,0,answer from studentQuestionList where refID=@paperID and questionID not in(select questionID from studentQuestionUsed where refID=@paperID)
	end

	if @pkind=0
	begin
		select @qty=count(*) from studentQuestionList where refID=@paperID
		--select @n=sum(qty) from examRuleInfo where examID=@examID and status=0
		if @qty<>@n
			insert into temp_exam_question_qty(paperID,examID,qty,qty0,memo) values(@paperID,@examID,@qty,@n,@memo)
		else
			insert into #temp
			select ID,questionID,kindID,scorePer,score,answer,myAnswer,questionName,A,B,C,D,E,F,image,imageA,imageB,imageC,imageD,imageE,imageF,knowPointID,kindName,memo from v_studentQuestionList where refID=@paperID order by kindID desc,ID
	end

	-- 错题集
	if @pkind=1
		insert into #temp
		select ID,questionID,kindID,0,0,answer,myAnswer,questionName,A,B,C,D,E,F,image,imageA,imageB,imageC,imageD,imageE,imageF,knowPointID,kindName,memo from v_studentQuestionWrong where enterID=@paperID

	-- 总题库
	if @pkind=2
	begin
		select @courseID=a.courseID, @certID=b.certID from studentCourseList a, courseInfo b where a.courseID=b.courseID and a.ID=@paperID
		if @kindID=3 and @onlyWrong=1	--only wrong answer questions
			insert into #temp
			select ID,questionID,kindID,0,0,answer,'',questionName,A,B,C,D,E,F,image,imageA,imageB,imageC,imageD,imageE,imageF,knowPointID,kindName,memo
			from v_questionInfo where [knowPointID] in(select [knowPointID] from examRuleInfo where examID=@examID) and status=0 and kindID=@kindID and answer='B' order by [knowPointID],kindID,ID
		else
			insert into #temp
			select ID,questionID,kindID,0,0,answer,'',questionName,A,B,C,D,E,F,image,imageA,imageB,imageC,imageD,imageE,imageF,knowPointID,kindName,memo
			from v_questionInfo where [knowPointID] in(select [knowPointID] from examRuleInfo where examID=@examID) and status=0 and kindID=@kindID order by [knowPointID],kindID,ID
	end

	-- 收藏夹
	if @pkind=3
		insert into #temp
		select ID,questionID,kindID,0,0,answer,'',questionName,A,B,C,D,E,F,image,imageA,imageB,imageC,imageD,imageE,imageF,knowPointID,kindName,memo from v_studentQuestionMark where enterID=@paperID

	-- 章节练习
	if @pkind=4
	begin
		select @courseID=a.courseID, @certID=b.certID from studentCourseList a, courseInfo b where a.courseID=b.courseID and a.ID=@paperID
		insert into #temp
		select a.ID,a.questionID,a.kindID,0,0,a.answer,'',questionName,A,B,C,D,E,F,image,imageA,imageB,imageC,imageD,imageE,imageF,a.knowPointID,a.kindName,a.memo
		from v_questionInfo a, (select distinct c.knowPointID, b.examID, b.kindID from examInfo b, examRuleInfo c where b.examID=c.examID and b.courseID=@courseID) d where a.knowPointID=d.knowPointID and a.status=0 and a.chapterID=@kindID
	end

	if not exists(select 1 from #temp)
		insert into #temp select 0,0,0,0,0,'','','没有发现相关题目。','','','','','','','','','','','','','',0,'',''

	if @pkind=0 and @page>0 and @pageSize>0
		select * from #temp order by kindID desc,ID offset (@page-1)*@pageSize rows fetch next @pageSize rows only
	else
		select top 100 percent * from #temp order by kindID, questionID
	return 0
END
GO

-- =============================================
-- CREATE Date: 2020-05-11
-- Description:	根据给定的数据，更新学员考试答案。返回已答题数量
-- Use Case:	exec update_student_question_answer 101,'A'
-- =============================================
ALTER PROCEDURE [dbo].[update_student_question_answer] 
	@ID int, @answer varchar(50)
AS
BEGIN
	declare @re int, @paperID int
	update studentQuestionList set myAnswer=@answer,answerDate=getDate() where ID=@ID
	select @re=count(*) from studentQuestionList where refID=(select refID from studentQuestionList where ID=@ID) and myAnswer>''
	return isnull(@re,0)
END
GO

-- =============================================
-- CREATE Date: 2020-05-11
-- Description:	根据给定的数据，更新学员考试剩余时间。
-- 如果是第一次更新，同时填写开始时间并将状态设为考试中。
-- 模拟考试的剩余时间以考生端为准，正式考试以服务器为准。
-- 正式考试时如果时间误差小于5秒钟，不做处理（返回0），否则返回服务器时间。
-- 如果已交卷或剩余时间为0，返回1，否则返回0
-- Use Case:	exec update_student_exam_secondRest 1,3140
-- =============================================
ALTER PROCEDURE [dbo].[update_student_exam_secondRest] 
	@paperID int, @secondRest int
AS
BEGIN
	declare @re int, @kind int, @refID int, @rest int
	select @re=0, @kind=kind, @refID=refID, @rest=0 from studentExamList where paperID=@paperID
	if @kind=0
		update studentExamList set secondRest=(case when secondRest>0 then @secondRest else secondRest end),lastDate=getDate(),startDate=(case when status=0 then getDate() else startDate end),status=(case when status=0 then 1 else status end) where paperID=@paperID
	else
	begin
		select @rest=datediff(s,getDate(),endDate) from v_passcardInfo where ID=@refID
		update studentExamList set secondRest=(case when @rest>0 then @rest else 0 end),lastDate=getDate(),startDate=(case when status=0 then getDate() else startDate end),status=(case when status=0 then 1 else status end) where paperID=@paperID
		if abs(@rest-@secondRest)<5
			select @rest=0
	end

	if exists(select 1 from studentExamList where paperID=@paperID and (status=2 or secondRest<5))
		select @re=1
	select @re as status, @rest as secondRest, count(*) as answerQty from studentQuestionList where refID=@paperID and myAnswer is not null
END

GO


-- =============================================
-- CREATE Date: 2020-05-11
-- Description:	学员考试交卷。
-- Use Case:	exec submit_student_exam 1
-- =============================================
ALTER PROCEDURE [dbo].[submit_student_exam] 
	@paperID int
AS
BEGIN
	declare @score decimal(18,1),@refID int,@kindID int, @kind int, @times int, @type int, @scorePass int, @username varchar(50), @host varchar(50),@item nvarchar(500),@certName varchar(50),@ID int,@status int
	select @score = 0, @refID=refID, @kindID=kindID, @kind=kind, @scorePass=scorePass, @status=status from studentExamList where paperID=@paperID
	select @ID=refID  from studentCourseList where ID=@refID

	if @status=1	--只有已开始状态的考试才能交卷
	begin
		--评分
		update studentQuestionList set answer=replace(answer,' ','') where refID=@paperID and charindex(' ',answer)>0
		update studentQuestionList set score=(case when answer=myAnswer then scorePer else 0 end) where refID=@paperID
		select @score=sum(score) from studentQuestionList where refID=@paperID
		--select @score=(case when @kind=1 and @score<@scorePass then ceiling(SQRT(@score)*10) else @score end)
		--select @score = (case when @score>100 then 88 else @score end)
		--交卷: 剩余时间清零
		update studentExamList set status=2,endDate=getDate(),score=@score,secondRest=0 where paperID=@paperID
		--将考试结果填写到相关表中
		if @kind=0 and @kindID=0		--证书模拟考试
		begin
			select @type = type,@username=username,@host=host,@certName=certName from v_studentCertList where ID=@ID
			update studentCertList set examScore=(case when examScore<@score then @score else examScore end),examTimes=examTimes+1 where ID=@ID
			select @score=examScore, @times= examTimes from studentCertList where ID=@ID
			update studentCourseList set examScore=@score, examTimes=@times where ID=@refID
			if @type=1 and @score >= @scorePass
			begin
				--企业内部证书通过考试，自动结束课程
				if exists(select 1 from studentCertList where ID=@ID and status<2)
				begin
					update studentCertList set result=1,status=2,closeDate=getDate() where ID=@ID
					update studentCourseList set status=2,endDate=getDate(),startDate=(case when startDate is null then getDate() else startDate end) where ID=@refID
					--发送消息  kindID：0 回复 1 通知
					set @item ='祝贺考试合格[' + @certName + ']！请确保上传的证书照片为本人自拍像（身份证照片或报名照翻拍视为无效），并于1个工作日后在本平台查询电子证件。若无法查询到电子证的，请核对上传的照片符合要求。'
					exec sendSysMessage @username,1,@item,@host,'system.'
				end
			end
			--备份试卷试题
			exec backupExam @paperID
		end
		if @kind=0 and @kindID=1		--课程模拟考试
			update studentCourseList set examScore=(case when examScore<@score then @score else examScore end),examTimes=examTimes+1 where ID=@refID
		if @kind=1		--在线考试
			update passcardInfo set score=@score where ID=@refID
	end
	
	return 0
END
GO

-- =============================================
-- CREATE Date: 2020-05-11
-- Description:	学员考试交卷。
-- Use Case:	exec submit_student_exam_pass 1
-- =============================================
CREATE PROCEDURE [dbo].[submit_student_exam_pass] 
	@paperID int, @score int
AS
BEGIN
	declare @refID int,@kindID int, @kind int, @times int, @type int, @scorePass int, @username varchar(50), @host varchar(50),@item nvarchar(500),@certName varchar(50),@ID int,@status int
	select @refID=refID, @kindID=kindID, @kind=kind, @scorePass=scorePass, @status=status from studentExamList where paperID=@paperID
	select @ID=refID  from studentCourseList where ID=@refID

		update studentExamList set status=2,endDate=getDate(),score=@score,secondRest=0 where paperID=@paperID
		--将考试结果填写到相关表中
		if @kind=0 and @kindID=0		--证书模拟考试
		begin
			select @type = type,@username=username,@host=host,@certName=certName from v_studentCertList where ID=@ID
			update studentCertList set examScore=@score where ID=@ID
			update studentCourseList set examScore=@score where ID=@refID
			if @type=1 and @score >= @scorePass
			begin
				--企业内部证书通过考试，自动结束课程
				if exists(select 1 from studentCertList where ID=@ID and status<2)
				begin
					update studentCertList set result=1,status=2,closeDate=getDate() where ID=@ID
					update studentCourseList set status=2,endDate=getDate(),startDate=(case when startDate is null then getDate() else startDate end) where ID=@refID
					--发送消息  kindID：0 回复 1 通知
					set @item ='祝贺考试合格[' + @certName + ']！请确保上传的证书照片为本人自拍像（身份证照片或报名照翻拍视为无效），并于1个工作日后在本平台查询电子证件。若无法查询到电子证的，请核对上传的照片符合要求。'
					exec sendSysMessage @username,1,@item,@host,'system.'
				end
			end
			--备份试卷试题
			--exec backupExam @paperID
		end
		if @kind=0 and @kindID=1		--课程模拟考试
			update studentCourseList set examScore=(case when examScore<@score then @score else examScore end) where ID=@refID
		if @kind=1		--在线考试
			update passcardInfo set score=@score where ID=@refID

	
	return 0
END
GO


-- =============================================
-- CREATE Date: 2020-05-13
-- Description:	交卷以后，将试卷信息备份到表中
-- @paperID: 试卷编号
-- Use Case:	exec backupExam 1
-- =============================================
ALTER PROCEDURE [dbo].[backupExam] 
	@paperID int
AS
BEGIN
	--避免重复提交
	if not exists(select 1 from ref_studentExamList a, studentExamList b where a.paperID=b.paperID and a.startDate=b.startDate and b.paperID=@paperID)
	begin
		declare @id int
		--备份试卷
		insert into ref_studentExamList(paperID,username,examID,refID,kindID,kind,status,minutes,secondRest,scoreTotal,scorePass,score,startDate,endDate,lastDate,mark,memo,regDate,registerID) select * from studentExamList where paperID=@paperID
		select @id=max(seq) from ref_studentExamList where paperID=@paperID
		--备份试题
		insert into ref_studentQuestionList(ID,questionID,refID,kindID,status,scorePer,score,answer,myAnswer,answerDate,memo,regDate,registerID,seq) select ID,questionID,refID,kindID,status,scorePer,score,answer,myAnswer,answerDate,memo,regDate,registerID,@id from studentQuestionList where refID=@paperID
		--更新试题对错记录
		--update studentQuestionUsed set myAnswer=b.myAnswer,status=(case when b.score>0 then 1 when b.score=0 and b.myAnswer is not null then 2 else studentQuestionUsed.status end) from studentQuestionList b where studentQuestionUsed.refID=b.refID and studentQuestionUsed.questionID=b.questionID and b.refID=@paperID
	end

	declare @refID int
	select @refID=refID from v_studentExamList where paperID=@paperID
	-- 将错误题目保存到错题库(答错或未答的)
	insert into studentQuestionWrong(enterID,questionID) select @refID,questionID from studentQuestionList where refID=@paperID and score=0 and questionID not in(select questionID from studentQuestionWrong where enterID=@refID)
	-- 将正确题目从错题库删除
	delete from studentQuestionWrong where enterID=@refID and questionID in(select questionID from studentQuestionList where refID=@paperID and score>0)
	-- 将错题的已用数量设置为1，使得这些错题在后续的试卷中优先抽取。
	update studentQuestionUsed set times=1 from studentQuestionUsed a, studentQuestionWrong b where a.refID=@paperID and b.enterID=@refID and a.questionID=b.questionID
	return 0
END

GO


-- =============================================
-- CREATE Date: 2020-05-13
-- Description:	向学员发送系统消息。
-- kindID: 0 回复 1 通知 2其他
-- Use Case:	exec sendSysMessage '1',...
-- =============================================
CREATE PROCEDURE [dbo].[sendSysMessage] 
	@username varchar(50),@kindID int,@item nvarchar(4000), @host varchar(50), @user varchar(50)
AS
BEGIN
	insert into studentMessageInfo(username,kindID,item,host,registerID) values(@username,@kindID,@item,@host,@user)
	return 0
END

GO

-- =============================================
-- CREATE Date: 2020-05-13
-- Description:	学员提交反馈。
-- Use Case:	exec submit_student_feedback '1',...
-- =============================================
ALTER PROCEDURE [dbo].[submit_student_feedback] 
	@username varchar(50),@mobile nvarchar(50),@email nvarchar(50),@item nvarchar(4000),@kindID int, @refID int,@host varchar(50)
AS
BEGIN
	insert into studentFeedbackInfo(username,mobile,email,kindID,item,refID,host,registerID) values(@username,@mobile,@email,@kindID,@item,@refID,@host,@username)
	return 0
END

GO

-- =============================================
-- CREATE Date: 2020-05-13
-- Description:	提交课堂交互信息。
-- Use Case:	exec submit_feedback_class '1',...
-- =============================================
ALTER PROCEDURE [dbo].[submit_feedback_class] 
	@username varchar(50),@item nvarchar(4000),@kindID int, @refID int,@classID varchar(50),@type int,@readerID varchar(50)
AS
BEGIN
	declare @title varchar(50),@readerName varchar(50)
	if @type=0
		select @title=name from studentInfo where username=@username
	else
		select @title=realName from userInfo where username=@username

	if @refID>0 --回复某个学生
		select @readerID=a.username from studentInfo a, studentFeedbackInfo b where a.username=b.username and b.ID=@refID

	insert into studentFeedbackInfo(username,kindID,item,refID,classID,type,readerID,title,registerID) values(@username,@kindID,@item,@refID,@classID,@type,@readerID,@title,@username)
	return 0
END

GO

-- =============================================
-- CREATE Date: 2020-05-13
-- Description:	学员消息阅读标记。
-- status:0 未读 1 已读 2 撤回  第一次设为已读时，填写阅读日期
-- Use Case:	exec setMessageReadStatus '1',...
-- =============================================
ALTER PROCEDURE [dbo].[setMessageReadStatus] 
	@ID int,@status int
AS
BEGIN
	update studentMessageInfo set status=@status, readDate=(case when @status=1 and readDate is null then getDate() else null end) where ID=@ID
	return 0
END

GO

-- =============================================
-- CREATE Date: 2020-05-13
-- Description:	给学员发送消息。
-- refID: studentFeedbackInfo.ID
-- Use Case:	exec addStudentMessage '310111',...
-- =============================================
CREATE PROCEDURE [dbo].[addStudentMessage] 
	@username varchar(50),@item nvarchar(4000),@kindID int,@emergency int, @refID int,@memo nvarchar(500),@host varchar(50),@registerID varchar(50)
AS
BEGIN
	insert into studentMessageInfo(username,item,refID,kindID,emergency,host,memo,registerID) values(@username,@item,@refID,@kindID,@emergency,@host,@memo,@registerID)
	return 0
END

GO

-- =============================================
-- CREATE DATE: 2020-05-14
-- 将学员反馈信息标记为已读
-- USE CASE: exec setStudentFeedbackRead 1, 'zzz'
-- =============================================
CREATE PROCEDURE [dbo].[setStudentFeedbackRead] 
	@ID int, @readerID varchar(50)
AS
BEGIN
	update studentFeedbackInfo set readerID=@readerID, readDate=getDate() where ID=@ID
END

GO

-- =============================================
-- CREATE DATE: 2020-05-14
-- 将学员反馈信息标记为已读
-- USE CASE: exec setStudentFeedbackDeal 1, '测试', 'albert'
-- =============================================
ALTER PROCEDURE [dbo].[setStudentFeedbackDeal] 
	@ID int, @memo nvarchar(4000), @dealerID varchar(50)
AS
BEGIN
	update studentFeedbackInfo set dealerID=@dealerID, dealDate=getDate(), memo=@memo, status=1 where ID=@ID
END

GO

-- =============================================
-- CREATE DATE: 2022-06-18
-- 撤销消息
-- USE CASE: exec cancelFeedbackInfo 1
-- =============================================
CREATE PROCEDURE [dbo].[cancelFeedbackInfo] 
	@ID int
AS
BEGIN
	delete from studentFeedbackInfo where ID=@ID
END

GO

-- CREATE DATE: 2020-05-16
-- 根据给定的参数，添加或者更新发给学员的消息
-- USE CASE: exec updateStudentMessageInfo 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[updateStudentMessageInfo]
	@ID int,@refID int,@item nvarchar(4000),@username varchar(50),@kindID int,@emergency int,@registerID varchar(50)
AS
BEGIN
	declare @host varchar(20)
	if @ID=0	-- 新纪录
	begin
		if @refID > 0	--回复学员反馈意见的消息
			select @username=username from studentFeedbackInfo where ID=@refID
		select @host = host from studentInfo where username=@username
		insert into studentMessageInfo(username,item,refID,kindID,emergency,host,registerID) values(@username,@item,@refID,@kindID,@emergency,@host,@registerID)
	end
	else
	begin
		update studentMessageInfo set kindID=@kindID,emergency=@emergency,username=@username,item=@item where ID=@ID
	end
END

-- =============================================
-- CREATE DATE: 2020-05-16
-- 撤回发给学员的消息
-- USE CASE: exec doCancelStudentMessage 1, '测试', 'albert'
-- =============================================
ALTER PROCEDURE [dbo].[doCancelStudentMessage] 
	@ID int
AS
BEGIN
	update studentMessageInfo set status=2 where ID=@ID
END

GO

-- =============================================
-- CREATE DATE: 2020-05-16
-- 管理员修改学员备注
-- USE CASE: exec setStudentMemo 1, '测试', 'albert'
-- =============================================
CREATE PROCEDURE [dbo].[setStudentMemo] 
	@ID int, @memo nvarchar(500)
AS
BEGIN
	update studentInfo set memo=@memo where userID=@ID
END

GO

-- =============================================
-- CREATE DATE: 2020-05-16
-- 管理员修改学员状态
-- USE CASE: exec setStudentStatus 1, '测试', 'albert'
-- =============================================
ALTER PROCEDURE [dbo].[setStudentStatus] 
	@username varchar(50), @status int, @registerID varchar(50)
AS
BEGIN
	update studentInfo set user_status=@status where username=@username
	-- 写操作日志
	exec writeOpLog '','修改学员状态','setStudentStatus',@registerID,'',@username
END

GO

-- =============================================
-- CREATE DATE: 2022-09-06
-- 重置学员密码
-- USE CASE: exec resetStudentPwd 1, 'albert.'
-- =============================================
ALTER PROCEDURE [dbo].[resetStudentPwd] 
	@username varchar(50), @registerID varchar(50)
AS
BEGIN
	declare @pwd varchar(50)
	select @pwd = item from dictionaryDoc where kind='studentPasswd' and ID='0'
	select @pwd=iif(host='spc','Sh123456',@pwd) from studentInfo where username=@username
	update studentInfo set password=@pwd where username=@username
	-- 写操作日志
	exec writeOpLog '','重置密码','resetStudentPwd',@registerID,@pwd,@username
	select @pwd as re
END
GO

-- =============================================
-- CREATE DATE: 2020-05-16
-- 管理员修改学员课程备注
-- USE CASE: exec setStudentCourseMemo 1, '测试', 'albert'
-- =============================================
CREATE PROCEDURE [dbo].[setStudentCourseMemo] 
	@ID int, @memo nvarchar(500)
AS
BEGIN
	update studentCourseList set memo=@memo where ID=@ID
END

-- =============================================
-- CREATE DATE: 2020-05-16
-- 管理员修改证书备注
-- USE CASE: exec setDiplomaMemo 1, '测试'
-- =============================================
CREATE PROCEDURE [dbo].[setDiplomaMemo] 
	@ID int, @memo nvarchar(500)
AS
BEGIN
	update diplomaInfo set memo=@memo where ID=@ID
END
GO

-- =============================================
-- CREATE DATE: 2020-05-16
-- 管理员修改证书生成记录备注
-- USE CASE: exec setGenerateDiplomaMemo 1, '测试'
-- =============================================
CREATE PROCEDURE [dbo].[setGenerateDiplomaMemo] 
	@ID int, @memo nvarchar(500)
AS
BEGIN
	update generateDiplomaInfo set memo=@memo where ID=@ID
END
GO

-- =============================================
-- CREATE DATE: 2020-05-16
-- 管理员修改待生成证书记录备注
-- USE CASE: exec setNeedDiplomaMemo 1, '测试'
-- =============================================
CREATE PROCEDURE [dbo].[setNeedDiplomaMemo] 
	@ID int, @memo nvarchar(500)
AS
BEGIN
	update studentCertList set memo=@memo where ID=@ID
END
GO

-- =============================================
-- CREATE DATE: 2020-05-16
-- 管理员取消/恢复待生成证书资格
-- @kindID: 0 取消  1 恢复
-- USE CASE: exec setNeedDiplomaCancel 1, '测试', 0
-- =============================================
ALTER PROCEDURE [dbo].[setNeedDiplomaCancel] 
	@ID int, @memo nvarchar(500), @k int, @user varchar(50)
AS
BEGIN
	declare @username varchar(50),@kindID int,@item nvarchar(4000), @host varchar(50)
	if @k=0
	begin
		update studentCertList set memo=@memo, diplomaID='*' where ID=@ID
		--send message to the student
		select @username=username,@kindID=1,@host=host,@item='你的证书[' + certName + ']申请暂时被拒绝，原因[' + @memo + ']' from v_studentCertList where ID=@ID
		exec sendSysMessage @username, @kindID, @item, @host, @user
	end
	if @k=1
	begin
		update studentCertList set diplomaID='' where ID=@ID
	end
END
GO

-- =============================================
-- CREATE DATE: 2020-05-16
-- 管理员修改导入学员报名表备注
-- USE CASE: exec setGenerateStudentMemo 1, '测试'
-- =============================================
CREATE PROCEDURE [dbo].[setGenerateStudentMemo] 
	@ID int, @memo nvarchar(500)
AS
BEGIN
	update generateStudentInfo set memo=@memo where ID=@ID
END
GO

-- =============================================
-- CREATE DATE: 2020-05-16
-- 管理员修改导入学员报名表备注
-- USE CASE: exec setGenerateMaterialMemo 1, '测试'
-- =============================================
CREATE PROCEDURE [dbo].[setGenerateMaterialMemo] 
	@ID int, @memo nvarchar(500)
AS
BEGIN
	update generateMaterialInfo set memo=@memo where ID=@ID
END
GO

-- CREATE DATE: 2020-05-16
-- 根据给定的参数，添加或者更新认证项目
-- USE CASE: exec updateCertificateInfo 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[updateCertificateInfo]
	@ID int,@certID varchar(50),@certName nvarchar(100),@shortName nvarchar(100),@term int,@termExt int,@agencyID int,@kindID int,@status int,@type int,@mark int,@days_study int,@days_exam int,@days_diploma int,@days_archive int,@host varchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	if @ID=0	-- 新纪录
	begin
		insert into certificateInfo(certID,certName,shortName,nickName,term,termExt,kindID,status,type,mark,agencyID,days_study,days_exam,days_diploma,days_archive,host,memo,registerID) values(@certID,@certName,@shortName,@shortName,@term,@termExt,@kindID,@status,@type,@mark,@agencyID,@days_study,@days_exam,@days_diploma,@days_archive,@host,@memo,@registerID)
	end
	else
	begin
		update certificateInfo set kindID=@kindID,agencyID=@agencyID,term=@term,termExt=@termExt,certName=@certName,shortName=@shortName,status=@status,type=@type,days_study=@days_study,days_exam=@days_exam,days_diploma=@days_diploma,days_archive=@days_archive,mark=@mark,host=@host,memo=@memo where ID=@ID
	end
END
GO

-- CREATE DATE: 2020-05-24
-- 根据给定的参数，添加或者更新课程
-- USE CASE: exec updateCourseInfo 1,1,'xxxx'...").value + "|" + rs("").value + "|" + rs("").value + "|" + rs("
ALTER PROCEDURE [dbo].[updateCourseInfo]
	@ID int,@courseID varchar(50),@courseName nvarchar(100),@shortName nvarchar(50),@hours int,@completionPass int,@deadline int,@deadday int,@period int,@kindID int,@reexamine int,@status int,@mark int,@certID varchar(50),@price int,@host varchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	if @shortName = ''
		set @shortName = @courseName
	if @ID=0	-- 新纪录
	begin
		insert into courseInfo(courseID,courseName,shortName,hours,completionPass,deadline,deadday,period,kindID,reexamine,status,mark,certID,price,host,memo,registerID) values(@courseID,@courseName,@shortName,@hours,@completionPass,@deadline,@deadday,@period,@kindID,@reexamine,@status,@mark,@certID,@price,@host,@memo,@registerID)
	end
	else
	begin
		update courseInfo set kindID=@kindID,shortName=@shortName,reexamine=@reexamine,courseID=@courseID,hours=@hours,completionPass=@completionPass,deadline=@deadline,deadday=@deadday,period=@period,courseName=@courseName,mark=@mark,status=@status,certID=@certID,price=@price,host=@host,memo=@memo where ID=@ID
	end
END
GO

-- CREATE DATE: 2020-05-24
-- 根据给定的参数，添加或者更新课表
-- USE CASE: exec updateLessonInfo 1,1,'xxxx'...
CREATE PROCEDURE [dbo].[updateLessonInfo]
	@ID int,@lessonID varchar(50),@lessonName nvarchar(100),@hours int,@courseID varchar(50),@seq int,@kindID int,@status int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @host varchar(20)
	if @ID=0	-- 新纪录
	begin
		insert into lessonInfo(lessonID,lessonName,hours,courseID,seq,kindID,status,memo,registerID) values(@lessonID,@lessonName,@hours,@courseID,@seq,@kindID,@status,@memo,@registerID)
	end
	else
	begin
		update lessonInfo set kindID=@kindID,lessonID=@lessonID,hours=@hours,lessonName=@lessonName,status=@status,courseID=@courseID,seq=@seq,memo=@memo where ID=@ID
	end
END
GO

-- CREATE DATE: 2020-05-24
-- 根据给定的参数，添加或者更新视频
-- USE CASE: exec updateVideoInfo 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[updateVideoInfo]
	@ID int,@videoID varchar(50),@videoName nvarchar(100),@minutes float,@proportion int,@type varchar(50),@author varchar(50),@lessonID varchar(50),@kindID int,@status int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @host varchar(20)
	if @ID=0	-- 新纪录
	begin
		insert into videoInfo(VideoID,videoName,minutes,lessonID,proportion,type,author,kindID,status,memo,registerID) values(@videoID,@videoName,@minutes,@lessonID,@proportion,@type,@author,@kindID,@status,@memo,@registerID)
	end
	else
	begin
		update videoInfo set kindID=@kindID,videoID=@videoID,minutes=@minutes,videoName=@videoName,status=@status,lessonID=@lessonID,proportion=@proportion,type=@type,author=@author,memo=@memo where ID=@ID
	end
END
GO

-- CREATE DATE: 2020-05-24
-- 根据给定的参数，添加或者更新课件
-- USE CASE: exec updateCoursewareInfo 1,1,'xxxx'...
CREATE PROCEDURE [dbo].[updateCoursewareInfo]
	@ID int,@coursewareID varchar(50),@coursewareName nvarchar(100),@pages int,@proportion int,@type varchar(50),@author varchar(50),@lessonID varchar(50),@kindID int,@status int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @host varchar(20)
	if @ID=0	-- 新纪录
	begin
		insert into coursewareInfo(coursewareID,coursewareName,pages,lessonID,proportion,type,author,kindID,status,memo,registerID) values(@coursewareID,@coursewareName,@pages,@lessonID,@proportion,@type,@author,@kindID,@status,@memo,@registerID)
	end
	else
	begin
		update coursewareInfo set kindID=@kindID,coursewareID=@coursewareID,pages=@pages,coursewareName=@coursewareName,status=@status,lessonID=@lessonID,proportion=@proportion,type=@type,author=@author,memo=@memo where ID=@ID
	end
END

-- CREATE DATE: 2020-05-24
-- 根据给定的参数，添加或者更新知识点
-- USE CASE: exec updateKnowPointInfo 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[updateKnowPointInfo]
	@ID int,@knowpointID varchar(50),@knowpointName nvarchar(100),@courseID varchar(50),@status int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @host varchar(20)
	if @ID=0 and not exists(select 1 from knowpointInfo where knowpointID=@knowpointID)	-- 新纪录
	begin
		insert into knowpointInfo(knowpointID,knowpointName,courseID,status,memo,registerID) values(@knowpointID,@knowpointName,@courseID,@status,@memo,@registerID)
	end
	else
	begin
		update knowpointInfo set knowpointID=@knowpointID,knowpointName=@knowpointName,status=@status,courseID=@courseID,memo=@memo where ID=@ID
	end
END

-- CREATE DATE: 2020-05-24
-- 根据给定的参数，添加或者更新题目
-- USE CASE: exec updateQuestionInfo 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[updateQuestionInfo]
	@ID int,@questionID varchar(50),@questionName nvarchar(2000),@knowPointID varchar(50),@answer varchar(50),@A nvarchar(200),@B nvarchar(200),@C nvarchar(200),@D nvarchar(200),@E nvarchar(200),@F nvarchar(200),@kindID int,@status int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @host varchar(20)
	if @ID=0 and not exists(select 1 from questionInfo where questionID=@questionID)	-- 新纪录
	begin
		insert into questionInfo(questionID,questionName,knowPointID,answer,A,B,C,D,E,F,kindID,status,memo,registerID) values(@questionID,@questionName,@knowPointID,replace(@answer,' ',''),@A,@B,@C,@D,@E,@F,@kindID,@status,@memo,@registerID)
	end
	else
	begin
		update questionInfo set questionID=@questionID,questionName=@questionName,knowPointID=@knowPointID,answer=replace(@answer,' ',''),A=@A,B=@B,C=@C,D=@D,E=@E,F=@F,status=@status,kindID=@kindID,memo=@memo where ID=@ID
	end
	exec writeOpLog '','更新题目','updateQuestion',@registerID,@questionName,@questionID
END
GO


-- CREATE DATE: 2020-05-24
-- 根据给定的参数，添加或者更新单位信息
-- USE CASE: exec updateHostInfo 1,1,'xxxx'...
CREATE PROCEDURE [dbo].[updateHostInfo]
	@hostID int,@hostNo  nvarchar(50),@hostName nvarchar(100),@title nvarchar(100),@kindID int,@status int,@linker  nvarchar(50),@phone nvarchar(50),@email nvarchar(50),@address nvarchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	if @hostID=0	-- 新纪录
	begin
		insert into hostInfo(hostNo,hostName,title,kindID,status,linker,phone,email,address,memo,registerID) values(@hostNo,@hostName,@title,@kindID,@status,@linker,@phone,@email,@address,@memo,@registerID)
		--初始化数据
		exec initialHost @hostNo
	end
	else
	begin
		update hostInfo set hostNo=@hostNo,kindID=@kindID,hostName=@hostName,title=@title,status=@status,linker=@linker,phone=@phone,email=@email,address=@address,memo=@memo where hostID=@hostID
	end
END
GO

-- CREATE DATE: 2020-05-24
-- 根据给定的参数，添加或者更新认证机构信息
-- USE CASE: exec updateAgencyInfo 1,1,'xxxx'...
CREATE PROCEDURE [dbo].[updateAgencyInfo]
	@ID int,@agencyID  nvarchar(50),@agencyName nvarchar(100),@title nvarchar(100),@kindID int,@status int,@linker  nvarchar(50),@phone nvarchar(50),@email nvarchar(50),@address nvarchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	if @agencyID=0 and not exists(select 1 from agencyInfo where agencyID=@agencyID)	-- 新纪录
	begin
		insert into agencyInfo(agencyID,agencyName,title,kindID,status,linker,phone,email,address,memo,registerID) values(@agencyID,@agencyName,@title,@kindID,@status,@linker,@phone,@email,@address,@memo,@registerID)
	end
	else
	begin
		update agencyInfo set agencyID=@agencyID,kindID=@kindID,agencyName=@agencyName,title=@title,status=@status,linker=@linker,phone=@phone,email=@email,address=@address,memo=@memo where ID=@ID
	end
END
GO


-- =============================================
-- CREATE Date: 2020-05-21
-- Description:	初始化新的公司。
-- Use Case:	exec initialHost 
-- =============================================
ALTER PROCEDURE [dbo].[initialHost] 
	@host varchar(50)
--with encryption
AS
BEGIN
	declare @passwd varchar(50), @id int,@k int
	select @passwd = memo,@k=0 from dictionaryDoc where kind='userPasswd' and ID=0
	if @host = ''
		set @k = 1

--0.创建初始用户
	--清除原有数据
	delete from userInfo where host=@host
	--导入新数据
	insert into userInfo(userNo,userName,password,realName,kindID,limitedDate,memo,host,registerID) select userNo,userNo + '.' + @host,@passwd,realName,kindID,'2037-09-20',memo,@host,registerID from userInfo_model where status=0 and owner=@k
--1.标准字典数据
	--清除原有数据
	delete from hostDict where host=@host and mark=1
	--导入新数据
	insert into hostDict(item,kind,description,memo,host,registerID) select item,ID,description,memo,@host,'admin.' from dictionaryDoc where kind='hostDict' and status=0
--2.标准角色权限数据
	--清除原有数据
	delete from roleInfo where host=@host
	delete from rolePermissionList where host=@host
	delete from roleUserList where host=@host
	delete from permissionInfo where host=@host
	--导入新数据
	if @host = ''
	begin
		insert into roleInfo(roleID,roleName,description,host,registerID) select roleID,roleName,description,@host,registerID from roleInfo_model where status=0
		insert into rolePermissionList(roleID,permissionID,host,registerID) select roleID,permissionID,@host,registerID from rolePermissionList_model where status=0
		insert into roleUserList(roleID,userName,scopeID,host,registerID) select roleID,userID + '.' + @host,scopeID,@host,registerID from roleUserList_model where status=0
		insert into permissionInfo(permissionID,permissionName,description,host,registerID) select permissionID,permissionName,description,@host,registerID from permissionInfo_model where status=0
	end
	else
	begin
		insert into roleInfo(roleID,roleName,description,host,registerID) select roleID,roleName,description,@host,registerID from roleInfo_model where owner=0 and status=0
		insert into rolePermissionList(roleID,permissionID,host,registerID) select roleID,permissionID,@host,registerID from rolePermissionList_model where owner=0 and status=0
		insert into roleUserList(roleID,userName,scopeID,host,registerID) select roleID,userID + '.' + @host,scopeID,@host,registerID from roleUserList_model where owner=0 and status=0
		insert into permissionInfo(permissionID,permissionName,description,host,registerID) select permissionID,permissionName,description,@host,registerID from permissionInfo_model where owner=0 and status=0
	end
--3.自动编号数据
--4.标准岗位数据
--5.标准工艺数据
--6.创建公司信息
	--清除原有数据
	delete from deptInfo where host=@host
	--导入新数据
	insert into deptInfo(pID,deptName,linker,phone,email,host,registerID) select 0,hostName,linker,phone,email,@host,registerID from hostInfo where hostNo=@host
	--标准部门数据
	select @id=max(deptID) from deptInfo where host=@host
	insert into deptInfo(pID,deptName,host,registerID) select @id,deptName,@host,registerID from deptInfo_model where dept_status=0
END
GO

-- CREATE DATE: 2017-07-07
-- 根据给定的参数，添加或者更新用户数据，并写日志
-- USE CASE: exec updateUserInfo 1,'xxxx'...
ALTER PROCEDURE [dbo].[updateUserInfo]
	@userID int,@userNo varchar(50),@realName varchar(50),@status int,@deptID varchar(50),@phone varchar(50),@email varchar(50),@limitedDate varchar(50),@host varchar(50),@memo nvarchar(500),@registerID varchar(50)
WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @logMemo varchar(500),@event varchar(50)
	declare @passwd varchar(50)
	select @passwd = memo from dictionaryDoc where kind='userPasswd' and ID=0
	set @logMemo = ''
	if @limitedDate='' set @limitedDate=null
	if @deptID='' or @deptID='null' set @deptID=0

	if @userID=0	-- 新纪录
	begin
		insert into userInfo(host,userNo,userName,realName,password,deptID,phone,email,limitedDate,memo,registerID) 
			values(@host,@userNo,@userNo+'.'+@host,@realName,@passwd,@deptID,@phone,@email,@limitedDate,@memo,@registerID)
		select @userID=max(userID) from userInfo where registerID=@registerID
		select @event = '新增'
		exec writeEventTrace @host,@registerID,'user',@userID,0,'登记',@userNo
	end
	else
	begin
		update userInfo set status=@status,realName=@realName,deptID=@deptID,phone=@phone,email=@email,limitedDate=@limitedDate,memo=@memo where userID=@userID
		select @event = '修改'
	end
	-- 写操作日志
	exec writeOpLog @host,@event,'user',@registerID,@userNo,@userID
END
GO

-- CREATE DATE: 2015-01-12
-- 根据给定的参数，删除用户数据，并写日志
-- USE CASE: exec delUserInfo 1
ALTER PROCEDURE [dbo].[delUserInfo]
	@ID int,@registerID varchar(50)
AS
BEGIN
	DECLARE @logMemo varchar(500),@event varchar(50),@userName varchar(50),@host varchar(50),@userNo varchar(50)
	select @logMemo = '',@userName = username,@host=host,@userNo=userNo from userInfo where userID=@ID
	if exists(select 1 from userInfo where userID=@ID)
	begin
		delete from roleUserList where userName=@userName
		delete from userPermissionList where userName=@userName
		update userInfo set status=9 where userID=@ID
		-- 写操作日志
		exec writeOpLog @host,'删除用户','user',@registerID,@userNo,@ID
	end
END
GO

-- CREATE DATE: 2015-01-12
-- 根据给定的参数，重置用户密码，并写日志
-- USE CASE: exec resetUserPasswd 1
CREATE PROCEDURE [dbo].[resetUserPasswd]
	@ID int,@registerID varchar(50)
AS
BEGIN
	DECLARE @logMemo varchar(500),@event varchar(50),@userName varchar(50),@host varchar(50),@userNo varchar(50),@passwd varchar(50)
	select @logMemo = '',@userName = username,@host=host,@userNo=userNo from userInfo where userID=@ID
	select @passwd = memo from dictionaryDoc where kind='userPasswd' and ID=0
	if exists(select 1 from userInfo where userID=@ID)
	begin
		update userInfo set [password]=@passwd where userID=@ID
		-- 写操作日志
		exec writeOpLog @host,'密码重置','user',@registerID,@userNo,@ID
	end
END
GO


-- CREATE DATE: 2020-05-24
-- 根据给定的参数，添加或者更新部门信息
-- USE CASE: exec updateDeptInfo 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[updateDeptInfo]
	@deptID int,@pID int,@deptName nvarchar(100),@kindID int,@status int,@linker  nvarchar(50),@phone nvarchar(50),@email nvarchar(50),@address nvarchar(50),@No varchar(50),@area varchar(50),@c555 int,@title nvarchar(500),@accountKind int,@payNow int,@host varchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	if @deptID=0	-- 新纪录
	begin
		insert into deptInfo(pID,deptName,kindID,dept_status,linker,phone,email,address,No,area,c555,title,accountKind,payNow,host,memo,registerID) values(@pID,@deptName,@kindID,@status,@linker,@phone,@email,@address,@No,@area,@c555,@title,@accountKind,@payNow,@host,@memo,@registerID)
	end
	else
	begin
		update deptInfo set pID=@pID,kindID=@kindID,deptName=@deptName,dept_status=@status,title=@title,accountKind=@accountKind,payNow=@payNow,linker=@linker,phone=@phone,email=@email,address=@address,No=@No,area=@area,c555=@c555,memo=@memo where deptID=@deptID
	end
END
GO

-- CREATE DATE: 2015-01-12
-- 根据给定的参数，删除部门数据，并写日志
-- USE CASE: exec delDeptInfo 1
CREATE PROCEDURE [dbo].[delDeptInfo]
	@ID int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @host varchar(50)
	if exists(select 1 from deptInfo where deptID=@ID)
	begin
		select @host=host from deptInfo where deptID=@ID
		update deptInfo set dept_status=9 where deptID=@ID
		-- 写操作日志
		exec writeOpLog @host,'删除部门','dept',@registerID,@memo,@ID
	end
END


-- CREATE DATE: 2020-05-24
-- 根据给定的参数，添加或者更新导入学员报名表信息
-- USE CASE: exec updateGenerateStudentInfo 1,1,'xxxx'...
CREATE PROCEDURE [dbo].[updateGenerateStudentInfo]
	@ID int,@item nvarchar(100),@qty int,@host varchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	if @ID=0	-- 新纪录
	begin
		insert into generateStudentInfo(item,qty,host,memo,registerID) values(@item,@qty,@host,@memo,@registerID)
	end
	else
	begin
		update generateStudentInfo set item=@item,qty=@qty,host=@host,memo=@memo where ID=@ID
	end
END
GO


-- CREATE DATE: 2015-01-12
-- 根据给定的参数，删除学员报名单数据，并写日志
-- USE CASE: exec delGenerateStudentInfo 1
CREATE PROCEDURE [dbo].[delGenerateStudentInfo]
	@ID int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @host varchar(50)
	if exists(select 1 from generateStudentInfo where ID=@ID)
	begin
		select @host=host from generateStudentInfo where ID=@ID
		delete from generateStudentInfo where ID=@ID
		-- 写操作日志
		exec writeOpLog @host,'删除上传报名表','generatestudent',@registerID,@memo,@ID
	end
END


-- CREATE DATE: 2020-05-24
-- 根据给定的参数，添加或者更新导入学员成绩表信息
-- USE CASE: exec updateGenerateScoreInfo 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[updateGenerateScoreInfo]
	@ID int,@item nvarchar(100),@certID varchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	if @ID=0	-- 新纪录
	begin
		insert into generateScoreInfo(item,certID,memo,registerID) values(@item,@certID,@memo,@registerID)
	end
	else
	begin
		update generateScoreInfo set item=@item,certID=@certID,memo=@memo where ID=@ID
	end
END
GO

-- CREATE DATE: 2015-01-12
-- 根据给定的参数，删除学员成绩单数据，并写日志
-- USE CASE: exec delGenerateScoreInfo 1
CREATE PROCEDURE [dbo].[delGenerateScoreInfo]
	@ID int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @host varchar(50)
	if exists(select 1 from generateScoreInfo where ID=@ID)
	begin
		select @host=host from generateScoreInfo where ID=@ID
		delete from generateScoreInfo where ID=@ID
		-- 写操作日志
		exec writeOpLog @host,'删除上传成绩单','generateScore',@registerID,@memo,@ID
	end
END
GO

-- CREATE Date: 2017-05-13
-- 根据给定的标识，调用相关算法自动生成编号。编码规则：公司 + 标识 + 2位年号 + n位序号。格式：SPCC1-20-00003
-- 生成的代码写入到表中供查询使用。
-- USE CASE: exec setAutoCode 'spc','C1',@re
ALTER PROCEDURE [dbo].[setAutoCode] 
	@host varchar(50),@kind varchar(50), @re varchar(50) output, @serial int output
--WITH ENCRYPTION
AS
BEGIN
	DECLARE @result varchar(50),@useYear int,@thisYear varchar(50),@lastYear varchar(50),@lastNo varchar(20),@n int,@split varchar(50),@long int,@mark varchar(50),@kind0 varchar(50)
	select @kind0=@kind
	if @kind='CLSC26'	--制冷的两个项目合并序号
		select @kind='CLSC25'
	if @kind='CLSC31'	--动火作业的两个项目合并序号
		select @kind='CLSC30'
	if @kind='CLSC19'	--消防管理的两个项目合并序号
		select @kind='CLSC18'

	select @result = '', @thisYear =  convert(varchar(4),getDate(),112),@serial=0,@long=(case when left(@kind,3)='CLS' then 2 else 5 end),@mark=(case when left(@kind,3)='CLS' then right(@kind,len(@kind)-3)+'-' else @kind end),@split=(case when left(@kind,3)='CLS' then '' else '-' end)
	if not exists(select 1 from autoCode where kind=@kind and host=@host)
		insert into autoCode(kind,mark,long,split,host) values(@kind,@mark,@long,@split,@host)

	-- 检查是否有本年度标识，如果没有则添加并将计数器置零
	select @lastYear = isnull(lastYear,''),@split=isnull(split,''),@useYear=useYear from autoCode where kind=@kind and host=@host
	if @useYear=0 and @lastYear <> @thisYear
		update autoCode set lastYear = @thisYear, lastNo = 0, lastCode = '' where kind=@kind and host=@host
	select @result = upper(@host + isnull((case when @kind0='CLSC26' then 'C26-' when @kind0='CLSC31' then 'C31-' when @kind0='CLSC19' then 'C19-' else mark end),'')) + @split + (case when @useYear=0 then right(lastYear,2) else '' end), @lastNo=cast(lastNo+1 as varchar), @n=long,@serial=serial+1 from autoCode where kind=@kind and host=@host
	update autoCode set lastNo = lastNo + 1, lastCode = @result, serial=serial+1 where kind=@kind and host=@host
	if @n>0
		set @result = @result + @split + isnull(replicate('0',@n-len(@lastNo)),'') + @lastNo
	else
		set @result = @result + @split + @lastNo

	select @re = @result
END

GO

-- =============================================
-- CREATE Date: 2020-05-10
-- Description:	根据给定的证书项目编号，为符合要求的学员生成企业内部证书。
-- @batchID: 0 new  >0 rebuild(do nothing)
-- @selList: 发放名单，用逗号分隔的ID in studentCertList
-- @selList1: 盖章名单，用逗号分隔的ID in studentCertList
-- Use Case:	exec generateDiplomaByCertID 'C5','spc','admin.'
-- =============================================
ALTER PROCEDURE [dbo].[generateDiplomaByCertID] 
	@certID varchar(50), @batchID int, @selList varchar(4000), @selList1 varchar(4000), @host varchar(50), @registerID varchar(50)
AS
BEGIN
	declare @ID int, @code varchar(50), @term int, @firstID varchar(50), @lastID varchar(50), @i int, @re int, @kindID int, @termExt int, @t int, @stamp int, @serial int
	select @term = term,@termExt=termExt,@i=0,@firstID='',@lastID='',@re=@batchID from certificateInfo where certID=@certID
	create table #temp(id int)
	create table #temp1(id int)
	declare @n int, @j int
	--提取盖章名单
	select @n=dbo.pf_getStrArrayLength(@selList1,','), @j=0
	while @n>@j
	begin
		insert into #temp1 values(dbo.pf_getStrArrayOfIndex(@selList1,',',@j))
		select @j = @j + 1
	end

	--新生成
	if @batchID=0 and exists(select ID from v_studentCertList where certID=@certID and host=@host and type=1 and result=1 and diplomaID='')
	begin
		--填写生成记录
		insert into generateDiplomaInfo(certID,host,registerID) select @certID,@host,@registerID
		select @re=max(ID) from generateDiplomaInfo where registerID=@registerID and certID=@certID and host=@host

		--生成证书
		--declare rc cursor for select ID,student_kindID from v_studentCertList where certID=@certID and host=@host and type=1 and result=1 and diplomaID='' order by dept1,name
		--提取发放名单
		select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
		while @n>@j
		begin
			insert into #temp values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
			select @j = @j + 1
		end

		declare rc cursor for select a.ID,student_kindID,(case when c.id>0 then 1 else 0 end) as stamp from #temp b INNER JOIN  v_studentCertList a ON a.ID=b.ID LEFT OUTER JOIN #temp1 c ON b.id=c.id order by dept1,name
		open rc
		fetch next from rc into @ID,@kindID,@stamp
		While @@fetch_status=0 
		Begin 
			select @i = @i + 1, @t=(case when @kindID=1 then @termExt else @term end)	--系统外期限不同
			exec setAutoCode @host,@certID,@code output, @serial output		--获取证书编号
			update studentCertList set diplomaID=@code where ID=@ID
			--生成证书，证书发放日期为结业日期
			insert into diplomaInfo(diplomaID,username,certID,batchID,refID,score,term,startDate,endDate,filename,stamp,host,registerID) select @code,username,certID,@re,@ID,examScore,@t,closeDate,dateadd(yy,@t,closeDate),'/upload/students/diplomas/' + @code + '.pdf',@stamp,@host,@registerID from studentCertList where ID=@ID
			if @i = 1
				set @firstID = @code
			set @lastID = @code
			fetch next from rc into @ID,@kindID,@stamp
		End
		Close rc 
		Deallocate rc
		drop table #temp
		--更新生成记录
		if @i>0
		begin
			update generateDiplomaInfo set qty=@i, firstID=@firstID,lastID=@lastID,filename='/upload/students/diplomaPublish/' + cast(@re as varchar) + '.pdf' where ID=@re
		end
	end
	-- 重新生成，证书编号不变，内容更新。
	if @batchID>0	
	begin
		--生成证书
		declare rc cursor for select a.ID,b.kindID,(case when c.id>0 then 1 else 0 end) as stamp from diplomaInfo a INNER JOIN studentInfo b on a.username=b.username LEFT OUTER JOIN #temp1 c on a.ID=c.id where a.certID=@certID and a.batchID=@batchID
		open rc
		fetch next from rc into @ID,@kindID,@j
		While @@fetch_status=0 
		Begin 
			select @i = @i + 1, @t=(case when @kindID=1 then @termExt else @term end)	--系统外期限不同
			--更新证书期限数据
			update diplomaInfo set term=@t,endDate=dateadd(yy,@t,startDate),stamp=@j where ID=@ID
			fetch next from rc into @ID,@kindID,@j
		End
		Close rc 
		Deallocate rc
	end
	return @re
END
GO

-- =============================================
-- CREATE Date: 2025-04-02
-- Description:	根据给定的身份证列表，为其所属的有效证书重新生成证书，以更新内容（一般是单位变更）。
-- @selList: 名单，用逗号分隔的username
-- Use Case:	exec generate_diploma_byUsername '...','admin.'
-- =============================================
ALTER PROCEDURE [dbo].[generate_diploma_byUsername] 
	@selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	--创建临时表
	create table #temp(id varchar(50))
	declare @n int, @j int
	select @selList=replace(replace(@selList,' ',''),'，',',')
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	exec writeOpLog '','重做证书','generate_diploma_byUsername',@registerID,'',@selList

	select a.* from v_diplomaInfo a, #temp b where a.username=b.ID and a.type=1 and a.status=0

	drop table #temp
END
GO

-- =============================================
-- CREATE Date: 2020-10-02
-- Description:	根据给定的证书项目编号，填写发放证书记录。
-- @selList: 发放名单，用逗号分隔的ID in studentCertList
-- @type: 发放方式  issueType
-- Use Case:	exec issueDiploma '...','spc','admin.'
-- =============================================
CREATE PROCEDURE [dbo].[issueDiploma] 
	@selList varchar(4000), @type int, @host varchar(50), @registerID varchar(50)
AS
BEGIN
	--为发放清单创建临时表
	create table #temp(id int)
	declare @n int, @j int, @re int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0, @re=0
	while @n>@j
	begin
		insert into #temp values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	--根据发放清单更新证书属性
	update diplomaInfo set issued=1, issueDate=getDate(), issueType=@type, issuer=@registerID from #temp a where diplomaInfo.ID=a.id

	--填写发放记录
	insert into issueDiplomaInfo(qty,IDList,issueType,host,registerID) select @n,@selList,@type,@host,@registerID

	drop table #temp

	select @re = max(id) from issueDiplomaInfo where registerID=@registerID
	return @re
END
GO

-- CREATE DATE: 2020-05-24
-- 根据给定的参数，添加或者更新导入学员报名信息（仅智能消防学校）. dept2Name有值的（加油站），判定为中石化员工
-- USE CASE: exec generateStudent 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[generateStudent]
	@username varchar(50),@name nvarchar(50),@dept1Name nvarchar(100),@tax varchar(50),@dept2Name nvarchar(100),@job varchar(50),@mobile nvarchar(50),@address nvarchar(50),@education nvarchar(50),@currDiplomaDate nvarchar(50),@memo nvarchar(500),@classID varchar(50),@oldNo varchar(50),@registerID varchar(50)

AS
BEGIN
	declare @password varchar(50),@kindID int,@companyID varchar(50),@dept1 varchar(50),@dept2 varchar(50),@fromID varchar(50),@price int,@unit varchar(100),@educationID int,@certID varchar(50),@courseID varchar(50),@projectID varchar(50),@host varchar(50),@err int,@exist int,@existOther int,@null int,@Tai int,@msg varchar(50)
	declare @retireDay int, @enterID int, @refID int
	select @dept1=0, @dept2=0, @unit=null, @educationID=0,@err=0,@exist=0,@existOther=0,@null=0,@oldNo=(case when @oldNo>0 then @oldNo else 0 end),@Tai=charindex('台',@username),@host='znxf',@username = upper(@username), @tax= UPPER(replace(dbo.whenull(@tax,''),' ','')), @address=REPLACE(dbo.whenull(@address,''),' ','')
	select @password = item,@kindID=0 from dictionaryDoc where kind='studentPasswd'
	select @educationID=ID from dictionaryDoc where kind='education' and item=@education
	if @currDiplomaDate='' or @currDiplomaDate='null' or @currDiplomaDate='undefined' set @currDiplomaDate=''
	select @classID=classID,@host=isnull(host,''),@certID=certID,@courseID=courseID,@projectID=dbo.pf_getStrArrayOfIndex(projectID,',',0) from classInfo where ID=@classID
	if @host=''
		select @host=host from projectInfo where projectID=@projectID
	if exists(select 1 from userInfo where realName=@memo)
		select @fromID=username,@memo=null from userInfo where realName=@memo
	else
		select @fromID=null
	select @companyID = deptID, @dept1=null from deptInfo where host=@host and pID=0
	select @host=iif(@dept2Name>'','spc',@host)

	if @host<>'spc' and @host<>'shm'
		select @unit=@dept1Name,@companyID=deptID from deptInfo where host='znxf' and pID=0	--合作单位或消防学校
	else
	begin
		if @dept1Name > ''
			select @dept1 = deptID from deptInfo where host=@host and deptName=@dept1Name
		if @dept2Name > ''
			select @dept2 = deptID from deptInfo where host=@host and deptName=@dept2Name
	end

	if exists(select 1 where [dbo].[fn_validateIDCard](@username)=0) and @Tai=0
	begin
		if @username = ''
			select @null = 1
		else
			select @err=1	-- 身份证错误
	end
	else
	begin
		-- 注册学员
		if not exists(select 1 from studentInfo where username=@username)	-- 新纪录
		begin
			if @tax>''
				select @unit=unitName, @address=address,@host=host from unitInfo where taxNo=@tax
			else if @unit>''
				select @tax=taxNo, @address=address,@host=host from unitInfo where unitName=@unit
			else if @host='shm'
				select @unit=a.unitName,@tax=a.taxNo, @address=a.address from unitInfo a, deptInfo b where b.host='shm' and b.deptID=@dept1 and a.unitName=b.deptName
			else if @host='spc' and @kindID=0
				select @unit=a.unitName,@tax=a.taxNo, @address=a.address from unitInfo a, deptInfo b where b.host='spc' and b.deptID=8 and a.unitName=b.deptName
			exec setUnitTaxConfirm @unit,@tax,@address,'',''
			insert into studentInfo(host,userName,name,password,kindID,companyID,dept1,dept2,unit,tax,job,mobile,address,education,memo,birthday,sex,age,registerID) 
			values(@host,upper(@username),@name,iif(@host<>'spc',@password,'Sh123456'),@kindID,@companyID,@dept1,@dept2,@unit,@tax,@job,@mobile,@address,@educationID,@memo,(case when @Tai=0 then substring(@username,7,8) else '2000-01-01' end),(case when @Tai=0 then dbo.getSexfromID(@username) else 0 end),(case when @Tai=0 then dbo.getAgefromID(@username) else '1' end),@registerID)
		end
		else
		begin
			update studentInfo set companyID=@companyID,dept1=@dept1,dept2=@dept2,unit=(case when @unit>'' then @unit else unit end),job=(case when @job>'' then @job else job end),mobile=(case when @mobile>'' then @mobile else mobile end),address=(case when @address>'' then @address else address end),education=(case when @educationID>0 then @educationID else education end),host=@host,memo=@memo where username=@username
		end

		select @retireDay=[dbo].[getRetireDayDiff](@username,@certID)

		if @retireDay>0
			select @existOther=1,@msg=iif(@retireDay=1,'该学员已距退休不足60天，不能报名。','不满18岁不能报名。')
	
		if @err=0 and @existOther=0
		begin
			-- 检查是否已报名相同的课程（未编班），如果有则删除
			select @enterID=ID,@refID=refID from studentCourseList where username=@username and courseID=@courseID and status<2 and classID is null
			if @enterID>0
			begin
				delete from studentCourseList where ID=@enterID
				delete from studentCertList where ID=@refID
				select @enterID=0
			end

			-- 在其他班级注册过
			if exists(select 1 from studentCourseList where username=@username and courseID=@courseID and status<2 and classID>'' and classID<>@classID)
				select @existOther=1,@msg=max(SNo) from studentCourseList where username=@username and courseID=@courseID and status<2 and classID>'' and classID<>@classID		--已在其他班注册过
			else
			begin
				declare @kind int, @payNow int, @title nvarchar(500), @deptID int
				select @payNow=0,@title=''
				if @host='spc'
				begin
					select @deptID=dept2 from studentInfo where username=@username
					if exists(select 1 from deptInfo where deptID=@deptID)
					begin
						select @kind=accountKind, @payNow=payNow, @title=title from deptInfo where deptID=@deptID
						if @kind=2
							select @title=item from dictionaryDoc where kind='SPCtitle'	--报账类型的部门，选取石化公司统一开票信息
					end
				end
				--合作单位设为未付费、后付费
				if @host not in('znxf','spc','shm')
					select @payNow = 1
				-- 注册课程
				--@ID,@username,@classID,@price,@amount,@invoice,@projectID,@title,@payNow,@needInvoice,@kindID,@type,@status,@datePay,@dateInvoice,@dateInvoicePick,@pay_memo,@currDiplomaID,@currDiplomaDate,@overdue,@fromID,@oldNo,@memo,@registerID
				select @price=price from projectInfo where projectID=@projectID
				if not exists(select 1 from studentCourseList where username=@username and courseID=@courseID and classID=@classID)
					exec @enterID=doEnter 0,@username,@classID,@price,0,'','',0,@projectID,@title,@payNow,0,0,0,0,'','','','','',@currDiplomaDate,0,0,@fromID,0,'',@oldNo,@memo,@host,@registerID
				else
					select @exist=1		--已在本班注册过
			end
		end
	end

	select @err as err, @exist as exist, @existOther as existOther, @null as errNull, @username as username,@name as name,isnull(@msg,'') as msg, @enterID as enterID
END
GO

------------------
-- CREATE DATE: 2020-05-24
-- 根据给定的参数，添加或者更新导入学员成绩信息
-- USE CASE: exec generateScore 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[generateScore]
	@batchID int,@passNo varchar(50),@username varchar(50),@name varchar(50),@score varchar(50),@registerID varchar(50)

AS
BEGIN
	declare @re int, @refID int,@certID varchar(50),@scorePass int, @enterID int,@score0 decimal(18,2)
	select @certID=certID,@re=1 from generatePasscardInfo where ID=@batchID
	select @enterID=enterID from passcardInfo where passNo=@passNo
	if len(@username) <> 18
		select @username=username from v_passcardInfo where passNo=@passNo
	select @scorePass=scorePass from examInfo where certID=@certID
	if @score = 'undefined' or @score = 'null' or @score = ''
		select @score0 = null
	else
		select @score0 = cast(@score as decimal(18,2))
	select @scorePass = isnull(@scorePass,80)

	if @enterID > 0
	begin
		--result:1 合格 2 不合格，结束课程
		select @refID=refID from studentCourseList where ID=@enterID
		update passcardInfo set score=@score0,status=(case when @score0>=@scorePass then 1 else 2 end) where passNo=@passNo
		update studentCertList set result=(case when @score0>=@scorePass then 1 else 2 end),status=(case when @score0>=@scorePass then 2 else status end),score=@score0,closeDate=(case when @score0>=@scorePass then getDate() else null end) where ID=@refID
		update studentCourseList set status=2,endDate=getDate(),closeDate=getDate() where ID=@enterID and @score0>=@scorePass
		select @re=0
		exec writeOpLog '','导入成绩','generateScore',@registerID,@score0,@enterID
	end

	return @re
END
GO

-- =============================================
-- CREATE Date: 2020-05-10
-- Description:	根据给定的类型编号，填写导入的批量图片记录。
-- Use Case:	exec generateMaterial 'C5','spc','admin.'
-- =============================================
CREATE PROCEDURE [dbo].[generateMaterial] 
	@kindID varchar(50), @qty int, @host varchar(50), @registerID varchar(50)
AS
BEGIN
	declare @re int
	--填写生成记录
	insert into generateMaterialInfo(kindID,qty,host,registerID) select @kindID,@qty,@host,@registerID
	select @re=max(ID) from generateMaterialInfo where registerID=@registerID and kindID=@kindID and host=@host
	return @re
END
GO

-- =============================================
-- Author:		Albert
-- Create date: 2020-06-20
-- Description:	student register report
-- e.g. exec p_rptStudentRegister 'spc','2020-01-01','2020-12-12','0',1,0,0,0,0,0
-- =============================================
ALTER PROCEDURE p_rptStudentRegister
	@host varchar(50),@startDate varchar(50),@endDate varchar(50),@kindID varchar(20),@groupHost int,@groupDept1 int,@groupKindID int,@groupDate varchar(20),@fromID varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @sql nvarchar(2000),@where nvarchar(2000),@group nvarchar(2000),@fields nvarchar(2000),@order nvarchar(2000)
	select @where='',@sql='',@group='',@fields='',@order=''
	
	--prepare condition statment
	if @host > ''
		select @where = dbo.getWhereStatement(@where,'host=' + '''' + @host + '''')
	if @startDate>'' 
		select @where = dbo.getWhereStatement(@where,'regDate>=' + '''' + @startDate + '''')
	if @endDate>'' 
		select @where = dbo.getWhereStatement(@where,'regDate<=' + '''' + @endDate + '''')
	if @kindID > ''
		select @where = dbo.getWhereStatement(@where,'kindID=' + @kindID)
	if @fromID > ''
		select @where = dbo.getWhereStatement(@where,'fromID=' + '''' + @fromID + '''')
		
	--prepare group by statment
	if @groupHost = 1
	begin
		select @group = dbo.getGroupStatement(@group,'hostName')
		select @fields = @fields + 'hostName as 公司,'
		select @order = dbo.getOrderStatement(@order,'公司')
	end
	if @groupDept1 = 1
	begin
		select @group = dbo.getGroupStatement(@group,'dept1Name')
		select @fields = @fields + 'dept1Name as 部门,'
		select @order = dbo.getOrderStatement(@order,'部门')
	end
	if @groupKindID = 1
	begin
		select @group = dbo.getGroupStatement(@group,'kindName')
		select @fields = @fields + 'kindName as 类别,'
		select @order = dbo.getOrderStatement(@order,'类别')
	end
	if @groupDate = 'month'
	begin
		select @group = dbo.getGroupStatement(@group,'left(regDate,7)')
		select @fields = @fields + 'left(regDate,7) as 月份,'
		select @order = dbo.getOrderStatement(@order,'月份')
	end
	if @groupDate = 'quarter'
	begin
		select @group = dbo.getGroupStatement(@group,'cast(left(regDate,4) as varchar)+''' + '.' + '''+cast(DATEPART(QUARTER, regDate) as varchar)')
		select @fields = @fields + 'cast(left(regDate,4) as varchar)+''' + '.' + '''+cast(DATEPART(QUARTER, regDate) as varchar) as 季度,'
		select @order = dbo.getOrderStatement(@order,'季度')
	end
	if @groupDate = 'year'
	begin
		select @group = dbo.getGroupStatement(@group,'left(regDate,4)')
		select @fields = @fields + 'left(regDate,4) as 年度,'
		select @order = dbo.getOrderStatement(@order,'年度')
	end
	
	--prepare sql statment
	select @sql = N'select ' + @fields + 'count(*) as 数量 from v_studentInfo' + @where + @group + @order
	
	--exec sql statment
	if @fields > ''
		exec sp_executesql @sql
END
GO


-- =============================================
-- Author:		Albert
-- Create date: 2020-06-20
-- Description:	student trainning report
-- e.g. exec p_rptStudentTrainning 'spc','2020-01-01','2020-12-12','0',1,0,0,0,0,0
-- =============================================
ALTER PROCEDURE p_rptStudentTrainning
	@host varchar(50),@startDate varchar(50),@endDate varchar(50),@kindID varchar(50),@courseID varchar(50),@status varchar(50),@groupHost int,@groupDept1 int,@groupKindID int,@groupCourseID int,@groupStatus int,@groupDate varchar(20),@fromID varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @sql nvarchar(2000),@where nvarchar(2000),@group nvarchar(2000),@fields nvarchar(2000),@order nvarchar(2000)
	select @where='',@sql='',@group='',@fields='',@order=''
	
	--prepare condition statment
	if @host > ''
		select @where = dbo.getWhereStatement(@where,'host=' + '''' + @host + '''')
	if @startDate>'' 
		select @where = dbo.getWhereStatement(@where,'regDate>=' + '''' + @startDate + '''')
	if @endDate>'' 
		select @where = dbo.getWhereStatement(@where,'regDate<=' + '''' + @endDate + '''')
	if @kindID > ''
		select @where = dbo.getWhereStatement(@where,'kindID=' + @kindID)
	if @courseID > ''
		select @where = dbo.getWhereStatement(@where,'courseID=' + '''' + @courseID + '''')
	if @status > ''
		select @where = dbo.getWhereStatement(@where,'status=' + @status)
	if @fromID > ''
		select @where = dbo.getWhereStatement(@where,'fromID=' + '''' + @fromID + '''')
		
	--prepare group by statment
	if @groupHost = 1
	begin
		select @group = dbo.getGroupStatement(@group,'hostName')
		select @fields = @fields + 'hostName as 公司,'
		select @order = dbo.getOrderStatement(@order,'公司')
	end
	if @groupDept1 = 1
	begin
		select @group = dbo.getGroupStatement(@group,'dept1Name')
		select @fields = @fields + 'dept1Name as 部门,'
		select @order = dbo.getOrderStatement(@order,'部门')
	end
	if @groupKindID = 1
	begin
		select @group = dbo.getGroupStatement(@group,'kindName')
		select @fields = @fields + 'kindName as 类别,'
		select @order = dbo.getOrderStatement(@order,'类别')
	end
	if @groupCourseID = 1
	begin
		select @group = dbo.getGroupStatement(@group,'courseName')
		select @fields = @fields + 'courseName as 课程,'
		select @order = dbo.getOrderStatement(@order,'课程')
	end
	if @groupStatus = 1
	begin
		select @group = dbo.getGroupStatement(@group,'statusName')
		select @fields = @fields + 'statusName as 状态,'
		select @order = dbo.getOrderStatement(@order,'状态')
	end
	if @groupDate = 'day'
	begin
		select @group = dbo.getGroupStatement(@group,'regDate')
		select @fields = @fields + 'regDate as 日期,'
		select @order = dbo.getOrderStatement(@order,'日期')
	end
	if @groupDate = 'month'
	begin
		select @group = dbo.getGroupStatement(@group,'left(regDate,7)')
		select @fields = @fields + 'left(regDate,7) as 月份,'
		select @order = dbo.getOrderStatement(@order,'月份')
	end
	if @groupDate = 'quarter'
	begin
		select @group = dbo.getGroupStatement(@group,'cast(left(regDate,4) as varchar)+''' + '.' + '''+cast(DATEPART(QUARTER, regDate) as varchar)')
		select @fields = @fields + 'cast(left(regDate,4) as varchar)+''' + '.' + '''+cast(DATEPART(QUARTER, regDate) as varchar) as 季度,'
		select @order = dbo.getOrderStatement(@order,'季度')
	end
	if @groupDate = 'year'
	begin
		select @group = dbo.getGroupStatement(@group,'left(regDate,4)')
		select @fields = @fields + 'left(regDate,4) as 年度,'
		select @order = dbo.getOrderStatement(@order,'年度')
	end
	
	--prepare sql statment
	select @sql = N'select ' + @fields + 'count(*) as 数量 from v_studentCourseList' + @where + @group + @order
	
	--exec sql statment
	if @fields > ''
		exec sp_executesql @sql
END
GO


-- =============================================
-- Author:		Albert
-- Create date: 2020-06-20
-- Description:	student diploma report
-- e.g. exec p_rptStudentDiploma 'spc','2020-01-01','2020-12-12','0',1,0,0,0,0,0
-- =============================================
ALTER PROCEDURE p_rptStudentDiploma
	@host varchar(50),@startDate varchar(50),@endDate varchar(50),@kindID varchar(50),@certID varchar(50),@status varchar(50),@agencyID varchar(50),@groupHost int,@groupDept1 int,@groupKindID int,@groupCertID int,@groupStatus int,@groupAgencyID int,@groupDate varchar(20),@fromID varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @sql nvarchar(2000),@where nvarchar(2000),@group nvarchar(2000),@fields nvarchar(2000),@order nvarchar(2000)
	select @where='',@sql='',@group='',@fields='',@order=''
	
	--prepare condition statment
	if @host > ''
		select @where = dbo.getWhereStatement(@where,'host=' + '''' + @host + '''')
	if @startDate>'' 
		select @where = dbo.getWhereStatement(@where,'startDate>=' + '''' + @startDate + '''')
	if @endDate>'' 
		select @where = dbo.getWhereStatement(@where,'startDate<=' + '''' + @endDate + '''')
	if @kindID > ''
		select @where = dbo.getWhereStatement(@where,'kindID=' + @kindID)
	if @certID > ''
		select @where = dbo.getWhereStatement(@where,'certID=' + '''' + @certID + '''')
	if @status > ''
		select @where = dbo.getWhereStatement(@where,'status=' + @status)
	if @agencyID > ''
		select @where = dbo.getWhereStatement(@where,'agencyID=' + '''' + @agencyID + '''')
	if @fromID > ''
		select @where = dbo.getWhereStatement(@where,'fromID=' + '''' + @fromID + '''')
		
	--prepare group by statment
	if @groupHost = 1
	begin
		select @group = dbo.getGroupStatement(@group,'hostName')
		select @fields = @fields + 'hostName as 公司,'
		select @order = dbo.getOrderStatement(@order,'公司')
	end
	if @groupDept1 = 1
	begin
		select @group = dbo.getGroupStatement(@group,'dept1Name')
		select @fields = @fields + 'dept1Name as 部门,'
		select @order = dbo.getOrderStatement(@order,'部门')
	end
	if @groupKindID = 1
	begin
		select @group = dbo.getGroupStatement(@group,'kindName')
		select @fields = @fields + 'kindName as 类别,'
		select @order = dbo.getOrderStatement(@order,'类别')
	end
	if @groupAgencyID = 1
	begin
		select @group = dbo.getGroupStatement(@group,'agencyName')
		select @fields = @fields + 'agencyName as 认证机构,'
		select @order = dbo.getOrderStatement(@order,'认证机构')
	end
	if @groupCertID = 1
	begin
		select @group = dbo.getGroupStatement(@group,'certName')
		select @fields = @fields + 'certName as 证书名称,'
		select @order = dbo.getOrderStatement(@order,'证书名称')
	end
	if @groupStatus = 1
	begin
		select @group = dbo.getGroupStatement(@group,'statusName')
		select @fields = @fields + 'statusName as 状态,'
		select @order = dbo.getOrderStatement(@order,'状态')
	end
	if @groupDate = 'month'
	begin
		select @group = dbo.getGroupStatement(@group,'left(startDate,7)')
		select @fields = @fields + 'left(startDate,7) as 月份,'
		select @order = dbo.getOrderStatement(@order,'月份')
	end
	if @groupDate = 'quarter'
	begin
		select @group = dbo.getGroupStatement(@group,'cast(left(startDate,4) as varchar)+''' + '.' + '''+cast(DATEPART(QUARTER, startDate) as varchar)')
		select @fields = @fields + 'cast(left(startDate,4) as varchar)+''' + '.' + '''+cast(DATEPART(QUARTER, startDate) as varchar) as 季度,'
		select @order = dbo.getOrderStatement(@order,'季度')
	end
	if @groupDate = 'year'
	begin
		select @group = dbo.getGroupStatement(@group,'left(startDate,4)')
		select @fields = @fields + 'left(startDate,4) as 年度,'
		select @order = dbo.getOrderStatement(@order,'年度')
	end
	
	--prepare sql statment
	select @sql = N'select ' + @fields + 'count(*) as 数量 from v_diplomaInfo' + @where + @group + @order
	
	--exec sql statment
	if @fields > ''
		exec sp_executesql @sql
END
GO


-- =============================================
-- Author:		Albert
-- Create date: 2020-06-20
-- Description:	student diplomalast report
-- e.g. exec p_rptStudentDiplomaLast 'spc','2020-01-01','2020-12-12','0',1,0,0,0,0,0
-- =============================================
ALTER PROCEDURE p_rptStudentDiplomaLast
	@host varchar(50),@startDate varchar(50),@endDate varchar(50),@kindID varchar(50),@certID varchar(50),@status varchar(50),@agencyID varchar(50),@groupHost int,@groupDept1 int,@groupKindID int,@groupCertID int,@groupStatus int,@groupAgencyID int,@groupDate varchar(20),@fromID varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @sql nvarchar(2000),@where nvarchar(2000),@group nvarchar(2000),@fields nvarchar(2000),@order nvarchar(2000)
	select @where='',@sql='',@group='',@fields='',@order=''
	
	--prepare condition statment
	if @host > ''
		select @where = dbo.getWhereStatement(@where,'host=' + '''' + @host + '''')
	if @startDate>'' 
		select @where = dbo.getWhereStatement(@where,'endDate>=' + '''' + @startDate + '''')
	if @endDate>'' 
		select @where = dbo.getWhereStatement(@where,'endDate<=' + '''' + @endDate + '''')
	if @kindID > ''
		select @where = dbo.getWhereStatement(@where,'kindID=' + @kindID)
	if @certID > ''
		select @where = dbo.getWhereStatement(@where,'certID=' + '''' + @certID + '''')
	if @status > ''
		select @where = dbo.getWhereStatement(@where,'status=' + @status)
	if @agencyID > ''
		select @where = dbo.getWhereStatement(@where,'agencyID=' + '''' + @agencyID + '''')
	if @fromID > ''
		select @where = dbo.getWhereStatement(@where,'fromID=' + '''' + @fromID + '''')
		
	--prepare group by statment
	if @groupHost = 1
	begin
		select @group = dbo.getGroupStatement(@group,'hostName')
		select @fields = @fields + 'hostName as 公司,'
		select @order = dbo.getOrderStatement(@order,'公司')
	end
	if @groupDept1 = 1
	begin
		select @group = dbo.getGroupStatement(@group,'dept1Name')
		select @fields = @fields + 'dept1Name as 部门,'
		select @order = dbo.getOrderStatement(@order,'部门')
	end
	if @groupKindID = 1
	begin
		select @group = dbo.getGroupStatement(@group,'kindName')
		select @fields = @fields + 'kindName as 类别,'
		select @order = dbo.getOrderStatement(@order,'类别')
	end
	if @groupAgencyID = 1
	begin
		select @group = dbo.getGroupStatement(@group,'agencyName')
		select @fields = @fields + 'agencyName as 认证机构,'
		select @order = dbo.getOrderStatement(@order,'认证机构')
	end
	if @groupCertID = 1
	begin
		select @group = dbo.getGroupStatement(@group,'certName')
		select @fields = @fields + 'certName as 证书名称,'
		select @order = dbo.getOrderStatement(@order,'证书名称')
	end
	if @groupStatus = 1
	begin
		select @group = dbo.getGroupStatement(@group,'statusName')
		select @fields = @fields + 'statusName as 状态,'
		select @order = dbo.getOrderStatement(@order,'状态')
	end
	if @groupDate = 'month'
	begin
		select @group = dbo.getGroupStatement(@group,'left(endDate,7)')
		select @fields = @fields + 'left(endDate,7) as 月份,'
		select @order = dbo.getOrderStatement(@order,'月份')
	end
	if @groupDate = 'quarter'
	begin
		select @group = dbo.getGroupStatement(@group,'cast(left(endDate,4) as varchar)+''' + '.' + '''+cast(DATEPART(QUARTER, endDate) as varchar)')
		select @fields = @fields + 'cast(left(endDate,4) as varchar)+''' + '.' + '''+cast(DATEPART(QUARTER, endDate) as varchar) as 季度,'
		select @order = dbo.getOrderStatement(@order,'季度')
	end
	if @groupDate = 'year'
	begin
		select @group = dbo.getGroupStatement(@group,'left(endDate,4)')
		select @fields = @fields + 'left(endDate,4) as 年度,'
		select @order = dbo.getOrderStatement(@order,'年度')
	end
	
	--prepare sql statment
	select @sql = N'select ' + @fields + 'count(*) as 数量 from v_diplomaLastInfo' + @where + @group + @order
	
	--exec sql statment
	if @fields > ''
		exec sp_executesql @sql
END
GO

-- =============================================
-- CREATE Date: 2020-06-25
-- Description:	填写SQL语句执行log。
-- Use Case:	exec writeSQLlog @sql,@params,@username,@ip,@host
-- =============================================
CREATE PROCEDURE [dbo].[writeSQLlog] 
	@sql varchar(4000), @params varchar(4000), @username varchar(50), @ip varchar(50), @host varchar(50)
AS
BEGIN
	--填写生成记录
	if @sql='updateStudentInfo' or @sql='updateStudentPassword' or @sql='addStudentCert' or @sql='delStudentCert' or @sql='submit_student_feedback'
		insert into SQLlog(sql,params,username,ip,host) values(@sql,@params,@username,@ip,@host)
END
GO

-- =============================================
-- CREATE Date: 2020-06-25
-- Description:	合并部门，原来隶属于同一个上级部门。
-- @id:deptID list with split ','   @deptName：合并后部门名称
-- Use Case:	exec mergeDepts @id,@deptName,@username
-- =============================================
ALTER PROCEDURE [dbo].[mergeDepts] 
	@id varchar(1000),@deptName nvarchar(100), @registerID varchar(50)
AS
BEGIN
	--获取合并部门的个数,取列表中第一个deptID作为合并目标
	declare @n int, @deptID int,@oid int,@merge nvarchar(1000), @host varchar(50)
	select @n = [dbo].[pf_getStrArrayLength](@id,','), @deptID = [dbo].[pf_getStrArrayOfIndex](@id,',',0),@merge=''
	select @host=host from deptInfo where deptID=@deptID
	update deptInfo set deptName=@deptName where deptID=@deptID
	--合并
	while @n>1	--第一个部门不被合并
	begin
		select @oid = [dbo].[pf_getStrArrayOfIndex](@id,',',@n-1)
		select @merge = @merge + ',' + deptName from deptInfo where deptID=@oid
		delete from deptInfo where pID=@oid		--删除下级部门
		delete from deptInfo where deptID=@oid		--删除被合并部门
		update studentInfo set dept1=@deptID where dept1=@oid	--修改被合并部门的学员
		update studentInfo set dept2=@deptID where dept2=@oid	--修改被合并部门的学员
		update studentInfo set dept3=@deptID where dept3=@oid	--修改被合并部门的学员
		select @n = @n - 1
	end
	select @merge = @deptName + @merge
	--写日志
	exec writeOpLog @host,'合并部门','mergeDepts',@registerID,@merge,@ID
END
GO


-- =============================================
-- CREATE Date: 2020-05-09
-- Description:	根据给定的数据，重置学员密码。
-- Use Case:	exec reset_student_password '120108....','13890000530'
-- =============================================
ALTER PROCEDURE [dbo].[reset_student_password] 
	@username varchar(50), @phone varchar(50)
AS
BEGIN
	declare @re int, @pwd varchar(50)
	select @re = 0, @pwd = item from dictionaryDoc where kind='studentPasswd' and ID='0'
	select @pwd=iif(host='spc','Sh123456',@pwd) from studentInfo where username=@username
	if not exists(select 1 from studentInfo where username=@username)
		set @re = 1
	else
		if not exists(select 1 from studentInfo where username=@username and mobile=@phone)
			set @re = 2
		else
			update studentInfo set password=@pwd where username=@username
	
	select @re as status, @pwd as password
END

GO


-- =============================================
-- CREATE Date: 2020-06-25
-- Description:	填写短信发送log。
-- Use Case:	exec writeSSMSlog @sql,@params,@username,@ip,@host
-- =============================================
ALTER PROCEDURE [dbo].[writeSSMSlog] 
	@message nvarchar(500), @mobile varchar(50), @kind varchar(50), @username varchar(50),@refID varchar(50), @registerID varchar(50)
AS
BEGIN
	--填写生成记录
	if @refID=''
		set @refID=null
	insert into log_sendsms(message,mobile,kind,username,refID,registerID) values(@message,@mobile,@kind,@username,@refID,@registerID)
END
GO

-- CREATE DATE: 2020-08-03
-- 根据给定的参数，添加或者更新试卷消息
-- USE CASE: exec updateExamInfo 1,1,'xxxx'...
CREATE PROCEDURE [dbo].[updateExamInfo]
	@ID int,@certID varchar(50),@courseID varchar(50),@examID varchar(50),@examName varchar(100),@scoreTotal int,@scorePass int,@minutes int,@kindID int,@status int,@memo varchar(500),@registerID varchar(50)
AS
BEGIN
	if @certID=''
		set @certID=null
	if @courseID=''
		set @courseID=null

	if @ID=0	-- 新纪录
	begin
		insert into examInfo(certID,courseID,examID,examName,scoreTotal,scorePass,minutes,kindID,status,memo,registerID) values(@certID,@courseID,@examID,@examName,@scoreTotal,@scorePass,@minutes,@kindID,@status,@memo,@registerID)
	end
	else
	begin
		update examInfo set kindID=@kindID,certID=@certID,courseID=@courseID,examID=@examID,examName=@examName,scoreTotal=@scoreTotal,scorePass=@scorePass,minutes=@minutes,status=@status,memo=@memo where ID=@ID
	end
END

-- CREATE DATE: 2020-08-04
-- 根据给定的参数，添加或者更新组卷规则消息
-- USE CASE: exec updateExamRuleInfo 1,1,'xxxx'...
CREATE PROCEDURE [dbo].[updateExamRuleInfo]
	@ID int,@examID varchar(50),@knowPointID varchar(50),@typeID int,@qty int,@scorePer decimal(18,1),@kindID int,@status int,@memo varchar(500),@registerID varchar(50)
AS
BEGIN
	if @knowPointID=''
		set @knowPointID=null

	if @ID=0	-- 新纪录
	begin
		insert into examRuleInfo(knowPointID,examID,typeID,qty,scorePer,kindID,status,memo,registerID) values(@knowPointID,@examID,@typeID,@qty,@scorePer,@kindID,@status,@memo,@registerID)
	end
	else
	begin
		update examRuleInfo set kindID=@kindID,knowPointID=@knowPointID,examID=@examID,typeID=@typeID,qty=@qty,scorePer=@scorePer,status=@status,memo=@memo where ID=@ID
	end
END

-- CREATE DATE: 20111223
-- Description:	写回执，根据给定回执类型、引用标识和用户名称生成回执记录
-- Use case:exec setReturnLog 'task','2','user1','spc'
-- =============================================
ALTER PROCEDURE [dbo].[setReturnLog] 
	@kindID varchar(50),@refID varchar(50),@userID varchar(50),@host varchar(50)
AS
BEGIN
	-- 如果还没有回执，则添加回执，否则不做处理
	if exists(select 1 from returnReceiptList where kindID=@kindID and refID=@refID and userName=@userID and receiptDate is null)
		update returnReceiptList set receiptDate=getDate() where kindID=@kindID and refID=@refID and userName=@userID
	if not exists(select 1 from returnReceiptList where kindID=@kindID and refID=@refID and userName=@userID)
		insert into returnReceiptList(receiptDate,userName,kindID,refID,host) values (getDate(),@userID,@kindID,@refID,@host)
END
GO

-- CREATE DATE: 2020-10-30
-- 根据给定的参数，添加或者更新发布的培训项目消息
-- USE CASE: exec updateProjectInfo 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updateProjectInfo]
	@ID int,@projectID varchar(50),@projectName varchar(100),@courseID varchar(50),@object varchar(50),@address varchar(200),@deadline varchar(50),@kindID int,@linker varchar(50),@mobile varchar(50),@phone varchar(50),@email varchar(50),@price int,@payKind int,@payGroup int,@host varchar(50),@dept varchar(500),@memo varchar(2000),@registerID varchar(50)
AS
BEGIN
	declare @certID varchar(50),@reexamine int, @serial int
	select @certID=certID,@reexamine=reexamine from courseInfo where courseID=@courseID
	if @deadline='' or @deadline='null'
		set @deadline=null

	if @ID=0	-- 新纪录
	begin
		declare @code varchar(50)
		--exec setAutoCode @host,@certID,@code output, @serial output		--获取证书编号
		exec setAutoCode '','Pro',@code output,@serial out		--获取证书编号
		insert into projectInfo(projectID,projectName,certID,courseID,reexamine,kindID,object,address,deadline,linker,mobile,phone,email,price,payKind,payGroup,memo,host,dept,registerID) values(@code,@projectName,@certID,@courseID,@reexamine,@kindID,@object,@address,@deadline,@linker,@mobile,@phone,@email,@price,@payKind,@payGroup,@memo,@host,@dept,@registerID)
	end
	else
	begin
		update projectInfo set projectName=@projectName,certID=@certID,courseID=@courseID,reexamine=@reexamine,object=@object,address=@address,deadline=@deadline,linker=@linker,mobile=@mobile,phone=@phone,email=@email,price=@price,payKind=@payKind,payGroup=@payGroup,host=@host,dept=@dept,memo=@memo,kindID=@kindID where ID=@ID
	end
END
GO

-- =============================================
-- CREATE DATE: 2020-10-30
-- 设置招生通告
-- USE CASE: exec setProjectStatus 1, '测试', 'albert'
-- =============================================
ALTER PROCEDURE [dbo].[setProjectStatus] 
	@ID int,@status int,@username varchar(50)
AS
BEGIN
	if @status=9
		delete from projectInfo where ID=@ID
	else
		update projectInfo set status=@status where ID=@ID
	-- 写操作日志
	declare @event varchar(50),@mem varchar(500)
	--exec writeOpLog @host,@event,'user',@registerID,@memo,@refID
	select @event=item,@mem='' from dictionaryDoc where kind='statusIssue' and ID=@status
	exec writeOpLog '',@event,'project',@username,@mem,@ID
END

GO

-- =============================================
-- CREATE DATE: 2020-11-28
-- 为给定招生批次的学员编号
-- USE CASE: exec setProjectStudentNo 'P-20-001', 'albert'
-- =============================================
CREATE PROCEDURE [dbo].[setProjectStudentNo] 
	@projectID varchar(50),@username varchar(50)
AS
BEGIN
	update studentCourseList set SNo=a.rank1 from (select ID,RANK() over(order by ID) as rank1 from studentCourseList where projectID=@projectID and checked=1) a where a.ID=studentCourseList.ID
	-- 写操作日志
	declare @event varchar(50),@mem varchar(500)
	--exec writeOpLog @host,@event,'user',@registerID,@memo,@refID
	select @event='编学号',@mem=''
	exec writeOpLog '',@event,'projectStudentNo',@username,@mem,@projectID
END

GO

-- =============================================
-- CREATE Date: 2020-10-08
-- Description:	确认报名人员列表。
-- @status: 1 确认  2 拒绝
-- @selList: 发放名单，用逗号分隔的username in studentCourseList
-- Use Case:	exec doStudentCourse_check 1,'...','spc','admin.'
-- =============================================
ALTER PROCEDURE [dbo].[doStudentCourse_check] 
	@status int, @classID varchar(50), @selList varchar(4000), @host varchar(50), @registerID varchar(50)
AS
BEGIN
	declare @re int

	--将名单导入到临时表
	create table #temp_studentCheck(id varchar(50), classStatus int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_studentCheck(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	update #temp_studentCheck set classStatus=c.status from #temp_studentCheck a, studentCourseList b, classInfo c where b.classID=c.classID and a.id=b.username and b.classID=@classID

	--修改报名人员状态  已结束班级的人员不能修改
	update studentCourseList set checked=@status,checkDate=GETDATE(),checker=@registerID from #temp_studentCheck a where studentCourseList.username=a.id and studentCourseList.classID=@classID and a.classStatus<2
	set @re=@@rowcount
	return @re
END
GO

-- =============================================
-- CREATE Date: 2020-10-08
-- Description:	确认报名人员列表。
-- @status: 1 确认  2 拒绝
-- @selList: 发放名单，用逗号分隔的ID in studentCourseList
-- Use Case:	exec doStudentPre_check 1,'...','spc','admin.'
-- =============================================
ALTER PROCEDURE [dbo].[doStudentPre_check] 
	@status int, @selList varchar(4000), @host varchar(50), @registerID varchar(50)
AS
BEGIN
	declare @re int

	--将名单导入到临时表
	create table #temp_studentCheck(id varchar(50))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_studentCheck(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	--修改报名人员状态  已结编班的人员不能剔除
	update studentCourseList set checked=@status,checkDate=GETDATE(),checker=@registerID from #temp_studentCheck a where studentCourseList.ID=a.id and (@status=1 or (@status=2 and studentCourseList.classID = ''))
	set @re=@@rowcount
	return @re
END
GO

-- =============================================
-- CREATE Date: 2020-10-08
-- Description:	将给定的在线报名人员编班。
-- @selList: 发放名单，用逗号分隔的ID in studentCourseList
-- Use Case:	exec doStudentPre_check 1,'...','spc','admin.'
-- =============================================
ALTER PROCEDURE [dbo].[pickStudents4Class] 
	@classID varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @re int, @ID int, @certID varchar(50),@payID int

	--将名单导入到临时表
	create table #temp_studentCheck(id varchar(50))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_studentCheck(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	select @re = 0
	if exists(select 1 from classInfo where classID=@classID)
	begin
		select @certID=certID from classInfo where classID=@classID
		declare rc cursor for select a.id from #temp_studentCheck a, v_studentCourseList b where a.id=b.ID and b.certID=@certID
		open rc
		fetch next from rc into @ID
		While @@fetch_status=0 
		Begin 
			exec updateEnterClass @ID,@classID,'','','','','',9,0,'','',@registerID
			--select @payID=payID from payDetailInfo where enterID=@ID
			--更新付款状态
			--update payInfo set status=1 where ID=@payID
			
			select @re=@re+1
			fetch next from rc into @ID
		End
		Close rc 
		Deallocate rc
	end

	select @re as re
END
GO

-- =============================================
-- CREATE Date: 2020-10-08
-- Description:	将给定的班级中选定的人员转入新的班级。
-- @selList: 发放名单，用逗号分隔的username in studentCourseList in class
-- Use Case:	exec [pickStudents2Class] '...','spc','admin.'
-- =============================================
ALTER PROCEDURE [dbo].[pickStudents2Class] 
	@classID varchar(50), @selList varchar(4000), @oldClassID varchar(50), @registerID varchar(50)
AS
BEGIN
	declare @re int, @ID int, @cID int, @pNo varchar(50), @mark varchar(50)
	select @pNo = ''
	select @cID=ID from classInfo where classID=@classID

	--将名单导入到临时表
	create table #temp_studentCheck(id varchar(50))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_studentCheck(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	select @re = 0
	if @classID='' or exists(select 1 from classInfo where classID=@classID)
	begin
		declare rc cursor for select b.id from #temp_studentCheck a, studentCourseList b where a.id=b.username and b.classID=@oldClassID
		open rc
		fetch next from rc into @ID
		While @@fetch_status=0 
		Begin 
			-- exec updateEnterClass @ID,@classID,'','','','','',9,0,'',@registerID
			if @classID>''
				exec lookRefSNo @cID, '', '', @pNo output, @mark output
			update studentCourseList set classID=@classID, SNo=@pNo where ID=@ID
			select @re=@re+1
			fetch next from rc into @ID
		End
		Close rc 
		Deallocate rc
	end

	select @re as re
END
GO

-- =============================================
-- CREATE Date: 2024-10-28
-- Description:	给定的班级中选定的人员更改支付类型（预付费/后付费,未付/已付）。
-- @selList: 名单，用逗号分隔的username in studentCourseList in class
-- @payNow: 由两位数字组成，第一位是预付费/后付费，第二位是未付/已付
-- Use Case:	exec [pickStudents2Paynow] '1','124223xxx','122'
-- =============================================
ALTER PROCEDURE [dbo].[pickStudents2Paynow] 
	@payNow varchar(50), @selList varchar(4000), @classID varchar(50), @registerID varchar(50)
AS
BEGIN
	declare @re int, @logMemo nvarchar(500)

	--将名单导入到临时表
	create table #temp_studentCheck(id varchar(50))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_studentCheck(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	select @re = count(*) from studentCourseList a, #temp_studentCheck b where a.username=b.id and a.classID=@classID and pay_status=0
	update studentCourseList set payNow=left(@payNow,1), pay_status=right(@payNow,1) from studentCourseList a, #temp_studentCheck b where a.username=b.id and a.classID=@classID  and pay_status=0
	-- 写操作日志
	select @logMemo=@selList + ':' + @payNow
	exec writeOpLog '','更改支付方式','pickStudents2Paynow',@registerID,@logMemo,@classID

	select @re as re
END
GO

-- =============================================
-- CREATE Date: 2021-02-17
-- Description:	根据给定的招生批号，向教务处提交报名人员列表。
-- @status: 1 确认  2 拒绝
-- @selList: 发放名单，用逗号分隔的ID in studentCourseList
-- Use Case:	exec doStudentCourse_submit 'P-20-005',1,'...','spc','admin.'
-- =============================================
ALTER PROCEDURE [dbo].[doStudentCourse_submit] 
	@projectID varchar(50), @status int, @selList varchar(4000), @host varchar(50), @registerID varchar(50)
AS
BEGIN
	declare @re int

	--将名单导入到临时表
	create table #temp_studentSubmit(id int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_studentSubmit values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	--修改报名人员状态，对已经编班的学员不能再提交或撤销，对未确认的不能提交。
	update studentCourseList set submited=@status,submitDate=GETDATE(),submiter=@registerID from #temp_studentSubmit a where studentCourseList.ID=a.id and studentCourseList.classID=0 and studentCourseList.checked=1
	set @re=@@rowcount
	return @re
END
GO

-- =============================================
-- CREATE Date: 2021-02-17
-- Description:	根据给定的人员列表，将其标记为加急/不加急。原来未加急的改为加急，原来加急的改为不加急。
-- @selList: 名单，用逗号分隔的ID in studentCourseList
-- Use Case:	exec set_students_express '...','spc','admin.'
-- =============================================
ALTER PROCEDURE [dbo].[set_students_express] 
	@selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @re int

	--将名单导入到临时表
	create table #temp_studentSubmit(id int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_studentSubmit values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	--修改报名人员状态，对未加急的设为加急，已加急的改为不加急。
	update studentCourseList set express=(case when express=0 then 1 else 0 end) from #temp_studentSubmit a where studentCourseList.ID=a.id
	set @re=@@rowcount
	return @re
END
GO

-- =============================================
-- CREATE Date: 2021-02-14
-- Description:	根据给定的数据（ID+资料类型），通知学员重新上传资料图片。
-- @status: 1 通知  3 关闭
-- @selList: 名单，用逗号分隔的ID in studentCourseList + '|' + kindID
-- Use Case:	exec doStudentMaterial_resubmit 1,'...','admin.'
-- =============================================
ALTER PROCEDURE [dbo].[doStudentMaterial_resubmit] 
	@status int, @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @re int

	--将名单导入到临时表
	create table #temp_studentBadPhoto(item varchar(100),id int,kindID int,name varchar(50),mobile varchar(50),username varchar(50),host varchar(40))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_studentBadPhoto(item) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	update #temp_studentBadPhoto set id=dbo.pf_getStrArrayOfIndex(item,'|',0), kindID=dbo.pf_getStrArrayOfIndex(item,'|',1)
	update a set a.name=b.name, a.mobile=b.mobile, a.item=c.item, a.username=b.username, a.host=b.host from #temp_studentBadPhoto a, v_studentCourseList b, dictionaryDoc c where a.ID=b.ID and a.kindID=c.ID and c.kind='material'

	if @status=1	--发布通知
	begin
		delete from studentMaterialsAsk where ID in(select a.ID from studentMaterialsAsk a, #temp_studentBadPhoto b where a.refID=b.id and a.kindID=b.kindID)
		insert into studentMaterialsAsk(refID,kindID,status,askerID,askDate) select id,kindID,@status,@registerID,getDate() from #temp_studentBadPhoto
		--更新统计
		--系统通知
		declare @username varchar(50), @host varchar(50), @item nvarchar(4000), @name varchar(50)
		declare rc cursor for select b.username,b.host,c.item,b.name from #temp_studentBadPhoto a, v_studentCourseList b, dictionaryDoc c where a.ID=b.ID and a.kindID=c.ID and c.kind='material'
		open rc
		fetch next from rc into @username,@host,@item,@name
		While @@fetch_status=0 
		Begin 
			--系统通知
			--@username varchar(50),@kindID int,@item nvarchar(4000), @host varchar(50), @user varchar(50)
			select @item = @name + '：经审核，您提交的' + @item + '的图片资料不符合要求，请修改后重新上传，谢谢。'
			exec sendSysMessage @username,1,@item,@host,@registerID
			fetch next from rc into @username,@host,@item,@name
		End
		Close rc 
		Deallocate rc
		--短信通知
		--填写service记录
		insert into studentServiceInfo(username,mobile,item,refID,vID,kindID,type,status,host,registerID) select username,mobile, '经审核，您提交的' + item + '的图片资料不符合要求，请修改后重新上传，谢谢。',id,kindID,0,0,2,host,@registerID from #temp_studentBadPhoto
	end

	if @status=3	--关闭
	begin
		update a set a.status=@status,a.closerID=@registerID,a.closerDate=getDate() from studentMaterialsAsk a, #temp_studentBadPhoto b where a.refID=b.id and a.kindID=b.kindID
		--更新service记录
		update studentServiceInfo set status=0,memo=isnull(memo,'') + '已提交并确认（' + @registerID + ' ' + convert(varchar(50),getDate(),20) + '）' from studentServiceInfo a, #temp_studentBadPhoto b where a.refID=b.id and a.vID=b.kindID
		--更新统计
	end

	select name,item,mobile,username,host from #temp_studentBadPhoto
END
GO

-- =============================================
-- CREATE DATE: 2020-11-10
-- 定时自动更新数据
-- USE CASE: exec plan_dailyCheck
-- =============================================
ALTER PROCEDURE [dbo].[plan_dailyCheck] 
AS
BEGIN
	--更新学员年龄
	update studentInfo set age=dbo.getAgefromID(username) where len(username)=18
	update studentInfo set age=datediff(yy,birthday,getDate()) where len(username)<>18 and birthday>''
	--检查招生简章是否过期
	update projectInfo set status=2 where status=1 and DATEDIFF(d,deadline,getDate())>0
	--检查用户是否过期
	update userInfo set status=1 where status<1 and limitedDate<getDate()
	--检查证书是否过期
	update diplomaInfo set status=1 where status<1 and endDate<getDate()
	--检查考试是否过期
	update generatePasscardInfo set status=1 where status<1 and DATEDIFF(d,startDate,getDate())>0
	--检查班级是否过期
	update classInfo set status=2 where status<2 and DATEDIFF(d,dateEnd,getDate())>30
	--报到超过60天未结课的，自动结束: 项目结束后才可重新报名，课程结束则不能继续做题
	--update studentCertList set status=2,closeDate=getDate() where status<2  and ID in(select refID from studentCourseList where status<2 and classID>''  and DATEDIFF(d,regDate,getDate())>60)
	--update studentCourseList set status=2,closeDate=getDate() where status<2 and classID>''  and DATEDIFF(d,regDate,getDate())>90
	--已有证书的自动结束
	update studentCourseList set status=2,closeDate=getDate() where status<2 and hold=0 and refID in(select ID from studentCertList where status<2 and diplomaID>'')
	update studentCertList set status=2,closeDate=getDate() where status<2 and hold=0 and diplomaID>'' 
	--已关闭的招生项目，删除被剔除的人员
	exec dealNoCheckedEnters
	--删除内训项目中超过期限不能自己删除但还未完成的课程
	exec deal_expireEnterInner
	--备份数据库
	BACKUP DATABASE elearning TO   DISK = N'D:\project\dbback\elearning.bak' WITH INIT, NOFORMAT
END
GO

-- CREATE DATE: 2021-02-18
-- 根据给定的参数，添加或者更新学员服务信息
-- USE CASE: exec updateStudentServiceInfo 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updateStudentServiceInfo]
	@ID int,@username varchar(50),@item nvarchar(4000),@refID int,@type int,@serviceDate varchar(50),@private int,@memo varchar(2000),@registerID varchar(50)
AS
BEGIN
	if @serviceDate='' set @serviceDate=convert(varchar(20),GETDATE(),23)
	
	if @ID=0	-- 新纪录
	begin
		insert into studentServiceInfo(username,item,refID,type,serviceDate,private,memo,registerID) values(@username,@item,@refID,@type,@serviceDate,@private,@memo,@registerID)
		select @ID=max(ID) from studentServiceInfo where registerID=@registerID
	end
	else
	begin
		update studentServiceInfo set item=@item,type=@type,serviceDate=@serviceDate,private=@private,memo=@memo where ID=@ID
	end

	select @ID as re
END
GO

-- CREATE DATE: 2021-04-06
-- 根据给定的参数，添加或者更新班级信息
-- USE CASE: exec updateClassInfo 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updateClassInfo]
	@ID int,@className nvarchar(100),@certID varchar(50),@courseID varchar(50),@projectID varchar(500),@adviserID varchar(50),@host varchar(50),@teacher varchar(50),@kindID int,@status int,@pre int,@dateStart varchar(50),@dateEnd varchar(50),@classroom nvarchar(500),@timetable nvarchar(2000),@archived int,@summary nvarchar(2000),@transaction_id varchar(50),@signatureType int,@memo nvarchar(2000),@registerID varchar(50)
AS
BEGIN
	declare @serial int, @kind varchar(50)
	if @dateStart='' set @dateStart=null
	if @dateEnd='' set @dateEnd=null
	if @certID='' or @certID is null
		select @certID=certID from courseInfo where courseID=@courseID

	--如果第一个字符就是分隔符，则将其删除
	if left(@projectID,1)=','
		set @projectID = right(@projectID,len(@projectID)-1)
			
	if @ID=0	-- 新纪录
	begin
		if @pre=0 or (@pre = 1 and not exists(select 1 from classInfo where pre=1 and courseID=@courseID and host=@host))	--每个项目的预备班只能创建一个
		begin
			declare @code varchar(50),@nickName varchar(50)
			if @certID='' and @projectID>''
				select @certID=certID from projectInfo where projectID=@projectID
			select @kind = 'CLS' + @certID
			exec setAutoCode '',@kind,@code output, @serial output		--获取编号
			if getDate()>='2022-01-01'
			begin
				--自动填写班级名称 202201危化消防
				select @nickName=nickName from certificateInfo where certID=@certID
				if @certID='C21' or @certID='C20' or @certID='C20A'
				begin
					--消防操作员单独编号，不按年份
					select @className = cast(eID as varchar) + @nickName from dictionaryDoc where kind='fireman' and ID=0
					update dictionaryDoc set eID=eID+1 where kind='fireman' and ID=0
				end
				else
					select @className = convert(varchar(4),getDate(),112) + right(@code,2) + @nickName
			end
			insert into classInfo(classID,className,certID,courseID,projectID,adviserID,teacher,kindID,status,pre,dateStart,dateEnd,classroom,timetable,summary,transaction_id,signatureType,memo,host,registerID) values(@code,@className,@certID,@courseID,@projectID,@adviserID,@teacher,@kindID,@status,@pre,@dateStart,@dateEnd,@classroom,@timetable,@summary,@transaction_id,@signatureType,@memo,@host,@registerID)
			select @ID=max(ID) from classInfo where courseID=@courseID and registerID=@registerID
		end
	end
	else
	begin
		--更改学员的签名类型
		if exists(select 1 from classInfo where ID=@ID and signatureType<>@signatureType)
			update studentCourseList set signatureType=@signatureType from studentCourseList a, classInfo b where a.classID=b.classID and b.ID=@ID
		update classInfo set archiver=(case when @archived=1 and archiver is null then @registerID else archiver end),archiveDate=(case when @archived=1 and archiveDate is null then getDate() else archiveDate end),className=@className,certID=@certID,courseID=@courseID,projectID=@projectID,adviserID=@adviserID,host=@host,teacher=@teacher,kindID=@kindID,status=@status,dateStart=@dateStart,dateEnd=@dateEnd,classroom=@classroom,timetable=@timetable,summary=@summary,transaction_id=@transaction_id,signatureType=@signatureType,memo=@memo where ID=@ID
	end
	select @ID as re
END
GO

-- CREATE DATE: 2015-01-12
-- 根据给定的参数，删除班级数据，并写日志
-- 如果班级有学生，则不能删除。
-- USE CASE: exec delClassInfo 1
CREATE PROCEDURE [dbo].[delClassInfo]
	@classID varchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @re int, @msg varchar(50)
	select @re=0,@msg='成功删除。'
	if exists(select 1 from classInfo where classID=@classID)
	begin
		if not exists(select 1 from studentCourseList where classID=@classID)
		begin
			delete from classInfo where classID=@classID
			-- 写操作日志
			exec writeOpLog '','删除班级','class',@registerID,@memo,@classID
		end
		else
			select @re=2,@msg='该班级还有学员，不能删除。'
	end
	else
		select @re=1,@msg='没有要删除的记录。'

	select @re as i, @msg as msg
END

GO

-- CREATE DATE: 2021-04-08
-- 根据给定的参数，添加或者更新缴费信息
-- USE CASE: exec updatePayInfo 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updatePayInfo]
	@ID int,@invoice varchar(50),@projectID varchar(50),@title nvarchar(100),@kindID varchar(50),@type int,@status int,@datePay varchar(50),@dateInvoice varchar(50),@dateInvoicePick varchar(50),@username varchar(50),@memo varchar(2000),@registerID varchar(50),@re int output
AS
BEGIN
	declare @event varchar(50),@payGroup int,@i int,@deptID int
	if @datePay='' set @datePay=null
	if @dateInvoice='' set @dateInvoice=null
	if @dateInvoicePick='' set @dateInvoicePick=null
	
	if @ID=0	-- 新纪录
	begin
		select @payGroup = payGroup,@i=0 from projectInfo where projectID=@projectID
		select @deptID=dept1 from studentInfo where username=@username
		--团体发票只生成一次
/*		if @kindID=1 and @payGroup=0 and exists(select 1 from payInfo where projectID=@projectID and kindID=1)
		begin
			select @ID=max(ID) from payInfo where projectID=@projectID and kindID=1
			select @i=1
		end
		if @kindID=1 and @payGroup=1 and exists(select 1 from payInfo where projectID=@projectID and kindID=1 and deptID=@deptID)
		begin
			select @ID=max(ID) from payInfo where projectID=@projectID and kindID=1 and deptID=@deptID
			select @i=1
		end
*/
		if @i=0
		begin
			insert into payInfo(invoice,projectID,title,kindID,type,status,deptID,datePay,dateInvoice,dateInvoicePick,memo,registerID) values(@invoice,@projectID,@title,@kindID,@type,@status,@deptID,@datePay,@dateInvoice,@dateInvoicePick,@memo,@registerID)
			select @event='新增',@ID=max(ID) from payInfo where registerID=@registerID and projectID=@projectID
		end
	end
	else
	begin
		update payInfo set invoice=@invoice,projectID=@projectID,title=@title,kindID=@kindID,type=@type,status=@status,datePay=@datePay,dateInvoice=@dateInvoice,dateInvoicePick=@dateInvoicePick,memo=@memo where ID=@ID
		select @event='修改'
	end
	-- 写操作日志
	exec writeOpLog '',@event,'pay',@registerID,@invoice,@ID
	select @re=@ID
END
GO

-- CREATE DATE: 2021-04-08
-- 根据给定的参数，更新发票金额
-- USE CASE: exec [updatePayAmount] 1
CREATE PROCEDURE [dbo].[updatePayAmount]
	@ID int
AS
BEGIN
	declare @amount int
	select @amount = sum(price) from payDetailInfo where payID=@ID
	update payInfo set amount=isnull(@amount,0) where ID=@ID
END
GO

-- CREATE DATE: 2021-04-08
-- 根据给定的参数，更新缴费金额，并更新发票金额
-- USE CASE: exec [updatePayPrice] 1
CREATE PROCEDURE [dbo].[updatePayPrice]
	@ID int,@price int
AS
BEGIN
	declare @payID int
	select @payID = payID from payDetailInfo where ID=@ID
	update payDetailInfo set price=isnull(@price,0) where ID=@ID
	exec updatePayAmount @payID
END
GO

-- CREATE DATE: 2024-04-27
-- 判断给定学员报名指定课程是否超年龄。如果为退休前60以上返回0不超龄，返回1 超龄，返回2 不满18岁。
ALTER FUNCTION [dbo].[getRetireDayDiff]
(	
	@username varchar(50), @certID varchar(50)
)
RETURNS int 
AS
BEGIN
	declare @re int, @retireAge int, @agencyID int, @retireDay int, @birthday smalldatetime, @sex int, @age int
	select @agencyID=agencyID,@re=0 from certificateInfo where certID=@certID
	if @agencyID=1 and @certID<>'C16'
	begin
		if len(@username)=18
			select @sex = cast(substring(@username,17,1) as int) % 2, @birthday=substring(@username,7,8), @age = (year(getDate())*10000 + month(getDate())*100 + day(getDate()) - substring(@username,7,4)*10000 - substring(@username,11,2)*100 - substring(@username,13,2))/10000
		else
			select @sex=sex, @birthday=birthday, @age=age from studentInfo where username=@username
		select @retireAge=(case when @sex=1 then 60 when @certID='C16' or @certID='C17' then 55 else 50 end)
		if @age>=18
			select @re=iif(datediff(d,getDate(),DATEADD(yy,@retireAge,@birthday))>60,0,1)
		else
			select @re=2
	end
	RETURN isnull(@re,0)
END
GO

-- =============================================
-- CREATE DATE: 2020-11-28
-- 为给定招生批次的给定学员报名
-- USE CASE: exec [doEnter] 'P-20-001', 'albert'
-- =============================================
ALTER PROCEDURE [dbo].[doEnter] 
	@ID int,@username varchar(50),@classID varchar(50),@price int,@amount int,@invoice varchar(50),@receipt varchar(50),@invoice_amount int,@projectID varchar(50),@title nvarchar(100),@payNow int,@needInvoice int,@kindID varchar(50),@type int,@status int,@datePay varchar(50),@dateInvoice varchar(50),@dateInvoicePick varchar(50),@pay_memo varchar(500),@currDiplomaID varchar(50),@currDiplomaDate varchar(50),@overdue int,@express int,@fromID varchar(50),@fromKind varchar(50),@source nvarchar(50),@oldNo int,@memo varchar(2000),@host varchar(50),@registerID varchar(50)
AS
BEGIN
	declare @event varchar(50),@mem varchar(500),@cID int,@name varchar(50),@certID varchar(50),@courseID varchar(50),@refID int,@t int,@payID int,@re int,@msg varchar(50),@SNo int,@mark int,@reexamine int,@pNo varchar(50),@certName varchar(60),@unit varchar(100),@job_status int,@education int,@mobile varchar(50),@email varchar(50),@address varchar(200),@today varchar(50),@signatureType int
	declare @retireDay int, @hasLesson int, @receipt0 varchar(50),@pre int

	if @classID='' or @classID='null' set @classID=null
	if @currDiplomaDate='' or @currDiplomaDate='null' set @currDiplomaDate=null
	if @currDiplomaID='' or @currDiplomaID='null' set @currDiplomaID=null
	select @re=0,@msg=iif(@ID=0,'报名成功。','保存成功。'),@hasLesson=0, @datePay=[dbo].[whenull](@datePay,null), @username=upper(@username), @host=[dbo].[whenull](@host,''), @receipt=[dbo].[whenull](@receipt,null),@receipt0='', @source=[dbo].[whenull](@source,null)
	select @cID = ID, @signatureType=signatureType, @pre=pre from classInfo where classID=@classID
	if @source is null
		select @source=title from hostInfo where hostNo=@host and @host<>'znxf'

	if @ID=0	--新的报名
	begin
		select @SNo=0,@mark=0,@retireDay=1000
		if @projectID=''	--导入班级的名单
		begin
			select @projectID=[dbo].[pf_getStrArrayOfIndex](projectID,',',0) from classInfo where classID=@classID
			select @price=price from projectInfo where projectID=@projectID
			select @certID=certID,@courseID=courseID from classInfo where classID=@classID
			if @price=0
				select @price=price from courseInfo where courseID=@courseID
		end
		else
		begin
			select @certID=certID,@reexamine=reexamine from projectInfo where projectID=@projectID
			select @courseID=courseID from courseInfo where certID=@certID and reexamine=@reexamine
		end
		select @retireDay=[dbo].[getRetireDayDiff](@username,@certID)

		if len(@username)>1 and exists(select 1 from studentCourseList where username=@username and courseID=@courseID and status<2)
			select @re=1,@msg='该课程已经报名且未结束，不能重复。'
		if @retireDay>0
			select @re=2,@msg=iif(@retireDay=1,'该学员已距退休不足60天，不能报名。','不满18岁不能报名。')

		if @re=0
		begin
			--添加证书项目
			select @host = iif(@host='',host,@host),@name=name,@job_status=job_status,@education=education,@unit=(case when host='znxf' then unit else hostName end),@address=address,@mobile=mobile,@email=email from v_studentInfo where username=@username
			insert into studentCertList(username,certID,reexamine,host,registerID) values(@username,@certID,@reexamine,@host,@registerID)
			select @refID=max(ID) from studentCertList where username=@username
			select @t=type,@certName=certName,@today=convert(varchar(20),getDate(),23) from certificateInfo where certID=@certID
			--if @host not in('znxf','shm','spc') and @price=0
			--	select @status=1	--合作单位默认已付
			--合作单位设为未付费、后付费
			if @host not in('znxf','spc','shm')
				select @payNow = 1, @status=0
			
			--添加课程
			--从预报名表里查找编号
			exec lookRefSNo @cID, @username, @name, @pNo output, @mark output
			declare @saler varchar(50)
			exec [setStudentSaler] @username, @fromID, @saler output
			--select @title=(case when @title>'' then @title else invoice end) from ref_student_spc where username=@username and classID=@cID
			--预报名表内人员自动确认：mark=0 , checked=1
			--insert into studentCourseList(username,courseID,refID,reexamine,type,hours,closeDate,projectID,classID,SNo,checked,checkDate,checker,submited,submitDate,submiter,host,registerID) select @username,courseID,@refID,@reexamine,@t,hours,dateadd(d,period,getDate()),@projectID,@classID,@pNo,(case when @mark=0 then 1 else 0 end),(case when @mark=0 then getDate() else null end),(case when @mark=0 then 'system.' else null end),1,getDate(),@registerID,@host,@registerID from courseInfo where courseID=@courseID
			insert into studentCourseList(username,courseID,refID,reexamine,payNow,needInvoice,title,pay_kindID,pay_type,pay_status,price,amount,noReceive,invoice,receipt,invoice_amount,dateInvoice,dateInvoicePick,datePay,pay_checker,pay_memo,type,hours,closeDate,projectID,classID,SNo,checked,checkDate,checker,submited,submitDate,submiter,currDiplomaID,currDiplomaDate,overdue,express,fromID,fromKind,source,oldNo,signatureType,memo,host,registerID) 
				select @username,courseID,@refID,@reexamine,@payNow,@needInvoice,@title,@kindID,@type,@status,@price,@amount,iif(@type=3 and @status=1,1,0),@invoice,@receipt,@invoice_amount,[dbo].[whenull](@dateInvoice,null),[dbo].[whenull](@dateInvoicePick,null),iif(@datePay>'',@datePay,iif(@status=1,getDate(),null)),iif(@status=1,@registerID,null),@pay_memo,@t,hours,dateadd(d,period,getDate()),@projectID,@classID,@pNo,1,getDate(),'system.',1,getDate(),@registerID,@currDiplomaID,@currDiplomaDate,@overdue,@express,@saler,@fromKind,@source,@oldNo,@signatureType,@memo,@host,@registerID from courseInfo where courseID=@courseID
			select @ID=max(ID) from studentCourseList where username=@username
	
			if @certID='C20' or @certID='C20A' or @certID='C21'	--消防员添加额外报名信息
				insert into firemanEnterInfo(enterID,kind5,kind4,registerID) values(@ID,(case when @certID='C20' or @certID='C20A' then 3 else 4 end),(case when @certID='C20A' then 1 else 0 end),@registerID)

			--更新单位信息
			if @host='spc'
				update studentInfo set linker=(case when a.linker is null then b.linker else a.linker end), phone=(case when a.phone is null then b.phone else a.phone end), address=(case when a.address is null then b.address else a.address end) from studentInfo a, deptInfo b where a.dept2=b.deptID and a.username=@username

			-- 写操作日志
			--exec writeOpLog @host,@event,'user',@registerID,@memo,@refID
			select @event='报名',@mem=@projectID
			exec writeOpLog '',@event,'enter',@registerID,@mem,@ID

			--向HR系统发送数据
			--exec eHR.[dbo].[updateResumeInfo1] @username,@name,'Z00001',0,@job_status,0,@unit,@education,@mobile,@email,'',@address,'','','','',0,'','system.'
			--exec eHR.[dbo].updateHunterDetail 0,'education',@username,'上海智能消防学校',@certName,@today,'',0,'','system.'
		end
	end
	else	--修改报名信息
	begin
		declare @oldClass varchar(50), @autoPay int
		select @oldClass=classID, @pNo=SNo, @autoPay=autoPay,@courseID=courseID, @receipt0=isnull(receipt,'') from studentCourseList where ID=@ID
		
		if @classID>'' and (@classID <> @oldClass or @pNo='0')
		begin
			--查找编号,,submited,,
			exec lookRefSNo @cID, @username, @name, @pNo output, @mark output
		end
		--先保存记录
		insert into del_studentCourseList select *,getDate(),'修改报名信息:' + @registerID from studentCourseList where ID=@ID
		if @autoPay=0
		begin
			if @dateInvoice>'' and @invoice>'' and exists(select 1 from studentCourseList where ID=@ID and (dateInvoice is null or dateInvoice=''))
				update studentCourseList set dateInvoice=@dateInvoice where invoice=@invoice and ID<>@ID	--团体发票更新开票日期
			update studentCourseList set source=iif(@source>'',@source,source),host=@host,overdue=@overdue,express=@express,fromID=dbo.whenull(@fromID,null),fromKind=@fromKind,classID=@classID,SNo=@pNo,noReceive=iif(@type=3 and @status=1 and noReceive=0,1,noReceive),checked=1,checkDate=iif(checkDate is null,getDate(),checkDate),checker=iif(checker is null,@registerID,checker),submited=1,submitDate=iif(submitDate is null,getDate(),submitDate),submiter=iif(submiter is null,@registerID,submiter),pay_memo=@pay_memo,signatureType=@signatureType,payNow=@payNow,needInvoice=@needInvoice,title=@title,pay_kindID=@kindID,pay_type=@type,pay_status=@status,price=@price,amount=@amount,invoice=@invoice,receipt=@receipt,invoice_amount=@invoice_amount,dateInvoice=[dbo].[whenull](@dateInvoice,null),dateInvoicePick=[dbo].[whenull](@dateInvoicePick,null),datePay=iif(@datePay>'' and @status>0,@datePay,iif(@status=1 and pay_status=0 and datePay is null,getDate(),datePay)),pay_checker=iif(@status=1 and pay_status=0 and pay_checker is null,@registerID,pay_checker),currDiplomaID=@currDiplomaID,currDiplomaDate=@currDiplomaDate,memo=@memo where ID=@ID
		end
		else
			update studentCourseList set source=@source,host=@host,overdue=@overdue,express=@express,fromID=dbo.whenull(@fromID,null),fromKind=@fromKind,classID=@classID,SNo=@pNo,checked=1,checkDate=iif(checkDate is null,getDate(),checkDate),checker=iif(checker is null,@registerID,checker),submited=1,submitDate=iif(submitDate is null,getDate(),submitDate),submiter=iif(submiter is null,@registerID,submiter),signatureType=@signatureType,needInvoice=@needInvoice,title=iif(autoInvoice=0,@title,title),invoice=iif(autoInvoice=0,@invoice,invoice),receipt=@receipt,invoice_amount=iif(autoInvoice=0,@invoice_amount,invoice_amount),dateInvoice=iif(autoInvoice=0,[dbo].[whenull](@dateInvoice,null),dateInvoice),dateInvoicePick=[dbo].[whenull](@dateInvoicePick,null),currDiplomaID=@currDiplomaID,currDiplomaDate=@currDiplomaDate,memo=@memo where ID=@ID
		select @event='修改报名信息',@mem=''
		exec writeOpLog '',@event,'enter',@registerID,@mem,@ID

		if exists(select 1 from studentLessonList where refID=@ID)
			select @hasLesson = 1
	end

	if @ID>0 and @receipt>'' and @receipt0=''	  -- 保存最后收据号码
		update dictionaryDoc set item=@receipt where kind='receipt' and ID='0'

	if @ID>0 and @hasLesson = 0	  -- 添加课表信息
	begin
		--添加课表
		insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,b.ID,a.hours,@username from lessonInfo a, studentCourseList b where a.courseID=b.courseID and b.ID=@ID and a.status=0

		--添加课件
		insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,@username from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0

		--添加视频
		insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,@username from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0
	end

	if @ID>0 and not exists(select 1 from studentExamList where refID=@ID)	  -- 添加考试信息
	begin
		--添加考试，题目暂不生成
		if exists(select 1 from  examInfo where courseID=@courseID)
			insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,kind,mark) select @username,examID,@ID,minutes,minutes*60,scoreTotal,scorePass,kindID,0,0 from examInfo where (courseID=@courseID or (courseID is null and certID=@certID)) and status=0
		else
			insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,kind,mark) select @username,examID,@ID,minutes,minutes*60,scoreTotal,scorePass,kindID,0,0 from examInfo where certID=@certID and status=0
	end

	select @re as re,@msg as msg, @payID as payID, @ID as enterID
END
GO

-- =============================================
-- CREATE DATE: 2020-11-28
-- 为给定学员报名所有可选课程（已选的覆盖），不进入班级
-- USE CASE: exec [doEnterDemo] 'P-20-001', 'albert'
-- =============================================
ALTER PROCEDURE [dbo].[doEnterDemo] 
	@username varchar(50)
AS
BEGIN
	declare @certID varchar(50),@courseID varchar(50),@host varchar(50),@refID int,@t int,@re int,@msg varchar(50),@mark int,@ID int,@reexamine int,@pNo varchar(50),@certName varchar(60),@unit varchar(100),@job_status int,@education int,@mobile varchar(50),@email varchar(50),@address varchar(200),@today varchar(50)
	
	--删除已选课程
	delete from studentCoursewareList where refID in(select a.ID from studentLessonList a, studentCourseList b where a.refID=b.ID and b.username=@username)
	delete from studentVideoList where refID in(select a.ID from studentLessonList a, studentCourseList b where a.refID=b.ID and b.username=@username)
	delete from studentQuestionList where refID in(select a.paperID from studentExamList a, studentCourseList b where a.refID=b.ID and b.username=@username)
	delete from studentLessonList where refID in(select ID from studentCourseList where username=@username)
	delete from studentExamList where refID in(select ID from studentCourseList where username=@username)
	delete from studentCertList where username=@username
	delete from studentCourseList where username=@username

	--查找可选课程
	declare rc cursor for select certID,courseID,reexamine from courseInfo where status=0 and host=''
	open rc
	fetch next from rc into @certID,@courseID,@reexamine
	While @@fetch_status=0 
	Begin 
		--添加证书项目
		insert into studentCertList(username,certID,reexamine,host) values(@username,@certID,@reexamine,'znxf')
		select @refID=max(ID) from studentCertList where username=@username
		select @t=type,@certName=certName,@today=convert(varchar(20),getDate(),23) from certificateInfo where certID=@certID

		--添加课程
		insert into studentCourseList(username,courseID,refID,reexamine,type,hours) select @username,courseID,@refID,@reexamine,@t,hours from courseInfo where courseID=@courseID
		select @ID=max(ID) from studentCourseList where username=@username

		--添加课表
		insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,b.ID,a.hours,@username from lessonInfo a, studentCourseList b where a.courseID=b.courseID and b.ID=@ID and a.status=0

		--添加课件
		insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,@username from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0

		--添加视频
		insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,@username from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0

		--添加考试，题目暂不生成
		if exists(select 1 from  examInfo where courseID=@courseID)
			insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,kind,mark) select @username,examID,@ID,minutes,minutes*60,scoreTotal,scorePass,kindID,0,0 from examInfo where (courseID=@courseID or (courseID is null and certID=@certID)) and status=0
		else
			insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,kind,mark) select @username,examID,@ID,minutes,minutes*60,scoreTotal,scorePass,kindID,0,0 from examInfo where certID=@certID and status=0

		fetch next from rc into @certID,@courseID,@reexamine
	End
	Close rc 
	Deallocate rc
END
GO

-- CREATE DATE: 2021-04-08
-- 确定某个报名资料合格
-- USE CASE: exec [doMaterial_check] 1
CREATE PROCEDURE [dbo].[doMaterial_check]
	@ID int,@registerID varchar(50)
AS
BEGIN
	update studentCourseList set materialCheck=1,materialChecker=@registerID where ID=@ID
END
GO

-- CREATE DATE: 2024-08-20
-- 根据给定的参数，删除报名数据，并写日志
-- USE CASE: exec delEnter 1
ALTER PROCEDURE [dbo].[delEnter]
	@ID int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @refID int,@kind int,@n int,@mark int,@re int,@msg varchar(100)
	select @re=1,@msg='未发现要删除的数据'
	if exists(select 1 from diplomaInfo a, v_studentCourseList b where a.diplomaID=b.diplomaID and b.ID=@ID)
		select @re=2,@msg='此次培训已取得证书，不能删除。'
	if exists(select 1 from studentCourseList where ID=@ID and pay_status>0)
		select @re=3,@msg='已有收费记录，不能删除。'
	if @re<2 and exists(select 1 from studentCourseList where ID=@ID)
	begin
		select @refID=refID,@mark=0,@memo=isnull(@memo,'') + '(' + username + ',' + name + ',' + courseName + ',' + classID + ')' from v_studentCourseList where ID=@ID

		--删除试题
		delete from studentQuestionList where refID in(select paperID from studentExamList where refID=@ID and mark=@mark)

		--删除考试
		delete from studentExamList where refID=@ID and mark=@mark

		--删除视频
		delete from studentVideoList where refID in(select ID from studentLessonList where refID=@ID)

		--删除课件
		delete from studentCoursewareList where refID in(select ID from studentLessonList where refID=@ID)

		--删除课表
		delete from studentLessonList where refID=@ID
		--删除课程
			--先保存记录
		insert into del_studentCourseList select *,getDate(),@memo + ':' + @registerID from studentCourseList where ID=@ID
		delete from studentCourseList where ID=@ID
		--删除证书项目
		delete from studentCertList where ID=@refID
		/*
		select @refID=payID from payDetailInfo where enterID=@ID
		select @n=count(*) from payDetailInfo where payID=@refID
		select @kind=kindID from payInfo where ID=@refID
		--如果是团体缴费，只有剩一个人的时候才删除发票。否则不删发票，重新计算开票金额
		if @n>1
			exec updatePayAmount @refID
		else
			delete from payInfo where ID=@refID
			
		delete from payDetailInfo where enterID=@ID
		*/
		-- 写操作日志
		exec writeOpLog '','删除','enter',@registerID,@memo,@ID
		select @re=0,@msg='成功删除'

		if exists(select 1 from passcardInfo where enterID=@ID)
		begin
			select @re=0,@msg='成功删除，但该学员已经制作准考证，请重新调整准考证及考试数据。'
			delete from passcardInfo where enterID=@ID
		end
	end
	select @re as status,@msg as msg
END
GO

-- CREATE DATE: 2015-01-12
-- 根据给定的参数，进行退课处理，并写日志
-- USE CASE: exec returnEnter 1
CREATE PROCEDURE [dbo].[returnEnter]
	@ID int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @refID int,@kind int,@n int,@mark int,@re int,@msg varchar(100)
	select @re=1,@msg='未发现要处理的数据'
	if exists(select 1 from diplomaInfo a, v_studentCourseList b where a.diplomaID=b.diplomaID and b.ID=@ID)
		select @re=2,@msg='此次培训已取得证书，不能退课。'
	if @re<2 and exists(select 1 from studentCourseList where ID=@ID)
	begin
		select @refID=refID,@mark=0,@memo=isnull(@memo,'') + '(' + username + ',' + name + ',' + courseName + ',' + classID + ')' from v_studentCourseList where ID=@ID
		--删除课程
		update studentCourseList set status=3 where ID=@ID
		--删除证书项目
		update studentCertList set status=3 where ID=@refID

		-- 写操作日志
		exec writeOpLog '','退课','enter',@registerID,@memo,@ID
		select @re=0,@msg='成功退课'
	end
	select @re as status,@msg as msg
END
GO

-- CREATE DATE: 2021-04-06
-- 根据给定的参数，添加或者更新准考证信息
-- mark: 0 生成准考证  1 保存信息
-- USE CASE: exec updateGeneratePasscardInfo 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updateGeneratePasscardInfo]
	@mark int,@ID int,@classID varchar(50),@title nvarchar(100), @selList varchar(4000),@startNo int,@startDate varchar(100),@startTime varchar(100),@address nvarchar(100),@notes nvarchar(500),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @n int, @j int, @i int, @re int,@sql varchar(500)
	select @re=@ID

	if @ID=0 and @mark=0	-- 新纪录
	begin
		create table #temp(id int) 
		select @sql ='ALTER table #temp add num int IDENTITY(' + cast(@startNo as varchar) + ',1) NOT NULL'
		exec(@sql)
		if @startDate='' or @startDate = 'null'
			select @startDate = null

		--提取名单
		select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
		while @n>@j
		begin
			insert into #temp values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
			select @j = @j + 1
		end

		--填写生成记录
		insert into generatePasscardInfo(classID,title,qty,startNo,startDate,startTime,address,notes,memo,registerID) values(@classID,@title,@n,@startNo,@startDate,@startTime,@address,@notes,@memo,@registerID)
		select @re=max(ID) from generatePasscardInfo where registerID=@registerID and classID=@classID

		--填写明细
		insert into passcardInfo(refID,enterID,passNo,password) select @re,b.id,replace(@startDate,'-','') + REPLICATE('0',3-len(b.num)) + cast(b.num as varchar),right(a.username,6) from studentCourseList a, #temp b where a.ID=b.id 

		--更新报名表
		update studentCourseList set passcardID=@re from studentCourseList a, #temp b where a.ID=b.id
	end
	if @ID>0 and @mark=1	-- 保存信息
	begin
		update generatePasscardInfo set classID=@classID,title=@title,startDate=@startDate,startTime=@startTime,address=@address,notes=@notes,memo=@memo where ID=@ID
	end
	return @re
END
GO

-- CREATE DATE: 2021-04-06
-- 根据给定的参数，添加或者更新考试信息
-- USE CASE: exec updateGeneratePasscardInfo1 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updateGeneratePasscardInfo1]
	@ID int,@certID varchar(50),@title nvarchar(100),@startNo int,@kindID int,@startDate varchar(100),@startTime varchar(100),@address nvarchar(100),@notes nvarchar(500),@sync int,@sniper varchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @re int, @event varchar(100),@logMemo varchar(500)
	select @re=@ID

	if @ID=0	-- 新纪录
	begin
		--填写生成记录
		insert into generatePasscardInfo(certID,title,startNo,kindID,startDate,startTime,address,notes,sync,sniper,memo,registerID) values(@certID,@title,@startNo,@kindID,@startDate,@startTime,@address,@notes,@sync,@sniper,@memo,@registerID)
		select @re=max(ID),@event='添加考试' from generatePasscardInfo where registerID=@registerID
	end
	if @ID>0	-- 保存信息
	begin
		update generatePasscardInfo set title=@title,kindID=@kindID,startDate=@startDate,startTime=@startTime,address=@address,notes=@notes,sync=@sync,sniper=@sniper,memo=@memo where ID=@ID
		select @event='修改考试'
	end
	-- 写操作日志
	select @logMemo=isnull(@title,'') + ':' + isnull(@startDate,'') + ':' + isnull(@startTime,'') + ':' + isnull(@address,'') + ':' + isnull(@notes,'') + ':' + isnull(@memo,'')
	exec writeOpLog '',@event,'generatePasscard',@registerID,@logMemo,@re
	select @re as re
END
GO

-- CREATE DATE: 2021-04-08
-- 为准考证记录写人文件
-- USE CASE: exec [updateGeneratePasscardFile] 1,'xxxx.pdf'
CREATE PROCEDURE [dbo].[updateGeneratePasscardFile]
	@ID int,@filename varchar(200)
AS
BEGIN
	update generatePasscardInfo set filename=@filename where ID=@ID
END
GO

-- CREATE DATE: 2015-01-12
-- 根据给定的参数，删除准考证数据，并写日志
-- USE CASE: exec delGeneratePasscard 1
ALTER PROCEDURE [dbo].[delGeneratePasscard]
	@ID int,@registerID varchar(50)
AS
BEGIN
	if exists(select 1 from generatePasscardInfo where ID=@ID)
	begin
		delete from generatePasscardInfo where ID=@ID
		-- 删除相关考生的准考证
		delete from passcardInfo where refID=@ID
		update studentCourseList set passcardID=0 where passcardID=@ID
		-- 写操作日志
		exec writeOpLog '','删除准考证','generatePasscard',@registerID,'',@ID
	end
END
GO

-- CREATE DATE: 2015-01-12
-- 根据给定的参数，更新复训证书编号
-- USE CASE: exec setReexamineDiploma 1,'xxx-22'
CREATE PROCEDURE [dbo].[setReexamineDiploma]
	@enterID int,@item varchar(100)
AS
BEGIN
	update studentCourseList set currDiplomaID=@item where ID=@enterID
END
GO


-- CREATE DATE: 2015-01-12
-- 根据给定的参数，关闭，并写日志
-- USE CASE: exec closeClassInfo 1
ALTER PROCEDURE [dbo].[closeClassInfo]
	@ID int, @status int ,@registerID varchar(50)
AS
BEGIN
	declare @classID varchar(50)
	if exists(select 1 from classInfo where ID=@ID)
	begin
		update classInfo set status=@status,dateEnd=(case when @status=2 and dateEnd is null then getDate() else dateEnd end) where ID=@ID
		-- 关闭报名信息
		select @classID=classID from classInfo where ID=@ID
		--if @status=2  --关闭
		--begin
			--update studentCourseList set status=2, closeDate=getDate() where classID=@classID
			--update studentCertList set status=2, closeDate=getDate() from studentCertList a, studentCourseList b where a.ID=b.refID and b.classID=@classID
		--end
		-- 写操作日志
		declare @event varchar(20)
		select @event = (case when @status=0 then '班级开启' when @status=2 then '班级结课' else '班级' end)
		exec writeOpLog '',@event,'class',@registerID,'',@ID
	end
END
GO

-- CREATE DATE: 2015-01-12
-- 根据给定的参数，关闭学员的课程学习，并写日志
-- USE CASE: exec closeStudentCourse 1
CREATE PROCEDURE [dbo].[closeStudentCourse]
	@ID int, @registerID varchar(50)
AS
BEGIN
	if exists(select 1 from studentCourseList where ID=@ID)
	begin
		update studentCourseList set status=2, closeDate=getDate() where ID=@ID
		update studentCertList set status=2, closeDate=getDate() from studentCertList a, studentCourseList b where a.ID=b.refID and b.ID=@ID
		-- 写操作日志
		declare @event varchar(20)
		select @event = '关闭学习'
		exec writeOpLog '',@event,'studentCourse',@registerID,'',@ID
	end
END
GO

-- CREATE DATE: 2015-01-12
-- 根据给定的参数，批量关闭/开启学员的课程学习，并写日志
-- selList: username
-- USE CASE: exec closeStudentCourseBatch 1
ALTER PROCEDURE [dbo].[closeStudentCourseBatch]
	@classID varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	--将名单导入到临时表
	create table #temp(enterID int, username varchar(50))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp(username) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end
	update #temp set enterID=b.ID from #temp a, studentCourseList b where a.username=b.username and b.classID=@classID

	update studentCourseList set closeDate=iif(a.closeDate is null,getDate(),a.closeDate), hold=iif(a.status=2,1,0), status=iif(a.status=2,1,2) from studentCourseList a, #temp b where a.ID=b.enterID
	update studentCertList set closeDate=iif(a.closeDate is null,getDate(),a.closeDate), hold=iif(a.status=2,1,0), status=iif(a.status=2,1,2) from studentCertList a, studentCourseList b, #temp c where a.ID=b.refID and b.ID=c.enterID
	-- 写操作日志
	declare @event varchar(20)
	select @event = '关闭/开启学习'
	exec writeOpLog '',@event,'studentCourse',@registerID,'',@selList
END
GO

-- CREATE DATE: 2023-01-11
-- 根据给定的参数，开启已关闭学员的课程学习，并写日志
-- USE CASE: exec reviveStudentCourse 1
CREATE PROCEDURE [dbo].[reviveStudentCourse]
	@ID int, @registerID varchar(50)
AS
BEGIN
	if exists(select 1 from studentCourseList where ID=@ID)
	begin
		update studentCourseList set status=1, closeDate=null where ID=@ID
		update studentCertList set status=1, closeDate=null from studentCertList a, studentCourseList b where a.ID=b.refID and b.ID=@ID
		-- 写操作日志
		declare @event varchar(20)
		select @event = '重启学习'
		exec writeOpLog '',@event,'studentCourse',@registerID,'',@ID
	end
END
GO


-- CREATE DATE: 2021-04-06
-- 根据给定的参数，添加或者更新消防员报名信息
-- USE CASE: exec updateFiremanEnterInfo 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updateFiremanEnterInfo]
	@enterID int,@area varchar(50),@address varchar(100),@employDate varchar(50),@university varchar(100),@gradeDate varchar(50),@profession varchar(50),@area_now varchar(50),@kind1 int,@kind2 int,@kind3 int,@kind4 int,@kind5 int,@kind6 int,@kind7 int,@kind8 int,@kind9 int,@kind10 int,@kind11 int,@kind12 int,@memo varchar(500),@registerID varchar(50)
AS
BEGIN
	declare @re int, @msg varchar(100)
	if @employDate='' set @employDate=null
	if @gradeDate='' set @gradeDate=null
	
	if not exists(select 1 from firemanEnterInfo where enterID=@enterID)	-- 新纪录
	begin
		insert into firemanEnterInfo(enterID,area,address,employDate,university,gradeDate,profession,area_now,kind1,kind2,kind3,kind4,kind5,kind6,kind7,kind8,kind9,kind10,kind11,kind12,memo,registerID) 
		values(@enterID,@area,@address,@employDate,@university,@gradeDate,@profession,@area_now,@kind1,@kind2,@kind3,@kind4,@kind5,@kind6,@kind7,@kind8,@kind9,@kind10,@kind11,@kind12,@memo,@registerID)
	end
	else
	begin
		update firemanEnterInfo set area=@area,address=@address,employDate=@employDate,university=@university,gradeDate=@gradeDate,profession=@profession,area_now=@area_now,kind1=@kind1,kind2=@kind2,kind3=@kind3,kind4=@kind4,kind5=@kind5,kind6=@kind6,kind7=@kind7,kind8=@kind8,kind9=@kind9,kind10=@kind10,kind11=@kind11,kind12=@kind12,memo=@memo where enterID=@enterID
	end
	select isnull(@re,0) as status, isnull(@msg,'') as msg
END
GO

-- CREATE DATE: 2021-05-13
-- 根据给定的参数，填写消防员报名材料文件路径
-- USE CASE: exec updateFiremanMaterials 1
ALTER PROCEDURE [dbo].[updateFiremanMaterials]
	@enterID int,@filename varchar(200),@filename1 varchar(200)
AS
BEGIN
	if exists(select 1 from firemanEnterInfo where enterID=@enterID)
	begin
		update firemanEnterInfo set materials=@filename,materials1=@filename1 where enterID=@enterID
	end
END
GO

-- CREATE DATE: 2021-05-13
-- 根据给定的参数，填写身份证正反面文件路径
-- USE CASE: exec updateIDcardsMaterials 1
CREATE PROCEDURE [dbo].[updateIDcardsMaterials]
	@username varchar(50),@filename varchar(200)
AS
BEGIN
	update studentInfo set IDa_filename=@filename where username=@username
END
GO

-- CREATE DATE: 2021-05-13
-- 根据给定的参数，填写消防员报名材料文件路径
-- USE CASE: exec updateFiremanZip 1
CREATE PROCEDURE [dbo].[updateFiremanZip]
	@enterID int,@zip varchar(200)
AS
BEGIN
	if exists(select 1 from firemanEnterInfo where enterID=@enterID)
	begin
		update firemanEnterInfo set zip=@zip where enterID=@enterID
	end
END
GO

-- CREATE DATE: 2023-02-17
-- 根据给定的参数，填写报名材料文件路径
-- type: m materials; p photos; e entryforms
-- USE CASE: exec updateMaterialZip 1
ALTER PROCEDURE [dbo].[updateMaterialZip]
	@refID varchar(50),@kind varchar(50),@type varchar(50),@zip varchar(200)
AS
BEGIN
	if @kind='class' and @type='m'
		update classInfo set zip=@zip where classID=@refID
	if @kind='class' and @type='p'
		update classInfo set pzip=@zip where classID=@refID
	if @kind='class' and @type='e'
		update classInfo set ezip=@zip where classID=@refID
	if @kind='apply' and @type='m'
		update generateApplyInfo set zip=@zip where ID=@refID
	if @kind='apply' and @type='p'
		update generateApplyInfo set pzip=@zip where ID=@refID
	if @kind='apply' and @type='e'
		update generateApplyInfo set ezip=@zip where ID=@refID
END
GO

-- CREATE DATE: 2023-02-16
-- 根据给定的参数，填写学员报名材料文件路径
-- USE CASE: exec updateEnterMaterials 1
ALTER PROCEDURE [dbo].[updateEnterMaterials]
	@enterID int,@filename1 varchar(200),@filename2 varchar(200),@filename3 varchar(200),@filename4 varchar(200)
AS
BEGIN
	update studentCourseList set file1=(case when @filename1>'' then @filename1 else file1 end), 
	file2=(case when @filename2>'' then @filename2 else file2 end), 
	file3=(case when @filename3>'' then @filename3 else file3 end),
	file4=(case when @filename4>'' then @filename4 else file4 end)
	where ID=@enterID
	declare @username varchar(50), @c varchar(50)
	select @username=username, @c=b.certID from studentCourseList a, courseInfo b where a.courseID=b.courseID and a.ID=@enterID
	if @c='C21' or @c='C20A'
		set @c='C20'
	if @c='C30' or @c='C31' or @c='C32' or @c='C35' or @c='C18' or @c='C19' or @c='C36' or @c='C37' or @c='C22' or @c='C23'
		set @c='C2'
	if @c='C24' or @c='C25' or @c='C26' or @c='C25B' or @c='C26B' or @c='C14' or @c='C15' or @c='C27' or @c='C27B'
		set @c='C12'
	if @c='C17'
		set @c='C16'
	select @username as username, @c as entryForm
END
GO

-- =============================================
-- CREATE DATE: 2020-11-28
-- 处理消防员报名名单
-- exec [dbo].[dealFiremanList]
-- =============================================
ALTER PROCEDURE [dbo].[dealFiremanList] 
AS
BEGIN
	declare @username varchar(50),@name varchar(50),@classID varchar(50),@price int,@projectID varchar(50),@kindID varchar(50),@type int,@status int,@memo varchar(2000),@registerID varchar(50)
	declare @certID varchar(50),@courseID varchar(50),@host varchar(50),@refID int,@t int,@payID int,@re int,@msg varchar(50),@SNo int,@mark int,@ID int,@reexamine int
	declare @edu int,@edu1 int,@unit varchar(100),@companyID int,@deptID int,@mobile varchar(50)
	select @re=0,@SNo=0,@mark=0,@kindID=0,@type=0,@status=0,@memo='',@registerID='albert.'
	
	declare rc cursor for select username,name,projectID,classID,edu,edu1,mobile,fee,unit,companyID,deptID,ID,(case when companyID=46 then 'znxf' else 'shm' end) from import_student_fireman where mark=1
	open rc
	fetch next from rc into @username,@name,@projectID,@classID,@edu,@edu1,@mobile,@price,@unit,@companyID,@deptID,@SNo,@host
	While @@fetch_status=0 
	Begin 
		--添加人员
		if not exists(select 1 from studentInfo where username=@username)
			insert into studentInfo(host,userName,name,kindID,companyID,dept1,job_status,mobile,education,unit,birthday,sex,age,registerID) 
				values(@host,upper(@username),@name,0,@companyID,@deptID,0,@mobile,@edu,@unit,substring(@username,7,8),dbo.getSexfromID(@username),dbo.getAgefromID(@username),@registerID)
		select @certID=certID,@reexamine=reexamine from projectInfo where projectID=@projectID
		select @courseID=courseID from courseInfo where certID=@certID and reexamine=@reexamine
		if not exists(select 1 from studentCourseList where username=@username and courseID=@courseID and status<2)
		begin
			--添加证书项目
			insert into studentCertList(username,certID,host,registerID) values(@username,@certID,@host,@registerID)
			select @refID=max(ID) from studentCertList where username=@username
			select @t=type from certificateInfo where certID=@certID

			--添加课程
			insert into studentCourseList(username,courseID,refID,reexamine,type,hours,closeDate,projectID,classID,SNo,host,registerID) select @username,courseID,@refID,@reexamine,@t,hours,dateadd(d,period,getDate()),@projectID,@classID,isnull(@SNo,0),@host,@registerID from courseInfo where certID=@certID and reexamine=@reexamine
			select @ID=max(ID) from studentCourseList where username=@username
	
			--消防员添加报名信息
			insert into firemanEnterInfo(enterID,kind1,kind2,kind4,kind5,kind6,kind10,kind11,kind12,registerID) values(@ID,0,2,(case when @courseID='L20A' then 1 else 0 end),(case when @courseID='L20' or @courseID='L20A' then 3 else 4 end),0,(case when @host='shm' then 3 else 5 end),(case when len(@unit)<4 then 1 else 0 end),@edu1,@registerID)

			--添加付款记录
			exec updatePayInfo 0,'',@projectID,@name,@kindID,@type,@status,'','','',@username,@memo,@registerID,@payID output

			--添加付款明细
			insert into payDetailInfo(payID,enterID,price,memo,registerID) values (@payID,@ID,@price,@memo,@registerID)
			exec updatePayAmount @payID
		end
		fetch next from rc into @username,@name,@projectID,@classID,@edu,@edu1,@mobile,@price,@unit,@companyID,@deptID,@SNo,@host
	End
	Close rc 
	Deallocate rc

END
GO

-- CREATE DATE: 2021-05-13
-- 根据给定的参数，修改班级信息和编号
-- USE CASE: exec updateEnterClass 1
ALTER PROCEDURE [dbo].[updateEnterClass]
	@enterID int,@classID varchar(200),@SNo varchar(50),@currDiplomaID varchar(50),@currDiplomaDate varchar(50),@signatureDate varchar(50),@title nvarchar(100),@payNow int,@overdue int,@fromID varchar(50),@registerID varchar(50)
AS
BEGIN
	declare @courseID varchar(50),@diplomaID varchar(50),@refID int,@signatureType int
	if @currDiplomaDate='' or @currDiplomaDate='null' set @currDiplomaDate=null
	if @signatureDate='' or @signatureDate='null' set @signatureDate=null
	if @currDiplomaID='' or @currDiplomaID='null' set @currDiplomaID=null
	if @fromID='' or @fromID='null' set @fromID=null
	if @classID='' or @classID='null' set @classID=null

	if exists(select 1 from studentCourseList where ID=@enterID)
	begin
		declare @certID varchar(50),@oldClass varchar(50),@pNo varchar(50),@cID int,@username varchar(50),@name varchar(50),@mark int
		select @certID=certID,@oldClass=classID,@username=username,@name=name,@mark=0,@courseID=courseID,@diplomaID=diplomaID,@refID=refID from v_studentCourseList where ID=@enterID
		select @signatureType=1
		if @classID>''
			select @cID = ID, @signatureType=signatureType from classInfo where classID=@classID
		
		if @classID <> @oldClass or @SNo='0' or @SNo=''
		begin
			--从预报名表里查找编号
			exec lookRefSNo @cID, @username, @name, @pNo output, @mark output
		end
		else
			select @pNo = @SNo

		/**/
		--update studentCourseList set classID=@classID,SNo=@pNo,submited=1,submitDate=(case when submitDate is null then GETDATE() else submitDate end),submiter=@registerID,checked=(case when @mark=0 then 1 else checked end),checkDate=(case when @mark=0 then GETDATE() else checkDate end),checker=(case when @mark=0 and checker is null then 'system.' else checker end) where ID=@enterID
		update studentCourseList set payNow=iif(@payNow<9,@payNow,payNow),title=iif(@title>'',@title,title),signatureDate=iif(@signatureDate is null,signatureDate,@signatureDate),status=(case when @diplomaID='' and status=2 then 0 else status end),classID=@classID,SNo=@pNo,overdue=@overdue,submited=iif(@classID>'',1,submited),submitDate=(case when @classID>'' and submitDate is null then GETDATE() else submitDate end),submiter=iif(@classID>'',@registerID,submiter),checked=iif(@classID>'',1,checked),checkDate=(case when @classID>'' and checkDate is null then GETDATE() else checkDate end),checker=(case when @classID>'' and checker is null then 'system.' else checker end),currDiplomaID=(case when @currDiplomaID is null then currDiplomaID else @currDiplomaID end),currDiplomaDate=(case when @currDiplomaDate is null then currDiplomaDate else @currDiplomaDate end),fromID=@fromID,signatureType=@signatureType where ID=@enterID
		update studentCertList set status=(case when @diplomaID='' and status=2 then 0 else status end) where ID=@refID
		if @certID='C20' or @certID='C20A' or @certID='C21' and not exists(select 1 from firemanEnterInfo where enterID=@enterID)	--消防员添加额外报名信息
			insert into firemanEnterInfo(enterID,kind4,kind5,registerID) values(@enterID,(case when @certID='C20A' then 1 else 0 end),(case when @certID='C20' then 3 else 4 end),@registerID)

		if not exists(select 1 from studentLessonList where refID=@enterID)
		begin
			--添加课表
			insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,b.ID,a.hours,@username from lessonInfo a, studentCourseList b where a.courseID=b.courseID and b.ID=@enterID and a.status=0

			--添加课件
			insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,@username from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@enterID and a.status=0

			--添加视频
			insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,@username from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@enterID and a.status=0

			--添加考试，题目暂不生成
			if exists(select 1 from  examInfo where courseID=@courseID)
				insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,kind,mark) select @username,examID,@enterID,minutes,minutes*60,scoreTotal,scorePass,kindID,0,0 from examInfo where (courseID=@courseID or (courseID is null and certID=@certID)) and status=0
			else
				insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,kind,mark) select @username,examID,@enterID,minutes,minutes*60,scoreTotal,scorePass,kindID,0,0 from examInfo where certID=@certID and status=0
		end
	end
END
GO

-- CREATE DATE: 2021-05-13
-- 根据给定的参数，获取该批次的证书列表
-- USE CASE: exec getDiplomaListByBatchID 1
ALTER PROCEDURE [dbo].[getDiplomaListByBatchID]
	@batchID int
AS
BEGIN
	declare @certID varchar(50)
	select @certID=certID from generateDiplomaInfo where ID=@batchID
	if @certID > ''
	begin
		if @certID in('C3','C4','C5','C6','C7','C8')
			SELECT ID,diplomaID,name,sexName,certID,certName,startDate,convert(varchar(20),dateadd(y,-1,dateadd(yy,term,startDate)),23) as endDate,term,host,dept1Name,title,job,logo,photo_filename,stamp,score,trainingDate,birthday FROM v_diplomaInfo where batchID=@batchID
		--if @certID in('C1','C2','C22','C23')
		else
			--SELECT ID,(case when @certID='C2' then '易燃易爆危险物品从业人员' when @certID='C31' then '动火作业' else certName end) as title,diplomaID,username,name,sexName,birthday,certID,(case when @certID='C31' then '动火作业' else certName end) as certName,startDate,endDate,term,(case when host<>'spc' and host<>'shm' then unit when host='spc' and kindID=1 then dept1Name when host='spc' and dept1=9 then '上海石油分公司物流中心' else hostName end) as hostName,(case when host='spc' and dept1=9 and job='' then '油品储运工' else job end) as job,educationName,'No.' + replace(space(7-len(serial))+cast(serial as varchar),' ','0') as diplomaNo,photo_filename,[dbo].[fn_formatDate](class_startDate,0) as class_startDate,[dbo].[fn_formatDate](class_endDate,0) as class_endDate FROM v_diplomaInfo where batchID=@batchID order by diplomaID
			SELECT ID,(case when @certID='C2' then '易燃易爆危险物品从业人员' else certName end) as title,diplomaID,username,name,sexName,birthday,certID,certName,startDate,endDate,term,(case when host<>'spc' and host<>'shm' then unit when host='spc' and kindID=1 then dept1Name when host='spc' and dept1=9 then '上海石油分公司物流中心' else hostName end) as hostName,(case when host='spc' and dept1=9 and job='' then '油品储运工' else job end) as job,educationName,'No.' + replace(space(7-len(serial))+cast(serial as varchar),' ','0') as diplomaNo,photo_filename,[dbo].[fn_formatDate](class_startDate,0) as class_startDate,[dbo].[fn_formatDate](class_endDate,0) as class_endDate FROM v_diplomaInfo where batchID=@batchID order by diplomaID
	end
END
GO


-- CREATE DATE: 2021-04-06
-- 根据给定的参数，添加或者更新证书信息
-- USE CASE: exec updateGenerateDiplomaInfo 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updateGenerateDiplomaInfo]
	@ID int,@certID varchar(50), @selList varchar(4000),@startDate varchar(50),@class_startDate varchar(50),@class_endDate varchar(50),@printed int,@printDate varchar(50),@delivery int,@deliveryDate varchar(50),@styleID int,@host nvarchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @n int, @j int, @i int, @re int,@sql varchar(500),@submitDate varchar(50),@firstID varchar(50),@lastID varchar(50),@term int, @code varchar(50),@username varchar(50),@refID int,@serial int,@d int,@enterID int
	--select @class_startDate=dateStart,@class_endDate=dateEnd from v_classInfo where classID=@classID
	select @re=@ID,@certID=certID,@term=term from certificateInfo where certID=@certID
	create table #temp(id varchar(50), courseID int) 
	if @printDate='' or @printDate = 'null'
		select @printDate = null
	if @deliveryDate='' or @deliveryDate = 'null'
		select @deliveryDate = null
	if @startDate='' or @startDate = 'null'
		select @startDate = convert(varchar(20),getDate(),23)

	if @ID=0	-- 新纪录
	begin
		--提取名单
		select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0,@i=0
		while @n>@j
		begin
			insert into #temp(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
			select @j = @j + 1
		end
		if @certID not in('C20','C20A','C21')
			update #temp set courseID=b.ID from #temp a, studentCourseList b where a.id=b.refID
		else
			update #temp set courseID=b.ID, id=c.ID from #temp a, studentCourseList b, studentCertList c where a.id=b.username and b.refID=c.ID and c.certID=@certID
		--禁止重复生成证书
		delete from #temp where id in(select b.ID from #temp a, studentCertList b where a.id=b.ID and b.diplomaID>'')
		select @n=count(*) from #temp
		
		--填写生成记录
		insert into generateDiplomaInfo(certID,firstID,lastID,startDate,class_startDate,class_endDate,printed,printDate,delivery,deliveryDate,styleID,host,memo,registerID) values(@certID,@firstID,@lastID,@startDate,@class_startDate,@class_endDate,@printed,@printDate,@delivery,@deliveryDate,@styleID,@host,@memo,@registerID)
		if @n>0
		begin
			select @re=max(ID) from generateDiplomaInfo where registerID=@registerID and certID=@certID

			--declare rc cursor for select b.id,username,ceiling(hours*1.00/8),submitDate,c.dateStart from v_studentCourseList a, #temp b, v_classInfo c where a.ID=b.courseID and a.classID=c.classID order by SNo
			declare rc cursor for select b.id,a.ID,a.username from v_studentCourseList a, #temp b where a.ID=b.courseID order by SNo
			open rc
			fetch next from rc into @refID,@enterID,@username
			While @@fetch_status=0 
			Begin 
				select @i = @i + 1
				exec setAutoCode @host,@certID,@code output, @serial out		--获取证书编号
				--生成证书，证书发放日期为给定日期
				--if @submitDate<@class_startDate
				--	select @submitDate=@class_startDate
				insert into diplomaInfo(diplomaID,username,certID,batchID,refID,term,startDate,endDate,class_startDate,class_endDate,serial,filename,host,registerID) select @code,@username,@certID,@re,@refID,@term,@startDate,dateadd(d,-1,dateadd(yy,@term,@startDate)),@class_startDate,@class_endDate,@serial,'/upload/students/diplomas/' + @code + '.pdf',host,@registerID from studentCourseList where ID=@enterID
				--if @certID not in('C20','C20A','C21')
					update studentCertList set diplomaID=@code,closeDate=(case when closeDate is null then getDate() else closeDate end) where id=@refID
				if @i = 1
					set @firstID = @code
				set @lastID = @code
				fetch next from rc into @refID,@enterID,@username
			End
			Close rc 
			Deallocate rc
			update generateDiplomaInfo set firstID=@firstID,lastID=@lastID,qty=@i,filename='/upload/students/diplomaPublish/' + cast(@re as varchar) + '.pdf' where ID=@re
		end
		drop table #temp
	end
	else
	begin
		--重新生成证书
		select @term=iif(term>0,term,@term) from generateDiplomaInfo where ID=@ID
		update diplomaInfo set startDate=@startDate,class_startDate=@class_startDate,class_endDate=@class_endDate,term=@term,endDate=dateadd(d,-1,dateadd(yy,@term,@startDate)),host=b.host
		 from diplomaInfo a, studentCourseList b where a.refID=b.refID and a.batchID=@ID
		if exists(select 1 from generateDiplomaInfo where ID=@ID and filename is null)
		begin
			declare @qty as int
			select @qty=count(*),@firstID=min(diplomaID),@lastID=max(diplomaID) from diplomaInfo where batchID=@ID
			update generateDiplomaInfo set firstID=@firstID,lastID=@lastID,qty=@qty,filename='/upload/students/diplomaPublish/' + cast(@re as varchar) + '.pdf' where ID=@ID
		end
	end
	return isnull(@re,0)
END
GO


-- CREATE DATE: 2021-04-06
-- 根据给定的参数，更新证书信息
-- USE CASE: exec updateGenerateDiplomaMemo 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updateGenerateDiplomaMemo]
	@ID int,@startDate varchar(50),@class_startDate varchar(50),@class_endDate varchar(50),@photo int,@photoDate varchar(50),@printed int,@printDate varchar(50),@delivery int,@deliveryDate varchar(50),@kindID int,@keyID int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	if @photoDate='' or @photoDate = 'null'
		select @photoDate = null
	if @printDate='' or @printDate = 'null'
		select @printDate = null
	if @deliveryDate='' or @deliveryDate = 'null'
		select @deliveryDate = null
	if @startDate='' or @startDate = 'null'
		select @startDate = convert(varchar(20),getDate(),23)

	update generateDiplomaInfo set kindID=@kindID,styleID=@keyID,startDate=@startDate,class_startDate=@class_startDate,class_endDate=@class_endDate,photo=@photo,photoDate=(case when @photo=0 then null when @photo=1 and @photoDate is null then getDate() else @photoDate end),printed=@printed,printDate=(case when @printed=0 then null when @printed=1 and @printDate is null then getDate() else @printDate end),delivery=@delivery,deliveryDate=(case when @delivery=0 then null when @delivery=1 and @deliveryDate is null then getDate() else @deliveryDate end),memo=@memo where ID=@ID
	-- 写操作日志
	exec writeOpLog '','证书制作修改','updateGenerateDiplomaMemo',@registerID,'',@ID
END
GO

-- CREATE DATE: 2021-05-13
-- 根据给定的参数，向考生批量发送考试通知
-- batchID: generatePasscardInfo.ID
-- USE CASE: exec sendMsg4Exam 1
ALTER PROCEDURE [dbo].[sendMsg4Exam]
	@batchID int, @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50),@kindID int
	--send system message
	if exists(select 1 from generatePasscardInfo where ID=@batchID)
	begin
		select @kindID=kindID from generatePasscardInfo where ID=@batchID
		declare rc cursor for select username,'尊敬的' + a.name + '：请您于' + b.startDate + '参加' + b.certName + '考试，' + (case when @kindID=0 then '地点为' + b.address + '。请携带身份证、准考证，迟到15分钟不得入场。' when @kindID=1 then '方式为手机在线考试（闭卷）。请按规定时间登录系统，阅读考试须知，迟到15分钟将无法进入。' else '' end),a.host from v_passcardInfo a, v_generatePasscardInfo b where a.refID=b.ID and b.ID=@batchID
		open rc
		fetch next from rc into @username,@item,@host
		While @@fetch_status=0 
		Begin 
			--0 回复 1 通知 2 其他
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item,@host
		End
		Close rc 
		Deallocate rc
		update generatePasscardInfo set send = send + 1,sendDate=getDate(),sender=@registerID where ID=@batchID
	end
	--return students list for send mobile message
	select name,username,mobile,b.certName,a.enterID, b.startDate as dt, b.address,'尊敬的' + a.name + '：请您于' + b.startDate + '参加' + b.certName + '考试，' + (case when @kindID=0 then '地点为' + b.address + '。请携带身份证、准考证，迟到15分钟不得入场。' when @kindID=1 then '方式为手机在线考试（闭卷）。请按规定时间登录系统，阅读考试须知，迟到15分钟将无法进入。' else '' end) as item, @kindID as kindID from v_passcardInfo a, v_generatePasscardInfo b where a.refID=b.ID and b.ID=@batchID
END
GO

-- CREATE DATE: 2021-05-13
-- 根据给定的参数，向考生批量发送考试通知(已申报成功的)
-- batchID: generateApplyInfo.ID
-- USE CASE: exec sendMsg4ExamApply 1
ALTER PROCEDURE [dbo].[sendMsg4ExamApply]
	@batchID int, @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50)
	--send system message
	if exists(select 1 from generateApplyInfo where ID=@batchID)
	begin
		declare rc cursor for select username,'尊敬的' + a.name + '：请您于' + examDate + '参加' + b.courseName + '考试，地点为' + b.address + '。请携带身份证、准考证，迟到15分钟不得入场。',a.host from v_applyInfo a, v_generateApplyInfo b where a.refID=b.ID and b.ID=@batchID and a.examDate>'' -- and a.statusApply=1
		open rc
		fetch next from rc into @username,@item,@host
		While @@fetch_status=0 
		Begin 
			--0 回复 1 通知 2 其他
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item,@host
		End
		Close rc 
		Deallocate rc
		update generateApplyInfo set send = send + 1,sendDate=getDate(),sender=@registerID where ID=@batchID
	end
	--return students list for send mobile message
	select name,username,mobile,b.courseName as certName,a.enterID, examDate as dt, b.address,'尊敬的' + a.name + '：请您于' + examDate + '参加' + b.courseName + '考试，地点为' + b.address + '。请携带身份证、准考证，迟到15分钟不得入场。' as item from v_applyInfo a, v_generateApplyInfo b where a.refID=b.ID and b.ID=@batchID and a.examDate>'' -- and a.statusApply=1
END
GO

-- CREATE DATE: 2021-05-13
-- 根据给定的参数，向考生批量发送开课通知
-- batchID: classInfo.classID; selList: username list
-- USE CASE: exec sendMsg4Class 1
ALTER PROCEDURE [dbo].[sendMsg4Class]
	@batchID varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50),@startDate varchar(50),@endDate varchar(50),@address varchar(100),@certName varchar(50),@kindID int
	--send system message
	--将名单导入到临时表
	create table #temp(username varchar(50))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp(username) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end
	if exists(select 1 from classInfo where classID=@batchID) and @n>0
	begin
		select @startDate=dateStart,@endDate=dateEnd,@address=classRoom,@certName=shortName,@kindID=kindID from v_classInfo where classID=@batchID
		declare rc cursor for select b.username,b.name + '：请于' + @startDate + '参加' + @certName + (case when @kindID=0 then '培训，' + @address + ',携带身份证原件、笔记本和笔。' else '在线培训。注意在规定时间内完成课程学习，在模拟考试中取得良好成绩，否则将影响考试和取证。' end) from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
		open rc
		fetch next from rc into @username,@item
		While @@fetch_status=0 
		Begin 
			--0 回复 1 通知 2 其他
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item
		End
		Close rc 
		Deallocate rc
		update classInfo set send = send + 1,sendDate=getDate(),sender=@registerID where classID=@batchID
		--return students list for send mobile message
		select b.name,b.username,b.mobile,@certName as certName, b.ID as enterID, @startDate as dt,@address as address,b.name + '：请于' + @startDate + '至' + @endDate + '参加' + @certName + (case when @kindID=0 then '培训，' + @address + '。携带身份证原件、笔记本和笔。' else '在线培训。注意在规定时间内完成课程学习，在模拟考试中取得良好成绩，否则将影响考试和取证。' end) as item, @kindID as kindID from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
	end
END
GO

-- CREATE DATE: 2025-08-17
-- 根据给定的参数，向考生批量发送竞赛通知
-- batchID: classInfo.classID; selList: username list
-- USE CASE: exec sendMsg4Competition 1
ALTER PROCEDURE [dbo].[sendMsg4Competition]
	@batchID varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50),@startDate varchar(50),@endDate varchar(50),@address varchar(100),@certName varchar(50),@kindID int
	--send system message
	--将名单导入到临时表
	create table #temp(username varchar(50))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp(username) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end
	if exists(select 1 from classInfo where classID=@batchID) and @n>0
	begin
		select @startDate=dateStart,@endDate=dateEnd,@address=classRoom,@certName=shortName,@kindID=kindID from v_classInfo where classID=@batchID
		declare rc cursor for select b.username,'电工高级（三级）、智能楼宇管理员高级（三级）、制冷空调系统安装维修工高级（三级）竞赛班开始报名，9月下旬培训11月考试。通过后享受政府补贴，并有机会获得额外奖金。咨询电话：021-52132119（周一至周五8:30-16:30）' from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
		open rc
		fetch next from rc into @username,@item
		While @@fetch_status=0 
		Begin 
			--0 回复 1 通知 2 其他
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item
		End
		Close rc 
		Deallocate rc
		update classInfo set send = send + 1,sendDate=getDate(),sender=@registerID where classID=@batchID
		--return students list for send mobile message
		select b.name,b.username,b.mobile,b.ID as enterID, '通过后享受政府补贴，并有机会获额外奖金。' as dt, '021-52132119' as address,'电工高级（三级）、智能楼宇管理员高级（三级）、制冷空调系统安装维修工高级（三级）竞赛班开始报名，9月下旬培训11月考试。通过后享受政府补贴，并有机会获得额外奖金。咨询电话：021-52132119（周一至周五8:30-16:30）' as item, @kindID as kindID from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
	end
END
GO

-- CREATE DATE: 2021-05-13
-- 根据给定的参数，向考生批量发送不安排考试通知
-- batchID: classInfo.classID; selList: studentCouresList.ID list
-- USE CASE: exec sendMsg4ExamDeny 1
CREATE PROCEDURE [dbo].[sendMsg4ExamDeny]
	@batchID varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50),@startDate varchar(50),@address varchar(100),@certName varchar(50),@kindID int
	--send system message
	--将名单导入到临时表
	create table #temp(username varchar(50))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp(username) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end
	if exists(select 1 from classInfo where classID=@batchID) and @n>0
	begin
		select @startDate=dateStart,@address=classRoom,@certName=shortName,@kindID=kindID from v_classInfo where classID=@batchID
		declare rc cursor for select b.username,b.name + '你好，由于在' + @certName + '项目培训中未能完成规定的进度和模拟成绩，暂不安排你参加本次考试。望抓紧学习，早日满足考试条件。' from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
		open rc
		fetch next from rc into @username,@item
		While @@fetch_status=0 
		Begin 
			--0 回复 1 通知 2 其他
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item
		End
		Close rc 
		Deallocate rc
		update classInfo set send = send + 1,sendDate=getDate(),sender=@registerID where classID=@batchID
		--return students list for send mobile message
		select b.name,b.username,b.mobile,@certName as certName, b.ID as enterID,b.name + '你好，由于在' + @certName + '项目培训中未能完成规定的进度和模拟成绩，暂不安排你参加本次考试。望抓紧学习，早日满足考试条件。' as item from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
	end
END
GO

-- CREATE DATE: 2021-05-13
-- 根据给定的参数，向考生批量发送考试成绩
-- batchID: generatePasscardInfo.ID
-- USE CASE: exec sendMsg4Score 1
ALTER PROCEDURE [dbo].[sendMsg4Score]
	@batchID int, @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50)
	--send system message
	if exists(select 1 from generatePasscardInfo where ID=@batchID)
	begin
		declare rc cursor for select username,'尊敬的' + a.name + '：您于近日参加的' + b.certName + '考试，结果为' + (case when a.status=1 then '合格，正在为您制作证书。' else '不合格，请留意后续安排。' end),a.host from v_passcardInfo a, v_generatePasscardInfo b where a.refID=b.ID and b.ID=@batchID
		open rc
		fetch next from rc into @username,@item,@host
		While @@fetch_status=0 
		Begin 
			--0 回复 1 通知 2 其他
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item,@host
		End
		Close rc 
		Deallocate rc
		update generatePasscardInfo set sendScore = sendScore + 1,sendScoreDate=getDate(),senderScore=@registerID where ID=@batchID
	end
	--return students list for send mobile message
	select name,username,mobile,b.certName, a.enterID, (case when a.status=1 then '合格，正在为您制作证书' else '不合格，请留意后续安排' end) as address,'尊敬的' + a.name + '：您于近日参加的' + b.certName + '考试，结果为' + (case when a.status=1 then '合格，正在为您制作证书。' else '不合格，请留意后续安排。' end) as item from v_passcardInfo a, v_generatePasscardInfo b where a.refID=b.ID and b.ID=@batchID
END
GO

-- CREATE DATE: 2021-05-13
-- 根据给定的参数，向考生批量发送考试成绩
-- batchID: generateApplyInfo.ID
-- USE CASE: exec sendMsg4ScoreApply 1
ALTER PROCEDURE [dbo].[sendMsg4ScoreApply]
	@batchID int, @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50)
	--send system message
	if exists(select 1 from generateApplyInfo where ID=@batchID)
	begin
		declare rc cursor for select username,'尊敬的' + a.name + '：您于近日参加的' + b.courseName + '考试，结果为' + (case when a.status=1 then '合格，正在为您制作证书。' when a.status=1 and score1='' then '缺考' else '不合格，请留意后续安排。' end),a.host from v_applyInfo a, v_generateApplyInfo b where a.refID=b.ID and b.ID=@batchID and a.statusApply=1
		open rc
		fetch next from rc into @username,@item,@host
		While @@fetch_status=0 
		Begin 
			--0 回复 1 通知 2 其他
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item,@host
		End
		Close rc 
		Deallocate rc
		update generateApplyInfo set sendScore = sendScore + 1,sendScoreDate=getDate(),senderScore=@registerID where ID=@batchID
	end
	--return students list for send mobile message
	select name,username,mobile,b.courseName as certName, a.enterID, (case when a.status=1 then '合格，正在为您制作证书' when a.status=1 and score1='' then '缺考' else '不合格，请留意后续安排' end) as address,'尊敬的' + a.name + '：您于近日参加的' + b.courseName + '考试，结果为' + (case when a.status=1 then '合格，正在为您制作证书。' when a.status=1 and score1='' then '缺考' else '不合格，请留意后续安排。' end) as item from v_applyInfo a, v_generateApplyInfo b where a.refID=b.ID and b.ID=@batchID and a.statusApply=1
END
GO

-- CREATE DATE: 2021-05-13
-- 根据给定的参数，向考生批量发送领证通知
-- batchID: generateApplyInfo.ID  selList: applyID
-- USE CASE: exec sendMsg4DiplomaApply 1
ALTER PROCEDURE [dbo].[sendMsg4DiplomaApply]
	@batchID int, @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50)

	--将名单导入到临时表
	create table #temp_diploma(id int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_diploma(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end
	
	--send system message
	if exists(select 1 from generateApplyInfo where ID=@batchID)
	begin
		declare rc cursor for select username,a.name + '：您已通过' + a.courseName + '考试，请持身份证到黄兴路158号D103领取证书(工作日8:30-16:00)。',a.host from v_applyInfo a, #temp_diploma c where a.ID=c.id and a.status=1
		open rc
		fetch next from rc into @username,@item,@host
		While @@fetch_status=0 
		Begin 
			--0 回复 1 通知 2 其他
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item,@host
		End
		Close rc 
		Deallocate rc
		update generateApplyInfo set sendScore = sendScore + 1,sendScoreDate=getDate(),senderScore=@registerID where ID=@batchID
	end
	--return students list for send mobile message
	select name,username,mobile,a.courseName as certName, a.enterID, '黄兴路158号D103' as address,a.name + '：您已通过' + a.courseName + '考试，请持身份证到黄兴路158号D103领取证书(工作日8:30-16:00)。' as item from v_applyInfo a, #temp_diploma c where a.ID=c.id and a.status=1
END
GO

-- CREATE DATE: 2021-05-13
-- 根据给定的参数，向学员批量发送督促学习提醒信息
-- batchID: classInfo.classID; selList: username list
-- USE CASE: exec sendMsg4StudyAlert 1
ALTER PROCEDURE [dbo].[sendMsg4StudyAlert]
	@batchID varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50),@certName varchar(50)
	--send system message
	--将名单导入到临时表
	create table #temp(username varchar(50))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp(username) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	--send system message
	if exists(select 1 from classInfo where classID=@batchID) and @n>0
	begin
		select @certName=shortName from v_classInfo where classID=@batchID
		declare rc cursor for select b.username,b.name + '：你正在参加的' + @certName + '培训，请按要求尽快完成在线学习，并在模拟考试中达到 90分以，否则可能影响考试和取证。' from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
		open rc
		fetch next from rc into @username,@item
		While @@fetch_status=0 
		Begin 
			--0 回复 1 通知 2 其他
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item
		End
		Close rc 
		Deallocate rc
		update classInfo set send = send + 1,sendDate=getDate(),sender=@registerID where classID=@batchID
		--return students list for send mobile message
		select b.name,b.username,b.mobile,@certName as certName, b.ID as enterID,b.name + '：你正在参加的' + @certName + '培训，请按要求尽快完成在线学习，并在模拟考试中达到 90分以，否则可能影响考试和取证。' as item from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
	end
END
GO

-- CREATE DATE: 2022-11-29
-- 根据给定的参数，向学员批量发送提交电子照片提醒信息
-- kind: "" 身份证  "cert":studentCertList.ID ; selList: username list
-- USE CASE: exec sendMsg4SubmitPhoto 1
ALTER PROCEDURE [dbo].[sendMsg4SubmitPhoto]
	@kind varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50),@certName varchar(50)
	--send system message
	--将名单导入到临时表
	create table #temp(username varchar(50))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp(username) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	if @kind='cert'
		update #temp set username=b.username from #temp a, studentCertList b where a.username=b.ID

	--send system message
	if @n>0
	begin
		declare rc cursor for select b.username,b.name + '：参加的培训需提交符合要求的证件照片（jpg/png格式），登录系统后在个人信息中上传。' from #temp a, studentInfo b where a.username=b.username
		open rc
		fetch next from rc into @username,@item
		While @@fetch_status=0 
		Begin 
			--0 回复 1 通知 2 其他
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item
		End
		Close rc 
		Deallocate rc
		--记录通知
		--如果kind='cert', 取得username list 替换 cert list
		declare @list varchar(4000)
		select @list=''
		declare rc cursor for select username from #temp
		open rc
		fetch next from rc into @item
		While @@fetch_status=0 
		Begin 
			select @list = @list + @item + ','
			fetch next from rc into @item
		End
		Close rc 
		Deallocate rc
		select @list = left(@list,len(@list)-1)
		exec sendAttections 0,@list,@registerID
		--return students list for send mobile message
		select b.name,b.username,b.mobile,'' as certName,b.name + '：参加的培训需提交符合要求的证件照片（jpg/png格式），登录系统后在个人信息中上传。' as item from #temp a, studentInfo b where a.username=b.username
	end
END
GO

-- CREATE DATE: 2022-11-29
-- 根据给定的参数，向学员批量发送提交电子签名提醒信息
-- batchID: classInfo.classID; selList: username list
-- USE CASE: exec sendMsg4SubmitSignature 1
ALTER PROCEDURE [dbo].[sendMsg4SubmitSignature]
	@batchID varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50),@certName varchar(50)
	--send system message
	--将名单导入到临时表
	create table #temp(username varchar(50),enterID int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp(username) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	--send system message
	if exists(select 1 from classInfo where classID=@batchID) and @n>0
	begin
		select @certName=shortName from v_classInfo where classID=@batchID
		declare rc cursor for select b.username,b.name + '：参加的' + @certName + '培训需提交电子签名，登录系统后在“我的课程”中进行签名。' from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
		open rc
		fetch next from rc into @username,@item
		While @@fetch_status=0 
		Begin 
			--0 回复 1 通知 2 其他
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item
		End
		Close rc 
		Deallocate rc

		--记录通知
		update #temp set enterID=b.ID from #temp a, studentCourseList b where a.username=b.username and b.classID=@batchID
		--取得enterID list 替换 username list
		declare @list varchar(4000)
		select @list=''
		declare rc cursor for select enterID from #temp
		open rc
		fetch next from rc into @item
		While @@fetch_status=0 
		Begin 
			select @list = @list + @item + ','
			fetch next from rc into @item
		End
		Close rc 
		Deallocate rc
		select @list = left(@list,len(@list)-1)
		exec sendAttections 1,@list,@registerID

		--return students list for send mobile message
		select b.name,b.username,b.mobile,@certName as certName, b.ID as enterID,b.name + '：参加的' + @certName + '培训需提交电子签名，登录系统后在“我的课程”中进行签名。' as item from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
	end
END
GO

-- CREATE DATE: 2022-11-29
-- 根据给定的参数，批量通知学员，登录系统并进行签名和付款
-- batchID: classInfo.classID; selList: username list
-- USE CASE: exec sendMsg4SubmitLogin 1
CREATE PROCEDURE [dbo].[sendMsg4SubmitLogin]
	@batchID varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50),@certName varchar(50)
	--send system message
	--将名单导入到临时表
	create table #temp(username varchar(50),enterID int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp(username) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	--send system message
	if exists(select 1 from classInfo where classID=@batchID) and @n>0
	begin
		select @certName=shortName from v_classInfo where classID=@batchID
		declare rc cursor for select b.username,b.name + '：欢迎到智能消防学校学习。在线操作步骤：扫描二维码登录，密码123456，完成电子签名、在线付费。' from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
		open rc
		fetch next from rc into @username,@item
		While @@fetch_status=0 
		Begin 
			--0 回复 1 通知 2 其他
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item
		End
		Close rc 
		Deallocate rc

		--记录通知
		update #temp set enterID=b.ID from #temp a, studentCourseList b where a.username=b.username and b.classID=@batchID
		--取得enterID list 替换 username list
		declare @list varchar(4000)
		select @list=''
		declare rc cursor for select enterID from #temp
		open rc
		fetch next from rc into @item
		While @@fetch_status=0 
		Begin 
			select @list = @list + @item + ','
			fetch next from rc into @item
		End
		Close rc 
		Deallocate rc
		select @list = left(@list,len(@list)-1)
		exec sendAttections 1,@list,@registerID

		--return students list for send mobile message
		select b.name,b.username,b.mobile,@certName as certName, b.ID as enterID,b.name + '：欢迎到智能消防学校学习。在线操作步骤：扫描二维码登录，密码123456，完成电子签名、在线付费。' as item from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
	end
END
GO

-- =============================================
-- CREATE Date: 2021-06-26
-- Description:	将给定的数据添加到指定购物车。
-- @@kindID: examer, diploma
-- @selList: 名单，用逗号分隔的ID in studentCourseList, diplomaInfo
-- Use Case:	exec [add2cart] 'examer','...','','admin.'
-- =============================================
CREATE PROCEDURE [dbo].[add2cart] 
	@kindID varchar(50), @selList varchar(4000),@memo nvarchar(500), @registerID varchar(50)
AS
BEGIN
	declare @re int

	--将名单导入到临时表
	create table #temp_cart(id int,username varchar(50))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_cart(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	if @kindID='examer'
		update a set a.username=b.username from #temp_cart a, studentCourseList b where a.ID=b.ID
	if @kindID='diploma'
		update a set a.username=b.username from #temp_cart a, diplomaInfo b where a.ID=b.ID

	--add to cart
	insert into cartBill(username,refID,kindID,memo,registerID) select username,id,@kindID,@memo,@registerID from #temp_cart where id not in(select refID from cartBill where kindID=@kindID)
END

GO

-- =============================================
-- CREATE Date: 2021-03-24
-- Description:	将给定的数据从指定购物车中移除。
-- @@kindID: examer, diploma
-- @selList: 名单，用逗号分隔的ID in studentCourseList, diplomaInfo
-- Use Case:	exec [remove4cart] 'examer','...'
-- =============================================
CREATE PROCEDURE [dbo].[remove4cart] 
	@kindID varchar(50), @selList varchar(4000)
AS
BEGIN
	declare @re int

	--将名单导入到临时表
	create table #temp_cart(id int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_cart(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	--remove from cart
	delete from cartBill where kindID=@kindID and id in(select id from #temp_cart)
END

GO

-- =============================================
-- CREATE Date: 2021-03-24
-- Description:	将指定购物车清空。
-- @@kindID: examer, diploma
-- Use Case:	exec [setCartEmpty] 'examer'
-- =============================================
ALTER PROCEDURE [dbo].[setCartEmpty] 
	@kindID varchar(50),@registerID varchar(50)
AS
BEGIN
	delete from cartBill where kindID=@kindID and registerID=@registerID
END

GO

-- =============================================
-- CREATE Date: 2021-03-24
-- Description:	将购物车中给定的人员放入考试安排。
-- @examID: 考试编号 generatePasscardInfo.ID
-- @selList: 名单，用逗号分隔的ID in cart
-- Use Case:	exec [pickExamer4cart] 2,'...'
-- =============================================
ALTER PROCEDURE [dbo].[pickExamer4cart] 
	@examID varchar(50), @selList varchar(4000),@registerID varchar(50)
AS
BEGIN
	--将名单导入到临时表
	create table #temp_cart(id int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_cart(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	declare @certID varchar(50)
	select @certID=certID from v_generatePasscardInfo where ID=@examID
	--删除课程与考试不符合的人员
	update cartBill set memo='培训与考试不符' from cartBill c, v_studentCourseList a, #temp_cart b where b.id=c.id and a.ID=c.refID and a.certID<>@certID
	delete from #temp_cart where id in(select b.id from v_studentCourseList a, #temp_cart b, cartBill c where b.id=c.id and a.ID=c.refID and a.certID<>@certID)
	--删除已经加入某个未结束的考试场次的人员
	update cartBill set memo='已安排其他场次:' + cast(d.ID as varchar) from cartBill c, passcardInfo a, #temp_cart b, generatePasscardInfo d where b.id=c.id and a.enterID=c.refID and a.refID=d.ID and d.status<2
	delete from #temp_cart where id in(select b.ID from passcardInfo a, #temp_cart b, cartBill c, generatePasscardInfo d where b.id=c.id and a.enterID=c.refID and a.refID=d.ID and d.status<2)
	--删除已经获取相应证书且距离失效超过6个月的人员，避免重复报考取证
	update cartBill set memo='已获取相关证书:' + a.diplomaID + ' 有效期至' + convert(varchar(10),a.endDate,23) from cartBill c, diplomaInfo a, #temp_cart b where b.id=c.id and a.username=c.username and a.certID=@certID and a.status=0 and datediff(d,getDate(),a.endDate)>=180
	delete from #temp_cart where id in(select b.ID from cartBill c, diplomaInfo a, #temp_cart b where b.id=c.id and a.username=c.username and a.certID=@certID and a.status=0 and datediff(d,getDate(),a.endDate)>=180)

	--如果为补考，则标记原来的考试
	update passcardInfo set resit=1 where ID in(select max(a.ID) as ID from passcardInfo a, #temp_cart b, cartBill c where a.enterID=c.refID and b.ID=c.ID and c.memo='*补考*' group by c.refID)

	--填写明细
	insert into passcardInfo(refID,enterID,password,kind,registerID) select @examID,c.refID,right(c.username,6),replace(c.memo,'*',''),@registerID from #temp_cart b, cartBill c where b.id=c.id

	--更新报名表
	update studentCourseList set passcardID=@examID from studentCourseList a, #temp_cart b, cartBill c where b.id=c.id and a.id=c.refID

	--删除购物车中数据
	delete from cartBill where ID in(select id from #temp_cart)
END

GO

-- =============================================
-- CREATE Date: 2021-03-24
-- Description:	将购物车中给定的人员放入申报安排。
-- @applyID: 申报编号 generateApplyInfo.ID
-- @selList: 名单，用逗号分隔的ID in cart
-- Use Case:	exec [pickApplyer4cart] 2,'...'
-- =============================================
ALTER PROCEDURE [dbo].[pickApplyer4cart] 
	@applyID varchar(50), @selList varchar(4000),@registerID varchar(50)
AS
BEGIN
	--将名单导入到临时表
	create table #temp_cart(id int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_cart(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	declare @courseID varchar(50)
	select @courseID=courseID from v_generateApplyInfo where ID=@applyID
	--删除课程与考试不符合的人员
	update cartBill set memo='培训与申报不符' from cartBill c, v_studentCourseList a, #temp_cart b where b.id=c.id and a.ID=c.refID and a.courseID<>@courseID
	delete from #temp_cart where id in(select b.id from v_studentCourseList a, #temp_cart b, cartBill c where b.id=c.id and a.ID=c.refID and a.courseID<>@courseID)
	--删除已经加入某个未结束的申报场次的人员
	update cartBill set memo='已安排其他场次' from cartBill c, applyInfo a, #temp_cart b, generateApplyInfo d where b.id=c.id and a.enterID=c.refID and a.refID=d.ID and d.status<1
	delete from #temp_cart where id in(select b.ID from applyInfo a, #temp_cart b, cartBill c, generateApplyInfo d where b.id=c.id and a.enterID=c.refID and a.refID=d.ID and d.status<1)
	--删除学历缺失、未付费的人员
	update cartBill set memo=iif(d.education=0,'无学历','未付费') from cartBill c, studentCourseList a, #temp_cart b, studentInfo d where b.id=c.id and a.ID=c.refID and a.username=d.username and (d.education=0 or (a.pay_status=0 and a.pay_type<3))
	delete from #temp_cart where id in(select b.ID from cartBill c, studentCourseList a, #temp_cart b, studentInfo d where b.id=c.id and a.ID=c.refID and a.username=d.username and (d.education=0 or (a.pay_status=0 and a.pay_type<3)))

	--如果为补考，则标记原来的考试
	--update applyInfo set resit=1 where ID in(select max(a.ID) as ID from applyInfo a, #temp_cart b, cartBill c where a.enterID=c.refID and b.ID=c.ID and c.memo='*补考*' group by c.refID)

	--填写明细
	insert into applyInfo(refID,enterID,statusApply,kind,registerID) select @applyID,c.refID,0,replace(c.memo,'*',''),@registerID from #temp_cart b, cartBill c where b.id=c.id

	--更新报名表
	update studentCourseList set applyID=@applyID from studentCourseList a, #temp_cart b, cartBill c where b.id=c.id and a.id=c.refID

	--删除购物车中数据
	delete from cartBill where ID in(select id from #temp_cart)
END

GO


-- =============================================
-- CREATE Date: 2021-03-24
-- Description:	将某个考试场次的考生移动到另外一场考试，或者删除。
-- @examID: 目标考试编号 generatePasscardInfo.ID
-- @selList: 名单，用逗号分隔的ID in passcardInfo
-- Use Case:	exec [changeExamer] 2,'...'
-- =============================================
CREATE PROCEDURE [dbo].[changeExamer] 
	@examID varchar(50), @selList varchar(4000),@registerID varchar(50)
AS
BEGIN
	--将名单导入到临时表
	create table #temp(id int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	if exists(select 1 from generatePasscardInfo where ID=@examID)
	begin
		--更换考试场次
		update passcardInfo set refID=@examID from passcardInfo a, #temp b where a.ID=b.ID
		--更新报名表
		update studentCourseList set passcardID=@examID from studentCourseList a, #temp b, passcardInfo c where b.id=c.id and a.id=c.enterID
	end
	else
	begin
		--更新报名表
		update studentCourseList set passcardID=0 from studentCourseList a, #temp b, passcardInfo c where b.id=c.id and a.id=c.enterID
		--删除考生
		delete from passcardInfo where ID in(select id from #temp)
	end
END

GO

-- =============================================
-- CREATE Date: 2021-03-24
-- Description:	将某个申报批次的考生移动到另外批次，或者删除。
-- @examID: 目标考试编号 generateApplyInfo.ID
-- @selList: 名单，用逗号分隔的ID in applyInfo
-- Use Case:	exec [changeApplier] 2,'...'
-- =============================================
ALTER PROCEDURE [dbo].[changeApplier] 
	@examID varchar(50), @selList varchar(4000),@registerID varchar(50)
AS
BEGIN
	--将名单导入到临时表
	create table #temp(id int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	if exists(select 1 from generateApplyInfo where ID=@examID)
	begin
		--更换考试场次
		update applyInfo set refID=@examID from applyInfo a, #temp b where a.ID=b.ID
		--更新报名表
		update studentCourseList set applyID=@examID from studentCourseList a, #temp b, applyInfo c where b.id=c.id and a.id=c.enterID
	end
	else
	begin
		--更新报名表
		update studentCourseList set applyID=0 from studentCourseList a, #temp b, applyInfo c where b.id=c.id and a.id=c.enterID
		--删除考生
		delete from applyInfo where ID in(select id from #temp)
	end
	
	-- 写操作日志
	exec writeOpLog '','考生移动申报批次','changeApplier',@registerID,@selList,@examID
END

GO

-- =============================================
-- Author:		Albert
-- Create date: 2025-05-28
-- Description:	对某场考试，为每个考生创建不同试卷
-- =============================================
CREATE PROCEDURE [dbo].[createPaper4Exam] 
	@batchID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @paperID int, @count int
	select @count=count(*) from passcardInfo where refID=@batchID
	if @count>0
	begin
		declare rc1 cursor for select a.paperID from studentExamList a, passcardInfo b where a.refID=b.ID and b.refID=@batchID and a.kind=1
		open rc1
		fetch next from rc1 into @paperID
		While @@fetch_status=0 
		Begin
			exec addQuestions4StudentExam @paperID,1,0,'',0,1,20,0	--强制重新生成题目
			fetch next from rc1 into @paperID
		End
		Close rc1
		Deallocate rc1
	end
END
GO

-- =============================================
-- CREATE Date: 2021-03-24
-- Description:	为指定的考试制作准考证。
-- Use Case:	exec [setPassNo4Exam] 1
-- =============================================
ALTER PROCEDURE [dbo].[setPassNo4Exam] 
	@examID varchar(50), @registerID varchar(50)
AS
BEGIN
	declare @re int, @startDate varchar(50),@certID varchar(50),@kindID int, @sync int
	select @startDate = startDate, @certID = certID, @kindID=kindID, @sync=sync from v_generatePasscardInfo where ID=@examID
	update passcardInfo set passNo = b.rank1 from passcardInfo a, (select a.ID, b.SNo, RANK() over(order by b.SNo,a.ID) as rank1 from passcardInfo a, studentCourseList b where a.enterID=b.ID and a.refID=@examID) b where a.ID=b.ID
	--if @certID='C1'
	update passcardInfo set passNo = substring(replace(@startDate,'-',''),3,2) + @examID + REPLICATE('0',3-len(passNo)) + cast(passNo as varchar) where refID=@examID
	--else
		--update passcardInfo set passNo = REPLICATE('0',4-len(@examID)) + @examID + REPLICATE('0',3-len(passNo)) + cast(passNo as varchar) where refID=@examID
	--如果是线上考试，生成考卷
	if @kindID=1
	begin
		delete from studentExamList where refID in(select ID from passcardInfo where refID=@examID)
		insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,kind,mark) select a.username,examID,a.ID,minutes,minutes*60,scoreTotal,scorePass,b.kindID,1,0 from v_passcardInfo a, examInfo b where a.refID=@examID and b.certID=@certID and b.mark=0 and b.status=0
		--如果是同步试卷，进行同步处理
		if @sync=1	
			exec syncPaper4Exam @examID
		else
			exec createPaper4Exam @examID	--否则分别生成试卷
	end
	-- 写操作日志
	exec writeOpLog '','准考证制作','setPassNo4Exam',@registerID,'',@examID
END
GO

-- =============================================
-- CREATE Date: 2021-03-24
-- Description:	关闭指定的考试。
-- Use Case:	exec [closeGeneratePasscard] 1
-- =============================================
ALTER PROCEDURE [dbo].[closeGeneratePasscard] 
	@examID varchar(50),@status int, @registerID varchar(50)
AS
BEGIN
	update generatePasscardInfo set status=@status where ID=@examID
	declare @event varchar(50)
	select @event=(case when @status=1 then '锁定考试' when @status=2 then '关闭考试' else '' end)
	-- 写操作日志
	exec writeOpLog '',@event,'closeGeneratePasscard',@registerID,'',@examID
END

GO


-- CREATE DATE: 2021-04-06
-- 根据给定的参数，添加或者更新申报信息
-- USE CASE: exec updateGenerateApplyInfo 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updateGenerateApplyInfo]
	@ID int,@courseID varchar(50),@applyID varchar(50),@title nvarchar(100),@startDate varchar(100),@endDate varchar(100),@planID varchar(50),@planQty varchar(50),@notes nvarchar(500),@address nvarchar(100),@teacher varchar(50),@classroom nvarchar(100),@adviserID varchar(50),@diplomaReady varchar(50),@host varchar(50),@memo nvarchar(500),@summary nvarchar(2000),@registerID varchar(50)
AS
BEGIN
	declare @re int
	select @re=@ID, @host=[dbo].[whenull](@host,'znxf')

	if @ID=0	-- 新纪录
	begin
		--填写生成记录
		insert into generateApplyInfo(courseID,applyID,title,startDate,endDate,planID,planQty,notes,address,teacher,classroom,diplomaReady,host,memo,registerID) values(@courseID,@applyID,@title,@startDate,@endDate,@planID,@planQty,@notes,@address,@teacher,@classroom,@diplomaReady,@host,@memo,@registerID)
		select @re=max(ID) from generateApplyInfo where registerID=@registerID
	end
	if @ID>0	-- 保存信息
	begin
		update generateApplyInfo set applyID=@applyID,title=@title,summary=@summary,startDate=@startDate,endDate=@endDate,planID=@planID,planQty=@planQty,notes=@notes,address=@address,teacher=@teacher,classroom=@classroom,adviserID=@adviserID,diplomaReady=@diplomaReady,host=@host,memo=@memo where ID=@ID
	end
	select @re as re
END
GO

-- CREATE DATE: 2015-01-12
-- 根据给定的参数，删除申报数据，并写日志
-- USE CASE: exec delGenerateApplyInfo 1
ALTER PROCEDURE [dbo].[delGenerateApplyInfo]
	@ID int,@registerID varchar(50)
AS
BEGIN
	if exists(select 1 from generateApplyInfo where ID=@ID)
	begin
		delete from generateApplyInfo where ID=@ID
		-- 删除相关考生的申报记录
		delete from applyInfo where refID=@ID
		update studentCourseList set applyID=0 where applyID=@ID
		-- 写操作日志
		exec writeOpLog '','删除申报','generateApply',@registerID,'',@ID
	end
END
GO

-- CREATE DATE: 2015-01-12
-- 根据给定的参数，关闭，并写日志
-- USE CASE: exec closeGenerateApplyInfo 1
CREATE PROCEDURE [dbo].[closeGenerateApplyInfo]
	@ID int, @status int ,@registerID varchar(50)
AS
BEGIN
	if exists(select 1 from generateApplyInfo where ID=@ID)
	begin
		update generateApplyInfo set status=@status where ID=@ID
		-- 写操作日志
		declare @event varchar(20)
		select @event = (case when @status=0 then '申报开启' when @status=2 then '申报关闭' else '申报锁定' end)
		exec writeOpLog '',@event,'apply',@registerID,'',@ID
	end
END
GO


------------------
-- CREATE DATE: 2020-05-24
-- 根据给定的参数，添加或者更新导入预报名学员信息
-- batchID: classInfo.ID
-- USE CASE: exec generateRefStudent 1,1,'xxxx'...
-- params = {"batchID":key, "ID":String(val["序号"]), "dept1":val["公司"], "dept2":val["加油站"], "name":val["姓名"], "username":un, "education":val["文化程度"], "job":val["岗位"], "mobile":String(phone), "expireDate":String(val["证书有效期"]), "memo":val["备注"], "invoice":val["开票信息"]};
ALTER PROCEDURE [dbo].[generateRefStudent]
	@batchID int,@ID varchar(50),@dept1 varchar(50),@dept2 varchar(50),@name varchar(50),@username varchar(50),@education varchar(50),@job varchar(50),@mobile varchar(50),@expireDate varchar(50),@memo varchar(50),@invoice varchar(50)
AS
BEGIN
	declare @re int, @dept int, @edu int, @dept22 int
	select @dept1=replace(@dept1,' ',''),@dept2=replace(@dept2,' ',''),@name=replace(@name,' ',''),@username=replace(@username,' ',''),@education=replace(@education,' ',''),@mobile=replace(@mobile,' ','')
	select @dept = (case when @dept1='沪东' then 2 when @dept1='沪南' then 3 when @dept1='沪西' then 4 when @dept1='沪北' then 6 when @dept1='物流中心' then 9 else 0 end)
	select @edu = ID from dictionaryDoc where kind='education' and item=@education
	select @dept22 = deptID from deptInfo where deptName=@dept2
	insert into ref_student_spc(classID,ID,deptName,stationName,name,username,education,edu,dept1,dept2,job,mobile,expireDate,memo,invoice) values(@batchID,@ID,@dept1,@dept2,@name,@username,@education,@edu,@dept,@dept22,@job,@mobile,@expireDate,@memo,@invoice)

	return isnull(@re,0)
END
GO

------------------
-- CREATE DATE: 2020-05-24
-- 根据给定的参数，删除预报名学员信息
-- batchID: classInfo.ID
-- USE CASE: exec delRefStudent 1
CREATE PROCEDURE [dbo].[delRefStudent]
	@batchID int
AS
BEGIN
	delete from ref_student_spc where classID=@batchID
END
GO

------------------
-- CREATE DATE: 2020-05-24
-- 根据给定的参数，查找预报名表，获取编号
-- @cID: classInfo.ID
-- mark: 0 预报名表内  1 表外
-- USE CASE: exec lookRefSNo 1
ALTER PROCEDURE [dbo].[lookRefSNo]
	@cID int, @username varchar(50), @name varchar(50), @pNo varchar(50) output, @mark int output
AS
BEGIN
	declare @SNo int
	select @pNo='',@SNo=0,@mark=1

		--从预报名表里查找编号
		--select @SNo = ID from ref_student_spc where username=@username and classID=@cID
		--if @SNo=0 and exists(select 1 from ref_student_spc where name=@name and classID=@cID)	--身份证如果没找到，再找姓名
		--begin
		--	select @SNo = ID from ref_student_spc where name=@name and classID=@cID
			--回填身份证
		--	update ref_student_spc set username=@username where name=@name and classID=@cID
		--end
		--如果预报名表中没有编号，则在班级里自动编号
		--if @SNo=0
		--begin
			--declare @no int
			--select @no = 0,@mark=1
			--select @no = SNo from classInfo where ID=@cID
			--if @no = 0
			--	select @no = max(ID) from ref_student_spc where classID=@cID
			----select @SNo = isnull(SNo,0) + 1 from classInfo where ID=@cID
			----update classInfo set SNo=@SNo where ID=@cID
		--end
		select top 1 @pNo = replace(isnull(a.SNo,''),cast(@cID as varchar) + '-','') from studentCourseList a, classInfo b where a.classID=b.classID and b.ID=@cID order by cast(replace(a.SNo,cast(@cID as varchar) + '-','') as int) desc
		select @SNo=isnull(@pNo,0) + 1
		select @pNo = cast(@cID as varchar) + '-' + dbo.fn_formatNum(@SNo,3,'0')
END
GO

-- CREATE DATE: 2021-05-13
-- 批量删除被剔除的报名记录，以及招生关闭后3天未被确认的报名
-- USE CASE: exec dealNoCheckedEnters
ALTER PROCEDURE [dbo].[dealNoCheckedEnters]
AS
BEGIN
	declare @ID int
	declare rc cursor for select ID from studentCourseList where checked=2 and projectID in (select projectID from projectInfo where status>1) union select ID from studentCourseList where checked=0 and projectID in (select projectID from projectInfo where status>1 and classID is null and (datediff(d,deadline,getDate())>3 or deadline is null))
	open rc
	fetch next from rc into @ID
	While @@fetch_status=0 
	Begin 
		exec delEnter @ID,'自动清理','system.'
		fetch next from rc into @ID
	End
	Close rc 
	Deallocate rc
END
GO

------------------
-- CREATE DATE: 2020-05-24
-- 根据给定的参数，添加或者更新导入申报结果信息
-- USE CASE: exec generateApply 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[generateApply]
	@batchID int,@passNo varchar(50),@username varchar(50),@name varchar(50),@examDate varchar(50)

AS
BEGIN
	if right(@examDate,1)='1' or right(@examDate,1)='2'
		select @examDate = left(@examDate,len(@examDate)-1) + '0'
	update applyInfo set applyNo=@passNo,examDate=@examDate,statusApply=1 from applyInfo a, v_applyInfo b where a.ID=b.ID and a.refID=@batchID and b.username=replace(@username,' ','')

	return 0
END
GO

------------------
-- CREATE DATE: 2020-05-24
-- 根据给定的参数，去除申报批次里未通过的人
-- USE CASE: exec dealGenerateApply 1
ALTER PROCEDURE [dbo].[dealGenerateApply]
	@batchID int ,@registerID varchar(50)
AS
BEGIN
	--报名信息里去除申报标识
	--update studentCourseList set applyID=0 from studentCourseList a, applyInfo b where a.ID=b.enterID and a.applyID=@batchID and b.refID=@batchID and b.statusApply=0
	--申报信息里设置为拒绝
	--update applyInfo set statusApply=2 where refID=@batchID and statusApply=0
	--填写操作日期
	update generateApplyInfo set importApplyDate=getDate(),importApplyID=@registerID where ID=@batchID
	-- 写操作日志
	declare @event varchar(20)
	select @event = '导入申报结果'
	exec writeOpLog '',@event,'importApply',@registerID,'',@batchID
END
GO

------------------
-- CREATE DATE: 2020-05-24
-- 根据给定的参数，添加或者更新导入申报成绩和证书信息
-- USE CASE: exec generateApplyScore 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[generateApplyScore]
	@batchID int,@ID int,@passNo varchar(50),@username varchar(50),@name varchar(50),@pass varchar(50),@score1 varchar(50),@score2 varchar(50),@startDate varchar(50),@registerID varchar(50)

AS
BEGIN
	declare @status int, @refID int, @enterID int, @certID varchar(50),@host varchar(50),@term int
	select @status=(case when len(@passNo)>2 then 1 when @score1>'' and @pass='' then 2 else 3 end)
	select @enterID=enterID from v_applyInfo where refID=@batchID and username=@username
	select @refID=refID, @certID=certID from v_studentCourseList where ID=@enterID
	select @term=term from certificateInfo where certID=@certID
	select @host = host from studentInfo where username=@username

	--更新申报信息
	update applyInfo set status=@status,score1=@score1,score2=@score2 from applyInfo a, v_applyInfo b where a.ID=b.ID and a.refID=@batchID and b.username=@username
	update generateApplyInfo set importScoreDate=getDate() where ID=@batchID and importScoreDate is null

	--更新报名信息
	update studentCertList set result=@status,status=(case when @status=1 then 2 else status end),diplomaID=(case when @status=1 then @passNo else null end),score=@score1,score1=@score1,score2=@score2,closeDate=(case when @status=1 then getDate() else null end) where ID=@refID
	update studentCourseList set status=2,endDate=getDate(),closeDate=getDate() where ID=@enterID and @status=1

	--添加证书信息
	if @status=1 and exists(select 1 from diplomaInfo where certID=@certID and diplomaID=@passNo)
		delete from diplomaInfo where certID=@certID and diplomaID=@passNo
	if @status=1
		insert into diplomaInfo(diplomaID,username,batchID,refID,certID,score,score1,score2,term,startDate,endDate,host,registerID) select @passNo,@username,@batchID,@refID,@certID,@score1,@score1,@score2,@term,@startDate,convert(varchar(20),dateadd(d,-1,dateadd(yy,@term,@startDate)),23),@host,@registerID
END
GO

------------------
-- CREATE DATE: 2020-05-24
-- 根据给定的参数，添加或者更新导入申报成绩和证书信息(安监自动下载)
-- USE CASE: exec generateApplyScore1 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[generateApplyScore1]
	@ID int,@passNo varchar(50),@score1 varchar(50),@score2 varchar(50),@startDate varchar(50),@registerID varchar(50)

AS
BEGIN
	declare @status int, @refID int, @enterID int, @certID varchar(50),@host varchar(50),@batchID int,@term int,@username varchar(50)
	select @status=(case when len(@passNo)>2 then 1 when @score1>'' and len(@passNo)<2 then 2 else 3 end),@score1=dbo.whenull(@score1,'0'),@score2=dbo.whenull(iif(@score2='无实操','',@score2),'0')
	select @enterID=enterID,@batchID=refID from v_applyInfo where ID=@ID
	select @refID=refID, @certID=certID, @username=username from v_studentCourseList where ID=@enterID
	select @term=term from certificateInfo where certID=@certID
	select @host = host from studentInfo where username=@username

	--更新申报信息
	update applyInfo set status=@status,score1=@score1,score2=@score2 from applyInfo where ID=@ID
	update generateApplyInfo set importScoreDate=getDate() where ID=@batchID and importScoreDate is null

	--更新报名信息
	update studentCertList set result=@status,status=2,diplomaID=(case when @status=1 then @passNo else null end),score=@score1,score1=@score1,score2=@score2,closeDate=getDate() where ID=@refID
	update studentCourseList set status=2,endDate=getDate(),closeDate=getDate() where ID=@enterID

	--添加证书信息
	if @status=1 and exists(select 1 from diplomaInfo where certID=@certID and diplomaID=@passNo)
		delete from diplomaInfo where certID=@certID and diplomaID=@passNo
	if @status=1
		insert into diplomaInfo(diplomaID,username,batchID,refID,certID,score,score1,score2,term,startDate,endDate,host,registerID) select @passNo,@username,@batchID,@refID,@certID,@score1,@score1,@score2,@term,@startDate,convert(varchar(20),dateadd(d,-1,dateadd(yy,@term,@startDate)),23),@host,@registerID
END
GO

------------------
-- CREATE DATE: 2025-08-12
-- 根据给定的参数，添加或者更新导入申报结果信息(安监自动下载)
-- USE CASE: exec generateApply1 1,1,'xxxx'...
CREATE PROCEDURE [dbo].[generateApply1]
	@ID int,@passNo varchar(50),@examDate varchar(50),@registerID varchar(50)

AS
BEGIN
	declare @batchID int
	select @batchID=refID from applyInfo where ID=@ID

	--更新申报信息
	if @examDate>''
	begin
		update applyInfo set applyNo=@passNo,examDate=@examDate,statusApply=1 from applyInfo where ID=@ID
		update generateApplyInfo set importApplyDate=getDate() where ID=@batchID and importApplyDate is null
	end
END
GO

-- CREATE DATE: 2022-11-28
-- 证书失效，将证书状态设为过期，截止日期设为昨天
-- USE CASE: exec cancelDiploma
ALTER PROCEDURE [dbo].[cancelDiploma]
	@diplomaID varchar(50),@registerID varchar(50)

AS
BEGIN
	declare @event varchar(20), @logMemo varchar(100)
	select @event = '证书失效', @logMemo=diplomaID + '/' + username + '/' + name + '/' + certName from v_diplomaInfo where diplomaID=@diplomaID

	--更新证书信息
	update diplomaInfo set status=1, endDate=dateadd(d,-1,getDate()) where diplomaID=@diplomaID
	-- 写操作日志
	exec writeOpLog @event,'diplomaExpire',@registerID,@logMemo,@diplomaID
END
GO

-- CREATE DATE: 2022-11-28
-- 恢复证书的有效性，如果没有超过原有效期，将证书状态设为有效，截止日期设为既定值
-- USE CASE: exec restartDiploma
CREATE PROCEDURE [dbo].[restartDiploma]
	@diplomaID varchar(50),@registerID varchar(50)

AS
BEGIN
	declare @event varchar(20), @logMemo varchar(100), @closeDate datetime
	select @event = '证书恢复', @logMemo=diplomaID + '/' + username + '/' + name + '/' + certName, @closeDate=dateadd(yy,term,startDate) from v_diplomaInfo where diplomaID=@diplomaID

	--更新证书信息
	if @closeDate>getDate()
	begin
		update diplomaInfo set status=0, endDate=@closeDate where diplomaID=@diplomaID
		-- 写操作日志
		exec writeOpLog @event,'diplomaRestart',@registerID,@logMemo,@diplomaID
	end
END
GO

------------------
-- CREATE DATE: 2020-05-24
-- 根据给定的参数，设置申报批次的发证日期, 同时关闭申报
-- USE CASE: exec setGenerateApplyIssue 1
ALTER PROCEDURE [dbo].[setGenerateApplyIssue]
	@batchID int, @startDate varchar(50) ,@registerID varchar(50)
AS
BEGIN
	declare @refID int, @enterID int, @certID varchar(50),@term int, @courseID varchar(50)
	select @courseID=courseID from generateApplyInfo where ID=@batchID
	select @certID=certID from courseInfo where courseID=@courseID
	select @term=term from certificateInfo where certID=@certID
	--填写发证日期
	update generateApplyInfo set status=2,diplomaStartDate=@startDate, diplomaTerm=@term,diplomaEndDate=convert(varchar(20),dateadd(d,-1,dateadd(yy,@term,@startDate)),23),importScoreDate=getDate(),importScoreID=@registerID,registerID=@registerID where ID=@batchID
	-- 写操作日志
	declare @event varchar(20)
	select @event = '导入申报成绩和证书'
	exec writeOpLog '',@event,'importApplyScore',@registerID,'',@batchID
END
GO

--CREATE Date:2020-11-13
--根据给定班主任，随机返回一个工作总结
--@mark: 0 年月日
ALTER PROCEDURE [dbo].[getRandSummary]
	@refID int
AS
BEGIN
	declare @adviserID varchar(50),@re varchar(2000)
	select @adviserID=adviserID from classInfo where ID=@refID
	if exists(select 1 from classInfo where adviserID=@adviserID and summary>'' and ID<>@refID)
		select @re=summary from classInfo where ID=(select top 1 ID from classInfo where adviserID=@adviserID and summary>'' and ID<>@refID order by newid())
	select isnull(@re,'') as summary
END
GO

-- CREATE DATE: 2021-05-13
-- 课表更新后，批量修改已报名人员的课表
-- USE CASE: exec rebuildLessonList
ALTER PROCEDURE [dbo].[rebuildLessonList]
	@courseID varchar(50), @regDate varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	declare @ID int,@username varchar(50)
	declare rc cursor for select ID,username from studentCourseList where passcardID=0 and courseID=@courseID and regDate>@regDate
	open rc
	fetch next from rc into @ID,@username
	While @@fetch_status=0 
	Begin 
		--添加课表
		delete from studentLessonList where refID=@ID
		insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,@ID,hours,'system.' from lessonInfo where courseID=@courseID and status=0

		--添加课件
		delete from studentCoursewareList where refID in(select ID from studentLessonList where refID=@ID)
		insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,'system.' from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0

		--添加视频
		delete from studentVideoList where refID in(select ID from studentLessonList where refID=@ID)
		insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,'system.' from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0

		--添加考试，题目暂不生成
		if exists(select 1 from  examInfo where courseID=@courseID)
		begin
			delete from studentExamList where refID=@ID
			insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,kind,mark) select @username,examID,@ID,minutes,minutes*60,scoreTotal,scorePass,kindID,0,0 from examInfo where courseID=@courseID and status=0
		end
		
		fetch next from rc into @ID,@username
	End
	Close rc 
	Deallocate rc
END

GO

-- CREATE DATE: 2021-05-13
-- 课表更新后，批量修改已报名人员的课表
-- USE CASE: exec [rebuildLessonByClass]
ALTER PROCEDURE [dbo].[rebuildLessonByClass]
	@class int, @registerID varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	declare @ID int, @username varchar(50), @courseID varchar(50)
	declare rc cursor for select a.ID,a.username,a.courseID from studentCourseList a, classInfo b where a.classID=b.classID and b.ID=@class
	open rc
	fetch next from rc into @ID,@username,@courseID
	While @@fetch_status=0 
	Begin 
		--添加课表
		delete from studentLessonList where refID=@ID
		insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,@ID,hours,'system.' from lessonInfo where courseID=@courseID and status=0

		--添加课件
		delete from studentCoursewareList where refID in(select ID from studentLessonList where refID=@ID)
		insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,'system.' from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0

		--添加视频
		delete from studentVideoList where refID in(select ID from studentLessonList where refID=@ID)
		insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,'system.' from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0

		--添加考试，题目暂不生成
		if exists(select 1 from  examInfo where courseID=@courseID)
		begin
			delete from studentExamList where refID=@ID
			insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,kind,mark) select @username,examID,@ID,minutes,minutes*60,scoreTotal,scorePass,kindID,0,0 from examInfo where courseID=@courseID and status=0
		end

		fetch next from rc into @ID,@username,@courseID
	End
	Close rc 
	Deallocate rc
	exec writeOpLog '','更新班级全体学员的课表','rebuildLessonByClass',@registerID,'',@class
END
GO

-- CREATE DATE: 2021-05-13
-- 课表更新后，修改已报名人员的课表
-- USE CASE: exec rebuildStudentLesson
ALTER PROCEDURE [dbo].[rebuildStudentLesson]
	@enterID int
AS
BEGIN
	SET NOCOUNT ON;
	declare @username varchar(50),@courseID varchar(50)
	select @username=username,@courseID=courseID from studentCourseList where ID=@enterID
	
	--添加课表
	delete from studentLessonList where refID=@enterID
	insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,@enterID,hours,'system.' from lessonInfo where courseID=@courseID and status=0

	--添加课件
	delete from studentCoursewareList where refID in(select ID from studentLessonList where refID=@enterID)
	insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,'system.' from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@enterID and a.status=0

	--添加视频
	delete from studentVideoList where refID in(select ID from studentLessonList where refID=@enterID)
	insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,'system.' from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@enterID and a.status=0

	--添加考试，题目暂不生成
	if exists(select 1 from  examInfo where courseID=@courseID and status=0)
	begin
		delete from studentExamList where refID=@enterID
		insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,kind,mark) select @username,examID,@enterID,minutes,minutes*60,scoreTotal,scorePass,kindID,0,0 from examInfo where courseID=@courseID and status=0
	end
END

GO

-- CREATE DATE: 2021-05-13
-- 收卷，强制交卷
-- USE CASE: exec closeExam
CREATE PROCEDURE [dbo].[closeExam]
	@ID int, @registerID varchar(50)
AS
BEGIN
	declare @paperID int

	declare rc cursor for select a.paperID from studentExamList a, passcardInfo b where a.refID=b.ID and a.kind=1 and b.refID=@ID and a.status=1
	open rc
	fetch next from rc into @paperID
	While @@fetch_status=0 
	Begin 
		exec submit_student_exam @paperID
		fetch next from rc into @paperID
	End
	Close rc 
	Deallocate rc

	update generatePasscardInfo set closeDate=getDate(), closer=@registerID where ID=@ID
END
GO

-- CREATE DATE: 2021-05-13
-- 确认考试成绩
-- USE CASE: exec confirmExam
ALTER PROCEDURE [dbo].[confirmExam]
	@ID int, @registerID varchar(50)
AS
BEGIN
	declare @re int, @refID int,@certID varchar(50),@scorePass int, @enterID int,@score0 decimal(18,2)
	select @certID=certID,@re=1 from generatePasscardInfo where ID=@ID
	select top 1 @scorePass=isnull(scorePass,80) from examInfo where certID=@certID and status=0 order by examID

	--result:1 合格 2 不合格，结束课程
	update passcardInfo set status=(case when score>=@scorePass then 1 else 2 end) where refID=@ID
	if exists(select 1 from [dbo].[certificateInfo] where certID=@certID and agencyID=4)	--本校发证项目将自动结束课程，其他项目不改变学习状态
	begin
		update studentCourseList set status=2,endDate=getDate(),closeDate=getDate() from studentCourseList a, passcardInfo b where a.ID=b.enterID and b.refID=@ID and b.score>=@scorePass
		update studentCertList set result=(case when b.score>=@scorePass then 1 else 2 end),status=(case when b.score>=@scorePass then 2 else c.status end),score=b.score,closeDate=(case when b.score>=@scorePass then getDate() else null end)
			from studentCertList c, studentCourseList a, passcardInfo b where c.ID=a.refID and a.ID=b.enterID and b.refID=@ID
	end
	select @re=0
	exec writeOpLog '','成绩确认','generateScore',@registerID,'',@ID
END
GO

-- =============================================
-- CREATE Date: 2021-02-14
-- Description:	删除内训项目中超过期限不能自己删除但还未完成的课程
-- USE CASE: exec deal_expireEnterInner
-- =============================================
ALTER PROCEDURE [dbo].[deal_expireEnterInner] 
AS
BEGIN
	SET NOCOUNT ON;
	declare @ID int

	declare rc cursor for select a.ID from studentCertList a, certificateInfo b, studentCourseList c, courseInfo d where a.certID=b.certID and a.ID=c.refID and c.courseID=d.courseID and b.type=1 and a.result<>1 and datediff(d,c.regDate,getDate())-deadday>0
	open rc
	fetch next from rc into @ID
	While @@fetch_status=0 
	Begin 
		--删除
		delete from studentCertList where ID=@ID
		delete from studentCourseList where refID=@ID
		fetch next from rc into @ID
	End
	Close rc 
	Deallocate rc
END
GO

--CREATE Date:2020-11-13
--根据给定日期范围，统计报名情况，按照@refID分类汇总，并区分不同公司数据
--@refID: y,m,w,d 年月周日
--@fromID: 销售人员只能看自己的数据
ALTER PROCEDURE [dbo].[getEnterRpt]
	@refID varchar(50), @startDate varchar(50), @endDate varchar(50), @certID varchar(50), @fromID varchar(50)
AS
BEGIN
	declare @sql nvarchar(4000), @group varchar(50), @where varchar(500)
	if @refID='d'
		select @group = 'submitDate'
	if @refID='m'
		select @group = 'left(submitDate,7)'
	if @refID='y'
		select @group = 'left(submitDate,4)'
	if @refID='w'
		select @group = 'datename(week,submitDate)'

	if @startDate > ''
		select @where='submitDate>=''' + @startDate + ''''
	if @endDate > ''
		select @where=@where + ' and submitDate<=''' + @endDate + ''''
	if @certID > ''
		select @where=@where + ' and certID=''' + @certID + ''''
	if @fromID > ''
		select @where=@where + ' and fromID=''' + @fromID + ''''

	select @sql='select ' + @group + ' as submitDate,count(*) as count,sum(case when host=''' + 'znxf' + ''' then 1 else 0 end) as znxf,sum(case when host=''' + 'spc' + ''' then 1 else 0 end) as spc,sum(case when host=''' + 'shm' + ''' then 1 else 0 end) as shm from v_studentCourseList where ' + @where + ' group by ' + @group + ' order by ' + @group
	
	EXEC(@sql)
END
GO

--CREATE Date:2020-11-13
--根据给定日期范围，统计报名情况，按照@refID分类汇总，并区分不同证书数据
--@refID: y,m,w,d 年月周日
--@fromID: 销售人员只能看自己的数据
ALTER PROCEDURE [dbo].[getEnterRptPie1]
	@startDate varchar(50), @endDate varchar(50), @fromID varchar(50)
AS
BEGIN
	declare @sql nvarchar(4000), @group varchar(50), @where varchar(500), @total int
	select @group = 'certShortName', @total=1
	if @startDate > ''
		select @where='submitDate>=''' + @startDate + ''''
	if @endDate > ''
		select @where=@where + ' and submitDate<=''' + @endDate + ''''
	if @fromID > ''
		select @where=@where + ' and fromID=''' + @fromID + ''''

	select @total=count(*) from v_studentCourseList where submitDate>=@startDate and submitDate<=@endDate
	
	select @sql='select ' + @group + ' as name,count(*) as value,count(*)*100/' + cast(@total as varchar) + ' as per from v_studentCourseList where ' + @where + ' group by ' + @group + ' order by ' + @group
	EXEC(@sql)
END
GO

--CREATE Date:2020-11-13
--根据给定日期范围，统计鉴定合格率，按照@refID分类汇总，并区分不同项目数据
--@refID: y,m,w,d 年月周日
ALTER PROCEDURE [dbo].[getExamRpt]
	@refID varchar(50), @startDate varchar(50), @endDate varchar(50)
AS
BEGIN
	declare @sql nvarchar(4000), @group varchar(50), @where varchar(500)

	if @refID='d'
		select @group = 'left(startDate,10)'
	if @refID='m'
		select @group = 'left(startDate,7)'
	if @refID='y'
		select @group = 'left(startDate,4)'
	if @refID='w'
		select @group = 'datename(week,startDate)'

	if @startDate > ''
		select @where='startDate>=''' + @startDate + ''''
	if @endDate > ''
		select @where=@where + ' and startDate<=''' + @endDate + ''''
	if @where > ''
		select @where=@where + ' and status=2'

	--给定日期范围内所有的项目
	create table #temp_cert(certID varchar(50),qty int,qtyYes int)
	select @sql = 'insert into #temp_cert(certID,qty,qtyYes) select certID,sum(qty),sum(qtyYes) from (select startDate, qty, qtyYes, certID from v_generatePasscardInfo where ' + @where + ' union select startDate, qty, qtyYes, certID from v_generateApplyInfo where ' + @where + ') a'
	select @sql = @sql + ' group by certID order by certID'
	EXEC(@sql)

	--给定日期范围内所有的日期
	create table #temp_date(startDate varchar(50))
	select @sql = 'insert into #temp_date select ' + @group + ' as startDate from '
	select @sql = @sql + '(select startDate from v_generatePasscardInfo where ' + @where + ' union select startDate from v_generateApplyInfo where ' + @where + ') a'
	select @sql = @sql + ' group by ' + @group + ' order by ' + @group
	EXEC(@sql)

	--给定日期范围内的项目报名统计
	create table #temp_data(startDate varchar(50),certID varchar(50),qty int,qtyYes int)
	select @sql='insert into #temp_data select ' + @group + ' as startDate,certID,sum(qty) as qty,sum(qtyYes) as qtyYes from '
	select @sql = @sql + '(select startDate, qty, qtyYes, certID from v_generatePasscardInfo where ' + @where + ' union select startDate, qty, qtyYes, certID from v_generateApplyInfo where ' + @where + ') a'
	select @sql = @sql + ' group by ' + @group + ',certID having sum(qty)>0 order by ' + @group + ',certID'
	EXEC(@sql)

	create table #temp_result(certID varchar(50),certName varchar(100),startDate varchar(50),qty int,qtyYes int,per decimal(18,2) default(0))
	insert into #temp_result(certID,startDate) select certID,startDate from #temp_cert, #temp_date
	update #temp_result set qty=a.qty,qtyYes=a.qtyYes,per=a.qtyYes*100/a.qty from #temp_data a where #temp_result.certID=a.certID and #temp_result.startDate=a.startDate
	update #temp_result set certName=shortName from certificateInfo a where #temp_result.certID=a.certID
	update #temp_result set per=a.qtyYes*100/a.qty from #temp_cert a where #temp_result.certID=a.certID and per=0
	select certID,certName,startDate,per from #temp_result order by certID,startDate
END
GO

--CREATE Date:2020-11-13
--根据给定日期范围，统计模拟考试成绩，按照@refID分类汇总，并区分不同项目数据
--@refID: y,m,w,d 年月周日
ALTER PROCEDURE [dbo].[getMockRpt]
	@refID varchar(50), @startDate varchar(50), @endDate varchar(50), @fromID varchar(50)
AS
BEGIN
	declare @sql nvarchar(4000), @group varchar(50), @where varchar(500)

	if @refID='d'
		select @group = 'submitDate'
	if @refID='m'
		select @group = 'left(submitDate,7)'
	if @refID='y'
		select @group = 'left(submitDate,4)'
	if @refID='w'
		select @group = 'datename(week,submitDate)'

	if @startDate > ''
		select @where='submitDate>=''' + @startDate + ''''
	if @endDate > ''
		select @where=@where + ' and submitDate<=''' + @endDate + ''''
	if @fromID > ''
		select @where=@where + ' and fromID=''' + @fromID + ''''

	--给定日期范围内所有的项目
	create table #temp_cert(certID varchar(50),examScore int,examTimes int)
	select @sql = 'insert into #temp_cert(certID,examScore,examTimes) select certID,avg(examScore),avg(examTimes) from v_studentCourseList where ' + @where
	select @sql = @sql + ' group by certID order by certID'
	EXEC(@sql)

	--给定日期范围内所有的日期
	create table #temp_date(submitDate varchar(50))
	select @sql = 'insert into #temp_date select ' + @group + ' as submitDate from v_studentCourseList where ' + @where
	select @sql = @sql + ' group by ' + @group + ' order by ' + @group
	EXEC(@sql)

	--给定日期范围内的项目报名统计
	create table #temp_data(submitDate varchar(50),certID varchar(50),examScore int,examTimes int)
	select @sql='insert into #temp_data select ' + @group + ' as submitDate,certID,avg(examScore),avg(examTimes) from v_studentCourseList where ' + @where
	select @sql = @sql + ' group by ' + @group + ',certID order by ' + @group + ',certID'
	EXEC(@sql)

	create table #temp_result(certID varchar(50),certName varchar(100),submitDate varchar(50),examScore int,examTimes int)
	insert into #temp_result(certID,submitDate) select certID,submitDate from #temp_cert, #temp_date
	update #temp_result set examScore=a.examScore,examTimes=a.examTimes from #temp_data a where #temp_result.certID=a.certID and #temp_result.submitDate=a.submitDate
	update #temp_result set certName=shortName from certificateInfo a where #temp_result.certID=a.certID
	select certID,certName,submitDate,isnull(examScore,0) as examScore,isnull(examTimes,0) as examTimes from #temp_result order by certID,submitDate
END
GO

--CREATE Date:2020-11-13
--根据给定班日期范围，统计班级情况
--@adviserID: 班主任
--@archived: 是否已归档 ''所有  '0'是  '1'否
ALTER PROCEDURE [dbo].[getClassRpt]
	@startDate varchar(50), @endDate varchar(50), @certID varchar(50), @adviserID varchar(50), @archived varchar(50)
AS
BEGIN
	declare @sql nvarchar(4000), @group varchar(50), @where varchar(500)

	if @startDate > ''
		select @where='dateStart>=''' + @startDate + ''''
	if @endDate > ''
		select @where=@where + ' and dateStart<=''' + @endDate + ''''
	if @certID > ''
		select @where=@where + ' and certID=''' + @certID + ''''
	if @adviserID > ''
		select @where=@where + ' and adviserID=''' + @adviserID + ''''
	if @archived = '0'
		select @where=@where + ' and archiveDate>'''''
	if @archived = '1'
		select @where=@where + ' and archiveDate='''''

	--先找出所有符合条件的班级列表
	create table #temp_class(classID varchar(50),className varchar(50),adviserID varchar(50),adviserName varchar(50),startDate varchar(50),endDate varchar(50),status int,examDate varchar(50),diplomaDate varchar(50),archiveDate varchar(50),archiverName varchar(50),certID varchar(50),qty int,qtyApply int,qtyExam int,qtyPass int,qtyReturn int,days_study int,days_exam int,days_diploma int,days_archive int,days_study0 int,days_exam0 int,days_diploma0 int,days_archive0 int,examScore int,examTimes int)
	
	select @sql='insert into #temp_class(classID,className,adviserID,adviserName,startDate,endDate,status,archiveDate,archiverName,certID,qty,qtyApply,qtyExam,qtyPass,qtyReturn,examScore,examTimes) '
	select @sql = @sql + 'select classID,className,adviserID,adviserName,dateStart,dateEnd,status,archiveDate,archiverName,certID,qty,qtyApply,qtyExam,qtyPass,qtyReturn,examScore,examTimes from v_classInfo where ' + @where + ' and dateStart<getDate() order by dateStart desc'
	EXEC(@sql)

	--填写考试日期
	create table #temp_date(classID varchar(50),thisDate varchar(50))
	insert into #temp_date select a.classID, min(a.startDate) from (select b.classID, c.startDate from studentCourseList b, generatePasscardInfo c where b.passcardID=c.ID and b.passcardID>0
	 union select b.classID, c.startDate from studentCourseList b, generateApplyInfo c where b.applyID=c.ID and b.applyID>0) a
	 group by classID

	update #temp_class set examDate = b.thisDate from #temp_date b where #temp_class.classID=b.classID and #temp_class.qtyApply>0

	--填写证书制作日期
	truncate table #temp_date
	insert into #temp_date select b.classID, min(d.startDate) from studentCourseList b, studentCertList c, diplomaInfo d where b.refID=c.ID and c.diplomaID=d.diplomaID and c.diplomaID>''
	 group by b.classID

	update #temp_class set diplomaDate = b.thisDate from #temp_date b where #temp_class.classID=b.classID and #temp_class.qtyExam>0

	--整理数据
		--导入标准周期
	update #temp_class set days_study=a.days_study,days_exam=a.days_exam,days_diploma=a.days_diploma,days_archive=a.days_archive from certificateInfo a where #temp_class.certID=a.certID
		--计算实际周期
	update #temp_class set startDate=left(startDate,10), days_study0=datediff(d,startDate,(case when endDate='' then getdate() else endDate end)),	--结课周期
		days_exam0=(case when endDate='' then 0 else datediff(d,endDate,(case when examDate is null then getdate() else examDate end)) end),	--考试周期
		days_diploma0=(case when examDate is null then 0 else datediff(d,examDate,(case when diplomaDate is null then getdate() else diplomaDate end)) end),	--制证周期
		days_archive0=(case when diplomaDate is null then 0 else datediff(d,diplomaDate,(case when archiveDate='' then getdate() else archiveDate end)) end)		--归档周期
	update #temp_class set days_study0=(case when days_study0<0 then 0 when days_study0>0 and days_study0<8 then 8 else days_study0 end),days_exam0=(case when days_exam0<0 then 0 when days_exam0>0 and days_exam0<8 then 8 else days_exam0 end),days_diploma0=(case when days_diploma0<0 then 0 when days_diploma0>0 and days_diploma0<8 then 8 else days_diploma0 end),days_archive0=(case when days_archive0<0 then 0 when days_archive0>0 and days_archive0<8 then 8 else days_archive0 end)

	select * from #temp_class
END
GO

--CREATE Date:2020-11-13
--根据给定日期范围，统计收费情况，按照@refID分类汇总，并区分不同公司数据
--@refID: y,m,w,d 年月周日
--@fromID: 销售人员只能看自己的数据
CREATE PROCEDURE [dbo].[getIncomeRpt1]
	@refID varchar(50), @startDate varchar(50), @endDate varchar(50), @certID varchar(50), @fromID varchar(50)
AS
BEGIN
	declare @sql nvarchar(4000), @group varchar(50), @where varchar(500)
	if @refID='d'
		select @group = 'submitDate'
	if @refID='m'
		select @group = 'left(submitDate,7)'
	if @refID='y'
		select @group = 'left(submitDate,4)'
	if @refID='w'
		select @group = 'datename(week,submitDate)'

	if @startDate > ''
		select @where='submitDate>=''' + @startDate + ''''
	if @endDate > ''
		select @where=@where + ' and submitDate<=''' + @endDate + ''''
	if @certID > ''
		select @where=@where + ' and certID=''' + @certID + ''''
	if @fromID > ''
		select @where=@where + ' and fromID=''' + @fromID + ''''

	select @sql='select ' + @group + ' as submitDate,sum(price) as count,sum(case when host=''' + 'znxf' + ''' then price else 0 end) as znxf,sum(case when host=''' + 'spc' + ''' then price else 0 end) as spc,sum(case when host=''' + 'shm' + ''' then price else 0 end) as shm from v_studentCourseList where ' + @where + ' group by ' + @group + ' order by ' + @group
	
	EXEC(@sql)
END
GO

--CREATE Date:2020-11-13
--根据给定日期范围，统计收费情况，按照@refID分类汇总，并区分不同证书数据
--@refID: y,m,w,d 年月周日
--@fromID: 销售人员只能看自己的数据
CREATE PROCEDURE [dbo].[getIncomeRptPie1]
	@startDate varchar(50), @endDate varchar(50), @fromID varchar(50)
AS
BEGIN
	declare @sql nvarchar(4000), @group varchar(50), @where varchar(500), @total int
	select @group = 'certShortName', @total=1
	if @startDate > ''
		select @where='submitDate>=''' + @startDate + ''''
	if @endDate > ''
		select @where=@where + ' and submitDate<=''' + @endDate + ''''
	if @fromID > ''
		select @where=@where + ' and fromID=''' + @fromID + ''''

	select @total=sum(price) from v_studentCourseList where submitDate>=@startDate and submitDate<=@endDate
	
	select @sql='select ' + @group + ' as name,sum(price) as value,sum(price)*100/' + cast(@total as varchar) + ' as per from v_studentCourseList where ' + @where + ' group by ' + @group + ' order by ' + @group
	EXEC(@sql)
END
GO


--获取某个学员某个科目模拟考试分析汇总
ALTER PROCEDURE getStudentExamStat
	@enterID int
AS
BEGIN
	select top 100 percent b.refID,b.examID,a.seq,min(c.examName) as examName,min(a.regDate) as regDate,a.knowpointID,a.kindID,min(a.knowpointName) as knowpointName,min(a.kindName) as kindName,sum(a.score) as score,count(*) as qty,sum(case when a.score>0 then 1 else 0 end) as qtyYes from v_ref_studentQuestionList a, studentExamList b, examInfo c
		where a.refID=b.paperID and b.examID=c.examID and b.refID=@enterID group by b.refID,b.examID,a.seq,a.knowpointID,a.kindID order by b.refID,b.examID,a.seq,a.knowpointID
END
GO

--获取某个班级模拟考试分析汇总
CREATE PROCEDURE getClassExamStat
	@classID varchar(50)
AS
BEGIN
	select top 100 percent b.examID,a.knowPointID,a.kindID,min(d.examName) as examName,min(a.knowPointName) as knowPointName,min(a.kindName) as kindName,count(*) as qty,sum(case when a.status=1 then 1 else 0 end) as qtyYes from v_studentQuestionUsed a, studentExamList b, studentCourseList c, examInfo d
		where a.refID=b.paperID and b.refID=c.ID and b.examID=d.examID and c.classID=@classID group by b.examID,a.knowPointID,a.kindID order by b.examID,a.knowPointID,a.kindID
END
GO

--获取某个班级所有科目模拟考试分析汇总
ALTER FUNCTION getStudentExamStatByClass
	(@classID varchar(50))
RETURNS TABLE 
AS
RETURN 
(
	select top 100 percent b.refID,b.examID,a.seq,min(d.username) as username,min(d.name) as name,min(c.examName) as examName,max(isnull(convert(varchar(16),b.startDate,20),'')) as startDate,max(isnull(convert(varchar(16),b.endDate,20),'')) as endDate,sum(a.score) as score,sum(a.scorePer) as scorePer,sum(case when a.kindID=1 then a.score else 0 end) as score1,sum(case when a.kindID=2 then a.score else 0 end) as score2,sum(case when a.kindID=3 then a.score else 0 end) as score3,sum(case when a.kindID=1 then a.scorePer else 0 end) as scorePer1,sum(case when a.kindID=2 then a.scorePer else 0 end) as scorePer2,sum(case when a.kindID=3 then a.scorePer else 0 end) as scorePer3 from v_ref_studentQuestionList a, ref_studentExamList b, examInfo c, v_studentCourseList d
		where a.seq=b.seq and b.examID=c.examID and b.refID=d.ID and d.classID=@classID group by b.refID,b.examID,a.seq order by b.refID,b.examID,a.seq
)
GO

--自动排课表
--@mark: A classID=generateApplyInfo.ID  B classID=classInfo.ID
ALTER PROCEDURE [autoSetClassSchedule]
	@classID varchar(50), @mark varchar(50), @registerID varchar(50)
AS
BEGIN
	declare @startDate smalldatetime, @courseID varchar(50), @online int, @n int,@seq int,@kindID int,@typeID int,@hours int,@period varchar(50),@item nvarchar(100), @theDate smalldatetime,@teacher varchar(50),@classroom varchar(50),@re int,@point int
	if @mark='A'
		select @startDate = startDate, @courseID=courseID, @n=0,@teacher=teacher,@classroom=classroom from generateApplyInfo where ID=@classID
	if @mark='B'
		select @startDate = dateStart, @courseID=courseID, @n=0,@teacher=teacher,@classroom=classroom from classInfo where ID=@classID

	if not exists(select 1 from faceDetectInfo where keyID in(select ID from classSchedule where classID=@classID))
	begin
		delete from classSchedule where classID=@classID
		set datefirst 1		--星期一为第一天

		declare rc cursor for select seq,kindID,typeID,online,hours,period,item,point from schedule where courseID=@courseID and status=0 order by seq
		open rc
		fetch next from rc into @seq,@kindID,@typeID,@online,@hours,@period,@item,@point
		While @@fetch_status=0 
		Begin
			--计算当前日期
			select @theDate = dateadd(d,@n,@startDate)
			--确定该日期及时段里教师是否有空，如果没有空，则随机选取其他有空的教师
			--if @teacher > '' and exists(select 1 from classSchedule where theDate=@theDate and typeID=@typeID and teacher=@teacher and online=0)
			--begin
			--	select @teacher = ''
			--	select top 1 @teacher = teacherID from dbo.getFreeTeacherList(@theDate,@classID,@mark) order by freePoint desc
			--end

			insert into classSchedule(mark,classID,courseID,seq,kindID,typeID,online,point,hours,period,theDate,theWeek,item,address,teacher,registerID)
				select @mark,@classID,@courseID,@seq,@kindID,@typeID,@online,@point,@hours,@period,@theDate,datepart(weekday,@theDate),@item,@classroom,@teacher,@registerID
			if @typeID=1
				select @n = @n + 1	--排完下午课进入下一天
			fetch next from rc into @seq,@kindID,@typeID,@online,@hours,@period,@item,@point
		End
		Close rc 
		Deallocate rc

		if @mark='A'
			update generateApplyInfo set scheduleDate=getDate() where ID=@classID
		if @mark='B'
			update classInfo set scheduleDate=getDate() where ID=@classID
	end
	else
		select @re=1	--已有签到记录的，课表不能删除

	select isnull(@re,0) as re
END
GO

------------------
-- CREATE DATE: 2020-05-24
-- 根据给定的参数，更新可变信息
-- USE CASE: exec [updateClassSchedule] 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[updateClassSchedule]
	@ID int, @classID varchar(50),@seq int,@kindID int,@typeID int,@online int,@hours int,@period varchar(50),@theDate varchar(50),@teacher varchar(50),@address nvarchar(100),@item nvarchar(100),@point int,@std int,@memo varchar(500),@registerID varchar(50)
AS
BEGIN
	declare @re int, @msg nvarchar(100), @mark varchar(20), @courseID varchar(20)
	set datefirst 1

	--select @classID=classID, @mark=mark from classSchedule where ID=@ID
	--if @teacher > '' and exists(select 1 from v_classSchedule where theDate=@theDate and typeID=@typeID and teacher=@teacher and online=0 and ID<>@ID)
	--	select @re=1,@msg=b.className from v_classSchedule a, classInfo b where a.classID=b.ID and a.theDate=@theDate and a.typeID=@typeID and a.teacher=@teacher and online=0 and a.ID<>@ID
	--else
	--if exists(select 1 from classSchedule where classID=@classID and typeID=@typeID and mark=@mark and @theDate=convert(varchar(20),theDate,23) and ID<>@ID)
	--	select @re=2, @msg='日期有重复'
	--else
	if @ID=0
	begin
		select @courseID=max(courseID) from classSchedule where classID=@classID
		insert into classSchedule(classID,courseID,seq,kindID,typeID,online,hours,period,theDate,theWeek,teacher,address,item,point,std,memo,registerID) values(@classID,@courseID,@seq,@kindID,@typeID,@online,@hours,@period,@theDate,datepart(weekday,@theDate),@teacher,@address,@item,@point,@std,@memo,@registerID)
		select @ID=max(ID) from classSchedule where classID=@classID
	end
	else
		update classSchedule set seq=@seq,kindID=@kindID,typeID=@typeID,online=@online,point=@point,std=@std,item=@item,hours=@hours,period=@period,theDate=@theDate,theWeek=datepart(weekday,@theDate),teacher=@teacher,address=@address,memo=@memo,registerID=@registerID where ID=@ID

	select isnull(@re,0) as status, isnull(@msg,'') as msg
END
GO

------------------
-- CREATE DATE: 2020-05-24
-- 根据给定的参数，更新可变信息
-- USE CASE: exec [updateStandardSchedule] 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[updateStandardSchedule]
	@ID int, @courseID varchar(50),@seq int,@kindID int,@typeID int,@online int,@hours int,@period varchar(50),@item nvarchar(100),@point int,@memo nvarchar(500),@registerID varchar(50)

AS
BEGIN
	declare @re int, @className varchar(50)
	if @ID=0
	begin
		insert into schedule(courseID,seq,kindID,typeID,online,hours,period,item,point,memo,registerID) values(@courseID,@seq,@kindID,@typeID,@online,@hours,@period,@item,@point,@memo,@registerID)
		select @ID=max(ID) from schedule where courseID=@courseID
	end
	else
		update schedule set seq=@seq,kindID=@kindID,typeID=@typeID,online=@online,point=@point,hours=@hours,period=@period,item=@item,memo=@memo,registerID=@registerID where ID=@ID

	select isnull(@re,0) as status, isnull(@className,'') as msg, @ID as ID
END
GO

-- CREATE DATE: 2021-04-06
-- 根据给定的参数，添加或者更新教师信息
-- USE CASE: exec updateTeacherInfo 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updateTeacherInfo]
	@ID int,@teacherID varchar(50),@teacherName varchar(50),@host varchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @re int
	select @re=@ID

	if @ID=0 and not exists(select 1 from teacherInfo where teacherID=@teacherID)	-- 新纪录
	begin
		--填写生成记录
		insert into teacherInfo(teacherID,teacherName,host,memo,registerID) values(@teacherID,@teacherName,@host,@memo,@registerID)
		select @re=max(ID) from teacherInfo where registerID=@registerID
	end
	if @ID>0 and not exists(select 1 from teacherInfo where teacherID=@teacherID and ID<>@ID)	-- 保存信息
	begin
		update teacherInfo set teacherName=@teacherName,host=(case when @host='' then null else @host end),memo=@memo where ID=@ID
	end

	--自动生成用户账号
	if not exists(select 1 from userInfo where userNo=@teacherID)
	begin
		declare @passwd varchar(50)
		select @passwd = memo from dictionaryDoc where kind='userPasswd' and ID=0
		insert into userInfo(host,userNo,userName,realName,password,deptID,registerID) 
			values(@host,@teacherID,@teacherID+'.'+@host,@teacherName,@passwd,0,'system.')
	end

	--自动给予教师角色
	if not exists(select 1 from roleUserList where username=@teacherID+'.'+@host and roleID='teacher')
		insert into roleUserList(roleID,userName,host,registerID) select 'teacher',@teacherID+'.'+@host,@host,'system.'
	
	select @re as re
END
GO

--自动调整班级内重复的学号，重复的自动放到最后
--可以接受classID or ID in classInfo
ALTER PROCEDURE autoSetClassSNo
	@classID varchar(50)
AS
BEGIN
	declare @ID int,@pNo varchar(50),@SNo varchar(50),@SNo0 varchar(50),@cID int,@mark int
	if exists(select 1 from classInfo where classID=@classID)
		select @cID=ID from classInfo where classID=@classID
	else
		select @classID=classID,@cID=ID from classInfo where ID=@classID

	select @SNo0=''
	declare rc cursor for select ID,SNo from studentCourseList where classID=@classID order by SNo
	open rc
	fetch next from rc into @ID,@SNo
	While @@fetch_status=0 
	Begin 
		if @SNo=@SNo0 
		begin
			exec lookRefSNo @cID, '', '', @pNo output,@mark output
			update studentCourseList set SNo=@pNo where ID=@ID
		end
		select @SNo0=@SNo 
		
		fetch next from rc into @ID,@SNo
	End
	Close rc 
	Deallocate rc
END
GO

------------------
-- CREATE DATE: 2022-08-18
-- 根据给定的参数，保存需要比较的学员名单
-- USE CASE: exec [checkStudentOrder_import] 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[checkStudentOrder_import]
	@batchID varchar(50),@username varchar(50),@name nvarchar(50),@dept1Name nvarchar(100),@memo varchar(500),@No varchar(50)
AS
BEGIN
	if @No='' or @No='null' or @No is null
		set @No = 0
	if not exists(select 1 from import_student_order where batchID=@batchID and username=@username)
		insert into import_student_order(batchID,username,name,dept1Name,memo,No) values(@batchID,@username,@name,@dept1Name,@memo,@No)
END
GO

------------------
-- CREATE DATE: 2022-08-18
-- 根据给定的参数，处理需要比较的学员名单
-- USE CASE: exec [checkStudentOrder] 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[checkStudentOrder]
	@batchID varchar(50),@certID varchar(50)
AS
BEGIN
	--删除旧数据
	delete from import_student_order where regDate<dateadd(d,-1,getDate())
	--检查身份证
	update import_student_order set mark=1, result='身份证错误' where batchID=@batchID and [dbo].[fn_validateIDCard](username)=0
	--检查是否已注册
	update import_student_order set mark=1, result='尚未注册' where batchID=@batchID and mark=0 and username not in(select username from studentInfo)
	--检查是否已报名
	update import_student_order set mark=1, result='尚未报名' where batchID=@batchID and mark=0 and username not in(select username from v_studentCourseList where certID=@certID)
	--补充单位名称
	update import_student_order set unit=b.dept1Name + b.unit,mobile=b.mobile from import_student_order a, v_studentInfo b where a.username=b.username and a.batchID=@batchID
	--查找报名信息
	update import_student_order set enterID=b.enterID from import_student_order a, (select username,max(c.ID) as enterID from studentCourseList c, courseInfo d where c.courseID=d.courseID and d.certID=@certID group by username) b where a.username=b.username and a.batchID=@batchID and a.mark=0
	--查找班级信息
	update import_student_order set classID=b.classID,SNo=b.SNo,diplomaID=b.diplomaID,diplomaDate=b.diploma_startDate,score=b.score + (case when b.score2>'' then '/'+b.score2 else '' end),enterDate=b.regDate,passcard=(case when b.passcardID+b.applyID>0 then cast(b.passcardID+b.applyID as varchar) else '' end) from import_student_order a, v_studentCourseList b where a.enterID=b.ID and a.batchID=@batchID and a.mark=0
	--查找开班时间
	update import_student_order set startDate=convert(varchar(10),b.dateStart,23),courseName=b.courseName,className=b.classNameMemo from import_student_order a, v_classInfo b where a.classID=b.classID and a.batchID=@batchID and a.mark=0

	select * from import_student_order where batchID=@batchID order by No,ID
END
GO

------------------
-- CREATE DATE: 2022-08-27
-- 根据给定的日期，统计每天、单位、课程的招生数量（以招生确认为准）
-- 输出为excel
-- USE CASE: exec [rpt_dailyUnitCourse] 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[rpt_dailyUnitCourse]
	@dateStart nvarchar(50), @dateEnd nvarchar(50)

AS
BEGIN
	declare @sql nvarchar(max), @column nvarchar(max), @condition nvarchar(max)
	if OBJECT_ID('tempdb..#tab_rpt_dailyUnitCourse') is not null
		drop table #tab_rpt_dailyUnitCourse
	create table #tab_rpt_dailyUnitCourse([日期] varchar(50),[单位] nvarchar(100))

	select @column = N'', @condition = N''
	if @dateStart>''
	begin
		select @condition = N'submitDate>=''' + @dateStart + N''''
		if @dateEnd>''
			select @condition = @condition + N' and submitDate<=''' + @dateEnd + N''''
	end	
	else
		if @dateEnd>''
			select @condition = N'submitDate<=''' + @dateEnd + N''''

	if @condition>''
		select @condition = N' where ' + @condition + N'';

	with sub AS
	(
	select distinct shortName
	from courseInfo where status=0 and host=''
	)

	select @column+=N'[' + cast(shortName as nvarchar(50)) + N'],' from sub  

	select @column=SUBSTRING(@column,1,len(@column)-1)

	declare @cols nvarchar(max) = N'alter table [dbo].[#tab_rpt_dailyUnitCourse] add [小计] int,' + replace(@column,',',' int,') + N' int'
	exec (@cols)

	select @sql=N'insert into #tab_rpt_dailyUnitCourse select submitDate, unit, 0,' + @column + 
	N' from v_studentUnitCourseInfo pivot(sum(qty) for shortName in (' + @column + N')) as pivot_stuinfo' + @condition + N' order by submitDate,unit'

	--print(@sql)

	exec (@sql)
	select @cols = N'update #tab_rpt_dailyUnitCourse set [小计]= isnull(' + replace(@column,',',',0)+isnull(') + N',0)'
	exec (@cols)
	select @cols = N'insert into #tab_rpt_dailyUnitCourse select ''合计'','''', sum([小计]),sum(isnull(' + replace(@column,',',',0)),sum(isnull(') + N',0)) from #tab_rpt_dailyUnitCourse'
	exec (@cols)
	select * from #tab_rpt_dailyUnitCourse
END
GO

------------------
-- CREATE DATE: 2022-08-27
-- 根据给定的日期，统计每天、课程的招生数量（以招生确认为准）
-- 输出为excel
-- USE CASE: exec [rpt_dailyCourse] 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[rpt_dailyCourse]
	@dateStart nvarchar(50), @dateEnd nvarchar(50)

AS
BEGIN
	declare @sql nvarchar(max), @column nvarchar(max), @condition nvarchar(max)
	if OBJECT_ID('tempdb..#tab_rpt_dailyCourse') is not null
		drop table #tab_rpt_dailyCourse
	create table #tab_rpt_dailyCourse([日期] varchar(50))

	select @column = N'', @condition = N''
	if @dateStart>''
	begin
		select @condition = N'submitDate>=''' + @dateStart + N''''
		if @dateEnd>''
			select @condition = @condition + N' and submitDate<=''' + @dateEnd + N''''
	end	
	else
		if @dateEnd>''
			select @condition = N'submitDate<=''' + @dateEnd + N''''

	if @condition>''
		select @condition = N' where ' + @condition + N'';

	with sub AS
	(
	select distinct shortName
	from courseInfo where status=0 and host=''
	)

	select @column+=N'[' + cast(shortName as nvarchar(50)) + N'],' from sub  

	select @column=SUBSTRING(@column,1,len(@column)-1)

	declare @cols nvarchar(max) = N'alter table [dbo].[#tab_rpt_dailyCourse] add [小计] int,' + replace(@column,',',' int,') + N' int'
	exec (@cols)

	select @sql=N'insert into #tab_rpt_dailyCourse select submitDate, 0,' + @column + 
	N' from v_studentCourseInfo pivot(sum(qty) for shortName in (' + @column + N')) as pivot_stuinfo' + @condition + N' order by submitDate'

	--print(@sql)

	exec (@sql)
	select @cols = N'update #tab_rpt_dailyCourse set [小计]= isnull(' + replace(@column,',',',0)+isnull(') + N',0)'
	exec (@cols)
	select @cols = N'insert into #tab_rpt_dailyCourse select ''合计'', sum([小计]),sum(isnull(' + replace(@column,',',',0)),sum(isnull(') + N',0)) from #tab_rpt_dailyCourse'
	exec (@cols)
	select * from #tab_rpt_dailyCourse
END
GO

-- =============================================
-- CREATE Date: 2022-11-24
-- Description:	向批量学生发送添加或更新签名、照片的通知。
-- @kindID: 0 照片  1 签名
-- @selList: 名单，用逗号分隔的username/enterID
-- Use Case:	exec [sendAttections] 2,'...'
-- =============================================
ALTER PROCEDURE [dbo].[sendAttections] 
	@kindID int, @selList varchar(4000),@registerID varchar(50)
AS
BEGIN
	declare @re int
	--将名单导入到临时表
	create table #temp_photo(id varchar(50))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0, @re=0
	while @n>@j
	begin
		insert into #temp_photo(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	--添加新纪录
	insert into log_attention(refID,kindID,registerID) select id,@kindID,@registerID from #temp_photo where id not in(select refID from log_attention where kindID=@kindID)
	insert into log_generateAttention(kindID,registerID) values(@kindID,@registerID)
	select @re=max(ID) from log_generateAttention where registerID=@registerID

	--更新原有纪录
	update log_attention set status=1, regDate=getDate(), registerID=@registerID from log_attention a, #temp_photo b where a.kindID=@kindID and a.refID=b.id

	--如果是提醒签名，将原来的签名去除
	if @kindID=1
		update studentCourseList set signature=null,signatureDate=null from studentCourseList a, #temp_photo b where a.ID=b.id

	drop table #temp_photo
	return isnull(@re,0)
END

GO

------------------
-- CREATE DATE: 2022-11-24
-- 回复关于提交照片、签名的提示信息
-- USE CASE: exec [replyAttention] 1
ALTER PROCEDURE [dbo].[replyAttention]
	@refID varchar(50),@kindID int
AS
BEGIN
	update log_attention set status=2, replyDate=getDate() where refID=@refID and kindID=@kindID
END
GO

-- =============================================
-- CREATE Date: 2022-11-24
-- Description:	批量关闭签名、照片通知状态。
-- batchID: classInfo.classID;
-- @kindID: 0 照片  1 签名  
-- kind: "" 身份证  "cert":studentCertList.ID
-- @selList: 名单，用逗号分隔的username/enterID
-- Use Case:	exec [closeAttections] 2,'...'
-- =============================================
ALTER PROCEDURE [dbo].[closeAttections] 
	@batchID varchar(50), @kindID int, @kind varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	--将名单导入到临时表
	create table #temp_attention_close(id varchar(50),enterID int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_attention_close(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	--如果是签名通知，应取得enterID list 替换 username list
	if @kindID=1
		update #temp_attention_close set enterID=b.ID from #temp_attention_close a, studentCourseList b where a.id=b.username and b.classID=@batchID
	--如果是studentCertList.ID with kindID=0
	if @kind='cert' and @kindID=0
		update #temp_attention_close set id=b.username from #temp_attention_close a, studentCertList b where a.id=b.ID

	--更新原有纪录
	update log_attention set status=3, closeItem=convert(varchar(50),getDate(),120) + ' ' + @registerID from log_attention a, #temp_attention_close b where a.kindID=@kindID and a.refID=b.id and a.status<3

	drop table #temp_attention_close
END

GO

-- =============================================
-- Author:		Albert
-- Create date: 2023-03-02
-- Description:	根据ID修改视频的点播地址
-- =============================================
CREATE PROCEDURE updateVideoVod 
	@videoID varchar(50),@vod varchar(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    update videoInfo set vod=@vod where videoID = @videoID
END
GO

-- =============================================
-- CREATE Date: 2022-11-24
-- Description:	批量撤销已制作的证书，kind:0返回到待发证状态; 1拒绝发证。
-- @selList: 名单，用逗号分隔的diplomaInfo.ID
-- Use Case:	exec [cancelDiplomas] '...'
-- =============================================
ALTER PROCEDURE [dbo].[cancelDiplomas] 
	@selList varchar(4000), @kind int, @registerID varchar(50)
AS
BEGIN
	--将名单导入到临时表
	create table #temp_diploma_cancel(id varchar(50))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_diploma_cancel(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	--if @kind=1
		update #temp_diploma_cancel set id=b.diplomaID from #temp_diploma_cancel a, diplomaInfo b where a.id=b.ID

	--更新报名表
	update studentCertList set diplomaID=(case when @kind=0 then null else '*' end) from studentCertList a, #temp_diploma_cancel b where a.diplomaID=b.id

	--删除证书记录
	delete from diplomaInfo where diplomaID in(select id from #temp_diploma_cancel)

	drop table #temp_diploma_cancel
END

GO

-- =============================================
-- CREATE Date: 2022-11-24
-- Description:	批量拒绝/撤销制作证书申请。
-- @kind: 0 拒绝  1 恢复
-- @selList: 名单，用逗号分隔的studentCertList.ID
-- Use Case:	exec [refuse_diploma_order] '...'
-- =============================================
CREATE PROCEDURE [dbo].[refuse_diploma_order] 
	@selList varchar(4000), @kind int, @registerID varchar(50)
AS
BEGIN
	--将名单导入到临时表
	create table #refuse_diploma_order(id int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #refuse_diploma_order(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	if @kind=0	--拒绝
	begin
		update studentCertList set diplomaID='*' from studentCertList a, #refuse_diploma_order b where a.ID=b.id
		exec writeOpLog '','拒绝证书制作申请','refuse_diploma_order',@registerID,'',@selList
	end
	if @kind=1	--恢复
	begin
		update studentCertList set diplomaID='' from studentCertList a, #refuse_diploma_order b where a.ID=b.id
		exec writeOpLog '','恢复证书制作申请','refuse_diploma_order',@registerID,'',@selList
	end

	drop table #refuse_diploma_order
END

GO

-- =============================================
-- Author:		Albert
-- Create date: 2023-03-28
-- Description:	对某场考试，设置相同的试卷题目及顺序
-- =============================================
ALTER PROCEDURE [dbo].[syncPaper4Exam] 
	@batchID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @paperID int, @n int
    --先找一个人配置题目
	select @paperID=min(a.paperID), @n=count(*) from studentExamList a, passcardInfo b where a.refID=b.ID and b.refID=@batchID and a.kind=1
	exec addQuestions4StudentExam @paperID,1,0,'',0,1,20,0	--强制重新生成题目
	--将其复制给其他人
	if @n>1 and @paperID>0
	begin
		--删除
		delete from studentQuestionList where refID in(select a.paperID from studentExamList a, passcardInfo b where a.refID=b.ID and b.refID=@batchID and a.paperID>@paperID)
		--添加
		insert into studentQuestionList(questionID,refID,kindID,scorePer,answer) select c.questionID,a.paperID,c.kindID,c.scorePer,c.answer from studentExamList a, passcardInfo b, studentQuestionList c where a.refID=b.ID and c.refID=@paperID and b.refID=@batchID and a.paperID>@paperID 
	end
END
GO

--整班删除报名记录
--exec dbo.delEnterByClass 669
create procedure delEnterByClass(@ID int)
as
begin
	delete from studentCertList where (ID in(select a.refID from studentCourseList a, classInfo b where a.classID=b.classID and b.ID=@ID))
	delete from studentCourseList where (ID in(select a.ID from studentCourseList a, classInfo b where a.classID=b.classID and b.ID=@ID))
end

------------------
-- CREATE DATE: 2020-05-24
-- 根据给定的参数，添加或者更新导入补考报名信息
-- USE CASE: exec applyResit 1,1,'xxxx'...
CREATE PROCEDURE [dbo].[applyResit]
	@batchID int,@passNo varchar(50),@username varchar(50), @registerID varchar(50)

AS
BEGIN
	-- 如果班级里已经有报名信息，更新数据
	if exists(select 1 from applyInfo a, studentCourseList b where a.enterID=b.ID and a.refID=@batchID and b.username=@username)
		update applyInfo set applyNo=@passNo,statusApply=1 from applyInfo a, studentCourseList b where a.enterID=b.ID and a.refID=@batchID and b.username=@username
	else
	begin
		-- 如果没有找到记录，先找初考记录
		declare @enterID int, @ID int
		select @enterID=max(b.ID) from generateApplyInfo a, studentCourseList b where a.ID=@batchID and b.username=@username and a.courseID=b.courseID
		select @ID=max(ID) from applyInfo where enterID=@enterID

		-- 初考记录添加已安排补考标记
		update applyInfo set resit=1 where ID=@ID

		-- 添加申报信息
		insert into applyInfo(refID,enterID,applyNo,statusApply,kind,registerID) select @batchID,@enterID,@passNo,1,'补考',@registerID

		--更新报名表
		update studentCourseList set applyID=@batchID where ID=@enterID
	end

	return 0
END
GO

-- CREATE DATE: 2023-02-16
-- 根据给定的参数，某个学员的不同资料互换
-- USE CASE: exec exchangeMaterial '31010900...','student_photo','student_IDcardB'
ALTER PROCEDURE [dbo].[exchangeMaterial]
	@username varchar(50),@source varchar(50), @target varchar(50),@registerID varchar(50)
AS
BEGIN
	declare @event varchar(50), @f1 varchar(500), @f2 varchar(500), @ID1 int, @ID2 int,@logMemo varchar(500)
	select @f1='',@f2='',@ID1=0,@ID2=0,@logMemo=@source + '-' + @target
	select @source=ID from dictionaryDoc where kind='material' and memo=@source
	select @target=ID from dictionaryDoc where kind='material' and memo=@target
	select @ID1=ID, @f1=filename from studentMaterials where  username=@username and kindID=@source
	select @ID2=ID, @f2=filename from studentMaterials where  username=@username and kindID=@target
	if @f1>''
		if @ID2>0
			update studentMaterials set filename=@f1 where ID=@ID2
		else
			insert into studentMaterials(username,kindID,filename,registerID) values(@username,@target,@f1,@registerID)
	if @f2>''
		if @ID1>0
			update studentMaterials set filename=@f2 where ID=@ID1
		else
			insert into studentMaterials(username,kindID,filename,registerID) values(@username,@source,@f2,@registerID)
	else
		delete from studentMaterials where ID=@ID1
	-- 写操作日志
	select @event='学员资料互换'
	exec writeOpLog '',@event,'exchangeMaterial',@registerID,@logMemo,@username
	select 0 as re
END
GO

-- CREATE DATE: 2020-05-08
-- 判断给定字符串是否为空，如果是，返回指定替代值，否则返回自身。
CREATE FUNCTION [dbo].[whenull]
(	
	@str varchar(500), @p varchar(50)
)
RETURNS varchar(500) 
AS
BEGIN
	if @str='' or @str='null' or @str='undefined' set @str=@p
	RETURN @str
END
GO

-- =============================================
-- Author:		Albert
-- Create date: 2023-03-02
-- Description:	上传发票信息
-- 发票代码+发票号+作废标记 unique value
-- =============================================
CREATE PROCEDURE import_invoice_daily 
	@kind nvarchar(50),@invCode varchar(50),@invID varchar(50),@taxNo varchar(50),@taxUnit nvarchar(50),@invDate varchar(50),@item varchar(100),@amount varchar(50),@cancel varchar(50),@cancelDate varchar(50),@operator nvarchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	if not exists(select 1 from invoiceInfo where invCode=@invCode and invID=@invID and cancel=iif(@cancel='是',1,0))
	begin
		
		insert into invoiceInfo(kind,invCode,invID,taxNo,taxUnit,invDate,item,amount,cancel,cancelDate,payType,payStatus,operator,memo,registerID)
		select @kind,@invCode,@invID,@taxNo,@taxUnit,[dbo].[whenull](@invDate,null),REPLACE(REPLACE(@item,'*非学历教育服务*',''),'培训费',''),@amount,iif(@cancel='是',1,0)
		,[dbo].[whenull](@cancelDate,null),(case when PATINDEX('%支付宝%',@memo)>0 then '支付宝' when PATINDEX('%微信%',@memo)>0 then '微信' when PATINDEX('%现金%',@memo)>0 then '现金' when PATINDEX('%转账%',@memo)>0 then '转账' else '' end)
		,iif(PATINDEX('%转账%',@memo)>0,1,0),@operator,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@memo,'支付宝',''),'微信',''),'现金',''),'转账',''),'换收据',''),' ',''),@registerID
	end
END
GO

-- =============================================
-- CREATE Date: 2020-10-02
-- Description:	批量标记收款（在应收款发票中操作）。
-- @selList: ID
-- =============================================
CREATE PROCEDURE [dbo].[setPayReceive] 
	@selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	--为创建临时表
	create table #temp(id int)
	declare @n int, @j int, @re int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0, @re=0
	while @n>@j
	begin
		insert into #temp values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	update invoiceInfo set payStatus=0, checkDate=getDate(), checker=@registerID from #temp a where invoiceInfo.ID=a.id and payStatus=1
	drop table #temp
END
GO

--CREATE Date:2023-08-25
--根据给定日期，统计不同收费方式的收费情况
ALTER PROCEDURE [dbo].[getDailyIncomeRpt]
	@startDate varchar(50), @endDate varchar(50)
AS
BEGIN
	select @endDate = iif(@endDate='',convert(varchar(20),getDate(),23),@endDate)
	create table #tbl (item varchar(50),amount int, inv int, mark int default(0))
	insert into #tbl(item,amount,inv) select payType,sum(amount),count(*) from(
		select payType,amount from v_invoiceInfo where invDate>=@startDate and invDate<=@endDate and amount>0 and cancel=0 and payStatus=0		--正收入发票, 不包含应收
		union all select typeName, amount from v_payReceiptInfo where datePay>=@startDate and datePay<=@endDate	--收据
		) a group by payType
	insert into #tbl(item,amount,inv) select '退费',-sum(ABS(amount)),count(*) from (
		select amount from v_invoiceInfo where invDate>=@startDate and invDate<=@endDate and amount<0	--红冲发票
		union all select amount from v_invoiceInfo where cancelDate>=@startDate and cancelDate<=@endDate and cancel=1	--作废发票
		) a
	insert into #tbl(item,amount,inv) select '银行到账',sum(amount),count(*) from v_invoiceInfo where checkDate>=@startDate and checkDate<=@endDate 	--转账确认
	insert into #tbl(item,amount,inv) select '合作单位付款',sum(amount),count(*) from v_invoiceInfo where checkDate>=@startDate and checkDate<=@endDate and 1=0 	--合作单位转账确认
	insert into #tbl(item,amount,inv,mark) select '收入合计',sum(amount),sum(inv),1 from #tbl
	insert into #tbl(item,amount,inv,mark) select '应收账款',sum(amount),count(*),2 from v_invoiceInfo where payStatus=1 	--应收账款(本校)
	insert into #tbl(item,amount,inv,mark) select '应收账款(合作单位)',sum(amount),count(*),2 from v_invoiceInfo where payStatus=1 and 1=0	--应收账款(合作单位)
	insert into #tbl(item,amount,inv,mark) select '应收账款合计',sum(amount),sum(inv),1 from #tbl where mark=2
	select item as 科目, isnull(amount,0) as 收入, isnull(inv,0) as 票据张数, mark from #tbl
END
GO

--CREATE Date:2023-08-25
--根据给定日期，统计不同项目的报名情况
ALTER PROCEDURE [dbo].[getDailyEnterRpt]
	@startDate varchar(50), @endDate varchar(50)
AS
BEGIN
	select @endDate = iif(@endDate='',convert(varchar(20),getDate(),23),@endDate)
	create table #tbl (courseID varchar(50),item varchar(50),amount int, inv int, mark int default(0))
	insert into #tbl(courseID, item) select courseID, shortName from v_courseInfo where status=0 and host=''
	update #tbl set amount = b.count from #tbl a, (select courseID, count(*) as count from v_studentCourseList where submitDate>=@startDate and submitDate<=@endDate and status<3 and host in('znxf','shm','spc') group by courseID) b where a.courseID=b.courseID	--报名人数(不包含退课的及合作单位的)
	update #tbl set inv = d.count from #tbl a, (select b.courseID, count(*) as count from v_studentCourseList b, classInfo c where b.classID=c.classID and c.pre=1 and b.status<3 and b.submitDate>'' group by b.courseID) d where a.courseID=d.courseID	--预备班人数(不包含退课的), 包括合作单位已提交的
	insert into #tbl(item,amount,inv,mark) select '合计',sum(amount),sum(inv),1 from #tbl
	select item as 科目, isnull(amount,0) as 报名人数, isnull(inv,0) as 未开班累计人数, courseID, mark from #tbl
END
GO


--CREATE Date:2023-07-30
--根据给定日期、类别，列出明细
--kind: 收费类型、退费、银行到账、合作单位付款、应收账款、应收账款(合作单位)
ALTER PROCEDURE [dbo].[getDailyIncomeRptDetail]
	@startDate varchar(50), @endDate varchar(50), @kind varchar(50)
AS
BEGIN
	select @endDate = iif(@endDate='',convert(varchar(20),getDate(),23),@endDate)
	if @kind='现金' or @kind='支付宝' or @kind='微信' or @kind='银行转账' or @kind='支票' 
		select payType,amount,invCode,invID,invDate,item,memo from v_invoiceInfo where invDate>=@startDate and invDate<=@endDate and amount>0 and cancel=0 and payStatus=0 and payType=@kind		--正收入发票, 不包含应收
		union all select typeName,amount,'', invoice,datePay,title,memo from v_payReceiptInfo where datePay>=@startDate and datePay<=@endDate and typeName=@kind	--收据
	if @kind='退费'
		select payType,amount,invCode,invID,invDate,item,memo from v_invoiceInfo where invDate>=@startDate and invDate<=@endDate and amount<0	--红冲发票
		union all select payType,amount,invCode,invID,cancelDate,item,memo from v_invoiceInfo where cancelDate>=@startDate and cancelDate<=@endDate and cancel=1	--作废发票
	if @kind='银行到账'
		select payType,amount,invCode,invID,checkDate,item,memo from v_invoiceInfo where checkDate>=@startDate and checkDate<=@endDate	--银行到账
	if @kind='合作单位付款'
		select payType,amount,invCode,invID,invDate,item,memo from v_invoiceInfo where invDate>=@startDate and invDate<=@endDate and 1=0	--合作单位付款
	if @kind='应收账款'
		select payType,amount,invCode,invID,invDate,item,memo from v_invoiceInfo where payStatus=1 	--应收账款(本校
	if @kind='应收账款(合作单位)'
		select payType,amount,invCode,invID,invDate,item,memo from v_invoiceInfo where payStatus=1 and 1=0	--应收账款(合作单位)
END
GO


--CREATE Date:2023-07-30
--根据给定日期、类别，列出明细
--kind: courseID
ALTER PROCEDURE [dbo].[getDailyEnterRptDetail]
	@startDate varchar(50), @endDate varchar(50), @kind varchar(50)
AS
BEGIN
	select @endDate = iif(@endDate='',convert(varchar(20),getDate(),23),@endDate)
	select SNo as 学号, username as 身份证, name as 姓名, shortName as 培训项目, submitDate as 报名日期, unit as 单位名称 from v_studentCourseList where submitDate>=@startDate and submitDate<=@endDate and status<3 and courseID=@kind and host in('znxf','shm','spc')
END
GO


--CREATE Date:2021-07-10
--根据给定石化公司部门ID，返回开票信息及付款类型
ALTER FUNCTION [dbo].[getDeptPayTitle](
	@deptID int
)
RETURNS @tab TABLE (payNow int, title nvarchar(500))
AS
BEGIN
	declare @kind int, @payNow int, @title nvarchar(500)
	if exists(select 1 from deptInfo where deptID=@deptID)
	begin
		select @kind=accountKind, @payNow=payNow, @title=title from deptInfo where deptID=@deptID
		if @kind=2
			select @title=item from dictionaryDoc where kind='SPCtitle'	--报账类型的部门，选取石化公司统一开票信息
		insert into @tab(payNow,title) select @payNow,@title
	end

	return
END
GO

-- =============================================
-- CREATE Date: 2023-06-01
-- Description:	根据名单提取报名数据
-- @selList: 名单，用逗号分隔的ID in applyInfo
-- Use Case:	exec [getApplyListByList] '...'
-- =============================================
ALTER PROCEDURE [dbo].[getApplyListByList] 
	@selList varchar(4000)
AS
BEGIN
	declare @kindID int, @unit nvarchar(200)
	--将名单导入到临时表
	create table #temp(id int, punit nvarchar(200))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end
	update #temp set punit=c.hostName from #temp a, v_applyInfo d, studentInfo b, hostInfo c where a.id=d.id and d.username=b.username and c.hostNo=b.host
	select name,sexName,educationName,username,mobile,iif(a.unit>'',a.unit,punit) as unit,iif(job='','管理',job) as job,link_address,IDdateStart,IDdateEnd,photo_filename as file1,certName,c.linker,a.ID,file2, (case when employe_filename>'' then N'工作证明' when job_filename>'' then N'居住证' when social_filename>'' then N'社保' else '' end) as jobcert, (case when employe_filename>'' then employe_filename when job_filename>'' then job_filename when social_filename>'' then social_filename else '' end) as jobfile,a.tax from v_applyInfo a, #temp b, hostInfo c where a.ID=b.id and a.host=c.hostNo order by passNo,a.ID
END
GO

-- =============================================
-- CREATE Date: 2025-09-27
-- Description:	根据classID获取generateApplyInfo数据
-- Use Case:	exec [getClassInfo] '...'
-- =============================================
CREATE PROCEDURE [dbo].[getClassInfo] 
	@classID int
AS
BEGIN
	select ID,applyID,planID,planQty,notes,startDate,endDate from v_generateApplyInfo where ID=@classID
END
GO

-- CREATE DATE: 2023-05-30
-- 申报说明
CREATE PROCEDURE [dbo].[setApplyMemo]
	@ID int, @step nvarchar(50), @memo nvarchar(500)
AS
BEGIN
	update applyInfo set step=@step,memo1=isnull(memo1,'')+'<br>'+isnull(memo,''),memo = @memo + ' ' + convert(varchar(20),getDate(),120) where ID=@ID
END
GO

-- CREATE DATE: 2023-05-30
-- 上传报名表记录
CREATE PROCEDURE [dbo].[setApplyUpload]
	@ID int
AS
BEGIN
	update applyInfo set upload=1,memo1=isnull(memo1,'') + '<br>' + '上传报名表' + convert(varchar(20),getDate(),120) where ID=@ID
END
GO

-- CREATE DATE: 2023-05-30
-- 上传照片
CREATE PROCEDURE [dbo].[setApplyPhotoUpload]
	@ID int
AS
BEGIN
	update applyInfo set memo1=isnull(memo1,'') + '<br>' + '上传照片' + convert(varchar(20),getDate(),120) where ID=@ID
END
GO


-- CREATE DATE: 2023-02-16
-- 生成一个班级的班级/申报报名表
-- USE CASE: exec [generate_emergency_exam_materials_byclass] 1
ALTER PROCEDURE [dbo].[generate_emergency_exam_materials_byclass]
	@batchID int, @selList varchar(4000), @keyID int, @fn nvarchar(100), @registerID varchar(50)
AS
BEGIN
	--将名单导入到临时表
	create table #temp(id int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	if @keyID=2		--班级
		update studentCourseList set file1='/upload/students/firemanMaterials/' + cast(b.ID as varchar) + '_' + b.name + '_' + b.username + @fn from studentCourseList a, v_applyInfo b, #temp c where a.ID=b.enterID and b.ID=c.id
	if @keyID=5		--报名表
		update studentCourseList set file2='/upload/students/firemanMaterials/' + cast(b.ID as varchar) + '_' + b.name + '_' + b.username + @fn from studentCourseList a, v_applyInfo b, #temp c where a.ID=b.enterID and b.ID=c.id
	--exec writeOpLog @fn,'generate_emergency_exam_materials_byclass',@registerID,@keyID,@batchID
	select a.ID,name,username,enterID,entryform from v_applyInfo a, #temp b where a.ID=b.id and a.signature>'' order by a.ID
END
GO

-- CREATE DATE: 2024-04-27
-- 检查某个班级是否有指定的学员
CREATE FUNCTION [dbo].[getApplyCount]
(	
	@refID int, @username varchar(50)
)
RETURNS int 
AS
BEGIN
	declare @re int
	SELECT @re=count(*) from applyInfo a, studentCourseList b, studentInfo c where a.refID=@refID and a.enterID=b.ID and b.username=c.username and (b.username=@username or c.name=@username)
	RETURN isnull(@re,0)
END
GO

-- CREATE DATE: 2024-04-27
-- 检查某个班级的学员数量
CREATE FUNCTION [dbo].[getGenerateApplyCount]
(	
	@refID int
)
RETURNS int 
AS
BEGIN
	declare @re int
	SELECT @re=count(*) from applyInfo where refID=@refID
	RETURN isnull(@re,0)
END
GO

-- CREATE DATE: 2020-05-08
-- 返回某个课表的签到情况：qty 总人数 qty0 签到总数 qty1 本班签到数 qty2 其他签到数。
-- USE CASE: select * from dbo.[getCheckinQty] 1
ALTER FUNCTION [dbo].[getCheckinQty]
(	
	@refID int
)
RETURNS varchar(1000)
AS
BEGIN
	declare @qty int, @qty0 int, @qty1 int, @qty2 int, @classID int
	select @classID=classID from classSchedule where ID=@refID
	SELECT @qty=count(*) from applyInfo where refID=@classID
	select @qty0 = count(*) from checkinInfo where refID=@refID and kindID=1
	select @qty1=count(*) from applyInfo a, checkinInfo b where a.enterID=b.enterID and b.refID=@refID and a.refID=@classID

	select @qty2=@qty0-@qty1

	RETURN cast(@qty as varchar) + '**' + cast(@qty0 as varchar) + '**' + cast(@qty1 as varchar) + '**' + cast(@qty2 as varchar)
END
GO

-- CREATE DATE: 2023-02-17
-- 学员退费
ALTER PROCEDURE [dbo].[enterRefund]
	@enterID int,@amount decimal(18,2),@dateRefund varchar(50),@memo nvarchar(500), @registerID varchar(50)
AS
BEGIN
	update studentCourseList set refund_memo=@memo, pay_status=2, refund_amount=@amount, dateRefund=@dateRefund, refunderID=@registerID where ID=@enterID
	exec writeOpLog '','退款','enter',@registerID,@memo,@enterID
END
GO

-- CREATE DATE: 2023-05-26
-- 学员付款
CREATE PROCEDURE [dbo].[enterPay]
	@enterID int,@amount decimal(18,2),@pay_kind int,@pay_type int,@memo nvarchar(500), @registerID varchar(50)
AS
BEGIN
	update studentCourseList set pay_kindID=@pay_kind, pay_type=@pay_type, pay_status=1, amount=@amount, datePay=getDate(), pay_checkDate=getDate(), pay_memo=@memo, pay_checker=@registerID where ID=@enterID
	exec writeOpLog '','付款','enter',@registerID,@memo,@enterID
END
GO

-- CREATE DATE: 2023-05-26
-- 诺诺支付开票信息
-- kind: 0 付款  1 退款  2 开票
-- payStatus: 支付状态（0--待支付 1--已支付 2--支付失败 3--关闭 4--退款中 5--退款成功 6--退款失败）
ALTER PROCEDURE [dbo].[setAutoPayInfo]
	@kind int,@enterOrder varchar(50),@amount decimal(18,2),@payStatus int,@payType varchar(50),@payTime varchar(50),@subject nvarchar(500),@customerTaxnum varchar(50),@orderNo varchar(50),@outOrderNo varchar(50),@userId varchar(50),@phone varchar(50),@memo nvarchar(500)
AS
BEGIN
	declare @classID varchar(50),@enterID int
	if (@kind=1 and @payStatus=5) or (@kind=2 and @payStatus=1)		--退款/发票时，根据诺诺订单号来匹配原付款记录
		select @enterID=enterID from autoPayInfo where orderNo=@orderNo and kind=0 and payStatus=1
	else
		select @enterID=left(@enterOrder,charindex('-',@enterOrder)-1)

	if not exists(select 1 from autoPayInfo where enterID=@enterID and kind=@kind and payStatus=@payStatus)
	begin
		insert into autoPayInfo (kind,enterID,enterOrder,amount,payType,payStatus,payTime,subject,customerTaxnum,orderNo,outOrderNo,userId,phone,memo) values(@kind,@enterID,@enterOrder,@amount,@payType,@payStatus,@payTime,@subject,@customerTaxnum,@orderNo,@outOrderNo,@userId,@phone,@memo)
		if @kind=0 and @payStatus=1
		begin
			select @classID=a.classID from classInfo a, studentCourseList b where a.courseID=b.courseID and b.ID=@enterID and a.pre=1 and a.host=''
			--如果没有班级，缴费后自动进入预备班
			update studentCourseList set autoPay=1,pay_status=1,pay_type=iif(@payType='WECHAT',2,1),datePay=@payTime,amount=@amount,checked=1,checkDate=getDate(),submited=1,submitDate=getDate(),pay_memo=isnull(pay_memo,'') + @userId + ':' + @outOrderNo,classID=iif(classID is null,@classID,classID),pay_checker='system.' where ID=@enterID
			--如果没有课表，添加课表
			if not exists(select 1 from studentLessonList where refID=@enterID)
				exec rebuildStudentLesson @enterID
		end
		if @kind=1 and @payStatus=5
		begin
			update studentCourseList set pay_status=2,refund_amount=@amount,dateRefund=@payTime,refunderID='system.',refund_memo=isnull(refund_memo,'')+@outOrderNo where ID=@enterID
		end
		if @kind=2 and @payStatus=1
			update studentCourseList set autoInvoice=1,invoice=@outOrderNo,file5=@memo,dateInvoice=@payTime,dateInvoicePick=getDate(),invoice_amount=@amount,needInvoice=0,title=@userId+' '+@customerTaxnum where ID=@enterID
		declare @event nvarchar(50)
		select @event=(case when @kind=0 then '接口付款' when @kind=1 then '接口退款' else '接口开票' end)
		exec writeOpLog '',@event,'autoPayInfo','system.',@memo,@enterID
	end
END
GO

-- CREATE DATE: 2021-05-13
-- 课表更新后，修改已报名人员的课表
-- USE CASE: exec [rebuildStudentLessonByUsername] '120109196812070029'
CREATE PROCEDURE [dbo].[rebuildStudentLessonByUsername]
	@username varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	declare @enterID int,@courseID varchar(50)
	declare rc cursor for select ID,courseID from studentCourseList where username=@username
	open rc
	fetch next from rc into @enterID, @courseID
	While @@fetch_status=0 
	Begin 
		--添加课表
		delete from studentLessonList where refID=@enterID
		insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,@enterID,hours,'system.' from lessonInfo where courseID=@courseID and status=0

		--添加课件
		delete from studentCoursewareList where refID in(select ID from studentLessonList where refID=@enterID)
		insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,'system.' from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@enterID and a.status=0

		--添加视频
		delete from studentVideoList where refID in(select ID from studentLessonList where refID=@enterID)
		insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,'system.' from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@enterID and a.status=0

		--添加考试，题目暂不生成
		if exists(select 1 from  examInfo where courseID=@courseID and status=0)
		begin
			delete from studentExamList where refID=@enterID
			insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,kind,mark) select @username,examID,@enterID,minutes,minutes*60,scoreTotal,scorePass,kindID,0,0 from examInfo where courseID=@courseID and status=0
		end

		fetch next from rc into @enterID, @courseID
	End
	Close rc 
	Deallocate rc
END
GO

-- CREATE DATE: 2021-05-13
-- 课表更新后，修改已报名人员的课表
-- USE CASE: exec [rebuildStudentLessonByDate] '2024-01-01'
CREATE PROCEDURE [dbo].[rebuildStudentLessonByDate]
	@date varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	declare @enterID int,@courseID varchar(50),@username varchar(50)
	declare rc cursor for select a.ID, a.courseID, a.username from studentCourseList a left outer join studentLessonList b on a.ID=b.refID where b.refID is null and a.status<2 and a.regDate>=@date
	open rc
	fetch next from rc into @enterID, @courseID, @username
	While @@fetch_status=0 
	Begin 
		--添加课表
		delete from studentLessonList where refID=@enterID
		insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,@enterID,hours,'system.' from lessonInfo where courseID=@courseID and status=0

		--添加课件
		delete from studentCoursewareList where refID in(select ID from studentLessonList where refID=@enterID)
		insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,'system.' from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@enterID and a.status=0

		--添加视频
		delete from studentVideoList where refID in(select ID from studentLessonList where refID=@enterID)
		insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,'system.' from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@enterID and a.status=0

		--添加考试，题目暂不生成
		if exists(select 1 from  examInfo where courseID=@courseID and status=0)
		begin
			delete from studentExamList where refID=@enterID
			insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,kind,mark) select @username,examID,@enterID,minutes,minutes*60,scoreTotal,scorePass,kindID,0,0 from examInfo where courseID=@courseID and status=0
		end

		fetch next from rc into @enterID, @courseID, @username
	End
	Close rc 
	Deallocate rc
END
GO

--CREATE Date:2021-07-10
--根据给定参数，返回当天课程列表
--mark: 0 每天一次考勤  1 上下午分别考勤
--drop FUNCTION [dbo].[getCurrScheduleList]
ALTER FUNCTION [dbo].[getCurrScheduleList]
(	
	@host varchar(50)
)
RETURNS @tab TABLE (ID int, classID varchar(50),courseID varchar(50),title nvarchar(200),typeID int,qty varchar(100))
AS
BEGIN 
	declare @hour int
	select @hour=DATEPART(HOUR, GETDATE())
	insert into @tab
	select a.ID,b.ID as classID,a.courseID,a.shortName + iif(checkinMark=1,a.typeName,'') as title, typeID, [dbo].[getCheckinQty](a.ID) as qty from v_classSchedule a, generateApplyInfo b where a.classID=b.ID and a.mark='A' and a.online=0 and a.typeID=iif(checkinMark=0 or @hour<12,0,1) and a.theDate=convert(varchar(20),getDate(),23) and b.host=iif(@host='','znxf',@host)
	union
	select a.ID,b.ID as classID,a.courseID,a.shortName + iif(checkinMark=1,a.typeName,'') as title, typeID, '0' from v_classSchedule a, classInfo b where a.classID=b.ID and a.mark='B' and a.online=0 and a.typeID=iif(checkinMark=0 or @hour<12,0,1) and a.theDate=convert(varchar(20),getDate(),23) and b.host=@host

	return
END
GO

-- =============================================
-- CREATE Date: 2021-03-24
-- Description:	删除课表。
-- Use Case:	exec [delStandardSchedule] 1
-- =============================================
CREATE PROCEDURE [dbo].[delStandardSchedule] 
	@ID varchar(50), @memo nvarchar(50), @registerID varchar(50)
AS
BEGIN
	delete from schedule where ID=@ID
	-- 写操作日志
	exec writeOpLog '','删除课表','delStandardSchedule',@registerID,@memo,@ID
END

GO

-- =============================================
-- CREATE Date: 2021-03-24
-- Description:	删除课表。
-- Use Case:	exec [delSchedule] 1
-- =============================================
CREATE PROCEDURE [dbo].[delSchedule] 
	@ID varchar(50), @memo nvarchar(50), @registerID varchar(50)
AS
BEGIN
	delete from classSchedule where ID=@ID
	-- 写操作日志
	exec writeOpLog '','删除班级课表明细','delStandardSchedule',@registerID,@memo,@ID
END

GO

-- CREATE DATE: 2023-05-26
-- 获取报名收费信息，为自动缴费提供参数
-- kindID:  0 pay  1 refund  2 invoice  3 对账单
ALTER PROCEDURE [dbo].[getEnterPayInfo]
	@enterID int, @kindID int
AS
BEGIN
	declare @enterOrder varchar(50)
	if @kindID=0
	begin
		select @enterOrder=cast(@enterID as varchar) + '-' + cast(autoPay_seq as varchar) from studentCourseList where ID=@enterID
		update studentCourseList set autoPay_seq = autoPay_seq + 1 where ID=@enterID
	end
	else
		select @enterOrder=enterOrder from autoPayInfo where enterID=@enterID and kind=0
	select @enterOrder as enterOrder, name, 'znxf' as host, price as amount, shortName as item from v_studentCourseList where ID=@enterID
END
GO

-- CREATE DATE: 2024-01-22
-- 人脸考勤数据处理
-- @selList: classSchedule.ID with split ','
-- USE CASE: exec [setFaceCheckin] 1
ALTER PROCEDURE [dbo].[setFaceCheckin]
	@username varchar(50), @file1 varchar(500), @selList varchar(4000), @confidence float
AS
BEGIN
	--将名单导入到临时表
	create table #temp(id int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	declare @re int, @msg varchar(50), @enterID int, @file2 varchar(200), @name nvarchar(50), @refID int

	select @enterID=0, @name=name from studentInfo where username=@username
	select @enterID=d.ID, @refID=c.id from applyInfo a, classSchedule b, #temp c, studentCourseList d where b.ID=c.id and b.classID=a.refID and a.enterID=d.ID and b.mark='A' and d.username=@username

	if @enterID=0
	begin
		declare rc cursor for select id from #temp
		open rc
		fetch next from rc into @refID
		While @@fetch_status=0 and @j>0
		Begin
			if exists(select 1 from studentCourseList where username=@username and status<2 and courseID=(select courseID from classSchedule where ID=@refID))
			begin
				select @enterID=max(ID) from studentCourseList where username=@username and status<2 and courseID=(select courseID from classSchedule where ID=@refID)
				select @j=0
			end
			if @j>0
				fetch next from rc into @refID
		End
		Close rc 
		Deallocate rc
	end

	if @enterID>0
	begin
		if not exists(select 1 from checkinInfo where enterID=@enterID and refID=@refID)
		begin
			insert into checkinInfo(enterID,kindID,refID) values(@enterID,1,@refID)
			select @re = max(ID) from checkinInfo where kindID=1 and enterID=@enterID and refID=@refID
			--记录人脸数据
			select @file2 = isnull(filename,'') from studentMaterials where username=@username and kindID=0
			insert into faceDetectInfo(refID,keyID,kindID,file1,file2,status,confidence) values(@enterID,@refID,2,@file1,@file2,0,@confidence)
			--标记照片
			update studentInfo set scanPhoto=1 where username=@username
			select @re=0, @msg='签到成功'
		end
		else
			select @re=2, @msg='重复签到'
	end
	else
	begin
		select @re=1, @msg='未报课程'
		insert into log_checkin_no_course(username,selList,file1) values(@username,@selList,@file1)
	end
	select isnull(@re,0) as status, @name as name, isnull(@msg,'') as msg
END
GO

-- CREATE DATE: 2024-01-22
-- 人脸考勤数据处理: 删除考勤
-- @ID: checkinInfo.ID
-- USE CASE: exec [cancelFaceCheckin] 1
CREATE PROCEDURE [dbo].[cancelFaceCheckin]
	@ID int
AS
BEGIN
	declare @enterID int, @refID int, @username varchar(50), @name nvarchar(50), @courseName nvarchar(60), @logMemo nvarchar(500)
	select @enterID=enterID, @refID=refID, @username=username, @name=name from v_checkinInfo where ID=@ID
	select @courseName=shortName from v_classSchedule where ID=@refID
	delete from faceDetectInfo where refID=@enterID and keyID=@refID
	delete from checkinInfo where ID=@ID
	select @logMemo = @username + @name + '-' + @courseName
	exec writeOpLog '','删除考勤','cancelFaceCheckin','',@logMemo,@refID
END
GO

-- CREATE DATE: 2023-10-13
-- 根据学员查找照片
-- USE CASE: exec [getPhotoByUsername] 1
CREATE PROCEDURE [dbo].[getPhotoByUsername]
	@username varchar(50)
AS
BEGIN
	declare @re varchar(500)
	select @re = filename from [dbo].[studentMaterials] where username=@username and kindID=0
	select isnull(@re,'') as filename
END
GO

-- =============================================
-- CREATE Date: 2020-05-08
-- Description:	更新学员照片库信息。
-- Use Case:	exec setStudentPhotoFaceID '310....' 
-- =============================================
CREATE PROCEDURE [dbo].[setStudentPhotoFaceID] 
	@username varchar(50), @faceID varchar(500), @faceScore varchar(50)
AS
BEGIN
	update studentInfo set faceID=@faceID, faceScore=@faceScore where username=@username
END
GO


-- CREATE DATE: 2024-06-23  拉布大林
-- 获取安监班级的刷脸考勤表
-- USE CASE: exec [getClassCheckinList] '1681'
ALTER PROCEDURE [dbo].[getClassCheckinList]
	@classID varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
 
	DECLARE @SqlStatement NVARCHAR(MAX), @ListToPivot  NVARCHAR(4000), @fields  NVARCHAR(4000), @updates  NVARCHAR(MAX), @theDate varchar(50), @i int, @mark int
	select @ListToPivot='', @i=0, @fields = '' ,@updates = '', @mark=checkinMark from generateApplyInfo where ID=@classID

	declare curs cursor for select convert(varchar(20),theDate,23) + iif(@mark=1,typeName,'') as theDate from v_classSchedule where mark='A' and online=0 and (typeID=0 or typeID=@mark) and classID=@classID order by theDate,typeID
	open curs
	fetch next from curs into @theDate
	while @@FETCH_STATUS = 0
	BEGIN
		select @fields = @fields + ',[' + @theDate + '] varchar(200)'
		select @ListToPivot = @ListToPivot + iif(@i>0,',','') + '[' + @theDate + ']', @i=@i+1
		select @updates = @updates + ' update @tb set [' + @theDate + ']=b.file1 + '','' + b.file2 from @tb a, [dbo].[faceDetectInfo] b where a.[' + @theDate + ']=b.keyID and a.enterID=b.refID and b.kindID=2'
		fetch next from curs into @theDate
	end
	CLOSE curs
	DEALLOCATE curs
	
	--q1:本班签到次数  q2:其他签到次数  q3:总签到次数
	SET @SqlStatement = N'
	declare @tb table(SNo varchar(50),passNo varchar(50),ID int,enterID int, qty int, username varchar(50), name nvarchar(50)' + @fields + ')
	declare @mark int
	select @mark=' + cast(@mark as varchar) + ' 
	insert into @tb
		SELECT * FROM (
		  SELECT
			c.SNo,
			c.passNo,
			c.applyID,
			c.enterID,
			0 as qty,
			username,
			name,
			theDate,
			d.refID
		  FROM (select * from (select SNo,passNo,ID as applyID,enterID, username, name from v_applyInfo where refID=' + @classID + ') a,
		  (select ID, convert(varchar(20),theDate,23) + iif(@mark=1,typeName,'''') as theDate from v_classSchedule where mark=''A'' and (typeID=0 or typeID=@mark) and classID=' + @classID + ') b) c 
		  left outer join (select enterID, refID, 1 as checkin from checkinInfo where kindID=1) d on c.ID=d.refID and c.enterID=d.enterID
		) e
		PIVOT (
		  MAX(refID)
		  FOR [theDate]
		  IN (' + @ListToPivot + ')
		) AS PivotTable; 
		update @tb set qty=dbo.getEnterCheckinOutClassQty(enterID,' + @classID + ');
		'
		 + @updates + '

	SELECT * FROM @tb order by passNo,ID
	';
 
	EXEC(@SqlStatement)
END
GO

-- CREATE DATE: 2023-02-16
-- 设置/取消学员看视频时免签
-- USE CASE: exec [setCheckPass] 1
ALTER PROCEDURE [dbo].[setCheckPass]
	@enterID int,@registerID varchar(50)
AS
BEGIN
	declare @event varchar(50)
	update studentCourseList set check_pass=iif(check_pass=0,1,0) where ID=@enterID
	update studentVideoList set shotNow=0 where refID in(select ID from studentLessonList where refID=@enterID)
	-- 写操作日志
	select @event='设置/取消免签'
	exec writeOpLog '', @event,'setCheckPass',@registerID,@enterID,@enterID
END
GO

-- CREATE DATE: 2023-02-16
-- 录入第三方题库(从网上爬取)
-- USE CASE: exec [addNewQuestionOther] 1
-- truncate table [questionOther]
ALTER PROCEDURE [dbo].[addNewQuestionOther]
	@mark varchar(50), @knowPointID varchar(50), @kindID int, @questionName nvarchar(500), @answer varchar(200), @memo nvarchar(500), @A nvarchar(200), @B nvarchar(200), @C nvarchar(200), @D nvarchar(200), @E nvarchar(200), @F nvarchar(200), @id_A varchar(50), @id_B varchar(50), @id_C varchar(50), @id_D varchar(50), @id_E varchar(50), @id_F nvarchar(50)
AS
BEGIN
	insert into [dbo].[questionOther](mark, knowPointID, kindID, questionName, answer, memo, A, B, C, D, E, F, id_A, id_B, id_C, id_D, id_E, id_F) values(@mark, @knowPointID, @kindID, @questionName, @answer, @memo, @A, @B, @C, @D, @E, @F, @id_A, @id_B, @id_C, @id_D, @id_E, @id_F)
END
GO

-- CREATE DATE: 2023-02-16
-- 处理第三方题库(从网上爬取)小鹅通
-- USE CASE: exec [dealQuestionOther] 
-- select * from [questionOther]
-- select distinct kindID,questionName,answer,A,B,C,D,E,F from [questionOther]
-- insert questionOther1 select * from [questionOther]
ALTER PROCEDURE [dbo].[dealQuestionOther]
AS
BEGIN
	update [questionOther] set kindID=3 where kindID=4
	update [questionOther] set answer=iif(answer=1,'A','B'),A='正确',B='错误' where kindID=3
	update [questionOther] set answer=(case when answer=id_A then 'A' when answer=id_B then 'B' when answer=id_C then 'C' when answer=id_D then 'D' when answer=id_E then 'E' when answer=id_F then 'F' else '' end) where kindID=1
	update [questionOther] set answer=replace(replace(replace(replace(replace(replace(answer,id_A,'A'),id_B,'B'),id_C,'C'),id_D,'D'),id_E,'E'),id_F,'F') where kindID=2
	update [questionOther] set answer=replace(answer,',','') where kindID=2
	update [questionOther] set questionName=replace(replace(REPLACE(REPLACE(questionName, CHAR(13), ''), CHAR(10),''),char(9),''),' ','')
END
GO

-- CREATE DATE: 2024-07-06
-- 返回培训证明信息（安监项目，个人版）
-- USE CASE: exec [getTrainingProofInfo] 1
ALTER PROCEDURE [dbo].[getTrainingProofInfo]
	@enterID int
AS
BEGIN
	declare @start varchar(50), @end varchar(50)
	if exists(select 1 from applyInfo where enterID=@enterID)
	begin
		select @start=convert(varchar(20),min(theDate),23), @end=convert(varchar(20),max(theDate),23) from classSchedule where mark='A' and classID = (select max(refID) from applyInfo where enterID=@enterID)
		SELECT @start as dateStart, @end as dateEnd, name, username, certName, reexamine, a.host, b.hostName FROM v_applyInfo a, hostInfo b where a.host=b.hostNo and a.enterID=@enterID
	end
END
GO

-- CREATE DATE: 2024-09-24
-- 返回培训证明信息（安监项目，机构版）
-- USE CASE: exec [getUnitTrainingProofInfo] 1
ALTER PROCEDURE [dbo].[getUnitTrainingProofInfo]
	@classID int
AS
BEGIN
	declare @start varchar(50), @end varchar(50)
	if exists(select 1 from generateApplyInfo where ID=@classID)
	begin
		select @start=convert(varchar(20),min(theDate),23), @end=convert(varchar(20),max(theDate),23) from classSchedule where mark='A' and classID = @classID
		SELECT applyID, @start as dateStart, @end as dateEnd, courseName as certName, reexamine, a.host, isnull(b.hostName,'') as hostName FROM v_generateApplyInfo a left outer join hostInfo b on a.host=b.hostNo where a.ID=@classID
	end
END
GO

-- CREATE DATE: 2024-07-06
-- 查找学员在本班的线下课程考勤情况
-- USE CASE: exec [getEnterCheckinListOnClass] 1
ALTER PROCEDURE [dbo].[getEnterCheckinListOnClass]
	@enterID int, @classID int
AS
BEGIN
	declare @checkinMark int
	if @classID=0
		select @classID=max(refID) from applyInfo where enterID=@enterID
	select @checkinMark=checkinMark from generateApplyInfo where ID=@classID

	if @classID>0
		select a.theDate + iif(@checkinMark=1,a.typeName,'') as theDate,a.item,a.teacherName,a.kindName,a.classID, b.file1, b.file2 from 
		(select * from v_classSchedule where mark='A' and online=0 and (typeID=0 or typeID=@checkinMark) and classID = @classID) a 
		left outer join 
		(select d.file1,d.file2,c.refID from checkinInfo c, faceDetectInfo d where c.enterID=d.refID and c.refID=d.keyID and c.kindID=1 and d.kindID=2 and c.enterID=@enterID) b
		on a.ID=b.refID
	else
		select a.theDate as theDate,a.item,a.teacherName,a.kindName,a.classID, b.file1, b.file2 from 
		(select * from v_classSchedule where mark='A' and online=0) a 
		inner join 
		(select d.file1,d.file2,c.refID from checkinInfo c, faceDetectInfo d where c.enterID=d.refID and c.refID=d.keyID and c.kindID=1 and d.kindID=2 and c.enterID=@enterID) b
		on a.ID=b.refID
END
GO

-- CREATE DATE: 2024-07-06
-- 查找学员在本班课表之外的线下课程考勤情况（只统计到本班开班之前180天-本班课程结束时间段）
-- USE CASE: exec [getEnterCheckinListOutClass] 1
ALTER PROCEDURE [dbo].[getEnterCheckinListOutClass]
	@enterID int, @classID int
AS
BEGIN
	declare @start varchar(50),@end varchar(50),@username varchar(50),@courseID varchar(50)
	if @classID=0
		select @classID=max(refID) from applyInfo where enterID=@enterID
	select @username=username,@courseID=courseID from v_applyInfo where enterID=@enterID
	select @start=convert(varchar(20),dateadd(d,-180,min(theDate)),23), @end=convert(varchar(20),max(theDate),23) from classSchedule where mark='A' and classID = @classID

	select a.theDate,a.item,a.teacherName,a.kindName,a.classID, b.file1, b.file2 from 
	(select * from v_classSchedule where mark='A' and classID <>@classID and theDate between @start and @end) a 
	inner join 
	(select d.file1,d.file2,c.refID from checkinInfo c, faceDetectInfo d where c.enterID=d.refID and c.refID=d.keyID and c.kindID=1 and d.kindID=2 and c.enterID in(select ID from studentCourseList where username=@username and courseID=@courseID)) b
	on a.ID=b.refID
END
GO

-- CREATE DATE: 2024-07-06
-- 查找学员在本班课表之外的线下课程考勤次数（只统计到本班开班之前180天-本班课程结束时间段）
-- USE CASE: select [dbo].[getEnterCheckinOutClassQty] 1
ALTER FUNCTION [dbo].[getEnterCheckinOutClassQty]
	(@enterID int,@classID varchar(50))
RETURNS int
AS
BEGIN
	declare @start varchar(50),@end varchar(50),@username varchar(50),@courseID varchar(50),@re int
	select @username=username,@courseID=courseID from v_applyInfo where enterID=@enterID
	select @start=convert(varchar(20),dateadd(d,-180,min(theDate)),23), @end=convert(varchar(20),max(theDate),23) from classSchedule where mark='A' and classID = (select max(refID) as refID from applyInfo where enterID=@enterID)

	select @re=count(*) from 
	(select ID from v_classSchedule where mark='A' and online=0 and classID not in (select refID from applyInfo where enterID=@enterID and refID=@classID) and theDate between @start and @end) a 
	inner join 
	(select c.refID from checkinInfo c, faceDetectInfo d where c.enterID=d.refID and c.refID=d.keyID and c.kindID=1 and d.kindID=2 and c.enterID in(select ID from studentCourseList where username=@username and courseID=@courseID)) b
	on a.ID=b.refID
	return isnull(@re,0)
END
GO

-- CREATE DATE: 2023-02-16
-- 记录支付接口返回数据
-- USE CASE: exec [setAutoPayReturn] 1
ALTER PROCEDURE [dbo].[setAutoPayReturn]
	@kind varchar(50), @memo nvarchar(4000), @memo1 nvarchar(4000)
AS
BEGIN
	insert into autoPayReturn(kind, memo, memo1) values(@kind, @memo, @memo1)
END
GO


--CREATE Date:2023-07-30
--根据给定日期，统计不同销售的当日、当月报名人数（checkDate为准）、收费情况（扣除退费，应收款以到账日期dateReceive为准）。
--如果@endDate=''，统计到月底，否则到指定日期
--sales如果有值，只能看自己的数据
ALTER PROCEDURE [dbo].[getSalesRpt]
	@startDate varchar(50), @endDate varchar(50), @host varchar(50), @sales varchar(50)
AS
BEGIN
	declare @d1 varchar(50), @d2 varchar(50)
	select @d1 = left(@startDate,7) + '-01', @d2 = iif(@endDate='',EOMONTH(@startDate),@endDate)
	create table #tbl (sales varchar(50),salesName nvarchar(50), p1 int, p2 int, p3 int, p4 int)
	create table #tbl0 (sales varchar(50), p1 int, p2 int)
	--当月销售额
	insert into #tbl(sales,p2) select fromID,sum(amount) from (select fromID, amount from v_studentCourseList where datePay>=@d1 and datePay<=@d2 and pay_type<>3 and host in('znxf','spc','shm')
		union all select fromID, amount from v_studentCourseList where dateReceive>=@d1 and dateReceive<=@d2 and pay_type=3 and host in('znxf','spc','shm')
		union all select fromID, -refund_amount from v_studentCourseList where dateRefund>=@d1 and dateRefund<=@d2 and host in('znxf','spc','shm')) a group by fromID
	--当天销售额
	insert into #tbl0(sales,p1) select fromID,sum(amount) from (select fromID, amount from v_studentCourseList where datePay=@startDate and pay_type<>3 and host in('znxf','spc','shm')
		union all select fromID, amount from v_studentCourseList where dateReceive=@startDate and pay_type=3 and host in('znxf','spc','shm')
		union all select fromID, -refund_amount from v_studentCourseList where dateRefund=@startDate and host in('znxf','spc','shm')) a group by fromID
	update #tbl set p1=b.p1 from #tbl a, #tbl0 b where a.sales=b.sales

	--当月报名人数
	delete from #tbl0
	insert into #tbl0(sales,p1) select fromID,count(*) from v_studentCourseList where checkDate>=@d1 and checkDate<=@d2 and host in('znxf','spc','shm') group by fromID
	update #tbl set p4=b.p1 from #tbl a, #tbl0 b where a.sales=b.sales
	--当天报名人数
	delete from #tbl0
	insert into #tbl0(sales,p1) select fromID,count(*) from v_studentCourseList where checkDate=@startDate and host in('znxf','spc','shm') group by fromID
	update #tbl set p3=b.p1 from #tbl a, #tbl0 b where a.sales=b.sales

	update #tbl set salesName=b.realName from #tbl a, userInfo b where a.sales=b.username
	update #tbl set salesName='未知' where sales='' or sales is null
	if @sales>''
		delete from #tbl where (sales<>@sales and sales<>iif(@sales='jiangwei.','amra.','')) or sales is null or sales=''
	insert into #tbl select '*',@startDate + iif(@endDate>'','/'+@endDate,'') + '合计',sum(p1),sum(p2),sum(p3),sum(p4) from #tbl
	select salesName as 销售, isnull(p1,0) as 当日金额, isnull(p2,0) as 当月金额, isnull(p3,0) as 当日人数, isnull(p4,0) as 当月人数, sales from #tbl order by 销售 desc
END
GO

--CREATE Date:2023-07-30
--根据给定日期、销售，列出销售明细
--如果@endDate=''，统计到月底，否则到指定日期
--kind: 0 当天金额  1 范围内金额  2 当天人数  3 范围内人数
ALTER PROCEDURE [dbo].[getSalesRptDetail]
	@startDate varchar(50), @endDate varchar(50), @host varchar(50), @sales varchar(50), @kind int
AS
BEGIN
	declare @d1 varchar(50), @d2 varchar(50)
	select @d1 = left(@startDate,7) + '-01', @d2 = iif(@endDate='',EOMONTH(@startDate),@endDate)
	if @kind=0
		select ID,autoPay,username as '身份证', name as '姓名', amount as '金额', datePay as '日期', pay_typeName as '类型', courseName, iif(unit>'',unit,hostName+dept1Name) + ':' + pay_memo as pay_memo from v_studentCourseList where datePay=@startDate and pay_type<>3 and host in('znxf','spc','shm') and fromID=@sales
		union all select ID,autoPay,username, name, amount, dateReceive, pay_typeName, courseName, iif(unit>'',unit,hostName+dept1Name) + ':' + pay_memo as pay_memo from v_studentCourseList where dateReceive=@startDate and pay_type=3 and host in('znxf','spc','shm') and fromID=@sales
		union all select ID,0,username, name, -refund_amount, dateRefund, '退款', courseName, refund_memo from v_studentCourseList where dateRefund=@startDate and host in('znxf','spc','shm') and fromID=@sales and refund_amount>0
	if @kind=1
		select ID,autoPay,username as '身份证', name as '姓名', amount as '金额', datePay as '日期', pay_typeName as '类型', courseName, iif(unit>'',unit,hostName+dept1Name) + ':' + pay_memo as pay_memo from v_studentCourseList where datePay>=@d1 and datePay<=@d2 and pay_type<>3 and host in('znxf','spc','shm') and fromID=@sales
		union all select ID,autoPay,username, name, amount, dateReceive, pay_typeName, courseName, iif(unit>'',unit,hostName+dept1Name) + ':' + pay_memo as pay_memo from v_studentCourseList where dateReceive>=@d1 and dateReceive<=@d2 and pay_type=3 and host in('znxf','spc','shm') and fromID=@sales
		union all select ID,0,username, name, -refund_amount, dateRefund, '退款', courseName, refund_memo from v_studentCourseList where dateRefund>=@d1 and dateRefund<=@d2 and host in('znxf','spc','shm') and fromID=@sales and refund_amount>0
	if @kind=2
		select ID,autoPay,username as '身份证', name as '姓名', amount as '金额', datePay as '日期', pay_typeName as '类型', courseName, iif(unit>'',unit,hostName+dept1Name) + ':' + pay_memo as pay_memo from v_studentCourseList where checkDate=@startDate and host in('znxf','spc','shm') and fromID=@sales
	if @kind=3
		select ID,autoPay,username as '身份证', name as '姓名', amount as '金额', datePay as '日期', pay_typeName as '类型', courseName, iif(unit>'',unit,hostName+dept1Name) + ':' + pay_memo as pay_memo from v_studentCourseList where checkDate>=@d1 and checkDate<=@d2 and host in('znxf','spc','shm') and fromID=@sales
END
GO

--CREATE Date:2023-07-30  last edit:2025-08-08
--根据给定日期范围，统计收费情况，不包括合作单位
--mark: D 日报  M 月报
ALTER PROCEDURE [dbo].[getIncomeRpt]
	@startDate varchar(50), @endDate varchar(50), @courseID varchar(50), @sales varchar(50), @mark varchar(50), @host varchar(50)
AS
BEGIN
	declare @sql nvarchar(4000), @where varchar(500), @where1 varchar(500)
	create table #tbl (datePay varchar(50), p1 int, p2 int, p3 int, p5 int, p6 int, p7 int, p int)
	-- p7退款 p付款小计
	select @where = ''
	if @startDate > ''
		select @where='datePay>=''' + @startDate + ''''
	if @endDate > ''
		select @where=@where + ' and datePay<=''' + @endDate + ''''
	if @courseID > ''
		select @where=@where + ' and courseID=''' + @courseID + ''''
	if @sales > ''
		select @where=@where + ' and fromID=''' + @sales + ''''
	if @where > ''
		select @where = @where -- + ' and host in(''znxf'',''spc'',''shm'')'

	select @sql=',sum(iif(pay_type=1,amount,0)) as p1,sum(iif(pay_type=2,amount,0)) as p2,sum(iif(pay_type=3,amount,0)) as p3,sum(iif(pay_type=3 and noReceive=1,amount,0)) as p5,sum(iif(pay_type=9,amount,0)) as p6, 0 as p7 from v_studentCourseList where ' + @where + ' group by '
	if @mark='D'
		select @sql = 'select datePay' + @sql + 'datePay'
	if @mark='M'
		select @sql = 'select left(datePay,7) as datePay' + @sql + 'left(datePay,7)'

	select @where1 = ''
	if @startDate > ''
		select @where1='dateRefund>=''' + @startDate + ''''
	if @endDate > ''
		select @where1=@where1 + ' and dateRefund<=''' + @endDate + ''''
	if @courseID > ''
		select @where1=@where1 + ' and courseID=''' + @courseID + ''''
	if @sales > ''
		select @where1=@where1 + ' and fromID=''' + @sales + ''''
	if @where1 > ''
		select @where1 = @where1 -- + ' and host in(''znxf'',''spc'',''shm'')'
	if @mark='D'
		select @sql= 'insert into #tbl select datePay, sum(isnull(p1,0)), sum(isnull(p2,0)), sum(isnull(p3,0)), sum(isnull(p5,0)), sum(isnull(p6,0)), sum(isnull(p7,0)), 0 from (' + @sql + ' union all select dateRefund,0,0,0,0,0,sum(refund_amount) from v_studentCourseList where ' + @where1 + ' group by dateRefund) a group by datePay'
	if @mark='M'
		select @sql= 'insert into #tbl select datePay as datePay, sum(isnull(p1,0)), sum(isnull(p2,0)), sum(isnull(p3,0)), sum(isnull(p5,0)), sum(isnull(p6,0)), sum(isnull(p7,0)), 0 from (' + @sql + ' union all select left(dateRefund,7),0,0,0,0,0,sum(refund_amount) from v_studentCourseList where ' + @where1 + ' group by left(dateRefund,7)) a group by datePay'

	EXECUTE (@sql)

	update #tbl set p = p1+p2+p3+p6
	insert into #tbl select '合计',sum(p1),sum(p2),sum(p3),sum(p5),sum(p6),sum(p7),sum(p) from #tbl
	select datePay as 日期, p1 as 支付宝, p2 as 微信, p3 as 转账, p5 as 其中未到账, p6 as 其他, p as 收款小计, p7 as 退款, p-p7 as 合计 from #tbl where datePay>'' order by datePay	-- pp 合计
END
GO


--CREATE Date:2023-07-30  last edit:2025-08-08
--根据给定日期(日/月)，统计收费情况明细
--mark: D 日报  M 月报
--key: 1-7: 支付宝收款, 微信收款, 银行转账, 未到账, 其他, 收款小计, 退款
ALTER PROCEDURE [dbo].[getIncomeRptDetail]
	@thisDate varchar(50), @startDate varchar(50), @endDate varchar(50), @courseID varchar(50), @sales varchar(50), @mark varchar(50), @key int
AS
BEGIN
	declare @sql nvarchar(4000), @where varchar(500), @noreceive int
	select @noreceive=iif(@key=4,1,0)
	select @key=(case when @key=4 then 3 when @key=5 then 9 else @key end)

	if @key<>7
	begin
		select @where = ''
		if @thisDate > ''
			if @mark='D'
				select @where='datePay=''' + @thisDate + ''''
			if @mark='M'
				select @where='left(datePay,7)=''' + @thisDate + ''''
		if @startDate > ''
			select @where=@where + ' and datePay>=''' + @startDate + ''''
		if @endDate > ''
			select @where=@where + ' and datePay<=''' + @endDate + ''''
		if @courseID > ''
			select @where=@where + ' and courseID=''' + @courseID + ''''
		if @sales > ''
			select @where=@where + ' and fromID=''' + @sales + ''''
		if @where > ''
			select @where = @where -- + ' and host in(''znxf'',''spc'',''shm'')'
		if @key<>6	--有支付方式
			select @where=@where + ' and pay_type=' + cast(@key as varchar) + iif(@noreceive=0,'',' and noReceive=1')

		select @sql='select username, name, amount, datePay, pay_typeName, shortName as courseName, iif(unit>'''',unit,hostName+dept1Name) + '':'' + pay_memo as pay_memo from v_studentCourseList where ' + @where
	end
	else
	begin
		if @thisDate > ''
			if @mark='D'
				select @where='dateRefund=''' + @thisDate + ''''
			if @mark='M'
				select @where='left(dateRefund,7)=''' + @thisDate + ''''
		if @startDate > ''
			select @where=@where + ' and dateRefund>=''' + @startDate + ''''
		if @endDate > ''
			select @where=@where + ' and dateRefund<=''' + @endDate + ''''
		if @courseID > ''
			select @where=@where + ' and courseID=''' + @courseID + ''''
		if @sales > ''
			select @where=@where + ' and fromID=''' + @sales + ''''
		if @where > ''
			select @where = @where -- + ' and host in(''znxf'',''spc'',''shm'')'

		select @sql='select username, name, -refund_amount, dateRefund, ''退款'', shortName as courseName, iif(unit>'''',unit,hostName+dept1Name) + '':'' + refund_memo as refund_memo from v_studentCourseList where ' + @where + ' and refund_amount>0'
	end

	EXECUTE (@sql)
END
GO


-- =============================================
-- CREATE Date: 2022-11-24
-- Description:	批量确认应收款已到账。
-- @selList: 名单，用逗号分隔的enterID
-- Use Case:	exec [checkReceiveList] 2,'...'
-- =============================================
ALTER PROCEDURE [dbo].[checkReceiveList] 
	@selList varchar(4000), @theDate varchar(50), @registerID varchar(50)
AS
BEGIN
	--将名单导入到临时表
	create table #temp_receive_check(id varchar(50),invoice varchar(50))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_receive_check(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	update studentCourseList set noReceive=2, receiverID=@registerID,dateReceive=@theDate from studentCourseList a, #temp_receive_check b where a.ID=b.id and a.noReceive=1

	--标记团体发票相关学员已付款
	update #temp_receive_check set invoice=b.invoice from #temp_receive_check a, studentCourseList b where a.id=b.id
	update studentCourseList set pay_status=1 from studentCourseList a, #temp_receive_check b where a.invoice=b.invoice and a.id<>b.id and a.invoice>''

	declare @event varchar(50), @logMemo nvarchar(500)
	select @event='确认应收款到账', @logMemo = @theDate + ':' + @selList
	-- 写操作日志
	exec writeOpLog '', @event,'checkReceiveList',@registerID,@logMemo,@logMemo
END

GO

-- =============================================
-- CREATE Date: 2022-11-24
-- Description:	将当前报名信息中的发票移到invoiceInfo中, 清除原发票信息，并置为需开票标识。
-- mark: 0 红冲  1 重开
-- Use Case:	exec [removeInvoice] 2,'...'
-- =============================================
ALTER PROCEDURE [dbo].[removeInvoice] 
	@enterID int, @mark int, @registerID varchar(50)
AS
BEGIN
	declare @event varchar(50), @logMemo nvarchar(500)
	select @event='移除发票准备' + iif(@mark=0,'红冲','重开'), @logMemo = invoice from studentCourseList where ID=@enterID
	insert into invoiceInfo(enterID, invCode, invDate, payType, payStatus, amount, item, autoPay, autoInvoice, cancel, cancelDate, memo) select @enterID, invoice,dateInvoice,pay_type,pay_status,invoice_amount,title, autoPay, autoInvoice, iif(@mark=0,1,0), iif(@mark=0,getDate(),null),file5 from studentCourseList where ID=@enterID
	update studentCourseList set title=isnull(title,'') + iif(@mark=0,' 红冲-原发票号：' + isnull(invoice,''),''), invoice_amount=iif(@mark=0,-invoice_amount,invoice_amount), invoice=null, file5=null, dateInvoice=null, dateInvoicePick=null, needInvoice=1, autoInvoice=0 where ID=@enterID
	-- 写操作日志
	exec writeOpLog '', @event,'removeInvoice',@registerID,@logMemo,@enterID
END

GO

--CREATE Date:2020-05-11
--根据给定的学员enterID，查找其所有发票文件，合并输出（以|为间隔）。
ALTER FUNCTION [dbo].[getCourseInvoice](@enterID int)
RETURNS varchar(4000)
AS
BEGIN
	declare @re varchar(4000), @p int, @item varchar(500)
	select @re = isnull(file5,'') from studentCourseList where ID=@enterID
	declare rc cursor for select isnull(memo,'') item from invoiceInfo where enterID=@enterID
	open rc
	fetch next from rc into @item
	While @@fetch_status=0 
	Begin 
		select @re = @re + '**' + @item
		fetch next from rc into @item
	End
	Close rc 
	Deallocate rc
	return isnull(@re,'')
END

GO

--CREATE Date:2023-07-30
--根据给定日期，列出收费-发票明细
--@startDate 收费日期  @startDate1 开票日期  @receivalbe: 应收款
ALTER PROCEDURE [dbo].[getPayInvoiceRpt]
	@startDate varchar(50), @endDate varchar(50), @startDate1 varchar(50), @endDate1 varchar(50), @host varchar(50), @autoPay int, @autoInvoice int, @receivable int, @received int
AS
BEGIN
	declare @sql nvarchar(max), @sql0 nvarchar(max), @where varchar(500), @m int
	select @endDate = iif(@endDate='',convert(varchar(20),getDate(),23),@endDate), @where = '', @m = 0
	select @endDate1 = iif(@endDate1='',convert(varchar(20),getDate(),23),@endDate1)
	if @autoPay= 1
		select @where = ' and autoPay=1'
	if @autoInvoice= 1
		select @where = @where + ' and autoInvoice=1'
	select @where = @where -- + ' and (host in(''znxf'',''spc'',''shm'') or invoice>'''')'

	select @sql0='select ID,autoPay,autoInvoice,'''' as outorderno,username, name, amount, datePay, pay_typeName, shortName,noReceive,invoice,dateInvoice, title, pay_memo,[dbo].[getCourseInvoice](ID) as invoicePDF from v_studentCourseList where '
	if @receivable=0 and @startDate>''
	begin
		select @sql = @sql0 + 'datePay>=''' + @startDate + ''' and datePay<=''' + @endDate + ''' and amount>0' + @where
		select @sql=@sql+'union all select ID,0,0,'''',username, name, -refund_amount, dateRefund, ''退款'', shortName,noReceive,invoice,dateInvoice, title, refund_memo,[dbo].[getCourseInvoice](ID) as invoicePDF from v_studentCourseList where dateRefund>=''' + @startDate + ''' and dateRefund<=''' + @endDate + ''' and refund_amount>0'
	end
	if @receivable=0 and @startDate1>''
		select @sql = @sql0 + 'dateInvoice>=''' + @startDate1 + ''' and dateInvoice<=''' + @endDate1 + '''' + @where
	if @receivable=1
		select @sql = @sql0 + 'noReceive=1 and amount>0' + @where
	if @received=1 and @startDate>''
		select @sql = @sql0 + 'noReceive=2 and amount>0 and dateReceive>=''' + @startDate + ''' and dateReceive<=''' + @endDate + ''' and amount>0' + @where
	if @received=1 and @startDate1>''
		select @sql = @sql0 + 'noReceive=2 and amount>0 and dateInvoice>=''' + @startDate1 + ''' and dateInvoice<=''' + @endDate1 + ''' and amount>0' + @where

	SET @sql = N'
	declare @tb table(ID int,autoPay int,autoInvoice int,[客户订单号] varchar(50),username varchar(50), name nvarchar(50), [金额] int, datePay varchar(50), pay_typeName nvarchar(50), shortName nvarchar(50),noReceive int,[发票号码] varchar(50),dateInvoice varchar(50), title nvarchar(200), pay_memo nvarchar(500),invoicePDF varchar(2000))
	insert into @tb
	' + @sql + 
	' update @tb set [客户订单号]=b.outOrderNo from @tb a, autoPayInfo b where a.ID=b.enterID and b.kind=0' + 
	' select * from @tb'
	EXECUTE (@sql)
END
GO

-- CREATE DATE: 2024-07-06
-- 查找学员本次报名的考试日期，如果有多次，选最后一次
-- 根据类型，从applyInfo 或 passcardInfo中提取
-- USE CASE: select [dbo].[getEnterExamDate](1)
CREATE FUNCTION [dbo].[getEnterExamDate]
	(@enterID int)
RETURNS varchar(50)
AS
BEGIN
	declare @re varchar(50),@agencyID int
	select @agencyID=c.agencyID from studentCourseList a, courseInfo b, [dbo].[certificateInfo] c where a.courseID=b.courseID and b.certID=c.certID and a.ID=@enterID
	if @agencyID=4		--本校发证
		select @re=isnull(convert(varchar(20),max(startDate),23),'') from v_passcardInfo where enterID=@enterID
	else
		select @re=isnull(convert(varchar(20),max(examDate),23),'') from applyInfo where enterID=@enterID

	return isnull(@re,'')
END
GO

-- CREATE DATE: 2023-10-13
-- 返回学员的发票列表
-- USE CASE: exec [getStudentInvoiceList] 1
CREATE PROCEDURE [dbo].[getStudentInvoiceList]
	@username varchar(50)
AS
BEGIN
	select file5 as [filename], isnull(convert(varchar(20),dateInvoice,23),'') as dateInvoice,amount from studentCourseList where username=@username and file5>'' order by ID desc
END
GO

-- CREATE DATE: 2023-10-13
-- 为学员重置模拟试卷
-- USE CASE: exec [rebuildStudentExam] 1
CREATE PROCEDURE [dbo].[rebuildStudentExam]
	@enterID int
AS
BEGIN
	declare @username varchar(50), @certID varchar(50), @courseID varchar(50)
	select @username=username,@courseID=a.courseID,@certID=b.certID from studentCourseList a, courseInfo b where a.courseID=b.courseID and a.ID=@enterID
	delete from studentExamList where refID=@enterID
	insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,kind,mark) select @username,examID,@enterID,minutes,minutes*60,scoreTotal,scorePass,kindID,0,0 from examInfo where (courseID=@courseID or (courseID is null and certID=@certID)) and status=0
END
GO

-- =============================================
-- CREATE Date: 2023-06-01
-- Description:	根据名单提取报名数据
-- @selList: 名单，用逗号分隔的kindID 0 applyID 1 enterID 2 username  @refID:classInfo.ID
-- Use Case:	exec [getStudentListByList] '...'
-- =============================================
ALTER PROCEDURE [dbo].[getStudentListByList] 
	@selList varchar(4000), @kindID int, @refID int
AS
BEGIN
	--将名单导入到临时表
	create table #temp(id varchar(50))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	if @kindID=0
		select a.ID,name,username,certName,a.enterID,a.certID from v_applyInfo a, #temp b where a.ID=b.id order by a.ID
	if @kindID=1
		select a.ID,name,username,certName,a.ID as enterID,a.certID from v_studentCourseList a, #temp b where a.ID=b.id order by a.ID
	if @kindID=2
		select a.ID,name,username,certName,a.ID as enterID,a.certID from v_studentCourseList a, #temp b, classInfo c where a.username=b.id and a.classID=c.classID and c.ID=@refID order by a.ID
END
GO

-- CREATE DATE: 2023-10-13
-- 消防成绩查询登记
-- USE CASE: exec [setFireScoreCheck] 1
ALTER PROCEDURE [dbo].[setFireScoreCheck]
	@enterID int, @score1 varchar(50), @score2 varchar(50), @examDate varchar(50), @registerID varchar(50)
AS
BEGIN
	if @enterID>0
	begin
		declare @status int, @refID int
		select @refID=refID from studentCourseList where ID=@enterID
		if @score1='' and @score2=''
			update studentCertList set result=0,score=null, score1=null, score2=null, examDate=null where ID=@refID
		else
		begin
			select @status=iif(@score1='缺考' and @score2='缺考',3,2)
			if @score1='缺考'
				select @score1 = 0, @score2=0
			if @score2='缺考'
				select @score2=0
			select @score1 = dbo.whenull(@score1,0), @score2=dbo.whenull(@score2,0), @examDate=dbo.whenull(@examDate,null)
			select @status=(case when @score1>=60.0 and @score2>=60.0 then 1 else @status end)
			update studentCertList set result=@status,status=(case when @status>0 then 2 else status end),score=@score1, score1=@score1, score2=@score2, examDate=@examDate,closeDate=getDate() from studentCertList where ID=@refID
			update studentCourseList set status=2,endDate=getDate(),closeDate=getDate() where ID=@enterID
		end
	end
END
GO

-- CREATE DATE: 2023-10-13
-- 复训日期查询登记
-- USE CASE: exec [setDiplomaCheckDate] 1
ALTER PROCEDURE [dbo].[setDiplomaCheckDate]
	@enterID int, @date varchar(50), @registerID varchar(50)
AS
BEGIN
	if @enterID>0
	begin
		update studentCourseList set currDiplomaDate=[dbo].[whenull](@date,null), currDiplomaID=registerID + convert(varchar(20),getDate(),23) where ID=@enterID
	end
END
GO

--判断某个模拟考试是否达到条件
ALTER FUNCTION [dbo].[getMockAllow]
(	
	@enterID int
)
RETURNS varchar(100) 
AS
BEGIN
	declare @re varchar(100), @agencyID int, @completion int
	select @agencyID=b.agencyID, @completion=a.completion from v_studentCourseList a, certificateInfo b where a.certID=b.certID and a.ID=@enterID
	if @agencyID=1 and @completion<60
	begin
		select @re='在线课程完成60%以上，再做模拟练习。'
	end
	--return isnull(@re,'')
	return ''
END
GO

-- CREATE DATE: 2023-10-13
-- 添加/取消收藏试题
-- mark: 0 添加 1 取消
-- USE CASE: exec [setFavoriteQuestion] 1
CREATE PROCEDURE [dbo].[setFavoriteQuestion]
	@enterID int, @questionID varchar(50), @mark int
AS
BEGIN
	if @mark=0 and not exists(select 1 from [dbo].[studentQuestionMark] where enterID=@enterID and questionID=@questionID)
		insert into [dbo].[studentQuestionMark](enterID, questionID) values(@enterID, @questionID)
	if @mark=1
		delete from [dbo].[studentQuestionMark] where enterID=@enterID and questionID=@questionID
	select 0 as status, iif(@mark=0,'已添加到收藏夹','已取消收藏') as msg
END
GO

-- CREATE DATE: 2024-9-26
-- 添加机构培训证明
-- USE CASE: exec [updateTrainingProof] 1
CREATE PROCEDURE [dbo].[updateTrainingProof]
	@classID int, @filename varchar(200)
AS
BEGIN
	update generateApplyInfo set filename=@filename where ID=@classID
END
GO

-- CREATE DATE: 2024-09-28
-- 返回报名表所需数据
-- USE CASE: exec [getEntryformInfo] 1
ALTER PROCEDURE [dbo].[getEntryformInfo]
	@enterID int, @classID int, @host varchar(50)
AS
BEGIN
	declare @hostName nvarchar(100), @fname varchar(200), @startDate varchar(50)
	if @classID=0
		select @classID=max(refID) from applyInfo where enterID=@enterID
	select @host=host, @fname='' from studentCourseList where ID=@enterID
	select @hostName=hostName from hostInfo where hostNo=@host
	select @fname=filename, @startDate=isnull(convert(varchar(20),startDate,23),'') from generateApplyInfo where ID=@classID
	select a.username,b.name,a.SNo,signatureType,isnull(a.signature,'') as signature,isnull(convert(varchar(20),a.signatureDate,23),'') as signatureDate,@startDate as startDate,c.reexamine,a.express,c.certID,c.courseName1 as courseName,a.price,c.price as priceStandard,@host as host,'上海智能消防学校' as hostName,b.sexName,birthday,b.mobile,b.age,b.job,b.educationName,b.address,b.IDaddress,b.ethnicity,b.IDdateStart,b.IDdateEnd,b.IDD_long,b.unit,b.photo_filename,b.IDa_filename,b.IDb_filename,b.edu_filename,@fname as proof_filename 
		from studentCourseList a, v_studentInfo b, v_courseInfo c where a.username=b.username and a.courseID=c.courseID and a.ID=@enterID
END
GO

-- CREATE DATE: 2024-09-28
-- 返回班级在线学习统计数据
-- mark: A apply, B class
-- USE CASE: exec [getClassStudyOnline] 1
ALTER PROCEDURE [dbo].[getClassStudyOnline]
	@classID varchar(50), @mark varchar(50), @theDate varchar(50)
AS
BEGIN
	declare @hostName nvarchar(100), @fname varchar(200)
	select @theDate=dbo.whenull(@theDate,convert(varchar(20),getDate(),23))
	create table #temp(ID int,enterID int,username varchar(50),name nvarchar(50),mobile varchar(50),completion decimal(10,2) default(0),completion_hours decimal(10,2) default(0),result int,score int default(0),score2 int default(0),pOffline int default(0),
		examTimes int default(0),goodTimes int default(0),goodRate decimal(10,2) default(0),examTimes1 int default(0),goodTimes1 int default(0),goodRate1 decimal(10,2) default(0)
		,examTimesLast int default(0),goodTimesLast int default(0),goodRateLast decimal(10,2) default(0),avgLast int default(0),predictedGrade int default(0),examTimes1Last int default(0),goodTimes1Last int default(0),goodRate1Last decimal(10,2) default(0),todayExamTimes int default(0),todayGoodTimes int default(0),bestScore int default(0),todayBestScore int default(0))
	
	--在线课程完成率
	if @mark='A'
		insert into #temp(ID,enterID,username,name,mobile,completion,completion_hours) select max(a.ID),b.ID,d.username,d.name,max(d.mobile),avg(c.completion),sum(c.completion*c.hours)/100.00 from applyInfo a, studentCourseList b, studentLessonList c, studentInfo d where a.enterID=b.ID and b.ID=c.refID and b.username=d.username and a.refID=@classID group by b.ID,d.username,d.name
	else
		insert into #temp(ID,enterID,username,name,mobile,completion,completion_hours) select cast(right(max(b.SNo),3) as int),b.ID,d.username,d.name,max(d.mobile),avg(c.completion),sum(c.completion*c.hours)/100.00 from studentCourseList b, studentLessonList c, studentInfo d where b.ID=c.refID and b.username=d.username and b.classID=@classID group by b.ID,d.username,d.name
	
	update #temp set examTimes=b.examTimes,goodTimes=b.goodTimes,examTimes1=b.examTimes1,goodTimes1=b.goodTimes1,bestScore=b.bestScore from #temp a, (select c.enterID,sum(iif(e.kindID=0,1,0)) as examTimes,sum(iif(d.score>=d.scorePass and e.kindID=0,1,0)) as goodTimes,sum(iif(e.kindID=1,1,0)) as examTimes1,sum(iif(d.score>=d.scorePass and e.kindID=1,1,0)) as goodTimes1, max(d.score) as bestScore from #temp c, ref_studentExamList d, examInfo e where c.enterID=d.refID and d.examID=e.examID group by c.enterID) b where a.enterID=b.enterID
	
	--当天练习次数
	update #temp set todayExamTimes=b.examTimes,todayGoodTimes=b.goodTimes,todayBestScore=b.bestScore from #temp a, (select c.enterID,count(*) as examTimes,sum(iif(d.score>=d.scorePass,1,0)) as goodTimes, max(d.score) as bestScore from #temp c, ref_studentExamList d, examInfo e where c.enterID=d.refID and d.examID=e.examID and d.backDate between @theDate and @theDate + ' 23:59:59' group by c.enterID) b where a.enterID=b.enterID
	
	--最近5次应知练习
	update #temp set examTimesLast=b.examTimes,goodTimesLast=b.goodTimes,avgLast=b.avgLast from #temp a, 
	(select enterID,count(*) as examTimes,sum(iif(score>=scorePass,1,0)) as goodTimes, avg(score) as avgLast
	FROM (
		SELECT
			c.enterID,e.kindID,d.score,d.scorePass,
			ROW_NUMBER() OVER (PARTITION BY c.enterID ORDER BY d.seq DESC) AS Rank
		FROM
			#temp c, ref_studentExamList d, examInfo e where c.enterID=d.refID and d.examID=e.examID and e.kindID=0
	) AS SubQuery
	WHERE Rank <= 5 group by enterID) b where a.enterID=b.enterID
	--最近5次应会练习
	update #temp set examTimes1Last=b.examTimes,goodTimes1Last=b.goodTimes from #temp a, 
	(select enterID,count(*) as examTimes,sum(iif(score>=scorePass,1,0)) as goodTimes 
	FROM (
		SELECT
			c.enterID,e.kindID,d.score,d.scorePass,
			ROW_NUMBER() OVER (PARTITION BY c.enterID ORDER BY d.seq DESC) AS Rank
		FROM
			#temp c, ref_studentExamList d, examInfo e where c.enterID=d.refID and d.examID=e.examID and e.kindID=1
	) AS SubQuery
	WHERE Rank <= 5 group by enterID) b where a.enterID=b.enterID

	--predictedGrade: 预估分数，以最后5次应知考试平均分为基数，适当提高一个系数。
	update #temp set predictedGrade=avgLast+(100-avgLast)/2.3,goodRate=goodTimes*100.00/iif(examTimes=0,1,examTimes), goodRate1=goodTimes1*100.00/iif(examTimes1=0,1,examTimes1), goodRateLast=goodTimesLast*100.00/iif(examTimesLast=0,1,examTimesLast), goodRate1Last=goodTimes1Last*100.00/iif(examTimes1Last=0,1,examTimes1Last), completion=iif(completion>99,100,completion) where examTimes>0
	update #temp set result=c.result,score=c.score,score2=c.score2 from #temp a, studentCourseList b, studentCertList c where a.enterID=b.ID and b.refID=c.ID
	-- 线下考勤
	update #temp set pOffline=b.p from #temp a, (select enterID,count(*) as p from classSchedule c, checkinInfo d where c.ID=d.refID and c.mark='A' and c.classID=@classID group by d.enterID) b where a.enterID=b.enterID
	update #temp set pOffline=isnull(pOffline,0)+[dbo].[getEnterCheckinOutClassQty](enterID,@classID)

	select * from #temp order by ID
END
GO

--去除发票抬头中的税号
ALTER FUNCTION getInvoiceTitle(@x nvarchar(200))
RETURNS nvarchar(200)
AS
BEGIN
	return replace(replace(replace(iif(PATINDEX('%[0-9]%',@x)=1,right(@x,len(@x)-PATINDEX('%[^ 0-9A-Za-z]%',@x)+1),left(@x,PATINDEX('%[0-9]%',@x+'1')-1)),'税号',''),'：',''),'，',''); 
END
GO

--CREATE Date:2023-07-30
--根据给定日期，列出收费、退费、开票明细
--结果中给出分类汇总数据
--mark: data/file
ALTER PROCEDURE [dbo].[getDailyRptTotal]
	@startDate varchar(50), @host varchar(50), @mark varchar(50)
AS
BEGIN
	declare @tb table(enterID int,kindID float,mark nvarchar(50) default(''),autoPay int,autoInvoice int,username varchar(50) default(''), name nvarchar(50) default(''), price int, amount int, datePay varchar(50) default(''), pay_type int, pay_typeName nvarchar(50) default(''), shortName nvarchar(50) default(''),noReceive int,invoice varchar(50) default(''),dateInvoice varchar(50) default(''), title nvarchar(200) default(''), autoPayName nvarchar(50), autoInvoiceName nvarchar(50), pay_memo nvarchar(500) default(''),invoicePDF varchar(2000) default(''))
	declare @tamount int
	--当天收费记录
	insert into @tb select ID,0,iif(invoice>'' and datePay=dateInvoice,'已开票',''),autoPay,autoInvoice,username, name, price, amount, datePay, pay_type, pay_typeName, shortName,noReceive,iif(invoice>'',invoice,iif(receipt>'','收据号：'+receipt,'')),dateInvoice, dbo.getInvoiceTitle(title), '', '',pay_memo,[dbo].[getCourseInvoice](ID) as invoicePDF from v_studentCourseList where datePay=@startDate and amount>0 and pay_status>0 -- and host in('znxf','spc','shm')
	--如果有当天开票被移除，将这张发票信息填回来（不包括红冲发票）
	--update @tb set invoice=b.invCode, dateInvoice=b.invDate from @tb a, v_invoiceInfo b where a.enterID=b.enterID and b.invDate=@startDate  -- and a.invoice='' 
	insert into @tb select ID,0,'',b.autoPay,b.autoInvoice,a.username,a.name,price, b.amount, datePay, pay_type, pay_typeName,shortName,noReceive,b.invCode,b.invDate,b.item, '', '',pay_memo,invoicePDF from @tb a, v_invoiceInfo b where a.enterID=b.enterID and b.invDate=@startDate and b.amount>0
	--开票日期如果大于当天，发票信息清除
	--update @tb set invoice='', dateInvoice='' where dateInvoice>@startDate
	--当天退款记录
	insert into @tb select ID,2,'退款',0,0,username, name, -refund_amount, -refund_amount, dateRefund, 0, '退款', shortName,noReceive,iif(invoice>'',invoice,iif(receipt>'','收据号：'+receipt,'')),dateInvoice, dbo.getInvoiceTitle(title), '', '', refund_memo,[dbo].[getCourseInvoice](ID) as invoicePDF from v_studentCourseList where dateRefund=@startDate and refund_amount>0 -- and host in('znxf','spc','shm')
	--今天付款今天红冲记录(红冲)
	insert into @tb select ID,3.1,'红冲',autoPay,autoInvoice,username, name, price, invoice_amount, datePay, pay_type, '红冲', shortName,noReceive,invoice,dateInvoice, dbo.getInvoiceTitle(title), '', '','',[dbo].[getCourseInvoice](ID) as invoicePDF from v_studentCourseList where dateInvoice=@startDate and datePay=@startDate and invoice>'' and invoice_amount<0
	--以前付款今天开票记录(预收开票)
	insert into @tb select ID,3,'预收开票',autoPay,autoInvoice,username, name, price, invoice_amount, datePay, pay_type, iif(invoice_amount<0,'红冲',pay_typeName), shortName,noReceive,invoice,dateInvoice, dbo.getInvoiceTitle(title), '', '','',[dbo].[getCourseInvoice](ID) as invoicePDF from v_studentCourseList where dateInvoice=@startDate and datePay<@startDate and invoice>'' and invoice_amount>0 -- and amount>0 and host in('znxf','spc','shm')
	--如果有之前开票被移除，那么这张发票应该是重开的
	update @tb set mark='重开发票',kindID=3.1 from @tb a, v_invoiceInfo b where a.enterID=b.enterID and b.invDate<=@startDate and a.kindID=3
	--今天开票转入历史库的记录，不包括已回填的发票
	insert into @tb select a.ID,4,'历史发票',b.autoPay,b.autoInvoice,username, name, b.amount, b.amount, a.datePay, b.payType, iif(b.amount<0,'红冲',pay_typeName), shortName,0,b.invCode,b.invDate, dbo.getInvoiceTitle(b.item), '', '','',b.memo as invoicePDF from v_studentCourseList a, v_invoiceInfo b where a.ID=b.enterID and b.invDate=@startDate and b.invCode not in(select invoice from @tb)
	--更新自动收费、自动开票
	update @tb set autoPayName=iif(autoPay=1,'线上','线下'), autoInvoiceName=iif(autoInvoice=1,'线上',iif(invoice>'','线下','')) where kindID in(0,3)
	--更新未开票标识
	update @tb set mark='未开票', kindID=1, dateInvoice='' where kindID=0 and (dateInvoice='' or dateInvoice>@startDate)
	--插入空行
	insert into @tb(enterID,kindID,invoice) select 0,1.1,''
	--插入空行
	insert into @tb(enterID,kindID,invoice) select 0,1.2,'线上未开票'
	--区分线上未开票标识
	update @tb set kindID=1.3 where kindID=1 and dateInvoice='' and autoPay=1
	--插入空行
	insert into @tb(enterID,kindID,invoice) select 0,1.6,'线下未开票'
	--区分线下未开票标识
	update @tb set kindID=1.7 where kindID=1 and dateInvoice='' and autoPay=0
	--插入空行
	insert into @tb(enterID,kindID,invoice) select 0,3.2,''
	--插入空行
	insert into @tb(enterID,kindID,invoice) select 0,3.3,'线上预收开票'
	--区分线上预收开票标识
	update @tb set kindID=3.5 where kindID=3 and autoInvoice=1
	--插入空行
	insert into @tb(enterID,kindID,invoice) select 0,3.8,'线下预收开票'
	--区分线上预收开票标识
	update @tb set kindID=3.9 where kindID=3 and autoInvoice=0 and noReceive=0 and amount>0
	--插入空行
	insert into @tb(enterID,kindID) select 0,5
	--插入合计
	insert into @tb(enterID,kindID,pay_type,amount,mark) select 0,6,0,sum(amount),'合计' from @tb
	--插入收费小计
	insert into @tb(enterID,kindID,pay_type,amount,mark) select 0,6,1,sum(amount),'收款小计' from @tb where kindID<3
	--插入收入分类小计
	insert into @tb(enterID,kindID,pay_type,amount,mark) select 0,7,pay_type,sum(amount),pay_typeName from @tb where kindID<2 group by pay_type,pay_typeName order by pay_type
	--插入退款小计
	insert into @tb(enterID,kindID,pay_type,amount,mark) select 0,7,6,sum(amount),'退款' from @tb where kindID=2
	--插入未开票小计
	insert into @tb(enterID,kindID,pay_type,amount,mark) select 0,7,7,sum(amount),'未开票' from @tb where kindID=1
	--插入预收开票小计
	insert into @tb(enterID,kindID,pay_type,amount,mark) select 0,7,8,sum(amount),'预收开票' from @tb where kindID=3
	--插入空行
	insert into @tb(enterID,kindID) select 0,8
	--插入页脚
	insert into @tb(enterID,kindID,invoice,shortName) select 1,8,'复核人：','制单人：'
	--插入线上未开票小计
	select @tamount=sum(amount) from @tb where kindID=1.3
	insert into @tb(enterID,kindID,pay_typeName,amount,invoice) select 0,1.4,'微信',isnull(@tamount,0),'线上未开票小计'
	--插入空行
	insert into @tb(enterID,kindID) select 0,1.5
	--插入线下未开票小计
	select @tamount=sum(amount) from @tb where kindID=1.7
	insert into @tb(enterID,kindID,pay_typeName,amount,invoice) select 0,1.8,'',isnull(@tamount,0),'线下未开票小计'
	--插入空行
	insert into @tb(enterID,kindID) select 0,1.9
	--插入线上未开票小计
	select @tamount=0
	select @tamount=sum(amount) from @tb where kindID=3.5
	insert into @tb(enterID,kindID,amount,invoice) select 0,3.6,isnull(@tamount,0),'线上预收开票小计'
	--插入空行
	insert into @tb(enterID,kindID) select 0,3.7
	--插入线下未开票小计
	select @tamount=0
	select @tamount=sum(amount) from @tb where kindID=3.9
	insert into @tb(enterID,kindID,amount,invoice) select 0,3.91,isnull(@tamount,0),'线下预收开票小计'
	--插入空行
	insert into @tb(enterID,kindID) select 0,3.92
	
	if @mark='data'
		select iif(kindID<5,cast(ROW_NUMBER() OVER (ORDER BY kindID,enterID) as varchar),'') as 'No',* from @tb order by kindID,enterID,pay_type
	if @mark='file'
		select iif(kindID<5,cast(ROW_NUMBER() OVER (ORDER BY kindID,enterID) as varchar),'') as 'No',enterID as '报名号',dateInvoice as '开票日期',datePay as '付款日期',name as '姓名',mark as '标识',invoice as '数电票号',title as '开票抬头',shortName as '项目',pay_typeName as '付款方式',price as '单价',iif(kindID<4,1,null) as '人数',amount as '金额',autoPayName as '付款类型',autoInvoiceName as '开票类型',pay_memo as '备注' from @tb order by kindID,enterID,pay_type
END
GO


--CREATE Date:2023-07-30
--根据给定日期，列出线上未开票/线上预收开票明细
--mark: 0 线上未开票  1 线上预收开票  3 线下未开票  4 线下预收开票
--结果中给出分类汇总数据
ALTER PROCEDURE [dbo].[getDailyRptTotalTrail]
	@startDate varchar(50), @host varchar(50), @mark int
AS
BEGIN
	declare @tb table(enterID int,kindID float,mark nvarchar(50) default(''),username varchar(50) default(''), pname nvarchar(50) default(''), price int, amount int, people int, datePay varchar(50) default(''), pay_type int, pay_typeName nvarchar(50) default(''), shortName nvarchar(50) default(''),noReceive int,invoice varchar(50) default(''),dateInvoice varchar(50) default(''), outOrderNo varchar(2000) default(''))
	--当天收费线上未开票记录
	if @mark=0
	begin
		insert into @tb select a.ID,0,'',username, name, price, a.amount, 1, datePay, a.pay_type, pay_typeName, shortName,noReceive,iif(invoice>'',invoice,iif(receipt>'','收据号：'+receipt,'')),dateInvoice, b.outOrderNo from v_studentCourseList a, autoPayInfo b where a.ID=b.enterID and b.kind=0 and a.datePay=@startDate and a.amount>0 and pay_status>0 and (invoice='' or dateInvoice>@startDate) and autoPay=1 -- and host in('znxf','spc','shm')
		--如果有当天开票被移除，将这条记录移除
		delete from @tb where enterID in(select a.enterID from @tb a, v_invoiceInfo b where a.enterID=b.enterID and b.invDate=@startDate)
	end
	--以前付款今天开票记录(预收开票)
	if @mark=1	
	begin
		insert into @tb select a.ID,0,'',username, name, price, a.invoice_amount, 1, datePay, a.pay_type, iif(a.amount<0,'红冲',pay_typeName), shortName,noReceive,invoice,dateInvoice, b.outOrderNo from v_studentCourseList a, autoPayInfo b where a.ID=b.enterID and b.kind=0 and dateInvoice=@startDate and datePay<@startDate and invoice>'' and a.amount>0 -- and a.autoInvoice=1 and host in('znxf','spc','shm')
		--如果有之前开票被移除，那么这张发票应该是重开的，移除掉
		delete from @tb where enterID in(select a.enterID from @tb a, v_invoiceInfo b where a.enterID=b.enterID and b.invDate<=@startDate)
	end
	--当天收费线下未开票记录
	if @mark=3
	begin
		insert into @tb select a.ID,0,'',username, name, price, a.amount, 1, datePay, a.pay_type, pay_typeName, shortName,noReceive,iif(invoice>'',invoice,iif(receipt>'','收据号：'+receipt,'')),dateInvoice, a.ID from v_studentCourseList a where a.datePay=@startDate and a.amount>0 and pay_status>0 and (invoice='' or dateInvoice>@startDate) and autoPay=0 -- and host in('znxf','spc','shm')
		--如果有当天开票被移除，将这条记录移除
		delete from @tb where enterID in(select a.enterID from @tb a, v_invoiceInfo b where a.enterID=b.enterID and b.invDate=@startDate)
	end
	--以前付款今天开票记录(预收开票)
	if @mark=4	
	begin
		insert into @tb select a.ID,0,'',username, name, price, a.invoice_amount, 1, datePay, a.pay_type, iif(a.amount<0,'红冲',pay_typeName), shortName,noReceive,invoice,dateInvoice, a.ID from v_studentCourseList a where dateInvoice=@startDate and datePay<@startDate and invoice>'' and a.amount>0 and autoPay=0 and noReceive=0 and a.autoInvoice=0 -- and host in('znxf','spc','shm')
		--如果有之前开票被移除，那么这张发票应该是重开的，移除掉
		delete from @tb where enterID in(select a.enterID from @tb a, v_invoiceInfo b where a.enterID=b.enterID and b.invDate<=@startDate)
	end

	--插入小计
	insert into @tb(enterID,kindID,amount,people) select 0,1,isnull(sum(amount),0),count(*) from @tb
	
	select * from @tb order by kindID,enterID
END
GO

--CREATE Date:2025-03-30
--根据给定日期，列出新开班列表。日期按照开班日期计算。
--结果中给出汇总数据
--mark: data/file
ALTER PROCEDURE [dbo].[getRptNewClass]
	@startDate varchar(50), @endDate varchar(50), @mark varchar(50)
AS
BEGIN
	select @endDate = dbo.whenull(@endDate,convert(varchar(20),getDate(),23))
	declare @tb table(classID varchar(50) default(''),kindID float,className nvarchar(100) default(''), courseID varchar(50) default(''), courseName nvarchar(100) default(''), dateStart varchar(50) default(''), classRoom nvarchar(50) default(''), qty int, teacherName nvarchar(50) default(''), adviserName nvarchar(50) default(''), memo nvarchar(500) default(''))
	insert into @tb 
		select ID,0,className, courseID, courseName, left(dateStart,10), classroom, qty, teacherName, adviserName, memo from v_classInfo where dateStart between @startDate and @endDate and pre=0 and agencyID>1
		union
		select ID,1,title, courseID, courseName, left(startDate,10), classroom, qty, teacherName, adviserName, memo from v_generateApplyInfo where startDate between @startDate and @endDate and host='znxf'
	
	insert into @tb(kindID, className, dateStart, qty) select 100,'合计',count(*),sum(qty) from @tb
	if @mark='data'
		select iif(classID>'',cast(ROW_NUMBER() OVER (ORDER BY kindID,courseID,classID) as varchar),'') as 'No',* from @tb order by kindID,courseID,classID
	if @mark='file'
		select iif(classID>'',cast(ROW_NUMBER() OVER (ORDER BY kindID,courseID,classID) as varchar),'') as 'No',classID as '班级编号',className as '班级名称',courseName as '课程名称',dateStart as '开课日期',classroom as '教室',qty as '人数',teacherName as '教师',adviserName as '班主任',memo as '备注' from @tb order by kindID,courseID,classID
END
GO

--CREATE Date:2025-03-31
--根据给定日期，列出教师/班主任工作量列表。日期按照班级结束日期计算。
--结果中给出汇总数据
--opt: 0 教师  1 班主任
--mark: data/file
ALTER PROCEDURE [dbo].[getRptWorkload]
	@startDate varchar(50), @endDate varchar(50), @opt int, @mark varchar(50)
AS
BEGIN
	select @endDate = dbo.whenull(@endDate,convert(varchar(20),getDate(),23))
	declare @tb table(classID varchar(50) default(''),kindID int,seq float,className nvarchar(100) default(''), courseID varchar(50) default(''), courseName nvarchar(100) default(''), dateEnd varchar(50) default(''), classRoom nvarchar(50) default(''), qty int default(0), workDays decimal(18,1) default(0), workload int default(0), teacherName nvarchar(50) default(''), teacher varchar(50) default(''), memo nvarchar(500) default(''))
	if @opt=0	--教师
	insert into @tb 
		select a.ID,0,0,className, courseID, courseName, b.lastDate, classroom, a.qty, b.workDays, a.qty*b.workDays, b.teacherName, b.teacher, memo from v_classInfo a, v_classTeacherWorkload b where a.ID=b.classID and b.mark='B' and b.lastDate between @startDate and @endDate and pre=0 and agencyID>1 and a.qty>0
		union
		select a.ID,1,0,title, courseID, courseName, b.lastDate, classroom, a.qty, b.workDays, a.qty*b.workDays, b.teacherName, b.teacher, memo from v_generateApplyInfo a, v_classTeacherWorkload b where a.ID=b.classID and b.mark='A' and b.lastDate between @startDate and @endDate and a.qty>0
	
	if @opt=1	--班主任
	insert into @tb 
		select ID,0,0,className, courseID, courseName, dbo.getClassLastDate(ID,'B'), classroom, qty, dbo.getClassRealDays(ID,'B'), qty*dbo.getClassRealDays(ID,'B'), adviserName, adviserID, memo from v_classInfo where dbo.getClassLastDate(ID,'B') between @startDate and @endDate and pre=0 and agencyID>1 and qty>0
		union
		select ID,1,0,title, courseID, courseName, dbo.getClassLastDate(ID,'A'), classroom, qty, dbo.getClassRealDays(ID,'A'), qty*dbo.getClassRealDays(ID,'A'), adviserName, adviserID, memo from v_generateApplyInfo where dbo.getClassLastDate(ID,'A') between @startDate and @endDate and qty>0

	--创建分组序列
	declare @tbg table(ID varchar(50), seq int)
	insert into @tbg select teacher, ROW_NUMBER() OVER (ORDER BY teacher) from @tb group by teacher
	update @tb set seq=b.seq from @tb a, @tbg b where a.teacher=b.ID
	
	--创建合计
	insert into @tb(kindID, seq, teacherName, dateEnd, qty, workDays, workload) select 100,100,'合计',isnull(count(*),0),isnull(sum(qty),0), isnull(sum(workDays),0),isnull(sum(workload),0) from @tb

	--创建分组汇总
	insert into @tb(kindID, seq, teacherName, dateEnd, qty, workDays, workload) select 1,max(b.seq)+0.5,'小计',isnull(count(*),0),isnull(sum(qty),0), isnull(sum(workDays),0),isnull(sum(workload),0) from @tb a, @tbg b where a.teacher=b.ID and a.kindID<100 group by a.teacher

	if @mark='data'
		select iif(classID>'',cast(ROW_NUMBER() OVER (ORDER BY kindID,courseID,classID) as varchar),'') as 'No',* from @tb order by seq,courseID,classID
	if @mark='file'
		select iif(classID>'',cast(ROW_NUMBER() OVER (ORDER BY kindID,courseID,classID) as varchar),'') as 'No',teacherName as '项目',classID as '班级编号',className as '班级名称',courseName as '课程名称',dateEnd as '结课日期',classroom as '教室',qty as '人数', workDays as '天数', workload as '工作量',memo as '备注' from @tb order by seq,courseID,classID
END
GO

--CREATE Date:2025-03-31
--根据给定日期，列出教师/班主任合格率列表。日期按照成绩导入日期计算。
--只计算安监项目
--结果中给出汇总数据
--opt: 0 教师  1 班主任  2 学生来源  3 课程
--mark: data/file
ALTER PROCEDURE [dbo].[getRptPassRate]
	@startDate varchar(50), @endDate varchar(50), @opt int, @mark varchar(50)
AS
BEGIN
	select @endDate = dbo.whenull(@endDate,convert(varchar(20),getDate(),23))
	declare @tb table(classID varchar(50) default(''),kindID int,seq float,className nvarchar(100) default(''), courseID varchar(50) default(''), courseName nvarchar(100) default(''), dateEnd varchar(50) default(''), qty int default(0), qtyExam int default(0), qtyPass int default(0), passRate decimal(18,2) default(0), teacherName nvarchar(50) default(''), teacher varchar(50) default(''), memo nvarchar(500) default(''))
	if @opt=0	--教师
	insert into @tb 
		select a.ID,1,0,title, courseID, courseName, a.importScoreDate, a.qty, qtyYes+qtyNo, qtyYes, 0, b.teacherName, b.teacher, memo from v_generateApplyInfo a, v_classTeacherWorkload b where a.ID=b.classID and b.mark='A' and a.importScoreDate between @startDate and @endDate and a.qty>0 and a.host='znxf'
	
	if @opt=1	--班主任
	insert into @tb 
		select ID,1,0,title, courseID, courseName, importScoreDate, qty, qtyYes+qtyNo, qtyYes, 0, adviserName, adviserID, memo from v_generateApplyInfo where importScoreDate between @startDate and @endDate and qty>0 and host='znxf'
	
	if @opt=2	--学生来源
	insert into @tb 
		select a.courseID,1,0,a.courseName, a.courseID, a.courseName, '', count(*), sum(iif(b.status=1 or b.status=2,1,0)), sum(iif(b.status=1,1,0)), 0, b.source, b.source, '' from v_generateApplyInfo a, v_applyInfo b where a.ID=b.refID and a.importScoreDate between @startDate and @endDate and a.qty>0 and a.host='znxf' group by b.source, a.courseID, a.courseName
	
	if @opt=3	--课程
	insert into @tb 
		select ID,1,0,title, courseID, courseName,importScoreDate, (qty), (qtyYes+qtyNo), (qtyYes), 0, courseName+' '+reexamineName, courseID, memo from v_generateApplyInfo where importScoreDate between @startDate and @endDate and qty>0 and host='znxf'

	--创建分组序列
	declare @tbg table(ID varchar(50), seq int)
	insert into @tbg select teacher, ROW_NUMBER() OVER (ORDER BY teacher) from @tb group by teacher
	update @tb set seq=b.seq from @tb a, @tbg b where a.teacher=b.ID
	
	--创建合计
	insert into @tb(kindID, seq, teacherName, dateEnd, qty, qtyExam, qtyPass) select 100,100,'合计',isnull(count(*),0),isnull(sum(qty),0), isnull(sum(qtyExam),0),isnull(sum(qtyPass),0) from @tb

	--创建分组汇总
	insert into @tb(kindID, seq, teacherName, dateEnd, qty, qtyExam, qtyPass) select 1,max(b.seq)+0.5,'小计',isnull(count(*),0),isnull(sum(qty),0), isnull(sum(qtyExam),0),isnull(sum(qtyPass),0) from @tb a, @tbg b where a.teacher=b.ID and a.kindID<100 group by a.teacher

	--计算通过率
	update @tb set passRate=qtyPass*100.00/iif(qtyExam>0,qtyExam,1)

	if @mark='data'
		select iif(classID>'',cast(ROW_NUMBER() OVER (ORDER BY kindID,courseID,classID) as varchar),'') as 'No',* from @tb order by seq,courseID,classID
	if @mark='file'
		select iif(classID>'',cast(ROW_NUMBER() OVER (ORDER BY kindID,courseID,classID) as varchar),'') as 'No',teacherName as '项目',classID as '班级编号',className as '班级名称',courseName as '课程名称',dateEnd as '发布日期',qty as '总人数', qtyExam as '考试人数', qtyPass as '通过人数', passRate as '通过率%',memo as '备注' from @tb order by seq,courseID,classID
END
GO

-- CREATE DATE: 2024-10-15
-- 查询班级课表
-- USE CASE: exec [getClassScheduleList] '123'
ALTER PROCEDURE [dbo].[getClassScheduleList]
	@classID int
AS
BEGIN
	select a.ID, a.theDate, a.typeName, item, iif(a.hours>4,4,iif(a.hours<1,1,a.hours)) as hours, isnull(a.teacherName,'未知') as teacherName, a.teacherSID, a.kindOnline, a.address,a.online, a.typeID 
	from v_classSchedule a, generateApplyInfo b where a.classID=b.ID and a.mark='A' and a.status=0 and b.ID=@classID and a.std=1 order by a.seq
END
GO

-- CREATE DATE: 2024-10-15
-- 标记课表上传记录
-- USE CASE: exec [setUploadSchedule] '123'
ALTER PROCEDURE [dbo].[setUploadSchedule]
	@classID varchar(50), @planID varchar(50), @registerID varchar(50)
AS
BEGIN
	update generateApplyInfo set planID=@planID,uploadScheduleDate=getDate(),uploadScheduler=@registerID where ID=@classID
END
GO

--将某个考勤移到另一个课程的班级里
--exec [changeCheckin2otherCourse] 125425,'602'
ALTER PROCEDURE [dbo].[changeCheckin2otherCourse]
	@enterID int, @classID varchar(50)
AS
BEGIN
	declare @enterID1 int, @username varchar(50),@ID int,@refID int,@schID int,@i int
	select @username=username from studentCourseList where ID=@enterID
	select @enterID1=enterID from applyInfo a, studentCourseList b where a.enterID=b.ID and a.refID=@classID and b.username=@username
	if @enterID1>0
	begin
		select @i = 0
		declare rc cursor for select id,refID from checkinInfo where enterID=@enterID
		open rc
		fetch next from rc into @ID,@refID
		While @@fetch_status=0 
		Begin 
			--获取新班级的课表
			select @i=@i+1
			select @schID=ID from (select ROW_NUMBER() OVER (ORDER BY ID) AS RowNumber, ID from classSchedule where classID=@classID and mark='A' and online=0 and typeID=0) a where a.RowNumber=@i
			--替换考勤
			update checkinInfo set enterID=@enterID1,refID=@schID where ID=@ID
			--替换刷脸
			update faceDetectInfo set refID=@enterID1,keyID=@schID where refID=@enterID and keyID=@refID
			fetch next from rc into @ID,@refID
		End
		Close rc 
		Deallocate rc
	end
END
GO

--查找某个申报班级的线下最早开课日期
CREATE FUNCTION getApplyClassFirstDate(@classID int)
RETURNS varchar(50)
AS
BEGIN
	declare @re varchar(50)
	select @re=convert(varchar(20),min(theDate),23) from classSchedule where classID=@classID and mark='A' and online=0
	return isnull(@re,'')
END
GO

--查找某个班级的线下最后上课日期
--mark: A applyInfo  B classInfo
CREATE FUNCTION getClassLastDate(@classID int, @mark varchar(50))
RETURNS varchar(50)
AS
BEGIN
	declare @re varchar(50)
	select @re=convert(varchar(20),max(theDate),23) from classSchedule where classID=@classID and mark=@mark and online=0
	return isnull(@re,'')
END
GO

--查找某个班级的线下实际上课天数
--mark: A applyInfo  B classInfo
ALTER FUNCTION getClassRealDays(@classID int, @mark varchar(50))
RETURNS decimal(18,1)
AS
BEGIN
	declare @re decimal(18,1)
	select @re=count(*)/2.0 from classSchedule where classID=@classID and mark=@mark and online=0 and point=1
	return isnull(@re,0)
END
GO

-- =============================================
-- CREATE Date: 2023-06-01
-- Description:	根据名单提取报名数据
-- @selList: 名单，用逗号分隔的kind A applyID  B username
-- Use Case:	exec [setInvoiceGroup] '...'
-- =============================================
ALTER PROCEDURE [dbo].[setInvoiceGroup] 
	@selList varchar(4000), @kind varchar(50), @classID varchar(50), @invoice varchar(50), @registerID varchar(50)
AS
BEGIN
	--将名单导入到临时表
	create table #temp(id varchar(50))
	declare @n int, @j int, @event nvarchar(50), @date varchar(50), @qty as int
	select @date=dateInvoice from studentCourseList where invoice=@invoice and amount>0
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0, @qty=0
	while @n>@j
	begin
		insert into #temp(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	if @kind='A'
		update studentCourseList set invoice=@invoice,dateInvoice=@date from studentCourseList a, #temp b, applyInfo c where b.id=c.id and a.id=c.enterID and (a.invoice='' or a.invoice is null)
	if @kind='B'
		update studentCourseList set invoice=@invoice,dateInvoice=@date from studentCourseList a, #temp b where a.username=b.id and a.classID=@classID and (a.invoice='' or a.invoice is null)
	SELECT @qty=@@ROWCOUNT

	-- 写操作日志
	select @event='设置/取消免签'
	exec writeOpLog '', @event,'setInvoiceGroup',@registerID,@selList,@invoice
	select 0 as status, '操作成功' as msg, @qty as qty
END
GO

-- CREATE DATE: 2020-05-08
-- 获取班级信息（档案用）
-- USE CASE: select * from dbo.[getNodeInfoArchive]('123','A')
-- kindID: A 申报班  B 培训班
ALTER FUNCTION [dbo].[getNodeInfoArchive]
(	
	@classID int, @kindID varchar(50)
)
RETURNS @tab TABLE (classID int, className nvarchar(500),applyID varchar(100),certName nvarchar(100),reexamineName nvarchar(50),startDate varchar(50), endDate varchar(50),qty int,qtyReturn int,qtyExam int,qtyPass int,summary nvarchar(2000),adviser nvarchar(50),attendanceRate decimal(18,2))
AS
BEGIN
	declare @startDate varchar(50),@endDate varchar(50),@qtyPass int,@qtyExam int,@adviserName nvarchar(50)

	if @kindID='B'	--培训班
	begin
		INSERT INTO @tab
		select ID,className,transaction_id,certName,reexamineName,dateStart,dateEnd,qty,qtyReturn,qtyExam,qtyPass,summary,adviserName,0 from v_classInfo where ID=@classID
	end
	if @kindID='A'		--申报班
	begin
		select @startDate=isnull(convert(varchar(20),min(theDate),23),''),@endDate=isnull(convert(varchar(20),max(theDate),23),'') from classSchedule where classID=@classID and mark=@kindID
		select @qtyPass=count(*) from applyInfo where refID=@classID and status=1
		select @qtyExam=count(*) from applyInfo where refID=@classID and (status=1 or status=2)
		select @adviserName=b.realName from generateApplyInfo a, userInfo b where a.adviserID=b.username and a.ID=@classID
		INSERT INTO @tab
		select ID,title,applyID,courseName,reexamineName,isnull(@startDate,''),isnull(@endDate,''),qty,0,@qtyExam,isnull(@qtyPass,0),summary,isnull(@adviserName,''),0 from v_generateApplyInfo where ID=@classID
	end

	update @tab set attendanceRate=dbo.getClassAttendanceRate(@classID, @kindID)

	RETURN
END
GO

-- CREATE DATE: 2020-05-08
-- 获取班级学员列表信息（档案用）
-- USE CASE: select * from dbo.[getStudentListByClassIDArchive]('123','A')
-- kindID: A 申报班  B 培训班
ALTER FUNCTION [dbo].[getStudentListByClassIDArchive]
(	
	@classID int, @kindID varchar(50)
)
RETURNS @tab TABLE (username varchar(50), name nvarchar(50),sexName nvarchar(50), age int, SNo varchar(50),mobile nvarchar(100),unit1 nvarchar(100),score varchar(50),
	diploma_startDate varchar(50),diplomaID varchar(50),score1 varchar(50),score2 varchar(50),statusName nvarchar(50),educationName nvarchar(50),hours varchar(50),
	completion1 varchar(50),hoursSpend1 varchar(50),startDate varchar(50), enterID int)
AS
BEGIN
	declare @refID varchar(50)

	if @kindID='B'	--培训班
	begin
		select @refID=classID from classInfo where ID=@classID
		INSERT INTO @tab
		select username , name ,sexName , age, SNo ,mobile ,unit ,score ,
			diploma_startDate ,diplomaID ,score1 ,score2 ,statusName ,educationName ,hours ,
			cast(isnull(completion,0) as decimal(18,2)) as completion1 ,cast(isnull(completion*hours/100,0) as decimal(18,2)) as hoursSpend1 ,startDate,ID
		 from v_studentCourseList where classID=@refID
 	end
	if @kindID='A'		--申报班
	begin
		INSERT INTO @tab
		select username , name ,sexName , age, SNo ,mobile ,unit,a.score ,
			diploma_startDate ,diplomaID ,a.score1 ,a.score2 ,statusName ,educationName ,hours ,
			cast(isnull(completion,0) as decimal(18,2)) as completion1 ,cast(isnull(completion*hours/100,0) as decimal(18,2)) as hoursSpend1 ,startDate,a.ID
		 from v_studentCourseList a, applyInfo b where a.ID=b.enterID and b.refID=@classID
	end

	RETURN
END
GO

-- CREATE DATE: 2025-01-20
--计算某个班级的出勤率
-- kindID: A 申报班  B 培训班
ALTER FUNCTION getClassAttendanceRate
(	
	@classID int, @kindID varchar(50)
)
RETURNS decimal(18,2)
AS
BEGIN
	declare @re decimal(18,2), @r1 decimal(18,2), @r int, @studentCount int, @scheduleCount int
	select @re=0, @r1=0, @r=0, @studentCount=0, @scheduleCount=0
	if @kindID='A'		--申报班
	begin
		-- 在线考勤
		select @re=avg(dbo.getCourseCompletion(a.ID)), @r=sum(dbo.getEnterCheckinOutClassQty(a.ID,@classID)), @studentCount=count(*) from dbo.studentCourseList a, applyInfo b where a.ID=b.enterID and b.refID=@classID
		-- 线下考勤
		select @r=@r+count(*) from classSchedule c, checkinInfo d where c.ID=d.refID and c.mark='A' and c.typeID=0 and c.classID=@classID
		select @scheduleCount=count(*) from classSchedule where mark='A' and typeID=0 and online=0 and classID=@classID
		select @r1 = @r*100.00/@studentCount/@scheduleCount/1.00
	end
	select @re=isnull((@re+iif(@r1>100,100,@r1))/2.00,0)
	return @re
END
GO

-- CREATE DATE: 2025-01-30
-- 根据身份证查找当前有课的消防操作员信息
-- USE CASE: exec [getFiremanInfo] '120'
ALTER PROCEDURE [dbo].[getFiremanInfo]
	@username varchar(50)
AS
BEGIN
	declare @name nvarchar(50), @enterID int, @examDate varchar(50), @refID int, @status int, @msg nvarchar(50)
	select @name='',@enterID=0,@examDate='',@status=0,@msg='',@refID=0
	select @name=name from studentInfo where username=@username
	select @enterID=ID, @refID=refID from studentCourseList where username=@username and status<2 and courseID in('L20','L20A','L21')
	
	if @enterID=0
		select @status=2, @msg='该学员没有相关课程'
	if @name=''
		select @status=1, @msg='没有找到该学员信息'

	if @refID>0
		select @examDate=isnull(convert(varchar(20),examDate,23),'') from studentCertList where ID=@refID
	select @status as status,@name as name, @enterID as enterID, @refID as refID, @examDate as examDate, @msg as msg
END
GO

-- CREATE DATE: 2025-01-30
-- 登记消防操作员考试日期
-- USE CASE: exec [setFiremanExamDate] '120'
CREATE PROCEDURE [dbo].[setFiremanExamDate]
	@refID int, @examDate varchar(50)
AS
BEGIN
	declare @status int, @msg nvarchar(50)
	select @status=0,@msg=''
	update studentCertList set examDate=@examDate where ID=@refID
	select @status as status, @msg as msg
END
GO

-- CREATE DATE: 2025-03-05
-- 登记消防操作员考试成绩
-- refID: studentCertList.ID
-- USE CASE: exec [saveExamScore] '120'
ALTER PROCEDURE [dbo].[saveExamScore]
	@refID int, @score varchar(50), @score2 varchar(50), @result int, @examDate varchar(50), @registerID varchar(50)
AS
BEGIN
	declare @status int, @msg nvarchar(50)
	select @status=0,@msg=''
	select @score=[dbo].[whenull](@score,'0'), @score2=[dbo].[whenull](@score2,'0')
	select @score=iif(PATINDEX('%[^0-9|.]%', @score)=0,@score,'0'), @score2=iif(PATINDEX('%[^0-9|.]%', @score2)=0,@score2,'0')
	update studentCertList set score=@score,score1=@score,score2=@score2,result=@result,examDate=dbo.whenull(@examDate,null) where ID=@refID

	-- 写操作日志
	exec writeOpLog '', '修改考试成绩','saveExamScore',@registerID,@result,@refID
	select 0 as status, '操作成功' as msg
END
GO

-- =============================================
-- CREATE Date: 2025-03-21
-- Description:	批量设置学员来源
-- @selList: 名单，用逗号分隔的kind A applyID  B username
-- Use Case:	exec [setStudentSource] '...'
-- =============================================
CREATE PROCEDURE [dbo].[setStudentSource] 
	@selList varchar(4000), @kind varchar(50), @classID varchar(50), @source nvarchar(50), @registerID varchar(50)
AS
BEGIN
	--将名单导入到临时表
	create table #temp(id varchar(50))
	declare @n int, @j int, @event nvarchar(50)
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	if @kind='A'
		update studentCourseList set source=@source from studentCourseList a, #temp b, applyInfo c where b.id=c.id and a.id=c.enterID
	if @kind='B'
		update studentCourseList set source=@source from studentCourseList a, #temp b where a.username=b.id and a.classID=@classID

	-- 写操作日志
	select @event='设置学员来源'
	exec writeOpLog '', @event,'setStudentSource',@registerID,@selList,@source
	select 0 as status, '操作成功' as msg
END
GO

-- CREATE DATE: 2025-03-22
-- 根据给定的参数，添加或者更新学员来源信息
-- USE CASE: exec updateSourceInfo 1,'P1','xxxx'...
CREATE PROCEDURE [dbo].[updateSourceInfo]
	@ID int,@source nvarchar(50),@status int,@registerID varchar(50)
AS
BEGIN
	declare @re int, @msg varchar(100), @event nvarchar(50)
	
	if not exists(select 1 from sourceInfo where ID=@ID)	-- 新纪录
	begin
		insert into sourceInfo(source,registerID) values(@source,@registerID)
		select @ID=max(ID) from sourceInfo where registerID=@registerID
	end
	else
	begin
		update sourceInfo set source=@source,status=@status where ID=@ID
	end
	-- 写操作日志
	select @event='编辑学员来源'
	exec writeOpLog '', @event,'updateSourceInfo',@registerID,@ID,@source
	select @ID as re
END
GO

-- CREATE DATE: 2015-01-12
-- 根据给定的参数，删除学员来源数据，并写日志
-- USE CASE: exec delSourceInfo 1
CREATE PROCEDURE [dbo].[delSourceInfo]
	@ID int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	if exists(select 1 from sourceInfo where ID=@ID)
	begin
		delete from sourceInfo where ID=@ID
		-- 写操作日志
		exec writeOpLog '','删除学员来源','delSourceInfo',@registerID,@memo,@ID
	end
END
GO


-- CREATE DATE: 2025-04-10
-- 获取学员已有证书信息
-- USE CASE: select * from dbo.[getStudentCertList]('120107196604032113')
CREATE FUNCTION [dbo].[getStudentDiplomaList]
(	
	@username varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT    dbo.v_diplomaInfo.ID, dbo.v_diplomaInfo.diplomaID, dbo.v_diplomaInfo.username, dbo.v_diplomaInfo.certID, dbo.v_diplomaInfo.status, dbo.v_diplomaInfo.score, dbo.v_diplomaInfo.term, 
               dbo.v_diplomaInfo.startDate, dbo.v_diplomaInfo.endDate, dbo.v_diplomaInfo.filename, dbo.v_diplomaInfo.memo, dbo.v_diplomaInfo.regDate, dbo.v_diplomaInfo.registerID, 
               dbo.v_diplomaInfo.name, dbo.v_diplomaInfo.sex, dbo.v_diplomaInfo.age, dbo.v_diplomaInfo.host, dbo.v_diplomaInfo.dept1, dbo.v_diplomaInfo.dept2, dbo.v_diplomaInfo.mobile, 
               dbo.v_diplomaInfo.email, dbo.v_diplomaInfo.hostName, dbo.v_diplomaInfo.dept1Name, dbo.v_diplomaInfo.dept2Name, dbo.v_diplomaInfo.sexName, dbo.v_diplomaInfo.kindName, 
               dbo.v_diplomaInfo.kindID, dbo.v_diplomaInfo.certName, dbo.v_diplomaInfo.agencyName, dbo.v_diplomaInfo.agencyID, dbo.v_diplomaInfo.statusName, 
               dbo.v_diplomaInfo.registerName
	FROM       dbo.v_studentDiplomaGroupExt ,
               dbo.v_diplomaInfo where dbo.v_diplomaInfo.username=@username and dbo.v_studentDiplomaGroupExt.username=@username and dbo.v_studentDiplomaGroupExt.diplomaID = dbo.v_diplomaInfo.diplomaID

)
GO

-- CREATE DATE: 2025-04-17
-- 变更考勤记录，从一个课程/班级转到另一个课程/班级
-- USE CASE: exec [changeCheckin4newClass] 1693, 1716, 0, 141904, 'L17'
-- @enterID0/@courseID0 must give one
ALTER PROCEDURE [dbo].[changeCheckin4newClass]
	@classID0 int, @classID1 int, @enterID0 int, @enterID1 int, @courseID0 varchar(50)
AS
BEGIN
	-- change check list from an old class and course to a new class and course
	-- the date will auto fill by order
	-- declare @classID0 int, @classID1 int, @enterID1 int, @enterID0 int, @courseID0 varchar(50)
	--if old enter had been deleted, find it in histroy record
	if @enterID0=0
		select @enterID0=max(ID) from del_studentCourseList where username=(select username from studentCourseList where ID=@enterID1) and courseID=@courseID0 and applyID>0
	--replace old check in with new records
	if @classID0 = @classID1
		update checkinInfo set enterID=@enterID1 where enterID=@enterID0
	else
		update checkinInfo set enterID=@enterID1, refID=d.refID from checkinInfo c, 
		(select e.ID,f.ID as refID from
			--find old class checkin records
			(select a.*,RANK() over(order by a.ID) as rank1,convert(varchar(20),b.theDate,23) as theDate1 from checkinInfo a, classSchedule b where a.refID=b.ID and a.kindID=1 and b.classID=@classID0 and b.mark='A' and a.enterID=@enterID0) e,
			--find new class checkin records
			(select ID,RANK() over(order by ID) as rank1,convert(varchar(20),theDate,23) as theDate1 from classSchedule where classID=@classID1 and mark='A' and online=0 and typeID=0) f
			where e.theDate1=f.theDate1 or e.rank1=f.rank1
		) d where c.ID=d.ID

	--replace old face detect records with new's
	update [dbo].[faceDetectInfo] set refID=@enterID1, keyID=b.refID from [faceDetectInfo] a, 
	(select c.ID,d.refID from
		(select ID,RANK() over(order by ID) as rank1 from [faceDetectInfo] where refID=@enterID0 and kindID=2) c,
		(select RANK() over(order by ID) as rank1, refID from checkinInfo where enterID=@enterID1) d
		where c.rank1=d.rank1) b
	where a.ID=b.ID
END
GO

-- CREATE DATE: 2020-05-08
-- 获取当前所有客户来源明细
-- USE CASE: select * from dbo.[getCurrSourceList]()
ALTER FUNCTION [dbo].[getCurrSourceList]()
RETURNS TABLE 
AS
RETURN 
(
	SELECT source as ID, source as item FROM v_sourceInfo where status=0 union select title,title as item from hostInfo where status=0
)
GO

-- CREATE DATE: 2020-05-08
-- 获取当前所有课程
-- USE CASE: select * from dbo.[getCurrCourseList]()
ALTER FUNCTION [dbo].[getCurrCourseList]()
RETURNS TABLE 
AS
RETURN 
(
	SELECT courseID as ID, shortName as item FROM v_courseInfo where status=0 and type=0
)
GO

--CREATE Date:2025-05-11
--根据给定日期，列出招生人数对比统计: 指定日期范围招生人数(不包含退课的)、上年同期、同比%、上年全年、前年全年
--@startDate 开始日期  @endDate 截止日期  @kind: 0 按课程  1 按客户来源  @mark: data/file
ALTER PROCEDURE [dbo].[getYOYRpt]
	@startDate varchar(50), @endDate varchar(50), @kind int, @mark varchar(50)
AS
BEGIN
	declare @sql nvarchar(max), @key varchar(500)
	select @endDate = iif(@endDate='',convert(varchar(20),getDate(),23),@endDate), @key = iif(@kind=0,'courseID','source')

	SET @sql = N'
	declare @tb table(kindID int default 0,ID nvarchar(50),item nvarchar(50) default(''''),thisYear int default 0,YOY int default 0,rate decimal(18,2) default 0,lastYear int default 0, blastYear int default 0)
	declare @mark varchar(50)
	select @mark=''' + @mark + '''
	--填写基本项目
	insert into @tb(ID,item) select ID,item from ' + iif(@kind=0,'dbo.[getCurrCourseList]()','dbo.[getCurrSourceList]()') + ' 
	--查找今年数据
	update @tb set thisYear=b.count from @tb a, (select ' + @key + ' as ID, count(*) as count from studentCourseList where status<3 and regDate between ''' + @startDate + ''' and ''' + @endDate + ''' group by ' + @key + ') b where a.ID=b.ID
	--查找上年同期数据
	update @tb set YOY=b.count from @tb a, (select ' + @key + ' as ID, count(*) as count from studentCourseList where status<3 and regDate between ''' + convert(varchar(20),dateadd(yy,-1,@startDate),23) + ''' and ''' + convert(varchar(20),dateadd(yy,-1,@endDate),23) + ''' group by ' + @key + ') b where a.ID=b.ID
	--查找上年全年数据
	update @tb set lastYear=b.count from @tb a, (select ' + @key + ' as ID, count(*) as count from studentCourseList where status<3 and regDate between ''' + cast(year(dateadd(yy,-1,@startDate)) as varchar) + '-01-01' + ''' and ''' + cast(year(dateadd(yy,-1,@startDate)) as varchar) + '-12-31' + ''' group by ' + @key + ') b where a.ID=b.ID
	--查找前年全年数据
	update @tb set blastYear=b.count from @tb a, (select ' + @key + ' as ID, count(*) as count from studentCourseList where status<3 and regDate between ''' + cast(year(dateadd(yy,-2,@startDate)) as varchar) + '-01-01' + ''' and ''' + cast(year(dateadd(yy,-2,@startDate)) as varchar) + '-12-31' + ''' group by ' + @key + ') b where a.ID=b.ID
	--添加合计
	insert into @tb select 1,'''',''合计'',sum(thisYear),sum(YOY),0,sum(lastYear),sum(blastYear) from @tb
	--计算同比
	update @tb set rate=iif(YOY=0,0,(thisYear-YOY)*100.00/YOY)

	if @mark=''data''
		select iif(kindID=0,cast(ROW_NUMBER() OVER (ORDER BY kindID) as varchar),'''') as No,* from @tb order by kindID,ID
	if @mark=''file''
		select iif(kindID=0,cast(ROW_NUMBER() OVER (ORDER BY kindID) as varchar),'''') as No,item as 项目,thisYear as [' + replace(@startDate,'-','') + '-' + replace(@endDate,'-','') + '], YOY as 去年同期, rate as 同比增长, lastYear as 去年全年, blastYear as 前年全年 from @tb  order by kindID,ID'
	
	EXECUTE (@sql)
END
GO

-- CREATE DATE: 2025-06-20
-- 获取student list under one saler
-- USE CASE: select * from dbo.[getStudentListBySaler]('panqingfeng.')
CREATE FUNCTION [dbo].[getStudentListBySaler]
(	
	@saler varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT * FROM v_studentInfo where fromID=@saler
	UNION
	SELECT * from v_studentInfo where username in(select distinct username from studentCourseList where fromID=@saler)
)
GO

--CREATE Date:2020-05-18
--返回学员在某个销售名下的课程数量
CREATE FUNCTION [dbo].[getStudentSalerCourseCount](@username varchar(50), @saler varchar(50))
RETURNS int
AS
BEGIN
	declare @re int
	select @re = 0
	select @re = count(*) from studentCourseList where username=@username and fromID=@saler
	return @re
END
GO

-- CREATE DATE: 2025-06-25
-- 根据给定的参数，添加或者更新企业客户信息
-- USE CASE: exec updateSalerUnitInfo 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updateSalerUnitInfo]
	@ID int,@unitName nvarchar(4000),@taxNo varchar(50),@saler varchar(50),@kindID int,@linker varchar(500),@phone varchar(200),@address varchar(200),@email varchar(200),@association varchar(50),@memo varchar(2000),@registerID varchar(50)
AS
BEGIN
	declare @logMemo nvarchar(500)
	if @ID=0	-- 新纪录
	begin
		insert into unitInfo(unitName,taxNo,saler,kindID,linker,phone,address,email,association,memo,registerID) values(@unitName,@taxNo,@saler,@kindID,@linker,@phone,@address,@email,@association,@memo,@registerID)
		select @ID=max(ID) from unitInfo where registerID=@registerID
	end
	else
	begin
		update unitInfo set unitName=@unitName,taxNo=@taxNo,saler=@saler,kindID=@kindID,linker=@linker,phone=@phone,address=@address,email=@email,association=@association,memo=@memo where ID=@ID
	end
	
	-- 写操作日志
	select @logMemo = @unitName+'  '+@linker+'  '+@phone+'  '+@memo
	exec writeOpLog '','企业信息','updateSalerUnitInfo',@registerID,@logMemo,@ID
	select @ID as re
END
GO

-- CREATE DATE: 2025-06-25
-- 根据给定的参数，确认企业名称和代码。
-- USE CASE: exec setUnitTaxConfirm 'P1','xxxx'...
CREATE PROCEDURE [dbo].[setUnitTaxConfirm]
	@unitName nvarchar(4000),@taxNo varchar(50),@address nvarchar(100),@username varchar(50),@registerID varchar(50)
AS
BEGIN
	declare @logMemo nvarchar(500)
	select @unitName=replace(dbo.whenull(@unitName,''),' ',''), @taxNo=replace(dbo.whenull(@taxNo,''),' ',''), @address=replace(dbo.whenull(@address,''),' ','')
	if @unitName>'' and @taxNo>'' and len(@taxNo)=18	--无名称或代码的或代码不正确的，不予处理
	begin
		if not exists(select 1 from unitInfo where unitName=@unitName or taxNo=@taxNo)	-- 新纪录
		begin
			insert into unitInfo(unitName,taxNo,address,checker,registerID) values(@unitName,@taxNo,@address,@registerID,@registerID)
			--自动更新那些有相同名称但无税号的学员信息
			update studentInfo set tax=@taxNo,address=iif(address is null and @address>'',@address,address) where unit=@unitName and (tax='' or tax is null)
			select @logMemo='新增企业' + @unitName + @taxNo + @address
		end
		else
		begin
			if @registerID=''	--非人工确认的（一般来自学员注册信息变更时触发的自动登记）
				update unitInfo set unitName=@unitName,address=iif(address is null and @address>'',@address,address) where taxNo=@taxNo and (checker='' or checker is null)
			else
			begin
				if exists(select 1 from unitInfo where unitName=@unitName and taxNo<>@taxNo)
					update unitInfo set taxNo=@taxNo,address=iif(@address>'',@address,address),checker=@registerID where unitName=@unitName
				else if exists(select 1 from unitInfo where taxNo=@taxNo and unitName<>@unitName)
					update unitInfo set unitName=@unitName,address=iif(@address>'',@address,address),checker=@registerID where taxNo=@taxNo
				--根据确认的企业信息，更新与此不符的学员信息
				update studentInfo set tax=@taxNo,address=iif(address is null and @address>'',@address,address) where unit=@unitName and tax<>@taxNo
				update studentInfo set unit=@unitName,address=iif(address is null and @address>'',@address,address) where tax=@taxNo and unit<>@unitName
				select @logMemo='确认企业代码' + @unitName + @taxNo + @address
			end
		end

		if @username>''
			update studentInfo set tax=@taxNo, unit=@unitName, address=@address where username=@username
	
		-- 写操作日志
		exec writeOpLog '','企业信息','setUnitTaxConfirm',@registerID,@logMemo,@taxNo
	end
	select @taxNo as re
END
GO

-- CREATE DATE: 2025-06-25
-- 根据给定的参数，检查企业名称和代码是否已登记，以代码为主。
-- USE CASE: exec checkUnitInfo 'P1','xxxx'...
ALTER PROCEDURE [dbo].[checkUnitInfo]
	@unitName nvarchar(4000),@taxNo varchar(50)
AS
BEGIN
	declare @re int
	select @unitName=replace(dbo.whenull(@unitName,''),' ',''), @taxNo=replace(dbo.whenull(@taxNo,''),' ','')
	if @taxNo>'' and exists(select 1 from unitInfo where taxNo=@taxNo)	-- 有代码
		select 1 as re,unitName,taxNo,saler,checker,checkerName,isnull(address,'') as address,isnull(phone,'') as phone from v_unitInfo where taxNo=@taxNo
	else if @unitName>'' and exists(select 1 from unitInfo where unitName=@unitName)	-- 有单位名称
		select 2 as re,unitName,taxNo,saler,checker,checkerName,isnull(address,'') as address,isnull(phone,'') as phone from v_unitInfo where unitName=@unitName
	else
		select 0 as re
END
GO

-- CREATE DATE: 2025-09-29
-- 检查某个班级的课表是否符合上报要求
-- 开班日期、班主任、培训地点，计划人数在 1-60 人之间，课表日期在计划日期之间，教师姓名，身份证，教室，学时1-4，课表日期+上下午不得重复
-- USE CASE: exec checkClassSchedule 1
ALTER PROCEDURE [dbo].[checkClassSchedule]
	@classID varchar(50)
AS
BEGIN
	declare @re int, @msg nvarchar(4000),@startDate smalldatetime,@endDate smalldatetime,@courseID varchar(50)
	select @startDate=startDate,@endDate=endDate,@courseID=courseID,@msg='',@re=0 from generateApplyInfo where ID=@classID
	--开班日期必须是下个月
	if month(getDate())>=month(@startDate)
		select @msg = @msg + '培训日期必须为下个月；'
	--培训周期
	if exists(select 1 from courseInfo where courseID=@courseID and period>datediff(d,@startDate,@endDate)+1)
		select @msg = @msg + '培训周期不足，至少天数：' + cast(period as varchar) + '；' from courseInfo where courseID=@courseID
	--班主任、培训地点，计划人数
	select @msg=@msg+iif(planQty<1 or planQty>60,'计划人数应在 1-60 人之间；','')+iif(adviserName>'','','班主任未填；')+iif(notes='','培训地点未填；','') from v_generateApplyInfo where ID=@classID
	--课表日期在计划日期之间
	if exists(select 1 from classSchedule where classID=@classID and mark='A' and (theDate<@startDate or theDate>@endDate))
		select @msg = @msg + '课表日期超出培训周期；'
	--教师姓名，身份证，教室，学时1-4
	select @msg=@msg+iif(teacherName='','教师姓名有空缺；','')+iif(teacherSID='','教师身份证有空缺；','')+iif(online=0 and address='','线下教室有空缺；','')+iif(hours<1 or hours>4,'学时应在1-4之间；','') from v_classSchedule where classID=@classID and mark='A'
	--课表日期+上下午不得重复
	if exists(select 1 from classSchedule where classID=@classID and mark='A' group by theDate, typeID having count(*)>1)
		select @msg = @msg + '课表日期+上下午不得重复；'
	select @msg as msg
END
GO

--CREATE Date:2020-05-18
--返回学员指定资料图片的大小
--kindID: 
--0	照片
--1	身份证正面
--2	身份证背面
--3	学历证书
--4	学信网认证
--5	在职证明
--6	居住证
--7	承诺书
--8	社保证明
--USE CASE: [dbo].[getStudentMaterialSize]('123','0')
CREATE FUNCTION [dbo].[getStudentMaterialSize](
	@username varchar(50), @kindID int
)
RETURNS int
AS
BEGIN
	declare @re int
	select @re = size from studentMaterials where username=@username and kindID=@kindID
	return isnull(@re,0)
END
GO

