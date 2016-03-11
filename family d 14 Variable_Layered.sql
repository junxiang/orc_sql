----USE [FamilyDollar]
  
  -
------select    [AGE_GROUP] ;[DATE_NUM] ;[FDO_FISCAL_2015] ;[freq_shop] ;[InterviewLength] ;[MONTHX] ;[MRK_FDO] ;[MRK_SEG1] ;[Q10_GRID_01_Q10] ;[Q100] ;[Q101_GRID_01_Q101] ;[Q101_GRID_02_Q101] ;[Q101_GRID_03_Q101] ;[Q102] ;[Q105] ;[Q106] ;[Q107] ;[Q108] ;[Q109] ;[Q110] ;[Q115_GRID_01_Q115] ;[Q115_GRID_02_Q115] ;[Q116_GRID_01_Q116] ;[Q116_GRID_02_Q116] ;[Q116_GRID_03_Q116] ;[Q117_GRID_01_Q117] ;[Q117_GRID_02_Q117] ;[Q117_GRID_03_Q117] ;[Q117_GRID_04_Q117] ;[Q117_GRID_05_Q117] ;[Q117_GRID_06_Q117] ;[Q117_GRID_07_Q117] ;[Q118] ;[Q12A] ;[Q12C] ;[Q12D] ;[Q13] ;[Q1401] ;[Q1402] ;[Q1403] ;[Q1404] ;[Q1405] ;[Q1406] ;[Q1407] ;[Q15] ;[Q16] ;[Q2_1] ;[Q3] ;[Q4_GRID_0_Q4] ;[Q5_GRID_01_Q5] ;[Q5_GRID_02_Q5] ;[Q5_GRID_03_Q5] ;[Q6] ;[Q63] ;[Q64] ;[Q7_GRID_01_Q7] ;[Q7_GRID_02_Q7] ;[Q7_GRID_03_Q7] ;[Q7_GRID_04_Q7] ;[Q7_GRID_05_Q7] ;[Q72_A01] ;[Q72_A02] ;[Q72_A03] ;[Q72_A04] ;[Q72_A05] ;[Q72_A06] ;[Q72_A07] ;[Q72_A08] ;[Q72_A09] ;[Q72_A10] ;[Q72_A11] ;[Q72_GRID_01_Q72A_GRID_1_0_Q72A] ;[Q72_GRID_02_Q72A_GRID_1_0_Q72A] ;[Q72_GRID_03_Q72A_GRID_1_0_Q72A] ;[Q72_GRID_04_Q72A_GRID_1_0_Q72A] ;[Q72_GRID_05_Q72A_GRID_1_0_Q72A] ;[Q72_GRID_06_Q72A_GRID_1_0_Q72A] ;[Q72_GRID_07_Q72A_GRID_1_0_Q72A] ;[Q72_GRID_08_Q72A_GRID_1_0_Q72A] ;[Q72_GRID_09_Q72A_GRID_1_0_Q72A] ;[Q72_GRID_10_Q72A_GRID_1_0_Q72A] ;[Q72_GRID_11_Q72A_GRID_1_0_Q72A] ;[Q72_GRID_12_Q72A_GRID_1_0_Q72A] ;[Q72_GRID_13_Q72A_GRID_1_0_Q72A] ;[Q7201] ;[Q7202] ;[Q7203] ;[Q7204] ;[Q7205] ;[Q7206] ;[Q7207] ;[Q7208] ;[Q7209] ;[Q7210] ;[Q7211] ;[Q7212] ;[Q7213] ;[Q8_GRID_01_Q8] ;[Q8_GRID_02_Q8] ;[Q8_GRID_03_Q8] ;[Q8_GRID_04_Q8] ;[Q9_GRID_01_Q9] ;[Q91A_GRID_01_Q91A] ;[Q91A_GRID_02_Q91A] ;[Q91A_GRID_03_Q91A] ;[Q91A_GRID_04_Q91A] ;[Q91A_GRID_05_Q91A] ;[Q91B_GRID_06_Q91B] ;[Q91B_GRID_07_Q91B] ;[Q91B_GRID_08_Q91B] ;[Q91B_GRID_10_Q91B] ;[Q91B_GRID_11_Q91B] ;[Q91C_GRID_09_Q91C] ;[Q91C_GRID_12_Q91C] ;[Q91C_GRID_13_Q91C] ;[Q91C_GRID_14_Q91C] ;[Q91D_GRID_15_Q91D] ;[Q92] ;[Q93] ;[QCB3] ;[QCB4] ;[qStoreN] ;[QUARTER_NEW] ;[RACE_ETH] ;[RECEIPTNUM] ;[Respondent_ID] ;[vDistrict] ;[vGroup] ;[vRegion] ;[weight] ;[YEAR_NEW] 

------ -
------ --exec sp_rename '[Sheet1$Victor].qStoreN','Store','column';
 
------select max(len(Q6)) --distinct  Q6,len(Q6),year_new 
------from [dbo].[tb_RawData]
 
------ select   count(*),count(distinct store),count(distinct Loc) from   [dbo].[Clusters]  

 
------select count(*),count(distinct store) 
------  from  [dbo].[Hierarchy] 
 
  
------select * from [v_RawData_Hierarchy_SCSF]
------select * from [v_RawData_Hierarchy_SF]
------select * from [dbo].[v_RawData_Hierarchy_SC]


------select * from V_KPI

------select a.L3,a.[Variable Name],a.TopNbox,a.Score,b.Value,b.max_value_valid,b.min_value_valid
------ from [dbo].[Questionnaire3] a inner join [dbo].[Variable_Values] b 
------on a.[Variable Name]=b.Variable  where trend=1
------order by a.L3,a.[Variable Name],b.Value

------select top 10 * from [Variable_Values] where variable='Q12D'

------select * from [v_dashboard_scoring_trending_CASH_var]

------exec p_get_DashBoard_test 3,9,'',30,6,91,2280

------exec p_get_DashBoard 3,9,'',-1,-1,-1,-1

------select distinct topNbox from [dbo].[Questionnaire3]
------select top 3 * from [dbo].[Questionnaire3]
------select top 3 * from [dbo].[Variable_Values]
------select  top 3  * from [dbo].[Variables]

--------alter table [dbo].[Variables] add [max_value] int,[min_value] int,[max_value_valid] int,[min_value_valid] int

--------;with c as(  select Variable,max(Value) mx,min(Value) mn from [dbo].[Variable_Values] group by Variable)

-------- update a
-------- set  max_value=mx,min_value=mn
-------- from   [dbo].[Variables]  a inner join c on a.variable=c.variable

--------  ;with c as(  select Variable,max(Value) mx,min(Value) mn from [dbo].[Variable_Values] where Value<90 and Variable like 'Q%'
--------  group by Variable) 
-------- update a
-------- set  max_value_valid=mx,min_value_valid=mn
-------- from   [dbo].[Variables]  a inner join c on a.variable=c.variable
--------alter table [Goals] add PID int not null identity(1,1) primary key ;

------select * from  [dbo].[Headline_Variable]  a  inner join  [dbo].[Questionnaire3] b
------on a.variable=[variable name]

------select * from  [dbo].[Headline_Variable]  a  inner join  [dbo].[Variable_Values]  b
------on a.variable=b.[variable]


------select * from  [dbo].[Headline_Variable]  a  inner join  [dbo].[Variables]  b
------on a.variable=b.[variable]

------select [Values],left([Value label],2) [Quarter],right(left([Value label],9),4) [Year] from [dbo].[Filters] where Variable='QUARTER_NEW'


------select * from [dbo].[Variables]

--------alter table [dbo].[KPICalcs3] add id int not null identity primary key
--------create index ix_nc_KPICalcs3_KPI on KPICalcs3(kpi)
--------create index ix_nc_KPICalcs3_var on KPICalcs3(Variable) include([weight])
 

------ select top 1  * from [dbo].[Questionnaire3]  

------ select top 1 * from [dbo].[KPICalcs3]

------  select * from [dbo].[Goals] 
  
  
------  select * from [dbo].[Hierarchy]


------  select distinct year_new,DATE_NUM from [dbo].[v_RawData_Hierarchy]


------    select concat(',[Scale', number,']')+char(10)
------ from master.dbo.spt_values
------  where number between 1 and 9 and type='p' for xml path('')

--------  Alter table [dbo].[Questionnaire3]  add Mid3Box nvarchar(50),Bot2Box nvarchar(50)
----------sp_rename '[dbo].[Questionnaire3].Bot3Box','Bot2Box','Column'
--------update  a 
--------set  Mid3Box ='3,4,5',Bot2Box='1,2'
--------from  [dbo].[Questionnaire3] a 
--------where trend=1 and topNbox='6,7'
--------update  a 
--------set  Mid3Box ='3',Bot2Box='2'
-----------select * 
--------from  [dbo].[Questionnaire3] a 
--------where trend=1 and topNbox='1' and id not in(60,61)

--------update  a 
--------set  Mid3Box ='-1',Bot2Box='2'
-----------select * 
--------from  [dbo].[Questionnaire3] a 
--------where trend=1 and topNbox='1' and id   in(60,61)

------select * from [dbo].[Questionnaire3] where trend=1 and TopNbox='6,7'

 
--------create index ix_nc_Trend_Scale_Breakdown on   Trend_Scale_Breakdown( [Scale])
------ -- select  'Positive' as Scale into   Trend_Scale_Breakdown
------ --union all select 'Neutral'
------ --union all select 'Negative'
------ --union all select null
 
------  select  * from Trend_Scale_Breakdown

------  --alter table     Trend_Scale_Breakdown add ID int not null identity(1,1) primary key

------ --- truncate table      Trend_Scale_Breakdown

------ --insert into     Trend_Scale_Breakdown
------ --select 'Negative'

------select * from [dbo].[KPICalcs3]

--------create index ix_nc_KPICalcs3_L2 on [dbo].[KPICalcs3](L2)



------ -- update a 
------ -- set [Group]=b.[Group],
------ --     [Region]=b.region,
------	--  district=b.district
------ -------select  b.* 
------ -- from [dbo].[v_RawData_Hierarchy]  a inner  join [dbo].[Hierarchy] b 
------ -- on a.store=b.store 
------ -- where a.[Group] is null  


------  sp_helptext '[dbo].[v_RawData_Hierarchy]'

------   select  [Q2_1] as Store,*   from [dbo].[tb_RawData](nolock) where  year_new =2 and [Q2_1] is null



------   select a.year_new, a.[group],b.[vGroup]
------  from  [dbo].[tb_RawData]  a   inner  join [dbo].[Sheet1$Victor20150225]  b
------   on a.q2_1=b.q2_1 and a.quarter_new=b.Quarter_new and a.year_new=b.Year_new
------  where  a.YEAR_NEW= 2   and b.vGroup is null


------  select * from [dbo].[Hierarchy] where store in(1740,2083)

--------  sp_rename '[dbo].[tb_RawData].[VGroup]',N'[Group]',N'COLUMN';
--------sp_rename '[dbo].[tb_RawData].VRegion','Region','column';
--------sp_rename '[dbo].[tb_RawData].VDistrict','District','column';
 
------select count(*) from [tb_rawdata]  where [Group] is null and year_new =2 

------sp_helptext '[dbo].[v_RawData_Hierarchy]'

 

   
------  select top 2 * from [KPICalcs3]
------  select top 2 * from Variables
------  select * from [dbo].[tb_Userlist]

------  [dbo].[p_get_DashBoard_test] 2,7,'  ',-1,-1,-1,-1

------      ---[dbo].[p_get_DashBoard_test] 2,7,' and ( AGE_GROUP=1 or AGE_GROUP=2 or AGE_GROUP=3 or AGE_GROUP=4 or AGE_GROUP=5 ) and ( freq_shop=1 or freq_shop=2 or freq_shop=3 ) and ( Q63=1 or Q63=2 ) and ( Q64=1 or Q64=2 or Q64=3 or Q64=4 or Q64=5 ) and ( RACE_ETH=1 or RACE_ETH=2 or RACE_ETH=3 or RACE_ETH=4 ) and ( Q72_A11=1 or Q72_A10=1 or Q72_A09=1 or Q72_A08=1 or Q72_A07=1 or Q72_A06=1 or Q72_A05=1 or Q72_A04=1 or Q72_A03=1 or Q72_A02=1 or Q72_A01=1 ) and ( STOREFORMAT=1 or STOREFORMAT=2 or STOREFORMAT=3 or STOREFORMAT=4 or STOREFORMAT=5 ) and ( CLUSTER_UPDATED=1 or CLUSTER_UPDATED=2 or CLUSTER_UPDATED=3 or CLUSTER_UPDATED=4 or CLUSTER_UPDATED=5 ) ',10,-1,-1,-1
------	 exec  [dbo].[p_get_DashBoard_TrackedKPI_test] 2,9,'SERVICE','',null,null,null,null
------	 exec   [dbo].[p_get_DashBoard_TrackedKPI] 2,9,'SERVICE','',null,null,null,null

------	 select *   from [dbo].[KPICalcs3] a inner join variable_values b on a.Variable=b.Variable
------	 where topnbox ='1'

------	 select  top 1 kpi,L2 from [dbo].[KPICalcs3] where kpi='SERVICE'
------ [p_get_KpiBreakdown] 3,9,'Customer CASH Score','',10 ,-1 ,-1 ,-1

------ [p_get_KpiBreakdown] 2,7,'Customer CASH Score','and ( AGE_GROUP=1 or AGE_GROUP=2 or AGE_GROUP=3 or AGE_GROUP=4 or AGE_GROUP=5 ) and ( freq_shop=1 or freq_shop=2 or freq_shop=3 ) and ( Q63=1 or Q63=2 ) and ( Q64=1 or Q64=2 or Q64=3 or Q64=4 or Q64=5 ) and ( RACE_ETH=1 or RACE_ETH=2 or RACE_ETH=3 or RACE_ETH=4 ) and ( Q72_A11=1 or Q72_A10=1 or Q72_A09=1 or Q72_A08=1 or Q72_A07=1 or Q72_A06=1 or Q72_A05=1 or Q72_A04=1 or Q72_A03=1 or Q72_A02=1 or Q72_A01=1 ) and ( STOREFORMAT=1 or STOREFORMAT=2 or STOREFORMAT=3 or STOREFORMAT=4 or STOREFORMAT=5 ) and ( CLUSTER_UPDATED=1 or CLUSTER_UPDATED=2 or CLUSTER_UPDATED=3 or CLUSTER_UPDATED=4 or CLUSTER_UPDATED=5 )',10 ,-1 ,-1 ,-1

 
------select  
------		case when [Goal LEvel]='Group' then ID end as  [Group] ,
------		case when [Goal LEvel]='Region' then ID end as  Region,
------		case when [Goal LEvel]='District' then ID end as  District,
------		case when [Goal LEvel]='Overall' then ID end as  [Overall],[CASH Survey] cs 
------ from [dbo].[Goals]


------ sp_helptext '[dbo].[p_get_KpiBreakdown_next]'
  

 

------sp_help'sp_MSforeachtable'


------select  [definition] from  sys.all_sql_modules where object_id=object_id('[dbo].[sp_MSforeachtable]')



------exec [p_get_KpiBreakdown_test] 3,9,'Customer CASH Score','',10 ,8 ,-1 ,-1
------exec [p_get_KpiBreakdown] 3,9,'Customer CASH Score','',10 ,8 ,-1 ,-1


------exec [p_get_KpiBreakdown_test] 3,9,'Customer CASH Score','',10 ,-1 ,-1 ,-1
------exec [p_get_KpiBreakdown] 3,9,'Customer CASH Score','',10 ,-1 ,-1 ,-1

------SP_NChelpindex ''

--------select * into [dbo].[tb_RawData_20150311BAK] from [dbo].[tb_RawData]


---------alter table [dbo].[tb_RawData] alter column Q6  text  --nvarchar(max)

------  select count(*) from [dbo].[Sheet1$Victor20150225]
------  --- [dbo].[Sheet1$Victor20150225BAK] 
------   where race_eth is null


------   select count (*) ,min(id)  from [dbo].[tb_RawData] where quarter_new =10
   
------   select count (*) ,min(id),max(id)  from   [dbo].[tb_RawData_20150311BAK]
------   --alter table [dbo].[Variables] drop constraint [pk_Variable_Position]

------   --drop index [dbo].[Variables].[ix_nc_Variables]
------   --alter table [dbo].[Variables] alter column Position int not null
------   -- alter table [dbo].[Variables] add constraint [pk_Variable_Position] primary key(position)

------select count(*)
------ ---top 10 
------   --   a.  [Group],b.[Group],
------   --   a.[Region],b.region,
------	  --a.district,b.district 
------  from tb_rawdata  a  left  join [dbo].[Hierarchy] b 
------  on a.[q2_1]=b.store 
------  where a.quarter_new =10  and a.[group] is null


------  select top 1 *  from [dbo].[Variable_Values]
 

------ select sum(weight) from tb_rawdata where quarter_new =10 

------ select * from    [dbo].[v_dashboard_scoring_trending_CASH_var]


------ [dbo].[p_get_DashBoard_test] 3,9,'  ',10,40,300,6199

------  [dbo].[p_get_DashBoard_test] 3,9,'  ',60,33,414,7777

------ select distinct [weight],[Q12A],[Q12c] ,[Q9_GRID_01_Q9]	from  [V_RawData_Hierarchy]   where YEAR_NEW= 3  	 and Store=6199  

------ select sum([weight]),count(*)	from  [V_RawData_Hierarchy]   where YEAR_NEW= 3 and quarter_new=9	 and Store=6199  and [Q12A] in(1)
------  select sum([weight]),count(*)	from  [V_RawData_Hierarchy]   where YEAR_NEW= 3   and quarter_new=9	 and Store=6199  and [Q12A] between 0 and 7

  
------  select * from  [Headline_Variable]
    


------	 ,max_value_valid,min_value_valid
------	 ,max_value_valid,min_value_valid

------	 select distinct  [weight] ,[Q7_GRID_02_Q7]  from  [dbo].[V_RawData_Hierarchy] where  year_new=3 and quarter_new=9 

------	   select * from   [dbo].[KPICalcs3] where Variable='Q7_GRID_02_Q7' 
------	 --  select 1855/2172.0
------	   select 1854/2170.0
------	   select sum([weight]),sum(case when [Q7_GRID_02_Q7] in(6,7) then [weight] end) from  [dbo].[tb_rawdata2015q1$Victor] where  year_new=3 and quarter_new=9 and [Q7_GRID_02_Q7] between 1 and 7

------	    select count([weight])  from  [dbo].[tb_rawdata2015q1$Victor] where  year_new=3 and quarter_new=9 and [Q7_GRID_02_Q7] between 1 and 7  and [group] is not null
------		 select count([weight])  from  [dbo].[tb_rawdata2015q1$Victor] where  year_new=3 and quarter_new=9 and[Q7_GRID_02_Q7] in(6,7)  and [group] is not null
------		  select sum([Q7_GRID_02_Q7])  from  [dbo].[tb_rawdata2015q1$Victor] where  year_new=3 and quarter_new=9  and [group] is not null
	     
 
 

------ select count(*)
------ --distinct a.q2_1,a. [Group], a. [Region], a. district,b.[Group],
------ --   b.region,
------	--b.district 
------  from tb_rawdata  a  left  join [dbo].[Hierarchy] b 
------  on a.[q2_1]=b.store 
------  where a.quarter_new =9  and a.[group] is null

------ --- select * into tb_rawdata_20150313BAK from tb_rawdata  
------ -- select * into [dbo].[Hierarchy_20150313BAK] from [dbo].[Hierarchy]

------ select sum(store),sum(district),sum(region),sum([group]) from [dbo].[Store Information$Victor]


------ select top 1 * from [dbo].[tb_rawdata2015q1$Victor] where    [group] is   null

------ select ' ,'+ quotename(name)+'=case when '+ quotename(name)+'=''#NULL!'' then null else  '+ quotename(name)+' end '+char(10)
------  from  sys.columns where object_id =object_id('[dbo].[tb_rawdata2015q1$Victor]')

------   select 'alter table  [dbo].[tb_rawdata2015q1$Victor] alter column '+Variable+'  int '+char(10) from (
------ select distinct quoteName(Variable) variable from  [dbo].[Variable_Values])t for xml path('')


------  select  'select '+( select ',sum('+ Variable +' ) as '+Variable  from (
------ select distinct quoteName(Variable) variable from  [dbo].[Variable_Values])t for xml path('') ) +'
------  from  [dbo].[tb_rawdata2015q1$Victor]'

   
------   select  kpi, Variable,TopNbox,min_value_valid,max_value_valid  from [dbo].[KPICalcs3]

------ sp_recompile '[v_RawData_Hierarchy]'

------  sp_refreshview '[v_RawData_Hierarchy]'
------select * from KPICalcs3
------ select * from [dbo].[Variables] 
------ select * from [dbo].[Trend_Scale_Breakdown]
------ select [L3],[Variable Name],TopNbox,Mid3Box,Bot2Box,Score ,b.max_value_valid,b.Min_value_valid,b.max_value,b.min_value
------ from [dbo].[Questionnaire3] a inner join [dbo].[Variables] b on a.[Variable Name] =b.Variable
------ where trend=1 and TopNbox='1'

------ select [L3],[Variable Name],TopNbox,Mid3Box,Bot2Box,Score 
------ from [dbo].[Questionnaire3] 
------ where trend=1 and TopNbox='1'


 
------ select Variable,max(Value) mx,min(Value) mn from [dbo].[Variable_Values] 
------ where Value<90    and Variable like 'Q%'
------ group by Variable


------ select top 2 * from [dbo].[StoreFormat]

------ select[Definition] ,object_name([Object_id]) from sys.all_sql_modules
------  where [Definition] like '%%'

------  sp_help'[dbo].[p_get_DashBoard_TrackedKPI]'
------    sp_helptext'[dbo].[p_get_DashBoard_TrackedKPI]'

 

------select * from V_kpi

------ select quotename(kpi,'''') from V_kpi

------  sp_help'[dbo].[CLUSTER_UPDATED_SCALE]'
------    sp_helptext'[dbo].[p_get_Trend]'


------	sp_MSforeachtable'select  ''?'' [Table], Name [Column],type_name(user_type_id) [Type],case when type_name(user_type_id) like ''n%'' then max_length/2 else max_length end Length 
------	from sys.all_columns where object_id=object_id(''?'',N''V'')   '


------	select  object_name(object_id) [Table], Name [Column],type_name(user_type_id) [Type],case when type_name(user_type_id) like 'n%' then max_length/2 else max_length end [Length] 
------	from sys.all_columns where object_id=object_id('Variables',N'U') 


------select  object_name(object_id) [Table], Name [Column],type_name(user_type_id) [Type],case when type_name(user_type_id) like 'n%' then max_length/2 else max_length end [Length] 
------	from sys.all_columns where object_id=object_id('V_KPI',N'V') 
 


------  SELECT cacheobjtype,objtype,usecounts,sql FROM sys.syscacheobjects
------WHERE sql LIKE '%Users%' and sql not like '%syscacheobjects%'
 


------   select    Variable,TopNbox,max_value_valid,min_value_valid  from [dbo].[KPICalcs3] 
------ where kpi='Customer CASH Score'

------ select distinct Store,StoreFormatMappedResponse,StoreFormatMappedLabel from [dbo].[Store Information$Victor] a where exists(select * from [dbo].[StoreFormat] where store=a.Store)


------  select count(*) from [dbo].[Store Information$Victor] a where exists(select * from [dbo].[StoreFormat] where store=a.Store) --8106
------  select count(*) from [dbo].[Store Information$Victor] a where not exists(select * from [dbo].[StoreFormat] where store=a.Store) --85
------  select count(*) from [dbo].[StoreFormat] --8126
  

------  select count(*) from   [dbo].[StoreFormat]
------  --insert into [storeFormat](Store,[Store Format],StoreFormat_LAbel,StoreFormat)
------  --select  Store,[Store Format],StoreFormatMappedLabel,StoreFormatMappedResponse 
------  --from [dbo].[Store Information$Victor] a where not exists(select * from [dbo].[StoreFormat] where store=a.Store  ) 

--------select  a.store, 
--------update a 
--------set [Store Format]=b.[Store Format],
--------		StoreFormat_LAbel=b.StoreFormatMappedLabel,
--------		StoreFormat=b.StoreFormatMappedResponse
--------from   [dbo].[StoreFormat] a inner  join [dbo].[Store Information$Victor] b
--------on a.Store=b.Store
--------where b.StoreFormatMappedLabel is not  null


------select  a.store, a.[Store Format],b.[Store Format],
------		a.StoreFormat_LAbel,b.StoreFormatMappedLabel,
------		a.StoreFormat,b.StoreFormatMappedResponse
------from   [dbo].[StoreFormat] a inner  join [dbo].[Store Information$Victor] b
------on a.Store=b.Store
------where b.StoreFormatMappedLabel is    null

------select * from [dbo].[StoreFormat] where [Store Format] is null



------with a as (
------ select   Store,StoreFormatMappedResponse from [dbo].[Store Information$Victor] 
------ group by Store,StoreFormatMappedResponse)
------ select store ,count(*) from a
------ group by store having count(*)<=1
 
 
-----------delete    a 
------select * 
------from [dbo].[StoreFormat] a where not exists(select * from [dbo].[Store Information$Victor] where store=a.Store and a.[STOREFORMAT]=StoreFormatMappedResponse)---
------ and exists (select * from tb_rawdata where q2_1=a.store)
   
------ select [L3],[Variable Name],TopNbox,Mid3Box,Bot2Box,Score ,b.max_value_valid,b.Min_value_valid,b.max_value,b.min_value 
------ from [dbo].[Questionnaire3] a inner join [dbo].[Variables] b on a.[Variable Name] =b.Variable 
------ where trend=1 and TopNbox='1'

------ select [L3],[Variable Name],TopNbox,Mid3Box,Bot2Box,Score ,b.max_value_valid,b.Min_value_valid,b.max_value,b.min_value,c.*
------ from [dbo].[Questionnaire3] a inner join [dbo].[Variables] b on a.[Variable Name] =b.Variable
------ inner join [dbo].[Variable_Values] c  on a.[Variable Name] =c.Variable
------ where trend=1 and TopNbox='1'

  
--------------update a
--------------set mid3box='-98' ,max_value_valid=case when a.max_value=3 then 2 else a.max_value_valid end
-------------- from [dbo].[Questionnaire3] a inner join [dbo].[Variables] b on a.[Variable Name] =b.Variable
-------------- where trend=1 and TopNbox='1'

--------------update b
--------------set     max_value_valid=case when b.max_value=3 then 2 else b.max_value_valid end
-------------- from [dbo].[Questionnaire3] a inner join [dbo].[Variables] b on a.[Variable Name] =b.Variable
-------------- where trend=1 and TopNbox='1'


------ select b.value,b.Value_label,a.Variable,a.max_value_valid,a.Min_value_valid,a.max_value,a.min_value
------ from [dbo].[Variables] a inner join   [dbo].[Variable_Values] b
------ on a.Variable=b.Variable

------ select top 2 * from [dbo].[KPICalcs3]

------ ------;with c as(  select Variable,max(Value) mx,min(Value) mn from [dbo].[Variable_Values] 
------	------	where Value<90   --and Variable like 'Q%'
------	------	and not (Value_label   like '%Don''t Know%' or   Value_label like '%Did not%')
------ ------ group by Variable) 
------ ------update a
------ ------set  max_value_valid=mx,min_value_valid=mn
------ ------from  [dbo].[KPICalcs3] a inner join c on a.variable=c.variable 


 

------ select * from [dbo].[KPICalcs3] a inner join [dbo].[Questionnaire3] b
------ on a.variable=b.[variable name]
------ where a.topNbox='1'


------  select *
------  from [dbo].[Variable_Values] 
------		where Value<90   --and Variable like 'Q%'
------		and  (Value_label   like '%Don''t Know%' or   Value_label like '%Did not%')
 
------------update a 
------------set [Mid3Box]=b.[Mid3Box],[Bot2Box]=b.[Bot2Box]
--------------select a.*
------------from [KPICalcs3] a inner join [dbo].[Questionnaire3] b
------------on a.variable=b.[variable name]
 
------select *   from [dbo].[Headline_Variable]

------select * from [v_dashboard_scoring_trending_CASH_var]

------      [dbo].[p_get_DashBoard] 3,9,'  ',10,14,130,-1

------	  [dbo].p_get_DashBoard_20150318BAK 3,9,'  ',10,14,130,-1


------	--- select * into  [dbo].[Questionnaire3_20150318BAK] from   [dbo].[Questionnaire3] where trend='1'

 
------ ------------with c as (select row_number() over(partition by L3 order by (select null)) as num,* from  [dbo].[Questionnaire3] where trend='1')
------------------update c
------------------set QuestionOrder=c.num
------ select * from   [dbo].[Questionnaire3] where trend is not null



------ select * from [dbo].[Questionnaire3] where  L3='C.A.S.H. STORE STANDARDS'
------and [Variable Name] is   null
 


------------update  [dbo].[Questionnaire3]
------------set [kpi breakdown]=null
------------ where  L3='C.A.S.H. STORE STANDARDS'
------------and [Variable Name] is   null
 

------ ------20150320
------select distinct quarter_new,year_new from tb_rawdata 

------ select  count(*) from  [dbo].[Variable$Victor]
------  select count(*) from  [dbo].[Variables]
------  select   * from [dbo].[Variable_Values]
 
------  select * from [dbo].[Variable_Values$Victor] where Variable like 'Q14__'
------   select  * from  [dbo].[Variable$Victor]  where Variable like 'Q14__'

------   ------update  [dbo].[Variable$Victor]  set Variable=concat(left(variable,3),0,right(Variable,1))  where Variable like 'Q14_'
------   ------update  [dbo].[Variable_Values$Victor]  set Variable=concat(left(variable,3),0,right(Variable,1))  where Variable like 'Q14_'


------ --------insert into [dbo].[Variable_Values](Variable,Value,Value_label)
------ --------select a.Variable,a.Value,a.Value_label
------ --------from [dbo].[Variable_Values$Victor] a full  join   [dbo].[Variable_Values] b
------ --------on a.Variable=b.Variable and a.value=b.Value
------ --------where b.variable is null
 
------  select ','+ quotename(name) from sys.columns where object_id=object_id('Data$Victor') for xml path('')
------  select ','+ quotename(name)+'=case when '+ quotename(name)+'=''#NULL!'' then null else '+ quotename(name)+' end'+char(10)
------   from sys.columns where object_id=object_id('Data_2014Q23$Victor') for xml path('')

------select  concat('exec sp_rename ''[Data$Victor].Q14',number,''',''Q140',number,''',''COLUMN'' ' ) from master.dbo.spt_values where number<=7 and number>=1 and type='P'

------  select concat('alter table [dbo].[Data$Victor]  alter column '+ quotename(name)+' '+type_name(user_type_id), 
------  case when type_name(user_type_id) like 'nvarchar' then '('+ case when max_length<0 then 'max' else cast(max_length/2 as varchar) end+')' else '' end )
------   from sys.columns where object_id=object_id('[dbo].[tb_RawData]') 

------select ' , alter table  [dbo].[Data$Victor] alter column '+b.n+' int'
------from (
------select   quotename(name) n
------ from sys.columns where object_id=object_id('[dbo].[tb_RawData]') ) a
------ right join  (  select   quotename(name) n from sys.columns where object_id=object_id('[dbo].[Data$Victor]') 
------ ) b on a.n=b.n where a.n is null

------select distinct quarter_new,year_new --count(*) 
------from [dbo].[Data$Victor] 
------select distinct quarter_new,year_new --count(*) 
------from [Data_2014Q23$Victor]  
------select -- distinct
------quarter_new,
--------year_new ,
------count(*) 
------from [Data_2014Q23$Victor] 
------group by quarter_new


------select -- distinct
------quarter_new,
--------year_new ,
------count(*) 
------from  [dbo].[tb_RawData]
------group by quarter_new

---------delete [dbo].[tb_RawData] where (quarter_new=10 and year_new=3) or (quarter_new in(6,7) and year_new=2)

------select  ','+ quotename(name) from sys.columns where object_id=object_id('Data_2014Q23$Victor') for xml path('')

------  ------------insert into [dbo].[Variables] ( [Variable],[Position],[Label],[Measurement Level],[Role],[Column Width],[Alignment],[Print Format],[Write Format])
------  ------------select  a.[Variable],a.[Position],a.[Label],a.[Measurement Level],a.[Role],a.[Column Width],a.[Alignment],a.[Print Format],a.[Write Format]
------  ------------ from  [dbo].[Variable$Victor] a full join  [dbo].[Variables] b
------  ------------on a. Variable=b.Variable 
------  ------------where b.variable is null  ;


------select *   from [dbo].[Variables] 
------select *    from  [dbo].[Variable_Values] where Value not in(98,97)


------  update a 
------  set [max_value]=b.[max_value],[min_value]=b.[min_value]
------  from [dbo].[Variables] a inner join (
------  select  Variable,max(value) [max_value],min(value) [min_value] 
------      from  [dbo].[Variable_Values]
------	    group by Variable)  b
------		on a.Variable=b.Variable

------  update a 
------  set [max_value]=b.[max_value_valid],[min_value]=b.[min_value_valid]
------  from [dbo].[Variables] a inner join (
------  select  Variable,max(value) [max_value_valid],min(value) [min_value_valid] 
------      from  [dbo].[Variable_Values] where valid=1
------	    group by Variable)  b
------		on a.Variable=b.Variable
------		and a.position>=131


----------select    a.*
----------from  [dbo].[Variable_Values]  a inner join (
----------  select  Variable,max(value) [max_value],min(value) [min_value] 
----------      from  [dbo].[Variable_Values] a where exists(select * from [Variables] where /*position>=131 and*/ variable=a.variable)
----------	    group by Variable ) b on a.variable=b.variable and a.value=b.max_value
----------		where a.value_label not like '%Don_t know%' and  a.value_label not like  '%Did not come in contact with an employee%'
----------		and a.value<90


------select    a.*
------from  [dbo].[Variable_Values]  a inner join (
------  select  Variable,max(value) [max_value],min(value) [min_value] 
------      from  [dbo].[Variable_Values] a where exists(select * from [Variables] where /*position>=131 and*/ variable=a.variable)
------	    group by Variable ) b on a.variable=b.variable and a.value=b.max_value
------		where not(a.value_label not like '%Don_t know%' 
------		and  a.value_label not like  '%Did not come in contact with an employee%'
------	    and  a.value_label not like  '%Did not shop in the cooler section%' 		 
------		and a.value<90)

---------alter table [dbo].[Variable_Values] add valid int not null default(1)
 
------update a 
------set a.valid=0
------from  [dbo].[Variable_Values]  a inner join (
------  select  Variable,max(value) [max_value],min(value) [min_value] 
------      from  [dbo].[Variable_Values] a where exists(select * from [Variables] where /*position>=131 and*/ variable=a.variable)
------	    group by Variable ) b on a.variable=b.variable and a.value=b.max_value
------		where not(a.value_label not like '%Don_t know%' 
------		and  a.value_label not like  '%Did not come in contact with an employee%'
------	    and  a.value_label not like  '%Did not shop in the cooler section%' 		 
------		and a.value<90)


----------select * into [dbo].[tb_RawData_20150320BAK] from [dbo].[tb_RawData]
------alter index [ix_c_Variable_Values] on [dbo].[Variable_Values] rebuild
------alter index [pk_Variable_Position] on [dbo].[Variables] rebuild
------alter index [ix_nc_Variables] on [dbo].[Variables] rebuild

------select  sum([weight]) from [dbo].[Data$Victor]  
 


------select year_new, sum([weight]) from [dbo].[tb_RawData] where quarter_new!=9
------group by  year_new ;

------select  ',count('+ quotename(name)+') as '+ quotename(name) from sys.columns where object_id=object_id('[tb_RawData]') for xml path('')
------select  ',sum('+ quotename(name)+') as '+ quotename(name) from (select distinct variable name from  [Variable_Values]) t for xml path('')

------select year_new,count(*),
------ count([Respondent_ID]) as [Respondent_ID],count([Q2_1]) as [Q2_1],count([Q3]) as [Q3],count([AGE_GROUP]) as [AGE_GROUP],count([RACE_ETH]) as [RACE_ETH],count([Q13]) as [Q13],count([freq_shop]) as [freq_shop],count([Q1401]) as [Q1401],count([Q1402]) as [Q1402],count([Q1403]) as [Q1403],count([Q1404]) as [Q1404],count([Q1405]) as [Q1405],count([Q1406]) as [Q1406],count([Q1407]) as [Q1407],count([Q7201]) as [Q7201],count([Q7202]) as [Q7202],count([Q7203]) as [Q7203],count([Q7204]) as [Q7204],count([Q7205]) as [Q7205],count([Q7206]) as [Q7206],count([Q7207]) as [Q7207],count([Q7208]) as [Q7208],count([Q7209]) as [Q7209],count([Q7210]) as [Q7210],count([Q7211]) as [Q7211],count([Q7212]) as [Q7212],count([Q7213]) as [Q7213],count([Q15]) as [Q15],count([Q16]) as [Q16],count([Q63]) as [Q63],count([Q64]) as [Q64],count([QCB3]) as [QCB3],count([QCB4]) as [QCB4],count([Q72_A01]) as [Q72_A01],count([Q72_A02]) as [Q72_A02],count([Q72_A03]) as [Q72_A03],count([Q72_A04]) as [Q72_A04],count([Q72_A05]) as [Q72_A05],count([Q72_A06]) as [Q72_A06],count([Q72_A07]) as [Q72_A07],count([Q72_A08]) as [Q72_A08],count([Q72_A09]) as [Q72_A09],count([Q72_A10]) as [Q72_A10],count([Q72_A11]) as [Q72_A11],count([MRK_FDO]) as [MRK_FDO],count([Q4_GRID_0_Q4]) as [Q4_GRID_0_Q4],count([Q5_GRID_01_Q5]) as [Q5_GRID_01_Q5],count([Q5_GRID_02_Q5]) as [Q5_GRID_02_Q5],count([Q5_GRID_03_Q5]) as [Q5_GRID_03_Q5],count([Q7_GRID_01_Q7]) as [Q7_GRID_01_Q7],count([Q7_GRID_02_Q7]) as [Q7_GRID_02_Q7],count([Q7_GRID_03_Q7]) as [Q7_GRID_03_Q7],count([Q7_GRID_04_Q7]) as [Q7_GRID_04_Q7],count([Q7_GRID_05_Q7]) as [Q7_GRID_05_Q7],count([Q8_GRID_01_Q8]) as [Q8_GRID_01_Q8],count([Q8_GRID_02_Q8]) as [Q8_GRID_02_Q8],count([Q8_GRID_03_Q8]) as [Q8_GRID_03_Q8],count([Q8_GRID_04_Q8]) as [Q8_GRID_04_Q8],count([Q9_GRID_01_Q9]) as [Q9_GRID_01_Q9],count([Q12A]) as [Q12A],count([Q12C]) as [Q12C],count([Q12D]) as [Q12D],count([Q10_GRID_01_Q10]) as [Q10_GRID_01_Q10],count([Q6]) as [Q6],count([Q92]) as [Q92],count([Q93]) as [Q93],count([Q72_GRID_01_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_01_Q72A_GRID_1_0_Q72A],count([Q72_GRID_02_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_02_Q72A_GRID_1_0_Q72A],count([Q72_GRID_03_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_03_Q72A_GRID_1_0_Q72A],count([Q72_GRID_04_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_04_Q72A_GRID_1_0_Q72A],count([Q72_GRID_05_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_05_Q72A_GRID_1_0_Q72A],count([Q72_GRID_06_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_06_Q72A_GRID_1_0_Q72A],count([Q72_GRID_07_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_07_Q72A_GRID_1_0_Q72A],count([Q72_GRID_08_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_08_Q72A_GRID_1_0_Q72A],count([Q72_GRID_09_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_09_Q72A_GRID_1_0_Q72A],count([Q72_GRID_10_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_10_Q72A_GRID_1_0_Q72A],count([Q72_GRID_11_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_11_Q72A_GRID_1_0_Q72A],count([Q72_GRID_12_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_12_Q72A_GRID_1_0_Q72A],count([Q72_GRID_13_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_13_Q72A_GRID_1_0_Q72A],count([Q110]) as [Q110],count([Q91A_GRID_01_Q91A]) as [Q91A_GRID_01_Q91A],count([Q91A_GRID_02_Q91A]) as [Q91A_GRID_02_Q91A],count([Q91A_GRID_03_Q91A]) as [Q91A_GRID_03_Q91A],count([Q91A_GRID_04_Q91A]) as [Q91A_GRID_04_Q91A],count([Q91A_GRID_05_Q91A]) as [Q91A_GRID_05_Q91A],count([Q91B_GRID_06_Q91B]) as [Q91B_GRID_06_Q91B],count([Q91B_GRID_07_Q91B]) as [Q91B_GRID_07_Q91B],count([Q91B_GRID_08_Q91B]) as [Q91B_GRID_08_Q91B],count([Q91B_GRID_10_Q91B]) as [Q91B_GRID_10_Q91B],count([Q91B_GRID_11_Q91B]) as [Q91B_GRID_11_Q91B],count([Q91C_GRID_09_Q91C]) as [Q91C_GRID_09_Q91C],count([Q91C_GRID_12_Q91C]) as [Q91C_GRID_12_Q91C],count([Q91C_GRID_13_Q91C]) as [Q91C_GRID_13_Q91C],count([Q91C_GRID_14_Q91C]) as [Q91C_GRID_14_Q91C],count([Q91D_GRID_15_Q91D]) as [Q91D_GRID_15_Q91D],count([Q100]) as [Q100],count([Q101_GRID_01_Q101]) as [Q101_GRID_01_Q101],count([Q101_GRID_02_Q101]) as [Q101_GRID_02_Q101],count([Q101_GRID_03_Q101]) as [Q101_GRID_03_Q101],count([Q102]) as [Q102],count([Q105]) as [Q105],count([Q106]) as [Q106],count([Q107]) as [Q107],count([Q108]) as [Q108],count([Q109]) as [Q109],count([Q115_GRID_01_Q115]) as [Q115_GRID_01_Q115],count([Q115_GRID_02_Q115]) as [Q115_GRID_02_Q115],count([Q116_GRID_01_Q116]) as [Q116_GRID_01_Q116],count([Q116_GRID_02_Q116]) as [Q116_GRID_02_Q116],count([Q116_GRID_03_Q116]) as [Q116_GRID_03_Q116],count([Q117_GRID_01_Q117]) as [Q117_GRID_01_Q117],count([Q117_GRID_02_Q117]) as [Q117_GRID_02_Q117],count([Q117_GRID_03_Q117]) as [Q117_GRID_03_Q117],count([Q117_GRID_04_Q117]) as [Q117_GRID_04_Q117],count([Q117_GRID_05_Q117]) as [Q117_GRID_05_Q117],count([Q117_GRID_06_Q117]) as [Q117_GRID_06_Q117],count([Q117_GRID_07_Q117]) as [Q117_GRID_07_Q117],count([Q118]) as [Q118],count([DATE_NUM]) as [DATE_NUM],count([MRK_SEG1]) as [MRK_SEG1],count([InterviewLength]) as [InterviewLength],count([MONTHX]) as [MONTHX],count([FDO_FISCAL_2015]) as [FDO_FISCAL_2015],count([QUARTER_NEW]) as [QUARTER_NEW],count([YEAR_NEW]) as [YEAR_NEW],count([weight]) as [weight],count([RECEIPTNUM]) as [RECEIPTNUM],count([Group]) as [Group],count([Region]) as [Region],count([District]) as [District],count([CB_REG]) as [CB_REG],count([CB_RURAL]) as [CB_RURAL],count([URBANICITY]) as [URBANICITY],count([Q92_INS01]) as [Q92_INS01],count([Q92_INS02]) as [Q92_INS02],count([Q92_INS03]) as [Q92_INS03],count([Q92_INS04]) as [Q92_INS04],count([Q92_INS05]) as [Q92_INS05],count([Q92_INS06]) as [Q92_INS06],count([Q92_INS07]) as [Q92_INS07],count([Q92_INS08]) as [Q92_INS08],count([Q92_INS09]) as [Q92_INS09],count([Q92_INS10]) as [Q92_INS10],count([Q92_INS11]) as [Q92_INS11],count([Q92_INS12]) as [Q92_INS12],count([Q92_INS13]) as [Q92_INS13],count([Q92_INS14]) as [Q92_INS14],count([Q92_INS15]) as [Q92_INS15],count([Q93_INS01]) as [Q93_INS01],count([Q93_INS02]) as [Q93_INS02],count([Q93_INS03]) as [Q93_INS03],count([Q93_INS04]) as [Q93_INS04],count([Q93_INS05]) as [Q93_INS05],count([Q93_INS06]) as [Q93_INS06],count([Q93_INS07]) as [Q93_INS07],count([Q93_INS08]) as [Q93_INS08],count([Q93_INS09]) as [Q93_INS09],count([Q93_INS10]) as [Q93_INS10],count([Q93_INS11]) as [Q93_INS11],count([Q93_INS12]) as [Q93_INS12],count([Q93_INS13]) as [Q93_INS13],count([Q93_INS14]) as [Q93_INS14],count([Q93_INS15]) as [Q93_INS15],count([id]) as [id]
------ ,sum([AGE_GROUP]) as [AGE_GROUP],sum([CB_REG]) as [CB_REG],sum([CB_RURAL]) as [CB_RURAL],sum([FDO_FISCAL_2015]) as [FDO_FISCAL_2015],sum([freq_shop]) as [freq_shop],sum([MONTHX]) as [MONTHX],sum([MRK_FDO]) as [MRK_FDO],sum([Q10_GRID_01_Q10]) as [Q10_GRID_01_Q10],sum([Q100]) as [Q100],sum([Q101_GRID_01_Q101]) as [Q101_GRID_01_Q101],sum([Q101_GRID_02_Q101]) as [Q101_GRID_02_Q101],sum([Q101_GRID_03_Q101]) as [Q101_GRID_03_Q101],sum([Q102]) as [Q102],sum([Q105]) as [Q105],sum([Q106]) as [Q106],sum([Q107]) as [Q107],sum([Q108]) as [Q108],sum([Q109]) as [Q109],sum([Q115_GRID_01_Q115]) as [Q115_GRID_01_Q115],sum([Q115_GRID_02_Q115]) as [Q115_GRID_02_Q115],sum([Q116_GRID_01_Q116]) as [Q116_GRID_01_Q116],sum([Q116_GRID_02_Q116]) as [Q116_GRID_02_Q116],sum([Q116_GRID_03_Q116]) as [Q116_GRID_03_Q116],sum([Q117_GRID_01_Q117]) as [Q117_GRID_01_Q117],sum([Q117_GRID_02_Q117]) as [Q117_GRID_02_Q117],sum([Q117_GRID_03_Q117]) as [Q117_GRID_03_Q117],sum([Q117_GRID_04_Q117]) as [Q117_GRID_04_Q117],sum([Q117_GRID_05_Q117]) as [Q117_GRID_05_Q117],sum([Q117_GRID_06_Q117]) as [Q117_GRID_06_Q117],sum([Q117_GRID_07_Q117]) as [Q117_GRID_07_Q117],sum([Q118]) as [Q118],sum([Q12A]) as [Q12A],sum([Q12C]) as [Q12C],sum([Q12D]) as [Q12D],sum([Q13]) as [Q13],sum([Q1401]) as [Q1401],sum([Q1402]) as [Q1402],sum([Q1403]) as [Q1403],sum([Q1404]) as [Q1404],sum([Q1405]) as [Q1405],sum([Q1406]) as [Q1406],sum([Q1407]) as [Q1407],sum([Q15]) as [Q15],sum([Q16]) as [Q16],sum([Q4_GRID_0_Q4]) as [Q4_GRID_0_Q4],sum([Q5_GRID_01_Q5]) as [Q5_GRID_01_Q5],sum([Q5_GRID_02_Q5]) as [Q5_GRID_02_Q5],sum([Q5_GRID_03_Q5]) as [Q5_GRID_03_Q5],sum([Q63]) as [Q63],sum([Q64]) as [Q64],sum([Q7_GRID_01_Q7]) as [Q7_GRID_01_Q7],sum([Q7_GRID_02_Q7]) as [Q7_GRID_02_Q7],sum([Q7_GRID_03_Q7]) as [Q7_GRID_03_Q7],sum([Q7_GRID_04_Q7]) as [Q7_GRID_04_Q7],sum([Q7_GRID_05_Q7]) as [Q7_GRID_05_Q7],sum([Q72_A01]) as [Q72_A01],sum([Q72_A02]) as [Q72_A02],sum([Q72_A03]) as [Q72_A03],sum([Q72_A04]) as [Q72_A04],sum([Q72_A05]) as [Q72_A05],sum([Q72_A06]) as [Q72_A06],sum([Q72_A07]) as [Q72_A07],sum([Q72_A08]) as [Q72_A08],sum([Q72_A09]) as [Q72_A09],sum([Q72_A10]) as [Q72_A10],sum([Q72_A11]) as [Q72_A11],sum([Q7201]) as [Q7201],sum([Q7202]) as [Q7202],sum([Q7203]) as [Q7203],sum([Q7204]) as [Q7204],sum([Q7205]) as [Q7205],sum([Q7206]) as [Q7206],sum([Q7207]) as [Q7207],sum([Q7208]) as [Q7208],sum([Q7209]) as [Q7209],sum([Q7210]) as [Q7210],sum([Q7211]) as [Q7211],sum([Q7212]) as [Q7212],sum([Q7213]) as [Q7213],sum([Q8_GRID_01_Q8]) as [Q8_GRID_01_Q8],sum([Q8_GRID_02_Q8]) as [Q8_GRID_02_Q8],sum([Q8_GRID_03_Q8]) as [Q8_GRID_03_Q8],sum([Q8_GRID_04_Q8]) as [Q8_GRID_04_Q8],sum([Q9_GRID_01_Q9]) as [Q9_GRID_01_Q9],sum([Q91A_GRID_01_Q91A]) as [Q91A_GRID_01_Q91A],sum([Q91A_GRID_02_Q91A]) as [Q91A_GRID_02_Q91A],sum([Q91A_GRID_03_Q91A]) as [Q91A_GRID_03_Q91A],sum([Q91A_GRID_04_Q91A]) as [Q91A_GRID_04_Q91A],sum([Q91A_GRID_05_Q91A]) as [Q91A_GRID_05_Q91A],sum([Q91B_GRID_06_Q91B]) as [Q91B_GRID_06_Q91B],sum([Q91B_GRID_07_Q91B]) as [Q91B_GRID_07_Q91B],sum([Q91B_GRID_08_Q91B]) as [Q91B_GRID_08_Q91B],sum([Q91B_GRID_10_Q91B]) as [Q91B_GRID_10_Q91B],sum([Q91B_GRID_11_Q91B]) as [Q91B_GRID_11_Q91B],sum([Q91C_GRID_09_Q91C]) as [Q91C_GRID_09_Q91C],sum([Q91C_GRID_12_Q91C]) as [Q91C_GRID_12_Q91C],sum([Q91C_GRID_13_Q91C]) as [Q91C_GRID_13_Q91C],sum([Q91C_GRID_14_Q91C]) as [Q91C_GRID_14_Q91C],sum([Q91D_GRID_15_Q91D]) as [Q91D_GRID_15_Q91D],sum([Q92_INS01]) as [Q92_INS01],sum([Q92_INS02]) as [Q92_INS02],sum([Q92_INS03]) as [Q92_INS03],sum([Q92_INS04]) as [Q92_INS04],sum([Q92_INS05]) as [Q92_INS05],sum([Q92_INS06]) as [Q92_INS06],sum([Q92_INS07]) as [Q92_INS07],sum([Q92_INS08]) as [Q92_INS08],sum([Q92_INS09]) as [Q92_INS09],sum([Q92_INS10]) as [Q92_INS10],sum([Q92_INS11]) as [Q92_INS11],sum([Q92_INS12]) as [Q92_INS12],sum([Q92_INS13]) as [Q92_INS13],sum([Q92_INS14]) as [Q92_INS14],sum([Q92_INS15]) as [Q92_INS15],sum([Q93_INS01]) as [Q93_INS01],sum([Q93_INS02]) as [Q93_INS02],sum([Q93_INS03]) as [Q93_INS03],sum([Q93_INS04]) as [Q93_INS04],sum([Q93_INS05]) as [Q93_INS05],sum([Q93_INS06]) as [Q93_INS06],sum([Q93_INS07]) as [Q93_INS07],sum([Q93_INS08]) as [Q93_INS08],sum([Q93_INS09]) as [Q93_INS09],sum([Q93_INS10]) as [Q93_INS10],sum([Q93_INS11]) as [Q93_INS11],sum([Q93_INS12]) as [Q93_INS12],sum([Q93_INS13]) as [Q93_INS13],sum([Q93_INS14]) as [Q93_INS14],sum([Q93_INS15]) as [Q93_INS15],sum([QCB3]) as [QCB3],sum([QCB4]) as [QCB4],sum([QUARTER_NEW]) as [QUARTER_NEW],sum([RACE_ETH]) as [RACE_ETH],sum([URBANICITY]) as [URBANICITY],sum([YEAR_NEW]) as [YEAR_NEW]
------   from [dbo].[tb_RawData] where quarter_new <>9
------   group by  year_new ;

   
------select year_new,count(*),
------ count([Respondent_ID]) as [Respondent_ID],count([Q2_1]) as [Q2_1],count([Q3]) as [Q3],count([AGE_GROUP]) as [AGE_GROUP],count([RACE_ETH]) as [RACE_ETH],count([Q13]) as [Q13],count([freq_shop]) as [freq_shop],count([Q1401]) as [Q1401],count([Q1402]) as [Q1402],count([Q1403]) as [Q1403],count([Q1404]) as [Q1404],count([Q1405]) as [Q1405],count([Q1406]) as [Q1406],count([Q1407]) as [Q1407],count([Q7201]) as [Q7201],count([Q7202]) as [Q7202],count([Q7203]) as [Q7203],count([Q7204]) as [Q7204],count([Q7205]) as [Q7205],count([Q7206]) as [Q7206],count([Q7207]) as [Q7207],count([Q7208]) as [Q7208],count([Q7209]) as [Q7209],count([Q7210]) as [Q7210],count([Q7211]) as [Q7211],count([Q7212]) as [Q7212],count([Q7213]) as [Q7213],count([Q15]) as [Q15],count([Q16]) as [Q16],count([Q63]) as [Q63],count([Q64]) as [Q64],count([QCB3]) as [QCB3],count([QCB4]) as [QCB4],count([Q72_A01]) as [Q72_A01],count([Q72_A02]) as [Q72_A02],count([Q72_A03]) as [Q72_A03],count([Q72_A04]) as [Q72_A04],count([Q72_A05]) as [Q72_A05],count([Q72_A06]) as [Q72_A06],count([Q72_A07]) as [Q72_A07],count([Q72_A08]) as [Q72_A08],count([Q72_A09]) as [Q72_A09],count([Q72_A10]) as [Q72_A10],count([Q72_A11]) as [Q72_A11],count([MRK_FDO]) as [MRK_FDO],count([Q4_GRID_0_Q4]) as [Q4_GRID_0_Q4],count([Q5_GRID_01_Q5]) as [Q5_GRID_01_Q5],count([Q5_GRID_02_Q5]) as [Q5_GRID_02_Q5],count([Q5_GRID_03_Q5]) as [Q5_GRID_03_Q5],count([Q7_GRID_01_Q7]) as [Q7_GRID_01_Q7],count([Q7_GRID_02_Q7]) as [Q7_GRID_02_Q7],count([Q7_GRID_03_Q7]) as [Q7_GRID_03_Q7],count([Q7_GRID_04_Q7]) as [Q7_GRID_04_Q7],count([Q7_GRID_05_Q7]) as [Q7_GRID_05_Q7],count([Q8_GRID_01_Q8]) as [Q8_GRID_01_Q8],count([Q8_GRID_02_Q8]) as [Q8_GRID_02_Q8],count([Q8_GRID_03_Q8]) as [Q8_GRID_03_Q8],count([Q8_GRID_04_Q8]) as [Q8_GRID_04_Q8],count([Q9_GRID_01_Q9]) as [Q9_GRID_01_Q9],count([Q12A]) as [Q12A],count([Q12C]) as [Q12C],count([Q12D]) as [Q12D],count([Q10_GRID_01_Q10]) as [Q10_GRID_01_Q10],count([Q6]) as [Q6],count([Q92]) as [Q92],count([Q93]) as [Q93],count([Q72_GRID_01_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_01_Q72A_GRID_1_0_Q72A],count([Q72_GRID_02_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_02_Q72A_GRID_1_0_Q72A],count([Q72_GRID_03_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_03_Q72A_GRID_1_0_Q72A],count([Q72_GRID_04_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_04_Q72A_GRID_1_0_Q72A],count([Q72_GRID_05_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_05_Q72A_GRID_1_0_Q72A],count([Q72_GRID_06_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_06_Q72A_GRID_1_0_Q72A],count([Q72_GRID_07_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_07_Q72A_GRID_1_0_Q72A],count([Q72_GRID_08_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_08_Q72A_GRID_1_0_Q72A],count([Q72_GRID_09_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_09_Q72A_GRID_1_0_Q72A],count([Q72_GRID_10_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_10_Q72A_GRID_1_0_Q72A],count([Q72_GRID_11_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_11_Q72A_GRID_1_0_Q72A],count([Q72_GRID_12_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_12_Q72A_GRID_1_0_Q72A],count([Q72_GRID_13_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_13_Q72A_GRID_1_0_Q72A],count([Q110]) as [Q110],count([Q91A_GRID_01_Q91A]) as [Q91A_GRID_01_Q91A],count([Q91A_GRID_02_Q91A]) as [Q91A_GRID_02_Q91A],count([Q91A_GRID_03_Q91A]) as [Q91A_GRID_03_Q91A],count([Q91A_GRID_04_Q91A]) as [Q91A_GRID_04_Q91A],count([Q91A_GRID_05_Q91A]) as [Q91A_GRID_05_Q91A],count([Q91B_GRID_06_Q91B]) as [Q91B_GRID_06_Q91B],count([Q91B_GRID_07_Q91B]) as [Q91B_GRID_07_Q91B],count([Q91B_GRID_08_Q91B]) as [Q91B_GRID_08_Q91B],count([Q91B_GRID_10_Q91B]) as [Q91B_GRID_10_Q91B],count([Q91B_GRID_11_Q91B]) as [Q91B_GRID_11_Q91B],count([Q91C_GRID_09_Q91C]) as [Q91C_GRID_09_Q91C],count([Q91C_GRID_12_Q91C]) as [Q91C_GRID_12_Q91C],count([Q91C_GRID_13_Q91C]) as [Q91C_GRID_13_Q91C],count([Q91C_GRID_14_Q91C]) as [Q91C_GRID_14_Q91C],count([Q91D_GRID_15_Q91D]) as [Q91D_GRID_15_Q91D],count([Q100]) as [Q100],count([Q101_GRID_01_Q101]) as [Q101_GRID_01_Q101],count([Q101_GRID_02_Q101]) as [Q101_GRID_02_Q101],count([Q101_GRID_03_Q101]) as [Q101_GRID_03_Q101],count([Q102]) as [Q102],count([Q105]) as [Q105],count([Q106]) as [Q106],count([Q107]) as [Q107],count([Q108]) as [Q108],count([Q109]) as [Q109],count([Q115_GRID_01_Q115]) as [Q115_GRID_01_Q115],count([Q115_GRID_02_Q115]) as [Q115_GRID_02_Q115],count([Q116_GRID_01_Q116]) as [Q116_GRID_01_Q116],count([Q116_GRID_02_Q116]) as [Q116_GRID_02_Q116],count([Q116_GRID_03_Q116]) as [Q116_GRID_03_Q116],count([Q117_GRID_01_Q117]) as [Q117_GRID_01_Q117],count([Q117_GRID_02_Q117]) as [Q117_GRID_02_Q117],count([Q117_GRID_03_Q117]) as [Q117_GRID_03_Q117],count([Q117_GRID_04_Q117]) as [Q117_GRID_04_Q117],count([Q117_GRID_05_Q117]) as [Q117_GRID_05_Q117],count([Q117_GRID_06_Q117]) as [Q117_GRID_06_Q117],count([Q117_GRID_07_Q117]) as [Q117_GRID_07_Q117],count([Q118]) as [Q118],count([DATE_NUM]) as [DATE_NUM],count([MRK_SEG1]) as [MRK_SEG1],count([InterviewLength]) as [InterviewLength],count([MONTHX]) as [MONTHX],count([FDO_FISCAL_2015]) as [FDO_FISCAL_2015],count([QUARTER_NEW]) as [QUARTER_NEW],count([YEAR_NEW]) as [YEAR_NEW],count([weight]) as [weight],count([RECEIPTNUM]) as [RECEIPTNUM],count([Group]) as [Group],count([Region]) as [Region],count([District]) as [District],count([CB_REG]) as [CB_REG],count([CB_RURAL]) as [CB_RURAL],count([URBANICITY]) as [URBANICITY],count([Q92_INS01]) as [Q92_INS01],count([Q92_INS02]) as [Q92_INS02],count([Q92_INS03]) as [Q92_INS03],count([Q92_INS04]) as [Q92_INS04],count([Q92_INS05]) as [Q92_INS05],count([Q92_INS06]) as [Q92_INS06],count([Q92_INS07]) as [Q92_INS07],count([Q92_INS08]) as [Q92_INS08],count([Q92_INS09]) as [Q92_INS09],count([Q92_INS10]) as [Q92_INS10],count([Q92_INS11]) as [Q92_INS11],count([Q92_INS12]) as [Q92_INS12],count([Q92_INS13]) as [Q92_INS13],count([Q92_INS14]) as [Q92_INS14],count([Q92_INS15]) as [Q92_INS15],count([Q93_INS01]) as [Q93_INS01],count([Q93_INS02]) as [Q93_INS02],count([Q93_INS03]) as [Q93_INS03],count([Q93_INS04]) as [Q93_INS04],count([Q93_INS05]) as [Q93_INS05],count([Q93_INS06]) as [Q93_INS06],count([Q93_INS07]) as [Q93_INS07],count([Q93_INS08]) as [Q93_INS08],count([Q93_INS09]) as [Q93_INS09],count([Q93_INS10]) as [Q93_INS10],count([Q93_INS11]) as [Q93_INS11],count([Q93_INS12]) as [Q93_INS12],count([Q93_INS13]) as [Q93_INS13],count([Q93_INS14]) as [Q93_INS14],count([Q93_INS15]) as [Q93_INS15]
------ ,sum([AGE_GROUP]) as [AGE_GROUP],sum([CB_REG]) as [CB_REG],sum([CB_RURAL]) as [CB_RURAL],sum([FDO_FISCAL_2015]) as [FDO_FISCAL_2015],sum([freq_shop]) as [freq_shop],sum([MONTHX]) as [MONTHX],sum([MRK_FDO]) as [MRK_FDO],sum([Q10_GRID_01_Q10]) as [Q10_GRID_01_Q10],sum([Q100]) as [Q100],sum([Q101_GRID_01_Q101]) as [Q101_GRID_01_Q101],sum([Q101_GRID_02_Q101]) as [Q101_GRID_02_Q101],sum([Q101_GRID_03_Q101]) as [Q101_GRID_03_Q101],sum([Q102]) as [Q102],sum([Q105]) as [Q105],sum([Q106]) as [Q106],sum([Q107]) as [Q107],sum([Q108]) as [Q108],sum([Q109]) as [Q109],sum([Q115_GRID_01_Q115]) as [Q115_GRID_01_Q115],sum([Q115_GRID_02_Q115]) as [Q115_GRID_02_Q115],sum([Q116_GRID_01_Q116]) as [Q116_GRID_01_Q116],sum([Q116_GRID_02_Q116]) as [Q116_GRID_02_Q116],sum([Q116_GRID_03_Q116]) as [Q116_GRID_03_Q116],sum([Q117_GRID_01_Q117]) as [Q117_GRID_01_Q117],sum([Q117_GRID_02_Q117]) as [Q117_GRID_02_Q117],sum([Q117_GRID_03_Q117]) as [Q117_GRID_03_Q117],sum([Q117_GRID_04_Q117]) as [Q117_GRID_04_Q117],sum([Q117_GRID_05_Q117]) as [Q117_GRID_05_Q117],sum([Q117_GRID_06_Q117]) as [Q117_GRID_06_Q117],sum([Q117_GRID_07_Q117]) as [Q117_GRID_07_Q117],sum([Q118]) as [Q118],sum([Q12A]) as [Q12A],sum([Q12C]) as [Q12C],sum([Q12D]) as [Q12D],sum([Q13]) as [Q13],sum([Q1401]) as [Q1401],sum([Q1402]) as [Q1402],sum([Q1403]) as [Q1403],sum([Q1404]) as [Q1404],sum([Q1405]) as [Q1405],sum([Q1406]) as [Q1406],sum([Q1407]) as [Q1407],sum([Q15]) as [Q15],sum([Q16]) as [Q16],sum([Q4_GRID_0_Q4]) as [Q4_GRID_0_Q4],sum([Q5_GRID_01_Q5]) as [Q5_GRID_01_Q5],sum([Q5_GRID_02_Q5]) as [Q5_GRID_02_Q5],sum([Q5_GRID_03_Q5]) as [Q5_GRID_03_Q5],sum([Q63]) as [Q63],sum([Q64]) as [Q64],sum([Q7_GRID_01_Q7]) as [Q7_GRID_01_Q7],sum([Q7_GRID_02_Q7]) as [Q7_GRID_02_Q7],sum([Q7_GRID_03_Q7]) as [Q7_GRID_03_Q7],sum([Q7_GRID_04_Q7]) as [Q7_GRID_04_Q7],sum([Q7_GRID_05_Q7]) as [Q7_GRID_05_Q7],sum([Q72_A01]) as [Q72_A01],sum([Q72_A02]) as [Q72_A02],sum([Q72_A03]) as [Q72_A03],sum([Q72_A04]) as [Q72_A04],sum([Q72_A05]) as [Q72_A05],sum([Q72_A06]) as [Q72_A06],sum([Q72_A07]) as [Q72_A07],sum([Q72_A08]) as [Q72_A08],sum([Q72_A09]) as [Q72_A09],sum([Q72_A10]) as [Q72_A10],sum([Q72_A11]) as [Q72_A11],sum([Q7201]) as [Q7201],sum([Q7202]) as [Q7202],sum([Q7203]) as [Q7203],sum([Q7204]) as [Q7204],sum([Q7205]) as [Q7205],sum([Q7206]) as [Q7206],sum([Q7207]) as [Q7207],sum([Q7208]) as [Q7208],sum([Q7209]) as [Q7209],sum([Q7210]) as [Q7210],sum([Q7211]) as [Q7211],sum([Q7212]) as [Q7212],sum([Q7213]) as [Q7213],sum([Q8_GRID_01_Q8]) as [Q8_GRID_01_Q8],sum([Q8_GRID_02_Q8]) as [Q8_GRID_02_Q8],sum([Q8_GRID_03_Q8]) as [Q8_GRID_03_Q8],sum([Q8_GRID_04_Q8]) as [Q8_GRID_04_Q8],sum([Q9_GRID_01_Q9]) as [Q9_GRID_01_Q9],sum([Q91A_GRID_01_Q91A]) as [Q91A_GRID_01_Q91A],sum([Q91A_GRID_02_Q91A]) as [Q91A_GRID_02_Q91A],sum([Q91A_GRID_03_Q91A]) as [Q91A_GRID_03_Q91A],sum([Q91A_GRID_04_Q91A]) as [Q91A_GRID_04_Q91A],sum([Q91A_GRID_05_Q91A]) as [Q91A_GRID_05_Q91A],sum([Q91B_GRID_06_Q91B]) as [Q91B_GRID_06_Q91B],sum([Q91B_GRID_07_Q91B]) as [Q91B_GRID_07_Q91B],sum([Q91B_GRID_08_Q91B]) as [Q91B_GRID_08_Q91B],sum([Q91B_GRID_10_Q91B]) as [Q91B_GRID_10_Q91B],sum([Q91B_GRID_11_Q91B]) as [Q91B_GRID_11_Q91B],sum([Q91C_GRID_09_Q91C]) as [Q91C_GRID_09_Q91C],sum([Q91C_GRID_12_Q91C]) as [Q91C_GRID_12_Q91C],sum([Q91C_GRID_13_Q91C]) as [Q91C_GRID_13_Q91C],sum([Q91C_GRID_14_Q91C]) as [Q91C_GRID_14_Q91C],sum([Q91D_GRID_15_Q91D]) as [Q91D_GRID_15_Q91D],sum([Q92_INS01]) as [Q92_INS01],sum([Q92_INS02]) as [Q92_INS02],sum([Q92_INS03]) as [Q92_INS03],sum([Q92_INS04]) as [Q92_INS04],sum([Q92_INS05]) as [Q92_INS05],sum([Q92_INS06]) as [Q92_INS06],sum([Q92_INS07]) as [Q92_INS07],sum([Q92_INS08]) as [Q92_INS08],sum([Q92_INS09]) as [Q92_INS09],sum([Q92_INS10]) as [Q92_INS10],sum([Q92_INS11]) as [Q92_INS11],sum([Q92_INS12]) as [Q92_INS12],sum([Q92_INS13]) as [Q92_INS13],sum([Q92_INS14]) as [Q92_INS14],sum([Q92_INS15]) as [Q92_INS15],sum([Q93_INS01]) as [Q93_INS01],sum([Q93_INS02]) as [Q93_INS02],sum([Q93_INS03]) as [Q93_INS03],sum([Q93_INS04]) as [Q93_INS04],sum([Q93_INS05]) as [Q93_INS05],sum([Q93_INS06]) as [Q93_INS06],sum([Q93_INS07]) as [Q93_INS07],sum([Q93_INS08]) as [Q93_INS08],sum([Q93_INS09]) as [Q93_INS09],sum([Q93_INS10]) as [Q93_INS10],sum([Q93_INS11]) as [Q93_INS11],sum([Q93_INS12]) as [Q93_INS12],sum([Q93_INS13]) as [Q93_INS13],sum([Q93_INS14]) as [Q93_INS14],sum([Q93_INS15]) as [Q93_INS15],sum([QCB3]) as [QCB3],sum([QCB4]) as [QCB4],sum([QUARTER_NEW]) as [QUARTER_NEW],sum([RACE_ETH]) as [RACE_ETH],sum([URBANICITY]) as [URBANICITY],sum([YEAR_NEW]) as [YEAR_NEW]
------   from [Data$Victor] 
------   group by  year_new ;

------ select year_new,count(*),
------ count([Respondent_ID]) as [Respondent_ID],count([Q2_1]) as [Q2_1],count([Q3]) as [Q3],count([AGE_GROUP]) as [AGE_GROUP],count([RACE_ETH]) as [RACE_ETH],count([Q13]) as [Q13],count([freq_shop]) as [freq_shop],count([Q1401]) as [Q1401],count([Q1402]) as [Q1402],count([Q1403]) as [Q1403],count([Q1404]) as [Q1404],count([Q1405]) as [Q1405],count([Q1406]) as [Q1406],count([Q1407]) as [Q1407],count([Q7201]) as [Q7201],count([Q7202]) as [Q7202],count([Q7203]) as [Q7203],count([Q7204]) as [Q7204],count([Q7205]) as [Q7205],count([Q7206]) as [Q7206],count([Q7207]) as [Q7207],count([Q7208]) as [Q7208],count([Q7209]) as [Q7209],count([Q7210]) as [Q7210],count([Q7211]) as [Q7211],count([Q7212]) as [Q7212],count([Q7213]) as [Q7213],count([Q15]) as [Q15],count([Q16]) as [Q16],count([Q63]) as [Q63],count([Q64]) as [Q64],count([QCB3]) as [QCB3],count([QCB4]) as [QCB4],count([Q72_A01]) as [Q72_A01],count([Q72_A02]) as [Q72_A02],count([Q72_A03]) as [Q72_A03],count([Q72_A04]) as [Q72_A04],count([Q72_A05]) as [Q72_A05],count([Q72_A06]) as [Q72_A06],count([Q72_A07]) as [Q72_A07],count([Q72_A08]) as [Q72_A08],count([Q72_A09]) as [Q72_A09],count([Q72_A10]) as [Q72_A10],count([Q72_A11]) as [Q72_A11],count([MRK_FDO]) as [MRK_FDO],count([Q4_GRID_0_Q4]) as [Q4_GRID_0_Q4],count([Q5_GRID_01_Q5]) as [Q5_GRID_01_Q5],count([Q5_GRID_02_Q5]) as [Q5_GRID_02_Q5],count([Q5_GRID_03_Q5]) as [Q5_GRID_03_Q5],count([Q7_GRID_01_Q7]) as [Q7_GRID_01_Q7],count([Q7_GRID_02_Q7]) as [Q7_GRID_02_Q7],count([Q7_GRID_03_Q7]) as [Q7_GRID_03_Q7],count([Q7_GRID_04_Q7]) as [Q7_GRID_04_Q7],count([Q7_GRID_05_Q7]) as [Q7_GRID_05_Q7],count([Q8_GRID_01_Q8]) as [Q8_GRID_01_Q8],count([Q8_GRID_02_Q8]) as [Q8_GRID_02_Q8],count([Q8_GRID_03_Q8]) as [Q8_GRID_03_Q8],count([Q8_GRID_04_Q8]) as [Q8_GRID_04_Q8],count([Q9_GRID_01_Q9]) as [Q9_GRID_01_Q9],count([Q12A]) as [Q12A],count([Q12C]) as [Q12C],count([Q12D]) as [Q12D],count([Q10_GRID_01_Q10]) as [Q10_GRID_01_Q10],count([Q6]) as [Q6],count([Q92]) as [Q92],count([Q93]) as [Q93],count([Q72_GRID_01_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_01_Q72A_GRID_1_0_Q72A],count([Q72_GRID_02_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_02_Q72A_GRID_1_0_Q72A],count([Q72_GRID_03_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_03_Q72A_GRID_1_0_Q72A],count([Q72_GRID_04_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_04_Q72A_GRID_1_0_Q72A],count([Q72_GRID_05_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_05_Q72A_GRID_1_0_Q72A],count([Q72_GRID_06_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_06_Q72A_GRID_1_0_Q72A],count([Q72_GRID_07_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_07_Q72A_GRID_1_0_Q72A],count([Q72_GRID_08_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_08_Q72A_GRID_1_0_Q72A],count([Q72_GRID_09_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_09_Q72A_GRID_1_0_Q72A],count([Q72_GRID_10_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_10_Q72A_GRID_1_0_Q72A],count([Q72_GRID_11_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_11_Q72A_GRID_1_0_Q72A],count([Q72_GRID_12_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_12_Q72A_GRID_1_0_Q72A],count([Q72_GRID_13_Q72A_GRID_1_0_Q72A]) as [Q72_GRID_13_Q72A_GRID_1_0_Q72A],count([Q110]) as [Q110],count([Q91A_GRID_01_Q91A]) as [Q91A_GRID_01_Q91A],count([Q91A_GRID_02_Q91A]) as [Q91A_GRID_02_Q91A],count([Q91A_GRID_03_Q91A]) as [Q91A_GRID_03_Q91A],count([Q91A_GRID_04_Q91A]) as [Q91A_GRID_04_Q91A],count([Q91A_GRID_05_Q91A]) as [Q91A_GRID_05_Q91A],count([Q91B_GRID_06_Q91B]) as [Q91B_GRID_06_Q91B],count([Q91B_GRID_07_Q91B]) as [Q91B_GRID_07_Q91B],count([Q91B_GRID_08_Q91B]) as [Q91B_GRID_08_Q91B],count([Q91B_GRID_10_Q91B]) as [Q91B_GRID_10_Q91B],count([Q91B_GRID_11_Q91B]) as [Q91B_GRID_11_Q91B],count([Q91C_GRID_09_Q91C]) as [Q91C_GRID_09_Q91C],count([Q91C_GRID_12_Q91C]) as [Q91C_GRID_12_Q91C],count([Q91C_GRID_13_Q91C]) as [Q91C_GRID_13_Q91C],count([Q91C_GRID_14_Q91C]) as [Q91C_GRID_14_Q91C],count([Q91D_GRID_15_Q91D]) as [Q91D_GRID_15_Q91D],count([Q100]) as [Q100],count([Q101_GRID_01_Q101]) as [Q101_GRID_01_Q101],count([Q101_GRID_02_Q101]) as [Q101_GRID_02_Q101],count([Q101_GRID_03_Q101]) as [Q101_GRID_03_Q101],count([Q102]) as [Q102],count([Q105]) as [Q105],count([Q106]) as [Q106],count([Q107]) as [Q107],count([Q108]) as [Q108],count([Q109]) as [Q109],count([Q115_GRID_01_Q115]) as [Q115_GRID_01_Q115],count([Q115_GRID_02_Q115]) as [Q115_GRID_02_Q115],count([Q116_GRID_01_Q116]) as [Q116_GRID_01_Q116],count([Q116_GRID_02_Q116]) as [Q116_GRID_02_Q116],count([Q116_GRID_03_Q116]) as [Q116_GRID_03_Q116],count([Q117_GRID_01_Q117]) as [Q117_GRID_01_Q117],count([Q117_GRID_02_Q117]) as [Q117_GRID_02_Q117],count([Q117_GRID_03_Q117]) as [Q117_GRID_03_Q117],count([Q117_GRID_04_Q117]) as [Q117_GRID_04_Q117],count([Q117_GRID_05_Q117]) as [Q117_GRID_05_Q117],count([Q117_GRID_06_Q117]) as [Q117_GRID_06_Q117],count([Q117_GRID_07_Q117]) as [Q117_GRID_07_Q117],count([Q118]) as [Q118],count([DATE_NUM]) as [DATE_NUM],count([MRK_SEG1]) as [MRK_SEG1],count([InterviewLength]) as [InterviewLength],count([MONTHX]) as [MONTHX],count([FDO_FISCAL_2015]) as [FDO_FISCAL_2015],count([QUARTER_NEW]) as [QUARTER_NEW],count([YEAR_NEW]) as [YEAR_NEW],count([weight]) as [weight],count([RECEIPTNUM]) as [RECEIPTNUM],count([Group]) as [Group],count([Region]) as [Region],count([District]) as [District],count([CB_REG]) as [CB_REG],count([CB_RURAL]) as [CB_RURAL],count([URBANICITY]) as [URBANICITY]
------ ,sum([AGE_GROUP]) as [AGE_GROUP],sum([CB_REG]) as [CB_REG],sum([CB_RURAL]) as [CB_RURAL],sum([FDO_FISCAL_2015]) as [FDO_FISCAL_2015],sum([freq_shop]) as [freq_shop],sum([MONTHX]) as [MONTHX],sum([MRK_FDO]) as [MRK_FDO],sum([Q10_GRID_01_Q10]) as [Q10_GRID_01_Q10],sum([Q100]) as [Q100],sum([Q101_GRID_01_Q101]) as [Q101_GRID_01_Q101],sum([Q101_GRID_02_Q101]) as [Q101_GRID_02_Q101],sum([Q101_GRID_03_Q101]) as [Q101_GRID_03_Q101],sum([Q102]) as [Q102],sum([Q105]) as [Q105],sum([Q106]) as [Q106],sum([Q107]) as [Q107],sum([Q108]) as [Q108],sum([Q109]) as [Q109],sum([Q115_GRID_01_Q115]) as [Q115_GRID_01_Q115],sum([Q115_GRID_02_Q115]) as [Q115_GRID_02_Q115],sum([Q116_GRID_01_Q116]) as [Q116_GRID_01_Q116],sum([Q116_GRID_02_Q116]) as [Q116_GRID_02_Q116],sum([Q116_GRID_03_Q116]) as [Q116_GRID_03_Q116],sum([Q117_GRID_01_Q117]) as [Q117_GRID_01_Q117],sum([Q117_GRID_02_Q117]) as [Q117_GRID_02_Q117],sum([Q117_GRID_03_Q117]) as [Q117_GRID_03_Q117],sum([Q117_GRID_04_Q117]) as [Q117_GRID_04_Q117],sum([Q117_GRID_05_Q117]) as [Q117_GRID_05_Q117],sum([Q117_GRID_06_Q117]) as [Q117_GRID_06_Q117],sum([Q117_GRID_07_Q117]) as [Q117_GRID_07_Q117],sum([Q118]) as [Q118],sum([Q12A]) as [Q12A],sum([Q12C]) as [Q12C],sum([Q12D]) as [Q12D],sum([Q13]) as [Q13],sum([Q1401]) as [Q1401],sum([Q1402]) as [Q1402],sum([Q1403]) as [Q1403],sum([Q1404]) as [Q1404],sum([Q1405]) as [Q1405],sum([Q1406]) as [Q1406],sum([Q1407]) as [Q1407],sum([Q15]) as [Q15],sum([Q16]) as [Q16],sum([Q4_GRID_0_Q4]) as [Q4_GRID_0_Q4],sum([Q5_GRID_01_Q5]) as [Q5_GRID_01_Q5],sum([Q5_GRID_02_Q5]) as [Q5_GRID_02_Q5],sum([Q5_GRID_03_Q5]) as [Q5_GRID_03_Q5],sum([Q63]) as [Q63],sum([Q64]) as [Q64],sum([Q7_GRID_01_Q7]) as [Q7_GRID_01_Q7],sum([Q7_GRID_02_Q7]) as [Q7_GRID_02_Q7],sum([Q7_GRID_03_Q7]) as [Q7_GRID_03_Q7],sum([Q7_GRID_04_Q7]) as [Q7_GRID_04_Q7],sum([Q7_GRID_05_Q7]) as [Q7_GRID_05_Q7],sum([Q72_A01]) as [Q72_A01],sum([Q72_A02]) as [Q72_A02],sum([Q72_A03]) as [Q72_A03],sum([Q72_A04]) as [Q72_A04],sum([Q72_A05]) as [Q72_A05],sum([Q72_A06]) as [Q72_A06],sum([Q72_A07]) as [Q72_A07],sum([Q72_A08]) as [Q72_A08],sum([Q72_A09]) as [Q72_A09],sum([Q72_A10]) as [Q72_A10],sum([Q72_A11]) as [Q72_A11],sum([Q7201]) as [Q7201],sum([Q7202]) as [Q7202],sum([Q7203]) as [Q7203],sum([Q7204]) as [Q7204],sum([Q7205]) as [Q7205],sum([Q7206]) as [Q7206],sum([Q7207]) as [Q7207],sum([Q7208]) as [Q7208],sum([Q7209]) as [Q7209],sum([Q7210]) as [Q7210],sum([Q7211]) as [Q7211],sum([Q7212]) as [Q7212],sum([Q7213]) as [Q7213],sum([Q8_GRID_01_Q8]) as [Q8_GRID_01_Q8],sum([Q8_GRID_02_Q8]) as [Q8_GRID_02_Q8],sum([Q8_GRID_03_Q8]) as [Q8_GRID_03_Q8],sum([Q8_GRID_04_Q8]) as [Q8_GRID_04_Q8],sum([Q9_GRID_01_Q9]) as [Q9_GRID_01_Q9],sum([Q91A_GRID_01_Q91A]) as [Q91A_GRID_01_Q91A],sum([Q91A_GRID_02_Q91A]) as [Q91A_GRID_02_Q91A],sum([Q91A_GRID_03_Q91A]) as [Q91A_GRID_03_Q91A],sum([Q91A_GRID_04_Q91A]) as [Q91A_GRID_04_Q91A],sum([Q91A_GRID_05_Q91A]) as [Q91A_GRID_05_Q91A],sum([Q91B_GRID_06_Q91B]) as [Q91B_GRID_06_Q91B],sum([Q91B_GRID_07_Q91B]) as [Q91B_GRID_07_Q91B],sum([Q91B_GRID_08_Q91B]) as [Q91B_GRID_08_Q91B],sum([Q91B_GRID_10_Q91B]) as [Q91B_GRID_10_Q91B],sum([Q91B_GRID_11_Q91B]) as [Q91B_GRID_11_Q91B],sum([Q91C_GRID_09_Q91C]) as [Q91C_GRID_09_Q91C],sum([Q91C_GRID_12_Q91C]) as [Q91C_GRID_12_Q91C],sum([Q91C_GRID_13_Q91C]) as [Q91C_GRID_13_Q91C],sum([Q91C_GRID_14_Q91C]) as [Q91C_GRID_14_Q91C],sum([Q91D_GRID_15_Q91D]) as [Q91D_GRID_15_Q91D],
------ sum([QCB3]) as [QCB3],sum([QCB4]) as [QCB4],sum([QUARTER_NEW]) as [QUARTER_NEW],sum([RACE_ETH]) as [RACE_ETH],sum([URBANICITY]) as [URBANICITY],sum([YEAR_NEW]) as [YEAR_NEW]
------   from  [dbo].[Data_2014Q23$Victor]  
------   group by  year_new ;


------   select sum(case when  Q5_GRID_03_Q5 in(6,7) then [weight] end),sum(case when  Q5_GRID_03_Q5 between 1 and 7 then 1 else null end) from [dbo].[tb_RawData] where year_new=2  and [district] is not null and quarter_new=10

------ select count(*) from [dbo].[tb_RawData] where year_new=2  and [district] is not null and Q5_GRID_03_Q5 between 1 and 7

------ select * from [dbo].[Questionnaire3] where   Trend='1' and [Variable name]='Q5_GRID_03_Q5'


------ select     TopNbox from [dbo].[Questionnaire3] where Trend='1' 
------ sp_help'[dbo].[Variable_Values]'


------ select definition,object_name(object_id) from sys.sql_modules where definition like '%[dbo].[v_dashboard_topbot_CASHAttr_Variable]%'

------update a 
------set Mid3Box=b.Mid3Box,Bot2Box=b.Bot2Box
------from  [dbo].[Headline_Variable] a inner join  [dbo].[Questionnaire3] b
------ on a.variable=b.[variable name]
 
------ select *   from [dbo].[Headline_Variable] a inner join  [dbo].[Questionnaire3] b
------ on a.variable=b.[variable name]

------ select * from  [dbo].[v_dashboard_scoring_trending_CASH_var]




 
------;with t as (
------select a.[Variable Name] Variable,a.TopNbox,b.max_value_valid,b.min_value_valid from  [dbo].[Questionnaire] a inner join [dbo].[Variables] b on a.[Variable Name]=b.Variable
------where a.trend is null and a.[Variable name] is not null  and a.MId3box is null and a.Bot2Box is null and a.score is not null
------)
------select t.variable,c.value,c.value_label from [dbo].[Variable_Values] c inner join t on c.Variable=t.Variable
------and c.Valid=1

--------select * from  [dbo].[Variables]
------; with v as (
------select Variable,max(value) a,min(value) i from [dbo].[Variable_Values] where valid=1
------group by Variable)
------update a
------set a.max_value_valid=v.a,a.min_value_valid=v.i
--------select * 
------from  [dbo].[Questionnaire] q inner join v on q.[Variable Name]=v.variable
------inner join Variables a on v.variable=a.variable
------where q.trend is null and q.[Variable name] is not null  and q.MId3box is null and q.Bot2Box is null and q.score is not null





------select * from [dbo].[tb_Userlist] where username='CMcginnis@FAMILYDOLLAR.com'


----------insert into [dbo].[tb_Userlist](UserName,Password,Permission_level)
----------select *,'Fd72xjdb','Chain access' from (values('MDEVENNEY@FAMILYDOLLAR.COM'),('DTANEJA@FAMILYDOLLAR.COM'),('MSANGAM@FAMILYDOLLAR.COM'),(
----------'JLAVENDER@FAMILYDOLLAR.COM'),('JJANKY@FAMILYDOLLAR.COM'),('NKEARNS@FAMILYDOLLAR.COM'),('TSOMERSET@FAMILYDOLLAR.COM')) as t(username)


------select username,count(*) from [dbo].[tb_Userlist]
------group by username order by 2


------select count(*) from [dbo].[v_RawData_Hierarchy] where Q9_GRID_01_Q9 >=1 and Q9_GRID_01_Q9<=7 and quarter_new=10 
------select count(*) from [dbo].[v_RawData_Hierarchy] where Q9_GRID_01_Q9 >=6 and Q9_GRID_01_Q9<=7 and quarter_new=10 

------select * from [dbo].[Questionnaire] 

 
 
----------alter table [dbo].[Questionnaire] add L3_Order int
--------;with c as (select L3,max(id) a,min(id) i from [dbo].[Questionnaire] group by L3)
--------,d as (select dense_rank() over(order by i) r,q.L3 from  [dbo].[Questionnaire] q inner join c on q.L3=c.L3)
--------update a
--------set a.L3_Order=d.r
--------from [dbo].[Questionnaire] a inner join d on a.L3=d.L3


------sp_refreshview '[dbo].[V_KPI]'


------select * from [dbo].[Variable_Values] where QUARTER_NEW

 select distinct password ,permission_level from [dbo].[tb_Userlist]
 select * from tb_userlist where username='long.chen'
 --select * into   [dbo].[tb_Userlist_20150624BAK]from [dbo].[tb_Userlist]

--INSERT INTO [dbo].[tb_Userlist]
--           ([Username],[Password] ,[FirstName],[Permission_level],[Group] ,[Region],[District],[Store] ,[EMPLOYEE_NUMBER])
--select      [EMAIL_ADDRESS],'Fd72xjdb',[FULL_NAME],'Field access',[GROUP],[REGION],[DISTRICT] ,[STORE],[EMPLOYEE_NUMBER]
--from (values
--(N'1051920',N'SIVAK, STUART',N'SSIVAK@FAMILYDOLLAR.com',N'04970',N'0040',N'19',NULL)
--,(N'1053036',N'SUSMAN, HARRY',N'HSUSMAN2@FAMILYDOLLAR.com',N'10305',N'0060',N'13',NULL)
--,(N'1053212',N'MARTIN, DARRELL',N'DMARTIN@FAMILYDOLLAR.com',N'09200',N'0020',N'45',NULL)
--) t([EMPLOYEE_NUMBER],[FULL_NAME],[EMAIL_ADDRESS],[STORE],[GROUP],[REGION],[DISTRICT])



--update a 
--set [Group]=b.[Group],[Region]=b.[Region],District=b.District,store=b.store
--from tb_userlist a inner join (
--select [EMPLOYEE_NUMBER],[FULL_NAME],[EMAIL_ADDRESS],[GROUP],[DISTRICT] ,Region=null,store=null
--from (values
--(N'1001877',N'ALARCON, CARLOS',N'CALARCON@FAMILYDOLLAR.com',N'0060',N'170')
--,(N'1039451',N'SPATZ, LEIGH ANN',N'LSPATZ@FAMILYDOLLAR.com',N'0040',N'179')
--,(N'289845',N'LABUZ, MELISSA K',N'MLABUZ@FAMILYDOLLAR.com',N'0010',N'490')
--,(N'483531',N'LUCAS, TIMOTHY M',N'TLUCAS@FAMILYDOLLAR.com',N'0030',N'455')
--,(N'516819',N'HAIR, JENNIFER',NULL,N'0060',N'173')
--,(N'609484',N'KOSKELA-VISCONTI, AMY L',N'AKOSKELA-VISCONTI@FAMILYDOLLAR.com',N'0010',N'100')
--,(N'644432',N'WAGNER, PETER J',N'PWAGNER@FAMILYDOLLAR.com',N'0010',N'301')
--,(N'652758',N'DAMICO, SALVATORE J',N'SDAMICO@FAMILYDOLLAR.com',N'0040',N'359')
--,(N'681571',N'UGUZ, SEDAT H',N'SUGUZ@FAMILYDOLLAR.com',N'0040',N'359')
--,(N'702863',N'WILSON, TODD E',N'TWILSON2@FAMILYDOLLAR.com',N'0060',N'411')
--,(N'716182',N'AST, NATHAN K',N'NAST@FAMILYDOLLAR.com',N'0060',N'508')
--,(N'733350',N'MAKEDONSKI, ANDREA S',N'AMAKEDONSKI@FAMILYDOLLAR.com',N'0060',N'377')
--,(N'810405',N'MCLAUGHLIN, WILLIAM J',N'WMcLaughlin@FAMILYDOLLAR.com',NULL,NULL)
--,(N'822813',N'YIM, CHONG ILL',N'JYIM@FAMILYDOLLAR.com',NULL,NULL)
--,(N'861733',N'CHIAPELLI, CRYSTAL G',N'CCHIAPELLI@FAMILYDOLLAR.com',N'0040',N'179')
--,(N'894911',N'FILLINGIM, DAVID P',N'DFILLINGIM@FAMILYDOLLAR.com',N'0040',N'451')
--,(N'913545',N'GRIESBAUM, LISA N',NULL,N'0010',NULL)
--) t([EMPLOYEE_NUMBER],[FULL_NAME],[EMAIL_ADDRESS],[GROUP],[DISTRICT])
--) b on a.username=b.[EMAIL_ADDRESS]

--INSERT INTO [dbo].[tb_Userlist]
--           ([Username],[Password] ,[FirstName],[Permission_level],[Group] ,[Region],[District],[Store] ,[EMPLOYEE_NUMBER])
--select b.[EMAIL_ADDRESS],'Fd72xjdb',b.[FULL_NAME],'Field access',b.[GROUP],b.[REGION],b.[DISTRICT] ,b.[STORE],b.[EMPLOYEE_NUMBER]
--from tb_userlist a right join (
--select [EMPLOYEE_NUMBER],[FULL_NAME],[EMAIL_ADDRESS],[GROUP],[DISTRICT] ,Region=null,store=null
--from (values
--(N'1001877',N'ALARCON, CARLOS',N'CALARCON@FAMILYDOLLAR.com',N'0060',N'170')
--,(N'1039451',N'SPATZ, LEIGH ANN',N'LSPATZ@FAMILYDOLLAR.com',N'0040',N'179')
--,(N'289845',N'LABUZ, MELISSA K',N'MLABUZ@FAMILYDOLLAR.com',N'0010',N'490')
--,(N'483531',N'LUCAS, TIMOTHY M',N'TLUCAS@FAMILYDOLLAR.com',N'0030',N'455')
--,(N'516819',N'HAIR, JENNIFER',NULL,N'0060',N'173')
--,(N'609484',N'KOSKELA-VISCONTI, AMY L',N'AKOSKELA-VISCONTI@FAMILYDOLLAR.com',N'0010',N'100')
--,(N'644432',N'WAGNER, PETER J',N'PWAGNER@FAMILYDOLLAR.com',N'0010',N'301')
--,(N'652758',N'DAMICO, SALVATORE J',N'SDAMICO@FAMILYDOLLAR.com',N'0040',N'359')
--,(N'681571',N'UGUZ, SEDAT H',N'SUGUZ@FAMILYDOLLAR.com',N'0040',N'359')
--,(N'702863',N'WILSON, TODD E',N'TWILSON2@FAMILYDOLLAR.com',N'0060',N'411')
--,(N'716182',N'AST, NATHAN K',N'NAST@FAMILYDOLLAR.com',N'0060',N'508')
--,(N'733350',N'MAKEDONSKI, ANDREA S',N'AMAKEDONSKI@FAMILYDOLLAR.com',N'0060',N'377')
--,(N'810405',N'MCLAUGHLIN, WILLIAM J',N'WMcLaughlin@FAMILYDOLLAR.com',NULL,NULL)
--,(N'822813',N'YIM, CHONG ILL',N'JYIM@FAMILYDOLLAR.com',NULL,NULL)
--,(N'861733',N'CHIAPELLI, CRYSTAL G',N'CCHIAPELLI@FAMILYDOLLAR.com',N'0040',N'179')
--,(N'894911',N'FILLINGIM, DAVID P',N'DFILLINGIM@FAMILYDOLLAR.com',N'0040',N'451')
--,(N'913545',N'GRIESBAUM, LISA N',NULL,N'0010',NULL)
--) t([EMPLOYEE_NUMBER],[FULL_NAME],[EMAIL_ADDRESS],[GROUP],[DISTRICT]) where email_address is not null
--) b on a.username=b.[EMAIL_ADDRESS] where a.username is null
 
--delete a  from tb_Userlist a inner join (
--select * from (values 
--(N'1002546',N'MCBROOM, TODD C',N'TMCBROOM@FAMILYDOLLAR.com',N'02542',N'0030',N'07',N'273')
--,(N'1007287',N'HAYHURST, CHARLENE',N'CHAYHURST@FAMILYDOLLAR.com',N'05199',N'0060',N'29',N'092')
--,(N'27411',N'TANGER, RUSSELL L',N'RTANGER@FAMILYDOLLAR.com',N'05127',N'0030',N'18',NULL)
--,(N'441963',N'LOPEZ-SALDIVAR, EDITH A',N'MLOPEZ@FAMILYDOLLAR.COM',N'03326',N'0030',N'07',N'218')
--,(N'600994',N'MOWEN, DARRELL',N'DMOWEN@FAMILYDOLLAR.com',N'10305',N'0060',N'13',NULL)
--,(N'633025',N'STITT, KAREN A',N'KSTITT@FAMILYDOLLAR.com',N'08694',N'0030',N'46',N'058')
--,(N'727704',N'OLIVER, CHARLES L',N'COLIVER@FAMILYDOLLAR.com',N'08694',N'0030',N'46',N'058')
--,(N'810406',N'ALMOND, LINDSAY DAVENPORT',N'LALMOND@FAMILYDOLLAR.com',N'09100',NULL,NULL,NULL)
--,(N'822813',N'YIM, CHONG ILL',N'JYIM@FAMILYDOLLAR.com',N'09600',NULL,NULL,NULL)
--,(N'921925',N'HICKOK, JOEL',N'JHICKOK@FAMILYDOLLAR.com',N'03660',N'0030',N'07',N'088')
--,(N'937983',N'FRENCH, DANIEL EDWARD',N'DFRENCH@FAMILYDOLLAR.com',N'04903',N'0030',N'42',N'303')
--,(N'998904',N'MOXHAM, EVAN MARK (Evan)',N'EMOXHAM@FAMILYDOLLAR.com',N'03115',N'0040',N'19',N'145')
--) t([EMPLOYEE_NUMBER],[FULL_NAME],[EMAIL_ADDRESS],[STORE],[GROUP],[REGION],[DISTRICT])
--) b on a.username=b.email_address
select top 1 * from tb_Userlist

--INSERT INTO [dbo].[tb_Userlist]
--           ([LastName],[FirstName],[Username],[Password] ,[Permission_level],jobTitel,[Group] ,[Region],[District],[Store])
--select [Last Name],[First Name],[Email Address],'Fd72xjdb','HRM access',[Title],case when [Level of Access] like 'Group %' then replace([Level of Access],'Group','') end,
--case when [Level of Access] like 'Region %' then replace([Level of Access],'Region','') end,
--case when [Level of Access] like 'District %' then replace([Level of Access],'District','') end,
--case when [Level of Access] like 'Store %' then replace([Level of Access],'Store','') end

-- from (values
--(N'Allen',N'Julia',N'jallen@familydollar.com',N'HRM Admin',N'Region 45')
--,(N'Bellizan',N'Cindy',N'cbellizan@familydollar.com',N'HRM Admin',N'Region 48')
--,(N'Botkin',N'Carey',N'cbotkin@familydollar.com',N'HRM Admin',N'Region 42')
--,(N'Brown',N'Sheila',N'sbrown5@familydollar.com',N'HRM Admin',N'Region 13')
--,(N'Brown',N'Sheila',N'sbrown5@familydollar.com',N'HRM Admin',N'Region 33')
--,(N'Claiborne',N'Diana',N'dclaiborne@familydollar.com',N'HRM Admin',N'Region 39')
--,(N'Diaz',N'Sara',N'sdiaz@familydollar.com',N'HRM Admin',N'Region 7')
--,(N'Dilworth',N'Shannon',N'sdilworth@familydollar.com',N'HRM Admin',N'Region 5')
--,(N'Feathers',N'Wendy',N'wfeathers@familydollar.com',N'HRM Admin',N'Region 16')
--,(N'Feathers',N'Wendy',N'wfeathers@familydollar.com',N'HRM Admin',N'Region 44')
--,(N'France',N'Rosie',N'rfrance@familydollar.com',N'HRM Admin',N'Region 8')
--,(N'Gonzalez',N'Genesis',N'ggonzalez@familydollar.com',N'HRM Admin',N'Region 2')
--,(N'Hornung',N'Cheryl',N'chornung@familydollar.com',N'HRM Admin',N'Region 9')
--,(N'Houston',N'Kim',N'khouston@familydollar.com',N'HRM Admin',N'Region 24')
--,(N'Kim-Dunlap',N'Su',N'skim-dunlap@familydollar.com',N'HRM Admin',N'Region 35')
--,(N'Lefebvre',N'Mandy',N'alefebvre@familydollar.com',N'HRM Admin',N'Region 38')
--,(N'Madden',N'Joani',N'jmadden@familydollar.com',N'HRM Admin',N'Region 29')
--,(N'Madden',N'Joani',N'jmadden@familydollar.com',N'HRM Admin',N'Region 49')
--,(N'McClurg',N'Kelly',N'kmcclurg@familydollar.com',N'HRM Admin',N'Region 41')
--,(N'McIntyre',N'Denise',N'dmcintyre@familydollar.com',N'HRM Admin',N'Region 32')
--,(N'Moffat',N'Trina',N'tmoffat@familydollar.com',N'HRM Admin',N'Region 22')
--,(N'Moore',N'Tamara',N'tmoore2@familydollar.com',N'HRM Admin',N'Region 1')
--,(N'Moore',N'Tamara',N'tmoore2@familydollar.com',N'HRM Admin',N'Region 21')
--,(N'Moore',N'Jackie',N'jmoore@familydollar.com',N'HRM Admin',N'Region 3')
--,(N'Roberts',N'Nancy',N'nroberts@familydollar.com',N'HRM Admin',N'Region 18')
--,(N'Rosensky',N'Bonnie',N'brosensky@familydollar.com',N'HRM Admin',N'Region 10')
--,(N'Rowland',N'Margo',N'mrowland@familydollar.com',N'HRM Admin',N'Region 27')
--,(N'Rule',N'Candie',N'crule@familydollar.com',N'HRM Admin',N'Region 47')
--,(N'Rush',N'Nancy',N'nrush@familydollar.com',N'HRM Admin',N'Region 19')
--,(N'Schmitz',N'Cindy',N'cschmitz@familydollar.com',N'HRM Admin',N'Region 43')
--,(N'Schmitz',N'Cindy',N'cschmitz@familydollar.com',N'HRM Admin',N'Region 37')
--,(N'Sheldon',N'Janice',N'jsheldon@familydollar.com',N'HRM Admin',N'Region 28')
--,(N'Spratley',N'Denise',N'dspratley@familydollar.com',N'HRM Admin',N'Region 14')
--,(N'Stuart',N'Pat',N'pstuart@familydollar.com',N'HRM Admin',N'Region 12')
--,(N'Stuart',N'Pat',N'pstuart@familydollar.com',N'HRM Admin',N'Region 40')
--,(N'Walker-Powers',N'Tanya',N'twalker-powers@familydollar.com',N'HRM Admin',N'Region 46')
--,(N'Washington',N'Misty',N'mwright@familydollar.com',N'HRM Admin',N'Region 23')
--,(N'Ais',N'Farrah',N'fais@familydollar.com',N'HRM',N'Group 50')
--,(N'Ais',N'Farrah',N'fais@familydollar.com',N'HRM',N'Group 20')
--,(N'Brown',N'Lisa',N'lbrown3@familydollar.com',N'HRM',N'Group 60')
--,(N'Canella',N'Monita',N'mcanella@familydollar.com',N'HRM',N'Group 10')
--,(N'Citarella',N'Fred',N'acitarella@familydollar.com',N'HRM',N'Group 40')
--,(N'Crawford',N'Larry',N'lcrawford@familydollar.com',N'HRM',N'Group 30')
--,(N'Criswell',N'Jennifer',N'lcrawford@familydollar.com',N'HRM',N'Group 10')
--,(N'Criswell',N'Jennifer',N'jcriswell@familydollar.com',N'HRM',N'Group 60')
--,(N'Cunningham',N'Mary',N'mcunningham@familydollar.com',N'HRM',N'Group 10')
--,(N'Devree',N'Mark',N'mdevree@familydollar.com',N'HRM',N'Group 10')
--,(N'Dickens',N'Jenny',N'jdickins2@familydollar.com',N'HRM',N'Group 30')
--,(N'Hoke',N'Gary',N'ghoke@familydollar.com',N'HRM',N'Group 50')
--,(N'Johnson',N'Leticia',N'lbrisco@familydollar.com',N'HRM',N'Group 20')
--,(N'Koh',N'Andrew',N'akoh@familydollar.com',N'HRM',N'Group 30')
--,(N'La Barrie',N'Rachel',N'rlabarrie@familydollar.com',N'HRM',N'Group 20')
--,(N'Lance',N'Angel',N'slance@familydollar.com',N'HRM',N'Group 20')
--,(N'Lance',N'Angel',N'slance@familydollar.com',N'HRM',N'Group 50')
--,(N'Mendez',N'Marcos',N'mmendez2@familydollar.com',N'HRM',N'Group 50')
--,(N'Mendez',N'Marcos',N'mmendez2@familydollar.com',N'HRM',N'Group 30')
--,(N'Olivier',N'Ashlee',N'aolivier@familydollar.com',N'HRM',N'Group 50')
--,(N'Owens',N'Bill',N'wowens@familydollar.com',N'HRM',N'Group 20')
--,(N'Reimers',N'Michelle',N'mreimers@familydollar.com',N'HRM',N'Group 30')
--,(N'Sheridan',N'Dawn',N'dsheridan@familydollar.com',N'HRM',N'Group 60')
--,(N'Stigall',N'Stephanie',N'sstigall@familydollar.com',N'HRM',N'Group 50')
--,(N'Tarkenton',N'Stephanie',N'starkenton@familydollar.com',N'HRM',N'Group 40')
--,(N'Tyler',N'Jennifer',N'jtyler2@familydollar.com',N'HRM',N'Group 40')
--,(N'Wardlow',N'D''Amon',N'dwardlow@familydollar.com',N'HRM',N'Group 60')
--,(N'Wilburn',N'Erin',N'ewilburn@familydollar.com',N'HRM',N'Group 10')
--) t([Last Name],[First Name],[Email Address],[Title],[Level of Access])


------select username,count(*) from tb_Userlist 
------group by username order by 2 desc

--------select * into [dbo].[Questionnaire_20150401BAK]  from [dbo].[Questionnaire] 

------select * from [dbo].[Questionnaire] 
--------update  [dbo].[Questionnaire] set TopNbox='2',Bot2Box='1'
------where trend=1 and Label like 'Did you%' and [variable name]='Q100'

------select * from [dbo].[Questionnaire] 
------where trend=1 and Label in( 'School & Office Supplies','Toys & Games','Party Goods')


--------update [dbo].[Questionnaire] 
--------set Label='Toys & Games'
--------where trend=1 and Label in( 'School & Office Supplies')
--------and [Variable Name]='Q91B_GRID_10_Q91B'

--------update [dbo].[Questionnaire] 
--------set Label='Party Goods'
--------where trend=1 and Label in( 'Toys & Games')
--------and [Variable Name]='Q91B_GRID_11_Q91B'

--------update [dbo].[Questionnaire] 
--------set Label='School & Office Supplies'
--------where trend=1 and Label in( 'Party Goods')
--------and [Variable Name]='Q91C_GRID_09_Q91C'

------select * from [dbo].[Variable_Values] where [variable]='Q100'

------select * from [dbo].[KPICalcs] where variable='Q7_GRID_02_Q7'
------select * from [dbo].[Hierarchy] where store=721  --- 10	14	427	721
------ select count(distinct [Group]) g ,count(distinct Region) r,count(distinct District) d,count(Distinct Q2_1) s from  [dbo].[v_RawData_Hierarchy]

------  select count(distinct [Group]) g ,count(distinct Region) r,count(distinct District) d,count(Distinct Q2_1) s from  [dbo].[tb_RawData]  where quarter_new=10

------  select  quotename(variable) +',' from Variables where position>130 for xml path('')

------select * from trends_head   

------select * from [dbo].[tb_RawData]

------select distinct  L3_Order , QuestionOrder, id from trends_head   

 
------ [p_get_Trend_test] 3,10,-1,'',-1,-1,-1,-1

------ select top 1 * from tb_rawdata

------ ---create index ix_nc_tb_rawdata_Respondent_id on tb_rawdata(Respondent_ID,[QUARTER_NEW])


------ 	select  ',
------					 ( sum(case when '+quotename(Variable)+' in('+a.TopNbox+')  then [weight] else 0.0 end)		 
------					  /nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0)   ) as '+quotename(Variable) 

------  from [KPICalcs] a     where a.L2='CASH CALCULATION'  for xml path('')


------  select * from [v_dashboard_scoring_trending_CASH_var]
  
  
------  [v_dashboard_scoring_trending_CASH_var]

------  select object_name(object_id),definition from sys.sql_modules where    (object_id) =object_id( '[dbo].[p_get_DashBoard_TrackedKPI]')

------  select sum(case when Q7_GRID_02_Q7 >=1 and Q7_GRID_02_Q7<=7 then 1 else 0 end ),
------		sum(case when Q7_GRID_02_Q7 >=6 and Q7_GRID_02_Q7<=7 then 1 else 0 end) 
------		from [dbo].[tb_RawData]  where quarter_new=10


------		select *from tb_userlist


------		--update statistics

------		--sp_updatestats

 

------   concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  )

------   select iif(1=2,1,2)
------   select distinct Variable from [dbo].[KPICalcs] where kpi='Customer CASH Score'


------   select  concat('union all select cast(' ,ID+1,' as int)  AS ID,cast(''',Scale,''' as nvarchar(30)) AS Scale')+char(10) from [dbo].[Trend_Scale_Breakdown] for xml path('')
   
  

----------select * into [dbo].[Trend_Scale_Breakdown] 
----------from (
----------  select cast(1 as int)  AS ID,cast('' as nvarchar(30)) AS Scale
----------union all select cast(2 as int)  AS ID,cast('BASE' as nvarchar(30)) AS Scale
----------union all select cast(5 as int)  AS ID,cast('Negative' as nvarchar(30)) AS Scale
----------union all select cast(4 as int)  AS ID,cast('Neutral' as nvarchar(30)) AS Scale
----------union all select cast(3 as int)  AS ID,cast('Positive' as nvarchar(30)) AS Scale

----------) t
------  select * from [dbo].[trends_head] where L3='EMPLOYEE SPECIFIC QUESTIONS'
------ select *  from [dbo].[Trend_Scale_Breakdown] 
------ select quotename(Position) p  from [dbo].[Questionnaire] where trend=1 and L3='EMPLOYEE SPECIFIC QUESTIONS' and [Variable Name]='Q100'
  
------ select * from [dbo].[Variable_Values] where Variable='q100'
------ sp_help'[dbo].[p_get_KpiBreakdown]'


------ select sum(case when Q100=2 then [weight] else 0.0 end)/sum(case when Q100 in(1,2) then [weight] end),sum(case when Q100 in(1,2) then [weight] end) from tb_rawdata where year_new=3 and Q100 in(1,2)

------ Position

------	select quotename(name),max_length,type_name(user_type_id) from sys.columns where object_id=object_id( 'tb_rawdata') 

------	select max(len( [MRK_SEG1])) from tb_rawdata

   
------	select ','+quotename([variable Name]) from [dbo].[Questionnaire] where   Trend=null for xml path('')
 
------     select object_name(object_id) , [definition] from sys.sql_modules
------	 where  [definition] like '%Questionnaire%' and object_name(object_id) not like '%BAK' 
------	 object_id=object_id('')object_name(object_id) 

------ [p_get_KpiBreakdown_base] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1

------ select *    from [dbo].[Headline_Variable]

------ select ','+quotename(value)+' as [FY'+left(stuff(value_label,1,4,''),6)+left(value_label,2)+']' from  [dbo].[Variable_Values] where Variable='QUARTER_NEW'  
------ for xml path('')


------ select count([group]) from tb_rawdata where quarter_new=10
 
------------ /* 
------------   author victor zhang
------------   date  20150403
------------ */
------------ create  View  V_Year_Quarter
------------ as 
------------    with y as (select  Value Year_ID,Value_label as Year_new from [dbo].[Variable_Values] where Variable='YEAR_NEW')
------------,q as (select  Value as Qrt_ID,right(left(Value_label,2),1) as Quarter_New,left(stuff(value_label,1,5,''),4) as Year_New from  [dbo].[Variable_Values] where Variable='QUARTER_NEW' )
------------select y.*,q.Qrt_ID,q.Quarter_New
------------from y inner join q on y.year_new=q.Year_new


------------update q
------------set q.label=t.label
------------from (
------------select 'Overall Satisfaction' as label,'Q4_GRID_0_Q4' as variable
------------union select 'Will return to shop FD' as label,'Q5_GRID_01_Q5' as variable
------------union select 'Will recommend FD to family/friends' as label,'Q5_GRID_02_Q5' as variable
------------union select 'Prefer FD for quick trip where I spend <$20' as label,'Q5_GRID_03_Q5' as variable
------------union select 'CASH STORE STANDARDS' as label,'' as variable
------------union select 'Aisles clear of boxes' as label,'Q7_GRID_01_Q7' as variable
------------union select 'Coolers clean' as label,'Q7_GRID_02_Q7' as variable
------------union select 'Entrance/check-out clear' as label,'Q7_GRID_03_Q7' as variable
------------union select 'Floors clean' as label,'Q7_GRID_04_Q7' as variable
------------union select 'Pleasant/neutral scent' as label,'Q7_GRID_05_Q7' as variable
------------union select 'Products in-stock' as label,'Q8_GRID_01_Q8' as variable
------------union select 'Prices clearly marked' as label,'Q8_GRID_02_Q8' as variable
------------union select 'Products in proper place organized' as label,'Q8_GRID_03_Q8' as variable
------------union select 'Packaging in good condition' as label,'Q8_GRID_04_Q8' as variable
------------union select 'Employees friendly' as label,'Q9_GRID_01_Q9' as variable
------------union select 'Greeted by employee' as label,'Q12A' as variable
------------union select 'Thanked for purchase' as label,'Q12C' as variable
------------union select 'Employee offered help' as label,'Q12D' as variable
------------union select 'Speed of check-out' as label,'Q10_GRID_01_Q10' as variable
------------union select 'AGREE THAT FAMILY DOLLAR HAS A WIDE VARIETY OF….' as label,'' as variable
------------union select 'Food' as label,'Q91A_GRID_01_Q91A' as variable
------------union select 'Cleaning/Laundry/Paper Products' as label,'Q91A_GRID_02_Q91A' as variable
------------union select 'Pet Products' as label,'Q91A_GRID_03_Q91A' as variable
------------union select 'Health/Beauty Products' as label,'Q91A_GRID_04_Q91A' as variable
------------union select 'Baby Care Items' as label,'Q91A_GRID_05_Q91A' as variable
------------union select 'Infant/Children''s Clothing' as label,'Q91B_GRID_06_Q91B' as variable
------------union select 'Adult Clothing' as label,'Q91B_GRID_07_Q91B' as variable
------------union select 'Housewares/Home Décor' as label,'Q91B_GRID_08_Q91B' as variable
------------union select 'Toys/Games' as label,'Q91B_GRID_10_Q91B' as variable
------------union select 'Party Goods' as label,'Q91B_GRID_11_Q91B' as variable
------------union select 'School/Office Supplies' as label,'Q91C_GRID_09_Q91C' as variable
------------union select 'Automotive/Hardware Products' as label,'Q91C_GRID_12_Q91C' as variable
------------union select 'Small Electronics/Phones/Accessories' as label,'Q91C_GRID_13_Q91C' as variable
------------union select 'Seasonal Items' as label,'Q91C_GRID_14_Q91C' as variable
------------union select 'EMPLOYEE SPECIFIC QUESTIONS' as label,'' as variable
------------union select 'Employees talking/texting on cell phone' as label,'Q100' as variable
------------union select 'Wearing red FD shirt' as label,'Q101_GRID_01_Q101' as variable
------------union select 'Wearing name tag' as label,'Q101_GRID_02_Q101' as variable
------------union select 'Completely focused during check-out' as label,'Q101_GRID_03_Q101' as variable
------------union select 'Cashier pointed out survey' as label,'Q102' as variable
------------) t  inner join [dbo].[Questionnaire] q on t.variable !='' and t.variable=q.[variable Name]
------------and q.trend=1
 

------select ','+quotename(Qrt_ID)+',['+concat(Qrt_ID,'!Base]')  from V_Year_Quarter where year_id=3 for xml path('')



------	 select quotename([variable Name])+','+char(10) from (
------	 select distinct [variable Name] from  [dbo].[Questionnaire] where trend =1 or [kpi BreakDown]=1 or dashboard=1) t for xml path('')

------ --drop index    on [dbo].[tb_RawData] 
  

-------- drop index [ix_nc_Headline_Variable_title] on [dbo].[Headline_Variable]
-------- drop index  [ix_nc_Headline_Variable_Var] on [dbo].[Headline_Variable]
--------ALTER TABLE [dbo].[Headline_Variable] drop   CONSTRAINT [PK_ID]


--------alter table [dbo].[Headline_Variable] alter column Variable nvarchar(50) not null
--------alter table [dbo].[Headline_Variable] alter column TopNbox nvarchar(20)  
 
--------ALTER TABLE [dbo].[Headline_Variable] ADD  CONSTRAINT [PK_ID] PRIMARY KEY CLUSTERED 
--------(
--------	[id] ASC
--------)
 
--------CREATE NONCLUSTERED INDEX [ix_nc_Headline_Variable_Var] ON [dbo].[Headline_Variable]
--------(
--------	[variable] ASC
--------) 
 
--------CREATE NONCLUSTERED INDEX [ix_nc_Headline_Variable_title] ON [dbo].[Headline_Variable]
--------(
--------	[title] ASC
--------) 
 

	  
------select * from [dbo].[Goals_Pivoted]

------select * from [goals] where id=48

------select sum(cs) from [dbo].[Goals_Pivoted]
------select *  from [dbo].[Goals] where id=20
 
------ select sum(cs) from(
------  select [Overall],[Group],[Region],[District],[CASH Survey] cs
------						       from [dbo].[Goals] pivot(max(ID) for [Goal Level] in( [Group],[Region],[District],[Overall]))p ) t

------  select top 1 100*[CASH Survey] cs  from [dbo].[Goals](nolock) where ID= and [Goal Level] =''''
------  select  distinct [Goal Level]       from [dbo].[Goals]
------------  /* 
------------ author :victor zhang 
------------ date:2015 02 09 
------------ */
------------ALTER View  [dbo].[V_KPI] 
------------ as  
------------  select Title as kpi,2  as idx 
------------   from [dbo].[Headline_Variable] 
------------   union  all
------------   select  kpi,1  from [dbo].[KPICalcs]
 
------select * from [dbo].[Headline_Variable] 
------select  *  from [dbo].[KPICalcs]
------select * from  [dbo].[Questionnaire]

------ if  exists(select * from [dbo].[Headline_Variable] where Title= @kpi)
------ else if  exists(select *  from [dbo].[KPICalcs] where kpi=@kpi) 

------   exec [p_get_KpiBreakdown_test] 3,10,'Customer CASH Score','',50 ,-1  ,-1  ,-1
------  exec [p_get_KpiBreakdown] 3,10,'Customer CASH Score','',20 ,-1 ,-1 ,-1
------  print '|||||||||||||'
------  exec  [dbo].[p_get_KpiBreakdown] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1

------    exec [p_get_KpiBreakdown] 3,10,'RECOMMEND','',50 ,-1 ,-1 ,-1
------  print '|||||||||||||'
------  exec  [dbo].[p_get_KpiBreakdown_next] 3,10,'RECOMMEND','',50 ,21 ,-1 ,-1

  
--------CREATE NONCLUSTERED INDEX [ix_nc_KPICalcs3_var] ON [dbo].[KPICalcs]
--------(
--------	[Variable] ASC,
--------	[TopNBox] ASC,
--------	[KPI]
--------)
--------INCLUDE ( 	
--------	[weight],[max_value_valid],
--------	[min_value_valid] ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = on, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--------GO



------  		select row_number() over(order by District) as ID,*   
------		from (
------		select  [Overall],[Group],[Region],[District],[CASH Survey] cs 
------									from [dbo].[Goals] pivot(max(ID) for [Goal Level] in( [Group],[Region],[District],[Overall]))p 
------									) t 
         
--------	;with c as (select  row_number() over( order by [goal Level],ID) num,*  from [dbo].[Goals]    )
--------	update c 
--------	set PID=num


 
--------alter table [dbo].[Goals] drop constraint [PK__Goals_PID]
--------alter table [dbo].[Goals] drop column PID
--------alter table [dbo].[Goals] add   PID int;

--------	;with c as (select  row_number() over( order by [goal Level],ID) num,*  from [dbo].[Goals]    )
--------	update c 
--------	set PID=num ;

--------alter table [dbo].[Goals] alter column   PID int not null
--------alter table [dbo].[Goals] add constraint [PK__Goals_PID] primary key (PID)


  
--------CREATE NONCLUSTERED INDEX [ix_nc_Goals] ON [dbo].[Goals]
--------(
--------	[ID] ASC
--------)
--------INCLUDE ( 	[Goal Level],
--------	[CASH Survey]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
-------- ;


------select *   from [dbo].[Goals]

--------select * from [dbo].[Questionnaire]  where label like 'Employees talking/texting on cell phone'  and [Variable Name]='Q100' 
--------update  [dbo].[Questionnaire]
--------set TopNbox='2',Bot2Box='1'  where label like 'Employees talking/texting on cell phone'  and [Variable Name]='Q100' 

--------select * from   [dbo].[Questionnaire20150228BAK] where   [Variable Name]='Q100' 

--------select * from [trends_head] where [Variable Name]='Q100'

------select * from [Goals_Pivoted]




------select [Group],region from [dbo].[Hierarchy] where district=210

 
------ ---drop index  [ix_nc_tb_rawdata_qag2] on [dbo].[tb_RawData]

------ sp_helpindex 'tb_RawData'

------ DBCC SHOW_statistics(tb_RawData,[ix_nc_tb_rawdata_qag2])


------ [dbo].[p_get_DashBoard_test] 3,10,'  ',30,18,345,-1
------ print '!!!'
------[dbo].[p_get_DashBoard] 3,10,'  ',30,18,345,-1


------select * from [dbo].[V_Year_Quarter]

------ select * from [dbo].[v_dashboard_scoring_trending_CASH_var]
 
------ print '!!!!'
------  select   Variable from [dbo].[v_dashboard_scoring_trending_CASH_var]
------  group by Variable

------   print '!!!!'
------   select * from (
------   select   Variable,row_number() over(partition by variable order by (select null)) as n from [dbo].[v_dashboard_scoring_trending_CASH_var]
------   ) t where n=1

------ select   * from sys.indexes where object_id=object_id('tb_RawData')

 

------	select concat('alter table [dbo].[Questionnaire] alter column [Scale',number,'] nvarchar(200)') from master.dbo.spt_values where type='P' and number between 1 and 14

------	---alter table [dbo].[Questionnaire] alter column       nvarchar(150)
 
 
------select * from   [dbo].[v_dashboard_scoring_trending_CASH_var]
------   print '###'
------ select   dashboard.variable,q.Label,q.[TopNBox],q.[Mid3Box],q.[Bot2Box]
------   from  dbo.dashboard_TopNBot as dashboard 
------					 inner join [dbo].[Variables]  vr(nolock) on vr.Position=dashboard.Position
------					 inner join [dbo].[Questionnaire] q(nolock) on  dashboard.Position=q.Position


------ select * from [dbo].[Trend_Scale_Breakdown]

------ 	 select [variable name], L3_Order , QuestionOrder, id,Position from trends_head

------select * from dashboard_TopNBot
------     [p_get_Trend] 3,10,default,'',10,40,300,6199
------	  exec [p_get_Trend_test] 3,9,default,'',10,-1,-1,-1

------ exec [p_get_Trend] 3,9,default,'',-1,-1,-1,-1
 

 
------	  exec [p_get_Trend] 3,9,-1,'',-1,-1,-1,-1
------	  print '@@@@@@'
------	  exec [p_get_Trend_test] 3,9,-1,'',-1,-1,-1,-1

------	   exec  [p_get_Trend_test] 3,9,-1,'',-1,-1,-1,-1
------[dbo].[Headline_Variable]

------select  Qrt_ID,Quarter_NEW from [dbo].[V_Year_Quarter] where   qrt_id>=9-1 and qrt_id<=9+3
------select * from [dbo].[V_Year_Quarter] where Qrt_id=9 and Year_id=2

------ select count(*) from tb_rawdata
------ select * from  [dbo].[V_Year_Quarter] 
------select distinct L3_order,L3 from  [dbo].[Questionnaire] where trend='1'

------  exec [p_get_Trend_test] 2,7,3,'',-1,-1,-1,-1

------  exec  [p_get_Trend] 3,10,-2,'',-1,-1,-1,-1

------  select * from V_Year_Quarter where quarter_new=1
   
------  select * from [dbo].[Trend_Scale_Breakdown]

------  select * from [dbo].[Headline_Variable]
------  	 select top 1 Position from [Variables]


------  select * from [dbo].KPICalcs




------	   select object_name(object_id),  [definition] from sys.sql_modules
------	   where [definition] like '%KPICalcs%' and object_name(object_id) not like '%BAK'  and object_name(object_id) not like '%test'


------ ----alter  table [dbo].[Questionnaire] alter column  [Trend] int

------ select distinct  [Dashboard],[KPI Breakdown],[Trend], [Cross Tab],[Verbatims],[Individual responses],[Filters] from [dbo].[Questionnaire]


------ 	  select  
------			  '[Q'+cast(Quarter_NEW as nvarchar)+']-[Q'
------			 +coalesce(( select top 1 'P'   from  [dbo].[V_Year_Quarter] where Year_ID=t.Year_ID -1 and Qrt_ID=t.Qrt_ID-1), cast(Quarter_NEW-1 as nvarchar) )+'],'
------	   from   [dbo].[V_Year_Quarter]  t where Year_ID=3  and qrt_id=9 order by Qrt_ID desc

 
------	  print '@@@"'
------	  exec [p_get_Trend_RollingQrt] 3,9,default,'',-1,-1,-1,-1
------exec [p_get_Trend_RollingQrt] 2,7,default,'',-1,-1,-1,-1

------select * from [dbo].[StoreFormat]


------select * from trends_head where label= 'Employees talking/texting on cell phone'



------	  select q.L3,q.Label,q.[Variable Name],ts.Scale,ts.id,q.QuestionOrder,q.L3_Order,q.position
			 
------	 from  [dbo].[Questionnaire] q inner join Trend_Scale_Breakdown ts on 1=1 and not(q.mid3box='-98' and ts.scale='Neutral')
------	  where  q.Trend='1' and  L3= 'EMPLOYEE SPECIFIC QUESTIONS' and label='Employees talking/texting on cell phone'
------	  order by q.L3_Order ,q.QuestionOrder,ts.id


------	  select * from [dbo].[Questionnaire] where trend=1 and [variable name]='Q100'




------	 select * from [dbo].[V_Year_Quarter]

 
------ coalesce
------	 select * from [V_Year_Quarter]

------select *  from [dbo].[Goals] where id=-1
------select * from [dbo].[Goals_Pivoted]

 
------ 	select row_number() over(order by [Overall] desc,[Group] desc,[Region] desc,[District] desc) as ID,*  
------		from (
------		select  [Overall],[Group],[Region],[District],[CASH Survey] cs 
------									from [dbo].[Goals] pivot(max(ID) for [Goal Level] in( [Group],[Region],[District],[Overall]))p 
------									) t;
 
------	--------select * from [Goals_R]

 
------     exec [dbo].p_get_KpiBreakdown_next_test 3,9,'customer cash score','  ',-1,-1,-1,-1
------   print '###'
------ exec [dbo].p_get_KpiBreakdown 3,-1,'customer cash score','  ',10,-1,-1,-1

------ select count(*),count(distinct Pos_id) from [dbo].[trends_head]

------  select * from [dbo].[Goals_Pivoted]

------   exec [p_get_Trend_test] 3,9,default,'',20,-1,-1,-1
------   print '##'
------    exec [p_get_Trend] 2,7,default,'',20,-1,-1,-1


------	   exec [p_get_Trend] 3,9,default,'',20,10,41,3201
------   print '##'
------    exec [p_get_Trend] 3,9,default,'',-1,-1,-1,-1
	
------	select * from [dbo].[Questionnaire]


---- select concat(',[', number,']')+char(10)
---- from master.dbo.spt_values
----  where number between 1 and 9 and type='p' for xml path('')



----   ;with c as (
---- select isnull(Q100 ,-99) as QRT
----, 100*sum(case when Q100=1 then weight end) /sum(case when Q100 in(1,2,3) then weight end) Y 
----, 100*sum(case when Q100=2 then weight end) /sum(case when Q100 in(1,2,3) then weight end) N 
----, 100*sum(case when Q100=3 then weight end) /sum(case when Q100 in(1,2,3) then weight end) D 
----,sum(case when Q100 in(1,2,3) then weight end) T
 
---- from  [dbo].[tb_FamilyDollar_RawData_v]
---- where Year_new=2
---- group by  Rollup(Q100 )
---- )
---- select * from c 
---- unpivot(Value for Vari in([T],[Y],[N],[D]) )up
---- pivot(sum(value) for Qrt in([-99],[3],[2],[1])) p
---- order by case when vari='T' then 0 else 1 end,vari
 


---- /*
----  ;with c as (
---- select  case when Grouping([x-xis-column])=1 then -99 else [x-xis-column] end as QRT
----, 100*sum(case when [y-xis-row]=1 then weight end) /sum(case when [y-xis-row] in(1,2,3,...,number) then weight end) Y 
----, 100*sum(case when [y-xis-row]=2 then weight end) /sum(case when [y-xis-row] in(1,2,3,...,number) then weight end) N 
----, 100*sum(case when [y-xis-row]=3 then weight end) /sum(case when [y-xis-row] in(1,2,3,...,number) then weight end) D 
----, 100*sum(case when [y-xis-row]=... then weight end) /sum(case when [y-xis-row] in(1,2,3,...,number) then weight end) e 
----, 100*sum(case when [y-xis-row]=number then weight end) /sum(case when [y-xis-row] in(1,2,3,...,number) then weight end) f 
----,sum(case when [y-xis-row] in(1,2,3...,number) then weight end) T
 
---- from  [dbo].[tb_FamilyDollar_RawData_v] where 1=1 and ....
---- group by  Rollup([x-xis-column] )
---- )
---- select * from c 
---- unpivot(Value for Vari in([T],[f],...,[Y],[N],[D]) )up
---- pivot(sum(value) for Qrt in([-99],[number],...,[3],[2],[1])) p
---- order by case when vari='T' then 0 else 1 end,vari
---- */


-------- select * into [dbo].[Goals_20150416BAK] from [dbo].[Goals]


-------- select *  from [dbo].[Goals]  

--------alter index all on [dbo].[Goals] rebuild


-------------------------------------


 
----select *  from   [dbo].[tb_Userlist]

-------alter table [dbo].[tb_Userlist] alter column flag nvarchar(10) not null  
------alter table [dbo].[tb_Userlist] add constraint [DF__tb_Userlis__Flag__473C8FC7] default('') for flag
 
----------INSERT INTO [dbo].[tb_Userlist] ([Username],[Password],[FirstName],[Permission_level],[JobTitel],[Group],[Region],[District],[Store],[EMPLOYEE_NUMBER],[Flag])
----------select * from  (    VALUES('EWOODSIII@FAMILYDOLLAR.com','Fd72xjdb','WOODS, III, EDWARD C (Eddie)','Field access','Business Manager 01...',null,null,null,'09200','1032050','NEW')
----------, ('AWARD@FAMILYDOLLAR.com','Fd72xjdb','WARD, ALBERT SCOTT (SCOTT)','Field access','DM in Training...','0060','29',null,'09200','1033654','NEW')
----------, ('RBONILLA@FAMILYDOLLAR.com','Fd72xjdb','BONILLA, RICARDO','Field access','DM in Training...','0050','48',null,'01230','1035435','NEW')
----------, ('RKOMINSKI@FAMILYDOLLAR.com','Fd72xjdb','KOMINSKI, RICHARD S (Rich)','Field access','AOM in Training...','0040','30',null,'05379','1036177','NEW')
----------, ('GLEVINE@FAMILYDOLLAR.com','Fd72xjdb','LEVINE, GLENN RICHARD','Field access','DM in Training...','0030','27',null,'02525','1035850','NEW')
---------- ) as t    ([Username],[Password],[FirstName],[Permission_level],[JobTitel]
----------           ,[Group],[Region],[District],[Store],[EMPLOYEE_NUMBER]
----------           ,[Flag])


----select * from (
----       select *,count(username) over(partition by username order by [Group]) cnt from [dbo].[tb_Userlist]
----	    )t where cnt>1
----		order by username



----select * from [dbo].[tb_Userlist] a  where  [Group] is null and [Region] is null and [District] is null and store is null and [password]='Fd72xjdb'
----and exists(select * from [dbo].[tb_Userlist_2015041701]  where username=a.username and [Permission_level]!='Chain access')

----select * from  [dbo].[Hierarchy]

------------update a set [Permission_level]= b. [Permission_level]
------------from [dbo].[tb_Userlist_2015041701] b  inner join [dbo].[tb_Userlist] a
------------on b.username=a.username and a.uid=b.uid
------------ where a.[Group] is null and a.[Region] is null and a.[District] is null and a.store is null and a.[password]='Fd72xjdb'


----select  a.*  from  [dbo].[tb_Userlist_2015041702BAK]   a inner join (
----select case  flag when'NEW' then 'Reject' else 'Disable' end [Action],'Group' Hierarchy,* from [dbo].[tb_Userlist_2015041702BAK] a where not exists(select * from [dbo].[Hierarchy] h where h.[Group]=a.[Group]) and a.[Group] is not null
----union
----select  case  flag when'NEW' then 'Reject' else 'Disable' end [Action],'Region', * from [dbo].[tb_Userlist_2015041702BAK] a where not exists(select * from [dbo].[Hierarchy] h where h.Region=a.Region) and a.Region is not null 
----union 
----select  case  flag when'NEW' then 'Reject' else 'Disable' end [Action],'District',* from [dbo].[tb_Userlist_2015041702BAK] a where not exists(select * from [dbo].[Hierarchy] h where h.District=a.District) and a.district is not null 
----union 
----select  case  flag when'NEW' then 'Reject' else 'Disable' end [Action],'Store' ,* from [dbo].[tb_Userlist_2015041702BAK] a where not exists(select * from [dbo].[Hierarchy] h where h.Store=a.Store) and a. store is not null
----) b on a.username=b.username
----where a.[Group] is null and a.[Region] is null and a.district is null and a.store is null
----order by a.username

 






----  'Chain access' ,'Field access'



 
 select distinct AGE_GROUP from tb_rawdata
 
 select * from [dbo].[Variable_Values] where Valid=1 and Variable='AGE_GROUP' 
 select * from [dbo].[Variables] where label like 'did the %'


  [p_get_c_test] 3,10,'AGE_GROUP','AGE_GROUP',11,'',-1,-1,-1,-1
  [p_get_c_test] 3,10,'YEAR_NEW','Q10_GRID_01_Q10',11,'',-1,-1,-1,-1

  [p_get_c_test] 3,-1,'Q106','Q109',11,' ',-1,-1,-1,-1
 execute  [p_get_c_test] 2,-1,'Quarter_NEW','Quarter_NEW',11,' ',-1,-1,-1,-1
 execute  [p_get_c_test] 2,-1,'Quarter_NEW','Q63',11,' ',-1,-1,-1,-1

 execute  [p_get_c_test] 2,-1,'Quarter_NEW','Q63',21,' ',-1,-1,-1,-1
 
   [p_get_c_test] 3,10,'YEAR_NEW','YEAR_NEW',11,'',-1,-1,-1,-1

  execute  [p_get_c_test] 2,-1,'Quarter_NEW','Q63',12,' ',-1,-1,-1,-1
 execute  [p_get_c_test] 2,-1,'Quarter_NEW','Q63',22,' ',-1,-1,-1,-1
---select     dbo.F_Test2(N'8,''a''; 2,''b'' ;4,''c'';3,''d'' ')

select * from 
select quarter_new,count(*),sum([weight]) from [dbo].[v_tb_FamilyDollar_RawData] 
where   year_new=2
group by quarter_new



select  distinct  [Q1401],[Q1402],[Q1403],[Q1404],[Q1405],[Q1406],[Q1407]
from [dbo].[tb_RawData]


 select * from [dbo].[tb_Userlist] where username='pchong_district'

 --update  [dbo].[tb_Userlist]
 --set [Group]='10',[Region]='8'   where username='pchong_district'

select * from [dbo].[Hierarchy] where district=245

 
SELECT  [Username] ,[Password],[FirstName],[Permission_level],[JobTitel]    ,[Group] ,[Region] ,[District],[Store],[EMPLOYEE_NUMBER] ,[Flag]
  FROM [dbo].[tb_Userlist]
 ---Field access    ---Chain access
   select *  FROM [dbo].[tb_Userlist]

------insert into [dbo].[tb_Userlist]([Username] ,[Password],[FirstName],[Permission_level],[JobTitel]    ,[Group] ,[Region] ,[District],[Store],[EMPLOYEE_NUMBER] ,[Flag])
------ select * from ( Values('TSONNIER@FAMILYDOLLAR.com' ,'Fd72xjdb','SONNIER, TIMOTHY (Tim)','Field access','DM in Training...'  ,'0050' ,'01' ,null,'09200','1036541' ,'Add')
------,('TLOGAN@FAMILYDOLLAR.com' ,'Fd72xjdb','LOGAN, TROY','Field access','DM in Training...'  ,'0060' ,'37' ,null,'07530','1038585' ,'Add')
------,('EBROOKS@FAMILYDOLLAR.com' ,'Fd72xjdb','BROOKS, ERMA R','Field access','Business Manager 01...'  ,null ,null ,null,'03594','204872' ,'Add') ) 
--as t( [Username] ,[Password],[FirstName],[Permission_level],[JobTitel]    ,[Group] ,[Region] ,[District],[Store],[EMPLOYEE_NUMBER] ,[Flag])


----;with cte as (select * from ( Values(null ,'Fd72xjdb','HERBERT, VERNON C','Field access','PM in Training...'   ,'0010' ,'08' ,null,null,'134445' ,'change')
----,(null ,'Fd72xjdb','GARCIA, PAUL N','Field access','Performance Manager...'   ,'0050' ,'01' ,'457',null,'747765' ,'change')
----,('KJACKSON@FAMILYDOLLAR.com' ,'Fd72xjdb','JACKSON, KENDALL','Field access','Performance Manager...'   ,'0060' ,'13' ,'358',null,'798069' ,'change')
----,('JOBERRY@FAMILYDOLLAR.com' ,'Fd72xjdb','OnullBERRY, JERALD JASON','Field access','Area Operations Manager...'   ,'0010' ,'40' ,'403',null,'799839' ,'change')
----,('JHARPER@FAMILYDOLLAR.com' ,'Fd72xjdb','HARPER, JAMES A','Field access','Performance Manager...'   ,'0010' ,'40' ,'527',null,'803747' ,'change')
----,('RCOLLINS@FAMILYDOLLAR.com' ,'Fd72xjdb','COLLINS, ROBIN D','Field access','Store Manager (Salaried)...'   ,'0010' ,'14' ,'427',null,'848419' ,'change')
----,(null ,'Fd72xjdb','LUGO, JOSE A','Field access','District Manager...'   ,'0050' ,'38' ,'085',null,'877083' ,'change')
----,('RTHEUNISII@FAMILYDOLLAR.com' ,'Fd72xjdb','THEUNIS II, ROBERT E','Field access','Store Manager (Salaried)...'   ,'0060' ,'13' ,'358',null,'895091' ,'change')
----)   as t( [Username] ,[Password],[FirstName],[Permission_level],[JobTitel]    ,[Group] ,[Region] ,[District],[Store],[EMPLOYEE_NUMBER] ,[Flag])
----)
----update a 
----set a.[Group]=c.[Group],
----    a.[Region]=c.[Region],
----	a.[District]=c.[District],
----	a.flag=c.flag
-------select a.*
---- from [dbo].[tb_Userlist] a inner join cte c on a.username=c.username
  


  ------select * from [dbo].[tb_Userlist] a  where flag<>'' and not exists( select * from [dbo].[Hierarchy] where [Group]=a.[Group]) and [Group] is not null
  ------select * from [dbo].[tb_Userlist] a  where flag<>'' and not exists( select * from [dbo].[Hierarchy] where Region=a.Region) and region is not null
  ------select * from [dbo].[tb_Userlist] a  where flag<>'' and not exists( select * from [dbo].[Hierarchy] where District=a.District) and district is not null
  ------select * from [dbo].[tb_Userlist] a  where flag<>'' and not exists( select * from [dbo].[Hierarchy] where Store=a.Store) and store is not null

 






   select object_name(object_id),  [definition] from sys.sql_modules
 	 where     object_id=object_id('[dbo].[p_prepare_data]')   ---[dbo].[p_get_crosstab] -[dbo].[p_prepare_data]

   select object_name(object_id),  [definition] from sys.sql_modules
 	 where     object_id=object_id('[dbo].[p_get_crosstab]')

select  *  from [dbo].[Cross Tab Spec$Victor]   order by id

 
select * from [dbo].[Variable_Values] where variable like '%Q14GRID%'




select  *   from [dbo].[Cross Tab Spec$Victor] order by ID
select * from [dbo].[Variable_Values] where variable like '%Quarter%'
 

select * from [dbo].[V_Year_Quarter]

--sp_helpindex'tb_rawdata'
--dbcc show_statistics(tb_rawdata,ix_nc_tb_rawdata_1)
--dbcc show_statistics(tb_rawdata,ix_nc_tb_rawdata_2)
--dbcc show_statistics(tb_rawdata,ix_nc_tb_rawdata_3)
--dbcc show_statistics(tb_rawdata,ix_nc_tb_rawdata_4)
--dbcc show_statistics(tb_rawdata,ix_nc_tb_rawdata_5)
--dbcc show_statistics(tb_rawdata,ix_nc_tb_rawdata_6)
--dbcc show_statistics(tb_rawdata,ix_nc_tb_rawdata_7)
--dbcc show_statistics(tb_rawdata,ix_nc_tb_rawdata_8)
--dbcc show_statistics(tb_rawdata,ix_nc_tb_rawdata_9)
 
 
 
 [dbo].[p_get_DashBoard_test] 3,10,'  ',40,-1,-1,-1
 

   exec  [dbo].[p_get_KpiBreakdown] 3,10,'ASSORTMENT','',-1 ,-1 ,-1 ,-1
  print '####'
   exec  [dbo].[p_get_KpiBreakdown_test] 3,10,'ASSORTMENT','',-1 ,-1 ,-1 ,-1


  exec  [dbo].[p_get_KpiBreakdown] 3,10,'Recommend','',10 ,-1 ,-1 ,-1
  print '####'
   exec  [dbo].[p_get_KpiBreakdown_test] 3,10,'ASSORTMENT','',10 ,-1 ,-1 ,-1


      exec  [dbo].p_get_KpiBreakdown_next_test 3,10,'CUSTOMER CASH SCORE','',10 ,-1 ,-1 ,-1
	    print '####'
	   exec  [dbo].p_get_KpiBreakdown_next 3,10,'CUSTOMER CASH SCORE','',10 ,-1 ,-1 ,-1


	 select len('')

	 select Var(isnull([weight],0)),Var([weight]),stdev(isnull([weight],0)),stdev([weight]),stdevp(isnull([weight],0)),stdevp([weight])
	 ,avg(isnull([weight],0)),avg([weight]),varp(isnull([weight],0)),varp([Weight]) 
	
	  from [dbo].[tb_RawData] where Year_new=2


	  select * from [KPICalcs]
	  select *　from  [dbo].[Headline_Variable]

	   select * from [dbo].[V_KPI]
[dbo].[trends_head]
 [dbo].[Trend_Scale_Breakdown]
----------	  var()/varp()方差
----------stdev()/stdevp()标准误差

select avg(isnull([Group],0)*1.0),count(*),sum([Group]),avg( [Group] *1.0)
 from [dbo].[tb_RawData] where Year_new=2
 select 3861080.0/116986

 select varp(a)
 from (values(3100),

   exec [p_get_Trend] 3,9,default,'',-1,-1,-1,-1

 select  a.*  ---a.L3,a.[Variable name],a.topNbox,a.Mid3box,a.Bot2box,b.Value,b.[Value_Label]  
 from [dbo].[Questionnaire] a inner join [dbo].[Variable_Values] b on a.[variable name]=b.variable
    where a.L3 like 'EMPLOYEE SPECIFIC QUESTIONS'


 select * 
 from [dbo].[trends_head] where L3   like 'EMPLOYEE SPECIFIC QUESTIONS'and [variable name]='Q100' 

  

  	  ----update [dbo].[trends_head] set  Scale=case when ID=3 Then 'NO' when  ID=4 then 'YES' else Scale end  
					----				  where L3= 'EMPLOYEE SPECIFIC QUESTIONS' and [variable name]='Q100'  ;



select sum(case when  Q100=1 then [weight] end)/sum(case when  Q100 in(1,2,3) then [weight] end),
sum(case when  Q100=2 then [weight] end)/sum(case when  Q100 in(1,2,3) then [weight] end),
sum(case when  Q100=3 then [weight] end)/sum(case when  Q100 in(1,2,3) then [weight] end),
sum(case when  Q100 in(1,2,3) then [weight] end)
 from [dbo].[tb_RawData] where quarter_new=10

 select *  from [dbo].[KPICalcs] 

   exec [p_get_Trend_test] 3,9,default,'',-1,-1,-1,-1
   exec [p_get_Trend] 3,9,default,'',-1,-1,-1,-1

  
   select *  from [dbo].[Questionnaire] where [variable name]='Q100'
   
   'Employees talking/texting on cell phone (% No)'

   select * from [trends_head] where [variable name]='Q100'
   --------update [trends_head]
   --------set label= 'Employees talking/texting</br>on cell phone (% No)'
   --------where [variable name]='Q100'

  -- sp_spaceused 'tb_rawdata'

   
       select   [definition] from sys.sql_modules
 	 where     object_id=object_id('[dbo].[p_get_c_test]') 
	  --[dbo].[p_get_Trend]---[dbo].[p_prepare_data]   ---[dbo].[p_get_KpiBreakdown]-----[dbo].[p_get_Trend]--[dbo].[p_get_KpiBreakdown_next]--[dbo].[p_get_DashBoard]

	 ---- alter index all on [dbo].[tb_RawData] rebuild
	  ---9999
 
 exec p_get_c_test 3,-1,'Q13','Q2',11,0,' ',-1,-1,-1,-1
 exec p_get_c_test 3,-1,'Q13','Q2',21,0,' ',-1,-1,-1,-1
 exec p_get_c_test 3,-1,'Q13','Q2',12,0,' ',-1,-1,-1,-1
 exec p_get_c_test 3,-1,'Q13','Q2',22,0,' ',-1,-1,-1,-1

  exec p_get_c_test 3,-1,'Q2','Q2',11,0,' ',-1,-1,-1,-1
 exec p_get_c_test 3,-1,'Q13','Q2',11,0,' ',-1,-1,-1,-1
exec p_get_c_test 3,-1,'Q13','Q2',21,0,' ',-1,-1,-1,-1
exec p_get_c_test 3,-1,'Q13','Q2',12,0,' ',-1,-1,-1,-1

  exec p_get_c_test 3,-1,'Q2','Q2',0,0,' ',-1,-1,-1,-1


 

  exec p_get_c_test 3,-1,'Q13','Q14',11,0,' ',-1,-1,-1,-1

select * from [dbo].[Cross Tab Spec$Victor] 

 ----sp_rename '[dbo].[Stats]','Stats_Index'

 select * from Stats_Index

 exec [dbo].[p_get_KpiBreakdown] 3,9,'SERVICE','  ',10,40,300,6199

  exec [dbo].[p_get_KpiBreakdown] 3,9,'SERVICE','  ',10,40,300,-1
 exec [dbo].[p_get_KpiBreakdown] 3,9,'SERVICE','  ',10,40,-1,-1
  exec [dbo].[p_get_KpiBreakdown] 3,9,'SERVICE','  ',-1,-1,-1,-1

   exec [dbo].[p_get_KpiBreakdown_test] 3,9,'SERVICE','   ',10,40,-1,-1
   print '###'
   exec [dbo].[p_get_KpiBreakdown] 3,9,'SERVICE','   ',10,40,-1,-1

 select * from [dbo].[KPICalcs]



   select top 1 * from sys.indexes where object_id=object_id('Tb_rawdata')

   select top 1 * from  sysindexes where id=object_id('Tb_rawdata') and used<2


 
	
	select top 2 * from [sys].[indexes]

	select top 2 * from [sys].[index_columns]


select variable+',' from (	select distinct quotename(Variable) Variable from [dbo].[Filters] )t for xml path('')


[YEAR_NEW],[QUARTER_NEW],[GROUP],[Region],[District],[Q2_1] as [Store],

[AGE_GROUP],[freq_shop],[Q63],[Q64],[RACE_ETH], ----[STOREFORMAT],[CLUSTER_UPDATED],
[Q72_A01],[Q72_A02],[Q72_A03],[Q72_A04],[Q72_A05],[Q72_A06],[Q72_A07],[Q72_A08],[Q72_A09],[Q72_A10],[Q72_A11],


select * from  [dbo].[Cross Tab Spec$Victor]

 
 exec p_get_c_test 3,-1,'Q13','Q2',11,0,' ',-1,-1,-1,-1

 exec p_get_c_test 3,-1,'Q13','Q2',12,0,' ',-1,-1,-1,-1
  exec p_get_c_test 3,-1,'Q13','Q2',21,0,' ',-1,-1,-1,-1
  exec p_get_c_test 3,-1,'Q13','Q2',22,0,' ',-1,-1,-1,-1


  exec p_get_c_test 3,-1,'Q13','Q14',0,0,' ',-1,-1,-1,-1
    exec p_get_c_test 3,-1,'Q14','Q13',0,0,' ',-1,-1,-1,-1

    exec p_get_c_test 3,-1,'Q2','Q13',0,0,' ',-1,-1,-1,-1
    exec p_get_c_test 3,-1,'Q2','Q14',21,0,' ',-1,-1,-1,-1
    exec p_get_c_test 3,-1,'Q2','Q72_1',11,0,' ',-1,-1,-1,-1

	exec p_get_c_test 3,-1,'Q14','Q72_1',0,0,' ',-1,-1,-1,-1


	select * from [dbo].[Cross Tab Spec$Victor] where type='MULti' and label like 'Earlier%'

	 select * from [dbo].[Stats_Index]
	 
	select Val = case when charindex('(',label)>0 and charindex(')',label)>charindex('(',label) then substring( label,charindex('(',label)+1,        charindex(')',label)-charindex('(',label)-1)
														 else  cast(Value as nvarchar) end,*
    from [dbo].[Cross Tab Spec$Victor]
	where  (label like '%([0-9][/,.,-]%[0-9])%'  or  label like '%([0-9])%')   
	
	----alter index all on  [dbo].[Cross Tab Spec$Victor] rebuild
	------	update [dbo].[Cross Tab Spec$Victor] set Val = case when charindex('(',label)>0 and charindex(')',label)>charindex('(',label) then substring( label,charindex('(',label)+1,charindex(')',label)-charindex('(',label)-1)
	------													 else  cast(Value as nvarchar) end
	------where  label like '%([0-9][/,.,-][0-9])%'  or  label like '%([0-9])%'   
	
	  
select * from   [dbo].[Cross Tab Spec$Victor] a  inner join [dbo].[Variable_Values] b on a.Variable=b.Variable where a.Type='MULTI'
 
select * from (select Variable,Quest,Label,Value,Val from [dbo].[Cross Tab Spec$Victor] where val is not null and quest='Q8b' )t
pivot( max(val) for value in([1],[2],[3])) p

  

 --- '+(select concat(' and ( [Quarter_NEW] between ', min(Qrt_ID),' and ',max(qrt_id),' )') from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW)+'
 select concat(' where ( [Quarter_NEW] between ', min(Qrt_ID),' and ',max(qrt_id),' )') from V_Year_Quarter(nolock) where Year_ID=3 --@YEAR_NEW  ;


--- dbcc show_statistics(tb_rawdata,[ix_nc_tb_rawdata_2])

select distinct [Group]  from tb_rawdata

  select * from variables where  variable like 'Q91A_GRID_%'


  select * from variables
  select * from [dbo].[Variable_Values]

  [AGE_GROUP],[freq_shop],[Q63] [Gender],[Q64] [income],[RACE_ETH],
 Q72_A01,Q72_A02,Q72_A03,Q72_A04,Q72_A05,Q72_A06,Q72_A07,Q72_A08,Q72_A09,Q72_A10,Q72_A11  --Government benifit
 [STOREFORMAT],[CLUSTER_UPDATED],MRK_FDO

 select ' AND [AGE_GROUP] in('+ @Age +')' ,
       ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' ,
 ' AND [Q63] in('+@Gender   +')' ,
 ' AND [Q64] in('+@Income    +')' ,
 ' AND [RACE_ETH] in('+@Racial_background   +')' ,
 ' AND ('+stuff((select case when len(data)=0 or data='0' or data='null' then '' else  concat('or [Q72_A',right(('000'+cast(id as nvarchar(2))),2),']=',data,char(10))  end 
from  [dbo].[f_FamilyDollar_SplitStr](@Government_benefits,',') 
for xml path('')
		),1,1,'2')  +')'  ,
' AND [STOREFORMAT] in('+@Store_Format   +')' ,
' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')' ,
' AND [MRK_FDO] in('+@Shopper_Segment   +')' 

select * from [dbo].[Clusters]

select case when len(data)=0 or data='0' or data='null' then '' else  concat('or [Q72_A',right(('000'+cast(id as nvarchar(2))),2),']=',data,char(10))  end 
from  [dbo].[f_FamilyDollar_SplitStr](@Government_benefits,',') 
 


select * from  [dbo].[f_FamilyDollar_SplitStr](',,,,,,,,,,',',') 
select len(',,,,,,,,,,')

sp_help '[dbo].[f_FamilyDollar_SplitStr]'

 ---select distinct MRK_FDO from tb_rawdata
  select * from [dbo].[Cross Tab Spec$Victor] where  label like '%Freq%'  -- Quest='Q2' and Value is not null


         select   [definition] from sys.sql_modules
 	 where     object_id=object_id('[dbo].[p_get_c_test]') ---[dbo].[p_prepare_data]  --[dbo].[F_TTest_SR]  --p_get_c_test
 	  ---select * from trends_head where Label in('Greeted by employee', 'Thanked for purchase', 'Employee offered help')


	   select * from [Stats_Index]


	   --sp_spaceused 'tb_rawdata'

;with c as (select Value as  number from [dbo].[Cross Tab Spec$Victor] where Quest='Q2' and Value is not null)
select c1.number,concat(c1.number,'!',c2.number) from c c1  inner join c c2 on c1.number<>c2.number
Order by c1.number


sp_helptext '[dbo].[F_TTest_SR]'

[dbo].[F_TTest_SR](1,1-2,2,2-2)
 dbo.F_TTest_SR(1,1-2,2,2-2,0.999)
-- Description:	  ---select    dbo.F_TTest_SR(892.407678999999,503,1037.530643,850,0.999)

  --select 'select  * into  [FamilyDollar_TEST].dbo.'+quotename(name) +' 
  --From FamilyDollar.dbo.'+quotename(name) 
  --from sysobjects where Type='U' 


   select    [definition]+char(10)+' GO '  from sys.sql_modules --[sys].[all_sql_modules]
     where object_name(object_id) not like 'sp%' and object_id!=158623608
 

          select   [definition] from sys.sql_modules
 	 where     object_id=object_id('p_prepare_data') ---[dbo].[p_prepare_data]  --[dbo].[F_TTest_SR]  --p_get_c_test
 	  
 
 select * from [dbo].[tb_Userlist] where [Store] like '9200'
 
 select   STORE,District,Region,[GROUP],[StoreFormatMappedLabel],[StoreFormatMappedResponse],[Store Format]
 from [dbo].[Store Information$Victor20150505] where not([Group] is null or Region is null or district is null or store is null)
 and [Store] like '9200'

  select   count(*)
 from [dbo].[Store Information$Victor20150505] where not([Group] is null or Region is null or district is null or store is null)


   select * from  [FamilyDollar].[dbo].[Hierarchy]
 

---insert into  [dbo].[Hierarchy]( STORE,District,Region,[GROUP])
------select  STORE,District,Region,[GROUP]
------from  [dbo].[Store Information$Victor20150505] where not([Group] is null and Region is null and district is null and store is null)

select * from  [dbo].[Store Information$Victor20150505] where not([Group] is null and Region is null and district is null and store is null)

---select * into [dbo].[StoreFormat_20150505BAK] from [dbo].[StoreFormat]

 
----insert into  [dbo].[StoreFormat]([Store],[Store Format],[STOREFORMAT_LABEL],[STOREFORMAT])
---- select   STORE ,[Store Format],[StoreFormatMappedLabel],[StoreFormatMappedResponse]
---- from [dbo].[Store Information$Victor20150505] where not([Group] is null or Region is null or district is null or store is null)
 


 select  count(*)   from tb_rawdata where [Group]='-9999'
 

--  [dbo].[US3000830_Q2_Q3_2014_data$Victor]

select  'Group' Hierarchy,* from [dbo].[tb_Userlist] a where not exists(select * from [dbo].[Hierarchy] h where h.[Group]=a.[Group]) and a.[Group] is not null
union
select   'Region', * from [dbo].[tb_Userlist] a where not exists(select * from [dbo].[Hierarchy] h where h.Region=a.Region) and a.Region is not null 
union 
select   'District',* from [dbo].[tb_Userlist] a where not exists(select * from [dbo].[Hierarchy] h where h.District=a.District) and a.district is not null 
union 
select  'Store' ,* from [dbo].[tb_Userlist] a where not exists(select * from [dbo].[Hierarchy] h where h.Store=a.Store) and a. store is not null


 select * from tb_Userlist where --username in('JLINEBAUGH@FAMILYDOLLAR.com','MBAKKE@FAMILYDOLLAR.com','DDANENBERG@FAMILYDOLLAR.com','RWALLENBERG2@FAMILYDOLLAR.com')
 username in('MVILGA@FAMILYDOLLAR.com','LSPATZ@FAMILYDOLLAR.com')


----delete from [dbo].[tb_userlist] where username in('KBRODLEY@FAMILYDOLLAR.com','HHoush@FAMILYDOLLAR.com','MHARITOPOULOS@FAMILYDOLLAR.com')
select  username,count(*)   from [tb_userlist] group by username having(count(*)>1)

select *    from [tb_userlist]  where username ='TKIRKPATRICK@FAMILYDOLLAR.com'

select top 10 * from [dbo].[US3000830_Q2_Q3_2014_data$Victor]
 
select ','+quotename(Column_Name)+'=case when '+quotename(Column_Name)+'=''#NULL!'' then null else '+quotename(Column_Name)+'  end ' 
from [INFORMATION_SCHEMA].[COLUMNS] where table_name ='US3000830_Q2_Q3_2014_data$Victor'

select ','+quotename(Column_Name)
from [INFORMATION_SCHEMA].[COLUMNS] where table_name ='US3000830_Q2_Q3_2014_data$Victor'  for xml path('')

--select * into [dbo].[US3000830_Q2_Q3_2014_data$VictorBAK] from [dbo].[US3000830_Q2_Q3_2014_data$Victor]

select top 10 *   from [dbo].[US3000830_Q2_Q3_2014_data$Victor]


------delete [dbo].[tb_RawData] where year_new=2 and quarter_new in(6,7)

------INSERT INTO  [dbo].[tb_RawData]
------           (id, [Respondent_ID],[Q2_1],[Q3],[AGE_GROUP],[RACE_ETH],[Q13],[freq_shop],[Q1401],[Q1402],[Q1403],[Q1404],[Q1405],[Q1406],[Q1407],[Q7201],[Q7202],[Q7203],[Q7204],[Q7205],[Q7206],[Q7207],[Q7208],[Q7209],[Q7210],[Q7211],[Q7212],[Q7213],[Q15],[Q16],[Q63],[Q64],[QCB3],[QCB4],[Q72_A01],[Q72_A02],[Q72_A03],[Q72_A04],[Q72_A05],[Q72_A06],[Q72_A07],[Q72_A08],[Q72_A09],[Q72_A10],[Q72_A11],[MRK_FDO],[Q4_GRID_0_Q4],[Q5_GRID_01_Q5],[Q5_GRID_02_Q5],[Q5_GRID_03_Q5],[Q7_GRID_01_Q7],[Q7_GRID_02_Q7],[Q7_GRID_03_Q7],[Q7_GRID_04_Q7],[Q7_GRID_05_Q7],[Q8_GRID_01_Q8],[Q8_GRID_02_Q8],[Q8_GRID_03_Q8],[Q8_GRID_04_Q8],[Q9_GRID_01_Q9],[Q12A],[Q12C],[Q12D],[Q10_GRID_01_Q10],[Q6],[Q92],[Q93],[Q72_GRID_01_Q72A_GRID_1_0_Q72A],[Q72_GRID_02_Q72A_GRID_1_0_Q72A],[Q72_GRID_03_Q72A_GRID_1_0_Q72A],[Q72_GRID_04_Q72A_GRID_1_0_Q72A],[Q72_GRID_05_Q72A_GRID_1_0_Q72A],[Q72_GRID_06_Q72A_GRID_1_0_Q72A],[Q72_GRID_07_Q72A_GRID_1_0_Q72A],[Q72_GRID_08_Q72A_GRID_1_0_Q72A],[Q72_GRID_09_Q72A_GRID_1_0_Q72A],[Q72_GRID_10_Q72A_GRID_1_0_Q72A],[Q72_GRID_11_Q72A_GRID_1_0_Q72A],[Q72_GRID_12_Q72A_GRID_1_0_Q72A],[Q72_GRID_13_Q72A_GRID_1_0_Q72A],[Q110],[Q91A_GRID_01_Q91A],[Q91A_GRID_02_Q91A],[Q91A_GRID_03_Q91A],[Q91A_GRID_04_Q91A],[Q91A_GRID_05_Q91A],[Q91B_GRID_06_Q91B],[Q91B_GRID_07_Q91B],[Q91B_GRID_08_Q91B],[Q91B_GRID_10_Q91B],[Q91B_GRID_11_Q91B],[Q91C_GRID_09_Q91C],[Q91C_GRID_12_Q91C],[Q91C_GRID_13_Q91C],[Q91C_GRID_14_Q91C],[Q91D_GRID_15_Q91D],[Q100],[Q101_GRID_01_Q101],[Q101_GRID_02_Q101],[Q101_GRID_03_Q101],[Q102],[Q105],[Q106],[Q107],[Q108],[Q109],[Q115_GRID_01_Q115],[Q115_GRID_02_Q115],[Q116_GRID_01_Q116],[Q116_GRID_02_Q116],[Q116_GRID_03_Q116],[Q117_GRID_01_Q117],[Q117_GRID_02_Q117],[Q117_GRID_03_Q117],[Q117_GRID_04_Q117],[Q117_GRID_05_Q117],[Q117_GRID_06_Q117],[Q117_GRID_07_Q117],[Q118],[DATE_NUM],[MRK_SEG1],[InterviewLength],[MONTHX],[FDO_FISCAL_2015],[QUARTER_NEW],[YEAR_NEW],[weight],[RECEIPTNUM],[GROUP],[REGION],[DISTRICT],[CB_REG],[CB_RURAL],[URBANICITY])

------select    row_number()over(order by (select null))+30000, [Respondent_ID],[Q2_1],[Q3],[AGE_GROUP],[RACE_ETH],[Q13],[freq_shop],[Q1401],[Q1402],[Q1403],[Q1404],[Q1405],[Q1406],[Q1407],[Q7201],[Q7202],[Q7203],[Q7204],[Q7205],[Q7206],[Q7207],[Q7208],[Q7209],[Q7210],[Q7211],[Q7212],[Q7213],[Q15],[Q16],[Q63],[Q64],[QCB3],[QCB4],[Q72_A01],[Q72_A02],[Q72_A03],[Q72_A04],[Q72_A05],[Q72_A06],[Q72_A07],[Q72_A08],[Q72_A09],[Q72_A10],[Q72_A11],[MRK_FDO],[Q4_GRID_0_Q4],[Q5_GRID_01_Q5],[Q5_GRID_02_Q5],[Q5_GRID_03_Q5],[Q7_GRID_01_Q7],[Q7_GRID_02_Q7],[Q7_GRID_03_Q7],[Q7_GRID_04_Q7],[Q7_GRID_05_Q7],[Q8_GRID_01_Q8],[Q8_GRID_02_Q8],[Q8_GRID_03_Q8],[Q8_GRID_04_Q8],[Q9_GRID_01_Q9],[Q12A],[Q12C],[Q12D],[Q10_GRID_01_Q10],[Q6],[Q92],[Q93],[Q72_GRID_01_Q72A_GRID_1_0_Q72A],[Q72_GRID_02_Q72A_GRID_1_0_Q72A],[Q72_GRID_03_Q72A_GRID_1_0_Q72A],[Q72_GRID_04_Q72A_GRID_1_0_Q72A],[Q72_GRID_05_Q72A_GRID_1_0_Q72A],[Q72_GRID_06_Q72A_GRID_1_0_Q72A],[Q72_GRID_07_Q72A_GRID_1_0_Q72A],[Q72_GRID_08_Q72A_GRID_1_0_Q72A],[Q72_GRID_09_Q72A_GRID_1_0_Q72A],[Q72_GRID_10_Q72A_GRID_1_0_Q72A],[Q72_GRID_11_Q72A_GRID_1_0_Q72A],[Q72_GRID_12_Q72A_GRID_1_0_Q72A],[Q72_GRID_13_Q72A_GRID_1_0_Q72A],[Q110],[Q91A_GRID_01_Q91A],[Q91A_GRID_02_Q91A],[Q91A_GRID_03_Q91A],[Q91A_GRID_04_Q91A],[Q91A_GRID_05_Q91A],[Q91B_GRID_06_Q91B],[Q91B_GRID_07_Q91B],[Q91B_GRID_08_Q91B],[Q91B_GRID_10_Q91B],[Q91B_GRID_11_Q91B],[Q91C_GRID_09_Q91C],[Q91C_GRID_12_Q91C],[Q91C_GRID_13_Q91C],[Q91C_GRID_14_Q91C],[Q91D_GRID_15_Q91D],[Q100],[Q101_GRID_01_Q101],[Q101_GRID_02_Q101],[Q101_GRID_03_Q101],[Q102],[Q105],[Q106],[Q107],[Q108],[Q109],[Q115_GRID_01_Q115],[Q115_GRID_02_Q115],[Q116_GRID_01_Q116],[Q116_GRID_02_Q116],[Q116_GRID_03_Q116],[Q117_GRID_01_Q117],[Q117_GRID_02_Q117],[Q117_GRID_03_Q117],[Q117_GRID_04_Q117],[Q117_GRID_05_Q117],[Q117_GRID_06_Q117],[Q117_GRID_07_Q117],[Q118],[DATE_NUM],[MRK_SEG1],[InterviewLength],[MONTHX],[FDO_FISCAL_2015],[QUARTER_NEW],[YEAR_NEW],[weight],[RECEIPTNUM],[GROUP],[REGION],[DISTRICT],[CB_REG],[CB_RURAL],[URBANICITY]
------from [dbo].[US3000830_Q2_Q3_2014_data$Victor]


alter index all on tb_rawdata rebuild

select distinct year_new,quarter_new   from [dbo].[US3000830_Q2_Q3_2014_data$Victor]


          select   [definition] from sys.sql_modules
 	 where     object_id=object_id('[dbo].[p_get_DashBoard]') --[dbo].[p_get_KpiBreakdown]--[dbo].[p_prepare_data]  --[dbo].[F_TTest_SR]  --p_get_c_test
 	  

----	   ; with ct as (select row_number() over(order by YEAR_NEW DESC,Quarter_NEW DESC,[Group],[REgion],District,Q2_1) as num,*
----							 from  [dbo].[tb_RawData]  )
----update ct set id =num

select year_new,count(*) from [dbo].[tb_RawData] group by year_new

select year_new,count(*) from [FamilyDollar_TEST].[dbo].[tb_RawData] group by year_new

 exec [p_get_KpiBreakdown_test] 3,9,'Customer CASH Score','',10 ,-1 ,-1 ,-1


 select top 10 [Group],[Region],[District],CB_REG,* from tb_RawData where [Region]=50



 select  'Group' Hierarchy,* from [dbo].[tb_Userlist] a(nolock) where not exists(select * from [dbo].[Hierarchy] h where h.[Group]=a.[Group]) and a.[Group] is not null
union
select   'Region', * from [dbo].[tb_Userlist] a where not exists(select * from [dbo].[Hierarchy] h where h.Region=a.Region) and a.Region is not null 
union 
select   'District',* from [dbo].[tb_Userlist] a where not exists(select * from [dbo].[Hierarchy] h where h.District=a.District) and a.district is not null 
union 
select  'Store' ,* from [dbo].[tb_Userlist] a where not exists(select * from [dbo].[Hierarchy] h where h.Store=a.Store) and a. store is not null


 select * from  [tb_Userlist] where Store=9200
 where --username in('ADAGGS@FAMILYDOLLAR.com','BWEBSTER2@FAMILYDOLLAR.com','EMUSSELWHITE@FAMILYDOLLAR.com')
  username='TKIRKPATRICK@FAMILYDOLLAR.com'
	
 select definition from sys.sql_modules where object_id=object_id('[dbo].[p_prepare_data]')

 select * from sys.stats
  select * from [tb_userlist]
    
 ---insert into #t
 select distinct u.uid ---into  #t
  from [dbo].[tb_userlist] u  inner join [dbo].[Hierarchy] h 
		on  ---u.[Group]=h.[Group] and u.region=h.[Region] and u.district=h.district and u.store=h.store
	 --- u.[Group]=h.[Group] and u.Region is null and u.district is null and u.store is null
		 --- u.[Group]=h.[Group] and u.region=h.[Region] and u.district is null and u.store is null
		 u.[Group]=h.[Group] and   u.region=h.[Region] and u.district=h.district and u.store is null 
		  and datediff(day,u.datecreated,getdate())=0
	
select *    from [tb_userlist] u where uid not in( select uid from #t)  and ([Group] is not null or u.Region is not null or u.district is not null or u.store is not null)

select *    from [tb_userlist] where datediff(day,datecreated,getdate())=0 and uid not in(969) and  ([Group] is not null or u.Region is not null or u.district is not null or u.store is not null)

--update u
--set [Group]=h.[Group],
--	Region=h.[Region],
--	district=h.district 
select *  from [tb_userlist] u inner join [Hierarchy] h on u.[Store]=h.store
where uid not in( select uid from #t)  and   u.store is not null 


 select * from [tb_userlist] where not([Group] is null and region is null and district is null and store is null) and store is   null and district is not null

--select * from temp_victor
select * from [dbo].[Hierarchy] where District =511

 

 update u
set [Group]=h.[Group],
	Region=h.[Region],
	district=h.district 
---select *  
from [tb_userlist] u inner join [Hierarchy] h on u.[Store]=h.store

 update u
set [Group]=h.[Group],
	Region=h.[Region] 
---select * 
 from [tb_userlist] u inner join [Hierarchy] h on u.district=h.district and u.store is null

  update u
set [Group]=h.[Group] 
 ---select * 
 from [tb_userlist] u inner join [Hierarchy] h on u.Region=h.Region and u.store is null and u.district is null

 alter index all on tb_userlist rebuild

 select a.uid,a.[Group],a.region,a.district,a.store,b.[Group],b.region,b.district,b.store 
 from [tb_userlist] a inner join  [dbo].[tb_Userlist_20150512BAK] b on a.username=b.username
 where a.[Group] is not null and b.[Group] is not null
 order by a.uid

 --Chain access
 --Field access
 --Fd72xjdb
--- select *    from tb_userlist where username='TJOHNSON4@FAMILYDOLLAR.com'
 select quotename(name)+',' from sys.columns where object_id=object_id('tb_userlist') for xml path('')

 ([UID],[Username],[Password],[FirstName],[LastName],[Permission_level],[JobTitel],[LoginDate],[DateCreated],[Group],[Region],[District],[Store],[saveFilter],[EMPLOYEE_NUMBER],[Flag],[Live],)
  
--insert into tb_userlist( [EMPLOYEE_NUMBER],[FirstName],username,STORE,[GROUP],REGION,DISTRICT,[Password],[Permission_level])
--select '1045662','JOHNSON, TOMAZINA','TJOHNSON4@FAMILYDOLLAR.com','08323','0030','46',null,'Fd72xjdb','Field access'
 --insert into tb_userlist([FirstName],[LastName],[Username],[Password],[Permission_level])
 ---select 'First Name','Lail','KLAIL@FAMILYDOLLAR.com','Fd72xjdb','Chain access'

 --insert into [tb_Userlist](username,[EMPLOYEE_NUMBER],[Password],Permission_level) 
 
---insert into [tb_Userlist]([EMPLOYEE_NUMBER],firstname,username,[STORE],[GROUP],[REGION],[DISTRICT],[Password],[Permission_level])

select *  from [tb_Userlist] where username in('PKIRK@FAMILYDOLLAR.com')

select definition from sys.sql_modules where object_id=object_id('[dbo].[p_get_crosstab_test]')


  select power(5.0,2)

 

select		[ID]
           ,[Filter]
           ,[Cross Variable (Banner)]
           ,[Down Variable (Stub)]
           ,[Remove from % base]
           ,[Type]
           ,[Question]
           ,[Label]
           ,[SPSS VAR NAME]
           ,[Variable]
           ,[Response count]
           ,[Position]
           ,[Value]
           ,[Quest]
           ,[Val]
           ,[Vals]
		   from [dbo].[Cross Tab Spec$Victor]  

--select *  into   [CrossTab_Variable_Value] from [dbo].[Variable_Values]
 
--alter table [CrossTab_Variable_Value] add [Position] int,G1 nvarchar(50),G2 nvarchar(50),G3 nvarchar(50),G4 nvarchar(50),G5 nvarchar(50),MultiTick smallint,Quest nvarchar(100)
select * from [CrossTab_Variable_Value] a inner join [dbo].[Cross Tab Spec$Victor]  b on a.variable=b.Variable


 --update a set  a.Position  =b.Position from [CrossTab_Variable_Value] a inner join [dbo].[Variables] b on a.Variable=b.Variable

    [p_get_crosstab] 3,-1,'Q2','Q14',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
    [p_get_crosstab] 3,-1,'Q2','Q14',12,0,' ',-1,-1,-1,-1,'','','','','','','','',''
	[p_get_crosstab] 3,-1,'Q2','Q14',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
    [p_get_crosstab] 3,-1,'Q2','Q14',22,0,' ',-1,-1,-1,-1,'','','','','','','','',''


    [p_get_crosstab] 3,-1,'Q2','Q13',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
    [p_get_crosstab] 3,-1,'Q2','Q13',12,0,' ',-1,-1,-1,-1,'','','','','','','','',''
	[p_get_crosstab] 3,-1,'Q2','Q13',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
    [p_get_crosstab] 3,-1,'Q2','Q13',22,0,' ',-1,-1,-1,-1,'','','','','','','','',''


    [p_get_crosstab] 3,-1,'Q2','Q63',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
    [p_get_crosstab] 3,-1,'Q2','Q63',12,0,' ',-1,-1,-1,-1,'','','','','','','','',''
	[p_get_crosstab] 3,-1,'Q2','Q63',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
    [p_get_crosstab] 3,-1,'Q2','Q63',22,0,' ',-1,-1,-1,-1,'','','','','','','','',''

	[p_get_crosstab] 3,-1,'Q2','Q63',0,0,' ',-1,-1,-1,-1,'','','','','','','','',''

	[p_get_crosstab] 3,-1,'Q63','Q64',0,0,' ',-1,-1,-1,-1,'','','','','','','','',''


	[p_get_crosstab_test] 3,-1,'Q2','Q14',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
	select * from [dbo].[Cross Tab Spec$Victor] where  quest='Q2'



	 [p_get_crosstab] 3,-1,'Q2','Q14',0,0,' ',-1,-1,-1,-1,'','','','','','','','',''


	 select AGE_GROUP,sum( [Q1401]),sum([Q1402]) ,sum([Q1403]),sum([Q1404]),sum([Q1405]),sum([Q1406]),sum([Q1407])
	 from tb_rawdata where year_new=3 and (  [Q1401] in(1) or [Q1402] in(1) or [Q1403] in(1) or [Q1404] in(1) or [Q1405] in(1) or [Q1406] in(1) or [Q1407] in(1)  )
	 group by Rollup(AGE_GROUP)
	 --( (case when [Q1401]=1 then 1 else 0 end)+ (case when [Q1402]=1 then 1 else 0 end)+ (case when [Q1403]=1 then 1 else 0 end)+ (case when [Q1404]=1 then 1 else 0 end)+ (case when [Q1405]=1 then 1 else 0 end)+ (case when [Q1406]=1 then 1 else 0 end)+ (case when [Q1407]=1 then 1 else 0 end))  end) as [-1],sum( case when  [Q1401] in(1) or [Q1402] in(1) or [Q1403] in(1) or [Q1404] in(1) or [Q1405] in(1) or [Q1406] in(1) or [Q1407] in(1)  then cast(1.0 as float) else cast(null as float) end) as [-2],sum( case when  [Q1401] in(1) or [Q1402] in(1) or [Q1403] in(1) or [Q1404] in(1) or [Q1405] in(1) or [Q1406] in(1) or [Q1407] in(1)  then power([Weight]/( (case when [Q1401]=1 then 1 else 0 end)+ (case when [Q1402]=1 then 1 else 0 end)+ (case when [Q1403]=1 then 1 else 0 end)+ (case when [Q1404]=1 then 1 else 0 end)+ (case when [Q1405]=1 then 1 else 0 end)+ (case when [Q1406]=1 then 1 else 0 end)+ (case when [Q1407]=1 then 1 else 0 end)),2)  end) as [-SW]
[dbo].[p_get_crosstab_test]

select * from  [dbo].[Cross Tab Spec$Victor]
select * from sys.objects where type='U'

select 'drop table [FamilyDollar_TEST].dbo.'+quotename(name)+' ;
      select * 
	   into [FamilyDollar_TEST].dbo.'+quotename(name)+'
	    from [FamilyDollar].dbo.'+quotename(name)+char(10)
	   from sys.objects where type='U'

 select  object_name(object_id),definition from sys.sql_modules where object_name(object_id) like 'p[_]get[_]%' and object_name(object_id) not like '%BAK'
[dbo].[p_get_crosstab_test]

 select  object_name(object_id),definition from sys.sql_modules where definition like '%Questionnaire%'

 select * from Questionnaire where trend=1 
 select * from trends_head




























 use [FamilyDollar_test]
 go
select  definition from   sys.sql_modules where  object_id =object_id('[dbo].[p_get_crosstab_test2]')

exec  [p_get_crosstab_test] 3,-1,'Q2','Q13',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''


exec  [p_get_crosstab_test] 3,-1,'Q2','Q13',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''


------ use   [FamilyDollar_TEST]
------ go
 
------ select * into[dbo].[Hierarchy_20150609BAK] from [dbo].[Hierarchy]
------ select * into  [dbo].[StoreFormat_20150609BAK] from  [dbo].[StoreFormat]

------ truncate table [dbo].[Hierarchy]
------ insert into [dbo].[Hierarchy]([Group],[Region],District, store)
------ select[Group],[Region],District, store
------  from [dbo].[StoreHierarchy$Victor] 
  
------ truncate table [dbo].[StoreFormat]
------INSERT INTO [dbo].[StoreFormat]
------           ([Store]    ,[Store Format] ,[STOREFORMAT_LABEL] ,[STOREFORMAT])
------select [Store], [Store Format],	StoreFormatMappedLabel,	StoreFormatMappedResponse
------from [dbo].[StoreHierarchy$Victor] 
 
------   select object_definition(object_id('[dbo].[p_prepare_data]'))
 
------ select top 100 * from [dbo].[Clusters]
------ select top 10 * from [dbo].[StoreFormat]

------ alter index all on  [FamilyDollar].[dbo].[tb_RawData] rebuild


select * from [dbo].[Variable_Values]
select * from [dbo].[Variables]

--select distinct a.Position,a.Variable,a.Label,b.Value,b.Value_label,b.Valid 
--into Variable_Layered from  [dbo].[Variables] a inner join [dbo].[Variable_Values] b on a.variable=b.variable 
---alter table [dbo].[Variable_Layered]	add Quest varchar(100),[Type] varchar(10)
---alter table [dbo].[Variable_Layered]	add G1 varchar(100),G1_Label varchar(300)
--update a set a.Quest=b.Quest,a.[Type]= b.[Type]  from Variable_Layered a inner join [dbo].[Cross Tab Spec$Victor]	b on a.variable=b.Variable
---update  Variable_Layered  set [Type]=isnull([Type],'SINGLE') where Type is null

[dbo].[Questionnaire]	where [cross tab]=1
select * from [Cross Tab Spec$Victor] where   quest='Q115a'
select * from Variable_Layered where quest='Q14'


--update a set a.G1=cast(b.value as varchar),a.G1_label= b.label 
--from Variable_Layered a inner join [dbo].[Cross Tab Spec$Victor]	b on a.variable=b.Variable 
--where  charindex(  concat(',',a.value) ,','+ b.Val )>0 and  b.val like '%,%'

--update a set a.G1=cast(b.value as varchar),a.G1_label= b.label 
--from Variable_Layered a inner join [dbo].[Cross Tab Spec$Victor]	b on a.variable=b.Variable 
--where  charindex(  concat(',',a.value) ,','+ b.Val )>0 and ( b.val like '%,%' or b.Label like '%([0-9])%' or b.Label like '%([0-9]%[/,-]%[0-9])%')


----------update a set a.value_Label=b.label,a.[Type]= b.[Type]  
----------select a.Variable,a.Value_label,a.value,b.label,b.value 
----------from Variable_Layered a inner join [dbo].[Cross Tab Spec$Victor]	b 
----------on a.variable=b.Variable and b.value is not null and b.quest is not null and a.value=  b.value  
----------where   b.label like '%(%)%' and  a.Type!='MULTI' b.val not like '%,%' 

select distinct a.Variable,a.Value,b.Value,b.label
from Variable_Layered a inner join [dbo].[Cross Tab Spec$Victor]	b 
on a.variable=b.Variable 
where  charindex(  concat(',',a.value) ,','+ b.Val )>0 and ( b.val like '%,%' or b.Label like '%([0-9])%' or b.Label like '%([0-9]%[/,-]%[0-9])%')

----update Variable_Layered  set G1=cast(value as varchar),G1_label=value_label where G1 is null and [type]='SINGLE'
----update Variable_Layered  set G1=cast(cast(Right(Variable,2) as int) as varchar),G1_label=Label where G1 is null and [type]='MULTI'
-----update Variable_Layered  set quest=Variable where Quest is null 
 
----update a set a.G1= cast(b.Value as varchar),a.G1_label=b.label
----from Variable_Layered a inner join [dbo].[Cross Tab Spec$Victor]	b 
----on a.variable=b.Variable 
----where  a.Type='MULTI'

select * from [dbo].[Cross Tab Spec$Victor]  where Quest='Q13'
select * from Variable_Layered where   [Type]='MULTI' and value<>0
----update  Variable_Layered set value=G1 ,value_label=g1_label where   [Type]='MULTI' and value>0

----update Variable_Layered set Quest='Q13o' where Quest='Q13' and Variable=Quest

----select * into Variable_Layered_20150611bak from Variable_Layered where  Variable like 'Q93%'

------update   Variable_Layered set Quest='Q93'  ,[Type]='MULTI' ,value=case when value>=1 then right(variable,2) else value end,
------							value_label=case when value>=1 then label else value_label end,G1_label=case when value>=1 then label else g1_label end,
------							G1=right(variable,2) where Variable like 'Q93%' 

--alter table Variable_Layered add ID int not null identity(1,1) primary key

 [dbo].[Data2015Q3$Victor]

 select 'alter table [Data2015Q3$Victor]  alter column '+quotename(column_name)+'  '+data_type
		+case when data_type like '%varchar' then concat('(', iif([CHARACTER_MAXIMUM_LENGTH]=-1,'max',cast([CHARACTER_MAXIMUM_LENGTH] as varchar)) ,') ') else ' ' end+';'+char(10)
 from [INFORMATION_SCHEMA].[COLUMNS] where table_name='tb_rawdata'


 --- select [CHARACTER_MAXIMUM_LENGTH],'alter table tb_rawdata alter column '+quotename(column_name)+' nvarchar(max) '   from [INFORMATION_SCHEMA].[COLUMNS] where table_name='tb_rawdata' and data_type='nvarchar' and [CHARACTER_MAXIMUM_LENGTH]>-1


--  alter index all on  tb_rawdata rebuild
 
  
--alter table tb_rawdata alter column [Q92] nvarchar(max) 
--alter table tb_rawdata alter column [Q93] nvarchar(max) 
--alter table tb_rawdata alter column [Q72_GRID_01_Q72A_GRID_1_0_Q72A] nvarchar(max) 
--alter table tb_rawdata alter column [Q72_GRID_02_Q72A_GRID_1_0_Q72A] nvarchar(max) 
--alter table tb_rawdata alter column [Q72_GRID_03_Q72A_GRID_1_0_Q72A] nvarchar(max) 
--alter table tb_rawdata alter column [Q72_GRID_04_Q72A_GRID_1_0_Q72A] nvarchar(max) 
--alter table tb_rawdata alter column [Q72_GRID_05_Q72A_GRID_1_0_Q72A] nvarchar(max) 
--alter table tb_rawdata alter column [Q72_GRID_06_Q72A_GRID_1_0_Q72A] nvarchar(max) 
--alter table tb_rawdata alter column [Q72_GRID_07_Q72A_GRID_1_0_Q72A] nvarchar(max) 
--alter table tb_rawdata alter column [Q72_GRID_08_Q72A_GRID_1_0_Q72A] nvarchar(max) 
--alter table tb_rawdata alter column [Q72_GRID_09_Q72A_GRID_1_0_Q72A] nvarchar(max) 
--alter table tb_rawdata alter column [Q72_GRID_10_Q72A_GRID_1_0_Q72A] nvarchar(max) 
--alter table tb_rawdata alter column [Q72_GRID_11_Q72A_GRID_1_0_Q72A] nvarchar(max) 
--alter table tb_rawdata alter column [Q72_GRID_12_Q72A_GRID_1_0_Q72A] nvarchar(max) 
--alter table tb_rawdata alter column [Q72_GRID_13_Q72A_GRID_1_0_Q72A] nvarchar(max) 
--alter table tb_rawdata alter column [Q110] nvarchar(max)  
 --alter table tb_rawdata add  CLUSTER int


 select ','+quotename( name)+'=Replace('+quotename(name)+','+quotename('#NULL!','''')+','''')' 
  from sys.columns(nolock) where object_id=object_id('[dbo].[Data2015Q3$Victor]')

  select  count(1) from [dbo].[Data2015Q3$Victor]



   select ','+quotename(name) 
   from sys.columns(nolock) where object_id=object_id('[dbo].[Data2015Q3$Victor]') for xml path('')

   --insert into tb_rawdata([Respondent_ID],[Q2_1],[Q3],[AGE_GROUP],[RACE_ETH],[Q13],[freq_shop],[Q1401],[Q1402],[Q1403],[Q1404],[Q1405],[Q1406],[Q1407],[Q7201],[Q7202],[Q7203],[Q7204],[Q7205],[Q7206],[Q7207],[Q7208],[Q7209],[Q7210],[Q7211],[Q7212],[Q7213],[Q15],[Q16],[Q63],[Q64],[QCB3],[QCB4],[Q72_A01],[Q72_A02],[Q72_A03],[Q72_A04],[Q72_A05],[Q72_A06],[Q72_A07],[Q72_A08],[Q72_A09],[Q72_A10],[Q72_A11],[MRK_FDO],[Q4_GRID_0_Q4],[Q5_GRID_01_Q5],[Q5_GRID_02_Q5],[Q5_GRID_03_Q5],[Q7_GRID_01_Q7],[Q7_GRID_02_Q7],[Q7_GRID_03_Q7],[Q7_GRID_04_Q7],[Q7_GRID_05_Q7],[Q8_GRID_01_Q8],[Q8_GRID_02_Q8],[Q8_GRID_03_Q8],[Q8_GRID_04_Q8],[Q9_GRID_01_Q9],[Q12A],[Q12C],[Q12D],[Q10_GRID_01_Q10],[Q6],[Q92],[Q93],[Q72_GRID_01_Q72A_GRID_1_0_Q72A],[Q72_GRID_02_Q72A_GRID_1_0_Q72A],[Q72_GRID_03_Q72A_GRID_1_0_Q72A],[Q72_GRID_04_Q72A_GRID_1_0_Q72A],[Q72_GRID_05_Q72A_GRID_1_0_Q72A],[Q72_GRID_06_Q72A_GRID_1_0_Q72A],[Q72_GRID_07_Q72A_GRID_1_0_Q72A],[Q72_GRID_08_Q72A_GRID_1_0_Q72A],[Q72_GRID_09_Q72A_GRID_1_0_Q72A],[Q72_GRID_10_Q72A_GRID_1_0_Q72A],[Q72_GRID_11_Q72A_GRID_1_0_Q72A],[Q72_GRID_12_Q72A_GRID_1_0_Q72A],[Q72_GRID_13_Q72A_GRID_1_0_Q72A],[Q110],[Q91A_GRID_01_Q91A],[Q91A_GRID_02_Q91A],[Q91A_GRID_03_Q91A],[Q91A_GRID_04_Q91A],[Q91A_GRID_05_Q91A],[Q91B_GRID_06_Q91B],[Q91B_GRID_07_Q91B],[Q91B_GRID_08_Q91B],[Q91B_GRID_10_Q91B],[Q91B_GRID_11_Q91B],[Q91C_GRID_09_Q91C],[Q91C_GRID_12_Q91C],[Q91C_GRID_13_Q91C],[Q91C_GRID_14_Q91C],[Q91D_GRID_15_Q91D],[Q100],[Q101_GRID_01_Q101],[Q101_GRID_02_Q101],[Q101_GRID_03_Q101],[Q102],[Q105],[Q106],[Q107],[Q108],[Q109],[Q115_GRID_01_Q115],[Q115_GRID_02_Q115],[Q116_GRID_01_Q116],[Q116_GRID_02_Q116],[Q116_GRID_03_Q116],[Q117_GRID_01_Q117],[Q117_GRID_02_Q117],[Q117_GRID_03_Q117],[Q117_GRID_04_Q117],[Q117_GRID_05_Q117],[Q117_GRID_06_Q117],[Q117_GRID_07_Q117],[Q118],[DATE_NUM],[MRK_SEG1],[InterviewLength],[MONTHX],[FDO_FISCAL_2015],[QUARTER_NEW],[YEAR_NEW],[weight],[RECEIPTNUM],[GROUP],[REGION],[DISTRICT],[CB_REG],[CB_RURAL],[URBANICITY],[CLUSTER],[Q92_INS01],[Q92_INS02],[Q92_INS03],[Q92_INS04],[Q92_INS05],[Q92_INS06],[Q92_INS07],[Q92_INS08],[Q92_INS09],[Q92_INS10],[Q92_INS11],[Q92_INS12],[Q92_INS13],[Q92_INS14],[Q92_INS15],[Q93_INS01],[Q93_INS02],[Q93_INS03],[Q93_INS04],[Q93_INS05],[Q93_INS06],[Q93_INS07],[Q93_INS08],[Q93_INS09],[Q93_INS10],[Q93_INS11],[Q93_INS12],[Q93_INS13],[Q93_INS14],[Q93_INS15],[id])
   --select  [Respondent_ID],[Q2_1],[Q3],[AGE_GROUP],[RACE_ETH],[Q13],[freq_shop],[Q1401],[Q1402],[Q1403],[Q1404],[Q1405],[Q1406],[Q1407],[Q7201],[Q7202],[Q7203],[Q7204],[Q7205],[Q7206],[Q7207],[Q7208],[Q7209],[Q7210],[Q7211],[Q7212],[Q7213],[Q15],[Q16],[Q63],[Q64],[QCB3],[QCB4],[Q72_A01],[Q72_A02],[Q72_A03],[Q72_A04],[Q72_A05],[Q72_A06],[Q72_A07],[Q72_A08],[Q72_A09],[Q72_A10],[Q72_A11],[MRK_FDO],[Q4_GRID_0_Q4],[Q5_GRID_01_Q5],[Q5_GRID_02_Q5],[Q5_GRID_03_Q5],[Q7_GRID_01_Q7],[Q7_GRID_02_Q7],[Q7_GRID_03_Q7],[Q7_GRID_04_Q7],[Q7_GRID_05_Q7],[Q8_GRID_01_Q8],[Q8_GRID_02_Q8],[Q8_GRID_03_Q8],[Q8_GRID_04_Q8],[Q9_GRID_01_Q9],[Q12A],[Q12C],[Q12D],[Q10_GRID_01_Q10],[Q6],[Q92],[Q93],[Q72_GRID_01_Q72A_GRID_1_0_Q72A],[Q72_GRID_02_Q72A_GRID_1_0_Q72A],[Q72_GRID_03_Q72A_GRID_1_0_Q72A],[Q72_GRID_04_Q72A_GRID_1_0_Q72A],[Q72_GRID_05_Q72A_GRID_1_0_Q72A],[Q72_GRID_06_Q72A_GRID_1_0_Q72A],[Q72_GRID_07_Q72A_GRID_1_0_Q72A],[Q72_GRID_08_Q72A_GRID_1_0_Q72A],[Q72_GRID_09_Q72A_GRID_1_0_Q72A],[Q72_GRID_10_Q72A_GRID_1_0_Q72A],[Q72_GRID_11_Q72A_GRID_1_0_Q72A],[Q72_GRID_12_Q72A_GRID_1_0_Q72A],[Q72_GRID_13_Q72A_GRID_1_0_Q72A],[Q110],[Q91A_GRID_01_Q91A],[Q91A_GRID_02_Q91A],[Q91A_GRID_03_Q91A],[Q91A_GRID_04_Q91A],[Q91A_GRID_05_Q91A],[Q91B_GRID_06_Q91B],[Q91B_GRID_07_Q91B],[Q91B_GRID_08_Q91B],[Q91B_GRID_10_Q91B],[Q91B_GRID_11_Q91B],[Q91C_GRID_09_Q91C],[Q91C_GRID_12_Q91C],[Q91C_GRID_13_Q91C],[Q91C_GRID_14_Q91C],[Q91D_GRID_15_Q91D],[Q100],[Q101_GRID_01_Q101],[Q101_GRID_02_Q101],[Q101_GRID_03_Q101],[Q102],[Q105],[Q106],[Q107],[Q108],[Q109],[Q115_GRID_01_Q115],[Q115_GRID_02_Q115],[Q116_GRID_01_Q116],[Q116_GRID_02_Q116],[Q116_GRID_03_Q116],[Q117_GRID_01_Q117],[Q117_GRID_02_Q117],[Q117_GRID_03_Q117],[Q117_GRID_04_Q117],[Q117_GRID_05_Q117],[Q117_GRID_06_Q117],[Q117_GRID_07_Q117],[Q118],[DATE_NUM],[MRK_SEG1],[InterviewLength],[MONTHX],[FDO_FISCAL_2015],[QUARTER_NEW],[YEAR_NEW],[weight],[RECEIPTNUM],[GROUP],[REGION],[DISTRICT],[CB_REG],[CB_RURAL],[URBANICITY],[CLUSTER],[Q92_INS01],[Q92_INS02],[Q92_INS03],[Q92_INS04],[Q92_INS05],[Q92_INS06],[Q92_INS07],[Q92_INS08],[Q92_INS09],[Q92_INS10],[Q92_INS11],[Q92_INS12],[Q92_INS13],[Q92_INS14],[Q92_INS15],[Q93_INS01],[Q93_INS02],[Q93_INS03],[Q93_INS04],[Q93_INS05],[Q93_INS06],[Q93_INS07],[Q93_INS08],[Q93_INS09],[Q93_INS10],[Q93_INS11],[Q93_INS12],[Q93_INS13],[Q93_INS14],[Q93_INS15],148147+[id]
   --from [dbo].[Data2015Q3$Victor]

   select distinct CLUSTER from [dbo].[Data2015Q3$Victor]
   select quarter_new,sum(weight) from tb_rawdata group by quarter_new

use [FamilyDollar_test]
 
select object_definition(object_id('p_get_crosstab_test3'))

select object_definition(object_id('[dbo].[p_get_KpiBreakdown]'))
select object_definition(object_id('[dbo].[p_get_KpiBreakdown_next]'))

select object_definition(object_id('[dbo].[p_get_Trend]'))

select object_definition(object_id('[dbo].[p_prepare_data]'))
select object_definition(object_id('[dbo].[p_get_DashBoard_TrackedKPI]'))
select object_definition(object_id('[dbo].[p_get_DashBoard]'))
select object_definition(object_id(''))

select * from variable_values where variable like 'Q91%'
select * from information_schema.columns where table_name='tb_rawdata' and data_type='nvarchar'

sp_helpindex'tb_rawdata'
sp_spaceused'tb_rawdata'

select * from sys.indexes where object_id=object_id('tb_rawdata')

 [dbo].[p_get_KpiBreakdown_test] 3,9,'Recommend','',50 ,-1 ,-1 ,-1

  [dbo].[p_get_KpiBreakdown] 3,10,'ASSORTMENT','',20 ,-1 ,-1 ,-1
 print getdate()
exec  [dbo].[p_get_KpiBreakdown] 3,9,'Recommend','',20 ,-1 ,-1 ,-1


select distinct quarter_new from tb_rawdata


 
select *    from tb_Userlist where username='long.chen'  ---Third user


 select count(1) from [FamilyDollar_TEST]..tb_Userlist