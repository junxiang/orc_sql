
use FamilyDollar_test 
go

--exec sp_rename '[dbo].[tb_rawdata]','tb_rawdata_Q3'
--exec sp_rename '[dbo].[tb_rawdata_20151125BAK]','tb_rawdata'

----truncate table nonsense_char
----insert into nonsense_char
----select  char(number) chr,  number code  
---- from master..spt_values where type ='P' and (number between 0 and 47   or  number between 48 and 57
----								or number between 58 and 64
----								 or number between 91 and 96
----								or number between 123 and 127 )

select * from nonsense_char where  chr='';

 --drop table nonsense_char
select * into nonsense_char from [FamilyDollar_TEST]..nonsense_char


--insert into nonsense_char values(char(10)+char(13),-1013)
--insert into nonsense_char values(char(13)+char(10),-1310)
--insert into nonsense_char values(char(32),32)
--insert into nonsense_char values(char(10),10)

--insert into nonsense_char values(char(9),10)
select * from  nonsense_char 

 --insert into Junk_word_clouds_list
 --select  'Family',max(noisewordid)+1 from Junk_word_clouds_list

--	drop table [FamilyDollar]..Top_n_word_clouds_list
--	go

--    select * into  [FamilyDollar]..Junk_word_clouds_list from [FamilyDollar_TEST]..Junk_word_clouds_list
--	select * into  [FamilyDollar]..Top_n_word_clouds_list from [FamilyDollar_TEST]..Top_n_word_clouds_list

 
--CREATE TABLE [dbo].[Junk_word_clouds_list](
--	[NoiseWord] [nvarchar](1000) NULL,
--	[NoiseWordId] [int] NULL
--) ON [PRIMARY]

--GO
 
--CREATE TABLE [dbo].[Top_n_word_clouds_list](
--	[id] [int] IDENTITY(1,1) NOT NULL,
--	[word] [nvarchar](1000) NULL,
--PRIMARY KEY CLUSTERED 
--(
--	[id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]

--GO


		--insert into Junk_word_clouds_list values('it')
		--select char(number) from master..spt_values where type='P'  and number between 1 and 255
		select top 1000 *  from Respondent_CloudWord_list  
		select * from Junk_word_clouds_list where  NoiseWordID is null


		select count(*) from Respondent_CloudWord_list where exists(select * from Junk_word_clouds_list where NoiseWord=word)

		select max(len(word)) from Respondent_CloudWord_list

		select distinct Question_Postion  from Respondent_CloudWord_list

-------------------------------------------------------------------------------------
		 truncate table Respondent_CloudWord_list
		 go
		 drop  index [ix_nc_qw]  on Respondent_CloudWord_list ;
 
		 alter table Respondent_CloudWord_list drop constraint PK_GID ;
		 alter table Respondent_CloudWord_list drop column GID; 
		 alter table Respondent_CloudWord_list drop constraint [cd_raw_id]  ;
		 alter table Respondent_CloudWord_list drop constraint [top_cd_word_id]  ;
		--select ' exec P_Split_String_2_Words '''+Variable+''' ;
		--go ' from     [dbo].[Variables] where variable like 'Q72_GRID____Q72A_GRID_1_0_Q72A'
		go
		 exec P_Split_String_2_Words 'Q72_GRID_01_Q72A_GRID_1_0_Q72A' ;
				go 
		 exec P_Split_String_2_Words 'Q72_GRID_02_Q72A_GRID_1_0_Q72A' ;
				go 
		 exec P_Split_String_2_Words 'Q72_GRID_03_Q72A_GRID_1_0_Q72A' ;
				go 
		 exec P_Split_String_2_Words 'Q72_GRID_04_Q72A_GRID_1_0_Q72A' ;
				go 
		 exec P_Split_String_2_Words 'Q72_GRID_05_Q72A_GRID_1_0_Q72A' ;
				go 
		 exec P_Split_String_2_Words 'Q72_GRID_06_Q72A_GRID_1_0_Q72A' ;
				go 
		 exec P_Split_String_2_Words 'Q72_GRID_07_Q72A_GRID_1_0_Q72A' ;
				go 
		 exec P_Split_String_2_Words 'Q72_GRID_08_Q72A_GRID_1_0_Q72A' ;
				go 
		 exec P_Split_String_2_Words 'Q72_GRID_09_Q72A_GRID_1_0_Q72A' ;
				go 
		 exec P_Split_String_2_Words 'Q72_GRID_10_Q72A_GRID_1_0_Q72A' ;
				go 
		 exec P_Split_String_2_Words 'Q72_GRID_11_Q72A_GRID_1_0_Q72A' ;
				go 
		 exec P_Split_String_2_Words 'Q72_GRID_12_Q72A_GRID_1_0_Q72A' ;
				go 
		 exec P_Split_String_2_Words 'Q72_GRID_13_Q72A_GRID_1_0_Q72A' ;
		go  ------
		exec P_Split_String_2_Words 'Q6'
		go
		exec P_Split_String_2_Words 'Q92'
		go
		exec P_Split_String_2_Words 'Q93'
		go
		exec P_Split_String_2_Words 'Q110'
		go
    drop table ##raw ; 
	go
	   
	 while exists( 	 select 1 from Respondent_CloudWord_list 
							 where ascii(right(word,1)) between 0 and 47 or ascii(right(word,1)) between 48 and 57
								or ascii(right(word,1)) between 58 and 64  or ascii(right(word,1)) between 91 and 96
								or ascii(right(word,1)) between 123 and 127 )
	 begin
	 update Respondent_CloudWord_list set Word =stuff(word,len(word),1,'') 	where ascii(right(word,1)) between 0 and 47 
								 or ascii(right(word,1)) between 48 and 57
								or ascii(right(word,1)) between 58 and 64
								 or ascii(right(word,1)) between 91 and 96
								or ascii(right(word,1)) between 123 and 127 ;
	 end ;
	 go

	 while exists( 	 select 1 from Respondent_CloudWord_list 
							 where ascii(left(word,1)) between 0 and 47 
							 or ascii(left(word,1)) between 48 and 57
								or ascii(left(word,1)) between 58 and 64
								 or ascii(left(word,1)) between 91 and 96
								or ascii(left(word,1)) between 123 and 127 )
	 begin
	 update Respondent_CloudWord_list set Word =stuff(word,1,1,'') 	where ascii(left(word,1)) between 0 and 47 
								or ascii(left(word,1)) between 48 and 57
								or ascii(left(word,1)) between 58 and 64
								 or ascii(left(word,1)) between 91 and 96
								or ascii(left(word,1)) between 123 and 127 ;
	 end ;
	 go

	 alter table Respondent_CloudWord_list add word_id int;
	 go
	  
	update Respondent_CloudWord_list set Word =ltrim(rtrim(lower(word)))
		
	delete from Respondent_CloudWord_list where word is null or  len(word)<=1 or isnumeric(word)=1
	delete a from Respondent_CloudWord_list a inner join [dbo].[Junk_word_clouds_list] b on  b.noiseword=a.word 
	
	go

	 truncate table Top_n_word_clouds_list ;
	 insert into Top_n_word_clouds_list(word)
	 select distinct  word from Respondent_CloudWord_list
	 go

	  update a set a.word_id=b.id
	  from Respondent_CloudWord_list a inner join Top_n_word_clouds_list b
	  on a.word=b.word
	go

	  alter table Respondent_CloudWord_list add GID bigint not null identity(1,1) ;
	  alter table Respondent_CloudWord_list add constraint PK_GID primary key(GID);
	  alter table Respondent_CloudWord_list add constraint top_cd_word_id foreign key(word_id) references Top_n_word_clouds_list(id) ;
	  alter table Respondent_CloudWord_list add constraint cd_raw_id foreign key(RawID) references tb_rawdata(id) ;
	  CREATE NONCLUSTERED   INDEX  ix_nc_qw ON [dbo].[Respondent_CloudWord_list] ([Question_Postion],[RawID],[word_id])  
go	   
	  alter index all on Respondent_CloudWord_list rebuild

go
	--select  word,Replace(word,'///','') from Respondent_CloudWord_list where word like '%//%' len(word)=(select max(len(word))     from Respondent_CloudWord_list)
	--update Respondent_CloudWord_list set Word =Replace(word,'///','') where word like '%///%'

	--update Respondent_CloudWord_list set Word =Replace(word,'!','') where GID=64849
	


	select * from Top_n_word_clouds_list


	 select gid, word,stuff(word,len(word),1,'') from Respondent_CloudWord_list 
	 where ascii(right(word,1)) between 0 and 47  or ascii(right(word,1)) between 48 and 57
	    or ascii(right(word,1)) between 58 and 64 
	    or ascii(right(word,1)) between 91 and 96
		or ascii(right(word,1)) between 123 and 127
	 select  word,stuff(word,1,1,'') from Respondent_CloudWord_list 
	 where ascii(left(word,1)) between 33 and 47 or ascii(left(word,1)) between 48 and 57
	    or ascii(left(word,1)) between 58 and 64
	    or ascii(left(word,1)) between 91 and 96
		or ascii(left(word,1)) between 123 and 126

---------------------------------------------------------------------
 select count( * ) from Respondent_CloudWord_list  where isnumeric(word)=1

select * from [dbo].[Questionnaire] where L3='OPEN'
select * from wordcloud_question
--drop table wordcloud_question
--select case when variable like 'Q72_GRID____Q72A_GRID_1_0_Q72A' then 4 when variable in('Q92','Q93') then 3 
--			when variable ='Q6' then 2 when Variable='Q110' then 1 end as Group1,
--			case when variable like 'Q72_GRID____Q72A_GRID_1_0_Q72A' then N'Q72_GRID' when variable in('Q92','Q93') then N'Q92Q93' 
--			else Variable  end as Group1_Text,
--		Variable,Position 
--		  into wordcloud_question
--		from    [dbo].[Variables] where variable in('Q6','Q92','Q93','Q110') or variable like 'Q72_GRID____Q72A_GRID_1_0_Q72A' 
--		order by position
 
go
/*
 author:victor zhang
 date:20150817
 function :split text to words
 -- select * from nonsense_char
*/
Alter proc P_Split_String_2_Words
(
 @Col2Split varchar(100)
 )
as
begin
--set nocount  on;

--select top 10 * from [FamilyDollar_TEST].[dbo].[WordTable]

--select top 5 * from tb_rawdata

	--declare @Col2Split varchar(100)='Q110' --'Q93' -- 'Q92' --'Q6' 
	declare @max_len int 
	declare @question_number int
	declare @sql nvarchar(max)=''

	if exists(select * from [tempdb].sys.objects where name='##raw' and type ='U')
	begin
	truncate table ##raw ;
	drop table ##raw ;
	end

	set @sql=N'select  ID, ['+@Col2Split+'] into ##raw  from tb_rawdata(nolock) where ['+@Col2Split+']>'''' ';
	exec sp_executesql @sql;

	set @sql=N'
	declare @i int=1,@chr nvarchar(10);

	while  exists(select * from nonsense_char where code>=@i)
	begin 
	   select top 1 @chr= chr,@i=code+1 from nonsense_char where code>=@i order by code ;
	   if  @chr is  not null and  @chr!='' '' 
	   	   update  ##raw set  ['+@Col2Split+']= Replace( ['+@Col2Split+'],@chr,'' '') ; 
	   
	 end 
	  update  ##raw set  ['+@Col2Split+']= Replace( ['+@Col2Split+'],char(10),'' '') ; 
	   update  ##raw set  ['+@Col2Split+']= Replace( ['+@Col2Split+'],char(13),'' '') ; 
	    update  ##raw set  ['+@Col2Split+']= Replace( ['+@Col2Split+'],char(9),'' '') ; 
	   
	 ';
	exec sp_executesql @sql;
	 
	 
	set @sql=N' set  @max_len=( select max(len( ['+@Col2Split+'])) from tb_rawdata(nolock) ) ;
				set @question_number=(select top 1 Position from [dbo].[Variables] where Variable='''+@Col2Split+''') ;'

	exec sp_executesql @sql,N'@max_len int output,@question_number int output ' ,@max_len output,@question_number output ;
	    
		
--	drop 	table Respondent_CloudWord_list
	if object_id(N'Respondent_CloudWord_list','U') is null 
	begin
		create     table Respondent_CloudWord_list(RawID bigint,Question_Postion int,Word nvarchar(4000)) ;
	end	
		 
	set   @sql=N'if object_id(N''tb_number'',N''U'') is not null  drop table tb_number ; 
				 select [ID] number into tb_number from tb_rawdata where ID between 1 and @max_len   ;
				 alter table tb_number add constraint pk_id primary key(number) ; ';
	exec sp_executesql @sql,N'@max_len int',@max_len;


	set @sql=N'; 
	 insert into Respondent_CloudWord_list(RawID,Question_Postion,Word)
	 SELECT    a.[ID],'+cast(@question_number as nvarchar(10))+', Word=SUBSTRING(a.['+@Col2Split+'],number,CHARINDEX('' '',a.['+@Col2Split+']+'' '',number)-number) 
	 FROM tb_number  num,  ##raw   a(nolock)
	 WHERE number<=len(a.['+@Col2Split+']+''a'') 
	  AND CHARINDEX('' '','' ''+a.['+@Col2Split+'],number)=number 
	  and len(SUBSTRING(a.['+@Col2Split+'],number,CHARINDEX('' '',a.['+@Col2Split+']+'' '',number)-number))>1
	  and isnumeric(SUBSTRING(a.['+@Col2Split+'],number,CHARINDEX('' '',a.['+@Col2Split+']+'' '',number)-number))=0
	  and not exists( select 1 from Junk_word_clouds_list(nolock) where  NoiseWord=SUBSTRING(a.['+@Col2Split+'],number,CHARINDEX('' '',a.['+@Col2Split+']+'' '',number)-number)  )
	  '
	  exec sp_executesql @sql,N'@max_len int',@max_len;
	   
 

--set nocount off ;
end ;

go


  --select * from [dbo].[Top_n_word_clouds_list]
  -- select * from wordcloud_question
  -- select * from [dbo].[Junk_word_clouds_list]
/*
 author:victor zhang
 date:20150817
 function :split text to words
 --p_gen_word_clouds 3,11,50,0,0,0,'','','','','','','','','','',N'Q92Q93','Store',0,0
 --p_gen_word_clouds 3,null,null,0,0,0,'','','','','','','','','','',N'Q6','',0,0

  print getdate()
 exec p_gen_word_clouds 3,null,null,0,0,0,'','','','','','','','','','',N'Q92Q93','',0,0
 exec p_gen_word_clouds 3,null,null,0,0,0,'','','','','','','','','','',N'Q72_GRID','',0,0
  exec p_gen_word_clouds 3,null,null,0,0,0,'','','','','','','','','','',N'Q72_GRID','size',0,.5
 exec p_gen_word_clouds 3,0,10,12,151,5449,'','','','','','','','','','',N'Q6','',0,30
  exec p_gen_word_clouds 3,11,10,12,151,0,'','','','','','','','','','',N'Q72_GRID','',0,0
*/

alter proc p_gen_word_clouds
(
@YEAR_NEW int ,
@QUARTER_NEW int ,  
@group int  , 
@region int  ,
@district int  ,
@store  int ,
@Age   nvarchar(100)='',
@Frequency_of_shopping  nvarchar(100)='',
@Gender  nvarchar(100)='',
@Income  nvarchar(100)='',
@Racial_background  nvarchar(100)='',
@Government_benefits  nvarchar(100)='',
@Store_Format  nvarchar(100)='',
@Store_Cluster  nvarchar(100)='',
@Shopper_Segment  nvarchar(100)='',
@DensityClass varchar(50)='',
@question nvarchar(50),
@search_text nvarchar(max)='',
@min_count int =0,
@min_percentage float=0
 )
as
begin
set nocount on ;
	 declare @sql nvarchar(max)='' , 
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @like_text nvarchar(max);
  
            set @search_text=iif(@search_text='Search','',@search_text) ;
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	

			declare @gb nvarchar(1000)=N'';
		  if len(@Government_benefits)=0 or len(@Government_benefits)-len( Replace(@Government_benefits,'0',''))=11 or @Government_benefits is null
		  begin
				set @gb=null;
		  end
		  else
		  begin 
			  select @gb=@gb+case when   data='1' then  concat('or [Q72_A',right(('000'+cast(id as nvarchar(2))),2),']=',data,char(10)) else ''  end 
			  from  [dbo].[f_FamilyDollar_SplitStr](@Government_benefits,',') 	 
		  end
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +') ' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +') ' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +') ' else '' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +') ' else '' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +') ' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+') ' else '' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +') '  else '' end+
						 case when @QUARTER_NEW>0 then '  and QUARTER_NEW='+cast(@QUARTER_NEW as nvarchar)+' ' when @YEAR_NEW>0 then '  and YEAR_NEW='+cast(@YEAR_NEW as nvarchar)+' ' else '' end  +
						 case when len(@DensityClass)>0 then ' and Density_Class  in( '+@DensityClass+')  '  else '' end;
						
   set @like_text  =iif(len(@search_text)<=0,N'',
						case when  @question='Q92Q93' then ' and (  
																  Q92 like '+quotename('%' +@search_text  + '%','''')+' 
															   or Q93 like '+quotename('%'+@search_text  + '%','''')+' '
							when  @question='Q6' then ' and (  Q6 like '+quotename('%' +@search_text  + '%','''')+' '
							when  @question='Q72_GRID' then '  and (  
															   [Q72_GRID_01_Q72A_GRID_1_0_Q72A] like '+quotename('%' +@search_text  + '%','''')+' 
															or [Q72_GRID_02_Q72A_GRID_1_0_Q72A] like '+quotename('%' +@search_text  + '%','''')+' 
															or [Q72_GRID_03_Q72A_GRID_1_0_Q72A] like '+quotename('%' +@search_text  + '%','''')+'
															or [Q72_GRID_04_Q72A_GRID_1_0_Q72A] like '+quotename('%' +@search_text  + '%','''')+'
															or [Q72_GRID_05_Q72A_GRID_1_0_Q72A] like '+quotename('%' +@search_text  + '%','''')+'
															or [Q72_GRID_06_Q72A_GRID_1_0_Q72A] like '+quotename('%' +@search_text  + '%','''')+'
															or [Q72_GRID_07_Q72A_GRID_1_0_Q72A] like '+quotename('%' +@search_text  + '%','''')+'
															or [Q72_GRID_08_Q72A_GRID_1_0_Q72A] like '+quotename('%' +@search_text  + '%','''')+'
															or [Q72_GRID_09_Q72A_GRID_1_0_Q72A] like '+quotename('%' +@search_text  + '%','''')+'
															or [Q72_GRID_10_Q72A_GRID_1_0_Q72A] like '+quotename('%' +@search_text  + '%','''')+'
															or [Q72_GRID_11_Q72A_GRID_1_0_Q72A] like '+quotename('%' +@search_text  + '%','''')+'
															or [Q72_GRID_12_Q72A_GRID_1_0_Q72A] like '+quotename('%' +@search_text  + '%','''')+'
															or [Q72_GRID_13_Q72A_GRID_1_0_Q72A] like '+quotename('%' +@search_text  + '%','''')+' '
							when  @question='Q110' then ' and (    Q110 like '+quotename('%' +@search_text  + '%','''')+' ' else '' end  
							+'   )'	);

 
			 set @where_raw=@where_con+@like_text;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +') '  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +') '  end;
 
  
	

	set @sql=N'; 
			select   TOP  '+  case when @min_count>0 then '  '+cast(@min_count as nvarchar)  
					 when @min_percentage>0 then '  '+cast(@min_percentage as nvarchar) +' percent'  else '  100 ' end  
			+'	 Word_ID,count(word_id)  cnt 
			     into #cte
				 from Respondent_CloudWord_list  wcl(nolock) 
						inner join    wordcloud_question    qst (nolock)
				 on  qst.position =wcl.Question_Postion
				 where     qst.Group1_text='''+ @question  +'''
			 '+isnull(N'  and exists( select  1 from    tb_rawdata   t (nolock) '+char(10)
									+' where wcl.RawID= t.id '+char(10)
					+nullif(
					coalesce(' and [Q2_1]='+cast(@store as nvarchar)+char(10),' and District='+cast(@district as nvarchar)+char(10) ,' and [Region]='+cast(@region as nvarchar)+char(10),' and [Group]='+cast(@group as nvarchar)+char(10),'') 
					+isnull(' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+char(10)+@where_sf+') '+char(10),'')
					+isnull(' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sc+')  '+char(10),'')
					+@where_raw,'') +char(10)+'  )   '
					
					,'')  +char(10) 

					+' group by Word_ID 
					   order by cnt desc ;
					 
				select     tn.word , ct.cnt --- ,ct.cnt*100.0/sum(ct.cnt) over(order by (select null) ) Percentage
					from #cte ct inner join Top_n_word_clouds_list tn(nolock) 
					on   ct.word_id=tn.id 
					order by ct.cnt desc
					    '
				 
 exec sp_executesql @sql;
 ---print @sql
set nocount off;

end ;
go 


select * from Top_n_word_clouds_list where len(word)<(select max(len(word)) from Top_n_word_clouds_list) order by len(word) desc
