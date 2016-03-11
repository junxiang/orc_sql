use familydollar
go

select *   from  familydollar. [dbo].[tb_Userlist]  where Permission_level is null username is null username in('WHOSKINS@FAMILYDOLLAR.com','AGREEN@FAMILYDOLLAR.com')  
 
select *  into familydollar.[dbo].[tb_Userlist_20160308BAK] from familydollar. [dbo].[tb_Userlist]

--alter table [tb_Userlist] add FullName nvarchar(200)

--insert into  familydollar.[dbo].[tb_Userlist]( Username,Password,Permission_level,DateCreated,flag)
--select  t.[EMAIL_ADDRESS],'Fd72xjdb','Chain access',getdate(),''
--from (values('MRINEY@FAMILYDOLLAR.com'),('jcoble@FAMILYDOLLAR.com')
--)t(email_address)


 
 --select * into familydollar.[dbo].[tb_Userlist_20150728BAK] from familydollar.[dbo].[tb_Userlist]

-- insert into [dbo].[tb_Userlist]([EMPLOYEE_NUMBER],FirstName,Username,[JOBTitel],[STORE],[GROUP],[REGION],[DISTRICT],Password,Permission_level,DateCreated,flag)
-- select [EMPLOYEE_NUMBER],[FULL_NAME],[EMAIL_ADDRESS],[JOB_NAME],[STORE],[GROUP],[REGION],[DISTRICT],'Fd72xjdb','Field access',getdate(),''
 
--insert into [dbo].[tb_Userlist]([EMPLOYEE_NUMBER],Username,[STORE],[GROUP],[REGION],[DISTRICT],Password,Permission_level,DateCreated,flag)
--select t.[EMPLOYEE_NUMBER],t.[EMAIL_ADDRESS],t.[STORE],t.[GROUP],t.[REGION],t.[DISTRICT],'Fd72xjdb','Field access',getdate(),''

--------add users --------------------------------------------
--insert into [dbo].[tb_Userlist]([EMPLOYEE_NUMBER],FULLName,Username,[STORE],[GROUP],[REGION],[DISTRICT],Password,Permission_level,DateCreated,flag,AddedDate,Live)
select [EMPLOYEE_NUMBER],[FULL_NAME],[EMAIL_ADDRESS],[STORE],[GROUP],[REGION],[DISTRICT],'Fd72xjdb','Field access',getdate(),'',getdate(),'1'
from (values (N'1100190',N'SCHEUFELE, KEVIN',N'KSCHEUFELE@FAMILYDOLLAR.com',N'PM in Training...',N'09200/FDO',N'26/01/2016',null,null,N'09200',N'PM in Training',N'0060',N'13',null,N'7280013 Region 13',N'Y')
,(N'1106018',N'MEIXELL, LISA',N'LMEIXELL3@FAMILYDOLLAR.com',N'DM in Training...',N'01532/1 KY SHEPHERD',N'29/02/2016',null,null,N'01532',N'DM in Training',N'0060',N'49',null,N'7280049 Region 49',N'Y')

 )t([EMPLOYEE_NUMBER],[FULL_NAME],[EMAIL_ADDRESS],[JOB_NAME],[LOCATION],[Hire_date],[ACTUAL_TERM_DATE],[NOTIFIED_TERM_DATE],[STORE],[BUSINESS_TITLE],[GROUP],[REGION],[DISTRICT],[ORGANIZATION],[CURRENT_EMPLOYEE_FLAG])
 where  not exists(   select username from tb_Userlist where username =t.[EMAIL_ADDRESS])
 and [EMAIL_ADDRESS] is not null
 
 ---------change users-------------------
 update a 
 set [group]=t.[Group],Region=t.region,district=t.district,store=null,fullname=t.[FULL_NAME],live=1
 --select [EMPLOYEE_NUMBER],[FULL_NAME],[EMAIL_ADDRESS],[Store],[GROUP],[Region],[DISTRICT]
 from (values
(N'1036541',N'SONNIER, TIMOTHY (Tim)',N'TSONNIER@FAMILYDOLLAR.com',N'District Manager...',N'District Manager...',N'7290230 District 230',N'7290002 District 2',N'Y',N'0050',N'01',N'230',N'1/02/2016',N'25/01/2016')
,(N'1088388',N'HOSKINS, WADE DOUGLAS (Doug)',N'WHOSKINS@FAMILYDOLLAR.com',N'District Manager...',N'DM in Training...',N'7290436 District 436',N'7280008 Region 8',N'Y',N'0010',N'08',N'436',N'1/02/2016',N'25/01/2016')
,(N'19544',N'STEWART, SHERRY L',N'SSTEWART3@FAMILYDOLLAR.com',N'District Manager...',N'Area Operations Manager...',N'7290231 District 231',N'7290231 District 231',N'Y',N'0050',N'24',N'231',N'1/02/2016',N'25/01/2016')
,(N'272396',N'LITTLE, AMY D',N'ALittle@FAMILYDOLLAR.com',N'District Manager...',N'Assistant District Manager...',N'7290500 District 500',N'7290131 District 131',N'Y',N'0020',N'26',N'500',N'1/02/2016',N'25/01/2016')
,(N'501938',N'BROOKS, TERESA O',N'TBROOKS@FAMILYDOLLAR.com',N'DM in Training...',N'Store Manager (Salaried)...',N'7280026 Region 26',N'9810857 Store 10857 (VA)',N'Y',N'0020',N'26',null,N'1/02/2016',N'25/01/2016')
,(N'606037',N'BURKHARDT, DAVE A',N'DBURKHARDT@FAMILYDOLLAR.com',N'Store Manager (Salaried)...',N'District Manager...',N'9807159 Store 07159 (OH)',N'7290499 District 499',N'Y',N'0010',N'22',N'560',N'1/02/2016',N'25/01/2016')
,(N'667515',N'LOWE, ALICIA MAUREEN',N'ALowe@FAMILYDOLLAR.com',N'Area Operations Manager...',N'RVP...',N'7290198 District 198',N'7280022 Region 22',N'Y',N'0010',N'22',N'198',N'1/02/2016',N'25/01/2016')
,(N'674080',N'CHAMBERS, CARTHO JR',null,N'Assistant District Manager...',N'Store Manager (Salaried)...',N'7290131 District 131',N'9807205 Store 07205 (NC)',N'Y',N'0020',N'26',N'131',N'1/02/2016',N'25/01/2016')
,(N'681571',N'UGUZ, SEDAT H',N'SUGUZ@FAMILYDOLLAR.com',N'Store Manager (Salaried)...',N'Performance Manager...',N'9803462 Store 03462 (MA)',N'7290392 District 392',N'Y',N'0040',N'32',N'359',N'1/02/2016',N'25/01/2016')
,(N'690048',N'LEIGHTON, ROBERT A',N'ALEIGHTON@FAMILYDOLLAR.com',N'Manager 05...',N'District Manager...',N'8140500 Merchandising Solutions',N'7290133 District 133',N'Y',null,null,null,N'1/02/2016',N'25/01/2016')
,(N'714243',N'NUNEZ, LOUIS A',N'LNUNEZ@FAMILYDOLLAR.com',N'Store Manager (Salaried)...',N'Store Manager (Salaried)...',N'9811535 Store 11535 (MA)',N'9802185 Store 02185 (MA)',N'Y',N'0040',N'32',N'359',N'1/02/2016',N'25/01/2016')
,(N'767607',N'FARMER, JAMES',N'JFARMER@FAMILYDOLLAR.com',N'District Manager...',N'Store Manager (Salaried)...',N'7290216 District 216',N'9804303 Store 04303 (KY)',N'Y',N'0010',N'14',N'216',N'1/02/2016',N'25/01/2016')
,(N'771518',N'REAVLEY, KENNETH L',N'KREAVLEY@FAMILYDOLLAR.com',N'Store Manager (Salaried)...',N'Area Operations Manager...',N'9803165 Store 03165 (OH)',N'7290198 District 198',N'Y',N'0010',N'22',N'444',N'1/02/2016',N'25/01/2016')
,(N'780801',N'WILBURN, TONYIA S',N'TWILBURN@FAMILYDOLLAR.com',N'Store Manager (Salaried)...',N'Store Manager (Salaried)...',N'9805535 Store 05535 (MS)',N'9807275 Store 07275 (AL)',N'Y',N'0020',N'41',N'067',N'1/02/2016',N'25/01/2016')
,(N'789332',N'HOUK, TINA M',N'THOUK@FAMILYDOLLAR.com',N'Store Manager (Salaried)...',N'District Manager...',N'9801114 Store 01114 (OH)',N'7290436 District 436',N'Y',N'0010',N'08',N'437',N'1/02/2016',N'25/01/2016')
,(N'812032',N'LYLE, LORI K',N'LLYLE@FAMILYDOLLAR.com',N'District Manager...',N'Performance Manager...',N'7290591 District 591',N'7290231 District 231',N'Y',null,null,null,N'1/02/2016',N'25/01/2016')
,(N'870409',N'HIMES, ASHLEY N',N'AHIMES@FAMILYDOLLAR.com',N'Performance Manager...',N'Store Manager (Salaried)...',N'7290146 District 146',N'9801346 Store 01346 (OH)',N'Y',N'0010',N'16',N'146',N'1/02/2016',N'25/01/2016')

) t ([EMPLOYEE_NUMBER],[FULL_NAME],[EMAIL_ADDRESS],[New Job],[Previous Job],[New Organization],[Previous Organization],[CURRENT_EMPLOYEE_FLAG],[GROUP],[REGION],[DISTRICT],[Today]]s_Date],[Last_Week]]s_Date])
inner join tb_Userlist a on t.email_address=a.username and a.Permission_level='Field access'


--insert into [dbo].[tb_Userlist]([EMPLOYEE_NUMBER],FullName,Username,[STORE],[GROUP],[REGION],[DISTRICT],Password,Permission_level,DateCreated,flag,AddedDate,Live)
select [EMPLOYEE_NUMBER],[FULL_NAME],[EMAIL_ADDRESS],null [STORE],[GROUP],[REGION],[DISTRICT],'Fd72xjdb','Field access',getdate(),'',getdate(),'1'
 from (values
 (N'1036541',N'SONNIER, TIMOTHY (Tim)',N'TSONNIER@FAMILYDOLLAR.com',N'District Manager...',N'District Manager...',N'7290230 District 230',N'7290002 District 2',N'Y',N'0050',N'01',N'230',N'1/02/2016',N'25/01/2016')
,(N'1088388',N'HOSKINS, WADE DOUGLAS (Doug)',N'WHOSKINS@FAMILYDOLLAR.com',N'District Manager...',N'DM in Training...',N'7290436 District 436',N'7280008 Region 8',N'Y',N'0010',N'08',N'436',N'1/02/2016',N'25/01/2016')
,(N'19544',N'STEWART, SHERRY L',N'SSTEWART3@FAMILYDOLLAR.com',N'District Manager...',N'Area Operations Manager...',N'7290231 District 231',N'7290231 District 231',N'Y',N'0050',N'24',N'231',N'1/02/2016',N'25/01/2016')
,(N'272396',N'LITTLE, AMY D',N'ALittle@FAMILYDOLLAR.com',N'District Manager...',N'Assistant District Manager...',N'7290500 District 500',N'7290131 District 131',N'Y',N'0020',N'26',N'500',N'1/02/2016',N'25/01/2016')
,(N'501938',N'BROOKS, TERESA O',N'TBROOKS@FAMILYDOLLAR.com',N'DM in Training...',N'Store Manager (Salaried)...',N'7280026 Region 26',N'9810857 Store 10857 (VA)',N'Y',N'0020',N'26',null,N'1/02/2016',N'25/01/2016')
,(N'606037',N'BURKHARDT, DAVE A',N'DBURKHARDT@FAMILYDOLLAR.com',N'Store Manager (Salaried)...',N'District Manager...',N'9807159 Store 07159 (OH)',N'7290499 District 499',N'Y',N'0010',N'22',N'560',N'1/02/2016',N'25/01/2016')
,(N'667515',N'LOWE, ALICIA MAUREEN',N'ALowe@FAMILYDOLLAR.com',N'Area Operations Manager...',N'RVP...',N'7290198 District 198',N'7280022 Region 22',N'Y',N'0010',N'22',N'198',N'1/02/2016',N'25/01/2016')
,(N'674080',N'CHAMBERS, CARTHO JR',null,N'Assistant District Manager...',N'Store Manager (Salaried)...',N'7290131 District 131',N'9807205 Store 07205 (NC)',N'Y',N'0020',N'26',N'131',N'1/02/2016',N'25/01/2016')
,(N'681571',N'UGUZ, SEDAT H',N'SUGUZ@FAMILYDOLLAR.com',N'Store Manager (Salaried)...',N'Performance Manager...',N'9803462 Store 03462 (MA)',N'7290392 District 392',N'Y',N'0040',N'32',N'359',N'1/02/2016',N'25/01/2016')
,(N'690048',N'LEIGHTON, ROBERT A',N'ALEIGHTON@FAMILYDOLLAR.com',N'Manager 05...',N'District Manager...',N'8140500 Merchandising Solutions',N'7290133 District 133',N'Y',null,null,null,N'1/02/2016',N'25/01/2016')
,(N'714243',N'NUNEZ, LOUIS A',N'LNUNEZ@FAMILYDOLLAR.com',N'Store Manager (Salaried)...',N'Store Manager (Salaried)...',N'9811535 Store 11535 (MA)',N'9802185 Store 02185 (MA)',N'Y',N'0040',N'32',N'359',N'1/02/2016',N'25/01/2016')
,(N'767607',N'FARMER, JAMES',N'JFARMER@FAMILYDOLLAR.com',N'District Manager...',N'Store Manager (Salaried)...',N'7290216 District 216',N'9804303 Store 04303 (KY)',N'Y',N'0010',N'14',N'216',N'1/02/2016',N'25/01/2016')
,(N'771518',N'REAVLEY, KENNETH L',N'KREAVLEY@FAMILYDOLLAR.com',N'Store Manager (Salaried)...',N'Area Operations Manager...',N'9803165 Store 03165 (OH)',N'7290198 District 198',N'Y',N'0010',N'22',N'444',N'1/02/2016',N'25/01/2016')
,(N'780801',N'WILBURN, TONYIA S',N'TWILBURN@FAMILYDOLLAR.com',N'Store Manager (Salaried)...',N'Store Manager (Salaried)...',N'9805535 Store 05535 (MS)',N'9807275 Store 07275 (AL)',N'Y',N'0020',N'41',N'067',N'1/02/2016',N'25/01/2016')
,(N'789332',N'HOUK, TINA M',N'THOUK@FAMILYDOLLAR.com',N'Store Manager (Salaried)...',N'District Manager...',N'9801114 Store 01114 (OH)',N'7290436 District 436',N'Y',N'0010',N'08',N'437',N'1/02/2016',N'25/01/2016')
,(N'812032',N'LYLE, LORI K',N'LLYLE@FAMILYDOLLAR.com',N'District Manager...',N'Performance Manager...',N'7290591 District 591',N'7290231 District 231',N'Y',null,null,null,N'1/02/2016',N'25/01/2016')
,(N'870409',N'HIMES, ASHLEY N',N'AHIMES@FAMILYDOLLAR.com',N'Performance Manager...',N'Store Manager (Salaried)...',N'7290146 District 146',N'9801346 Store 01346 (OH)',N'Y',N'0010',N'16',N'146',N'1/02/2016',N'25/01/2016')

) t ([EMPLOYEE_NUMBER],[FULL_NAME],[EMAIL_ADDRESS],[New Job],[Previous Job],[New Organization],[Previous Organization],[CURRENT_EMPLOYEE_FLAG],[GROUP],[REGION],[DISTRICT],[Today]]s_Date],[Last_Week]]s_Date])
where not exists(select * from tb_Userlist a where t.email_address=a.username)
and email_address is not null


-------delete user
update a
set live=0,RemovedDate=Getdate()
from  tb_userlist a  where username in( 
 select username from (values
 (null) 
,(N'JLOPEZ2@FAMILYDOLLAR.com')
,(N'KOrr@FAMILYDOLLAR.com')


) t(username) where username is not null
)

update a
set live=0,RemovedDate=Getdate()
from  tb_userlist a  where username in(
select email_address from (values
(N'1039451',N'SPATZ, LEIGH ANN',N'LSPATZ@FAMILYDOLLAR.com',N'District Manager...',N'00022/1 VA ROANOKE',N'20/04/2015',N'27/01/2016',N'27/01/2016',N'00022',N'District Manager II',N'0040',N'28',N'179',N'7290179 District 179')
,(N'1088714',N'SPAULDING, LEVI',N'LSPAULDING@FAMILYDOLLAR.com',N'DM in Training...',N'02128/1 IN JEFFERSON',N'30/11/2015',N'28/01/2016',N'29/01/2016',N'02128',N'DM in Training',N'0060',N'49',null,N'7280049 Region 49')
,(N'422494',N'GILL, NORMAN J',N'NGILL@FAMILYDOLLAR.com',N'Performance Manager...',N'01232/1 OK TULSA',N'8/09/2014',N'27/01/2016',N'26/01/2016',N'01232',N'Performance Manager',N'0060',N'29',N'092',N'7290092 District 92')
,(N'579373',N'TOLSMA, CHAD M',N'CTOLSMA@FAMILYDOLLAR.com',N'District Manager...',N'06086/1 ND FARGO',N'24/07/2007',N'27/01/2016',N'27/01/2016',N'06086',N'District Manager II',N'0060',N'37',N'377',N'7290377 District 377')
,(N'717599',N'LOWE, ERSKINE L (Lee)',N'ELOWE@FAMILYDOLLAR.com',N'District Manager...',N'09437/W NC BURLINGTO',N'24/02/2010',N'23/01/2016',N'27/01/2016',N'09437',N'District Manager II',N'0020',N'26',N'500',N'7290500 District 500')
,(N'753539',N'CARPENTER, KEVIN',N'KCARPENTER@FAMILYDOLLAR.com',N'Area Operations Manager...',N'01121/1 TX BEAUMONT',N'25/10/2010',N'30/01/2016',N'30/01/2016',N'01121',N'Area Operations Manager',N'0050',N'01',N'457',N'7290457 District 457')
,(N'885282',N'ELLIS, STEVEN W',N'SEllis@FAMILYDOLLAR.com',N'RVP...',N'01334/1 MI JACKSON',N'4/02/2013',N'29/01/2016',N'28/01/2016',N'01334',N'Regional VP, Store Operations',N'0010',N'47',null,N'7280047 Region 47')
)t([EMPLOYEE_NUMBER],[FULL_NAME],[EMAIL_ADDRESS],[JOB_NAME],[LOCATION],[Hire_date],[ACTUAL_TERM_DATE],[NOTIFIED_TERM_DATE],[STORE],[BUSINESS_TITLE],[GROUP],[REGION],[DISTRICT],[ORGANIZATION])
 
)

select * from  tb_userlist a  where username in(
 'RPEREZ3@FAMILYDOLLAR.com'
,'MDANIELS@FAMILYDOLLAR.com'
,'KLITTLETON@FAMILYDOLLAR.com'
,'KLITTLETON@FAMILYDOLLAR.com'
 
)


  update familydollar. [dbo].[tb_Userlist] set live=1 where live is null
select username,count(1) from tb_userlist
group by username having(count(1)>=2)

 
select * from tb_userlist  
-----------------------------------------------[tb_userlist]---------------------------------------------------------------------------------------------------------------------------------
--use [FamilyDollar]
update u
set [Group]=h.[Group],
	Region=h.[Region],
	district=h.district 
---select *  
from [tb_userlist] u inner join [Hierarchy] h on u.[Store]=h.store

 update u
set [Group]=h.[Group],
	Region=h.[Region] 
--select * 
 from [tb_userlist] u inner join [Hierarchy] h on u.district=h.district and u.store is null

  update u
set [Group]=h.[Group] 
 ---select * 
 from [tb_userlist] u inner join [Hierarchy] h on u.Region=h.Region and u.store is null and u.district is null


select *  from  [dbo].[tb_Userlist] where datediff(day,datecreated,getdate())=0


  ------drop table [FamilyDollar].[dbo].[tb_Userlist]
  ------select * into [FamilyDollar].[dbo].[tb_Userlist] from [FamilyDollar_test].[dbo].[tb_Userlist]



use [FamilyDollar_test]
go
   drop table familydollar_test.[dbo].[tb_Userlist]
 select * into familydollar_test.[dbo].[tb_Userlist] from familydollar.[dbo].[tb_Userlist]
 go

update u
set [Group]=h.[Group],
	Region=h.[Region],
	district=h.district 
---select *  
from [tb_userlist] u inner join [Hierarchy] h on u.[Store]=h.store

 update u
set [Group]=h.[Group],
	Region=h.[Region] 
--select * 
 from [tb_userlist] u inner join [Hierarchy] h on u.district=h.district and u.store is null

  update u
set [Group]=h.[Group] 
 ---select * 
 from [tb_userlist] u inner join [Hierarchy] h on u.Region=h.Region and u.store is null and u.district is null


 select * from [FamilyDollar].[dbo].[tb_Userlist] where live=1
 select count(*)  from [FamilyDollar_test].[dbo].[tb_Userlist]




 ------------------------------------------------------------****************************************************
 /****** Script for SelectTopNRows command from SSMS  ******-/
--Unique users (1)
SELECT distinct 
[Username]
,[Password]
,[Permission_level]
,[Live]
,[FullName]
FROM [FamilyDollar].[dbo].[tb_Userlist]
  where live = 1
  and username like '%familydollar%'





--Users including duplicates (2)
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  
[Username]
,[Password]
,[Permission_level] 
,[Group]
,[Region]
,[District]
,[Live]
,[FullName]
  FROM [FamilyDollar].[dbo].[tb_Userlist]
  where live = 1
  and username like '%familydollar%'




--Query to show just duplicate user sand number of times they occur in list: (3)

select username , [count] from (
SELECT  
[Username]
,[Password]
,[Permission_level]
,count(*) as [count]
,[Live]
,[FullName]
FROM [FamilyDollar].[dbo].[tb_Userlist]
  where live = 1
  and username like '%familydollar%'
  group by [Username]
 ,[Password]
 ,[Permission_level]
 ,[Live]
 ,[FullName]
 having count(*)>1) as a

 update a
set live=0,RemovedDate=Getdate()
--- select t.*,a.* 
 from tb_Userlist a inner join 
 (select * from 
(values
(N'ALARCON, CARLOS',N'CALARCON@FAMILYDOLLAR.com',N'1001877')
,(N'MARTINEZ, ABEL VILLALON',N'AMARTINEZ2@FAMILYDOLLAR.com',N'1004631')
,(N'EASTON, DAVID',null,N'1005843')
,(N'MORELAND, MATTHEW',N'MMORELAND@FAMILYDOLLAR.com',N'1005990')
,(N'CRISWELL, JENNIFER',N'JCRISWELL@FAMILYDOLLAR.com',N'1012386')
,(N'WILSON, JHALAN',N'JWILSON4@FAMILYDOLLAR.com',N'1012957')
,(N'BROWN, LISA',N'LBROWN3@FAMILYDOLLAR.com',N'1013885')
,(N'TOKOFSKY, DENNIS ROSS',N'DTOKOFSKY@FAMILYDOLLAR.com',N'1025512')
,(N'WALKER, KINNETH D',N'KWALKER@FAMILYDOLLAR.com',N'1042196')
,(N'BEAN, TERRENCE C JR',N'TBEAN2@FAMILYDOLLAR.com',N'1043009')
,(N'MONTCHAL, PAMELA (PAM)',N'PMONTCHAL@FAMILYDOLLAR.com',N'1083309')
,(N'CARDINAL, ERIC',N'ECARDINAL@FAMILYDOLLAR.com',N'1087273')
,(N'WILSON, THERESA RUTH',N'TWilson2@FAMILYDOLLAR.com',N'155008')
,(N'CAIN, JAMES H',N'JCAIN@FAMILYDOLLAR.com',N'178724')
,(N'GRIFFIN JR, PHILIP R',N'PGRIFFINJR@FAMILYDOLLAR.com',N'202567')
,(N'REYNAGA, JOSE L',N'JREYNAGA@FAMILYDOLLAR.com',N'227719')
,(N'GOMEZ, LIONEL N',N'LGOMEZ@FAMILYDOLLAR.com',N'25036')
,(N'BARATTA, LUCY M',N'LBaratta@FAMILYDOLLAR.com',N'26249')
,(N'HAYES, BRENDA L',N'BHAYES@FAMILYDOLLAR.com',N'267781')
,(N'BONNECAZE, EARL',N'ebonnecaze@familydollar.com',N'27499')
,(N'PHILLIPS, STEPHEN F',N'SPHILLIPS@FAMILYDOLLAR.com',N'27502')
,(N'WEBSTER, BRENDA K',N'BWEBSTER@FAMILYDOLLAR.com',N'27666')
,(N'MOFFITT, DAVID F',N'DMOFFITT@FAMILYDOLLAR.com',N'27681')
,(N'CLEGG, ALONZO W JR',N'ACLEGG@FAMILYDOLLAR.com',N'27764')
,(N'SMITH, KENNETH T',N'KSMITH@FAMILYDOLLAR.com',N'28369')
,(N'STYRON, DANNY L',N'DStyron@FAMILYDOLLAR.com',N'344044')
,(N'ALLEN, JOSEPH W',N'JAllen@FAMILYDOLLAR.com',N'363800')
,(N'LEHEW, JESSICA L',N'JJones2@FAMILYDOLLAR.com',N'379594')
,(N'GIBLIN, JULIE P',N'JGiblin@FAMILYDOLLAR.com',N'384291')
,(N'REYNOLDS, JOHN',N'JReynolds@FAMILYDOLLAR.com',N'397620')
,(N'YEATTS, RONALD D',N'RYEATTS@FAMILYDOLLAR.com',N'477191')
,(N'NOEL, LAURA C',N'LNoel@familydollar.com',N'502676')
,(N'WOODRING, JEANNE A',N'JWOODRING@FAMILYDOLLAR.com',N'538827')
,(N'WASHINGTON, KEVIN',N'KWASHINGTON2@FAMILYDOLLAR.com',N'541557')
,(N'MALIKOWSKI, TRICIA A',N'TMALIKOWSKI@FAMILYDOLLAR.com',N'588430')
,(N'NAECKER, THERESA',N'Tnaecker@FAMILYDOLLAR.COM',N'600019')
,(N'HINKSTON, VERONICA M',N'VHINKSTON@FAMILYDOLLAR.com',N'610540')
,(N'GREEN, JACINTA D',N'JGREEN@FAMILYDOLLAR.com',N'630952')
,(N'WAGNER, PETER J',N'PWAGNER@FAMILYDOLLAR.com',N'644432')
,(N'BLAIR, MARY A',N'MBLAIR2@FAMILYDOLLAR.com',N'650185')
,(N'PAVICH, MIKE J',N'MPAVICH@FAMILYDOLLAR.com',N'660366')
,(N'MARTIN, RAYMOND R',N'RMARTIN@FAMILYDOLLAR.com',N'678125')
,(N'HOLSINGER, AARON P',N'AHolsinger@FAMILYDOLLAR.com',N'701811')
,(N'MAKEDONSKI, ANDREA S',N'AMAKEDONSKI@FAMILYDOLLAR.com',N'733350')
,(N'STEPP, RICHARD L',N'RSTEPP@FAMILYDOLLAR.com',N'746285')
,(N'MOORE, DAVID RYAN',N'DMOORE@FAMILYDOLLAR.com',N'749522')
,(N'MUSSELWHITE, EMMETT L',N'EMUSSELWHITE@FAMILYDOLLAR.com',N'771267')
,(N'LIVERS, JOHN ARNOLD III',N'JLIVERS@FAMILYDOLLAR.com',N'779228')
,(N'DIAZ, ANTONIO',N'ADIAZ@FAMILYDOLLAR.com',N'780004')
,(N'HEMPEN, MICHAEL BERNARD',N'MHEMPEN@FAMILYDOLLAR.com',N'783824')
,(N'DEMATTEO, RUSSELL A',N'RDEMATTEO@FAMILYDOLLAR.com',N'799883')
,(N'JOHANSSON, KRISTOFER LARS',N'KJohnson2@FAMILYDOLLAR.com',N'800257')
,(N'DELPH, FRANKLIN D JR',N'FDELPH@FAMILYDOLLAR.com',N'802791')
,(N'SOUZA, BARBARA R',N'BSOUZA@FAMILYDOLLAR.com',N'811320')
,(N'WALLACE, MATTHEW J',N'MWALLACE2@FAMILYDOLLAR.com',N'813593')
,(N'WALDRON, JOHN',N'JWaldron@FAMILYDOLLAR.com',N'841670')
,(N'WALCZESKY, SCOTT A',N'SWALCZESKY@FAMILYDOLLAR.com',N'841994')
,(N'HAMILTON, DUSTIN L',N'DHamilton2@FAMILYDOLLAR.com',N'846174')
,(N'MCNEFF, AMBER L',N'AMCNEFF@FAMILYDOLLAR.com',N'850453')
,(N'SUFFLE, BERNADETTE',N'BSUFFLE@FAMILYDOLLAR.com',N'853541')
,(N'SHELTON, TIMOTHY JOEL',N'TSHELTON@FAMILYDOLLAR.com',N'863381')
,(N'RAMOS, JONATHAN',N'JRAMOS2@FAMILYDOLLAR.com',N'894908')
,(N'WILLIS, JEREMY L',N'JWILLIS2@FAMILYDOLLAR.com',N'898936')
,(N'ANELLO, MICHAEL EDWARD',N'MAnello@FAMILYDOLLAR.com',N'922845')
,(N'ROOD, STEVEN',N'SROOD@FAMILYDOLLAR.com',N'932302')
,(N'KYEREMATENG, GIBSON',N'GKYEREMATENG@FAMILYDOLLAR.com',N'933551')
,(N'JUNEAU, TAMMY',N'TJuneau@FAMILYDOLLAR.com',N'9340')
,(N'MOORE, TAMARA',N'TMOORE2@FAMILYDOLLAR.com',N'945688')
,(N'WILSON, JEREMY J',N'JWILSON3@FAMILYDOLLAR.com',N'964520')
,(N'WIGGINS, ROD R',N'RWIGGINS@FAMILYDOLLAR.com',N'97411')
)t ([Employee Full Name],[EMAIL_ADDRESS],[Employee Number]) )t on  a.live=1 and a.username=t.EMAIL_ADDRESS
  and a.[Employee_Number] is null
and a.[Employee_Number]=t.[Employee Number] 
 

 