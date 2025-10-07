USE [elearning]
GO
--�������ݿ���־�ļ���
use master
ALTER DATABASE elearning SET RECOVERY SIMPLE
DBCC SHRINKDATABASE(elearning)
DBCC SHRINKFILE(2)
ALTER DATABASE elearning SET RECOVERY FULL
--sp_change_users_login 'update_one','sqlrw','sqlrw'
--De0penl99O53!4N#~9.
--set datefirst 1  --������һ��Ϊ��һ��

select * from dictionaryDoc where kind like '%material%' order by kind, ID
select * from dictionaryDoc where kind like '%schedule%' order by kind, ID
select * from dictionaryDoc where kind like '%online%' order by kind, ID
select * from dictionaryDoc where item like '%Ԥ��%' order by kind, ID
--delete from dictionaryDoc where mID=1298
insert into dictionaryDoc(ID,item,kind,description,memo) values('0','����','servicePrivate','','')
insert into dictionaryDoc(ID,item,kind,description,memo) values('1','˽��','servicePrivate','','')
insert into dictionaryDoc(ID,item,kind,description,memo) values('2','����','accountKind','','')
insert into dictionaryDoc(ID,item,kind,description,memo) values('3','̨��֤','IDkind','','')
insert into dictionaryDoc(ID,item,kind,description,memo) values('5','����','IDkind','','')
insert into dictionaryDoc(ID,item,kind,description,memo) values('6','��','week','','')
insert into dictionaryDoc(ID,item,kind,description,memo) values('8','�籣֤��','material','student_social','')
insert into dictionaryDoc(ID,item,kind,description,memo) values('0','����','fromKind','','')
update dictionaryDoc set item='ʵ��' where mID=1297
update dictionaryDoc set item='����' where mID=1291
update dictionaryDoc set item='�о���������' where mID=242
update dictionaryDoc set item='���ƻ�ͬ��ѧ��' where mID=241
update dictionaryDoc set item='ר�ƻ�ͬ��ѧ��' where mID=240
update dictionaryDoc set item='��ר��ͬ��ѧ��' where mID=239
update dictionaryDoc set item='���л�ͬ��ѧ��' where mID=238
delete from dictionaryDoc where mID=243

--questionType
-- JOB
-- dailywork: exec plan_dailyCheck  run at 0:01:00 every day

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- table
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

--�������������
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
	[owner] [int] NULL  DEFAULT ((0)),	--0 ����  1 ϵͳר��  2 ��˾ר��
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
	[owner] [int] NULL DEFAULT ((0)),	--0 ����  1 ϵͳר��  2 ��˾ר��
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

-- ֤����Ŀ
CREATE TABLE [dbo].[certificateInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[certID] [varchar](50) NOT NULL,
	[certName] [varchar](50) NOT NULL,
	[shortName] [varchar](50) NOT NULL,
	[kindID] [int] NULL default(0),		--certKind 0 ������Ŀ  1 ר����Ŀ
	[type] [int] NULL default(0),		--certType 0 �ⲿ��֤  1 �ڲ���֤
	[agencyID] [varchar](50) NULL,		--�䷢����
	[status] [int] NULL default(0),		--statusEffect
	[term] [int] NULL default(0),		--��Ч�ڣ��꣩
	[host] [varchar](50) NOT NULL,		--ר����Ŀ������
	[memo] [varchar](500) NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

-- �γ�
CREATE TABLE [dbo].[courseInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[certID] [varchar](50) NULL,
	[courseID] [varchar](50) NOT NULL,
	[courseName] [varchar](50) NOT NULL,
	[kindID] [int] NULL DEFAULT ((0)),		--certKind 0 ������Ŀ  1 ר����Ŀ
	[hours] [int] NULL DEFAULT ((0)),
	[status] [int] NULL DEFAULT ((0)),
	[deadline] [int] NULL default(20),		--���ڴ��������˿Σ�%��
	[deadday] [int] NULL default(20),		--���ڴ��������˿Σ��죩
	[period] [int] NULL default(90),		--���ڴ���ǿ�ƽ����γ̣��죩
	[periodExt] [int] NULL default(360),	--�����ѵ���ڣ��죩
	[completionPass] [int] NULL default(100),		--�ﵽ�ڴ����ɽ�ҵ��%��
	[host] [varchar](50) NOT NULL,			--ר����Ŀ������
	[memo] [varchar](500) NULL,
	[regDate] [datetime] NULL DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

-- ��������ѵ��Ŀ����
CREATE TABLE [dbo].[projectInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[projectID] [varchar](50) NOT NULL,
	[projectName] [varchar](50) NOT NULL,
	[certID] [varchar](50) NOT NULL,
	[kindID] [int] NULL default(0),		--certKind 0 ������Ŀ  1 ר����Ŀ
	[object] [varchar](50) NULL,		--��ѵ����
	[address] [varchar](200) NULL,		--��ѵ�ص�
	[deadline] [smalldatetime] NULL,	--��ֹ����
	[status] [int] NULL default(0),		--statusIssue
	[phone] [varchar](50) NULL,		--��ѵ����
	[email] [varchar](50) NULL,		--��ѵ����
	[payKind] [int] NULL default(0),		--payKind 0 ����  1 ����
	[payGroup] [int] NULL default(0),		--���忪Ʊ����ʽ payGroup 0 ��˾  1 ����
	[price] [int] NULL default(0),		--
	[host] [varchar](50) NOT NULL,		--ר����Ŀ������
	[memo] [varchar](2000) NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

-- ֤���ı�
CREATE TABLE [dbo].[diplomaInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[diplomaID] [varchar](50) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[certID] [varchar](50) NULL,
	[status] [int] NULL default(0),		--statusEffect
	[score] decimal(18,1) NULL default(0),	
	[term] [int] NULL default(0),		--��Ч�ڣ��꣩
	[startDate] [smallDatetime] NULL,
	[endDate] [smallDatetime] NULL,
	[filename] [varchar](50) NOT NULL,	--�����ĵ�
	[issued] [int] NULL default(0),		--statusNo  0 �� 1 �� �ѷ���
	[issueDate] [Datetime] NULL,		--��������
	[issueType] [int] NULL default(0),	--issueType ���ŷ�ʽ  0 ���� 1 ������ȡ  2 ����
	[issuer] [varchar](50) NULL,		--������
	[host] [varchar](50) NOT NULL,		
	[memo] [varchar](500) NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO


-- ���
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

-- ��˾�γ�Ŀ¼
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

-- ��˾��ʦ
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
	[examScore] decimal(18,1) NULL default(0),	//ģ�⿼����óɼ�
	[examTimes] [int] NULL default(0),	//ģ�⿼�Դ���
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
	[examScore] decimal(18,1) NULL default(0),	//ģ�⿼����óɼ�
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
-- completion: ��ɶ�%
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

-- �Ծ�
-- status: planStatus
-- kindID:dictionaryDoc.examKind 0 ����  1 ���¿���
-- ֤����certID��γ̱��courseID���У�֤����γ̹���ͬһ���Ծ���
-- ֻ��֤���ţ��ÿ���ֻΪ֤�����У�
-- ֻ�пγ̱�ţ��ÿ���ֻΪ�γ����С�
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
-- proportion: ��Ƶ�ڿγ���ռ�ݵĿ�ʱ����
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
-- proportion: �μ��ڿγ���ռ�ݵĿ�ʱ����
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

-- ѧԱ�Ծ�
-- status: examStatus	0 ׼����  1 �ѿ�ʼ  2 �ѽ���
-- kindID:dictionaryDoc.examKind 0 ��֤ 1 �γ�
-- refID: when kingID=0 then [studentCertList].ID; when kindID=1 then [studentCourseList].ID
CREATE TABLE [dbo].[studentExamList](
	[paperID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[examID] [varchar](50) NOT NULL,
	[refID] [int] NULL default(0),
	[kindID] [int] NULL default(0),
	[status] [int] NULL default(0),
	[minutes] [int] NULL default(0),		--������ʱ�������ӣ�
	[secondRest] [int] NULL default(0),		--ʣ������
	[scoreTotal] [int] NULL,				--�ܷ�
	[scorePass] [int] NULL,					--������
	[score] decimal(18,1) NULL default(0),	--ѧԱ�÷�
	[startDate] [datetime] NULL,			--��ʼʱ��
	[endDate] [datetime] NULL,				--����ʱ��
	[lastDate] [datetime] NULL,				--������ʱ��
	[memo] [varchar](500) NULL,
	[regDate] [datetime] NULL  DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

-- ѧԱ����
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

-- ѧԱ����
-- status: dealStatus
-- kindID:dictionaryDoc.feedback
-- emergency:0 һ��  1 ����
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

-- ѧԱ����
-- status: readStatus 0 δ��  1 �Ѷ�  2 ����
-- kindID:dictionaryDoc.message
-- emergency:0 һ��  1 ����
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

--�γ���������б�
--kindID: material
--mark:0 ��֤��Ŀ  1 ��ѵ��Ŀ
--step:���׶� 0 ѡ��ǰ  1 ����ǰ  2 ��֤��ǰ
CREATE TABLE [dbo].[certNeedMaterial](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[kindID] [int] NOT NULL default(0),
	[certID] [varchar](50) NOT NULL,
	[mark] [int] NULL default(0),
	[step] [int] NULL default(0)
) ON [PRIMARY]

--ѧ���ύ�����б�
--kindID: material
--type:0 ����  1 ֽ��
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

--ѧ�����������б�
--kindID: material
--status: 0 ���� 1 ֪ͨ  2 ��Ӧ  3 ȷ�� 
--asker:����   answer:��Ӧ   closer:ȷ��
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

--ѧ�������γ�ר�����
--ÿ�ſγ�ֻ��һ��ר�����
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

--ͨ�ø���
CREATE TABLE [dbo].[materialInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[refID] [varchar](50) NOT NULL,		--���ձ�ʶ
	[kind] [varchar](50) NOT NULL,		--���
	[filename] [varchar](50) NULL,		--�ļ�����·��
	[type] [int] NULL default(0),
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL DEFAULT (getdate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--�Զ����к�
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

--֤�������б�
--ÿ����������֤�齫��¼����
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

--֤�鷢���б�
--ÿ����������֤�齫��¼����
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


--�ϴ�ѧԱ�����б�
--ÿ���������ɱ�����¼
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

--�ϴ�ѧԱ�ɼ��б���֤���ţ�
--ÿ���������ɳɼ���¼
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

--�����ϴ�ѧԱ����
--ÿ���������ɳɼ���¼
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

--�����ϴ�ѧԱ������ϸ
CREATE TABLE [dbo].[generateMaterialDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[batchID] [int] NOT NULL default(0),
	[filename] [varchar](100) NULL
) ON [PRIMARY]

GO

--���ŷ��ͼ�¼
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

--ѧԱ�����¼
CREATE TABLE [dbo].[studentServiceInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NULL,
	[mobile] [varchar](50) NULL,		--��ϵ�������绰���룩
	[item] [nvarchar](4000) NULL,		--��������
	[refID] [int] NULL default(0),		--studentCourseList.ID
	[vID] [int] NULL default(0),		--dictionaryDoc.ID where kind='material'
	[kindID] [int] NULL default(0),		--��Դ���:serviceKind:0 ����  1 ѧУ
	[type] [int] NULL default(0),		--������ʽ:serviceType:0 ����  1 �绰  2 �ֳ�  9 ����
	[status] [int] NULL default(0),		--statusService: 0 �Ѿ����  1 ��������  2 �ȴ�����
	[private] [int] NULL default(0),	--0 ����  1 ˽��
	[backDate] [datetime] NULL,			--��������
	[feedback] [nvarchar](500) NULL,	--��������
	[serviceDate] [datetime] NULL default(getDate()),
	[host] [varchar](50) NULL,
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--�༶��Ϣ
CREATE TABLE [dbo].[classInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[classID] [varchar](50) NOT NULL,
	[certID] [varchar](50) NULL,		--
	[projectID] [varchar](50) NULL,		--
	[adviserID] [varchar](50) NULL,		--������
	[kindID] [int] NULL default(0),		--�������:serviceKind:0 ֪ͨ  1 �ط�  2 ��ѯ  9 ����
	[status] [int] NULL default(0),		--planStatus: 0 ׼��  1 ����  2 ����
	[dateStart] [datetime] NULL,		--��������
	[dateEnd] [datetime] NULL,			--��������
	[classroom] [nvarchar](500) NULL,	--����
	[host] [varchar](50) NULL,
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--�շ���Ϣ
CREATE TABLE [dbo].[payInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[invoice] [varchar](50) NULL,		--��Ʊ��
	[projectID] [varchar](50) NULL,		--
	[title] [nvarchar](100) NULL,		--̧ͷ
	[amount] decimal(18,2) NULL default(0),		--��Ʊ���
	[kindID] [int] NULL default(0),		--���:payKind:0 ����  1 ����
	[type] [int] NULL default(0),		--֧����ʽ:payType:0 �ֽ�  1 ֧����  2 ΢��  3 ����ת��  9 ����
	[status] [int] NULL default(0),		--statusPay: 0 δ֧��  1 ��֧��  2 ���˿�
	[deptID] [int] NULL default(0),		--���ſ�Ʊ
	[datePay] [datetime] NULL,			--��������
	[dateInvoice] [smalldatetime] NULL,		--��Ʊ����
	[dateInvoicePick] [smalldatetime] NULL,		--��Ʊ��ȡ����
	[dateRefund] [smalldatetime] NULL,		--�˿�����
	[refunderID] [varchar](50) NULL,		--�˿������
	[checkDate] [smalldatetime] NULL,	--ȷ������
	[checkerID] [varchar](50) NULL,		--ȷ����
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--�շ���ϸ
CREATE TABLE [dbo].[payDetailInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[payID] int NOT NULL,		--payInfo.ID
	[enterID] int NOT NULL,		--studentCourseList.ID
	[price] decimal(18,2) NULL default(0),		--���
	[status] [int] NULL default(0),		--statusEffect
	[payID_old] int NULL default(0),	
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--����վ��ʶ���ձ�
CREATE TABLE [dbo].[deptRefrence](
	[deptID] int NOT NULL,		--deptInfo.deptID
	[refID] [varchar](50) NOT NULL,		--from SPC
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate())
) ON [PRIMARY]

GO

--��������׼��֤��Ϣ
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

--׼��֤
CREATE TABLE [dbo].[passcardInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[refID] [int] NOT NULL,
	[enterID] [int] NOT NULL,
	[passNo] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[score] [int] NULL default(0),
	[resit] [int] NULL default(0),
	[status] [int] NULL default(0),  --examResult:0 δ�� 1 �ϸ� 2 ���ϸ�
	[memo] [varchar](50) NULL,
	[regDate] [smalldatetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--�����걨������Ϣ
CREATE TABLE [dbo].[generateApplyInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[courseID] [varchar](50) NOT NULL,		--
	[applyID] [varchar](50) NULL,		--�걨����
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

--�걨
CREATE TABLE [dbo].[applyInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[refID] [int] NOT NULL,
	[enterID] [int] NOT NULL,
	[applyNo] [varchar](50) NULL,
	[score] [int] NULL default(0),  
	[score1] [int] NULL default(0),
	[score2] [int] NULL default(0),
	[resit] [int] NULL default(0),
	[statusApply] [int] NULL default(0),  --statusApply:0 ����  1 ͨ�� 2 δͨ��
	[status] [int] NULL default(0),  --examResult:0 δ�� 1 �ϸ� 2 ���ϸ� 3 ȱ��
	[memo] [varchar](50) NULL,
	[regDate] [smalldatetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--׼��֤
CREATE TABLE [dbo].[firemanEnterInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[enterID] [int] NOT NULL,
	[area] [varchar](50) NULL,				--�������ڵ�
	[address] [varchar](100) NULL,			--��ϸ��ַ
	[employDate] [smalldatetime] NULL,		--�μӹ���ʱ��
	[university] [varchar](100) NULL,		--����ѧУ
	[gradeDate] [smalldatetime] NULL,		--��ҵʱ��
	[profession] [varchar](50) NULL,		--רҵ����
	[area_now] [varchar](50) NULL,			--��ס����
	[kind1] [int] NULL default(0),			--��Ա����
	[kind2] [int] NULL default(0),			--������ò
	[kind3] [int] NULL default(0),			--ѧУ����
	[kind4] [int] NULL default(0),			--ְҵ����
	[kind5] [int] NULL default(0),			--ְҵ�ȼ�
	[kind6] [int] NULL default(0),			--��������
	[kind7] [int] NULL default(0),			--�����ʸ�������
	[kind8] [int] NULL default(0),			--���ְҵ
	[kind9] [int] NULL default(0),			--�걨�ʸ�
	[kind10] [int] NULL default(0),			--����ְҵ
	[kind11] [int] NULL default(0),			--��ְ���
	[kind12] [int] NULL default(0),			--ѧ��
	[materials] [varchar](200) NULL,
	[memo] [varchar](500) NULL,
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO


--���ﳵ
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

--ĳ���Ծ����������
CREATE TABLE [dbo].[studentQuestionUsed](
	[questionID] [varchar](50) NOT NULL,
	[refID] [int] NULL,		--paperID
	[kindID] [int] NULL,
	[status] [int] NULL,	--0 δ��  1 ��ȷ  2 ����
	[answer] [varchar](50) NULL,
	[myAnswer] [varchar](50) NULL,
	[times] [int] NULL default(0)
) ON [PRIMARY]

GO

--�α�
CREATE TABLE [dbo].[schedule](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[courseID] [varchar](50) NOT NULL,
	[seq] [int] NULL default(0),
	[kindID] [int] NULL default(0),		--0 ����  1 ʵѵ  2 ��ϰ
	[typeID] [int] NULL default(0),		--0 ����  1 ����  2 ����
	[hours] [int] NULL default(0),		--��ʱ
	[period] [varchar](50) NOT NULL,	--ʱ��
	[item] [nvarchar](100) NULL,
	[status] [int] NULL default(0),
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--�α�
CREATE TABLE [dbo].[classSchedule](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[classID] [varchar](50) NOT NULL,
	[courseID] [varchar](50) NOT NULL,
	[seq] [int] NULL default(0),
	[kindID] [int] NULL default(0),		--scheduleKind: 0 ����  1 ʵѵ
	[typeID] [int] NULL default(0),		--scheduleType: 0 ����  1 ����
	[online] [int] NULL default(0),		--online: 0 ����  1 ����
	[hours] [int] NULL default(0),		--��ʱ
	[period] [varchar](50) NOT NULL,	--ʱ��
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

--��ʦ��Ϣ
CREATE TABLE [dbo].[teacherInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[teacherID] [varchar](50) NOT NULL,
	[teacherName] [varchar](50) NOT NULL,
	[partner] [int] NULL default(0),	--�������
	[status] [int] NULL,
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--��ʦ��Ϣ
CREATE TABLE [dbo].[courseTeacherList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[teacherID] [varchar](50) NOT NULL,
	[courseID] [varchar](50) NOT NULL,
	[type0] [int] NULL default(0),	--����
	[type1] [int] NULL default(0),	--ʵѵ
	[status] [int] NULL,
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL
) ON [PRIMARY]

GO

--������λ��Ϣ
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

--��ʾ��Ƭ��ǩ������Ϣ
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

--��ʾ��Ƭ��ǩ����������Ϣ
CREATE TABLE [dbo].[log_generateAttention](
	[ID] int IDENTITY(1,1) NOT NULL,
	[kindID] [int] NULL default(0),	    --0 photo  1 signature
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL default('admin.')
) ON [PRIMARY]
GO

--��Ʊ��Ϣ
CREATE TABLE [dbo].[invoiceInfo](
	[ID] int IDENTITY(1,1) NOT NULL,
	[kind] [nvarchar](50),	    --��Ʊ����
	[invCode] [varchar](50) NULL,	--��Ʊ����
	[invID] [varchar](50) NULL,		--��Ʊ����
	[taxNo] [varchar](50) NULL,	--˰��
	[taxUnit] [varchar](50) NULL,		--��Ʊ̧ͷ
	[invDate] [datetime] NULL,  --��������
	[item] [nvarchar](50) NULL,  --��Ŀ
	[amount] decimal(18,2) NULL default(0),		--��Ʊ���
	[cancel] [int] NULL default(0),	    --0 ��Ч  1 ����
	[cancelDate] [datetime] NULL,  --��������
	[payType] [nvarchar](50) NULL,  --֧����ʽ
	[payStatus] [int] NULL default(0),	    --֧��״̬ 0 �Ѹ�  1 Ӧ��
	[operator] [nvarchar](50) NULL,  --��Ʊ��
	[memo] [nvarchar](500) NULL,
	[checkDate] [datetime] NULL,  --�տ�ȷ������
	[checker] [nvarchar](50) NULL,  --�տ�ȷ����
	[regDate] [datetime] NULL default(getDate()),  --��������
	[registerID] [varchar](50) NULL default('admin.')	--������
) ON [PRIMARY]
GO

--ŵŵ������Ϣ
CREATE TABLE [dbo].[autoPayInfo](
	[ID] int IDENTITY(1,1) NOT NULL,
	[kind] [int] NULL DEFAULT (0),	    --���: 0 pay, 1 invoice, 2 refund
	[enterID] [int] NULL DEFAULT (0),
	[amount] [decimal](18, 2) default(0),		--���
	[payStatus] [int] NULL DEFAULT (0),	--0--��֧�� 1--��֧�� 2--֧��ʧ�� 3--�ر� 4--�˿��� 5--�˿�ɹ� 6--�˿�ʧ��
	[payTime] [datetime] NULL,  --����
	[payType] [varchar](50) NULL,		--֧������ WECHAT/ALIPAY
	[subject] [nvarchar](500) NULL,  --��Ŀ
	[customerTaxnum] [varchar](50) NULL,  --˰��
	[taxUnit] [varchar](50) NULL,		--��Ʊ̧ͷ
	[orderNo] [varchar](50) NULL,  --ŵŵ������
	[outOrderNo] [varchar](50) NULL,  --֧��������/��Ʊ��
	[userId] [varchar](50) NULL,  --
	[phone] [varchar](50) NULL,  --
	[memo] [nvarchar](500) NULL,
	[regDate] [datetime] NULL default(getDate())
) ON [PRIMARY]
GO

--ŵŵ�ӿڷ���ԭʼ��Ϣ
CREATE TABLE [dbo].[autoPayReturn](
	[ID] int IDENTITY(1,1) NOT NULL,
	[kind] [varchar](50) NULL,
	[memo] [nvarchar](4000) NULL,
	[regDate] [datetime] NULL default(getDate())
) ON [PRIMARY]
GO

--����Ƶˢ����ʶ��¼
CREATE TABLE [dbo].[log_set_shotNow](
	[ID] int IDENTITY(1,1) NOT NULL,
	[refID] int NULL,
	[shotTime] int NULL,
	[shoted] int NULL,
	[regDate] [datetime] NULL default(getDate())
) ON [PRIMARY]
GO

--ָ�����ۡ���˾�����ŵ�����۸�
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

--ѧԱ��Դ��Ϣ
CREATE TABLE [dbo].[sourceInfo](
	[ID] int IDENTITY(1,1) NOT NULL,
	[source] nvarchar(50) NOT NULL,	
	[status] [int] NULL default(0),
	[regDate] [datetime] NULL default(getDate()),
	[registerID] [varchar](50) NULL default('admin.')
) ON [PRIMARY]
GO

--�û����Բ鿴�İ༶
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

--�ο���Ƶ
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
-- ��¼��0. �ɹ� 1. not found 2. passwd error 3.diabled 4.expired
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
	select @e=0,@msg='��¼�ɹ�',@userID=0,@name='',@username=@username,@hostName=hostName,@newCourse=0 from hostInfo where hostNo=@host
	
	if exists(select 1 from studentInfo where username=@username)	-- and host=@host
	begin
		select @userID=userID,@user=userName,@name=name,@passwd0=password,@status=user_status,@newCourse=dbo.getStudentCurrCourseCount(username) from studentInfo where username=@username
		if @user <> @username
			select @e=1,@msg='���û�������, ��ע�ᡣ'	--��ֹSQLע��
		if @passwd <> @passwd0
			select @e=2,@msg='�������'
		if @status = 1
			select @e=3,@msg='�˺��ѱ����á�'
		if @status = 2
			select @e=4,@msg='�����ѹ��ڣ��������������롣'
	end
	else
		select @e=1,@msg='���û������ڡ�'
	insert into @Table_Var(e,msg,userID,username,name,hostName,newCourse) values(@e,@msg,@userID,@username,@name,@hostName,@newCourse)
	RETURN
END
GO

-- CREATE DATE: 2020-05-01
-- ��¼��0. �ɹ� 1. not found 2. passwd error 3.diabled 4.expired
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
	select @e=0,@msg='��¼�ɹ�',@userID=0,@realName=''
	select @hostName=hostName,@hostKind=kindID from hostInfo where hostNo=@host
	
	if exists(select 1 from userInfo where userNo=@username and (host='' or host=@host))
	begin
		select @userID=userID,@userNo=userNo,@user=userName,@realName=realName,@passwd0=password,@status=status,@deptID=deptID from userInfo where userNo=@username and (host='' or host=@host)
		if @userNo <> @username
			select @e=1,@msg='���û������ڡ�'	--��ֹSQLע��
		if @password <> @passwd0
			select @e=2,@msg='�������'
		if @status = 1
			select @e=3,@msg='�˺��ѱ����á�'
		if @status = 2
			select @e=4,@msg='�����ѹ��ڣ��������������롣'
		select @teacher=dbo.userHasRole(@user,'teacher')
	end
	else
		select @e=1,@msg='���û������ڡ�'
	insert into @Table_Var(e,msg,userID,username,realName,hostName,hostKind,deptID,teacher) values(@e,@msg,@userID,iif(@user='samra.','amra.',@user),@realName,@hostName,@hostKind,@deptID,@teacher)
	RETURN
END
GO

-- CREATE DATE: 2020-05-08
-- ��ȡѧԱ��ѡ֤����Ŀ
-- status:0 ׼��  1 ѧϰ��  2 ����
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
-- ��ȡѧԱ��ѡ֤����Ŀ��ȥ����ѡ��Ŀ��������˾ר����Ŀ��
-- status:0 ׼��  1 ѧϰ��  2 ����
-- ��ȡ��֤���ڹ���ǰ60�첻����ѡ
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

	if @kindID=0	--ϵͳ��Ա��
	begin
		INSERT INTO @tab
		SELECT * FROM
		(
			SELECT a.ID,a.certID,a.certName,0 as mark,a.reexamine from v_certificateInfo a, projectInfo b where a.certID=b.certID and b.host=@host and b.status=1 and (dbo.pf_inStrArray(b.dept,',',@deptID)=1 or @deptID='') 	--�ѿ����ⲿ��֤��Ŀ
			union
			SELECT ID,certID,certName,0 as mark,reexamine from v_certificateInfo where host=@host and status=0 and kindID=0 and type=1 and (mark=0 or mark=1)	--�����ڲ���֤��Ŀ��������
			union
			SELECT a.ID,a.certID,a.certName,0,a.reexamine from v_certificateInfo a, studentInfo b where a.status=0 and a.kindID=1 and b.username=@username and a.host=b.host and (a.mark=0 or a.mark=1)	--������֤��Ŀ��ר����
		) x where certID not in (select certID from v_studentCertList where username=@username and status<2 and diplomaID='' union select certID from v_diplomaInfo where username=@username and status=0 and datediff(d,getDate(),endDate)>180)
		union
		SELECT * FROM
		(
			select ID,courseID,courseName,1 as mark,re from v_courseInfo where status=0 and kindID=0 and certID='' and (mark=0 or mark=1)	--���з���֤��Ŀ��������
			union
			SELECT a.ID,a.courseID,a.courseName,1,a.re from v_courseInfo a, studentInfo b where a.status=0 and a.kindID=1 and a.certID='' and b.username=@username and a.host=b.host and (a.mark=0 or a.mark=1)	--���з���֤��Ŀ��ר����
		) y where courseID not in (select courseID from v_studentCourseList where username=@username and status<2)
	end
	else	--ϵͳ��Ա��
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
			delete from @tab where certID='C5'	--���ó���60��
		else
			if @c555=0
				update @tab set certName=certName + '(����60��Ĳ��ô��½����๤��)' where certID='C5'	--����60���Ҳ���Ԥ����Χ�ĸ�����ʾ
	end
	RETURN
END
GO

-- CREATE DATE: 2020-05-08
-- ��ȡĳ����֤��Ŀ�����пγ��б�
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
-- ��ȡĳ��ѧԱ��ѡ��֤��Ŀ�����пγ��б�
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
-- ��ȡĳ��ѧԱ�����пγ��б�
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
-- ��ȡѧԱĳ���γ̵Ŀν��б�
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
-- ��ȡѧԱĳ���γ̵Ŀν��б�
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
-- ��ȡѧԱĳ���γ̵Ŀν���Ϣ
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
-- ��ȡʯ����˾һ�������б�
-- USE CASE: select * from dbo.[getDept1List](1)
CREATE FUNCTION [dbo].[getDept1List]()
RETURNS TABLE 
AS
RETURN 
(
	select top 100 percent * from (select deptID,deptName from deptInfo where host='spc' and kindID=0 and pID=8 and dept_status=0 union select 99,'ϵͳ�ⵥλ') a order by deptID 
)
GO

-- CREATE DATE: 2020-05-08
-- ��ȡһ�������б�
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
-- ��ȡѧԱĳ���νڵ���Ƶ
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
-- ��ȡѧԱĳ���νڵ���Ƶ
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
-- ��ȡĳ����ʦ�Ŀγ���Ŀ
-- @username: ��ĳ��demoѧԱ������
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
--���ݸ�����ѧԱ֤����Ŀ����������ɶ�
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
--���ݸ�����ѧԱ֤����Ŀ���������Ƿ������˿�
--��������һ�����ޣ�����ɿ�ʱ���ȴﵽһ��ֵ�����Ѹ��ѣ�����ֱ��ɾ��
--0 ���� 1 ������
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
--���ݸ�����ѧԱ�νڣ���������ɶ�
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
--���ݸ�����ѧԱ�γ̣���������ɶ�
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
--���ݸ�����ѧԱ�γ�ID��������ģ�⿼���Ծ�ID
--���ҿγ����֤��Ŀ��ԣ����û�����ҿγ̱���Ŀ��ԡ�
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
		select @re = @re + '{"paperID":' + cast(@p as varchar) + ',"item":"' + @item + '","examScore":"' + cast(@score as varchar) + '��","pkind":0, "examID":""},'
		select @i=@i+1
		fetch next from rc into @p,@item,@score
	End
	Close rc 
	Deallocate rc
	
	if @i > 0
	begin
		-- ��Ӵ��⼯
		select @re = @re + '{"paperID":' + cast(@enterID as varchar) + ',"item":"���⼯","examScore":"' + cast(count(*) as varchar) + '��","pkind":1, "examID":""},' from studentQuestionWrong where enterID=@enterID

		-- ��������
		declare @courseID varchar(50), @certID varchar(50), @pp varchar(50), @kindID int, @qty1 varchar(50), @qty2 varchar(50), @qty3 varchar(50)
		select @courseID=a.courseID, @certID=b.certID from studentCourseList a, courseInfo b where a.courseID=b.courseID and a.ID=@enterID
		declare rc cursor for select cast(count(*) as varchar), isnull(sum(iif(a.kindID=1,1,0)),0), isnull(sum(iif(a.kindID=2,1,0)),0), isnull(sum(iif(a.kindID=3,1,0)),0), d.examID, d.kindID from questionInfo a, (select distinct knowPointID, b.examID, b.kindID from examInfo b, examRuleInfo c where b.examID=c.examID and b.courseID=@courseID) d 
			where a.knowPointID=d.knowPointID and a.status=0
			group by d.examID, d.kindID
		open rc
		fetch next from rc into @pp,@qty1,@qty2,@qty3,@item,@kindID
		While @@fetch_status=0 
		Begin 
			select @re = @re + '{"paperID":' + cast(@enterID as varchar) + ',"item":"' + iif(@kindID=0,'Ӧ֪','Ӧ��') + '�����","examScore":"' + @pp + '��","pkind":2, "examID":"' + @item + '","qty1":' + @qty1 + ',"qty2":' + @qty2 + ',"qty3":' + @qty3 + '},'
			fetch next from rc into @pp,@qty1,@qty2,@qty3,@item,@kindID
		End
		Close rc 
		Deallocate rc

		-- ����ղؼ�
		select @re = @re + '{"paperID":' + cast(@enterID as varchar) + ',"item":"�ղؼ�","examScore":"' + cast(count(*) as varchar) + '��","pkind":3, "examID":""},' from studentQuestionMark where enterID=@enterID

		-- ����½���ϰ
		if exists(select top 1 1 from questionInfo a, (select distinct knowPointID, b.examID, b.kindID from examInfo b, examRuleInfo c where b.examID=c.examID and b.courseID=@courseID) d where a.knowPointID=d.knowPointID and a.status=0 and a.chapterID>0)
		begin
			select @re = @re + '{"paperID":' + cast(@enterID as varchar) + ',"item":"�½���ϰ","examScore":"' + cast(count(*) as varchar) + '��","pkind":4, "examID":"","list":[' from questionInfo a, (select distinct knowPointID, b.examID, b.kindID from examInfo b, examRuleInfo c where b.examID=c.examID and b.courseID=@courseID) d where a.knowPointID=d.knowPointID and a.status=0 and a.chapterID>0
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
--���ݸ�����ѧԱ�γ�ID��������γ̰����İ�����Ƶ
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
-- ��ȡ������Ϣ  pkind:0 ģ��/��ʽ����  1 ���⼯  2 �����  3 �ղؼ�  4 �½���ϰ
-- USE CASE: exec getStudentExamInfo
-- =============================================
ALTER PROCEDURE [dbo].[getStudentExamInfo] 
	@paperID int, @pkind int, @examID varchar(50), @username varchar(50), @kind int
AS
BEGIN
	declare @answerQty int
	declare @num int, @n int
	select @n = 0, @num=0
	--ģ��/��ʽ����
	if @pkind = 0
	begin
		select @answerQty=count(*) from studentQuestionList where refID=@paperID and myAnswer is not null
		select *,dbo.getOnlineExamStatus(paperID) as startExamMsg, 0 as pkind, @examID as examID, 0 as lastNum, @username as username,[dbo].[getExamQuestionQty](examID) as questionQty,@answerQty as answerQty, [dbo].[getMockAllow](iif(kind=0,refID,0)) as allowMockMsg, @kind as kind1 from v_studentExamList where paperID=@paperID
	end
	--���⼯
	if @pkind = 1
	begin
		select @n=count(*) from v_studentQuestionWrong where enterID=@paperID
		select @paperID as paperID, 0 as status, '' as missingItems, 0 as kind, 0 as kindID, 0 as mark, 0 as score, 1 as pkind, '' as startExamMsg, @examID as examID, 0 as lastNum, @username as username, @n as questionQty, 0 as answerQty, '' as allowMockMsg, @kind as kind1
	end
	--�����
	if @pkind = 2
	begin
		select @num = num from studentTotalExamPlace where username=@username and examID=@examID and kind=@kind
		select @n=count(*) from questionInfo where [knowPointID] in(select [knowPointID] from examRuleInfo where examID=@examID) and status=0 and kindID=@kind
		--��ֹ�����Ŀ����������Ŀ����
		select @num=iif(@num>=@n-1,@n-1,@num)
		select @paperID as paperID, 0 as status, '' as missingItems, 0 as kind, 0 as kindID, 0 as mark, 0 as score, 2 as pkind, '' as startExamMsg, @examID as examID, isnull(@num,0) as lastNum, @username as username, @n as questionQty, 0 as answerQty, '' as allowMockMsg, @kind as kind1
	end
	--�ղؼ�
	if @pkind = 3
	begin
		select @num = num from studentTotalExamPlace where examID=@paperID and kind=4
		select @n=count(*) from [dbo].[studentQuestionMark] where enterID=@paperID
		select @paperID as paperID, 0 as status, '' as missingItems, 0 as kind, 0 as kindID, 0 as mark, 0 as score, 3 as pkind, '' as startExamMsg, @examID as examID, isnull(@num,0) as lastNum, @username as username, @n as questionQty, 0 as answerQty, '' as allowMockMsg, @kind as kind1
	end
	--�½���ϰ
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
-- ��ȡָ��kind���ֵ��б�
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
--����ѧԱ����Ϣ����
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
--����ѧԱδ��ɿγ�����
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
--����ѧԱĳ��֤����Ŀ������֤����
ALTER FUNCTION [dbo].[getStudentLastDiplomaByCertID](@username varchar(50),@certID varchar(50))
RETURNS varchar(50)
AS
BEGIN
	declare @re varchar(50)
	select @re = ''
	select top 1 @re = diplomaID from diplomaInfo where username=@username and certID=@certID order by ID desc
	return @re
END

-- ��ָ�����ŷָ��ַ��������طָ���Ԫ�ظ���
-- �����ܼ򵥣����ǿ��ַ����д��ڶ��ٸ��ָ����ţ�Ȼ���ټ�һ������Ҫ��Ľ����
ALTER function [dbo].[pf_getStrArrayLength]
(
	@str varchar(5000),  --Ҫ�ָ���ַ���
	@split varchar(10)  --�ָ�����
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

-- ��ָ�����ŷָ��ַ��������طָ��ָ�������ĵڼ���Ԫ�أ�������һ������
ALTER function [dbo].[pf_getStrArrayOfIndex]
(
	@str varchar(5000),  --Ҫ�ָ���ַ���
	@split varchar(10),  --�ָ�����
	@index int --ȡ�ڼ���Ԫ��,��0��ʼ
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

	--�����һ���ַ����Ƿָ���������ɾ��
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

	--����������������1���ַ��������ڷָ����� 2���ַ����д��ڷָ����ţ�����whileѭ����@locationΪ0����Ĭ��Ϊ�ַ��������һ���ָ����š�
	return substring(@str,@start,@location-@start)
end


-- CREATE DATE: 2014-07-27
-- Description:	�����û�����ѯ�Ƿ���ָ����Ȩ�ޣ��������0��ʾû�и�Ȩ�ޣ�����0��ʾ��Ȩ��
-- Use case: select dbo.userHasPermission('desk1','store|formula')
-- UPDATE: 2017-05-28 @permissionID֧�ֶ��Ȩ����ɵ��ַ�������|�ָ�����
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
		-- �����û������н�ɫ������Ȩ��
		select @k1=@k1+isnull(count(*),0) from v_userRolePermissionList where username=@userID and permissionID=@p
		-- �����û�ֱ�ӷ����Ȩ��
		select @k2=@k2+isnull(count(*),0) from userPermissionList a,permissionInfo b where a.permissionID=b.permissionID and a.username=@userID and a.permissionID=@p and a.status=0
		-- ������Ȩ�õ���Ȩ��
		select @k3=@k3+isnull(count(*),0) from grantInfo a,permissionInfo b where a.grantItem=b.permissionID and a.userID=@userID and grantItem=@p and a.status=0 and a.kind='permission'
		set @i = @i + 1
	end
	set @Result = @k1 + @k2 + @k3
	-- ���Ҫ��Ȩ��Ϊ�գ����κ��˶���Ȩ�ޡ�
	if @permissionID = ''
		set @Result = 1
	RETURN @Result
END

-- CREATE DATE: 2017-09-30
-- Description:	�����û�����ѯ�Ƿ���ָ���Ľ�ɫ���������0��ʾû�У�����0��ʾ��
-- Use case: select dbo.userHasRole('desk1','store|formula')
-- UPDATE: 2017-05-28 @roleID֧�ֶ��Ȩ����ɵ��ַ�������|�ָ�����
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
		-- �����û������н�ɫ
		select @k1=@k1+isnull(count(*),0) from roleUserList where username=@userID and roleID=@p
		set @i = @i + 1
	end
	set @Result = @k1
	RETURN @Result
END

-- CREATE DATE: 2014-10-17
-- ���ݸ������û�������������Ȩ��
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
		-- ֱ�ӷ�����û���Ȩ��
		select a.permissionID,b.permissionName,isnull(b.description,'') from userPermissionList a, permissionInfo b where a.permissionID=b.permissionID and a.userName=@userName and a.host=b.host and a.status=0
		-- �ɽ�ɫ������û���Ȩ��
		union
		select a.permissionID,b.permissionName,isnull(b.description,'') from rolePermissionList a, permissionInfo b, roleUserList c where a.permissionID=b.permissionID and a.host=b.host and a.roleID=c.roleID and a.host=c.host and c.userName=@userName and a.status=0
		-- ������Ȩ���û���Ȩ��
		union
		select a.grantItem,b.permissionName,isnull(b.description,'') from grantInfo a, permissionInfo b where a.grantItem=b.permissionID and a.grantMan=@userName and a.host=b.host and a.status=0
	RETURN
END

GO

-- CREATE DATE: 2014-10-17
-- ���ݸ������û��Ϳγ̣���������Ƿȱ�Ĳ���
-- mark:0 ��֤��Ŀ  1 ��ѵ��Ŀ
-- step:���׶� 0 ѡ��ǰ  1 ����ǰ  2 ��֤��ǰ
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
			select @status = @status + 1, @msg = @msg + '��������(����վ), '
	end
	if @host='znxf'
	begin
		if @unit is null or @unit = ''
			select @status = @status + 1, @msg = @msg + '��λ����, '
		--if @dept is null or @dept = ''
		--	select @status = @status + 1, @msg = @msg + '����, '
	end
	if @job is null or @job = ''
		select @status = @status + 1, @msg = @msg + '��λ, '

	if @msg > ''
		set @msg = '�����ύ���ϣ�' + left(@msg,len(@msg)-1)
	insert into @Table_Var(status,msg) values(@status,@msg)
	RETURN
END
GO

-- CREATE DATE: 2015-04-06
-- ���ݸ������û���������û�е�Ȩ��
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
	-- ���г�����Ȩ��
	--1.��ͨȨ��
	insert into @Table_Var
		select permissionID,permissionName,isnull(description,'') from permissionInfo where host=@host and status=0
	-- ɾ���ѷ�����û���Ȩ��
		update @Table_Var set permissionID='' from @Table_Var a, (select permissionID from dbo.getPermissionListByUser(@userName)) b where a.permissionID=b.permissionID
		delete from @Table_Var where permissionID=''

	RETURN
END

GO

-- ���ݸ��ڵ�ID��ȡ����tree����
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

-- ���ݸ��ڵ�ID��ȡ����tree����
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
--���ݸ����������ƣ����ز��Ŵ���
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
--���ݸ�����䣬ȷ��where������ƴ���ַ�������and��ʽ��
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
--���ݸ�����䣬ȷ��group������ƴ���ַ�������,��ʽ��
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
--���ݸ�����䣬ȷ��order by������ƴ���ַ�������,��ʽ��
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
--���ݸ���ѧԱ�Ŀγ̣�ȷ����ͨ������
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
			select @re='���¿��Ժϸ�'
		else
			select @re='���Գɼ���' + @c + '��'
	end
	else
		select @re= '����ʴ�' + @c + '%'

	return @re
END
GO

-- Create date: 2014-08-10
-- Last Update: 2015-04-10
-- Description:	���ݸ�����ִ���͡����ñ�ʶ���û����Ʋ�ѯ��ִ����
-- ���@userID=''����ʾ��ѯ���н����˻�ִ����
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
-- Description:	���ݸ������͡����ñ�ʶ, ��ѯ���Ķ�����
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
-- Description:	���ݸ�������֪ͨ���, ��ѯ�ѱ�������ȷ������
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
-- Description:	���ݸ�������֪ͨ���, ��ѯ���ϸ�ͼƬ֪ͨ����
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
-- Description:	���ݸ�������֪ͨ���, ��ѯ���ύ����
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
--���ݸ������������ظ���·��
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

-- ��ָ�����ŷָ��ַ������жϸ������ַ��Ƿ������棬�������Ϊ�ջ���Ŀ���ַ���������1������0
CREATE function [dbo].[pf_inStrArray]
(
	@str varchar(5000),  --Ҫ�ָ���ַ���
	@split varchar(10),  --�ָ�����
	@f varchar(500) --Ҫ���ҵ��ַ���
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

-- �ж�ָ��ѧԱ�Ƿ�Ϊĳ������������ˣ��Ƿ���1������0
CREATE function [dbo].[isStudentInProject]
(
	@stu varchar(50),  --ѧԱ���֤
	@projectID varchar(50) --Ҫ���ҵ����κ�
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

-- ����ָ���γ̵ķ���
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

-- ����ָ�����εķ���
-- �����sales����ȡcoursePrice�й涨�ļ۸� 
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

-- ����ָ����λ�Ŀγ�
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

-- ����ָ����ʦ��ѡ�Ŀγ�
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
-- ��ȡѧԱ��ѡ������Ŀ��ȥ����ѡ��Ŀ��
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

	if @kindID=0	--ϵͳ��Ա��
	begin
		INSERT INTO @tab
		SELECT projectID,projectName FROM
		(
			SELECT projectID,projectName,a.certID from v_certificateInfo a, projectInfo b where a.certID=b.certID and b.host=@host and b.status=1 and (dbo.pf_inStrArray(b.dept,',',@deptID)=1 or @deptID=0) 	
			--�ѿ����ⲿ��֤��Ŀ
		) x where certID not in (select certID from v_studentCertList where username=@username and status<2 union select certID from diplomaInfo where username=@username and status=0 and datediff(d,getDate(),endDate)>180) 
		--�и���Ŀδѧ��ı������и���Ŀ��֤90����δ���ڵĽ���ֹ����
	end
	else	--ϵͳ��Ա������ѡ���б���˾�ⲿ��Ч��Ŀ
	begin
		INSERT INTO @tab
		SELECT projectID,projectName FROM
		(
			SELECT projectID,projectName,a.certID from v_certificateInfo a, projectInfo b where a.certID=b.certID and b.host=@host and b.status=1 and @deptID>0 	
			--�ѿ����ⲿ��֤��Ŀ
		) x where certID not in (select certID from v_studentCertList where username=@username and status<2 union select certID from diplomaInfo where username=@username and status=0 and datediff(d,getDate(),endDate)>180) 
		--�и���Ŀδѧ��ı������и���Ŀ��֤90����δ���ڵĽ���ֹ����
	end

	RETURN
END
GO

-- CREATE DATE: 2020-05-08
-- ��ȡѧԱ��ѡ������Ŀ��ȥ����ѡ��Ŀ��
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
-- ��ȡѧԱ�ο�����\�绰
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
-- ����Ԥ����������ж���ѡ�γ��Ƿ�����ֻ��C1,C16,C17���߼�У�顣
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
-- ����Ԥ����������ж���ѡ�γ��Ƿ�����ֻ��C1,C16,C17���߼�У�顣
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
-- ��ȡ������Ŀ����ѧԱ�ο����е����
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
-- ��ȡ�����������Ӧ��ѧԱ��֪
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
--���ݸ������������ر�����ȱʧ����Ŀ
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
			--����Ա��Ҫ�ṩ����֤��
			declare @kind6 int, @kind12 int
			--select @kind6=kind6,@kind12=kind12 from firemanEnterInfo where enterID=@enterID
			--select @missingItems = @missingItems + (case when photo_filename='' then ',��Ƭ' else '' end)
			--	 + (case when IDa_filename='' then ',���֤����' else '' end)
			--	 + (case when IDb_filename='' then ',���֤����' else '' end)
				 --+ (case when edu_filename='' then ',ѧ��֤��' else '' end)
				 --+ (case when CHESICC_filename='' and @kind12<4 then ',ѧ������ͼ' else '' end)	--��ר������Ҫѧ����֤��
				 --+ (case when employe_filename='' then ',����֤��' else '' end)
				 --+ (case when job_filename='' and @kind6=1 then ',ְҵ�ʸ�֤��' else '' end)
			--	from v_studentInfo where username=@username

		end
		else
		begin
			if @education=0
				select @missingItems = @missingItems + ',ѧ��'
			--if @phone='' or @phone is null
			--	select @missingItems = @missingItems + ',��λ�绰'
			--if @address='' or @address is null
			--	select @missingItems = @missingItems + ',��λ��ַ'
			if @job='' or @job is null
				select @missingItems = @missingItems + ',������λ'
			--if @host='znxf' and (@dept='' or @dept is null)
			--	select @missingItems = @missingItems + ',��������'
			--����֤��
			--if @reexamine=1 and (@currDiplomaID='' or @currDiplomaID is null)	
				--select @missingItems = @missingItems + ', ' + @courseName + '֤����'
		end

		if @mobile='' or @mobile is null
			select @missingItems = @missingItems + ',�ֻ�����'
		--if @host='znxf' and (@unit='' or @unit is null)
			--select @missingItems = @missingItems + ',��λ����'

		if @missingItems > ''
			select @missingItems = right(@missingItems,len(@missingItems)-1)
	end

	if @projectID = '' and @certID in('C3','C4','C5','C6','C7','C8')
	begin
		if @job='' or @job is null
			select @missingItems = @missingItems + ',������λ'
	end

	return isnull(@missingItems,'')
END
GO

--CREATE Date:2020-11-13
--���ݸ������������ر�����ȱʧ����Ŀ
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
--���ݸ������֤����ȡ��ȱʧ�ĸ�ѵ�������е�֤����
ALTER FUNCTION [dbo].[getReexamineDiploma](@username varchar(50))
RETURNS @tab TABLE (enterID int,item varchar(100))
AS
BEGIN
	--δ�����Ŀγ̡���ѵ��û����д֤����
	insert into @tab
	select ID,'�μӸ����'+courseName+'֤����' from v_studentCourseList where username=@username and reexamine=1 and currDiplomaID='' and status<2
	return
END
GO

--CREATE Date:2021-07-18
--���ݸ��༶����ȡ�˷�����
CREATE FUNCTION [dbo].[getRefundListByClass](@classID varchar(50),@price int)
RETURNS TABLE 
AS
RETURN 
(
	select row_number() over(order by dept2Name) as ID,(case when dept2Name>'' then dept2Name else dept1Name end) as deptName,username,name,@price as price from v_studentCourseList where classID=@classID
)
GO

--CREATE Date:2020-11-13
--���ݸ��༶����ȡ����
--@row: ���ҷ�����ʱÿҳ��������@top ��ͷ���� ��һҳ�б�ͷ������ҳû�С�@row=0 ������
ALTER FUNCTION [dbo].[getStudentListInClass](@classID varchar(50),@row int,@top int)
RETURNS @tab TABLE (ID int,SNo varchar(50),name varchar(50),ID1 varchar(50),SNo1 varchar(50),name1 varchar(50))
AS
BEGIN
	if @row=0
		insert into @tab select row_number() over(order by SNo) as ID,SNo,name,0,'','' from v_studentCourseList where classID=@classID
	else
	begin
		--����������
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
--���ݸ����ڣ�����ָ����ʽ
--@mark: 0 ������
CREATE FUNCTION [dbo].[fn_formatDate](@date varchar(20),@mark int)
RETURNS varchar(50)
AS
BEGIN
	declare @re varchar(50)
	if @mark=0
		select @re=left(@date,4) + '��' + substring(@date,6,2) + '��' + right(@date,2) + '��'
	return isnull(@re,'')
END
GO

--CREATE Date:2021-07-10
--���ݸ���������������ӵ�еİ༶�б�
--��˾�����ţ���Ŀ
ALTER FUNCTION [dbo].[getClassListByDept](
	@host varchar(50), @deptID varchar(50), @certID varchar(50)
)
RETURNS @tab TABLE (classID varchar(50),className varchar(50),statusName varchar(50),qty int)
AS
BEGIN
	declare @sql nvarchar(2000), @s varchar(500)
	if @certID > ''
	begin
		if @deptID > '0'	--�в��ŵģ����ղ��Ų�ѯ
			insert into @tab select classID,className,statusName,qty from v_classInfo where certID=@certID and ID in(select classID from ref_student_spc where dept1=@deptID  group by classID)
		else	-- û�в��ţ����չ�˾��ѯ
			insert into @tab select classID,className,statusName,qty from v_classInfo where certID=@certID and ID in(select a.classID from ref_student_spc a, deptInfo b where a.dept1=b.deptID and b.host=@host group by a.classID)
	end
	else
	begin
		if @deptID > '0'	--�в��ŵģ����ղ��Ų�ѯ
			insert into @tab select classID,className,statusName,qty from v_classInfo where ID in(select classID from ref_student_spc where dept1=@deptID  group by classID)
		else	-- û�в��ţ����չ�˾��ѯ
			insert into @tab select classID,className,statusName,qty from v_classInfo where ID in(select a.classID from ref_student_spc a, deptInfo b where a.dept1=b.deptID and b.host=@host group by a.classID)
	end
	
	return
END
GO

--CREATE Date:2021-07-10
--���ݸ���������������ӵ�е������б�
--��˾�����ţ���Ŀ
ALTER FUNCTION [dbo].[getProjectListByDept](
	@host varchar(50), @deptID varchar(50), @certID varchar(50)
)
RETURNS @tab TABLE (projectID varchar(50),projectName varchar(50),status int,statusName varchar(50))
AS
BEGIN
	declare @sql nvarchar(2000), @s varchar(500)
	if @certID > ''
	begin
		if @deptID > '0'	--�в��ŵģ����ղ��Ų�ѯ
			insert into @tab select projectID,projectName,status,statusName from v_projectInfo where host=@host and certID=@certID and status>0 and (dept='' or [dbo].[pf_inStrArray](dept,',',@deptID)=1) and hide=0
		else	-- û�в��ţ����չ�˾��ѯ
			insert into @tab select projectID,projectName,status,statusName from v_projectInfo where host=@host and certID=@certID and status>0 and hide=0
	end
	else
	begin
		if @deptID > '0'	--�в��ŵģ����ղ��Ų�ѯ
			insert into @tab select projectID,projectName,status,statusName from v_projectInfo where host=@host and status>0 and (dept='' or [dbo].[pf_inStrArray](dept,',',@deptID)=1) and hide=0
		else	-- û�в��ţ����չ�˾��ѯ
			insert into @tab select projectID,projectName,status,statusName from v_projectInfo where host=@host and status>0 and hide=0
	end
	
	return
END
GO

--��ȡ�༶������Ԥ��������(mark:0)+��������(mark:1)��Ԥ�������������Ƿ�ʵ�ʱ���(submited:0/1)
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

--��ȡĳ����˾�μӵ���Ŀ�б�
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

--��ȡĳ��ѧԱ��������Ŀ�б�
ALTER FUNCTION getExamListByUsername
(	
	@username varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	--���߿���
	select a.paperID,b.kindID,'����' as kindName,a.status,a.statusName,b.certName,b.startDate,a.minutes,b.endDate,b.address,c.username,d.name from v_studentExamList a, v_passcardInfo b, studentCourseList c, studentInfo d where a.refID=b.ID and b.enterID=c.ID and c.username=d.username and b.kindID=1 and b.startDate>=convert(varchar(20),getDate(),23) and b.passNo>'' and b.username=@username

	--ѧУ���¿���
	union
	select 0,0,'����',0,'׼��',b.certName,b.startDate,0,b.endDate,b.address,c.username,d.name from v_passcardInfo b, studentCourseList c, studentInfo d where b.enterID=c.ID and c.username=d.username and b.kindID=0 and b.startDate>=convert(varchar(20),getDate(),23) and b.passNo>'' and b.username=@username

	--���������¿���
	union
	select 0,0,'����',0,'׼��',b.courseName,b.examDate,0,'',b.address,c.username,d.name from v_applyInfo b, studentCourseList c, studentInfo d where b.enterID=c.ID and c.username=d.username and b.examDate>=convert(varchar(20),getDate(),23) and b.username=@username
)
GO

--�ж�ĳ�����Ͽ��Ե�״̬
ALTER FUNCTION getOnlineExamStatus
(	
	@examID int
)
RETURNS varchar(100) 
AS
BEGIN
	declare @re varchar(100)
	--���߿���
	if exists(select 1 from studentExamList where paperID=@examID and kind=1)
	begin
		select @re = ''
		--������Ƿ񵽴￪��ʱ��
		if exists(select 1 from v_passcardInfo a, studentExamList b where a.ID=b.refID and b.paperID=@examID and a.startDate>convert(varchar(16),getDate(),20))
			select @re='������δ��ʼ��'
		--������Ƿ񵽴����ʱ��(δ��¼����
		if @re = '' and exists(select 1 from v_passcardInfo a, studentExamList b where a.ID=b.refID and b.paperID=@examID and a.endDate<convert(varchar(16),getDate(),20) and b.status=0)
			select @re='�����ѽ�����'
	end
	return isnull(@re,'')
END
GO

--��ȡĳ��������ذ༶�б�
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
--���ݸ������������ؿ��ý�ʦ���б�
--freePoint: �������������ڿ���ʱ��ٷֱ�
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
		select @host=''	--dingʹ����������ѧУ����Դ

	--�����������ʸ�Ľ�ʦ
	insert into @tab(teacherID,teacherName,freePoint) select teacherID,teacherName,@days from v_courseTeacherList a, courseInfo b where a.courseID=b.certID and a.host=@host and b.courseID=@courseID
	--����������ſ�����
	--update @tab set freePoint=freePoint-isnull(c.days,0) from @tab d left outer join (select teacher,count(*) as days from classSchedule a, @tab b where a.teacher=b.teacherID and a.online=0 and a.theDate between @startDate and @endDate group by a.teacher,a.theDate) c on d.teacherID=c.teacher
	--update @tab set freePoint=(case when @days>0 then freePoint*100/@days else 100 end)
	--delete from @tab where freePoint=0

	return
END
GO

-- CREATE DATE: 2020-05-08
-- ��ȡĳ������ĳ���༶��Ľ�����Ϣ�б�ѧԱ����ʦ��
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
		select ID,username,title,classID,item,readerID,'',refID,type,regDate,0 from v_studentFeedbackInfo where username=@username and classID=@classID	--�Լ��ķ���
		union 
		select ID,username,title,classID,item,readerID,'',refID,type,regDate,0 from v_studentFeedbackInfo where readerID=@username and classID=@classID	--���͸��Լ��ķ���

	if @type = 0	--student
		insert into @tab
			select ID,username,title,classID,item,readerID,'',refID,type,regDate,0 from v_studentFeedbackInfo where classID=@classID and type=1 and readerID=''	--��ʦ�������˵ķ���
	else	--teacher
		insert into @tab
			select ID,username,title,classID,item,readerID,'',refID,type,regDate,0 from v_studentFeedbackInfo where classID=@classID and type=0	--����ѧ���ķ���
			union 
			select ID,username,title,classID,item,readerID,'',refID,type,regDate,0 from v_studentFeedbackInfo where username<>@username and classID=@classID and type=1	--������ʦ�ķ���
	
	--�Լ��ķ��Ա��Ϊ'��'
	update @tab set title='��' where username=@username
	--���ĳ��ѧ���ķ��Ա��'@'
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
-- ���ݸ����Ĳ���������ѧԱ���룬��д��־
-- return:0 �ɹ�  1 �û�������  2 �û�����  3 �������  9 ����
-- USE CASE: exec updateStudentPassword 1,'xxxx'...
ALTER PROCEDURE [dbo].[updateStudentPassword]
	@username varchar(50),@password varchar(50),@mobile varchar(50),@host varchar(50),@ip varchar(50),@registerID varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @logMemo varchar(500),@event varchar(50),@re int
	select @logMemo = '',@event='�޸�����', @re=0	--0 success

	if exists(select 1 from studentInfo where username=@username)	-- �¼�¼
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
	-- д������־
	if @re = 0
		exec writeOpLog @host,@event,'student',@registerID,@username,@username
	return @re
END

-- =============================================
-- CREATE DATE: 2020-05-04
-- ��¼ѧԱ��¼��Ϣ
-- student:0 ѧԱ  1 �û�
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
-- ��¼ѧԱ�ǳ���Ϣ
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
-- ���ݸ����Ĳ�������ӻ��߸����û����ݣ���д��־
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
		set @ethnicity = '��'
	if @fromID>''
		select @fromKind=kindID from unitInfo where saler=@fromID and unitName=@unit

	if @mark=0	-- �¼�¼
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
			select @event = '����'
			exec writeEventTrace @host,@registerID,'user',@username,0,'�Ǽ�',@username
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
			--������˾���޸�host
			--if(@companyID0<>@companyID)
			if(@companyID>0 and (@host='znxf' or @host='spc'))
				select @host=host from deptInfo where deptID=@companyID

			--������������룬���������룬���򱣳�ԭ������.
			insert into [log_update_studentInfo] select *,@registerID,getDate() from studentInfo where username=@username
			update studentInfo set kindID=@kindID,password=(case when @password>'' then @password else password end),companyID=@companyID,host=@host,dept1=@dept1,dept2=@dept2,dept3=@dept3,job=@job,job_status=@job_status,name=@name,mobile=@mobile,phone=@phone,email=@email,address=@address,limitDate=@limitDate,education=@education,unit=@unit,tax=@tax,dept=@dept,@linker=(case when @linker>'' then @linker else linker end)
			,ethnicity=(case when @ethnicity='' then ethnicity else @ethnicity end),IDaddress=(case when @IDaddress='' then IDaddress else @IDaddress end),bureau=(case when @bureau='' then bureau else @bureau end),IDdateStart=(case when @IDdateStart is null then IDdateStart else @IDdateStart end),IDdateEnd=(case when @IDdateStart is not null then @IDdateEnd else IDdateEnd end),experience=@experience,fromID=@fromID,fromKind=@fromKind,memo=@memo where username=@username
			select @event = '�޸�'
			--�����ϵͳ�ڱ��Ϊϵͳ�⣬����Ƿ��Ѿ�ѡ����Щϵͳ�ڿγ�(�ǵ������γ�)���������ɾ��
			if @kindID=1 and @kindID0=0 and exists(select 1 from v_studentCourseList where username=@username and mark=1)
			begin
				delete from studentCourseList where ID in(select ID from v_studentCourseList where username=@username and mark=1 and type=1)
				delete from studentCertList where ID in(select ID from v_studentCertList where username=@username and mark=1 and type=1)
			end
			--��������˹�˾������ڵı�����֤��ҲҪ�޸�
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
		-- ����ϵͳ�ⵥλ��Ϣ��������Ƿ���������λ
		if @kindID=1 and len(@dept1Name)>3
		begin
			if exists(select 1 from deptInfo where deptName=@dept1Name and dept_status=0 and host=@host)
				select @dept1=deptID from deptInfo where deptName=@dept1Name and dept_status=0 and host=@host
			else
				exec @dept1 = autoAddDept @companyID,@dept1Name,@kindID,@host,@username
			update studentInfo set dept1=@dept1 where username=@username
		end
		-- д������־
		exec writeOpLog @host,@event,'student',@registerID,@username,@username
	end
	return @re
END
GO

-- CREATE DATE: 2021-11-15
-- ���ݸ����Ĳ�����������û����ݣ������֤�û�������д��־
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
			select @event = '����'
			exec writeEventTrace @host,@registerID,'user',@username,0,'�Ǽ�',@username
		end

	if @re = 0
	begin
		-- ����ϵͳ�ⵥλ��Ϣ��������Ƿ���������λ
		if @kindID=1 and len(@dept1Name)>3
		begin
			if exists(select 1 from deptInfo where deptName=@dept1Name and dept_status=0 and host=@host)
				select @dept1=deptID from deptInfo where deptName=@dept1Name and dept_status=0 and host=@host
			else
				exec @dept1 = autoAddDept @companyID,@dept1Name,@kindID,@host,@username
			update studentInfo set dept1=@dept1 where username=@username
		end
		-- д������־
		exec writeOpLog @host,@event,'student',@registerID,@username,@username
	end
	return @re
END

GO


-- =============================================
-- CREATE Date: 2020-05-08
-- Description:	ѧԱѡ�������֤����Ŀ������ӵ����ݿⲢͬʱ�����صĿγ̡�
-- mark: 0 ֤����Ŀ  1 ��ѵ��Ŀ��ֻ�пγ̣�
-- url: subdomain
-- ����֤����Ŀ����ʱ�������ɿγ̡��μ����Ծ��ȱ����ٷ���
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
	--@fromID���û��.��׺�������ȥ��
	select @event='���߱���',@refID=0,@re=0,@host=iif(@url>'',@url,host),@checked=0,@SNo=0,@dept1=dept1,@dept2=dept2,@payNow=0,@title='',@fromID=iif(charindex('.',@fromID)>0,@fromID,iif(@fromID>'',@fromID+'.',@fromID)),@fromKind=fromKind from studentInfo where username=@username
	if @host='spc'
	begin
		if exists(select 1 from deptInfo where deptID=@dept2)
		begin
			select @kind=accountKind, @payNow=payNow, @title=title from deptInfo where deptID=@dept2
			if @kind=2
				select @title=item from dictionaryDoc where kind='SPCtitle'	--�������͵Ĳ��ţ�ѡȡʯ����˾ͳһ��Ʊ��Ϣ
		end
	end
	select @type=type, @fromID=iif(@fromID='arma.','amra.',@fromID) from certificateInfo where certID=@certID
	if @type=0	--��ʯ����Ŀ
	begin
		select top 1 @projectID = projectID,@price=[dbo].[getProjectPrice](projectID,@fromID) from projectInfo where host=@host and status=1 and certID=@certID and reexamine=@reexamine order by projectID desc -- and (dept='' or [dbo].[pf_inStrArray](dept,',',@dept1)=1)
		if @projectID is null
			select @re = 2, @msg = 'û���ҵ����ʵ���Ŀ�����ܱ�����'
	end
	select @courseID=courseID from courseInfo where certID=@certID and reexamine=@reexamine
	--select @classID=classID from classInfo where dbo.pf_inStrArray(projectID,',',@projectID)=1 and status=0

	if @host<>'znxf'	--��˾��Ա�����Ԥ����������Զ�ȷ��
	begin
		if exists(select 1 from ref_student_spc a, projectInfo b where a.projectID=b.projectID and a.username=@username and b.certID=@certID and datediff(d,a.regDate,getDate())<10)
			select @checked = 1,@checkDate=getDate(),@checker='system.',@SNo=a.ID from ref_student_spc a, projectInfo b where a.projectID=b.projectID and a.username=@username and b.certID=@certID and datediff(d,a.regDate,getDate())<60
	end

	if exists(select 1 from certificateInfo where certID=@certID)
		set @mark = 0
	else
		set @mark = 1

	if (@mark=0 and not exists(select 1 from studentCertList where certID=@certID and username=@username and diplomaID is null and status<2)) or (@mark=1 and not exists(select 1 from studentCourseList where courseID=@certID and username=@username and status<2))	--δ�����Ŀγ��Լ���ε�δ��֤���
	begin
		if @mark=0
		begin
			if @reexamine=1 and datediff(d,getDate(),@currDiplomaDate)<3
				select @re = 2, @msg = 'Ӧ��ѵ�����ٽ����޷������걨Ҫ��'
			else
			begin
				select @source=title from hostInfo where hostNo=@host and @host<>'znxf'
				--���֤����Ŀ
				insert into studentCertList(username,certID,reexamine,host,registerID,memo) values(@username,@certID,@reexamine,@host,@username,@url)
				select @refID=max(ID) from studentCertList where registerID=@username and certID=@certID
				select @type=type from v_studentCertList where ID=@refID
				--������λ��ʯ���ڲ���Ŀ����Ϊδ���ѡ��󸶷�
				if @host not in('znxf','spc','shm') or @type=1
					select @payNow = 1
				declare @saler varchar(50)
				exec [setStudentSaler] @username, @fromID, @saler output

				--��ӿγ�  ʯ���ڲ���Ŀ����Ϊ��ǩ��
				insert into studentCourseList(username,courseID,refID,payNow,title,price,type,signatureType,hours,closeDate,projectID,classID,SNo,reexamine,checked,checkDate,checker,currDiplomaID,currDiplomaDate,fromID,fromKind,source,host,registerID) select @username,courseID,@refID,@payNow,@title,@price,@type,iif(@type=1,0,1),hours,dateadd(d,period,getDate()),@projectID,@classID,@SNo,@reexamine,@checked,@checkDate,@checker,@currDiplomaID,@currDiplomaDate,@saler,@fromKind,@source,@host,@username from courseInfo where courseID=@courseID
				select @ID=max(ID) from studentCourseList where refID=@refID

				if @type=1	--��˾�ڲ���Ŀ
				begin
					--��ӿα�
					insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,b.ID,a.hours,@username from lessonInfo a, studentCourseList b where a.courseID=b.courseID and b.ID=@ID and a.status=0
	
					--��ӿμ�
					insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,@username from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0

					--�����Ƶ
					insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,@username from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0

					--��ӿ��ԣ���Ŀ�ݲ�����
					if exists(select 1 from  examInfo where courseID=@courseID)
						insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,mark) select @username,examID,@ID,minutes,minutes*60,scoreTotal,scorePass,kindID,@mark from examInfo where (courseID=@courseID or (courseID is null and certID=@certID)) and status=0 order by ID
					else
						insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,mark) select @username,examID,@ID,minutes,minutes*60,scoreTotal,scorePass,kindID,@mark from examInfo where certID=@certID and status=0 order by ID
				end
			end
		end
	
		if @mark=1
		begin
			--��ӿγ�
			insert into studentCourseList(username,courseID,refID,type,hours,closeDate,projectID,classID,SNo,checked,checkDate,checker,host,registerID) select @username,@certID,@refID,1,hours,dateadd(d,period,getDate()),@projectID,@classID,@SNo,@checked,@checkDate,@checker,@host,@username from courseInfo where courseID=@certID and reexamine=@reexamine
			select @refID=max(ID) from studentCourseList where registerID=@username
			select @ID=@refID

			--��ӿα�
			insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,@refID,hours,@username from lessonInfo where courseID=@certID and status=0
	
			--��ӿμ�
			insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,@username from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@refID and a.status=0

			--�����Ƶ
			insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,@username from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@refID and a.status=0

			--��ӿ��ԣ���Ŀ�ݲ�����
			insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,mark) select @username,examID,@refID,minutes,minutes*60,scoreTotal,scorePass,kindID,@mark from examInfo where courseID=@certID and status=0
		end

		--��Ӹ����¼
		--exec updatePayInfo 0,'',@projectID,'',0,0,0,'','','',@username,'','system.',@payID output

		--��Ӹ�����ϸ
		--insert into payDetailInfo(payID,enterID,price,memo,registerID) values (@payID,@ID,@price,'','system.')
		--exec updatePayAmount @payID

		--д��־
		select @logMemo=@certID + ':' + @fromID
		exec writeOpLog '',@event,'addStudentCert',@username,@logMemo,@ID
	end
	else
		select @re = 1, @msg = '������֤ͬ����Ŀ�������ظ�������'
	select @ID as enterID, isnull(@re,0) as status, isnull(@msg,'') as msg
END
GO


-- CREATE Date: 2025-08-16
-- ����username��fromID���жϸ�ѧԱӦ�������ĸ�����Ա������������ۣ��򷵻�ԭ�е����ۣ����򽫸�ѧԱ���Ϊ�µ�����
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
-- Description:	ѧԱѡ�������֤����Ŀ������ɾ����ͬʱɾ����صĿγ̡�
-- mark: 0 ֤����Ŀ  1 ��ѵ��Ŀ��ֻ�пγ̣�
-- Use Case:	exec delStudentCert '310....' 
-- =============================================
ALTER PROCEDURE [dbo].[delStudentCert] 
	@ID int,@mark int
AS
BEGIN
	DECLARE @logMemo nvarchar(500),@event varchar(50),@re int,@refID int,@username varchar(50),@host varchar(50)
	select @event='�Ƴ���ѡ֤����Ŀ',@refID=0,@re=0
	if @mark = 0
	begin
		select @username=username,@host=host from studentCertList where ID=@ID
		select @refID=ID,@logMemo=courseID + ':' + @username from studentCourseList where refID=@ID

		--ɾ������
		delete from studentQuestionList where refID in(select paperID from studentExamList where refID=@refID)

		--ɾ������
		delete from studentExamList where refID=@refID

		--ɾ����Ƶ
		delete from studentVideoList where refID in(select ID from studentLessonList where refID=@refID)

		--ɾ���μ�
		delete from studentCoursewareList where refID in(select ID from studentLessonList where refID=@refID)

		--ɾ���α�
		delete from studentLessonList where refID=@refID
		--ɾ���γ�
		delete from studentCourseList where ID=@refID
		--ɾ��֤����Ŀ
		delete from studentCertList where ID=@ID
	end
	if @mark = 1
	begin
		select @username=username,@host=host from studentCourseList where ID=@ID
		select @logMemo=courseID + ':' + @username from studentCourseList where refID=@ID

		--ɾ������
		delete from studentQuestionList where refID in(select paperID from studentExamList where refID=@ID and mark=@mark)

		--ɾ������
		delete from studentExamList where refID=@ID and mark=@mark

		--ɾ����Ƶ
		delete from studentVideoList where refID in(select ID from studentLessonList where refID=@ID)

		--ɾ���μ�
		delete from studentCoursewareList where refID in(select ID from studentLessonList where refID=@ID)

		--ɾ���α�
		delete from studentLessonList where refID=@ID
		--ɾ���γ�
		delete from studentCourseList where ID=@ID
		--ɾ��֤����Ŀ
		delete from studentCertList where ID=@ID
	end

	-- д������־
	exec writeOpLog '',@event,'delStudentCert',@username,@logMemo,@ID

	return @re
END
GO

-- =============================================
-- CREATE Date: 2020-05-09
-- Description:	���ݸ��������ݣ�����ѧԱ������Ƶ�Ľ��ȡ�
-- shoted: 0 ������¼  1 ����shotTime
-- �����Ƿ�Ҫ������Ϣ��0 �����  1 ���
-- Use Case:	exec update_video_currentTime 1,530
-- =============================================
ALTER PROCEDURE [dbo].[update_video_currentTime] 
	@ID int, @currentTime int, @shoted int
AS
BEGIN
	declare @refID int, @shotTime int, @shotNow int, @n int, @agencyID int, @check_pass int
	select @n = 60 * 25  --(10��ͨѶһ��)20��������һ��
	select @refID=refID,@shotTime=iif(@shoted=1,0,shotTime+iif(@currentTime>maxTime and shotNow=0,@currentTime-maxTime,0)),@shotNow=shotNow from studentVideoList where ID=@ID
	select @check_pass=check_pass from studentCourseList where ID=(select max(refID) from studentLessonList where ID=@refID)
	select @agencyID=agencyID from v_courseInfo where courseID in(select courseID from studentCourseList where ID in(select refID from studentLessonList where ID=@refID))

	select @shotNow = iif(@shotTime>=@n or (@shotNow=1 and @shoted=0), 1, 0)
	--������Ŀ�ҷ���ǩ��Ҫ���գ���������Ҫ
	select @shotNow = iif(@agencyID=1 and @check_pass=0,@shotNow,0)
	update studentVideoList set maxTime=(case when @currentTime>maxTime and @shotNow=0 then @currentTime else maxTime end),lastTime=iif(@shotNow=0,@currentTime,lastTime),shotTime=@shotTime,shotNow=@shotNow where ID=@ID
	if @shotNow=0
		exec update_lesson_completion @refID
	return @shotNow
END
GO

-- =============================================
-- CREATE Date: 2020-05-09
-- Description:	���ݸ��������ݣ�����ѧԱ�����μ��Ľ��ȡ�
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
-- Description:	����ָ���νڵĽ��ȡ�
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
		--������Ϣ  kindID��0 �ظ� 1 ֪ͨ
		select @item ='��ϲ���Ѿ����"' + courseName + '"�γ̵�ѧϰ��',@host=host,@username=username from v_studentCourseList where ID=@refID
		exec sendSysMessage @username,1,@item,@host,'system.'
	end
	return 0
END

GO


-- =============================================
-- CREATE Date: 2020-05-10
-- Description:	���ݸ������ϴ��ļ����ݣ�������ص���Ϣ��
-- kind:0 ѧ���ϴ�����  1 ��������
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
			select @kindID=ID,@event='�ϴ�'+item from dictionaryDoc where kind='material' and memo=@upID
			if exists(select 1 from studentInfo where username=@key)
			begin
				delete from studentMaterials where username=@key and kindID=@kindID
				insert into studentMaterials(kindID,username,filename,type,size,registerID) values(@kindID,@key,@file,0,@fsize,@registerID)
				select @ID=a.ID,@refID=b.ID from studentMaterialsAsk a, studentCourseList b where a.refID=b.ID and b.username=@key and a.kindID=@kindID and a.status=1
				if @ID>0
				begin
					update studentMaterialsAsk set status=2,answerID=@registerID,answerDate=getDate() where ID=@ID
					--����service��¼
					update studentServiceInfo set status=1,backDate=getDate(),feedback='���ύ��ͼƬ' where refID=@refID and vID=@kindID
				end
				--������ϴ�ͼƬ�����һ���Ƿ��д߽�֪ͨ
				if @upID='student_photo' and exists(select 1 from log_attention where kindID=0 and refID=@key and status=1)
					exec [replyAttention] @key, 0
				-- ��¼��Ƭ��С
				if @upID='student_photo'
					update studentInfo set photo_size = @fsize where username=@key
			end
			else
				if [dbo].[fn_validateIDCard](@key) = 1
					select @re = 2	--���޴���
				else
					select @re=1	--���֤�������
		end
		else
			select @re = 3	--���֤���ļ�������
	end
	else
	begin
		if @upID = 'course_video'	--�γ���Ƶ
		begin
			update videoInfo set filename=@file where videoID=@key
			select @i=1
		end
		if @upID = 'course_courseware'	--�μ�
		begin
			update coursewareInfo set filename=@file where coursewareID=@key
			select @i=1
		end
		if @upID = 'student_diploma'	--ѧԱ֤��
		begin
			update diplomaInfo set filename=@file where diplomaID=@key
			select @i=1, @event='�ϴ�ѧԱ֤��'
		end
		if @upID = 'host_logo'	--��˾logo
		begin
			update hostInfo set logo=@file where hostNo=@key
			select @i=1
		end
		if @upID = 'host_QR'	--��˾ѧԱ��¼��ά��
		begin
			update hostInfo set QR=@file where hostNo=@key
			select @i=1
		end
		if @upID = 'student_list'	--ѧԱ������
		begin
			--update generateStudentInfo set filename=@file where ID=@key
			update classInfo set filename=@file where ID=@key
			select @i=1, @event='�ϴ�ѧԱ������'
		end
		if @upID = 'score_list'	--ѧԱ�ɼ���
		begin
			update generatePasscardInfo set filescore=@file where ID=@key
			select @i=1, @event='�ϴ�ѧԱ�ɼ���'
		end
		if @upID = 'ref_student_list'	--ѧԱԤ������
		begin
			update classInfo set filename=@file where ID=@key
			select @i=1, @event='�ϴ�ѧԱԤ������'
		end
		if @upID = 'apply_list'	--�걨���
		begin
			update generateApplyInfo set filename=@file where ID=@key
			select @i=1, @event='�ϴ��걨���'
		end
		if @upID = 'apply_score_list'	--�걨�ɼ���֤��
		begin
			update generateApplyInfo set filescore=@file where ID=@key
			select @i=1, @event='�ϴ��걨�ɼ���֤��'
		end
		if @upID = 'apply_resit_list'	--�걨��������
		begin
			update generateApplyInfo set memo=isnull(memo,'') + '������������' + convert(varchar(20),getDate(),23) where ID=@key
			select @i=1, @event='�ϴ��걨��������'
		end
		if @upID = 'student_letter_signature'	--��ŵ��ǩ��
		begin
			update studentCourseList set signature=@file,signatureDate=getDate() where ID=@key
			select @i=1, @event='�ϴ���ŵ��ǩ��'
			--���һ���Ƿ��д߽�֪ͨ
			if exists(select 1 from log_attention where kindID=1 and refID=@key and status=1)
				exec [replyAttention] @key, 1
		end
		if @i = 0 and @upID = 'invoice_pdf'	--��Ʊ �ϴ�����Ϊ�ѿ�Ʊ����Ʊ����Ϊ����
		begin
			update studentCourseList set file5=@file,needInvoice=2,dateInvoice=getDate() where ID=@key  
			--update payInfo set dateInvoice=getDate() where ID=(select payID from payDetailInfo where enterID=@key)
			select @i=1, @event='�ϴ���Ʊ'
		end
		if @i = 0 and @upID like 'question_image%'	--��ĿͼƬ
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
			select @i=1, @event='��ĿͼƬ'
		end
		--if @upID = 'project_brochure'	--��������
		if @i=0
		begin
			if exists(select 1 from materialInfo where refID=@key and kind=@upID)
				delete from materialInfo where refID=@key and kind=@upID
			insert into materialInfo(refID,kind,filename,registerID) values(@key,@upID,@file,@registerID)
			select @i=1
		end
	end
	-- д������־
	exec writeOpLog '',@event,'',@registerID,'',@key

	--�����ϴ���д��¼
	if @multiple > 0 and @re=0
		insert into generateMaterialDetail(batchID,filename) values(@multiple,@file)
	return @re
END
GO

/*
-- =============================================
-- CREATE Date: 2020-05-10
-- Description:	���ݸ������Ծ��ţ�ΪѧԱ���ɿ�����Ŀ��
-- mark:0 ���������Ŀ����������  1 ǿ����������Ŀ
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
			--���ʱ���ո��Ծ���ʹ�ù�����Ŀ�������ȡʹ�ô������ٵ���Ŀ
			set @sql='insert into studentQuestionList(questionID,refID,kindID,scorePer,answer) select top ' + cast(@qty as varchar) + ' a.questionID,' + cast(@paperID as varchar) + ',a.kindID,' + cast(@scorePer as varchar) + ',a.answer from questionInfo a left outer join studentQuestionUsed b on a.questionID=b.questionID and b.refID=' + cast(@paperID as varchar) + ' where a.knowPointID=''' + @kp + ''' and a.kindID=' + cast(@type as varchar) + ' and a.status=0 order by b.times,newid()'
			if exists(select 1 from v_studentQuestionList where refID=@paperID and knowPointID=@kp and kindID=@type)	--��ֹ�ظ�������Ŀ
			begin
				insert into look_exam_question_overflow(questionID,refID,kindID,knowPointID) select questionID,refID,kindID,@kp from studentQuestionList where refID=@paperID and kindID=@type
				delete from studentQuestionList where ID in(select ID from v_studentQuestionList where refID=@paperID and knowPointID=@kp and kindID=@type)
			end
			EXEC sp_executesql @sql		--�����ȡ��Ŀ

			if exists(select 1 from v_studentQuestionList where refID=@paperID and knowPointID=@kp and kindID=@type group by questionID having count(*)>1)	--����ظ���Ŀ
			begin
				delete from studentQuestionList where ID in(select ID from v_studentQuestionList where refID=@paperID and knowPointID=@kp and kindID=@type)
				EXEC sp_executesql @sql		--�����ȡ��Ŀ
			end

			fetch next from rc into @kp,@type,@qty,@scorePer
		End
		Close rc 
		Deallocate rc

		--���³�ȡ����Ŀд�뵽��ʹ����Ŀ�б���
		update studentQuestionUsed set times=times+1 from studentQuestionList b where studentQuestionUsed.questionID=b.questionID and studentQuestionUsed.refID=b.refID and studentQuestionUsed.refID=@paperID
		insert into studentQuestionUsed(questionID,refID,kindID,status,answer) select questionID,refID,kindID,0,answer from studentQuestionList where refID=@paperID and questionID not in(select questionID from studentQuestionUsed where refID=@paperID)
	end
	return 0
END
GO*/

-- =============================================
-- CREATE Date: 2020-05-10
-- Description:	���ݸ������Ծ��ţ�ΪѧԱ���ɿ�����Ŀ��
-- mark:0 ���������Ŀ����������  1 ǿ����������Ŀ
-- pkind:0 ģ��/��ʽ����  1 ���⼯  2 �����  3 �ղؼ�  4 �½���ϰ
-- kindID: when pkind=2  questionInfo.kindID   when pkind=4  questionInfo.chapterID
-- paperID: pkind 0 - paperID; pkind>0 - enterID
-- onlyWrong: 0 all  1 only wrong answer of �ж���
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

	-- ģ��/��ʽ����
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
			--���ʱ���ո��Ծ���ʹ�ù�����Ŀ�������ȡʹ�ô������ٵ���Ŀ
			set @sql='insert into studentQuestionList(questionID,refID,kindID,scorePer,answer) select top ' + cast(@qty as varchar) + ' a.questionID,' + cast(@paperID as varchar) + ',a.kindID,' + cast(@scorePer as varchar) + ',a.answer from questionInfo a left outer join studentQuestionUsed b on a.questionID=b.questionID and b.refID=' + cast(@paperID as varchar) + ' where a.knowPointID=''' + @kp + ''' and a.kindID=' + cast(@type as varchar) + ' and a.status=0 order by b.times,newid()'
			/**
			if exists(select 1 from v_studentQuestionList where refID=@paperID and knowPointID=@kp and kindID=@type)	--��ֹ�ظ�������Ŀ
			begin
				insert into look_exam_question_overflow(questionID,refID,kindID,knowPointID) select questionID,refID,kindID,@kp from studentQuestionList where refID=@paperID and kindID=@type
				delete from studentQuestionList where ID in(select ID from v_studentQuestionList where refID=@paperID and knowPointID=@kp and kindID=@type)
			end
			**/
			EXEC sp_executesql @sql		--�����ȡ��Ŀ
			select @memo=@memo + @kp+'/'+cast(@type as varchar)+'/'+cast(@qty as varchar) + '; '
			/**
			if exists(select 1 from v_studentQuestionList where refID=@paperID and knowPointID=@kp and kindID=@type group by questionID having count(*)>1)	--����ظ���Ŀ
			begin
				delete from studentQuestionList where ID in(select ID from v_studentQuestionList where refID=@paperID and knowPointID=@kp and kindID=@type)
				EXEC sp_executesql @sql		--�����ȡ��Ŀ
			end
			**/
			fetch next from rc into @kp,@type,@qty,@scorePer
		End
		Close rc 
		Deallocate rc

		--���³�ȡ����Ŀд�뵽��ʹ����Ŀ�б���
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

	-- ���⼯
	if @pkind=1
		insert into #temp
		select ID,questionID,kindID,0,0,answer,myAnswer,questionName,A,B,C,D,E,F,image,imageA,imageB,imageC,imageD,imageE,imageF,knowPointID,kindName,memo from v_studentQuestionWrong where enterID=@paperID

	-- �����
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

	-- �ղؼ�
	if @pkind=3
		insert into #temp
		select ID,questionID,kindID,0,0,answer,'',questionName,A,B,C,D,E,F,image,imageA,imageB,imageC,imageD,imageE,imageF,knowPointID,kindName,memo from v_studentQuestionMark where enterID=@paperID

	-- �½���ϰ
	if @pkind=4
	begin
		select @courseID=a.courseID, @certID=b.certID from studentCourseList a, courseInfo b where a.courseID=b.courseID and a.ID=@paperID
		insert into #temp
		select a.ID,a.questionID,a.kindID,0,0,a.answer,'',questionName,A,B,C,D,E,F,image,imageA,imageB,imageC,imageD,imageE,imageF,a.knowPointID,a.kindName,a.memo
		from v_questionInfo a, (select distinct c.knowPointID, b.examID, b.kindID from examInfo b, examRuleInfo c where b.examID=c.examID and b.courseID=@courseID) d where a.knowPointID=d.knowPointID and a.status=0 and a.chapterID=@kindID
	end

	if not exists(select 1 from #temp)
		insert into #temp select 0,0,0,0,0,'','','û�з��������Ŀ��','','','','','','','','','','','','','',0,'',''

	if @pkind=0 and @page>0 and @pageSize>0
		select * from #temp order by kindID desc,ID offset (@page-1)*@pageSize rows fetch next @pageSize rows only
	else
		select top 100 percent * from #temp order by kindID, questionID
	return 0
END
GO

-- =============================================
-- CREATE Date: 2020-05-11
-- Description:	���ݸ��������ݣ�����ѧԱ���Դ𰸡������Ѵ�������
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
-- Description:	���ݸ��������ݣ�����ѧԱ����ʣ��ʱ�䡣
-- ����ǵ�һ�θ��£�ͬʱ��д��ʼʱ�䲢��״̬��Ϊ�����С�
-- ģ�⿼�Ե�ʣ��ʱ���Կ�����Ϊ׼����ʽ�����Է�����Ϊ׼��
-- ��ʽ����ʱ���ʱ�����С��5���ӣ�������������0�������򷵻ط�����ʱ�䡣
-- ����ѽ����ʣ��ʱ��Ϊ0������1�����򷵻�0
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
-- Description:	ѧԱ���Խ���
-- Use Case:	exec submit_student_exam 1
-- =============================================
ALTER PROCEDURE [dbo].[submit_student_exam] 
	@paperID int
AS
BEGIN
	declare @score decimal(18,1),@refID int,@kindID int, @kind int, @times int, @type int, @scorePass int, @username varchar(50), @host varchar(50),@item nvarchar(500),@certName varchar(50),@ID int,@status int
	select @score = 0, @refID=refID, @kindID=kindID, @kind=kind, @scorePass=scorePass, @status=status from studentExamList where paperID=@paperID
	select @ID=refID  from studentCourseList where ID=@refID

	if @status=1	--ֻ���ѿ�ʼ״̬�Ŀ��Բ��ܽ���
	begin
		--����
		update studentQuestionList set answer=replace(answer,' ','') where refID=@paperID and charindex(' ',answer)>0
		update studentQuestionList set score=(case when answer=myAnswer then scorePer else 0 end) where refID=@paperID
		select @score=sum(score) from studentQuestionList where refID=@paperID
		--select @score=(case when @kind=1 and @score<@scorePass then ceiling(SQRT(@score)*10) else @score end)
		--select @score = (case when @score>100 then 88 else @score end)
		--����: ʣ��ʱ������
		update studentExamList set status=2,endDate=getDate(),score=@score,secondRest=0 where paperID=@paperID
		--�����Խ����д����ر���
		if @kind=0 and @kindID=0		--֤��ģ�⿼��
		begin
			select @type = type,@username=username,@host=host,@certName=certName from v_studentCertList where ID=@ID
			update studentCertList set examScore=(case when examScore<@score then @score else examScore end),examTimes=examTimes+1 where ID=@ID
			select @score=examScore, @times= examTimes from studentCertList where ID=@ID
			update studentCourseList set examScore=@score, examTimes=@times where ID=@refID
			if @type=1 and @score >= @scorePass
			begin
				--��ҵ�ڲ�֤��ͨ�����ԣ��Զ������γ�
				if exists(select 1 from studentCertList where ID=@ID and status<2)
				begin
					update studentCertList set result=1,status=2,closeDate=getDate() where ID=@ID
					update studentCourseList set status=2,endDate=getDate(),startDate=(case when startDate is null then getDate() else startDate end) where ID=@refID
					--������Ϣ  kindID��0 �ظ� 1 ֪ͨ
					set @item ='ף�ؿ��Ժϸ�[' + @certName + ']����ȷ���ϴ���֤����ƬΪ�������������֤��Ƭ�����շ�����Ϊ��Ч��������1�������պ��ڱ�ƽ̨��ѯ����֤�������޷���ѯ������֤�ģ���˶��ϴ�����Ƭ����Ҫ��'
					exec sendSysMessage @username,1,@item,@host,'system.'
				end
			end
			--�����Ծ�����
			exec backupExam @paperID
		end
		if @kind=0 and @kindID=1		--�γ�ģ�⿼��
			update studentCourseList set examScore=(case when examScore<@score then @score else examScore end),examTimes=examTimes+1 where ID=@refID
		if @kind=1		--���߿���
			update passcardInfo set score=@score where ID=@refID
	end
	
	return 0
END
GO

-- =============================================
-- CREATE Date: 2020-05-11
-- Description:	ѧԱ���Խ���
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
		--�����Խ����д����ر���
		if @kind=0 and @kindID=0		--֤��ģ�⿼��
		begin
			select @type = type,@username=username,@host=host,@certName=certName from v_studentCertList where ID=@ID
			update studentCertList set examScore=@score where ID=@ID
			update studentCourseList set examScore=@score where ID=@refID
			if @type=1 and @score >= @scorePass
			begin
				--��ҵ�ڲ�֤��ͨ�����ԣ��Զ������γ�
				if exists(select 1 from studentCertList where ID=@ID and status<2)
				begin
					update studentCertList set result=1,status=2,closeDate=getDate() where ID=@ID
					update studentCourseList set status=2,endDate=getDate(),startDate=(case when startDate is null then getDate() else startDate end) where ID=@refID
					--������Ϣ  kindID��0 �ظ� 1 ֪ͨ
					set @item ='ף�ؿ��Ժϸ�[' + @certName + ']����ȷ���ϴ���֤����ƬΪ�������������֤��Ƭ�����շ�����Ϊ��Ч��������1�������պ��ڱ�ƽ̨��ѯ����֤�������޷���ѯ������֤�ģ���˶��ϴ�����Ƭ����Ҫ��'
					exec sendSysMessage @username,1,@item,@host,'system.'
				end
			end
			--�����Ծ�����
			--exec backupExam @paperID
		end
		if @kind=0 and @kindID=1		--�γ�ģ�⿼��
			update studentCourseList set examScore=(case when examScore<@score then @score else examScore end) where ID=@refID
		if @kind=1		--���߿���
			update passcardInfo set score=@score where ID=@refID

	
	return 0
END
GO


-- =============================================
-- CREATE Date: 2020-05-13
-- Description:	�����Ժ󣬽��Ծ���Ϣ���ݵ�����
-- @paperID: �Ծ���
-- Use Case:	exec backupExam 1
-- =============================================
ALTER PROCEDURE [dbo].[backupExam] 
	@paperID int
AS
BEGIN
	--�����ظ��ύ
	if not exists(select 1 from ref_studentExamList a, studentExamList b where a.paperID=b.paperID and a.startDate=b.startDate and b.paperID=@paperID)
	begin
		declare @id int
		--�����Ծ�
		insert into ref_studentExamList(paperID,username,examID,refID,kindID,kind,status,minutes,secondRest,scoreTotal,scorePass,score,startDate,endDate,lastDate,mark,memo,regDate,registerID) select * from studentExamList where paperID=@paperID
		select @id=max(seq) from ref_studentExamList where paperID=@paperID
		--��������
		insert into ref_studentQuestionList(ID,questionID,refID,kindID,status,scorePer,score,answer,myAnswer,answerDate,memo,regDate,registerID,seq) select ID,questionID,refID,kindID,status,scorePer,score,answer,myAnswer,answerDate,memo,regDate,registerID,@id from studentQuestionList where refID=@paperID
		--��������Դ��¼
		--update studentQuestionUsed set myAnswer=b.myAnswer,status=(case when b.score>0 then 1 when b.score=0 and b.myAnswer is not null then 2 else studentQuestionUsed.status end) from studentQuestionList b where studentQuestionUsed.refID=b.refID and studentQuestionUsed.questionID=b.questionID and b.refID=@paperID
	end

	declare @refID int
	select @refID=refID from v_studentExamList where paperID=@paperID
	-- ��������Ŀ���浽�����(����δ���)
	insert into studentQuestionWrong(enterID,questionID) select @refID,questionID from studentQuestionList where refID=@paperID and score=0 and questionID not in(select questionID from studentQuestionWrong where enterID=@refID)
	-- ����ȷ��Ŀ�Ӵ����ɾ��
	delete from studentQuestionWrong where enterID=@refID and questionID in(select questionID from studentQuestionList where refID=@paperID and score>0)
	-- �������������������Ϊ1��ʹ����Щ�����ں������Ծ������ȳ�ȡ��
	update studentQuestionUsed set times=1 from studentQuestionUsed a, studentQuestionWrong b where a.refID=@paperID and b.enterID=@refID and a.questionID=b.questionID
	return 0
END

GO


-- =============================================
-- CREATE Date: 2020-05-13
-- Description:	��ѧԱ����ϵͳ��Ϣ��
-- kindID: 0 �ظ� 1 ֪ͨ 2����
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
-- Description:	ѧԱ�ύ������
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
-- Description:	�ύ���ý�����Ϣ��
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

	if @refID>0 --�ظ�ĳ��ѧ��
		select @readerID=a.username from studentInfo a, studentFeedbackInfo b where a.username=b.username and b.ID=@refID

	insert into studentFeedbackInfo(username,kindID,item,refID,classID,type,readerID,title,registerID) values(@username,@kindID,@item,@refID,@classID,@type,@readerID,@title,@username)
	return 0
END

GO

-- =============================================
-- CREATE Date: 2020-05-13
-- Description:	ѧԱ��Ϣ�Ķ���ǡ�
-- status:0 δ�� 1 �Ѷ� 2 ����  ��һ����Ϊ�Ѷ�ʱ����д�Ķ�����
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
-- Description:	��ѧԱ������Ϣ��
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
-- ��ѧԱ������Ϣ���Ϊ�Ѷ�
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
-- ��ѧԱ������Ϣ���Ϊ�Ѷ�
-- USE CASE: exec setStudentFeedbackDeal 1, '����', 'albert'
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
-- ������Ϣ
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
-- ���ݸ����Ĳ�������ӻ��߸��·���ѧԱ����Ϣ
-- USE CASE: exec updateStudentMessageInfo 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[updateStudentMessageInfo]
	@ID int,@refID int,@item nvarchar(4000),@username varchar(50),@kindID int,@emergency int,@registerID varchar(50)
AS
BEGIN
	declare @host varchar(20)
	if @ID=0	-- �¼�¼
	begin
		if @refID > 0	--�ظ�ѧԱ�����������Ϣ
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
-- ���ط���ѧԱ����Ϣ
-- USE CASE: exec doCancelStudentMessage 1, '����', 'albert'
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
-- ����Ա�޸�ѧԱ��ע
-- USE CASE: exec setStudentMemo 1, '����', 'albert'
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
-- ����Ա�޸�ѧԱ״̬
-- USE CASE: exec setStudentStatus 1, '����', 'albert'
-- =============================================
ALTER PROCEDURE [dbo].[setStudentStatus] 
	@username varchar(50), @status int, @registerID varchar(50)
AS
BEGIN
	update studentInfo set user_status=@status where username=@username
	-- д������־
	exec writeOpLog '','�޸�ѧԱ״̬','setStudentStatus',@registerID,'',@username
END

GO

-- =============================================
-- CREATE DATE: 2022-09-06
-- ����ѧԱ����
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
	-- д������־
	exec writeOpLog '','��������','resetStudentPwd',@registerID,@pwd,@username
	select @pwd as re
END
GO

-- =============================================
-- CREATE DATE: 2020-05-16
-- ����Ա�޸�ѧԱ�γ̱�ע
-- USE CASE: exec setStudentCourseMemo 1, '����', 'albert'
-- =============================================
CREATE PROCEDURE [dbo].[setStudentCourseMemo] 
	@ID int, @memo nvarchar(500)
AS
BEGIN
	update studentCourseList set memo=@memo where ID=@ID
END

-- =============================================
-- CREATE DATE: 2020-05-16
-- ����Ա�޸�֤�鱸ע
-- USE CASE: exec setDiplomaMemo 1, '����'
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
-- ����Ա�޸�֤�����ɼ�¼��ע
-- USE CASE: exec setGenerateDiplomaMemo 1, '����'
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
-- ����Ա�޸Ĵ�����֤���¼��ע
-- USE CASE: exec setNeedDiplomaMemo 1, '����'
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
-- ����Աȡ��/�ָ�������֤���ʸ�
-- @kindID: 0 ȡ��  1 �ָ�
-- USE CASE: exec setNeedDiplomaCancel 1, '����', 0
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
		select @username=username,@kindID=1,@host=host,@item='���֤��[' + certName + ']������ʱ���ܾ���ԭ��[' + @memo + ']' from v_studentCertList where ID=@ID
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
-- ����Ա�޸ĵ���ѧԱ������ע
-- USE CASE: exec setGenerateStudentMemo 1, '����'
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
-- ����Ա�޸ĵ���ѧԱ������ע
-- USE CASE: exec setGenerateMaterialMemo 1, '����'
-- =============================================
CREATE PROCEDURE [dbo].[setGenerateMaterialMemo] 
	@ID int, @memo nvarchar(500)
AS
BEGIN
	update generateMaterialInfo set memo=@memo where ID=@ID
END
GO

-- CREATE DATE: 2020-05-16
-- ���ݸ����Ĳ�������ӻ��߸�����֤��Ŀ
-- USE CASE: exec updateCertificateInfo 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[updateCertificateInfo]
	@ID int,@certID varchar(50),@certName nvarchar(100),@shortName nvarchar(100),@term int,@termExt int,@agencyID int,@kindID int,@status int,@type int,@mark int,@days_study int,@days_exam int,@days_diploma int,@days_archive int,@host varchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	if @ID=0	-- �¼�¼
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
-- ���ݸ����Ĳ�������ӻ��߸��¿γ�
-- USE CASE: exec updateCourseInfo 1,1,'xxxx'...").value + "|" + rs("").value + "|" + rs("").value + "|" + rs("
ALTER PROCEDURE [dbo].[updateCourseInfo]
	@ID int,@courseID varchar(50),@courseName nvarchar(100),@shortName nvarchar(50),@hours int,@completionPass int,@deadline int,@deadday int,@period int,@kindID int,@reexamine int,@status int,@mark int,@certID varchar(50),@price int,@host varchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	if @shortName = ''
		set @shortName = @courseName
	if @ID=0	-- �¼�¼
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
-- ���ݸ����Ĳ�������ӻ��߸��¿α�
-- USE CASE: exec updateLessonInfo 1,1,'xxxx'...
CREATE PROCEDURE [dbo].[updateLessonInfo]
	@ID int,@lessonID varchar(50),@lessonName nvarchar(100),@hours int,@courseID varchar(50),@seq int,@kindID int,@status int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @host varchar(20)
	if @ID=0	-- �¼�¼
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
-- ���ݸ����Ĳ�������ӻ��߸�����Ƶ
-- USE CASE: exec updateVideoInfo 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[updateVideoInfo]
	@ID int,@videoID varchar(50),@videoName nvarchar(100),@minutes float,@proportion int,@type varchar(50),@author varchar(50),@lessonID varchar(50),@kindID int,@status int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @host varchar(20)
	if @ID=0	-- �¼�¼
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
-- ���ݸ����Ĳ�������ӻ��߸��¿μ�
-- USE CASE: exec updateCoursewareInfo 1,1,'xxxx'...
CREATE PROCEDURE [dbo].[updateCoursewareInfo]
	@ID int,@coursewareID varchar(50),@coursewareName nvarchar(100),@pages int,@proportion int,@type varchar(50),@author varchar(50),@lessonID varchar(50),@kindID int,@status int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @host varchar(20)
	if @ID=0	-- �¼�¼
	begin
		insert into coursewareInfo(coursewareID,coursewareName,pages,lessonID,proportion,type,author,kindID,status,memo,registerID) values(@coursewareID,@coursewareName,@pages,@lessonID,@proportion,@type,@author,@kindID,@status,@memo,@registerID)
	end
	else
	begin
		update coursewareInfo set kindID=@kindID,coursewareID=@coursewareID,pages=@pages,coursewareName=@coursewareName,status=@status,lessonID=@lessonID,proportion=@proportion,type=@type,author=@author,memo=@memo where ID=@ID
	end
END

-- CREATE DATE: 2020-05-24
-- ���ݸ����Ĳ�������ӻ��߸���֪ʶ��
-- USE CASE: exec updateKnowPointInfo 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[updateKnowPointInfo]
	@ID int,@knowpointID varchar(50),@knowpointName nvarchar(100),@courseID varchar(50),@status int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @host varchar(20)
	if @ID=0 and not exists(select 1 from knowpointInfo where knowpointID=@knowpointID)	-- �¼�¼
	begin
		insert into knowpointInfo(knowpointID,knowpointName,courseID,status,memo,registerID) values(@knowpointID,@knowpointName,@courseID,@status,@memo,@registerID)
	end
	else
	begin
		update knowpointInfo set knowpointID=@knowpointID,knowpointName=@knowpointName,status=@status,courseID=@courseID,memo=@memo where ID=@ID
	end
END

-- CREATE DATE: 2020-05-24
-- ���ݸ����Ĳ�������ӻ��߸�����Ŀ
-- USE CASE: exec updateQuestionInfo 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[updateQuestionInfo]
	@ID int,@questionID varchar(50),@questionName nvarchar(2000),@knowPointID varchar(50),@answer varchar(50),@A nvarchar(200),@B nvarchar(200),@C nvarchar(200),@D nvarchar(200),@E nvarchar(200),@F nvarchar(200),@kindID int,@status int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @host varchar(20)
	if @ID=0 and not exists(select 1 from questionInfo where questionID=@questionID)	-- �¼�¼
	begin
		insert into questionInfo(questionID,questionName,knowPointID,answer,A,B,C,D,E,F,kindID,status,memo,registerID) values(@questionID,@questionName,@knowPointID,replace(@answer,' ',''),@A,@B,@C,@D,@E,@F,@kindID,@status,@memo,@registerID)
	end
	else
	begin
		update questionInfo set questionID=@questionID,questionName=@questionName,knowPointID=@knowPointID,answer=replace(@answer,' ',''),A=@A,B=@B,C=@C,D=@D,E=@E,F=@F,status=@status,kindID=@kindID,memo=@memo where ID=@ID
	end
	exec writeOpLog '','������Ŀ','updateQuestion',@registerID,@questionName,@questionID
END
GO


-- CREATE DATE: 2020-05-24
-- ���ݸ����Ĳ�������ӻ��߸��µ�λ��Ϣ
-- USE CASE: exec updateHostInfo 1,1,'xxxx'...
CREATE PROCEDURE [dbo].[updateHostInfo]
	@hostID int,@hostNo  nvarchar(50),@hostName nvarchar(100),@title nvarchar(100),@kindID int,@status int,@linker  nvarchar(50),@phone nvarchar(50),@email nvarchar(50),@address nvarchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	if @hostID=0	-- �¼�¼
	begin
		insert into hostInfo(hostNo,hostName,title,kindID,status,linker,phone,email,address,memo,registerID) values(@hostNo,@hostName,@title,@kindID,@status,@linker,@phone,@email,@address,@memo,@registerID)
		--��ʼ������
		exec initialHost @hostNo
	end
	else
	begin
		update hostInfo set hostNo=@hostNo,kindID=@kindID,hostName=@hostName,title=@title,status=@status,linker=@linker,phone=@phone,email=@email,address=@address,memo=@memo where hostID=@hostID
	end
END
GO

-- CREATE DATE: 2020-05-24
-- ���ݸ����Ĳ�������ӻ��߸�����֤������Ϣ
-- USE CASE: exec updateAgencyInfo 1,1,'xxxx'...
CREATE PROCEDURE [dbo].[updateAgencyInfo]
	@ID int,@agencyID  nvarchar(50),@agencyName nvarchar(100),@title nvarchar(100),@kindID int,@status int,@linker  nvarchar(50),@phone nvarchar(50),@email nvarchar(50),@address nvarchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	if @agencyID=0 and not exists(select 1 from agencyInfo where agencyID=@agencyID)	-- �¼�¼
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
-- Description:	��ʼ���µĹ�˾��
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

--0.������ʼ�û�
	--���ԭ������
	delete from userInfo where host=@host
	--����������
	insert into userInfo(userNo,userName,password,realName,kindID,limitedDate,memo,host,registerID) select userNo,userNo + '.' + @host,@passwd,realName,kindID,'2037-09-20',memo,@host,registerID from userInfo_model where status=0 and owner=@k
--1.��׼�ֵ�����
	--���ԭ������
	delete from hostDict where host=@host and mark=1
	--����������
	insert into hostDict(item,kind,description,memo,host,registerID) select item,ID,description,memo,@host,'admin.' from dictionaryDoc where kind='hostDict' and status=0
--2.��׼��ɫȨ������
	--���ԭ������
	delete from roleInfo where host=@host
	delete from rolePermissionList where host=@host
	delete from roleUserList where host=@host
	delete from permissionInfo where host=@host
	--����������
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
--3.�Զ��������
--4.��׼��λ����
--5.��׼��������
--6.������˾��Ϣ
	--���ԭ������
	delete from deptInfo where host=@host
	--����������
	insert into deptInfo(pID,deptName,linker,phone,email,host,registerID) select 0,hostName,linker,phone,email,@host,registerID from hostInfo where hostNo=@host
	--��׼��������
	select @id=max(deptID) from deptInfo where host=@host
	insert into deptInfo(pID,deptName,host,registerID) select @id,deptName,@host,registerID from deptInfo_model where dept_status=0
END
GO

-- CREATE DATE: 2017-07-07
-- ���ݸ����Ĳ�������ӻ��߸����û����ݣ���д��־
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

	if @userID=0	-- �¼�¼
	begin
		insert into userInfo(host,userNo,userName,realName,password,deptID,phone,email,limitedDate,memo,registerID) 
			values(@host,@userNo,@userNo+'.'+@host,@realName,@passwd,@deptID,@phone,@email,@limitedDate,@memo,@registerID)
		select @userID=max(userID) from userInfo where registerID=@registerID
		select @event = '����'
		exec writeEventTrace @host,@registerID,'user',@userID,0,'�Ǽ�',@userNo
	end
	else
	begin
		update userInfo set status=@status,realName=@realName,deptID=@deptID,phone=@phone,email=@email,limitedDate=@limitedDate,memo=@memo where userID=@userID
		select @event = '�޸�'
	end
	-- д������־
	exec writeOpLog @host,@event,'user',@registerID,@userNo,@userID
END
GO

-- CREATE DATE: 2015-01-12
-- ���ݸ����Ĳ�����ɾ���û����ݣ���д��־
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
		-- д������־
		exec writeOpLog @host,'ɾ���û�','user',@registerID,@userNo,@ID
	end
END
GO

-- CREATE DATE: 2015-01-12
-- ���ݸ����Ĳ����������û����룬��д��־
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
		-- д������־
		exec writeOpLog @host,'��������','user',@registerID,@userNo,@ID
	end
END
GO


-- CREATE DATE: 2020-05-24
-- ���ݸ����Ĳ�������ӻ��߸��²�����Ϣ
-- USE CASE: exec updateDeptInfo 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[updateDeptInfo]
	@deptID int,@pID int,@deptName nvarchar(100),@kindID int,@status int,@linker  nvarchar(50),@phone nvarchar(50),@email nvarchar(50),@address nvarchar(50),@No varchar(50),@area varchar(50),@c555 int,@title nvarchar(500),@accountKind int,@payNow int,@host varchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	if @deptID=0	-- �¼�¼
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
-- ���ݸ����Ĳ�����ɾ���������ݣ���д��־
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
		-- д������־
		exec writeOpLog @host,'ɾ������','dept',@registerID,@memo,@ID
	end
END


-- CREATE DATE: 2020-05-24
-- ���ݸ����Ĳ�������ӻ��߸��µ���ѧԱ��������Ϣ
-- USE CASE: exec updateGenerateStudentInfo 1,1,'xxxx'...
CREATE PROCEDURE [dbo].[updateGenerateStudentInfo]
	@ID int,@item nvarchar(100),@qty int,@host varchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	if @ID=0	-- �¼�¼
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
-- ���ݸ����Ĳ�����ɾ��ѧԱ���������ݣ���д��־
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
		-- д������־
		exec writeOpLog @host,'ɾ���ϴ�������','generatestudent',@registerID,@memo,@ID
	end
END


-- CREATE DATE: 2020-05-24
-- ���ݸ����Ĳ�������ӻ��߸��µ���ѧԱ�ɼ�����Ϣ
-- USE CASE: exec updateGenerateScoreInfo 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[updateGenerateScoreInfo]
	@ID int,@item nvarchar(100),@certID varchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	if @ID=0	-- �¼�¼
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
-- ���ݸ����Ĳ�����ɾ��ѧԱ�ɼ������ݣ���д��־
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
		-- д������־
		exec writeOpLog @host,'ɾ���ϴ��ɼ���','generateScore',@registerID,@memo,@ID
	end
END
GO

-- CREATE Date: 2017-05-13
-- ���ݸ����ı�ʶ����������㷨�Զ����ɱ�š�������򣺹�˾ + ��ʶ + 2λ��� + nλ��š���ʽ��SPCC1-20-00003
-- ���ɵĴ���д�뵽���й���ѯʹ�á�
-- USE CASE: exec setAutoCode 'spc','C1',@re
ALTER PROCEDURE [dbo].[setAutoCode] 
	@host varchar(50),@kind varchar(50), @re varchar(50) output, @serial int output
--WITH ENCRYPTION
AS
BEGIN
	DECLARE @result varchar(50),@useYear int,@thisYear varchar(50),@lastYear varchar(50),@lastNo varchar(20),@n int,@split varchar(50),@long int,@mark varchar(50),@kind0 varchar(50)
	select @kind0=@kind
	if @kind='CLSC26'	--�����������Ŀ�ϲ����
		select @kind='CLSC25'
	if @kind='CLSC31'	--������ҵ��������Ŀ�ϲ����
		select @kind='CLSC30'
	if @kind='CLSC19'	--���������������Ŀ�ϲ����
		select @kind='CLSC18'

	select @result = '', @thisYear =  convert(varchar(4),getDate(),112),@serial=0,@long=(case when left(@kind,3)='CLS' then 2 else 5 end),@mark=(case when left(@kind,3)='CLS' then right(@kind,len(@kind)-3)+'-' else @kind end),@split=(case when left(@kind,3)='CLS' then '' else '-' end)
	if not exists(select 1 from autoCode where kind=@kind and host=@host)
		insert into autoCode(kind,mark,long,split,host) values(@kind,@mark,@long,@split,@host)

	-- ����Ƿ��б���ȱ�ʶ�����û������Ӳ�������������
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
-- Description:	���ݸ�����֤����Ŀ��ţ�Ϊ����Ҫ���ѧԱ������ҵ�ڲ�֤�顣
-- @batchID: 0 new  >0 rebuild(do nothing)
-- @selList: �����������ö��ŷָ���ID in studentCertList
-- @selList1: �����������ö��ŷָ���ID in studentCertList
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
	--��ȡ��������
	select @n=dbo.pf_getStrArrayLength(@selList1,','), @j=0
	while @n>@j
	begin
		insert into #temp1 values(dbo.pf_getStrArrayOfIndex(@selList1,',',@j))
		select @j = @j + 1
	end

	--������
	if @batchID=0 and exists(select ID from v_studentCertList where certID=@certID and host=@host and type=1 and result=1 and diplomaID='')
	begin
		--��д���ɼ�¼
		insert into generateDiplomaInfo(certID,host,registerID) select @certID,@host,@registerID
		select @re=max(ID) from generateDiplomaInfo where registerID=@registerID and certID=@certID and host=@host

		--����֤��
		--declare rc cursor for select ID,student_kindID from v_studentCertList where certID=@certID and host=@host and type=1 and result=1 and diplomaID='' order by dept1,name
		--��ȡ��������
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
			select @i = @i + 1, @t=(case when @kindID=1 then @termExt else @term end)	--ϵͳ�����޲�ͬ
			exec setAutoCode @host,@certID,@code output, @serial output		--��ȡ֤����
			update studentCertList set diplomaID=@code where ID=@ID
			--����֤�飬֤�鷢������Ϊ��ҵ����
			insert into diplomaInfo(diplomaID,username,certID,batchID,refID,score,term,startDate,endDate,filename,stamp,host,registerID) select @code,username,certID,@re,@ID,examScore,@t,closeDate,dateadd(yy,@t,closeDate),'/upload/students/diplomas/' + @code + '.pdf',@stamp,@host,@registerID from studentCertList where ID=@ID
			if @i = 1
				set @firstID = @code
			set @lastID = @code
			fetch next from rc into @ID,@kindID,@stamp
		End
		Close rc 
		Deallocate rc
		drop table #temp
		--�������ɼ�¼
		if @i>0
		begin
			update generateDiplomaInfo set qty=@i, firstID=@firstID,lastID=@lastID,filename='/upload/students/diplomaPublish/' + cast(@re as varchar) + '.pdf' where ID=@re
		end
	end
	-- �������ɣ�֤���Ų��䣬���ݸ��¡�
	if @batchID>0	
	begin
		--����֤��
		declare rc cursor for select a.ID,b.kindID,(case when c.id>0 then 1 else 0 end) as stamp from diplomaInfo a INNER JOIN studentInfo b on a.username=b.username LEFT OUTER JOIN #temp1 c on a.ID=c.id where a.certID=@certID and a.batchID=@batchID
		open rc
		fetch next from rc into @ID,@kindID,@j
		While @@fetch_status=0 
		Begin 
			select @i = @i + 1, @t=(case when @kindID=1 then @termExt else @term end)	--ϵͳ�����޲�ͬ
			--����֤����������
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
-- Description:	���ݸ��������֤�б�Ϊ����������Ч֤����������֤�飬�Ը������ݣ�һ���ǵ�λ�������
-- @selList: �������ö��ŷָ���username
-- Use Case:	exec generate_diploma_byUsername '...','admin.'
-- =============================================
ALTER PROCEDURE [dbo].[generate_diploma_byUsername] 
	@selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	--������ʱ��
	create table #temp(id varchar(50))
	declare @n int, @j int
	select @selList=replace(replace(@selList,' ',''),'��',',')
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	exec writeOpLog '','����֤��','generate_diploma_byUsername',@registerID,'',@selList

	select a.* from v_diplomaInfo a, #temp b where a.username=b.ID and a.type=1 and a.status=0

	drop table #temp
END
GO

-- =============================================
-- CREATE Date: 2020-10-02
-- Description:	���ݸ�����֤����Ŀ��ţ���д����֤���¼��
-- @selList: �����������ö��ŷָ���ID in studentCertList
-- @type: ���ŷ�ʽ  issueType
-- Use Case:	exec issueDiploma '...','spc','admin.'
-- =============================================
CREATE PROCEDURE [dbo].[issueDiploma] 
	@selList varchar(4000), @type int, @host varchar(50), @registerID varchar(50)
AS
BEGIN
	--Ϊ�����嵥������ʱ��
	create table #temp(id int)
	declare @n int, @j int, @re int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0, @re=0
	while @n>@j
	begin
		insert into #temp values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	--���ݷ����嵥����֤������
	update diplomaInfo set issued=1, issueDate=getDate(), issueType=@type, issuer=@registerID from #temp a where diplomaInfo.ID=a.id

	--��д���ż�¼
	insert into issueDiplomaInfo(qty,IDList,issueType,host,registerID) select @n,@selList,@type,@host,@registerID

	drop table #temp

	select @re = max(id) from issueDiplomaInfo where registerID=@registerID
	return @re
END
GO

-- CREATE DATE: 2020-05-24
-- ���ݸ����Ĳ�������ӻ��߸��µ���ѧԱ������Ϣ������������ѧУ��. dept2Name��ֵ�ģ�����վ�����ж�Ϊ��ʯ��Ա��
-- USE CASE: exec generateStudent 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[generateStudent]
	@username varchar(50),@name nvarchar(50),@dept1Name nvarchar(100),@tax varchar(50),@dept2Name nvarchar(100),@job varchar(50),@mobile nvarchar(50),@address nvarchar(50),@education nvarchar(50),@currDiplomaDate nvarchar(50),@memo nvarchar(500),@classID varchar(50),@oldNo varchar(50),@registerID varchar(50)

AS
BEGIN
	declare @password varchar(50),@kindID int,@companyID varchar(50),@dept1 varchar(50),@dept2 varchar(50),@fromID varchar(50),@price int,@unit varchar(100),@educationID int,@certID varchar(50),@courseID varchar(50),@projectID varchar(50),@host varchar(50),@err int,@exist int,@existOther int,@null int,@Tai int,@msg varchar(50)
	declare @retireDay int, @enterID int, @refID int
	select @dept1=0, @dept2=0, @unit=null, @educationID=0,@err=0,@exist=0,@existOther=0,@null=0,@oldNo=(case when @oldNo>0 then @oldNo else 0 end),@Tai=charindex('̨',@username),@host='znxf',@username = upper(@username), @tax= UPPER(replace(dbo.whenull(@tax,''),' ','')), @address=REPLACE(dbo.whenull(@address,''),' ','')
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
		select @unit=@dept1Name,@companyID=deptID from deptInfo where host='znxf' and pID=0	--������λ������ѧУ
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
			select @err=1	-- ���֤����
	end
	else
	begin
		-- ע��ѧԱ
		if not exists(select 1 from studentInfo where username=@username)	-- �¼�¼
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
			select @existOther=1,@msg=iif(@retireDay=1,'��ѧԱ�Ѿ����ݲ���60�죬���ܱ�����','����18�겻�ܱ�����')
	
		if @err=0 and @existOther=0
		begin
			-- ����Ƿ��ѱ�����ͬ�Ŀγ̣�δ��ࣩ���������ɾ��
			select @enterID=ID,@refID=refID from studentCourseList where username=@username and courseID=@courseID and status<2 and classID is null
			if @enterID>0
			begin
				delete from studentCourseList where ID=@enterID
				delete from studentCertList where ID=@refID
				select @enterID=0
			end

			-- �������༶ע���
			if exists(select 1 from studentCourseList where username=@username and courseID=@courseID and status<2 and classID>'' and classID<>@classID)
				select @existOther=1,@msg=max(SNo) from studentCourseList where username=@username and courseID=@courseID and status<2 and classID>'' and classID<>@classID		--����������ע���
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
							select @title=item from dictionaryDoc where kind='SPCtitle'	--�������͵Ĳ��ţ�ѡȡʯ����˾ͳһ��Ʊ��Ϣ
					end
				end
				--������λ��Ϊδ���ѡ��󸶷�
				if @host not in('znxf','spc','shm')
					select @payNow = 1
				-- ע��γ�
				--@ID,@username,@classID,@price,@amount,@invoice,@projectID,@title,@payNow,@needInvoice,@kindID,@type,@status,@datePay,@dateInvoice,@dateInvoicePick,@pay_memo,@currDiplomaID,@currDiplomaDate,@overdue,@fromID,@oldNo,@memo,@registerID
				select @price=price from projectInfo where projectID=@projectID
				if not exists(select 1 from studentCourseList where username=@username and courseID=@courseID and classID=@classID)
					exec @enterID=doEnter 0,@username,@classID,@price,0,'','',0,@projectID,@title,@payNow,0,0,0,0,'','','','','',@currDiplomaDate,0,0,@fromID,0,'',@oldNo,@memo,@host,@registerID
				else
					select @exist=1		--���ڱ���ע���
			end
		end
	end

	select @err as err, @exist as exist, @existOther as existOther, @null as errNull, @username as username,@name as name,isnull(@msg,'') as msg, @enterID as enterID
END
GO

------------------
-- CREATE DATE: 2020-05-24
-- ���ݸ����Ĳ�������ӻ��߸��µ���ѧԱ�ɼ���Ϣ
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
		--result:1 �ϸ� 2 ���ϸ񣬽����γ�
		select @refID=refID from studentCourseList where ID=@enterID
		update passcardInfo set score=@score0,status=(case when @score0>=@scorePass then 1 else 2 end) where passNo=@passNo
		update studentCertList set result=(case when @score0>=@scorePass then 1 else 2 end),status=(case when @score0>=@scorePass then 2 else status end),score=@score0,closeDate=(case when @score0>=@scorePass then getDate() else null end) where ID=@refID
		update studentCourseList set status=2,endDate=getDate(),closeDate=getDate() where ID=@enterID and @score0>=@scorePass
		select @re=0
		exec writeOpLog '','����ɼ�','generateScore',@registerID,@score0,@enterID
	end

	return @re
END
GO

-- =============================================
-- CREATE Date: 2020-05-10
-- Description:	���ݸ��������ͱ�ţ���д���������ͼƬ��¼��
-- Use Case:	exec generateMaterial 'C5','spc','admin.'
-- =============================================
CREATE PROCEDURE [dbo].[generateMaterial] 
	@kindID varchar(50), @qty int, @host varchar(50), @registerID varchar(50)
AS
BEGIN
	declare @re int
	--��д���ɼ�¼
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
		select @fields = @fields + 'hostName as ��˾,'
		select @order = dbo.getOrderStatement(@order,'��˾')
	end
	if @groupDept1 = 1
	begin
		select @group = dbo.getGroupStatement(@group,'dept1Name')
		select @fields = @fields + 'dept1Name as ����,'
		select @order = dbo.getOrderStatement(@order,'����')
	end
	if @groupKindID = 1
	begin
		select @group = dbo.getGroupStatement(@group,'kindName')
		select @fields = @fields + 'kindName as ���,'
		select @order = dbo.getOrderStatement(@order,'���')
	end
	if @groupDate = 'month'
	begin
		select @group = dbo.getGroupStatement(@group,'left(regDate,7)')
		select @fields = @fields + 'left(regDate,7) as �·�,'
		select @order = dbo.getOrderStatement(@order,'�·�')
	end
	if @groupDate = 'quarter'
	begin
		select @group = dbo.getGroupStatement(@group,'cast(left(regDate,4) as varchar)+''' + '.' + '''+cast(DATEPART(QUARTER, regDate) as varchar)')
		select @fields = @fields + 'cast(left(regDate,4) as varchar)+''' + '.' + '''+cast(DATEPART(QUARTER, regDate) as varchar) as ����,'
		select @order = dbo.getOrderStatement(@order,'����')
	end
	if @groupDate = 'year'
	begin
		select @group = dbo.getGroupStatement(@group,'left(regDate,4)')
		select @fields = @fields + 'left(regDate,4) as ���,'
		select @order = dbo.getOrderStatement(@order,'���')
	end
	
	--prepare sql statment
	select @sql = N'select ' + @fields + 'count(*) as ���� from v_studentInfo' + @where + @group + @order
	
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
		select @fields = @fields + 'hostName as ��˾,'
		select @order = dbo.getOrderStatement(@order,'��˾')
	end
	if @groupDept1 = 1
	begin
		select @group = dbo.getGroupStatement(@group,'dept1Name')
		select @fields = @fields + 'dept1Name as ����,'
		select @order = dbo.getOrderStatement(@order,'����')
	end
	if @groupKindID = 1
	begin
		select @group = dbo.getGroupStatement(@group,'kindName')
		select @fields = @fields + 'kindName as ���,'
		select @order = dbo.getOrderStatement(@order,'���')
	end
	if @groupCourseID = 1
	begin
		select @group = dbo.getGroupStatement(@group,'courseName')
		select @fields = @fields + 'courseName as �γ�,'
		select @order = dbo.getOrderStatement(@order,'�γ�')
	end
	if @groupStatus = 1
	begin
		select @group = dbo.getGroupStatement(@group,'statusName')
		select @fields = @fields + 'statusName as ״̬,'
		select @order = dbo.getOrderStatement(@order,'״̬')
	end
	if @groupDate = 'day'
	begin
		select @group = dbo.getGroupStatement(@group,'regDate')
		select @fields = @fields + 'regDate as ����,'
		select @order = dbo.getOrderStatement(@order,'����')
	end
	if @groupDate = 'month'
	begin
		select @group = dbo.getGroupStatement(@group,'left(regDate,7)')
		select @fields = @fields + 'left(regDate,7) as �·�,'
		select @order = dbo.getOrderStatement(@order,'�·�')
	end
	if @groupDate = 'quarter'
	begin
		select @group = dbo.getGroupStatement(@group,'cast(left(regDate,4) as varchar)+''' + '.' + '''+cast(DATEPART(QUARTER, regDate) as varchar)')
		select @fields = @fields + 'cast(left(regDate,4) as varchar)+''' + '.' + '''+cast(DATEPART(QUARTER, regDate) as varchar) as ����,'
		select @order = dbo.getOrderStatement(@order,'����')
	end
	if @groupDate = 'year'
	begin
		select @group = dbo.getGroupStatement(@group,'left(regDate,4)')
		select @fields = @fields + 'left(regDate,4) as ���,'
		select @order = dbo.getOrderStatement(@order,'���')
	end
	
	--prepare sql statment
	select @sql = N'select ' + @fields + 'count(*) as ���� from v_studentCourseList' + @where + @group + @order
	
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
		select @fields = @fields + 'hostName as ��˾,'
		select @order = dbo.getOrderStatement(@order,'��˾')
	end
	if @groupDept1 = 1
	begin
		select @group = dbo.getGroupStatement(@group,'dept1Name')
		select @fields = @fields + 'dept1Name as ����,'
		select @order = dbo.getOrderStatement(@order,'����')
	end
	if @groupKindID = 1
	begin
		select @group = dbo.getGroupStatement(@group,'kindName')
		select @fields = @fields + 'kindName as ���,'
		select @order = dbo.getOrderStatement(@order,'���')
	end
	if @groupAgencyID = 1
	begin
		select @group = dbo.getGroupStatement(@group,'agencyName')
		select @fields = @fields + 'agencyName as ��֤����,'
		select @order = dbo.getOrderStatement(@order,'��֤����')
	end
	if @groupCertID = 1
	begin
		select @group = dbo.getGroupStatement(@group,'certName')
		select @fields = @fields + 'certName as ֤������,'
		select @order = dbo.getOrderStatement(@order,'֤������')
	end
	if @groupStatus = 1
	begin
		select @group = dbo.getGroupStatement(@group,'statusName')
		select @fields = @fields + 'statusName as ״̬,'
		select @order = dbo.getOrderStatement(@order,'״̬')
	end
	if @groupDate = 'month'
	begin
		select @group = dbo.getGroupStatement(@group,'left(startDate,7)')
		select @fields = @fields + 'left(startDate,7) as �·�,'
		select @order = dbo.getOrderStatement(@order,'�·�')
	end
	if @groupDate = 'quarter'
	begin
		select @group = dbo.getGroupStatement(@group,'cast(left(startDate,4) as varchar)+''' + '.' + '''+cast(DATEPART(QUARTER, startDate) as varchar)')
		select @fields = @fields + 'cast(left(startDate,4) as varchar)+''' + '.' + '''+cast(DATEPART(QUARTER, startDate) as varchar) as ����,'
		select @order = dbo.getOrderStatement(@order,'����')
	end
	if @groupDate = 'year'
	begin
		select @group = dbo.getGroupStatement(@group,'left(startDate,4)')
		select @fields = @fields + 'left(startDate,4) as ���,'
		select @order = dbo.getOrderStatement(@order,'���')
	end
	
	--prepare sql statment
	select @sql = N'select ' + @fields + 'count(*) as ���� from v_diplomaInfo' + @where + @group + @order
	
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
		select @fields = @fields + 'hostName as ��˾,'
		select @order = dbo.getOrderStatement(@order,'��˾')
	end
	if @groupDept1 = 1
	begin
		select @group = dbo.getGroupStatement(@group,'dept1Name')
		select @fields = @fields + 'dept1Name as ����,'
		select @order = dbo.getOrderStatement(@order,'����')
	end
	if @groupKindID = 1
	begin
		select @group = dbo.getGroupStatement(@group,'kindName')
		select @fields = @fields + 'kindName as ���,'
		select @order = dbo.getOrderStatement(@order,'���')
	end
	if @groupAgencyID = 1
	begin
		select @group = dbo.getGroupStatement(@group,'agencyName')
		select @fields = @fields + 'agencyName as ��֤����,'
		select @order = dbo.getOrderStatement(@order,'��֤����')
	end
	if @groupCertID = 1
	begin
		select @group = dbo.getGroupStatement(@group,'certName')
		select @fields = @fields + 'certName as ֤������,'
		select @order = dbo.getOrderStatement(@order,'֤������')
	end
	if @groupStatus = 1
	begin
		select @group = dbo.getGroupStatement(@group,'statusName')
		select @fields = @fields + 'statusName as ״̬,'
		select @order = dbo.getOrderStatement(@order,'״̬')
	end
	if @groupDate = 'month'
	begin
		select @group = dbo.getGroupStatement(@group,'left(endDate,7)')
		select @fields = @fields + 'left(endDate,7) as �·�,'
		select @order = dbo.getOrderStatement(@order,'�·�')
	end
	if @groupDate = 'quarter'
	begin
		select @group = dbo.getGroupStatement(@group,'cast(left(endDate,4) as varchar)+''' + '.' + '''+cast(DATEPART(QUARTER, endDate) as varchar)')
		select @fields = @fields + 'cast(left(endDate,4) as varchar)+''' + '.' + '''+cast(DATEPART(QUARTER, endDate) as varchar) as ����,'
		select @order = dbo.getOrderStatement(@order,'����')
	end
	if @groupDate = 'year'
	begin
		select @group = dbo.getGroupStatement(@group,'left(endDate,4)')
		select @fields = @fields + 'left(endDate,4) as ���,'
		select @order = dbo.getOrderStatement(@order,'���')
	end
	
	--prepare sql statment
	select @sql = N'select ' + @fields + 'count(*) as ���� from v_diplomaLastInfo' + @where + @group + @order
	
	--exec sql statment
	if @fields > ''
		exec sp_executesql @sql
END
GO

-- =============================================
-- CREATE Date: 2020-06-25
-- Description:	��дSQL���ִ��log��
-- Use Case:	exec writeSQLlog @sql,@params,@username,@ip,@host
-- =============================================
CREATE PROCEDURE [dbo].[writeSQLlog] 
	@sql varchar(4000), @params varchar(4000), @username varchar(50), @ip varchar(50), @host varchar(50)
AS
BEGIN
	--��д���ɼ�¼
	if @sql='updateStudentInfo' or @sql='updateStudentPassword' or @sql='addStudentCert' or @sql='delStudentCert' or @sql='submit_student_feedback'
		insert into SQLlog(sql,params,username,ip,host) values(@sql,@params,@username,@ip,@host)
END
GO

-- =============================================
-- CREATE Date: 2020-06-25
-- Description:	�ϲ����ţ�ԭ��������ͬһ���ϼ����š�
-- @id:deptID list with split ','   @deptName���ϲ���������
-- Use Case:	exec mergeDepts @id,@deptName,@username
-- =============================================
ALTER PROCEDURE [dbo].[mergeDepts] 
	@id varchar(1000),@deptName nvarchar(100), @registerID varchar(50)
AS
BEGIN
	--��ȡ�ϲ����ŵĸ���,ȡ�б��е�һ��deptID��Ϊ�ϲ�Ŀ��
	declare @n int, @deptID int,@oid int,@merge nvarchar(1000), @host varchar(50)
	select @n = [dbo].[pf_getStrArrayLength](@id,','), @deptID = [dbo].[pf_getStrArrayOfIndex](@id,',',0),@merge=''
	select @host=host from deptInfo where deptID=@deptID
	update deptInfo set deptName=@deptName where deptID=@deptID
	--�ϲ�
	while @n>1	--��һ�����Ų����ϲ�
	begin
		select @oid = [dbo].[pf_getStrArrayOfIndex](@id,',',@n-1)
		select @merge = @merge + ',' + deptName from deptInfo where deptID=@oid
		delete from deptInfo where pID=@oid		--ɾ���¼�����
		delete from deptInfo where deptID=@oid		--ɾ�����ϲ�����
		update studentInfo set dept1=@deptID where dept1=@oid	--�޸ı��ϲ����ŵ�ѧԱ
		update studentInfo set dept2=@deptID where dept2=@oid	--�޸ı��ϲ����ŵ�ѧԱ
		update studentInfo set dept3=@deptID where dept3=@oid	--�޸ı��ϲ����ŵ�ѧԱ
		select @n = @n - 1
	end
	select @merge = @deptName + @merge
	--д��־
	exec writeOpLog @host,'�ϲ�����','mergeDepts',@registerID,@merge,@ID
END
GO


-- =============================================
-- CREATE Date: 2020-05-09
-- Description:	���ݸ��������ݣ�����ѧԱ���롣
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
-- Description:	��д���ŷ���log��
-- Use Case:	exec writeSSMSlog @sql,@params,@username,@ip,@host
-- =============================================
ALTER PROCEDURE [dbo].[writeSSMSlog] 
	@message nvarchar(500), @mobile varchar(50), @kind varchar(50), @username varchar(50),@refID varchar(50), @registerID varchar(50)
AS
BEGIN
	--��д���ɼ�¼
	if @refID=''
		set @refID=null
	insert into log_sendsms(message,mobile,kind,username,refID,registerID) values(@message,@mobile,@kind,@username,@refID,@registerID)
END
GO

-- CREATE DATE: 2020-08-03
-- ���ݸ����Ĳ�������ӻ��߸����Ծ���Ϣ
-- USE CASE: exec updateExamInfo 1,1,'xxxx'...
CREATE PROCEDURE [dbo].[updateExamInfo]
	@ID int,@certID varchar(50),@courseID varchar(50),@examID varchar(50),@examName varchar(100),@scoreTotal int,@scorePass int,@minutes int,@kindID int,@status int,@memo varchar(500),@registerID varchar(50)
AS
BEGIN
	if @certID=''
		set @certID=null
	if @courseID=''
		set @courseID=null

	if @ID=0	-- �¼�¼
	begin
		insert into examInfo(certID,courseID,examID,examName,scoreTotal,scorePass,minutes,kindID,status,memo,registerID) values(@certID,@courseID,@examID,@examName,@scoreTotal,@scorePass,@minutes,@kindID,@status,@memo,@registerID)
	end
	else
	begin
		update examInfo set kindID=@kindID,certID=@certID,courseID=@courseID,examID=@examID,examName=@examName,scoreTotal=@scoreTotal,scorePass=@scorePass,minutes=@minutes,status=@status,memo=@memo where ID=@ID
	end
END

-- CREATE DATE: 2020-08-04
-- ���ݸ����Ĳ�������ӻ��߸�����������Ϣ
-- USE CASE: exec updateExamRuleInfo 1,1,'xxxx'...
CREATE PROCEDURE [dbo].[updateExamRuleInfo]
	@ID int,@examID varchar(50),@knowPointID varchar(50),@typeID int,@qty int,@scorePer decimal(18,1),@kindID int,@status int,@memo varchar(500),@registerID varchar(50)
AS
BEGIN
	if @knowPointID=''
		set @knowPointID=null

	if @ID=0	-- �¼�¼
	begin
		insert into examRuleInfo(knowPointID,examID,typeID,qty,scorePer,kindID,status,memo,registerID) values(@knowPointID,@examID,@typeID,@qty,@scorePer,@kindID,@status,@memo,@registerID)
	end
	else
	begin
		update examRuleInfo set kindID=@kindID,knowPointID=@knowPointID,examID=@examID,typeID=@typeID,qty=@qty,scorePer=@scorePer,status=@status,memo=@memo where ID=@ID
	end
END

-- CREATE DATE: 20111223
-- Description:	д��ִ�����ݸ�����ִ���͡����ñ�ʶ���û��������ɻ�ִ��¼
-- Use case:exec setReturnLog 'task','2','user1','spc'
-- =============================================
ALTER PROCEDURE [dbo].[setReturnLog] 
	@kindID varchar(50),@refID varchar(50),@userID varchar(50),@host varchar(50)
AS
BEGIN
	-- �����û�л�ִ������ӻ�ִ������������
	if exists(select 1 from returnReceiptList where kindID=@kindID and refID=@refID and userName=@userID and receiptDate is null)
		update returnReceiptList set receiptDate=getDate() where kindID=@kindID and refID=@refID and userName=@userID
	if not exists(select 1 from returnReceiptList where kindID=@kindID and refID=@refID and userName=@userID)
		insert into returnReceiptList(receiptDate,userName,kindID,refID,host) values (getDate(),@userID,@kindID,@refID,@host)
END
GO

-- CREATE DATE: 2020-10-30
-- ���ݸ����Ĳ�������ӻ��߸��·�������ѵ��Ŀ��Ϣ
-- USE CASE: exec updateProjectInfo 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updateProjectInfo]
	@ID int,@projectID varchar(50),@projectName varchar(100),@courseID varchar(50),@object varchar(50),@address varchar(200),@deadline varchar(50),@kindID int,@linker varchar(50),@mobile varchar(50),@phone varchar(50),@email varchar(50),@price int,@payKind int,@payGroup int,@host varchar(50),@dept varchar(500),@memo varchar(2000),@registerID varchar(50)
AS
BEGIN
	declare @certID varchar(50),@reexamine int, @serial int
	select @certID=certID,@reexamine=reexamine from courseInfo where courseID=@courseID
	if @deadline='' or @deadline='null'
		set @deadline=null

	if @ID=0	-- �¼�¼
	begin
		declare @code varchar(50)
		--exec setAutoCode @host,@certID,@code output, @serial output		--��ȡ֤����
		exec setAutoCode '','Pro',@code output,@serial out		--��ȡ֤����
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
-- ��������ͨ��
-- USE CASE: exec setProjectStatus 1, '����', 'albert'
-- =============================================
ALTER PROCEDURE [dbo].[setProjectStatus] 
	@ID int,@status int,@username varchar(50)
AS
BEGIN
	if @status=9
		delete from projectInfo where ID=@ID
	else
		update projectInfo set status=@status where ID=@ID
	-- д������־
	declare @event varchar(50),@mem varchar(500)
	--exec writeOpLog @host,@event,'user',@registerID,@memo,@refID
	select @event=item,@mem='' from dictionaryDoc where kind='statusIssue' and ID=@status
	exec writeOpLog '',@event,'project',@username,@mem,@ID
END

GO

-- =============================================
-- CREATE DATE: 2020-11-28
-- Ϊ�����������ε�ѧԱ���
-- USE CASE: exec setProjectStudentNo 'P-20-001', 'albert'
-- =============================================
CREATE PROCEDURE [dbo].[setProjectStudentNo] 
	@projectID varchar(50),@username varchar(50)
AS
BEGIN
	update studentCourseList set SNo=a.rank1 from (select ID,RANK() over(order by ID) as rank1 from studentCourseList where projectID=@projectID and checked=1) a where a.ID=studentCourseList.ID
	-- д������־
	declare @event varchar(50),@mem varchar(500)
	--exec writeOpLog @host,@event,'user',@registerID,@memo,@refID
	select @event='��ѧ��',@mem=''
	exec writeOpLog '',@event,'projectStudentNo',@username,@mem,@projectID
END

GO

-- =============================================
-- CREATE Date: 2020-10-08
-- Description:	ȷ�ϱ�����Ա�б�
-- @status: 1 ȷ��  2 �ܾ�
-- @selList: �����������ö��ŷָ���username in studentCourseList
-- Use Case:	exec doStudentCourse_check 1,'...','spc','admin.'
-- =============================================
ALTER PROCEDURE [dbo].[doStudentCourse_check] 
	@status int, @classID varchar(50), @selList varchar(4000), @host varchar(50), @registerID varchar(50)
AS
BEGIN
	declare @re int

	--���������뵽��ʱ��
	create table #temp_studentCheck(id varchar(50), classStatus int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_studentCheck(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	update #temp_studentCheck set classStatus=c.status from #temp_studentCheck a, studentCourseList b, classInfo c where b.classID=c.classID and a.id=b.username and b.classID=@classID

	--�޸ı�����Ա״̬  �ѽ����༶����Ա�����޸�
	update studentCourseList set checked=@status,checkDate=GETDATE(),checker=@registerID from #temp_studentCheck a where studentCourseList.username=a.id and studentCourseList.classID=@classID and a.classStatus<2
	set @re=@@rowcount
	return @re
END
GO

-- =============================================
-- CREATE Date: 2020-10-08
-- Description:	ȷ�ϱ�����Ա�б�
-- @status: 1 ȷ��  2 �ܾ�
-- @selList: �����������ö��ŷָ���ID in studentCourseList
-- Use Case:	exec doStudentPre_check 1,'...','spc','admin.'
-- =============================================
ALTER PROCEDURE [dbo].[doStudentPre_check] 
	@status int, @selList varchar(4000), @host varchar(50), @registerID varchar(50)
AS
BEGIN
	declare @re int

	--���������뵽��ʱ��
	create table #temp_studentCheck(id varchar(50))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_studentCheck(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	--�޸ı�����Ա״̬  �ѽ������Ա�����޳�
	update studentCourseList set checked=@status,checkDate=GETDATE(),checker=@registerID from #temp_studentCheck a where studentCourseList.ID=a.id and (@status=1 or (@status=2 and studentCourseList.classID = ''))
	set @re=@@rowcount
	return @re
END
GO

-- =============================================
-- CREATE Date: 2020-10-08
-- Description:	�����������߱�����Ա��ࡣ
-- @selList: �����������ö��ŷָ���ID in studentCourseList
-- Use Case:	exec doStudentPre_check 1,'...','spc','admin.'
-- =============================================
ALTER PROCEDURE [dbo].[pickStudents4Class] 
	@classID varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @re int, @ID int, @certID varchar(50),@payID int

	--���������뵽��ʱ��
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
			--���¸���״̬
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
-- Description:	�������İ༶��ѡ������Աת���µİ༶��
-- @selList: �����������ö��ŷָ���username in studentCourseList in class
-- Use Case:	exec [pickStudents2Class] '...','spc','admin.'
-- =============================================
ALTER PROCEDURE [dbo].[pickStudents2Class] 
	@classID varchar(50), @selList varchar(4000), @oldClassID varchar(50), @registerID varchar(50)
AS
BEGIN
	declare @re int, @ID int, @cID int, @pNo varchar(50), @mark varchar(50)
	select @pNo = ''
	select @cID=ID from classInfo where classID=@classID

	--���������뵽��ʱ��
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
-- Description:	�����İ༶��ѡ������Ա����֧�����ͣ�Ԥ����/�󸶷�,δ��/�Ѹ�����
-- @selList: �������ö��ŷָ���username in studentCourseList in class
-- @payNow: ����λ������ɣ���һλ��Ԥ����/�󸶷ѣ��ڶ�λ��δ��/�Ѹ�
-- Use Case:	exec [pickStudents2Paynow] '1','124223xxx','122'
-- =============================================
ALTER PROCEDURE [dbo].[pickStudents2Paynow] 
	@payNow varchar(50), @selList varchar(4000), @classID varchar(50), @registerID varchar(50)
AS
BEGIN
	declare @re int, @logMemo nvarchar(500)

	--���������뵽��ʱ��
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
	-- д������־
	select @logMemo=@selList + ':' + @payNow
	exec writeOpLog '','����֧����ʽ','pickStudents2Paynow',@registerID,@logMemo,@classID

	select @re as re
END
GO

-- =============================================
-- CREATE Date: 2021-02-17
-- Description:	���ݸ������������ţ�������ύ������Ա�б�
-- @status: 1 ȷ��  2 �ܾ�
-- @selList: �����������ö��ŷָ���ID in studentCourseList
-- Use Case:	exec doStudentCourse_submit 'P-20-005',1,'...','spc','admin.'
-- =============================================
ALTER PROCEDURE [dbo].[doStudentCourse_submit] 
	@projectID varchar(50), @status int, @selList varchar(4000), @host varchar(50), @registerID varchar(50)
AS
BEGIN
	declare @re int

	--���������뵽��ʱ��
	create table #temp_studentSubmit(id int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_studentSubmit values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	--�޸ı�����Ա״̬�����Ѿ�����ѧԱ�������ύ��������δȷ�ϵĲ����ύ��
	update studentCourseList set submited=@status,submitDate=GETDATE(),submiter=@registerID from #temp_studentSubmit a where studentCourseList.ID=a.id and studentCourseList.classID=0 and studentCourseList.checked=1
	set @re=@@rowcount
	return @re
END
GO

-- =============================================
-- CREATE Date: 2021-02-17
-- Description:	���ݸ�������Ա�б�������Ϊ�Ӽ�/���Ӽ���ԭ��δ�Ӽ��ĸ�Ϊ�Ӽ���ԭ���Ӽ��ĸ�Ϊ���Ӽ���
-- @selList: �������ö��ŷָ���ID in studentCourseList
-- Use Case:	exec set_students_express '...','spc','admin.'
-- =============================================
ALTER PROCEDURE [dbo].[set_students_express] 
	@selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @re int

	--���������뵽��ʱ��
	create table #temp_studentSubmit(id int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_studentSubmit values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	--�޸ı�����Ա״̬����δ�Ӽ�����Ϊ�Ӽ����ѼӼ��ĸ�Ϊ���Ӽ���
	update studentCourseList set express=(case when express=0 then 1 else 0 end) from #temp_studentSubmit a where studentCourseList.ID=a.id
	set @re=@@rowcount
	return @re
END
GO

-- =============================================
-- CREATE Date: 2021-02-14
-- Description:	���ݸ��������ݣ�ID+�������ͣ���֪ͨѧԱ�����ϴ�����ͼƬ��
-- @status: 1 ֪ͨ  3 �ر�
-- @selList: �������ö��ŷָ���ID in studentCourseList + '|' + kindID
-- Use Case:	exec doStudentMaterial_resubmit 1,'...','admin.'
-- =============================================
ALTER PROCEDURE [dbo].[doStudentMaterial_resubmit] 
	@status int, @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @re int

	--���������뵽��ʱ��
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

	if @status=1	--����֪ͨ
	begin
		delete from studentMaterialsAsk where ID in(select a.ID from studentMaterialsAsk a, #temp_studentBadPhoto b where a.refID=b.id and a.kindID=b.kindID)
		insert into studentMaterialsAsk(refID,kindID,status,askerID,askDate) select id,kindID,@status,@registerID,getDate() from #temp_studentBadPhoto
		--����ͳ��
		--ϵͳ֪ͨ
		declare @username varchar(50), @host varchar(50), @item nvarchar(4000), @name varchar(50)
		declare rc cursor for select b.username,b.host,c.item,b.name from #temp_studentBadPhoto a, v_studentCourseList b, dictionaryDoc c where a.ID=b.ID and a.kindID=c.ID and c.kind='material'
		open rc
		fetch next from rc into @username,@host,@item,@name
		While @@fetch_status=0 
		Begin 
			--ϵͳ֪ͨ
			--@username varchar(50),@kindID int,@item nvarchar(4000), @host varchar(50), @user varchar(50)
			select @item = @name + '������ˣ����ύ��' + @item + '��ͼƬ���ϲ�����Ҫ�����޸ĺ������ϴ���лл��'
			exec sendSysMessage @username,1,@item,@host,@registerID
			fetch next from rc into @username,@host,@item,@name
		End
		Close rc 
		Deallocate rc
		--����֪ͨ
		--��дservice��¼
		insert into studentServiceInfo(username,mobile,item,refID,vID,kindID,type,status,host,registerID) select username,mobile, '����ˣ����ύ��' + item + '��ͼƬ���ϲ�����Ҫ�����޸ĺ������ϴ���лл��',id,kindID,0,0,2,host,@registerID from #temp_studentBadPhoto
	end

	if @status=3	--�ر�
	begin
		update a set a.status=@status,a.closerID=@registerID,a.closerDate=getDate() from studentMaterialsAsk a, #temp_studentBadPhoto b where a.refID=b.id and a.kindID=b.kindID
		--����service��¼
		update studentServiceInfo set status=0,memo=isnull(memo,'') + '���ύ��ȷ�ϣ�' + @registerID + ' ' + convert(varchar(50),getDate(),20) + '��' from studentServiceInfo a, #temp_studentBadPhoto b where a.refID=b.id and a.vID=b.kindID
		--����ͳ��
	end

	select name,item,mobile,username,host from #temp_studentBadPhoto
END
GO

-- =============================================
-- CREATE DATE: 2020-11-10
-- ��ʱ�Զ���������
-- USE CASE: exec plan_dailyCheck
-- =============================================
ALTER PROCEDURE [dbo].[plan_dailyCheck] 
AS
BEGIN
	--����ѧԱ����
	update studentInfo set age=dbo.getAgefromID(username) where len(username)=18
	update studentInfo set age=datediff(yy,birthday,getDate()) where len(username)<>18 and birthday>''
	--������������Ƿ����
	update projectInfo set status=2 where status=1 and DATEDIFF(d,deadline,getDate())>0
	--����û��Ƿ����
	update userInfo set status=1 where status<1 and limitedDate<getDate()
	--���֤���Ƿ����
	update diplomaInfo set status=1 where status<1 and endDate<getDate()
	--��鿼���Ƿ����
	update generatePasscardInfo set status=1 where status<1 and DATEDIFF(d,startDate,getDate())>0
	--���༶�Ƿ����
	update classInfo set status=2 where status<2 and DATEDIFF(d,dateEnd,getDate())>30
	--��������60��δ��εģ��Զ�����: ��Ŀ������ſ����±������γ̽������ܼ�������
	--update studentCertList set status=2,closeDate=getDate() where status<2  and ID in(select refID from studentCourseList where status<2 and classID>''  and DATEDIFF(d,regDate,getDate())>60)
	--update studentCourseList set status=2,closeDate=getDate() where status<2 and classID>''  and DATEDIFF(d,regDate,getDate())>90
	--����֤����Զ�����
	update studentCourseList set status=2,closeDate=getDate() where status<2 and hold=0 and refID in(select ID from studentCertList where status<2 and diplomaID>'')
	update studentCertList set status=2,closeDate=getDate() where status<2 and hold=0 and diplomaID>'' 
	--�ѹرյ�������Ŀ��ɾ�����޳�����Ա
	exec dealNoCheckedEnters
	--ɾ����ѵ��Ŀ�г������޲����Լ�ɾ������δ��ɵĿγ�
	exec deal_expireEnterInner
	--�������ݿ�
	BACKUP DATABASE elearning TO   DISK = N'D:\project\dbback\elearning.bak' WITH INIT, NOFORMAT
END
GO

-- CREATE DATE: 2021-02-18
-- ���ݸ����Ĳ�������ӻ��߸���ѧԱ������Ϣ
-- USE CASE: exec updateStudentServiceInfo 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updateStudentServiceInfo]
	@ID int,@username varchar(50),@item nvarchar(4000),@refID int,@type int,@serviceDate varchar(50),@private int,@memo varchar(2000),@registerID varchar(50)
AS
BEGIN
	if @serviceDate='' set @serviceDate=convert(varchar(20),GETDATE(),23)
	
	if @ID=0	-- �¼�¼
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
-- ���ݸ����Ĳ�������ӻ��߸��°༶��Ϣ
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

	--�����һ���ַ����Ƿָ���������ɾ��
	if left(@projectID,1)=','
		set @projectID = right(@projectID,len(@projectID)-1)
			
	if @ID=0	-- �¼�¼
	begin
		if @pre=0 or (@pre = 1 and not exists(select 1 from classInfo where pre=1 and courseID=@courseID and host=@host))	--ÿ����Ŀ��Ԥ����ֻ�ܴ���һ��
		begin
			declare @code varchar(50),@nickName varchar(50)
			if @certID='' and @projectID>''
				select @certID=certID from projectInfo where projectID=@projectID
			select @kind = 'CLS' + @certID
			exec setAutoCode '',@kind,@code output, @serial output		--��ȡ���
			if getDate()>='2022-01-01'
			begin
				--�Զ���д�༶���� 202201Σ������
				select @nickName=nickName from certificateInfo where certID=@certID
				if @certID='C21' or @certID='C20' or @certID='C20A'
				begin
					--��������Ա������ţ��������
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
		--����ѧԱ��ǩ������
		if exists(select 1 from classInfo where ID=@ID and signatureType<>@signatureType)
			update studentCourseList set signatureType=@signatureType from studentCourseList a, classInfo b where a.classID=b.classID and b.ID=@ID
		update classInfo set archiver=(case when @archived=1 and archiver is null then @registerID else archiver end),archiveDate=(case when @archived=1 and archiveDate is null then getDate() else archiveDate end),className=@className,certID=@certID,courseID=@courseID,projectID=@projectID,adviserID=@adviserID,host=@host,teacher=@teacher,kindID=@kindID,status=@status,dateStart=@dateStart,dateEnd=@dateEnd,classroom=@classroom,timetable=@timetable,summary=@summary,transaction_id=@transaction_id,signatureType=@signatureType,memo=@memo where ID=@ID
	end
	select @ID as re
END
GO

-- CREATE DATE: 2015-01-12
-- ���ݸ����Ĳ�����ɾ���༶���ݣ���д��־
-- ����༶��ѧ��������ɾ����
-- USE CASE: exec delClassInfo 1
CREATE PROCEDURE [dbo].[delClassInfo]
	@classID varchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @re int, @msg varchar(50)
	select @re=0,@msg='�ɹ�ɾ����'
	if exists(select 1 from classInfo where classID=@classID)
	begin
		if not exists(select 1 from studentCourseList where classID=@classID)
		begin
			delete from classInfo where classID=@classID
			-- д������־
			exec writeOpLog '','ɾ���༶','class',@registerID,@memo,@classID
		end
		else
			select @re=2,@msg='�ð༶����ѧԱ������ɾ����'
	end
	else
		select @re=1,@msg='û��Ҫɾ���ļ�¼��'

	select @re as i, @msg as msg
END

GO

-- CREATE DATE: 2021-04-08
-- ���ݸ����Ĳ�������ӻ��߸��½ɷ���Ϣ
-- USE CASE: exec updatePayInfo 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updatePayInfo]
	@ID int,@invoice varchar(50),@projectID varchar(50),@title nvarchar(100),@kindID varchar(50),@type int,@status int,@datePay varchar(50),@dateInvoice varchar(50),@dateInvoicePick varchar(50),@username varchar(50),@memo varchar(2000),@registerID varchar(50),@re int output
AS
BEGIN
	declare @event varchar(50),@payGroup int,@i int,@deptID int
	if @datePay='' set @datePay=null
	if @dateInvoice='' set @dateInvoice=null
	if @dateInvoicePick='' set @dateInvoicePick=null
	
	if @ID=0	-- �¼�¼
	begin
		select @payGroup = payGroup,@i=0 from projectInfo where projectID=@projectID
		select @deptID=dept1 from studentInfo where username=@username
		--���巢Ʊֻ����һ��
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
			select @event='����',@ID=max(ID) from payInfo where registerID=@registerID and projectID=@projectID
		end
	end
	else
	begin
		update payInfo set invoice=@invoice,projectID=@projectID,title=@title,kindID=@kindID,type=@type,status=@status,datePay=@datePay,dateInvoice=@dateInvoice,dateInvoicePick=@dateInvoicePick,memo=@memo where ID=@ID
		select @event='�޸�'
	end
	-- д������־
	exec writeOpLog '',@event,'pay',@registerID,@invoice,@ID
	select @re=@ID
END
GO

-- CREATE DATE: 2021-04-08
-- ���ݸ����Ĳ��������·�Ʊ���
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
-- ���ݸ����Ĳ��������½ɷѽ������·�Ʊ���
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
-- �жϸ���ѧԱ����ָ���γ��Ƿ����䡣���Ϊ����ǰ60���Ϸ���0�����䣬����1 ���䣬����2 ����18�ꡣ
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
-- Ϊ�����������εĸ���ѧԱ����
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
	select @re=0,@msg=iif(@ID=0,'�����ɹ���','����ɹ���'),@hasLesson=0, @datePay=[dbo].[whenull](@datePay,null), @username=upper(@username), @host=[dbo].[whenull](@host,''), @receipt=[dbo].[whenull](@receipt,null),@receipt0='', @source=[dbo].[whenull](@source,null)
	select @cID = ID, @signatureType=signatureType, @pre=pre from classInfo where classID=@classID
	if @source is null
		select @source=title from hostInfo where hostNo=@host and @host<>'znxf'

	if @ID=0	--�µı���
	begin
		select @SNo=0,@mark=0,@retireDay=1000
		if @projectID=''	--����༶������
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
			select @re=1,@msg='�ÿγ��Ѿ�������δ�����������ظ���'
		if @retireDay>0
			select @re=2,@msg=iif(@retireDay=1,'��ѧԱ�Ѿ����ݲ���60�죬���ܱ�����','����18�겻�ܱ�����')

		if @re=0
		begin
			--���֤����Ŀ
			select @host = iif(@host='',host,@host),@name=name,@job_status=job_status,@education=education,@unit=(case when host='znxf' then unit else hostName end),@address=address,@mobile=mobile,@email=email from v_studentInfo where username=@username
			insert into studentCertList(username,certID,reexamine,host,registerID) values(@username,@certID,@reexamine,@host,@registerID)
			select @refID=max(ID) from studentCertList where username=@username
			select @t=type,@certName=certName,@today=convert(varchar(20),getDate(),23) from certificateInfo where certID=@certID
			--if @host not in('znxf','shm','spc') and @price=0
			--	select @status=1	--������λĬ���Ѹ�
			--������λ��Ϊδ���ѡ��󸶷�
			if @host not in('znxf','spc','shm')
				select @payNow = 1, @status=0
			
			--��ӿγ�
			--��Ԥ����������ұ��
			exec lookRefSNo @cID, @username, @name, @pNo output, @mark output
			declare @saler varchar(50)
			exec [setStudentSaler] @username, @fromID, @saler output
			--select @title=(case when @title>'' then @title else invoice end) from ref_student_spc where username=@username and classID=@cID
			--Ԥ����������Ա�Զ�ȷ�ϣ�mark=0 , checked=1
			--insert into studentCourseList(username,courseID,refID,reexamine,type,hours,closeDate,projectID,classID,SNo,checked,checkDate,checker,submited,submitDate,submiter,host,registerID) select @username,courseID,@refID,@reexamine,@t,hours,dateadd(d,period,getDate()),@projectID,@classID,@pNo,(case when @mark=0 then 1 else 0 end),(case when @mark=0 then getDate() else null end),(case when @mark=0 then 'system.' else null end),1,getDate(),@registerID,@host,@registerID from courseInfo where courseID=@courseID
			insert into studentCourseList(username,courseID,refID,reexamine,payNow,needInvoice,title,pay_kindID,pay_type,pay_status,price,amount,noReceive,invoice,receipt,invoice_amount,dateInvoice,dateInvoicePick,datePay,pay_checker,pay_memo,type,hours,closeDate,projectID,classID,SNo,checked,checkDate,checker,submited,submitDate,submiter,currDiplomaID,currDiplomaDate,overdue,express,fromID,fromKind,source,oldNo,signatureType,memo,host,registerID) 
				select @username,courseID,@refID,@reexamine,@payNow,@needInvoice,@title,@kindID,@type,@status,@price,@amount,iif(@type=3 and @status=1,1,0),@invoice,@receipt,@invoice_amount,[dbo].[whenull](@dateInvoice,null),[dbo].[whenull](@dateInvoicePick,null),iif(@datePay>'',@datePay,iif(@status=1,getDate(),null)),iif(@status=1,@registerID,null),@pay_memo,@t,hours,dateadd(d,period,getDate()),@projectID,@classID,@pNo,1,getDate(),'system.',1,getDate(),@registerID,@currDiplomaID,@currDiplomaDate,@overdue,@express,@saler,@fromKind,@source,@oldNo,@signatureType,@memo,@host,@registerID from courseInfo where courseID=@courseID
			select @ID=max(ID) from studentCourseList where username=@username
	
			if @certID='C20' or @certID='C20A' or @certID='C21'	--����Ա��Ӷ��ⱨ����Ϣ
				insert into firemanEnterInfo(enterID,kind5,kind4,registerID) values(@ID,(case when @certID='C20' or @certID='C20A' then 3 else 4 end),(case when @certID='C20A' then 1 else 0 end),@registerID)

			--���µ�λ��Ϣ
			if @host='spc'
				update studentInfo set linker=(case when a.linker is null then b.linker else a.linker end), phone=(case when a.phone is null then b.phone else a.phone end), address=(case when a.address is null then b.address else a.address end) from studentInfo a, deptInfo b where a.dept2=b.deptID and a.username=@username

			-- д������־
			--exec writeOpLog @host,@event,'user',@registerID,@memo,@refID
			select @event='����',@mem=@projectID
			exec writeOpLog '',@event,'enter',@registerID,@mem,@ID

			--��HRϵͳ��������
			--exec eHR.[dbo].[updateResumeInfo1] @username,@name,'Z00001',0,@job_status,0,@unit,@education,@mobile,@email,'',@address,'','','','',0,'','system.'
			--exec eHR.[dbo].updateHunterDetail 0,'education',@username,'�Ϻ���������ѧУ',@certName,@today,'',0,'','system.'
		end
	end
	else	--�޸ı�����Ϣ
	begin
		declare @oldClass varchar(50), @autoPay int
		select @oldClass=classID, @pNo=SNo, @autoPay=autoPay,@courseID=courseID, @receipt0=isnull(receipt,'') from studentCourseList where ID=@ID
		
		if @classID>'' and (@classID <> @oldClass or @pNo='0')
		begin
			--���ұ��,,submited,,
			exec lookRefSNo @cID, @username, @name, @pNo output, @mark output
		end
		--�ȱ����¼
		insert into del_studentCourseList select *,getDate(),'�޸ı�����Ϣ:' + @registerID from studentCourseList where ID=@ID
		if @autoPay=0
		begin
			if @dateInvoice>'' and @invoice>'' and exists(select 1 from studentCourseList where ID=@ID and (dateInvoice is null or dateInvoice=''))
				update studentCourseList set dateInvoice=@dateInvoice where invoice=@invoice and ID<>@ID	--���巢Ʊ���¿�Ʊ����
			update studentCourseList set source=iif(@source>'',@source,source),host=@host,overdue=@overdue,express=@express,fromID=dbo.whenull(@fromID,null),fromKind=@fromKind,classID=@classID,SNo=@pNo,noReceive=iif(@type=3 and @status=1 and noReceive=0,1,noReceive),checked=1,checkDate=iif(checkDate is null,getDate(),checkDate),checker=iif(checker is null,@registerID,checker),submited=1,submitDate=iif(submitDate is null,getDate(),submitDate),submiter=iif(submiter is null,@registerID,submiter),pay_memo=@pay_memo,signatureType=@signatureType,payNow=@payNow,needInvoice=@needInvoice,title=@title,pay_kindID=@kindID,pay_type=@type,pay_status=@status,price=@price,amount=@amount,invoice=@invoice,receipt=@receipt,invoice_amount=@invoice_amount,dateInvoice=[dbo].[whenull](@dateInvoice,null),dateInvoicePick=[dbo].[whenull](@dateInvoicePick,null),datePay=iif(@datePay>'' and @status>0,@datePay,iif(@status=1 and pay_status=0 and datePay is null,getDate(),datePay)),pay_checker=iif(@status=1 and pay_status=0 and pay_checker is null,@registerID,pay_checker),currDiplomaID=@currDiplomaID,currDiplomaDate=@currDiplomaDate,memo=@memo where ID=@ID
		end
		else
			update studentCourseList set source=@source,host=@host,overdue=@overdue,express=@express,fromID=dbo.whenull(@fromID,null),fromKind=@fromKind,classID=@classID,SNo=@pNo,checked=1,checkDate=iif(checkDate is null,getDate(),checkDate),checker=iif(checker is null,@registerID,checker),submited=1,submitDate=iif(submitDate is null,getDate(),submitDate),submiter=iif(submiter is null,@registerID,submiter),signatureType=@signatureType,needInvoice=@needInvoice,title=iif(autoInvoice=0,@title,title),invoice=iif(autoInvoice=0,@invoice,invoice),receipt=@receipt,invoice_amount=iif(autoInvoice=0,@invoice_amount,invoice_amount),dateInvoice=iif(autoInvoice=0,[dbo].[whenull](@dateInvoice,null),dateInvoice),dateInvoicePick=[dbo].[whenull](@dateInvoicePick,null),currDiplomaID=@currDiplomaID,currDiplomaDate=@currDiplomaDate,memo=@memo where ID=@ID
		select @event='�޸ı�����Ϣ',@mem=''
		exec writeOpLog '',@event,'enter',@registerID,@mem,@ID

		if exists(select 1 from studentLessonList where refID=@ID)
			select @hasLesson = 1
	end

	if @ID>0 and @receipt>'' and @receipt0=''	  -- ��������վݺ���
		update dictionaryDoc set item=@receipt where kind='receipt' and ID='0'

	if @ID>0 and @hasLesson = 0	  -- ��ӿα���Ϣ
	begin
		--��ӿα�
		insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,b.ID,a.hours,@username from lessonInfo a, studentCourseList b where a.courseID=b.courseID and b.ID=@ID and a.status=0

		--��ӿμ�
		insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,@username from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0

		--�����Ƶ
		insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,@username from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0
	end

	if @ID>0 and not exists(select 1 from studentExamList where refID=@ID)	  -- ��ӿ�����Ϣ
	begin
		--��ӿ��ԣ���Ŀ�ݲ�����
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
-- Ϊ����ѧԱ�������п�ѡ�γ̣���ѡ�ĸ��ǣ���������༶
-- USE CASE: exec [doEnterDemo] 'P-20-001', 'albert'
-- =============================================
ALTER PROCEDURE [dbo].[doEnterDemo] 
	@username varchar(50)
AS
BEGIN
	declare @certID varchar(50),@courseID varchar(50),@host varchar(50),@refID int,@t int,@re int,@msg varchar(50),@mark int,@ID int,@reexamine int,@pNo varchar(50),@certName varchar(60),@unit varchar(100),@job_status int,@education int,@mobile varchar(50),@email varchar(50),@address varchar(200),@today varchar(50)
	
	--ɾ����ѡ�γ�
	delete from studentCoursewareList where refID in(select a.ID from studentLessonList a, studentCourseList b where a.refID=b.ID and b.username=@username)
	delete from studentVideoList where refID in(select a.ID from studentLessonList a, studentCourseList b where a.refID=b.ID and b.username=@username)
	delete from studentQuestionList where refID in(select a.paperID from studentExamList a, studentCourseList b where a.refID=b.ID and b.username=@username)
	delete from studentLessonList where refID in(select ID from studentCourseList where username=@username)
	delete from studentExamList where refID in(select ID from studentCourseList where username=@username)
	delete from studentCertList where username=@username
	delete from studentCourseList where username=@username

	--���ҿ�ѡ�γ�
	declare rc cursor for select certID,courseID,reexamine from courseInfo where status=0 and host=''
	open rc
	fetch next from rc into @certID,@courseID,@reexamine
	While @@fetch_status=0 
	Begin 
		--���֤����Ŀ
		insert into studentCertList(username,certID,reexamine,host) values(@username,@certID,@reexamine,'znxf')
		select @refID=max(ID) from studentCertList where username=@username
		select @t=type,@certName=certName,@today=convert(varchar(20),getDate(),23) from certificateInfo where certID=@certID

		--��ӿγ�
		insert into studentCourseList(username,courseID,refID,reexamine,type,hours) select @username,courseID,@refID,@reexamine,@t,hours from courseInfo where courseID=@courseID
		select @ID=max(ID) from studentCourseList where username=@username

		--��ӿα�
		insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,b.ID,a.hours,@username from lessonInfo a, studentCourseList b where a.courseID=b.courseID and b.ID=@ID and a.status=0

		--��ӿμ�
		insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,@username from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0

		--�����Ƶ
		insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,@username from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0

		--��ӿ��ԣ���Ŀ�ݲ�����
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
-- ȷ��ĳ���������Ϻϸ�
-- USE CASE: exec [doMaterial_check] 1
CREATE PROCEDURE [dbo].[doMaterial_check]
	@ID int,@registerID varchar(50)
AS
BEGIN
	update studentCourseList set materialCheck=1,materialChecker=@registerID where ID=@ID
END
GO

-- CREATE DATE: 2024-08-20
-- ���ݸ����Ĳ�����ɾ���������ݣ���д��־
-- USE CASE: exec delEnter 1
ALTER PROCEDURE [dbo].[delEnter]
	@ID int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @refID int,@kind int,@n int,@mark int,@re int,@msg varchar(100)
	select @re=1,@msg='δ����Ҫɾ��������'
	if exists(select 1 from diplomaInfo a, v_studentCourseList b where a.diplomaID=b.diplomaID and b.ID=@ID)
		select @re=2,@msg='�˴���ѵ��ȡ��֤�飬����ɾ����'
	if exists(select 1 from studentCourseList where ID=@ID and pay_status>0)
		select @re=3,@msg='�����շѼ�¼������ɾ����'
	if @re<2 and exists(select 1 from studentCourseList where ID=@ID)
	begin
		select @refID=refID,@mark=0,@memo=isnull(@memo,'') + '(' + username + ',' + name + ',' + courseName + ',' + classID + ')' from v_studentCourseList where ID=@ID

		--ɾ������
		delete from studentQuestionList where refID in(select paperID from studentExamList where refID=@ID and mark=@mark)

		--ɾ������
		delete from studentExamList where refID=@ID and mark=@mark

		--ɾ����Ƶ
		delete from studentVideoList where refID in(select ID from studentLessonList where refID=@ID)

		--ɾ���μ�
		delete from studentCoursewareList where refID in(select ID from studentLessonList where refID=@ID)

		--ɾ���α�
		delete from studentLessonList where refID=@ID
		--ɾ���γ�
			--�ȱ����¼
		insert into del_studentCourseList select *,getDate(),@memo + ':' + @registerID from studentCourseList where ID=@ID
		delete from studentCourseList where ID=@ID
		--ɾ��֤����Ŀ
		delete from studentCertList where ID=@refID
		/*
		select @refID=payID from payDetailInfo where enterID=@ID
		select @n=count(*) from payDetailInfo where payID=@refID
		select @kind=kindID from payInfo where ID=@refID
		--���������ɷѣ�ֻ��ʣһ���˵�ʱ���ɾ����Ʊ������ɾ��Ʊ�����¼��㿪Ʊ���
		if @n>1
			exec updatePayAmount @refID
		else
			delete from payInfo where ID=@refID
			
		delete from payDetailInfo where enterID=@ID
		*/
		-- д������־
		exec writeOpLog '','ɾ��','enter',@registerID,@memo,@ID
		select @re=0,@msg='�ɹ�ɾ��'

		if exists(select 1 from passcardInfo where enterID=@ID)
		begin
			select @re=0,@msg='�ɹ�ɾ��������ѧԱ�Ѿ�����׼��֤�������µ���׼��֤���������ݡ�'
			delete from passcardInfo where enterID=@ID
		end
	end
	select @re as status,@msg as msg
END
GO

-- CREATE DATE: 2015-01-12
-- ���ݸ����Ĳ����������˿δ�����д��־
-- USE CASE: exec returnEnter 1
CREATE PROCEDURE [dbo].[returnEnter]
	@ID int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @refID int,@kind int,@n int,@mark int,@re int,@msg varchar(100)
	select @re=1,@msg='δ����Ҫ���������'
	if exists(select 1 from diplomaInfo a, v_studentCourseList b where a.diplomaID=b.diplomaID and b.ID=@ID)
		select @re=2,@msg='�˴���ѵ��ȡ��֤�飬�����˿Ρ�'
	if @re<2 and exists(select 1 from studentCourseList where ID=@ID)
	begin
		select @refID=refID,@mark=0,@memo=isnull(@memo,'') + '(' + username + ',' + name + ',' + courseName + ',' + classID + ')' from v_studentCourseList where ID=@ID
		--ɾ���γ�
		update studentCourseList set status=3 where ID=@ID
		--ɾ��֤����Ŀ
		update studentCertList set status=3 where ID=@refID

		-- д������־
		exec writeOpLog '','�˿�','enter',@registerID,@memo,@ID
		select @re=0,@msg='�ɹ��˿�'
	end
	select @re as status,@msg as msg
END
GO

-- CREATE DATE: 2021-04-06
-- ���ݸ����Ĳ�������ӻ��߸���׼��֤��Ϣ
-- mark: 0 ����׼��֤  1 ������Ϣ
-- USE CASE: exec updateGeneratePasscardInfo 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updateGeneratePasscardInfo]
	@mark int,@ID int,@classID varchar(50),@title nvarchar(100), @selList varchar(4000),@startNo int,@startDate varchar(100),@startTime varchar(100),@address nvarchar(100),@notes nvarchar(500),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @n int, @j int, @i int, @re int,@sql varchar(500)
	select @re=@ID

	if @ID=0 and @mark=0	-- �¼�¼
	begin
		create table #temp(id int) 
		select @sql ='ALTER table #temp add num int IDENTITY(' + cast(@startNo as varchar) + ',1) NOT NULL'
		exec(@sql)
		if @startDate='' or @startDate = 'null'
			select @startDate = null

		--��ȡ����
		select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
		while @n>@j
		begin
			insert into #temp values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
			select @j = @j + 1
		end

		--��д���ɼ�¼
		insert into generatePasscardInfo(classID,title,qty,startNo,startDate,startTime,address,notes,memo,registerID) values(@classID,@title,@n,@startNo,@startDate,@startTime,@address,@notes,@memo,@registerID)
		select @re=max(ID) from generatePasscardInfo where registerID=@registerID and classID=@classID

		--��д��ϸ
		insert into passcardInfo(refID,enterID,passNo,password) select @re,b.id,replace(@startDate,'-','') + REPLICATE('0',3-len(b.num)) + cast(b.num as varchar),right(a.username,6) from studentCourseList a, #temp b where a.ID=b.id 

		--���±�����
		update studentCourseList set passcardID=@re from studentCourseList a, #temp b where a.ID=b.id
	end
	if @ID>0 and @mark=1	-- ������Ϣ
	begin
		update generatePasscardInfo set classID=@classID,title=@title,startDate=@startDate,startTime=@startTime,address=@address,notes=@notes,memo=@memo where ID=@ID
	end
	return @re
END
GO

-- CREATE DATE: 2021-04-06
-- ���ݸ����Ĳ�������ӻ��߸��¿�����Ϣ
-- USE CASE: exec updateGeneratePasscardInfo1 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updateGeneratePasscardInfo1]
	@ID int,@certID varchar(50),@title nvarchar(100),@startNo int,@kindID int,@startDate varchar(100),@startTime varchar(100),@address nvarchar(100),@notes nvarchar(500),@sync int,@sniper varchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @re int, @event varchar(100),@logMemo varchar(500)
	select @re=@ID

	if @ID=0	-- �¼�¼
	begin
		--��д���ɼ�¼
		insert into generatePasscardInfo(certID,title,startNo,kindID,startDate,startTime,address,notes,sync,sniper,memo,registerID) values(@certID,@title,@startNo,@kindID,@startDate,@startTime,@address,@notes,@sync,@sniper,@memo,@registerID)
		select @re=max(ID),@event='��ӿ���' from generatePasscardInfo where registerID=@registerID
	end
	if @ID>0	-- ������Ϣ
	begin
		update generatePasscardInfo set title=@title,kindID=@kindID,startDate=@startDate,startTime=@startTime,address=@address,notes=@notes,sync=@sync,sniper=@sniper,memo=@memo where ID=@ID
		select @event='�޸Ŀ���'
	end
	-- д������־
	select @logMemo=isnull(@title,'') + ':' + isnull(@startDate,'') + ':' + isnull(@startTime,'') + ':' + isnull(@address,'') + ':' + isnull(@notes,'') + ':' + isnull(@memo,'')
	exec writeOpLog '',@event,'generatePasscard',@registerID,@logMemo,@re
	select @re as re
END
GO

-- CREATE DATE: 2021-04-08
-- Ϊ׼��֤��¼д���ļ�
-- USE CASE: exec [updateGeneratePasscardFile] 1,'xxxx.pdf'
CREATE PROCEDURE [dbo].[updateGeneratePasscardFile]
	@ID int,@filename varchar(200)
AS
BEGIN
	update generatePasscardInfo set filename=@filename where ID=@ID
END
GO

-- CREATE DATE: 2015-01-12
-- ���ݸ����Ĳ�����ɾ��׼��֤���ݣ���д��־
-- USE CASE: exec delGeneratePasscard 1
ALTER PROCEDURE [dbo].[delGeneratePasscard]
	@ID int,@registerID varchar(50)
AS
BEGIN
	if exists(select 1 from generatePasscardInfo where ID=@ID)
	begin
		delete from generatePasscardInfo where ID=@ID
		-- ɾ����ؿ�����׼��֤
		delete from passcardInfo where refID=@ID
		update studentCourseList set passcardID=0 where passcardID=@ID
		-- д������־
		exec writeOpLog '','ɾ��׼��֤','generatePasscard',@registerID,'',@ID
	end
END
GO

-- CREATE DATE: 2015-01-12
-- ���ݸ����Ĳ��������¸�ѵ֤����
-- USE CASE: exec setReexamineDiploma 1,'xxx-22'
CREATE PROCEDURE [dbo].[setReexamineDiploma]
	@enterID int,@item varchar(100)
AS
BEGIN
	update studentCourseList set currDiplomaID=@item where ID=@enterID
END
GO


-- CREATE DATE: 2015-01-12
-- ���ݸ����Ĳ������رգ���д��־
-- USE CASE: exec closeClassInfo 1
ALTER PROCEDURE [dbo].[closeClassInfo]
	@ID int, @status int ,@registerID varchar(50)
AS
BEGIN
	declare @classID varchar(50)
	if exists(select 1 from classInfo where ID=@ID)
	begin
		update classInfo set status=@status,dateEnd=(case when @status=2 and dateEnd is null then getDate() else dateEnd end) where ID=@ID
		-- �رձ�����Ϣ
		select @classID=classID from classInfo where ID=@ID
		--if @status=2  --�ر�
		--begin
			--update studentCourseList set status=2, closeDate=getDate() where classID=@classID
			--update studentCertList set status=2, closeDate=getDate() from studentCertList a, studentCourseList b where a.ID=b.refID and b.classID=@classID
		--end
		-- д������־
		declare @event varchar(20)
		select @event = (case when @status=0 then '�༶����' when @status=2 then '�༶���' else '�༶' end)
		exec writeOpLog '',@event,'class',@registerID,'',@ID
	end
END
GO

-- CREATE DATE: 2015-01-12
-- ���ݸ����Ĳ������ر�ѧԱ�Ŀγ�ѧϰ����д��־
-- USE CASE: exec closeStudentCourse 1
CREATE PROCEDURE [dbo].[closeStudentCourse]
	@ID int, @registerID varchar(50)
AS
BEGIN
	if exists(select 1 from studentCourseList where ID=@ID)
	begin
		update studentCourseList set status=2, closeDate=getDate() where ID=@ID
		update studentCertList set status=2, closeDate=getDate() from studentCertList a, studentCourseList b where a.ID=b.refID and b.ID=@ID
		-- д������־
		declare @event varchar(20)
		select @event = '�ر�ѧϰ'
		exec writeOpLog '',@event,'studentCourse',@registerID,'',@ID
	end
END
GO

-- CREATE DATE: 2015-01-12
-- ���ݸ����Ĳ����������ر�/����ѧԱ�Ŀγ�ѧϰ����д��־
-- selList: username
-- USE CASE: exec closeStudentCourseBatch 1
ALTER PROCEDURE [dbo].[closeStudentCourseBatch]
	@classID varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	--���������뵽��ʱ��
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
	-- д������־
	declare @event varchar(20)
	select @event = '�ر�/����ѧϰ'
	exec writeOpLog '',@event,'studentCourse',@registerID,'',@selList
END
GO

-- CREATE DATE: 2023-01-11
-- ���ݸ����Ĳ����������ѹر�ѧԱ�Ŀγ�ѧϰ����д��־
-- USE CASE: exec reviveStudentCourse 1
CREATE PROCEDURE [dbo].[reviveStudentCourse]
	@ID int, @registerID varchar(50)
AS
BEGIN
	if exists(select 1 from studentCourseList where ID=@ID)
	begin
		update studentCourseList set status=1, closeDate=null where ID=@ID
		update studentCertList set status=1, closeDate=null from studentCertList a, studentCourseList b where a.ID=b.refID and b.ID=@ID
		-- д������־
		declare @event varchar(20)
		select @event = '����ѧϰ'
		exec writeOpLog '',@event,'studentCourse',@registerID,'',@ID
	end
END
GO


-- CREATE DATE: 2021-04-06
-- ���ݸ����Ĳ�������ӻ��߸�������Ա������Ϣ
-- USE CASE: exec updateFiremanEnterInfo 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updateFiremanEnterInfo]
	@enterID int,@area varchar(50),@address varchar(100),@employDate varchar(50),@university varchar(100),@gradeDate varchar(50),@profession varchar(50),@area_now varchar(50),@kind1 int,@kind2 int,@kind3 int,@kind4 int,@kind5 int,@kind6 int,@kind7 int,@kind8 int,@kind9 int,@kind10 int,@kind11 int,@kind12 int,@memo varchar(500),@registerID varchar(50)
AS
BEGIN
	declare @re int, @msg varchar(100)
	if @employDate='' set @employDate=null
	if @gradeDate='' set @gradeDate=null
	
	if not exists(select 1 from firemanEnterInfo where enterID=@enterID)	-- �¼�¼
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
-- ���ݸ����Ĳ�������д����Ա���������ļ�·��
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
-- ���ݸ����Ĳ�������д���֤�������ļ�·��
-- USE CASE: exec updateIDcardsMaterials 1
CREATE PROCEDURE [dbo].[updateIDcardsMaterials]
	@username varchar(50),@filename varchar(200)
AS
BEGIN
	update studentInfo set IDa_filename=@filename where username=@username
END
GO

-- CREATE DATE: 2021-05-13
-- ���ݸ����Ĳ�������д����Ա���������ļ�·��
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
-- ���ݸ����Ĳ�������д���������ļ�·��
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
-- ���ݸ����Ĳ�������дѧԱ���������ļ�·��
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
-- ��������Ա��������
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
		--�����Ա
		if not exists(select 1 from studentInfo where username=@username)
			insert into studentInfo(host,userName,name,kindID,companyID,dept1,job_status,mobile,education,unit,birthday,sex,age,registerID) 
				values(@host,upper(@username),@name,0,@companyID,@deptID,0,@mobile,@edu,@unit,substring(@username,7,8),dbo.getSexfromID(@username),dbo.getAgefromID(@username),@registerID)
		select @certID=certID,@reexamine=reexamine from projectInfo where projectID=@projectID
		select @courseID=courseID from courseInfo where certID=@certID and reexamine=@reexamine
		if not exists(select 1 from studentCourseList where username=@username and courseID=@courseID and status<2)
		begin
			--���֤����Ŀ
			insert into studentCertList(username,certID,host,registerID) values(@username,@certID,@host,@registerID)
			select @refID=max(ID) from studentCertList where username=@username
			select @t=type from certificateInfo where certID=@certID

			--��ӿγ�
			insert into studentCourseList(username,courseID,refID,reexamine,type,hours,closeDate,projectID,classID,SNo,host,registerID) select @username,courseID,@refID,@reexamine,@t,hours,dateadd(d,period,getDate()),@projectID,@classID,isnull(@SNo,0),@host,@registerID from courseInfo where certID=@certID and reexamine=@reexamine
			select @ID=max(ID) from studentCourseList where username=@username
	
			--����Ա��ӱ�����Ϣ
			insert into firemanEnterInfo(enterID,kind1,kind2,kind4,kind5,kind6,kind10,kind11,kind12,registerID) values(@ID,0,2,(case when @courseID='L20A' then 1 else 0 end),(case when @courseID='L20' or @courseID='L20A' then 3 else 4 end),0,(case when @host='shm' then 3 else 5 end),(case when len(@unit)<4 then 1 else 0 end),@edu1,@registerID)

			--��Ӹ����¼
			exec updatePayInfo 0,'',@projectID,@name,@kindID,@type,@status,'','','',@username,@memo,@registerID,@payID output

			--��Ӹ�����ϸ
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
-- ���ݸ����Ĳ������޸İ༶��Ϣ�ͱ��
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
			--��Ԥ����������ұ��
			exec lookRefSNo @cID, @username, @name, @pNo output, @mark output
		end
		else
			select @pNo = @SNo

		/**/
		--update studentCourseList set classID=@classID,SNo=@pNo,submited=1,submitDate=(case when submitDate is null then GETDATE() else submitDate end),submiter=@registerID,checked=(case when @mark=0 then 1 else checked end),checkDate=(case when @mark=0 then GETDATE() else checkDate end),checker=(case when @mark=0 and checker is null then 'system.' else checker end) where ID=@enterID
		update studentCourseList set payNow=iif(@payNow<9,@payNow,payNow),title=iif(@title>'',@title,title),signatureDate=iif(@signatureDate is null,signatureDate,@signatureDate),status=(case when @diplomaID='' and status=2 then 0 else status end),classID=@classID,SNo=@pNo,overdue=@overdue,submited=iif(@classID>'',1,submited),submitDate=(case when @classID>'' and submitDate is null then GETDATE() else submitDate end),submiter=iif(@classID>'',@registerID,submiter),checked=iif(@classID>'',1,checked),checkDate=(case when @classID>'' and checkDate is null then GETDATE() else checkDate end),checker=(case when @classID>'' and checker is null then 'system.' else checker end),currDiplomaID=(case when @currDiplomaID is null then currDiplomaID else @currDiplomaID end),currDiplomaDate=(case when @currDiplomaDate is null then currDiplomaDate else @currDiplomaDate end),fromID=@fromID,signatureType=@signatureType where ID=@enterID
		update studentCertList set status=(case when @diplomaID='' and status=2 then 0 else status end) where ID=@refID
		if @certID='C20' or @certID='C20A' or @certID='C21' and not exists(select 1 from firemanEnterInfo where enterID=@enterID)	--����Ա��Ӷ��ⱨ����Ϣ
			insert into firemanEnterInfo(enterID,kind4,kind5,registerID) values(@enterID,(case when @certID='C20A' then 1 else 0 end),(case when @certID='C20' then 3 else 4 end),@registerID)

		if not exists(select 1 from studentLessonList where refID=@enterID)
		begin
			--��ӿα�
			insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,b.ID,a.hours,@username from lessonInfo a, studentCourseList b where a.courseID=b.courseID and b.ID=@enterID and a.status=0

			--��ӿμ�
			insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,@username from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@enterID and a.status=0

			--�����Ƶ
			insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,@username from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@enterID and a.status=0

			--��ӿ��ԣ���Ŀ�ݲ�����
			if exists(select 1 from  examInfo where courseID=@courseID)
				insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,kind,mark) select @username,examID,@enterID,minutes,minutes*60,scoreTotal,scorePass,kindID,0,0 from examInfo where (courseID=@courseID or (courseID is null and certID=@certID)) and status=0
			else
				insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,kind,mark) select @username,examID,@enterID,minutes,minutes*60,scoreTotal,scorePass,kindID,0,0 from examInfo where certID=@certID and status=0
		end
	end
END
GO

-- CREATE DATE: 2021-05-13
-- ���ݸ����Ĳ�������ȡ�����ε�֤���б�
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
			--SELECT ID,(case when @certID='C2' then '��ȼ�ױ�Σ����Ʒ��ҵ��Ա' when @certID='C31' then '������ҵ' else certName end) as title,diplomaID,username,name,sexName,birthday,certID,(case when @certID='C31' then '������ҵ' else certName end) as certName,startDate,endDate,term,(case when host<>'spc' and host<>'shm' then unit when host='spc' and kindID=1 then dept1Name when host='spc' and dept1=9 then '�Ϻ�ʯ�ͷֹ�˾��������' else hostName end) as hostName,(case when host='spc' and dept1=9 and job='' then '��Ʒ���˹�' else job end) as job,educationName,'No.' + replace(space(7-len(serial))+cast(serial as varchar),' ','0') as diplomaNo,photo_filename,[dbo].[fn_formatDate](class_startDate,0) as class_startDate,[dbo].[fn_formatDate](class_endDate,0) as class_endDate FROM v_diplomaInfo where batchID=@batchID order by diplomaID
			SELECT ID,(case when @certID='C2' then '��ȼ�ױ�Σ����Ʒ��ҵ��Ա' else certName end) as title,diplomaID,username,name,sexName,birthday,certID,certName,startDate,endDate,term,(case when host<>'spc' and host<>'shm' then unit when host='spc' and kindID=1 then dept1Name when host='spc' and dept1=9 then '�Ϻ�ʯ�ͷֹ�˾��������' else hostName end) as hostName,(case when host='spc' and dept1=9 and job='' then '��Ʒ���˹�' else job end) as job,educationName,'No.' + replace(space(7-len(serial))+cast(serial as varchar),' ','0') as diplomaNo,photo_filename,[dbo].[fn_formatDate](class_startDate,0) as class_startDate,[dbo].[fn_formatDate](class_endDate,0) as class_endDate FROM v_diplomaInfo where batchID=@batchID order by diplomaID
	end
END
GO


-- CREATE DATE: 2021-04-06
-- ���ݸ����Ĳ�������ӻ��߸���֤����Ϣ
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

	if @ID=0	-- �¼�¼
	begin
		--��ȡ����
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
		--��ֹ�ظ�����֤��
		delete from #temp where id in(select b.ID from #temp a, studentCertList b where a.id=b.ID and b.diplomaID>'')
		select @n=count(*) from #temp
		
		--��д���ɼ�¼
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
				exec setAutoCode @host,@certID,@code output, @serial out		--��ȡ֤����
				--����֤�飬֤�鷢������Ϊ��������
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
		--��������֤��
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
-- ���ݸ����Ĳ���������֤����Ϣ
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
	-- д������־
	exec writeOpLog '','֤�������޸�','updateGenerateDiplomaMemo',@registerID,'',@ID
END
GO

-- CREATE DATE: 2021-05-13
-- ���ݸ����Ĳ����������������Ϳ���֪ͨ
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
		declare rc cursor for select username,'�𾴵�' + a.name + '��������' + b.startDate + '�μ�' + b.certName + '���ԣ�' + (case when @kindID=0 then '�ص�Ϊ' + b.address + '����Я�����֤��׼��֤���ٵ�15���Ӳ����볡��' when @kindID=1 then '��ʽΪ�ֻ����߿��ԣ��վ����밴�涨ʱ���¼ϵͳ���Ķ�������֪���ٵ�15���ӽ��޷����롣' else '' end),a.host from v_passcardInfo a, v_generatePasscardInfo b where a.refID=b.ID and b.ID=@batchID
		open rc
		fetch next from rc into @username,@item,@host
		While @@fetch_status=0 
		Begin 
			--0 �ظ� 1 ֪ͨ 2 ����
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item,@host
		End
		Close rc 
		Deallocate rc
		update generatePasscardInfo set send = send + 1,sendDate=getDate(),sender=@registerID where ID=@batchID
	end
	--return students list for send mobile message
	select name,username,mobile,b.certName,a.enterID, b.startDate as dt, b.address,'�𾴵�' + a.name + '��������' + b.startDate + '�μ�' + b.certName + '���ԣ�' + (case when @kindID=0 then '�ص�Ϊ' + b.address + '����Я�����֤��׼��֤���ٵ�15���Ӳ����볡��' when @kindID=1 then '��ʽΪ�ֻ����߿��ԣ��վ����밴�涨ʱ���¼ϵͳ���Ķ�������֪���ٵ�15���ӽ��޷����롣' else '' end) as item, @kindID as kindID from v_passcardInfo a, v_generatePasscardInfo b where a.refID=b.ID and b.ID=@batchID
END
GO

-- CREATE DATE: 2021-05-13
-- ���ݸ����Ĳ����������������Ϳ���֪ͨ(���걨�ɹ���)
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
		declare rc cursor for select username,'�𾴵�' + a.name + '��������' + examDate + '�μ�' + b.courseName + '���ԣ��ص�Ϊ' + b.address + '����Я�����֤��׼��֤���ٵ�15���Ӳ����볡��',a.host from v_applyInfo a, v_generateApplyInfo b where a.refID=b.ID and b.ID=@batchID and a.examDate>'' -- and a.statusApply=1
		open rc
		fetch next from rc into @username,@item,@host
		While @@fetch_status=0 
		Begin 
			--0 �ظ� 1 ֪ͨ 2 ����
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item,@host
		End
		Close rc 
		Deallocate rc
		update generateApplyInfo set send = send + 1,sendDate=getDate(),sender=@registerID where ID=@batchID
	end
	--return students list for send mobile message
	select name,username,mobile,b.courseName as certName,a.enterID, examDate as dt, b.address,'�𾴵�' + a.name + '��������' + examDate + '�μ�' + b.courseName + '���ԣ��ص�Ϊ' + b.address + '����Я�����֤��׼��֤���ٵ�15���Ӳ����볡��' as item from v_applyInfo a, v_generateApplyInfo b where a.refID=b.ID and b.ID=@batchID and a.examDate>'' -- and a.statusApply=1
END
GO

-- CREATE DATE: 2021-05-13
-- ���ݸ����Ĳ����������������Ϳ���֪ͨ
-- batchID: classInfo.classID; selList: username list
-- USE CASE: exec sendMsg4Class 1
ALTER PROCEDURE [dbo].[sendMsg4Class]
	@batchID varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50),@startDate varchar(50),@endDate varchar(50),@address varchar(100),@certName varchar(50),@kindID int
	--send system message
	--���������뵽��ʱ��
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
		declare rc cursor for select b.username,b.name + '������' + @startDate + '�μ�' + @certName + (case when @kindID=0 then '��ѵ��' + @address + ',Я�����֤ԭ�����ʼǱ��ͱʡ�' else '������ѵ��ע���ڹ涨ʱ������ɿγ�ѧϰ����ģ�⿼����ȡ�����óɼ�������Ӱ�쿼�Ժ�ȡ֤��' end) from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
		open rc
		fetch next from rc into @username,@item
		While @@fetch_status=0 
		Begin 
			--0 �ظ� 1 ֪ͨ 2 ����
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item
		End
		Close rc 
		Deallocate rc
		update classInfo set send = send + 1,sendDate=getDate(),sender=@registerID where classID=@batchID
		--return students list for send mobile message
		select b.name,b.username,b.mobile,@certName as certName, b.ID as enterID, @startDate as dt,@address as address,b.name + '������' + @startDate + '��' + @endDate + '�μ�' + @certName + (case when @kindID=0 then '��ѵ��' + @address + '��Я�����֤ԭ�����ʼǱ��ͱʡ�' else '������ѵ��ע���ڹ涨ʱ������ɿγ�ѧϰ����ģ�⿼����ȡ�����óɼ�������Ӱ�쿼�Ժ�ȡ֤��' end) as item, @kindID as kindID from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
	end
END
GO

-- CREATE DATE: 2025-08-17
-- ���ݸ����Ĳ����������������;���֪ͨ
-- batchID: classInfo.classID; selList: username list
-- USE CASE: exec sendMsg4Competition 1
ALTER PROCEDURE [dbo].[sendMsg4Competition]
	@batchID varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50),@startDate varchar(50),@endDate varchar(50),@address varchar(100),@certName varchar(50),@kindID int
	--send system message
	--���������뵽��ʱ��
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
		declare rc cursor for select b.username,'�繤�߼���������������¥�����Ա�߼���������������յ�ϵͳ��װά�޹��߼��������������࿪ʼ������9����Ѯ��ѵ11�¿��ԡ�ͨ���������������������л����ö��⽱����ѯ�绰��021-52132119����һ������8:30-16:30��' from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
		open rc
		fetch next from rc into @username,@item
		While @@fetch_status=0 
		Begin 
			--0 �ظ� 1 ֪ͨ 2 ����
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item
		End
		Close rc 
		Deallocate rc
		update classInfo set send = send + 1,sendDate=getDate(),sender=@registerID where classID=@batchID
		--return students list for send mobile message
		select b.name,b.username,b.mobile,b.ID as enterID, 'ͨ���������������������л������⽱��' as dt, '021-52132119' as address,'�繤�߼���������������¥�����Ա�߼���������������յ�ϵͳ��װά�޹��߼��������������࿪ʼ������9����Ѯ��ѵ11�¿��ԡ�ͨ���������������������л����ö��⽱����ѯ�绰��021-52132119����һ������8:30-16:30��' as item, @kindID as kindID from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
	end
END
GO

-- CREATE DATE: 2021-05-13
-- ���ݸ����Ĳ����������������Ͳ����ſ���֪ͨ
-- batchID: classInfo.classID; selList: studentCouresList.ID list
-- USE CASE: exec sendMsg4ExamDeny 1
CREATE PROCEDURE [dbo].[sendMsg4ExamDeny]
	@batchID varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50),@startDate varchar(50),@address varchar(100),@certName varchar(50),@kindID int
	--send system message
	--���������뵽��ʱ��
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
		declare rc cursor for select b.username,b.name + '��ã�������' + @certName + '��Ŀ��ѵ��δ����ɹ涨�Ľ��Ⱥ�ģ��ɼ����ݲ�������μӱ��ο��ԡ���ץ��ѧϰ���������㿼��������' from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
		open rc
		fetch next from rc into @username,@item
		While @@fetch_status=0 
		Begin 
			--0 �ظ� 1 ֪ͨ 2 ����
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item
		End
		Close rc 
		Deallocate rc
		update classInfo set send = send + 1,sendDate=getDate(),sender=@registerID where classID=@batchID
		--return students list for send mobile message
		select b.name,b.username,b.mobile,@certName as certName, b.ID as enterID,b.name + '��ã�������' + @certName + '��Ŀ��ѵ��δ����ɹ涨�Ľ��Ⱥ�ģ��ɼ����ݲ�������μӱ��ο��ԡ���ץ��ѧϰ���������㿼��������' as item from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
	end
END
GO

-- CREATE DATE: 2021-05-13
-- ���ݸ����Ĳ����������������Ϳ��Գɼ�
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
		declare rc cursor for select username,'�𾴵�' + a.name + '�����ڽ��ղμӵ�' + b.certName + '���ԣ����Ϊ' + (case when a.status=1 then '�ϸ�����Ϊ������֤�顣' else '���ϸ�������������š�' end),a.host from v_passcardInfo a, v_generatePasscardInfo b where a.refID=b.ID and b.ID=@batchID
		open rc
		fetch next from rc into @username,@item,@host
		While @@fetch_status=0 
		Begin 
			--0 �ظ� 1 ֪ͨ 2 ����
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item,@host
		End
		Close rc 
		Deallocate rc
		update generatePasscardInfo set sendScore = sendScore + 1,sendScoreDate=getDate(),senderScore=@registerID where ID=@batchID
	end
	--return students list for send mobile message
	select name,username,mobile,b.certName, a.enterID, (case when a.status=1 then '�ϸ�����Ϊ������֤��' else '���ϸ��������������' end) as address,'�𾴵�' + a.name + '�����ڽ��ղμӵ�' + b.certName + '���ԣ����Ϊ' + (case when a.status=1 then '�ϸ�����Ϊ������֤�顣' else '���ϸ�������������š�' end) as item from v_passcardInfo a, v_generatePasscardInfo b where a.refID=b.ID and b.ID=@batchID
END
GO

-- CREATE DATE: 2021-05-13
-- ���ݸ����Ĳ����������������Ϳ��Գɼ�
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
		declare rc cursor for select username,'�𾴵�' + a.name + '�����ڽ��ղμӵ�' + b.courseName + '���ԣ����Ϊ' + (case when a.status=1 then '�ϸ�����Ϊ������֤�顣' when a.status=1 and score1='' then 'ȱ��' else '���ϸ�������������š�' end),a.host from v_applyInfo a, v_generateApplyInfo b where a.refID=b.ID and b.ID=@batchID and a.statusApply=1
		open rc
		fetch next from rc into @username,@item,@host
		While @@fetch_status=0 
		Begin 
			--0 �ظ� 1 ֪ͨ 2 ����
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item,@host
		End
		Close rc 
		Deallocate rc
		update generateApplyInfo set sendScore = sendScore + 1,sendScoreDate=getDate(),senderScore=@registerID where ID=@batchID
	end
	--return students list for send mobile message
	select name,username,mobile,b.courseName as certName, a.enterID, (case when a.status=1 then '�ϸ�����Ϊ������֤��' when a.status=1 and score1='' then 'ȱ��' else '���ϸ��������������' end) as address,'�𾴵�' + a.name + '�����ڽ��ղμӵ�' + b.courseName + '���ԣ����Ϊ' + (case when a.status=1 then '�ϸ�����Ϊ������֤�顣' when a.status=1 and score1='' then 'ȱ��' else '���ϸ�������������š�' end) as item from v_applyInfo a, v_generateApplyInfo b where a.refID=b.ID and b.ID=@batchID and a.statusApply=1
END
GO

-- CREATE DATE: 2021-05-13
-- ���ݸ����Ĳ�������������������֤֪ͨ
-- batchID: generateApplyInfo.ID  selList: applyID
-- USE CASE: exec sendMsg4DiplomaApply 1
ALTER PROCEDURE [dbo].[sendMsg4DiplomaApply]
	@batchID int, @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50)

	--���������뵽��ʱ��
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
		declare rc cursor for select username,a.name + '������ͨ��' + a.courseName + '���ԣ�������֤������·158��D103��ȡ֤��(������8:30-16:00)��',a.host from v_applyInfo a, #temp_diploma c where a.ID=c.id and a.status=1
		open rc
		fetch next from rc into @username,@item,@host
		While @@fetch_status=0 
		Begin 
			--0 �ظ� 1 ֪ͨ 2 ����
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item,@host
		End
		Close rc 
		Deallocate rc
		update generateApplyInfo set sendScore = sendScore + 1,sendScoreDate=getDate(),senderScore=@registerID where ID=@batchID
	end
	--return students list for send mobile message
	select name,username,mobile,a.courseName as certName, a.enterID, '����·158��D103' as address,a.name + '������ͨ��' + a.courseName + '���ԣ�������֤������·158��D103��ȡ֤��(������8:30-16:00)��' as item from v_applyInfo a, #temp_diploma c where a.ID=c.id and a.status=1
END
GO

-- CREATE DATE: 2021-05-13
-- ���ݸ����Ĳ�������ѧԱ�������Ͷ���ѧϰ������Ϣ
-- batchID: classInfo.classID; selList: username list
-- USE CASE: exec sendMsg4StudyAlert 1
ALTER PROCEDURE [dbo].[sendMsg4StudyAlert]
	@batchID varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50),@certName varchar(50)
	--send system message
	--���������뵽��ʱ��
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
		declare rc cursor for select b.username,b.name + '�������ڲμӵ�' + @certName + '��ѵ���밴Ҫ�󾡿��������ѧϰ������ģ�⿼���дﵽ 90���ԣ��������Ӱ�쿼�Ժ�ȡ֤��' from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
		open rc
		fetch next from rc into @username,@item
		While @@fetch_status=0 
		Begin 
			--0 �ظ� 1 ֪ͨ 2 ����
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item
		End
		Close rc 
		Deallocate rc
		update classInfo set send = send + 1,sendDate=getDate(),sender=@registerID where classID=@batchID
		--return students list for send mobile message
		select b.name,b.username,b.mobile,@certName as certName, b.ID as enterID,b.name + '�������ڲμӵ�' + @certName + '��ѵ���밴Ҫ�󾡿��������ѧϰ������ģ�⿼���дﵽ 90���ԣ��������Ӱ�쿼�Ժ�ȡ֤��' as item from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
	end
END
GO

-- CREATE DATE: 2022-11-29
-- ���ݸ����Ĳ�������ѧԱ���������ύ������Ƭ������Ϣ
-- kind: "" ���֤  "cert":studentCertList.ID ; selList: username list
-- USE CASE: exec sendMsg4SubmitPhoto 1
ALTER PROCEDURE [dbo].[sendMsg4SubmitPhoto]
	@kind varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50),@certName varchar(50)
	--send system message
	--���������뵽��ʱ��
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
		declare rc cursor for select b.username,b.name + '���μӵ���ѵ���ύ����Ҫ���֤����Ƭ��jpg/png��ʽ������¼ϵͳ���ڸ�����Ϣ���ϴ���' from #temp a, studentInfo b where a.username=b.username
		open rc
		fetch next from rc into @username,@item
		While @@fetch_status=0 
		Begin 
			--0 �ظ� 1 ֪ͨ 2 ����
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item
		End
		Close rc 
		Deallocate rc
		--��¼֪ͨ
		--���kind='cert', ȡ��username list �滻 cert list
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
		select b.name,b.username,b.mobile,'' as certName,b.name + '���μӵ���ѵ���ύ����Ҫ���֤����Ƭ��jpg/png��ʽ������¼ϵͳ���ڸ�����Ϣ���ϴ���' as item from #temp a, studentInfo b where a.username=b.username
	end
END
GO

-- CREATE DATE: 2022-11-29
-- ���ݸ����Ĳ�������ѧԱ���������ύ����ǩ��������Ϣ
-- batchID: classInfo.classID; selList: username list
-- USE CASE: exec sendMsg4SubmitSignature 1
ALTER PROCEDURE [dbo].[sendMsg4SubmitSignature]
	@batchID varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50),@certName varchar(50)
	--send system message
	--���������뵽��ʱ��
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
		declare rc cursor for select b.username,b.name + '���μӵ�' + @certName + '��ѵ���ύ����ǩ������¼ϵͳ���ڡ��ҵĿγ̡��н���ǩ����' from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
		open rc
		fetch next from rc into @username,@item
		While @@fetch_status=0 
		Begin 
			--0 �ظ� 1 ֪ͨ 2 ����
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item
		End
		Close rc 
		Deallocate rc

		--��¼֪ͨ
		update #temp set enterID=b.ID from #temp a, studentCourseList b where a.username=b.username and b.classID=@batchID
		--ȡ��enterID list �滻 username list
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
		select b.name,b.username,b.mobile,@certName as certName, b.ID as enterID,b.name + '���μӵ�' + @certName + '��ѵ���ύ����ǩ������¼ϵͳ���ڡ��ҵĿγ̡��н���ǩ����' as item from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
	end
END
GO

-- CREATE DATE: 2022-11-29
-- ���ݸ����Ĳ���������֪ͨѧԱ����¼ϵͳ������ǩ���͸���
-- batchID: classInfo.classID; selList: username list
-- USE CASE: exec sendMsg4SubmitLogin 1
CREATE PROCEDURE [dbo].[sendMsg4SubmitLogin]
	@batchID varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	declare @username varchar(50),@item varchar(500),@host varchar(50),@certName varchar(50)
	--send system message
	--���������뵽��ʱ��
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
		declare rc cursor for select b.username,b.name + '����ӭ����������ѧУѧϰ�����߲������裺ɨ���ά���¼������123456����ɵ���ǩ�������߸��ѡ�' from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
		open rc
		fetch next from rc into @username,@item
		While @@fetch_status=0 
		Begin 
			--0 �ظ� 1 ֪ͨ 2 ����
			exec sendSysMessage @username,1,@item,@host,'system.'
			fetch next from rc into @username,@item
		End
		Close rc 
		Deallocate rc

		--��¼֪ͨ
		update #temp set enterID=b.ID from #temp a, studentCourseList b where a.username=b.username and b.classID=@batchID
		--ȡ��enterID list �滻 username list
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
		select b.name,b.username,b.mobile,@certName as certName, b.ID as enterID,b.name + '����ӭ����������ѧУѧϰ�����߲������裺ɨ���ά���¼������123456����ɵ���ǩ�������߸��ѡ�' as item from #temp a, v_studentCourseList b where a.username=b.username and b.classID=@batchID
	end
END
GO

-- =============================================
-- CREATE Date: 2021-06-26
-- Description:	��������������ӵ�ָ�����ﳵ��
-- @@kindID: examer, diploma
-- @selList: �������ö��ŷָ���ID in studentCourseList, diplomaInfo
-- Use Case:	exec [add2cart] 'examer','...','','admin.'
-- =============================================
CREATE PROCEDURE [dbo].[add2cart] 
	@kindID varchar(50), @selList varchar(4000),@memo nvarchar(500), @registerID varchar(50)
AS
BEGIN
	declare @re int

	--���������뵽��ʱ��
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
-- Description:	�����������ݴ�ָ�����ﳵ���Ƴ���
-- @@kindID: examer, diploma
-- @selList: �������ö��ŷָ���ID in studentCourseList, diplomaInfo
-- Use Case:	exec [remove4cart] 'examer','...'
-- =============================================
CREATE PROCEDURE [dbo].[remove4cart] 
	@kindID varchar(50), @selList varchar(4000)
AS
BEGIN
	declare @re int

	--���������뵽��ʱ��
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
-- Description:	��ָ�����ﳵ��ա�
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
-- Description:	�����ﳵ�и�������Ա���뿼�԰��š�
-- @examID: ���Ա�� generatePasscardInfo.ID
-- @selList: �������ö��ŷָ���ID in cart
-- Use Case:	exec [pickExamer4cart] 2,'...'
-- =============================================
ALTER PROCEDURE [dbo].[pickExamer4cart] 
	@examID varchar(50), @selList varchar(4000),@registerID varchar(50)
AS
BEGIN
	--���������뵽��ʱ��
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
	--ɾ���γ��뿼�Բ����ϵ���Ա
	update cartBill set memo='��ѵ�뿼�Բ���' from cartBill c, v_studentCourseList a, #temp_cart b where b.id=c.id and a.ID=c.refID and a.certID<>@certID
	delete from #temp_cart where id in(select b.id from v_studentCourseList a, #temp_cart b, cartBill c where b.id=c.id and a.ID=c.refID and a.certID<>@certID)
	--ɾ���Ѿ�����ĳ��δ�����Ŀ��Գ��ε���Ա
	update cartBill set memo='�Ѱ�����������:' + cast(d.ID as varchar) from cartBill c, passcardInfo a, #temp_cart b, generatePasscardInfo d where b.id=c.id and a.enterID=c.refID and a.refID=d.ID and d.status<2
	delete from #temp_cart where id in(select b.ID from passcardInfo a, #temp_cart b, cartBill c, generatePasscardInfo d where b.id=c.id and a.enterID=c.refID and a.refID=d.ID and d.status<2)
	--ɾ���Ѿ���ȡ��Ӧ֤���Ҿ���ʧЧ����6���µ���Ա�������ظ�����ȡ֤
	update cartBill set memo='�ѻ�ȡ���֤��:' + a.diplomaID + ' ��Ч����' + convert(varchar(10),a.endDate,23) from cartBill c, diplomaInfo a, #temp_cart b where b.id=c.id and a.username=c.username and a.certID=@certID and a.status=0 and datediff(d,getDate(),a.endDate)>=180
	delete from #temp_cart where id in(select b.ID from cartBill c, diplomaInfo a, #temp_cart b where b.id=c.id and a.username=c.username and a.certID=@certID and a.status=0 and datediff(d,getDate(),a.endDate)>=180)

	--���Ϊ����������ԭ���Ŀ���
	update passcardInfo set resit=1 where ID in(select max(a.ID) as ID from passcardInfo a, #temp_cart b, cartBill c where a.enterID=c.refID and b.ID=c.ID and c.memo='*����*' group by c.refID)

	--��д��ϸ
	insert into passcardInfo(refID,enterID,password,kind,registerID) select @examID,c.refID,right(c.username,6),replace(c.memo,'*',''),@registerID from #temp_cart b, cartBill c where b.id=c.id

	--���±�����
	update studentCourseList set passcardID=@examID from studentCourseList a, #temp_cart b, cartBill c where b.id=c.id and a.id=c.refID

	--ɾ�����ﳵ������
	delete from cartBill where ID in(select id from #temp_cart)
END

GO

-- =============================================
-- CREATE Date: 2021-03-24
-- Description:	�����ﳵ�и�������Ա�����걨���š�
-- @applyID: �걨��� generateApplyInfo.ID
-- @selList: �������ö��ŷָ���ID in cart
-- Use Case:	exec [pickApplyer4cart] 2,'...'
-- =============================================
ALTER PROCEDURE [dbo].[pickApplyer4cart] 
	@applyID varchar(50), @selList varchar(4000),@registerID varchar(50)
AS
BEGIN
	--���������뵽��ʱ��
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
	--ɾ���γ��뿼�Բ����ϵ���Ա
	update cartBill set memo='��ѵ���걨����' from cartBill c, v_studentCourseList a, #temp_cart b where b.id=c.id and a.ID=c.refID and a.courseID<>@courseID
	delete from #temp_cart where id in(select b.id from v_studentCourseList a, #temp_cart b, cartBill c where b.id=c.id and a.ID=c.refID and a.courseID<>@courseID)
	--ɾ���Ѿ�����ĳ��δ�������걨���ε���Ա
	update cartBill set memo='�Ѱ�����������' from cartBill c, applyInfo a, #temp_cart b, generateApplyInfo d where b.id=c.id and a.enterID=c.refID and a.refID=d.ID and d.status<1
	delete from #temp_cart where id in(select b.ID from applyInfo a, #temp_cart b, cartBill c, generateApplyInfo d where b.id=c.id and a.enterID=c.refID and a.refID=d.ID and d.status<1)
	--ɾ��ѧ��ȱʧ��δ���ѵ���Ա
	update cartBill set memo=iif(d.education=0,'��ѧ��','δ����') from cartBill c, studentCourseList a, #temp_cart b, studentInfo d where b.id=c.id and a.ID=c.refID and a.username=d.username and (d.education=0 or (a.pay_status=0 and a.pay_type<3))
	delete from #temp_cart where id in(select b.ID from cartBill c, studentCourseList a, #temp_cart b, studentInfo d where b.id=c.id and a.ID=c.refID and a.username=d.username and (d.education=0 or (a.pay_status=0 and a.pay_type<3)))

	--���Ϊ����������ԭ���Ŀ���
	--update applyInfo set resit=1 where ID in(select max(a.ID) as ID from applyInfo a, #temp_cart b, cartBill c where a.enterID=c.refID and b.ID=c.ID and c.memo='*����*' group by c.refID)

	--��д��ϸ
	insert into applyInfo(refID,enterID,statusApply,kind,registerID) select @applyID,c.refID,0,replace(c.memo,'*',''),@registerID from #temp_cart b, cartBill c where b.id=c.id

	--���±�����
	update studentCourseList set applyID=@applyID from studentCourseList a, #temp_cart b, cartBill c where b.id=c.id and a.id=c.refID

	--ɾ�����ﳵ������
	delete from cartBill where ID in(select id from #temp_cart)
END

GO


-- =============================================
-- CREATE Date: 2021-03-24
-- Description:	��ĳ�����Գ��εĿ����ƶ�������һ�����ԣ�����ɾ����
-- @examID: Ŀ�꿼�Ա�� generatePasscardInfo.ID
-- @selList: �������ö��ŷָ���ID in passcardInfo
-- Use Case:	exec [changeExamer] 2,'...'
-- =============================================
CREATE PROCEDURE [dbo].[changeExamer] 
	@examID varchar(50), @selList varchar(4000),@registerID varchar(50)
AS
BEGIN
	--���������뵽��ʱ��
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
		--�������Գ���
		update passcardInfo set refID=@examID from passcardInfo a, #temp b where a.ID=b.ID
		--���±�����
		update studentCourseList set passcardID=@examID from studentCourseList a, #temp b, passcardInfo c where b.id=c.id and a.id=c.enterID
	end
	else
	begin
		--���±�����
		update studentCourseList set passcardID=0 from studentCourseList a, #temp b, passcardInfo c where b.id=c.id and a.id=c.enterID
		--ɾ������
		delete from passcardInfo where ID in(select id from #temp)
	end
END

GO

-- =============================================
-- CREATE Date: 2021-03-24
-- Description:	��ĳ���걨���εĿ����ƶ����������Σ�����ɾ����
-- @examID: Ŀ�꿼�Ա�� generateApplyInfo.ID
-- @selList: �������ö��ŷָ���ID in applyInfo
-- Use Case:	exec [changeApplier] 2,'...'
-- =============================================
ALTER PROCEDURE [dbo].[changeApplier] 
	@examID varchar(50), @selList varchar(4000),@registerID varchar(50)
AS
BEGIN
	--���������뵽��ʱ��
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
		--�������Գ���
		update applyInfo set refID=@examID from applyInfo a, #temp b where a.ID=b.ID
		--���±�����
		update studentCourseList set applyID=@examID from studentCourseList a, #temp b, applyInfo c where b.id=c.id and a.id=c.enterID
	end
	else
	begin
		--���±�����
		update studentCourseList set applyID=0 from studentCourseList a, #temp b, applyInfo c where b.id=c.id and a.id=c.enterID
		--ɾ������
		delete from applyInfo where ID in(select id from #temp)
	end
	
	-- д������־
	exec writeOpLog '','�����ƶ��걨����','changeApplier',@registerID,@selList,@examID
END

GO

-- =============================================
-- Author:		Albert
-- Create date: 2025-05-28
-- Description:	��ĳ�����ԣ�Ϊÿ������������ͬ�Ծ�
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
			exec addQuestions4StudentExam @paperID,1,0,'',0,1,20,0	--ǿ������������Ŀ
			fetch next from rc1 into @paperID
		End
		Close rc1
		Deallocate rc1
	end
END
GO

-- =============================================
-- CREATE Date: 2021-03-24
-- Description:	Ϊָ���Ŀ�������׼��֤��
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
	--��������Ͽ��ԣ����ɿ���
	if @kindID=1
	begin
		delete from studentExamList where refID in(select ID from passcardInfo where refID=@examID)
		insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,kind,mark) select a.username,examID,a.ID,minutes,minutes*60,scoreTotal,scorePass,b.kindID,1,0 from v_passcardInfo a, examInfo b where a.refID=@examID and b.certID=@certID and b.mark=0 and b.status=0
		--�����ͬ���Ծ�����ͬ������
		if @sync=1	
			exec syncPaper4Exam @examID
		else
			exec createPaper4Exam @examID	--����ֱ������Ծ�
	end
	-- д������־
	exec writeOpLog '','׼��֤����','setPassNo4Exam',@registerID,'',@examID
END
GO

-- =============================================
-- CREATE Date: 2021-03-24
-- Description:	�ر�ָ���Ŀ��ԡ�
-- Use Case:	exec [closeGeneratePasscard] 1
-- =============================================
ALTER PROCEDURE [dbo].[closeGeneratePasscard] 
	@examID varchar(50),@status int, @registerID varchar(50)
AS
BEGIN
	update generatePasscardInfo set status=@status where ID=@examID
	declare @event varchar(50)
	select @event=(case when @status=1 then '��������' when @status=2 then '�رտ���' else '' end)
	-- д������־
	exec writeOpLog '',@event,'closeGeneratePasscard',@registerID,'',@examID
END

GO


-- CREATE DATE: 2021-04-06
-- ���ݸ����Ĳ�������ӻ��߸����걨��Ϣ
-- USE CASE: exec updateGenerateApplyInfo 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updateGenerateApplyInfo]
	@ID int,@courseID varchar(50),@applyID varchar(50),@title nvarchar(100),@startDate varchar(100),@endDate varchar(100),@planID varchar(50),@planQty varchar(50),@notes nvarchar(500),@address nvarchar(100),@teacher varchar(50),@classroom nvarchar(100),@adviserID varchar(50),@diplomaReady varchar(50),@host varchar(50),@memo nvarchar(500),@summary nvarchar(2000),@registerID varchar(50)
AS
BEGIN
	declare @re int
	select @re=@ID, @host=[dbo].[whenull](@host,'znxf')

	if @ID=0	-- �¼�¼
	begin
		--��д���ɼ�¼
		insert into generateApplyInfo(courseID,applyID,title,startDate,endDate,planID,planQty,notes,address,teacher,classroom,diplomaReady,host,memo,registerID) values(@courseID,@applyID,@title,@startDate,@endDate,@planID,@planQty,@notes,@address,@teacher,@classroom,@diplomaReady,@host,@memo,@registerID)
		select @re=max(ID) from generateApplyInfo where registerID=@registerID
	end
	if @ID>0	-- ������Ϣ
	begin
		update generateApplyInfo set applyID=@applyID,title=@title,summary=@summary,startDate=@startDate,endDate=@endDate,planID=@planID,planQty=@planQty,notes=@notes,address=@address,teacher=@teacher,classroom=@classroom,adviserID=@adviserID,diplomaReady=@diplomaReady,host=@host,memo=@memo where ID=@ID
	end
	select @re as re
END
GO

-- CREATE DATE: 2015-01-12
-- ���ݸ����Ĳ�����ɾ���걨���ݣ���д��־
-- USE CASE: exec delGenerateApplyInfo 1
ALTER PROCEDURE [dbo].[delGenerateApplyInfo]
	@ID int,@registerID varchar(50)
AS
BEGIN
	if exists(select 1 from generateApplyInfo where ID=@ID)
	begin
		delete from generateApplyInfo where ID=@ID
		-- ɾ����ؿ������걨��¼
		delete from applyInfo where refID=@ID
		update studentCourseList set applyID=0 where applyID=@ID
		-- д������־
		exec writeOpLog '','ɾ���걨','generateApply',@registerID,'',@ID
	end
END
GO

-- CREATE DATE: 2015-01-12
-- ���ݸ����Ĳ������رգ���д��־
-- USE CASE: exec closeGenerateApplyInfo 1
CREATE PROCEDURE [dbo].[closeGenerateApplyInfo]
	@ID int, @status int ,@registerID varchar(50)
AS
BEGIN
	if exists(select 1 from generateApplyInfo where ID=@ID)
	begin
		update generateApplyInfo set status=@status where ID=@ID
		-- д������־
		declare @event varchar(20)
		select @event = (case when @status=0 then '�걨����' when @status=2 then '�걨�ر�' else '�걨����' end)
		exec writeOpLog '',@event,'apply',@registerID,'',@ID
	end
END
GO


------------------
-- CREATE DATE: 2020-05-24
-- ���ݸ����Ĳ�������ӻ��߸��µ���Ԥ����ѧԱ��Ϣ
-- batchID: classInfo.ID
-- USE CASE: exec generateRefStudent 1,1,'xxxx'...
-- params = {"batchID":key, "ID":String(val["���"]), "dept1":val["��˾"], "dept2":val["����վ"], "name":val["����"], "username":un, "education":val["�Ļ��̶�"], "job":val["��λ"], "mobile":String(phone), "expireDate":String(val["֤����Ч��"]), "memo":val["��ע"], "invoice":val["��Ʊ��Ϣ"]};
ALTER PROCEDURE [dbo].[generateRefStudent]
	@batchID int,@ID varchar(50),@dept1 varchar(50),@dept2 varchar(50),@name varchar(50),@username varchar(50),@education varchar(50),@job varchar(50),@mobile varchar(50),@expireDate varchar(50),@memo varchar(50),@invoice varchar(50)
AS
BEGIN
	declare @re int, @dept int, @edu int, @dept22 int
	select @dept1=replace(@dept1,' ',''),@dept2=replace(@dept2,' ',''),@name=replace(@name,' ',''),@username=replace(@username,' ',''),@education=replace(@education,' ',''),@mobile=replace(@mobile,' ','')
	select @dept = (case when @dept1='����' then 2 when @dept1='����' then 3 when @dept1='����' then 4 when @dept1='����' then 6 when @dept1='��������' then 9 else 0 end)
	select @edu = ID from dictionaryDoc where kind='education' and item=@education
	select @dept22 = deptID from deptInfo where deptName=@dept2
	insert into ref_student_spc(classID,ID,deptName,stationName,name,username,education,edu,dept1,dept2,job,mobile,expireDate,memo,invoice) values(@batchID,@ID,@dept1,@dept2,@name,@username,@education,@edu,@dept,@dept22,@job,@mobile,@expireDate,@memo,@invoice)

	return isnull(@re,0)
END
GO

------------------
-- CREATE DATE: 2020-05-24
-- ���ݸ����Ĳ�����ɾ��Ԥ����ѧԱ��Ϣ
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
-- ���ݸ����Ĳ���������Ԥ��������ȡ���
-- @cID: classInfo.ID
-- mark: 0 Ԥ��������  1 ����
-- USE CASE: exec lookRefSNo 1
ALTER PROCEDURE [dbo].[lookRefSNo]
	@cID int, @username varchar(50), @name varchar(50), @pNo varchar(50) output, @mark int output
AS
BEGIN
	declare @SNo int
	select @pNo='',@SNo=0,@mark=1

		--��Ԥ����������ұ��
		--select @SNo = ID from ref_student_spc where username=@username and classID=@cID
		--if @SNo=0 and exists(select 1 from ref_student_spc where name=@name and classID=@cID)	--���֤���û�ҵ�����������
		--begin
		--	select @SNo = ID from ref_student_spc where name=@name and classID=@cID
			--�������֤
		--	update ref_student_spc set username=@username where name=@name and classID=@cID
		--end
		--���Ԥ��������û�б�ţ����ڰ༶���Զ����
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
-- ����ɾ�����޳��ı�����¼���Լ������رպ�3��δ��ȷ�ϵı���
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
		exec delEnter @ID,'�Զ�����','system.'
		fetch next from rc into @ID
	End
	Close rc 
	Deallocate rc
END
GO

------------------
-- CREATE DATE: 2020-05-24
-- ���ݸ����Ĳ�������ӻ��߸��µ����걨�����Ϣ
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
-- ���ݸ����Ĳ�����ȥ���걨������δͨ������
-- USE CASE: exec dealGenerateApply 1
ALTER PROCEDURE [dbo].[dealGenerateApply]
	@batchID int ,@registerID varchar(50)
AS
BEGIN
	--������Ϣ��ȥ���걨��ʶ
	--update studentCourseList set applyID=0 from studentCourseList a, applyInfo b where a.ID=b.enterID and a.applyID=@batchID and b.refID=@batchID and b.statusApply=0
	--�걨��Ϣ������Ϊ�ܾ�
	--update applyInfo set statusApply=2 where refID=@batchID and statusApply=0
	--��д��������
	update generateApplyInfo set importApplyDate=getDate(),importApplyID=@registerID where ID=@batchID
	-- д������־
	declare @event varchar(20)
	select @event = '�����걨���'
	exec writeOpLog '',@event,'importApply',@registerID,'',@batchID
END
GO

------------------
-- CREATE DATE: 2020-05-24
-- ���ݸ����Ĳ�������ӻ��߸��µ����걨�ɼ���֤����Ϣ
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

	--�����걨��Ϣ
	update applyInfo set status=@status,score1=@score1,score2=@score2 from applyInfo a, v_applyInfo b where a.ID=b.ID and a.refID=@batchID and b.username=@username
	update generateApplyInfo set importScoreDate=getDate() where ID=@batchID and importScoreDate is null

	--���±�����Ϣ
	update studentCertList set result=@status,status=(case when @status=1 then 2 else status end),diplomaID=(case when @status=1 then @passNo else null end),score=@score1,score1=@score1,score2=@score2,closeDate=(case when @status=1 then getDate() else null end) where ID=@refID
	update studentCourseList set status=2,endDate=getDate(),closeDate=getDate() where ID=@enterID and @status=1

	--���֤����Ϣ
	if @status=1 and exists(select 1 from diplomaInfo where certID=@certID and diplomaID=@passNo)
		delete from diplomaInfo where certID=@certID and diplomaID=@passNo
	if @status=1
		insert into diplomaInfo(diplomaID,username,batchID,refID,certID,score,score1,score2,term,startDate,endDate,host,registerID) select @passNo,@username,@batchID,@refID,@certID,@score1,@score1,@score2,@term,@startDate,convert(varchar(20),dateadd(d,-1,dateadd(yy,@term,@startDate)),23),@host,@registerID
END
GO

------------------
-- CREATE DATE: 2020-05-24
-- ���ݸ����Ĳ�������ӻ��߸��µ����걨�ɼ���֤����Ϣ(�����Զ�����)
-- USE CASE: exec generateApplyScore1 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[generateApplyScore1]
	@ID int,@passNo varchar(50),@score1 varchar(50),@score2 varchar(50),@startDate varchar(50),@registerID varchar(50)

AS
BEGIN
	declare @status int, @refID int, @enterID int, @certID varchar(50),@host varchar(50),@batchID int,@term int,@username varchar(50)
	select @status=(case when len(@passNo)>2 then 1 when @score1>'' and len(@passNo)<2 then 2 else 3 end),@score1=dbo.whenull(@score1,'0'),@score2=dbo.whenull(iif(@score2='��ʵ��','',@score2),'0')
	select @enterID=enterID,@batchID=refID from v_applyInfo where ID=@ID
	select @refID=refID, @certID=certID, @username=username from v_studentCourseList where ID=@enterID
	select @term=term from certificateInfo where certID=@certID
	select @host = host from studentInfo where username=@username

	--�����걨��Ϣ
	update applyInfo set status=@status,score1=@score1,score2=@score2 from applyInfo where ID=@ID
	update generateApplyInfo set importScoreDate=getDate() where ID=@batchID and importScoreDate is null

	--���±�����Ϣ
	update studentCertList set result=@status,status=2,diplomaID=(case when @status=1 then @passNo else null end),score=@score1,score1=@score1,score2=@score2,closeDate=getDate() where ID=@refID
	update studentCourseList set status=2,endDate=getDate(),closeDate=getDate() where ID=@enterID

	--���֤����Ϣ
	if @status=1 and exists(select 1 from diplomaInfo where certID=@certID and diplomaID=@passNo)
		delete from diplomaInfo where certID=@certID and diplomaID=@passNo
	if @status=1
		insert into diplomaInfo(diplomaID,username,batchID,refID,certID,score,score1,score2,term,startDate,endDate,host,registerID) select @passNo,@username,@batchID,@refID,@certID,@score1,@score1,@score2,@term,@startDate,convert(varchar(20),dateadd(d,-1,dateadd(yy,@term,@startDate)),23),@host,@registerID
END
GO

------------------
-- CREATE DATE: 2025-08-12
-- ���ݸ����Ĳ�������ӻ��߸��µ����걨�����Ϣ(�����Զ�����)
-- USE CASE: exec generateApply1 1,1,'xxxx'...
CREATE PROCEDURE [dbo].[generateApply1]
	@ID int,@passNo varchar(50),@examDate varchar(50),@registerID varchar(50)

AS
BEGIN
	declare @batchID int
	select @batchID=refID from applyInfo where ID=@ID

	--�����걨��Ϣ
	if @examDate>''
	begin
		update applyInfo set applyNo=@passNo,examDate=@examDate,statusApply=1 from applyInfo where ID=@ID
		update generateApplyInfo set importApplyDate=getDate() where ID=@batchID and importApplyDate is null
	end
END
GO

-- CREATE DATE: 2022-11-28
-- ֤��ʧЧ����֤��״̬��Ϊ���ڣ���ֹ������Ϊ����
-- USE CASE: exec cancelDiploma
ALTER PROCEDURE [dbo].[cancelDiploma]
	@diplomaID varchar(50),@registerID varchar(50)

AS
BEGIN
	declare @event varchar(20), @logMemo varchar(100)
	select @event = '֤��ʧЧ', @logMemo=diplomaID + '/' + username + '/' + name + '/' + certName from v_diplomaInfo where diplomaID=@diplomaID

	--����֤����Ϣ
	update diplomaInfo set status=1, endDate=dateadd(d,-1,getDate()) where diplomaID=@diplomaID
	-- д������־
	exec writeOpLog @event,'diplomaExpire',@registerID,@logMemo,@diplomaID
END
GO

-- CREATE DATE: 2022-11-28
-- �ָ�֤�����Ч�ԣ����û�г���ԭ��Ч�ڣ���֤��״̬��Ϊ��Ч����ֹ������Ϊ�ȶ�ֵ
-- USE CASE: exec restartDiploma
CREATE PROCEDURE [dbo].[restartDiploma]
	@diplomaID varchar(50),@registerID varchar(50)

AS
BEGIN
	declare @event varchar(20), @logMemo varchar(100), @closeDate datetime
	select @event = '֤��ָ�', @logMemo=diplomaID + '/' + username + '/' + name + '/' + certName, @closeDate=dateadd(yy,term,startDate) from v_diplomaInfo where diplomaID=@diplomaID

	--����֤����Ϣ
	if @closeDate>getDate()
	begin
		update diplomaInfo set status=0, endDate=@closeDate where diplomaID=@diplomaID
		-- д������־
		exec writeOpLog @event,'diplomaRestart',@registerID,@logMemo,@diplomaID
	end
END
GO

------------------
-- CREATE DATE: 2020-05-24
-- ���ݸ����Ĳ����������걨���εķ�֤����, ͬʱ�ر��걨
-- USE CASE: exec setGenerateApplyIssue 1
ALTER PROCEDURE [dbo].[setGenerateApplyIssue]
	@batchID int, @startDate varchar(50) ,@registerID varchar(50)
AS
BEGIN
	declare @refID int, @enterID int, @certID varchar(50),@term int, @courseID varchar(50)
	select @courseID=courseID from generateApplyInfo where ID=@batchID
	select @certID=certID from courseInfo where courseID=@courseID
	select @term=term from certificateInfo where certID=@certID
	--��д��֤����
	update generateApplyInfo set status=2,diplomaStartDate=@startDate, diplomaTerm=@term,diplomaEndDate=convert(varchar(20),dateadd(d,-1,dateadd(yy,@term,@startDate)),23),importScoreDate=getDate(),importScoreID=@registerID,registerID=@registerID where ID=@batchID
	-- д������־
	declare @event varchar(20)
	select @event = '�����걨�ɼ���֤��'
	exec writeOpLog '',@event,'importApplyScore',@registerID,'',@batchID
END
GO

--CREATE Date:2020-11-13
--���ݸ��������Σ��������һ�������ܽ�
--@mark: 0 ������
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
-- �α���º������޸��ѱ�����Ա�Ŀα�
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
		--��ӿα�
		delete from studentLessonList where refID=@ID
		insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,@ID,hours,'system.' from lessonInfo where courseID=@courseID and status=0

		--��ӿμ�
		delete from studentCoursewareList where refID in(select ID from studentLessonList where refID=@ID)
		insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,'system.' from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0

		--�����Ƶ
		delete from studentVideoList where refID in(select ID from studentLessonList where refID=@ID)
		insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,'system.' from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0

		--��ӿ��ԣ���Ŀ�ݲ�����
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
-- �α���º������޸��ѱ�����Ա�Ŀα�
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
		--��ӿα�
		delete from studentLessonList where refID=@ID
		insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,@ID,hours,'system.' from lessonInfo where courseID=@courseID and status=0

		--��ӿμ�
		delete from studentCoursewareList where refID in(select ID from studentLessonList where refID=@ID)
		insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,'system.' from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0

		--�����Ƶ
		delete from studentVideoList where refID in(select ID from studentLessonList where refID=@ID)
		insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,'system.' from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@ID and a.status=0

		--��ӿ��ԣ���Ŀ�ݲ�����
		if exists(select 1 from  examInfo where courseID=@courseID)
		begin
			delete from studentExamList where refID=@ID
			insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,kind,mark) select @username,examID,@ID,minutes,minutes*60,scoreTotal,scorePass,kindID,0,0 from examInfo where courseID=@courseID and status=0
		end

		fetch next from rc into @ID,@username,@courseID
	End
	Close rc 
	Deallocate rc
	exec writeOpLog '','���°༶ȫ��ѧԱ�Ŀα�','rebuildLessonByClass',@registerID,'',@class
END
GO

-- CREATE DATE: 2021-05-13
-- �α���º��޸��ѱ�����Ա�Ŀα�
-- USE CASE: exec rebuildStudentLesson
ALTER PROCEDURE [dbo].[rebuildStudentLesson]
	@enterID int
AS
BEGIN
	SET NOCOUNT ON;
	declare @username varchar(50),@courseID varchar(50)
	select @username=username,@courseID=courseID from studentCourseList where ID=@enterID
	
	--��ӿα�
	delete from studentLessonList where refID=@enterID
	insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,@enterID,hours,'system.' from lessonInfo where courseID=@courseID and status=0

	--��ӿμ�
	delete from studentCoursewareList where refID in(select ID from studentLessonList where refID=@enterID)
	insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,'system.' from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@enterID and a.status=0

	--�����Ƶ
	delete from studentVideoList where refID in(select ID from studentLessonList where refID=@enterID)
	insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,'system.' from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@enterID and a.status=0

	--��ӿ��ԣ���Ŀ�ݲ�����
	if exists(select 1 from  examInfo where courseID=@courseID and status=0)
	begin
		delete from studentExamList where refID=@enterID
		insert into studentExamList(username,examID,refID,minutes,secondRest,scoreTotal,scorePass,kindID,kind,mark) select @username,examID,@enterID,minutes,minutes*60,scoreTotal,scorePass,kindID,0,0 from examInfo where courseID=@courseID and status=0
	end
END

GO

-- CREATE DATE: 2021-05-13
-- �վ�ǿ�ƽ���
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
-- ȷ�Ͽ��Գɼ�
-- USE CASE: exec confirmExam
ALTER PROCEDURE [dbo].[confirmExam]
	@ID int, @registerID varchar(50)
AS
BEGIN
	declare @re int, @refID int,@certID varchar(50),@scorePass int, @enterID int,@score0 decimal(18,2)
	select @certID=certID,@re=1 from generatePasscardInfo where ID=@ID
	select top 1 @scorePass=isnull(scorePass,80) from examInfo where certID=@certID and status=0 order by examID

	--result:1 �ϸ� 2 ���ϸ񣬽����γ�
	update passcardInfo set status=(case when score>=@scorePass then 1 else 2 end) where refID=@ID
	if exists(select 1 from [dbo].[certificateInfo] where certID=@certID and agencyID=4)	--��У��֤��Ŀ���Զ������γ̣�������Ŀ���ı�ѧϰ״̬
	begin
		update studentCourseList set status=2,endDate=getDate(),closeDate=getDate() from studentCourseList a, passcardInfo b where a.ID=b.enterID and b.refID=@ID and b.score>=@scorePass
		update studentCertList set result=(case when b.score>=@scorePass then 1 else 2 end),status=(case when b.score>=@scorePass then 2 else c.status end),score=b.score,closeDate=(case when b.score>=@scorePass then getDate() else null end)
			from studentCertList c, studentCourseList a, passcardInfo b where c.ID=a.refID and a.ID=b.enterID and b.refID=@ID
	end
	select @re=0
	exec writeOpLog '','�ɼ�ȷ��','generateScore',@registerID,'',@ID
END
GO

-- =============================================
-- CREATE Date: 2021-02-14
-- Description:	ɾ����ѵ��Ŀ�г������޲����Լ�ɾ������δ��ɵĿγ�
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
		--ɾ��
		delete from studentCertList where ID=@ID
		delete from studentCourseList where refID=@ID
		fetch next from rc into @ID
	End
	Close rc 
	Deallocate rc
END
GO

--CREATE Date:2020-11-13
--���ݸ������ڷ�Χ��ͳ�Ʊ������������@refID������ܣ������ֲ�ͬ��˾����
--@refID: y,m,w,d ��������
--@fromID: ������Աֻ�ܿ��Լ�������
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
--���ݸ������ڷ�Χ��ͳ�Ʊ������������@refID������ܣ������ֲ�֤ͬ������
--@refID: y,m,w,d ��������
--@fromID: ������Աֻ�ܿ��Լ�������
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
--���ݸ������ڷ�Χ��ͳ�Ƽ����ϸ��ʣ�����@refID������ܣ������ֲ�ͬ��Ŀ����
--@refID: y,m,w,d ��������
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

	--�������ڷ�Χ�����е���Ŀ
	create table #temp_cert(certID varchar(50),qty int,qtyYes int)
	select @sql = 'insert into #temp_cert(certID,qty,qtyYes) select certID,sum(qty),sum(qtyYes) from (select startDate, qty, qtyYes, certID from v_generatePasscardInfo where ' + @where + ' union select startDate, qty, qtyYes, certID from v_generateApplyInfo where ' + @where + ') a'
	select @sql = @sql + ' group by certID order by certID'
	EXEC(@sql)

	--�������ڷ�Χ�����е�����
	create table #temp_date(startDate varchar(50))
	select @sql = 'insert into #temp_date select ' + @group + ' as startDate from '
	select @sql = @sql + '(select startDate from v_generatePasscardInfo where ' + @where + ' union select startDate from v_generateApplyInfo where ' + @where + ') a'
	select @sql = @sql + ' group by ' + @group + ' order by ' + @group
	EXEC(@sql)

	--�������ڷ�Χ�ڵ���Ŀ����ͳ��
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
--���ݸ������ڷ�Χ��ͳ��ģ�⿼�Գɼ�������@refID������ܣ������ֲ�ͬ��Ŀ����
--@refID: y,m,w,d ��������
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

	--�������ڷ�Χ�����е���Ŀ
	create table #temp_cert(certID varchar(50),examScore int,examTimes int)
	select @sql = 'insert into #temp_cert(certID,examScore,examTimes) select certID,avg(examScore),avg(examTimes) from v_studentCourseList where ' + @where
	select @sql = @sql + ' group by certID order by certID'
	EXEC(@sql)

	--�������ڷ�Χ�����е�����
	create table #temp_date(submitDate varchar(50))
	select @sql = 'insert into #temp_date select ' + @group + ' as submitDate from v_studentCourseList where ' + @where
	select @sql = @sql + ' group by ' + @group + ' order by ' + @group
	EXEC(@sql)

	--�������ڷ�Χ�ڵ���Ŀ����ͳ��
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
--���ݸ��������ڷ�Χ��ͳ�ư༶���
--@adviserID: ������
--@archived: �Ƿ��ѹ鵵 ''����  '0'��  '1'��
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

	--���ҳ����з��������İ༶�б�
	create table #temp_class(classID varchar(50),className varchar(50),adviserID varchar(50),adviserName varchar(50),startDate varchar(50),endDate varchar(50),status int,examDate varchar(50),diplomaDate varchar(50),archiveDate varchar(50),archiverName varchar(50),certID varchar(50),qty int,qtyApply int,qtyExam int,qtyPass int,qtyReturn int,days_study int,days_exam int,days_diploma int,days_archive int,days_study0 int,days_exam0 int,days_diploma0 int,days_archive0 int,examScore int,examTimes int)
	
	select @sql='insert into #temp_class(classID,className,adviserID,adviserName,startDate,endDate,status,archiveDate,archiverName,certID,qty,qtyApply,qtyExam,qtyPass,qtyReturn,examScore,examTimes) '
	select @sql = @sql + 'select classID,className,adviserID,adviserName,dateStart,dateEnd,status,archiveDate,archiverName,certID,qty,qtyApply,qtyExam,qtyPass,qtyReturn,examScore,examTimes from v_classInfo where ' + @where + ' and dateStart<getDate() order by dateStart desc'
	EXEC(@sql)

	--��д��������
	create table #temp_date(classID varchar(50),thisDate varchar(50))
	insert into #temp_date select a.classID, min(a.startDate) from (select b.classID, c.startDate from studentCourseList b, generatePasscardInfo c where b.passcardID=c.ID and b.passcardID>0
	 union select b.classID, c.startDate from studentCourseList b, generateApplyInfo c where b.applyID=c.ID and b.applyID>0) a
	 group by classID

	update #temp_class set examDate = b.thisDate from #temp_date b where #temp_class.classID=b.classID and #temp_class.qtyApply>0

	--��д֤����������
	truncate table #temp_date
	insert into #temp_date select b.classID, min(d.startDate) from studentCourseList b, studentCertList c, diplomaInfo d where b.refID=c.ID and c.diplomaID=d.diplomaID and c.diplomaID>''
	 group by b.classID

	update #temp_class set diplomaDate = b.thisDate from #temp_date b where #temp_class.classID=b.classID and #temp_class.qtyExam>0

	--��������
		--�����׼����
	update #temp_class set days_study=a.days_study,days_exam=a.days_exam,days_diploma=a.days_diploma,days_archive=a.days_archive from certificateInfo a where #temp_class.certID=a.certID
		--����ʵ������
	update #temp_class set startDate=left(startDate,10), days_study0=datediff(d,startDate,(case when endDate='' then getdate() else endDate end)),	--�������
		days_exam0=(case when endDate='' then 0 else datediff(d,endDate,(case when examDate is null then getdate() else examDate end)) end),	--��������
		days_diploma0=(case when examDate is null then 0 else datediff(d,examDate,(case when diplomaDate is null then getdate() else diplomaDate end)) end),	--��֤����
		days_archive0=(case when diplomaDate is null then 0 else datediff(d,diplomaDate,(case when archiveDate='' then getdate() else archiveDate end)) end)		--�鵵����
	update #temp_class set days_study0=(case when days_study0<0 then 0 when days_study0>0 and days_study0<8 then 8 else days_study0 end),days_exam0=(case when days_exam0<0 then 0 when days_exam0>0 and days_exam0<8 then 8 else days_exam0 end),days_diploma0=(case when days_diploma0<0 then 0 when days_diploma0>0 and days_diploma0<8 then 8 else days_diploma0 end),days_archive0=(case when days_archive0<0 then 0 when days_archive0>0 and days_archive0<8 then 8 else days_archive0 end)

	select * from #temp_class
END
GO

--CREATE Date:2020-11-13
--���ݸ������ڷ�Χ��ͳ���շ����������@refID������ܣ������ֲ�ͬ��˾����
--@refID: y,m,w,d ��������
--@fromID: ������Աֻ�ܿ��Լ�������
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
--���ݸ������ڷ�Χ��ͳ���շ����������@refID������ܣ������ֲ�֤ͬ������
--@refID: y,m,w,d ��������
--@fromID: ������Աֻ�ܿ��Լ�������
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


--��ȡĳ��ѧԱĳ����Ŀģ�⿼�Է�������
ALTER PROCEDURE getStudentExamStat
	@enterID int
AS
BEGIN
	select top 100 percent b.refID,b.examID,a.seq,min(c.examName) as examName,min(a.regDate) as regDate,a.knowpointID,a.kindID,min(a.knowpointName) as knowpointName,min(a.kindName) as kindName,sum(a.score) as score,count(*) as qty,sum(case when a.score>0 then 1 else 0 end) as qtyYes from v_ref_studentQuestionList a, studentExamList b, examInfo c
		where a.refID=b.paperID and b.examID=c.examID and b.refID=@enterID group by b.refID,b.examID,a.seq,a.knowpointID,a.kindID order by b.refID,b.examID,a.seq,a.knowpointID
END
GO

--��ȡĳ���༶ģ�⿼�Է�������
CREATE PROCEDURE getClassExamStat
	@classID varchar(50)
AS
BEGIN
	select top 100 percent b.examID,a.knowPointID,a.kindID,min(d.examName) as examName,min(a.knowPointName) as knowPointName,min(a.kindName) as kindName,count(*) as qty,sum(case when a.status=1 then 1 else 0 end) as qtyYes from v_studentQuestionUsed a, studentExamList b, studentCourseList c, examInfo d
		where a.refID=b.paperID and b.refID=c.ID and b.examID=d.examID and c.classID=@classID group by b.examID,a.knowPointID,a.kindID order by b.examID,a.knowPointID,a.kindID
END
GO

--��ȡĳ���༶���п�Ŀģ�⿼�Է�������
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

--�Զ��ſα�
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
		set datefirst 1		--����һΪ��һ��

		declare rc cursor for select seq,kindID,typeID,online,hours,period,item,point from schedule where courseID=@courseID and status=0 order by seq
		open rc
		fetch next from rc into @seq,@kindID,@typeID,@online,@hours,@period,@item,@point
		While @@fetch_status=0 
		Begin
			--���㵱ǰ����
			select @theDate = dateadd(d,@n,@startDate)
			--ȷ�������ڼ�ʱ�����ʦ�Ƿ��пգ����û�пգ������ѡȡ�����пյĽ�ʦ
			--if @teacher > '' and exists(select 1 from classSchedule where theDate=@theDate and typeID=@typeID and teacher=@teacher and online=0)
			--begin
			--	select @teacher = ''
			--	select top 1 @teacher = teacherID from dbo.getFreeTeacherList(@theDate,@classID,@mark) order by freePoint desc
			--end

			insert into classSchedule(mark,classID,courseID,seq,kindID,typeID,online,point,hours,period,theDate,theWeek,item,address,teacher,registerID)
				select @mark,@classID,@courseID,@seq,@kindID,@typeID,@online,@point,@hours,@period,@theDate,datepart(weekday,@theDate),@item,@classroom,@teacher,@registerID
			if @typeID=1
				select @n = @n + 1	--��������ν�����һ��
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
		select @re=1	--����ǩ����¼�ģ��α���ɾ��

	select isnull(@re,0) as re
END
GO

------------------
-- CREATE DATE: 2020-05-24
-- ���ݸ����Ĳ��������¿ɱ���Ϣ
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
	--	select @re=2, @msg='�������ظ�'
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
-- ���ݸ����Ĳ��������¿ɱ���Ϣ
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
-- ���ݸ����Ĳ�������ӻ��߸��½�ʦ��Ϣ
-- USE CASE: exec updateTeacherInfo 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updateTeacherInfo]
	@ID int,@teacherID varchar(50),@teacherName varchar(50),@host varchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	declare @re int
	select @re=@ID

	if @ID=0 and not exists(select 1 from teacherInfo where teacherID=@teacherID)	-- �¼�¼
	begin
		--��д���ɼ�¼
		insert into teacherInfo(teacherID,teacherName,host,memo,registerID) values(@teacherID,@teacherName,@host,@memo,@registerID)
		select @re=max(ID) from teacherInfo where registerID=@registerID
	end
	if @ID>0 and not exists(select 1 from teacherInfo where teacherID=@teacherID and ID<>@ID)	-- ������Ϣ
	begin
		update teacherInfo set teacherName=@teacherName,host=(case when @host='' then null else @host end),memo=@memo where ID=@ID
	end

	--�Զ������û��˺�
	if not exists(select 1 from userInfo where userNo=@teacherID)
	begin
		declare @passwd varchar(50)
		select @passwd = memo from dictionaryDoc where kind='userPasswd' and ID=0
		insert into userInfo(host,userNo,userName,realName,password,deptID,registerID) 
			values(@host,@teacherID,@teacherID+'.'+@host,@teacherName,@passwd,0,'system.')
	end

	--�Զ������ʦ��ɫ
	if not exists(select 1 from roleUserList where username=@teacherID+'.'+@host and roleID='teacher')
		insert into roleUserList(roleID,userName,host,registerID) select 'teacher',@teacherID+'.'+@host,@host,'system.'
	
	select @re as re
END
GO

--�Զ������༶���ظ���ѧ�ţ��ظ����Զ��ŵ����
--���Խ���classID or ID in classInfo
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
-- ���ݸ����Ĳ�����������Ҫ�Ƚϵ�ѧԱ����
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
-- ���ݸ����Ĳ�����������Ҫ�Ƚϵ�ѧԱ����
-- USE CASE: exec [checkStudentOrder] 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[checkStudentOrder]
	@batchID varchar(50),@certID varchar(50)
AS
BEGIN
	--ɾ��������
	delete from import_student_order where regDate<dateadd(d,-1,getDate())
	--������֤
	update import_student_order set mark=1, result='���֤����' where batchID=@batchID and [dbo].[fn_validateIDCard](username)=0
	--����Ƿ���ע��
	update import_student_order set mark=1, result='��δע��' where batchID=@batchID and mark=0 and username not in(select username from studentInfo)
	--����Ƿ��ѱ���
	update import_student_order set mark=1, result='��δ����' where batchID=@batchID and mark=0 and username not in(select username from v_studentCourseList where certID=@certID)
	--���䵥λ����
	update import_student_order set unit=b.dept1Name + b.unit,mobile=b.mobile from import_student_order a, v_studentInfo b where a.username=b.username and a.batchID=@batchID
	--���ұ�����Ϣ
	update import_student_order set enterID=b.enterID from import_student_order a, (select username,max(c.ID) as enterID from studentCourseList c, courseInfo d where c.courseID=d.courseID and d.certID=@certID group by username) b where a.username=b.username and a.batchID=@batchID and a.mark=0
	--���Ұ༶��Ϣ
	update import_student_order set classID=b.classID,SNo=b.SNo,diplomaID=b.diplomaID,diplomaDate=b.diploma_startDate,score=b.score + (case when b.score2>'' then '/'+b.score2 else '' end),enterDate=b.regDate,passcard=(case when b.passcardID+b.applyID>0 then cast(b.passcardID+b.applyID as varchar) else '' end) from import_student_order a, v_studentCourseList b where a.enterID=b.ID and a.batchID=@batchID and a.mark=0
	--���ҿ���ʱ��
	update import_student_order set startDate=convert(varchar(10),b.dateStart,23),courseName=b.courseName,className=b.classNameMemo from import_student_order a, v_classInfo b where a.classID=b.classID and a.batchID=@batchID and a.mark=0

	select * from import_student_order where batchID=@batchID order by No,ID
END
GO

------------------
-- CREATE DATE: 2022-08-27
-- ���ݸ��������ڣ�ͳ��ÿ�졢��λ���γ̵�����������������ȷ��Ϊ׼��
-- ���Ϊexcel
-- USE CASE: exec [rpt_dailyUnitCourse] 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[rpt_dailyUnitCourse]
	@dateStart nvarchar(50), @dateEnd nvarchar(50)

AS
BEGIN
	declare @sql nvarchar(max), @column nvarchar(max), @condition nvarchar(max)
	if OBJECT_ID('tempdb..#tab_rpt_dailyUnitCourse') is not null
		drop table #tab_rpt_dailyUnitCourse
	create table #tab_rpt_dailyUnitCourse([����] varchar(50),[��λ] nvarchar(100))

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

	declare @cols nvarchar(max) = N'alter table [dbo].[#tab_rpt_dailyUnitCourse] add [С��] int,' + replace(@column,',',' int,') + N' int'
	exec (@cols)

	select @sql=N'insert into #tab_rpt_dailyUnitCourse select submitDate, unit, 0,' + @column + 
	N' from v_studentUnitCourseInfo pivot(sum(qty) for shortName in (' + @column + N')) as pivot_stuinfo' + @condition + N' order by submitDate,unit'

	--print(@sql)

	exec (@sql)
	select @cols = N'update #tab_rpt_dailyUnitCourse set [С��]= isnull(' + replace(@column,',',',0)+isnull(') + N',0)'
	exec (@cols)
	select @cols = N'insert into #tab_rpt_dailyUnitCourse select ''�ϼ�'','''', sum([С��]),sum(isnull(' + replace(@column,',',',0)),sum(isnull(') + N',0)) from #tab_rpt_dailyUnitCourse'
	exec (@cols)
	select * from #tab_rpt_dailyUnitCourse
END
GO

------------------
-- CREATE DATE: 2022-08-27
-- ���ݸ��������ڣ�ͳ��ÿ�졢�γ̵�����������������ȷ��Ϊ׼��
-- ���Ϊexcel
-- USE CASE: exec [rpt_dailyCourse] 1,1,'xxxx'...
ALTER PROCEDURE [dbo].[rpt_dailyCourse]
	@dateStart nvarchar(50), @dateEnd nvarchar(50)

AS
BEGIN
	declare @sql nvarchar(max), @column nvarchar(max), @condition nvarchar(max)
	if OBJECT_ID('tempdb..#tab_rpt_dailyCourse') is not null
		drop table #tab_rpt_dailyCourse
	create table #tab_rpt_dailyCourse([����] varchar(50))

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

	declare @cols nvarchar(max) = N'alter table [dbo].[#tab_rpt_dailyCourse] add [С��] int,' + replace(@column,',',' int,') + N' int'
	exec (@cols)

	select @sql=N'insert into #tab_rpt_dailyCourse select submitDate, 0,' + @column + 
	N' from v_studentCourseInfo pivot(sum(qty) for shortName in (' + @column + N')) as pivot_stuinfo' + @condition + N' order by submitDate'

	--print(@sql)

	exec (@sql)
	select @cols = N'update #tab_rpt_dailyCourse set [С��]= isnull(' + replace(@column,',',',0)+isnull(') + N',0)'
	exec (@cols)
	select @cols = N'insert into #tab_rpt_dailyCourse select ''�ϼ�'', sum([С��]),sum(isnull(' + replace(@column,',',',0)),sum(isnull(') + N',0)) from #tab_rpt_dailyCourse'
	exec (@cols)
	select * from #tab_rpt_dailyCourse
END
GO

-- =============================================
-- CREATE Date: 2022-11-24
-- Description:	������ѧ��������ӻ����ǩ������Ƭ��֪ͨ��
-- @kindID: 0 ��Ƭ  1 ǩ��
-- @selList: �������ö��ŷָ���username/enterID
-- Use Case:	exec [sendAttections] 2,'...'
-- =============================================
ALTER PROCEDURE [dbo].[sendAttections] 
	@kindID int, @selList varchar(4000),@registerID varchar(50)
AS
BEGIN
	declare @re int
	--���������뵽��ʱ��
	create table #temp_photo(id varchar(50))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0, @re=0
	while @n>@j
	begin
		insert into #temp_photo(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	--����¼�¼
	insert into log_attention(refID,kindID,registerID) select id,@kindID,@registerID from #temp_photo where id not in(select refID from log_attention where kindID=@kindID)
	insert into log_generateAttention(kindID,registerID) values(@kindID,@registerID)
	select @re=max(ID) from log_generateAttention where registerID=@registerID

	--����ԭ�м�¼
	update log_attention set status=1, regDate=getDate(), registerID=@registerID from log_attention a, #temp_photo b where a.kindID=@kindID and a.refID=b.id

	--���������ǩ������ԭ����ǩ��ȥ��
	if @kindID=1
		update studentCourseList set signature=null,signatureDate=null from studentCourseList a, #temp_photo b where a.ID=b.id

	drop table #temp_photo
	return isnull(@re,0)
END

GO

------------------
-- CREATE DATE: 2022-11-24
-- �ظ������ύ��Ƭ��ǩ������ʾ��Ϣ
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
-- Description:	�����ر�ǩ������Ƭ֪ͨ״̬��
-- batchID: classInfo.classID;
-- @kindID: 0 ��Ƭ  1 ǩ��  
-- kind: "" ���֤  "cert":studentCertList.ID
-- @selList: �������ö��ŷָ���username/enterID
-- Use Case:	exec [closeAttections] 2,'...'
-- =============================================
ALTER PROCEDURE [dbo].[closeAttections] 
	@batchID varchar(50), @kindID int, @kind varchar(50), @selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	--���������뵽��ʱ��
	create table #temp_attention_close(id varchar(50),enterID int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_attention_close(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	--�����ǩ��֪ͨ��Ӧȡ��enterID list �滻 username list
	if @kindID=1
		update #temp_attention_close set enterID=b.ID from #temp_attention_close a, studentCourseList b where a.id=b.username and b.classID=@batchID
	--�����studentCertList.ID with kindID=0
	if @kind='cert' and @kindID=0
		update #temp_attention_close set id=b.username from #temp_attention_close a, studentCertList b where a.id=b.ID

	--����ԭ�м�¼
	update log_attention set status=3, closeItem=convert(varchar(50),getDate(),120) + ' ' + @registerID from log_attention a, #temp_attention_close b where a.kindID=@kindID and a.refID=b.id and a.status<3

	drop table #temp_attention_close
END

GO

-- =============================================
-- Author:		Albert
-- Create date: 2023-03-02
-- Description:	����ID�޸���Ƶ�ĵ㲥��ַ
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
-- Description:	����������������֤�飬kind:0���ص�����֤״̬; 1�ܾ���֤��
-- @selList: �������ö��ŷָ���diplomaInfo.ID
-- Use Case:	exec [cancelDiplomas] '...'
-- =============================================
ALTER PROCEDURE [dbo].[cancelDiplomas] 
	@selList varchar(4000), @kind int, @registerID varchar(50)
AS
BEGIN
	--���������뵽��ʱ��
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

	--���±�����
	update studentCertList set diplomaID=(case when @kind=0 then null else '*' end) from studentCertList a, #temp_diploma_cancel b where a.diplomaID=b.id

	--ɾ��֤���¼
	delete from diplomaInfo where diplomaID in(select id from #temp_diploma_cancel)

	drop table #temp_diploma_cancel
END

GO

-- =============================================
-- CREATE Date: 2022-11-24
-- Description:	�����ܾ�/��������֤�����롣
-- @kind: 0 �ܾ�  1 �ָ�
-- @selList: �������ö��ŷָ���studentCertList.ID
-- Use Case:	exec [refuse_diploma_order] '...'
-- =============================================
CREATE PROCEDURE [dbo].[refuse_diploma_order] 
	@selList varchar(4000), @kind int, @registerID varchar(50)
AS
BEGIN
	--���������뵽��ʱ��
	create table #refuse_diploma_order(id int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #refuse_diploma_order(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	if @kind=0	--�ܾ�
	begin
		update studentCertList set diplomaID='*' from studentCertList a, #refuse_diploma_order b where a.ID=b.id
		exec writeOpLog '','�ܾ�֤����������','refuse_diploma_order',@registerID,'',@selList
	end
	if @kind=1	--�ָ�
	begin
		update studentCertList set diplomaID='' from studentCertList a, #refuse_diploma_order b where a.ID=b.id
		exec writeOpLog '','�ָ�֤����������','refuse_diploma_order',@registerID,'',@selList
	end

	drop table #refuse_diploma_order
END

GO

-- =============================================
-- Author:		Albert
-- Create date: 2023-03-28
-- Description:	��ĳ�����ԣ�������ͬ���Ծ���Ŀ��˳��
-- =============================================
ALTER PROCEDURE [dbo].[syncPaper4Exam] 
	@batchID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @paperID int, @n int
    --����һ����������Ŀ
	select @paperID=min(a.paperID), @n=count(*) from studentExamList a, passcardInfo b where a.refID=b.ID and b.refID=@batchID and a.kind=1
	exec addQuestions4StudentExam @paperID,1,0,'',0,1,20,0	--ǿ������������Ŀ
	--���临�Ƹ�������
	if @n>1 and @paperID>0
	begin
		--ɾ��
		delete from studentQuestionList where refID in(select a.paperID from studentExamList a, passcardInfo b where a.refID=b.ID and b.refID=@batchID and a.paperID>@paperID)
		--���
		insert into studentQuestionList(questionID,refID,kindID,scorePer,answer) select c.questionID,a.paperID,c.kindID,c.scorePer,c.answer from studentExamList a, passcardInfo b, studentQuestionList c where a.refID=b.ID and c.refID=@paperID and b.refID=@batchID and a.paperID>@paperID 
	end
END
GO

--����ɾ��������¼
--exec dbo.delEnterByClass 669
create procedure delEnterByClass(@ID int)
as
begin
	delete from studentCertList where (ID in(select a.refID from studentCourseList a, classInfo b where a.classID=b.classID and b.ID=@ID))
	delete from studentCourseList where (ID in(select a.ID from studentCourseList a, classInfo b where a.classID=b.classID and b.ID=@ID))
end

------------------
-- CREATE DATE: 2020-05-24
-- ���ݸ����Ĳ�������ӻ��߸��µ��벹��������Ϣ
-- USE CASE: exec applyResit 1,1,'xxxx'...
CREATE PROCEDURE [dbo].[applyResit]
	@batchID int,@passNo varchar(50),@username varchar(50), @registerID varchar(50)

AS
BEGIN
	-- ����༶���Ѿ��б�����Ϣ����������
	if exists(select 1 from applyInfo a, studentCourseList b where a.enterID=b.ID and a.refID=@batchID and b.username=@username)
		update applyInfo set applyNo=@passNo,statusApply=1 from applyInfo a, studentCourseList b where a.enterID=b.ID and a.refID=@batchID and b.username=@username
	else
	begin
		-- ���û���ҵ���¼�����ҳ�����¼
		declare @enterID int, @ID int
		select @enterID=max(b.ID) from generateApplyInfo a, studentCourseList b where a.ID=@batchID and b.username=@username and a.courseID=b.courseID
		select @ID=max(ID) from applyInfo where enterID=@enterID

		-- ������¼����Ѱ��Ų������
		update applyInfo set resit=1 where ID=@ID

		-- ����걨��Ϣ
		insert into applyInfo(refID,enterID,applyNo,statusApply,kind,registerID) select @batchID,@enterID,@passNo,1,'����',@registerID

		--���±�����
		update studentCourseList set applyID=@batchID where ID=@enterID
	end

	return 0
END
GO

-- CREATE DATE: 2023-02-16
-- ���ݸ����Ĳ�����ĳ��ѧԱ�Ĳ�ͬ���ϻ���
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
	-- д������־
	select @event='ѧԱ���ϻ���'
	exec writeOpLog '',@event,'exchangeMaterial',@registerID,@logMemo,@username
	select 0 as re
END
GO

-- CREATE DATE: 2020-05-08
-- �жϸ����ַ����Ƿ�Ϊ�գ�����ǣ�����ָ�����ֵ�����򷵻�����
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
-- Description:	�ϴ���Ʊ��Ϣ
-- ��Ʊ����+��Ʊ��+���ϱ�� unique value
-- =============================================
CREATE PROCEDURE import_invoice_daily 
	@kind nvarchar(50),@invCode varchar(50),@invID varchar(50),@taxNo varchar(50),@taxUnit nvarchar(50),@invDate varchar(50),@item varchar(100),@amount varchar(50),@cancel varchar(50),@cancelDate varchar(50),@operator nvarchar(50),@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	if not exists(select 1 from invoiceInfo where invCode=@invCode and invID=@invID and cancel=iif(@cancel='��',1,0))
	begin
		
		insert into invoiceInfo(kind,invCode,invID,taxNo,taxUnit,invDate,item,amount,cancel,cancelDate,payType,payStatus,operator,memo,registerID)
		select @kind,@invCode,@invID,@taxNo,@taxUnit,[dbo].[whenull](@invDate,null),REPLACE(REPLACE(@item,'*��ѧ����������*',''),'��ѵ��',''),@amount,iif(@cancel='��',1,0)
		,[dbo].[whenull](@cancelDate,null),(case when PATINDEX('%֧����%',@memo)>0 then '֧����' when PATINDEX('%΢��%',@memo)>0 then '΢��' when PATINDEX('%�ֽ�%',@memo)>0 then '�ֽ�' when PATINDEX('%ת��%',@memo)>0 then 'ת��' else '' end)
		,iif(PATINDEX('%ת��%',@memo)>0,1,0),@operator,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@memo,'֧����',''),'΢��',''),'�ֽ�',''),'ת��',''),'���վ�',''),' ',''),@registerID
	end
END
GO

-- =============================================
-- CREATE Date: 2020-10-02
-- Description:	��������տ��Ӧ�տƱ�в�������
-- @selList: ID
-- =============================================
CREATE PROCEDURE [dbo].[setPayReceive] 
	@selList varchar(4000), @registerID varchar(50)
AS
BEGIN
	--Ϊ������ʱ��
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
--���ݸ������ڣ�ͳ�Ʋ�ͬ�շѷ�ʽ���շ����
ALTER PROCEDURE [dbo].[getDailyIncomeRpt]
	@startDate varchar(50), @endDate varchar(50)
AS
BEGIN
	select @endDate = iif(@endDate='',convert(varchar(20),getDate(),23),@endDate)
	create table #tbl (item varchar(50),amount int, inv int, mark int default(0))
	insert into #tbl(item,amount,inv) select payType,sum(amount),count(*) from(
		select payType,amount from v_invoiceInfo where invDate>=@startDate and invDate<=@endDate and amount>0 and cancel=0 and payStatus=0		--�����뷢Ʊ, ������Ӧ��
		union all select typeName, amount from v_payReceiptInfo where datePay>=@startDate and datePay<=@endDate	--�վ�
		) a group by payType
	insert into #tbl(item,amount,inv) select '�˷�',-sum(ABS(amount)),count(*) from (
		select amount from v_invoiceInfo where invDate>=@startDate and invDate<=@endDate and amount<0	--��巢Ʊ
		union all select amount from v_invoiceInfo where cancelDate>=@startDate and cancelDate<=@endDate and cancel=1	--���Ϸ�Ʊ
		) a
	insert into #tbl(item,amount,inv) select '���е���',sum(amount),count(*) from v_invoiceInfo where checkDate>=@startDate and checkDate<=@endDate 	--ת��ȷ��
	insert into #tbl(item,amount,inv) select '������λ����',sum(amount),count(*) from v_invoiceInfo where checkDate>=@startDate and checkDate<=@endDate and 1=0 	--������λת��ȷ��
	insert into #tbl(item,amount,inv,mark) select '����ϼ�',sum(amount),sum(inv),1 from #tbl
	insert into #tbl(item,amount,inv,mark) select 'Ӧ���˿�',sum(amount),count(*),2 from v_invoiceInfo where payStatus=1 	--Ӧ���˿�(��У)
	insert into #tbl(item,amount,inv,mark) select 'Ӧ���˿�(������λ)',sum(amount),count(*),2 from v_invoiceInfo where payStatus=1 and 1=0	--Ӧ���˿�(������λ)
	insert into #tbl(item,amount,inv,mark) select 'Ӧ���˿�ϼ�',sum(amount),sum(inv),1 from #tbl where mark=2
	select item as ��Ŀ, isnull(amount,0) as ����, isnull(inv,0) as Ʊ������, mark from #tbl
END
GO

--CREATE Date:2023-08-25
--���ݸ������ڣ�ͳ�Ʋ�ͬ��Ŀ�ı������
ALTER PROCEDURE [dbo].[getDailyEnterRpt]
	@startDate varchar(50), @endDate varchar(50)
AS
BEGIN
	select @endDate = iif(@endDate='',convert(varchar(20),getDate(),23),@endDate)
	create table #tbl (courseID varchar(50),item varchar(50),amount int, inv int, mark int default(0))
	insert into #tbl(courseID, item) select courseID, shortName from v_courseInfo where status=0 and host=''
	update #tbl set amount = b.count from #tbl a, (select courseID, count(*) as count from v_studentCourseList where submitDate>=@startDate and submitDate<=@endDate and status<3 and host in('znxf','shm','spc') group by courseID) b where a.courseID=b.courseID	--��������(�������˿εļ�������λ��)
	update #tbl set inv = d.count from #tbl a, (select b.courseID, count(*) as count from v_studentCourseList b, classInfo c where b.classID=c.classID and c.pre=1 and b.status<3 and b.submitDate>'' group by b.courseID) d where a.courseID=d.courseID	--Ԥ��������(�������˿ε�), ����������λ���ύ��
	insert into #tbl(item,amount,inv,mark) select '�ϼ�',sum(amount),sum(inv),1 from #tbl
	select item as ��Ŀ, isnull(amount,0) as ��������, isnull(inv,0) as δ�����ۼ�����, courseID, mark from #tbl
END
GO


--CREATE Date:2023-07-30
--���ݸ������ڡ�����г���ϸ
--kind: �շ����͡��˷ѡ����е��ˡ�������λ���Ӧ���˿Ӧ���˿�(������λ)
ALTER PROCEDURE [dbo].[getDailyIncomeRptDetail]
	@startDate varchar(50), @endDate varchar(50), @kind varchar(50)
AS
BEGIN
	select @endDate = iif(@endDate='',convert(varchar(20),getDate(),23),@endDate)
	if @kind='�ֽ�' or @kind='֧����' or @kind='΢��' or @kind='����ת��' or @kind='֧Ʊ' 
		select payType,amount,invCode,invID,invDate,item,memo from v_invoiceInfo where invDate>=@startDate and invDate<=@endDate and amount>0 and cancel=0 and payStatus=0 and payType=@kind		--�����뷢Ʊ, ������Ӧ��
		union all select typeName,amount,'', invoice,datePay,title,memo from v_payReceiptInfo where datePay>=@startDate and datePay<=@endDate and typeName=@kind	--�վ�
	if @kind='�˷�'
		select payType,amount,invCode,invID,invDate,item,memo from v_invoiceInfo where invDate>=@startDate and invDate<=@endDate and amount<0	--��巢Ʊ
		union all select payType,amount,invCode,invID,cancelDate,item,memo from v_invoiceInfo where cancelDate>=@startDate and cancelDate<=@endDate and cancel=1	--���Ϸ�Ʊ
	if @kind='���е���'
		select payType,amount,invCode,invID,checkDate,item,memo from v_invoiceInfo where checkDate>=@startDate and checkDate<=@endDate	--���е���
	if @kind='������λ����'
		select payType,amount,invCode,invID,invDate,item,memo from v_invoiceInfo where invDate>=@startDate and invDate<=@endDate and 1=0	--������λ����
	if @kind='Ӧ���˿�'
		select payType,amount,invCode,invID,invDate,item,memo from v_invoiceInfo where payStatus=1 	--Ӧ���˿�(��У
	if @kind='Ӧ���˿�(������λ)'
		select payType,amount,invCode,invID,invDate,item,memo from v_invoiceInfo where payStatus=1 and 1=0	--Ӧ���˿�(������λ)
END
GO


--CREATE Date:2023-07-30
--���ݸ������ڡ�����г���ϸ
--kind: courseID
ALTER PROCEDURE [dbo].[getDailyEnterRptDetail]
	@startDate varchar(50), @endDate varchar(50), @kind varchar(50)
AS
BEGIN
	select @endDate = iif(@endDate='',convert(varchar(20),getDate(),23),@endDate)
	select SNo as ѧ��, username as ���֤, name as ����, shortName as ��ѵ��Ŀ, submitDate as ��������, unit as ��λ���� from v_studentCourseList where submitDate>=@startDate and submitDate<=@endDate and status<3 and courseID=@kind and host in('znxf','shm','spc')
END
GO


--CREATE Date:2021-07-10
--���ݸ���ʯ����˾����ID�����ؿ�Ʊ��Ϣ����������
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
			select @title=item from dictionaryDoc where kind='SPCtitle'	--�������͵Ĳ��ţ�ѡȡʯ����˾ͳһ��Ʊ��Ϣ
		insert into @tab(payNow,title) select @payNow,@title
	end

	return
END
GO

-- =============================================
-- CREATE Date: 2023-06-01
-- Description:	����������ȡ��������
-- @selList: �������ö��ŷָ���ID in applyInfo
-- Use Case:	exec [getApplyListByList] '...'
-- =============================================
ALTER PROCEDURE [dbo].[getApplyListByList] 
	@selList varchar(4000)
AS
BEGIN
	declare @kindID int, @unit nvarchar(200)
	--���������뵽��ʱ��
	create table #temp(id int, punit nvarchar(200))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end
	update #temp set punit=c.hostName from #temp a, v_applyInfo d, studentInfo b, hostInfo c where a.id=d.id and d.username=b.username and c.hostNo=b.host
	select name,sexName,educationName,username,mobile,iif(a.unit>'',a.unit,punit) as unit,iif(job='','����',job) as job,link_address,IDdateStart,IDdateEnd,photo_filename as file1,certName,c.linker,a.ID,file2, (case when employe_filename>'' then N'����֤��' when job_filename>'' then N'��ס֤' when social_filename>'' then N'�籣' else '' end) as jobcert, (case when employe_filename>'' then employe_filename when job_filename>'' then job_filename when social_filename>'' then social_filename else '' end) as jobfile,a.tax from v_applyInfo a, #temp b, hostInfo c where a.ID=b.id and a.host=c.hostNo order by passNo,a.ID
END
GO

-- =============================================
-- CREATE Date: 2025-09-27
-- Description:	����classID��ȡgenerateApplyInfo����
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
-- �걨˵��
CREATE PROCEDURE [dbo].[setApplyMemo]
	@ID int, @step nvarchar(50), @memo nvarchar(500)
AS
BEGIN
	update applyInfo set step=@step,memo1=isnull(memo1,'')+'<br>'+isnull(memo,''),memo = @memo + ' ' + convert(varchar(20),getDate(),120) where ID=@ID
END
GO

-- CREATE DATE: 2023-05-30
-- �ϴ��������¼
CREATE PROCEDURE [dbo].[setApplyUpload]
	@ID int
AS
BEGIN
	update applyInfo set upload=1,memo1=isnull(memo1,'') + '<br>' + '�ϴ�������' + convert(varchar(20),getDate(),120) where ID=@ID
END
GO

-- CREATE DATE: 2023-05-30
-- �ϴ���Ƭ
CREATE PROCEDURE [dbo].[setApplyPhotoUpload]
	@ID int
AS
BEGIN
	update applyInfo set memo1=isnull(memo1,'') + '<br>' + '�ϴ���Ƭ' + convert(varchar(20),getDate(),120) where ID=@ID
END
GO


-- CREATE DATE: 2023-02-16
-- ����һ���༶�İ༶/�걨������
-- USE CASE: exec [generate_emergency_exam_materials_byclass] 1
ALTER PROCEDURE [dbo].[generate_emergency_exam_materials_byclass]
	@batchID int, @selList varchar(4000), @keyID int, @fn nvarchar(100), @registerID varchar(50)
AS
BEGIN
	--���������뵽��ʱ��
	create table #temp(id int)
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	if @keyID=2		--�༶
		update studentCourseList set file1='/upload/students/firemanMaterials/' + cast(b.ID as varchar) + '_' + b.name + '_' + b.username + @fn from studentCourseList a, v_applyInfo b, #temp c where a.ID=b.enterID and b.ID=c.id
	if @keyID=5		--������
		update studentCourseList set file2='/upload/students/firemanMaterials/' + cast(b.ID as varchar) + '_' + b.name + '_' + b.username + @fn from studentCourseList a, v_applyInfo b, #temp c where a.ID=b.enterID and b.ID=c.id
	--exec writeOpLog @fn,'generate_emergency_exam_materials_byclass',@registerID,@keyID,@batchID
	select a.ID,name,username,enterID,entryform from v_applyInfo a, #temp b where a.ID=b.id and a.signature>'' order by a.ID
END
GO

-- CREATE DATE: 2024-04-27
-- ���ĳ���༶�Ƿ���ָ����ѧԱ
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
-- ���ĳ���༶��ѧԱ����
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
-- ����ĳ���α��ǩ�������qty ������ qty0 ǩ������ qty1 ����ǩ���� qty2 ����ǩ������
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
-- ѧԱ�˷�
ALTER PROCEDURE [dbo].[enterRefund]
	@enterID int,@amount decimal(18,2),@dateRefund varchar(50),@memo nvarchar(500), @registerID varchar(50)
AS
BEGIN
	update studentCourseList set refund_memo=@memo, pay_status=2, refund_amount=@amount, dateRefund=@dateRefund, refunderID=@registerID where ID=@enterID
	exec writeOpLog '','�˿�','enter',@registerID,@memo,@enterID
END
GO

-- CREATE DATE: 2023-05-26
-- ѧԱ����
CREATE PROCEDURE [dbo].[enterPay]
	@enterID int,@amount decimal(18,2),@pay_kind int,@pay_type int,@memo nvarchar(500), @registerID varchar(50)
AS
BEGIN
	update studentCourseList set pay_kindID=@pay_kind, pay_type=@pay_type, pay_status=1, amount=@amount, datePay=getDate(), pay_checkDate=getDate(), pay_memo=@memo, pay_checker=@registerID where ID=@enterID
	exec writeOpLog '','����','enter',@registerID,@memo,@enterID
END
GO

-- CREATE DATE: 2023-05-26
-- ŵŵ֧����Ʊ��Ϣ
-- kind: 0 ����  1 �˿�  2 ��Ʊ
-- payStatus: ֧��״̬��0--��֧�� 1--��֧�� 2--֧��ʧ�� 3--�ر� 4--�˿��� 5--�˿�ɹ� 6--�˿�ʧ�ܣ�
ALTER PROCEDURE [dbo].[setAutoPayInfo]
	@kind int,@enterOrder varchar(50),@amount decimal(18,2),@payStatus int,@payType varchar(50),@payTime varchar(50),@subject nvarchar(500),@customerTaxnum varchar(50),@orderNo varchar(50),@outOrderNo varchar(50),@userId varchar(50),@phone varchar(50),@memo nvarchar(500)
AS
BEGIN
	declare @classID varchar(50),@enterID int
	if (@kind=1 and @payStatus=5) or (@kind=2 and @payStatus=1)		--�˿�/��Ʊʱ������ŵŵ��������ƥ��ԭ�����¼
		select @enterID=enterID from autoPayInfo where orderNo=@orderNo and kind=0 and payStatus=1
	else
		select @enterID=left(@enterOrder,charindex('-',@enterOrder)-1)

	if not exists(select 1 from autoPayInfo where enterID=@enterID and kind=@kind and payStatus=@payStatus)
	begin
		insert into autoPayInfo (kind,enterID,enterOrder,amount,payType,payStatus,payTime,subject,customerTaxnum,orderNo,outOrderNo,userId,phone,memo) values(@kind,@enterID,@enterOrder,@amount,@payType,@payStatus,@payTime,@subject,@customerTaxnum,@orderNo,@outOrderNo,@userId,@phone,@memo)
		if @kind=0 and @payStatus=1
		begin
			select @classID=a.classID from classInfo a, studentCourseList b where a.courseID=b.courseID and b.ID=@enterID and a.pre=1 and a.host=''
			--���û�а༶���ɷѺ��Զ�����Ԥ����
			update studentCourseList set autoPay=1,pay_status=1,pay_type=iif(@payType='WECHAT',2,1),datePay=@payTime,amount=@amount,checked=1,checkDate=getDate(),submited=1,submitDate=getDate(),pay_memo=isnull(pay_memo,'') + @userId + ':' + @outOrderNo,classID=iif(classID is null,@classID,classID),pay_checker='system.' where ID=@enterID
			--���û�пα���ӿα�
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
		select @event=(case when @kind=0 then '�ӿڸ���' when @kind=1 then '�ӿ��˿�' else '�ӿڿ�Ʊ' end)
		exec writeOpLog '',@event,'autoPayInfo','system.',@memo,@enterID
	end
END
GO

-- CREATE DATE: 2021-05-13
-- �α���º��޸��ѱ�����Ա�Ŀα�
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
		--��ӿα�
		delete from studentLessonList where refID=@enterID
		insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,@enterID,hours,'system.' from lessonInfo where courseID=@courseID and status=0

		--��ӿμ�
		delete from studentCoursewareList where refID in(select ID from studentLessonList where refID=@enterID)
		insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,'system.' from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@enterID and a.status=0

		--�����Ƶ
		delete from studentVideoList where refID in(select ID from studentLessonList where refID=@enterID)
		insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,'system.' from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@enterID and a.status=0

		--��ӿ��ԣ���Ŀ�ݲ�����
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
-- �α���º��޸��ѱ�����Ա�Ŀα�
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
		--��ӿα�
		delete from studentLessonList where refID=@enterID
		insert into studentLessonList(lessonID,refID,hours,registerID) select lessonID,@enterID,hours,'system.' from lessonInfo where courseID=@courseID and status=0

		--��ӿμ�
		delete from studentCoursewareList where refID in(select ID from studentLessonList where refID=@enterID)
		insert into studentCoursewareList(coursewareID,refID,proportion,pages,registerID) select a.coursewareID,b.ID,a.proportion,a.pages,'system.' from coursewareInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@enterID and a.status=0

		--�����Ƶ
		delete from studentVideoList where refID in(select ID from studentLessonList where refID=@enterID)
		insert into studentVideoList(videoID,refID,proportion,minutes,registerID) select a.videoID,b.ID,a.proportion,a.minutes,'system.' from videoInfo a, studentLessonList b where a.lessonID=b.lessonID and b.refID=@enterID and a.status=0

		--��ӿ��ԣ���Ŀ�ݲ�����
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
--���ݸ������������ص���γ��б�
--mark: 0 ÿ��һ�ο���  1 ������ֱ���
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
-- Description:	ɾ���α�
-- Use Case:	exec [delStandardSchedule] 1
-- =============================================
CREATE PROCEDURE [dbo].[delStandardSchedule] 
	@ID varchar(50), @memo nvarchar(50), @registerID varchar(50)
AS
BEGIN
	delete from schedule where ID=@ID
	-- д������־
	exec writeOpLog '','ɾ���α�','delStandardSchedule',@registerID,@memo,@ID
END

GO

-- =============================================
-- CREATE Date: 2021-03-24
-- Description:	ɾ���α�
-- Use Case:	exec [delSchedule] 1
-- =============================================
CREATE PROCEDURE [dbo].[delSchedule] 
	@ID varchar(50), @memo nvarchar(50), @registerID varchar(50)
AS
BEGIN
	delete from classSchedule where ID=@ID
	-- д������־
	exec writeOpLog '','ɾ���༶�α���ϸ','delStandardSchedule',@registerID,@memo,@ID
END

GO

-- CREATE DATE: 2023-05-26
-- ��ȡ�����շ���Ϣ��Ϊ�Զ��ɷ��ṩ����
-- kindID:  0 pay  1 refund  2 invoice  3 ���˵�
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
-- �����������ݴ���
-- @selList: classSchedule.ID with split ','
-- USE CASE: exec [setFaceCheckin] 1
ALTER PROCEDURE [dbo].[setFaceCheckin]
	@username varchar(50), @file1 varchar(500), @selList varchar(4000), @confidence float
AS
BEGIN
	--���������뵽��ʱ��
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
			--��¼��������
			select @file2 = isnull(filename,'') from studentMaterials where username=@username and kindID=0
			insert into faceDetectInfo(refID,keyID,kindID,file1,file2,status,confidence) values(@enterID,@refID,2,@file1,@file2,0,@confidence)
			--�����Ƭ
			update studentInfo set scanPhoto=1 where username=@username
			select @re=0, @msg='ǩ���ɹ�'
		end
		else
			select @re=2, @msg='�ظ�ǩ��'
	end
	else
	begin
		select @re=1, @msg='δ���γ�'
		insert into log_checkin_no_course(username,selList,file1) values(@username,@selList,@file1)
	end
	select isnull(@re,0) as status, @name as name, isnull(@msg,'') as msg
END
GO

-- CREATE DATE: 2024-01-22
-- �����������ݴ���: ɾ������
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
	exec writeOpLog '','ɾ������','cancelFaceCheckin','',@logMemo,@refID
END
GO

-- CREATE DATE: 2023-10-13
-- ����ѧԱ������Ƭ
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
-- Description:	����ѧԱ��Ƭ����Ϣ��
-- Use Case:	exec setStudentPhotoFaceID '310....' 
-- =============================================
CREATE PROCEDURE [dbo].[setStudentPhotoFaceID] 
	@username varchar(50), @faceID varchar(500), @faceScore varchar(50)
AS
BEGIN
	update studentInfo set faceID=@faceID, faceScore=@faceScore where username=@username
END
GO


-- CREATE DATE: 2024-06-23  ��������
-- ��ȡ����༶��ˢ�����ڱ�
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
	
	--q1:����ǩ������  q2:����ǩ������  q3:��ǩ������
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
-- ����/ȡ��ѧԱ����Ƶʱ��ǩ
-- USE CASE: exec [setCheckPass] 1
ALTER PROCEDURE [dbo].[setCheckPass]
	@enterID int,@registerID varchar(50)
AS
BEGIN
	declare @event varchar(50)
	update studentCourseList set check_pass=iif(check_pass=0,1,0) where ID=@enterID
	update studentVideoList set shotNow=0 where refID in(select ID from studentLessonList where refID=@enterID)
	-- д������־
	select @event='����/ȡ����ǩ'
	exec writeOpLog '', @event,'setCheckPass',@registerID,@enterID,@enterID
END
GO

-- CREATE DATE: 2023-02-16
-- ¼����������(��������ȡ)
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
-- ������������(��������ȡ)С��ͨ
-- USE CASE: exec [dealQuestionOther] 
-- select * from [questionOther]
-- select distinct kindID,questionName,answer,A,B,C,D,E,F from [questionOther]
-- insert questionOther1 select * from [questionOther]
ALTER PROCEDURE [dbo].[dealQuestionOther]
AS
BEGIN
	update [questionOther] set kindID=3 where kindID=4
	update [questionOther] set answer=iif(answer=1,'A','B'),A='��ȷ',B='����' where kindID=3
	update [questionOther] set answer=(case when answer=id_A then 'A' when answer=id_B then 'B' when answer=id_C then 'C' when answer=id_D then 'D' when answer=id_E then 'E' when answer=id_F then 'F' else '' end) where kindID=1
	update [questionOther] set answer=replace(replace(replace(replace(replace(replace(answer,id_A,'A'),id_B,'B'),id_C,'C'),id_D,'D'),id_E,'E'),id_F,'F') where kindID=2
	update [questionOther] set answer=replace(answer,',','') where kindID=2
	update [questionOther] set questionName=replace(replace(REPLACE(REPLACE(questionName, CHAR(13), ''), CHAR(10),''),char(9),''),' ','')
END
GO

-- CREATE DATE: 2024-07-06
-- ������ѵ֤����Ϣ��������Ŀ�����˰棩
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
-- ������ѵ֤����Ϣ��������Ŀ�������棩
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
-- ����ѧԱ�ڱ�������¿γ̿������
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
-- ����ѧԱ�ڱ���α�֮������¿γ̿��������ֻͳ�Ƶ����࿪��֮ǰ180��-����γ̽���ʱ��Σ�
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
-- ����ѧԱ�ڱ���α�֮������¿γ̿��ڴ�����ֻͳ�Ƶ����࿪��֮ǰ180��-����γ̽���ʱ��Σ�
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
-- ��¼֧���ӿڷ�������
-- USE CASE: exec [setAutoPayReturn] 1
ALTER PROCEDURE [dbo].[setAutoPayReturn]
	@kind varchar(50), @memo nvarchar(4000), @memo1 nvarchar(4000)
AS
BEGIN
	insert into autoPayReturn(kind, memo, memo1) values(@kind, @memo, @memo1)
END
GO


--CREATE Date:2023-07-30
--���ݸ������ڣ�ͳ�Ʋ�ͬ���۵ĵ��ա����±���������checkDateΪ׼�����շ�������۳��˷ѣ�Ӧ�տ��Ե�������dateReceiveΪ׼����
--���@endDate=''��ͳ�Ƶ��µף�����ָ������
--sales�����ֵ��ֻ�ܿ��Լ�������
ALTER PROCEDURE [dbo].[getSalesRpt]
	@startDate varchar(50), @endDate varchar(50), @host varchar(50), @sales varchar(50)
AS
BEGIN
	declare @d1 varchar(50), @d2 varchar(50)
	select @d1 = left(@startDate,7) + '-01', @d2 = iif(@endDate='',EOMONTH(@startDate),@endDate)
	create table #tbl (sales varchar(50),salesName nvarchar(50), p1 int, p2 int, p3 int, p4 int)
	create table #tbl0 (sales varchar(50), p1 int, p2 int)
	--�������۶�
	insert into #tbl(sales,p2) select fromID,sum(amount) from (select fromID, amount from v_studentCourseList where datePay>=@d1 and datePay<=@d2 and pay_type<>3 and host in('znxf','spc','shm')
		union all select fromID, amount from v_studentCourseList where dateReceive>=@d1 and dateReceive<=@d2 and pay_type=3 and host in('znxf','spc','shm')
		union all select fromID, -refund_amount from v_studentCourseList where dateRefund>=@d1 and dateRefund<=@d2 and host in('znxf','spc','shm')) a group by fromID
	--�������۶�
	insert into #tbl0(sales,p1) select fromID,sum(amount) from (select fromID, amount from v_studentCourseList where datePay=@startDate and pay_type<>3 and host in('znxf','spc','shm')
		union all select fromID, amount from v_studentCourseList where dateReceive=@startDate and pay_type=3 and host in('znxf','spc','shm')
		union all select fromID, -refund_amount from v_studentCourseList where dateRefund=@startDate and host in('znxf','spc','shm')) a group by fromID
	update #tbl set p1=b.p1 from #tbl a, #tbl0 b where a.sales=b.sales

	--���±�������
	delete from #tbl0
	insert into #tbl0(sales,p1) select fromID,count(*) from v_studentCourseList where checkDate>=@d1 and checkDate<=@d2 and host in('znxf','spc','shm') group by fromID
	update #tbl set p4=b.p1 from #tbl a, #tbl0 b where a.sales=b.sales
	--���챨������
	delete from #tbl0
	insert into #tbl0(sales,p1) select fromID,count(*) from v_studentCourseList where checkDate=@startDate and host in('znxf','spc','shm') group by fromID
	update #tbl set p3=b.p1 from #tbl a, #tbl0 b where a.sales=b.sales

	update #tbl set salesName=b.realName from #tbl a, userInfo b where a.sales=b.username
	update #tbl set salesName='δ֪' where sales='' or sales is null
	if @sales>''
		delete from #tbl where (sales<>@sales and sales<>iif(@sales='jiangwei.','amra.','')) or sales is null or sales=''
	insert into #tbl select '*',@startDate + iif(@endDate>'','/'+@endDate,'') + '�ϼ�',sum(p1),sum(p2),sum(p3),sum(p4) from #tbl
	select salesName as ����, isnull(p1,0) as ���ս��, isnull(p2,0) as ���½��, isnull(p3,0) as ��������, isnull(p4,0) as ��������, sales from #tbl order by ���� desc
END
GO

--CREATE Date:2023-07-30
--���ݸ������ڡ����ۣ��г�������ϸ
--���@endDate=''��ͳ�Ƶ��µף�����ָ������
--kind: 0 ������  1 ��Χ�ڽ��  2 ��������  3 ��Χ������
ALTER PROCEDURE [dbo].[getSalesRptDetail]
	@startDate varchar(50), @endDate varchar(50), @host varchar(50), @sales varchar(50), @kind int
AS
BEGIN
	declare @d1 varchar(50), @d2 varchar(50)
	select @d1 = left(@startDate,7) + '-01', @d2 = iif(@endDate='',EOMONTH(@startDate),@endDate)
	if @kind=0
		select ID,autoPay,username as '���֤', name as '����', amount as '���', datePay as '����', pay_typeName as '����', courseName, iif(unit>'',unit,hostName+dept1Name) + ':' + pay_memo as pay_memo from v_studentCourseList where datePay=@startDate and pay_type<>3 and host in('znxf','spc','shm') and fromID=@sales
		union all select ID,autoPay,username, name, amount, dateReceive, pay_typeName, courseName, iif(unit>'',unit,hostName+dept1Name) + ':' + pay_memo as pay_memo from v_studentCourseList where dateReceive=@startDate and pay_type=3 and host in('znxf','spc','shm') and fromID=@sales
		union all select ID,0,username, name, -refund_amount, dateRefund, '�˿�', courseName, refund_memo from v_studentCourseList where dateRefund=@startDate and host in('znxf','spc','shm') and fromID=@sales and refund_amount>0
	if @kind=1
		select ID,autoPay,username as '���֤', name as '����', amount as '���', datePay as '����', pay_typeName as '����', courseName, iif(unit>'',unit,hostName+dept1Name) + ':' + pay_memo as pay_memo from v_studentCourseList where datePay>=@d1 and datePay<=@d2 and pay_type<>3 and host in('znxf','spc','shm') and fromID=@sales
		union all select ID,autoPay,username, name, amount, dateReceive, pay_typeName, courseName, iif(unit>'',unit,hostName+dept1Name) + ':' + pay_memo as pay_memo from v_studentCourseList where dateReceive>=@d1 and dateReceive<=@d2 and pay_type=3 and host in('znxf','spc','shm') and fromID=@sales
		union all select ID,0,username, name, -refund_amount, dateRefund, '�˿�', courseName, refund_memo from v_studentCourseList where dateRefund>=@d1 and dateRefund<=@d2 and host in('znxf','spc','shm') and fromID=@sales and refund_amount>0
	if @kind=2
		select ID,autoPay,username as '���֤', name as '����', amount as '���', datePay as '����', pay_typeName as '����', courseName, iif(unit>'',unit,hostName+dept1Name) + ':' + pay_memo as pay_memo from v_studentCourseList where checkDate=@startDate and host in('znxf','spc','shm') and fromID=@sales
	if @kind=3
		select ID,autoPay,username as '���֤', name as '����', amount as '���', datePay as '����', pay_typeName as '����', courseName, iif(unit>'',unit,hostName+dept1Name) + ':' + pay_memo as pay_memo from v_studentCourseList where checkDate>=@d1 and checkDate<=@d2 and host in('znxf','spc','shm') and fromID=@sales
END
GO

--CREATE Date:2023-07-30  last edit:2025-08-08
--���ݸ������ڷ�Χ��ͳ���շ������������������λ
--mark: D �ձ�  M �±�
ALTER PROCEDURE [dbo].[getIncomeRpt]
	@startDate varchar(50), @endDate varchar(50), @courseID varchar(50), @sales varchar(50), @mark varchar(50), @host varchar(50)
AS
BEGIN
	declare @sql nvarchar(4000), @where varchar(500), @where1 varchar(500)
	create table #tbl (datePay varchar(50), p1 int, p2 int, p3 int, p5 int, p6 int, p7 int, p int)
	-- p7�˿� p����С��
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
	insert into #tbl select '�ϼ�',sum(p1),sum(p2),sum(p3),sum(p5),sum(p6),sum(p7),sum(p) from #tbl
	select datePay as ����, p1 as ֧����, p2 as ΢��, p3 as ת��, p5 as ����δ����, p6 as ����, p as �տ�С��, p7 as �˿�, p-p7 as �ϼ� from #tbl where datePay>'' order by datePay	-- pp �ϼ�
END
GO


--CREATE Date:2023-07-30  last edit:2025-08-08
--���ݸ�������(��/��)��ͳ���շ������ϸ
--mark: D �ձ�  M �±�
--key: 1-7: ֧�����տ�, ΢���տ�, ����ת��, δ����, ����, �տ�С��, �˿�
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
		if @key<>6	--��֧����ʽ
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

		select @sql='select username, name, -refund_amount, dateRefund, ''�˿�'', shortName as courseName, iif(unit>'''',unit,hostName+dept1Name) + '':'' + refund_memo as refund_memo from v_studentCourseList where ' + @where + ' and refund_amount>0'
	end

	EXECUTE (@sql)
END
GO


-- =============================================
-- CREATE Date: 2022-11-24
-- Description:	����ȷ��Ӧ�տ��ѵ��ˡ�
-- @selList: �������ö��ŷָ���enterID
-- Use Case:	exec [checkReceiveList] 2,'...'
-- =============================================
ALTER PROCEDURE [dbo].[checkReceiveList] 
	@selList varchar(4000), @theDate varchar(50), @registerID varchar(50)
AS
BEGIN
	--���������뵽��ʱ��
	create table #temp_receive_check(id varchar(50),invoice varchar(50))
	declare @n int, @j int
	select @n=dbo.pf_getStrArrayLength(@selList,','), @j=0
	while @n>@j
	begin
		insert into #temp_receive_check(id) values(dbo.pf_getStrArrayOfIndex(@selList,',',@j))
		select @j = @j + 1
	end

	update studentCourseList set noReceive=2, receiverID=@registerID,dateReceive=@theDate from studentCourseList a, #temp_receive_check b where a.ID=b.id and a.noReceive=1

	--������巢Ʊ���ѧԱ�Ѹ���
	update #temp_receive_check set invoice=b.invoice from #temp_receive_check a, studentCourseList b where a.id=b.id
	update studentCourseList set pay_status=1 from studentCourseList a, #temp_receive_check b where a.invoice=b.invoice and a.id<>b.id and a.invoice>''

	declare @event varchar(50), @logMemo nvarchar(500)
	select @event='ȷ��Ӧ�տ��', @logMemo = @theDate + ':' + @selList
	-- д������־
	exec writeOpLog '', @event,'checkReceiveList',@registerID,@logMemo,@logMemo
END

GO

-- =============================================
-- CREATE Date: 2022-11-24
-- Description:	����ǰ������Ϣ�еķ�Ʊ�Ƶ�invoiceInfo��, ���ԭ��Ʊ��Ϣ������Ϊ�迪Ʊ��ʶ��
-- mark: 0 ���  1 �ؿ�
-- Use Case:	exec [removeInvoice] 2,'...'
-- =============================================
ALTER PROCEDURE [dbo].[removeInvoice] 
	@enterID int, @mark int, @registerID varchar(50)
AS
BEGIN
	declare @event varchar(50), @logMemo nvarchar(500)
	select @event='�Ƴ���Ʊ׼��' + iif(@mark=0,'���','�ؿ�'), @logMemo = invoice from studentCourseList where ID=@enterID
	insert into invoiceInfo(enterID, invCode, invDate, payType, payStatus, amount, item, autoPay, autoInvoice, cancel, cancelDate, memo) select @enterID, invoice,dateInvoice,pay_type,pay_status,invoice_amount,title, autoPay, autoInvoice, iif(@mark=0,1,0), iif(@mark=0,getDate(),null),file5 from studentCourseList where ID=@enterID
	update studentCourseList set title=isnull(title,'') + iif(@mark=0,' ���-ԭ��Ʊ�ţ�' + isnull(invoice,''),''), invoice_amount=iif(@mark=0,-invoice_amount,invoice_amount), invoice=null, file5=null, dateInvoice=null, dateInvoicePick=null, needInvoice=1, autoInvoice=0 where ID=@enterID
	-- д������־
	exec writeOpLog '', @event,'removeInvoice',@registerID,@logMemo,@enterID
END

GO

--CREATE Date:2020-05-11
--���ݸ�����ѧԱenterID�����������з�Ʊ�ļ����ϲ��������|Ϊ�������
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
--���ݸ������ڣ��г��շ�-��Ʊ��ϸ
--@startDate �շ�����  @startDate1 ��Ʊ����  @receivalbe: Ӧ�տ�
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
		select @sql=@sql+'union all select ID,0,0,'''',username, name, -refund_amount, dateRefund, ''�˿�'', shortName,noReceive,invoice,dateInvoice, title, refund_memo,[dbo].[getCourseInvoice](ID) as invoicePDF from v_studentCourseList where dateRefund>=''' + @startDate + ''' and dateRefund<=''' + @endDate + ''' and refund_amount>0'
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
	declare @tb table(ID int,autoPay int,autoInvoice int,[�ͻ�������] varchar(50),username varchar(50), name nvarchar(50), [���] int, datePay varchar(50), pay_typeName nvarchar(50), shortName nvarchar(50),noReceive int,[��Ʊ����] varchar(50),dateInvoice varchar(50), title nvarchar(200), pay_memo nvarchar(500),invoicePDF varchar(2000))
	insert into @tb
	' + @sql + 
	' update @tb set [�ͻ�������]=b.outOrderNo from @tb a, autoPayInfo b where a.ID=b.enterID and b.kind=0' + 
	' select * from @tb'
	EXECUTE (@sql)
END
GO

-- CREATE DATE: 2024-07-06
-- ����ѧԱ���α����Ŀ������ڣ�����ж�Σ�ѡ���һ��
-- �������ͣ���applyInfo �� passcardInfo����ȡ
-- USE CASE: select [dbo].[getEnterExamDate](1)
CREATE FUNCTION [dbo].[getEnterExamDate]
	(@enterID int)
RETURNS varchar(50)
AS
BEGIN
	declare @re varchar(50),@agencyID int
	select @agencyID=c.agencyID from studentCourseList a, courseInfo b, [dbo].[certificateInfo] c where a.courseID=b.courseID and b.certID=c.certID and a.ID=@enterID
	if @agencyID=4		--��У��֤
		select @re=isnull(convert(varchar(20),max(startDate),23),'') from v_passcardInfo where enterID=@enterID
	else
		select @re=isnull(convert(varchar(20),max(examDate),23),'') from applyInfo where enterID=@enterID

	return isnull(@re,'')
END
GO

-- CREATE DATE: 2023-10-13
-- ����ѧԱ�ķ�Ʊ�б�
-- USE CASE: exec [getStudentInvoiceList] 1
CREATE PROCEDURE [dbo].[getStudentInvoiceList]
	@username varchar(50)
AS
BEGIN
	select file5 as [filename], isnull(convert(varchar(20),dateInvoice,23),'') as dateInvoice,amount from studentCourseList where username=@username and file5>'' order by ID desc
END
GO

-- CREATE DATE: 2023-10-13
-- ΪѧԱ����ģ���Ծ�
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
-- Description:	����������ȡ��������
-- @selList: �������ö��ŷָ���kindID 0 applyID 1 enterID 2 username  @refID:classInfo.ID
-- Use Case:	exec [getStudentListByList] '...'
-- =============================================
ALTER PROCEDURE [dbo].[getStudentListByList] 
	@selList varchar(4000), @kindID int, @refID int
AS
BEGIN
	--���������뵽��ʱ��
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
-- �����ɼ���ѯ�Ǽ�
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
			select @status=iif(@score1='ȱ��' and @score2='ȱ��',3,2)
			if @score1='ȱ��'
				select @score1 = 0, @score2=0
			if @score2='ȱ��'
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
-- ��ѵ���ڲ�ѯ�Ǽ�
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

--�ж�ĳ��ģ�⿼���Ƿ�ﵽ����
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
		select @re='���߿γ����60%���ϣ�����ģ����ϰ��'
	end
	--return isnull(@re,'')
	return ''
END
GO

-- CREATE DATE: 2023-10-13
-- ���/ȡ���ղ�����
-- mark: 0 ��� 1 ȡ��
-- USE CASE: exec [setFavoriteQuestion] 1
CREATE PROCEDURE [dbo].[setFavoriteQuestion]
	@enterID int, @questionID varchar(50), @mark int
AS
BEGIN
	if @mark=0 and not exists(select 1 from [dbo].[studentQuestionMark] where enterID=@enterID and questionID=@questionID)
		insert into [dbo].[studentQuestionMark](enterID, questionID) values(@enterID, @questionID)
	if @mark=1
		delete from [dbo].[studentQuestionMark] where enterID=@enterID and questionID=@questionID
	select 0 as status, iif(@mark=0,'����ӵ��ղؼ�','��ȡ���ղ�') as msg
END
GO

-- CREATE DATE: 2024-9-26
-- ��ӻ�����ѵ֤��
-- USE CASE: exec [updateTrainingProof] 1
CREATE PROCEDURE [dbo].[updateTrainingProof]
	@classID int, @filename varchar(200)
AS
BEGIN
	update generateApplyInfo set filename=@filename where ID=@classID
END
GO

-- CREATE DATE: 2024-09-28
-- ���ر�������������
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
	select a.username,b.name,a.SNo,signatureType,isnull(a.signature,'') as signature,isnull(convert(varchar(20),a.signatureDate,23),'') as signatureDate,@startDate as startDate,c.reexamine,a.express,c.certID,c.courseName1 as courseName,a.price,c.price as priceStandard,@host as host,'�Ϻ���������ѧУ' as hostName,b.sexName,birthday,b.mobile,b.age,b.job,b.educationName,b.address,b.IDaddress,b.ethnicity,b.IDdateStart,b.IDdateEnd,b.IDD_long,b.unit,b.photo_filename,b.IDa_filename,b.IDb_filename,b.edu_filename,@fname as proof_filename 
		from studentCourseList a, v_studentInfo b, v_courseInfo c where a.username=b.username and a.courseID=c.courseID and a.ID=@enterID
END
GO

-- CREATE DATE: 2024-09-28
-- ���ذ༶����ѧϰͳ������
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
	
	--���߿γ������
	if @mark='A'
		insert into #temp(ID,enterID,username,name,mobile,completion,completion_hours) select max(a.ID),b.ID,d.username,d.name,max(d.mobile),avg(c.completion),sum(c.completion*c.hours)/100.00 from applyInfo a, studentCourseList b, studentLessonList c, studentInfo d where a.enterID=b.ID and b.ID=c.refID and b.username=d.username and a.refID=@classID group by b.ID,d.username,d.name
	else
		insert into #temp(ID,enterID,username,name,mobile,completion,completion_hours) select cast(right(max(b.SNo),3) as int),b.ID,d.username,d.name,max(d.mobile),avg(c.completion),sum(c.completion*c.hours)/100.00 from studentCourseList b, studentLessonList c, studentInfo d where b.ID=c.refID and b.username=d.username and b.classID=@classID group by b.ID,d.username,d.name
	
	update #temp set examTimes=b.examTimes,goodTimes=b.goodTimes,examTimes1=b.examTimes1,goodTimes1=b.goodTimes1,bestScore=b.bestScore from #temp a, (select c.enterID,sum(iif(e.kindID=0,1,0)) as examTimes,sum(iif(d.score>=d.scorePass and e.kindID=0,1,0)) as goodTimes,sum(iif(e.kindID=1,1,0)) as examTimes1,sum(iif(d.score>=d.scorePass and e.kindID=1,1,0)) as goodTimes1, max(d.score) as bestScore from #temp c, ref_studentExamList d, examInfo e where c.enterID=d.refID and d.examID=e.examID group by c.enterID) b where a.enterID=b.enterID
	
	--������ϰ����
	update #temp set todayExamTimes=b.examTimes,todayGoodTimes=b.goodTimes,todayBestScore=b.bestScore from #temp a, (select c.enterID,count(*) as examTimes,sum(iif(d.score>=d.scorePass,1,0)) as goodTimes, max(d.score) as bestScore from #temp c, ref_studentExamList d, examInfo e where c.enterID=d.refID and d.examID=e.examID and d.backDate between @theDate and @theDate + ' 23:59:59' group by c.enterID) b where a.enterID=b.enterID
	
	--���5��Ӧ֪��ϰ
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
	--���5��Ӧ����ϰ
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

	--predictedGrade: Ԥ�������������5��Ӧ֪����ƽ����Ϊ�������ʵ����һ��ϵ����
	update #temp set predictedGrade=avgLast+(100-avgLast)/2.3,goodRate=goodTimes*100.00/iif(examTimes=0,1,examTimes), goodRate1=goodTimes1*100.00/iif(examTimes1=0,1,examTimes1), goodRateLast=goodTimesLast*100.00/iif(examTimesLast=0,1,examTimesLast), goodRate1Last=goodTimes1Last*100.00/iif(examTimes1Last=0,1,examTimes1Last), completion=iif(completion>99,100,completion) where examTimes>0
	update #temp set result=c.result,score=c.score,score2=c.score2 from #temp a, studentCourseList b, studentCertList c where a.enterID=b.ID and b.refID=c.ID
	-- ���¿���
	update #temp set pOffline=b.p from #temp a, (select enterID,count(*) as p from classSchedule c, checkinInfo d where c.ID=d.refID and c.mark='A' and c.classID=@classID group by d.enterID) b where a.enterID=b.enterID
	update #temp set pOffline=isnull(pOffline,0)+[dbo].[getEnterCheckinOutClassQty](enterID,@classID)

	select * from #temp order by ID
END
GO

--ȥ����Ʊ̧ͷ�е�˰��
ALTER FUNCTION getInvoiceTitle(@x nvarchar(200))
RETURNS nvarchar(200)
AS
BEGIN
	return replace(replace(replace(iif(PATINDEX('%[0-9]%',@x)=1,right(@x,len(@x)-PATINDEX('%[^ 0-9A-Za-z]%',@x)+1),left(@x,PATINDEX('%[0-9]%',@x+'1')-1)),'˰��',''),'��',''),'��',''); 
END
GO

--CREATE Date:2023-07-30
--���ݸ������ڣ��г��շѡ��˷ѡ���Ʊ��ϸ
--����и��������������
--mark: data/file
ALTER PROCEDURE [dbo].[getDailyRptTotal]
	@startDate varchar(50), @host varchar(50), @mark varchar(50)
AS
BEGIN
	declare @tb table(enterID int,kindID float,mark nvarchar(50) default(''),autoPay int,autoInvoice int,username varchar(50) default(''), name nvarchar(50) default(''), price int, amount int, datePay varchar(50) default(''), pay_type int, pay_typeName nvarchar(50) default(''), shortName nvarchar(50) default(''),noReceive int,invoice varchar(50) default(''),dateInvoice varchar(50) default(''), title nvarchar(200) default(''), autoPayName nvarchar(50), autoInvoiceName nvarchar(50), pay_memo nvarchar(500) default(''),invoicePDF varchar(2000) default(''))
	declare @tamount int
	--�����շѼ�¼
	insert into @tb select ID,0,iif(invoice>'' and datePay=dateInvoice,'�ѿ�Ʊ',''),autoPay,autoInvoice,username, name, price, amount, datePay, pay_type, pay_typeName, shortName,noReceive,iif(invoice>'',invoice,iif(receipt>'','�վݺţ�'+receipt,'')),dateInvoice, dbo.getInvoiceTitle(title), '', '',pay_memo,[dbo].[getCourseInvoice](ID) as invoicePDF from v_studentCourseList where datePay=@startDate and amount>0 and pay_status>0 -- and host in('znxf','spc','shm')
	--����е��쿪Ʊ���Ƴ��������ŷ�Ʊ��Ϣ���������������巢Ʊ��
	--update @tb set invoice=b.invCode, dateInvoice=b.invDate from @tb a, v_invoiceInfo b where a.enterID=b.enterID and b.invDate=@startDate  -- and a.invoice='' 
	insert into @tb select ID,0,'',b.autoPay,b.autoInvoice,a.username,a.name,price, b.amount, datePay, pay_type, pay_typeName,shortName,noReceive,b.invCode,b.invDate,b.item, '', '',pay_memo,invoicePDF from @tb a, v_invoiceInfo b where a.enterID=b.enterID and b.invDate=@startDate and b.amount>0
	--��Ʊ����������ڵ��죬��Ʊ��Ϣ���
	--update @tb set invoice='', dateInvoice='' where dateInvoice>@startDate
	--�����˿��¼
	insert into @tb select ID,2,'�˿�',0,0,username, name, -refund_amount, -refund_amount, dateRefund, 0, '�˿�', shortName,noReceive,iif(invoice>'',invoice,iif(receipt>'','�վݺţ�'+receipt,'')),dateInvoice, dbo.getInvoiceTitle(title), '', '', refund_memo,[dbo].[getCourseInvoice](ID) as invoicePDF from v_studentCourseList where dateRefund=@startDate and refund_amount>0 -- and host in('znxf','spc','shm')
	--���츶��������¼(���)
	insert into @tb select ID,3.1,'���',autoPay,autoInvoice,username, name, price, invoice_amount, datePay, pay_type, '���', shortName,noReceive,invoice,dateInvoice, dbo.getInvoiceTitle(title), '', '','',[dbo].[getCourseInvoice](ID) as invoicePDF from v_studentCourseList where dateInvoice=@startDate and datePay=@startDate and invoice>'' and invoice_amount<0
	--��ǰ������쿪Ʊ��¼(Ԥ�տ�Ʊ)
	insert into @tb select ID,3,'Ԥ�տ�Ʊ',autoPay,autoInvoice,username, name, price, invoice_amount, datePay, pay_type, iif(invoice_amount<0,'���',pay_typeName), shortName,noReceive,invoice,dateInvoice, dbo.getInvoiceTitle(title), '', '','',[dbo].[getCourseInvoice](ID) as invoicePDF from v_studentCourseList where dateInvoice=@startDate and datePay<@startDate and invoice>'' and invoice_amount>0 -- and amount>0 and host in('znxf','spc','shm')
	--�����֮ǰ��Ʊ���Ƴ�����ô���ŷ�ƱӦ�����ؿ���
	update @tb set mark='�ؿ���Ʊ',kindID=3.1 from @tb a, v_invoiceInfo b where a.enterID=b.enterID and b.invDate<=@startDate and a.kindID=3
	--���쿪Ʊת����ʷ��ļ�¼���������ѻ���ķ�Ʊ
	insert into @tb select a.ID,4,'��ʷ��Ʊ',b.autoPay,b.autoInvoice,username, name, b.amount, b.amount, a.datePay, b.payType, iif(b.amount<0,'���',pay_typeName), shortName,0,b.invCode,b.invDate, dbo.getInvoiceTitle(b.item), '', '','',b.memo as invoicePDF from v_studentCourseList a, v_invoiceInfo b where a.ID=b.enterID and b.invDate=@startDate and b.invCode not in(select invoice from @tb)
	--�����Զ��շѡ��Զ���Ʊ
	update @tb set autoPayName=iif(autoPay=1,'����','����'), autoInvoiceName=iif(autoInvoice=1,'����',iif(invoice>'','����','')) where kindID in(0,3)
	--����δ��Ʊ��ʶ
	update @tb set mark='δ��Ʊ', kindID=1, dateInvoice='' where kindID=0 and (dateInvoice='' or dateInvoice>@startDate)
	--�������
	insert into @tb(enterID,kindID,invoice) select 0,1.1,''
	--�������
	insert into @tb(enterID,kindID,invoice) select 0,1.2,'����δ��Ʊ'
	--��������δ��Ʊ��ʶ
	update @tb set kindID=1.3 where kindID=1 and dateInvoice='' and autoPay=1
	--�������
	insert into @tb(enterID,kindID,invoice) select 0,1.6,'����δ��Ʊ'
	--��������δ��Ʊ��ʶ
	update @tb set kindID=1.7 where kindID=1 and dateInvoice='' and autoPay=0
	--�������
	insert into @tb(enterID,kindID,invoice) select 0,3.2,''
	--�������
	insert into @tb(enterID,kindID,invoice) select 0,3.3,'����Ԥ�տ�Ʊ'
	--��������Ԥ�տ�Ʊ��ʶ
	update @tb set kindID=3.5 where kindID=3 and autoInvoice=1
	--�������
	insert into @tb(enterID,kindID,invoice) select 0,3.8,'����Ԥ�տ�Ʊ'
	--��������Ԥ�տ�Ʊ��ʶ
	update @tb set kindID=3.9 where kindID=3 and autoInvoice=0 and noReceive=0 and amount>0
	--�������
	insert into @tb(enterID,kindID) select 0,5
	--����ϼ�
	insert into @tb(enterID,kindID,pay_type,amount,mark) select 0,6,0,sum(amount),'�ϼ�' from @tb
	--�����շ�С��
	insert into @tb(enterID,kindID,pay_type,amount,mark) select 0,6,1,sum(amount),'�տ�С��' from @tb where kindID<3
	--�����������С��
	insert into @tb(enterID,kindID,pay_type,amount,mark) select 0,7,pay_type,sum(amount),pay_typeName from @tb where kindID<2 group by pay_type,pay_typeName order by pay_type
	--�����˿�С��
	insert into @tb(enterID,kindID,pay_type,amount,mark) select 0,7,6,sum(amount),'�˿�' from @tb where kindID=2
	--����δ��ƱС��
	insert into @tb(enterID,kindID,pay_type,amount,mark) select 0,7,7,sum(amount),'δ��Ʊ' from @tb where kindID=1
	--����Ԥ�տ�ƱС��
	insert into @tb(enterID,kindID,pay_type,amount,mark) select 0,7,8,sum(amount),'Ԥ�տ�Ʊ' from @tb where kindID=3
	--�������
	insert into @tb(enterID,kindID) select 0,8
	--����ҳ��
	insert into @tb(enterID,kindID,invoice,shortName) select 1,8,'�����ˣ�','�Ƶ��ˣ�'
	--��������δ��ƱС��
	select @tamount=sum(amount) from @tb where kindID=1.3
	insert into @tb(enterID,kindID,pay_typeName,amount,invoice) select 0,1.4,'΢��',isnull(@tamount,0),'����δ��ƱС��'
	--�������
	insert into @tb(enterID,kindID) select 0,1.5
	--��������δ��ƱС��
	select @tamount=sum(amount) from @tb where kindID=1.7
	insert into @tb(enterID,kindID,pay_typeName,amount,invoice) select 0,1.8,'',isnull(@tamount,0),'����δ��ƱС��'
	--�������
	insert into @tb(enterID,kindID) select 0,1.9
	--��������δ��ƱС��
	select @tamount=0
	select @tamount=sum(amount) from @tb where kindID=3.5
	insert into @tb(enterID,kindID,amount,invoice) select 0,3.6,isnull(@tamount,0),'����Ԥ�տ�ƱС��'
	--�������
	insert into @tb(enterID,kindID) select 0,3.7
	--��������δ��ƱС��
	select @tamount=0
	select @tamount=sum(amount) from @tb where kindID=3.9
	insert into @tb(enterID,kindID,amount,invoice) select 0,3.91,isnull(@tamount,0),'����Ԥ�տ�ƱС��'
	--�������
	insert into @tb(enterID,kindID) select 0,3.92
	
	if @mark='data'
		select iif(kindID<5,cast(ROW_NUMBER() OVER (ORDER BY kindID,enterID) as varchar),'') as 'No',* from @tb order by kindID,enterID,pay_type
	if @mark='file'
		select iif(kindID<5,cast(ROW_NUMBER() OVER (ORDER BY kindID,enterID) as varchar),'') as 'No',enterID as '������',dateInvoice as '��Ʊ����',datePay as '��������',name as '����',mark as '��ʶ',invoice as '����Ʊ��',title as '��Ʊ̧ͷ',shortName as '��Ŀ',pay_typeName as '���ʽ',price as '����',iif(kindID<4,1,null) as '����',amount as '���',autoPayName as '��������',autoInvoiceName as '��Ʊ����',pay_memo as '��ע' from @tb order by kindID,enterID,pay_type
END
GO


--CREATE Date:2023-07-30
--���ݸ������ڣ��г�����δ��Ʊ/����Ԥ�տ�Ʊ��ϸ
--mark: 0 ����δ��Ʊ  1 ����Ԥ�տ�Ʊ  3 ����δ��Ʊ  4 ����Ԥ�տ�Ʊ
--����и��������������
ALTER PROCEDURE [dbo].[getDailyRptTotalTrail]
	@startDate varchar(50), @host varchar(50), @mark int
AS
BEGIN
	declare @tb table(enterID int,kindID float,mark nvarchar(50) default(''),username varchar(50) default(''), pname nvarchar(50) default(''), price int, amount int, people int, datePay varchar(50) default(''), pay_type int, pay_typeName nvarchar(50) default(''), shortName nvarchar(50) default(''),noReceive int,invoice varchar(50) default(''),dateInvoice varchar(50) default(''), outOrderNo varchar(2000) default(''))
	--�����շ�����δ��Ʊ��¼
	if @mark=0
	begin
		insert into @tb select a.ID,0,'',username, name, price, a.amount, 1, datePay, a.pay_type, pay_typeName, shortName,noReceive,iif(invoice>'',invoice,iif(receipt>'','�վݺţ�'+receipt,'')),dateInvoice, b.outOrderNo from v_studentCourseList a, autoPayInfo b where a.ID=b.enterID and b.kind=0 and a.datePay=@startDate and a.amount>0 and pay_status>0 and (invoice='' or dateInvoice>@startDate) and autoPay=1 -- and host in('znxf','spc','shm')
		--����е��쿪Ʊ���Ƴ�����������¼�Ƴ�
		delete from @tb where enterID in(select a.enterID from @tb a, v_invoiceInfo b where a.enterID=b.enterID and b.invDate=@startDate)
	end
	--��ǰ������쿪Ʊ��¼(Ԥ�տ�Ʊ)
	if @mark=1	
	begin
		insert into @tb select a.ID,0,'',username, name, price, a.invoice_amount, 1, datePay, a.pay_type, iif(a.amount<0,'���',pay_typeName), shortName,noReceive,invoice,dateInvoice, b.outOrderNo from v_studentCourseList a, autoPayInfo b where a.ID=b.enterID and b.kind=0 and dateInvoice=@startDate and datePay<@startDate and invoice>'' and a.amount>0 -- and a.autoInvoice=1 and host in('znxf','spc','shm')
		--�����֮ǰ��Ʊ���Ƴ�����ô���ŷ�ƱӦ�����ؿ��ģ��Ƴ���
		delete from @tb where enterID in(select a.enterID from @tb a, v_invoiceInfo b where a.enterID=b.enterID and b.invDate<=@startDate)
	end
	--�����շ�����δ��Ʊ��¼
	if @mark=3
	begin
		insert into @tb select a.ID,0,'',username, name, price, a.amount, 1, datePay, a.pay_type, pay_typeName, shortName,noReceive,iif(invoice>'',invoice,iif(receipt>'','�վݺţ�'+receipt,'')),dateInvoice, a.ID from v_studentCourseList a where a.datePay=@startDate and a.amount>0 and pay_status>0 and (invoice='' or dateInvoice>@startDate) and autoPay=0 -- and host in('znxf','spc','shm')
		--����е��쿪Ʊ���Ƴ�����������¼�Ƴ�
		delete from @tb where enterID in(select a.enterID from @tb a, v_invoiceInfo b where a.enterID=b.enterID and b.invDate=@startDate)
	end
	--��ǰ������쿪Ʊ��¼(Ԥ�տ�Ʊ)
	if @mark=4	
	begin
		insert into @tb select a.ID,0,'',username, name, price, a.invoice_amount, 1, datePay, a.pay_type, iif(a.amount<0,'���',pay_typeName), shortName,noReceive,invoice,dateInvoice, a.ID from v_studentCourseList a where dateInvoice=@startDate and datePay<@startDate and invoice>'' and a.amount>0 and autoPay=0 and noReceive=0 and a.autoInvoice=0 -- and host in('znxf','spc','shm')
		--�����֮ǰ��Ʊ���Ƴ�����ô���ŷ�ƱӦ�����ؿ��ģ��Ƴ���
		delete from @tb where enterID in(select a.enterID from @tb a, v_invoiceInfo b where a.enterID=b.enterID and b.invDate<=@startDate)
	end

	--����С��
	insert into @tb(enterID,kindID,amount,people) select 0,1,isnull(sum(amount),0),count(*) from @tb
	
	select * from @tb order by kindID,enterID
END
GO

--CREATE Date:2025-03-30
--���ݸ������ڣ��г��¿����б����ڰ��տ������ڼ��㡣
--����и�����������
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
	
	insert into @tb(kindID, className, dateStart, qty) select 100,'�ϼ�',count(*),sum(qty) from @tb
	if @mark='data'
		select iif(classID>'',cast(ROW_NUMBER() OVER (ORDER BY kindID,courseID,classID) as varchar),'') as 'No',* from @tb order by kindID,courseID,classID
	if @mark='file'
		select iif(classID>'',cast(ROW_NUMBER() OVER (ORDER BY kindID,courseID,classID) as varchar),'') as 'No',classID as '�༶���',className as '�༶����',courseName as '�γ�����',dateStart as '��������',classroom as '����',qty as '����',teacherName as '��ʦ',adviserName as '������',memo as '��ע' from @tb order by kindID,courseID,classID
END
GO

--CREATE Date:2025-03-31
--���ݸ������ڣ��г���ʦ/�����ι������б����ڰ��հ༶�������ڼ��㡣
--����и�����������
--opt: 0 ��ʦ  1 ������
--mark: data/file
ALTER PROCEDURE [dbo].[getRptWorkload]
	@startDate varchar(50), @endDate varchar(50), @opt int, @mark varchar(50)
AS
BEGIN
	select @endDate = dbo.whenull(@endDate,convert(varchar(20),getDate(),23))
	declare @tb table(classID varchar(50) default(''),kindID int,seq float,className nvarchar(100) default(''), courseID varchar(50) default(''), courseName nvarchar(100) default(''), dateEnd varchar(50) default(''), classRoom nvarchar(50) default(''), qty int default(0), workDays decimal(18,1) default(0), workload int default(0), teacherName nvarchar(50) default(''), teacher varchar(50) default(''), memo nvarchar(500) default(''))
	if @opt=0	--��ʦ
	insert into @tb 
		select a.ID,0,0,className, courseID, courseName, b.lastDate, classroom, a.qty, b.workDays, a.qty*b.workDays, b.teacherName, b.teacher, memo from v_classInfo a, v_classTeacherWorkload b where a.ID=b.classID and b.mark='B' and b.lastDate between @startDate and @endDate and pre=0 and agencyID>1 and a.qty>0
		union
		select a.ID,1,0,title, courseID, courseName, b.lastDate, classroom, a.qty, b.workDays, a.qty*b.workDays, b.teacherName, b.teacher, memo from v_generateApplyInfo a, v_classTeacherWorkload b where a.ID=b.classID and b.mark='A' and b.lastDate between @startDate and @endDate and a.qty>0
	
	if @opt=1	--������
	insert into @tb 
		select ID,0,0,className, courseID, courseName, dbo.getClassLastDate(ID,'B'), classroom, qty, dbo.getClassRealDays(ID,'B'), qty*dbo.getClassRealDays(ID,'B'), adviserName, adviserID, memo from v_classInfo where dbo.getClassLastDate(ID,'B') between @startDate and @endDate and pre=0 and agencyID>1 and qty>0
		union
		select ID,1,0,title, courseID, courseName, dbo.getClassLastDate(ID,'A'), classroom, qty, dbo.getClassRealDays(ID,'A'), qty*dbo.getClassRealDays(ID,'A'), adviserName, adviserID, memo from v_generateApplyInfo where dbo.getClassLastDate(ID,'A') between @startDate and @endDate and qty>0

	--������������
	declare @tbg table(ID varchar(50), seq int)
	insert into @tbg select teacher, ROW_NUMBER() OVER (ORDER BY teacher) from @tb group by teacher
	update @tb set seq=b.seq from @tb a, @tbg b where a.teacher=b.ID
	
	--�����ϼ�
	insert into @tb(kindID, seq, teacherName, dateEnd, qty, workDays, workload) select 100,100,'�ϼ�',isnull(count(*),0),isnull(sum(qty),0), isnull(sum(workDays),0),isnull(sum(workload),0) from @tb

	--�����������
	insert into @tb(kindID, seq, teacherName, dateEnd, qty, workDays, workload) select 1,max(b.seq)+0.5,'С��',isnull(count(*),0),isnull(sum(qty),0), isnull(sum(workDays),0),isnull(sum(workload),0) from @tb a, @tbg b where a.teacher=b.ID and a.kindID<100 group by a.teacher

	if @mark='data'
		select iif(classID>'',cast(ROW_NUMBER() OVER (ORDER BY kindID,courseID,classID) as varchar),'') as 'No',* from @tb order by seq,courseID,classID
	if @mark='file'
		select iif(classID>'',cast(ROW_NUMBER() OVER (ORDER BY kindID,courseID,classID) as varchar),'') as 'No',teacherName as '��Ŀ',classID as '�༶���',className as '�༶����',courseName as '�γ�����',dateEnd as '�������',classroom as '����',qty as '����', workDays as '����', workload as '������',memo as '��ע' from @tb order by seq,courseID,classID
END
GO

--CREATE Date:2025-03-31
--���ݸ������ڣ��г���ʦ/�����κϸ����б����ڰ��ճɼ��������ڼ��㡣
--ֻ���㰲����Ŀ
--����и�����������
--opt: 0 ��ʦ  1 ������  2 ѧ����Դ  3 �γ�
--mark: data/file
ALTER PROCEDURE [dbo].[getRptPassRate]
	@startDate varchar(50), @endDate varchar(50), @opt int, @mark varchar(50)
AS
BEGIN
	select @endDate = dbo.whenull(@endDate,convert(varchar(20),getDate(),23))
	declare @tb table(classID varchar(50) default(''),kindID int,seq float,className nvarchar(100) default(''), courseID varchar(50) default(''), courseName nvarchar(100) default(''), dateEnd varchar(50) default(''), qty int default(0), qtyExam int default(0), qtyPass int default(0), passRate decimal(18,2) default(0), teacherName nvarchar(50) default(''), teacher varchar(50) default(''), memo nvarchar(500) default(''))
	if @opt=0	--��ʦ
	insert into @tb 
		select a.ID,1,0,title, courseID, courseName, a.importScoreDate, a.qty, qtyYes+qtyNo, qtyYes, 0, b.teacherName, b.teacher, memo from v_generateApplyInfo a, v_classTeacherWorkload b where a.ID=b.classID and b.mark='A' and a.importScoreDate between @startDate and @endDate and a.qty>0 and a.host='znxf'
	
	if @opt=1	--������
	insert into @tb 
		select ID,1,0,title, courseID, courseName, importScoreDate, qty, qtyYes+qtyNo, qtyYes, 0, adviserName, adviserID, memo from v_generateApplyInfo where importScoreDate between @startDate and @endDate and qty>0 and host='znxf'
	
	if @opt=2	--ѧ����Դ
	insert into @tb 
		select a.courseID,1,0,a.courseName, a.courseID, a.courseName, '', count(*), sum(iif(b.status=1 or b.status=2,1,0)), sum(iif(b.status=1,1,0)), 0, b.source, b.source, '' from v_generateApplyInfo a, v_applyInfo b where a.ID=b.refID and a.importScoreDate between @startDate and @endDate and a.qty>0 and a.host='znxf' group by b.source, a.courseID, a.courseName
	
	if @opt=3	--�γ�
	insert into @tb 
		select ID,1,0,title, courseID, courseName,importScoreDate, (qty), (qtyYes+qtyNo), (qtyYes), 0, courseName+' '+reexamineName, courseID, memo from v_generateApplyInfo where importScoreDate between @startDate and @endDate and qty>0 and host='znxf'

	--������������
	declare @tbg table(ID varchar(50), seq int)
	insert into @tbg select teacher, ROW_NUMBER() OVER (ORDER BY teacher) from @tb group by teacher
	update @tb set seq=b.seq from @tb a, @tbg b where a.teacher=b.ID
	
	--�����ϼ�
	insert into @tb(kindID, seq, teacherName, dateEnd, qty, qtyExam, qtyPass) select 100,100,'�ϼ�',isnull(count(*),0),isnull(sum(qty),0), isnull(sum(qtyExam),0),isnull(sum(qtyPass),0) from @tb

	--�����������
	insert into @tb(kindID, seq, teacherName, dateEnd, qty, qtyExam, qtyPass) select 1,max(b.seq)+0.5,'С��',isnull(count(*),0),isnull(sum(qty),0), isnull(sum(qtyExam),0),isnull(sum(qtyPass),0) from @tb a, @tbg b where a.teacher=b.ID and a.kindID<100 group by a.teacher

	--����ͨ����
	update @tb set passRate=qtyPass*100.00/iif(qtyExam>0,qtyExam,1)

	if @mark='data'
		select iif(classID>'',cast(ROW_NUMBER() OVER (ORDER BY kindID,courseID,classID) as varchar),'') as 'No',* from @tb order by seq,courseID,classID
	if @mark='file'
		select iif(classID>'',cast(ROW_NUMBER() OVER (ORDER BY kindID,courseID,classID) as varchar),'') as 'No',teacherName as '��Ŀ',classID as '�༶���',className as '�༶����',courseName as '�γ�����',dateEnd as '��������',qty as '������', qtyExam as '��������', qtyPass as 'ͨ������', passRate as 'ͨ����%',memo as '��ע' from @tb order by seq,courseID,classID
END
GO

-- CREATE DATE: 2024-10-15
-- ��ѯ�༶�α�
-- USE CASE: exec [getClassScheduleList] '123'
ALTER PROCEDURE [dbo].[getClassScheduleList]
	@classID int
AS
BEGIN
	select a.ID, a.theDate, a.typeName, item, iif(a.hours>4,4,iif(a.hours<1,1,a.hours)) as hours, isnull(a.teacherName,'δ֪') as teacherName, a.teacherSID, a.kindOnline, a.address,a.online, a.typeID 
	from v_classSchedule a, generateApplyInfo b where a.classID=b.ID and a.mark='A' and a.status=0 and b.ID=@classID and a.std=1 order by a.seq
END
GO

-- CREATE DATE: 2024-10-15
-- ��ǿα��ϴ���¼
-- USE CASE: exec [setUploadSchedule] '123'
ALTER PROCEDURE [dbo].[setUploadSchedule]
	@classID varchar(50), @planID varchar(50), @registerID varchar(50)
AS
BEGIN
	update generateApplyInfo set planID=@planID,uploadScheduleDate=getDate(),uploadScheduler=@registerID where ID=@classID
END
GO

--��ĳ�������Ƶ���һ���γ̵İ༶��
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
			--��ȡ�°༶�Ŀα�
			select @i=@i+1
			select @schID=ID from (select ROW_NUMBER() OVER (ORDER BY ID) AS RowNumber, ID from classSchedule where classID=@classID and mark='A' and online=0 and typeID=0) a where a.RowNumber=@i
			--�滻����
			update checkinInfo set enterID=@enterID1,refID=@schID where ID=@ID
			--�滻ˢ��
			update faceDetectInfo set refID=@enterID1,keyID=@schID where refID=@enterID and keyID=@refID
			fetch next from rc into @ID,@refID
		End
		Close rc 
		Deallocate rc
	end
END
GO

--����ĳ���걨�༶���������翪������
CREATE FUNCTION getApplyClassFirstDate(@classID int)
RETURNS varchar(50)
AS
BEGIN
	declare @re varchar(50)
	select @re=convert(varchar(20),min(theDate),23) from classSchedule where classID=@classID and mark='A' and online=0
	return isnull(@re,'')
END
GO

--����ĳ���༶����������Ͽ�����
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

--����ĳ���༶������ʵ���Ͽ�����
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
-- Description:	����������ȡ��������
-- @selList: �������ö��ŷָ���kind A applyID  B username
-- Use Case:	exec [setInvoiceGroup] '...'
-- =============================================
ALTER PROCEDURE [dbo].[setInvoiceGroup] 
	@selList varchar(4000), @kind varchar(50), @classID varchar(50), @invoice varchar(50), @registerID varchar(50)
AS
BEGIN
	--���������뵽��ʱ��
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

	-- д������־
	select @event='����/ȡ����ǩ'
	exec writeOpLog '', @event,'setInvoiceGroup',@registerID,@selList,@invoice
	select 0 as status, '�����ɹ�' as msg, @qty as qty
END
GO

-- CREATE DATE: 2020-05-08
-- ��ȡ�༶��Ϣ�������ã�
-- USE CASE: select * from dbo.[getNodeInfoArchive]('123','A')
-- kindID: A �걨��  B ��ѵ��
ALTER FUNCTION [dbo].[getNodeInfoArchive]
(	
	@classID int, @kindID varchar(50)
)
RETURNS @tab TABLE (classID int, className nvarchar(500),applyID varchar(100),certName nvarchar(100),reexamineName nvarchar(50),startDate varchar(50), endDate varchar(50),qty int,qtyReturn int,qtyExam int,qtyPass int,summary nvarchar(2000),adviser nvarchar(50),attendanceRate decimal(18,2))
AS
BEGIN
	declare @startDate varchar(50),@endDate varchar(50),@qtyPass int,@qtyExam int,@adviserName nvarchar(50)

	if @kindID='B'	--��ѵ��
	begin
		INSERT INTO @tab
		select ID,className,transaction_id,certName,reexamineName,dateStart,dateEnd,qty,qtyReturn,qtyExam,qtyPass,summary,adviserName,0 from v_classInfo where ID=@classID
	end
	if @kindID='A'		--�걨��
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
-- ��ȡ�༶ѧԱ�б���Ϣ�������ã�
-- USE CASE: select * from dbo.[getStudentListByClassIDArchive]('123','A')
-- kindID: A �걨��  B ��ѵ��
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

	if @kindID='B'	--��ѵ��
	begin
		select @refID=classID from classInfo where ID=@classID
		INSERT INTO @tab
		select username , name ,sexName , age, SNo ,mobile ,unit ,score ,
			diploma_startDate ,diplomaID ,score1 ,score2 ,statusName ,educationName ,hours ,
			cast(isnull(completion,0) as decimal(18,2)) as completion1 ,cast(isnull(completion*hours/100,0) as decimal(18,2)) as hoursSpend1 ,startDate,ID
		 from v_studentCourseList where classID=@refID
 	end
	if @kindID='A'		--�걨��
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
--����ĳ���༶�ĳ�����
-- kindID: A �걨��  B ��ѵ��
ALTER FUNCTION getClassAttendanceRate
(	
	@classID int, @kindID varchar(50)
)
RETURNS decimal(18,2)
AS
BEGIN
	declare @re decimal(18,2), @r1 decimal(18,2), @r int, @studentCount int, @scheduleCount int
	select @re=0, @r1=0, @r=0, @studentCount=0, @scheduleCount=0
	if @kindID='A'		--�걨��
	begin
		-- ���߿���
		select @re=avg(dbo.getCourseCompletion(a.ID)), @r=sum(dbo.getEnterCheckinOutClassQty(a.ID,@classID)), @studentCount=count(*) from dbo.studentCourseList a, applyInfo b where a.ID=b.enterID and b.refID=@classID
		-- ���¿���
		select @r=@r+count(*) from classSchedule c, checkinInfo d where c.ID=d.refID and c.mark='A' and c.typeID=0 and c.classID=@classID
		select @scheduleCount=count(*) from classSchedule where mark='A' and typeID=0 and online=0 and classID=@classID
		select @r1 = @r*100.00/@studentCount/@scheduleCount/1.00
	end
	select @re=isnull((@re+iif(@r1>100,100,@r1))/2.00,0)
	return @re
END
GO

-- CREATE DATE: 2025-01-30
-- �������֤���ҵ�ǰ�пε���������Ա��Ϣ
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
		select @status=2, @msg='��ѧԱû����ؿγ�'
	if @name=''
		select @status=1, @msg='û���ҵ���ѧԱ��Ϣ'

	if @refID>0
		select @examDate=isnull(convert(varchar(20),examDate,23),'') from studentCertList where ID=@refID
	select @status as status,@name as name, @enterID as enterID, @refID as refID, @examDate as examDate, @msg as msg
END
GO

-- CREATE DATE: 2025-01-30
-- �Ǽ���������Ա��������
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
-- �Ǽ���������Ա���Գɼ�
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

	-- д������־
	exec writeOpLog '', '�޸Ŀ��Գɼ�','saveExamScore',@registerID,@result,@refID
	select 0 as status, '�����ɹ�' as msg
END
GO

-- =============================================
-- CREATE Date: 2025-03-21
-- Description:	��������ѧԱ��Դ
-- @selList: �������ö��ŷָ���kind A applyID  B username
-- Use Case:	exec [setStudentSource] '...'
-- =============================================
CREATE PROCEDURE [dbo].[setStudentSource] 
	@selList varchar(4000), @kind varchar(50), @classID varchar(50), @source nvarchar(50), @registerID varchar(50)
AS
BEGIN
	--���������뵽��ʱ��
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

	-- д������־
	select @event='����ѧԱ��Դ'
	exec writeOpLog '', @event,'setStudentSource',@registerID,@selList,@source
	select 0 as status, '�����ɹ�' as msg
END
GO

-- CREATE DATE: 2025-03-22
-- ���ݸ����Ĳ�������ӻ��߸���ѧԱ��Դ��Ϣ
-- USE CASE: exec updateSourceInfo 1,'P1','xxxx'...
CREATE PROCEDURE [dbo].[updateSourceInfo]
	@ID int,@source nvarchar(50),@status int,@registerID varchar(50)
AS
BEGIN
	declare @re int, @msg varchar(100), @event nvarchar(50)
	
	if not exists(select 1 from sourceInfo where ID=@ID)	-- �¼�¼
	begin
		insert into sourceInfo(source,registerID) values(@source,@registerID)
		select @ID=max(ID) from sourceInfo where registerID=@registerID
	end
	else
	begin
		update sourceInfo set source=@source,status=@status where ID=@ID
	end
	-- д������־
	select @event='�༭ѧԱ��Դ'
	exec writeOpLog '', @event,'updateSourceInfo',@registerID,@ID,@source
	select @ID as re
END
GO

-- CREATE DATE: 2015-01-12
-- ���ݸ����Ĳ�����ɾ��ѧԱ��Դ���ݣ���д��־
-- USE CASE: exec delSourceInfo 1
CREATE PROCEDURE [dbo].[delSourceInfo]
	@ID int,@memo nvarchar(500),@registerID varchar(50)
AS
BEGIN
	if exists(select 1 from sourceInfo where ID=@ID)
	begin
		delete from sourceInfo where ID=@ID
		-- д������־
		exec writeOpLog '','ɾ��ѧԱ��Դ','delSourceInfo',@registerID,@memo,@ID
	end
END
GO


-- CREATE DATE: 2025-04-10
-- ��ȡѧԱ����֤����Ϣ
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
-- ������ڼ�¼����һ���γ�/�༶ת����һ���γ�/�༶
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
-- ��ȡ��ǰ���пͻ���Դ��ϸ
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
-- ��ȡ��ǰ���пγ�
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
--���ݸ������ڣ��г����������Ա�ͳ��: ָ�����ڷ�Χ��������(�������˿ε�)������ͬ�ڡ�ͬ��%������ȫ�ꡢǰ��ȫ��
--@startDate ��ʼ����  @endDate ��ֹ����  @kind: 0 ���γ�  1 ���ͻ���Դ  @mark: data/file
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
	--��д������Ŀ
	insert into @tb(ID,item) select ID,item from ' + iif(@kind=0,'dbo.[getCurrCourseList]()','dbo.[getCurrSourceList]()') + ' 
	--���ҽ�������
	update @tb set thisYear=b.count from @tb a, (select ' + @key + ' as ID, count(*) as count from studentCourseList where status<3 and regDate between ''' + @startDate + ''' and ''' + @endDate + ''' group by ' + @key + ') b where a.ID=b.ID
	--��������ͬ������
	update @tb set YOY=b.count from @tb a, (select ' + @key + ' as ID, count(*) as count from studentCourseList where status<3 and regDate between ''' + convert(varchar(20),dateadd(yy,-1,@startDate),23) + ''' and ''' + convert(varchar(20),dateadd(yy,-1,@endDate),23) + ''' group by ' + @key + ') b where a.ID=b.ID
	--��������ȫ������
	update @tb set lastYear=b.count from @tb a, (select ' + @key + ' as ID, count(*) as count from studentCourseList where status<3 and regDate between ''' + cast(year(dateadd(yy,-1,@startDate)) as varchar) + '-01-01' + ''' and ''' + cast(year(dateadd(yy,-1,@startDate)) as varchar) + '-12-31' + ''' group by ' + @key + ') b where a.ID=b.ID
	--����ǰ��ȫ������
	update @tb set blastYear=b.count from @tb a, (select ' + @key + ' as ID, count(*) as count from studentCourseList where status<3 and regDate between ''' + cast(year(dateadd(yy,-2,@startDate)) as varchar) + '-01-01' + ''' and ''' + cast(year(dateadd(yy,-2,@startDate)) as varchar) + '-12-31' + ''' group by ' + @key + ') b where a.ID=b.ID
	--��Ӻϼ�
	insert into @tb select 1,'''',''�ϼ�'',sum(thisYear),sum(YOY),0,sum(lastYear),sum(blastYear) from @tb
	--����ͬ��
	update @tb set rate=iif(YOY=0,0,(thisYear-YOY)*100.00/YOY)

	if @mark=''data''
		select iif(kindID=0,cast(ROW_NUMBER() OVER (ORDER BY kindID) as varchar),'''') as No,* from @tb order by kindID,ID
	if @mark=''file''
		select iif(kindID=0,cast(ROW_NUMBER() OVER (ORDER BY kindID) as varchar),'''') as No,item as ��Ŀ,thisYear as [' + replace(@startDate,'-','') + '-' + replace(@endDate,'-','') + '], YOY as ȥ��ͬ��, rate as ͬ������, lastYear as ȥ��ȫ��, blastYear as ǰ��ȫ�� from @tb  order by kindID,ID'
	
	EXECUTE (@sql)
END
GO

-- CREATE DATE: 2025-06-20
-- ��ȡstudent list under one saler
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
--����ѧԱ��ĳ���������µĿγ�����
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
-- ���ݸ����Ĳ�������ӻ��߸�����ҵ�ͻ���Ϣ
-- USE CASE: exec updateSalerUnitInfo 1,'P1','xxxx'...
ALTER PROCEDURE [dbo].[updateSalerUnitInfo]
	@ID int,@unitName nvarchar(4000),@taxNo varchar(50),@saler varchar(50),@kindID int,@linker varchar(500),@phone varchar(200),@address varchar(200),@email varchar(200),@association varchar(50),@memo varchar(2000),@registerID varchar(50)
AS
BEGIN
	declare @logMemo nvarchar(500)
	if @ID=0	-- �¼�¼
	begin
		insert into unitInfo(unitName,taxNo,saler,kindID,linker,phone,address,email,association,memo,registerID) values(@unitName,@taxNo,@saler,@kindID,@linker,@phone,@address,@email,@association,@memo,@registerID)
		select @ID=max(ID) from unitInfo where registerID=@registerID
	end
	else
	begin
		update unitInfo set unitName=@unitName,taxNo=@taxNo,saler=@saler,kindID=@kindID,linker=@linker,phone=@phone,address=@address,email=@email,association=@association,memo=@memo where ID=@ID
	end
	
	-- д������־
	select @logMemo = @unitName+'  '+@linker+'  '+@phone+'  '+@memo
	exec writeOpLog '','��ҵ��Ϣ','updateSalerUnitInfo',@registerID,@logMemo,@ID
	select @ID as re
END
GO

-- CREATE DATE: 2025-06-25
-- ���ݸ����Ĳ�����ȷ����ҵ���ƺʹ��롣
-- USE CASE: exec setUnitTaxConfirm 'P1','xxxx'...
CREATE PROCEDURE [dbo].[setUnitTaxConfirm]
	@unitName nvarchar(4000),@taxNo varchar(50),@address nvarchar(100),@username varchar(50),@registerID varchar(50)
AS
BEGIN
	declare @logMemo nvarchar(500)
	select @unitName=replace(dbo.whenull(@unitName,''),' ',''), @taxNo=replace(dbo.whenull(@taxNo,''),' ',''), @address=replace(dbo.whenull(@address,''),' ','')
	if @unitName>'' and @taxNo>'' and len(@taxNo)=18	--�����ƻ����Ļ���벻��ȷ�ģ����账��
	begin
		if not exists(select 1 from unitInfo where unitName=@unitName or taxNo=@taxNo)	-- �¼�¼
		begin
			insert into unitInfo(unitName,taxNo,address,checker,registerID) values(@unitName,@taxNo,@address,@registerID,@registerID)
			--�Զ�������Щ����ͬ���Ƶ���˰�ŵ�ѧԱ��Ϣ
			update studentInfo set tax=@taxNo,address=iif(address is null and @address>'',@address,address) where unit=@unitName and (tax='' or tax is null)
			select @logMemo='������ҵ' + @unitName + @taxNo + @address
		end
		else
		begin
			if @registerID=''	--���˹�ȷ�ϵģ�һ������ѧԱע����Ϣ���ʱ�������Զ��Ǽǣ�
				update unitInfo set unitName=@unitName,address=iif(address is null and @address>'',@address,address) where taxNo=@taxNo and (checker='' or checker is null)
			else
			begin
				if exists(select 1 from unitInfo where unitName=@unitName and taxNo<>@taxNo)
					update unitInfo set taxNo=@taxNo,address=iif(@address>'',@address,address),checker=@registerID where unitName=@unitName
				else if exists(select 1 from unitInfo where taxNo=@taxNo and unitName<>@unitName)
					update unitInfo set unitName=@unitName,address=iif(@address>'',@address,address),checker=@registerID where taxNo=@taxNo
				--����ȷ�ϵ���ҵ��Ϣ��������˲�����ѧԱ��Ϣ
				update studentInfo set tax=@taxNo,address=iif(address is null and @address>'',@address,address) where unit=@unitName and tax<>@taxNo
				update studentInfo set unit=@unitName,address=iif(address is null and @address>'',@address,address) where tax=@taxNo and unit<>@unitName
				select @logMemo='ȷ����ҵ����' + @unitName + @taxNo + @address
			end
		end

		if @username>''
			update studentInfo set tax=@taxNo, unit=@unitName, address=@address where username=@username
	
		-- д������־
		exec writeOpLog '','��ҵ��Ϣ','setUnitTaxConfirm',@registerID,@logMemo,@taxNo
	end
	select @taxNo as re
END
GO

-- CREATE DATE: 2025-06-25
-- ���ݸ����Ĳ����������ҵ���ƺʹ����Ƿ��ѵǼǣ��Դ���Ϊ����
-- USE CASE: exec checkUnitInfo 'P1','xxxx'...
ALTER PROCEDURE [dbo].[checkUnitInfo]
	@unitName nvarchar(4000),@taxNo varchar(50)
AS
BEGIN
	declare @re int
	select @unitName=replace(dbo.whenull(@unitName,''),' ',''), @taxNo=replace(dbo.whenull(@taxNo,''),' ','')
	if @taxNo>'' and exists(select 1 from unitInfo where taxNo=@taxNo)	-- �д���
		select 1 as re,unitName,taxNo,saler,checker,checkerName,isnull(address,'') as address,isnull(phone,'') as phone from v_unitInfo where taxNo=@taxNo
	else if @unitName>'' and exists(select 1 from unitInfo where unitName=@unitName)	-- �е�λ����
		select 2 as re,unitName,taxNo,saler,checker,checkerName,isnull(address,'') as address,isnull(phone,'') as phone from v_unitInfo where unitName=@unitName
	else
		select 0 as re
END
GO

-- CREATE DATE: 2025-09-29
-- ���ĳ���༶�Ŀα��Ƿ�����ϱ�Ҫ��
-- �������ڡ������Ρ���ѵ�ص㣬�ƻ������� 1-60 ��֮�䣬�α������ڼƻ�����֮�䣬��ʦ���������֤�����ң�ѧʱ1-4���α�����+�����粻���ظ�
-- USE CASE: exec checkClassSchedule 1
ALTER PROCEDURE [dbo].[checkClassSchedule]
	@classID varchar(50)
AS
BEGIN
	declare @re int, @msg nvarchar(4000),@startDate smalldatetime,@endDate smalldatetime,@courseID varchar(50)
	select @startDate=startDate,@endDate=endDate,@courseID=courseID,@msg='',@re=0 from generateApplyInfo where ID=@classID
	--�������ڱ������¸���
	if month(getDate())>=month(@startDate)
		select @msg = @msg + '��ѵ���ڱ���Ϊ�¸��£�'
	--��ѵ����
	if exists(select 1 from courseInfo where courseID=@courseID and period>datediff(d,@startDate,@endDate)+1)
		select @msg = @msg + '��ѵ���ڲ��㣬����������' + cast(period as varchar) + '��' from courseInfo where courseID=@courseID
	--�����Ρ���ѵ�ص㣬�ƻ�����
	select @msg=@msg+iif(planQty<1 or planQty>60,'�ƻ�����Ӧ�� 1-60 ��֮�䣻','')+iif(adviserName>'','','������δ�')+iif(notes='','��ѵ�ص�δ�','') from v_generateApplyInfo where ID=@classID
	--�α������ڼƻ�����֮��
	if exists(select 1 from classSchedule where classID=@classID and mark='A' and (theDate<@startDate or theDate>@endDate))
		select @msg = @msg + '�α����ڳ�����ѵ���ڣ�'
	--��ʦ���������֤�����ң�ѧʱ1-4
	select @msg=@msg+iif(teacherName='','��ʦ�����п�ȱ��','')+iif(teacherSID='','��ʦ���֤�п�ȱ��','')+iif(online=0 and address='','���½����п�ȱ��','')+iif(hours<1 or hours>4,'ѧʱӦ��1-4֮�䣻','') from v_classSchedule where classID=@classID and mark='A'
	--�α�����+�����粻���ظ�
	if exists(select 1 from classSchedule where classID=@classID and mark='A' group by theDate, typeID having count(*)>1)
		select @msg = @msg + '�α�����+�����粻���ظ���'
	select @msg as msg
END
GO

--CREATE Date:2020-05-18
--����ѧԱָ������ͼƬ�Ĵ�С
--kindID: 
--0	��Ƭ
--1	���֤����
--2	���֤����
--3	ѧ��֤��
--4	ѧ������֤
--5	��ְ֤��
--6	��ס֤
--7	��ŵ��
--8	�籣֤��
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

