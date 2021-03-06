USE [FamilyDollar_test]
GO
 
 
	/* 
	 --victor zhang
 -- create date 2015-01-29 
 */
 
  
 	 update [dbo].[Cross Tab Spec$Victor] set [Filter] =isnull([Filter],''),
										[Cross Variable (Banner)]=isnull([Cross Variable (Banner)],''),
										[Down Variable (Stub)]=isnull([Down Variable (Stub)],''),
										 [type]=isnull([Type],''),
										 [Remove from % base]=isnull([Remove from % base] ,'');

	  update a set  a.Position  =b. Position
	  from [dbo].[Cross Tab Spec$Victor]  a inner join [dbo].[Variables] b on a.Variable=b.Variable
  
	  update  [dbo].[Cross Tab Spec$Victor]  set  Value = case when ISNUMERIC(Question)=1 then Question else null end
	  -----------------------------
	  update  a set Quest= b.Question
	  from [dbo].[Cross Tab Spec$Victor] a  inner join (
	  select distinct  Variable,Question from [dbo].[Cross Tab Spec$Victor]   where ISNUMERIC(Question) =0 and Question is not null ) b
	  on a.variable=b.variable

	  update [dbo].[Cross Tab Spec$Victor] set Quest='Q14'  where type='MULTI' and Variable like 'Q14__'
    
	  update [dbo].[Cross Tab Spec$Victor] set Quest='Q72_1'  where type='MULTI' and Variable like 'Q72__' and Variable not like 'Q72[_]_'

	  update [dbo].[Cross Tab Spec$Victor] set Quest='Q72_2'  where type='MULTI'  and Variable like 'Q72[_]A__' and Variable not  like 'Q72[_]_'

  
 -----------------------------

	update  a  set   [Response count]= 1
	from [dbo].[Cross Tab Spec$Victor] a inner join (select * from [dbo].[Cross Tab Spec$Victor] where Label='Response count') b
	on a.Variable=b.Variable
	 

	update  a  set   [Response count]= 1
	from [dbo].[Cross Tab Spec$Victor] a inner join (select * from [dbo].[Cross Tab Spec$Victor] where Label='Response count' ) b
	on a.Quest=b.Quest and a.Type='MULTI'

		update  a  set   [Response count]= 1,Quest=Variable 
	from [dbo].[Cross Tab Spec$Victor] a 
	 where Label like 'Quarter%'

	update  a  set   [Response count]= 1,Quest=Variable 
	from [dbo].[Cross Tab Spec$Victor] a 
	 where  Variable='StoreFormat'

	update  a  set   Quest=Variable 
	from [dbo].[Cross Tab Spec$Victor] a 
	 where  Variable='CLUSTER_UPDATED'

	update  a  set   Quest=Variable 
	from [dbo].[Cross Tab Spec$Victor] a 
	 where  Variable='YEAR_NEW'


	update [dbo].[Cross Tab Spec$Victor] set Val =  cast(Value as nvarchar)  
	where  label not like '%([0-9][/,.,-]%[0-9])%'  and   label not like '%([0-9])%'   

	update [dbo].[Cross Tab Spec$Victor] set Val = case when charindex('(',label)>0 and charindex(')',label)>charindex('(',label) then substring( label,charindex('(',label)+1,charindex(')',label)-charindex('(',label)-1)
														 else  cast(Value as nvarchar) end
	where  (label like '%([0-9][/,.,-]%[0-9])%'  or  label like '%([0-9])%'   )



	 update [dbo].[Cross Tab Spec$Victor] 
	 set Val=Replace(val,'-',',4,') 
	 where val='3-5'

	update [dbo].[Cross Tab Spec$Victor] 
	set Val=Replace(Replace(Replace(val,'/',','),'-',','),'.',',') 
	 where cast(Value as nvarchar)<> val

	update  a  set   Val=Question 
	from [dbo].[Cross Tab Spec$Victor] a 
	 where  Variable='YEAR_NEW' and ISNUMERIC(Question) =1


	 update a
	 set Question=cast(num as nvarchar),
		 val=num
	 from [dbo].[Cross Tab Spec$Victor] a inner join (
	 select row_number() over (order by ID) num,*  from [dbo].[Cross Tab Spec$Victor] where Variable='Quarter_NEW' and val is not null) b
	 on a.Variable=b.Variable and a.id=b.id
	 where a.Variable='Quarter_NEW' and a.Val is not null


	  update a
	  set a.Vals=b.vals
	  from [dbo].[Cross Tab Spec$Victor] a inner join 
	  (  select distinct 'Total' Label,Variable,Quest,Position,'-1'  as Value,t.Val as vals from [dbo].[Cross Tab Spec$Victor] a 
		 cross apply 
		 (select val=(select ','+Val from [dbo].[Cross Tab Spec$Victor] where val is not null and Quest =a.Quest  order by id For xml path('')) ) t
		  where a.val is not null 
	   ) b on a.Variable=b.Variable and a.Quest=b.Quest
	   where a.Val is not null

	 update    [dbo].[Cross Tab Spec$Victor] set val='1',vals=',1' where   Type='MULTI' and val is not null

------------------------------  
-------------------------------------------------------Year_Quarter----------------------------------------------------------------------
	 ---------- if object_id(N'dbo.Year_Quarter',N'U') is not null  
		----------			drop table Year_Quarter ;
		----------select y.*,q.Qrt_ID,q.Quarter_New
		----------	into Year_Quarter
		----------from (select  Value Year_ID,Value_label as Year_new from [dbo].[Variable_Values] where Variable='YEAR_NEW') y 
		----------	inner join (select  Value as Qrt_ID,right(left(Value_label,2),1) as Quarter_New,left(stuff(value_label,1,5,''),4) as Year_New from  [dbo].[Variable_Values] where Variable='QUARTER_NEW' ) q
		----------	 on y.year_new=q.Year_new  ;
  ----------      alter table dbo.Year_Quarter alter column [Year_ID]  int;
		----------alter table dbo.Year_Quarter alter column [Year_new]  int;
		----------alter table dbo.Year_Quarter alter column [Quarter_New]  int;
		----------alter table dbo.Year_Quarter alter column Qrt_ID int not null ;
		--------------alter table dbo.Year_Quarter  add constraint PK_Year_Quarter_Qrt_ID primary key(Qrt_ID asc ) ;
	
		---------- /* 
		----------   author victor zhang
		----------   date  20150403
		---------- */
		---------- Alter  View  V_Year_Quarter
		---------- as 
		----------	  select * from dbo.Year_Quarter
-------------go
 -------------------------------GOALS----------------------------------------------------------------------------------------
        drop INDEX [ix_nc_Goals] ON [dbo].[Goals] ;

	  alter table [dbo].[Goals] drop constraint [PK__Goals_PID] ;
	  alter table [dbo].[Goals] add constraint [PK__Goals_PID] primary key(PID);
		 CREATE NONCLUSTERED    INDEX [ix_nc_Goals] ON [dbo].[Goals]
		(
			[ID] ASC,[Goal Level]
		)
		INCLUDE (  [CASH Survey])  ;
 
		if object_id(N'dbo.Goals_Pivoted',N'U') is not null  
		drop table Goals_Pivoted

		select row_number() over(order by District) as ID,*  into Goals_Pivoted
		from (
		select  [Overall],[Group],[Region],[District],[CASH Survey] cs 
									from [dbo].[Goals] pivot(max(ID) for [Goal Level] in( [Group],[Region],[District],[Overall]))p 
									) t;
		update dbo.Goals_Pivoted set cs=100*cs ;
		update  dbo.Goals_Pivoted set District=isnull(District,0),Region=isnull(Region,0), [Group]=isnull([Group],0),[Overall]=isnull([Overall],0)
		alter table Goals_Pivoted alter column ID int not null  ;
		alter table Goals_Pivoted add constraint pk_Goals_Pivoted_ID primary key(ID) ;
		create index ix_nc_Goals_Pivoted_district on  [Goals_Pivoted](District) include(cs) where district >0;
		create index ix_nc_Goals_Pivoted_region on  [Goals_Pivoted](Region) include(cs) where Region>0;
		create index ix_nc_Goals_Pivoted_Group on  [Goals_Pivoted]([Group]) include(cs) where [Group]>0;
		create index ix_nc_Goals_Pivoted_overall on  [Goals_Pivoted]([Overall]) include(cs) where [Overall]>=-1;

-----------------------------------------------dashboard_TopNBot--------------------------------------------------------------- 
		 if object_id(N'dbo.dashboard_TopNBot',N'U') is not null  
				drop table dashboard_TopNBot
		select   v.Position, t.Variable  into dashboard_TopNBot
		   from (select cast('Q10_GRID_01_Q10' as nvarchar(50))  as Variable
				 union all   select   'Q12A'
				union all   select   'Q12C'
				union all   select   'Q12D'
				union all   select   'Q7_GRID_01_Q7'
				union all   select   'Q7_GRID_02_Q7'
				union all   select   'Q7_GRID_03_Q7'
				union all   select   'Q7_GRID_04_Q7'
				union all   select   'Q7_GRID_05_Q7'
				union all   select   'Q8_GRID_01_Q8'
				union all   select   'Q8_GRID_02_Q8'
				union all   select   'Q8_GRID_03_Q8'
				union all   select   'Q8_GRID_04_Q8'
				union all   select   'Q9_GRID_01_Q9' ) t inner join  [dbo].[Variables]   v  on t.variable=v.variable
				order by 1  ;

	    alter table dbo.dashboard_TopNBot alter column Position int not null 
		---alter table dashboard_TopNBot add constraint PK_dashboard_TopNBot_V primary key(Position) ;
		--create index ix_nc_dashboard_TopNBot_V on dashboard_TopNBot(Variable) ;
		----------------go
---------------------------------------------------------------------------------------------------------------
 -------------- 	  /*author :victor
	--------------		   create date:20150203
	--------------		  */
	--------------alter view [dbo].[v_dashboard_scoring_trending_CASH_var]
	--------------as   
	-------------- select   dashboard.variable,q.Label,q.[TopNBox],q.[Mid3Box],q.[Bot2Box]
	--------------   from  dbo.dashboard_TopNBot as dashboard (nolock) 
	--------------					 inner join [dbo].[Variables]  vr(nolock) on vr.Position=dashboard.Position
	--------------					 inner join [dbo].[Questionnaire] q(nolock) on  dashboard.Position=q.Position

------go

 --------------------------[Variables]----------------------------------------------------------------------------------------------------
--	;with c as(  select Variable,max(Value) mx,min(Value) mn 
--				 from [dbo].[Variable_Values]
--				 group by Variable)
--	 update a
--	 set  max_value=mx,min_value=mn
--	 from  [dbo].[Variables]  a inner join c on a.variable=c.variable

--	;with c as(  select Variable,max(Value) mx,min(Value) mn 
--				 from [dbo].[Variable_Values] 
--				 where   valid=1
--				 group by Variable) 
--	 update a
--	 set  max_value_valid=mx,min_value_valid=mn
--	 from  [dbo].[Variables] a inner join c on a.variable=c.variable
;
ALTER TABLE [dbo].[Variables] ADD  CONSTRAINT [pk_Variable_Position] PRIMARY KEY CLUSTERED 
(
	[Position] ASC
);

CREATE NONCLUSTERED INDEX [ix_nc_Variables] ON [dbo].[Variables]
(
	[Variable] ASC
)
INCLUDE ( 	[max_value],
	[min_value],
	[max_value_valid],
	[min_value_valid],
	[Label]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
 
   
----------------------------------------Questionnaire-------------------------------------------------------------------------------------------
 
 --------------  update a
	-------------- set    max_value=c.max_value,
	--------------		min_value=c.min_value,
	--------------		max_value_valid=c.max_value_valid,
	--------------		min_value_valid=c.min_value_valid,
	---------------      Position=c.Position
	-------------- from  [dbo].[Questionnaire]  a inner join [Variables] c on a.[Variable Name]=c.variable


------------------------------question_order
----------------  
---------------- update a
---------------- set questionorder=ct.num
---------------- from   [dbo].[Questionnaire]  a inner join ( select   row_number() over(partition by L3 order by id ) num,ID from   [dbo].[Questionnaire] where [Variable Name] is not null) ct on a.id=ct.id

------------ ---l3_order
------------;with c as (select L3,max(id) a,min(id) i from [dbo].[Questionnaire] group by L3)
------------,d as (select dense_rank() over(order by i) r,q.L3 from  [dbo].[Questionnaire] q inner join c on q.L3=c.L3)
------------update a
------------set a.L3_Order=d.r
------------from [dbo].[Questionnaire] a inner join d on a.L3=d.L3
 
----------------update a
----------------set mid3box='-98' ,max_value_valid=case when a.max_value=3 then 2 else a.max_value_valid end
---------------- from [dbo].[Questionnaire] a inner join [dbo].[Variables] b on a.[Variable Name] =b.Variable
---------------- where trend=1 and TopNbox='1'
 
----------------with c as (select row_number() over(partition by L3 order by (select null)) as num,* from  [dbo].[Questionnaire] where trend='1')
----------------update c
----------------set QuestionOrder=c.num --- from  [dbo].[Questionnaire] where trend=1
 
 
		----------update q
		----------set q.label=t.label
		----------from (
		----------select 'Overall Satisfaction' as label,'Q4_GRID_0_Q4' as variable
		----------union select 'Will return to shop FD' as label,'Q5_GRID_01_Q5' as variable
		----------union select 'Will recommend FD to family/friends' as label,'Q5_GRID_02_Q5' as variable
		----------union select 'Prefer FD for quick trip where I spend <$20' as label,'Q5_GRID_03_Q5' as variable
		----------union select 'CASH STORE STANDARDS' as label,'' as variable
		----------union select 'Aisles clear of boxes' as label,'Q7_GRID_01_Q7' as variable
		----------union select 'Coolers clean' as label,'Q7_GRID_02_Q7' as variable
		----------union select 'Entrance/check-out clear' as label,'Q7_GRID_03_Q7' as variable
		----------union select 'Floors clean' as label,'Q7_GRID_04_Q7' as variable
		----------union select 'Pleasant/neutral scent' as label,'Q7_GRID_05_Q7' as variable
		----------union select 'Products in-stock' as label,'Q8_GRID_01_Q8' as variable
		----------union select 'Prices clearly marked' as label,'Q8_GRID_02_Q8' as variable
		----------union select 'Products in proper place organized' as label,'Q8_GRID_03_Q8' as variable
		----------union select 'Packaging in good condition' as label,'Q8_GRID_04_Q8' as variable
		----------union select 'Employees friendly' as label,'Q9_GRID_01_Q9' as variable
		----------union select 'Greeted by employee' as label,'Q12A' as variable
		----------union select 'Thanked for purchase' as label,'Q12C' as variable
		----------union select 'Employee offered help' as label,'Q12D' as variable
		----------union select 'Speed of check-out' as label,'Q10_GRID_01_Q10' as variable
		----------union select 'AGREE THAT FAMILY DOLLAR HAS A WIDE VARIETY OF….' as label,'' as variable
		----------union select 'Food' as label,'Q91A_GRID_01_Q91A' as variable
		----------union select 'Cleaning/Laundry/Paper Products' as label,'Q91A_GRID_02_Q91A' as variable
		----------union select 'Pet Products' as label,'Q91A_GRID_03_Q91A' as variable
		----------union select 'Health/Beauty Products' as label,'Q91A_GRID_04_Q91A' as variable
		----------union select 'Baby Care Items' as label,'Q91A_GRID_05_Q91A' as variable
		----------union select 'Infant/Children''s Clothing' as label,'Q91B_GRID_06_Q91B' as variable
		----------union select 'Adult Clothing' as label,'Q91B_GRID_07_Q91B' as variable
		----------union select 'Housewares/Home Décor' as label,'Q91B_GRID_08_Q91B' as variable
		----------union select 'Toys/Games' as label,'Q91B_GRID_10_Q91B' as variable
		----------union select 'Party Goods' as label,'Q91B_GRID_11_Q91B' as variable
		----------union select 'School/Office Supplies' as label,'Q91C_GRID_09_Q91C' as variable
		----------union select 'Automotive/Hardware Products' as label,'Q91C_GRID_12_Q91C' as variable
		----------union select 'Small Electronics/Phones/Accessories' as label,'Q91C_GRID_13_Q91C' as variable
		----------union select 'Seasonal Items' as label,'Q91C_GRID_14_Q91C' as variable
		----------union select 'EMPLOYEE SPECIFIC QUESTIONS' as label,'' as variable
		----------union select 'Employees talking/texting on cell phone' as label,'Q100' as variable
		----------union select 'Wearing red FD shirt' as label,'Q101_GRID_01_Q101' as variable
		----------union select 'Wearing name tag' as label,'Q101_GRID_02_Q101' as variable
		----------union select 'Completely focused during check-out' as label,'Q101_GRID_03_Q101' as variable
		----------union select 'Cashier pointed out survey' as label,'Q102' as variable
		----------) t  inner join [dbo].[Questionnaire] q on t.variable !='' and t.variable=q.[variable Name]
		----------and q.trend=1

		 ----------update [dbo].[Questionnaire]
		 ----------set Label='Employees talking/texting on cell phone (% No)' where L3='EMPLOYEE SPECIFIC QUESTIONS' and [variable name]='Q100'
;
ALTER TABLE [dbo].[Questionnaire] ADD PRIMARY KEY CLUSTERED 
(
	[ID] ASC
);

		drop   INDEX [ix_nc_Questionnaire3_v] ON [dbo].[Questionnaire] ;
		CREATE NONCLUSTERED INDEX [ix_nc_Questionnaire3_v] ON [dbo].[Questionnaire]
		(
			[Variable Name] ASC,[L3] ASC,[L3_Order] ASC,[QuestionOrder] ASC,[Position] ASC
		)
		INCLUDE ( 	[TopNBox],[Mid3Box],[Bot2Box],[Trend]);

		drop   INDEX [ix_nc_Questionnaire3_position] ON [dbo].[Questionnaire] ;
		CREATE NONCLUSTERED INDEX [ix_nc_Questionnaire3_position] ON [dbo].[Questionnaire]
		(	[Position] ASC
		)
		INCLUDE ([L3] , [Variable Name],[TopNBox],
			[Mid3Box],
			[Bot2Box],
			[Trend],Label);

------------------------------------[Headline_Variable]-------------------------------------------
 
------update a 
------set KPI_ID=num
------from [Headline_Variable] a inner join  (select row_number() over(order by Position) num, * from  Headline_Variable) b on a.Position=b.Position
 
--   update a
--	 set    max_value=c.max_value,
--			min_value=c.min_value,
--			max_value_valid=c.max_value_valid,
--			min_value_valid=c.min_value_valid,
--			Position=c.Position
--	 from  [dbo].[Headline_Variable]  a inner join [Variables] c on a.variable=c.variable

	----update a 
	----set [Mid3Box]=b.[Mid3Box],
	----	[Bot2Box]=b.[Bot2Box],
	----	[TopNBox]=b.[TopNbox]
	----from [Headline_Variable] a inner join [dbo].[Questionnaire] b
	----on a.variable=b.[variable name]
 
 
alter table [Headline_Variable] add constraint PK_Position primary key(Position)
		--------CREATE NONCLUSTERED    INDEX [ix_nc_Headline_Variable_title] ON [dbo].[Headline_Variable]
		--------(
		--------	[title] ASC,[variable] ASC
		--------)INCLUDE ( 	[TopNBox],
		--------	[Mid3Box],
		--------	[Bot2Box]) ;
 
		--------CREATE NONCLUSTERED    INDEX [ix_nc_Headline_Variable_Var] ON [dbo].[Headline_Variable]
		--------(
		--------	[variable] ASC
		--------)
		--------INCLUDE ( 	[TopNBox],
		--------	[Mid3Box],
		--------	[Bot2Box])  ; 

------------------------------------[KPICalcs]-------------------------------------------
 
	  
		------------update a 
		------------set  a.KPI_ID=b.num
		------------from [KPICalcs]  a inner join (
		------------select row_number() over(order by mx) as num,KPI
		------------from (
		------------  select  max(id)   mx,kpi 
		------------  from [KPICalcs] a  
		------------  group by KPI) t ) b on a.KPI=b.KPI
		
--   update a
--	 set    max_value=c.max_value,
--			min_value=c.min_value,
--			max_value_valid=c.max_value_valid,
--			min_value_valid=c.min_value_valid,
--			Position=c.Position
--	 from  [dbo].KPICalcs  a inner join [Variables] c on a.variable=c.variable
 
	--update a 
	--set [Mid3Box]=b.[Mid3Box],
	--	[Bot2Box]=b.[Bot2Box],
	--	[TopNBox]=b.[TopNbox]
	--from [KPICalcs] a inner join [dbo].[Questionnaire] b
	--on a.variable=b.[variable name]
 
			ALTER TABLE [dbo].[KPICalcs] ADD PRIMARY KEY CLUSTERED 
			(				[id] ASC			) ;
 
			CREATE NONCLUSTERED INDEX [ix_nc_KPICalcs3_KPI] ON [dbo].[KPICalcs]	(				[KPI] ASC,[KPI_ID]			)  ;
 
			CREATE NONCLUSTERED INDEX [ix_nc_KPICalcs3_L2] ON [dbo].[KPICalcs]	( 	[L2] ASC ) ;
			CREATE NONCLUSTERED    INDEX [ix_nc_KPICalcs3_var] ON [dbo].[KPICalcs](	 [KPI_ID],[Variable],Position  )
			INCLUDE ([KPI], [TopNBox] ,[Mid3Box],[Bot2Box],[weight])   ; 

 ------------------------------------Trend_Scale_Breakdown-------------------------------------------------------------------------
 
	  if object_id(N'dbo.Trend_Scale_Breakdown',N'U') is not null  
	   drop table Trend_Scale_Breakdown ; 

		select * into [dbo].[Trend_Scale_Breakdown] 
		from (
		 select cast(1 as int)  AS ID,cast('' as nvarchar(30)) AS Scale ,cast(1 as tinyint) Category
		 union all select cast(2 as int)  AS ID,cast('BASE' as nvarchar(30)) AS Scale,cast(1 as tinyint) Category
		 union all select cast(5 as int)  AS ID,cast('Negative' as nvarchar(30)) AS Scale,cast(1 as tinyint) Category
		 union all select cast(4 as int)  AS ID,cast('Neutral' as nvarchar(30)) AS Scale,cast(1 as tinyint) Category
		 union all select cast(3 as int)  AS ID,cast('Positive' as nvarchar(30)) AS Scale,cast(1 as tinyint) Category
		 union all 

		 select cast(1 as int)  AS ID,cast('' as nvarchar(30)) AS Scale,cast(2 as tinyint) Category
		 union all select cast(2 as int)  AS ID,cast('BASE' as nvarchar(30)) AS Scale,cast(2 as tinyint) Category
		 union all select cast(5 as int)  AS ID,cast('Don''t know' as nvarchar(30)) AS Scale,cast(2 as tinyint) Category
		 union all select cast(4 as int)  AS ID,cast('NO' as nvarchar(30)) AS Scale,cast(2 as tinyint) Category
		 union all select cast(3 as int)  AS ID,cast('Yes' as nvarchar(30)) AS Scale,cast(2 as tinyint) Category
		) t
		 
  -------------------------------------------------------------------------------

	  if object_id(N'dbo.trends_head',N'U') is not null  
	   drop table trends_head ;

	 ---------- select q.L3,q.Label,q.[Variable Name],ts.Scale,ts.id,q.QuestionOrder,q.L3_Order,q.position,q.Position*10+ts.id as Pos_id
		----------	into trends_head
	 ----------from  [dbo].[Questionnaire] q inner join Trend_Scale_Breakdown ts on 1=1 and not(q.mid3box='-98' and ts.scale='Neutral')
	 ---------- where  q.Trend='1'
	 ---------- order by q.L3_Order ,q.QuestionOrder,ts.id  ;

	 ---------- update [dbo].[trends_head] set  id=case when Scale='Positive' Then '5' when  Scale='Negative' then '3' else id end  
		----------							  where L3= 'EMPLOYEE SPECIFIC QUESTIONS' and [variable name]='Q100'  ;

	 ---------- update [dbo].[trends_head] set Scale=case when Scale='Positive' Then 'Yes' when  Scale='Negative' then 'No' else Scale end   where L3= 'EMPLOYEE SPECIFIC QUESTIONS' ;
	  
	select * 
	    into trends_head
	from (
		select q.L3 as L2,q.L3,q.Label,q.[Variable Name],ts.Scale,ts.id,q.QuestionOrder,q.L3_Order,q.position,q.Position*10+ts.id as Pos_id
		 	
		 from  [dbo].[Questionnaire] q inner join Trend_Scale_Breakdown ts on 1=1 and not(q.mid3box='-98' and ts.scale='Neutral')
		  where  q.Trend='1' and not(q.L3= 'EMPLOYEE SPECIFIC QUESTIONS' and q.L3_Order=6)  and ts.Category=1
		union
		select q.L3 as L2,q.L3,q.Label,q.[Variable Name],ts.Scale,ts.id,q.QuestionOrder,q.L3_Order,q.position,q.Position*10+ts.id as Pos_id
		 from  [dbo].[Questionnaire] q inner join Trend_Scale_Breakdown ts on 1=1 and not(q.mid3box='-98' and ts.scale='Neutral')
		  where  q.Trend='1' and  (q.L3= 'EMPLOYEE SPECIFIC QUESTIONS' and q.L3_Order=6)  and ts.Category=2
	  ) t
	  order by  L3_Order , QuestionOrder, id  ;


	  update trends_head
	  set Scale=case Scale when 'Positive' then 'YES' when 'Negative'  then 'NO' else scale end
	  where Label in('Greeted by employee', 'Thanked for purchase', 'Employee offered help') and [Variable Name] in('Q12A','Q12C','Q12D')

	   update [dbo].[trends_head] set  Scale=case when ID=3 Then 'NO' when  ID=4 then 'YES' else Scale end  
							where L3= 'EMPLOYEE SPECIFIC QUESTIONS' and [variable name]='Q100'  ;

	   update [dbo].[trends_head]
	   set Label='Employees talking/texting</br>on cell phone (% No)'  -----'Employees talking/texting on cell phone (% No)' 
	   where  L3= 'EMPLOYEE SPECIFIC QUESTIONS' and [variable name]='Q100'

	   update [dbo].[trends_head]
	   set L3=N'OVERALL SATISFACTION & LOYALTY' where L3='OVERALL SATISFACTION'
	    update [dbo].[trends_head]
	   set L3=N'CASH SCORE ATTRIBUTES' where L3='CASH STORE STANDARDS'

	   -- update [dbo].[trends_head]
	   --set L2=N'CASH SCORE ATTRIBUTES' where L2='CASH STORE STANDARDS'

	     update [dbo].[trends_head]
	   set L3=N'CLEANLINESS' where L3='CASH SCORE ATTRIBUTES' and [Variable Name] in('Q7_GRID_01_Q7','Q7_GRID_02_Q7','Q7_GRID_03_Q7','Q7_GRID_04_Q7','Q7_GRID_05_Q7')

	      update [dbo].[trends_head]
	   set L3=N'ASSORTMENT' where L3='CASH SCORE ATTRIBUTES' and [Variable Name] in('Q8_GRID_01_Q8','Q8_GRID_02_Q8','Q8_GRID_03_Q8','Q8_GRID_04_Q8')
	   	      update [dbo].[trends_head]
	   set L3=N'SERVICE' where L3='CASH SCORE ATTRIBUTES' and [Variable Name] in('Q9_GRID_01_Q9','Q12A','Q12C','Q12D')
	   	      update [dbo].[trends_head]
	   set L3=N'H.S.' where L3='CASH SCORE ATTRIBUTES' and [Variable Name] in('Q10_GRID_01_Q10')

	 ---  select * from [dbo].[trends_head] where label='Aisles clear of boxes'
	  
	    
	  alter table trends_head alter column Pos_id  int   not null ;
	  alter table trends_head add constraint pk_pos_id primary key(Pos_id) ;
	   
	   ---drop  index ix_nc_trends_head_order  on trends_head ;
	  create    index ix_nc_trends_head_order  on trends_head(L3_Order , QuestionOrder, Pos_id,id,Position) include(L3,[Variable Name],Label,scale) ;
  
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		DROP INDEX [dbo].[Hierarchy].[ix_Hierarchy_district]
		DROP INDEX [dbo].[Hierarchy].[ix_Hierarchy_group]
		DROP INDEX [dbo].[Hierarchy].[ix_Hierarchy_Region]
		alter table [dbo].[Hierarchy] DROP constraint PK_Store;

		ALTER TABLE [dbo].[Hierarchy] ADD  CONSTRAINT [PK_Store] PRIMARY KEY CLUSTERED 	(			[Store] 		) ;
		CREATE NONCLUSTERED INDEX [ix_Hierarchy_district] ON [dbo].[Hierarchy]
		(
			[District] ,[Region],[Group]
		);
		CREATE NONCLUSTERED INDEX [ix_Hierarchy_Region] ON [dbo].[Hierarchy]
		(
			[Region] ASC,[Group]
		); 
		CREATE NONCLUSTERED INDEX [ix_Hierarchy_group] ON [dbo].[Hierarchy]
		(
			[Group] ASC
		) ; 
-----------------------------------------------tb_rawdata---------------------------------------------------------------------------
			drop index  [ix_nc_tb_rawdata_1]  on tb_rawdata ;
			drop index  [ix_nc_tb_rawdata_2]  on tb_rawdata ;
			drop index  [ix_nc_tb_rawdata_3]  on tb_rawdata ;
			drop index  [ix_nc_tb_rawdata_4]  on tb_rawdata ;
			drop index  [ix_nc_tb_rawdata_8]  on tb_rawdata ;
			drop index  [ix_nc_tb_rawdata_10]  on tb_rawdata ;
			drop index  [ix_nc_tb_rawdata_12] on tb_rawdata ;
			drop index  [ix_nc_tb_rawdata_13] on tb_rawdata ;
			drop index  [ix_nc_tb_rawdata_14] on tb_rawdata ;
			drop index  [ix_nc_tb_rawdata_15] on tb_rawdata ;

			alter table  [dbo].[tb_RawData]    drop  constraint [PK_tb_RawData_ID]
  
		 update tb_rawdata set [Group]= '-9999' ,  [Region]= '-9999' , district= '-9999' 
		  --update rd
		  --set rd.[group] = -9999,
		  --rd.[region] = -9999,
		  --rd.[district] = -9999 
		  --from [dbo].[tb_RawData] rd inner join [dbo].[Hierarchy] h on h.store = rd.q2_1 
		  update rd
		  set rd.[group] = h.[group],
		  rd.[region] = h.[region],
		  rd.[district] = h.[district] 
		  from [dbo].[tb_RawData] rd inner join [dbo].[Hierarchy] h on h.store = rd.q2_1
  
		  update tb_rawdata set [Group]=isnull([Group],'-9999'),  [Region]=isnull(region,'-9999'), district=isnull(district,'-9999') 
   	
 --- select count(*),count([Group]),count([REgion]),count(District)  from tb_rawdata where [group]>-9999

			alter table  [dbo].[tb_RawData]   add constraint [PK_tb_RawData_ID]  primary key(ID) ;

			CREATE NONCLUSTERED INDEX [ix_nc_tb_rawdata_1] ON [dbo].[tb_RawData]
			(
				[YEAR_NEW] ASC,	[QUARTER_NEW] ASC,	[Group] ASC,[Region] ASC,[District] ASC,[Q2_1] ASC	)
			INCLUDE ( 	
				[AGE_GROUP],[freq_shop],[RACE_ETH],[Q63],[Q64],	[weight],
				[Q10_GRID_01_Q10],
				[Q100],
				[Q101_GRID_01_Q101],
				[Q101_GRID_02_Q101],
				[Q101_GRID_03_Q101],
				[Q102],
				[Q105],
				[Q106],
				[Q107],
				[Q108],
				[Q109],
				[Q115_GRID_01_Q115],
				[Q115_GRID_02_Q115],
				[Q116_GRID_01_Q116],
				[Q116_GRID_02_Q116],
				[Q116_GRID_03_Q116],
				[Q117_GRID_01_Q117],
				[Q117_GRID_02_Q117],
				[Q117_GRID_03_Q117],
				[Q117_GRID_04_Q117],
				[Q117_GRID_05_Q117],
				[Q117_GRID_06_Q117],
				[Q117_GRID_07_Q117],
				[Q118],
				[Q12A],
				[Q12C],
				[Q12D],
				[Q4_GRID_0_Q4],
				[Q5_GRID_01_Q5],
				[Q5_GRID_02_Q5],
				[Q5_GRID_03_Q5],
				[Q7_GRID_01_Q7],
				[Q7_GRID_02_Q7],
				[Q7_GRID_03_Q7],
				[Q7_GRID_04_Q7],
				[Q7_GRID_05_Q7],
				[Q8_GRID_01_Q8],
				[Q8_GRID_02_Q8],
				[Q8_GRID_03_Q8],
				[Q8_GRID_04_Q8],
				[Q9_GRID_01_Q9],
				[Q91A_GRID_01_Q91A],
				[Q91A_GRID_02_Q91A],
				[Q91A_GRID_03_Q91A],
				[Q91A_GRID_04_Q91A],
				[Q91A_GRID_05_Q91A],
				[Q91B_GRID_06_Q91B],
				[Q91B_GRID_07_Q91B],
				[Q91B_GRID_08_Q91B],
				[Q91B_GRID_10_Q91B],
				[Q91B_GRID_11_Q91B],
				[Q91C_GRID_09_Q91C],
				[Q91C_GRID_12_Q91C],
				[Q91C_GRID_13_Q91C],
				[Q91C_GRID_14_Q91C]
				--,[CB_REG],[CB_RURAL],[URBANICITY],[Q92_INS01],[Q92_INS02],[Q92_INS03],[Q92_INS04],[Q92_INS05],[Q92_INS06],[Q92_INS07],[Q92_INS08],[Q92_INS09],[Q92_INS10],[Q92_INS11],[Q92_INS12],[Q92_INS13],[Q92_INS14],[Q92_INS15],[Q93_INS01],[Q93_INS02],[Q93_INS03],[Q93_INS04],[Q93_INS05],[Q93_INS06],[Q93_INS07],[Q93_INS08],[Q93_INS09],[Q93_INS10],[Q93_INS11],[Q93_INS12],[Q93_INS13],[Q93_INS14],[Q93_INS15]
				) ;
  
			CREATE NONCLUSTERED INDEX [ix_nc_tb_rawdata_2] ON [dbo].[tb_RawData]
			(
				[QUARTER_NEW] ASC,[Group] ASC,	[Region] ASC,[District] ASC,[Q2_1] ASC  )
			INCLUDE ( 	YEAR_NEW,
				[AGE_GROUP],
				[freq_shop],
				[RACE_ETH],
				[Q63],
				[Q64],
				[weight],
				[Q10_GRID_01_Q10],
				[Q100],
				[Q101_GRID_01_Q101],
				[Q101_GRID_02_Q101],
				[Q101_GRID_03_Q101],
				[Q102],
				[Q105],
				[Q106],
				[Q107],
				[Q108],
				[Q109],
				[Q115_GRID_01_Q115],
				[Q115_GRID_02_Q115],
				[Q116_GRID_01_Q116],
				[Q116_GRID_02_Q116],
				[Q116_GRID_03_Q116],
				[Q117_GRID_01_Q117],
				[Q117_GRID_02_Q117],
				[Q117_GRID_03_Q117],
				[Q117_GRID_04_Q117],
				[Q117_GRID_05_Q117],
				[Q117_GRID_06_Q117],
				[Q117_GRID_07_Q117],
				[Q118],
				[Q12A],
				[Q12C],
				[Q12D],
				[Q4_GRID_0_Q4],
				[Q5_GRID_01_Q5],
				[Q5_GRID_02_Q5],
				[Q5_GRID_03_Q5],
				[Q7_GRID_01_Q7],
				[Q7_GRID_02_Q7],
				[Q7_GRID_03_Q7],
				[Q7_GRID_04_Q7],
				[Q7_GRID_05_Q7],
				[Q8_GRID_01_Q8],
				[Q8_GRID_02_Q8],
				[Q8_GRID_03_Q8],
				[Q8_GRID_04_Q8],
				[Q9_GRID_01_Q9],
				[Q91A_GRID_01_Q91A],
				[Q91A_GRID_02_Q91A],
				[Q91A_GRID_03_Q91A],
				[Q91A_GRID_04_Q91A],
				[Q91A_GRID_05_Q91A],
				[Q91B_GRID_06_Q91B],
				[Q91B_GRID_07_Q91B],
				[Q91B_GRID_08_Q91B],
				[Q91B_GRID_10_Q91B],
				[Q91B_GRID_11_Q91B],
				[Q91C_GRID_09_Q91C],
				[Q91C_GRID_12_Q91C],
				[Q91C_GRID_13_Q91C],
				[Q91C_GRID_14_Q91C]
				) ;

	  CREATE NONCLUSTERED INDEX [ix_nc_tb_rawdata_3] ON [dbo].[tb_RawData]
			(
				[Group] ASC,[Region] ASC,		[District] ASC,				[Q2_1] ASC			)
			INCLUDE ( YEAR_NEW,QUARTER_NEW,
				[AGE_GROUP],
				[freq_shop],
				[RACE_ETH],
				[Q63],
				[Q64],
				[weight],
				[Q10_GRID_01_Q10],
				[Q100],
				[Q101_GRID_01_Q101],
				[Q101_GRID_02_Q101],
				[Q101_GRID_03_Q101],
				[Q102],
				[Q105],
				[Q106],
				[Q107],
				[Q108],
				[Q109],
				[Q115_GRID_01_Q115],
				[Q115_GRID_02_Q115],
				[Q116_GRID_01_Q116],
				[Q116_GRID_02_Q116],
				[Q116_GRID_03_Q116],
				[Q117_GRID_01_Q117],
				[Q117_GRID_02_Q117],
				[Q117_GRID_03_Q117],
				[Q117_GRID_04_Q117],
				[Q117_GRID_05_Q117],
				[Q117_GRID_06_Q117],
				[Q117_GRID_07_Q117],
				[Q118],
				[Q12A],
				[Q12C],
				[Q12D],
				[Q4_GRID_0_Q4],
				[Q5_GRID_01_Q5],
				[Q5_GRID_02_Q5],
				[Q5_GRID_03_Q5],
				[Q7_GRID_01_Q7],
				[Q7_GRID_02_Q7],
				[Q7_GRID_03_Q7],
				[Q7_GRID_04_Q7],
				[Q7_GRID_05_Q7],
				[Q8_GRID_01_Q8],
				[Q8_GRID_02_Q8],
				[Q8_GRID_03_Q8],
				[Q8_GRID_04_Q8],
				[Q9_GRID_01_Q9],
				[Q91A_GRID_01_Q91A],
				[Q91A_GRID_02_Q91A],
				[Q91A_GRID_03_Q91A],
				[Q91A_GRID_04_Q91A],
				[Q91A_GRID_05_Q91A],
				[Q91B_GRID_06_Q91B],
				[Q91B_GRID_07_Q91B],
				[Q91B_GRID_08_Q91B],
				[Q91B_GRID_10_Q91B],
				[Q91B_GRID_11_Q91B],
				[Q91C_GRID_09_Q91C],
				[Q91C_GRID_12_Q91C],
				[Q91C_GRID_13_Q91C],
				[Q91C_GRID_14_Q91C]
				) ;
 
  CREATE NONCLUSTERED INDEX [ix_nc_tb_rawdata_4] ON [dbo].[tb_RawData]
			(
				 [District] ASC,[Q2_1] ASC	)
			INCLUDE ( YEAR_NEW,QUARTER_NEW,[Group] ,[Region] ,
				[AGE_GROUP],
				[freq_shop],
				[RACE_ETH],
				[Q63],
				[Q64],
				[weight],
				[Q10_GRID_01_Q10],
				[Q100],
				[Q101_GRID_01_Q101],
				[Q101_GRID_02_Q101],
				[Q101_GRID_03_Q101],
				[Q102],
				[Q105],
				[Q106],
				[Q107],
				[Q108],
				[Q109],
				[Q115_GRID_01_Q115],
				[Q115_GRID_02_Q115],
				[Q116_GRID_01_Q116],
				[Q116_GRID_02_Q116],
				[Q116_GRID_03_Q116],
				[Q117_GRID_01_Q117],
				[Q117_GRID_02_Q117],
				[Q117_GRID_03_Q117],
				[Q117_GRID_04_Q117],
				[Q117_GRID_05_Q117],
				[Q117_GRID_06_Q117],
				[Q117_GRID_07_Q117],
				[Q118],
				[Q12A],
				[Q12C],
				[Q12D],
				[Q4_GRID_0_Q4],
				[Q5_GRID_01_Q5],
				[Q5_GRID_02_Q5],
				[Q5_GRID_03_Q5],
				[Q7_GRID_01_Q7],
				[Q7_GRID_02_Q7],
				[Q7_GRID_03_Q7],
				[Q7_GRID_04_Q7],
				[Q7_GRID_05_Q7],
				[Q8_GRID_01_Q8],
				[Q8_GRID_02_Q8],
				[Q8_GRID_03_Q8],
				[Q8_GRID_04_Q8],
				[Q9_GRID_01_Q9],
				[Q91A_GRID_01_Q91A],
				[Q91A_GRID_02_Q91A],
				[Q91A_GRID_03_Q91A],
				[Q91A_GRID_04_Q91A],
				[Q91A_GRID_05_Q91A],
				[Q91B_GRID_06_Q91B],
				[Q91B_GRID_07_Q91B],
				[Q91B_GRID_08_Q91B],
				[Q91B_GRID_10_Q91B],
				[Q91B_GRID_11_Q91B],
				[Q91C_GRID_09_Q91C],
				[Q91C_GRID_12_Q91C],
				[Q91C_GRID_13_Q91C],
				[Q91C_GRID_14_Q91C]
				) ;

  		CREATE NONCLUSTERED INDEX [ix_nc_tb_rawdata_8] ON [dbo].[tb_RawData]
			( 
				[Q2_1] ,[District] ,	[REgion],[Group],			 YEAR_NEW,    QUARTER_NEW			)
			INCLUDE ( 	
				[AGE_GROUP],
				[freq_shop],
				[RACE_ETH],
				[Q63],
				[Q64],
				[weight],
				[Q10_GRID_01_Q10],
				[Q100],
				[Q101_GRID_01_Q101],
				[Q101_GRID_02_Q101],
				[Q101_GRID_03_Q101],
				[Q102],
				[Q105],
				[Q106],
				[Q107],
				[Q108],
				[Q109],
				[Q115_GRID_01_Q115],
				[Q115_GRID_02_Q115],
				[Q116_GRID_01_Q116],
				[Q116_GRID_02_Q116],
				[Q116_GRID_03_Q116],
				[Q117_GRID_01_Q117],
				[Q117_GRID_02_Q117],
				[Q117_GRID_03_Q117],
				[Q117_GRID_04_Q117],
				[Q117_GRID_05_Q117],
				[Q117_GRID_06_Q117],
				[Q117_GRID_07_Q117],
				[Q118],
				[Q12A],
				[Q12C],
				[Q12D],
				[Q4_GRID_0_Q4],
				[Q5_GRID_01_Q5],
				[Q5_GRID_02_Q5],
				[Q5_GRID_03_Q5],
				[Q7_GRID_01_Q7],
				[Q7_GRID_02_Q7],
				[Q7_GRID_03_Q7],
				[Q7_GRID_04_Q7],
				[Q7_GRID_05_Q7],
				[Q8_GRID_01_Q8],
				[Q8_GRID_02_Q8],
				[Q8_GRID_03_Q8],
				[Q8_GRID_04_Q8],
				[Q9_GRID_01_Q9],
				[Q91A_GRID_01_Q91A],
				[Q91A_GRID_02_Q91A],
				[Q91A_GRID_03_Q91A],
				[Q91A_GRID_04_Q91A],
				[Q91A_GRID_05_Q91A],
				[Q91B_GRID_06_Q91B],
				[Q91B_GRID_07_Q91B],
				[Q91B_GRID_08_Q91B],
				[Q91B_GRID_10_Q91B],
				[Q91B_GRID_11_Q91B],
				[Q91C_GRID_09_Q91C],
				[Q91C_GRID_12_Q91C],
				[Q91C_GRID_13_Q91C],
				[Q91C_GRID_14_Q91C]
				) ;

	CREATE NONCLUSTERED INDEX [ix_nc_tb_rawdata_10] ON [dbo].[tb_RawData]
			(  
				 Quarter_NEW,     [Group]
			)
			INCLUDE ( 	
				[AGE_GROUP],
				[freq_shop],
				[RACE_ETH],
				[Q63],
				[Q64],
				[weight],
				[Q10_GRID_01_Q10],
				[Q100],
				[Q101_GRID_01_Q101],
				[Q101_GRID_02_Q101],
				[Q101_GRID_03_Q101],
				[Q102],
				[Q105],
				[Q106],
				[Q107],
				[Q108],
				[Q109],
				[Q115_GRID_01_Q115],
				[Q115_GRID_02_Q115],
				[Q116_GRID_01_Q116],
				[Q116_GRID_02_Q116],
				[Q116_GRID_03_Q116],
				[Q117_GRID_01_Q117],
				[Q117_GRID_02_Q117],
				[Q117_GRID_03_Q117],
				[Q117_GRID_04_Q117],
				[Q117_GRID_05_Q117],
				[Q117_GRID_06_Q117],
				[Q117_GRID_07_Q117],
				[Q118],
				[Q12A],
				[Q12C],
				[Q12D],
				[Q4_GRID_0_Q4],
				[Q5_GRID_01_Q5],
				[Q5_GRID_02_Q5],
				[Q5_GRID_03_Q5],
				[Q7_GRID_01_Q7],
				[Q7_GRID_02_Q7],
				[Q7_GRID_03_Q7],
				[Q7_GRID_04_Q7],
				[Q7_GRID_05_Q7],
				[Q8_GRID_01_Q8],
				[Q8_GRID_02_Q8],
				[Q8_GRID_03_Q8],
				[Q8_GRID_04_Q8],
				[Q9_GRID_01_Q9],
				[Q91A_GRID_01_Q91A],
				[Q91A_GRID_02_Q91A],
				[Q91A_GRID_03_Q91A],
				[Q91A_GRID_04_Q91A],
				[Q91A_GRID_05_Q91A],
				[Q91B_GRID_06_Q91B],
				[Q91B_GRID_07_Q91B],
				[Q91B_GRID_08_Q91B],
				[Q91B_GRID_10_Q91B],
				[Q91B_GRID_11_Q91B],
				[Q91C_GRID_09_Q91C],
				[Q91C_GRID_12_Q91C],
				[Q91C_GRID_13_Q91C],
				[Q91C_GRID_14_Q91C]
				) ;

CREATE NONCLUSTERED INDEX [ix_nc_tb_rawdata_12]
ON [dbo].[tb_RawData] ([YEAR_NEW],[Group])
INCLUDE ([Q4_GRID_0_Q4],[Q5_GRID_01_Q5],[Q5_GRID_02_Q5],[Q5_GRID_03_Q5],[Q7_GRID_01_Q7],[Q7_GRID_02_Q7],[Q7_GRID_03_Q7],[Q7_GRID_04_Q7],[Q7_GRID_05_Q7],[Q8_GRID_01_Q8],[Q8_GRID_02_Q8],[Q8_GRID_03_Q8],[Q8_GRID_04_Q8],[Q9_GRID_01_Q9],[Q12A],[Q12C],[Q12D],[Q10_GRID_01_Q10],[Q91A_GRID_01_Q91A],[Q91A_GRID_02_Q91A],[Q91A_GRID_03_Q91A],[Q91A_GRID_04_Q91A],[Q91A_GRID_05_Q91A],[Q91B_GRID_06_Q91B],[Q91B_GRID_07_Q91B],[Q91B_GRID_08_Q91B],[Q91B_GRID_10_Q91B],[Q91B_GRID_11_Q91B],[Q91C_GRID_09_Q91C],[Q91C_GRID_12_Q91C],[Q91C_GRID_13_Q91C],[Q91C_GRID_14_Q91C],[Q100],[Q101_GRID_01_Q101],[Q101_GRID_02_Q101],[Q101_GRID_03_Q101],[Q102],[QUARTER_NEW],[weight]);
 
CREATE NONCLUSTERED INDEX [ix_nc_tb_rawdata_13]
ON [dbo].[tb_RawData] ([District],[YEAR_NEW])
INCLUDE ([Q4_GRID_0_Q4],[Q5_GRID_01_Q5],[Q5_GRID_02_Q5],[Q5_GRID_03_Q5],[Q7_GRID_01_Q7],[Q7_GRID_02_Q7],[Q7_GRID_03_Q7],[Q7_GRID_04_Q7],[Q7_GRID_05_Q7],[Q8_GRID_01_Q8],[Q8_GRID_02_Q8],[Q8_GRID_03_Q8],[Q8_GRID_04_Q8],[Q9_GRID_01_Q9],[Q12A],[Q12C],[Q12D],[Q10_GRID_01_Q10],[Q91A_GRID_01_Q91A],[Q91A_GRID_02_Q91A],[Q91A_GRID_03_Q91A],[Q91A_GRID_04_Q91A],[Q91A_GRID_05_Q91A],[Q91B_GRID_06_Q91B],[Q91B_GRID_07_Q91B],[Q91B_GRID_08_Q91B],[Q91B_GRID_10_Q91B],[Q91B_GRID_11_Q91B],[Q91C_GRID_09_Q91C],[Q91C_GRID_12_Q91C],[Q91C_GRID_13_Q91C],[Q91C_GRID_14_Q91C],[Q100],[Q101_GRID_01_Q101],[Q101_GRID_02_Q101],[Q101_GRID_03_Q101],[Q102],[weight],[Group],[Region]) ;

CREATE NONCLUSTERED INDEX [ix_nc_tb_rawdata_14]
ON [dbo].[tb_RawData] ([YEAR_NEW],[Group],[District])
INCLUDE ([Q7_GRID_01_Q7],[Q7_GRID_02_Q7],[Q7_GRID_03_Q7],[Q7_GRID_04_Q7],[Q7_GRID_05_Q7],[Q8_GRID_01_Q8],[Q8_GRID_02_Q8],[Q8_GRID_03_Q8],[Q8_GRID_04_Q8],[Q9_GRID_01_Q9],[Q12A],[Q12C],[Q10_GRID_01_Q10],[QUARTER_NEW],[weight],[Region]);

 
CREATE NONCLUSTERED INDEX ix_nc_tb_rawdata_15   ON [dbo].[tb_RawData] ([QUARTER_NEW],[District])  INCLUDE ([Q2_1],[Group],[Region])
---------------------------------------------[tb_userlist]---------------------------------------------------------------------------------------------------------------------------------
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

--------------------------------------sp_refreshview-------------------------------------------------------------------------------------------------------

		exec sp_refreshview 'v_RawData_Hierarchy_SF';

		exec sp_refreshview 'v_RawData_Hierarchy_SC';

		exec sp_refreshview 'view_FD_VerbatimsRawData';

		exec sp_refreshview 'v_RawData_Hierarchy_SCSF';

		exec sp_refreshview 'v_tb_FamilyDollar_RawData';

		exec sp_refreshview 'v_dashboard_scoring_trending_CASH_var';

		exec sp_refreshview 'v_RawData_Hierarchy';

		exec sp_refreshview 'V_KPI';
		exec sp_refreshview 'view_FD_VerbatimsRawData_Q92Q93';
		exec sp_refreshview 'V_Year_Quarter'



 






