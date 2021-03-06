USE [FamilyDollar]
GO
/****** Object:  StoredProcedure [dbo].[A]    Script Date: 27/10/2015 10:33:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 查看存储过程或方法或视图      
CREATE proc [dbo].[A]
@procname nvarchar(700)      
as
exec p_helptext @procname 
GO
/****** Object:  StoredProcedure [dbo].[p_FamilyDollar_getBatchSelect]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- use FamilyDollar
CREATE PROC [dbo].[p_FamilyDollar_getBatchSelect] (@fun NVARCHAR(80) ,@Select NVARCHAR(max))     
AS     
  BEGIN     
    DECLARE @sub_sql NVARCHAR(max)     
    DECLARE @sub_result NVARCHAR(max)     
    SET @sub_sql=''     
    DECLARE @sub_output float     
    DECLARE @sub_size INT     
    DECLARE @sub_index INT     
    DECLARE @sub_distinctTable TABLE     
      (     
         id   INT IDENTITY(1, 1),     
         data NVARCHAR(max)     
      )     
    INSERT INTO @sub_distinctTable     (data)     
    SELECT data     
    FROM   dbo.f_FamilyDollar_splitstr(@Select, '_jimiCutjimi_')     
    SELECT @sub_size = Count(*)     
    FROM   @sub_distinctTable     
    SET @sub_index=0     
    SET @sub_result=''     
    WHILE @sub_index < @sub_size     
      BEGIN     
          SELECT @sub_sql = data     
          FROM   @sub_distinctTable     
          WHERE  id = ( @sub_index + 1 )     
          IF @sub_sql <> ''     
            BEGIN     
                BEGIN try     
                    SET @sub_sql=     
                    ' select @cnt='+@fun+' from tb_FamilyDollar_RawData_v where 1=1 '     
                    + @sub_sql     
                    EXEC Sp_executesql     
                      @sub_sql,     
                      N'@cnt float output',     
                      @sub_output output     
                    SET @sub_result=@sub_result     
                                    + CONVERT(NVARCHAR(150), isnull(@sub_output,0), 120) +     
                                    ','     
                END try     
                BEGIN catch     
                    SET @sub_sql=     ' select @cnt='+@fun+' from tb_FamilyDollar_RawData_v where 1=1 '     + @sub_sql     
                   -- SELECT @sub_sql     
                END catch     
            END     
          SET @sub_index=@sub_index + 1     
      END     
      IF( Len(@sub_result) > 1 )     
      BEGIN     
          SET @sub_result=Substring(@sub_result, 0, Len(@sub_result))     
      END     
    SELECT @sub_result   
END 



GO
/****** Object:  StoredProcedure [dbo].[p_FamilyDollar_getBatchSelect_multiplication]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- use FamilyDollar
-- p_FamilyDollar_getBatchSelect_multiplication '',''
CREATE PROC [dbo].[p_FamilyDollar_getBatchSelect_multiplication] (@fun NVARCHAR(80) ,@Select NVARCHAR(max))     
AS     
  BEGIN     
    DECLARE @sub_sql NVARCHAR(max)     
    DECLARE @sub_result NVARCHAR(max)     
    SET @sub_sql=''     
    DECLARE @sub_output nvarchar(220)     
    DECLARE @sub_size INT     
    DECLARE @sub_index INT     
    DECLARE @sub_distinctTable TABLE     
      (     
         id   INT IDENTITY(1, 1),     
         data NVARCHAR(max)     
      )     
    INSERT INTO @sub_distinctTable     (data)     
    SELECT data     
    FROM   dbo.f_FamilyDollar_splitstr(@Select, '_jimiCutjimi_')     
    SELECT @sub_size = Count(*)     
    FROM   @sub_distinctTable     
    SET @sub_index=0     
    SET @sub_result=''     
    WHILE @sub_index < @sub_size     
      BEGIN     
          SELECT @sub_sql = data     
          FROM   @sub_distinctTable     
          WHERE  id = ( @sub_index + 1 )     
          IF @sub_sql <> ''     
            BEGIN     
                BEGIN try     
                    SET @sub_sql=     
                    ' select @cnt=convert(nvarchar(120),sum(weight),120)+''_''+convert(nvarchar(120),sum(weight*weight),120) from tb_FamilyDollar_RawData_v where 1=1 '     
                    + @sub_sql     
                    EXEC Sp_executesql     
                      @sub_sql,     
                      N'@cnt nvarchar(220) output',     
                      @sub_output output     
                    SET @sub_result=@sub_result     
                                    + CONVERT(NVARCHAR(150), isnull(@sub_output,0), 120) +     
                                    ','     
                END try     
                BEGIN catch     
                    --SET @sub_sql=     ' select @cnt='+@fun+' from tb_FamilyDollar_RawData_v where 1=1 '     + @sub_sql     
                   -- SELECT @sub_sql     
                END catch     
            END     
          SET @sub_index=@sub_index + 1     
      END     
      IF( Len(@sub_result) > 1 )     
      BEGIN     
          SET @sub_result=Substring(@sub_result, 0, Len(@sub_result))     
      END     
    SELECT @sub_result   
END 

GO
/****** Object:  StoredProcedure [dbo].[p_FamilyDollar_getDistinctRow]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- use FamilyDollar
-- exec p_FamilyDollar_getDistinctRow 'Q5','and 1=1'                         
CREATE proc [dbo].[p_FamilyDollar_getDistinctRow]                      
(                          
  @Column NVARCHAR(170),  @Where NVARCHAR(max)                            
)                          
as                          
begin                           
   DECLARE @str NVARCHAR(max)                                            
   set @Where=@Where                             
   begin               
    if(@Column= 'Q5')              
    begin 
        set @str=''                          
        SET @str= ' SELECT  distinct                          '                      
        set @str=@str+  ' convert(int,Q5) as RowValue '                
        set @str=@str+  ' FROM tb_FamilyDollar_RawData_v                              '                      
        set @str=@str+ ' where 1=1 '+ @Where                   
        set @str=@str+  ' order by RowValue  desc                             '                     
        exec Sp_executesql @str                                     
    end               
    else              
    begin              
        set @str=''                          
        SET @str= ' SELECT  distinct                          '                      
        set @str=@str+ @Column +' as RowValue                                '                
        set @str=@str+  ' FROM tb_FamilyDollar_RawData_v                              '                      
        set @str=@str+  ' where 1=1 '+ @Where                   
        set @str=@str+  ' order by RowValue  desc                             '                     
        exec Sp_executesql @str          
    end                 
   end                      
                         
end 

GO
/****** Object:  StoredProcedure [dbo].[p_FamilyDollar_getSelectNum]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec p_FamilyDollar_getSelectNum ''           
CREATE proc [dbo].[p_FamilyDollar_getSelectNum]   
(            
   @Select NVARCHAR(max)              
)            
as            
begin             
   exec Sp_executesql @Select           
end 

GO
/****** Object:  StoredProcedure [dbo].[P_FamilyDollar_getxyresult]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec p_FamilyDollar_getXYResult 'Q3','Q3',' '    
-- select top 10 * from tb_FamilyDollar_RawData_v     
-- P_FamilyDollar_getxyresult 'Member','Member',''                                                                                       
CREATE proc [dbo].[P_FamilyDollar_getxyresult] (@X         NVARCHAR(300),                                   
                                            @parameter NVARCHAR(300),                                   
                                            @Where     NVARCHAR(max))                                   
AS                                   
  BEGIN                                   
  DECLARE @str NVARCHAR(max)                                   
  DECLARE @strBase_total NVARCHAR(max)                                   
  DECLARE @strDistinct_x NVARCHAR(max)                                   
  DECLARE @strDistinct_y NVARCHAR(max)                                
  SET @strBase_total= ' SELECT  sum(weight) as allBase FROM tb_FamilyDollar_RawData_v  where 1=1 '                                   
       + @Where   + dbo.f_FamilyDollar_getxyCondition(@X)                                   
       + dbo.f_FamilyDollar_getxyCondition(@parameter)                                                           
  EXEC Sp_executesql   @strBase_total                                   
  SET @str=''                                   
  SET @str= ' SELECT    outTable.' + @parameter                                   
    + ' as yValue ,' + '  outTable.' + @X                                   
    + ' as xValue , ' + '  sum(weight) as num'                                   
    + ' ,(select sum(weight) from tb_FamilyDollar_RawData_v as inTable where 1=1 and inTable.'                                   
    + @parameter + '=outTable.' + @parameter + ' '                                   
    + @Where                                   
    + dbo.f_FamilyDollar_getxyCondition('inTable.' + @parameter)                                   
    + dbo.f_FamilyDollar_getxyCondition('inTable.' + @X)                                  
    + ' )  as Base'                                   
    + ' ,(select sum(weight) from tb_FamilyDollar_RawData_v as inTable where 1=1 and inTable.'                                   
    + @X + '=outTable.' + @X + ' ' + @Where                                   
    + dbo.f_FamilyDollar_getxyCondition('inTable.' + @X)                                   
    + dbo.f_FamilyDollar_getxyCondition('inTable.' + @parameter)                                   
    + ' ) as BaseColumn'   
	+ ' ,sum(weight*weight) as multiplication'                                   
    + ' FROM tb_FamilyDollar_RawData_v as outTable'                                   
    + ' where 1=1 ' + @Where                                   
    + dbo.f_FamilyDollar_getxyCondition('outTable.' + @X)                                   
    + dbo.f_FamilyDollar_getxyCondition('outTable.' + @parameter)                                   
    + ' group by  outTable.' + @X + ',outTable.'                                   
    + @parameter                                   
  -- select    @str                       
  EXEC Sp_executesql @str                                 
  --|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||                                  
    SET @strDistinct_x= ' SELECT distinct ' + @X                                   
        + ',sum(weight) as num ,dbo.F_FamilyDollar_getordernum( '+ @X+ ','''+@X+''') OrderNum' 
		+ ' ,sum(weight*weight) as multiplication'                                      
        + ' FROM tb_FamilyDollar_RawData_v '                                   
        + ' where 1=1 ' + @Where                            
        + dbo.f_FamilyDollar_getxyCondition(@X)                                   
        + dbo.f_FamilyDollar_getxyCondition(@parameter)                                   
        + ' group by ' + @X + ' order by OrderNum  '   +dbo.f_FamilyDollar_getOrderType(@X,'c')                            
     --|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||                                  
  EXEC Sp_executesql @strDistinct_x                               
  --select @strDistinct_x                            
  SET @strDistinct_y= ' SELECT distinct ' + @parameter + ''                                   
      + ',sum(weight) as num ,dbo.F_FamilyDollar_getordernum('+ @parameter+ ','''+@parameter+''')  OrderNum,sum(weight*weight) as multiplication FROM tb_FamilyDollar_RawData_v  '                                   
      + ' where 1=1 ' + @Where                                   
      + dbo.f_FamilyDollar_getxyCondition( @parameter)                                   
      + dbo.f_FamilyDollar_getxyCondition(@X)                                   
      + ' group by ' + @parameter                                   
      + ' order by OrderNum   '   +dbo.f_FamilyDollar_getOrderType(@parameter,'d')                            
  EXEC Sp_executesql @strDistinct_y                                 
  --select @strDistinct_y                              
END 

GO
/****** Object:  StoredProcedure [dbo].[p_gen_word_clouds]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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
 exec p_gen_word_clouds 3,null,null,0,0,0,'','','','','','','','','','',N'Q6','',0,0
 exec p_gen_word_clouds 3,null,null,0,0,0,'','','','','','','','','','',N'Q72_GRID','',0,0
  exec p_gen_word_clouds 3,null,null,0,0,0,'','','','','','','','','','',N'Q72_GRID','size',0,.5
 exec p_gen_word_clouds 3,0,10,12,151,5449,'','','','','','','','','','',N'Q6','',0,30
  exec p_gen_word_clouds 3,11,10,12,151,0,'','','','','','','','','','',N'Q72_GRID','',0,0
*/

CREATE proc [dbo].[p_gen_word_clouds]
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

GO
/****** Object:  StoredProcedure [dbo].[p_get_c_test]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
  ---author victor
 ---createdate 2015-01-27
 [p_get_crosstab] 3,10,'AGE_GROUP','AGE_GROUP',11,'',-1,-1,-1,-1
  [p_get_crosstab] 3,10,'YEAR_NEW','Q10_GRID_01_Q10',11,'',-1,-1,-1,-1
    
    [p_get_c_test] 3,-1,'Q106','Q109',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
  [p_get_c_test] 3,-1,'Q106','Q109',22,0,' ',-1,-1,-1,-1,'','','','','','','','',''
  [p_get_c_test] 3,-1,'Q106','Q109',12,0,' ',-1,-1,-1,-1,'','','','','','','','',''
  [p_get_c_test] 3,-1,'Q9a','Q15',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

   [p_get_c_test] 3,-1,'Q14','Q2',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   [p_get_c_test] 3,-1,'Q2','Q14',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   [p_get_c_test] 3,-1,'Q2','Q14',12,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   [p_get_c_test] 3,-1,'Q2','Q14',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   [p_get_c_test] 3,-1,'Q2','Q14',22,0,' ',-1,-1,-1,-1,'','','','','','','','',''

    [p_get_c_test] 3,-1,'Q2','Q2',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

	 [p_get_c_test] 3,-1,'Q2','Q63',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
      
 Stats: Column %           11
		Row %              21 
		Col % w/counts     12 
		Row % w/counts     22
		select* from Stats_Index
select * from [dbo].[Cross Tab Spec$Victor] where label like '%what%'
*/
CREATE   procedure [dbo].[p_get_c_test](
@YEAR_NEW int , 
@QUARTER_NEW int  ,
@columnname  nvarchar(100),
@rowname  nvarchar(100),
@STATS   tinyint=0,
@SIGNIFICANCE float =0.0,
@wherecondition nvarchar(max) ,
@group int  ,
@region int  ,
@district int  ,
@store  int  ,
@Age   nvarchar(50)='',
@Frequency_of_shopping  nvarchar(50)='',
@Gender  nvarchar(50)='',
@Income  nvarchar(50)='',
@Racial_background  nvarchar(50)='',
@Government_benefits  nvarchar(50)='',
@Store_Format  nvarchar(50)='',
@Store_Cluster  nvarchar(50)='',
@Shopper_Segment  nvarchar(50)='' 
)
as 
begin 

   set nocount on ; 
   declare @sql nvarchar(max) ='',
		   @form1   nvarchar(max)='',
		   @form2  nvarchar(max)='',
		   @form2_1  nvarchar(max)='',
		   @form4  nvarchar(max)='',
		   @form5  nvarchar(max)='',
		   @form6  nvarchar(max)='',
		   @form7  nvarchar(max)='',
		   @form8  nvarchar(max)='',
		   @form8_1  nvarchar(max)='',
		   @form3 nvarchar(4000)='',@form3_1 nvarchar(4000)='',
		   @raw nvarchar(max)='',
		   @groupby nvarchar(max)='' ,
		   @hierarchy nvarchar(max)='',	
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),@where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int, 
		   @item   nvarchar(20)='',
		   @col nvarchar(max)='',
		   @formw nvarchar(max)='',
		   @variable nvarchar(500),
		   @type nvarchar(20)='SINGLE';
			
			set @columnname=ltrim(rtrim(@columnname));
			set @rowname=ltrim(rtrim(@rowname));
			if len(@columnname)<=0 return ;
			if len(@rowname)<=0 return;

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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;


---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 '+
						(case when @YEAR_NEW>0 then ' and YEAR_NEW='+cast(+@YEAR_NEW as nvarchar) else ' ' end)+
						(case when @QUARTER_NEW>0 then ' and QUARTER_NEW='+cast(@QUARTER_NEW as nvarchar) else ' ' end),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 


	set @groupby= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						   case when  @district  is null then null else ',[Group],[Region],District' end ,
						   case when  @region is null then null else ',[Group],[Region]' end,
						   case when  @group  is null then null else ',[Group]' end, ''		 );

	set @hierarchy	=isnull(' and Store='+cast(@store as nvarchar) ,'')+
					 isnull( ' and District='+cast(@district as nvarchar),'')+
					 isnull( ' and [Region]='+cast(@region as nvarchar)  ,'')+
					 isnull( ' and [Group]='+cast(@group as nvarchar)  ,'')
	
	---Total  = -1 	
	---CNT=-2
	---Base = 0
	 select top 1 @item=quotename(Item) from [Stats_Index] where Num=@STATS;	
	  

	select @form1=@form1+ concat(',sum(case when ', quotename(variable),'  in(',iif( [Type]='MULTI','1',Val),') then ','[Weight]',' else 0 end)  as ',quotename(Value)
								,',sum(case when ', quotename(variable),'  in(',iif( [Type]='MULTI','1',Val),') then ',' cast(1.0 as float) ',' else cast(0.0 as float) end)  as [',Value,'-2]') +char(10)
			,@form2=@form2+concat(',',quotename(Value,'''''')) 
			,@form2_1=@form2_1+concat(',''',Value,'-2''') 
			,@form3=@form3+ (case when [Type]='MULTI' then 'or '+quotename(variable)+' in(1) '  else ','+ Val end)
			,@formw=@formw+(case when [Type]='MULTI' then concat('+ (case when ',quotename(Variable),'=1 then 1 else 0 end)') else ' ' end)
			,@variable=variable
			,@type=[Type]
    from [dbo].[Cross Tab Spec$Victor]  where     Quest=@rowname  and val is not null;
	 
	set @form3_1=case when @type='MULTI' then 'sum( case when '+stuff( @form3,1,2,'')+' then cast(1.0 as float)/[w@] else cast(null as float) end)' 
					else 'sum(case when '+ quotename(@variable)+'  in('+stuff( @form3,1,1,'')+') then cast(1.0 as float) else cast(null as float) end) '    end+' as [-2]';	 
			
	set @form3_1=Replace(@form3_1,'/[w@]','/('+stuff(@formw,1,1,'')+')');
					  
	set @form3=case when @type='MULTI' then 'sum( case when '+stuff( @form3,1,2,'')+' then [Weight]/[w@]  end)' 
					else 'sum(case when '+ quotename(@variable)+'  in('+stuff( @form3,1,1,'')+') then [Weight] end) '    end+' as [-1]';


	 set @form3=Replace(@form3,'/[w@]','/('+stuff(@formw,1,1,'')+')');
 

	set @form4=Replace(Replace(@form2,',''',',['),'''',']')+',[-1]'+Replace(Replace(@form2_1,',''',',['),'''',']')+',[-2]'


    select  @col=@col+ case when [Type]='MULTI' then concat(' when ',quotename(Variable),' in(1) then ',quotename(Value,''''),'  ') 
							else  concat(' when ',quotename(Variable),' in(',Val,') then ',quotename(Value,''''),' ') end+char(10) 	
	       ,@form6=@form6+','+quotename(Value)
		   ,@form7=@form7+ ','+quotename(Value)+','+''','+cast(Value as nvarchar)+';'''
		   ,@form8=@form8+concat(',R.',quotename(Value),
									case when left(@STATS,1)=2  then '/nullif(R.Total,0.0) ' 
										 when  left(@STATS,1)=1 then '/ case when RT.'+quotename(Value)+' is null  then 1.0 else  nullif(RT.'+quotename(Value) +',0.0) end ' else '' end,' as ',quotename(Label))
		   ,@form8_1=@form8_1+concat(',',quotename(Value),' as ',quotename(Label))
	  from [dbo].[Cross Tab Spec$Victor] where   Quest= @columnname  and val is not null;   	
	   
	declare @t_form nvarchar(max)='';
	;with c as (select Value as  number from [dbo].[Cross Tab Spec$Victor] where  Quest= @columnname  and val is not null)
	select @t_form=@t_form+concat(', dbo.F_TTest_SR(',quotename(c1.number),',[',c1.number,'-2],',quotename(c2.number),',[',c1.number,'-2],0.999) as [',c1.number,'!',c2.number,']') 
	from c c1  inner join c c2 on c1.number<>c2.number  	order by c1.number, c2.number  ;   
	 
	set @columnname=quotename(@columnname);
	  
	set @sql=@raw+ N' 
			, c as (
			 select  case '+@col+' else ''-9999'' end as [xaxis]
					'+@form1+','+@form3+','+@form3_1+'
			 from  rawdata 
			 group by   case '+@col+' else ''-9999'' end
			 ) 
			,tab as ( 
			select  *  from (
					 select concat(xaxis,case when charindex(''-2'','+@item+')>0 then ''-2'' else null end) as xaxis,
									case when '+@item+'=''-2'' then ''-1'' else Replace('+@item+',''-2'','''') end as '+@item+',Value     
					  from c  c2 
					 unpivot(Value for '+@item+' in('+stuff(@form4,1,1,'')+') )up
			 ) t
			 pivot(sum(value) for [xaxis] in('+stuff(@form6+Replace(@form6 ,']','-2]'),1,1,'')+')) p 
			  
			  )  
			 select '+@item+' '+ stuff(Replace(Replace(@form6,',[','+isnull(['),']','],0.0)'),1,1,',') +' as Total  '+@form6  +char(10)
							   + stuff(Replace(Replace(@form6,',[','+isnull(['),']','-2],0.0)'),1,1,',') +' as CNT'+Replace(@form6 ,']','-2]')+char(10)
							   +@t_form+'
			 into #tab2
			 from tab   '+'
			 
			 select cr.Label as '+@item+',r.Total '+(case when left(@STATS,1)=1 then '/ (case when RT.Total is null then 1.0 else  nullif(RT.Total,0.0) end) as ' else ' ' end)+' Total '+ @form8 +' 
			 from  #tab2  r  inner join (
										select N''-1'' as Value,N''Total'' as label,-1 as id
										union all
										 select cast(Value as nvarchar) Value,Label,value as id from  [dbo].[Cross Tab Spec$Victor]  where   Quest='+quotename(@rowname,'''')+'  and val is not null
									 ) cr 
									on r.'+@item+'=cr.[value]

              '+case when  left(@STATS,1)=1  then ' left join (select  * from #tab2 where '+@item+'=''-1'') as RT on R.'+@item+'!=RT.'+@item+'   ' else '' end +'
			 order by cr.id

			 '
		----select @sql  ;
	   exec sp_executesql @sql ;
			  

 set nocount off ;
end

 

GO
/****** Object:  StoredProcedure [dbo].[p_Get_Comments]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 author victor zhang
 date  20150424
 function 
*/
CREATE  proc  [dbo].[p_Get_Comments]
(@columnlist  nvarchar(max),
 @wherecondition nvarchar(max) ,
 @sqlwhere nvarchar(max)
)
as 

begin
set nocount on

		declare @sql nvarchar(max);
		set @sql='
		select top ' + @columnlist+',v_MRK_FDO,[Group],[Region],[District],v_STORE,id 
		 from view_FD_VerbatimsRawData  '+char(10)
				 + @wherecondition +'
		 ';

		exec sp_executesql @sql;
	
		set @sql=' select count(id) from view_FD_VerbatimsRawData where 1=1 '+char(10) + @sqlwhere
		exec sp_executesql @sql;
set nocount off
end

GO
/****** Object:  StoredProcedure [dbo].[p_Get_Comments_a]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 author victor zhang
 date  20150424
 function 
*/
CREATE  proc  [dbo].[p_Get_Comments_a]
(@columnlist  nvarchar(max),
 @wherecondition nvarchar(max) ,
 @sqlwhere nvarchar(max)
)
as 

begin
set nocount on

		declare @sql nvarchar(max);
		set @sql='
		select top ' + @columnlist + ' v_Q92_INS_v_Q93_INS,v_Q92_v_Q93,v_MRK_FDO,[Group],Region,District,v_STORE,id from [view_FD_VerbatimsRawData_Q92Q93]
		 '+char(10)
				 + @wherecondition +'
		 ';

		exec sp_executesql @sql;
	
		set @sql=' select count(vid) from [view_FD_VerbatimsRawData_Q92Q93] where 1=1 '+char(10) + @sqlwhere
		exec sp_executesql @sql;
set nocount off
end

GO
/****** Object:  StoredProcedure [dbo].[p_Get_Comments_test]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 author victor zhang
 date  20150424
 function 
 exec p_Get_Comments_test 3,10,20,null,null,null, null,null,null,null,null,null,null,null,null,'Q6','','v_STORE asc'

 exec p_Get_Comments_test 3,10,20,null,null,null, null,null,null,null,null,null,null,null,null,'Q92Q93','we','v_STORE asc'
*/
CREATE  proc  [dbo].[p_Get_Comments_test]
(
		@YEAR_NEW int ,
		@QUARTER_NEW int , 
		@group int  , 
		@region int  ,
		@district int  ,
		@store  int ,
		@Age   nvarchar(50)='',
		@Frequency_of_shopping  nvarchar(50)='',
		@Gender  nvarchar(50)='',
		@Income  nvarchar(50)='',
		@Racial_background  nvarchar(50)='',
		@Government_benefits  nvarchar(50)='',
		@Store_Format  nvarchar(50)='',
		@Store_Cluster  nvarchar(50)='',
		@Shopper_Segment  nvarchar(50)='',

		@question nvarchar(50),  ----Q6    Q92   Q93   Q72_GRID_01_Q72A_GRID_1_0_Q72A to Q72_GRID_13_Q72A_GRID_1_0_Q72A   Q110 
		@search_text nvarchar(max),
		@sort_list nvarchar(100)='v_STORE asc',
		@pagesize  int=50,
		@pageindex int=1
)
as 

begin
set nocount on;

 declare @sql nvarchar(max) ='',   
		   @raw  nvarchar(max)='', 
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
			@where_con  nvarchar(max), 
		   @where_sc nvarchar(max),
		   @out_columns nvarchar(4000)='',
		   @like_text nvarchar(max)='' ;
			
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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(ltrim(rtrim(@gb)))>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end+
						 case when  @YEAR_NEW>0 then ' AND YEAR_NEW='+cast(@YEAR_NEW as nvarchar)  else '' end+
						 case when  @QUARTER_NEW>0 then ' AND QUARTER_NEW='+cast(@QUARTER_NEW as nvarchar)  else '' end+
						 case when @group >0 then ' AND [v_Group]='+cast(@group as nvarchar) else '' end +
						 case when @region >0 then ' AND [v_Region]='+cast(@region as nvarchar) else '' end +
						 case when @district >0 then ' AND [v_District]='+cast(@district as nvarchar) else '' end +
						 case when @store >0 then ' AND [V_Store]='+cast(@store as nvarchar) else '' end ;
		
			 set @where_raw=@where_con+ 
					   case when  @question='Q92Q93' then '  ' 
							when  @question='Q6' then ' and  v_Q6 is not null and v_Q6<>''''  '
							when  @question='Q72_GRID' then ' and v_Q72_GRID is not null and v_Q72_GRID <>'''' '
							when  @question='Q110' then ' and v_Q110 is not null and v_Q110 <>'''' ' else ' ' end ;
						 
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;



      set @out_columns=case when  @question='Q92Q93' then ' v_Q92_INS_v_Q93_INS [Category],v_Q92_v_Q93 [COMMENT],v_MRK_FDO [FDO SEGMENT],[Group],[Region],[District],v_STORE  STORE,id ' 
							when  @question='Q6' then ' v_Q4_GRID_0_Q4 [OVERALL SATISFACTION],v_Q6  [COMMENT],v_MRK_FDO [FDO SEGMENT],[Group],[Region],[District],v_STORE  STORE,id '
							when  @question='Q72_GRID' then ' v_Q7201_Q7213 [Product Category],v_Q72_GRID  [COMMENT],v_MRK_FDO [FDO SEGMENT],[Group],[Region],[District],v_STORE  STORE,id '
							when  @question='Q110' then ' v_Q109  [Store Mainenance Issue?],v_Q110  [COMMENT],v_MRK_FDO [FDO SEGMENT],[Group],[Region],[District],v_STORE  STORE,id ' end ;

      set @like_text  =iif(len(@search_text)<=0,N'',
						case when  @question='Q92Q93' then 'and (  v_Q92_INS like '+quotename('%'+@search_text  + '%','''')+'  
															   or v_Q93_INS like '+quotename('%' +@search_text  + '%','''')+'  
															   or Q92 like '+quotename('%' +@search_text  + '%','''')+' 
															   or Q93 like '+quotename('%'+@search_text  + '%','''')
							when  @question='Q6' then ' and (  v_Q4_GRID_0_Q4 like '+quotename('%' +@search_text  + '%','''')+' 
															or v_Q6 like '+quotename('%' +@search_text  + '%','''')+''
							when  @question='Q72_GRID' then '  and (   v_Q7201_Q7213 like '+quotename('%' +@search_text  + '%','''')+' 
																	or v_Q72_GRID like '+quotename('%' +@search_text  + '%','''')+' '
							when  @question='Q110' then ' and (   v_Q109 like '+quotename('%' +@search_text  + '%','''')+'
															   or v_Q110 like '+quotename('%' +@search_text  + '%','''')+' ' else ' ' end 

							+' or v_MRK_FDO like '+quotename('%' +@search_text  + '%','''')+' or v_STORE like '+quotename('%' +@search_text  + '%','''')+' )'	);


       set @where_raw=@where_raw+' '+@like_text ;
 
---Raw Data with filter
	set @raw=concat(N' ;with rawdata as ( select Row_number() over(order by id) Num,  *  from  '+(case when @question='Q92Q93' then ' [view_FD_VerbatimsRawData_Q92Q93] ' else ' [view_FD_VerbatimsRawData] ' end)+' t   where   1=1  '+char(10),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+char(10)+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sc+')  ',
							@where_raw ,char(10)+'  )   ')+char(10)  ; 

		set @sql=@raw+'
		select '   + @out_columns
		+'
		 from rawdata 
		 '+(case when @pageindex >0 then  'where  num >='+cast((@pageindex-1)*@pagesize as nvarchar)+' and num<='+cast(@pageindex*@pagesize as nvarchar) else ' ' end)+' 
		 '+iif(len(@sort_list)>0,  ' order by '+@sort_list , ' ' ) ;

	exec sp_executesql @sql;
	---- select @sql;
		set @sql=@raw+' select count(id) from rawdata  ' ;
		exec sp_executesql @sql;

set nocount off;
end

GO
/****** Object:  StoredProcedure [dbo].[p_get_crosstab]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
  ---author victor
 ---createdate 2015-01-27
 [p_get_crosstab_test] 3,10,'AGE_GROUP','AGE_GROUP',11,'',-1,-1,-1,-1
  [p_get_crosstab_test] 3,10,'YEAR_NEW','Q10_GRID_01_Q10',11,'',-1,-1,-1,-1
    
    [p_get_crosstab_test] 3,-1,'Q106','Q109',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
  [p_get_crosstab_test] 3,-1,'Q106','Q109',22,0,' ',-1,-1,-1,-1,'','','','','','','','',''
  [p_get_crosstab_test] 3,-1,'Q106','Q109',12,0,' ',-1,-1,-1,-1,'','','','','','','','',''
  [p_get_crosstab_test] 3,-1,'Q9a','Q15',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

   [p_get_crosstab_test] 3,-1,'Q14','Q2',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
  exec  [p_get_crosstab_test] 3,-1,'Q2','Q14',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   [p_get_crosstab_test] 3,-1,'Q2','Q14',12,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   [p_get_crosstab_test] 3,-1,'Q2','Q14',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   [p_get_crosstab_test] 3,-1,'Q2','Q14',22,0,' ',-1,-1,-1,-1,'','','','','','','','',''

    [p_get_crosstab_test] 3,-1,'Q2','Q2',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

	exec  [p_get_crosstab_test] 3,-1,'Q2','Q63',21,0,' ',10,8,-1,-1,'','','','','','','','',''
	exec  [p_get_crosstab_test] 3,-1,'Q2','Q14',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
    exec [p_get_crosstab_test] 3,-1,'Q2','Q14',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''  

 Stats: Column %           11
		Row %              21 
		Col % w/counts     12 
		Row % w/counts     22
		select* from Stats_Index
select * from [dbo].[Cross Tab Spec$Victor] where label like '%what%'
*/
CREATE   procedure [dbo].[p_get_crosstab](
@YEAR_NEW int , 
@QUARTER_NEW int  ,
@columnname  nvarchar(100),
@rowname  nvarchar(100),
@STATS   tinyint=0,
@SIGNIFICANCE float =0.0,
@wherecondition nvarchar(max) ,
@group int  ,
@region int  ,
@district int  ,
@store  int  ,
@Age   nvarchar(50)='',
@Frequency_of_shopping  nvarchar(50)='',
@Gender  nvarchar(50)='',
@Income  nvarchar(50)='',
@Racial_background  nvarchar(50)='',
@Government_benefits  nvarchar(50)='',
@Store_Format  nvarchar(50)='',
@Store_Cluster  nvarchar(50)='',
@Shopper_Segment  nvarchar(50)='' 
)
as 
begin 

   set nocount on ; 
   declare @sql nvarchar(max) ='',
		   @form1   nvarchar(max)='',
		   @form2  nvarchar(max)='',
		   @form2_1  nvarchar(max)='', @form2_2  nvarchar(max)='',
		   @form4  nvarchar(max)='',
		   @form5  nvarchar(max)='',
		   @form6  nvarchar(max)='',
		   @form7  nvarchar(max)='',
		   @form8  nvarchar(max)='',
		   @form8_1  nvarchar(max)='',
		   @form3 nvarchar(4000)='',@form3_1 nvarchar(4000)='',@form3_2 nvarchar(4000)='',
		   @raw nvarchar(max)='',
		   @groupby nvarchar(max)='' ,
		   @hierarchy nvarchar(max)='',	
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),@where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int, 
		   @item   nvarchar(20)='',
		   @col nvarchar(max)='',
		   @formw nvarchar(max)='',
		   @variable nvarchar(500),
		   @type nvarchar(20)='SINGLE';
			
			set @columnname=ltrim(rtrim(@columnname));
			set @rowname=ltrim(rtrim(@rowname));
			if len(@columnname)<=0 return ;
			if len(@rowname)<=0 return;

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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;

	set @groupby= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						   case when  @district  is null then null else ',[Group],[Region],District' end ,
						   case when  @region is null then null else ',[Group],[Region]' end,
						   case when  @group  is null then null else ',[Group]' end, ''		 );

	set @hierarchy	=isnull(' and Store='+cast(@store as nvarchar) ,'')+
					 isnull( ' and District='+cast(@district as nvarchar),'')+
					 isnull( ' and [Region]='+cast(@region as nvarchar)  ,'')+
					 isnull( ' and [Group]='+cast(@group as nvarchar)  ,'');
---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 '+
						(case when @YEAR_NEW>0 then ' and YEAR_NEW='+cast(+@YEAR_NEW as nvarchar) else ' ' end)+
						(case when @QUARTER_NEW>0 then ' and QUARTER_NEW='+cast(@QUARTER_NEW as nvarchar) else ' ' end),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',@hierarchy,' ',
							@where_raw ,'  )   ')+char(10)  ; 



	
	---Total  = -1 	
	---CNT=-2
	---Base = 0
	 select top 1 @item=quotename(Item) from [Stats_Index] where Num=@STATS;	
	  

	select @form1=@form1+ concat(',sum(case when ', quotename(variable),'  in(',iif( [Type]='MULTI','1',Val),') then ','[Weight]',' else 0 end)  as ',quotename(Value)
								,',sum(case when ', quotename(variable),'  in(',iif( [Type]='MULTI','1',Val),') then ',' cast(1.0 as float) ',' else cast(0.0 as float) end)  as [',Value,'-2]'
								,',sum(case when ', quotename(variable),'  in(',iif( [Type]='MULTI','1',Val),') then ',' power([Weight],2) ',' else 0 end)  as ',quotename(cast(Value as nvarchar)+N'-SW')) +char(10)
			,@form2=@form2+concat(',',quotename(Value,'''''')) 
			,@form2_1=@form2_1+concat(',''',Value,'-2''') 
			,@form2_2=@form2_2+concat(',''',Value,'-SW''') 
			,@form3=@form3+ (case when [Type]='MULTI' then 'or '+quotename(variable)+' in(1) '  else ','+ Val end)
			,@formw=@formw+(case when [Type]='MULTI' then concat('+ (case when ',quotename(Variable),'=1 then 1 else 0 end)') else ' ' end)
			,@variable=variable
			,@type=[Type]
    from [dbo].[Cross Tab Spec$Victor](nolock)  where     Quest=@rowname  and val is not null;
	 

	set @form3_2=case when @type='MULTI' then 'sum( case when '+stuff( @form3,1,2,'')+' then power([Weight]/[w@],2)  end)' 
					else 'sum(case when '+ quotename(@variable)+'  in('+stuff( @form3,1,1,'')+') then power([Weight],2) end) '    end+' as [-SW]';

----	 set @form3_2=Replace(@form3_2,'/[w@]','/('+stuff(@formw,1,1,'')+')');
	  set @form3_2=Replace(@form3_2,'/[w@]','');

	set @form3_1=case when @type='MULTI' then 'sum( case when '+stuff( @form3,1,2,'')+' then cast(1.0 as float)/[w@] else cast(null as float) end)' 
					else 'sum(case when '+ quotename(@variable)+'  in('+stuff( @form3,1,1,'')+') then cast(1.0 as float) else cast(null as float) end) '    end+' as [-2]';	 
			
	---set @form3_1=Replace(@form3_1,'/[w@]','/('+stuff(@formw,1,1,'')+')');
	set @form3_1=Replace(@form3_1,'/[w@]','');

					  
	set @form3=case when @type='MULTI' then 'sum( case when '+stuff( @form3,1,2,'')+' then [Weight]/[w@]  end)' 
					else 'sum(case when '+ quotename(@variable)+'  in('+stuff( @form3,1,1,'')+') then [Weight] end) '    end+' as [-1]';

	--- set @form3=Replace(@form3,'/[w@]','/('+stuff(@formw,1,1,'')+')');
   set @form3=Replace(@form3,'/[w@]','');

	set @form4=Replace(Replace(@form2,',''',',['),'''',']')+',[-1]'+Replace(Replace(@form2_1,',''',',['),'''',']')+',[-2]'+Replace(Replace(@form2_2,',''',',['),'''',']')+',[-SW]'

    select  @col=@col+ case when [Type]='MULTI' then concat(' when ',quotename(Variable),' in(1) then ',quotename(Value,''''),'  ') 
							else  concat(' when ',quotename(Variable),' in(',Val,') then ',quotename(Value,''''),' ') end+char(10) 	
	       ,@form6=@form6+','+quotename(Value)
		   ,@form7=@form7+ ','+quotename(Value)+','+''','+cast(Value as nvarchar)+';'''
		   ,@form8=@form8+iif(@STATS<=0 ,concat(',',quotename(Value),'  ',quotename(Label),',',quotename(cast(Value as nvarchar)+'-2'),' ',quotename(Label+' Count'),',',quotename(cast(Value as nvarchar)+'-SW'),' ',quotename(Label+' SW')),
							 concat(',concat('+case when  left(@STATS,1)=1 then concat('Rt.',quotename(Value),','','', Rt.',quotename(cast(Value as nvarchar)+N'-2'),','','',')
													else 'r.[-1],'','',r.[-1-2],'','',' end
										+' R.',quotename(Value),','','', R.',quotename(cast(Value as nvarchar)+N'-2'),','','',','R.',quotename(Value),
									case when left(@STATS,1)=2  then '/nullif(R.[-1],0.0) ' 
										 when  left(@STATS,1)=1 then '/ case when RT.'+quotename(Value)+' is null  then 1.0 else  nullif(RT.'+quotename(Value) +',0.0) end ' else '' end,
										case when left(@STATS,1)=1 then  concat(','','',Rt.',quotename(cast(Value as nvarchar)+N'-SW')+' ) as ') 
										when left(@STATS,1)=2 then  ','','',R.[-1-SW] ) as ' else '' end ,quotename(Label)) 
										  )
		   ,@form8_1=@form8_1+concat(',',quotename(Value),' as ',quotename(Label))
	  from [dbo].[Cross Tab Spec$Victor](nolock) where   Quest= @columnname  and val is not null;   	
	   
	 
	set @columnname=quotename(@columnname);
	  
	set @sql=@raw+ N' 
			, c as (
			 select  (case when Grouping(case '+@col+' else ''-9999'' end)=1 then 1 else 0 end) as AL, 
			 case '+@col+' else ''-9999'' end as [xaxis]
					'+@form1+','+@form3+','+@form3_1+','+@form3_2+'
			 from  rawdata 
			 group by   rollup(case '+@col+' else ''-9999'' end)
			 ) 
			,tab as ( 
			select  *  from (
					 select concat(xaxis,case when charindex(''-2'','+@item+')>0 then ''-2'' when charindex(''-SW'','+@item+')>0 then ''-SW'' else null end) as xaxis,
									case when '+@item+'=''-2'' then ''-1'' when '+@item+'=''-SW'' then ''-1'' else Replace(Replace('+@item+',''-2'',''''),''-SW'','''') end as '+@item+',Value     
					  from (select case when AL=1 then N'+quotename('-1','''')+' else xaxis end as xaxis,'+stuff(@form4,1,1,'')+' from c ) c2 
					 unpivot(Value for '+@item+' in('+stuff(@form4,1,1,'')+') )up
			 ) t
			 pivot(sum(value) for [xaxis] in([-1],'+stuff(@form6+Replace(@form6 ,']','-2]')+Replace(@form6 ,']','-SW]'),1,1,'')+',[-1-2],[-1-SW])) p 
			  
			  )  
			 select '+@item+', [-1],'+stuff(@form6+Replace(@form6 ,']','-2]')+Replace(@form6 ,']','-SW]'),1,1,'')+',[-1-2],[-1-SW]'+char(10)
							/*  + @t_form+*/ +'
			 into #tab2
			 from tab   

			 select cr.Label as '+@item+','+iif(@STATS<=0,'r.[-1] Total,r.[-1-2] [Total Count],r.[-1-SW] [Total SW]',
												'concat('+(case when left(@STATS,1)=1 then 'rt.[-1],'','',rt.[-1-2],'','',' else ' r.[-1],'','',r.[-1-2],'','', ' end) +'r.[-1],'','',r.[-1-2],'','', r.[-1]'
												+(case when left(@STATS,1)=1 then '/ (case when RT.[-1] is null then 1.0 else  nullif(RT.[-1],0.0) end)  ' else ' ' end)
												+ case when left(@STATS,1)=1 then ','','',rt.[-1-SW]  ) Total' when left(@STATS,1)=2 then ','','',r.[-1-SW]  ) Total' end )+'  '+char(10)
												+ @form8 +' 
			 from  #tab2  r  inner join (
										select N''-1'' as Value,N''Total'' as label,-1 as id
										union all
										 select cast(Value as nvarchar) Value,Label,value as id from  [dbo].[Cross Tab Spec$Victor](nolock)  where   Quest='+quotename(@rowname,'''')+'  and val is not null
									 ) cr 
									on r.'+@item+'=cr.[value]

              '+case when  left(@STATS,1)=1  then ' inner join (select  * from #tab2 where '+@item+'=''-1'') as RT on 1=1   ' else '' end +'
			 order by cr.id

			 '

	   exec sp_executesql @sql ;

	   --print left(@sql,4000)
	   --print substring(@sql,4001,4000)
	   --print substring(@sql,8001,4000)
	   --print substring(@sql,12001,4000)
			  
----select @sql  ;
 set nocount off ;
end

 

GO
/****** Object:  StoredProcedure [dbo].[p_get_crosstab_test]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
  ---author victor
 ---createdate 2015-01-27
  [p_get_crosstab_test] 3,10,'Q2','Q64',11,'',-1,-1,-1,-1,'','','','','','','','',''
    
  [p_get_crosstab_test3] 3,-1,'Q106','Q109',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
  [p_get_crosstab_test3] 3,-1,'Q106','Q109',22,0,' ',-1,-1,-1,-1,'','','','','','','','',''
  [p_get_crosstab_test3] 3,-1,'Q106','Q109',12,0,' ',-1,-1,-1,-1,'','','','','','','','',''
  [p_get_crosstab_test3] 3,-1,'Q9a','Q15',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

   [p_get_crosstab_test3] 3,-1,'Q14','Q2',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   [p_get_crosstab_test3] 3,-1,'Q2','Q14',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   [p_get_crosstab_test3] 3,-1,'Q2','Q14',12,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   [p_get_crosstab_test3] 3,-1,'Q2','Q14',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   [p_get_crosstab_test3] 3,-1,'Q2','Q14',22,0,' ',-1,-1,-1,-1,'','','','','','','','',''

    [p_get_crosstab_test3] 3,-1,'Q72_1','Q2',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
		
		exec [p_get_crosstab_test3] 3,-1,'Q2','Q63',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
	    exec [p_get_crosstab_test3] 3,-1,'Q2','Q63',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
	    exec [p_get_crosstab] 3,-1,'Q2','Q63',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

		exec [p_get_crosstab_test3] 3,-1,'Q2','Q14',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
	    exec [p_get_crosstab] 3,-1,'Q14','Q2',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

    [p_get_crosstab] 3,-1,'Q2','Q13',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
    [p_get_crosstab] 3,-1,'Q2','Q13',12,0,' ',-1,-1,-1,-1,'','','','','','','','',''
	[p_get_crosstab] 3,-1,'Q2','Q13',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
    [p_get_crosstab] 3,-1,'Q2','Q13',22,0,' ',-1,-1,-1,-1,'','','','','','','','',''


   exec [p_get_crosstab] 3,-1,'Q2','Q63',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   print getdate()
   exec   [p_get_crosstab_test3] 3,-1,'Q2','Q63',12,0,' ',-1,-1,-1,-1,'','','','','','','','',''
	exec [p_get_crosstab_test] 3,-1,'Q2','Q63',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
  exec  [p_get_crosstab_test4] 3,-1,'Q2','Q63',12,0,' ',-1,-1,-1,-1,'','','','','','','','',''

	[p_get_crosstab_test4] 3,-1,'Q2','Q63',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

	 exec [p_get_crosstab_test4] 3,-1,'Q2','Q14',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

	 print getdate()
	exec [p_get_crosstab_test] 3,-1,'Q2','Q14',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

 exec [p_get_crosstab_test4] 3,-1,'Q14','Q2',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
print getdate()
	exec [p_get_crosstab_test] 3,-1,'Q14','Q2',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

	exec [p_get_crosstab_test4] 3,-1,'Q2','Q4',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
	exec [p_get_crosstab_test4] 3,-1,'Q2','Q4',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
      
 Stats: Column %           11
		Row %              21 
		Col % w/counts     12 
		Row % w/counts     22
		select* from Stats_Index
select * from [dbo].[Cross Tab Spec$Victor] where label like '%what%'
*/
CREATE   procedure [dbo].[p_get_crosstab_test](
@YEAR_NEW int , 
@QUARTER_NEW int  ,
@columnname  nvarchar(100),
@rowname  nvarchar(100),
@STATS   tinyint=0,
@SIGNIFICANCE float =0.0,
@wherecondition nvarchar(max) ,
@group int  ,
@region int  ,
@district int  ,
@store  int  ,
@Age   nvarchar(50)='',
@Frequency_of_shopping  nvarchar(50)='',
@Gender  nvarchar(50)='',
@Income  nvarchar(50)='',
@Racial_background  nvarchar(50)='',
@Government_benefits  nvarchar(50)='',
@Store_Format  nvarchar(50)='',
@Store_Cluster  nvarchar(50)='',
@Shopper_Segment  nvarchar(50)='' 
)
as 
begin 

   set nocount on ; 
   declare @sql nvarchar(max) ='',
		   @raw nvarchar(max)='',
		   @hierarchy nvarchar(max)='',	
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),@where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int, 
		   @item   nvarchar(20)='';
  
			set @columnname=ltrim(rtrim(@columnname));
			set @rowname=ltrim(rtrim(@rowname));
			if len(@columnname)<=0 return ;
			if len(@rowname)<=0 return;

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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;


	set @hierarchy	=isnull(' and Store='+cast(@store as nvarchar) ,' ')+
					 isnull( ' and District='+cast(@district as nvarchar),' ')+
					 isnull( ' and [Region]='+cast(@region as nvarchar)  ,' ')+
					 isnull( ' and [Group]='+cast(@group as nvarchar)  ,' ')
	
	select top 1 @item=quotename(Item) from [Stats_Index] where Num=@STATS;	
	  
	  --	 select  quotename(Item),* from [Stats_Index]
declare @colvariable varchar(100)='',@colform varchar(max)='',@colform1 varchar(max)='',@colform2 varchar(max)='',
		@values varchar(4000)='',@coltype varchar(100)='SINGLE';

	select top 1 @coltype=[Type] from Variable_Layered(nolock) where Quest=@columnname ;

	if @coltype='MULTI'
	begin
		  select @colform=@colform
					+',sum(case when '+quotename(variable)+' =1 then [weight] else 0.0 end) as ['+cast(value as varchar(10))+'!B]'
					+',sum(case when '+quotename(variable)+' =1 then 1.0 else 0.0 end) as ['+cast(value as varchar(10))+'!C]'
					+',sum(case when '+quotename(variable)+' =1 then [weight]*[weight] else 0.0 end) as ['+cast(value as varchar(10))+'!S]',
				@colform1=@colform1
				+',sum(['+cast(value as varchar(10))+'!B]) as ['+cast(value as varchar(10))+'!B]'
				+',sum(['+cast(value as varchar(10))+'!C]) as ['+cast(value as varchar(10))+'!C]'
				+',sum(['+cast(value as varchar(10))+'!S]) as ['+cast(value as varchar(10))+'!S]',
				@colvariable= quotename(Quest),
				@values=@values+' or '+quotename(Variable)+' =1 ' ,
				@colform2=@colform2+','
						+case when left(@STATS,1)=1 then  
									 'cast(b.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(b.['+cast(value as varchar(10))+'!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B]/nullif(b.['+cast(value as varchar(10))+'!B],0.0) as varchar(30))+'+quotename(',','''')
								   +'+cast(b.['+cast(value as varchar(10))+'!S] as varchar(30))   as ['+cast(value_label as varchar(100))+']'
							  when left(@STATS,1)=2 then 
									'cast(a.[Total!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.[Total!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B]/nullif(a.[Total!B],0.0) as varchar(30))+'+quotename(',','''')
								   +'+cast(a.[Total!S] as varchar(30))   as ['+cast(value_label as varchar(100))+']'
							  else 'cast(a.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!S] as varchar(30))   as ['+cast(value_label as varchar(100))+']'
						end
		   from Variable_Layered(nolock) where Quest=@columnname and value>=1 and valid=1 and used=1;
	end
	else
	begin
		  select @colform=@colform
					+',sum(case when '+quotename(variable)+' in('+cast(value as varchar(10))+') then [weight] else 0.0 end) as ['+cast(value as varchar(10))+'!B]'
					+',sum(case when '+quotename(variable)+' in('+cast(value as varchar(10))+') then 1.0 else 0.0 end) as ['+cast(value as varchar(10))+'!C]'
					+',sum(case when '+quotename(variable)+' in('+cast(value as varchar(10))+') then [weight]*[weight] else 0.0 end) as ['+cast(value as varchar(10))+'!S]',
				@colform1=@colform1
				+',sum(['+cast(value as varchar(10))+'!B]) as ['+cast(value as varchar(10))+'!B]'
				+',sum(['+cast(value as varchar(10))+'!C]) as ['+cast(value as varchar(10))+'!C]'
				+',sum(['+cast(value as varchar(10))+'!S]) as ['+cast(value as varchar(10))+'!S]',
				@colvariable= quotename(variable),
				@values=@values+','+cast(value as varchar(10)) ,
				@colform2=@colform2+','
						+case when left(@STATS,1)=1 then  
									 'cast(b.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(b.['+cast(value as varchar(10))+'!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B]/nullif(b.['+cast(value as varchar(10))+'!B],0.0) as varchar(30))+'+quotename(',','''')
								   +'+cast(b.['+cast(value as varchar(10))+'!S] as varchar(30))   as ['+cast(value_label as varchar(100))+']'
							  when left(@STATS,1)=2 then 
									'cast(a.[Total!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.[Total!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B]/nullif(a.[Total!B],0.0) as varchar(30))+'+quotename(',','''')
								   +'+cast(a.[Total!S] as varchar(30))   as ['+cast(value_label as varchar(100))+']'
							  else 'cast(a.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!S] as varchar(30))   as ['+cast(value_label as varchar(100))+']'
						end
		   from Variable_Layered(nolock) where Quest=@columnname  and valid=1 and used=1;
	   end
	     

declare @rowvariable varchar(100) ='' ,@rowform varchar(max)='',@rowvalues varchar(8000)='',@rowtype varchar(100)='SINGLE'
		,@rowform_1 varchar(max)='',@rowform_2 varchar(max)='' ;

select top 1 @rowtype=[Type]  from Variable_Layered(nolock) where Quest=@rowname ;

	if @rowtype='MULTI'
	begin
	  select @rowform=@rowform+' when Grouping('+quotename(variable)+')=0 then '+quotename(cast(value as varchar(10)),'''') +'  ',
			@rowvariable=quotename(Quest) ,
			@rowform_1=@rowform_1+', '+quotename(variable)+' ',
			@rowform_2=@rowform_2+'or '+quotename(variable)+'=1  '
	  from Variable_Layered(nolock) where Quest=@rowname and valid=1 and value>=1 and used=1;
	end
	else
	begin
	  select @rowform=@rowform+' when '+quotename(variable)+' in('+cast(value as varchar(10))+') then '+quotename(cast(value as varchar(10)),'''') +' ',
			@rowvariable=quotename(variable),
			@rowvalues=@rowvalues+',' +quotename(cast(value as varchar(10)),'''')
	  from Variable_Layered(nolock) where Quest=@rowname and valid=1 and used=1;
   end

---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 '+
						(case when @YEAR_NEW>0 then ' and YEAR_NEW='+cast(+@YEAR_NEW as nvarchar) else ' ' end)+
						(case when @QUARTER_NEW>0 then ' and QUARTER_NEW='+cast(@QUARTER_NEW as nvarchar) else ' ' end),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',@hierarchy,
							@where_raw ,'  )   ')+char(10)  ; 

	set @sql=@raw+'
	,t1 as (
	select 	case '+@rowform+' else '+quotename('-9999','''')+' end as '+@rowvariable+','
	+case when @coltype='MULTI' then '
			sum(case when '+stuff(@values,1,3,'')+'   then [weight] end) as [Total!B],
			sum(case when '+stuff(@values,1,3,'')+'   then  1.0 end) as [Total!C],
			sum(case when '+stuff(@values,1,3,'')+'   then [weight]*[weight] end) as [Total!S]
			' 
		  else '
			sum(case when '+@colvariable+' in ('+stuff(@values,1,1,'')+') then [weight] end) as [Total!B],
			sum(case when '+@colvariable+' in ('+stuff(@values,1,1,'')+') then  1.0 end) as [Total!C],
			sum(case when '+@colvariable+' in ('+stuff(@values,1,1,'')+') then [weight]*[weight] end) as [Total!S]
			' end 
			+@colform+' 
	from rawdata  '+case when @rowtype='MULTI' then ' where '+stuff(@rowform_2,1,2,'') else 'where '+@rowvariable+' in ('+stuff(@rowvalues,1,1,'')+')' end+'
	group by '+case when @rowtype='MULTI' then ' Grouping sets('+stuff(@rowform_1,1,1,'')+') '+char(10)+' having( '+stuff(@rowform_2,1,2,'')+' )'
					 else ' (case '+@rowform+' else '+quotename('-9999','''')+' end) ' end+'
	)

	,t1_1 as (
	select  ''-1111'' as '+@rowvariable+','
	+case when @coltype='MULTI' then '
			sum(case when '+stuff(@values,1,3,'')+'   then [weight] end) as [Total!B],
			sum(case when '+stuff(@values,1,3,'')+'   then  1.0 end) as [Total!C],
			sum(case when '+stuff(@values,1,3,'')+'   then [weight]*[weight] end) as [Total!S]
			' 
		  else '
			sum(case when '+@colvariable+' in ('+stuff(@values,1,1,'')+') then [weight] end) as [Total!B],
			sum(case when '+@colvariable+' in ('+stuff(@values,1,1,'')+') then  1.0 end) as [Total!C],
			sum(case when '+@colvariable+' in ('+stuff(@values,1,1,'')+') then [weight]*[weight] end) as [Total!S]
			' end 
			+@colform+' 
	from rawdata  '+case when @rowtype='MULTI' then ' where '+stuff(@rowform_2,1,2,'') else 'where '+@rowvariable+' in ('+stuff(@rowvalues,1,1,'')+')' end+'
	)
	select * into #tt from t1
	union all 
	select * from t1_1 ;

	;with t1 as (select * from #tt)
    ,t2 as (  ---valid detail data in values
	select 1000+v.value as idx , v.Value_label  '+@rowvariable+',  sum([Total!B]) [Total!B],sum([Total!C]) [Total!C],sum([Total!S]) [Total!S] '
	+@colform1+'
	from t1 inner join  (select Value,Value_label from Variable_Layered where Quest='+quotename(@rowname,'''')+'  and valid=1 and used=1 '+case when @rowtype='MULTI' then ' and value>0 and used=1 ' else '' end+' ) v
	on t1.'+@rowvariable+'=v.value
	where t1.'+@rowvariable+'  > '+quotename('-1111','''')+'
	group by v.Value_label ,V.value
	)
	,t3 as ( ---valid grouped data in values
	select 2000+v.G1 as idx, v.G1_label  '+@rowvariable+',  sum([Total!B]) [Total!B],sum([Total!C]) [Total!C],sum([Total!S]) [Total!S] '
	+@colform1+'
	from t1 inner join  (select Value,G1,G1_label from Variable_Layered where Quest='+quotename(@rowname,'''')+' and valid=1 and used=1 '+case when @rowtype='MULTI' then ' and value>0 and used=1 ' else '' end+') v
	on t1.'+@rowvariable+'=v.value
	where t1.'+@rowvariable+' > '+quotename('-1111','''')+'
	group by v.G1_label ,v.G1
	)
	,t4 as (  ---valid total data in values
	select -1 as idx, ''Total''  '+@rowvariable+',  sum([Total!B]) [Total!B],sum([Total!C]) [Total!C],sum([Total!S]) [Total!S] '
	+@colform1+'
	from t1 
	where t1.'+@rowvariable+' = '+quotename('-1111','''')+'
	)
	,t5 as (
    select * from t4
	union all
	select * from t2
	union all 
	select * from t3	 
	)
	 select min(idx) over(partition by '+@rowvariable+' order by idx ) as minidx,* 
	 into #t6 
	 from t5 ;

	select  a.'+@rowvariable+' as '+@item+','
	+case when left(@STATS,1)=1 then ' cast(b.[Total!B] as varchar(30))+'+quotename(',','''')+'+cast(b.[Total!C] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!B] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!C] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!B]/nullif(b.[Total!B],0.0) as varchar(30))+'+quotename(',','''')+'+cast(b.[Total!S] as varchar(30)) as  Total'  
		  when left(@STATS,1)=2 then ' cast(a.[Total!B] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!C] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!B] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!C] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!B]/nullif(a.[Total!B],0.0) as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!S] as varchar(30)) as  Total ' 
		  else  ' cast(a.[Total!B] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!C] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!B] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!S] as varchar(30)) as  Total' end
	 +char(10) +@colform2+'
	from #t6 a '
	+case when left(@STATS,1)=1 then ',(select * from #t6 where idx=-1) b' when left(@STATS,1)=2 then ' ' else ' ' end+'
	where a.minidx=a.idx
	order by a.minidx
 
	' ;


	   exec sp_executesql @sql ;
	---select @sql  ;	  

 set nocount off ;
end



GO
/****** Object:  StoredProcedure [dbo].[p_get_crosstab_test_20150624BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
  ---author victor
 ---createdate 2015-01-27
 [p_get_crosstab_test] 3,10,'AGE_GROUP','AGE_GROUP',11,'',-1,-1,-1,-1
  [p_get_crosstab_test] 3,10,'YEAR_NEW','Q10_GRID_01_Q10',11,'',-1,-1,-1,-1
    
    [p_get_crosstab_test] 3,-1,'Q106','Q109',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
  [p_get_crosstab_test] 3,-1,'Q106','Q109',22,0,' ',-1,-1,-1,-1,'','','','','','','','',''
  [p_get_crosstab_test] 3,-1,'Q106','Q109',12,0,' ',-1,-1,-1,-1,'','','','','','','','',''
  [p_get_crosstab_test] 3,-1,'Q9a','Q15',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

   [p_get_crosstab_test] 3,-1,'Q14','Q2',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
  exec  [p_get_crosstab_test] 3,-1,'Q2','Q14',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   [p_get_crosstab_test] 3,-1,'Q2','Q14',12,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   [p_get_crosstab_test] 3,-1,'Q2','Q14',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   [p_get_crosstab_test] 3,-1,'Q2','Q14',22,0,' ',-1,-1,-1,-1,'','','','','','','','',''

    [p_get_crosstab_test] 3,-1,'Q2','Q2',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

	exec  [p_get_crosstab_test] 3,-1,'Q2','Q63',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
	exec  [p_get_crosstab_test] 3,-1,'Q2','Q14',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
    exec [p_get_crosstab_test] 3,-1,'Q2','Q14',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''  

 Stats: Column %           11
		Row %              21 
		Col % w/counts     12 
		Row % w/counts     22
		select* from Stats_Index
select * from [dbo].[Cross Tab Spec$Victor] where label like '%what%'
*/
CREATE   procedure [dbo].[p_get_crosstab_test_20150624BAK](
@YEAR_NEW int , 
@QUARTER_NEW int  ,
@columnname  nvarchar(100),
@rowname  nvarchar(100),
@STATS   tinyint=0,
@SIGNIFICANCE float =0.0,
@wherecondition nvarchar(max) ,
@group int  ,
@region int  ,
@district int  ,
@store  int  ,
@Age   nvarchar(50)='',
@Frequency_of_shopping  nvarchar(50)='',
@Gender  nvarchar(50)='',
@Income  nvarchar(50)='',
@Racial_background  nvarchar(50)='',
@Government_benefits  nvarchar(50)='',
@Store_Format  nvarchar(50)='',
@Store_Cluster  nvarchar(50)='',
@Shopper_Segment  nvarchar(50)='' 
)
as 
begin 

   set nocount on ; 
   declare @sql nvarchar(max) ='',
		   @form1   nvarchar(max)='',
		   @form2  nvarchar(max)='',
		   @form2_1  nvarchar(max)='', @form2_2  nvarchar(max)='',
		   @form4  nvarchar(max)='',
		   @form5  nvarchar(max)='',
		   @form6  nvarchar(max)='',
		   @form7  nvarchar(max)='',
		   @form8  nvarchar(max)='',
		   @form8_1  nvarchar(max)='',
		   @form3 nvarchar(4000)='',@form3_1 nvarchar(4000)='',@form3_2 nvarchar(4000)='',
		   @raw nvarchar(max)='',
		   @groupby nvarchar(max)='' ,
		   @hierarchy nvarchar(max)='',	
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),@where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int, 
		   @item   nvarchar(20)='',
		   @col nvarchar(max)='',
		   @formw nvarchar(max)='',
		   @variable nvarchar(500),
		   @type nvarchar(20)='SINGLE';
			
			set @columnname=ltrim(rtrim(@columnname));
			set @rowname=ltrim(rtrim(@rowname));
			if len(@columnname)<=0 return ;
			if len(@rowname)<=0 return;

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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;

	set @groupby= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						   case when  @district  is null then null else ',[Group],[Region],District' end ,
						   case when  @region is null then null else ',[Group],[Region]' end,
						   case when  @group  is null then null else ',[Group]' end, ''		 );

	set @hierarchy	=isnull(' and Store='+cast(@store as nvarchar) ,'')+
					 isnull( ' and District='+cast(@district as nvarchar),'')+
					 isnull( ' and [Region]='+cast(@region as nvarchar)  ,'')+
					 isnull( ' and [Group]='+cast(@group as nvarchar)  ,'');
---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 '+
						(case when @YEAR_NEW>0 then ' and YEAR_NEW='+cast(+@YEAR_NEW as nvarchar) else ' ' end)+
						(case when @QUARTER_NEW>0 then ' and QUARTER_NEW='+cast(@QUARTER_NEW as nvarchar) else ' ' end),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',@hierarchy,' ',
							@where_raw ,'  )   ')+char(10)  ; 



	
	---Total  = -1 	
	---CNT=-2
	---Base = 0
	 select top 1 @item=quotename(Item) from [Stats_Index] where Num=@STATS;	
	  

	select @form1=@form1+ concat(',sum(case when ', quotename(variable),'  in(',iif( [Type]='MULTI','1',Val),') then ','[Weight]',' else 0 end)  as ',quotename(Value)
								,',sum(case when ', quotename(variable),'  in(',iif( [Type]='MULTI','1',Val),') then ',' cast(1.0 as float) ',' else cast(0.0 as float) end)  as [',Value,'-2]'
								,',sum(case when ', quotename(variable),'  in(',iif( [Type]='MULTI','1',Val),') then ',' power([Weight],2) ',' else 0 end)  as ',quotename(cast(Value as nvarchar)+N'-SW')) +char(10)
			,@form2=@form2+concat(',',quotename(Value,'''''')) 
			,@form2_1=@form2_1+concat(',''',Value,'-2''') 
			,@form2_2=@form2_2+concat(',''',Value,'-SW''') 
			,@form3=@form3+ (case when [Type]='MULTI' then 'or '+quotename(variable)+' in(1) '  else ','+ Val end)
			,@formw=@formw+(case when [Type]='MULTI' then concat('+ (case when ',quotename(Variable),'=1 then 1 else 0 end)') else ' ' end)
			,@variable=variable
			,@type=[Type]
    from [dbo].[Cross Tab Spec$Victor](nolock)  where     Quest=@rowname  and val is not null;
	 

	set @form3_2=case when @type='MULTI' then 'sum( case when '+stuff( @form3,1,2,'')+' then power([Weight]/[w@],2)  end)' 
					else 'sum(case when '+ quotename(@variable)+'  in('+stuff( @form3,1,1,'')+') then power([Weight],2) end) '    end+' as [-SW]';

----	 set @form3_2=Replace(@form3_2,'/[w@]','/('+stuff(@formw,1,1,'')+')');
	  set @form3_2=Replace(@form3_2,'/[w@]','');

	set @form3_1=case when @type='MULTI' then 'sum( case when '+stuff( @form3,1,2,'')+' then cast(1.0 as float)/[w@] else cast(null as float) end)' 
					else 'sum(case when '+ quotename(@variable)+'  in('+stuff( @form3,1,1,'')+') then cast(1.0 as float) else cast(null as float) end) '    end+' as [-2]';	 
			
	---set @form3_1=Replace(@form3_1,'/[w@]','/('+stuff(@formw,1,1,'')+')');
	set @form3_1=Replace(@form3_1,'/[w@]','');

					  
	set @form3=case when @type='MULTI' then 'sum( case when '+stuff( @form3,1,2,'')+' then [Weight]/[w@]  end)' 
					else 'sum(case when '+ quotename(@variable)+'  in('+stuff( @form3,1,1,'')+') then [Weight] end) '    end+' as [-1]';

	--- set @form3=Replace(@form3,'/[w@]','/('+stuff(@formw,1,1,'')+')');
   set @form3=Replace(@form3,'/[w@]','');

	set @form4=Replace(Replace(@form2,',''',',['),'''',']')+',[-1]'+Replace(Replace(@form2_1,',''',',['),'''',']')+',[-2]'+Replace(Replace(@form2_2,',''',',['),'''',']')+',[-SW]'

    select  @col=@col+ case when [Type]='MULTI' then concat(' when ',quotename(Variable),' in(1) then ',quotename(Value,''''),'  ') 
							else  concat(' when ',quotename(Variable),' in(',Val,') then ',quotename(Value,''''),' ') end+char(10) 	
	       ,@form6=@form6+','+quotename(Value)
		   ,@form7=@form7+ ','+quotename(Value)+','+''','+cast(Value as nvarchar)+';'''
		   ,@form8=@form8+iif(@STATS<=0 ,concat(',',quotename(Value),'  ',quotename(Label),',',quotename(cast(Value as nvarchar)+'-2'),' ',quotename(Label+' Count'),',',quotename(cast(Value as nvarchar)+'-SW'),' ',quotename(Label+' SW')),
							 concat(',concat('+case when  left(@STATS,1)=1 then concat('Rt.',quotename(Value),','','', Rt.',quotename(cast(Value as nvarchar)+N'-2'),','','',')
													else 'r.[-1],'','',r.[-1-2],'','',' end
										+' R.',quotename(Value),','','', R.',quotename(cast(Value as nvarchar)+N'-2'),','','',','R.',quotename(Value),
									case when left(@STATS,1)=2  then '/nullif(R.[-1],0.0) ' 
										 when  left(@STATS,1)=1 then '/ case when RT.'+quotename(Value)+' is null  then 1.0 else  nullif(RT.'+quotename(Value) +',0.0) end ' else '' end,
										case when left(@STATS,1)=1 then  concat(','','',Rt.',quotename(cast(Value as nvarchar)+N'-SW')+' ) as ') 
										when left(@STATS,1)=2 then  ','','',R.[-1-SW] ) as ' else '' end ,quotename(Label)) 
										  )
		   ,@form8_1=@form8_1+concat(',',quotename(Value),' as ',quotename(Label))
	  from [dbo].[Cross Tab Spec$Victor](nolock) where   Quest= @columnname  and val is not null;   	
	   
	 
	set @columnname=quotename(@columnname);
	  
	set @sql=@raw+ N' 
			, c as (
			 select  (case when Grouping(case '+@col+' else ''-9999'' end)=1 then 1 else 0 end) as AL, 
			 case '+@col+' else ''-9999'' end as [xaxis]
					'+@form1+','+@form3+','+@form3_1+','+@form3_2+'
			 from  rawdata 
			 group by   rollup(case '+@col+' else ''-9999'' end)
			 ) 
			,tab as ( 
			select  *  from (
					 select concat(xaxis,case when charindex(''-2'','+@item+')>0 then ''-2'' when charindex(''-SW'','+@item+')>0 then ''-SW'' else null end) as xaxis,
									case when '+@item+'=''-2'' then ''-1'' when '+@item+'=''-SW'' then ''-1'' else Replace(Replace('+@item+',''-2'',''''),''-SW'','''') end as '+@item+',Value     
					  from (select case when AL=1 then N'+quotename('-1','''')+' else xaxis end as xaxis,'+stuff(@form4,1,1,'')+' from c ) c2 
					 unpivot(Value for '+@item+' in('+stuff(@form4,1,1,'')+') )up
			 ) t
			 pivot(sum(value) for [xaxis] in([-1],'+stuff(@form6+Replace(@form6 ,']','-2]')+Replace(@form6 ,']','-SW]'),1,1,'')+',[-1-2],[-1-SW])) p 
			  
			  )  
			 select '+@item+', [-1],'+stuff(@form6+Replace(@form6 ,']','-2]')+Replace(@form6 ,']','-SW]'),1,1,'')+',[-1-2],[-1-SW]'+char(10)
							/*  + @t_form+*/ +'
			 into #tab2
			 from tab   

			 select cr.Label as '+@item+','+iif(@STATS<=0,'r.[-1] Total,r.[-1-2] [Total Count],r.[-1-SW] [Total SW]',
												'concat('+(case when left(@STATS,1)=1 then 'rt.[-1],'','',rt.[-1-2],'','',' else ' r.[-1],'','',r.[-1-2],'','', ' end) +'r.[-1],'','',r.[-1-2],'','', r.[-1]'
												+(case when left(@STATS,1)=1 then '/ (case when RT.[-1] is null then 1.0 else  nullif(RT.[-1],0.0) end)  ' else ' ' end)
												+ case when left(@STATS,1)=1 then ','','',rt.[-1-SW]  ) Total' when left(@STATS,1)=2 then ','','',r.[-1-SW]  ) Total' end )+'  '+char(10)
												+ @form8 +' 
			 from  #tab2  r  inner join (
										select N''-1'' as Value,N''Total'' as label,-1 as id
										union all
										 select cast(Value as nvarchar) Value,Label,value as id from  [dbo].[Cross Tab Spec$Victor](nolock)  where   Quest='+quotename(@rowname,'''')+'  and val is not null
									 ) cr 
									on r.'+@item+'=cr.[value]

              '+case when  left(@STATS,1)=1  then ' inner join (select  * from #tab2 where '+@item+'=''-1'') as RT on 1=1   ' else '' end +'
			 order by cr.id

			 '

	   exec sp_executesql @sql ;

	   --print left(@sql,4000)
	   --print substring(@sql,4001,4000)
	   --print substring(@sql,8001,4000)
	   --print substring(@sql,12001,4000)
			  
----select @sql  ;
 set nocount off ;
end

 

GO
/****** Object:  StoredProcedure [dbo].[p_get_crosstab_test4]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
  ---author victor
 ---createdate 2015-01-27
  [p_get_crosstab_test] 3,10,'Q2','Q64',11,'',-1,-1,-1,-1,'','','','','','','','',''
    
  [p_get_crosstab_test3] 3,-1,'Q106','Q109',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
  [p_get_crosstab_test3] 3,-1,'Q106','Q109',22,0,' ',-1,-1,-1,-1,'','','','','','','','',''
  [p_get_crosstab_test3] 3,-1,'Q106','Q109',12,0,' ',-1,-1,-1,-1,'','','','','','','','',''
  [p_get_crosstab_test4] 3,-1,'Q9a','Q15',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

   [p_get_crosstab_test4] 3,-1,'Q14','Q2',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   [p_get_crosstab_test3] 3,-1,'Q2','Q14',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   [p_get_crosstab_test3] 3,-1,'Q2','Q14',12,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   [p_get_crosstab_test3] 3,-1,'Q2','Q14',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   [p_get_crosstab_test3] 3,-1,'Q2','Q14',22,0,' ',-1,-1,-1,-1,'','','','','','','','',''

    [p_get_crosstab_test3] 3,-1,'Q72_1','Q2',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
		
		exec [p_get_crosstab_test3] 3,-1,'Q2','Q63',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
	    exec [p_get_crosstab_test3] 3,-1,'Q2','Q63',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
	    exec [p_get_crosstab] 3,-1,'Q2','Q63',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

		exec [p_get_crosstab_test4] 3,-1,'Q2','Q13',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
	    exec [p_get_crosstab] 3,-1,'Q14','Q2',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

    [p_get_crosstab] 3,-1,'Q2','Q13',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
    [p_get_crosstab] 3,-1,'Q2','Q13',12,0,' ',-1,-1,-1,-1,'','','','','','','','',''
	[p_get_crosstab] 3,-1,'Q2','Q13',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
    [p_get_crosstab] 3,-1,'Q2','Q13',22,0,' ',-1,-1,-1,-1,'','','','','','','','',''


   exec [p_get_crosstab] 3,-1,'Q2','Q63',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
   print getdate()
   exec   [p_get_crosstab_test3] 3,-1,'Q2','Q63',12,0,' ',-1,-1,-1,-1,'','','','','','','','',''
	exec [p_get_crosstab_test4] 3,-1,'Q2','Q63',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
  exec  [p_get_crosstab_test4] 3,-1,'Q2','Q63',12,0,' ',-1,-1,-1,-1,'','','','','','','','',''

	[p_get_crosstab_test4] 3,-1,'Q2','Q63',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

	 exec [p_get_crosstab_test4] 3,-1,'Q2','Q14',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

	 print getdate()
	exec [p_get_crosstab_test] 3,-1,'Q2','Q14',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

 exec [p_get_crosstab_test4] 3,-1,'Q14','Q2',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
print getdate()
	exec [p_get_crosstab_test] 3,-1,'Q14','Q2',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''

	exec [p_get_crosstab_test4] 3,-1,'Q2','Q4',11,0,' ',-1,-1,-1,-1,'','','','','','','','',''
	exec [p_get_crosstab_test4] 3,-1,'Q2','Q4',21,0,' ',-1,-1,-1,-1,'','','','','','','','',''
      
 Stats: Column %           11
		Row %              21 
		Col % w/counts     12 
		Row % w/counts     22
		select* from Stats_Index
select * from [dbo].[Cross Tab Spec$Victor] where label like '%what%'
*/
CREATE   procedure [dbo].[p_get_crosstab_test4](
@YEAR_NEW int , 
@QUARTER_NEW int  ,
@columnname  nvarchar(100),
@rowname  nvarchar(100),
@STATS   tinyint=0,
@SIGNIFICANCE float =0.0,
@wherecondition nvarchar(max) ,
@group int  ,
@region int  ,
@district int  ,
@store  int  ,
@Age   nvarchar(50)='',
@Frequency_of_shopping  nvarchar(50)='',
@Gender  nvarchar(50)='',
@Income  nvarchar(50)='',
@Racial_background  nvarchar(50)='',
@Government_benefits  nvarchar(50)='',
@Store_Format  nvarchar(50)='',
@Store_Cluster  nvarchar(50)='',
@Shopper_Segment  nvarchar(50)='' 
)
as 
begin 

   set nocount on ; 
   declare @sql nvarchar(max) ='',
		   @raw nvarchar(max)='',
		   @hierarchy nvarchar(max)='',	
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),@where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int, 
		   @item   nvarchar(20)='';
  
			set @columnname=ltrim(rtrim(@columnname));
			set @rowname=ltrim(rtrim(@rowname));
			if len(@columnname)<=0 return ;
			if len(@rowname)<=0 return;

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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;


	set @hierarchy	=isnull(' and Store='+cast(@store as nvarchar) ,' ')+
					 isnull( ' and District='+cast(@district as nvarchar),' ')+
					 isnull( ' and [Region]='+cast(@region as nvarchar)  ,' ')+
					 isnull( ' and [Group]='+cast(@group as nvarchar)  ,' ')
	
	select top 1 @item=quotename(Item) from [Stats_Index] where Num=@STATS;	
	  
	  --	 select  quotename(Item),* from [Stats_Index]
declare @colvariable varchar(100)='',@colform varchar(max)='',@colform1 varchar(max)='',@colform2 varchar(max)='',
		@values varchar(4000)='',@coltype varchar(100)='SINGLE';

	select top 1 @coltype=[Type] from Variable_Layered(nolock) where Quest=@columnname ;

	if @coltype='MULTI'
	begin
		  select @colform=@colform
					+',sum(case when '+quotename(variable)+' =1 then [weight] else 0.0 end) as ['+cast(value as varchar(10))+'!B]'
					+',sum(case when '+quotename(variable)+' =1 then 1.0 else 0.0 end) as ['+cast(value as varchar(10))+'!C]'
					+',sum(case when '+quotename(variable)+' =1 then [weight]*[weight] else 0.0 end) as ['+cast(value as varchar(10))+'!S]',
				@colform1=@colform1
				+',sum(['+cast(value as varchar(10))+'!B]) as ['+cast(value as varchar(10))+'!B]'
				+',sum(['+cast(value as varchar(10))+'!C]) as ['+cast(value as varchar(10))+'!C]'
				+',sum(['+cast(value as varchar(10))+'!S]) as ['+cast(value as varchar(10))+'!S]',
				@colvariable= quotename(Quest),
				@values=@values+' or '+quotename(Variable)+' =1 ' ,
				@colform2=@colform2+','
						+case when left(@STATS,1)=1 then  
									 'cast(b.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(b.['+cast(value as varchar(10))+'!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B]/nullif(b.['+cast(value as varchar(10))+'!B],0.0) as varchar(30))+'+quotename(',','''')
								   +'+cast(b.['+cast(value as varchar(10))+'!S] as varchar(30))+'+quotename(',','''')
								   +'+a.totest +'+quotename(',','''')
								   +'+a.toshow   as ['+cast(value_label as varchar(100))+']'
							  when left(@STATS,1)=2 then 
									'cast(a.[Total!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.[Total!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B]/nullif(a.[Total!B],0.0) as varchar(30))+'+quotename(',','''')
								   +'+cast(a.[Total!S] as varchar(30))+'+quotename(',','''') 
								   +'+case when a.idx=-1 then ''N'' else  '''+left(ToTest,1)+''' end +'+quotename(',','''') 
								   +'+case when a.idx=-1 then ''N'' else  '''+left(ToShow,1)+''' end  as ['+cast(value_label as varchar(100))+']'
							  else 'cast(a.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!S] as varchar(30))   as ['+cast(value_label as varchar(100))+']'
						end
		   from Variable_Layered(nolock) where Quest=@columnname and value>=1 and valid=1 and used=1;
	end
	else
	begin
		  select @colform=@colform
					+',sum(case when '+quotename(variable)+' in('+cast(value as varchar(10))+') then [weight] else 0.0 end) as ['+cast(value as varchar(10))+'!B]'
					+',sum(case when '+quotename(variable)+' in('+cast(value as varchar(10))+') then 1.0 else 0.0 end) as ['+cast(value as varchar(10))+'!C]'
					+',sum(case when '+quotename(variable)+' in('+cast(value as varchar(10))+') then [weight]*[weight] else 0.0 end) as ['+cast(value as varchar(10))+'!S]',
				@colform1=@colform1
				+',sum(['+cast(value as varchar(10))+'!B]) as ['+cast(value as varchar(10))+'!B]'
				+',sum(['+cast(value as varchar(10))+'!C]) as ['+cast(value as varchar(10))+'!C]'
				+',sum(['+cast(value as varchar(10))+'!S]) as ['+cast(value as varchar(10))+'!S]',
				@colvariable= quotename(variable),
				@values=@values+','+cast(value as varchar(10)) ,
				@colform2=@colform2+','
						+case when left(@STATS,1)=1 then  
									 'cast(b.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(b.['+cast(value as varchar(10))+'!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B]/nullif(b.['+cast(value as varchar(10))+'!B],0.0) as varchar(30))+'+quotename(',','''')
								   +'+cast(b.['+cast(value as varchar(10))+'!S] as varchar(30))+'+quotename(',','''')
								   +'+a.totest +'+quotename(',','''')
								   +'+a.toshow    as ['+cast(value_label as varchar(100))+']'
							  when left(@STATS,1)=2 then 
									'cast(a.[Total!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.[Total!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B]/nullif(a.[Total!B],0.0) as varchar(30))+'+quotename(',','''')
								   +'+cast(a.[Total!S] as varchar(30))+'+quotename(',','''') 
								   +'+case when a.idx=-1 then ''N'' else '''+left(ToTest,1)+''' end+'+quotename(',','''') 
								   +'+case when a.idx=-1 then ''N'' else '''+left(ToShow,1)+''' end   as ['+cast(value_label as varchar(100))+']'
							  else 'cast(a.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!C] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!B] as varchar(30))+'+quotename(',','''')
								   +'+cast(a.['+cast(value as varchar(10))+'!S] as varchar(30))   as ['+cast(value_label as varchar(100))+']'
						end
		   from Variable_Layered(nolock) where Quest=@columnname  and valid=1 and used=1;
	   end
	     

declare @rowvariable varchar(100) ='' ,@rowform varchar(max)='',@rowvalues varchar(8000)='',@rowtype varchar(100)='SINGLE'
		,@rowform_1 varchar(max)='',@rowform_2 varchar(max)='' ;

select top 1 @rowtype=[Type]  from Variable_Layered(nolock) where Quest=@rowname ;

	if @rowtype='MULTI'
	begin
	  select @rowform=@rowform+' when Grouping('+quotename(variable)+')=0 then '+quotename(cast(value as varchar(10)),'''') +'  ',
			@rowvariable=quotename(Quest) ,
			@rowform_1=@rowform_1+', '+quotename(variable)+' ',
			@rowform_2=@rowform_2+'or '+quotename(variable)+'=1  '
	  from Variable_Layered(nolock) where Quest=@rowname and valid=1 and value>=1 and used=1;
	end
	else
	begin
	  select @rowform=@rowform+' when '+quotename(variable)+' in('+cast(value as varchar(10))+') then '+quotename(cast(value as varchar(10)),'''') +' ',
			@rowvariable=quotename(variable),
			@rowvalues=@rowvalues+',' +quotename(cast(value as varchar(10)),'''')
	  from Variable_Layered(nolock) where Quest=@rowname and valid=1 and used=1;
   end

---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 '+
						(case when @YEAR_NEW>0 then ' and YEAR_NEW='+cast(+@YEAR_NEW as nvarchar) else ' ' end)+
						(case when @QUARTER_NEW>0 then ' and QUARTER_NEW='+cast(@QUARTER_NEW as nvarchar) else ' ' end),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',@hierarchy,
							@where_raw ,'  )   ')+char(10)  ; 

	set @sql=@raw+'
	,t1 as (
	select 	case '+@rowform+' else '+quotename('-9999','''')+' end as '+@rowvariable+','
	+case when @coltype='MULTI' then '
			sum(case when '+stuff(@values,1,3,'')+'   then [weight] end) as [Total!B],
			sum(case when '+stuff(@values,1,3,'')+'   then  1.0 end) as [Total!C],
			sum(case when '+stuff(@values,1,3,'')+'   then [weight]*[weight] end) as [Total!S]
			' 
		  else '
			sum(case when '+@colvariable+' in ('+stuff(@values,1,1,'')+') then [weight] end) as [Total!B],
			sum(case when '+@colvariable+' in ('+stuff(@values,1,1,'')+') then  1.0 end) as [Total!C],
			sum(case when '+@colvariable+' in ('+stuff(@values,1,1,'')+') then [weight]*[weight] end) as [Total!S]
			' end 
			+@colform+' 
	from rawdata  '+case when @rowtype='MULTI' then ' where '+stuff(@rowform_2,1,2,'') else 'where '+@rowvariable+' in ('+stuff(@rowvalues,1,1,'')+')' end+'
	group by '+case when @rowtype='MULTI' then ' Grouping sets('+stuff(@rowform_1,1,1,'')+') '+char(10)+' having( '+stuff(@rowform_2,1,2,'')+' )'
					 else ' (case '+@rowform+' else '+quotename('-9999','''')+' end) ' end+'
	)

	,t1_1 as (
	select  ''-1111'' as '+@rowvariable+','
	+case when @coltype='MULTI' then '
			sum(case when '+stuff(@values,1,3,'')+'   then [weight] end) as [Total!B],
			sum(case when '+stuff(@values,1,3,'')+'   then  1.0 end) as [Total!C],
			sum(case when '+stuff(@values,1,3,'')+'   then [weight]*[weight] end) as [Total!S]
			' 
		  else '
			sum(case when '+@colvariable+' in ('+stuff(@values,1,1,'')+') then [weight] end) as [Total!B],
			sum(case when '+@colvariable+' in ('+stuff(@values,1,1,'')+') then  1.0 end) as [Total!C],
			sum(case when '+@colvariable+' in ('+stuff(@values,1,1,'')+') then [weight]*[weight] end) as [Total!S]
			' end 
			+@colform+' 
	from rawdata  '+case when @rowtype='MULTI' then ' where '+stuff(@rowform_2,1,2,'') else 'where '+@rowvariable+' in ('+stuff(@rowvalues,1,1,'')+')' end+'
	)
	select * into #tt from t1
	union all 
	select * from t1_1 ;

	;with t1 as (select * from #tt)
    ,t2 as (  ---valid detail data in values
	select 1000+v.value as idx , v.Value_label  '+@rowvariable+',  sum([Total!B]) [Total!B],sum([Total!C]) [Total!C],sum([Total!S]) [Total!S] '
	+@colform1+',ToTest,ToShow
	from t1 inner join  (select Value,Value_label,left(ToTest,1) as ToTest,left(ToShow,1) ToShow 
						 from Variable_Layered where Quest='+quotename(@rowname,'''')+'  and valid=1 and used=1 '+case when @rowtype='MULTI' then ' and value>0 and used=1 ' else '' end+' ) v
	on t1.'+@rowvariable+'=v.value
	where t1.'+@rowvariable+'  > '+quotename('-1111','''')+'
	group by v.Value_label ,V.value,ToTest,ToShow
	)
	,t3 as ( ---valid grouped data in values
	select 2000+v.G1 as idx, v.G1_label  '+@rowvariable+',  sum([Total!B]) [Total!B],sum([Total!C]) [Total!C],sum([Total!S]) [Total!S] '
	+@colform1+',ToTest,ToShow
	from t1 inner join  (select Value,G1,G1_label,right(ToTest,1) as ToTest,right(ToShow,1) ToShow 
						 from Variable_Layered where Quest='+quotename(@rowname,'''')+' and valid=1 and used=1 '+case when @rowtype='MULTI' then ' and value>0 and used=1 ' else '' end+') v
	on t1.'+@rowvariable+'=v.value
	where t1.'+@rowvariable+' > '+quotename('-1111','''')+'
	group by v.G1_label ,v.G1,ToTest,ToShow
	)
	,t4 as (  ---valid total data in values
	select -1 as idx, ''Total''  '+@rowvariable+',  sum([Total!B]) [Total!B],sum([Total!C]) [Total!C],sum([Total!S]) [Total!S] '
	+@colform1+',''N'' ToTest,''N''  ToShow
	from t1 
	where t1.'+@rowvariable+' = '+quotename('-1111','''')+'
	)
	,t5 as (
    select * from t4
	union all
	select * from t2
	union all 
	select * from t3	 
	)
	 select min(idx) over(partition by '+@rowvariable+' order by idx ) as minidx,* 
	 into #t6 
	 from t5 ;

	select  a.'+@rowvariable+' as '+@item+','
	+case when left(@STATS,1)=1 then ' cast(b.[Total!B] as varchar(30))+'+quotename(',','''')+'+cast(b.[Total!C] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!B] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!C] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!B]/nullif(b.[Total!B],0.0) as varchar(30))+'+quotename(',','''')+'+cast(b.[Total!S] as varchar(30))+'+quotename(',','''')+'+b.ToTest+'+quotename(',','''')+'+b.ToShow as  Total'  
		  when left(@STATS,1)=2 then ' cast(a.[Total!B] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!C] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!B] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!C] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!B]/nullif(a.[Total!B],0.0) as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!S] as varchar(30))+'+quotename(',','''')+'+'+quotename('N','''')+'+'+quotename(',','''')+'+'+quotename('N','''')+' as  Total ' 
		  else  ' cast(a.[Total!B] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!C] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!B] as varchar(30))+'+quotename(',','''')+'+cast(a.[Total!S] as varchar(30)) as  Total' end
	 +char(10) +@colform2+'
	from #t6 a '
	+case when left(@STATS,1)=1 then ',(select * from #t6 where idx=-1) b' when left(@STATS,1)=2 then ' ' else ' ' end+'
	where a.minidx=a.idx
	order by a.minidx
 
	' ;


	   exec sp_executesql @sql ;
	---select @sql  ;	  

 set nocount off ;
end



GO
/****** Object:  StoredProcedure [dbo].[p_get_DashBoard]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_DashBoard] 3,10,'  ',10,14,130,43
  [dbo].[p_get_DashBoard_test] 3,10,'  ',-1,-1,-1,-1
  exec  [dbo].[p_get_DashBoard_test] 3,10,'  ',10,14,130,-1
  exec    [dbo].[p_get_DashBoard] 3,10,'  ',10,14,427,721
  [dbo].[p_get_DashBoard_test] 3,9,'  ',10,14,-1,-1

[dbo].[p_get_DashBoard_test] null,10,'  ',30,18,345,5566
   [dbo].[p_get_DashBoard_test] 3,11,'  ',10,40,300,7898
   [dbo].[p_get_DashBoard_test] 2,7,'  ',10,14,130,-1
   [dbo].[p_get_DashBoard_test] 2,7,'  ',-1,-1,-1,-1
    ---[dbo].[p_get_DashBoard_test] 2,7,' and ( AGE_GROUP=1 or AGE_GROUP=2 or AGE_GROUP=3 or AGE_GROUP=4 or AGE_GROUP=5 ) and ( freq_shop=1 or freq_shop=2 or freq_shop=3 ) and ( Q63=1 or Q63=2 ) and ( Q64=1 or Q64=2 or Q64=3 or Q64=4 or Q64=5 ) and ( RACE_ETH=1 or RACE_ETH=2 or RACE_ETH=3 or RACE_ETH=4 ) and ( Q72_A11=1 or Q72_A10=1 or Q72_A09=1 or Q72_A08=1 or Q72_A07=1 or Q72_A06=1 or Q72_A05=1 or Q72_A04=1 or Q72_A03=1 or Q72_A02=1 or Q72_A01=1 ) and ( STOREFORMAT=1 or STOREFORMAT=2 or STOREFORMAT=3 or STOREFORMAT=4 or STOREFORMAT=5 ) and ( CLUSTER_UPDATED=1 or CLUSTER_UPDATED=2 or CLUSTER_UPDATED=3 or CLUSTER_UPDATED=4 or CLUSTER_UPDATED=5 ) ',10,-1,-1,-1

	exec p_get_DashBoard 3,10,'',50,50,1,655,'','','','','','0,0,0,0,0,0,0,0,0,0,0','','',''
	exec p_get_DashBoard_test 3,11,'',50,50,1,655,'','','','','','0,0,0,0,0,0,0,0,0,0,0','','',''

	 exec  [dbo].[p_get_DashBoard_test] 3,11,'  ',-1,-1,-1,-1
	  exec    [dbo].[p_get_DashBoard] 3,11,'  ',10,40,300,7898
*/
CREATE    proc [dbo].[p_get_DashBoard] (
@YEAR_NEW int,
@QUARTER_NEW int,
@wherecondition nvarchar(200),
@group int ,
@region int ,
@district int ,
@store  int   ,
@Age   nvarchar(100)='',
@Frequency_of_shopping  nvarchar(100)='',
@Gender  nvarchar(100)='',
@Income  nvarchar(100)='',
@Racial_background  nvarchar(100)='',
@Government_benefits  nvarchar(100)='',
@Store_Format  nvarchar(100)='',
@Store_Cluster  nvarchar(100)='',
@Shopper_Segment  nvarchar(100)=''
 )
 as 
 begin

   set nocount on ;

   declare @sql nvarchar(max) ='', 
		   @headlinesbar   nvarchar(max) ='',
		   @headlinesbar_1   nvarchar(max) ='',
		   @rankingsbar    nvarchar(max)='',
		   @customer_cash_score nvarchar(max)='' ,
		   @TopBotCustCASHAttr  nvarchar(max)='',
		   @TopBotSCORINGCustCASHAttr nvarchar(max)='',
		   @TopBotTRENDINGCustCASHAttr nvarchar(max)= '', 
		   @formhead nvarchar(max)='',
		   @formrank nvarchar(max)='',
		   @formcash nvarchar(max)='', 
		   @formcash_1 nvarchar(max)='', 
		   @formtbsco5 nvarchar(max)='',
		   @formtbtre nvarchar(max)='', 
		   @form nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @groupby nvarchar(max)='',
		   @grouping nvarchar(max)='',
		   @grouping_1 nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_sc nvarchar(max),
		   @where_raw nvarchar(max),
		   @where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @pos3 int,
		   @pos4 int;


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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;

	 

		---Raw Data with filter
			set @raw=concat(N';with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 '+char(10),@where_raw ,
									' and exists(select * from [dbo].[StoreFormat](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sf+') ',
									' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sc+')  ',
									'  )   ')+char(10)  ; 


			set @groupby= coalesce(case when @store is null  then null else ',[Group], Region, District, Store ' end,
				case when @district is null  then null else ',[Group], Region, District ' end,
				case when @region is null  then null else ',[Group], Region ' end,
				case when @group is null  then null else ',[Group]' end,
				''	) ;

			set @hierarchy	=coalesce( ' and Store='+cast(@store as nvarchar) ,
									 ' and District='+cast(@district as nvarchar) ,
									 ' and [Region]='+cast(@region as nvarchar) ,
									  ' and [Group]='+cast(@group as nvarchar) ,
							 ''
							 );

		set @grouping= coalesce( 
						   case when @store is null    then null else '( case when Grouping([Group])=1 then ''F''  when Grouping(Region)=1  then ''G''   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL  ' end 
						 , case when @district is null then null else '( case when Grouping([Group])=1 then ''F''  when Grouping(Region)=1  then ''G''  when Grouping(District)=1 then ''R''  else ''D''  end) as AL ' end
						 , case when @region is null   then null else '( case when Grouping([Group])=1 then ''F''  when Grouping(Region)=1  then ''G''  else ''R''   end) as AL ' end
						 , case when @group is null    then null else '( case when Grouping([Group])=1 then ''F''  else ''G'' end) as AL  ' end 
						 , '''F'' as AL') ;

		set @grouping_1=coalesce(case when @store is null then null else 'case  when AL=''G'' then [Group] when AL=''R'' then [Region]  when AL=''D'' then District When Al=''S'' then Store end as HI' end,
								 case when @district is null then null else 'case  when AL=''G'' then [Group] when AL=''R'' then [Region]  when AL=''D'' then District  end as HI' end,
								 case when @region is null then null else 'case  when AL=''G'' then [Group] when AL=''R'' then [Region]	 end as HI' end,
								 case when @group is null then null else 'case when AL=''G'' then [Group]  end as HI' end,
								   ' cast(null as int) as HI'
								  )
		     
----Headlines bar (shows for chain user type only) ,max_value_valid,min_value_valid

set @formhead=''	  
select @formhead=@formhead+', isnull( cast( cast(100*'+quotename(Variable)+' as decimal(18,0) ) as nvarchar)+''%'',''N/A'')  as' +quotename(Title) ,
	   @headlinesbar=@headlinesbar+', sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/ nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then  [weight]  end),0)  as '+quotename(Variable)  ,
	   @headlinesbar_1=@headlinesbar_1+', null  as '+quotename(Variable) 
from [dbo].[Headline_Variable] order by Position;

set @formhead=stuff(@formhead,1,1,'') ;
set @headlinesbar=stuff(@headlinesbar,1,1,'') ;
set @headlinesbar_1=stuff(@headlinesbar_1,1,1,'') ;

set  @headlinesbar=',headline as ( 
			select '+isnull(stuff(nullif(@groupby,''),1,1,'')+',','')+char(10)+@headlinesbar+',1 as flag	
			from rawdata   where  QUARTER_NEW = @QUARTER_NEW   
			  '+@hierarchy+'
			  '+isnull(' group by  '+stuff(nullif(@groupby,''),1,1,''),'') +'
		    union all select '+isnull(stuff(Replace(nullif(@groupby,''),',',',cast(null as int) as '),1,1,'')+',','')+char(10)+@headlinesbar_1+',0 as flag
		) 
		,h  as (select     '+@formhead +'  from headline where flag=(select max(flag) from headline) )';
 
----------------------------------------------------------------------------------------------- 
-----Rankings bar	  
  set @rankingsbar='' ;			  
  set  @formrank  ='' ; 

      select @formrank=@formrank+','+quotename(L2)+'= case when '+f.cs+' then null else  ('+e.eq+')  end' from 
		(select distinct L2 from [dbo].[KPICalcs] where L2='CASH CALCULATION')  l outer apply
		(select eq=stuff((select   concat('+ isnull(',quotename(Variable),',0) *', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,1,'' )) e outer apply
		(select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,3,'' )) f ;

     set @formrank=stuff(@formrank,1,1,'') ;
  	 
	select @rankingsbar=@rankingsbar+',
					 ( sum(case when '+quotename(Variable)+' in('+a.TopNbox+')  then [weight] else 0.0 end)		 
					  /nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0)   ) as '+quotename(Variable) 
  from [KPICalcs] a     where a.L2='CASH CALCULATION' 

    set @rankingsbar=stuff(@rankingsbar,1,1,'')  ;

	set @rankingsbar=',rankings as (
				   select  '+isnull(stuff(nullif(@groupby,''),1,1,'')+',','')+char(10)+@grouping+',
							'+@rankingsbar+'
					from  rawdata    where 1=1   AND QUARTER_NEW = @QUARTER_NEW  and [District]>0 
					  '  +isnull(' Group by rollup('+stuff(nullif(@groupby,''),1,1,'')+')','')+' )
			,r1 as (select  AL'+@groupby+','+@formrank+' 
					from rankings 
			)  
			,temprank as ( select  AL,'+@grouping_1+',rank() over(partition by AL order by [CASH CALCULATION] desc) as rnk
							 from r1 
			 )   
			,r as (  
			select  G,R,D,S 
			from (
			  select  AL,Rnk   from  temprank
		 	  where 1=1 '
					  + coalesce(  ' and (AL=''S'' and HI='+cast(@store as nvarchar)+'   ) '
								+isnull((select top 1 '
										or (AL=''D'' and  HI='+cast(district as nvarchar)+'  )
										or (AL=''R'' and HI='+cast(Region as nvarchar)+'   )
										or (AL=''G'' and HI='+cast([Group] as nvarchar)+' )'
										  from [dbo].[Hierarchy] where Store=@store  ),''), 
								   ' and (AL=''D'' and HI='+cast(@district as nvarchar)+') '
								+isnull((select top 1 '
										 or (AL=''R''  and HI='+cast(Region as nvarchar)+' ) 
										 or (AL=''G''  and HI='+cast([Group] as nvarchar)+'   )  '
										   from [dbo].[Hierarchy] where District=@district  ),''), 
								   ' and (AL=''R'' and [HI]='+cast(@region as nvarchar)+') '
								+isnull((select top 1 '
										 or (AL=''G''  and   [HI]='+cast([Group] as nvarchar)+'   )'
										  from [dbo].[Hierarchy] where Region=@region  ),'') , 
								   ' and (AL=''G'' and [HI]='+cast(@group as nvarchar)+') ',
								   '  ')
			+'	
			union all select  ''G'' AL,null as rnk
			union all select  ''R'' AL,null as rnk	
			union all select  ''D'' AL,null as rnk	
			union all select  ''S'' AL,null as rnk	
			) tab 
		     pivot( max(rnk) for AL in([G],[R],[D],[S]) ) p  
			 union all
			 select count(distinct [Group]) g ,count(distinct Region) r,count(distinct District) d,count(Distinct [Q2_1]) s from rawdata  where  QUARTER_NEW = @QUARTER_NEW  and [District]>0
		)
			  ' ; 
--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula 
 
  	set @customer_cash_score='';

	set @formcash='';
	select @formcash=@formcash+','+quotename(L2)+'= case when '+f.cs+' then null else 100*('+e.eq+')  end ' ,
		   @formcash_1=@formcash_1+', cast(null as int) as '+quotename(L2) 
	from (select distinct L2 from [dbo].[KPICalcs])  l outer apply
		 (select eq=stuff((select   concat('+isnull(',quotename(Variable),',0) *', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,1,'' )) e outer apply
		 (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,3,'' )) f ;
  
	set @formcash=stuff(@formcash,1,1,'') ;
	set @formcash_1=stuff(@formcash_1,1,1,'') ;

  	select @customer_cash_score=@customer_cash_score+',
					  sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end)/nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end) ,0)  as '+quotename(Variable) 
	from (select distinct Variable,[TopNBox],[Mid3Box],[Bot2Box] from  [KPICalcs]) t;

    set @customer_cash_score=stuff(@customer_cash_score,1,1,'') ;
 
	set @customer_cash_score=',cashscore as ( 
				select   QUARTER_NEW   as [Qrt] '+@groupby+',
						'+@customer_cash_score+'
				from  rawdata 
				where   ([QUARTER_NEW] between  (@QUARTER_NEW-1  )   and  @QUARTER_NEW )  '+@hierarchy+'
				group by [QUARTER_NEW] '+@groupby+' 
			 ) '   +char(10) 
			 +'
			,ut as (  select   Qrt'+@groupby+','+@formcash+' ,1 as flag
			    
			  from cashscore
			  union all select @QUARTER_NEW as  Qrt'+replace(@groupby,',',', null as ')+','+@formcash_1+',0 as flag 
			  union all select @QUARTER_NEW-1 as  Qrt'+replace(@groupby,',',', null as ')+','+@formcash_1+',0 as flag 
			  )
			,tab as (   select c.* 
			     from ut  c inner join (select max(flag) f,qrt q from ut group by qrt) d on c.flag=d.f and c.qrt=d.q 	)
           ,c as (
			select  isnull(  convert(varchar(20), cast( [CLEANLINESS SCORE] as decimal(18,1))  ),''N/A'')     [CLEANLINESS],
				    isnull(  convert(varchar(20), cast( [ASSORTMENT SCORE]  as decimal(18,1))  ),''N/A'')     [ASSORTMENT], 
				    isnull(  convert(varchar(20), cast( [SERVICE SCORE]  as decimal(18,1))  ),''N/A'')     [SERVICE],
				    isnull(  convert(varchar(20), cast( [HIGH SPEED SCORE]  as decimal(18,1))  ),''N/A'')    [HIGH SPEED],    
					isnull(  convert(varchar(20), cast( [CASH CALCULATION]  as decimal(18,1))  ),''N/A'')   [CASH]
			from tab  where qrt=  @QUARTER_NEW  
			union all
			select convert(varchar(20), cast( (a.[CLEANLINESS SCORE]- b.[CLEANLINESS SCORE] )  as decimal(18,0))    )    [CLEANLINESS],
				   convert(varchar(20), cast( (a.[ASSORTMENT SCORE]- b.[ASSORTMENT SCORE] )   as decimal(18,0))  )    [ASSORTMENT], 					   
				   convert(varchar(20), cast( (a. [SERVICE SCORE]- b.[SERVICE SCORE] )   as decimal(18,0))  )        [SERVICE],
				   convert(varchar(20), cast( (a.[HIGH SPEED SCORE]- b.[HIGH SPEED SCORE])  as decimal(18,0))  )      [HIGH SPEED], 					   
				   convert(varchar(20), cast( (a.[CASH CALCULATION]- b.[CASH CALCULATION] )  as decimal(18,0))    )    [CASH] 
			from (select * from tab where qrt=  @QUARTER_NEW ) a left join (select * from  tab where qrt=  (@QUARTER_NEW-1 ) )  b
			 on  1=1
			  )
			  '   ;
 
------------------------------------------------------------------
----------Top and Bottom SCORING Customer CASH Attributes	this is the top 3 and bottom 3 scoring varibales from the CASH variables listed below, based on the top 2 box aggregate
----------	Q7_GRID_01_Q7 	Q7_GRID_02_Q7 	Q7_GRID_03_Q7 	Q7_GRID_04_Q7 	Q7_GRID_05_Q7 	Q8_GRID_01_Q8 	Q8_GRID_02_Q8 	Q8_GRID_03_Q8 	Q8_GRID_04_Q8
----------	Q9_GRID_01_Q9 	Q12A			Q12C			 Q12D			 Q10_GRID_01_Q10
----------Top and Bottom TRENDING Customer CASH Attributes	Same as the table above, but ordered based on the top and bottom variances to the previous period (quarter).
 	set @TopBotCustCASHAttr ='' ; 
	select @formtbsco5=@formtbsco5+', '+quotename(Variable)  from  dbo.dashboard_TopNBot   ;
	set @formtbsco5 =stuff(@formtbsco5,1,1,'') ;


	select @TopBotCustCASHAttr=@TopBotCustCASHAttr+', 
			sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end)/nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0) as '+quotename(Variable)
	 from [dbo].[v_dashboard_scoring_trending_CASH_var] ;
	
	set @TopBotCustCASHAttr=stuff(@TopBotCustCASHAttr,1,1,'') ;
	  
	set @TopBotCustCASHAttr=',topbot as (
	   select  [QUARTER_NEW]   as Period '+@groupby+', 
					'+@TopBotCustCASHAttr+'
		from rawdata   where  QUARTER_NEW>= (@QUARTER_NEW-1  )  and QUARTER_NEW<= @QUARTER_NEW  '+@hierarchy+'
		group by    [QUARTER_NEW]   '+@groupby +' 	) ' +char(10)
		 +',temp as ( 
		    select  '+isnull(nullif(stuff(@groupby,1,1,''),'')+',','') +' Variable,100.0*['+cast(@QUARTER_NEW as nvarchar)+']  cur,100.0* ['+cast(@QUARTER_NEW-1 as nvarchar)+']  as pre
		    from topbot 
		    unpivot(Value for Variable in('+@formtbsco5+') ) up
		    pivot(max(Value) for Period in(['+cast(@QUARTER_NEW as nvarchar)+'],['+cast(@QUARTER_NEW-1 as nvarchar)+'])) p 
	)
	,temp1 as (
		 select c.Label,case when [cur]>[pre] then ''+'' else '''' end +coalesce(cast( cast([cur] -[pre] as decimal(18,0)) as varchar(30)),''N/A'')    as Variance,
				isnull(cast(cast(cur as decimal(18,0)) as varchar(30))+''%'',''N/A'') as CurrentPeriod,
			    row_number() over(order by case when [pre]>=0.0 then 0 else 1 end,a.[cur] desc) num1,
				row_number() over(order by case when [pre]>=0.0 then 0 else 1 end,a.[cur] asc ) num2,
			    row_number() over(order by case when [pre]>=0.0 then 0 else 1 end, [cur]-[pre]  desc) num11,
				row_number() over(order by case when [pre]>=0.0 then 0 else 1 end, [cur]-[pre]  asc) num22
			 
		 from   temp  a	right join  [dbo].[v_dashboard_scoring_trending_CASH_var] c on c.Variable=a.Variable  
	)
 select * into #final 
	from  (
		select ''Top 3 SCORING Customer CASH Attributes''  as a,''Diff vs. Last Qtr'' as b ,''Current Period''  as c ,''Bottom 3 SCORING Customer CASH Attributes'' as d,''Diff vs. Last Qtr'' as e,''Current Period'' as f,cast(1 as int) as g
		union all
		select top 3  a.Label, a.Variance  , a.currentPeriod ,b.Label, b.Variance , b.currentPeriod  ,1 as g
		from temp1 a  inner join temp1 b  on a.num1=b.num2  order by a.num1 ---and a.num1<=3
	    union all
		select ''Top 3 TRENDING Customer CASH Attributes'',''Diff vs. Last Qtr'',''Current Period'',''Bottom 3 TRENDING Customer CASH Attributes'',''Diff vs. Last Qtr'',''Current Period'',2 as g
		union all
		select top 3  a.Label, a.Variance , a.currentPeriod  ,b.Label, b.Variance , b.currentPeriod  ,2 as g
		from temp1 a  inner join temp1 b  on a.num11=b.num22  order by a.num11 ---   and a.num11<=3

		union all 
		select *,null e ,null f,3 as g from h

		union all
		select cast(g as varchar),cast(r as varchar),cast(d as varchar),cast(s as varchar),null e ,null f,4 as g from r

		union all 
		select *,null f,5 as g from c

		 )  t  ;

		 select a  [OVERALL SATISFACTION],b [RETURN TO SHOP],c  [RECOMMEND],d [PREFER FD FOR QUICK TRIPS]  from #final  where g=3  ;
		 select a as  G,b as R,c as D ,d as  S   from #final  where g=4  ;
		 select  a as [CLEANLINESS],b as  [ASSORTMENT],c as  [SERVICE],d as [HIGH SPEED],e as [CASH]     from #final  where g=5  ;

		 '	+case when @store is not null then  'select  ''N/A''  [Goal]' 
			       else ' select isnull( convert(varchar(20), cast( 100*b.[CASH Survey]  as decimal(18,1) ) ),''N/A'')  as [Goal]
			from  [Goals] b(nolock) where '+coalesce(case when @store is not null then '1=0' end,
											'    b.ID='+cast(@district as nvarchar)+'  and  b.[Goal Level]=''District''',
											'    b.ID='+cast(@region as nvarchar)+'  and  b.[Goal Level]=''Region''',
											 '   b.ID='+cast(@group as nvarchar)+' and  b.[Goal Level]=''Group''', 
											 '   b.ID=-1 and  b.[Goal Level]=''Overall''') 
			 end
      +'
	  select  a,b,c,d,e,f  from #final  where g=1  ;
	  select  a,b,c,d,e,f  from #final  where g=2  ;'         ;
 
	set @sql=@raw+@headlinesbar+char(10)+@rankingsbar+char(10)+@customer_cash_score+char(10)+@TopBotCustCASHAttr ;
   ----select @sql ;
	--print left(@sql,4000)
	--print substring(@sql,4001,4000)
	--print substring(@sql,8001,4000)
	--print substring(@sql,12001,4000)
	--print substring(@sql,16001,4000)



     exec sp_executesql @sql,N'  @YEAR_NEW int,   @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
   	 
	set nocount off ;

 end

   

GO
/****** Object:  StoredProcedure [dbo].[p_get_DashBoard_20150305BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_DashBoard_test] 3,10,'  ',10,14,130,41
  [dbo].[p_get_DashBoard_test] 3,9,'  ',-1,-1,-1,-1
   [dbo].[p_get_DashBoard_test] 3,9,'  ',10,14,130,-1
  [dbo].[p_get_DashBoard_test] 3,9,'  ',10,14,-1,-1
    [dbo].[p_get_DashBoard_test] 3,9,'  ',20,-1,-1,-1
[dbo].[p_get_DashBoard_test] 3,9,'  ',30,18,345,5566
[dbo].[p_get_DashBoard_test] 3,9,'  ',10,40,300,7898
*/
Create     proc [dbo].[p_get_DashBoard_20150305BAK] (
@YEAR_NEW int,
@QUARTER_NEW int,
@wherecondition nvarchar(max),
@group int ,
@region int ,
@district int ,
@store  int  
 )
 as 
 begin

   set nocount on ;

   declare @sql nvarchar(max) ='', 
		   @headlinesbar   nvarchar(max) ='',
		   @headlinesbar_1   nvarchar(max) ='',
		   @rankingsbar    nvarchar(max)='',
		   @customer_cash_score nvarchar(max)='' ,
		   @TopBotCustCASHAttr  nvarchar(max)='',
		   @TopBotSCORINGCustCASHAttr nvarchar(max)='',
		   @TopBotTRENDINGCustCASHAttr nvarchar(max)= '', 
		   @formhead nvarchar(max)='',
		   @formrank nvarchar(max)='',
		   @formcash nvarchar(max)='', 
		   @formcash_1 nvarchar(max)='', 
		   @formtbsco5 nvarchar(max)='',
		   @formtbtre nvarchar(max)='', 
		   @form nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @groupby nvarchar(max)='',
		   @grouping nvarchar(max)='',
		   @grouping_1 nvarchar(max)='',
		   @hierarchy nvarchar(max)='' ;


			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;
			  
 
 ---Raw Data with filter
	set @raw=concat(N'print @YEAR_NEW; print @QUARTER_NEW ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy]   where 1=1 ',@wherecondition+')   ')+char(10)  ;
	
	set @groupby= coalesce(case when @store is null  then null else ',[Group], Region, District, Store ' end,
		case when @district is null  then null else ',[Group], Region, District ' end,
		case when @region is null  then null else ',[Group], Region ' end,
		case when @group is null  then null else ',[Group]' end,
		''	) ;

	set @hierarchy	=coalesce(case when @store  is null then null else ' and Store='+cast(@store as nvarchar) end,
			         case when  @district  is null then null else ' and District='+cast(@district as nvarchar) end ,
					 case when  @region  is null then null else ' and [Region]='+cast(@region as nvarchar) end,
					 case when  @group  is null then null else ' and [Group]='+cast(@group as nvarchar) end,
					 ''
					 );

    set @grouping= coalesce( 
					   case when @store is null    then null else '( case when Grouping([Group])=1 then ''F''  when Grouping(Region)=1  then ''G''   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL  ' end 
					 , case when @district is null then null else '( case when Grouping([Group])=1 then ''F''  when Grouping(Region)=1  then ''G''  when Grouping(District)=1 then ''R''  else ''D''  end) as AL ' end
					 , case when @region is null   then null else '( case when Grouping([Group])=1 then ''F''  when Grouping(Region)=1  then ''G''  else ''R''   end) as AL ' end
					 , case when @group is null    then null else '( case when Grouping([Group])=1 then ''F''  else ''G'' end) as AL  ' end 
					 , '''F'' as AL') ;

	set @grouping_1=coalesce(case when @store is null then null else 'case  when AL=''G'' then [Group] when AL=''R'' then [Region]  when AL=''D'' then District When Al=''S'' then Store end as HI' end,
							 case when @district is null then null else 'case  when AL=''G'' then [Group] when AL=''R'' then [Region]  when AL=''D'' then District  end as HI' end,
							 case when @region is null then null else 'case  when AL=''G'' then [Group] when AL=''R'' then [Region]	 end as HI' end,
							 case when @group is null then null else 'case when AL=''G'' then [Group]  end as HI' end,
							   ' cast(null as int) as HI'
							  )
		     
----Headlines bar (shows for chain user type only) 

set @formhead=''	  
select @formhead=@formhead+', isnull(nullif(format('+quotename(Variable)+',''#%''),''%''),''N/A'')  as' +quotename(Title) ,
	   @headlinesbar=@headlinesbar+', sum(case when  '+quotename(Variable)+' in(6,7) then 1.0 end)/ sum(case when  '+quotename(Variable)+' between 1 and 7 then 1.0  end)  as '+quotename(Variable)  ,
	   @headlinesbar_1=@headlinesbar_1+', null  as '+quotename(Variable) 
from [dbo].[Headline_Variable] ;

set @formhead=stuff(@formhead,1,1,'') ;
set @headlinesbar=stuff(@headlinesbar,1,1,'') ;
set @headlinesbar_1=stuff(@headlinesbar_1,1,1,'') ;

set  @headlinesbar=',headline as ( 
			select '+isnull(stuff(nullif(@groupby,''),1,1,'')+',','')+char(10)+@headlinesbar+',1 as flag	
			from rawdata   where 1=1 '+
			coalesce(case when @QUARTER_NEW is null and @QUARTER_NEW<=0 then null else ' AND QUARTER_NEW = @QUARTER_NEW  ' end,
					 case when @YEAR_NEW is null and @YEAR_NEW<=0 then null else ' and  YEAR_NEW=@YEAR_NEW   ' end,'  ')+'
					 '+@hierarchy+'
			  '+isnull(' group by  '+stuff(nullif(@groupby,''),1,1,''),'') +'
		    union all select '+isnull(stuff(Replace(nullif(@groupby,''),',',',cast(null as int) as '),1,1,'')+',','')+char(10)+@headlinesbar_1+',0 as flag
		) ' +char(10)
		 +'select     '+@formhead +'  from headline where flag=(select max(flag) from headline) '
set @sql=@raw+@headlinesbar ;
 ------select @sql ;
 exec sp_executesql @sql,N'  @YEAR_NEW int,   @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
----------------------------------------------------------------------------------------------- 
-----Rankings bar	 
  set  @sql= N''; 
  set @rankingsbar='' ;			  
  set  @formrank  ='' ;
   
 select @formrank=@formrank+','+quotename(L2)+'= ('+e.eq+') ' from 
		(select distinct L2 from [dbo].[KPICalcs] where L2='CASH CALCULATION')  l outer apply
		(select eq=stuff((select   concat('+ isnull(',quotename(Variable),',0) *', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,1,'' )) e ;

  set @formrank=stuff(@formrank,1,1,'') ;
  	 
	select @rankingsbar=@rankingsbar+',
					  ( sum(case when '+quotename(Variable)+' in('+stuff((select top 1 Right(Vl.Value,2*[TOP N BOX SCORE]) from [KPICalcs] k where k.Variable=vr.Variable ),1,1,'')+')  then 1.0 end)		 
					  /sum(case when '+quotename(Variable)+' in('+Value+')  then 1.0 end)   ) as '+quotename(Variable) 
	from ( select distinct Variable  from [dbo].[KPICalcs]  where L2='CASH CALCULATION' ) vr 	outer apply 
		 ( select Value=STUFF((select ','+cast(Value as varchar)  from  [dbo].[Variable_Values] val where Value<=7 and  val.Variable=vr.Variable   order by Value for xml path('')),1,1,'' )  	) Vl ;
 
    set @rankingsbar=stuff(@rankingsbar,1,1,'')  ;

	set @rankingsbar=',rankings as (
				   select  '+isnull(stuff(nullif(@groupby,''),1,1,'')+',','')+char(10)+@grouping+',
							'+@rankingsbar+'
					from  rawdata    where 1=1 '+
					coalesce(case when @QUARTER_NEW is null and @QUARTER_NEW<=0 then null else ' AND QUARTER_NEW = @QUARTER_NEW  ' end,
							 case when @YEAR_NEW is null and @YEAR_NEW<=0 then null else ' and  YEAR_NEW=@YEAR_NEW' end,'  ')+'
					'+isnull(' Group by rollup('+stuff(nullif(@groupby,''),1,1,'')+')','')+' )
			,r1 as (select  AL'+@groupby+','+@formrank+' 
					from rankings 
			)  
			,temprank as ( select  AL,'+@grouping_1+',Rank() over(partition by AL order by [CASH CALCULATION]) as rnk
							 from r1 
			 )			  
			select  G,R,D,S 
			from (
			  select  AL,Rnk 
			  from  temprank
		 	  where 1=1 '
					  + coalesce(  ' and (AL=''S'' and HI='+cast(@store as nvarchar)+'   ) 
										or (AL=''D'' and HI=(select top 1 district from [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') )
										or (AL=''R'' and HI=(select top 1 Region from [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') )
										or (AL=''G'' and HI=(select top 1 [Group] from [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') )',
								   ' and (AL=''D'' and HI='+cast(@district as nvarchar)+') 
										 or (AL=''R''  and HI=(select top 1 [Region] from [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') ) 
										 or (AL=''G''  and HI=(select top 1 [Group] from [dbo].[Hierarchy] where [District]='+cast(@district as nvarchar)+') )  ',
								   ' and (AL=''R'' and [HI]='+cast(@region as nvarchar)+') 
										 or (AL=''G''  and HI=(select top 1 [Group] from [dbo].[Hierarchy] where [Region]='+cast(@region as nvarchar)+') )' ,
								   ' and (AL=''G'' and [HI]='+cast(@group as nvarchar)+') ',
								   '  ')
			+'	
			union all select  ''G'' AL,null as rnk
			union all select  ''R'' AL,null as rnk	
			union all select  ''D'' AL,null as rnk	
			union all select  ''S'' AL,null as rnk	
			) tab 
		     pivot( max(rnk) for AL in([G],[R],[D],[S]) ) p  
			 union all
			 select count(distinct [Group]) g ,count(distinct Region) r,count(distinct District) d,count(Distinct Store) s from [dbo].[Hierarchy] ;
			  ' ;

set @sql=@raw+@rankingsbar ;
---select @sql ;
 exec sp_executesql @sql,N'  @YEAR_NEW int,   @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula 
 
  	set @customer_cash_score='';

	set @formcash='';
	select @formcash=@formcash+','+quotename(L2)+'= 100*('+e.eq+')  ' , @formcash_1=@formcash_1+', cast(null as int) as '+quotename(L2) 
	from (select distinct L2 from [dbo].[KPICalcs])  l outer apply
		 (select eq=stuff((select   concat('+isnull(',quotename(Variable),',0) *', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,1,'' )) e

	set @formcash=stuff(@formcash,1,1,'') ;
	set @formcash_1=stuff(@formcash_1,1,1,'') ;

	select @customer_cash_score=@customer_cash_score+',
					  ( sum(case when '+quotename(Variable)+' in('+stuff((select top 1 Right(Vl.Value,2*[TOP N BOX SCORE]) from [KPICalcs] k where k.Variable=vr.Variable ),1,1,'')+')  then 1.0 end)			 
					  /sum(case when '+quotename(Variable)+' in('+Value+')  then 1.0 end)   ) as '+quotename(Variable) 
	from ( select distinct Variable  from [dbo].[KPICalcs]  ) vr 	outer apply 
		 ( select Value=STUFF((select ','+cast(Value as varchar)  from  [dbo].[Variable_Values] val where Value<=7 and  val.Variable=vr.Variable   order by Value for xml path('')),1,1,'' )  	) Vl ;
 
    set @customer_cash_score=stuff(@customer_cash_score,1,1,'') ;
 
	set @customer_cash_score=',cashscore as ( 
				select   QUARTER_NEW   as [Qrt] '+@groupby+',
						'+@customer_cash_score+'
				from  rawdata 
				where   ([QUARTER_NEW] between  (@QUARTER_NEW-1  )   and  @QUARTER_NEW )  '+@hierarchy+'
				group by [QUARTER_NEW] '+@groupby+' 
			 ) '   +char(10) 
			 +'
			,ut as (  select   Qrt'+@groupby+','+@formcash+' ,1 as flag
			    
			  from cashscore
			  union all select @QUARTER_NEW as  Qrt'+replace(@groupby,',',', null as ')+','+@formcash_1+',0 as flag 
			  )
			   select c.* into #tab 
			     from ut  c inner join (select max(flag) f,qrt q from ut group by qrt) d on c.flag=d.f and c.qrt=d.q 		    ;
			    
			select  isnull(  convert(varchar(20), cast([CLEANLINESS SCORE] as int)),''N/A'')     [CLEANLINESS],
				    isnull(  convert(varchar(20), cast([ASSORTMENT SCORE] as int)),''N/A'')     [ASSORTMENT], 
				    isnull(  convert(varchar(20), cast([SERVICE SCORE] as int)),''N/A'')     [SERVICE],
				    isnull(  convert(varchar(20), cast([HIGH SPEED SCORE] as int)),''N/A'')    [HIGH SPEED],    
					isnull(  convert(varchar(20), cast([CASH CALCULATION] as int)),''N/A'')   [CASH]
			from #tab  where qrt=  @QUARTER_NEW  
			union all
			select  isnull(  convert(varchar(20), cast( (a.[CLEANLINESS SCORE]- b.[CLEANLINESS SCORE] ) as int) ),''N/A'')   [CLEANLINESS],
					isnull(  convert(varchar(20), cast( (a.[ASSORTMENT SCORE]- b.[ASSORTMENT SCORE] )  as int) ) ,''N/A'')   [ASSORTMENT], 					   
					isnull(  convert(varchar(20), cast( (a. [SERVICE SCORE]- b.[SERVICE SCORE] )  as int) )  ,''N/A'')       [SERVICE],
				    isnull(  convert(varchar(20), cast( (a.[HIGH SPEED SCORE]- b.[HIGH SPEED SCORE]) as int) ) ,''N/A'')     [HIGH SPEED], 					   
					isnull(  convert(varchar(20), cast( (a.[CASH CALCULATION]- b.[CASH CALCULATION] )  as int) ) ,''N/A'')   [CASH] 
			from (select * from #tab where qrt=  @QUARTER_NEW ) a left join (select * from  #tab where qrt=  (@QUARTER_NEW-1 ) )  b
			 on  1=1 '+
			coalesce(case when @store is null   then null else ' and a.[Group]=b.[Group] and a.Region=b.Region and a.District=b.District and a.Store=b.Store ' end,
					 case when @district is null   then null else ' and a.[Group]=b.[Group] and a.Region=b.Region and a.District=b.District ' end,
					 case when @region is null  then null else ' and a.[Group]=b.[Group] and a.Region=b.Region ' end,
					 case when @group is null   then null else 'and a.[Group]=b.[Group] ' end,' '	)+' 
			  ;
			'+case when @store is not null then  'select  ''N/A''  [Goal]' 
			       else '
			select isnull( convert(varchar(20), cast( 100*b.[CASH Survey]  as int) ),''N/A'')  as [Goal]
			from  [Goals] b where '+coalesce(case when @store is not null then '1=0' end,
											' b.[Goal Level]=''District'' and  b.ID='+cast(@district as nvarchar),
											'  b.[Goal Level]=''Region'' and b.ID='+cast(@region as nvarchar),
											 ' b.[Goal Level]=''Group'' and  b.ID='+cast(@group as nvarchar), 
											 ' b.[Goal Level]=''Overall'' and  -1=b.ID') 
			 end
				  ;
					 
	set @sql=@raw+@customer_cash_score ;
	----select @sql ;
 exec sp_executesql @sql,N'  @YEAR_NEW int,   @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;

 
------------------------------------------------------------------
----------Top and Bottom SCORING Customer CASH Attributes	this is the top 3 and bottom 3 scoring varibales from the CASH variables listed below, based on the top 2 box aggregate
----------	Q7_GRID_01_Q7 	Q7_GRID_02_Q7 	Q7_GRID_03_Q7 	Q7_GRID_04_Q7 	Q7_GRID_05_Q7 	Q8_GRID_01_Q8 	Q8_GRID_02_Q8 	Q8_GRID_03_Q8 	Q8_GRID_04_Q8
----------	Q9_GRID_01_Q9 	Q12A			Q12C			 Q12D			 Q10_GRID_01_Q10
----------Top and Bottom TRENDING Customer CASH Attributes	Same as the table above, but ordered based on the top and bottom variances to the previous period (quarter).
 	set @TopBotCustCASHAttr ='' ; 
	select @formtbsco5=@formtbsco5+', '+quotename(Variable)  
	from (select distinct Variable from [dbo].[v_dashboard_scoring_trending_CASH_var]) t ;
	set @formtbsco5 =stuff(@formtbsco5,1,1,'') ;


	select @TopBotCustCASHAttr=@TopBotCustCASHAttr+', 
			sum(case when '+quotename(Variable)+' in('+TopNbox+')  then 1.0 end)/nullif(sum(case when '+quotename(Variable)+' between '+cast(min_value_valid as nvarchar)+' and '+cast(max_value_valid as nvarchar)+'  then 1.0 end),0) as '+quotename(Variable)
	 from [dbo].[v_dashboard_scoring_trending_CASH_var] ;
	
	set @TopBotCustCASHAttr=stuff(@TopBotCustCASHAttr,1,1,'') ;
	  
	set @TopBotCustCASHAttr=',topbot as (
	   select [QUARTER_NEW] as Period '+@groupby+', 
					'+@TopBotCustCASHAttr+'
		from rawdata   where  QUARTER_NEW>= (@QUARTER_NEW-1  )  and QUARTER_NEW<= @QUARTER_NEW  '+@hierarchy+'
		group by   [QUARTER_NEW] '+@groupby +' 	) ' +char(10)
		 +',temp as ( select * 	from topbot  unpivot(CurrentPeriod for Variable in('+@formtbsco5+') ) up )

		 select c.Label,isnull(convert(varchar(20),cast(100*(a.CurrentPeriod- b.CurrentPeriod) as int)),''N/A'')  as Variance,isnull(nullif(Format(a.CurrentPeriod,''#%''),''%''),''N/A'') as CurrentPeriod,
			    row_number() over(order by a.CurrentPeriod desc) num1,row_number() over(order by a.CurrentPeriod asc ) num2,
			    row_number() over(order by b.CurrentPeriod desc) num11,row_number() over(order by b.CurrentPeriod asc) num22
			   into #temp1 
		 from (select * from temp where Period= @QUARTER_NEW) a 
				left join (select * from temp where Period= ( @QUARTER_NEW-1  ) ) b on a.Variable=b.Variable 
				 '+
			coalesce(case when @store is null   then null else ' and a.[Group]=b.[Group] and a.Region=b.Region and a.District=b.District and a.Store=b.Store ' end,
					 case when @district is null   then null else ' and a.[Group]=b.[Group] and a.Region=b.Region and a.District=b.District ' end,
					 case when @region is null   then null else ' and a.[Group]=b.[Group] and a.Region=b.Region ' end,
					 case when @group is null   then null else 'and a.[Group]=b.[Group] ' end,	''	)+'
				right join  [dbo].[v_dashboard_scoring_trending_CASH_var] c on c.Variable=a.Variable 
		
				 ;

		select ''Top 3 SCORING Customer CASH Attributes'',''Variance'',''Current Period'',''Bottom 3 SCORING Customer CASH Attributes'',''Variance'',''Current Period''
		union all
		select a.Label, a.Variance  , a.currentPeriod ,b.Label, b.Variance , b.currentPeriod as nvarchar 
		from #temp1 a  inner join #temp1 b  on a.num1=b.num2 and a.num1<=3
		;
 
		 select ''Top 3 TRENDING Customer CASH Attributes'',''Variance'',''Current Period'',''Bottom 3 TRENDING Customer CASH Attributes'',''Variance'',''Current Period''
		 union all
		 select a.Label, a.Variance , a.currentPeriod  ,b.Label, b.Variance , b.currentPeriod as nvarchar 
		 from #temp1 a  inner join #temp1 b  on a.num11=b.num22     and a.num11<=3	;
		   
		 ' ;
 
	set @sql=@raw+@TopBotCustCASHAttr ;
 
     exec sp_executesql @sql,N'  @YEAR_NEW int,   @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
   	 
   --- select @sql ;

	set nocount off ;

 end

   
GO
/****** Object:  StoredProcedure [dbo].[p_get_DashBoard_20150401BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_DashBoard] 3,9,'  ',10,14,130,43
  [dbo].[p_get_DashBoard_test] 3,9,'  ',-1,-1,-1,-1
  exec  [dbo].[p_get_DashBoard_test] 3,10,'  ',10,14,130,-1
  exec    [dbo].[p_get_DashBoard] 3,10,'  ',10,14,130,-1
  [dbo].[p_get_DashBoard_test] 3,9,'  ',10,14,-1,-1
    [dbo].[p_get_DashBoard_test1] 3,9,'  ',20,-1,-1,-1
[dbo].[p_get_DashBoard_test1] 3,9,'  ',30,18,345,5566
[dbo].[p_get_DashBoard_test1] 3,9,'  ',10,40,300,7898
   [dbo].[p_get_DashBoard_test] 2,7,'  ',10,14,130,-1
   [dbo].[p_get_DashBoard_test] 2,7,'  ',-1,-1,-1,-1
    ---[dbo].[p_get_DashBoard_test] 2,7,' and ( AGE_GROUP=1 or AGE_GROUP=2 or AGE_GROUP=3 or AGE_GROUP=4 or AGE_GROUP=5 ) and ( freq_shop=1 or freq_shop=2 or freq_shop=3 ) and ( Q63=1 or Q63=2 ) and ( Q64=1 or Q64=2 or Q64=3 or Q64=4 or Q64=5 ) and ( RACE_ETH=1 or RACE_ETH=2 or RACE_ETH=3 or RACE_ETH=4 ) and ( Q72_A11=1 or Q72_A10=1 or Q72_A09=1 or Q72_A08=1 or Q72_A07=1 or Q72_A06=1 or Q72_A05=1 or Q72_A04=1 or Q72_A03=1 or Q72_A02=1 or Q72_A01=1 ) and ( STOREFORMAT=1 or STOREFORMAT=2 or STOREFORMAT=3 or STOREFORMAT=4 or STOREFORMAT=5 ) and ( CLUSTER_UPDATED=1 or CLUSTER_UPDATED=2 or CLUSTER_UPDATED=3 or CLUSTER_UPDATED=4 or CLUSTER_UPDATED=5 ) ',10,-1,-1,-1

*/
create     proc [dbo].[p_get_DashBoard_20150401BAK] (
@YEAR_NEW int,
@QUARTER_NEW int,
@wherecondition nvarchar(max),
@group int ,
@region int ,
@district int ,
@store  int  
 )
 as 
 begin

   set nocount on ;

   declare @sql nvarchar(max) ='', 
		   @headlinesbar   nvarchar(max) ='',
		   @headlinesbar_1   nvarchar(max) ='',
		   @rankingsbar    nvarchar(max)='',
		   @customer_cash_score nvarchar(max)='' ,
		   @TopBotCustCASHAttr  nvarchar(max)='',
		   @TopBotSCORINGCustCASHAttr nvarchar(max)='',
		   @TopBotTRENDINGCustCASHAttr nvarchar(max)= '', 
		   @formhead nvarchar(max)='',
		   @formrank nvarchar(max)='',
		   @formcash nvarchar(max)='', 
		   @formcash_1 nvarchar(max)='', 
		   @formtbsco5 nvarchar(max)='',
		   @formtbtre nvarchar(max)='', 
		   @form nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @groupby nvarchar(max)='',
		   @grouping nvarchar(max)='',
		   @grouping_1 nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_sc nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @pos3 int,
		   @pos4 int;


			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;

			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	
 
---Raw Data with filter
	set @raw=concat(N'print @YEAR_NEW; print @QUARTER_NEW  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 ',@where_raw ,
							' and exists(select * from [dbo].[StoreFormat](nolock)  where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							'  )   ')+char(10)  ; 


	set @groupby= coalesce(case when @store is null  then null else ',[Group], Region, District, Store ' end,
		case when @district is null  then null else ',[Group], Region, District ' end,
		case when @region is null  then null else ',[Group], Region ' end,
		case when @group is null  then null else ',[Group]' end,
		''	) ;

	set @hierarchy	=coalesce(case when @store  is null then null else ' and Store='+cast(@store as nvarchar) end,
			         case when  @district  is null then null else ' and District='+cast(@district as nvarchar) end ,
					 case when  @region  is null then null else ' and [Region]='+cast(@region as nvarchar) end,
					 case when  @group  is null then null else ' and [Group]='+cast(@group as nvarchar) end,
					 ''
					 );

    set @grouping= coalesce( 
					   case when @store is null    then null else '( case when Grouping([Group])=1 then ''F''  when Grouping(Region)=1  then ''G''   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL  ' end 
					 , case when @district is null then null else '( case when Grouping([Group])=1 then ''F''  when Grouping(Region)=1  then ''G''  when Grouping(District)=1 then ''R''  else ''D''  end) as AL ' end
					 , case when @region is null   then null else '( case when Grouping([Group])=1 then ''F''  when Grouping(Region)=1  then ''G''  else ''R''   end) as AL ' end
					 , case when @group is null    then null else '( case when Grouping([Group])=1 then ''F''  else ''G'' end) as AL  ' end 
					 , '''F'' as AL') ;

	set @grouping_1=coalesce(case when @store is null then null else 'case  when AL=''G'' then [Group] when AL=''R'' then [Region]  when AL=''D'' then District When Al=''S'' then Store end as HI' end,
							 case when @district is null then null else 'case  when AL=''G'' then [Group] when AL=''R'' then [Region]  when AL=''D'' then District  end as HI' end,
							 case when @region is null then null else 'case  when AL=''G'' then [Group] when AL=''R'' then [Region]	 end as HI' end,
							 case when @group is null then null else 'case when AL=''G'' then [Group]  end as HI' end,
							   ' cast(null as int) as HI'
							  )
		     
----Headlines bar (shows for chain user type only) ,max_value_valid,min_value_valid

set @formhead=''	  
select @formhead=@formhead+', isnull( cast( cast(100*'+quotename(Variable)+' as decimal(18,0) ) as nvarchar)+''%'',''N/A'')  as' +quotename(Title) ,
	   @headlinesbar=@headlinesbar+', sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/ nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then  [weight]  end),0)  as '+quotename(Variable)  ,
	   @headlinesbar_1=@headlinesbar_1+', null  as '+quotename(Variable) 
from [dbo].[Headline_Variable] order by id;

set @formhead=stuff(@formhead,1,1,'') ;
set @headlinesbar=stuff(@headlinesbar,1,1,'') ;
set @headlinesbar_1=stuff(@headlinesbar_1,1,1,'') ;

set  @headlinesbar=',headline as ( 
			select '+isnull(stuff(nullif(@groupby,''),1,1,'')+',','')+char(10)+@headlinesbar+',1 as flag	
			from rawdata   where 1=1 '+
			coalesce( 
			case when @QUARTER_NEW is null and @QUARTER_NEW<=0 then null else ' AND QUARTER_NEW = @QUARTER_NEW  ' end,case when @YEAR_NEW is null and @YEAR_NEW<=0 then null else ' and  YEAR_NEW=@YEAR_NEW   ' end,
					'  ')+'
					 '+@hierarchy+'
			  '+isnull(' group by  '+stuff(nullif(@groupby,''),1,1,''),'') +'
		    union all select '+isnull(stuff(Replace(nullif(@groupby,''),',',',cast(null as int) as '),1,1,'')+',','')+char(10)+@headlinesbar_1+',0 as flag
		) 
		,h  as (select     '+@formhead +'  from headline where flag=(select max(flag) from headline) )';
 
----------------------------------------------------------------------------------------------- 
-----Rankings bar	  
  set @rankingsbar='' ;			  
  set  @formrank  ='' ; 

      select @formrank=@formrank+','+quotename(L2)+'= case when '+f.cs+' then null else  ('+e.eq+')  end' from 
		(select distinct L2 from [dbo].[KPICalcs] where L2='CASH CALCULATION')  l outer apply
		(select eq=stuff((select   concat('+ isnull(',quotename(Variable),',0) *', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,1,'' )) e outer apply
		(select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,3,'' )) f ;

     set @formrank=stuff(@formrank,1,1,'') ;
  	 
	select @rankingsbar=@rankingsbar+',
					 ( sum(case when '+quotename(Variable)+' in('+a.TopNbox+')  then [weight] else 0.0 end)		 
					  /nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0)   ) as '+quotename(Variable) 
  from [KPICalcs] a     where a.L2='CASH CALCULATION' 

    set @rankingsbar=stuff(@rankingsbar,1,1,'')  ;

	set @rankingsbar=',rankings as (
				   select  '+isnull(stuff(nullif(@groupby,''),1,1,'')+',','')+char(10)+@grouping+',
							'+@rankingsbar+'
					from  rawdata    where 1=1 '+
					coalesce(case when @QUARTER_NEW is null and @QUARTER_NEW<=0 then null else ' AND QUARTER_NEW = @QUARTER_NEW  ' end,
							 case when @YEAR_NEW is null and @YEAR_NEW<=0 then null else ' and  YEAR_NEW=@YEAR_NEW' end,'  ')+'
					'+isnull(' Group by rollup('+stuff(nullif(@groupby,''),1,1,'')+')','')+' )
			,r1 as (select  AL'+@groupby+','+@formrank+' 
					from rankings 
			)  
			,temprank as ( select  AL,'+@grouping_1+',Rank() over(partition by AL order by [CASH CALCULATION]) as rnk
							 from r1 
			 )   
			,r as (  
			select  G,R,D,S 
			from (
			  select  AL,Rnk   from  temprank
		 	  where 1=1 '
					  + coalesce(  ' and (AL=''S'' and HI='+cast(@store as nvarchar)+'   ) '
								+isnull((select top 1 '
										or (AL=''D'' and  HI='+cast(district as nvarchar)+'  )
										or (AL=''R'' and HI='+cast(Region as nvarchar)+'   )
										or (AL=''G'' and HI='+cast([Group] as nvarchar)+' )'
										  from [dbo].[Hierarchy] where Store=@store  ),''), 
								   ' and (AL=''D'' and HI='+cast(@district as nvarchar)+') '
								+isnull((select top 1 '
										 or (AL=''R''  and HI='+cast(Region as nvarchar)+' ) 
										 or (AL=''G''  and HI='+cast([Group] as nvarchar)+'   )  '
										   from [dbo].[Hierarchy] where District=@district  ),''), 
								   ' and (AL=''R'' and [HI]='+cast(@region as nvarchar)+') '
								+isnull((select top 1 '
										 or (AL=''G''  and   [HI]='+cast([Group] as nvarchar)+'   )'
										  from [dbo].[Hierarchy] where Region=@region  ),'') , 
								   ' and (AL=''G'' and [HI]='+cast(@group as nvarchar)+') ',
								   '  ')
			+'	
			union all select  ''G'' AL,null as rnk
			union all select  ''R'' AL,null as rnk	
			union all select  ''D'' AL,null as rnk	
			union all select  ''S'' AL,null as rnk	
			) tab 
		     pivot( max(rnk) for AL in([G],[R],[D],[S]) ) p  
			 union all
			 select count(distinct [Group]) g ,count(distinct Region) r,count(distinct District) d,count(Distinct Store) s from [dbo].[Hierarchy] 
		)
			  ' ; 
--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula 
 
  	set @customer_cash_score='';

	set @formcash='';
	select @formcash=@formcash+','+quotename(L2)+'= case when '+f.cs+' then null else cast(100*('+e.eq+') as decimal(18,0) ) end ' ,
		   @formcash_1=@formcash_1+', cast(null as int) as '+quotename(L2) 
	from (select distinct L2 from [dbo].[KPICalcs])  l outer apply
		 (select eq=stuff((select   concat('+isnull(',quotename(Variable),',0) *', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,1,'' )) e outer apply
		 (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,3,'' )) f ;
  
	set @formcash=stuff(@formcash,1,1,'') ;
	set @formcash_1=stuff(@formcash_1,1,1,'') ;

  	select @customer_cash_score=@customer_cash_score+',
					  sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end)/nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end) ,0)  as '+quotename(Variable) 
	from (select distinct Variable,[TopNBox],[Mid3Box],[Bot2Box] from  [KPICalcs]) t;

    set @customer_cash_score=stuff(@customer_cash_score,1,1,'') ;
 
	set @customer_cash_score=',cashscore as ( 
				select   QUARTER_NEW   as [Qrt] '+@groupby+',
						'+@customer_cash_score+'
				from  rawdata 
				where   ([QUARTER_NEW] between  (@QUARTER_NEW-1  )   and  @QUARTER_NEW )  '+@hierarchy+'
				group by [QUARTER_NEW] '+@groupby+' 
			 ) '   +char(10) 
			 +'
			,ut as (  select   Qrt'+@groupby+','+@formcash+' ,1 as flag
			    
			  from cashscore
			  union all select @QUARTER_NEW as  Qrt'+replace(@groupby,',',', null as ')+','+@formcash_1+',0 as flag 
			  union all select @QUARTER_NEW-1 as  Qrt'+replace(@groupby,',',', null as ')+','+@formcash_1+',0 as flag 
			  )
			,tab as (   select c.* 
			     from ut  c inner join (select max(flag) f,qrt q from ut group by qrt) d on c.flag=d.f and c.qrt=d.q 	)
           ,c as (
			select  isnull(  convert(varchar(20),  [CLEANLINESS SCORE]  ),''N/A'')     [CLEANLINESS],
				    isnull(  convert(varchar(20),  [ASSORTMENT SCORE]  ),''N/A'')     [ASSORTMENT], 
				    isnull(  convert(varchar(20),  [SERVICE SCORE]  ),''N/A'')     [SERVICE],
				    isnull(  convert(varchar(20),  [HIGH SPEED SCORE]  ),''N/A'')    [HIGH SPEED],    
					isnull(  convert(varchar(20),  [CASH CALCULATION]  ),''N/A'')   [CASH]
			from tab  where qrt=  @QUARTER_NEW  
			union all
			select  isnull(  convert(varchar(20),  (a.[CLEANLINESS SCORE]- b.[CLEANLINESS SCORE] )   ),''N/A'')   [CLEANLINESS],
					isnull(  convert(varchar(20),  (a.[ASSORTMENT SCORE]- b.[ASSORTMENT SCORE] )   ) ,''N/A'')   [ASSORTMENT], 					   
					isnull(  convert(varchar(20),  (a. [SERVICE SCORE]- b.[SERVICE SCORE] )   )  ,''N/A'')       [SERVICE],
				    isnull(  convert(varchar(20),  (a.[HIGH SPEED SCORE]- b.[HIGH SPEED SCORE])  ) ,''N/A'')     [HIGH SPEED], 					   
					isnull(  convert(varchar(20),  (a.[CASH CALCULATION]- b.[CASH CALCULATION] )   ) ,''N/A'')   [CASH] 
			from (select * from tab where qrt=  @QUARTER_NEW ) a left join (select * from  tab where qrt=  (@QUARTER_NEW-1 ) )  b
			 on  1=1
			  )
			  '   ;
 
------------------------------------------------------------------
----------Top and Bottom SCORING Customer CASH Attributes	this is the top 3 and bottom 3 scoring varibales from the CASH variables listed below, based on the top 2 box aggregate
----------	Q7_GRID_01_Q7 	Q7_GRID_02_Q7 	Q7_GRID_03_Q7 	Q7_GRID_04_Q7 	Q7_GRID_05_Q7 	Q8_GRID_01_Q8 	Q8_GRID_02_Q8 	Q8_GRID_03_Q8 	Q8_GRID_04_Q8
----------	Q9_GRID_01_Q9 	Q12A			Q12C			 Q12D			 Q10_GRID_01_Q10
----------Top and Bottom TRENDING Customer CASH Attributes	Same as the table above, but ordered based on the top and bottom variances to the previous period (quarter).
 	set @TopBotCustCASHAttr ='' ; 
	select @formtbsco5=@formtbsco5+', '+quotename(Variable)  
	from (select distinct Variable from [dbo].[v_dashboard_scoring_trending_CASH_var]) t ;
	set @formtbsco5 =stuff(@formtbsco5,1,1,'') ;


	select @TopBotCustCASHAttr=@TopBotCustCASHAttr+', 
			sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end)/nullif(sum(case when '+quotename(Variable)+' between '+cast(min_value_valid as nvarchar)+' and '+cast(max_value_valid as nvarchar)+'  then [weight] end),0) as '+quotename(Variable)
	 from [dbo].[v_dashboard_scoring_trending_CASH_var] ;
	
	set @TopBotCustCASHAttr=stuff(@TopBotCustCASHAttr,1,1,'') ;
	  
	set @TopBotCustCASHAttr=',topbot as (
	   select  [QUARTER_NEW]   as Period '+@groupby+', 
					'+@TopBotCustCASHAttr+'
		from rawdata   where  QUARTER_NEW>= (@QUARTER_NEW-1  )  and QUARTER_NEW<= @QUARTER_NEW  '+@hierarchy+'
		group by    [QUARTER_NEW]   '+@groupby +' 	) ' +char(10)
		 +',temp as ( 
		    select  '+isnull(nullif(stuff(@groupby,1,1,''),'')+',','') +' Variable,cast(100*['+cast(@QUARTER_NEW as nvarchar)+'] as decimal(18,0) ) cur,cast(100* ['+cast(@QUARTER_NEW-1 as nvarchar)+'] as  decimal(18,0)) as pre
		    from topbot 
		    unpivot(Value for Variable in('+@formtbsco5+') ) up
		    pivot(max(Value) for Period in(['+cast(@QUARTER_NEW as nvarchar)+'],['+cast(@QUARTER_NEW-1 as nvarchar)+'])) p 
	)
	,temp1 as (
		 select c.Label,isnull( cast([cur]-[pre]  as varchar),''N/A'')  as Variance,isnull(cast(cur as varchar)+''%'',''N/A'') as CurrentPeriod,
			    row_number() over(order by a.[cur] desc) num1,row_number() over(order by a.[cur] asc ) num2,
			    row_number() over(order by [cur]-[pre]  desc) num11,row_number() over(order by [cur]-[pre]  asc) num22
			 
		 from   temp  a	right join  [dbo].[v_dashboard_scoring_trending_CASH_var] c on c.Variable=a.Variable  
	)
 select * into #final 
	from  (
		select ''Top 3 SCORING Customer CASH Attributes''  as a,''Variance'' as b ,''Current Period''  as c ,''Bottom 3 SCORING Customer CASH Attributes'' as d,''Variance'' as e,''Current Period'' as f,cast(1 as int) as g
		union all
		select a.Label, a.Variance  , a.currentPeriod ,b.Label, b.Variance , b.currentPeriod  ,1 as g
		from temp1 a  inner join temp1 b  on a.num1=b.num2 and a.num1<=3
	    union all
		select ''Top 3 TRENDING Customer CASH Attributes'',''Variance'',''Current Period'',''Bottom 3 TRENDING Customer CASH Attributes'',''Variance'',''Current Period'',2 as g
		union all
		select a.Label, a.Variance , a.currentPeriod  ,b.Label, b.Variance , b.currentPeriod  ,2 as g
		from temp1 a  inner join temp1 b  on a.num11=b.num22     and a.num11<=3

		union all 
		select *,null e ,null f,3 as g from h

		union all
		select cast(g as varchar),cast(r as varchar),cast(d as varchar),cast(s as varchar),null e ,null f,4 as g from r

		union all 
		select *,null f,5 as g from c

		 )  t  ;

		 select a  [OVERALL SATISFACTION],b [RETURN TO SHOP],c  [RECOMMEND],d [PREFER FD FOR QUICK TRIPS]  from #final  where g=3  ;
		 select a as  G,b as R,c as D ,d as  S   from #final  where g=4  ;
		 select  a as [CLEANLINESS],b as  [ASSORTMENT],c as  [SERVICE],d as [HIGH SPEED],e as [CASH]     from #final  where g=5  ;

		 '	+case when @store is not null then  'select  ''N/A''  [Goal]' 
			       else ' select isnull( convert(varchar(20), cast( 100*b.[CASH Survey]  as decimal(18,0) ) ),''N/A'')  as [Goal]
			from  [Goals] b(nolock) where '+coalesce(case when @store is not null then '1=0' end,
											'    b.ID='+cast(@district as nvarchar)+'  and  b.[Goal Level]=''District''',
											'    b.ID='+cast(@region as nvarchar)+'  and  b.[Goal Level]=''Region''',
											 '   b.ID='+cast(@group as nvarchar)+' and  b.[Goal Level]=''Group''', 
											 '   b.ID<=-1 and  b.[Goal Level]=''Overall''') 
			 end
      +'
	  select  a,b,c,d,e,f  from #final  where g=1  ;
	  select  a,b,c,d,e,f  from #final  where g=2  ;'         ;
 
	set @sql=@raw+@headlinesbar+char(10)+@rankingsbar+char(10)+@customer_cash_score+char(10)+@TopBotCustCASHAttr ;
   ----select @sql ;
     exec sp_executesql @sql,N'  @YEAR_NEW int,   @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
   	 
	set nocount off ;

 end

   
GO
/****** Object:  StoredProcedure [dbo].[p_get_DashBoard_20150403BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_DashBoard] 3,10,'  ',10,14,130,43
  [dbo].[p_get_DashBoard_test] 3,9,'  ',-1,-1,-1,-1
  exec  [dbo].[p_get_DashBoard_test] 3,10,'  ',10,14,130,-1
  exec    [dbo].[p_get_DashBoard] 3,10,'  ',10,14,427,721
  [dbo].[p_get_DashBoard_test] 3,9,'  ',10,14,-1,-1
    [dbo].[p_get_DashBoard_test1] 3,9,'  ',20,-1,-1,-1
[dbo].[p_get_DashBoard_test1] 3,9,'  ',30,18,345,5566
[dbo].[p_get_DashBoard_test1] 3,9,'  ',10,40,300,7898
   [dbo].[p_get_DashBoard_test] 2,7,'  ',10,14,130,-1
   [dbo].[p_get_DashBoard_test] 2,7,'  ',-1,-1,-1,-1
    ---[dbo].[p_get_DashBoard_test] 2,7,' and ( AGE_GROUP=1 or AGE_GROUP=2 or AGE_GROUP=3 or AGE_GROUP=4 or AGE_GROUP=5 ) and ( freq_shop=1 or freq_shop=2 or freq_shop=3 ) and ( Q63=1 or Q63=2 ) and ( Q64=1 or Q64=2 or Q64=3 or Q64=4 or Q64=5 ) and ( RACE_ETH=1 or RACE_ETH=2 or RACE_ETH=3 or RACE_ETH=4 ) and ( Q72_A11=1 or Q72_A10=1 or Q72_A09=1 or Q72_A08=1 or Q72_A07=1 or Q72_A06=1 or Q72_A05=1 or Q72_A04=1 or Q72_A03=1 or Q72_A02=1 or Q72_A01=1 ) and ( STOREFORMAT=1 or STOREFORMAT=2 or STOREFORMAT=3 or STOREFORMAT=4 or STOREFORMAT=5 ) and ( CLUSTER_UPDATED=1 or CLUSTER_UPDATED=2 or CLUSTER_UPDATED=3 or CLUSTER_UPDATED=4 or CLUSTER_UPDATED=5 ) ',10,-1,-1,-1

*/
create    proc [dbo].[p_get_DashBoard_20150403BAK] (
@YEAR_NEW int,
@QUARTER_NEW int,
@wherecondition nvarchar(max),
@group int ,
@region int ,
@district int ,
@store  int  
 )
 as 
 begin

   set nocount on ;

   declare @sql nvarchar(max) ='', 
		   @headlinesbar   nvarchar(max) ='',
		   @headlinesbar_1   nvarchar(max) ='',
		   @rankingsbar    nvarchar(max)='',
		   @customer_cash_score nvarchar(max)='' ,
		   @TopBotCustCASHAttr  nvarchar(max)='',
		   @TopBotSCORINGCustCASHAttr nvarchar(max)='',
		   @TopBotTRENDINGCustCASHAttr nvarchar(max)= '', 
		   @formhead nvarchar(max)='',
		   @formrank nvarchar(max)='',
		   @formcash nvarchar(max)='', 
		   @formcash_1 nvarchar(max)='', 
		   @formtbsco5 nvarchar(max)='',
		   @formtbtre nvarchar(max)='', 
		   @form nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @groupby nvarchar(max)='',
		   @grouping nvarchar(max)='',
		   @grouping_1 nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_sc nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @pos3 int,
		   @pos4 int;


			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;

			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	
 
---Raw Data with filter
	set @raw=concat(N'print @YEAR_NEW; print @QUARTER_NEW  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 ',@where_raw ,
							' and exists(select * from [dbo].[StoreFormat](nolock)  where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							'  )   ')+char(10)  ; 


	set @groupby= coalesce(case when @store is null  then null else ',[Group], Region, District, Store ' end,
		case when @district is null  then null else ',[Group], Region, District ' end,
		case when @region is null  then null else ',[Group], Region ' end,
		case when @group is null  then null else ',[Group]' end,
		''	) ;

	set @hierarchy	=coalesce( ' and Store='+cast(@store as nvarchar) ,
							 ' and District='+cast(@district as nvarchar) ,
							 ' and [Region]='+cast(@region as nvarchar) ,
							  ' and [Group]='+cast(@group as nvarchar) ,
					 ''
					 );

    set @grouping= coalesce( 
					   case when @store is null    then null else '( case when Grouping([Group])=1 then ''F''  when Grouping(Region)=1  then ''G''   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL  ' end 
					 , case when @district is null then null else '( case when Grouping([Group])=1 then ''F''  when Grouping(Region)=1  then ''G''  when Grouping(District)=1 then ''R''  else ''D''  end) as AL ' end
					 , case when @region is null   then null else '( case when Grouping([Group])=1 then ''F''  when Grouping(Region)=1  then ''G''  else ''R''   end) as AL ' end
					 , case when @group is null    then null else '( case when Grouping([Group])=1 then ''F''  else ''G'' end) as AL  ' end 
					 , '''F'' as AL') ;

	set @grouping_1=coalesce(case when @store is null then null else 'case  when AL=''G'' then [Group] when AL=''R'' then [Region]  when AL=''D'' then District When Al=''S'' then Store end as HI' end,
							 case when @district is null then null else 'case  when AL=''G'' then [Group] when AL=''R'' then [Region]  when AL=''D'' then District  end as HI' end,
							 case when @region is null then null else 'case  when AL=''G'' then [Group] when AL=''R'' then [Region]	 end as HI' end,
							 case when @group is null then null else 'case when AL=''G'' then [Group]  end as HI' end,
							   ' cast(null as int) as HI'
							  )
		     
----Headlines bar (shows for chain user type only) ,max_value_valid,min_value_valid

set @formhead=''	  
select @formhead=@formhead+', isnull( cast( cast(100*'+quotename(Variable)+' as decimal(18,0) ) as nvarchar)+''%'',''N/A'')  as' +quotename(Title) ,
	   @headlinesbar=@headlinesbar+', sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/ nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then  [weight]  end),0)  as '+quotename(Variable)  ,
	   @headlinesbar_1=@headlinesbar_1+', null  as '+quotename(Variable) 
from [dbo].[Headline_Variable] order by id;

set @formhead=stuff(@formhead,1,1,'') ;
set @headlinesbar=stuff(@headlinesbar,1,1,'') ;
set @headlinesbar_1=stuff(@headlinesbar_1,1,1,'') ;

set  @headlinesbar=',headline as ( 
			select '+isnull(stuff(nullif(@groupby,''),1,1,'')+',','')+char(10)+@headlinesbar+',1 as flag	
			from rawdata   where  QUARTER_NEW = @QUARTER_NEW   
			  '+@hierarchy+'
			  '+isnull(' group by  '+stuff(nullif(@groupby,''),1,1,''),'') +'
		    union all select '+isnull(stuff(Replace(nullif(@groupby,''),',',',cast(null as int) as '),1,1,'')+',','')+char(10)+@headlinesbar_1+',0 as flag
		) 
		,h  as (select     '+@formhead +'  from headline where flag=(select max(flag) from headline) )';
 
----------------------------------------------------------------------------------------------- 
-----Rankings bar	  
  set @rankingsbar='' ;			  
  set  @formrank  ='' ; 

      select @formrank=@formrank+','+quotename(L2)+'= case when '+f.cs+' then null else  ('+e.eq+')  end' from 
		(select distinct L2 from [dbo].[KPICalcs] where L2='CASH CALCULATION')  l outer apply
		(select eq=stuff((select   concat('+ isnull(',quotename(Variable),',0) *', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,1,'' )) e outer apply
		(select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,3,'' )) f ;

     set @formrank=stuff(@formrank,1,1,'') ;
  	 
	select @rankingsbar=@rankingsbar+',
					 ( sum(case when '+quotename(Variable)+' in('+a.TopNbox+')  then [weight] else 0.0 end)		 
					  /nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0)   ) as '+quotename(Variable) 
  from [KPICalcs] a     where a.L2='CASH CALCULATION' 

    set @rankingsbar=stuff(@rankingsbar,1,1,'')  ;

	set @rankingsbar=',rankings as (
				   select  '+isnull(stuff(nullif(@groupby,''),1,1,'')+',','')+char(10)+@grouping+',
							'+@rankingsbar+'
					from  rawdata    where 1=1   AND QUARTER_NEW = @QUARTER_NEW  
					  '  +isnull(' Group by rollup('+stuff(nullif(@groupby,''),1,1,'')+')','')+' )
			,r1 as (select  AL'+@groupby+','+@formrank+' 
					from rankings 
			)  
			,temprank as ( select  AL,'+@grouping_1+',rank() over(partition by AL order by [CASH CALCULATION] desc) as rnk
							 from r1 
			 )   
			,r as (  
			select  G,R,D,S 
			from (
			  select  AL,Rnk   from  temprank
		 	  where 1=1 '
					  + coalesce(  ' and (AL=''S'' and HI='+cast(@store as nvarchar)+'   ) '
								+isnull((select top 1 '
										or (AL=''D'' and  HI='+cast(district as nvarchar)+'  )
										or (AL=''R'' and HI='+cast(Region as nvarchar)+'   )
										or (AL=''G'' and HI='+cast([Group] as nvarchar)+' )'
										  from [dbo].[Hierarchy] where Store=@store  ),''), 
								   ' and (AL=''D'' and HI='+cast(@district as nvarchar)+') '
								+isnull((select top 1 '
										 or (AL=''R''  and HI='+cast(Region as nvarchar)+' ) 
										 or (AL=''G''  and HI='+cast([Group] as nvarchar)+'   )  '
										   from [dbo].[Hierarchy] where District=@district  ),''), 
								   ' and (AL=''R'' and [HI]='+cast(@region as nvarchar)+') '
								+isnull((select top 1 '
										 or (AL=''G''  and   [HI]='+cast([Group] as nvarchar)+'   )'
										  from [dbo].[Hierarchy] where Region=@region  ),'') , 
								   ' and (AL=''G'' and [HI]='+cast(@group as nvarchar)+') ',
								   '  ')
			+'	
			union all select  ''G'' AL,null as rnk
			union all select  ''R'' AL,null as rnk	
			union all select  ''D'' AL,null as rnk	
			union all select  ''S'' AL,null as rnk	
			) tab 
		     pivot( max(rnk) for AL in([G],[R],[D],[S]) ) p  
			 union all
			 select count(distinct [Group]) g ,count(distinct Region) r,count(distinct District) d,count(Distinct [Q2_1]) s from [dbo].[tb_RawData]   where  QUARTER_NEW = @QUARTER_NEW 
		)
			  ' ; 
--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula 
 
  	set @customer_cash_score='';

	set @formcash='';
	select @formcash=@formcash+','+quotename(L2)+'= case when '+f.cs+' then null else cast(100*('+e.eq+') as decimal(18,0) ) end ' ,
		   @formcash_1=@formcash_1+', cast(null as int) as '+quotename(L2) 
	from (select distinct L2 from [dbo].[KPICalcs])  l outer apply
		 (select eq=stuff((select   concat('+isnull(',quotename(Variable),',0) *', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,1,'' )) e outer apply
		 (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,3,'' )) f ;
  
	set @formcash=stuff(@formcash,1,1,'') ;
	set @formcash_1=stuff(@formcash_1,1,1,'') ;

  	select @customer_cash_score=@customer_cash_score+',
					  sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end)/nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end) ,0)  as '+quotename(Variable) 
	from (select distinct Variable,[TopNBox],[Mid3Box],[Bot2Box] from  [KPICalcs]) t;

    set @customer_cash_score=stuff(@customer_cash_score,1,1,'') ;
 
	set @customer_cash_score=',cashscore as ( 
				select   QUARTER_NEW   as [Qrt] '+@groupby+',
						'+@customer_cash_score+'
				from  rawdata 
				where   ([QUARTER_NEW] between  (@QUARTER_NEW-1  )   and  @QUARTER_NEW )  '+@hierarchy+'
				group by [QUARTER_NEW] '+@groupby+' 
			 ) '   +char(10) 
			 +'
			,ut as (  select   Qrt'+@groupby+','+@formcash+' ,1 as flag
			    
			  from cashscore
			  union all select @QUARTER_NEW as  Qrt'+replace(@groupby,',',', null as ')+','+@formcash_1+',0 as flag 
			  union all select @QUARTER_NEW-1 as  Qrt'+replace(@groupby,',',', null as ')+','+@formcash_1+',0 as flag 
			  )
			,tab as (   select c.* 
			     from ut  c inner join (select max(flag) f,qrt q from ut group by qrt) d on c.flag=d.f and c.qrt=d.q 	)
           ,c as (
			select  isnull(  convert(varchar(20),  [CLEANLINESS SCORE]  ),''N/A'')     [CLEANLINESS],
				    isnull(  convert(varchar(20),  [ASSORTMENT SCORE]  ),''N/A'')     [ASSORTMENT], 
				    isnull(  convert(varchar(20),  [SERVICE SCORE]  ),''N/A'')     [SERVICE],
				    isnull(  convert(varchar(20),  [HIGH SPEED SCORE]  ),''N/A'')    [HIGH SPEED],    
					isnull(  convert(varchar(20),  [CASH CALCULATION]  ),''N/A'')   [CASH]
			from tab  where qrt=  @QUARTER_NEW  
			union all
			select  isnull(  convert(varchar(20),  (a.[CLEANLINESS SCORE]- b.[CLEANLINESS SCORE] )   ),''N/A'')   [CLEANLINESS],
					isnull(  convert(varchar(20),  (a.[ASSORTMENT SCORE]- b.[ASSORTMENT SCORE] )   ) ,''N/A'')   [ASSORTMENT], 					   
					isnull(  convert(varchar(20),  (a. [SERVICE SCORE]- b.[SERVICE SCORE] )   )  ,''N/A'')       [SERVICE],
				    isnull(  convert(varchar(20),  (a.[HIGH SPEED SCORE]- b.[HIGH SPEED SCORE])  ) ,''N/A'')     [HIGH SPEED], 					   
					isnull(  convert(varchar(20),  (a.[CASH CALCULATION]- b.[CASH CALCULATION] )   ) ,''N/A'')   [CASH] 
			from (select * from tab where qrt=  @QUARTER_NEW ) a left join (select * from  tab where qrt=  (@QUARTER_NEW-1 ) )  b
			 on  1=1
			  )
			  '   ;
 
------------------------------------------------------------------
----------Top and Bottom SCORING Customer CASH Attributes	this is the top 3 and bottom 3 scoring varibales from the CASH variables listed below, based on the top 2 box aggregate
----------	Q7_GRID_01_Q7 	Q7_GRID_02_Q7 	Q7_GRID_03_Q7 	Q7_GRID_04_Q7 	Q7_GRID_05_Q7 	Q8_GRID_01_Q8 	Q8_GRID_02_Q8 	Q8_GRID_03_Q8 	Q8_GRID_04_Q8
----------	Q9_GRID_01_Q9 	Q12A			Q12C			 Q12D			 Q10_GRID_01_Q10
----------Top and Bottom TRENDING Customer CASH Attributes	Same as the table above, but ordered based on the top and bottom variances to the previous period (quarter).
 	set @TopBotCustCASHAttr ='' ; 
	select @formtbsco5=@formtbsco5+', '+quotename(Variable)  
	from (select distinct Variable from [dbo].[v_dashboard_scoring_trending_CASH_var]) t ;
	set @formtbsco5 =stuff(@formtbsco5,1,1,'') ;


	select @TopBotCustCASHAttr=@TopBotCustCASHAttr+', 
			sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end)/nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0) as '+quotename(Variable)
	 from [dbo].[v_dashboard_scoring_trending_CASH_var] ;
	
	set @TopBotCustCASHAttr=stuff(@TopBotCustCASHAttr,1,1,'') ;
	  
	set @TopBotCustCASHAttr=',topbot as (
	   select  [QUARTER_NEW]   as Period '+@groupby+', 
					'+@TopBotCustCASHAttr+'
		from rawdata   where  QUARTER_NEW>= (@QUARTER_NEW-1  )  and QUARTER_NEW<= @QUARTER_NEW  '+@hierarchy+'
		group by    [QUARTER_NEW]   '+@groupby +' 	) ' +char(10)
		 +',temp as ( 
		    select  '+isnull(nullif(stuff(@groupby,1,1,''),'')+',','') +' Variable,cast(100*['+cast(@QUARTER_NEW as nvarchar)+'] as decimal(18,0) ) cur,cast(100* ['+cast(@QUARTER_NEW-1 as nvarchar)+'] as  decimal(18,0)) as pre
		    from topbot 
		    unpivot(Value for Variable in('+@formtbsco5+') ) up
		    pivot(max(Value) for Period in(['+cast(@QUARTER_NEW as nvarchar)+'],['+cast(@QUARTER_NEW-1 as nvarchar)+'])) p 
	)
	,temp1 as (
		 select c.Label,isnull( cast([cur]-[pre]  as varchar),''N/A'')  as Variance,isnull(cast(cur as varchar)+''%'',''N/A'') as CurrentPeriod,
			    row_number() over(order by a.[cur] desc) num1,row_number() over(order by a.[cur] asc ) num2,
			    row_number() over(order by [cur]-[pre]  desc) num11,row_number() over(order by [cur]-[pre]  asc) num22
			 
		 from   temp  a	right join  [dbo].[v_dashboard_scoring_trending_CASH_var] c on c.Variable=a.Variable  
	)
 select * into #final 
	from  (
		select ''Top 3 SCORING Customer CASH Attributes''  as a,''Variance'' as b ,''Current Period''  as c ,''Bottom 3 SCORING Customer CASH Attributes'' as d,''Variance'' as e,''Current Period'' as f,cast(1 as int) as g
		union all
		select a.Label, a.Variance  , a.currentPeriod ,b.Label, b.Variance , b.currentPeriod  ,1 as g
		from temp1 a  inner join temp1 b  on a.num1=b.num2 and a.num1<=3
	    union all
		select ''Top 3 TRENDING Customer CASH Attributes'',''Variance'',''Current Period'',''Bottom 3 TRENDING Customer CASH Attributes'',''Variance'',''Current Period'',2 as g
		union all
		select a.Label, a.Variance , a.currentPeriod  ,b.Label, b.Variance , b.currentPeriod  ,2 as g
		from temp1 a  inner join temp1 b  on a.num11=b.num22     and a.num11<=3

		union all 
		select *,null e ,null f,3 as g from h

		union all
		select cast(g as varchar),cast(r as varchar),cast(d as varchar),cast(s as varchar),null e ,null f,4 as g from r

		union all 
		select *,null f,5 as g from c

		 )  t  ;

		 select a  [OVERALL SATISFACTION],b [RETURN TO SHOP],c  [RECOMMEND],d [PREFER FD FOR QUICK TRIPS]  from #final  where g=3  ;
		 select a as  G,b as R,c as D ,d as  S   from #final  where g=4  ;
		 select  a as [CLEANLINESS],b as  [ASSORTMENT],c as  [SERVICE],d as [HIGH SPEED],e as [CASH]     from #final  where g=5  ;

		 '	+case when @store is not null then  'select  ''N/A''  [Goal]' 
			       else ' select isnull( convert(varchar(20), cast( 100*b.[CASH Survey]  as decimal(18,0) ) ),''N/A'')  as [Goal]
			from  [Goals] b(nolock) where '+coalesce(case when @store is not null then '1=0' end,
											'    b.ID='+cast(@district as nvarchar)+'  and  b.[Goal Level]=''District''',
											'    b.ID='+cast(@region as nvarchar)+'  and  b.[Goal Level]=''Region''',
											 '   b.ID='+cast(@group as nvarchar)+' and  b.[Goal Level]=''Group''', 
											 '   b.ID<=-1 and  b.[Goal Level]=''Overall''') 
			 end
      +'
	  select  a,b,c,d,e,f  from #final  where g=1  ;
	  select  a,b,c,d,e,f  from #final  where g=2  ;'         ;
 
	set @sql=@raw+@headlinesbar+char(10)+@rankingsbar+char(10)+@customer_cash_score+char(10)+@TopBotCustCASHAttr ;
   ----select @sql ;
     exec sp_executesql @sql,N'  @YEAR_NEW int,   @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
   	 
	set nocount off ;

 end

   
GO
/****** Object:  StoredProcedure [dbo].[p_get_DashBoard_20150623BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_DashBoard] 3,10,'  ',10,14,130,43
  [dbo].[p_get_DashBoard_test] 3,10,'  ',-1,-1,-1,-1
  exec  [dbo].[p_get_DashBoard_test] 3,10,'  ',10,14,130,-1
  exec    [dbo].[p_get_DashBoard] 3,10,'  ',10,14,427,721
  [dbo].[p_get_DashBoard_test] 3,9,'  ',10,14,-1,-1

[dbo].[p_get_DashBoard_test] null,10,'  ',30,18,345,5566
   [dbo].[p_get_DashBoard_test] 3,10,'  ',10,40,300,7898
   [dbo].[p_get_DashBoard_test] 2,7,'  ',10,14,130,-1
   [dbo].[p_get_DashBoard_test] 2,7,'  ',-1,-1,-1,-1
    ---[dbo].[p_get_DashBoard_test] 2,7,' and ( AGE_GROUP=1 or AGE_GROUP=2 or AGE_GROUP=3 or AGE_GROUP=4 or AGE_GROUP=5 ) and ( freq_shop=1 or freq_shop=2 or freq_shop=3 ) and ( Q63=1 or Q63=2 ) and ( Q64=1 or Q64=2 or Q64=3 or Q64=4 or Q64=5 ) and ( RACE_ETH=1 or RACE_ETH=2 or RACE_ETH=3 or RACE_ETH=4 ) and ( Q72_A11=1 or Q72_A10=1 or Q72_A09=1 or Q72_A08=1 or Q72_A07=1 or Q72_A06=1 or Q72_A05=1 or Q72_A04=1 or Q72_A03=1 or Q72_A02=1 or Q72_A01=1 ) and ( STOREFORMAT=1 or STOREFORMAT=2 or STOREFORMAT=3 or STOREFORMAT=4 or STOREFORMAT=5 ) and ( CLUSTER_UPDATED=1 or CLUSTER_UPDATED=2 or CLUSTER_UPDATED=3 or CLUSTER_UPDATED=4 or CLUSTER_UPDATED=5 ) ',10,-1,-1,-1

	exec p_get_DashBoard 3,10,'',50,50,1,655,'','','','','','0,0,0,0,0,0,0,0,0,0,0','','',''


*/
CREATE    proc [dbo].[p_get_DashBoard_20150623BAK] (
@YEAR_NEW int,
@QUARTER_NEW int,
@wherecondition nvarchar(200),
@group int ,
@region int ,
@district int ,
@store  int   ,
@Age   nvarchar(100)='',
@Frequency_of_shopping  nvarchar(100)='',
@Gender  nvarchar(100)='',
@Income  nvarchar(100)='',
@Racial_background  nvarchar(100)='',
@Government_benefits  nvarchar(100)='',
@Store_Format  nvarchar(100)='',
@Store_Cluster  nvarchar(100)='',
@Shopper_Segment  nvarchar(100)=''
 )
 as 
 begin

   set nocount on ;

   declare @sql nvarchar(max) ='', 
		   @headlinesbar   nvarchar(max) ='',
		   @headlinesbar_1   nvarchar(max) ='',
		   @rankingsbar    nvarchar(max)='',
		   @customer_cash_score nvarchar(max)='' ,
		   @TopBotCustCASHAttr  nvarchar(max)='',
		   @TopBotSCORINGCustCASHAttr nvarchar(max)='',
		   @TopBotTRENDINGCustCASHAttr nvarchar(max)= '', 
		   @formhead nvarchar(max)='',
		   @formrank nvarchar(max)='',
		   @formcash nvarchar(max)='', 
		   @formcash_1 nvarchar(max)='', 
		   @formtbsco5 nvarchar(max)='',
		   @formtbtre nvarchar(max)='', 
		   @form nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @groupby nvarchar(max)='',
		   @grouping nvarchar(max)='',
		   @grouping_1 nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_sc nvarchar(max),
		   @where_raw nvarchar(max),
		   @where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @pos3 int,
		   @pos4 int;


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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;

	 

		---Raw Data with filter
			set @raw=concat(N';with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 '+char(10),@where_raw ,
									' and exists(select * from [dbo].[StoreFormat](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sf+') ',
									' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sc+')  ',
									'  )   ')+char(10)  ; 


			set @groupby= coalesce(case when @store is null  then null else ',[Group], Region, District, Store ' end,
				case when @district is null  then null else ',[Group], Region, District ' end,
				case when @region is null  then null else ',[Group], Region ' end,
				case when @group is null  then null else ',[Group]' end,
				''	) ;

			set @hierarchy	=coalesce( ' and Store='+cast(@store as nvarchar) ,
									 ' and District='+cast(@district as nvarchar) ,
									 ' and [Region]='+cast(@region as nvarchar) ,
									  ' and [Group]='+cast(@group as nvarchar) ,
							 ''
							 );

		set @grouping= coalesce( 
						   case when @store is null    then null else '( case when Grouping([Group])=1 then ''F''  when Grouping(Region)=1  then ''G''   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL  ' end 
						 , case when @district is null then null else '( case when Grouping([Group])=1 then ''F''  when Grouping(Region)=1  then ''G''  when Grouping(District)=1 then ''R''  else ''D''  end) as AL ' end
						 , case when @region is null   then null else '( case when Grouping([Group])=1 then ''F''  when Grouping(Region)=1  then ''G''  else ''R''   end) as AL ' end
						 , case when @group is null    then null else '( case when Grouping([Group])=1 then ''F''  else ''G'' end) as AL  ' end 
						 , '''F'' as AL') ;

		set @grouping_1=coalesce(case when @store is null then null else 'case  when AL=''G'' then [Group] when AL=''R'' then [Region]  when AL=''D'' then District When Al=''S'' then Store end as HI' end,
								 case when @district is null then null else 'case  when AL=''G'' then [Group] when AL=''R'' then [Region]  when AL=''D'' then District  end as HI' end,
								 case when @region is null then null else 'case  when AL=''G'' then [Group] when AL=''R'' then [Region]	 end as HI' end,
								 case when @group is null then null else 'case when AL=''G'' then [Group]  end as HI' end,
								   ' cast(null as int) as HI'
								  )
		     
----Headlines bar (shows for chain user type only) ,max_value_valid,min_value_valid

set @formhead=''	  
select @formhead=@formhead+', isnull( cast( cast(100*'+quotename(Variable)+' as decimal(18,0) ) as nvarchar)+''%'',''N/A'')  as' +quotename(Title) ,
	   @headlinesbar=@headlinesbar+', sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/ nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then  [weight]  end),0)  as '+quotename(Variable)  ,
	   @headlinesbar_1=@headlinesbar_1+', null  as '+quotename(Variable) 
from [dbo].[Headline_Variable] order by Position;

set @formhead=stuff(@formhead,1,1,'') ;
set @headlinesbar=stuff(@headlinesbar,1,1,'') ;
set @headlinesbar_1=stuff(@headlinesbar_1,1,1,'') ;

set  @headlinesbar=',headline as ( 
			select '+isnull(stuff(nullif(@groupby,''),1,1,'')+',','')+char(10)+@headlinesbar+',1 as flag	
			from rawdata   where  QUARTER_NEW = @QUARTER_NEW   
			  '+@hierarchy+'
			  '+isnull(' group by  '+stuff(nullif(@groupby,''),1,1,''),'') +'
		    union all select '+isnull(stuff(Replace(nullif(@groupby,''),',',',cast(null as int) as '),1,1,'')+',','')+char(10)+@headlinesbar_1+',0 as flag
		) 
		,h  as (select     '+@formhead +'  from headline where flag=(select max(flag) from headline) )';
 
----------------------------------------------------------------------------------------------- 
-----Rankings bar	  
  set @rankingsbar='' ;			  
  set  @formrank  ='' ; 

      select @formrank=@formrank+','+quotename(L2)+'= case when '+f.cs+' then null else  ('+e.eq+')  end' from 
		(select distinct L2 from [dbo].[KPICalcs] where L2='CASH CALCULATION')  l outer apply
		(select eq=stuff((select   concat('+ isnull(',quotename(Variable),',0) *', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,1,'' )) e outer apply
		(select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,3,'' )) f ;

     set @formrank=stuff(@formrank,1,1,'') ;
  	 
	select @rankingsbar=@rankingsbar+',
					 ( sum(case when '+quotename(Variable)+' in('+a.TopNbox+')  then [weight] else 0.0 end)		 
					  /nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0)   ) as '+quotename(Variable) 
  from [KPICalcs] a     where a.L2='CASH CALCULATION' 

    set @rankingsbar=stuff(@rankingsbar,1,1,'')  ;

	set @rankingsbar=',rankings as (
				   select  '+isnull(stuff(nullif(@groupby,''),1,1,'')+',','')+char(10)+@grouping+',
							'+@rankingsbar+'
					from  rawdata    where 1=1   AND QUARTER_NEW = @QUARTER_NEW  and [District]>0 
					  '  +isnull(' Group by rollup('+stuff(nullif(@groupby,''),1,1,'')+')','')+' )
			,r1 as (select  AL'+@groupby+','+@formrank+' 
					from rankings 
			)  
			,temprank as ( select  AL,'+@grouping_1+',rank() over(partition by AL order by [CASH CALCULATION] desc) as rnk
							 from r1 
			 )   
			,r as (  
			select  G,R,D,S 
			from (
			  select  AL,Rnk   from  temprank
		 	  where 1=1 '
					  + coalesce(  ' and (AL=''S'' and HI='+cast(@store as nvarchar)+'   ) '
								+isnull((select top 1 '
										or (AL=''D'' and  HI='+cast(district as nvarchar)+'  )
										or (AL=''R'' and HI='+cast(Region as nvarchar)+'   )
										or (AL=''G'' and HI='+cast([Group] as nvarchar)+' )'
										  from [dbo].[Hierarchy] where Store=@store  ),''), 
								   ' and (AL=''D'' and HI='+cast(@district as nvarchar)+') '
								+isnull((select top 1 '
										 or (AL=''R''  and HI='+cast(Region as nvarchar)+' ) 
										 or (AL=''G''  and HI='+cast([Group] as nvarchar)+'   )  '
										   from [dbo].[Hierarchy] where District=@district  ),''), 
								   ' and (AL=''R'' and [HI]='+cast(@region as nvarchar)+') '
								+isnull((select top 1 '
										 or (AL=''G''  and   [HI]='+cast([Group] as nvarchar)+'   )'
										  from [dbo].[Hierarchy] where Region=@region  ),'') , 
								   ' and (AL=''G'' and [HI]='+cast(@group as nvarchar)+') ',
								   '  ')
			+'	
			union all select  ''G'' AL,null as rnk
			union all select  ''R'' AL,null as rnk	
			union all select  ''D'' AL,null as rnk	
			union all select  ''S'' AL,null as rnk	
			) tab 
		     pivot( max(rnk) for AL in([G],[R],[D],[S]) ) p  
			 union all
			 select count(distinct [Group]) g ,count(distinct Region) r,count(distinct District) d,count(Distinct [Q2_1]) s from rawdata  where  QUARTER_NEW = @QUARTER_NEW  and [District]>0
		)
			  ' ; 
--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula 
 
  	set @customer_cash_score='';

	set @formcash='';
	select @formcash=@formcash+','+quotename(L2)+'= case when '+f.cs+' then null else cast(100*('+e.eq+') as decimal(18,1) ) end ' ,
		   @formcash_1=@formcash_1+', cast(null as int) as '+quotename(L2) 
	from (select distinct L2 from [dbo].[KPICalcs])  l outer apply
		 (select eq=stuff((select   concat('+isnull(',quotename(Variable),',0) *', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,1,'' )) e outer apply
		 (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,3,'' )) f ;
  
	set @formcash=stuff(@formcash,1,1,'') ;
	set @formcash_1=stuff(@formcash_1,1,1,'') ;

  	select @customer_cash_score=@customer_cash_score+',
					  sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end)/nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end) ,0)  as '+quotename(Variable) 
	from (select distinct Variable,[TopNBox],[Mid3Box],[Bot2Box] from  [KPICalcs]) t;

    set @customer_cash_score=stuff(@customer_cash_score,1,1,'') ;
 
	set @customer_cash_score=',cashscore as ( 
				select   QUARTER_NEW   as [Qrt] '+@groupby+',
						'+@customer_cash_score+'
				from  rawdata 
				where   ([QUARTER_NEW] between  (@QUARTER_NEW-1  )   and  @QUARTER_NEW )  '+@hierarchy+'
				group by [QUARTER_NEW] '+@groupby+' 
			 ) '   +char(10) 
			 +'
			,ut as (  select   Qrt'+@groupby+','+@formcash+' ,1 as flag
			    
			  from cashscore
			  union all select @QUARTER_NEW as  Qrt'+replace(@groupby,',',', null as ')+','+@formcash_1+',0 as flag 
			  union all select @QUARTER_NEW-1 as  Qrt'+replace(@groupby,',',', null as ')+','+@formcash_1+',0 as flag 
			  )
			,tab as (   select c.* 
			     from ut  c inner join (select max(flag) f,qrt q from ut group by qrt) d on c.flag=d.f and c.qrt=d.q 	)
           ,c as (
			select  isnull(  convert(varchar(20),  [CLEANLINESS SCORE]  ),''N/A'')     [CLEANLINESS],
				    isnull(  convert(varchar(20),  [ASSORTMENT SCORE]  ),''N/A'')     [ASSORTMENT], 
				    isnull(  convert(varchar(20),  [SERVICE SCORE]  ),''N/A'')     [SERVICE],
				    isnull(  convert(varchar(20),  [HIGH SPEED SCORE]  ),''N/A'')    [HIGH SPEED],    
					isnull(  convert(varchar(20),  [CASH CALCULATION]  ),''N/A'')   [CASH]
			from tab  where qrt=  @QUARTER_NEW  
			union all
			select convert(varchar(20),  (a.[CLEANLINESS SCORE]- b.[CLEANLINESS SCORE] )   )    [CLEANLINESS],
				   convert(varchar(20),  (a.[ASSORTMENT SCORE]- b.[ASSORTMENT SCORE] )   )    [ASSORTMENT], 					   
				   convert(varchar(20),  (a. [SERVICE SCORE]- b.[SERVICE SCORE] )   )        [SERVICE],
				   convert(varchar(20),  (a.[HIGH SPEED SCORE]- b.[HIGH SPEED SCORE])  )      [HIGH SPEED], 					   
				   convert(varchar(20),  (a.[CASH CALCULATION]- b.[CASH CALCULATION] )   )    [CASH] 
			from (select * from tab where qrt=  @QUARTER_NEW ) a left join (select * from  tab where qrt=  (@QUARTER_NEW-1 ) )  b
			 on  1=1
			  )
			  '   ;
 
------------------------------------------------------------------
----------Top and Bottom SCORING Customer CASH Attributes	this is the top 3 and bottom 3 scoring varibales from the CASH variables listed below, based on the top 2 box aggregate
----------	Q7_GRID_01_Q7 	Q7_GRID_02_Q7 	Q7_GRID_03_Q7 	Q7_GRID_04_Q7 	Q7_GRID_05_Q7 	Q8_GRID_01_Q8 	Q8_GRID_02_Q8 	Q8_GRID_03_Q8 	Q8_GRID_04_Q8
----------	Q9_GRID_01_Q9 	Q12A			Q12C			 Q12D			 Q10_GRID_01_Q10
----------Top and Bottom TRENDING Customer CASH Attributes	Same as the table above, but ordered based on the top and bottom variances to the previous period (quarter).
 	set @TopBotCustCASHAttr ='' ; 
	select @formtbsco5=@formtbsco5+', '+quotename(Variable)  from  dbo.dashboard_TopNBot   ;
	set @formtbsco5 =stuff(@formtbsco5,1,1,'') ;


	select @TopBotCustCASHAttr=@TopBotCustCASHAttr+', 
			sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end)/nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0) as '+quotename(Variable)
	 from [dbo].[v_dashboard_scoring_trending_CASH_var] ;
	
	set @TopBotCustCASHAttr=stuff(@TopBotCustCASHAttr,1,1,'') ;
	  
	set @TopBotCustCASHAttr=',topbot as (
	   select  [QUARTER_NEW]   as Period '+@groupby+', 
					'+@TopBotCustCASHAttr+'
		from rawdata   where  QUARTER_NEW>= (@QUARTER_NEW-1  )  and QUARTER_NEW<= @QUARTER_NEW  '+@hierarchy+'
		group by    [QUARTER_NEW]   '+@groupby +' 	) ' +char(10)
		 +',temp as ( 
		    select  '+isnull(nullif(stuff(@groupby,1,1,''),'')+',','') +' Variable,cast(100*['+cast(@QUARTER_NEW as nvarchar)+'] as decimal(18,0) ) cur,cast(100* ['+cast(@QUARTER_NEW-1 as nvarchar)+'] as  decimal(18,0)) as pre
		    from topbot 
		    unpivot(Value for Variable in('+@formtbsco5+') ) up
		    pivot(max(Value) for Period in(['+cast(@QUARTER_NEW as nvarchar)+'],['+cast(@QUARTER_NEW-1 as nvarchar)+'])) p 
	)
	,temp1 as (
		 select c.Label,isnull( cast([cur]-[pre]  as varchar),''N/A'')  as Variance,isnull(cast(cur as varchar)+''%'',''N/A'') as CurrentPeriod,
			    row_number() over(order by a.[cur] desc) num1,row_number() over(order by a.[cur] asc ) num2,
			    row_number() over(order by [cur]-[pre]  desc) num11,row_number() over(order by [cur]-[pre]  asc) num22
			 
		 from   temp  a	right join  [dbo].[v_dashboard_scoring_trending_CASH_var] c on c.Variable=a.Variable  
	)
 select * into #final 
	from  (
		select ''Top 3 SCORING Customer CASH Attributes''  as a,''Diff vs. Last Qtr'' as b ,''Current Period''  as c ,''Bottom 3 SCORING Customer CASH Attributes'' as d,''Diff vs. Last Qtr'' as e,''Current Period'' as f,cast(1 as int) as g
		union all
		select a.Label, a.Variance  , a.currentPeriod ,b.Label, b.Variance , b.currentPeriod  ,1 as g
		from temp1 a  inner join temp1 b  on a.num1=b.num2 and a.num1<=3
	    union all
		select ''Top 3 TRENDING Customer CASH Attributes'',''Diff vs. Last Qtr'',''Current Period'',''Bottom 3 TRENDING Customer CASH Attributes'',''Diff vs. Last Qtr'',''Current Period'',2 as g
		union all
		select a.Label, a.Variance , a.currentPeriod  ,b.Label, b.Variance , b.currentPeriod  ,2 as g
		from temp1 a  inner join temp1 b  on a.num11=b.num22     and a.num11<=3

		union all 
		select *,null e ,null f,3 as g from h

		union all
		select cast(g as varchar),cast(r as varchar),cast(d as varchar),cast(s as varchar),null e ,null f,4 as g from r

		union all 
		select *,null f,5 as g from c

		 )  t  ;

		 select a  [OVERALL SATISFACTION],b [RETURN TO SHOP],c  [RECOMMEND],d [PREFER FD FOR QUICK TRIPS]  from #final  where g=3  ;
		 select a as  G,b as R,c as D ,d as  S   from #final  where g=4  ;
		 select  a as [CLEANLINESS],b as  [ASSORTMENT],c as  [SERVICE],d as [HIGH SPEED],e as [CASH]     from #final  where g=5  ;

		 '	+case when @store is not null then  'select  ''N/A''  [Goal]' 
			       else ' select isnull( convert(varchar(20), cast( 100*b.[CASH Survey]  as decimal(18,1) ) ),''N/A'')  as [Goal]
			from  [Goals] b(nolock) where '+coalesce(case when @store is not null then '1=0' end,
											'    b.ID='+cast(@district as nvarchar)+'  and  b.[Goal Level]=''District''',
											'    b.ID='+cast(@region as nvarchar)+'  and  b.[Goal Level]=''Region''',
											 '   b.ID='+cast(@group as nvarchar)+' and  b.[Goal Level]=''Group''', 
											 '   b.ID=-1 and  b.[Goal Level]=''Overall''') 
			 end
      +'
	  select  a,b,c,d,e,f  from #final  where g=1  ;
	  select  a,b,c,d,e,f  from #final  where g=2  ;'         ;
 
	set @sql=@raw+@headlinesbar+char(10)+@rankingsbar+char(10)+@customer_cash_score+char(10)+@TopBotCustCASHAttr ;
   ----select @sql ;
	--print left(@sql,4000)
	--print substring(@sql,4001,4000)
	--print substring(@sql,8001,4000)
	--print substring(@sql,12001,4000)
	--print substring(@sql,16001,4000)


	



     exec sp_executesql @sql,N'  @YEAR_NEW int,   @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
   	 
	set nocount off ;

 end

   

GO
/****** Object:  StoredProcedure [dbo].[p_get_DashBoard_test]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_DashBoard] 3,10,'  ',10,14,130,43
  [dbo].[p_get_DashBoard_test] 3,10,'  ',-1,-1,-1,-1
  exec  [dbo].[p_get_DashBoard_test] 3,10,'  ',10,14,130,-1
  exec    [dbo].[p_get_DashBoard] 3,10,'  ',10,14,427,721
  [dbo].[p_get_DashBoard_test] 3,9,'  ',10,14,-1,-1

[dbo].[p_get_DashBoard_test] null,10,'  ',30,18,345,5566
   [dbo].[p_get_DashBoard_test] 3,11,'  ',10,40,300,7898
   [dbo].[p_get_DashBoard_test] 2,7,'  ',10,14,130,-1
   [dbo].[p_get_DashBoard_test] 2,7,'  ',-1,-1,-1,-1
    ---[dbo].[p_get_DashBoard_test] 2,7,' and ( AGE_GROUP=1 or AGE_GROUP=2 or AGE_GROUP=3 or AGE_GROUP=4 or AGE_GROUP=5 ) and ( freq_shop=1 or freq_shop=2 or freq_shop=3 ) and ( Q63=1 or Q63=2 ) and ( Q64=1 or Q64=2 or Q64=3 or Q64=4 or Q64=5 ) and ( RACE_ETH=1 or RACE_ETH=2 or RACE_ETH=3 or RACE_ETH=4 ) and ( Q72_A11=1 or Q72_A10=1 or Q72_A09=1 or Q72_A08=1 or Q72_A07=1 or Q72_A06=1 or Q72_A05=1 or Q72_A04=1 or Q72_A03=1 or Q72_A02=1 or Q72_A01=1 ) and ( STOREFORMAT=1 or STOREFORMAT=2 or STOREFORMAT=3 or STOREFORMAT=4 or STOREFORMAT=5 ) and ( CLUSTER_UPDATED=1 or CLUSTER_UPDATED=2 or CLUSTER_UPDATED=3 or CLUSTER_UPDATED=4 or CLUSTER_UPDATED=5 ) ',10,-1,-1,-1

	exec p_get_DashBoard 3,10,'',50,50,1,655,'','','','','','0,0,0,0,0,0,0,0,0,0,0','','',''
	exec p_get_DashBoard_test 3,11,'',50,50,1,655,'','','','','','0,0,0,0,0,0,0,0,0,0,0','','',''

	 exec  [dbo].[p_get_DashBoard_test] 3,11,'  ',-1,-1,-1,-1
	  exec    [dbo].[p_get_DashBoard] 3,11,'  ',10,40,300,7898
*/
CREATE    proc [dbo].[p_get_DashBoard_test] (
@YEAR_NEW int,
@QUARTER_NEW int,
@wherecondition nvarchar(200),
@group int ,
@region int ,
@district int ,
@store  int   ,
@Age   nvarchar(100)='',
@Frequency_of_shopping  nvarchar(100)='',
@Gender  nvarchar(100)='',
@Income  nvarchar(100)='',
@Racial_background  nvarchar(100)='',
@Government_benefits  nvarchar(100)='',
@Store_Format  nvarchar(100)='',
@Store_Cluster  nvarchar(100)='',
@Shopper_Segment  nvarchar(100)=''
 )
 as 
 begin

   set nocount on ;

   declare @sql nvarchar(max) ='', 
		   @headlinesbar   nvarchar(max) ='',
		   @headlinesbar_1   nvarchar(max) ='',
		   @rankingsbar    nvarchar(max)='',
		   @customer_cash_score nvarchar(max)='' ,
		   @TopBotCustCASHAttr  nvarchar(max)='',
		   @TopBotSCORINGCustCASHAttr nvarchar(max)='',
		   @TopBotTRENDINGCustCASHAttr nvarchar(max)= '', 
		   @formhead nvarchar(max)='',
		   @formrank nvarchar(max)='',
		   @formcash nvarchar(max)='', 
		   @formcash_1 nvarchar(max)='', 
		   @formtbsco5 nvarchar(max)='',
		   @formtbtre nvarchar(max)='', 
		   @form nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @groupby nvarchar(max)='',
		   @grouping nvarchar(max)='',
		   @grouping_1 nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_sc nvarchar(max),
		   @where_raw nvarchar(max),
		   @where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @pos3 int,
		   @pos4 int;


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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;

	 

		---Raw Data with filter
			set @raw=concat(N';with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 '+char(10),@where_raw ,
									' and exists(select * from [dbo].[StoreFormat](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sf+') ',
									' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sc+')  ',
									'  )   ')+char(10)  ; 


			set @groupby= coalesce(case when @store is null  then null else ',[Group], Region, District, Store ' end,
				case when @district is null  then null else ',[Group], Region, District ' end,
				case when @region is null  then null else ',[Group], Region ' end,
				case when @group is null  then null else ',[Group]' end,
				''	) ;

			set @hierarchy	=coalesce( ' and Store='+cast(@store as nvarchar) ,
									 ' and District='+cast(@district as nvarchar) ,
									 ' and [Region]='+cast(@region as nvarchar) ,
									  ' and [Group]='+cast(@group as nvarchar) ,
							 ''
							 );

		set @grouping= coalesce( 
						   case when @store is null    then null else '( case when Grouping([Group])=1 then ''F''  when Grouping(Region)=1  then ''G''   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL  ' end 
						 , case when @district is null then null else '( case when Grouping([Group])=1 then ''F''  when Grouping(Region)=1  then ''G''  when Grouping(District)=1 then ''R''  else ''D''  end) as AL ' end
						 , case when @region is null   then null else '( case when Grouping([Group])=1 then ''F''  when Grouping(Region)=1  then ''G''  else ''R''   end) as AL ' end
						 , case when @group is null    then null else '( case when Grouping([Group])=1 then ''F''  else ''G'' end) as AL  ' end 
						 , '''F'' as AL') ;

		set @grouping_1=coalesce(case when @store is null then null else 'case  when AL=''G'' then [Group] when AL=''R'' then [Region]  when AL=''D'' then District When Al=''S'' then Store end as HI' end,
								 case when @district is null then null else 'case  when AL=''G'' then [Group] when AL=''R'' then [Region]  when AL=''D'' then District  end as HI' end,
								 case when @region is null then null else 'case  when AL=''G'' then [Group] when AL=''R'' then [Region]	 end as HI' end,
								 case when @group is null then null else 'case when AL=''G'' then [Group]  end as HI' end,
								   ' cast(null as int) as HI'
								  )
		     
----Headlines bar (shows for chain user type only) ,max_value_valid,min_value_valid

set @formhead=''	  
select @formhead=@formhead+', isnull( cast( cast(100*'+quotename(Variable)+' as decimal(18,0) ) as nvarchar)+''%'',''N/A'')  as' +quotename(Title) ,
	   @headlinesbar=@headlinesbar+', sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/ nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then  [weight]  end),0)  as '+quotename(Variable)  ,
	   @headlinesbar_1=@headlinesbar_1+', null  as '+quotename(Variable) 
from [dbo].[Headline_Variable] order by Position;

set @formhead=stuff(@formhead,1,1,'') ;
set @headlinesbar=stuff(@headlinesbar,1,1,'') ;
set @headlinesbar_1=stuff(@headlinesbar_1,1,1,'') ;

set  @headlinesbar=',headline as ( 
			select '+isnull(stuff(nullif(@groupby,''),1,1,'')+',','')+char(10)+@headlinesbar+',1 as flag	
			from rawdata   where  QUARTER_NEW = @QUARTER_NEW   
			  '+@hierarchy+'
			  '+isnull(' group by  '+stuff(nullif(@groupby,''),1,1,''),'') +'
		    union all select '+isnull(stuff(Replace(nullif(@groupby,''),',',',cast(null as int) as '),1,1,'')+',','')+char(10)+@headlinesbar_1+',0 as flag
		) 
		,h  as (select     '+@formhead +'  from headline where flag=(select max(flag) from headline) )';
 
----------------------------------------------------------------------------------------------- 
-----Rankings bar	  
  set @rankingsbar='' ;			  
  set  @formrank  ='' ; 

      select @formrank=@formrank+','+quotename(L2)+'= case when '+f.cs+' then null else  ('+e.eq+')  end' from 
		(select distinct L2 from [dbo].[KPICalcs] where L2='CASH CALCULATION')  l outer apply
		(select eq=stuff((select   concat('+ isnull(',quotename(Variable),',0) *', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,1,'' )) e outer apply
		(select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,3,'' )) f ;

     set @formrank=stuff(@formrank,1,1,'') ;
  	 
	select @rankingsbar=@rankingsbar+',
					 ( sum(case when '+quotename(Variable)+' in('+a.TopNbox+')  then [weight] else 0.0 end)		 
					  /nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0)   ) as '+quotename(Variable) 
  from [KPICalcs] a     where a.L2='CASH CALCULATION' 

    set @rankingsbar=stuff(@rankingsbar,1,1,'')  ;

	set @rankingsbar=',rankings as (
				   select  '+isnull(stuff(nullif(@groupby,''),1,1,'')+',','')+char(10)+@grouping+',
							'+@rankingsbar+'
					from  rawdata    where 1=1   AND QUARTER_NEW = @QUARTER_NEW  and [District]>0 
					  '  +isnull(' Group by rollup('+stuff(nullif(@groupby,''),1,1,'')+')','')+' )
			,r1 as (select  AL'+@groupby+','+@formrank+' 
					from rankings 
			)  
			,temprank as ( select  AL,'+@grouping_1+',rank() over(partition by AL order by [CASH CALCULATION] desc) as rnk
							 from r1 
			 )   
			,r as (  
			select  G,R,D,S 
			from (
			  select  AL,Rnk   from  temprank
		 	  where 1=1 '
					  + coalesce(  ' and (AL=''S'' and HI='+cast(@store as nvarchar)+'   ) '
								+isnull((select top 1 '
										or (AL=''D'' and  HI='+cast(district as nvarchar)+'  )
										or (AL=''R'' and HI='+cast(Region as nvarchar)+'   )
										or (AL=''G'' and HI='+cast([Group] as nvarchar)+' )'
										  from [dbo].[Hierarchy] where Store=@store  ),''), 
								   ' and (AL=''D'' and HI='+cast(@district as nvarchar)+') '
								+isnull((select top 1 '
										 or (AL=''R''  and HI='+cast(Region as nvarchar)+' ) 
										 or (AL=''G''  and HI='+cast([Group] as nvarchar)+'   )  '
										   from [dbo].[Hierarchy] where District=@district  ),''), 
								   ' and (AL=''R'' and [HI]='+cast(@region as nvarchar)+') '
								+isnull((select top 1 '
										 or (AL=''G''  and   [HI]='+cast([Group] as nvarchar)+'   )'
										  from [dbo].[Hierarchy] where Region=@region  ),'') , 
								   ' and (AL=''G'' and [HI]='+cast(@group as nvarchar)+') ',
								   '  ')
			+'	
			union all select  ''G'' AL,null as rnk
			union all select  ''R'' AL,null as rnk	
			union all select  ''D'' AL,null as rnk	
			union all select  ''S'' AL,null as rnk	
			) tab 
		     pivot( max(rnk) for AL in([G],[R],[D],[S]) ) p  
			 union all
			 select count(distinct [Group]) g ,count(distinct Region) r,count(distinct District) d,count(Distinct [Q2_1]) s from rawdata  where  QUARTER_NEW = @QUARTER_NEW  and [District]>0
		)
			  ' ; 
--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula 
 
  	set @customer_cash_score='';

	set @formcash='';
	select @formcash=@formcash+','+quotename(L2)+'= case when '+f.cs+' then null else 100*('+e.eq+')  end ' ,
		   @formcash_1=@formcash_1+', cast(null as int) as '+quotename(L2) 
	from (select distinct L2 from [dbo].[KPICalcs])  l outer apply
		 (select eq=stuff((select   concat('+isnull(',quotename(Variable),',0) *', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,1,'' )) e outer apply
		 (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,3,'' )) f ;
  
	set @formcash=stuff(@formcash,1,1,'') ;
	set @formcash_1=stuff(@formcash_1,1,1,'') ;

  	select @customer_cash_score=@customer_cash_score+',
					  sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end)/nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end) ,0)  as '+quotename(Variable) 
	from (select distinct Variable,[TopNBox],[Mid3Box],[Bot2Box] from  [KPICalcs]) t;

    set @customer_cash_score=stuff(@customer_cash_score,1,1,'') ;
 
	set @customer_cash_score=',cashscore as ( 
				select   QUARTER_NEW   as [Qrt] '+@groupby+',
						'+@customer_cash_score+'
				from  rawdata 
				where   ([QUARTER_NEW] between  (@QUARTER_NEW-1  )   and  @QUARTER_NEW )  '+@hierarchy+'
				group by [QUARTER_NEW] '+@groupby+' 
			 ) '   +char(10) 
			 +'
			,ut as (  select   Qrt'+@groupby+','+@formcash+' ,1 as flag
			    
			  from cashscore
			  union all select @QUARTER_NEW as  Qrt'+replace(@groupby,',',', null as ')+','+@formcash_1+',0 as flag 
			  union all select @QUARTER_NEW-1 as  Qrt'+replace(@groupby,',',', null as ')+','+@formcash_1+',0 as flag 
			  )
			,tab as (   select c.* 
			     from ut  c inner join (select max(flag) f,qrt q from ut group by qrt) d on c.flag=d.f and c.qrt=d.q 	)
           ,c as (
			select  isnull(  convert(varchar(20), cast( [CLEANLINESS SCORE] as decimal(18,1))  ),''N/A'')     [CLEANLINESS],
				    isnull(  convert(varchar(20), cast( [ASSORTMENT SCORE]  as decimal(18,1))  ),''N/A'')     [ASSORTMENT], 
				    isnull(  convert(varchar(20), cast( [SERVICE SCORE]  as decimal(18,1))  ),''N/A'')     [SERVICE],
				    isnull(  convert(varchar(20), cast( [HIGH SPEED SCORE]  as decimal(18,1))  ),''N/A'')    [HIGH SPEED],    
					isnull(  convert(varchar(20), cast( [CASH CALCULATION]  as decimal(18,1))  ),''N/A'')   [CASH]
			from tab  where qrt=  @QUARTER_NEW  
			union all
			select convert(varchar(20), cast( (a.[CLEANLINESS SCORE]- b.[CLEANLINESS SCORE] )  as decimal(18,0))    )    [CLEANLINESS],
				   convert(varchar(20), cast( (a.[ASSORTMENT SCORE]- b.[ASSORTMENT SCORE] )   as decimal(18,0))  )    [ASSORTMENT], 					   
				   convert(varchar(20), cast( (a. [SERVICE SCORE]- b.[SERVICE SCORE] )   as decimal(18,0))  )        [SERVICE],
				   convert(varchar(20), cast( (a.[HIGH SPEED SCORE]- b.[HIGH SPEED SCORE])  as decimal(18,0))  )      [HIGH SPEED], 					   
				   convert(varchar(20), cast( (a.[CASH CALCULATION]- b.[CASH CALCULATION] )  as decimal(18,0))    )    [CASH] 
			from (select * from tab where qrt=  @QUARTER_NEW ) a left join (select * from  tab where qrt=  (@QUARTER_NEW-1 ) )  b
			 on  1=1
			  )
			  '   ;
 
------------------------------------------------------------------
----------Top and Bottom SCORING Customer CASH Attributes	this is the top 3 and bottom 3 scoring varibales from the CASH variables listed below, based on the top 2 box aggregate
----------	Q7_GRID_01_Q7 	Q7_GRID_02_Q7 	Q7_GRID_03_Q7 	Q7_GRID_04_Q7 	Q7_GRID_05_Q7 	Q8_GRID_01_Q8 	Q8_GRID_02_Q8 	Q8_GRID_03_Q8 	Q8_GRID_04_Q8
----------	Q9_GRID_01_Q9 	Q12A			Q12C			 Q12D			 Q10_GRID_01_Q10
----------Top and Bottom TRENDING Customer CASH Attributes	Same as the table above, but ordered based on the top and bottom variances to the previous period (quarter).
 	set @TopBotCustCASHAttr ='' ; 
	select @formtbsco5=@formtbsco5+', '+quotename(Variable)  from  dbo.dashboard_TopNBot   ;
	set @formtbsco5 =stuff(@formtbsco5,1,1,'') ;


	select @TopBotCustCASHAttr=@TopBotCustCASHAttr+', 
			sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end)/nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0) as '+quotename(Variable)
	 from [dbo].[v_dashboard_scoring_trending_CASH_var] ;
	
	set @TopBotCustCASHAttr=stuff(@TopBotCustCASHAttr,1,1,'') ;
	  
	set @TopBotCustCASHAttr=',topbot as (
	   select  [QUARTER_NEW]   as Period '+@groupby+', 
					'+@TopBotCustCASHAttr+'
		from rawdata   where  QUARTER_NEW>= (@QUARTER_NEW-1  )  and QUARTER_NEW<= @QUARTER_NEW  '+@hierarchy+'
		group by    [QUARTER_NEW]   '+@groupby +' 	) ' +char(10)
		 +',temp as ( 
		    select  '+isnull(nullif(stuff(@groupby,1,1,''),'')+',','') +' Variable,100.0*['+cast(@QUARTER_NEW as nvarchar)+']  cur,100.0* ['+cast(@QUARTER_NEW-1 as nvarchar)+']  as pre
		    from topbot 
		    unpivot(Value for Variable in('+@formtbsco5+') ) up
		    pivot(max(Value) for Period in(['+cast(@QUARTER_NEW as nvarchar)+'],['+cast(@QUARTER_NEW-1 as nvarchar)+'])) p 
	)
	,temp1 as (
		 select c.Label,case when [cur]>[pre] then ''+'' else '''' end +coalesce(cast( cast([cur] -[pre] as decimal(18,0)) as varchar(30)),''N/A'')    as Variance,
				isnull(cast(cast(cur as decimal(18,0)) as varchar(30))+''%'',''N/A'') as CurrentPeriod,
			    row_number() over(order by case when [pre]>=0.0 then 0 else 1 end,a.[cur] desc) num1,
				row_number() over(order by case when [pre]>=0.0 then 0 else 1 end,a.[cur] asc ) num2,
			    row_number() over(order by case when [pre]>=0.0 then 0 else 1 end, [cur]-[pre]  desc) num11,
				row_number() over(order by case when [pre]>=0.0 then 0 else 1 end, [cur]-[pre]  asc) num22
			 
		 from   temp  a	right join  [dbo].[v_dashboard_scoring_trending_CASH_var] c on c.Variable=a.Variable  
	)
 select * into #final 
	from  (
		select ''Top 3 SCORING Customer CASH Attributes''  as a,''Diff vs. Last Qtr'' as b ,''Current Period''  as c ,''Bottom 3 SCORING Customer CASH Attributes'' as d,''Diff vs. Last Qtr'' as e,''Current Period'' as f,cast(1 as int) as g
		union all
		select top 3  a.Label, a.Variance  , a.currentPeriod ,b.Label, b.Variance , b.currentPeriod  ,1 as g
		from temp1 a  inner join temp1 b  on a.num1=b.num2  order by a.num1 ---and a.num1<=3
	    union all
		select ''Top 3 TRENDING Customer CASH Attributes'',''Diff vs. Last Qtr'',''Current Period'',''Bottom 3 TRENDING Customer CASH Attributes'',''Diff vs. Last Qtr'',''Current Period'',2 as g
		union all
		select top 3  a.Label, a.Variance , a.currentPeriod  ,b.Label, b.Variance , b.currentPeriod  ,2 as g
		from temp1 a  inner join temp1 b  on a.num11=b.num22  order by a.num11 ---   and a.num11<=3

		union all 
		select *,null e ,null f,3 as g from h

		union all
		select cast(g as varchar),cast(r as varchar),cast(d as varchar),cast(s as varchar),null e ,null f,4 as g from r

		union all 
		select *,null f,5 as g from c

		 )  t  ;

		 select a  [OVERALL SATISFACTION],b [RETURN TO SHOP],c  [RECOMMEND],d [PREFER FD FOR QUICK TRIPS]  from #final  where g=3  ;
		 select a as  G,b as R,c as D ,d as  S   from #final  where g=4  ;
		 select  a as [CLEANLINESS],b as  [ASSORTMENT],c as  [SERVICE],d as [HIGH SPEED],e as [CASH]     from #final  where g=5  ;

		 '	+case when @store is not null then  'select  ''N/A''  [Goal]' 
			       else ' select isnull( convert(varchar(20), cast( 100*b.[CASH Survey]  as decimal(18,1) ) ),''N/A'')  as [Goal]
			from  [Goals] b(nolock) where '+coalesce(case when @store is not null then '1=0' end,
											'    b.ID='+cast(@district as nvarchar)+'  and  b.[Goal Level]=''District''',
											'    b.ID='+cast(@region as nvarchar)+'  and  b.[Goal Level]=''Region''',
											 '   b.ID='+cast(@group as nvarchar)+' and  b.[Goal Level]=''Group''', 
											 '   b.ID=-1 and  b.[Goal Level]=''Overall''') 
			 end
      +'
	  select  a,b,c,d,e,f  from #final  where g=1  ;
	  select  a,b,c,d,e,f  from #final  where g=2  ;'         ;
 
	set @sql=@raw+@headlinesbar+char(10)+@rankingsbar+char(10)+@customer_cash_score+char(10)+@TopBotCustCASHAttr ;
   ----select @sql ;
	--print left(@sql,4000)
	--print substring(@sql,4001,4000)
	--print substring(@sql,8001,4000)
	--print substring(@sql,12001,4000)
	--print substring(@sql,16001,4000)



     exec sp_executesql @sql,N'  @YEAR_NEW int,   @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
   	 
	set nocount off ;

 end

   

GO
/****** Object:  StoredProcedure [dbo].[p_get_DashBoard_TrackedKPI]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
  ---author victor
 ---createdate 2015-01-27 
  [dbo].[p_get_DashBoard_TrackedKPI_rollingQrt] 3,9,'RETURN TO SHOP','',10,null,null,null
  [dbo].[p_get_DashBoard_TrackedKPI_rollingQrt] 3,10,'OVERALL SATISFACTION','',10,null,null,null
  [dbo].[p_get_DashBoard_TrackedKPI_rollingQrt] 3,9,'SERVICE','',30,-1,null,null
exec  [dbo].[p_get_DashBoard_TrackedKPI_rollingQrt] 3,9,'SERVICE','',null,null,null,null
exec  [dbo].[p_get_DashBoard_TrackedKPI] 3,9,'SERVICE','',null,null,null,null
 [dbo].[p_get_DashBoard_TrackedKPI_rollingQrt] 1,9,'SERVICE','',30,6,null,null
*/
CREATE      proc [dbo].[p_get_DashBoard_TrackedKPI] (
@YEAR_NEW  int,
@QUARTER_NEW int,
@kpi  nvarchar(60),
@wherecondition nvarchar(max),
@group int,
@region int ,
@district int,
@store  int ,
@Age   nvarchar(100)='',
@Frequency_of_shopping  nvarchar(100)='',
@Gender  nvarchar(100)='',
@Income  nvarchar(100)='',
@Racial_background  nvarchar(100)='',
@Government_benefits  nvarchar(100)='',
@Store_Format  nvarchar(100)='',
@Store_Cluster  nvarchar(100)='',
@Shopper_Segment  nvarchar(100)=''
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='',
		   @formhead_1 nvarchar(max)='',  
		   @formcash nvarchar(max)='', 
		   @formcash_1 nvarchar(max)='', 
		   @raw  nvarchar(max)='',
		   @groupby nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @idx int,
		   @outlist nvarchar(500)='',
		   @pivotin nvarchar(500)='';

			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;		

	set @groupby= coalesce(case when @store is null   then null else ',[Group], Region, District, Store ' end,
		case when @district is null   then null else ',[Group], Region, District ' end,
		case when @region is null  then null else ',[Group], Region ' end,
		case when @group is null   then null else ',[Group]' end,
		''	) ;

	set @hierarchy	=coalesce( ' and Store='+cast(@store as nvarchar) ,
							   ' and District='+cast(@district as nvarchar)  ,
								' and [Region]='+cast(@region as nvarchar)  ,
								 ' and [Group]='+cast(@group as nvarchar) ,
					 ''
					 );

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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;
 

	   set @outlist = stuff( (select ','+quotename( value  )+' as [FY'+left(stuff(value_label,1,4,''),6)+left(value_label,2)+']' 
							 from  [dbo].[Variable_Values] 
								where   Value >= (case when @QUARTER_NEW>=5 then @QUARTER_NEW-3 else 1  end) and value<=(case when @QUARTER_NEW>=5 then @QUARTER_NEW else 4  end) and Variable='QUARTER_NEW'
								  for xml path('')),1,1,'');

	    set @pivotin=(case when @QUARTER_NEW>=5 then concat(quotename(@QUARTER_NEW-3),',',quotename(@QUARTER_NEW-2),',',quotename(@QUARTER_NEW-1),',',quotename(@QUARTER_NEW)) else '[1],[2],[3],[4]' end) ;
---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 '+char(10),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,char(10)+'  )   ')+char(10)  ; 

	  if  exists(select * from [dbo].[Headline_Variable] where Title= @kpi)
	 begin    
				select @formhead=@formhead+', '+quotename(Variable)+'  as' +quotename(Title)  
				from [dbo].[Headline_Variable] where Title=@kpi ;
				set @formhead=stuff(@formhead,1,1,'') ;

				select @formhead_1=@formhead_1+', sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0) as '+quotename(Variable) 
				from [dbo].[Headline_Variable] where Title=@kpi;

				set @formhead_1=stuff(@formhead_1,1,1,'') ;

				set  @headlinesbar=',headline as ( 
							select    QUARTER_NEW   as [Qrt] '+@groupby+',
								 '+@formhead_1+'	
							from rawdata   where QUARTER_NEW >='+ concat(case when @QUARTER_NEW>=5 then @QUARTER_NEW-3 else 1 end,' and QUARTER_NEW<=',case when @QUARTER_NEW>=5 then @QUARTER_NEW else 4 end)+'  '+@hierarchy+'
							group by  QUARTER_NEW  '+@groupby+'
						)
						,tab as (select    qrt, '+@formhead +'   from headline )
							select   '  +@outlist+'  
							from ( select Qrt, cast(100*'+quotename(@kpi)+' as decimal(18,0) ) as '+quotename(@kpi)+'
									from  tab 
									union all select null qrt,null  '+quotename(@kpi)+'
							 ) t  pivot(max('+quotename(@kpi)+') for Qrt in('+@pivotin+')) p ;	 '
				set @sql=@raw+@headlinesbar ;
			--- select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int,@QUARTER_NEW int', @YEAR_NEW ,@QUARTER_NEW;
	 end 

-----------------------------------------------------------------------------------------------
 
	 else if  exists(select *  from [dbo].[KPICalcs] where kpi=@kpi) 
		 begin   				 
				select @formcash=@formcash+','+quotename(@kpi)+'= case when '+f.cs+' then null else ('+e.eq+') end ' 
				from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0) *', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
					 (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;
  
				set @formcash=stuff(@formcash,1,1,'') ;
	  
				select @formcash_1=@formcash_1+',
								  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end)			 
								  / nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')   then [weight] end),0)   ) as '+quotename(Variable) 
				from  [dbo].[KPICalcs] where kpi=@kpi    ; 

				set @formcash_1=stuff(@formcash_1,1,1,'') ;
 
				set @customer_cash_score=',cashscore as ( 	        
						select   QUARTER_NEW  as [Qrt]'+@groupby+', 
								'+@formcash_1+'
						from  rawdata where QUARTER_NEW >='+ concat(case when @QUARTER_NEW>=5 then @QUARTER_NEW-3 else 1 end,' and QUARTER_NEW<=',case when @QUARTER_NEW>=5 then @QUARTER_NEW else 4 end)+'    '+@hierarchy+'
						group by   QUARTER_NEW '+@groupby   +char(10) 
						 +')
						 , tab as (
							  select   Qrt,'+@formcash+' 	  from cashscore 
							  )			   
							select   '+@outlist+'
							from ( select Qrt, cast(100*'+quotename(@kpi)+' as decimal(18,0) )  '+quotename(@kpi)+'
									from tab  
										union all select null qrt,null  '+quotename(@kpi)+'
							 ) t  pivot(max('+quotename(@kpi)+') for Qrt in('+@pivotin+')) p ;    ';
					 
				set @sql=@raw+@customer_cash_score ;
			---- select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int,@QUARTER_NEW int', @YEAR_NEW ,@QUARTER_NEW;
	end 
	 
	set nocount off ;

 end

   

 

GO
/****** Object:  StoredProcedure [dbo].[p_get_DashBoard_TrackedKPI_20150301BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27 
  [dbo].[p_get_DashBoard_TrackedKPI_test] 3,9,'RETURN TO SHOP','',10,null,null,null
   [dbo].[p_get_DashBoard_TrackedKPI] 3,9,'OVERALL SATISFACTION',''
    [dbo].[p_get_DashBoard_TrackedKPI_test] 3,9,'SERVICE','',30,6,null,null
*/
create      proc [dbo].[p_get_DashBoard_TrackedKPI_20150301BAK] (
@YEAR_NEW  int,
@QUARTER_NEW int,
@kpi  nvarchar(60),
@wherecondition nvarchar(max),
@group int,
@region int ,
@district int,
@store  int 
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='', 
		   @form nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @groupby nvarchar(max)='',
		   @hierarchy nvarchar(max)='';

			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;		

	set @groupby= coalesce(case when @store is null   then null else ',[Group], Region, District, Store ' end,
		case when @district is null   then null else ',[Group], Region, District ' end,
		case when @region is null  then null else ',[Group], Region ' end,
		case when @group is null   then null else ',[Group]' end,
		''	) ;

	set @hierarchy	=coalesce(case when  @store  is null then null else ' and Store='+cast(@store as nvarchar) end,
			         case when  @district  is null then null else ' and District='+cast(@district as nvarchar) end ,
					 case when  @region  is null then null else ' and [Region]='+cast(@region as nvarchar) end,
					 case when  @group  is null then null else ' and [Group]='+cast(@group as nvarchar) end,
					 ''
					 );

 ---Raw Data with filter
	set @raw=concat(N'print @YEAR_NEW ; print  @QUARTER_NEW ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy]   where 1=1 ',@wherecondition+' )   ')+char(10)  ;
  

	 if exists(select top 1 idx from V_KPI where kpi=@kpi and idx=2)
	 begin 
				set @formhead=''	  
				select @formhead=@formhead+', '+quotename(Variable)+'  as' +quotename(Title)  
				from [dbo].[Headline_Variable] where Title=@kpi ;
				set @formhead=stuff(@formhead,1,1,'') ;

				select @headlinesbar=@headlinesbar+', sum(case when  '+quotename(Variable)+' in(6,7) then 1.0 end)/sum(case when  '+quotename(Variable)+' between 1 and 7 then 1.0  end) as '+quotename(Variable) 
				from [dbo].[Headline_Variable] where Title=@kpi;

				set @headlinesbar=stuff(@headlinesbar,1,1,'') ;

				set  @headlinesbar=',headline as ( 
							select  isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)  as [Qrt] '+@groupby+',
								 '+@headlinesbar+'	
							from rawdata   where YEAR_NEW= @YEAR_NEW  '+@hierarchy+'
							group by isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)'+@groupby+'
						) ' +char(10)
						 +',tab as (select    qrt, '+@formhead +'  
						   from headline )
							select   isnull([1],0)  as [Quarter 1], isnull([2],0) as [Quater 2], isnull([3],0) as [Quater 3], isnull([4],0) as [Quater 4] 
							from ( select Qrt, cast(100*'+quotename(@kpi)+' as int) as '+quotename(@kpi)+'
									from  tab  
							 ) t  pivot(max('+quotename(@kpi)+') for Qrt in([1],[2],[3],[4])) p ;
							 '
				set @sql=@raw+@headlinesbar ;
				--- select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int,   @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
	 end
-----------------------------------------------------------------------------------------------
 
	 if exists(select top 1 idx from V_KPI where kpi=@kpi and idx=1) 
		 begin 
  				set @customer_cash_score='';

				set @formcash='';
				select @formcash=@formcash+','+quotename(l.KPI)+'= ('+e.eq+')  ' 
				from 
					(select distinct L2,KPI from [dbo].[KPICalcs] where kpi=@kpi)  l outer apply
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0) *', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,1,'' )) e

				set @formcash=stuff(@formcash,1,1,'') ;
	  
				select @customer_cash_score=@customer_cash_score+',
								  ( sum(case when '+quotename(Variable)+' in('+stuff((select top 1 Right(Vl.Value,2*[TOP N BOX SCORE]) from [KPICalcs] k where k.Variable=vr.Variable ),1,1,'')+')  then 1.0 end)			 
								  /sum(case when '+quotename(Variable)+' in('+Value+')  then 1.0 end)   ) as '+quotename(Variable) 
				from ( select distinct Variable  from [dbo].[KPICalcs] where kpi=@kpi ) vr 	outer apply 
					 ( select Value=STUFF((select ','+cast(Value as varchar(10))  from  [dbo].[Variable_Values] val where Value<=7 and  val.Variable=vr.Variable   order by Value for xml path('')),1,1,'' )  	) Vl ;
 
				set @customer_cash_score=stuff(@customer_cash_score,1,1,'') ;
 
				set @customer_cash_score=',cashscore as ( 
	        
						select  isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)  as [Qrt]'+@groupby+', 
								'+@customer_cash_score+'
						from  rawdata where YEAR_NEW= @YEAR_NEW   '+@hierarchy+'
						group by isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)'+@groupby   +char(10) 
						 +')
						 , tab as (
							  select   Qrt,'+@formcash+' 
							  from cashscore 
							  )			   
							select  isnull([1],0)  as [Quarter 1], isnull([2],0) as [Quater 2], isnull([3],0) as [Quater 3], isnull([4],0) as [Quater 4] 
							from ( select Qrt, cast(100*'+quotename(@kpi)+' as int) '+quotename(@kpi)+'
									from tab  
							 ) t  pivot(max('+quotename(@kpi)+') for Qrt in([1],[2],[3],[4])) p ;
		 
			  
							 ';
					 
				set @sql=@raw+@customer_cash_score ;
			--- select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int,   @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
	end 
	 
	set nocount off ;

 end

   

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_DashBoard_TrackedKPI_20150306BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27 
  [dbo].[p_get_DashBoard_TrackedKPI_test] 3,9,'RETURN TO SHOP','',10,null,null,null
  [dbo].[p_get_DashBoard_TrackedKPI_test] 3,9,'OVERALL SATISFACTION','',10,null,null,null
  [dbo].[p_get_DashBoard_TrackedKPI_test] 3,9,'SERVICE','',30,6,null,null
 [dbo].[p_get_DashBoard_TrackedKPI_test] 2,9,'SERVICE','',30,6,null,null
 [dbo].[p_get_DashBoard_TrackedKPI_test] 1,9,'SERVICE','',30,6,null,null
*/
Create      proc [dbo].[p_get_DashBoard_TrackedKPI_20150306BAK] (
@YEAR_NEW  int,
@QUARTER_NEW int,
@kpi  nvarchar(60),
@wherecondition nvarchar(max),
@group int,
@region int ,
@district int,
@store  int 
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='',
		   @formhead_1 nvarchar(max)='',  
		   @formcash nvarchar(max)='', 
		   @formcash_1 nvarchar(max)='', 
		   @raw  nvarchar(max)='',
		   @groupby nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int;

			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;		

	set @groupby= coalesce(case when @store is null   then null else ',[Group], Region, District, Store ' end,
		case when @district is null   then null else ',[Group], Region, District ' end,
		case when @region is null  then null else ',[Group], Region ' end,
		case when @group is null   then null else ',[Group]' end,
		''	) ;

	set @hierarchy	=coalesce(case when  @store  is null then null else ' and Store='+cast(@store as nvarchar) end,
			         case when  @district  is null then null else ' and District='+cast(@district as nvarchar) end ,
					 case when  @region  is null then null else ' and [Region]='+cast(@region as nvarchar) end,
					 case when  @group  is null then null else ' and [Group]='+cast(@group as nvarchar) end,
					 ''
					 );

			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	
 
---Raw Data with filter
	set @raw=concat(N'print @YEAR_NEW; print @QUARTER_NEW  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 

	 if exists(select top 1 idx from V_KPI where kpi=@kpi and idx=2)
	 begin    
				select @formhead=@formhead+', '+quotename(Variable)+'  as' +quotename(Title)  
				from [dbo].[Headline_Variable] where Title=@kpi ;
				set @formhead=stuff(@formhead,1,1,'') ;

				select @formhead_1=@formhead_1+', sum(case when  '+quotename(Variable)+' in(6,7) then [weight] end)/nullif(sum(case when  '+quotename(Variable)+' between 1 and 7 then [weight] end),0) as '+quotename(Variable) 
				from [dbo].[Headline_Variable] where Title=@kpi;

				set @formhead_1=stuff(@formhead_1,1,1,'') ;

				set  @headlinesbar=',headline as ( 
							select  isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)  as [Qrt] '+@groupby+',
								 '+@formhead_1+'	
							from rawdata   where YEAR_NEW= @YEAR_NEW  '+@hierarchy+'
							group by isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)'+@groupby+'
						)
						,tab as (select    qrt, '+@formhead +'   from headline )
							select   isnull([1],0)  as [Quarter 1], isnull([2],0) as [Quater 2], isnull([3],0) as [Quater 3], isnull([4],0) as [Quater 4] 
							from ( select Qrt, cast(100*'+quotename(@kpi)+' as int) as '+quotename(@kpi)+'
									from  tab 
									union all select null qrt,null  '+quotename(@kpi)+'
							 ) t  pivot(max('+quotename(@kpi)+') for Qrt in([1],[2],[3],[4])) p ;	 '
				set @sql=@raw+@headlinesbar ;
				--- select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int,   @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
	 end
-----------------------------------------------------------------------------------------------
 
	 if exists(select top 1 idx from V_KPI where kpi=@kpi and idx=1) 
		 begin 
  				 
				select @formcash=@formcash+','+quotename(l.KPI)+'= ('+e.eq+')  ' 
				from 
					(select distinct L2,KPI from [dbo].[KPICalcs] where kpi=@kpi)  l outer apply
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0) *', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,1,'' )) e

				set @formcash=stuff(@formcash,1,1,'') ;
	  
				select @formcash_1=@formcash_1+',
								  ( sum(case when '+quotename(Variable)+' in('+stuff((select top 1 Right(Vl.Value,2*[TOP N BOX SCORE]) from [KPICalcs] k where k.Variable=vr.Variable ),1,1,'')+')  then [weight] end)			 
								  / nullif(sum(case when '+quotename(Variable)+' in('+Value+')  then [weight] end),0)   ) as '+quotename(Variable) 
				from ( select distinct Variable  from [dbo].[KPICalcs] where kpi=@kpi ) vr 	outer apply 
					 ( select Value=STUFF((select ','+cast(Value as varchar(10))  from  [dbo].[Variable_Values] val where Value<=7 and  val.Variable=vr.Variable   order by Value for xml path('')),1,1,'' )  	) Vl ;
 
				set @formcash_1=stuff(@formcash_1,1,1,'') ;
 
				set @customer_cash_score=',cashscore as ( 	        
						select  isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)  as [Qrt]'+@groupby+', 
								'+@formcash_1+'
						from  rawdata where YEAR_NEW= @YEAR_NEW   '+@hierarchy+'
						group by isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)'+@groupby   +char(10) 
						 +')
						 , tab as (
							  select   Qrt,'+@formcash+' 	  from cashscore 
							  )			   
							select  isnull([1],0)  as [Quarter 1], isnull([2],0) as [Quater 2], isnull([3],0) as [Quater 3], isnull([4],0) as [Quater 4] 
							from ( select Qrt, cast(100*'+quotename(@kpi)+' as int)  '+quotename(@kpi)+'
									from tab  
										union all select null qrt,null  '+quotename(@kpi)+'
							 ) t  pivot(max('+quotename(@kpi)+') for Qrt in([1],[2],[3],[4])) p ;    ';
					 
				set @sql=@raw+@customer_cash_score ;
			--- select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int,   @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
	end 
	 
	set nocount off ;

 end

   

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_DashBoard_TrackedKPI_20150403BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27 
  [dbo].[p_get_DashBoard_TrackedKPI_test] 3,9,'RETURN TO SHOP','',10,null,null,null
  [dbo].[p_get_DashBoard_TrackedKPI_test] 3,9,'OVERALL SATISFACTION','',10,null,null,null
  [dbo].[p_get_DashBoard_TrackedKPI_test] 3,9,'SERVICE','',30,-1,null,null
exec  [dbo].[p_get_DashBoard_TrackedKPI] 3,9,'SERVICE','',null,null,null,null
exec  [dbo].[p_get_DashBoard_TrackedKPI_test] 3,9,'SERVICE','',null,null,null,null
 [dbo].[p_get_DashBoard_TrackedKPI_test] 1,9,'SERVICE','',30,6,null,null
*/
CREATE      proc [dbo].[p_get_DashBoard_TrackedKPI_20150403BAK] (
@YEAR_NEW  int,
@QUARTER_NEW int,
@kpi  nvarchar(60),
@wherecondition nvarchar(max),
@group int,
@region int ,
@district int,
@store  int 
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='',
		   @formhead_1 nvarchar(max)='',  
		   @formcash nvarchar(max)='', 
		   @formcash_1 nvarchar(max)='', 
		   @raw  nvarchar(max)='',
		   @groupby nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @idx int;

			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;		

	set @groupby= coalesce(case when @store is null   then null else ',[Group], Region, District, Store ' end,
		case when @district is null   then null else ',[Group], Region, District ' end,
		case when @region is null  then null else ',[Group], Region ' end,
		case when @group is null   then null else ',[Group]' end,
		''	) ;

	set @hierarchy	=coalesce( ' and Store='+cast(@store as nvarchar) ,
							   ' and District='+cast(@district as nvarchar)  ,
								' and [Region]='+cast(@region as nvarchar)  ,
								 ' and [Group]='+cast(@group as nvarchar) ,
					 ''
					 );

			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	
 
---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 

   select top 1 @idx= idx from V_KPI where kpi=@kpi ;
	 if  (   @idx=2)
	 begin    
				select @formhead=@formhead+', '+quotename(Variable)+'  as' +quotename(Title)  
				from [dbo].[Headline_Variable] where Title=@kpi ;
				set @formhead=stuff(@formhead,1,1,'') ;

				select @formhead_1=@formhead_1+', sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0) as '+quotename(Variable) 
				from [dbo].[Headline_Variable] where Title=@kpi;

				set @formhead_1=stuff(@formhead_1,1,1,'') ;

				set  @headlinesbar=',headline as ( 
							select  isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)  as [Qrt] '+@groupby+',
								 '+@formhead_1+'	
							from rawdata   where YEAR_NEW= @YEAR_NEW  '+@hierarchy+'
							group by isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)'+@groupby+'
						)
						,tab as (select    qrt, '+@formhead +'   from headline )
							select   [1]  as [Quarter 1], [2] as [Quater 2], [3] as [Quater 3], [4] as [Quater 4] 
							from ( select Qrt, cast(100*'+quotename(@kpi)+' as decimal(18,0) ) as '+quotename(@kpi)+'
									from  tab 
									union all select null qrt,null  '+quotename(@kpi)+'
							 ) t  pivot(max('+quotename(@kpi)+') for Qrt in([1],[2],[3],[4])) p ;	 '
				set @sql=@raw+@headlinesbar ;
				--- select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int', @YEAR_NEW ;
	 end
	---isnull([1],0)  as [Quarter 1], isnull([2],0) as [Quater 2], isnull([3],0) as [Quater 3], isnull([4],0) as [Quater 4]  
-----------------------------------------------------------------------------------------------
 
	else if  (@idx=1) 
		 begin   				 
				select @formcash=@formcash+','+quotename(@kpi)+'= case when '+f.cs+' then null else ('+e.eq+') end ' 
				from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0) *', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
					 (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;
  
				set @formcash=stuff(@formcash,1,1,'') ;
	  
				select @formcash_1=@formcash_1+',
								  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end)			 
								  / nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')   then [weight] end),0)   ) as '+quotename(Variable) 
				from  [dbo].[KPICalcs] where kpi=@kpi    ; 

				set @formcash_1=stuff(@formcash_1,1,1,'') ;
 
				set @customer_cash_score=',cashscore as ( 	        
						select  isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)  as [Qrt]'+@groupby+', 
								'+@formcash_1+'
						from  rawdata where YEAR_NEW= @YEAR_NEW   '+@hierarchy+'
						group by isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)'+@groupby   +char(10) 
						 +')
						 , tab as (
							  select   Qrt,'+@formcash+' 	  from cashscore 
							  )			   
							select   [1]  as [Quarter 1], [2] as [Quater 2], [3] as [Quater 3], [4] as [Quater 4] 
							from ( select Qrt, cast(100*'+quotename(@kpi)+' as decimal(18,0) )  '+quotename(@kpi)+'
									from tab  
										union all select null qrt,null  '+quotename(@kpi)+'
							 ) t  pivot(max('+quotename(@kpi)+') for Qrt in([1],[2],[3],[4])) p ;    ';
					 
				set @sql=@raw+@customer_cash_score ;
			---- select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int', @YEAR_NEW ;
	end 
	 
	set nocount off ;

 end

   

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_DashBoard_TrackedKPI_20150623BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
  ---author victor
 ---createdate 2015-01-27 
  [dbo].[p_get_DashBoard_TrackedKPI_rollingQrt] 3,9,'RETURN TO SHOP','',10,null,null,null
  [dbo].[p_get_DashBoard_TrackedKPI_rollingQrt] 3,10,'OVERALL SATISFACTION','',10,null,null,null
  [dbo].[p_get_DashBoard_TrackedKPI_rollingQrt] 3,9,'SERVICE','',30,-1,null,null
exec  [dbo].[p_get_DashBoard_TrackedKPI_rollingQrt] 3,9,'SERVICE','',null,null,null,null
exec  [dbo].[p_get_DashBoard_TrackedKPI] 3,9,'SERVICE','',null,null,null,null
 [dbo].[p_get_DashBoard_TrackedKPI_rollingQrt] 1,9,'SERVICE','',30,6,null,null
*/
CREATE      proc [dbo].[p_get_DashBoard_TrackedKPI_20150623BAK] (
@YEAR_NEW  int,
@QUARTER_NEW int,
@kpi  nvarchar(60),
@wherecondition nvarchar(max),
@group int,
@region int ,
@district int,
@store  int ,
@Age   nvarchar(100)='',
@Frequency_of_shopping  nvarchar(100)='',
@Gender  nvarchar(100)='',
@Income  nvarchar(100)='',
@Racial_background  nvarchar(100)='',
@Government_benefits  nvarchar(100)='',
@Store_Format  nvarchar(100)='',
@Store_Cluster  nvarchar(100)='',
@Shopper_Segment  nvarchar(100)=''
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='',
		   @formhead_1 nvarchar(max)='',  
		   @formcash nvarchar(max)='', 
		   @formcash_1 nvarchar(max)='', 
		   @raw  nvarchar(max)='',
		   @groupby nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @idx int,
		   @outlist nvarchar(500)='',
		   @pivotin nvarchar(500)='';

			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;		

	set @groupby= coalesce(case when @store is null   then null else ',[Group], Region, District, Store ' end,
		case when @district is null   then null else ',[Group], Region, District ' end,
		case when @region is null  then null else ',[Group], Region ' end,
		case when @group is null   then null else ',[Group]' end,
		''	) ;

	set @hierarchy	=coalesce( ' and Store='+cast(@store as nvarchar) ,
							   ' and District='+cast(@district as nvarchar)  ,
								' and [Region]='+cast(@region as nvarchar)  ,
								 ' and [Group]='+cast(@group as nvarchar) ,
					 ''
					 );

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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;
 

	   set @outlist = stuff( (select ','+quotename( value  )+' as [FY'+left(stuff(value_label,1,4,''),6)+left(value_label,2)+']' 
							 from  [dbo].[Variable_Values] 
								where   Value >= (case when @QUARTER_NEW>=5 then @QUARTER_NEW-3 else 1  end) and value<=(case when @QUARTER_NEW>=5 then @QUARTER_NEW else 4  end) and Variable='QUARTER_NEW'
								  for xml path('')),1,1,'');

	    set @pivotin=(case when @QUARTER_NEW>=5 then concat(quotename(@QUARTER_NEW-3),',',quotename(@QUARTER_NEW-2),',',quotename(@QUARTER_NEW-1),',',quotename(@QUARTER_NEW)) else '[1],[2],[3],[4]' end) ;
---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 '+char(10),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,char(10)+'  )   ')+char(10)  ; 

	  if  exists(select * from [dbo].[Headline_Variable] where Title= @kpi)
	 begin    
				select @formhead=@formhead+', '+quotename(Variable)+'  as' +quotename(Title)  
				from [dbo].[Headline_Variable] where Title=@kpi ;
				set @formhead=stuff(@formhead,1,1,'') ;

				select @formhead_1=@formhead_1+', sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0) as '+quotename(Variable) 
				from [dbo].[Headline_Variable] where Title=@kpi;

				set @formhead_1=stuff(@formhead_1,1,1,'') ;

				set  @headlinesbar=',headline as ( 
							select    QUARTER_NEW   as [Qrt] '+@groupby+',
								 '+@formhead_1+'	
							from rawdata   where QUARTER_NEW >='+ concat(case when @QUARTER_NEW>=5 then @QUARTER_NEW-3 else 1 end,' and QUARTER_NEW<=',case when @QUARTER_NEW>=5 then @QUARTER_NEW else 4 end)+'  '+@hierarchy+'
							group by  QUARTER_NEW  '+@groupby+'
						)
						,tab as (select    qrt, '+@formhead +'   from headline )
							select   '  +@outlist+'  
							from ( select Qrt, cast(100*'+quotename(@kpi)+' as decimal(18,0) ) as '+quotename(@kpi)+'
									from  tab 
									union all select null qrt,null  '+quotename(@kpi)+'
							 ) t  pivot(max('+quotename(@kpi)+') for Qrt in('+@pivotin+')) p ;	 '
				set @sql=@raw+@headlinesbar ;
			--- select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int,@QUARTER_NEW int', @YEAR_NEW ,@QUARTER_NEW;
	 end 

-----------------------------------------------------------------------------------------------
 
	 else if  exists(select *  from [dbo].[KPICalcs] where kpi=@kpi) 
		 begin   				 
				select @formcash=@formcash+','+quotename(@kpi)+'= case when '+f.cs+' then null else ('+e.eq+') end ' 
				from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0) *', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
					 (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;
  
				set @formcash=stuff(@formcash,1,1,'') ;
	  
				select @formcash_1=@formcash_1+',
								  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end)			 
								  / nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')   then [weight] end),0)   ) as '+quotename(Variable) 
				from  [dbo].[KPICalcs] where kpi=@kpi    ; 

				set @formcash_1=stuff(@formcash_1,1,1,'') ;
 
				set @customer_cash_score=',cashscore as ( 	        
						select   QUARTER_NEW  as [Qrt]'+@groupby+', 
								'+@formcash_1+'
						from  rawdata where QUARTER_NEW >='+ concat(case when @QUARTER_NEW>=5 then @QUARTER_NEW-3 else 1 end,' and QUARTER_NEW<=',case when @QUARTER_NEW>=5 then @QUARTER_NEW else 4 end)+'    '+@hierarchy+'
						group by   QUARTER_NEW '+@groupby   +char(10) 
						 +')
						 , tab as (
							  select   Qrt,'+@formcash+' 	  from cashscore 
							  )			   
							select   '+@outlist+'
							from ( select Qrt, cast(100*'+quotename(@kpi)+' as decimal(18,0) )  '+quotename(@kpi)+'
									from tab  
										union all select null qrt,null  '+quotename(@kpi)+'
							 ) t  pivot(max('+quotename(@kpi)+') for Qrt in('+@pivotin+')) p ;    ';
					 
				set @sql=@raw+@customer_cash_score ;
			---- select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int,@QUARTER_NEW int', @YEAR_NEW ,@QUARTER_NEW;
	end 
	 
	set nocount off ;

 end

   

 

GO
/****** Object:  StoredProcedure [dbo].[p_get_DashBoard_TrackedKPI_rollingQrt]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
  ---author victor
 ---createdate 2015-01-27 
  [dbo].[p_get_DashBoard_TrackedKPI_rollingQrt] 3,9,'RETURN TO SHOP','',10,null,null,null
  [dbo].[p_get_DashBoard_TrackedKPI_rollingQrt] 3,10,'OVERALL SATISFACTION','',10,null,null,null
  [dbo].[p_get_DashBoard_TrackedKPI_rollingQrt] 3,9,'SERVICE','',30,-1,null,null
exec  [dbo].[p_get_DashBoard_TrackedKPI_rollingQrt] 3,9,'SERVICE','',null,null,null,null
exec  [dbo].[p_get_DashBoard_TrackedKPI] 3,9,'SERVICE','',null,null,null,null
 [dbo].[p_get_DashBoard_TrackedKPI_rollingQrt] 1,9,'SERVICE','',30,6,null,null
*/
CREATE      proc [dbo].[p_get_DashBoard_TrackedKPI_rollingQrt] (
@YEAR_NEW  int,
@QUARTER_NEW int,
@kpi  nvarchar(60),
@wherecondition nvarchar(max),
@group int,
@region int ,
@district int,
@store  int 
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='',
		   @formhead_1 nvarchar(max)='',  
		   @formcash nvarchar(max)='', 
		   @formcash_1 nvarchar(max)='', 
		   @raw  nvarchar(max)='',
		   @groupby nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @idx int,
		   @outlist nvarchar(500)='',
		   @pivotin nvarchar(500)='';

			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;		

	set @groupby= coalesce(case when @store is null   then null else ',[Group], Region, District, Store ' end,
		case when @district is null   then null else ',[Group], Region, District ' end,
		case when @region is null  then null else ',[Group], Region ' end,
		case when @group is null   then null else ',[Group]' end,
		''	) ;

	set @hierarchy	=coalesce( ' and Store='+cast(@store as nvarchar) ,
							   ' and District='+cast(@district as nvarchar)  ,
								' and [Region]='+cast(@region as nvarchar)  ,
								 ' and [Group]='+cast(@group as nvarchar) ,
					 ''
					 );

			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	
 
	   set @outlist = stuff( (select ','+quotename( value  )+' as [FY'+left(stuff(value_label,1,4,''),6)+left(value_label,2)+']' 
							 from  [dbo].[Variable_Values] 
								where   Value >= (case when @QUARTER_NEW>=5 then @QUARTER_NEW-3 else 1  end) and value<=(case when @QUARTER_NEW>=5 then @QUARTER_NEW else 4  end) and Variable='QUARTER_NEW'
								  for xml path('')),1,1,'');

	    set @pivotin=(case when @QUARTER_NEW>=5 then concat(quotename(@QUARTER_NEW-3),',',quotename(@QUARTER_NEW-2),',',quotename(@QUARTER_NEW-1),',',quotename(@QUARTER_NEW)) else '[1],[2],[3],[4]' end) ;
---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 

   select top 1 @idx= idx from V_KPI where kpi=@kpi ;
	 if  (   @idx=2)
	 begin    
				select @formhead=@formhead+', '+quotename(Variable)+'  as' +quotename(Title)  
				from [dbo].[Headline_Variable] where Title=@kpi ;
				set @formhead=stuff(@formhead,1,1,'') ;

				select @formhead_1=@formhead_1+', sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0) as '+quotename(Variable) 
				from [dbo].[Headline_Variable] where Title=@kpi;

				set @formhead_1=stuff(@formhead_1,1,1,'') ;

				set  @headlinesbar=',headline as ( 
							select    QUARTER_NEW   as [Qrt] '+@groupby+',
								 '+@formhead_1+'	
							from rawdata   where QUARTER_NEW >='+ concat(case when @QUARTER_NEW>=5 then @QUARTER_NEW-3 else 1 end,' and QUARTER_NEW<=',case when @QUARTER_NEW>=5 then @QUARTER_NEW else 4 end)+'  '+@hierarchy+'
							group by  QUARTER_NEW  '+@groupby+'
						)
						,tab as (select    qrt, '+@formhead +'   from headline )
							select   '  +@outlist+'  
							from ( select Qrt, cast(100*'+quotename(@kpi)+' as decimal(18,0) ) as '+quotename(@kpi)+'
									from  tab 
									union all select null qrt,null  '+quotename(@kpi)+'
							 ) t  pivot(max('+quotename(@kpi)+') for Qrt in('+@pivotin+')) p ;	 '
				set @sql=@raw+@headlinesbar ;
			--- select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int,@QUARTER_NEW int', @YEAR_NEW ,@QUARTER_NEW;
	 end 

-----------------------------------------------------------------------------------------------
 
	else if  (@idx=1) 
		 begin   				 
				select @formcash=@formcash+','+quotename(@kpi)+'= case when '+f.cs+' then null else ('+e.eq+') end ' 
				from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0) *', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
					 (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;
  
				set @formcash=stuff(@formcash,1,1,'') ;
	  
				select @formcash_1=@formcash_1+',
								  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end)			 
								  / nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')   then [weight] end),0)   ) as '+quotename(Variable) 
				from  [dbo].[KPICalcs] where kpi=@kpi    ; 

				set @formcash_1=stuff(@formcash_1,1,1,'') ;
 
				set @customer_cash_score=',cashscore as ( 	        
						select   QUARTER_NEW  as [Qrt]'+@groupby+', 
								'+@formcash_1+'
						from  rawdata where QUARTER_NEW >='+ concat(case when @QUARTER_NEW>=5 then @QUARTER_NEW-3 else 1 end,' and QUARTER_NEW<=',case when @QUARTER_NEW>=5 then @QUARTER_NEW else 4 end)+'    '+@hierarchy+'
						group by   QUARTER_NEW '+@groupby   +char(10) 
						 +')
						 , tab as (
							  select   Qrt,'+@formcash+' 	  from cashscore 
							  )			   
							select   '+@outlist+'
							from ( select Qrt, cast(100*'+quotename(@kpi)+' as decimal(18,0) )  '+quotename(@kpi)+'
									from tab  
										union all select null qrt,null  '+quotename(@kpi)+'
							 ) t  pivot(max('+quotename(@kpi)+') for Qrt in('+@pivotin+')) p ;    ';
					 
				set @sql=@raw+@customer_cash_score ;
			---- select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int,@QUARTER_NEW int', @YEAR_NEW ,@QUARTER_NEW;
	end 
	 
	set nocount off ;

 end

   

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_DashBoard_TrackedKPI_test]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
  ---author victor
 ---createdate 2015-01-27 
  [dbo].[p_get_DashBoard_TrackedKPI] 3,9,'RETURN TO SHOP','',10,null,null,null
  [dbo].[p_get_DashBoard_TrackedKPI] 3,10,'OVERALL SATISFACTION','',10,null,null,null
  [dbo].[p_get_DashBoard_TrackedKPI] 3,9,'SERVICE','',30,-1,null,null
exec  [dbo].[p_get_DashBoard_TrackedKPI] 3,9,'SERVICE','',null,null,null,null
exec  [dbo].[p_get_DashBoard_TrackedKPI] 3,9,'SERVICE','',null,null,null,null
 [dbo].[p_get_DashBoard_TrackedKPI] 1,9,'SERVICE','',30,6,null,null
*/
CREATE      proc [dbo].[p_get_DashBoard_TrackedKPI_test] (
@YEAR_NEW  int,
@QUARTER_NEW int,
@kpi  nvarchar(60),
@wherecondition nvarchar(max),
@group int,
@region int ,
@district int,
@store  int 
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='',
		   @formhead_1 nvarchar(max)='',  
		   @formcash nvarchar(max)='', 
		   @formcash_1 nvarchar(max)='', 
		   @raw  nvarchar(max)='',
		   @groupby nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @idx int,
		   @outlist nvarchar(500)='',
		   @pivotin nvarchar(500)='';

			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;		

	set @groupby= coalesce(case when @store is null   then null else ',[Group], Region, District, Store ' end,
		case when @district is null   then null else ',[Group], Region, District ' end,
		case when @region is null  then null else ',[Group], Region ' end,
		case when @group is null   then null else ',[Group]' end,
		''	) ;

	set @hierarchy	=coalesce( ' and Store='+cast(@store as nvarchar) ,
							   ' and District='+cast(@district as nvarchar)  ,
								' and [Region]='+cast(@region as nvarchar)  ,
								 ' and [Group]='+cast(@group as nvarchar) ,
					 ''
					 );

			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	
 
	   set @outlist = stuff( (select ','+quotename( value  )+' as [FY'+left(stuff(value_label,1,4,''),6)+left(value_label,2)+']' 
							 from  [dbo].[Variable_Values] 
								where   Value >= (case when @QUARTER_NEW>=5 then @QUARTER_NEW-3 else 1  end) and value<=(case when @QUARTER_NEW>=5 then @QUARTER_NEW else 4  end) and Variable='QUARTER_NEW'
								  for xml path('')),1,1,'');

	    set @pivotin=(case when @QUARTER_NEW>=5 then concat(quotename(@QUARTER_NEW-3),',',quotename(@QUARTER_NEW-2),',',quotename(@QUARTER_NEW-1),',',quotename(@QUARTER_NEW)) else '[1],[2],[3],[4]' end) ;
---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 '+char(10),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,char(10)+'  )   ')+char(10)  ; 

	  if  exists(select * from [dbo].[Headline_Variable] where Title= @kpi)
	 begin    
				select @formhead=@formhead+', '+quotename(Variable)+'  as' +quotename(Title)  
				from [dbo].[Headline_Variable] where Title=@kpi ;
				set @formhead=stuff(@formhead,1,1,'') ;

				select @formhead_1=@formhead_1+', sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0) as '+quotename(Variable) 
				from [dbo].[Headline_Variable] where Title=@kpi;

				set @formhead_1=stuff(@formhead_1,1,1,'') ;

				set  @headlinesbar=',headline as ( 
							select    QUARTER_NEW   as [Qrt] '+@groupby+',
								 '+@formhead_1+'	
							from rawdata   where QUARTER_NEW >='+ concat(case when @QUARTER_NEW>=5 then @QUARTER_NEW-3 else 1 end,' and QUARTER_NEW<=',case when @QUARTER_NEW>=5 then @QUARTER_NEW else 4 end)+'  '+@hierarchy+'
							group by  QUARTER_NEW  '+@groupby+'
						)
						,tab as (select    qrt, '+@formhead +'   from headline )
							select   '  +@outlist+'  
							from ( select Qrt, cast(100*'+quotename(@kpi)+' as decimal(18,0) ) as '+quotename(@kpi)+'
									from  tab 
									union all select null qrt,null  '+quotename(@kpi)+'
							 ) t  pivot(max('+quotename(@kpi)+') for Qrt in('+@pivotin+')) p ;	 '
				set @sql=@raw+@headlinesbar ;
			--- select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int,@QUARTER_NEW int', @YEAR_NEW ,@QUARTER_NEW;
	 end 

-----------------------------------------------------------------------------------------------
 
	 else if  exists(select *  from [dbo].[KPICalcs] where kpi=@kpi) 
		 begin   				 
				select @formcash=@formcash+','+quotename(@kpi)+'= case when '+f.cs+' then null else ('+e.eq+') end ' 
				from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0) *', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
					 (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;
  
				set @formcash=stuff(@formcash,1,1,'') ;
	  
				select @formcash_1=@formcash_1+',
								  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end)			 
								  / nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')   then [weight] end),0)   ) as '+quotename(Variable) 
				from  [dbo].[KPICalcs] where kpi=@kpi    ; 

				set @formcash_1=stuff(@formcash_1,1,1,'') ;
 
				set @customer_cash_score=',cashscore as ( 	        
						select   QUARTER_NEW  as [Qrt]'+@groupby+', 
								'+@formcash_1+'
						from  rawdata where QUARTER_NEW >='+ concat(case when @QUARTER_NEW>=5 then @QUARTER_NEW-3 else 1 end,' and QUARTER_NEW<=',case when @QUARTER_NEW>=5 then @QUARTER_NEW else 4 end)+'    '+@hierarchy+'
						group by   QUARTER_NEW '+@groupby   +char(10) 
						 +')
						 , tab as (
							  select   Qrt,'+@formcash+' 	  from cashscore 
							  )			   
							select   '+@outlist+'
							from ( select Qrt, cast(100*'+quotename(@kpi)+' as decimal(18,0) )  '+quotename(@kpi)+'
									from tab  
										union all select null qrt,null  '+quotename(@kpi)+'
							 ) t  pivot(max('+quotename(@kpi)+') for Qrt in('+@pivotin+')) p ;    ';
					 
				set @sql=@raw+@customer_cash_score ;
			---- select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int,@QUARTER_NEW int', @YEAR_NEW ,@QUARTER_NEW;
	end 
	 
	set nocount off ;

 end

   

 
GO
/****** Object:  StoredProcedure [dbo].[p_Get_Hierarchy]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
 author victor zhang
 datetime :20150424
 function :  hierarchy
 exec p_Get_Hierarchy '[Group],[District]',' and [district]=20','[Group] desc'

*/
CREATE proc [dbo].[p_Get_Hierarchy]
(
  --@group int =-1 , 
  --@region int = -1,
  --@district int = -1 ,
  --@store  int=-1 ,
  @columnlist  nvarchar(200),
  @wherecondition nvarchar(4000) ='',
  @orderby   nvarchar(500)

)
as 
begin
set nocount on ;

	declare @sql nvarchar(max);

			--set @group= case when @group<=0 then null else @group end ;
			--set	@region=case when @region<=0 then null else @region end ;
			--set @district=case when @district<=0 then null else @district end;
			--set @store=case when @store<=0 then null else @store end  ;	

	set @sql='select distinct '+@columnlist+' 
			 from Hierarchy (nolock)
			where 1=1 '
			+ 
			------concat( ' AND [Group]='+ cast(@group  as nvarchar)
			------			        ,' AND [Region]='+cast(@region  as nvarchar)
			------					,' AND [District]='+cast(@district as nvarchar)
			------					,' AND [Store]='+cast(@store as nvarchar))
				  +char(10)+ @wherecondition
			      +  case when len(@orderby)>0 then  '   order by ' +@orderby else ' ' end

	execute sp_executesql @sql;

set nocount off ;
end

GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,410,5697
[dbo].[p_get_KpiBreakdown_test] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,-1,-1
[p_get_KpiBreakdown] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
[p_get_KpiBreakdown_test] 3,9,'Recommend','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown_test] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown_test] 3,9,'Customer CASH Score','',10 ,8 ,62 ,-1
exec [p_get_KpiBreakdown] 3,9,'Customer CASH Score','',10 ,8 ,62 ,-1

exec [dbo].[p_get_KpiBreakdown_test] 3,9,'SERVICE','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown] 3,9,'SERVICE','  ',10,40,300,6199
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
CREATE   procedure [dbo].[p_get_KpiBreakdown](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
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
@Shopper_Segment  nvarchar(100)=''
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
			@where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int, 
		   @c2  nvarchar(max),
		   @kpi_id int;
  
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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;

---Raw Data with filter
	set @raw=concat(N' ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where   1=1  '+char(10),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+char(10)+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sc+')  ',
							@where_raw ,char(10)+'  )   ')+char(10)  ; 

----------------------------------------------------------------------------------------------------------------------------------------
	if @store is not null 
	begin
		set @c2=  ', case when  Store='+cast(@store as nvarchar)+
								isnull((select top 1 '  
										or (Grouping([Group])+ Grouping(Region) + Grouping(District)+ Grouping([Store]) =0 and  District='+cast(District as nvarchar)+' )
										or ( Grouping([Group])+ Grouping(Region)  + Grouping(District)=0 and Grouping([Store]) =1 and [district]='+cast(District as nvarchar)+' )
										or (  Grouping([Group])+ Grouping(Region)=0 and Grouping(District)=1 and [Region]='+cast(Region as nvarchar)+' )
										or ( Grouping([Group])=0 and Grouping(Region)=1 and [Group]='+cast( [Group] as nvarchar)+'  ) 
											'   from  [dbo].[Hierarchy](nolock)   where  Store=@store),'')+' or  Grouping([Group])=1 then 1 else 0 end as flag' 
	 end
	 else if   @district is not null 
	 begin
		set @c2= 	', case when   district='+cast(@district as nvarchar)+
								isnull((select top 1 '
										or ( Grouping([Group])+ Grouping(Region)  + Grouping(District)=0 and Grouping([Store]) =1  and  Region='+cast(Region as nvarchar)+'  ) 
										or ( Grouping([Group])+ Grouping(Region)=0 and Grouping(District)=1 and Region='+cast(Region as nvarchar)+' )
										or (Grouping([Group])=0 and Grouping(Region)=1 and [Group]='+cast([Group] as nvarchar)+' ) 
												'  from  [dbo].[Hierarchy](nolock)   where District= @district ),'')+'  or  Grouping([Group])=1 then 1 else 0 end as flag'
	 end
	 else if  @region is not null 
	 begin
		set @c2= 	', case when  [Region]='+cast(@region as nvarchar)+
									 isnull((select top 1 '
										Or ( Grouping([Group])+ Grouping(Region)=0 and Grouping(District)=1 and  [Group]='+cast([Group] as nvarchar)+'  )
										or (Grouping([Group])=0 and Grouping(Region)=1 and [Group]='+cast([Group] as nvarchar)+' )'
										 from  [dbo].[Hierarchy](nolock)   where  [Region]=@region ),'')+'   or  Grouping([Group])=1 then 1 
						      else 0 end as flag ' 
	 end  
	 else if @group is not null
	 begin
		set @c2= ', case when Region<0 or [District]<0 or [Group]<0   then 0 
						 when   [Group]='+cast(@group as nvarchar)+' or Grouping(Region)=1  or  Grouping([Group])=1 then 1 
						 else 0 end as flag '
	 end
	 else
	 begin
		set @c2= ',case when [Group]<0 or Region<0 or [District]<0  then 0 else  1 end as flag  '
	 end ;
-----------------------------------------------------------------------------------------------------------------------------------------
	
 	set @kpi_id=( select top 1 KPI_ID  from v_KPI where kpi=@kpi	);

	  if  @kpi_id<0
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)
   
   		    select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
				,@ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
				 
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;

			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';

				select  @ps2=@ps2+ ','+quotename(Variable)+ ','+quotename(Variable+'!B')
						, @headlinesbar=@headlinesbar+', 100* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end),0) as '+quotename(Variable)
						+',  sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end)  as '+quotename(Variable+'!B')
				from [dbo].[Headline_Variable] (nolock)  where KPI_ID=abs(@kpi_id);

				 
				set @ps2=stuff(@ps2,1,1,'') ;
			
 
				 set @headlinesbar=stuff(@headlinesbar,1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select isnull(  cast(  [QUARTER_NEW] as nvarchar)  ,''YTD'') as TP,[Group],[Region],District,Store,
									--------( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
									--------	   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
							 '+ @headlinesbar +char(10)+@c2+'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW '+(select concat(' and ( [Quarter_NEW] between ', min(Qrt_ID),' and ',max(qrt_id),' )') from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW)+'
						group by   Grouping sets( YEAR_NEW,   [QUARTER_NEW]  ) , Rollup([Group],  Region, District, Store)
						) 
						select concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
							   '+@ps3+' 
						from (select  TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store s,value
								from  (select * from  headline t where flag=1)   ft		
								unpivot(Value for Variable in('+@ps2+')) up
						 )ut
								pivot( sum(Value) for TP in('+@ps1+')) p  
						order by  g,r,d,s
		
						' ;
					 set @sql=@raw+@headlinesbar ;
				------select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int ', @YEAR_NEW   ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	

 else if  @kpi_id>0
		 begin 
 
		   set @ps3='' ;
		   set @ps1='' ;

		   if @kpi='Customer CASH Score'
		   begin
 				select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
						, @ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,1)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
				from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
		    
				set @ps1=N'[YTD],[YTD!Base]'+@ps1;
				set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,1)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';
		   end
		   else
		   begin
 			select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
					, @ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
		    
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;
			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';
		  end

				set @formcash='';
				select @formcash=@formcash+','+quotename(@kpi)+'= case when '+f.cs+' then null else 100*('+e.eq+') end' from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs] kpi(nolock)  where  KPI_ID=@kpi_id  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi(nolock)  where  KPI_ID=@kpi_id  for xml path('')),1,3,'' )) f ;
   
				select @formcash=@formcash+','+quotename(@kpi+'!B')+'= case when '+f.cs+' then null else ('+e.eq+') end' from  
					(select eq=stuff((select  '+isnull(',quotename(Variable+'!B'),',0)  '  from [dbo].[KPICalcs] kpi(nolock)  where  KPI_ID=@kpi_id for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable+'!B'),'  is null  ')  from [dbo].[KPICalcs] kpi(nolock)  where  KPI_ID=@kpi_id  for xml path('')),1,3,'' )) f ;
    
				select @form=@form+',	  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end) /nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0)   ) as '+quotename(Variable) 
								+',	sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight]/[WCNT] end) as '+quotename(Variable+'!B') 
					  ,@form1=@form1+'+ (case when '+quotename(Variable) +'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then cast(1.0 as float) else cast(0.0 as float) end) '
				from   [dbo].[KPICalcs](nolock)  where KPI_ID=@kpi_id ;

				set @form=stuff(@form,1,1,'') ;
				  
				 set @form=replace(@form,'/[WCNT]','/('+stuff(@form1,1,1,'')+')' );
	
				set @customer_cash_score=', cashscore as ( 
							select isnull( cast(  [QUARTER_NEW] as nvarchar),''YTD'') as TP,b.[Group],b.[Region],b.District,b.Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
									when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
									'+@form+char(10)+@c2+'
							from  rawdata as b  where YEAR_NEW= @YEAR_NEW  '+(select concat(' and ( [Quarter_NEW] between ', min(Qrt_ID),' and ',max(qrt_id),' )') from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW)+' 
							group by   Grouping sets( YEAR_NEW, [QUARTER_NEW]   ) ,Rollup(b.[Group],b.[Region],b.District,b.Store) 
						 ) 
						, c1 as (
						 select AL, TP, [Group], [Region], District, Store'+@formcash+'
						 from   cashscore 	  t  where flag=1
						)
						select  concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
						   '+@ps3+','+case when @kpi='Customer CASH Score' then  ' cast( 
						         (case AL when ''F'' then  (select top 1 cs from [dbo].[Goals_Pivoted](nolock) where overall=-1 )
										when ''G'' then  (select  top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Group]=p.[g]) 
										when ''R'' then  (select  top 1   cs from [dbo].[Goals_Pivoted](nolock) where  [Region]=p.[r]) 
										when ''D'' then  (select   top 1 cs from [dbo].[Goals_Pivoted](nolock) where  [District]=p.[d])  
								end) as decimal(18,1) )' else ' null ' end 
								+' as [Goal] 
						from (
							select TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d ,Store s,value,AL
							from   c1
							 unpivot(Value for Variable in('+quotename(@kpi)+','+quotename(@kpi+'!B')+')) up
						 )ut
						  pivot( sum(Value) for TP in('+@ps1+')) p
							  
					order by  g,r,d,s
						'   ;
				 set @sql=@raw+@customer_cash_score ;
				 ---select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int ', @YEAR_NEW   ;
   end
     set nocount off ;
end

 

GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_20150301BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,410,5697
[dbo].[p_get_KpiBreakdown_test] 3,9,'SERVICE','',-1 ,-1 ,410 ,-1
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
create procedure [dbo].[p_get_KpiBreakdown_20150301BAK](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
@group int  , 
@region int  ,
@district int  ,
@store  int 
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='';
  
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	

---Raw Data with filter
	set @raw=concat(N'print @YEAR_NEW; print @QUARTER_NEW  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy]    where 1=1 ',@wherecondition,')   ')+char(10)  ; 
	 
	 if exists(select top 1 idx from V_KPI where kpi=@kpi and idx=2) 
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)

				set @formhead=''	  
				select @formhead=@formhead+', format(isnull('+quotename(Variable)+',0),''0%'') '   from [dbo].[Headline_Variable]  where title=@kpi ;

				set @ps1=N'[Quarter 1],[Quarter 2],[Quarter 3],[Quarter 4],[YTD]';

				select @ps2=stuff((select ','+quotename(Variable) from [dbo].[Headline_Variable] where title=@kpi  for xml path('')),1,1,'') ;

				set @ps3=N'cast([Quarter 1] as int) [Quarter 1],cast([Quarter 2] as int) [Quarter 2],cast([Quarter 3] as int) [Quarter 3],cast([Quarter 4] as int) [Quarter 4],cast([YTD] as int) [YTD]';

				set @headlinesbar=stuff((select ', 100* sum(case when  '+quotename(Variable)+' between 6 and 7 then 1 end)*1.0/nullif(sum(case when  '+quotename(Variable)+' between 1 and 7 then 1 else 0 end),0) as '+quotename(Variable)+char(10) from [dbo].[Headline_Variable] where title=@kpi  for xml path('')),1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  ) as TP,[Group],[Region],District,Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
										   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
							 '+ @headlinesbar +'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW 
						group by   concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  ) ,Rollup([Group],  Region, District, Store)
						) 
						,ytd as (
									select [Group],[Region],District,Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
										   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
									 '+ @headlinesbar +'	
								from rawdata   where DATE_NUM<convert(varchar(10),getdate()-1,112) and YEAR_NEW= @YEAR_NEW  
								group by    Rollup([Group],  Region, District, Store) 
						) 
						,tab as  (
						select * 
						from headline 			 
						union all
						select ''YTD'' TP,* 
						from ytd  
						) 
						select concat(''Group '',[Group]) [Group],concat(''Region '',[Region]) [Region],concat(''District '',[District]) [District],concat(''Store '',[Store]) [Store],
							   '+@ps3+' 
					    from (
						select * from tab t
										 where 		1=1	'  + 
						coalesce( ' and Store='+cast(@store as nvarchar)+'  
									or (AL=''S'' and exists(select * from [dbo].[Hierarchy] where Store=t.Store and District=(select top 1 district from [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') ))
									or (AL=''D'' and [district]=(select top 1 district from [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') )
									or (AL=''R'' and [Region]=(select top 1 [Region]   from  [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') )
									or (AL=''G'' and [Group]=(select top 1 [Group]   from  [dbo].[Hierarchy]  where  Store='+cast(@store as nvarchar)+') ) 
										', 
								' and   district='+cast(@district as nvarchar)+'  or (AL=''D'' and exists(select district from  [dbo].[Hierarchy] where District=t.District and  Region=(select top 1 [Region] from [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') ) ) 
									or (AL=''R'' and Region=(select top 1 [Region] from [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') )
									or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') ) 
											', 
								' and  [Region]='+cast(@region as nvarchar)+'
									Or (AL=''R'' and exists(select Region from [dbo].[Hierarchy] where [Region]=t.[Region] and  [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where  [Region]='+cast(@region as nvarchar)+') ) )
									or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where  [Region]='+cast(@region as nvarchar)+') )' ,

								' and  [Group]='+cast(@group as nvarchar)+' or AL=''G'' ',
								'   ')+'
								or AL=''F'' 
								) as ft		
								unpivot(Value for Variable in('+@ps2+')) up
								pivot( sum(Value) for TP in('+@ps1+')) p

						order by cast(replace([Group],''Group '','''') as int),cast(replace([Region],''Region '','''') as int),cast(Replace([District],''District '','''') as int),cast(Replace([Store],''Store '','''') as int)
		
						' +char(10) ;
					 set @sql=@raw+@headlinesbar ;
					--select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int,   @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula
----------	The CASH score graph (shown here in green) will be colored red when lower than the goal, green when equal to or higher than to goal for the current team (when rounded to no decimal places). See the Goals worksheet for the goals. We have goals for group, region and district but not store. When store seleted this can just be grey.
----------	Can clicking on the Customer CASH score graph navigate the user to the KPI Breakdown page, with the CASH score selected?
----------Clealiness Score	See KPICalcs worksheet for formula
----------Assortment Score	See KPICalcs worksheet for formula
----------Service Score	See KPICalcs worksheet for formula
----------High Speed Score	See KPICalcs worksheet for formula
 if exists(select top 1 idx from V_KPI where kpi=@kpi and idx=1)
		 begin 
				set @ps1=N'[Quarter 1],[Quarter 2],[Quarter 3],[Quarter 4],[YTD]';

				set @ps3=N'cast([Quarter 1] as int) [Quarter 1],cast([Quarter 2] as int) [Quarter 2],cast([Quarter 3] as int) [Quarter 3],cast([Quarter 4] as int) [Quarter 4],cast([YTD] as int) [YTD],cast([Goal] as int) [Goal]';
  
				set @formcash='';
				select @formcash=@formcash+','+quotename(kpi)+'= 100*('+e.eq+') ' from 
					(select distinct kpi,L2 from [dbo].[KPICalcs] where kpi=@kpi)  l outer apply
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,1,'' )) e
		 
				select @form=@form+',
								  ( sum(case when '+quotename(Variable)+' in('+stuff((select top 1 Right(Vl.Value,2*[TOP N BOX SCORE]) from [KPICalcs] k where k.Variable=vr.Variable ),1,1,'')+')  then 1 end)*1.0			 
								  /sum(case when '+quotename(Variable)+' in('+Value+')  then 1 end)   ) as '+quotename(Variable) 
				from ( select distinct Variable  from [dbo].[KPICalcs] where kpi=@kpi ) vr 	outer apply 
					 ( select Value=STUFF((select ','+cast(Value as varchar(10))  from  [dbo].[Variable_Values] val where Value<=7 and  val.Variable=vr.Variable   order by Value for xml path('')),1,1,'' )  	) Vl ;
    
				set @form=stuff(@form,1,1,'') ;

				select @form1=@form1+', null as '+quotename(Variable) 
				from ( select distinct Variable  from [dbo].[KPICalcs] where kpi=@kpi ) vr 	outer apply 
					 ( select Value=STUFF((select ','+cast(Value as varchar)  from  [dbo].[Variable_Values] val where Value<=7 and  val.Variable=vr.Variable   order by Value for xml path('')),1,1,'' )  	) Vl ;
    
				set @form1=stuff(@form1,1,1,'') ;
	
				set @customer_cash_score=', cashscore as ( 
							select concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  ) as TP,b.[Group],b.[Region],b.District,b.Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
									when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
									'+@form+'
							from  rawdata as b  where YEAR_NEW= @YEAR_NEW  
							group by concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  ),Rollup(b.[Group],b.[Region],b.District,b.Store) 
						 ) 
						 ,ytd as (
						 select ''YTD'' as TP,b.[Group],b.[Region],b.District,b.Store,
								( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
									   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
								'+@form+'
						from  rawdata as b  where DATE_NUM<convert(varchar(10),getdate()-1,112) and YEAR_NEW= @YEAR_NEW  
						group by  Rollup(b.[Group],b.[Region],b.District,b.Store)
						)
						, c1 as (
						 select TP, [Group], [Region], District, Store'+@formcash+',
								100*(case AL when ''F'' then  (select top 1 [Cash Survey] from [dbo].[Goals] where [Goal Level]=''Overall'')
										when ''G'' then  (select top 1 [Cash Survey] from [dbo].[Goals] where [Goal Level]=''Group'' and [id]=t.[Group]) 
										when ''R'' then  (select top 1 [Cash Survey] from [dbo].[Goals] where [Goal Level]=''Region'' and [id]=t.[Region]) 
										when ''D'' then  (select top 1 [Cash Survey] from [dbo].[Goals] where [Goal Level]=''District'' and [id]=t.[District]) 
										when ''S'' then null
								end) as [Goal] 
						 from(
								select * from  cashscore 
								union all
								select * from ytd
							) t
								where 		1=1	'  + 
								coalesce( ' and   store='+cast(@store as nvarchar)+'  
											or (AL=''S'' and exists(select * from [dbo].[Hierarchy] where Store=t.Store and District=(select top 1 district from [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') ))
											or (AL=''D'' and district=(select top 1 district from [dbo].[Hierarchy]  where Store='+cast(@store as nvarchar)+') )
											or (AL=''R'' and Region=(select top 1 [Region] from [dbo].[Hierarchy]  where Store='+cast(@store as nvarchar)+') )
											or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') ) 
												',

										' and   district='+cast(@district as nvarchar)+'  
											or (AL=''D'' and exists(select district from  [dbo].[Hierarchy] where District=t.District and  Region=(select top 1 [Region] from [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') ) ) 
											or (AL=''R'' and Region=(select top 1 [Region] from [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') )
											or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') ) 
													', 
										' and  [Region]='+cast(@region as nvarchar)+' 
											Or (AL=''R'' and exists(select Region from [dbo].[Hierarchy] where [Region]=t.[Region] and  [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where  [Region]='+cast(@region as nvarchar)+') ) )
											or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where  [Region]='+cast(@region as nvarchar)+') )' ,

										' and  [Group]='+cast(@group as nvarchar)+' or AL=''G'' ',
										'   ')+'
										or AL=''F'' 
						)
						select  concat(''Group '',[Group]) [Group],concat(''Region '',[Region]) [Region],concat(''District '',[District]) [District],concat(''Store '',[Store]) [Store],
						   '+@ps3+'
						from   c1
							 unpivot(Value for Variable in('+quotename(@kpi)+')) up
							 pivot( sum(Value) for TP in('+@ps1+')) p
					order by cast(replace([Group],''Group '','''') as int),cast(replace([Region],''Region '','''') as int),cast(Replace([District],''District '','''') as int),cast(Replace([Store],''Store '','''') as int)
						'   +char(10) ;
				 set @sql=@raw+@customer_cash_score ;
				 ---select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int, @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
   end

set nocount off ;
end

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_20150311BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,410,5697
[dbo].[p_get_KpiBreakdown_test] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,-1,-1
[p_get_KpiBreakdown_test] 3,9,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown_test] 3,9,'Customer CASH Score','',10 ,8 ,62 ,-1
exec [p_get_KpiBreakdown] 3,9,'Customer CASH Score','',10 ,8 ,62 ,-1
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
create   procedure [dbo].[p_get_KpiBreakdown_20150311BAK](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
@group int  , 
@region int  ,
@district int  ,
@store  int 
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @idx int;
  
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	
			
			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	
 
---Raw Data with filter
	set @raw=concat(N'print @YEAR_NEW; print @QUARTER_NEW  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 
							
    select top 1 @idx= idx from V_KPI where kpi=@kpi ;
	 if  (  @idx=2) 
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)
   
				select @formhead=@formhead+', format(isnull('+quotename(Variable)+',0),''0%'') ',
						@ps2=@ps2+ ','+quotename(Variable)
				from [dbo].[Headline_Variable]  where title=@kpi ;

				set @ps1=N'[Quarter 1],[Quarter 2],[Quarter 3],[Quarter 4],[YTD]';
				 
				set @ps2=stuff(@ps2,1,1,'') ;
				set @ps3=N'cast([Quarter 1] as int) [Quarter 1],cast([Quarter 2] as int) [Quarter 2],cast([Quarter 3] as int) [Quarter 3],cast([Quarter 4] as int) [Quarter 4],cast([YTD] as int) [YTD]';

				set @headlinesbar=stuff((select ', 100* sum(case when  '+quotename(Variable)+' between 6 and 7 then [weight] end)/nullif(sum(case when  '+quotename(Variable)+' between 1 and 7 then [weight] end),0) as '+quotename(Variable)+char(10) from [dbo].[Headline_Variable] where title=@kpi  for xml path('')),1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select  isnull(concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  ),''YTD'') as TP,[Group],[Region],District,Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
										   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
							 '+ @headlinesbar +'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW 
						group by   Grouping sets( YEAR_NEW, concat(''Quarter '', isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4))) , Rollup([Group],  Region, District, Store)
						) 
						select concat(''Group '',[Group]) [Group],concat(''Region '',[Region]) [Region],concat(''District '',[District]) [District],concat(''Store '',[Store]) [Store],
							   '+@ps3+' 
					    from (
						select * from headline t
										 where 		1=1	'  + 
						coalesce( ' and Store='+cast(@store as nvarchar)+'  
									or (AL=''S'' and exists(select * from [dbo].[Hierarchy] where Store=t.Store and District=(select top 1 district from [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') ))
									or (AL=''D'' and [district]=(select top 1 district from [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') )
									or (AL=''R'' and [Region]=(select top 1 [Region]   from  [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') )
									or (AL=''G'' and [Group]=(select top 1 [Group]   from  [dbo].[Hierarchy]  where  Store='+cast(@store as nvarchar)+') ) 
										', 
								' and   district='+cast(@district as nvarchar)+'  or (AL=''D'' and exists(select district from  [dbo].[Hierarchy] where District=t.District and  Region=(select top 1 [Region] from [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') ) ) 
									or (AL=''R'' and Region=(select top 1 [Region] from [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') )
									or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') ) 
											', 
								' and  [Region]='+cast(@region as nvarchar)+'
									Or (AL=''R'' and exists(select Region from [dbo].[Hierarchy] where [Region]=t.[Region] and  [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where  [Region]='+cast(@region as nvarchar)+') ) )
									or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where  [Region]='+cast(@region as nvarchar)+') )' ,

								' and  [Group]='+cast(@group as nvarchar)+' or AL=''G'' ',
								'   ')+'
								or AL =''F''
								) as ft		
								unpivot(Value for Variable in('+@ps2+')) up
								pivot( sum(Value) for TP in('+@ps1+')) p 
						order by cast(replace([Group],''Group '','''') as int),cast(replace([Region],''Region '','''') as int),cast(Replace([District],''District '','''') as int),cast(Replace([Store],''Store '','''') as int)
		
						' ;
					 set @sql=@raw+@headlinesbar ;
					---select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int,   @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula
----------	The CASH score graph (shown here in green) will be colored red when lower than the goal, green when equal to or higher than to goal for the current team (when rounded to no decimal places). See the Goals worksheet for the goals. We have goals for group, region and district but not store. When store seleted this can just be grey.
----------	Can clicking on the Customer CASH score graph navigate the user to the KPI Breakdown page, with the CASH score selected?
----------Clealiness Score	See KPICalcs worksheet for formula
----------Assortment Score	See KPICalcs worksheet for formula
----------Service Score	See KPICalcs worksheet for formula
----------High Speed Score	See KPICalcs worksheet for formula
 else if  (@idx=1)
		 begin 
				set @ps1=N'[Quarter 1],[Quarter 2],[Quarter 3],[Quarter 4],[YTD]';

				set @ps3=N'cast([Quarter 1] as int) [Quarter 1],cast([Quarter 2] as int) [Quarter 2],cast([Quarter 3] as int) [Quarter 3],cast([Quarter 4] as int) [Quarter 4],cast([YTD] as int) [YTD]';
   
				set @formcash='';
				select @formcash=@formcash+','+quotename(@kpi)+'=case when '+f.cs+' then null else  100*('+e.eq+') end' from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs3] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs3] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;
   
				select @form=@form+',
								  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] end)			 
								  /nullif(sum(case when '+quotename(Variable)+'  between 1 and 7 then [weight] end),0)   ) as '+quotename(Variable) 
								  ,@form1=@form1+', null as '+quotename(Variable) 
				from ( select distinct Variable,TopNbox  from [dbo].[KPICalcs3] where kpi=@kpi ) vr    ;
    
				set @form=stuff(@form,1,1,'') ; 
				set @form1=stuff(@form1,1,1,'') ;
	
				set @customer_cash_score=', cashscore as ( 
							select isnull(concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  ),''YTD'') as TP,b.[Group],b.[Region],b.District,b.Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
									when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
									'+@form+'
							from  rawdata as b  where YEAR_NEW= @YEAR_NEW  
							group by   Grouping sets( YEAR_NEW, concat(''Quarter '', isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4))) ,Rollup(b.[Group],b.[Region],b.District,b.Store) 
						 ) 
						 ,gl as (
						      select [Overall],[Group],[Region],[District],100*[CASH Survey] cs
						       from [dbo].[Goals](nolock) pivot(max(ID) for [Goal Level] in( [Group],[Region],[District],[Overall]))p 
							) 
						, c1 as (
						 select AL,TP, [Group], [Region], District, Store'+@formcash+'
						 from   cashscore 	  t
								where 		1=1	'  + 
								coalesce( ' and   store='+cast(@store as nvarchar)+'  
											or (AL=''S'' and exists(select * from [dbo].[Hierarchy] where Store=t.Store and District=(select top 1 district from [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') ))
											or (AL=''D'' and district=(select top 1 district from [dbo].[Hierarchy]  where Store='+cast(@store as nvarchar)+') )
											or (AL=''R'' and Region=(select top 1 [Region] from [dbo].[Hierarchy]  where Store='+cast(@store as nvarchar)+') )
											or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') ) 
												', 
										' and   district='+cast(@district as nvarchar)+'  
											or (AL=''D'' and exists(select district from  [dbo].[Hierarchy] where District=t.District and  Region=(select top 1 [Region] from [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') ) ) 
											or (AL=''R'' and Region=(select top 1 [Region] from [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') )
											or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') ) 
													', 
										' and  [Region]='+cast(@region as nvarchar)+' 
											Or (AL=''R'' and exists(select Region from [dbo].[Hierarchy] where [Region]=t.[Region] and  [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where  [Region]='+cast(@region as nvarchar)+') ) )
											or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where  [Region]='+cast(@region as nvarchar)+') )' ,

										' and  [Group]='+cast(@group as nvarchar)+' or AL=''G'' ',
										'   ')+'
										or AL=''F'' 
						)
						select  concat(''Group '',[Group]) [Group],concat(''Region '',[Region]) [Region],concat(''District '',[District]) [District],concat(''Store '',[Store]) [Store],
						   '+@ps3+', cast( (case AL when ''F'' then  (select  cs from gl where overall<=-1 )
										when ''G'' then  (select  cs from gl where  [Group]=p.[Group]) 
										when ''R'' then  (select   cs from gl where  [Region]=p.[Region]) 
										when ''D'' then  (select  cs from gl where  [District]=p.[District])  
								end) as int) as [Goal] 
						from   c1
							 unpivot(Value for Variable in('+quotename(@kpi)+')) up
							 pivot( sum(Value) for TP in('+@ps1+')) p
					order by cast(replace([Group],''Group '','''') as int),cast(replace([Region],''Region '','''') as int),cast(Replace([District],''District '','''') as int),cast(Replace([Store],''Store '','''') as int)
						'   ;
				 set @sql=@raw+@customer_cash_score ;
				 ---select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int, @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
   end

set nocount off ;
end

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_20150402BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,410,5697
[dbo].[p_get_KpiBreakdown_test] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,-1,-1
[p_get_KpiBreakdown_test] 3,9,'Recommend','',-1 ,-1 ,-1 ,-1
[p_get_KpiBreakdown_test] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
[p_get_KpiBreakdown] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown_test] 3,9,'Customer CASH Score','',10 ,8 ,62 ,-1
exec [p_get_KpiBreakdown] 3,9,'Customer CASH Score','',10 ,8 ,62 ,-1

exec [dbo].[p_get_KpiBreakdown_test] 3,9,'SERVICE','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown] 3,9,'SERVICE','  ',10,40,300,6199
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
create   procedure [dbo].[p_get_KpiBreakdown_20150402BAK](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
@group int  , 
@region int  ,
@district int  ,
@store  int 
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @idx int,
		   @c  nvarchar(max);
  
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	
			
			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	
 
---Raw Data with filter
	set @raw=concat(N' ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 and district>0  ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 
							
    select top 1 @idx= idx from V_KPI where kpi=@kpi ;

	set @c=  coalesce( case when @store is not null then ' and Store='+cast(@store as nvarchar)+
							isnull((select top 1 '  
									or (AL=''S'' and exists(select * from [dbo].[Hierarchy] where Store=t.Store and District='+cast(District as nvarchar)+' ))
									or (AL=''D'' and [district]='+cast(District as nvarchar)+' )
									or (AL=''R'' and [Region]='+cast(Region as nvarchar)+' )
									or (AL=''G'' and [Group]='+cast( [Group] as nvarchar)+'  ) 
										'   from  [dbo].[Hierarchy]  where  Store=@store),'')+' or AL =''F'' ' end, 
					  case when @district is not null then	' and   district='+cast(@district as nvarchar)+
							isnull((select top 1 '
								    or (AL=''D'' and exists(select district from  [dbo].[Hierarchy] where District=t.District and  Region='+cast(Region as nvarchar)+' ) ) 
									or (AL=''R'' and Region='+cast(Region as nvarchar)+' )
									or (AL=''G'' and [Group]='+cast([Group] as nvarchar)+' ) 
											'  from  [dbo].[Hierarchy]  where District= @district ),'')+' or AL =''F'' ' end, 
					 case when @region is not null then	' and  [Region]='+cast(@region as nvarchar)+
					 isnull((select top 1 '
									Or (AL=''R'' and exists(select Region from [dbo].[Hierarchy] where [Region]=t.[Region] and  [Group]='+cast([Group] as nvarchar)+' ) )
									or (AL=''G'' and [Group]='+cast([Group] as nvarchar)+' )'
									 from  [dbo].[Hierarchy]  where  [Region]=@region ),'')+' or AL =''F'' ' end ,

								' and  [Group]='+cast(@group as nvarchar)+' or AL=''G'' or AL =''F'' ',
								'   ')  ;

	 if  (  @idx=2) 
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)
   
				select @formhead=@formhead+', format(isnull('+quotename(Variable)+',0),''0%'') ',
						@ps2=@ps2+ ','+quotename(Variable)
						, @headlinesbar=@headlinesbar+', 100* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end),0) as '+quotename(Variable)
				from [dbo].[Headline_Variable]  where title=@kpi ;

				set @ps1=N'[Quarter 1],[Quarter 2],[Quarter 3],[Quarter 4],[YTD]';
				 
				set @ps2=stuff(@ps2,1,1,'') ;
				set @ps3=N'cast([Quarter 1] as decimal(18,0)) [Quarter 1],cast([Quarter 2] as decimal(18,0)) [Quarter 2],cast([Quarter 3] as decimal(18,0)) [Quarter 3],cast([Quarter 4] as decimal(18,0)) [Quarter 4],cast([YTD] as decimal(18,0)) [YTD]';

				 
				----select @headlinesbar=@headlinesbar+', 100* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end),0) as '+quotename(Variable)
				---- from [dbo].[Headline_Variable] where title=@kpi  
				 
				 set @headlinesbar=stuff(@headlinesbar,1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select isnull(concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  ),''YTD'') as TP,[Group],[Region],District,Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
										   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
							 '+ @headlinesbar +'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW 
						group by   Grouping sets( YEAR_NEW,concat(''Quarter '', isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)) ) , Rollup([Group],  Region, District, Store)
						) 
						select concat(''Group '',[Group]) [Group],concat(''Region '',[Region]) [Region],concat(''District '',[District]) [District],concat(''Store '',[Store]) [Store],
							   '+@ps3+' 
					    from (
								select * from headline t  where 	1=1	'  +@c+'							
						 ) as ft		
								unpivot(Value for Variable in('+@ps2+')) up
								pivot( sum(Value) for TP in('+@ps1+')) p 
						order by cast(replace([Group],''Group '','''') as int),cast(replace([Region],''Region '','''') as int),cast(Replace([District],''District '','''') as int),cast(Replace([Store],''Store '','''') as int)
		
						' ;
					 set @sql=@raw+@headlinesbar ;
					---select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int ', @YEAR_NEW   ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula
----------	The CASH score graph (shown here in green) will be colored red when lower than the goal, green when equal to or higher than to goal for the current team (when rounded to no decimal places). See the Goals worksheet for the goals. We have goals for group, region and district but not store. When store seleted this can just be grey.
----------	Can clicking on the Customer CASH score graph navigate the user to the KPI Breakdown page, with the CASH score selected?
----------Clealiness Score	See KPICalcs worksheet for formula
----------Assortment Score	See KPICalcs worksheet for formula
----------Service Score	See KPICalcs worksheet for formula
----------High Speed Score	See KPICalcs worksheet for formula
 else if  (@idx=1)
		 begin 
				set @ps1=N'[Quarter 1],[Quarter 2],[Quarter 3],[Quarter 4],[YTD]';

				set @ps3=N'cast([Quarter 1] as decimal(18,0)) [Quarter 1],cast([Quarter 2] as decimal(18,0)) [Quarter 2],cast([Quarter 3] as decimal(18,0)) [Quarter 3],cast([Quarter 4] as decimal(18,0)) [Quarter 4],cast([YTD] as decimal(18,0)) [YTD]';
   
				set @formcash='';
				select @formcash=@formcash+','+quotename(@kpi)+'=case when '+f.cs+' then null else  100*('+e.eq+') end' from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;
   
				select @form=@form+',
								  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end)			 
								  /nullif(sum(case when '+quotename(Variable)+'   in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end),0)   ) as '+quotename(Variable) 
								  ,@form1=@form1+', null as '+quotename(Variable) 
				from    [dbo].[KPICalcs] where kpi=@kpi   ;
    
				set @form=stuff(@form,1,1,'') ; 
				set @form1=stuff(@form1,1,1,'') ;
	
				set @customer_cash_score=', cashscore as ( 
							select isnull(concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  ),''YTD'') as TP,b.[Group],b.[Region],b.District,b.Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
									when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
									'+@form+'
							from  rawdata as b  where YEAR_NEW= @YEAR_NEW  
							group by   Grouping sets( YEAR_NEW, concat(''Quarter '', isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4))) ,Rollup(b.[Group],b.[Region],b.District,b.Store) 
						 ) 
						 ,gl as (
						      select [Overall],[Group],[Region],[District],100*[CASH Survey] cs
						       from [dbo].[Goals](nolock) pivot(max(ID) for [Goal Level] in( [Group],[Region],[District],[Overall]))p 
							) 
						, c1 as (
						 select AL, TP, [Group], [Region], District, Store'+@formcash+'
						 from   cashscore 	  t
								where 		1=1	'  + @c+' 
						)
						select  concat(''Group '',[Group]) [Group],concat(''Region '',[Region]) [Region],concat(''District '',[District]) [District],concat(''Store '',[Store]) [Store],
						   '+@ps3+','+case when @kpi='Customer CASH Score' then  ' cast( 
						         (case AL when ''F'' then  (select top 1 cs from gl where overall<=-1 )
										when ''G'' then  (select  top 1  cs from gl where  [Group]=p.[Group]) 
										when ''R'' then  (select  top 1   cs from gl where  [Region]=p.[Region]) 
										when ''D'' then  (select   top 1 cs from gl where  [District]=p.[District])  
								end) as int)' else ' null ' end 
								+' as [Goal] 
						from   c1
							 unpivot(Value for Variable in('+quotename(@kpi)+')) up
							 pivot( sum(Value) for TP in('+@ps1+')) p
					order by cast(replace([Group],''Group '','''') as int),cast(replace([Region],''Region '','''') as int),cast(Replace([District],''District '','''') as int),cast(Replace([Store],''Store '','''') as int)
						'   ;
				 set @sql=@raw+@customer_cash_score ;
				 ---select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int ', @YEAR_NEW   ;
   end
     set nocount off ;
end

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_20150407BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_base] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,410,5697
[dbo].[p_get_KpiBreakdown_base] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_base] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,-1,-1
[p_get_KpiBreakdown_base] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
[p_get_KpiBreakdown_test] 3,9,'Recommend','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown_base] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown_test] 3,9,'Customer CASH Score','',10 ,8 ,62 ,-1
exec [p_get_KpiBreakdown] 3,9,'Customer CASH Score','',10 ,8 ,62 ,-1

exec [dbo].[p_get_KpiBreakdown_test] 3,9,'SERVICE','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown] 3,9,'SERVICE','  ',10,40,300,6199
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
CREATE   procedure [dbo].[p_get_KpiBreakdown_20150407BAK](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
@group int  , 
@region int  ,
@district int  ,
@store  int 
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @idx int,
		   @c  nvarchar(max);
  
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	
			
			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	
 
---Raw Data with filter
	set @raw=concat(N' ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 and district>0  ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 

							
    select top 1 @idx= idx from V_KPI where kpi=@kpi ;

	set @c=  coalesce( case when @store is not null then ' and Store='+cast(@store as nvarchar)+
							isnull((select top 1 '  
									or (AL=''S'' and exists(select * from [dbo].[Hierarchy] where Store=t.Store and District='+cast(District as nvarchar)+' ))
									or (AL=''D'' and [district]='+cast(District as nvarchar)+' )
									or (AL=''R'' and [Region]='+cast(Region as nvarchar)+' )
									or (AL=''G'' and [Group]='+cast( [Group] as nvarchar)+'  ) 
										'   from  [dbo].[Hierarchy]  where  Store=@store),'')+' or AL =''F'' ' end, 
					  case when @district is not null then	' and   district='+cast(@district as nvarchar)+
							isnull((select top 1 '
								    or (AL=''D'' and exists(select district from  [dbo].[Hierarchy] where District=t.District and  Region='+cast(Region as nvarchar)+' ) ) 
									or (AL=''R'' and Region='+cast(Region as nvarchar)+' )
									or (AL=''G'' and [Group]='+cast([Group] as nvarchar)+' ) 
											'  from  [dbo].[Hierarchy]  where District= @district ),'')+' or AL =''F'' ' end, 
					 case when @region is not null then	' and  [Region]='+cast(@region as nvarchar)+
					 isnull((select top 1 '
									Or (AL=''R'' and exists(select Region from [dbo].[Hierarchy] where [Region]=t.[Region] and  [Group]='+cast([Group] as nvarchar)+' ) )
									or (AL=''G'' and [Group]='+cast([Group] as nvarchar)+' )'
									 from  [dbo].[Hierarchy]  where  [Region]=@region ),'')+' or AL =''F'' ' end ,

								' and  [Group]='+cast(@group as nvarchar)+' or AL=''G'' or AL =''F'' ',
								'   ')  ;

			select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,'!Base]' )
				,@ps3=@ps3+',cast('+quotename(Qrt_ID)+' as decimal(18,0)) [Quarter '+concat(quarter_new,'],cast([',Qrt_ID,'!Base] as decimal(18,0)) [Q',quarter_new,'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
				 
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;

			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';
 		

	 if  (  @idx=2) 
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)
   
				select  @ps2=@ps2+ ','+quotename(Variable)+ ','+quotename(Variable+'!B')
						, @headlinesbar=@headlinesbar+', 100* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end),0) as '+quotename(Variable)
						+',  sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end)  as '+quotename(Variable+'!B')
				from [dbo].[Headline_Variable]  where title=@kpi ;

				 
				set @ps2=stuff(@ps2,1,1,'') ;
			
				 
				----select @headlinesbar=@headlinesbar+', 100* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end),0) as '+quotename(Variable)
				---- from [dbo].[Headline_Variable] where title=@kpi  
				 
				 set @headlinesbar=stuff(@headlinesbar,1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select isnull(  cast(  [QUARTER_NEW] as nvarchar)  ,''YTD'') as TP,[Group],[Region],District,Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
										   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
							 '+ @headlinesbar +'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW 
						group by   Grouping sets( YEAR_NEW,   [QUARTER_NEW]  ) , Rollup([Group],  Region, District, Store)
						) 
						select concat(''Group '',[Group]) [Group],concat(''Region '',[Region]) [Region],concat(''District '',[District]) [District],concat(''Store '',[Store]) [Store],
							   '+@ps3+' 
						from (select  TP+(case when charindex(''!B'',Variable)>0 then ''!Base'' else '''' end) as  TP,[Group],[Region],District,Store,value
								from ( 	select * from headline t  where 	1=1	'  +@c+'							
								) as ft		
								unpivot(Value for Variable in('+@ps2+')) up
						 )ut
								pivot( sum(Value) for TP in('+@ps1+')) p 
						order by cast(replace([Group],''Group '','''') as int),cast(replace([Region],''Region '','''') as int),cast(Replace([District],''District '','''') as int),cast(Replace([Store],''Store '','''') as int)
		
						' ;
					 set @sql=@raw+@headlinesbar ;
				------select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int ', @YEAR_NEW   ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	

 else if  (@idx=1)
		 begin 
 
				set @formcash='';
				select @formcash=@formcash+','+quotename(@kpi)+'=case when '+f.cs+' then null else  100*('+e.eq+') end' from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;

				select @formcash=@formcash+','+quotename(@kpi+'!B')+'=case when '+f.cs+' then null else  ('+e.eq+') end' from  
					(select eq=stuff((select    '+isnull(',quotename(Variable+'!B'),',0)'  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable+'!B'),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;
   
      
				select @form=@form+',	  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end) /nullif(sum(case when '+quotename(Variable)+'   in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end),0)   ) as '+quotename(Variable) 
								  +' ,sum(case when '+quotename(Variable)+'   in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end) as '+quotename(Variable+'!B') 
								 
				from    [dbo].[KPICalcs] where kpi=@kpi   ;
    
				set @form=stuff(@form,1,1,'') ;  
	
				set @customer_cash_score=', cashscore as ( 
							select isnull( cast(  [QUARTER_NEW] as nvarchar),''YTD'') as TP,b.[Group],b.[Region],b.District,b.Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
									when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
									'+@form+'
							from  rawdata as b  where YEAR_NEW= @YEAR_NEW  
							group by   Grouping sets( YEAR_NEW, [QUARTER_NEW]   ) ,Rollup(b.[Group],b.[Region],b.District,b.Store) 
						 ) 
						 ,gl as (
						      select [Overall],[Group],[Region],[District],100*[CASH Survey] cs
						       from [dbo].[Goals](nolock) pivot(max(ID) for [Goal Level] in( [Group],[Region],[District],[Overall]))p 
							) 
						, c1 as (
						 select AL, TP, [Group], [Region], District, Store'+@formcash+'
						 from   cashscore 	  t
								where 		1=1	'  + @c+' 
						)
						select  concat(''Group '',[Group]) [Group],concat(''Region '',[Region]) [Region],concat(''District '',[District]) [District],concat(''Store '',[Store]) [Store],
						   '+@ps3+','+case when @kpi='Customer CASH Score' then  ' cast( 
						         (case AL when ''F'' then  (select top 1 cs from gl where overall<=-1 )
										when ''G'' then  (select  top 1  cs from gl where  [Group]=p.[Group]) 
										when ''R'' then  (select  top 1   cs from gl where  [Region]=p.[Region]) 
										when ''D'' then  (select   top 1 cs from gl where  [District]=p.[District])  
								end) as int)' else ' null ' end 
								+' as [Goal] 
						from (
							select TP+(case when charindex(''!B'',Variable)>0 then ''!Base'' else '''' end) as  TP,[Group],[Region],District,Store,value,AL
							from   c1
							 unpivot(Value for Variable in('+quotename(@kpi)+','+quotename(@kpi+'!B')+')) up
						 )ut
							 pivot( sum(Value) for TP in('+@ps1+')) p
					order by cast(replace([Group],''Group '','''') as int),cast(replace([Region],''Region '','''') as int),cast(Replace([District],''District '','''') as int),cast(Replace([Store],''Store '','''') as int)
						'   ;
				 set @sql=@raw+@customer_cash_score ;
				 ---select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int ', @YEAR_NEW   ;
   end
     set nocount off ;
end

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_20150410BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,410,5697
[dbo].[p_get_KpiBreakdown_test] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,-1,-1
[p_get_KpiBreakdown] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
[p_get_KpiBreakdown_test] 3,9,'Recommend','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown_test] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown_test] 3,9,'Customer CASH Score','',10 ,8 ,62 ,-1
exec [p_get_KpiBreakdown] 3,9,'Customer CASH Score','',10 ,8 ,62 ,-1

exec [dbo].[p_get_KpiBreakdown_test] 3,9,'SERVICE','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown] 3,9,'SERVICE','  ',10,40,300,6199
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
CREATE   procedure [dbo].[p_get_KpiBreakdown_20150410BAK](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
@group int  , 
@region int  ,
@district int  ,
@store  int 
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int, 
		   @c2  nvarchar(max);
  
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	
			
			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	
 
---Raw Data with filter
	set @raw=concat(N' ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 and district>0  ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 

----------------------------------------------------------------------------------------------------------------------------------------
	set @c2=   coalesce(
								  case when @store is not null then ', case when  Store='+cast(@store as nvarchar)+
								isnull((select top 1 '  
										or (Grouping([Group])+ Grouping(Region) + Grouping(District)+ Grouping([Store]) =0 and  District='+cast(District as nvarchar)+' )
										or ( Grouping([Group])+ Grouping(Region)  + Grouping(District)=0 and Grouping([Store]) =1 and [district]='+cast(District as nvarchar)+' )
										or (  Grouping([Group])+ Grouping(Region)=0 and Grouping(District)=1 and [Region]='+cast(Region as nvarchar)+' )
										or ( Grouping([Group])=0 and Grouping(Region)=1 and [Group]='+cast( [Group] as nvarchar)+'  ) 
											'   from  [dbo].[Hierarchy]  where  Store=@store),'')+' or  Grouping([Group])=1 then 1 else 0 end as flag' end, 
								 case when @district is not null then	', case when   district='+cast(@district as nvarchar)+
								isnull((select top 1 '
										or ( Grouping([Group])+ Grouping(Region)  + Grouping(District)=0 and Grouping([Store]) =1  and  Region='+cast(Region as nvarchar)+'  ) 
										or ( Grouping([Group])+ Grouping(Region)=0 and Grouping(District)=1 and Region='+cast(Region as nvarchar)+' )
										or (Grouping([Group])=0 and Grouping(Region)=1 and [Group]='+cast([Group] as nvarchar)+' ) 
												'  from  [dbo].[Hierarchy]  where District= @district ),'')+'  or  Grouping([Group])=1 then 1 else 0 end as flag' end, 
								 case when @region is not null then	', case when  [Region]='+cast(@region as nvarchar)+
									 isnull((select top 1 '
										Or ( Grouping([Group])+ Grouping(Region)=0 and Grouping(District)=1 and  [Group]='+cast([Group] as nvarchar)+'  )
										or (Grouping([Group])=0 and Grouping(Region)=1 and [Group]='+cast([Group] as nvarchar)+' )'
										 from  [dbo].[Hierarchy]  where  [Region]=@region ),'')+'   or  Grouping([Group])=1 then 1 else 0 end as flag ' end ,

									', case when   [Group]='+cast(@group as nvarchar)+' or Grouping(Region)=1  or  Grouping([Group])=1 then 1 else 0 end as flag ',
									', 1 as flag  ')  ;
-----------------------------------------------------------------------------------------------------------------------------------------
			select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
				,@ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
				 
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;

			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';
 		

	  if  exists(select * from [dbo].[Headline_Variable] where Title= @kpi)
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)
   
				select  @ps2=@ps2+ ','+quotename(Variable)+ ','+quotename(Variable+'!B')
						, @headlinesbar=@headlinesbar+', 100* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end),0) as '+quotename(Variable)
						+',  sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end)  as '+quotename(Variable+'!B')
				from [dbo].[Headline_Variable]  where title=@kpi ;

				 
				set @ps2=stuff(@ps2,1,1,'') ;
			
 
				 set @headlinesbar=stuff(@headlinesbar,1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select isnull(  cast(  [QUARTER_NEW] as nvarchar)  ,''YTD'') as TP,[Group],[Region],District,Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
										   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
							 '+ @headlinesbar +char(10)+@c2+'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW 
						group by   Grouping sets( YEAR_NEW,   [QUARTER_NEW]  ) , Rollup([Group],  Region, District, Store)
						) 
						select concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
							   '+@ps3+' 
						from (select  TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store s,value
								from  (select * from  headline t where flag=1)   ft		
								unpivot(Value for Variable in('+@ps2+')) up
						 )ut
								pivot( sum(Value) for TP in('+@ps1+')) p 
						order by  g,r,d,s
		
						' ;
					 set @sql=@raw+@headlinesbar ;
				------select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int ', @YEAR_NEW   ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	

 else if  exists(select *  from [dbo].[KPICalcs] where kpi=@kpi) 
		 begin 
 
				set @formcash='';
				select @formcash=@formcash+','+quotename(@kpi)+'=case when '+f.cs+' then null else  100*('+e.eq+') end' from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;

				select @formcash=@formcash+','+quotename(@kpi+'!B')+'=case when '+f.cs+' then null else  ('+e.eq+') end' from  
					(select eq=stuff((select    '+isnull(',quotename(Variable+'!B'),',0)'  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable+'!B'),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;
   
      
				select @form=@form+',	  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end) /nullif(sum(case when '+quotename(Variable)+'   in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end),0)   ) as '+quotename(Variable) 
								  +' ,sum(case when '+quotename(Variable)+'   in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end) as '+quotename(Variable+'!B') 
								 
				from    [dbo].[KPICalcs] where kpi=@kpi   ;
    
				set @form=stuff(@form,1,1,'') ;  
	
				set @customer_cash_score=', cashscore as ( 
							select isnull( cast(  [QUARTER_NEW] as nvarchar),''YTD'') as TP,b.[Group],b.[Region],b.District,b.Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
									when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
									'+@form+char(10)+@c2+'
							from  rawdata as b  where YEAR_NEW= @YEAR_NEW  
							group by   Grouping sets( YEAR_NEW, [QUARTER_NEW]   ) ,Rollup(b.[Group],b.[Region],b.District,b.Store) 
						 ) 
						, c1 as (
						 select AL, TP, [Group], [Region], District, Store'+@formcash+'
						 from   cashscore 	  t  where flag=1
						)
						select  concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
						   '+@ps3+','+case when @kpi='Customer CASH Score' then  ' cast( 
						         (case AL when ''F'' then  (select top 1 cs from [dbo].[Goals_Pivoted](nolock) where overall=-1 )
										when ''G'' then  (select  top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Group]=p.[g]) 
										when ''R'' then  (select  top 1   cs from [dbo].[Goals_Pivoted](nolock) where  [Region]=p.[r]) 
										when ''D'' then  (select   top 1 cs from [dbo].[Goals_Pivoted](nolock) where  [District]=p.[d])  
								end) as decimal(18,0) )' else ' null ' end 
								+' as [Goal] 
						from (
							select TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d ,Store s,value,AL
							from   c1
							 unpivot(Value for Variable in('+quotename(@kpi)+','+quotename(@kpi+'!B')+')) up
						 )ut
							 pivot( sum(Value) for TP in('+@ps1+')) p
					order by  g,r,d,s
						'   ;
				 set @sql=@raw+@customer_cash_score ;
				 ---select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int ', @YEAR_NEW   ;
   end
     set nocount off ;
end

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_20150422BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,410,5697
[dbo].[p_get_KpiBreakdown_test] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,-1,-1
[p_get_KpiBreakdown] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
[p_get_KpiBreakdown_test] 3,9,'Recommend','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown_test] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown_test] 3,9,'Customer CASH Score','',10 ,8 ,62 ,-1
exec [p_get_KpiBreakdown] 3,9,'Customer CASH Score','',10 ,8 ,62 ,-1

exec [dbo].[p_get_KpiBreakdown_test] 3,9,'SERVICE','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown] 3,9,'SERVICE','  ',10,40,300,6199
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
CREATE   procedure [dbo].[p_get_KpiBreakdown_20150422BAK](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
@group int  , 
@region int  ,
@district int  ,
@store  int 
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int, 
		   @c2  nvarchar(max);
  
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	
			
			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	
 
---Raw Data with filter
	set @raw=concat(N' ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where   district>0  ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 

----------------------------------------------------------------------------------------------------------------------------------------
	if @store is not null 
	begin
		set @c2=  ', case when  Store='+cast(@store as nvarchar)+
								isnull((select top 1 '  
										or (Grouping([Group])+ Grouping(Region) + Grouping(District)+ Grouping([Store]) =0 and  District='+cast(District as nvarchar)+' )
										or ( Grouping([Group])+ Grouping(Region)  + Grouping(District)=0 and Grouping([Store]) =1 and [district]='+cast(District as nvarchar)+' )
										or (  Grouping([Group])+ Grouping(Region)=0 and Grouping(District)=1 and [Region]='+cast(Region as nvarchar)+' )
										or ( Grouping([Group])=0 and Grouping(Region)=1 and [Group]='+cast( [Group] as nvarchar)+'  ) 
											'   from  [dbo].[Hierarchy]  where  Store=@store),'')+' or  Grouping([Group])=1 then 1 else 0 end as flag' 
	 end
	 else if   @district is not null 
	 begin
		set @c2= 	', case when   district='+cast(@district as nvarchar)+
								isnull((select top 1 '
										or ( Grouping([Group])+ Grouping(Region)  + Grouping(District)=0 and Grouping([Store]) =1  and  Region='+cast(Region as nvarchar)+'  ) 
										or ( Grouping([Group])+ Grouping(Region)=0 and Grouping(District)=1 and Region='+cast(Region as nvarchar)+' )
										or (Grouping([Group])=0 and Grouping(Region)=1 and [Group]='+cast([Group] as nvarchar)+' ) 
												'  from  [dbo].[Hierarchy]  where District= @district ),'')+'  or  Grouping([Group])=1 then 1 else 0 end as flag'
	 end
	 else if  @region is not null 
	 begin
		set @c2= 	', case when  [Region]='+cast(@region as nvarchar)+
									 isnull((select top 1 '
										Or ( Grouping([Group])+ Grouping(Region)=0 and Grouping(District)=1 and  [Group]='+cast([Group] as nvarchar)+'  )
										or (Grouping([Group])=0 and Grouping(Region)=1 and [Group]='+cast([Group] as nvarchar)+' )'
										 from  [dbo].[Hierarchy]  where  [Region]=@region ),'')+'   or  Grouping([Group])=1 then 1 else 0 end as flag ' 
	 end  
	 else if @group is not null
	 begin
		set @c2= ', case when   [Group]='+cast(@group as nvarchar)+' or Grouping(Region)=1  or  Grouping([Group])=1 then 1 else 0 end as flag '
	 end
	 else
	 begin
		set @c2= ', 1 as flag  '
	 end ;
-----------------------------------------------------------------------------------------------------------------------------------------
	
 		

	  if  exists(select * from [dbo].[Headline_Variable] where Title= @kpi)
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)
   
   		    select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
				,@ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
				 
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;

			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';

				select  @ps2=@ps2+ ','+quotename(Variable)+ ','+quotename(Variable+'!B')
						, @headlinesbar=@headlinesbar+', 100* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end),0) as '+quotename(Variable)
						+',  sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end)  as '+quotename(Variable+'!B')
				from [dbo].[Headline_Variable]  where title=@kpi ;

				 
				set @ps2=stuff(@ps2,1,1,'') ;
			
 
				 set @headlinesbar=stuff(@headlinesbar,1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select isnull(  cast(  [QUARTER_NEW] as nvarchar)  ,''YTD'') as TP,[Group],[Region],District,Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
										   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
							 '+ @headlinesbar +char(10)+@c2+'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW 
						group by   Grouping sets( YEAR_NEW,   [QUARTER_NEW]  ) , Rollup([Group],  Region, District, Store)
						) 
						select concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
							   '+@ps3+' 
						from (select  TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store s,value
								from  (select * from  headline t where flag=1)   ft		
								unpivot(Value for Variable in('+@ps2+')) up
						 )ut
								pivot( sum(Value) for TP in('+@ps1+')) p 
						order by  g,r,d,s
		
						' ;
					 set @sql=@raw+@headlinesbar ;
				------select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int ', @YEAR_NEW   ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	

 else if  exists(select *  from [dbo].[KPICalcs] where kpi=@kpi) 
		 begin 
 
		   set @ps3='' ;
		   set @ps1='' ;

		   if @kpi='Customer CASH Score'
		   begin
 				select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
						, @ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,1)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
				from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
		    
				set @ps1=N'[YTD],[YTD!Base]'+@ps1;
				set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,1)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';
		   end
		   else
		   begin
 			select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
					, @ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
		    
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;
			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';
		  end

				set @formcash='';
				select @formcash=@formcash+','+quotename(@kpi)+'= case when '+f.cs+' then null else 100*('+e.eq+') end' from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;
   
				select @formcash=@formcash+','+quotename(@kpi+'!B')+'= case when '+f.cs+' then null else ('+e.eq+') end' from  
					(select eq=stuff((select  '+isnull(',quotename(Variable+'!B'),',0)  '  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable+'!B'),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;
    
				select @form=@form+',	  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end) /nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0)   ) as '+quotename(Variable) 
								+',	sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight]/[WCNT] end) as '+quotename(Variable+'!B') 
					  ,@form1=@form1+'+ (case when '+quotename(Variable) +'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then cast(1.0 as float) else cast(0.0 as float) end) '
				from   [dbo].[KPICalcs] where kpi=@kpi 	 ;

				set @form=stuff(@form,1,1,'') ;
				  
				 set @form=replace(@form,'/[WCNT]','/('+stuff(@form1,1,1,'')+')' );
	
				set @customer_cash_score=', cashscore as ( 
							select isnull( cast(  [QUARTER_NEW] as nvarchar),''YTD'') as TP,b.[Group],b.[Region],b.District,b.Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
									when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
									'+@form+char(10)+@c2+'
							from  rawdata as b  where YEAR_NEW= @YEAR_NEW  
							group by   Grouping sets( YEAR_NEW, [QUARTER_NEW]   ) ,Rollup(b.[Group],b.[Region],b.District,b.Store) 
						 ) 
						, c1 as (
						 select AL, TP, [Group], [Region], District, Store'+@formcash+'
						 from   cashscore 	  t  where flag=1
						)
						select  concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
						   '+@ps3+','+case when @kpi='Customer CASH Score' then  ' cast( 
						         (case AL when ''F'' then  (select top 1 cs from [dbo].[Goals_Pivoted](nolock) where overall=-1 )
										when ''G'' then  (select  top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Group]=p.[g]) 
										when ''R'' then  (select  top 1   cs from [dbo].[Goals_Pivoted](nolock) where  [Region]=p.[r]) 
										when ''D'' then  (select   top 1 cs from [dbo].[Goals_Pivoted](nolock) where  [District]=p.[d])  
								end) as decimal(18,1) )' else ' null ' end 
								+' as [Goal] 
						from (
							select TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d ,Store s,value,AL
							from   c1
							 unpivot(Value for Variable in('+quotename(@kpi)+','+quotename(@kpi+'!B')+')) up
						 )ut
						  pivot( sum(Value) for TP in('+@ps1+')) p
							  
					order by  g,r,d,s
						'   ;
				 set @sql=@raw+@customer_cash_score ;
				 ---select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int ', @YEAR_NEW   ;
   end
     set nocount off ;
end

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_20150623BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,410,5697
[dbo].[p_get_KpiBreakdown_test] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,-1,-1
[p_get_KpiBreakdown] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
[p_get_KpiBreakdown_test] 3,9,'Recommend','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown_test] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown_test] 3,9,'Customer CASH Score','',10 ,8 ,62 ,-1
exec [p_get_KpiBreakdown] 3,9,'Customer CASH Score','',10 ,8 ,62 ,-1

exec [dbo].[p_get_KpiBreakdown_test] 3,9,'SERVICE','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown] 3,9,'SERVICE','  ',10,40,300,6199
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
CREATE   procedure [dbo].[p_get_KpiBreakdown_20150623BAK](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
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
@Shopper_Segment  nvarchar(100)=''
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
			@where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int, 
		   @c2  nvarchar(max),
		   @kpi_id int;
  
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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;

---Raw Data with filter
	set @raw=concat(N' ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where   1=1  '+char(10),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+char(10)+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sc+')  ',
							@where_raw ,char(10)+'  )   ')+char(10)  ; 

----------------------------------------------------------------------------------------------------------------------------------------
	if @store is not null 
	begin
		set @c2=  ', case when  Store='+cast(@store as nvarchar)+
								isnull((select top 1 '  
										or (Grouping([Group])+ Grouping(Region) + Grouping(District)+ Grouping([Store]) =0 and  District='+cast(District as nvarchar)+' )
										or ( Grouping([Group])+ Grouping(Region)  + Grouping(District)=0 and Grouping([Store]) =1 and [district]='+cast(District as nvarchar)+' )
										or (  Grouping([Group])+ Grouping(Region)=0 and Grouping(District)=1 and [Region]='+cast(Region as nvarchar)+' )
										or ( Grouping([Group])=0 and Grouping(Region)=1 and [Group]='+cast( [Group] as nvarchar)+'  ) 
											'   from  [dbo].[Hierarchy](nolock)   where  Store=@store),'')+' or  Grouping([Group])=1 then 1 else 0 end as flag' 
	 end
	 else if   @district is not null 
	 begin
		set @c2= 	', case when   district='+cast(@district as nvarchar)+
								isnull((select top 1 '
										or ( Grouping([Group])+ Grouping(Region)  + Grouping(District)=0 and Grouping([Store]) =1  and  Region='+cast(Region as nvarchar)+'  ) 
										or ( Grouping([Group])+ Grouping(Region)=0 and Grouping(District)=1 and Region='+cast(Region as nvarchar)+' )
										or (Grouping([Group])=0 and Grouping(Region)=1 and [Group]='+cast([Group] as nvarchar)+' ) 
												'  from  [dbo].[Hierarchy](nolock)   where District= @district ),'')+'  or  Grouping([Group])=1 then 1 else 0 end as flag'
	 end
	 else if  @region is not null 
	 begin
		set @c2= 	', case when  [Region]='+cast(@region as nvarchar)+
									 isnull((select top 1 '
										Or ( Grouping([Group])+ Grouping(Region)=0 and Grouping(District)=1 and  [Group]='+cast([Group] as nvarchar)+'  )
										or (Grouping([Group])=0 and Grouping(Region)=1 and [Group]='+cast([Group] as nvarchar)+' )'
										 from  [dbo].[Hierarchy](nolock)   where  [Region]=@region ),'')+'   or  Grouping([Group])=1 then 1 
						      else 0 end as flag ' 
	 end  
	 else if @group is not null
	 begin
		set @c2= ', case when Region<0 or [District]<0 or [Group]<0   then 0 
						 when   [Group]='+cast(@group as nvarchar)+' or Grouping(Region)=1  or  Grouping([Group])=1 then 1 
						 else 0 end as flag '
	 end
	 else
	 begin
		set @c2= ',case when [Group]<0 or Region<0 or [District]<0  then 0 else  1 end as flag  '
	 end ;
-----------------------------------------------------------------------------------------------------------------------------------------
	
 	set @kpi_id=( select top 1 KPI_ID  from v_KPI where kpi=@kpi	);

	  if  @kpi_id<0
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)
   
   		    select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
				,@ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
				 
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;

			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';

				select  @ps2=@ps2+ ','+quotename(Variable)+ ','+quotename(Variable+'!B')
						, @headlinesbar=@headlinesbar+', 100* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end),0) as '+quotename(Variable)
						+',  sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end)  as '+quotename(Variable+'!B')
				from [dbo].[Headline_Variable] (nolock)  where KPI_ID=abs(@kpi_id);

				 
				set @ps2=stuff(@ps2,1,1,'') ;
			
 
				 set @headlinesbar=stuff(@headlinesbar,1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select isnull(  cast(  [QUARTER_NEW] as nvarchar)  ,''YTD'') as TP,[Group],[Region],District,Store,
									--------( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
									--------	   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
							 '+ @headlinesbar +char(10)+@c2+'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW '+(select concat(' and ( [Quarter_NEW] between ', min(Qrt_ID),' and ',max(qrt_id),' )') from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW)+'
						group by   Grouping sets( YEAR_NEW,   [QUARTER_NEW]  ) , Rollup([Group],  Region, District, Store)
						) 
						select concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
							   '+@ps3+' 
						from (select  TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store s,value
								from  (select * from  headline t where flag=1)   ft		
								unpivot(Value for Variable in('+@ps2+')) up
						 )ut
								pivot( sum(Value) for TP in('+@ps1+')) p  
						order by  g,r,d,s
		
						' ;
					 set @sql=@raw+@headlinesbar ;
				------select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int ', @YEAR_NEW   ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	

 else if  @kpi_id>0
		 begin 
 
		   set @ps3='' ;
		   set @ps1='' ;

		   if @kpi='Customer CASH Score'
		   begin
 				select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
						, @ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,1)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
				from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
		    
				set @ps1=N'[YTD],[YTD!Base]'+@ps1;
				set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,1)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';
		   end
		   else
		   begin
 			select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
					, @ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
		    
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;
			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';
		  end

				set @formcash='';
				select @formcash=@formcash+','+quotename(@kpi)+'= case when '+f.cs+' then null else 100*('+e.eq+') end' from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs] kpi(nolock)  where  KPI_ID=@kpi_id  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi(nolock)  where  KPI_ID=@kpi_id  for xml path('')),1,3,'' )) f ;
   
				select @formcash=@formcash+','+quotename(@kpi+'!B')+'= case when '+f.cs+' then null else ('+e.eq+') end' from  
					(select eq=stuff((select  '+isnull(',quotename(Variable+'!B'),',0)  '  from [dbo].[KPICalcs] kpi(nolock)  where  KPI_ID=@kpi_id for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable+'!B'),'  is null  ')  from [dbo].[KPICalcs] kpi(nolock)  where  KPI_ID=@kpi_id  for xml path('')),1,3,'' )) f ;
    
				select @form=@form+',	  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end) /nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0)   ) as '+quotename(Variable) 
								+',	sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight]/[WCNT] end) as '+quotename(Variable+'!B') 
					  ,@form1=@form1+'+ (case when '+quotename(Variable) +'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then cast(1.0 as float) else cast(0.0 as float) end) '
				from   [dbo].[KPICalcs](nolock)  where KPI_ID=@kpi_id ;

				set @form=stuff(@form,1,1,'') ;
				  
				 set @form=replace(@form,'/[WCNT]','/('+stuff(@form1,1,1,'')+')' );
	
				set @customer_cash_score=', cashscore as ( 
							select isnull( cast(  [QUARTER_NEW] as nvarchar),''YTD'') as TP,b.[Group],b.[Region],b.District,b.Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
									when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
									'+@form+char(10)+@c2+'
							from  rawdata as b  where YEAR_NEW= @YEAR_NEW  '+(select concat(' and ( [Quarter_NEW] between ', min(Qrt_ID),' and ',max(qrt_id),' )') from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW)+' 
							group by   Grouping sets( YEAR_NEW, [QUARTER_NEW]   ) ,Rollup(b.[Group],b.[Region],b.District,b.Store) 
						 ) 
						, c1 as (
						 select AL, TP, [Group], [Region], District, Store'+@formcash+'
						 from   cashscore 	  t  where flag=1
						)
						select  concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
						   '+@ps3+','+case when @kpi='Customer CASH Score' then  ' cast( 
						         (case AL when ''F'' then  (select top 1 cs from [dbo].[Goals_Pivoted](nolock) where overall=-1 )
										when ''G'' then  (select  top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Group]=p.[g]) 
										when ''R'' then  (select  top 1   cs from [dbo].[Goals_Pivoted](nolock) where  [Region]=p.[r]) 
										when ''D'' then  (select   top 1 cs from [dbo].[Goals_Pivoted](nolock) where  [District]=p.[d])  
								end) as decimal(18,1) )' else ' null ' end 
								+' as [Goal] 
						from (
							select TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d ,Store s,value,AL
							from   c1
							 unpivot(Value for Variable in('+quotename(@kpi)+','+quotename(@kpi+'!B')+')) up
						 )ut
						  pivot( sum(Value) for TP in('+@ps1+')) p
							  
					order by  g,r,d,s
						'   ;
				 set @sql=@raw+@customer_cash_score ;
				 ---select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int ', @YEAR_NEW   ;
   end
     set nocount off ;
end

 

GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_next]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'Customer CASH Score','',10 ,14 ,104,795

[dbo].[p_get_KpiBreakdown_next_base] 3,9,'Customer CASH Score','',-1 ,-1 ,-1,-1
[dbo].[p_get_KpiBreakdown_next_base] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,-1,-1

[dbo].[p_get_KpiBreakdown_next_base] 3,9,'SERVICE','',-1 ,-1 ,410 ,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'Customer CASH Score','',10 ,14 ,104,795
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'Customer CASH Score','',-1 ,-1 ,-1,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'Recommend','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'Recommend','  ',10,40,300,6199


exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',null,null,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',null,null,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,null,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,null,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,300,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,300,null


exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,300,6199
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
CREATE procedure [dbo].[p_get_KpiBreakdown_next](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
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
@Shopper_Segment  nvarchar(100)=''
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),@where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @KPI_ID int,
		   @c nvarchar(max),@groupby_1 nvarchar(4000)='' ,@groupby_2 nvarchar(4000)='' ;
  
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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;

	set @hierarchy	=coalesce(  ' and Store='+cast(@store as nvarchar)  ,
			           ' and District='+cast(@district as nvarchar)   ,
					   ' and [Region]='+cast(@region as nvarchar)  ,
					   ' and [Group]='+cast(@group as nvarchar)  ,
					 ''
					 ); 

   set @c=  coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (   district='+cast(@district as nvarchar)+' and Store >0)', 
								' and (  [Region]='+cast(@region as nvarchar)+'  and District >0) ' , 
								' and (  [Group]='+cast(@group as nvarchar)+' and Region >0 ) ',
								' and [Group] is null or [Group]>0 ');

	set @groupby_1= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						    case when  @district  is null then null else ', [Group],[Region],District,Store  ' end ,
						    case when  @region is null then null else ',[Group],[Region],District,cast(null as int) as Store' end,
						    case when  @group  is null then null else ',[Group],[Region],cast(null as int) as District,cast(null as int) as Store' end,
						    ',[Group],cast(null as int) as [Region],cast(null as int) as District,cast(null as int) as Store' );

	set @groupby_2= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						     case when  @district  is null then null else ',[Group],[Region],District,Store' end ,
						     case when  @region is null then null else ',[Group],[Region],District ' end,
						     case when  @group  is null then null else ',[Group],[Region]' end,
						     ',Rollup([Group])' );
 

---Raw Data with filter
	set @raw=concat(N';with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where   1=1  '+char(10),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+char(10)+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sc+')  ',
							@where_raw +char(10),'  )   ')+char(10)  ; 

     set @KPI_ID=(select top 1 KPI_ID from [dbo].[V_KPI] where KPI=@kpi);
	 if  @KPI_ID<0
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)
 
    
   		    select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
				,@ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
				 
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;

			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';


				select   @ps2=@ps2+','+quotename(Variable) + ','+quotename(Variable+'!B')
						,@headlinesbar=@headlinesbar+', 100.0* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+' in( '+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+' ) then [weight] end),0) as '+quotename(Variable)
													+', sum(case when  '+quotename(Variable)+' in( '+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+' ) then [weight] end) as '+quotename(Variable+'!B')
				 from [dbo].[Headline_Variable]  where  KPI_ID=abs(@KPI_ID );

				 set @ps2=stuff(@ps2,1,1,'') ;
	
				----set @ps1=N'[1],[2],[3],[4],[YTD],[1!Base],[2!Base],[3!Base],[4!Base],[YTD!Base]';

				----set @ps3=N'cast([1] as decimal(18,0)) [Quarter 1],cast([1!Base] as decimal(18,0)) [Q1!Base],cast([2] as decimal(18,0)) [Quarter 2],cast([2!Base] as decimal(18,0)) [Q2!Base],
				----cast([3] as decimal(18,0)) [Quarter 3],cast([3!Base] as decimal(18,0)) [Q3!Base],cast([4] as decimal(18,0)) [Quarter 4],cast([4!Base] as decimal(18,0)) [Q4!Base],
				----cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';
 

				set @headlinesbar=stuff(@headlinesbar,1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select isnull(  cast(  [QUARTER_NEW] as nvarchar)  ,''YTD'') as TP '+@groupby_1+'	,
							 '+ @headlinesbar +'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW   '+(select concat(' and ( [Quarter_NEW] between ', min(Qrt_ID),' and ',max(qrt_id),' )') from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW)+'
							'+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (  district='+cast(@district as nvarchar)+' )', 
								' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
								' and (  [Group]='+cast(@group as nvarchar)+') ',
								'  ')
								+'
						group by  Grouping Sets(YEAR_NEW,   [QUARTER_NEW] ) '+@groupby_2+'	
						)   
						select concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
							   '+@ps3+' 
						from (
							select  TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store s,value
							    from (
								         select * from headline t
												 where 		1=1	'  +@c+'							 
										) as ft		
										unpivot(Value for Variable in('+@ps2+')) up
						    ) ut
								pivot( sum(Value) for TP in('+@ps1+')) p
						
						order by g,r,d,s
		
						' +char(10) ;
					 set @sql=@raw+@headlinesbar ;
				----	  select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int', @YEAR_NEW  ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula
----------	The CASH score graph (shown here in green) will be colored red when lower than the goal, green when equal to or higher than to goal for the current team (when rounded to no decimal places). See the Goals worksheet for the goals. We have goals for group, region and district but not store. When store seleted this can just be grey.
----------	Can clicking on the Customer CASH score graph navigate the user to the KPI Breakdown page, with the CASH score selected?
----------Clealiness Score	See KPICalcs worksheet for formula
----------Assortment Score	See KPICalcs worksheet for formula
----------Service Score	See KPICalcs worksheet for formula
----------High Speed Score	See KPICalcs worksheet for formula
       else if  @KPI_ID>0
		 begin 
		  ------    if @kpi='Customer CASH Score'
			 ------ begin
				------set @ps1=N'[1],[2],[3],[4],[YTD],[1!Base],[2!Base],[3!Base],[4!Base],[YTD!Base]';

				------set @ps3=N'cast([1] as decimal(18,1)) [Quarter 1],cast([1!Base] as decimal(18,0)) [Q1!Base],cast([2] as decimal(18,1)) [Quarter 2], cast([2!Base] as decimal(18,0)) [Q2!Base],
				------			cast([3] as decimal(18,1)) [Quarter 3],cast([3!Base] as decimal(18,0)) [Q3!Base],cast([4] as decimal(18,1)) [Quarter 4], cast([4!Base] as decimal(18,0)) [Q4!Base],
				------			cast([YTD] as decimal(18,1)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,1)) [Goal]';
			 ------ end
			 ------ else 
			 ------ begin
				------	set @ps1=N'[1],[2],[3],[4],[YTD],[1!Base],[2!Base],[3!Base],[4!Base],[YTD!Base]';

				------	set @ps3=N'cast([1] as decimal(18,0)) [Quarter 1],cast([1!Base] as decimal(18,0)) [Q1!Base],cast([2] as decimal(18,0)) [Quarter 2], cast([2!Base] as decimal(18,0)) [Q2!Base],
				------				cast([3] as decimal(18,0)) [Quarter 3],cast([3!Base] as decimal(18,0)) [Q3!Base],cast([4] as decimal(18,0)) [Quarter 4], cast([4!Base] as decimal(18,0)) [Q4!Base],
				------				cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,0)) [Goal]';
			 ------ end

		   set @ps3='' ;
		   set @ps1='' ;

		   if @kpi='Customer CASH Score'
		   begin
 				select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
						, @ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,1)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
				from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
		    
				set @ps1=N'[YTD],[YTD!Base]'+@ps1;
				set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,1)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,1))  [Goal] ';
		   end
		   else
		   begin
 			select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
					, @ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
		    
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;
			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,1))  [Goal] ';
		  end


				set @formcash='';
				select @formcash=@formcash+','+quotename(@kpi)+'= case when '+f.cs+' then null else 100*('+e.eq+') end' from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,3,'' )) f ;
   
				select @formcash=@formcash+','+quotename(@kpi+'!B')+'= case when '+f.cs+' then null else ('+e.eq+') end' from  
					(select eq=stuff((select  '+isnull(',quotename(Variable+'!B'),',0)  '  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable+'!B'),'  is null  ')  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,3,'' )) f ;
    
				select @form=@form+',	  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end) /nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0)   ) as '+quotename(Variable) 
								+',	sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight]/[WCNT] end) as '+quotename(Variable+'!B') 
					  ,@form1=@form1+'+ (case when '+quotename(Variable) +'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then cast(1.0 as float) else cast(0.0 as float) end) '
				from   [dbo].[KPICalcs] where  KPI_ID=@KPI_ID 	 ;

				set @form=stuff(@form,1,1,'') ;
				  
				 set @form=replace(@form,'/[WCNT]','/('+stuff(@form1,1,1,'')+')' );

	
				set @customer_cash_score=', cashscore as ( 
							select isnull( cast(  [QUARTER_NEW] as nvarchar),''YTD'') as TP '+@groupby_1+'	,
									'+@form+'
							from  rawdata   where YEAR_NEW= @YEAR_NEW   '+(select concat(' and ( [Quarter_NEW] between ', min(Qrt_ID),' and ',max(qrt_id),' )') from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW)+'
							'+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (  district='+cast(@district as nvarchar)+' )', 
								' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
								' and (  [Group]='+cast(@group as nvarchar)+') ',
								'  ')
								+'							 
							group by Grouping Sets(YEAR_NEW, [QUARTER_NEW]  ) '+@groupby_2+' 
						 )
						, c1 as (
						 select TP, [Group], [Region], District, Store'+@formcash+','
						 +case when @kpi='Customer CASH Score' then  '
								 (case  when Store is not null then null
										when [District] is not null  then (select top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [District]=t.[District])  
										when [Region] is not null    then (select  top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Region]=t.[Region]) 
										when [Group] is not null then (select top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Group]=t.[Group]) 
										else  (select top 1 cs from [dbo].[Goals_Pivoted](nolock) where overall=-1 ) 
								end) ' else ' null ' end +'  as [Goal] 
						 from  cashscore  t 
								where 		1=1	'  +@c+'									 
						)
						select  concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
						   '+@ps3+'
						   from (
							   select TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store  s,value,[Goal]
								from   c1
								 unpivot(Value for Variable in('+quotename(@kpi)+','+quotename(@kpi+'!B')+')) up
							 )ut
							 pivot( sum(Value) for TP in('+@ps1+')) p
					order by g,r,d,s
						'   +char(10) ;
				 set @sql=@raw+@customer_cash_score ;
				 ---select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int', @YEAR_NEW ;
   end

set nocount off ;
end

 

GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_next_20150305BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,410,5697
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','',-1 ,-1 ,410 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
create procedure [dbo].[p_get_KpiBreakdown_next_20150305BAK](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
@group int  , 
@region int  ,
@district int  ,
@store  int 
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @hierarchy nvarchar(max)='';
  
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	

	set @hierarchy	=coalesce(case when  @store  is null then null else ' and Store='+cast(@store as nvarchar) end,
			         case when  @district  is null then null else ' and District='+cast(@district as nvarchar) end ,
					 case when  @region  is null then null else ' and [Region]='+cast(@region as nvarchar) end,
					 case when  @group  is null then null else ' and [Group]='+cast(@group as nvarchar) end,
					 ''
					 );

---Raw Data with filter
	set @raw=concat(N'print @YEAR_NEW; print @QUARTER_NEW  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy]    where 1=1 ',@wherecondition,')   ')+char(10)  ; 
	 
	 if exists(select top 1 idx from V_KPI where kpi=@kpi and idx=2) 
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)

				set @formhead=''	  
				select @formhead=@formhead+', format(isnull('+quotename(Variable)+',0),''0%'') '   from [dbo].[Headline_Variable]  where title=@kpi ;

				set @ps1=N'[Quarter 1],[Quarter 2],[Quarter 3],[Quarter 4],[YTD]';

				select @ps2=stuff((select ','+quotename(Variable) from [dbo].[Headline_Variable] where title=@kpi  for xml path('')),1,1,'') ;

				set @ps3=N'cast([Quarter 1] as int) [Quarter 1],cast([Quarter 2] as int) [Quarter 2],cast([Quarter 3] as int) [Quarter 3],cast([Quarter 4] as int) [Quarter 4],cast([YTD] as int) [YTD]';

				set @headlinesbar=stuff((select ', 100* sum(case when  '+quotename(Variable)+' between 6 and 7 then 1 end)*1.0/nullif(sum(case when  '+quotename(Variable)+' between 1 and 7 then 1 else 0 end),0) as '+quotename(Variable)+char(10) from [dbo].[Headline_Variable] where title=@kpi  for xml path('')),1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  ) as TP,[Group],[Region],District,Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
										   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
							 '+ @headlinesbar +'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW   
						group by   concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  ) ,Rollup([Group],  Region, District, Store)
						) 
						,ytd as (
									select [Group],[Region],District,Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
										   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
									 '+ @headlinesbar +'	
								from rawdata   where DATE_NUM<convert(varchar(10),getdate()-1,112) and YEAR_NEW= @YEAR_NEW   
								group by    Rollup([Group],  Region, District, Store) 
						) 
						,tab as  (
						select * 				from headline 			 
						union all
						select ''YTD'' TP,* 	from ytd  
						) 
						select concat(''Group '',[Group]) [Group],concat(''Region '',[Region]) [Region],concat(''District '',[District]) [District],concat(''Store '',[Store]) [Store],
							   '+@ps3+' 
					    from (
						select * from tab t
										 where 		1=1	'  + 
						coalesce( ' and Store='+cast(@store as nvarchar)+'  
									--or (AL=''S'' and exists(select * from [dbo].[Hierarchy] where Store=t.Store and District=(select top 1 district from [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') ))
									--or (AL=''D'' and [district]=(select top 1 district from [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') )
									--or (AL=''R'' and [Region]=(select top 1 [Region]   from  [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') )
									--or (AL=''G'' and [Group]=(select top 1 [Group]   from  [dbo].[Hierarchy]  where  Store='+cast(@store as nvarchar)+') ) 
										', 
								' and  (AL=''S'' and  district='+cast(@district as nvarchar)+' )
								  --  or (AL=''D'' and exists(select district from  [dbo].[Hierarchy] where District=t.District and  Region=(select top 1 [Region] from [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') ) ) 
								  --	or (AL=''R'' and Region=(select top 1 [Region] from [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') )
								--	or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') ) 
											', 
								' and (AL=''D'' and [Region]='+cast(@region as nvarchar)+' )
									--Or (AL=''R'' and exists(select Region from [dbo].[Hierarchy] where [Region]=t.[Region] and  [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where  [Region]='+cast(@region as nvarchar)+') ) )
									--or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where  [Region]='+cast(@region as nvarchar)+') )' ,

								' and (AL=''R'' and [Group]='+cast(@group as nvarchar)+') 
								  ---or AL=''G'' ',
								' and AL=''G''  ')+'
								---or AL=''F'' 
								) as ft		
								unpivot(Value for Variable in('+@ps2+')) up
								pivot( sum(Value) for TP in('+@ps1+')) p

						order by cast(replace([Group],''Group '','''') as int),cast(replace([Region],''Region '','''') as int),cast(Replace([District],''District '','''') as int),cast(Replace([Store],''Store '','''') as int)
		
						' +char(10) ;
					 set @sql=@raw+@headlinesbar ;
					--select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int,   @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula
----------	The CASH score graph (shown here in green) will be colored red when lower than the goal, green when equal to or higher than to goal for the current team (when rounded to no decimal places). See the Goals worksheet for the goals. We have goals for group, region and district but not store. When store seleted this can just be grey.
----------	Can clicking on the Customer CASH score graph navigate the user to the KPI Breakdown page, with the CASH score selected?
----------Clealiness Score	See KPICalcs worksheet for formula
----------Assortment Score	See KPICalcs worksheet for formula
----------Service Score	See KPICalcs worksheet for formula
----------High Speed Score	See KPICalcs worksheet for formula
 if exists(select top 1 idx from V_KPI where kpi=@kpi and idx=1)
		 begin 
				set @ps1=N'[Quarter 1],[Quarter 2],[Quarter 3],[Quarter 4],[YTD]';

				set @ps3=N'cast([Quarter 1] as int) [Quarter 1],cast([Quarter 2] as int) [Quarter 2],cast([Quarter 3] as int) [Quarter 3],cast([Quarter 4] as int) [Quarter 4],cast([YTD] as int) [YTD],cast([Goal] as int) [Goal]';
  
				set @formcash='';
				select @formcash=@formcash+','+quotename(kpi)+'= 100*('+e.eq+') ' from 
					(select distinct kpi,L2 from [dbo].[KPICalcs] where kpi=@kpi)  l outer apply
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.L2=l.L2  for xml path('')),1,1,'' )) e
		 
				select @form=@form+',
								  ( sum(case when '+quotename(Variable)+' in('+stuff((select top 1 Right(Vl.Value,2*[TOP N BOX SCORE]) from [KPICalcs] k where k.Variable=vr.Variable ),1,1,'')+')  then 1 end)*1.0			 
								  /sum(case when '+quotename(Variable)+' in('+Value+')  then 1 end)   ) as '+quotename(Variable) 
				from ( select distinct Variable  from [dbo].[KPICalcs] where kpi=@kpi ) vr 	outer apply 
					 ( select Value=STUFF((select ','+cast(Value as varchar(10))  from  [dbo].[Variable_Values] val where Value<=7 and  val.Variable=vr.Variable   order by Value for xml path('')),1,1,'' )  	) Vl ;
    
				set @form=stuff(@form,1,1,'') ;

				select @form1=@form1+', null as '+quotename(Variable) 
				from ( select distinct Variable  from [dbo].[KPICalcs] where kpi=@kpi ) vr 	outer apply 
					 ( select Value=STUFF((select ','+cast(Value as varchar)  from  [dbo].[Variable_Values] val where Value<=7 and  val.Variable=vr.Variable   order by Value for xml path('')),1,1,'' )  	) Vl ;
    
				set @form1=stuff(@form1,1,1,'') ;
	
				set @customer_cash_score=', cashscore as ( 
							select concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  ) as TP,b.[Group],b.[Region],b.District,b.Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
									when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
									'+@form+'
							from  rawdata as b  where YEAR_NEW= @YEAR_NEW    
							group by concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  ),Rollup(b.[Group],b.[Region],b.District,b.Store) 
						 ) 
						 ,ytd as (
						 select ''YTD'' as TP,b.[Group],b.[Region],b.District,b.Store,
								( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
									   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
								'+@form+'
						from  rawdata as b  where DATE_NUM<convert(varchar(10),getdate()-1,112) and YEAR_NEW= @YEAR_NEW   
						group by  Rollup(b.[Group],b.[Region],b.District,b.Store)
						)
						, c1 as (
						 select TP, [Group], [Region], District, Store'+@formcash+',
								100*(case AL when ''F'' then  (select top 1 [Cash Survey] from [dbo].[Goals] where [Goal Level]=''Overall'')
										when ''G'' then  (select top 1 [Cash Survey] from [dbo].[Goals] where [Goal Level]=''Group'' and [id]=t.[Group]) 
										when ''R'' then  (select top 1 [Cash Survey] from [dbo].[Goals] where [Goal Level]=''Region'' and [id]=t.[Region]) 
										when ''D'' then  (select top 1 [Cash Survey] from [dbo].[Goals] where [Goal Level]=''District'' and [id]=t.[District]) 
										when ''S'' then null
								end) as [Goal] 
						 from(
								select * from  cashscore 
								union all
								select * from ytd
							) t
								where 		1=1	'  + 
								coalesce( ' and   store='+cast(@store as nvarchar)+'  
										--	or (AL=''S'' and exists(select * from [dbo].[Hierarchy] where Store=t.Store and District=(select top 1 district from [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') ))
										--	or (AL=''D'' and district=(select top 1 district from [dbo].[Hierarchy]  where Store='+cast(@store as nvarchar)+') )
										--	or (AL=''R'' and Region=(select top 1 [Region] from [dbo].[Hierarchy]  where Store='+cast(@store as nvarchar)+') )
										--	or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') ) 
												',

										' and  (AL=''S'' and  district='+cast(@district as nvarchar)+'  )
										--	or (AL=''D'' and exists(select district from  [dbo].[Hierarchy] where District=t.District and  Region=(select top 1 [Region] from [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') ) ) 
										--	or (AL=''R'' and Region=(select top 1 [Region] from [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') )
										--	or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') ) 
													', 
										' and (AL=''D'' and   [Region]='+cast(@region as nvarchar)+' )
										--	Or (AL=''R'' and exists(select Region from [dbo].[Hierarchy] where [Region]=t.[Region] and  [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where  [Region]='+cast(@region as nvarchar)+') ) )
										--	or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where  [Region]='+cast(@region as nvarchar)+') )' ,

										' and (AL=''R'' and [Group]='+cast(@group as nvarchar)+') 
										-- or AL=''G'' ',
										' and AL=''G''  ')+'
										---or AL=''F'' 
						)
						select  concat(''Group '',[Group]) [Group],concat(''Region '',[Region]) [Region],concat(''District '',[District]) [District],concat(''Store '',[Store]) [Store],
						   '+@ps3+'
						from   c1
							 unpivot(Value for Variable in('+quotename(@kpi)+')) up
							 pivot( sum(Value) for TP in('+@ps1+')) p
					order by cast(replace([Group],''Group '','''') as int),cast(replace([Region],''Region '','''') as int),cast(Replace([District],''District '','''') as int),cast(Replace([Store],''Store '','''') as int)
						'   +char(10) ;
				 set @sql=@raw+@customer_cash_score ;
				 ---select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int, @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
   end

set nocount off ;
end

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_next_20150309BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,410,5697
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,-1,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','',-1 ,-1 ,410 ,-1
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
CREATE procedure [dbo].[p_get_KpiBreakdown_next_20150309BAK](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
@group int  , 
@region int  ,
@district int  ,
@store  int 
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @idx int;
  
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	

			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	

	set @hierarchy	=coalesce(case when  @store  is null then null else ' and Store='+cast(@store as nvarchar) end,
			         case when  @district  is null then null else ' and District='+cast(@district as nvarchar) end ,
					 case when  @region  is null then null else ' and [Region]='+cast(@region as nvarchar) end,
					 case when  @group  is null then null else ' and [Group]='+cast(@group as nvarchar) end,
					 ''
					 );

---Raw Data with filter
	set @raw=concat(N'print @YEAR_NEW; print @QUARTER_NEW  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 

      select top 1 @idx= idx from V_KPI where kpi=@kpi ;

	 if  ( @idx=2) 
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)
 
				select @formhead=@formhead+', format(isnull('+quotename(Variable)+',0),''0%'') '
				,@ps2=@ps2+','+quotename(Variable)  
				 from [dbo].[Headline_Variable]  where title=@kpi ;
				 set @ps2=stuff(@ps2,1,1,'') ;
	
				set @ps1=N'[Quarter 1],[Quarter 2],[Quarter 3],[Quarter 4],[YTD]';

				set @ps3=N'cast([Quarter 1] as int) [Quarter 1],cast([Quarter 2] as int) [Quarter 2],cast([Quarter 3] as int) [Quarter 3],cast([Quarter 4] as int) [Quarter 4],cast([YTD] as int) [YTD]';

				set @headlinesbar=stuff((select ', 100* sum(case when  '+quotename(Variable)+' between 6 and 7 then [weight] end)/nullif(sum(case when  '+quotename(Variable)+' between 1 and 7 then [weight] end),0) as '+quotename(Variable)+char(10) from [dbo].[Headline_Variable] where title=@kpi  for xml path('')),1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select isnull(concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  ),''YTD'') as TP,[Group],[Region],District,Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
										   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
							 '+ @headlinesbar +'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW   
						group by  Grouping Sets(Year_new, concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  )) ,Rollup([Group],  Region, District, Store)
						)   
						select concat(''Group '',[Group]) [Group],concat(''Region '',[Region]) [Region],concat(''District '',[District]) [District],concat(''Store '',[Store]) [Store],
							   '+@ps3+' 
					    from (
						select * from headline t
										 where 		1=1	'  + 
						coalesce( ' and Store='+cast(@store as nvarchar)+'  
									--or (AL=''S'' and exists(select * from [dbo].[Hierarchy] where Store=t.Store and District=(select top 1 district from [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') ))
									--or (AL=''D'' and [district]=(select top 1 district from [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') )
									--or (AL=''R'' and [Region]=(select top 1 [Region]   from  [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') )
									--or (AL=''G'' and [Group]=(select top 1 [Group]   from  [dbo].[Hierarchy]  where  Store='+cast(@store as nvarchar)+') ) 
										', 
								' and  (AL=''S'' and  district='+cast(@district as nvarchar)+' )
								  --  or (AL=''D'' and exists(select district from  [dbo].[Hierarchy] where District=t.District and  Region=(select top 1 [Region] from [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') ) ) 
								  --	or (AL=''R'' and Region=(select top 1 [Region] from [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') )
								--	or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') ) 
											', 
								' and (AL=''D'' and [Region]='+cast(@region as nvarchar)+' )
									--Or (AL=''R'' and exists(select Region from [dbo].[Hierarchy] where [Region]=t.[Region] and  [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where  [Region]='+cast(@region as nvarchar)+') ) )
									--or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where  [Region]='+cast(@region as nvarchar)+') )' ,

								' and (AL=''R'' and [Group]='+cast(@group as nvarchar)+') 
								  ---or AL=''G'' ',
								' and AL=''G'' or AL=''F'' ')+'
							 
								) as ft		
								unpivot(Value for Variable in('+@ps2+')) up
								pivot( sum(Value) for TP in('+@ps1+')) p

						order by cast(replace([Group],''Group '','''') as int),cast(replace([Region],''Region '','''') as int),cast(Replace([District],''District '','''') as int),cast(Replace([Store],''Store '','''') as int)
		
						' +char(10) ;
					 set @sql=@raw+@headlinesbar ;
					--select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int,   @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula
----------	The CASH score graph (shown here in green) will be colored red when lower than the goal, green when equal to or higher than to goal for the current team (when rounded to no decimal places). See the Goals worksheet for the goals. We have goals for group, region and district but not store. When store seleted this can just be grey.
----------	Can clicking on the Customer CASH score graph navigate the user to the KPI Breakdown page, with the CASH score selected?
----------Clealiness Score	See KPICalcs worksheet for formula
----------Assortment Score	See KPICalcs worksheet for formula
----------Service Score	See KPICalcs worksheet for formula
----------High Speed Score	See KPICalcs worksheet for formula
 else if  (@idx=1)
		 begin 
				set @ps1=N'[Quarter 1],[Quarter 2],[Quarter 3],[Quarter 4],[YTD]';

				set @ps3=N'cast([Quarter 1] as int) [Quarter 1],cast([Quarter 2] as int) [Quarter 2],cast([Quarter 3] as int) [Quarter 3],cast([Quarter 4] as int) [Quarter 4],cast([YTD] as int) [YTD],cast([Goal] as int) [Goal]';
  
				set @formcash='';
				select @formcash=@formcash+','+quotename(@kpi)+'= case when '+f.cs+' then null else 100*('+e.eq+') end' from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs3] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs3] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;
   
		 
				select @form=@form+',
								  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] end)			 
								  /nullif(sum(case when '+quotename(Variable)+' between 1 and 7  then [weight] end),0)   ) as '+quotename(Variable) 
								  ,@form1=@form1+', null as '+quotename(Variable) 
				from ( select distinct Variable ,TopNbox from [dbo].[KPICalcs3] where kpi=@kpi ) vr 	 ;

				set @form=stuff(@form,1,1,'') ;
				  
				set @form1=stuff(@form1,1,1,'') ;
	
				set @customer_cash_score=', cashscore as ( 
							select isnull(concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  ),''YTD'') as TP,b.[Group],b.[Region],b.District,b.Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
									when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
									'+@form+'
							from  rawdata as b  where YEAR_NEW= @YEAR_NEW    
							group by Grouping Sets(Year_New, concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  )),Rollup(b.[Group],b.[Region],b.District,b.Store) 
						 )
						 ,gl as (
						      select [Overall],[Group],[Region],[District],100*[CASH Survey] cs
						       from [dbo].[Goals] pivot(max(ID) for [Goal Level] in( [Group],[Region],[District],[Overall]))p 
							) 
						, c1 as (
						 select TP, [Group], [Region], District, Store'+@formcash+',
								 (case AL when ''F'' then  (select  cs from gl where overall<=-1 )
										when ''G'' then  (select  cs from gl where  [Group]=t.[Group]) 
										when ''R'' then  (select   cs from gl where  [Region]=t.[Region]) 
										when ''D'' then  (select  cs from gl where  [District]=t.[District])  
								end) as [Goal] 
						 from  cashscore  t 
								where 		1=1	'  + 
								coalesce( ' and   store='+cast(@store as nvarchar)+'  
										--	or (AL=''S'' and exists(select * from [dbo].[Hierarchy] where Store=t.Store and District=(select top 1 district from [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') ))
										--	or (AL=''D'' and district=(select top 1 district from [dbo].[Hierarchy]  where Store='+cast(@store as nvarchar)+') )
										--	or (AL=''R'' and Region=(select top 1 [Region] from [dbo].[Hierarchy]  where Store='+cast(@store as nvarchar)+') )
										--	or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where Store='+cast(@store as nvarchar)+') ) 
												',

										' and  (AL=''S'' and  district='+cast(@district as nvarchar)+'  )
										--	or (AL=''D'' and exists(select district from  [dbo].[Hierarchy] where District=t.District and  Region=(select top 1 [Region] from [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') ) ) 
										--	or (AL=''R'' and Region=(select top 1 [Region] from [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') )
										--	or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where District='+cast(@district as nvarchar)+') ) 
													', 
										' and (AL=''D'' and   [Region]='+cast(@region as nvarchar)+' )
										--	Or (AL=''R'' and exists(select Region from [dbo].[Hierarchy] where [Region]=t.[Region] and  [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where  [Region]='+cast(@region as nvarchar)+') ) )
										--	or (AL=''G'' and [Group]=(select top 1 [Group] from  [dbo].[Hierarchy] where  [Region]='+cast(@region as nvarchar)+') )' ,

										' and (AL=''R'' and [Group]='+cast(@group as nvarchar)+') 
										-- or AL=''G'' ',
										' and AL=''G''  or AL=''F''')+'
									 
						)
						select  concat(''Group '',[Group]) [Group],concat(''Region '',[Region]) [Region],concat(''District '',[District]) [District],concat(''Store '',[Store]) [Store],
						   '+@ps3+'
						from   c1
							 unpivot(Value for Variable in('+quotename(@kpi)+')) up
							 pivot( sum(Value) for TP in('+@ps1+')) p
					order by cast(replace([Group],''Group '','''') as int),cast(replace([Region],''Region '','''') as int),cast(Replace([District],''District '','''') as int),cast(Replace([Store],''Store '','''') as int)
						'   +char(10) ;
				 set @sql=@raw+@customer_cash_score ;
				--- select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int, @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
   end

set nocount off ;
end

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_next_20150316BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'Customer CASH Score','',10 ,14 ,104,795
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'Customer CASH Score','',10 ,14 ,104,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,-1,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','',-1 ,-1 ,410 ,-1
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'Customer CASH Score','',10 ,14 ,104,795
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'Customer CASH Score','',-1 ,-1 ,-1,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'Recommend','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'Recommend','  ',10,40,300,6199
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
create procedure [dbo].[p_get_KpiBreakdown_next_20150316BAK](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
@group int  , 
@region int  ,
@district int  ,
@store  int 
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @idx int,
		   @c nvarchar(max);
  
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	

			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	

	set @hierarchy	=coalesce(case when  @store  is null then null else ' and Store='+cast(@store as nvarchar) end,
			         case when  @district  is null then null else ' and District='+cast(@district as nvarchar) end ,
					 case when  @region  is null then null else ' and [Region]='+cast(@region as nvarchar) end,
					 case when  @group  is null then null else ' and [Group]='+cast(@group as nvarchar) end,
					 ''
					 );

   set @c=  coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (AL=''S'' and  district='+cast(@district as nvarchar)+' )', 
								' and (AL=''D'' and [Region]='+cast(@region as nvarchar)+' )  ' , 
								' and (AL=''R'' and [Group]='+cast(@group as nvarchar)+') ',
								' and AL=''G'' or AL=''F'' ');
---Raw Data with filter
	set @raw=concat(N'print @YEAR_NEW; print @QUARTER_NEW  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 

      select top 1 @idx= idx from V_KPI where kpi=@kpi ;

	 if  ( @idx=2) 
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)
 
				select @formhead=@formhead+', format(isnull('+quotename(Variable)+',0),''0%'') '
				,@ps2=@ps2+','+quotename(Variable)  
				 from [dbo].[Headline_Variable]  where title=@kpi ;
				 set @ps2=stuff(@ps2,1,1,'') ;
	
				set @ps1=N'[Quarter 1],[Quarter 2],[Quarter 3],[Quarter 4],[YTD]';

				set @ps3=N'cast([Quarter 1] as decimal(18,0)) [Quarter 1],cast([Quarter 2] as decimal(18,0)) [Quarter 2],cast([Quarter 3] as decimal(18,0)) [Quarter 3],cast([Quarter 4] as decimal(18,0)) [Quarter 4],cast([YTD] as decimal(18,0)) [YTD]';
				----set @ps3=N'cast([Quarter 1] as int) [Quarter 1],cast([Quarter 2] as int) [Quarter 2],cast([Quarter 3] as int) [Quarter 3],cast([Quarter 4] as int) [Quarter 4],cast([YTD] as int) [YTD]';
				select @headlinesbar=@headlinesbar+', 100.0* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] end)/nullif(sum(case when  '+quotename(Variable)+' between '+cast(min_value_valid as nvarchar(2))+' and '+cast(max_value_valid as nvarchar(2))+' then [weight] end),0) as '+quotename(Variable)
				 from [dbo].[Headline_Variable] where title=@kpi ;

				set @headlinesbar=stuff(@headlinesbar,1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select isnull(concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  ),''YTD'') as TP,[Group],[Region],District,Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
										   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
							 '+ @headlinesbar +'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW   
							'+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (  district='+cast(@district as nvarchar)+' )', 
								' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
								' and (  [Group]='+cast(@group as nvarchar)+') ',
								'  ')
								+'
						group by  Grouping Sets(Year_new, concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  )) ,Rollup([Group],  Region, District, Store)
						)   
						select concat(''Group '',[Group]) [Group],concat(''Region '',[Region]) [Region],concat(''District '',[District]) [District],concat(''Store '',[Store]) [Store],
							   '+@ps3+' 
					    from (
						select * from headline t
										 where 		1=1	'  +@c+'							 
								) as ft		
								unpivot(Value for Variable in('+@ps2+')) up
								pivot( sum(Value) for TP in('+@ps1+')) p

						order by cast(replace([Group],''Group '','''') as int),cast(replace([Region],''Region '','''') as int),cast(Replace([District],''District '','''') as int),cast(Replace([Store],''Store '','''') as int)
		
						' +char(10) ;
					 set @sql=@raw+@headlinesbar ;
					---  select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int,   @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula
----------	The CASH score graph (shown here in green) will be colored red when lower than the goal, green when equal to or higher than to goal for the current team (when rounded to no decimal places). See the Goals worksheet for the goals. We have goals for group, region and district but not store. When store seleted this can just be grey.
----------	Can clicking on the Customer CASH score graph navigate the user to the KPI Breakdown page, with the CASH score selected?
----------Clealiness Score	See KPICalcs worksheet for formula
----------Assortment Score	See KPICalcs worksheet for formula
----------Service Score	See KPICalcs worksheet for formula
----------High Speed Score	See KPICalcs worksheet for formula
 else if  (@idx=1)
		 begin 
				set @ps1=N'[Quarter 1],[Quarter 2],[Quarter 3],[Quarter 4],[YTD]';

				set @ps3=N'cast([Quarter 1] as decimal(18,0)) [Quarter 1],cast([Quarter 2] as decimal(18,0)) [Quarter 2],cast([Quarter 3] as decimal(18,0)) [Quarter 3],cast([Quarter 4] as decimal(18,0)) [Quarter 4],cast([YTD] as decimal(18,0)) [YTD],cast([Goal] as decimal(18,0)) [Goal]';
				--set @ps3=N'cast([Quarter 1] as int) [Quarter 1],cast([Quarter 2] as int) [Quarter 2],cast([Quarter 3] as int) [Quarter 3],cast([Quarter 4] as int) [Quarter 4],cast([YTD] as int) [YTD],cast([Goal] as int) [Goal]';
  
				set @formcash='';
				select @formcash=@formcash+','+quotename(@kpi)+'= case when '+f.cs+' then null else 100*('+e.eq+') end' from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs3] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs3] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;
   
		 
				select @form=@form+',
								  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] end)			 
								  /nullif(sum(case when '+quotename(Variable)+' between '+cast(min_value_valid as nvarchar(2))+' and '+cast(max_value_valid as nvarchar(2))+'  then [weight] end),0)   ) as '+quotename(Variable) 
								  ,@form1=@form1+', null as '+quotename(Variable) 
				from   [dbo].[KPICalcs3] where kpi=@kpi 	 ;

				set @form=stuff(@form,1,1,'') ;
				  
				set @form1=stuff(@form1,1,1,'') ;
	
				set @customer_cash_score=', cashscore as ( 
							select isnull(concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  ),''YTD'') as TP,[Group],[Region],District,Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
									when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
									'+@form+'
							from  rawdata   where YEAR_NEW= @YEAR_NEW   
							'+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (  district='+cast(@district as nvarchar)+' )', 
								' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
								' and (  [Group]='+cast(@group as nvarchar)+') ',
								'  ')
								+'							 
							group by Grouping Sets(Year_New, concat(''Quarter '',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  )),Rollup( [Group], [Region], District, Store) 
						 )
						 ,gl as (
						      select [Overall],[Group],[Region],[District],100*[CASH Survey] cs
						       from [dbo].[Goals] pivot(max(ID) for [Goal Level] in( [Group],[Region],[District],[Overall]))p 
							) 
						, c1 as (
						 select TP, [Group], [Region], District, Store'+@formcash+',
								 (case AL when ''F'' then  (select  cs from gl where overall<=-1 )
										when ''G'' then  (select  cs from gl where  [Group]=t.[Group]) 
										when ''R'' then  (select   cs from gl where  [Region]=t.[Region]) 
										when ''D'' then  (select  cs from gl where  [District]=t.[District])  
								end) as [Goal] 
						 from  cashscore  t 
								where 		1=1	'  +@c+'									 
						)
						select  concat(''Group '',[Group]) [Group],concat(''Region '',[Region]) [Region],concat(''District '',[District]) [District],concat(''Store '',[Store]) [Store],
						   '+@ps3+'
						from   c1
							 unpivot(Value for Variable in('+quotename(@kpi)+')) up
							 pivot( sum(Value) for TP in('+@ps1+')) p
					order by cast(replace([Group],''Group '','''') as int),cast(replace([Region],''Region '','''') as int),cast(Replace([District],''District '','''') as int),cast(Replace([Store],''Store '','''') as int)
						'   +char(10) ;
				 set @sql=@raw+@customer_cash_score ;
				 ---select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int, @QUARTER_NEW int', @YEAR_NEW,  @QUARTER_NEW  ;
   end

set nocount off ;
end

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_next_20150403BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'Customer CASH Score','',10 ,14 ,104,795
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'Customer CASH Score','',10 ,14 ,104,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,-1,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','',-1 ,-1 ,410 ,-1
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'Customer CASH Score','',10 ,14 ,104,795
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'Customer CASH Score','',-1 ,-1 ,-1,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'Recommend','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'Recommend','  ',10,40,300,6199


exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',null,null,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',null,null,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,null,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,null,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,300,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,300,null


exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,300,6199
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
CREATE procedure [dbo].[p_get_KpiBreakdown_next_20150403BAK](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
@group int  , 
@region int  ,
@district int  ,
@store  int 
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @idx int,
		   @c nvarchar(max),@groupby_1 nvarchar(4000)='' ,@groupby_2 nvarchar(4000)='' ;
  
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	

			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	

	set @hierarchy	=coalesce(  ' and Store='+cast(@store as nvarchar)  ,
			           ' and District='+cast(@district as nvarchar)   ,
					   ' and [Region]='+cast(@region as nvarchar)  ,
					   ' and [Group]='+cast(@group as nvarchar)  ,
					 ''
					 ); 

   set @c=  coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (   district='+cast(@district as nvarchar)+' and Store is not null)', 
								' and (  [Region]='+cast(@region as nvarchar)+'  and District is not null) ' , 
								' and (  [Group]='+cast(@group as nvarchar)+' and Region is not null ) ',
								'   ');

	set @groupby_1= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						    case when  @district  is null then null else ', [Group],[Region],District,Store  ' end ,
						    case when  @region is null then null else ',[Group],[Region],District,cast(null as int) as Store' end,
						    case when  @group  is null then null else ',[Group],[Region],cast(null as int) as District,cast(null as int) as Store' end,
						    ',[Group],cast(null as int) as [Region],cast(null as int) as District,cast(null as int) as Store' );

	set @groupby_2= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						     case when  @district  is null then null else ',[Group],[Region],Rollup(District,Store)' end ,
						     case when  @region is null then null else ',[Group],Rollup([Region],District) ' end,
						     case when  @group  is null then null else ',Rollup([Group],[Region])' end,
						     ',Rollup([Group])' );
 
---Raw Data with filter
	set @raw=concat(N';with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 and district>0  ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 

      select top 1 @idx= idx from V_KPI where kpi=@kpi ;

	 if  ( @idx=2) 
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)
 
				select  ------ @formhead=@formhead+', format(isnull('+quotename(Variable)+',0),''0%'') ',
						@ps2=@ps2+','+quotename(Variable)  
						,@headlinesbar=@headlinesbar+', 100.0* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+' in( '+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+' ) then [weight] end),0) as '+quotename(Variable)
				 from [dbo].[Headline_Variable]  where title=@kpi ;

				 set @ps2=stuff(@ps2,1,1,'') ;
	
				set @ps1=N'[1],[2],[3],[4],[YTD]';

				set @ps3=N'cast([1] as decimal(18,0)) [Quarter 1],cast([2] as decimal(18,0)) [Quarter 2],cast([3] as decimal(18,0)) [Quarter 3],cast([4] as decimal(18,0)) [Quarter 4],cast([YTD] as decimal(18,0)) [YTD]';
				
				----select @headlinesbar=@headlinesbar+', 100.0* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+' in( '+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+' ) then [weight] end),0) as '+quotename(Variable)
				---- from [dbo].[Headline_Variable] where title=@kpi ;

				set @headlinesbar=stuff(@headlinesbar,1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select isnull(concat('''',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  ),''YTD'') as TP '+@groupby_1+'	,
							 '+ @headlinesbar +'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW   
							'+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (  district='+cast(@district as nvarchar)+' )', 
								' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
								' and (  [Group]='+cast(@group as nvarchar)+') ',
								'  ')
								+'
						group by  Grouping Sets(Year_new, concat('''',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  )) '+@groupby_2+'	
						)   
						select concat(''Group '',[Group]) [Group],concat(''Region '',[Region]) [Region],concat(''District '',[District]) [District],concat(''Store '',[Store]) [Store],
							   '+@ps3+' 
					    from (
						select * from headline t
										 where 		1=1	'  +@c+'							 
								) as ft		
								unpivot(Value for Variable in('+@ps2+')) up
								pivot( sum(Value) for TP in('+@ps1+')) p

						order by cast(replace([Group],''Group '','''') as int),cast(replace([Region],''Region '','''') as int),cast(Replace([District],''District '','''') as int),cast(Replace([Store],''Store '','''') as int)
		
						' +char(10) ;
					 set @sql=@raw+@headlinesbar ;
					---  select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int', @YEAR_NEW  ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula
----------	The CASH score graph (shown here in green) will be colored red when lower than the goal, green when equal to or higher than to goal for the current team (when rounded to no decimal places). See the Goals worksheet for the goals. We have goals for group, region and district but not store. When store seleted this can just be grey.
----------	Can clicking on the Customer CASH score graph navigate the user to the KPI Breakdown page, with the CASH score selected?
----------Clealiness Score	See KPICalcs worksheet for formula
----------Assortment Score	See KPICalcs worksheet for formula
----------Service Score	See KPICalcs worksheet for formula
----------High Speed Score	See KPICalcs worksheet for formula
 else if  (@idx=1)
		 begin 
				set @ps1=N'[1],[2],[3],[4],[YTD]';

				set @ps3=N'cast([1] as decimal(18,0)) [Quarter 1],cast([2] as decimal(18,0)) [Quarter 2],cast([3] as decimal(18,0)) [Quarter 3],cast([4] as decimal(18,0)) [Quarter 4],cast([YTD] as decimal(18,0)) [YTD],cast([Goal] as decimal(18,0)) [Goal]';
				
  
				set @formcash='';
				select @formcash=@formcash+','+quotename(@kpi)+'= case when '+f.cs+' then null else 100*('+e.eq+') end' from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;
   
		 
				select @form=@form+',
								  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end)			 
								  /nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0)   ) as '+quotename(Variable) 
								 ---- ,@form1=@form1+', null as '+quotename(Variable) 
				from   [dbo].[KPICalcs] where kpi=@kpi 	 ;

				set @form=stuff(@form,1,1,'') ;
				  
				------set @form1=stuff(@form1,1,1,'') ;
	
				set @customer_cash_score=', cashscore as ( 
							select isnull(concat('''',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  ),''YTD'') as TP '+@groupby_1+'	,
									'+@form+'
							from  rawdata   where YEAR_NEW= @YEAR_NEW   
							'+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (  district='+cast(@district as nvarchar)+' )', 
								' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
								' and (  [Group]='+cast(@group as nvarchar)+') ',
								'  ')
								+'							 
							group by Grouping Sets(Year_New, concat('''',isnull(nullif(cast([QUARTER_NEW] as int)%4,0),4)  )) '+@groupby_2+' 
						 )
						 ,gl as (
						      select [Overall],[Group],[Region],[District],100*[CASH Survey] cs
						       from [dbo].[Goals] pivot(max(ID) for [Goal Level] in( [Group],[Region],[District],[Overall]))p 
							) 
						, c1 as (
						 select TP, [Group], [Region], District, Store'+@formcash+','
						 +case when @kpi='Customer CASH Score' then  '
								 (case  when Store is not null then null
										when [District] is not null  then (select  cs from gl where  [District]=t.[District])  
										when [Region] is not null    then (select   cs from gl where  [Region]=t.[Region]) 
										when [Group] is not null then (select  cs from gl where  [Group]=t.[Group]) 
										else  (select  cs from gl where overall<=-1 ) 
								end) ' else ' null ' end +'  as [Goal] 
						 from  cashscore  t 
								where 		1=1	'  +@c+'									 
						)
						select  concat(''Group '',[Group]) [Group],concat(''Region '',[Region]) [Region],concat(''District '',[District]) [District],concat(''Store '',[Store]) [Store],
						   '+@ps3+'
						from   c1
							 unpivot(Value for Variable in('+quotename(@kpi)+')) up
							 pivot( sum(Value) for TP in('+@ps1+')) p
					order by cast(replace([Group],''Group '','''') as int),cast(replace([Region],''Region '','''') as int),cast(Replace([District],''District '','''') as int),cast(Replace([Store],''Store '','''') as int)
						'   +char(10) ;
				 set @sql=@raw+@customer_cash_score ;
				 ---select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int', @YEAR_NEW ;
   end

set nocount off ;
end

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_next_20150422BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'Customer CASH Score','',10 ,14 ,104,795

[dbo].[p_get_KpiBreakdown_next_base] 3,9,'Customer CASH Score','',-1 ,-1 ,-1,-1
[dbo].[p_get_KpiBreakdown_next_base] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,-1,-1

[dbo].[p_get_KpiBreakdown_next_base] 3,9,'SERVICE','',-1 ,-1 ,410 ,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'Customer CASH Score','',10 ,14 ,104,795
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'Customer CASH Score','',-1 ,-1 ,-1,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'Recommend','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'Recommend','  ',10,40,300,6199


exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',null,null,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',null,null,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,null,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,null,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,300,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,300,null


exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,300,6199
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
CREATE procedure [dbo].[p_get_KpiBreakdown_next_20150422BAK](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
@group int  , 
@region int  ,
@district int  ,
@store  int 
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @idx int,
		   @c nvarchar(max),@groupby_1 nvarchar(4000)='' ,@groupby_2 nvarchar(4000)='' ;
  
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	

			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	

	set @hierarchy	=coalesce(  ' and Store='+cast(@store as nvarchar)  ,
			           ' and District='+cast(@district as nvarchar)   ,
					   ' and [Region]='+cast(@region as nvarchar)  ,
					   ' and [Group]='+cast(@group as nvarchar)  ,
					 ''
					 ); 

   set @c=  coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (   district='+cast(@district as nvarchar)+' and Store is not null)', 
								' and (  [Region]='+cast(@region as nvarchar)+'  and District is not null) ' , 
								' and (  [Group]='+cast(@group as nvarchar)+' and Region is not null ) ',
								'   ');

	set @groupby_1= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						    case when  @district  is null then null else ', [Group],[Region],District,Store  ' end ,
						    case when  @region is null then null else ',[Group],[Region],District,cast(null as int) as Store' end,
						    case when  @group  is null then null else ',[Group],[Region],cast(null as int) as District,cast(null as int) as Store' end,
						    ',[Group],cast(null as int) as [Region],cast(null as int) as District,cast(null as int) as Store' );

	set @groupby_2= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						     case when  @district  is null then null else ',[Group],[Region],Rollup(District,Store)' end ,
						     case when  @region is null then null else ',[Group],Rollup([Region],District) ' end,
						     case when  @group  is null then null else ',Rollup([Group],[Region])' end,
						     ',Rollup([Group])' );
 
---Raw Data with filter
	set @raw=concat(N';with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where   district>0  ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 

    
	 if  exists(select * from [dbo].[Headline_Variable] where Title= @kpi)
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)
 
				select   @ps2=@ps2+','+quotename(Variable) + ','+quotename(Variable+'!B')
						,@headlinesbar=@headlinesbar+', 100.0* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+' in( '+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+' ) then [weight] end),0) as '+quotename(Variable)
													+', sum(case when  '+quotename(Variable)+' in( '+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+' ) then [weight] end) as '+quotename(Variable+'!B')
				 from [dbo].[Headline_Variable]  where title=@kpi ;

				 set @ps2=stuff(@ps2,1,1,'') ;
	
				set @ps1=N'[1],[2],[3],[4],[YTD],[1!Base],[2!Base],[3!Base],[4!Base],[YTD!Base]';

				set @ps3=N'cast([1] as decimal(18,0)) [Quarter 1],cast([1!Base] as decimal(18,0)) [Q1!Base],cast([2] as decimal(18,0)) [Quarter 2],cast([2!Base] as decimal(18,0)) [Q2!Base],
				cast([3] as decimal(18,0)) [Quarter 3],cast([3!Base] as decimal(18,0)) [Q3!Base],cast([4] as decimal(18,0)) [Quarter 4],cast([4!Base] as decimal(18,0)) [Q4!Base],
				cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';
 

				set @headlinesbar=stuff(@headlinesbar,1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select isnull( concat('''',isnull(nullif( [QUARTER_NEW]  %4,0),4)  ),''YTD'') as TP '+@groupby_1+'	,
							 '+ @headlinesbar +'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW   
							'+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (  district='+cast(@district as nvarchar)+' )', 
								' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
								' and (  [Group]='+cast(@group as nvarchar)+') ',
								'  ')
								+'
						group by  Grouping Sets((Year_New),(concat('''',isnull(nullif( [QUARTER_NEW]  %4,0),4)) )  ) '+@groupby_2+'	
						)   
						select concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
							   '+@ps3+' 
						from (
							select  TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store s,value
							    from (
								         select * from headline t
												 where 		1=1	'  +@c+'							 
										) as ft		
										unpivot(Value for Variable in('+@ps2+')) up
						    ) ut
								pivot( sum(Value) for TP in('+@ps1+')) p

						order by g,r,d,s
		
						' +char(10) ;
					 set @sql=@raw+@headlinesbar ;
					---  select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int', @YEAR_NEW  ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula
----------	The CASH score graph (shown here in green) will be colored red when lower than the goal, green when equal to or higher than to goal for the current team (when rounded to no decimal places). See the Goals worksheet for the goals. We have goals for group, region and district but not store. When store seleted this can just be grey.
----------	Can clicking on the Customer CASH score graph navigate the user to the KPI Breakdown page, with the CASH score selected?
----------Clealiness Score	See KPICalcs worksheet for formula
----------Assortment Score	See KPICalcs worksheet for formula
----------Service Score	See KPICalcs worksheet for formula
----------High Speed Score	See KPICalcs worksheet for formula
       else if  exists(select *  from [dbo].[KPICalcs] where kpi=@kpi) 
		 begin 
		      if @kpi='Customer CASH Score'
			  begin
				set @ps1=N'[1],[2],[3],[4],[YTD],[1!Base],[2!Base],[3!Base],[4!Base],[YTD!Base]';

				set @ps3=N'cast([1] as decimal(18,1)) [Quarter 1],cast([1!Base] as decimal(18,0)) [Q1!Base],cast([2] as decimal(18,1)) [Quarter 2], cast([2!Base] as decimal(18,0)) [Q2!Base],
							cast([3] as decimal(18,1)) [Quarter 3],cast([3!Base] as decimal(18,0)) [Q3!Base],cast([4] as decimal(18,1)) [Quarter 4], cast([4!Base] as decimal(18,0)) [Q4!Base],
							cast([YTD] as decimal(18,1)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,1)) [Goal]';
			  end
			  else 
			  begin
					set @ps1=N'[1],[2],[3],[4],[YTD],[1!Base],[2!Base],[3!Base],[4!Base],[YTD!Base]';

					set @ps3=N'cast([1] as decimal(18,0)) [Quarter 1],cast([1!Base] as decimal(18,0)) [Q1!Base],cast([2] as decimal(18,0)) [Quarter 2], cast([2!Base] as decimal(18,0)) [Q2!Base],
								cast([3] as decimal(18,0)) [Quarter 3],cast([3!Base] as decimal(18,0)) [Q3!Base],cast([4] as decimal(18,0)) [Quarter 4], cast([4!Base] as decimal(18,0)) [Q4!Base],
								cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,0)) [Goal]';
			  end

				set @formcash='';
				select @formcash=@formcash+','+quotename(@kpi)+'= case when '+f.cs+' then null else 100*('+e.eq+') end' from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;
   
				select @formcash=@formcash+','+quotename(@kpi+'!B')+'= case when '+f.cs+' then null else ('+e.eq+') end' from  
					(select eq=stuff((select  '+isnull(',quotename(Variable+'!B'),',0)  '  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable+'!B'),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;
    
				select @form=@form+',	  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end) /nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0)   ) as '+quotename(Variable) 
								+',	sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight]/[WCNT] end) as '+quotename(Variable+'!B') 
					  ,@form1=@form1+'+ (case when '+quotename(Variable) +'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then cast(1.0 as float) else cast(0.0 as float) end) '
				from   [dbo].[KPICalcs] where kpi=@kpi 	 ;

				set @form=stuff(@form,1,1,'') ;
				  
				 set @form=replace(@form,'/[WCNT]','/('+stuff(@form1,1,1,'')+')' );

	
				set @customer_cash_score=', cashscore as ( 
							select isnull( concat('''',isnull(nullif( [QUARTER_NEW]  %4,0),4)  ),''YTD'') as TP '+@groupby_1+'	,
									'+@form+'
							from  rawdata   where YEAR_NEW= @YEAR_NEW   
							'+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (  district='+cast(@district as nvarchar)+' )', 
								' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
								' and (  [Group]='+cast(@group as nvarchar)+') ',
								'  ')
								+'							 
							group by Grouping Sets(Year_New,(concat('''',isnull(nullif( [QUARTER_NEW]  %4,0),4)))  ) '+@groupby_2+' 
						 )
						, c1 as (
						 select TP, [Group], [Region], District, Store'+@formcash+','
						 +case when @kpi='Customer CASH Score' then  '
								 (case  when Store is not null then null
										when [District] is not null  then (select top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [District]=t.[District])  
										when [Region] is not null    then (select  top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Region]=t.[Region]) 
										when [Group] is not null then (select top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Group]=t.[Group]) 
										else  (select top 1 cs from [dbo].[Goals_Pivoted](nolock) where overall=-1 ) 
								end) ' else ' null ' end +'  as [Goal] 
						 from  cashscore  t 
								where 		1=1	'  +@c+'									 
						)
						select  concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
						   '+@ps3+'
						   from (
							   select TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store  s,value,[Goal]
								from   c1
								 unpivot(Value for Variable in('+quotename(@kpi)+','+quotename(@kpi+'!B')+')) up
							 )ut
							 pivot( sum(Value) for TP in('+@ps1+')) p
					order by g,r,d,s
						'   +char(10) ;
				 set @sql=@raw+@customer_cash_score ;
				 ---select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int', @YEAR_NEW ;
   end

set nocount off ;
end

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_next_20150623BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'Customer CASH Score','',10 ,14 ,104,795

[dbo].[p_get_KpiBreakdown_next_base] 3,9,'Customer CASH Score','',-1 ,-1 ,-1,-1
[dbo].[p_get_KpiBreakdown_next_base] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,-1,-1

[dbo].[p_get_KpiBreakdown_next_base] 3,9,'SERVICE','',-1 ,-1 ,410 ,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'Customer CASH Score','',10 ,14 ,104,795
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'Customer CASH Score','',-1 ,-1 ,-1,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'Recommend','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'Recommend','  ',10,40,300,6199


exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',null,null,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',null,null,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,null,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,null,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,300,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,300,null


exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,300,6199
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
CREATE procedure [dbo].[p_get_KpiBreakdown_next_20150623BAK](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
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
@Shopper_Segment  nvarchar(100)=''
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),@where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @KPI_ID int,
		   @c nvarchar(max),@groupby_1 nvarchar(4000)='' ,@groupby_2 nvarchar(4000)='' ;
  
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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;

	set @hierarchy	=coalesce(  ' and Store='+cast(@store as nvarchar)  ,
			           ' and District='+cast(@district as nvarchar)   ,
					   ' and [Region]='+cast(@region as nvarchar)  ,
					   ' and [Group]='+cast(@group as nvarchar)  ,
					 ''
					 ); 

   set @c=  coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (   district='+cast(@district as nvarchar)+' and Store is not null)', 
								' and (  [Region]='+cast(@region as nvarchar)+'  and District is not null) ' , 
								' and (  [Group]='+cast(@group as nvarchar)+' and Region is not null ) ',
								' and [Group] is null or [Group]>0 ');

	set @groupby_1= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						    case when  @district  is null then null else ', [Group],[Region],District,Store  ' end ,
						    case when  @region is null then null else ',[Group],[Region],District,cast(null as int) as Store' end,
						    case when  @group  is null then null else ',[Group],[Region],cast(null as int) as District,cast(null as int) as Store' end,
						    ',[Group],cast(null as int) as [Region],cast(null as int) as District,cast(null as int) as Store' );

	set @groupby_2= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						     case when  @district  is null then null else ',[Group],[Region],Rollup(District,Store)' end ,
						     case when  @region is null then null else ',[Group],Rollup([Region],District) ' end,
						     case when  @group  is null then null else ',Rollup([Group],[Region])' end,
						     ',Rollup([Group])' );
 

---Raw Data with filter
	set @raw=concat(N';with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where   1=1  '+char(10),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+char(10)+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sc+')  ',
							@where_raw +char(10),'  )   ')+char(10)  ; 

     set @KPI_ID=(select top 1 KPI_ID from [dbo].[V_KPI] where KPI=@kpi);
	 if  @KPI_ID<0
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)
 
    
   		    select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
				,@ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
				 
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;

			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';


				select   @ps2=@ps2+','+quotename(Variable) + ','+quotename(Variable+'!B')
						,@headlinesbar=@headlinesbar+', 100.0* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+' in( '+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+' ) then [weight] end),0) as '+quotename(Variable)
													+', sum(case when  '+quotename(Variable)+' in( '+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+' ) then [weight] end) as '+quotename(Variable+'!B')
				 from [dbo].[Headline_Variable]  where  KPI_ID=abs(@KPI_ID );

				 set @ps2=stuff(@ps2,1,1,'') ;
	
				----set @ps1=N'[1],[2],[3],[4],[YTD],[1!Base],[2!Base],[3!Base],[4!Base],[YTD!Base]';

				----set @ps3=N'cast([1] as decimal(18,0)) [Quarter 1],cast([1!Base] as decimal(18,0)) [Q1!Base],cast([2] as decimal(18,0)) [Quarter 2],cast([2!Base] as decimal(18,0)) [Q2!Base],
				----cast([3] as decimal(18,0)) [Quarter 3],cast([3!Base] as decimal(18,0)) [Q3!Base],cast([4] as decimal(18,0)) [Quarter 4],cast([4!Base] as decimal(18,0)) [Q4!Base],
				----cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';
 

				set @headlinesbar=stuff(@headlinesbar,1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select isnull(  cast(  [QUARTER_NEW] as nvarchar)  ,''YTD'') as TP '+@groupby_1+'	,
							 '+ @headlinesbar +'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW   '+(select concat(' and ( [Quarter_NEW] between ', min(Qrt_ID),' and ',max(qrt_id),' )') from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW)+'
							'+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (  district='+cast(@district as nvarchar)+' )', 
								' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
								' and (  [Group]='+cast(@group as nvarchar)+') ',
								'  ')
								+'
						group by  Grouping Sets(YEAR_NEW,   [QUARTER_NEW] ) '+@groupby_2+'	
						)   
						select concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
							   '+@ps3+' 
						from (
							select  TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store s,value
							    from (
								         select * from headline t
												 where 		1=1	'  +@c+'							 
										) as ft		
										unpivot(Value for Variable in('+@ps2+')) up
						    ) ut
								pivot( sum(Value) for TP in('+@ps1+')) p
						
						order by g,r,d,s
		
						' +char(10) ;
					 set @sql=@raw+@headlinesbar ;
				----	  select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int', @YEAR_NEW  ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula
----------	The CASH score graph (shown here in green) will be colored red when lower than the goal, green when equal to or higher than to goal for the current team (when rounded to no decimal places). See the Goals worksheet for the goals. We have goals for group, region and district but not store. When store seleted this can just be grey.
----------	Can clicking on the Customer CASH score graph navigate the user to the KPI Breakdown page, with the CASH score selected?
----------Clealiness Score	See KPICalcs worksheet for formula
----------Assortment Score	See KPICalcs worksheet for formula
----------Service Score	See KPICalcs worksheet for formula
----------High Speed Score	See KPICalcs worksheet for formula
       else if  @KPI_ID>0
		 begin 
		  ------    if @kpi='Customer CASH Score'
			 ------ begin
				------set @ps1=N'[1],[2],[3],[4],[YTD],[1!Base],[2!Base],[3!Base],[4!Base],[YTD!Base]';

				------set @ps3=N'cast([1] as decimal(18,1)) [Quarter 1],cast([1!Base] as decimal(18,0)) [Q1!Base],cast([2] as decimal(18,1)) [Quarter 2], cast([2!Base] as decimal(18,0)) [Q2!Base],
				------			cast([3] as decimal(18,1)) [Quarter 3],cast([3!Base] as decimal(18,0)) [Q3!Base],cast([4] as decimal(18,1)) [Quarter 4], cast([4!Base] as decimal(18,0)) [Q4!Base],
				------			cast([YTD] as decimal(18,1)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,1)) [Goal]';
			 ------ end
			 ------ else 
			 ------ begin
				------	set @ps1=N'[1],[2],[3],[4],[YTD],[1!Base],[2!Base],[3!Base],[4!Base],[YTD!Base]';

				------	set @ps3=N'cast([1] as decimal(18,0)) [Quarter 1],cast([1!Base] as decimal(18,0)) [Q1!Base],cast([2] as decimal(18,0)) [Quarter 2], cast([2!Base] as decimal(18,0)) [Q2!Base],
				------				cast([3] as decimal(18,0)) [Quarter 3],cast([3!Base] as decimal(18,0)) [Q3!Base],cast([4] as decimal(18,0)) [Quarter 4], cast([4!Base] as decimal(18,0)) [Q4!Base],
				------				cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,0)) [Goal]';
			 ------ end

		   set @ps3='' ;
		   set @ps1='' ;

		   if @kpi='Customer CASH Score'
		   begin
 				select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
						, @ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,1)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
				from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
		    
				set @ps1=N'[YTD],[YTD!Base]'+@ps1;
				set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,1)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,1))  [Goal] ';
		   end
		   else
		   begin
 			select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
					, @ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
		    
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;
			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,1))  [Goal] ';
		  end


				set @formcash='';
				select @formcash=@formcash+','+quotename(@kpi)+'= case when '+f.cs+' then null else 100*('+e.eq+') end' from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,3,'' )) f ;
   
				select @formcash=@formcash+','+quotename(@kpi+'!B')+'= case when '+f.cs+' then null else ('+e.eq+') end' from  
					(select eq=stuff((select  '+isnull(',quotename(Variable+'!B'),',0)  '  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable+'!B'),'  is null  ')  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,3,'' )) f ;
    
				select @form=@form+',	  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end) /nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0)   ) as '+quotename(Variable) 
								+',	sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight]/[WCNT] end) as '+quotename(Variable+'!B') 
					  ,@form1=@form1+'+ (case when '+quotename(Variable) +'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then cast(1.0 as float) else cast(0.0 as float) end) '
				from   [dbo].[KPICalcs] where  KPI_ID=@KPI_ID 	 ;

				set @form=stuff(@form,1,1,'') ;
				  
				 set @form=replace(@form,'/[WCNT]','/('+stuff(@form1,1,1,'')+')' );

	
				set @customer_cash_score=', cashscore as ( 
							select isnull( cast(  [QUARTER_NEW] as nvarchar),''YTD'') as TP '+@groupby_1+'	,
									'+@form+'
							from  rawdata   where YEAR_NEW= @YEAR_NEW   '+(select concat(' and ( [Quarter_NEW] between ', min(Qrt_ID),' and ',max(qrt_id),' )') from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW)+'
							'+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (  district='+cast(@district as nvarchar)+' )', 
								' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
								' and (  [Group]='+cast(@group as nvarchar)+') ',
								'  ')
								+'							 
							group by Grouping Sets(YEAR_NEW, [QUARTER_NEW]  ) '+@groupby_2+' 
						 )
						, c1 as (
						 select TP, [Group], [Region], District, Store'+@formcash+','
						 +case when @kpi='Customer CASH Score' then  '
								 (case  when Store is not null then null
										when [District] is not null  then (select top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [District]=t.[District])  
										when [Region] is not null    then (select  top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Region]=t.[Region]) 
										when [Group] is not null then (select top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Group]=t.[Group]) 
										else  (select top 1 cs from [dbo].[Goals_Pivoted](nolock) where overall=-1 ) 
								end) ' else ' null ' end +'  as [Goal] 
						 from  cashscore  t 
								where 		1=1	'  +@c+'									 
						)
						select  concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
						   '+@ps3+'
						   from (
							   select TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store  s,value,[Goal]
								from   c1
								 unpivot(Value for Variable in('+quotename(@kpi)+','+quotename(@kpi+'!B')+')) up
							 )ut
							 pivot( sum(Value) for TP in('+@ps1+')) p
					order by g,r,d,s
						'   +char(10) ;
				 set @sql=@raw+@customer_cash_score ;
				 ---select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int', @YEAR_NEW ;
   end

set nocount off ;
end

 

GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_next_20150630bak]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'Customer CASH Score','',10 ,14 ,104,795

[dbo].[p_get_KpiBreakdown_next_base] 3,9,'Customer CASH Score','',-1 ,-1 ,-1,-1
[dbo].[p_get_KpiBreakdown_next_base] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,-1,-1

[dbo].[p_get_KpiBreakdown_next_base] 3,9,'SERVICE','',-1 ,-1 ,410 ,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'Customer CASH Score','',10 ,14 ,104,795
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'Customer CASH Score','',-1 ,-1 ,-1,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'Recommend','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'Recommend','  ',10,40,300,6199


exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',null,null,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',null,null,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,null,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,null,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,300,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,300,null


exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,300,6199
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
create procedure [dbo].[p_get_KpiBreakdown_next_20150630bak](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
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
@Shopper_Segment  nvarchar(100)=''
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),@where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @KPI_ID int,
		   @c nvarchar(max),@groupby_1 nvarchar(4000)='' ,@groupby_2 nvarchar(4000)='' ;
  
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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;

	set @hierarchy	=coalesce(  ' and Store='+cast(@store as nvarchar)  ,
			           ' and District='+cast(@district as nvarchar)   ,
					   ' and [Region]='+cast(@region as nvarchar)  ,
					   ' and [Group]='+cast(@group as nvarchar)  ,
					 ''
					 ); 

   set @c=  coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (   district='+cast(@district as nvarchar)+' and Store is not null)', 
								' and (  [Region]='+cast(@region as nvarchar)+'  and District is not null) ' , 
								' and (  [Group]='+cast(@group as nvarchar)+' and Region is not null ) ',
								' and [Group] is null or [Group]>0 ');

	set @groupby_1= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						    case when  @district  is null then null else ', [Group],[Region],District,Store  ' end ,
						    case when  @region is null then null else ',[Group],[Region],District,cast(null as int) as Store' end,
						    case when  @group  is null then null else ',[Group],[Region],cast(null as int) as District,cast(null as int) as Store' end,
						    ',[Group],cast(null as int) as [Region],cast(null as int) as District,cast(null as int) as Store' );

	set @groupby_2= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						     case when  @district  is null then null else ',[Group],[Region],Rollup(District,Store)' end ,
						     case when  @region is null then null else ',[Group],Rollup([Region],District) ' end,
						     case when  @group  is null then null else ',Rollup([Group],[Region])' end,
						     ',Rollup([Group])' );
 

---Raw Data with filter
	set @raw=concat(N';with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where   1=1  '+char(10),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+char(10)+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sc+')  ',
							@where_raw +char(10),'  )   ')+char(10)  ; 

     set @KPI_ID=(select top 1 KPI_ID from [dbo].[V_KPI] where KPI=@kpi);
	 if  @KPI_ID<0
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)
 
    
   		    select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
				,@ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
				 
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;

			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';


				select   @ps2=@ps2+','+quotename(Variable) + ','+quotename(Variable+'!B')
						,@headlinesbar=@headlinesbar+', 100.0* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+' in( '+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+' ) then [weight] end),0) as '+quotename(Variable)
													+', sum(case when  '+quotename(Variable)+' in( '+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+' ) then [weight] end) as '+quotename(Variable+'!B')
				 from [dbo].[Headline_Variable]  where  KPI_ID=abs(@KPI_ID );

				 set @ps2=stuff(@ps2,1,1,'') ;
	
				----set @ps1=N'[1],[2],[3],[4],[YTD],[1!Base],[2!Base],[3!Base],[4!Base],[YTD!Base]';

				----set @ps3=N'cast([1] as decimal(18,0)) [Quarter 1],cast([1!Base] as decimal(18,0)) [Q1!Base],cast([2] as decimal(18,0)) [Quarter 2],cast([2!Base] as decimal(18,0)) [Q2!Base],
				----cast([3] as decimal(18,0)) [Quarter 3],cast([3!Base] as decimal(18,0)) [Q3!Base],cast([4] as decimal(18,0)) [Quarter 4],cast([4!Base] as decimal(18,0)) [Q4!Base],
				----cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';
 

				set @headlinesbar=stuff(@headlinesbar,1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select isnull(  cast(  [QUARTER_NEW] as nvarchar)  ,''YTD'') as TP '+@groupby_1+'	,
							 '+ @headlinesbar +'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW   '+(select concat(' and ( [Quarter_NEW] between ', min(Qrt_ID),' and ',max(qrt_id),' )') from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW)+'
							'+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (  district='+cast(@district as nvarchar)+' )', 
								' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
								' and (  [Group]='+cast(@group as nvarchar)+') ',
								'  ')
								+'
						group by  Grouping Sets(YEAR_NEW,   [QUARTER_NEW] ) '+@groupby_2+'	
						)   
						select concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
							   '+@ps3+' 
						from (
							select  TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store s,value
							    from (
								         select * from headline t
												 where 		1=1	'  +@c+'							 
										) as ft		
										unpivot(Value for Variable in('+@ps2+')) up
						    ) ut
								pivot( sum(Value) for TP in('+@ps1+')) p
						
						order by g,r,d,s
		
						' +char(10) ;
					 set @sql=@raw+@headlinesbar ;
				----	  select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int', @YEAR_NEW  ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula
----------	The CASH score graph (shown here in green) will be colored red when lower than the goal, green when equal to or higher than to goal for the current team (when rounded to no decimal places). See the Goals worksheet for the goals. We have goals for group, region and district but not store. When store seleted this can just be grey.
----------	Can clicking on the Customer CASH score graph navigate the user to the KPI Breakdown page, with the CASH score selected?
----------Clealiness Score	See KPICalcs worksheet for formula
----------Assortment Score	See KPICalcs worksheet for formula
----------Service Score	See KPICalcs worksheet for formula
----------High Speed Score	See KPICalcs worksheet for formula
       else if  @KPI_ID>0
		 begin 
		  ------    if @kpi='Customer CASH Score'
			 ------ begin
				------set @ps1=N'[1],[2],[3],[4],[YTD],[1!Base],[2!Base],[3!Base],[4!Base],[YTD!Base]';

				------set @ps3=N'cast([1] as decimal(18,1)) [Quarter 1],cast([1!Base] as decimal(18,0)) [Q1!Base],cast([2] as decimal(18,1)) [Quarter 2], cast([2!Base] as decimal(18,0)) [Q2!Base],
				------			cast([3] as decimal(18,1)) [Quarter 3],cast([3!Base] as decimal(18,0)) [Q3!Base],cast([4] as decimal(18,1)) [Quarter 4], cast([4!Base] as decimal(18,0)) [Q4!Base],
				------			cast([YTD] as decimal(18,1)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,1)) [Goal]';
			 ------ end
			 ------ else 
			 ------ begin
				------	set @ps1=N'[1],[2],[3],[4],[YTD],[1!Base],[2!Base],[3!Base],[4!Base],[YTD!Base]';

				------	set @ps3=N'cast([1] as decimal(18,0)) [Quarter 1],cast([1!Base] as decimal(18,0)) [Q1!Base],cast([2] as decimal(18,0)) [Quarter 2], cast([2!Base] as decimal(18,0)) [Q2!Base],
				------				cast([3] as decimal(18,0)) [Quarter 3],cast([3!Base] as decimal(18,0)) [Q3!Base],cast([4] as decimal(18,0)) [Quarter 4], cast([4!Base] as decimal(18,0)) [Q4!Base],
				------				cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,0)) [Goal]';
			 ------ end

		   set @ps3='' ;
		   set @ps1='' ;

		   if @kpi='Customer CASH Score'
		   begin
 				select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
						, @ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,1)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
				from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
		    
				set @ps1=N'[YTD],[YTD!Base]'+@ps1;
				set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,1)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,1))  [Goal] ';
		   end
		   else
		   begin
 			select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
					, @ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
		    
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;
			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,1))  [Goal] ';
		  end


				set @formcash='';
				select @formcash=@formcash+','+quotename(@kpi)+'= case when '+f.cs+' then null else 100*('+e.eq+') end' from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,3,'' )) f ;
   
				select @formcash=@formcash+','+quotename(@kpi+'!B')+'= case when '+f.cs+' then null else ('+e.eq+') end' from  
					(select eq=stuff((select  '+isnull(',quotename(Variable+'!B'),',0)  '  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable+'!B'),'  is null  ')  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,3,'' )) f ;
    
				select @form=@form+',	  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end) /nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0)   ) as '+quotename(Variable) 
								+',	sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight]/[WCNT] end) as '+quotename(Variable+'!B') 
					  ,@form1=@form1+'+ (case when '+quotename(Variable) +'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then cast(1.0 as float) else cast(0.0 as float) end) '
				from   [dbo].[KPICalcs] where  KPI_ID=@KPI_ID 	 ;

				set @form=stuff(@form,1,1,'') ;
				  
				 set @form=replace(@form,'/[WCNT]','/('+stuff(@form1,1,1,'')+')' );

	
				set @customer_cash_score=', cashscore as ( 
							select isnull( cast(  [QUARTER_NEW] as nvarchar),''YTD'') as TP '+@groupby_1+'	,
									'+@form+'
							from  rawdata   where YEAR_NEW= @YEAR_NEW   '+(select concat(' and ( [Quarter_NEW] between ', min(Qrt_ID),' and ',max(qrt_id),' )') from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW)+'
							'+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (  district='+cast(@district as nvarchar)+' )', 
								' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
								' and (  [Group]='+cast(@group as nvarchar)+') ',
								'  ')
								+'							 
							group by Grouping Sets(YEAR_NEW, [QUARTER_NEW]  ) '+@groupby_2+' 
						 )
						, c1 as (
						 select TP, [Group], [Region], District, Store'+@formcash+','
						 +case when @kpi='Customer CASH Score' then  '
								 (case  when Store is not null then null
										when [District] is not null  then (select top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [District]=t.[District])  
										when [Region] is not null    then (select  top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Region]=t.[Region]) 
										when [Group] is not null then (select top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Group]=t.[Group]) 
										else  (select top 1 cs from [dbo].[Goals_Pivoted](nolock) where overall=-1 ) 
								end) ' else ' null ' end +'  as [Goal] 
						 from  cashscore  t 
								where 		1=1	'  +@c+'									 
						)
						select  concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
						   '+@ps3+'
						   from (
							   select TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store  s,value,[Goal]
								from   c1
								 unpivot(Value for Variable in('+quotename(@kpi)+','+quotename(@kpi+'!B')+')) up
							 )ut
							 pivot( sum(Value) for TP in('+@ps1+')) p
					order by g,r,d,s
						'   +char(10) ;
				 set @sql=@raw+@customer_cash_score ;
				 ---select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int', @YEAR_NEW ;
   end

set nocount off ;
end

 

GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_next_RollingQrt]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'Customer CASH Score','',10 ,14 ,104,795

[dbo].[p_get_KpiBreakdown_next_RollingQrt] 3,9,'Customer CASH Score','',-1 ,-1 ,-1,-1
[dbo].[p_get_KpiBreakdown_next_RollingQrt] 3,10,'OVERALL SATISFACTION','',-1 ,-1 ,-1,-1

[dbo].[p_get_KpiBreakdown_next_RollingQrt] 3,9,'SERVICE','',-1 ,-1 ,410 ,-1
exec [dbo].[p_get_KpiBreakdown_next_RollingQrt] 3,9,'Customer CASH Score','',10 ,14 ,104,795
exec [dbo].[p_get_KpiBreakdown_next_RollingQrt] 3,9,'Customer CASH Score','',-1 ,-1 ,-1,-1
exec [dbo].[p_get_KpiBreakdown_next_RollingQrt] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_next_RollingQrt] 3,9,'Recommend','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'Recommend','  ',10,40,300,6199


exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',null,null,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',null,null,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,null,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,null,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,300,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,300,null


exec [dbo].[p_get_KpiBreakdown_next_RollingQrt] 3,9,'SERVICE','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,300,6199
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
CREATE procedure [dbo].[p_get_KpiBreakdown_next_RollingQrt](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
@group int  , 
@region int  ,
@district int  ,
@store  int 
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @idx int,
		   @c nvarchar(max),@groupby_1 nvarchar(4000)='' ,@groupby_2 nvarchar(4000)='' ;
  
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	

			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	

	set @hierarchy	=coalesce(  ' and Store='+cast(@store as nvarchar)  ,
			           ' and District='+cast(@district as nvarchar)   ,
					   ' and [Region]='+cast(@region as nvarchar)  ,
					   ' and [Group]='+cast(@group as nvarchar)  ,
					 ''
					 ); 

   set @c=  coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (   district='+cast(@district as nvarchar)+' and Store is not null)', 
								' and (  [Region]='+cast(@region as nvarchar)+'  and District is not null) ' , 
								' and (  [Group]='+cast(@group as nvarchar)+' and Region is not null ) ',
								'   ');

	set @groupby_1= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						    case when  @district  is null then null else ', [Group],[Region],District,Store  ' end ,
						    case when  @region is null then null else ',[Group],[Region],District,cast(null as int) as Store' end,
						    case when  @group  is null then null else ',[Group],[Region],cast(null as int) as District,cast(null as int) as Store' end,
						    ',[Group],cast(null as int) as [Region],cast(null as int) as District,cast(null as int) as Store' );

	set @groupby_2= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						     case when  @district  is null then null else ',[Group],[Region],Rollup(District,Store)' end ,
						     case when  @region is null then null else ',[Group],Rollup([Region],District) ' end,
						     case when  @group  is null then null else ',Rollup([Group],[Region])' end,
						     ',Rollup([Group])' );
 
---Raw Data with filter
	set @raw=concat(N';with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 and district>0  ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 

    

	   select  @ps1=  @ps1+ '['+cast(Qrt_ID as nvarchar)+'],['+cast(Qrt_ID as nvarchar)+'!Base],'
			 ,@ps3= @ps3+'cast(['+cast(Qrt_ID as nvarchar)+'] as decimal(18,0) )   [FY'+cast(Year_new as nvarchar)+'Q'+cast(Quarter_NEW as nvarchar)+'],cast(['+cast(Qrt_ID as nvarchar)+'!Base] as decimal(18,0) )   [FY'+cast(Year_new as nvarchar)+'Q'+cast(Quarter_NEW as nvarchar)+'!Base],'
	   from   [dbo].[V_Year_Quarter] t(nolock)  where Qrt_ID between @QUARTER_NEW-3 and @QUARTER_NEW
	    order by Qrt_ID;
	 

	 if  exists(select * from [dbo].[Headline_Variable] where Title= @kpi)
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)
 
				select   @ps2=@ps2+','+quotename(Variable) + ','+quotename(Variable+'!B')
						,@headlinesbar=@headlinesbar+', 100.0* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+' in( '+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+' ) then [weight] end),0) as '+quotename(Variable)
													+', sum(case when  '+quotename(Variable)+' in( '+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+' ) then [weight] end) as '+quotename(Variable+'!B')
				 from [dbo].[Headline_Variable]  where title=@kpi ;

				 set @ps2=stuff(@ps2,1,1,'') ;
	
				set @ps1=@ps1+N'[YTD],[YTD!Base]';

				set @ps3=@ps3+N'cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';
 

				set @headlinesbar=stuff(@headlinesbar,1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select  cast( [QUARTER_NEW] as nvarchar)  as TP '+@groupby_1+'	,
							 '+ @headlinesbar +'	
							from rawdata   where ( QUARTER_NEW between '+cast(@QUARTER_NEW-3 as nvarchar)+' and   @QUARTER_NEW  )
							'+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (  district='+cast(@district as nvarchar)+' )', 
								' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
								' and (  [Group]='+cast(@group as nvarchar)+') ',
								'  ')
								+'
						group by    [QUARTER_NEW]   '+@groupby_2+'	
						union all
					   select  ''YTD''  as TP '+@groupby_1+'	,
							 '+ @headlinesbar +'	
							from rawdata   where (   YEAR_NEW=@YEAR_NEW )
							'+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (  district='+cast(@district as nvarchar)+' )', 
								' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
								' and (  [Group]='+cast(@group as nvarchar)+') ',
								'  ')
								+'
						group by    '+stuff(@groupby_2,1,1,'')+'	

						)   
						select concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
							   '+@ps3+' 
						from (
							select  TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store s,value
							    from (
								         select * from headline t
												 where 		1=1	'  +@c+'							 
										) as ft		
										unpivot(Value for Variable in('+@ps2+')) up
						    ) ut
								pivot( sum(Value) for TP in('+@ps1+')) p

						order by g,r,d,s
		
						' +char(10) ;
					 set @sql=@raw+@headlinesbar ;
					---  select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int,@QUARTER_NEW int', @YEAR_NEW,@QUARTER_NEW  ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula
----------	The CASH score graph (shown here in green) will be colored red when lower than the goal, green when equal to or higher than to goal for the current team (when rounded to no decimal places). See the Goals worksheet for the goals. We have goals for group, region and district but not store. When store seleted this can just be grey.
----------	Can clicking on the Customer CASH score graph navigate the user to the KPI Breakdown page, with the CASH score selected?
----------Clealiness Score	See KPICalcs worksheet for formula
----------Assortment Score	See KPICalcs worksheet for formula
----------Service Score	See KPICalcs worksheet for formula
----------High Speed Score	See KPICalcs worksheet for formula
       else if  exists(select *  from [dbo].[KPICalcs] where kpi=@kpi) 
		 begin 
				set @ps1=@ps1+N'[YTD],[YTD!Base]';

				set @ps3=@ps3+N'cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,0)) [Goal]';
				 
				set @formcash='';
				select @formcash=@formcash+','+quotename(@kpi)+'= case when '+f.cs+' then null else 100*('+e.eq+') end' from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;
   
				select @formcash=@formcash+','+quotename(@kpi+'!B')+'= case when '+f.cs+' then null else ('+e.eq+') end' from  
					(select eq=stuff((select  '+isnull(',quotename(Variable+'!B'),',0)'  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable+'!B'),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;
    
				select @form=@form+',	  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end) /nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0)   ) as '+quotename(Variable) 
				+',	sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end) as '+quotename(Variable+'!B') 
								---  ,@form1=@form1+', null as '+quotename(Variable) 
				from   [dbo].[KPICalcs] where kpi=@kpi 	 ;

				set @form=stuff(@form,1,1,'') ;
				  
				---set @form1=stuff(@form1,1,1,'') ;
	
				set @customer_cash_score=', cashscore as ( 
							select  cast( [QUARTER_NEW] as nvarchar)  as TP '+@groupby_1+'	,
									'+@form+'
							from  rawdata   where ( QUARTER_NEW between '+cast(@QUARTER_NEW-3 as nvarchar)+' and   @QUARTER_NEW  )
							'+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (  district='+cast(@district as nvarchar)+' )', 
								' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
								' and (  [Group]='+cast(@group as nvarchar)+') ',
								'  ')
								+'							 
							group by  [QUARTER_NEW] '+@groupby_2+' 
							union all
							select   ''YTD''  as TP '+@groupby_1+'	,
									'+@form+'
							from  rawdata   where YEAR_NEW= @YEAR_NEW   
							'+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (  district='+cast(@district as nvarchar)+' )', 
								' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
								' and (  [Group]='+cast(@group as nvarchar)+') ',
								'  ')
								+'							 
							group by   '+stuff(@groupby_2,1,1,'')+' 
						 )
						, c1 as (
						 select TP, [Group], [Region], District, Store'+@formcash+','
						 +case when @kpi='Customer CASH Score' then  '
								 (case  when Store is not null then null
										when [District] is not null  then (select top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [District]=t.[District])  
										when [Region] is not null    then (select  top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Region]=t.[Region]) 
										when [Group] is not null then (select top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Group]=t.[Group]) 
										else  (select top 1 cs from [dbo].[Goals_Pivoted](nolock) where overall=-1 ) 
								end) ' else ' null ' end +'  as [Goal] 
						 from  cashscore  t 
								where 		1=1	'  +@c+'									 
						)
						select  concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
						   '+@ps3+'
						   from (
							   select TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store  s,value,[Goal]
								from   c1
								 unpivot(Value for Variable in('+quotename(@kpi)+','+quotename(@kpi+'!B')+')) up
							 )ut
							 pivot( sum(Value) for TP in('+@ps1+')) p
					order by g,r,d,s
						'   +char(10) ;
				 set @sql=@raw+@customer_cash_score ;
				 ---select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int,@QUARTER_NEW int', @YEAR_NEW ,@QUARTER_NEW;
   end

set nocount off ;
end

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_next_test]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'Customer CASH Score','',10 ,14 ,104,795

[dbo].[p_get_KpiBreakdown_next_base] 3,9,'Customer CASH Score','',-1 ,-1 ,-1,-1
[dbo].[p_get_KpiBreakdown_next_base] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,-1,-1

[dbo].[p_get_KpiBreakdown_next_base] 3,9,'SERVICE','',-1 ,-1 ,410 ,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'Customer CASH Score','',10 ,14 ,104,795
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'Customer CASH Score','',-1 ,-1 ,-1,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'Recommend','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'Recommend','  ',10,40,300,6199


exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',null,null,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',null,null,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,null,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,null,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,300,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,300,null


exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,300,6199
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
CREATE procedure [dbo].[p_get_KpiBreakdown_next_test](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
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
@Shopper_Segment  nvarchar(100)=''
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),@where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @KPI_ID int,
		   @c nvarchar(max),@groupby_1 nvarchar(4000)='' ,@groupby_2 nvarchar(4000)='' ;
  
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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;

	set @hierarchy	=coalesce(  ' and Store='+cast(@store as nvarchar)  ,
			           ' and District='+cast(@district as nvarchar)   ,
					   ' and [Region]='+cast(@region as nvarchar)  ,
					   ' and [Group]='+cast(@group as nvarchar)  ,
					 ''
					 ); 

   set @c=  coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (   district='+cast(@district as nvarchar)+' and Store >0)', 
								' and (  [Region]='+cast(@region as nvarchar)+'  and District >0) ' , 
								' and (  [Group]='+cast(@group as nvarchar)+' and Region >0 ) ',
								' and [Group] is null or [Group]>0 ');

	set @groupby_1= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						    case when  @district  is null then null else ', [Group],[Region],District,Store  ' end ,
						    case when  @region is null then null else ',[Group],[Region],District,cast(null as int) as Store' end,
						    case when  @group  is null then null else ',[Group],[Region],cast(null as int) as District,cast(null as int) as Store' end,
						    ',[Group],cast(null as int) as [Region],cast(null as int) as District,cast(null as int) as Store' );

	set @groupby_2= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						     case when  @district  is null then null else ',[Group],[Region],District,Store' end ,
						     case when  @region is null then null else ',[Group],[Region],District ' end,
						     case when  @group  is null then null else ',[Group],[Region]' end,
						     ',Rollup([Group])' );
 

---Raw Data with filter
	set @raw=concat(N';with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where   1=1  '+char(10),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+char(10)+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sc+')  ',
							@where_raw +char(10),'  )   ')+char(10)  ; 

     set @KPI_ID=(select top 1 KPI_ID from [dbo].[V_KPI] where KPI=@kpi);
	 if  @KPI_ID<0
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)
 
    
   		    select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
				,@ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
				 
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;

			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';


				select   @ps2=@ps2+','+quotename(Variable) + ','+quotename(Variable+'!B')
						,@headlinesbar=@headlinesbar+', 100.0* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+' in( '+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+' ) then [weight] end),0) as '+quotename(Variable)
													+', sum(case when  '+quotename(Variable)+' in( '+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+' ) then [weight] end) as '+quotename(Variable+'!B')
				 from [dbo].[Headline_Variable]  where  KPI_ID=abs(@KPI_ID );

				 set @ps2=stuff(@ps2,1,1,'') ;
	
				----set @ps1=N'[1],[2],[3],[4],[YTD],[1!Base],[2!Base],[3!Base],[4!Base],[YTD!Base]';

				----set @ps3=N'cast([1] as decimal(18,0)) [Quarter 1],cast([1!Base] as decimal(18,0)) [Q1!Base],cast([2] as decimal(18,0)) [Quarter 2],cast([2!Base] as decimal(18,0)) [Q2!Base],
				----cast([3] as decimal(18,0)) [Quarter 3],cast([3!Base] as decimal(18,0)) [Q3!Base],cast([4] as decimal(18,0)) [Quarter 4],cast([4!Base] as decimal(18,0)) [Q4!Base],
				----cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';
 

				set @headlinesbar=stuff(@headlinesbar,1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select isnull(  cast(  [QUARTER_NEW] as nvarchar)  ,''YTD'') as TP '+@groupby_1+'	,
							 '+ @headlinesbar +'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW   '+(select concat(' and ( [Quarter_NEW] between ', min(Qrt_ID),' and ',max(qrt_id),' )') from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW)+'
							'+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (  district='+cast(@district as nvarchar)+' )', 
								' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
								' and (  [Group]='+cast(@group as nvarchar)+') ',
								'  ')
								+'
						group by  Grouping Sets(YEAR_NEW,   [QUARTER_NEW] ) '+@groupby_2+'	
						)   
						select concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
							   '+@ps3+' 
						from (
							select  TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store s,value
							    from (
								         select * from headline t
												 where 		1=1	'  +@c+'							 
										) as ft		
										unpivot(Value for Variable in('+@ps2+')) up
						    ) ut
								pivot( sum(Value) for TP in('+@ps1+')) p
						
						order by g,r,d,s
		
						' +char(10) ;
					 set @sql=@raw+@headlinesbar ;
				----	  select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int', @YEAR_NEW  ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula
----------	The CASH score graph (shown here in green) will be colored red when lower than the goal, green when equal to or higher than to goal for the current team (when rounded to no decimal places). See the Goals worksheet for the goals. We have goals for group, region and district but not store. When store seleted this can just be grey.
----------	Can clicking on the Customer CASH score graph navigate the user to the KPI Breakdown page, with the CASH score selected?
----------Clealiness Score	See KPICalcs worksheet for formula
----------Assortment Score	See KPICalcs worksheet for formula
----------Service Score	See KPICalcs worksheet for formula
----------High Speed Score	See KPICalcs worksheet for formula
       else if  @KPI_ID>0
		 begin 
		  ------    if @kpi='Customer CASH Score'
			 ------ begin
				------set @ps1=N'[1],[2],[3],[4],[YTD],[1!Base],[2!Base],[3!Base],[4!Base],[YTD!Base]';

				------set @ps3=N'cast([1] as decimal(18,1)) [Quarter 1],cast([1!Base] as decimal(18,0)) [Q1!Base],cast([2] as decimal(18,1)) [Quarter 2], cast([2!Base] as decimal(18,0)) [Q2!Base],
				------			cast([3] as decimal(18,1)) [Quarter 3],cast([3!Base] as decimal(18,0)) [Q3!Base],cast([4] as decimal(18,1)) [Quarter 4], cast([4!Base] as decimal(18,0)) [Q4!Base],
				------			cast([YTD] as decimal(18,1)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,1)) [Goal]';
			 ------ end
			 ------ else 
			 ------ begin
				------	set @ps1=N'[1],[2],[3],[4],[YTD],[1!Base],[2!Base],[3!Base],[4!Base],[YTD!Base]';

				------	set @ps3=N'cast([1] as decimal(18,0)) [Quarter 1],cast([1!Base] as decimal(18,0)) [Q1!Base],cast([2] as decimal(18,0)) [Quarter 2], cast([2!Base] as decimal(18,0)) [Q2!Base],
				------				cast([3] as decimal(18,0)) [Quarter 3],cast([3!Base] as decimal(18,0)) [Q3!Base],cast([4] as decimal(18,0)) [Quarter 4], cast([4!Base] as decimal(18,0)) [Q4!Base],
				------				cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,0)) [Goal]';
			 ------ end

		   set @ps3='' ;
		   set @ps1='' ;

		   if @kpi='Customer CASH Score'
		   begin
 				select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
						, @ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,1)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
				from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
		    
				set @ps1=N'[YTD],[YTD!Base]'+@ps1;
				set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,1)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,1))  [Goal] ';
		   end
		   else
		   begin
 			select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
					, @ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
		    
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;
			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,1))  [Goal] ';
		  end


				set @formcash='';
				select @formcash=@formcash+','+quotename(@kpi)+'= case when '+f.cs+' then null else 100*('+e.eq+') end' from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,3,'' )) f ;
   
				select @formcash=@formcash+','+quotename(@kpi+'!B')+'= case when '+f.cs+' then null else ('+e.eq+') end' from  
					(select eq=stuff((select  '+isnull(',quotename(Variable+'!B'),',0)  '  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable+'!B'),'  is null  ')  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,3,'' )) f ;
    
				select @form=@form+',	  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end) /nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0)   ) as '+quotename(Variable) 
								+',	sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight]/[WCNT] end) as '+quotename(Variable+'!B') 
					  ,@form1=@form1+'+ (case when '+quotename(Variable) +'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then cast(1.0 as float) else cast(0.0 as float) end) '
				from   [dbo].[KPICalcs] where  KPI_ID=@KPI_ID 	 ;

				set @form=stuff(@form,1,1,'') ;
				  
				 set @form=replace(@form,'/[WCNT]','/('+stuff(@form1,1,1,'')+')' );

	
				set @customer_cash_score=', cashscore as ( 
							select isnull( cast(  [QUARTER_NEW] as nvarchar),''YTD'') as TP '+@groupby_1+'	,
									'+@form+'
							from  rawdata   where YEAR_NEW= @YEAR_NEW   '+(select concat(' and ( [Quarter_NEW] between ', min(Qrt_ID),' and ',max(qrt_id),' )') from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW)+'
							'+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (  district='+cast(@district as nvarchar)+' )', 
								' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
								' and (  [Group]='+cast(@group as nvarchar)+') ',
								'  ')
								+'							 
							group by Grouping Sets(YEAR_NEW, [QUARTER_NEW]  ) '+@groupby_2+' 
						 )
						, c1 as (
						 select TP, [Group], [Region], District, Store'+@formcash+','
						 +case when @kpi='Customer CASH Score' then  '
								 (case  when Store is not null then null
										when [District] is not null  then (select top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [District]=t.[District])  
										when [Region] is not null    then (select  top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Region]=t.[Region]) 
										when [Group] is not null then (select top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Group]=t.[Group]) 
										else  (select top 1 cs from [dbo].[Goals_Pivoted](nolock) where overall=-1 ) 
								end) ' else ' null ' end +'  as [Goal] 
						 from  cashscore  t 
								where 		1=1	'  +@c+'									 
						)
						select  concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
						   '+@ps3+'
						   from (
							   select TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store  s,value,[Goal]
								from   c1
								 unpivot(Value for Variable in('+quotename(@kpi)+','+quotename(@kpi+'!B')+')) up
							 )ut
							 pivot( sum(Value) for TP in('+@ps1+')) p
					order by g,r,d,s
						'   +char(10) ;
				 set @sql=@raw+@customer_cash_score ;
				 ---select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int', @YEAR_NEW ;
   end

set nocount off ;
end

 

GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_next2]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_next_test] 3,9,'Customer CASH Score','',10 ,14 ,104,795

[dbo].[p_get_KpiBreakdown_next_base] 3,9,'Customer CASH Score','',-1 ,-1 ,-1,-1
[dbo].[p_get_KpiBreakdown_next_base] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,-1,-1

[dbo].[p_get_KpiBreakdown_next_base] 3,9,'SERVICE','',-1 ,-1 ,410 ,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'Customer CASH Score','',10 ,14 ,104,795
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'Customer CASH Score','',-1 ,-1 ,-1,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'Recommend','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown_next2] 3,9,'Recommend','  ',10,-1,-1,-1


exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',null,null,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',null,null,null,null

exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,null,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,null,null,null
 
exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,300,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,300,null


exec [dbo].[p_get_KpiBreakdown_next_test] 3,9,'SERVICE','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,40,300,6199

exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',null,null,null,null
exec [dbo].[p_get_KpiBreakdown_next] 3,9,'SERVICE','  ',10,null,null,null 
---exec [dbo].[p_get_KpiBreakdown_next2] 3,9,'SERVICE','  ',null,null,null,null
exec [dbo].[p_get_KpiBreakdown_next2] 3,9,'SERVICE','  ',10,null,null,null
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
CREATE  procedure [dbo].[p_get_KpiBreakdown_next2](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
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
@Shopper_Segment  nvarchar(100)=''
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @hierarchy nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),@where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @KPI_ID int,
		   @c nvarchar(max),@groupby_1 nvarchar(4000)='' ,@groupby_2 nvarchar(4000)='' ;
  
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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;

	set @hierarchy	=coalesce(  ' and Store='+cast(@store as nvarchar)  ,
			           ' and District='+cast(@district as nvarchar)   ,
					   ' and [Region]='+cast(@region as nvarchar)  ,
					   ' and [Group]='+cast(@group as nvarchar)  ,
					 ''
					 ); 

   set @c=  coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
								' and  (   district='+cast(@district as nvarchar)+' and Store >0)', 
								' and (  [Region]='+cast(@region as nvarchar)+'  and District >0) ' , 
								' and( (  [Group]='+cast(@group as nvarchar)+' and Region >0 ) or ([Group]>0 and [Region] is null) or (Region is null and [Group] is null and district is null and store is null) ) ',
								' and [Group] is null or [Group]>0 ');

	set @groupby_1= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						    case when  @district  is null then null else ', [Group],[Region],District,Store  ' end ,
						    case when  @region is null then null else ',[Group],[Region],District,cast(null as int) as Store' end,
						    case when  @group  is null then null else ',[Group],[Region],cast(null as int) as District,cast(null as int) as Store' end,
						    ',[Group],cast(null as int) as [Region],cast(null as int) as District,cast(null as int) as Store' );

	set @groupby_2= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						     case when  @district  is null then null else ',[Group],[Region],Rollup(District,Store)' end ,
						     case when  @region is null then null else ',[Group],Rollup([Region],District) ' end,
						     case when  @group  is null then null else ',Rollup([Group],[Region])' end,
						     ',Rollup([Group])' );
 

---Raw Data with filter
	set @raw=concat(N';with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where   1=1  '+char(10),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+char(10)+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sc+')  ',
							@where_raw +char(10),'  )   ')+char(10)  ; 

     set @KPI_ID=(select top 1 KPI_ID from [dbo].[V_KPI] where KPI=@kpi);
	 if  @KPI_ID<0
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)
 
    
   		    select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
				,@ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
				 
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;

			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';


				select   @ps2=@ps2+','+quotename(Variable) + ','+quotename(Variable+'!B')
						,@headlinesbar=@headlinesbar+', 100.0* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+' in( '+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+' ) then [weight] end),0) as '+quotename(Variable)
													+', sum(case when  '+quotename(Variable)+' in( '+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+' ) then [weight] end) as '+quotename(Variable+'!B')
				 from [dbo].[Headline_Variable]  where  KPI_ID=abs(@KPI_ID );

				 set @ps2=stuff(@ps2,1,1,'') ;
	
				----set @ps1=N'[1],[2],[3],[4],[YTD],[1!Base],[2!Base],[3!Base],[4!Base],[YTD!Base]';

				----set @ps3=N'cast([1] as decimal(18,0)) [Quarter 1],cast([1!Base] as decimal(18,0)) [Q1!Base],cast([2] as decimal(18,0)) [Quarter 2],cast([2!Base] as decimal(18,0)) [Q2!Base],
				----cast([3] as decimal(18,0)) [Quarter 3],cast([3!Base] as decimal(18,0)) [Q3!Base],cast([4] as decimal(18,0)) [Quarter 4],cast([4!Base] as decimal(18,0)) [Q4!Base],
				----cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';
 

				set @headlinesbar=stuff(@headlinesbar,1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select isnull(  cast(  [QUARTER_NEW] as nvarchar)  ,''YTD'') as TP '+@groupby_1+'	,
							 '+ @headlinesbar +'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW   '+(select concat(' and ( [Quarter_NEW] between ', min(Qrt_ID),' and ',max(qrt_id),' )') from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW)+'
							'
							----+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
							----	' and  (  district='+cast(@district as nvarchar)+' )', 
							----	' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
							----	' and (  [Group]='+cast(@group as nvarchar)+') ',
							----	'  ')
								+'
						group by  Grouping Sets(YEAR_NEW,   [QUARTER_NEW] ) '+@groupby_2+'	
						)   
						select concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
							   '+@ps3+' 
						from (
							select  TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store s,value
							    from (
								         select * from headline t
												 where 		1=1	'  +@c+'							 
										) as ft		
										unpivot(Value for Variable in('+@ps2+')) up
						    ) ut
								pivot( sum(Value) for TP in('+@ps1+')) p
						
						order by g,r,d,s
		
						' +char(10) ;
					 set @sql=@raw+@headlinesbar ;
				----	  select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int', @YEAR_NEW  ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	
----------See KPICalcs worksheet for formula
----------	The CASH score graph (shown here in green) will be colored red when lower than the goal, green when equal to or higher than to goal for the current team (when rounded to no decimal places). See the Goals worksheet for the goals. We have goals for group, region and district but not store. When store seleted this can just be grey.
----------	Can clicking on the Customer CASH score graph navigate the user to the KPI Breakdown page, with the CASH score selected?
----------Clealiness Score	See KPICalcs worksheet for formula
----------Assortment Score	See KPICalcs worksheet for formula
----------Service Score	See KPICalcs worksheet for formula
----------High Speed Score	See KPICalcs worksheet for formula
       else if  @KPI_ID>0
		 begin 
		  ------    if @kpi='Customer CASH Score'
			 ------ begin
				------set @ps1=N'[1],[2],[3],[4],[YTD],[1!Base],[2!Base],[3!Base],[4!Base],[YTD!Base]';

				------set @ps3=N'cast([1] as decimal(18,1)) [Quarter 1],cast([1!Base] as decimal(18,0)) [Q1!Base],cast([2] as decimal(18,1)) [Quarter 2], cast([2!Base] as decimal(18,0)) [Q2!Base],
				------			cast([3] as decimal(18,1)) [Quarter 3],cast([3!Base] as decimal(18,0)) [Q3!Base],cast([4] as decimal(18,1)) [Quarter 4], cast([4!Base] as decimal(18,0)) [Q4!Base],
				------			cast([YTD] as decimal(18,1)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,1)) [Goal]';
			 ------ end
			 ------ else 
			 ------ begin
				------	set @ps1=N'[1],[2],[3],[4],[YTD],[1!Base],[2!Base],[3!Base],[4!Base],[YTD!Base]';

				------	set @ps3=N'cast([1] as decimal(18,0)) [Quarter 1],cast([1!Base] as decimal(18,0)) [Q1!Base],cast([2] as decimal(18,0)) [Quarter 2], cast([2!Base] as decimal(18,0)) [Q2!Base],
				------				cast([3] as decimal(18,0)) [Quarter 3],cast([3!Base] as decimal(18,0)) [Q3!Base],cast([4] as decimal(18,0)) [Quarter 4], cast([4!Base] as decimal(18,0)) [Q4!Base],
				------				cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,0)) [Goal]';
			 ------ end

		   set @ps3='' ;
		   set @ps1='' ;

		   if @kpi='Customer CASH Score'
		   begin
 				select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
						, @ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,1)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
				from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
		    
				set @ps1=N'[YTD],[YTD!Base]'+@ps1;
				set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,1)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,1))  [Goal] ';
		   end
		   else
		   begin
 			select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
					, @ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
		    
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;
			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base],cast([Goal] as decimal(18,1))  [Goal] ';
		  end


				set @formcash='';
				select @formcash=@formcash+','+quotename(@kpi)+'= case when '+f.cs+' then null else 100*('+e.eq+') end' from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,3,'' )) f ;
   
				select @formcash=@formcash+','+quotename(@kpi+'!B')+'= case when '+f.cs+' then null else ('+e.eq+') end' from  
					(select eq=stuff((select  '+isnull(',quotename(Variable+'!B'),',0)  '  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable+'!B'),'  is null  ')  from [dbo].[KPICalcs] kpi where  KPI_ID=@KPI_ID  for xml path('')),1,3,'' )) f ;
    
				select @form=@form+',	  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end) /nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0)   ) as '+quotename(Variable) 
								+',	sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight]/[WCNT] end) as '+quotename(Variable+'!B') 
					  ,@form1=@form1+'+ (case when '+quotename(Variable) +'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then cast(1.0 as float) else cast(0.0 as float) end) '
				from   [dbo].[KPICalcs] where  KPI_ID=@KPI_ID 	 ;

				set @form=stuff(@form,1,1,'') ;
				  
				 set @form=replace(@form,'/[WCNT]','/('+stuff(@form1,1,1,'')+')' );

	
				set @customer_cash_score=', cashscore as ( 
							select isnull( cast(  [QUARTER_NEW] as nvarchar),''YTD'') as TP '+@groupby_1+'	,
									'+@form+'
							from  rawdata   where YEAR_NEW= @YEAR_NEW   '+(select concat(' and ( [Quarter_NEW] between ', min(Qrt_ID),' and ',max(qrt_id),' )') from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW)+'
							'
							------+ coalesce(' and Store='+cast(@store as nvarchar)+'  ', 
							------	' and  (  district='+cast(@district as nvarchar)+' )', 
							------	' and (  [Region]='+cast(@region as nvarchar)+' )  ' , 
							------	' and (  [Group]='+cast(@group as nvarchar)+') ',
							------	'  ')
								+'							 
							group by Grouping Sets(YEAR_NEW, [QUARTER_NEW]  ) '+@groupby_2+' 
						 )
						, c1 as (
						 select TP, [Group], [Region], District, Store'+@formcash+','
						 +case when @kpi='Customer CASH Score' then  '
								 (case  when Store is not null then null
										when [District] is not null  then (select top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [District]=t.[District])  
										when [Region] is not null    then (select  top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Region]=t.[Region]) 
										when [Group] is not null then (select top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Group]=t.[Group]) 
										else  (select top 1 cs from [dbo].[Goals_Pivoted](nolock) where overall=-1 ) 
								end) ' else ' null ' end +'  as [Goal] 
						 from  cashscore  t 
								where 		1=1	'  +@c+'									 
						)
						select  concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
						   '+@ps3+'
						   from (
							   select TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store  s,value,[Goal]
								from   c1
								 unpivot(Value for Variable in('+quotename(@kpi)+','+quotename(@kpi+'!B')+')) up
							 )ut
							 pivot( sum(Value) for TP in('+@ps1+')) p
					order by g,r,d,s
						'   +char(10) ;
				 set @sql=@raw+@customer_cash_score ;
				 ---select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int', @YEAR_NEW ;
   end

set nocount off ;
end

 

GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_rollingqrt]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_rollingqrt] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,410,5697
[dbo].[p_get_KpiBreakdown_test] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_rollingqrt] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,-1,-1
[p_get_KpiBreakdown] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
[p_get_KpiBreakdown_rollingqrt] 3,9,'Recommend','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown_rollingqrt] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown_test] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown_rollingqrt] 3,9,'Customer CASH Score','',10 ,8 ,62 ,-1
exec [p_get_KpiBreakdown_rollingqrt] 3,9,'Customer CASH Score','',10 ,8 ,62 ,-1

exec [dbo].[p_get_KpiBreakdown_rollingqrt] 3,9,'SERVICE','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown_rollingqrt] 3,9,'SERVICE','  ',10,40,300,6199
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
CREATE   procedure [dbo].[p_get_KpiBreakdown_rollingqrt](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
@group int  , 
@region int  ,
@district int  ,
@store  int 
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int, 
		   @c2  nvarchar(max);
  
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	
			
			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	
 
---Raw Data with filter
	set @raw=concat(N' ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 and district>0  ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 

----------------------------------------------------------------------------------------------------------------------------------------
	if @store is not null 
	begin
		set @c2=  ', case when  Store='+cast(@store as nvarchar)+
								isnull((select top 1 '  
										or (Grouping([Group])+ Grouping(Region) + Grouping(District)+ Grouping([Store]) =0 and  District='+cast(District as nvarchar)+' )
										or ( Grouping([Group])+ Grouping(Region)  + Grouping(District)=0 and Grouping([Store]) =1 and [district]='+cast(District as nvarchar)+' )
										or (  Grouping([Group])+ Grouping(Region)=0 and Grouping(District)=1 and [Region]='+cast(Region as nvarchar)+' )
										or ( Grouping([Group])=0 and Grouping(Region)=1 and [Group]='+cast( [Group] as nvarchar)+'  ) 
											'   from  [dbo].[Hierarchy]  where  Store=@store),'')+' or  Grouping([Group])=1 then 1 else 0 end as flag' 
	 end
	 else if   @district is not null 
	 begin
		set @c2= 	', case when   district='+cast(@district as nvarchar)+
								isnull((select top 1 '
										or ( Grouping([Group])+ Grouping(Region)  + Grouping(District)=0 and Grouping([Store]) =1  and  Region='+cast(Region as nvarchar)+'  ) 
										or ( Grouping([Group])+ Grouping(Region)=0 and Grouping(District)=1 and Region='+cast(Region as nvarchar)+' )
										or (Grouping([Group])=0 and Grouping(Region)=1 and [Group]='+cast([Group] as nvarchar)+' ) 
												'  from  [dbo].[Hierarchy]  where District= @district ),'')+'  or  Grouping([Group])=1 then 1 else 0 end as flag'
	 end
	 else if  @region is not null 
	 begin
		set @c2= 	', case when  [Region]='+cast(@region as nvarchar)+
									 isnull((select top 1 '
										Or ( Grouping([Group])+ Grouping(Region)=0 and Grouping(District)=1 and  [Group]='+cast([Group] as nvarchar)+'  )
										or (Grouping([Group])=0 and Grouping(Region)=1 and [Group]='+cast([Group] as nvarchar)+' )'
										 from  [dbo].[Hierarchy]  where  [Region]=@region ),'')+'   or  Grouping([Group])=1 then 1 else 0 end as flag ' 
	 end  
	 else if @group is not null
	 begin
		set @c2= ', case when   [Group]='+cast(@group as nvarchar)+' or Grouping(Region)=1  or  Grouping([Group])=1 then 1 else 0 end as flag '
	 end
	 else
	 begin
		set @c2= ', 1 as flag  '
	 end ;
-----------------------------------------------------------------------------------------------------------------------------------------
			select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
				,@ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [FY'+cast(year_new as nvarchar)+'Q'+concat(QUARTER_NEW,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [FY'+cast(year_new as nvarchar)+'Q',QUARTER_NEW,N'!Base]')
			from V_Year_Quarter(nolock) where qrt_ID between @QUARTER_NEW-3  and @QUARTER_NEW   ;
				 
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;

			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';
 		

	  if  exists(select * from [dbo].[Headline_Variable] where Title= @kpi)
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)
   
				select  @ps2=@ps2+ ','+quotename(Variable)+ ','+quotename(Variable+'!B')
						, @headlinesbar=@headlinesbar+', 100* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end),0) as '+quotename(Variable)
						+',  sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end)  as '+quotename(Variable+'!B')
				from [dbo].[Headline_Variable]  where title=@kpi ;

				 
				set @ps2=stuff(@ps2,1,1,'') ;
			
 
				 set @headlinesbar=stuff(@headlinesbar,1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select   cast(  [QUARTER_NEW] as nvarchar)   as TP,[Group],[Region],District,Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
										   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
							 '+ @headlinesbar +char(10)+@c2+'	
							from rawdata   where   ( QUARTER_NEW between @QUARTER_NEW-3  and @QUARTER_NEW)
						group by     [QUARTER_NEW]  , Rollup([Group],  Region, District, Store)
						union all
							select  ''YTD''  as TP,[Group],[Region],District,Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
										   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
							 '+ @headlinesbar +char(10)+@c2+'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW   
						group by    Rollup([Group],  Region, District, Store)

						) 
						select concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
							   '+@ps3+' 
						from (select  TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store s,value
								from  (select * from  headline t where flag=1)   ft		
								unpivot(Value for Variable in('+@ps2+')) up
						 )ut
								pivot( sum(Value) for TP in('+@ps1+')) p 
						order by  g,r,d,s
		
						' ;
					 set @sql=@raw+@headlinesbar ;
				------select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int ,@QUARTER_NEW int', @YEAR_NEW ,@QUARTER_NEW  ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	

 else if  exists(select *  from [dbo].[KPICalcs] where kpi=@kpi) 
		 begin 
 
				set @formcash='';
				select @formcash=@formcash+','+quotename(@kpi)+'=case when '+f.cs+' then null else  100*('+e.eq+') end' from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;

				select @formcash=@formcash+','+quotename(@kpi+'!B')+'=case when '+f.cs+' then null else  ('+e.eq+') end' from  
					(select eq=stuff((select    '+isnull(',quotename(Variable+'!B'),',0)'  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable+'!B'),'  is null  ')  from [dbo].[KPICalcs] kpi where kpi.kpi=@kpi  for xml path('')),1,3,'' )) f ;
   
      
				select @form=@form+',	  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end) /nullif(sum(case when '+quotename(Variable)+'   in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end),0)   ) as '+quotename(Variable) 
								  +' ,sum(case when '+quotename(Variable)+'   in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end) as '+quotename(Variable+'!B') 
								 
				from    [dbo].[KPICalcs] where kpi=@kpi   ;
    
				set @form=stuff(@form,1,1,'') ;  
	
				set @customer_cash_score=', cashscore as ( 
							select   cast(  [QUARTER_NEW] as nvarchar)  as TP,b.[Group],b.[Region],b.District,b.Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
									when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
									'+@form+char(10)+@c2+'
							from  rawdata as b  where  ( QUARTER_NEW between @QUARTER_NEW-3  and @QUARTER_NEW)
							group by     [QUARTER_NEW]   ,Rollup(b.[Group],b.[Region],b.District,b.Store) 
						union all
							select  ''YTD''  as TP,b.[Group],b.[Region],b.District,b.Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
									when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
									'+@form+char(10)+@c2+'
							from  rawdata as b  where YEAR_NEW= @YEAR_NEW  
							group by    Rollup(b.[Group],b.[Region],b.District,b.Store) 
						 ) 
						, c1 as (
						 select AL, TP, [Group], [Region], District, Store'+@formcash+'
						 from   cashscore 	  t  where flag=1
						)
						select  concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
						   '+@ps3+','+case when @kpi='Customer CASH Score' then  ' cast( 
						         (case AL when ''F'' then  (select top 1 cs from [dbo].[Goals_Pivoted](nolock) where overall=-1 )
										when ''G'' then  (select  top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Group]=p.[g]) 
										when ''R'' then  (select  top 1   cs from [dbo].[Goals_Pivoted](nolock) where  [Region]=p.[r]) 
										when ''D'' then  (select   top 1 cs from [dbo].[Goals_Pivoted](nolock) where  [District]=p.[d])  
								end) as decimal(18,0) )' else ' null ' end 
								+' as [Goal] 
						from (
							select TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d ,Store s,value,AL
							from   c1
							 unpivot(Value for Variable in('+quotename(@kpi)+','+quotename(@kpi+'!B')+')) up
						 )ut
						  pivot( sum(Value) for TP in('+@ps1+')) p
							  
					order by  g,r,d,s
						'   ;
				 set @sql=@raw+@customer_cash_score ;
				 ---select @sql;
				 exec sp_executesql @sql,N'  @YEAR_NEW int ,@QUARTER_NEW int ', @YEAR_NEW  ,@QUARTER_NEW ;
   end
     set nocount off ;
end

 

GO
/****** Object:  StoredProcedure [dbo].[p_get_KpiBreakdown_test]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
  ---author victor
 ---createdate 2015-01-27
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',20 ,2 ,-1 ,-1
 [dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'ASSORTMENT','',10 ,14 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,410,5697
[dbo].[p_get_KpiBreakdown_test] 3,9,'SERVICE','',-1 ,-1 ,-1 ,-1
[dbo].[p_get_KpiBreakdown_test] 3,9,'OVERALL SATISFACTION','',-1 ,-1 ,-1,-1
[p_get_KpiBreakdown] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
[p_get_KpiBreakdown_test] 3,9,'Recommend','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown_test] 3,10,'Customer CASH Score','',-1 ,-1 ,-1 ,-1
exec [p_get_KpiBreakdown_test] 3,9,'Customer CASH Score','',10 ,8 ,62 ,-1
exec [p_get_KpiBreakdown] 3,9,'Customer CASH Score','',10 ,8 ,62 ,-1
 [dbo].[p_get_KpiBreakdown_test] 3,9,'OVERALL SATISFACTION','',10 ,-1 ,-1 ,-1
exec [dbo].[p_get_KpiBreakdown_test] 3,9,'SERVICE','  ',10,40,300,6199
exec [dbo].[p_get_KpiBreakdown] 3,9,'SERVICE','  ',10,40,300,6199
@group int =-1 ,  --all
@region int =-1 ,
@district int =-1 ,
@store  int =-1
*/
CREATE   procedure [dbo].[p_get_KpiBreakdown_test](
@YEAR_NEW int ,
@QUARTER_NEW int ,
@kpi nvarchar(60) ,
@wherecondition nvarchar(max) ,
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
@Shopper_Segment  nvarchar(100)=''
 )
 as 
 begin

   set nocount on ;
   declare @sql nvarchar(max) ='',  
		   @headlinesbar   nvarchar(max) ='', 
		   @customer_cash_score nvarchar(max)='' , 
		   @formhead nvarchar(max)='', 
		   @formcash nvarchar(max)='',  
		   @form nvarchar(max)='',@form1 nvarchar(max)='',
		   @raw  nvarchar(max)='',
		   @ps1 nvarchar(max)='',
		   @ps2 nvarchar(max)='',
		   @ps3 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
			@where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int, 
		   @c2  nvarchar(max),
		   @kpi_id int;
  
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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;

---Raw Data with filter
	set @raw=concat(N' ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where   1=1  '+char(10),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+char(10)+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sc+')  ',
							@where_raw ,char(10)+'  )   ')+char(10)  ; 

----------------------------------------------------------------------------------------------------------------------------------------
	if @store is not null 
	begin
		set @c2=  ', case when  Store='+cast(@store as nvarchar)+
								isnull((select top 1 '  
										or (Grouping([Group])+ Grouping(Region) + Grouping(District)+ Grouping([Store]) =0 and  District='+cast(District as nvarchar)+' )
										or ( Grouping([Group])+ Grouping(Region)  + Grouping(District)=0 and Grouping([Store]) =1 and [district]='+cast(District as nvarchar)+' )
										or (  Grouping([Group])+ Grouping(Region)=0 and Grouping(District)=1 and [Region]='+cast(Region as nvarchar)+' )
										or ( Grouping([Group])=0 and Grouping(Region)=1 and [Group]='+cast( [Group] as nvarchar)+'  ) 
											'   from  [dbo].[Hierarchy](nolock)   where  Store=@store),'')+' or  Grouping([Group])=1 then 1 else 0 end as flag' 
	 end
	 else if   @district is not null 
	 begin
		set @c2= 	', case when   district='+cast(@district as nvarchar)+
								isnull((select top 1 '
										or ( Grouping([Group])+ Grouping(Region)  + Grouping(District)=0 and Grouping([Store]) =1  and  Region='+cast(Region as nvarchar)+'  ) 
										or ( Grouping([Group])+ Grouping(Region)=0 and Grouping(District)=1 and Region='+cast(Region as nvarchar)+' )
										or (Grouping([Group])=0 and Grouping(Region)=1 and [Group]='+cast([Group] as nvarchar)+' ) 
												'  from  [dbo].[Hierarchy](nolock)   where District= @district ),'')+'  or  Grouping([Group])=1 then 1 else 0 end as flag'
	 end
	 else if  @region is not null 
	 begin
		set @c2= 	', case when  [Region]='+cast(@region as nvarchar)+
									 isnull((select top 1 '
										Or ( Grouping([Group])+ Grouping(Region)=0 and Grouping(District)=1 and  [Group]='+cast([Group] as nvarchar)+'  )
										or (Grouping([Group])=0 and Grouping(Region)=1 and [Group]='+cast([Group] as nvarchar)+' )'
										 from  [dbo].[Hierarchy](nolock)   where  [Region]=@region ),'')+'   or  Grouping([Group])=1 then 1 
						      else 0 end as flag ' 
	 end  
	 else if @group is not null
	 begin
		set @c2= ', case when Region<0 or [District]<0 or [Group]<0   then 0 
						 when   [Group]='+cast(@group as nvarchar)+' or Grouping(Region)=1  or  Grouping([Group])=1 then 1 
						 else 0 end as flag '
	 end
	 else
	 begin
		set @c2= ',case when [Group]<0 or Region<0 or [District]<0  then 0 else  1 end as flag  '
	 end ;
-----------------------------------------------------------------------------------------------------------------------------------------
	
 	set @kpi_id=( select top 1 KPI_ID  from v_KPI where kpi=@kpi	);

	  if  @kpi_id<0
	 begin   
				----Overall sat	Q4_GRID_0_Q4	Top 2 box (6 /7)
				----Return to shop	Q5_GRID_01_Q5	Top 2 box (6 /7)
				----Recommend	Q5_GRID_02_Q5	Top 2 box (6 /7)
				----Prefer FD for quick trips	Q5_GRID_03_Q5	Top 2 box (6 /7)
   
   		    select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
				,@ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
				 
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;

			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';

				select  @ps2=@ps2+ ','+quotename(Variable)+ ','+quotename(Variable+'!B')
						, @headlinesbar=@headlinesbar+', 100* sum(case when  '+quotename(Variable)+' in('+TopNbox+') then [weight] else 0.0 end)/nullif(sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end),0) as '+quotename(Variable)
						+',  sum(case when  '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+') then [weight] end)  as '+quotename(Variable+'!B')
				from [dbo].[Headline_Variable] (nolock)  where KPI_ID=abs(@kpi_id);

				 
				set @ps2=stuff(@ps2,1,1,'') ;
			
 
				 set @headlinesbar=stuff(@headlinesbar,1,1,'');

				set  @headlinesbar='  ,headline as ( 
							select isnull(  cast(  [QUARTER_NEW] as nvarchar)  ,''YTD'') as TP,[Group],[Region],District,Store,
									--------( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
									--------	   when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
							 '+ @headlinesbar +char(10)+@c2+'	
							from rawdata   where  YEAR_NEW= @YEAR_NEW '+(select concat(' and ( [Quarter_NEW] between ', min(Qrt_ID),' and ',max(qrt_id),' )') from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW)+'
						group by   Grouping sets( YEAR_NEW,   [QUARTER_NEW]  ) , Rollup([Group],  Region, District, Store)
						) 
						select concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
							   '+@ps3+' 
						from (select  TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d,Store s,value
								from  (select * from  headline t where flag=1)   ft		
								unpivot(Value for Variable in('+@ps2+')) up
						 )ut
								pivot( sum(Value) for TP in('+@ps1+')) p  
						order by  g,r,d,s
		
						' ;
					 set @sql=@raw+@headlinesbar ;
				------select @sql ;
				 exec sp_executesql @sql,N'  @YEAR_NEW int ', @YEAR_NEW   ;
  end

--------------------------------------------------------------------------------------------------------------------------------------------
----------Customer CASH Score	

 else if  @kpi_id>0
		 begin 
 
		   set @ps3='' ;
		   set @ps1='' ;

		   if @kpi='Customer CASH Score'
		   begin
 				select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
						, @ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,1)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
				from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
		    
				set @ps1=N'[YTD],[YTD!Base]'+@ps1;
				set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,1)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';
		   end
		   else
		   begin
 			select @ps1=@ps1+','+quotename(Qrt_ID)+',['+concat(Qrt_ID,N'!Base]' )
					, @ps3=@ps3+',cast('+quotename(Qrt_ID)+N' as decimal(18,0)) [Quarter '+concat(quarter_new,N'],cast([',Qrt_ID,N'!Base] as decimal(18,0)) [Q',quarter_new,N'!Base]')
			from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW  ;
		    
			set @ps1=N'[YTD],[YTD!Base]'+@ps1;
			set @ps3=stuff(@ps3,1,1,'')+N',cast([YTD] as decimal(18,0)) [YTD],cast([YTD!Base] as decimal(18,0)) [YTD!Base] ';
		  end

				set @formcash='';
				select @formcash=@formcash+','+quotename(@kpi)+'= case when '+f.cs+' then null else 100*('+e.eq+') end' from  
					(select eq=stuff((select   concat('+isnull(',quotename(Variable),',0)*', isnull([weight],1))  from [dbo].[KPICalcs] kpi(nolock)  where  KPI_ID=@kpi_id  for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable),'  is null  ')  from [dbo].[KPICalcs] kpi(nolock)  where  KPI_ID=@kpi_id  for xml path('')),1,3,'' )) f ;
   
				select @formcash=@formcash+','+quotename(@kpi+'!B')+'= case when '+f.cs+' then null else ('+e.eq+') end' from  
					(select eq=stuff((select  '+isnull(',quotename(Variable+'!B'),',0)  '  from [dbo].[KPICalcs] kpi(nolock)  where  KPI_ID=@kpi_id for xml path('')),1,1,'' )) e outer apply
				    (select cs=stuff((select    concat('and ',quotename(Variable+'!B'),'  is null  ')  from [dbo].[KPICalcs] kpi(nolock)  where  KPI_ID=@kpi_id  for xml path('')),1,3,'' )) f ;
    
				select @form=@form+',	  ( sum(case when '+quotename(Variable)+' in('+TopNbox+')  then [weight] else 0.0 end) /nullif(sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight] end),0)   ) as '+quotename(Variable) 
								+',	sum(case when '+quotename(Variable)+'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then [weight]/[WCNT] end) as '+quotename(Variable+'!B') 
					  ,@form1=@form1+'+ (case when '+quotename(Variable) +'  in('+[TopNBox]+','+[Mid3Box]+','+[Bot2Box]+')  then cast(1.0 as float) else cast(0.0 as float) end) '
				from   [dbo].[KPICalcs](nolock)  where KPI_ID=@kpi_id ;

				set @form=stuff(@form,1,1,'') ;
				  
				 set @form=replace(@form,'/[WCNT]','/('+stuff(@form1,1,1,'')+')' );
	
				set @customer_cash_score=', cashscore as ( 
							select isnull( cast(  [QUARTER_NEW] as nvarchar),''YTD'') as TP,b.[Group],b.[Region],b.District,b.Store,
									( case when Grouping([Group])=1  then ''F''  when Grouping(Region)=1  then ''G''			 
									when Grouping(District)=1 then ''R''  when Grouping([Store])=1 then ''D''   else ''S'' end) as AL 	,
									'+@form+char(10)+@c2+'
							from  rawdata as b  where YEAR_NEW= @YEAR_NEW  '+(select concat(' and ( [Quarter_NEW] between ', min(Qrt_ID),' and ',max(qrt_id),' )') from V_Year_Quarter(nolock) where Year_ID=@YEAR_NEW)+' 
							group by   Grouping sets( YEAR_NEW, [QUARTER_NEW]   ) ,Rollup(b.[Group],b.[Region],b.District,b.Store) 
						 ) 
						, c1 as (
						 select AL, TP, [Group], [Region], District, Store'+@formcash+'
						 from   cashscore 	  t  where flag=1
						)
						select  concat(''Group '',[g]) [Group],concat(''Region '',[r]) [Region],concat(''District '',[d]) [District],concat(''Store '',[s]) [Store],
						   '+@ps3+','+case when @kpi='Customer CASH Score' then  ' cast( 
						         (case AL when ''F'' then  (select top 1 cs from [dbo].[Goals_Pivoted](nolock) where overall=-1 )
										when ''G'' then  (select  top 1  cs from [dbo].[Goals_Pivoted](nolock) where  [Group]=p.[g]) 
										when ''R'' then  (select  top 1   cs from [dbo].[Goals_Pivoted](nolock) where  [Region]=p.[r]) 
										when ''D'' then  (select   top 1 cs from [dbo].[Goals_Pivoted](nolock) where  [District]=p.[d])  
								end) as decimal(18,1) )' else ' null ' end 
								+' as [Goal] 
						from (
							select TP+(case when charindex(''!B'',Variable)>0 then N''!Base'' else N'''' end) as  TP,[Group] g,[Region] r,District d ,Store s,value,AL
							from   c1
							 unpivot(Value for Variable in('+quotename(@kpi)+','+quotename(@kpi+'!B')+')) up
						 )ut
						  pivot( sum(Value) for TP in('+@ps1+')) p
							  
					order by  g,r,d,s
						'   ;
				 set @sql=@raw+@customer_cash_score ;
				
				 exec sp_executesql @sql,N'  @YEAR_NEW int ', @YEAR_NEW   ;
   end ;

  --- select @sql;
     set nocount off ;
end

 

GO
/****** Object:  StoredProcedure [dbo].[p_get_Trend]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [p_get_Trend_base] 2,5,-1,'',-1,-1,-1,-1
  exec [p_get_Trend_test] 2,7,default,'',-1,-1,-1,-1
 exec [p_get_Trend_base] 3,10,default,'',10,12,157,-1
 exec [p_get_Trend] 3,10,default,'',10,12,157,-1
 exec [p_get_Trend_test] 3,11,default,'',-1,-1,-1,-1
 [p_get_Trend_test] 3,11,default,'',40,19,140,-1
 [p_get_Trend_test] 3,10,default,'',40,19,145,-1
  [p_get_Trend_test] 3,10,default,'',40,19,-1,-1
   [p_get_Trend_test] 3,10,default,'',40,-1,-1,-1
   [p_get_Trend_test] 3,9,default,'',40,-1,-1,-1
     [p_get_Trend_test] 3,10,default,'',10,40,300,6199
	  exec [p_get_Trend_test] 3,9,default,'',-1,-1,-1,-1
	  go
	  exec [p_get_Trend_test] 2,7,default,'',-1,-1,-1,-1
*/
CREATE   procedure [dbo].[p_get_Trend](
@YEAR_NEW int , 
@QUARTER_NEW int  ,
@kpi  int =-1,
@wherecondition nvarchar(max) ,
@group int  ,
@region int  ,
@district int  ,
@store  int  ,
@Age   nvarchar(100)='',
@Frequency_of_shopping  nvarchar(100)='',
@Gender  nvarchar(100)='',
@Income  nvarchar(100)='',
@Racial_background  nvarchar(100)='',
@Government_benefits  nvarchar(100)='',
@Store_Format  nvarchar(100)='',
@Store_Cluster  nvarchar(100)='',
@Shopper_Segment  nvarchar(100)='' 
)
as 
begin 

   set nocount on ; 
   declare @sql nvarchar(max) ='',   
		   @form2 nvarchar(max),
		   @form3 nvarchar(4000)='',
		   @form3_1 nvarchar(4000)='', 
		   @raw nvarchar(max)='',
		   @groupby nvarchar(max)='' ,
		   @hierarchy nvarchar(max)='',	
		   @form5_1 nvarchar(max)='',
		   @form_1 nvarchar(max)='',
		   @form5_2 nvarchar(max)='',
		   @form_2 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),@where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @VartoPrevPeriod nvarchar(1000),
		   @vartolastyearperiod nvarchar(500);
			
	 
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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;

---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 '+char(10),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+char(10)+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sc+')  ',
							@where_raw +char(10),'  )   ')+char(10)  ; 

							 
     set @form2='' ;
	 
	 
	  select @form3=  @form3+ '[Q'+cast(Qrt_ID as nvarchar)+'],'
			 ,@form3_1= @form3_1+'cast(100.0*[Q'+cast(Qrt_ID as nvarchar)+'] as decimal(18,0) )   [Q'+cast(Quarter_NEW as nvarchar)+'],'
			 , @VartoPrevPeriod= case when Qrt_ID=@QUARTER_NEW then 'cast(100.0*[Q'+cast(Qrt_ID as nvarchar)+'] -100*[Q'
			 +coalesce(( select top 1 'P'   from  [dbo].[V_Year_Quarter](nolock)  where Year_ID=t.Year_ID -1 and Qrt_ID=t.Qrt_ID-1) , cast(Qrt_ID-1 as nvarchar) )+'] as decimal(18,0))  ' else @VartoPrevPeriod end,
			 @vartolastyearperiod=case when Qrt_ID=@QUARTER_NEW then 'cast(100.0*([Q'+cast(Qrt_ID as nvarchar)+'] -[LastYear]) as decimal(18,0))' else @vartolastyearperiod end
	   from   [dbo].[V_Year_Quarter] t(nolock)  where Year_ID=@YEAR_NEW  order by Qrt_ID;
	  
	 

	   set @form3=@form3+N'[YTD],[LastYear],[QP]'  ; 
	   set @form3_1=@form3_1+N'cast(100*[YTD] as decimal(18,0)) [YTD],'+isnull(@VartoPrevPeriod,' NULL ')+'    [VartoPrevPeriod],'+isnull(@vartolastyearperiod,' NULL ')+' [LastYear]';
 
----------------ID	Scale
----------------1	
----------------2	BASE
----------------3	Positive
----------------4	Neutral
----------------5	Negative

 if @kpi>0
 begin
	  select  @form2=@form2+ ',  ['+cast(Position as nvarchar )+'1]'  + concat(', [',Position,'3] , [',Position,'4] , [',Position,'5],[',Position,'2]')
	        , @form_1= @form_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight] else 0.0  end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as ['+cast(Position as nvarchar)+'1]',

			 @form5_1= @form5_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'3]') +
				      ',sum(case when '+quotename([Variable name])+' in('+mid3box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'4]')+
			          ',sum(case when '+quotename([Variable name])+' in('+bot2box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight] end),0) as [',Position,'5]')+
					  ', sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight]/100.0 end)  as [',Position,'2]')
	  from [dbo].[Questionnaire](nolock) where   Trend=1 and   L3_order=  @kpi ;
  end
  else
  begin

	  select  @form2=@form2+ ',  ['+cast(Position as nvarchar )+'1]'  + concat(', [',Position,'3] , [',Position,'4] , [',Position,'5],[',Position,'2]')
	        , @form_1= @form_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight] else 0.0  end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as ['+cast(Position as nvarchar)+'1]',

			 @form5_1= @form5_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'3]') +
				      ',sum(case when '+quotename([Variable name])+' in('+mid3box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'4]')+
			          ',sum(case when '+quotename([Variable name])+' in('+bot2box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight] end),0) as [',Position,'5]')+
					  ', sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight]/100.0 end)  as [',Position,'2]')
	  from [dbo].[Questionnaire](nolock) where   Trend=1    ;

  end

   set @form2=stuff(@form2,1,1,'') ; 
	set @groupby= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						   case when  @district  is null then null else ',[Group],[Region],District' end ,
						   case when  @region is null then null else ',[Group],[Region]' end,
						   case when  @group  is null then null else ',[Group]' end, ''		 );

	set @hierarchy	=coalesce(' and Store='+cast(@store as nvarchar)  ,
							 ' and District='+cast(@district as nvarchar)  ,
							 ' and [Region]='+cast(@region as nvarchar)  ,
							 ' and [Group]='+cast(@group as nvarchar)  ,
							 ''		 ); 
					 	  
	set @sql=@raw+'  
			,trend as (    
					select   ''YTD''  as TP 
					'+@groupby+@form_1+@form5_1+'
					from  rawdata  where  YEAR_NEW= @YEAR_NEW  '+@hierarchy+' 
					 '+isnull(' group by '+nullif(stuff(@groupby,1,1,''),''),'') +'
			union all
					select    ''LastYear''  as TP 
					'+@groupby+@form_1+@form5_1+'
					from  rawdata  where  YEAR_NEW=(@YEAR_NEW-1)  and  QUARTER_NEW=(@QUARTER_NEW-4) '+@hierarchy+' 
					  '+isnull(' group by '+nullif(stuff(@groupby,1,1,''),''),'') +'
			union all 
		    select     ''Q''+cast( QUARTER_NEW as nvarchar) as TP  '   +@groupby+@form_1+@form5_1+'
		    from  rawdata  where YEAR_NEW= @YEAR_NEW   '+@hierarchy+' 
			group by     QUARTER_NEW   '+@groupby+' 
            '+
			case when @QUARTER_NEW%4=1 then '	union all 
						select    ''QP'' as TP  '   +@groupby+@form_1+@form5_1+'
						from  rawdata  where YEAR_NEW= ( @YEAR_NEW-1  )  and QUARTER_NEW=(@QUARTER_NEW-1)  '+@hierarchy+' 
						   '+isnull('group by '+stuff(nullif(@groupby,''),1,1,''),'') 
			    else ' '
			 end 
			+' 	
			 )    select  
							 c.L3 as L2,c.label as Variable,c.scale as Value,
							'+@form3_1+' ,iif(c.id=2,case when  [YTD]  is null  then ''none'' else ''inline''  end,'''') as [Graph]  
					  from   trend  t 
					 unpivot(Value for Variable in( '+@form2+') ) up
					 pivot(sum(Value) for  TP  in('+@form3+') ) p
					 right join '+case when @kpi >0 then ' (select * from   [trends_head](nolock)  where L3_Order='+cast(@kpi as nvarchar) +' ) ' else '  [trends_head](nolock) ' end+'   c 
								on c.Pos_id=  Variable  
			  order by   c.L3_Order ,c.QuestionOrder, c.id  
    
			 ;' ;
		----- select @sql  ;
			--- print @sql
		     exec sp_executesql @sql,N'@YEAR_NEW int,@QUARTER_NEW int ',@YEAR_NEW,@QUARTER_NEW  ;

 set nocount off ;
end

 

GO
/****** Object:  StoredProcedure [dbo].[p_get_Trend_20150326BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [p_get_Trend_test] 3,9,'',-1,-1,-1,-1
 [p_get_Trend_test] 3,9,'',-1,-1,-1,-1
 [p_get_Trend_test] 3,9,'',-1,-1,-1,-1
 [p_get_Trend_test] 3,9,'',40,19,140,-1
 [p_get_Trend_test] 3,9,'',40,19,145,-1
  [p_get_Trend_test] 3,9,'',40,19,-1,-1
   [p_get_Trend_test] 3,9,'',40,-1,-1,-1
     [p_get_Trend_test] 3,9,'',10,40,300,6199
*/
create  procedure [dbo].[p_get_Trend_20150326BAK](
@YEAR_NEW int , 
@QUARTER_NEW int  ,
@wherecondition nvarchar(max) ,
@group int  ,
@region int  ,
@district int  ,
@store  int   
)
as 
begin 

   set nocount on ; 
   declare @sql nvarchar(max) ='',  
		   @trend nvarchar(max)='', 
		   @form nvarchar(max)='',
		   @form2 nvarchar(max)='',
		   @form3 nvarchar(4000)='',
		   @form3_1 nvarchar(4000)='', 
		   @form5 nvarchar(max)='',
		   @form6 nvarchar(max)='',
		   @form8 nvarchar(max)='',
		   @form9 nvarchar(max)='',
		   @raw nvarchar(max)='',
		   @groupby nvarchar(max)='' ,
		   @hierarchy nvarchar(max)='',	
		   @form5_1 nvarchar(max)='',
		   @form_1 nvarchar(max)='',
		   @form5_2 nvarchar(max)='',
		   @form_2 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int;
 
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	

			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	
 
---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 



	set @form3=N'[SurVeysCompleted],[Q1],[Q2],[Q3],[Q4],[YTD],[LastYear]'  ; 
	set @form3_1=N'cast([SurVeysCompleted] as decimal(18,0)) [SurVeysCompleted],cast(100*[Q1] as decimal(18,0)) as [Q1],cast(100*[Q2] as decimal(18,0)) [Q2],cast(100*[Q3] as decimal(18,0)) [Q3],cast(100*[Q4] as decimal(18,0)) [Q4],cast(100*[YTD] as decimal(18,0)) [YTD],cast(100*[LastYear] as decimal(18,0)) [LastYear]'  ;


   	select   @form6=@form6+ ', ['+ vr.[Variable name]  +'!Positive] , ['+ vr.[Variable name]  +'!Neutral] , ['+ vr.[Variable name]  +'!Negative]'
			, @form2=@form2+ ',  '+quotename( [Variable name] ) 
	from   [dbo].[Questionnaire] vr  where Trend='1'  ;
     
 	set @form2=stuff(@form2,1,1,'') ; 

	  select  @form= @form+', sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then 1 end) as ['+[Variable name]+']',
			  @form5= @form5+', null as  ['+[Variable name]+'!Positive],  null as ['+[Variable name]+'!Neutral],null as ['+[Variable name]+']',
	  
	         @form_1= @form_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight] end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as ['+[Variable name]+']',

			 @form5_1= @form5_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight] end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then  [weight] end),0) as ['+[Variable name]+'!Positive]' +
				      ',sum(case when '+quotename([Variable name])+' in('+mid3box+') then [weight] end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then  [weight] end),0) as ['+[Variable name]+'!Neutral]'+
			          ',sum(case when '+quotename([Variable name])+' in('+bot2box+') then [weight] end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as ['+[Variable name]+'!Negative]'
	  from [dbo].[Questionnaire] where   Trend='1'
	   
   
	set @groupby= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						   case when  @district  is null then null else ', [Group],[Region],District' end ,
						   case when  @region is null then null else ',[Group],[Region]' end,
						   case when  @group  is null then null else ',[Group]' end, ''		 );

	set @hierarchy	=coalesce(case when  @store  is null then null else ' and Store='+cast(@store as nvarchar) end,
			         case when  @district  is null then null else ' and District='+cast(@district as nvarchar) end ,
					 case when  @region  is null then null else ' and [Region]='+cast(@region as nvarchar) end,
					 case when  @group  is null then null else ' and [Group]='+cast(@group as nvarchar) end,
					 ''
					 ); 
					 	  
	set @sql=@raw+'  ,YTD as (		
	        select  '	+isnull(nullif(stuff(@groupby,1,1,''),'')+',','')+stuff(@form_1,1,1,'')+@form5_1+'
		    from  rawdata  where  YEAR_NEW= @YEAR_NEW   '+@hierarchy+' 
			'+coalesce(' group by  '+nullif(stuff(@groupby,1,1,''),'') ,'' )+'
			),LastYear as (	 
					select   ' 	+isnull(nullif(stuff(@groupby,1,1,''),'')+',','')+stuff(@form_1,1,1,'')+@form5_1+'
					from  rawdata  Where   YEAR_NEW=( @YEAR_NEW-1  )  '+@hierarchy+' 
					'+coalesce(' group by  '+nullif(stuff(@groupby,1,1,''),'') ,'' )+'
			)	
			,trend as (   
			select ''YTD'' TP,* from YTD
			union all select ''LastYear'' TP,* from LastYear
			union all 
		    select  concat(''Q'', isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)) as TP  '   +@groupby+@form_1+@form5_1+'
		    from  rawdata  where YEAR_NEW= @YEAR_NEW   '+@hierarchy+' 
			group by  concat(''Q'', isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)) '+@groupby+' 
			 
			union all 
	        select  ''SurVeysCompleted''  '	+@groupby+@form+@form5+'
		    from  rawdata  Where   YEAR_NEW= @YEAR_NEW   '+@hierarchy+' 
			'+coalesce(' group by  '+nullif(stuff(@groupby,1,1,''),'') ,'' )+' 				 
			
			 )  
			,tab as (
					select  
							(case when charindex(''!'',Variable)>0 then  left(Variable, charindex(''!'',Variable)-1) else  Variable end) as Variable,
							isnull((case when charindex(''!'',Variable)>0 then  right(Variable,len(Variable)-charindex(''!'',Variable))  end ),'''') as Value,
							'+@form3_1+'  
					  from  (select TP,'+@form2+@form6+'  from trend ) t 
					 unpivot(Value for Variable in( '+@form2+@form6+') ) up
					 pivot(sum(Value) for  TP  in('+@form3+') ) p
			 ) 
			 select c.L3 as L2,c.label as Variable,c.scale as Value,[SurVeysCompleted],[Q1],[Q2],[Q3],[Q4],[YTD],[YTD]-[LastYear] as [VartoPrevPeriod],[LastYear],null as [Graph]
			  from  tab   a   right join (select q.L3,q.Label,q.[Variable Name],ts.Scale,ts.id,q.QuestionOrder from  [dbo].[Questionnaire] q inner join Trend_Scale_Breakdown ts on 1=1 where  q.Trend=''1'') c 
								on c.[Variable Name]=a.Variable 
							  and c.scale=a.Value
			  order by   c.L3 desc,c.QuestionOrder,c.id
  ;
			   
			 ;' ;
			  
	--- select @sql ;
		     exec sp_executesql @sql,N'@YEAR_NEW int ',@YEAR_NEW   ;


set nocount off ;
end

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_Trend_20150327BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [p_get_Trend_test] 3,9,'',-1,-1,-1,-1
 [p_get_Trend_test] 3,10,'',-1,-1,-1,-1
 [p_get_Trend_test] 3,10,'',-1,-1,-1,-1
 [p_get_Trend_test] 3,10,'',40,19,140,-1
 [p_get_Trend_test] 3,10,'',40,19,145,-1
  [p_get_Trend_test] 3,10,'',40,19,-1,-1
   [p_get_Trend_test] 3,10,'',40,-1,-1,-1
     [p_get_Trend_test] 3,10,'',10,40,300,6199
*/
create  procedure [dbo].[p_get_Trend_20150327BAK](
@YEAR_NEW int , 
@QUARTER_NEW int  ,
@wherecondition nvarchar(max) ,
@group int  ,
@region int  ,
@district int  ,
@store  int   
)
as 
begin 

   set nocount on ; 
   declare @sql nvarchar(max) ='',  
		   @trend nvarchar(max)='', 
		   @form nvarchar(max)='',
		   @form2 nvarchar(max)='',
		   @form3 nvarchar(4000)='',
		   @form3_1 nvarchar(4000)='', 
		   @form5 nvarchar(max)='',
		   @form6 nvarchar(max)='',
		   @form8 nvarchar(max)='',
		   @form9 nvarchar(max)='',
		   @raw nvarchar(max)='',
		   @groupby nvarchar(max)='' ,
		   @hierarchy nvarchar(max)='',	
		   @form5_1 nvarchar(max)='',
		   @form_1 nvarchar(max)='',
		   @form5_2 nvarchar(max)='',
		   @form_2 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int;
 
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	

			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	
 
---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 



	set @form3=N'[SurVeysCompleted],[Q1],[Q2],[Q3],[Q4],[YTD],[LastYear]'  ; 
	set @form3_1=N'cast([SurVeysCompleted] as decimal(18,0)) [SurVeysCompleted],cast(100*[Q1] as decimal(18,0)) as [Q1],cast(100*[Q2] as decimal(18,0)) [Q2],cast(100*[Q3] as decimal(18,0)) [Q3],cast(100*[Q4] as decimal(18,0)) [Q4],cast(100*[YTD] as decimal(18,0)) [YTD],cast(100*[LastYear] as decimal(18,0)) [LastYear]'  ;


   	select   @form6=@form6+ ', ['+ vr.[Variable name]  +'!Positive] , ['+ vr.[Variable name]  +'!Neutral] , ['+ vr.[Variable name]  +'!Negative]'
			, @form2=@form2+ ',  '+quotename( [Variable name] ) 
	from   [dbo].[Questionnaire] vr  where Trend='1'  ;
     
 	set @form2=stuff(@form2,1,1,'') ; 

	  select  @form= @form+', sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then 1 end) as ['+[Variable name]+']',
			  @form5= @form5+', null as  ['+[Variable name]+'!Positive],  null as ['+[Variable name]+'!Neutral],null as ['+[Variable name]+']',
	  
	         @form_1= @form_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight] else 0.0  end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as ['+[Variable name]+']',

			 @form5_1= @form5_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then  [weight] end),0) as ['+[Variable name]+'!Positive]' +
				      ',sum(case when '+quotename([Variable name])+' in('+mid3box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then  [weight] end),0) as ['+[Variable name]+'!Neutral]'+
			          ',sum(case when '+quotename([Variable name])+' in('+bot2box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as ['+[Variable name]+'!Negative]'
	  from [dbo].[Questionnaire] where   Trend='1'
	   
   
	set @groupby= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						   case when  @district  is null then null else ', [Group],[Region],District' end ,
						   case when  @region is null then null else ',[Group],[Region]' end,
						   case when  @group  is null then null else ',[Group]' end, ''		 );

	set @hierarchy	=coalesce(case when  @store  is null then null else ' and Store='+cast(@store as nvarchar) end,
			         case when  @district  is null then null else ' and District='+cast(@district as nvarchar) end ,
					 case when  @region  is null then null else ' and [Region]='+cast(@region as nvarchar) end,
					 case when  @group  is null then null else ' and [Group]='+cast(@group as nvarchar) end,
					 ''
					 ); 
					 	  
	set @sql=@raw+'  ,YTD as (		
	        select  '	+isnull(nullif(stuff(@groupby,1,1,''),'')+',','')+stuff(@form_1,1,1,'')+@form5_1+'
		    from  rawdata  where  YEAR_NEW= @YEAR_NEW   '+@hierarchy+' 
			'+coalesce(' group by  '+nullif(stuff(@groupby,1,1,''),'') ,'' )+'
			),LastYear as (	 
					select   ' 	+isnull(nullif(stuff(@groupby,1,1,''),'')+',','')+stuff(@form_1,1,1,'')+@form5_1+'
					from  rawdata  Where   YEAR_NEW=( @YEAR_NEW-1  )  '+@hierarchy+' 
					'+coalesce(' group by  '+nullif(stuff(@groupby,1,1,''),'') ,'' )+'
			)	
			,trend as (   
			select ''YTD'' TP,* from YTD
			union all select ''LastYear'' TP,* from LastYear
			union all 
		    select  concat(''Q'', isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)) as TP  '   +@groupby+@form_1+@form5_1+'
		    from  rawdata  where YEAR_NEW= @YEAR_NEW   '+@hierarchy+' 
			group by  concat(''Q'', isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)) '+@groupby+' 
			 
			union all 
	        select  ''SurVeysCompleted''  '	+@groupby+@form+@form5+'
		    from  rawdata  Where   YEAR_NEW= @YEAR_NEW   '+@hierarchy+' 
			'+coalesce(' group by  '+nullif(stuff(@groupby,1,1,''),'') ,'' )+' 				 
			
			 )  
			,tab as (
					select  
							(case when charindex(''!'',Variable)>0 then  left(Variable, charindex(''!'',Variable)-1) else  Variable end) as Variable,
							isnull((case when charindex(''!'',Variable)>0 then  right(Variable,len(Variable)-charindex(''!'',Variable))  end ),'''') as Value,
							'+@form3_1+'  
					  from  (select TP,'+@form2+@form6+'  from trend ) t 
					 unpivot(Value for Variable in( '+@form2+@form6+') ) up
					 pivot(sum(Value) for  TP  in('+@form3+') ) p
			 ) 
			 select c.L3 as L2,c.label as Variable,c.scale as Value,[SurVeysCompleted],[Q1],[Q2],[Q3],[Q4],[YTD],'
			 +case @QUARTER_NEW%4 when 0 then '[Q4]-[Q3] ' when 1 then ' null ' when 2 then '[Q2]-[Q1] ' when 3 then '[Q3]-[Q2] ' else ' null ' end+' as [VartoPrevPeriod],[LastYear],null as [Graph]
			  from  tab   a   right join (select q.L3,q.Label,q.[Variable Name],ts.Scale,ts.id,q.QuestionOrder,q.L3_Order
										 from  [dbo].[Questionnaire] q inner join Trend_Scale_Breakdown ts on 1=1 and not(q.mid3box=''-98'' and ts.scale=''Neutral'')		  where  q.Trend=''1'') c 
								on c.[Variable Name]=a.Variable 
							  and c.scale=a.Value
			  order by   c.L3_Order ,c.QuestionOrder,c.id
    
			 ;' ;
			  
	--- select @sql ;
		     exec sp_executesql @sql,N'@YEAR_NEW int ',@YEAR_NEW   ;


set nocount off ;
end

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_Trend_20150401BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [p_get_Trend_test] 2,5,'',-1,-1,-1,-1
 [p_get_Trend_test] 3,10,'',-1,-1,-1,-1
 [p_get_Trend_test] 3,9,'',-1,-1,-1,-1
 [p_get_Trend_test] 3,10,'',40,19,140,-1
 [p_get_Trend_test] 3,10,'',40,19,145,-1
  [p_get_Trend_test] 3,10,'',40,19,-1,-1
   [p_get_Trend_test] 3,10,'',40,-1,-1,-1
     [p_get_Trend_test] 3,10,'',10,40,300,6199
*/
create   procedure [dbo].[p_get_Trend_20150401BAK](
@YEAR_NEW int , 
@QUARTER_NEW int  ,
@wherecondition nvarchar(max) ,
@group int  ,
@region int  ,
@district int  ,
@store  int   
)
as 
begin 

   set nocount on ; 
   declare @sql nvarchar(max) ='',  
		   @trend nvarchar(max)='', 
		   @form nvarchar(max)='',
		   @form2 nvarchar(max)='',
		   @form3 nvarchar(4000)='',
		   @form3_1 nvarchar(4000)='', 
		   @form5 nvarchar(max)='',
		   @form6 nvarchar(max)='',
		   @form8 nvarchar(max)='',
		   @form9 nvarchar(max)='',
		   @raw nvarchar(max)='',
		   @groupby nvarchar(max)='' ,
		   @hierarchy nvarchar(max)='',	
		   @form5_1 nvarchar(max)='',
		   @form_1 nvarchar(max)='',
		   @form5_2 nvarchar(max)='',
		   @form_2 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int;
 
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	

			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	
 
---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 



	set @form3=N'[SurVeysCompleted],[Q1],[Q2],[Q3],[Q4],[YTD],[LastYear],[QP]'  ; 
	set @form3_1=N'cast([SurVeysCompleted] as decimal(18,0)) [SurVeysCompleted],cast(100*[Q1] as decimal(18,0)) as [Q1],cast(100*[Q2] as decimal(18,0)) [Q2],cast(100*[Q3] as decimal(18,0)) [Q3],cast(100*[Q4] as decimal(18,0)) [Q4],cast(100*[YTD] as decimal(18,0)) [YTD],cast(100*[LastYear] as decimal(18,0)) [LastYear],cast(100*[QP] as decimal(18,0)) as [QP]'  ;
	 
   	select   @form6=@form6+ ', ['+ vr.[Variable name]  +'!Positive] , ['+ vr.[Variable name]  +'!Neutral] , ['+ vr.[Variable name]  +'!Negative]'
			, @form2=@form2+ ',  '+quotename( [Variable name] ) 
	from   [dbo].[Questionnaire] vr  where Trend='1'  ;
     
 	set @form2=stuff(@form2,1,1,'') ; 

	  select  @form= @form+', sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then 1 end) as ['+[Variable name]+']',
			  @form5= @form5+', null as  ['+[Variable name]+'!Positive],  null as ['+[Variable name]+'!Neutral],null as ['+[Variable name]+']',
	  
	         @form_1= @form_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight] else 0.0  end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as ['+[Variable name]+']',

			 @form5_1= @form5_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then  [weight] end),0) as ['+[Variable name]+'!Positive]' +
				      ',sum(case when '+quotename([Variable name])+' in('+mid3box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then  [weight] end),0) as ['+[Variable name]+'!Neutral]'+
			          ',sum(case when '+quotename([Variable name])+' in('+bot2box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as ['+[Variable name]+'!Negative]'
	  from [dbo].[Questionnaire] where   Trend='1'
	   
   
	set @groupby= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						   case when  @district  is null then null else ',[Group],[Region],District' end ,
						   case when  @region is null then null else ',[Group],[Region]' end,
						   case when  @group  is null then null else ',[Group]' end, ''		 );

	set @hierarchy	=coalesce(' and Store='+cast(@store as nvarchar)  ,
							 ' and District='+cast(@district as nvarchar)  ,
							 ' and [Region]='+cast(@region as nvarchar)  ,
							 ' and [Group]='+cast(@group as nvarchar)  ,
							 ''		 ); 
					 	  
	set @sql=@raw+'  ,YTD as (		
	        select  '	+isnull(nullif(stuff(@groupby,1,1,''),'')+',','')+stuff(@form_1,1,1,'')+@form5_1+'
		    from  rawdata  where  YEAR_NEW= @YEAR_NEW   '+@hierarchy+' 
			'+coalesce(' group by  '+nullif(stuff(@groupby,1,1,''),'') ,'' )+'
			),LastYear as (	 
					select   ' 	+isnull(nullif(stuff(@groupby,1,1,''),'')+',','')+stuff(@form_1,1,1,'')+@form5_1+'
					from  rawdata  Where   YEAR_NEW=( @YEAR_NEW-1  )  '+@hierarchy+' 
					'+coalesce(' group by  '+nullif(stuff(@groupby,1,1,''),'') ,'' )+'
			)	
			,trend as (   
			select ''YTD'' TP,* from YTD
			union all select ''LastYear'' TP,* from LastYear
			union all 
		    select   concat(''Q'', isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)) as TP  '   +@groupby+@form_1+@form5_1+'
		    from  rawdata  where YEAR_NEW= @YEAR_NEW   '+@hierarchy+' 
			group by  concat(''Q'', isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)) '+@groupby+' 
            '+
			case when @QUARTER_NEW%4=1 then '	union all 
						select    ''QP'' as TP  '   +@groupby+@form_1+@form5_1+'
						from  rawdata  where YEAR_NEW= (@YEAR_NEW-1) and QUARTER_NEW='+cast( @QUARTER_NEW-1  as nvarchar ) +'  '+@hierarchy+' 
						   '+isnull('group by '+stuff(nullif(@groupby,''),1,1,''),'') 
			    else ' '
			 end 
			+' 						  
			union all 
	        select  ''SurVeysCompleted''  '	+@groupby+@form+@form5+'
		    from  rawdata  Where   YEAR_NEW= @YEAR_NEW   '+@hierarchy+' 
			'+coalesce(' group by  '+nullif(stuff(@groupby,1,1,''),'') ,'' )+' 				 
			
			 )  
			,tab as (
					select  
							(case when charindex(''!'',Variable)>0 then  left(Variable, charindex(''!'',Variable)-1) else  Variable end) as Variable,
							isnull((case when charindex(''!'',Variable)>0 then  right(Variable,len(Variable)-charindex(''!'',Variable))  end ),'''') as Value,
							'+@form3_1+'  
					  from  (select TP,'+@form2+@form6+'  from trend ) t 
					 unpivot(Value for Variable in( '+@form2+@form6+') ) up
					 pivot(sum(Value) for  TP  in('+@form3+') ) p
			 ) 
			 select c.L3 as L2,c.label as Variable,c.scale as Value,[SurVeysCompleted],[Q1],[Q2],[Q3],[Q4],[YTD],'
			 +(case  (@QUARTER_NEW%4) when  0  then '[Q4]-[Q3] '	  when  1 then ' [Q1]-[QP] '
									  when  2 then '[Q2]-[Q1] '       when  3 then '[Q3]-[Q2] ' 
					  else ' null ' end)
			 +' as [VartoPrevPeriod],[LastYear],null as [Graph]
			  from  tab   a   right join (select q.L3,q.Label,q.[Variable Name],ts.Scale,ts.id,q.QuestionOrder,q.L3_Order
										 from  [dbo].[Questionnaire] q(nolock) inner join Trend_Scale_Breakdown ts(nolock) on 1=1 and not(q.mid3box=''-98'' and ts.scale=''Neutral'')	 where  q.Trend=''1'') c 
								on c.[Variable Name]=a.Variable 
							  and c.scale=a.Value
			  order by   c.L3_Order ,c.QuestionOrder,c.id
    
			 ;' ;
			   
		     exec sp_executesql @sql,N'@YEAR_NEW int ',@YEAR_NEW  ;
---select @sql ;
 
end

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_Trend_20150403BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [p_get_Trend_base] 2,5,-1,'',-1,-1,-1,-1
 exec [p_get_Trend_base] 3,10,default,'',10,12,157,-1
 exec [p_get_Trend] 3,10,default,'',10,12,157,-1
 [p_get_Trend_base] 3,9,default,'',-1,-1,-1,-1
 [p_get_Trend_base] 3,10,default,'',40,19,140,-1
 [p_get_Trend_base] 3,10,default,'',40,19,145,-1
  [p_get_Trend_base] 3,10,default,'',40,19,-1,-1
   [p_get_Trend_base] 3,10,default,'',40,-1,-1,-1
     [p_get_Trend_base] 3,10,default,'',10,40,300,6199
*/
CREATE   procedure [dbo].[p_get_Trend_20150403BAK](
@YEAR_NEW int , 
@QUARTER_NEW int  ,
@kpi  int =-1,
@wherecondition nvarchar(max) ,
@group int  ,
@region int  ,
@district int  ,
@store  int   
)
as 
begin 

   set nocount on ; 
   declare @sql nvarchar(max) ='',   
		   @form2 nvarchar(max),
		   @form3 nvarchar(4000)='',
		   @form3_1 nvarchar(4000)='', 
		   @form6 nvarchar(max)='',
		   @form8 nvarchar(max)='',
		   @form9 nvarchar(max)='',
		   @raw nvarchar(max)='',
		   @groupby nvarchar(max)='' ,
		   @hierarchy nvarchar(max)='',	
		   @form5_1 nvarchar(max)='',
		   @form_1 nvarchar(max)='',
		   @form5_2 nvarchar(max)='',
		   @form_2 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int;
			
	 
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	

			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	
 
---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 



	set @form3=N'[Q1],[Q2],[Q3],[Q4],[YTD],[LastYear],[QP]'  ; 
	set @form3_1=N'cast(100*[Q1] as decimal(18,0)) as [Q1],cast(100*[Q2] as decimal(18,0)) [Q2],cast(100*[Q3] as decimal(18,0)) [Q3],cast(100*[Q4] as decimal(18,0)) [Q4],cast(100*[YTD] as decimal(18,0)) [YTD],cast(100*[LastYear] as decimal(18,0)) [LastYear],cast(100*[QP] as decimal(18,0)) as [QP]'  ;
	set @form2='' ;
	 
	  select   @form6=@form6+ ', ['+ [Variable name]  +'!3] , ['+ [Variable name]  +'!4] , ['+ [Variable name]  +'!5],['+ [Variable name]  +'!2]'
			, @form2=@form2+ ',  '+quotename( [Variable name] )  
	        , @form_1= @form_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight] else 0.0  end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as ['+[Variable name]+']',

			 @form5_1= @form5_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then  [weight] end),0) as ['+[Variable name]+'!3]' +
				      ',sum(case when '+quotename([Variable name])+' in('+mid3box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then  [weight] end),0) as ['+[Variable name]+'!4]'+
			          ',sum(case when '+quotename([Variable name])+' in('+bot2box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as ['+[Variable name]+'!5]'+
					  ', sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight]/100.0 end)  as ['+[Variable name]+'!2]'
	  from [dbo].[Questionnaire] where   Trend='1' and L3_order=(case when @kpi>0 then  @kpi else L3_order end)   ;
 
	   
   set @form2=stuff(@form2,1,1,'') ; 
	set @groupby= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						   case when  @district  is null then null else ',[Group],[Region],District' end ,
						   case when  @region is null then null else ',[Group],[Region]' end,
						   case when  @group  is null then null else ',[Group]' end, ''		 );

	set @hierarchy	=coalesce(' and Store='+cast(@store as nvarchar)  ,
							 ' and District='+cast(@district as nvarchar)  ,
							 ' and [Region]='+cast(@region as nvarchar)  ,
							 ' and [Group]='+cast(@group as nvarchar)  ,
							 ''		 ); 
					 	  
	set @sql=@raw+'  ,YTD as (		
	        select  '	+isnull(nullif(stuff(@groupby,1,1,''),'')+',','')+stuff(@form_1,1,1,'')+@form5_1+'
		    from  rawdata  where  YEAR_NEW= @YEAR_NEW   '+@hierarchy+' 
			'+coalesce(' group by  '+nullif(stuff(@groupby,1,1,''),'') ,'' )+'
			),LastYear as (	 
					select   ' 	+isnull(nullif(stuff(@groupby,1,1,''),'')+',','')+stuff(@form_1,1,1,'')+@form5_1+'
					from  rawdata  Where   YEAR_NEW=( @YEAR_NEW-1  )  '+@hierarchy+' 
					'+coalesce(' group by  '+nullif(stuff(@groupby,1,1,''),'') ,'' )+'
			)	
			,trend as (   
			select ''YTD'' TP,* from YTD
			union all select ''LastYear'' TP,* from LastYear
			union all 
		    select   concat(''Q'', isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)) as TP  '   +@groupby+@form_1+@form5_1+'
		    from  rawdata  where YEAR_NEW= @YEAR_NEW   '+@hierarchy+' 
			group by  concat(''Q'', isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)) '+@groupby+' 
            '+
			case when @QUARTER_NEW%4=1 then '	union all 
						select    ''QP'' as TP  '   +@groupby+@form_1+@form5_1+'
						from  rawdata  where YEAR_NEW= (@YEAR_NEW-1) and QUARTER_NEW='+cast( @QUARTER_NEW-1  as nvarchar ) +'  '+@hierarchy+' 
						   '+isnull('group by '+stuff(nullif(@groupby,''),1,1,''),'') 
			    else ' '
			 end 
			+' 	
			 )  
			,tab as (
					select  
							(case when charindex(''!'',Variable)>0 then  left(Variable, charindex(''!'',Variable)-1) else  Variable end) as Variable,
							isnull((case when charindex(''!'',Variable)>0 then  right(Variable,len(Variable)-charindex(''!'',Variable))  end ),'''') as Value,
							'+@form3_1+'  
					  from   trend  t 
					 unpivot(Value for Variable in( '+@form2+@form6+') ) up
					 pivot(sum(Value) for  TP  in('+@form3+') ) p
			 ) 
			 select c.L3 as L2,c.label as Variable,c.scale as Value,[Q1],[Q2],[Q3],[Q4],[YTD],'
			 +(case  (@QUARTER_NEW%4) when  0  then '[Q4]-[Q3] '	  when  1 then ' [Q1]-[QP] '
									  when  2 then '[Q2]-[Q1] '       when  3 then '[Q3]-[Q2] ' 
					  else ' null ' end)
			 +' as [VartoPrevPeriod],[LastYear],iif(c.id=2,case when  [Q1] >=0 or  [Q2]>=0 or  [Q3]>=0 or [Q4] >=0 then ''inline'' else ''none'' end,'''') as [Graph]
			  from  tab   a   right join  [trends_head]  c(nolock)
								on c.[Variable Name]=a.Variable 
							    and  c.id=(case when a.Value='''' then 1 else  a.Value end)
			  order by   c.L3_Order ,c.QuestionOrder,c.id
    
			 ;' ;
			   
		     exec sp_executesql @sql,N'@YEAR_NEW int ',@YEAR_NEW  ;
 ----select @sql ;
 set nocount off ;
end

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_Trend_20150410BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [p_get_Trend_base] 2,5,-1,'',-1,-1,-1,-1
 exec [p_get_Trend_base] 3,10,default,'',10,12,157,-1
 exec [p_get_Trend] 3,10,default,'',10,12,157,-1
 exec [p_get_Trend_base] 3,9,default,'',-1,-1,-1,-1
 [p_get_Trend_base] 3,10,default,'',40,19,140,-1
 [p_get_Trend_base] 3,10,default,'',40,19,145,-1
  [p_get_Trend_base] 3,10,default,'',40,19,-1,-1
   [p_get_Trend_base] 3,10,default,'',40,-1,-1,-1
     [p_get_Trend_base] 3,10,default,'',10,40,300,6199
	  exec [p_get_Trend] 3,9,default,'',-1,-1,-1,-1
	  go
	  exec [p_get_Trend_base] 3,9,default,'',-1,-1,-1,-1
*/
CREATE   procedure [dbo].[p_get_Trend_20150410BAK](
@YEAR_NEW int , 
@QUARTER_NEW int  ,
@kpi  int =-1,
@wherecondition nvarchar(max) ,
@group int  ,
@region int  ,
@district int  ,
@store  int   
)
as 
begin 

   set nocount on ; 
   declare @sql nvarchar(max) ='',   
		   @form2 nvarchar(max),
		   @form3 nvarchar(4000)='',
		   @form3_1 nvarchar(4000)='', 
		   @form6 nvarchar(max)='',
		   @form8 nvarchar(max)='',
		   @form9 nvarchar(max)='',
		   @raw nvarchar(max)='',
		   @groupby nvarchar(max)='' ,
		   @hierarchy nvarchar(max)='',	
		   @form5_1 nvarchar(max)='',
		   @form_1 nvarchar(max)='',
		   @form5_2 nvarchar(max)='',
		   @form_2 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int;
			
	 
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	

			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	;
 
	 
---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 

							 
	set @form3=N'[Q1],[Q2],[Q3],[Q4],[YTD],[LastYear],[QP]'  ; 
	set @form3_1=N'cast(100*[Q1] as decimal(18,0)) as [Q1],cast(100*[Q2] as decimal(18,0)) [Q2],cast(100*[Q3] as decimal(18,0)) [Q3],cast(100*[Q4] as decimal(18,0)) [Q4],cast(100*[YTD] as decimal(18,0)) [YTD],cast(100*[LastYear] as decimal(18,0)) [LastYear],cast(100*[QP] as decimal(18,0)) as [QP]'  ;
	set @form2='' ;
	 
----------------ID	Scale
----------------1	
----------------2	BASE
----------------3	Positive
----------------4	Neutral
----------------5	Negative

if @kpi>=0 
begin
	  select   @form6=@form6+ concat(', [',Position,'!3] , [',Position,'!4] , [',Position,'!5],[',Position,'!2]')
			, @form2=@form2+ ',  '+quotename(Position )  
	        , @form_1= @form_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight] else 0.0  end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as '+quotename(Position),

			 @form5_1= @form5_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'!3]') +
				      ',sum(case when '+quotename([Variable name])+' in('+mid3box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'!4]')+
			          ',sum(case when '+quotename([Variable name])+' in('+bot2box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight] end),0) as [',Position,'!5]')+
					  ', sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight]/100.0 end)  as [',Position,'!2]')
	  from [dbo].[Questionnaire] where   Trend='1' and L3_order=  @kpi    ;
end 
else 
begin
	  select   @form6=@form6+ concat(', [',Position,'!3] , [',Position,'!4] , [',Position,'!5],[',Position,'!2]')
			, @form2=@form2+ ',  '+quotename(Position )  
	        , @form_1= @form_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight] else 0.0  end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as '+quotename(Position),

			 @form5_1= @form5_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'!3]') +
				      ',sum(case when '+quotename([Variable name])+' in('+mid3box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'!4]')+
			          ',sum(case when '+quotename([Variable name])+' in('+bot2box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight] end),0) as [',Position,'!5]')+
					  ', sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight]/100.0 end)  as [',Position,'!2]')
	  from [dbo].[Questionnaire] where   Trend='1'
end
 
	   
   set @form2=stuff(@form2,1,1,'') ; 
	set @groupby= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						   case when  @district  is null then null else ',[Group],[Region],District' end ,
						   case when  @region is null then null else ',[Group],[Region]' end,
						   case when  @group  is null then null else ',[Group]' end, ''		 );

	set @hierarchy	=coalesce(' and Store='+cast(@store as nvarchar)  ,
							 ' and District='+cast(@district as nvarchar)  ,
							 ' and [Region]='+cast(@region as nvarchar)  ,
							 ' and [Group]='+cast(@group as nvarchar)  ,
							 ''		 ); 
					 	  
	set @sql=@raw+'  ,YTD as (		
	        select  '	+isnull(nullif(stuff(@groupby,1,1,''),'')+',','')+stuff(@form_1,1,1,'')+@form5_1+'
		    from  rawdata  where  YEAR_NEW= @YEAR_NEW   '+@hierarchy+' 
			'+coalesce(' group by  '+nullif(stuff(@groupby,1,1,''),'') ,'' )+'
			),LastYear as (	 
					select   ' 	+isnull(nullif(stuff(@groupby,1,1,''),'')+',','')+stuff(@form_1,1,1,'')+@form5_1+'
					from  rawdata  Where   YEAR_NEW=( @YEAR_NEW-1  )  '+@hierarchy+' 
					'+coalesce(' group by  '+nullif(stuff(@groupby,1,1,''),'') ,'' )+'
			)	
			,trend as (   
			select ''YTD'' TP,* from YTD
			union all select ''LastYear'' TP,* from LastYear
			union all 
		    select   concat(''Q'', isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)) as TP  '   +@groupby+@form_1+@form5_1+'
		    from  rawdata  where YEAR_NEW= @YEAR_NEW   '+@hierarchy+' 
			group by  concat(''Q'', isnull(nullif( cast( QUARTER_NEW as int) %4,0),4)) '+@groupby+' 
            '+
			case when @QUARTER_NEW%4=1 then '	union all 
						select    ''QP'' as TP  '   +@groupby+@form_1+@form5_1+'
						from  rawdata  where YEAR_NEW= (@YEAR_NEW-1) and QUARTER_NEW='+cast( @QUARTER_NEW-1  as nvarchar ) +'  '+@hierarchy+' 
						   '+isnull('group by '+stuff(nullif(@groupby,''),1,1,''),'') 
			    else ' '
			 end 
			+' 	
			 )  
			,tab as (
					select  
							(case when charindex(''!'',Variable)>0 then  left(Variable, charindex(''!'',Variable)-1) else  Variable end) as Variable,
							isnull((case when charindex(''!'',Variable)>0 then  right(Variable,len(Variable)-charindex(''!'',Variable))  end ),'''') as Value,
							'+@form3_1+'  
					  from   trend  t 
					 unpivot(Value for Variable in( '+@form2+@form6+') ) up
					 pivot(sum(Value) for  TP  in('+@form3+') ) p
			 ) 
			 select c.L3 as L2,c.label as Variable,c.scale as Value,[Q1],[Q2],[Q3],[Q4],[YTD],'
			 +(case  (@QUARTER_NEW%4) when  0  then '[Q4]-[Q3] '	  when  1 then ' [Q1]-[QP] '
									  when  2 then '[Q2]-[Q1] '       when  3 then '[Q3]-[Q2] ' 
					  else ' null ' end)
			 +' as [VartoPrevPeriod],[LastYear],iif(c.id=2,case when  [Q1] >=0 or  [Q2]>=0 or  [Q3]>=0 or [Q4] >=0 then ''inline'' else ''none'' end,'''') as [Graph]
			  from  tab   a   right join    [trends_head]   c (nolock)
								on c.Position=a.Variable 
							    and  c.id=(case when a.Value='''' then 1 else  a.Value end)
								'+case when @kpi >=0 then ' where c.L3_Order='+cast(@kpi as nvarchar) else ' ' end+'
			  order by   c.L3_Order ,c.QuestionOrder,c.id
    
			 ;' ;
			   
		     exec sp_executesql @sql,N'@YEAR_NEW int ',@YEAR_NEW  ;
 ----select @sql ;
 set nocount off ;
end

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_Trend_20150413BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [p_get_Trend_base] 2,5,-1,'',-1,-1,-1,-1
 exec [p_get_Trend_base] 3,10,default,'',10,12,157,-1
 exec [p_get_Trend] 3,10,default,'',10,12,157,-1
 exec [p_get_Trend_test] 3,9,default,'',-1,-1,-1,-1
 [p_get_Trend_test] 3,10,default,'',40,19,140,-1
 [p_get_Trend_test] 3,10,default,'',40,19,145,-1
  [p_get_Trend_test] 3,10,default,'',40,19,-1,-1
   [p_get_Trend_test] 3,10,default,'',40,-1,-1,-1
     [p_get_Trend_test] 3,10,default,'',10,40,300,6199
	  exec [p_get_Trend] 3,9,default,'',-1,-1,-1,-1
	  go
	  exec [p_get_Trend_test] 2,7,default,'',-1,-1,-1,-1
*/
create   procedure [dbo].[p_get_Trend_20150413BAK](
@YEAR_NEW int , 
@QUARTER_NEW int  ,
@kpi  int =-1,
@wherecondition nvarchar(max) ,
@group int  ,
@region int  ,
@district int  ,
@store  int   
)
as 
begin 

   set nocount on ; 
   declare @sql nvarchar(max) ='',   
		   @form2 nvarchar(max),
		   @form3 nvarchar(4000)='',
		   @form3_1 nvarchar(4000)='', 
		   @form6 nvarchar(max)='',
		   @form8 nvarchar(max)='',
		   @form9 nvarchar(max)='',
		   @raw nvarchar(max)='',
		   @groupby nvarchar(max)='' ,
		   @hierarchy nvarchar(max)='',	
		   @form5_1 nvarchar(max)='',
		   @form_1 nvarchar(max)='',
		   @form5_2 nvarchar(max)='',
		   @form_2 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @VartoPrevPeriod nvarchar(1000);
			
	 
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	

			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	;
 
	 
---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 

							 
     set @form2='' ;
	 
	 
	  select @form3=  @form3+ '[Q'+cast(Qrt_ID as nvarchar)+'],'
			 ,@form3_1= @form3_1+'cast(100.0*[Q'+cast(Qrt_ID as nvarchar)+'] as decimal(18,0) )   [Q'+cast(Quarter_NEW as nvarchar)+'],'
			 , @VartoPrevPeriod= case when Qrt_ID=@QUARTER_NEW then '[Q'+cast(Quarter_NEW as nvarchar)+']-[Q'+coalesce(( select top 1 'P'   from  [dbo].[V_Year_Quarter] where Year_ID=t.Year_ID -1 and Qrt_ID=t.Qrt_ID-1), cast(Quarter_NEW-1 as nvarchar) )+']' else @VartoPrevPeriod end
	   from   [dbo].[V_Year_Quarter] t(nolock)  where Year_ID=@YEAR_NEW  order by Qrt_ID;
	 
	 

	   set @form3=@form3+N'[YTD],[LastYear],[QP]'  ; 
	   set @form3_1=@form3_1+N'cast(100*[YTD] as decimal(18,0)) [YTD],cast(100*[LastYear] as decimal(18,0)) [LastYear],cast(100*[QP] as decimal(18,0)) as [QP]'  ;
 
----------------ID	Scale
----------------1	
----------------2	BASE
----------------3	Positive
----------------4	Neutral
----------------5	Negative

 
	  select   @form6=@form6+ concat(', [',Position,'!3] , [',Position,'!4] , [',Position,'!5],[',Position,'!2]')
			, @form2=@form2+ ',  '+quotename(Position )  
	        , @form_1= @form_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight] else 0.0  end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as '+quotename(Position),

			 @form5_1= @form5_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'!3]') +
				      ',sum(case when '+quotename([Variable name])+' in('+mid3box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'!4]')+
			          ',sum(case when '+quotename([Variable name])+' in('+bot2box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight] end),0) as [',Position,'!5]')+
					  ', sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight]/100.0 end)  as [',Position,'!2]')
	  from [dbo].[Questionnaire] where   Trend=1 and   L3_order=(case when @kpi>0 then  @kpi else L3_order end)    ;
  

   set @form2=stuff(@form2,1,1,'') ; 
	set @groupby= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						   case when  @district  is null then null else ',[Group],[Region],District' end ,
						   case when  @region is null then null else ',[Group],[Region]' end,
						   case when  @group  is null then null else ',[Group]' end, ''		 );

	set @hierarchy	=coalesce(' and Store='+cast(@store as nvarchar)  ,
							 ' and District='+cast(@district as nvarchar)  ,
							 ' and [Region]='+cast(@region as nvarchar)  ,
							 ' and [Group]='+cast(@group as nvarchar)  ,
							 ''		 ); 
					 	  
	set @sql=@raw+'  
			,trend as (    
					select  case when YEAR_NEW='+cast( @YEAR_NEW as nvarchar)+' then ''YTD'' when YEAR_NEW='+cast(( @YEAR_NEW-1  ) as nvarchar)+' then  ''LastYear'' end as TP 
					'+@groupby+@form_1+@form5_1+'
					from  rawdata  where YEAR_NEW>= '+cast(( @YEAR_NEW-1  ) as nvarchar)+' and  YEAR_NEW<= @YEAR_NEW   '+@hierarchy+' 
					group by YEAR_NEW '+@groupby +'
			
			union all 
		    select   concat(''Q'',  QUARTER_NEW ) as TP  '   +@groupby+@form_1+@form5_1+'
		    from  rawdata  where YEAR_NEW= @YEAR_NEW   '+@hierarchy+' 
			group by  concat(''Q'',  QUARTER_NEW ) '+@groupby+' 
            '+
			case when @QUARTER_NEW%4=1 then '	union all 
						select    ''QP'' as TP  '   +@groupby+@form_1+@form5_1+'
						from  rawdata  where YEAR_NEW= '+cast(( @YEAR_NEW-1  ) as nvarchar)+'  and QUARTER_NEW='+cast( (@QUARTER_NEW-1)  as nvarchar ) +'  '+@hierarchy+' 
						   '+isnull('group by '+stuff(nullif(@groupby,''),1,1,''),'') 
			    else ' '
			 end 
			+' 	
			 )  
			,tab as (
					select  
							(case when charindex(''!'',Variable)>0 then  left(Variable, charindex(''!'',Variable)-1) else  Variable end) as Variable,
							 (case when charindex(''!'',Variable)>0 then  right(Variable,len(Variable)-charindex(''!'',Variable)) else 1  end )  as Value,
							'+@form3_1+'  
					  from   trend  t 
					 unpivot(Value for Variable in( '+@form2+@form6+') ) up
					 pivot(sum(Value) for  TP  in('+@form3+') ) p
			 ) 
			 select c.L3 as L2,c.label as Variable,c.scale as Value,[Q1],[Q2],[Q3],[Q4],[YTD],'
					+case when  @VartoPrevPeriod is null then ' NUll ' else @VartoPrevPeriod end 	 +' as [VartoPrevPeriod],
					[LastYear],iif(c.id=2,case when  [Q1] is null and  [Q2] is null and    [Q3] is null and  [Q4]  is null  then ''none'' else ''inline''  end,'''') as [Graph]
			  from  tab   a   right join '+case when @kpi >0 then ' (select * from   [trends_head](nolock)  where L3_Order='+cast(@kpi as nvarchar) +' ) ' else '  [trends_head](nolock) ' end+'   c 
								on c.Position=a.Variable 
							    and  c.id=  a.Value
								
			  order by   c.L3_Order ,c.QuestionOrder,c.id
    
			 ;' ;
			   
		     exec sp_executesql @sql,N'@YEAR_NEW int ',@YEAR_NEW  ;
 ----select @sql ;
 set nocount off ;
end

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_Trend_20150422BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [p_get_Trend_base] 2,5,-1,'',-1,-1,-1,-1
 exec [p_get_Trend_base] 3,10,default,'',10,12,157,-1
 exec [p_get_Trend] 3,10,default,'',10,12,157,-1
 exec [p_get_Trend_test] 3,9,default,'',-1,-1,-1,-1
 [p_get_Trend_test] 3,10,default,'',40,19,140,-1
 [p_get_Trend_test] 3,10,default,'',40,19,145,-1
  [p_get_Trend_test] 3,10,default,'',40,19,-1,-1
   [p_get_Trend_test] 3,10,default,'',40,-1,-1,-1
     [p_get_Trend_test] 3,10,default,'',10,40,300,6199
	  exec [p_get_Trend] 3,9,default,'',-1,-1,-1,-1
	  go
	  exec [p_get_Trend_test] 2,7,default,'',-1,-1,-1,-1
*/
Create    procedure [dbo].[p_get_Trend_20150422BAK](
@YEAR_NEW int , 
@QUARTER_NEW int  ,
@kpi  int =-1,
@wherecondition nvarchar(max) ,
@group int  ,
@region int  ,
@district int  ,
@store  int   
)
as 
begin 

   set nocount on ; 
   declare @sql nvarchar(max) ='',   
		   @form2 nvarchar(max),
		   @form3 nvarchar(4000)='',
		   @form3_1 nvarchar(4000)='', 
		   @raw nvarchar(max)='',
		   @groupby nvarchar(max)='' ,
		   @hierarchy nvarchar(max)='',	
		   @form5_1 nvarchar(max)='',
		   @form_1 nvarchar(max)='',
		   @form5_2 nvarchar(max)='',
		   @form_2 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @VartoPrevPeriod nvarchar(1000);
			
	 
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	

			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	;
 
	 
---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 

							 
     set @form2='' ;
	 
	 
	  select @form3=  @form3+ '[Q'+cast(Qrt_ID as nvarchar)+'],'
			 ,@form3_1= @form3_1+'cast(100.0*[Q'+cast(Qrt_ID as nvarchar)+'] as decimal(18,0) )   [Q'+cast(Quarter_NEW as nvarchar)+'],'
			 , @VartoPrevPeriod= case when Qrt_ID=@QUARTER_NEW then 'cast(100.0*[Q'+cast(Qrt_ID as nvarchar)+'] as decimal(18,0))-cast(100*[Q'
			 +coalesce(( select top 1 'P'   from  [dbo].[V_Year_Quarter] where Year_ID=t.Year_ID -1 and Qrt_ID=t.Qrt_ID-1) , cast(Qrt_ID-1 as nvarchar) )+'] as decimal(18,0))  ' else @VartoPrevPeriod end
	   from   [dbo].[V_Year_Quarter] t(nolock)  where Year_ID=@YEAR_NEW  order by Qrt_ID;
	  

	   set @form3=@form3+N'[YTD],[LastYear],[QP]'  ; 
	   set @form3_1=@form3_1+N'cast(100*[YTD] as decimal(18,0)) [YTD],'+isnull(@VartoPrevPeriod,' NULL ')+'    [VartoPrevPeriod],cast(100*[LastYear] as decimal(18,0)) [LastYear]'  ;
 
----------------ID	Scale
----------------1	
----------------2	BASE
----------------3	Positive
----------------4	Neutral
----------------5	Negative

 
	  select  @form2=@form2+ ',  ['+cast(Position as nvarchar )+'1]'  + concat(', [',Position,'3] , [',Position,'4] , [',Position,'5],[',Position,'2]')
	        , @form_1= @form_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight] else 0.0  end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as ['+cast(Position as nvarchar)+'1]',

			 @form5_1= @form5_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'3]') +
				      ',sum(case when '+quotename([Variable name])+' in('+mid3box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'4]')+
			          ',sum(case when '+quotename([Variable name])+' in('+bot2box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight] end),0) as [',Position,'5]')+
					  ', sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight]/100.0 end)  as [',Position,'2]')
	  from [dbo].[Questionnaire](nolock) where   Trend=1 and   L3_order=(case when @kpi>0 then  @kpi else L3_order end)    ;
  

   set @form2=stuff(@form2,1,1,'') ; 
	set @groupby= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						   case when  @district  is null then null else ',[Group],[Region],District' end ,
						   case when  @region is null then null else ',[Group],[Region]' end,
						   case when  @group  is null then null else ',[Group]' end, ''		 );

	set @hierarchy	=coalesce(' and Store='+cast(@store as nvarchar)  ,
							 ' and District='+cast(@district as nvarchar)  ,
							 ' and [Region]='+cast(@region as nvarchar)  ,
							 ' and [Group]='+cast(@group as nvarchar)  ,
							 ''		 ); 
					 	  
	set @sql=@raw+'  
			,trend as (    
					select  case when YEAR_NEW='+cast( @YEAR_NEW as nvarchar)+' then ''YTD'' when YEAR_NEW='+cast(( @YEAR_NEW-1  ) as nvarchar)+' then  ''LastYear'' end as TP 
					'+@groupby+@form_1+@form5_1+'
					from  rawdata  where YEAR_NEW  >= '+cast(( @YEAR_NEW-1  ) as nvarchar)+' and YEAR_NEW<= '+cast( @YEAR_NEW as nvarchar)+'   '+@hierarchy+' 
					group by YEAR_NEW '+@groupby +'
			
			union all 
		    select     ''Q''+cast( QUARTER_NEW as nvarchar) as TP  '   +@groupby+@form_1+@form5_1+'
		    from  rawdata  where YEAR_NEW= @YEAR_NEW   '+@hierarchy+' 
			group by     QUARTER_NEW   '+@groupby+' 
            '+
			case when @QUARTER_NEW%4=1 then '	union all 
						select    ''QP'' as TP  '   +@groupby+@form_1+@form5_1+'
						from  rawdata  where YEAR_NEW= '+cast(( @YEAR_NEW-1  ) as nvarchar)+'  and QUARTER_NEW='+cast( (@QUARTER_NEW-1)  as nvarchar ) +'  '+@hierarchy+' 
						   '+isnull('group by '+stuff(nullif(@groupby,''),1,1,''),'') 
			    else ' '
			 end 
			+' 	
			 )    select  
							 c.L3 as L2,c.label as Variable,c.scale as Value,
							'+@form3_1+' ,iif(c.id=2,case when  [YTD]  is null  then ''none'' else ''inline''  end,'''') as [Graph]  
					  from   trend  t 
					 unpivot(Value for Variable in( '+@form2+') ) up
					 pivot(sum(Value) for  TP  in('+@form3+') ) p
					 right join '+case when @kpi >0 then ' (select * from   [trends_head](nolock)  where L3_Order='+cast(@kpi as nvarchar) +' ) ' else '  [trends_head](nolock) ' end+'   c 
								on c.Pos_id=  Variable  
			  order by   c.L3_Order ,c.QuestionOrder, case when c.Position=96 then (case when c.id=3 then 5 when c.id=5 then 3 else c.id end)   else c.id end
    
			 ;' ;
			 ---  select @sql  ;
		     exec sp_executesql @sql,N'@YEAR_NEW int ',@YEAR_NEW  ;

 set nocount off ;
end

 
GO
/****** Object:  StoredProcedure [dbo].[p_get_Trend_20150623BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [p_get_Trend_base] 2,5,-1,'',-1,-1,-1,-1
 exec [p_get_Trend_base] 3,10,default,'',10,12,157,-1
 exec [p_get_Trend] 3,10,default,'',10,12,157,-1
 exec [p_get_Trend_test] 3,9,default,'',-1,-1,-1,-1
 [p_get_Trend_test] 3,10,default,'',40,19,140,-1
 [p_get_Trend_test] 3,10,default,'',40,19,145,-1
  [p_get_Trend_test] 3,10,default,'',40,19,-1,-1
   [p_get_Trend_test] 3,10,default,'',40,-1,-1,-1
     [p_get_Trend_test] 3,10,default,'',10,40,300,6199
	  exec [p_get_Trend] 3,9,default,'',-1,-1,-1,-1
	  go
	  exec [p_get_Trend_test] 2,7,default,'',-1,-1,-1,-1
*/
CREATE   procedure [dbo].[p_get_Trend_20150623BAK](
@YEAR_NEW int , 
@QUARTER_NEW int  ,
@kpi  int =-1,
@wherecondition nvarchar(max) ,
@group int  ,
@region int  ,
@district int  ,
@store  int  ,
@Age   nvarchar(100)='',
@Frequency_of_shopping  nvarchar(100)='',
@Gender  nvarchar(100)='',
@Income  nvarchar(100)='',
@Racial_background  nvarchar(100)='',
@Government_benefits  nvarchar(100)='',
@Store_Format  nvarchar(100)='',
@Store_Cluster  nvarchar(100)='',
@Shopper_Segment  nvarchar(100)='' 
)
as 
begin 

   set nocount on ; 
   declare @sql nvarchar(max) ='',   
		   @form2 nvarchar(max),
		   @form3 nvarchar(4000)='',
		   @form3_1 nvarchar(4000)='', 
		   @raw nvarchar(max)='',
		   @groupby nvarchar(max)='' ,
		   @hierarchy nvarchar(max)='',	
		   @form5_1 nvarchar(max)='',
		   @form_1 nvarchar(max)='',
		   @form5_2 nvarchar(max)='',
		   @form_2 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),@where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @VartoPrevPeriod nvarchar(1000);
			
	 
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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;

---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 '+char(10),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+char(10)+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sc+')  ',
							@where_raw +char(10),'  )   ')+char(10)  ; 

							 
     set @form2='' ;
	 
	 
	  select @form3=  @form3+ '[Q'+cast(Qrt_ID as nvarchar)+'],'
			 ,@form3_1= @form3_1+'cast(100.0*[Q'+cast(Qrt_ID as nvarchar)+'] as decimal(18,0) )   [Q'+cast(Quarter_NEW as nvarchar)+'],'
			 , @VartoPrevPeriod= case when Qrt_ID=@QUARTER_NEW then 'cast(100.0*[Q'+cast(Qrt_ID as nvarchar)+'] as decimal(18,0))-cast(100*[Q'
			 +coalesce(( select top 1 'P'   from  [dbo].[V_Year_Quarter](nolock)  where Year_ID=t.Year_ID -1 and Qrt_ID=t.Qrt_ID-1) , cast(Qrt_ID-1 as nvarchar) )+'] as decimal(18,0))  ' else @VartoPrevPeriod end
	   from   [dbo].[V_Year_Quarter] t(nolock)  where Year_ID=@YEAR_NEW  order by Qrt_ID;
	  

	   set @form3=@form3+N'[YTD],[LastYear],[QP]'  ; 
	   set @form3_1=@form3_1+N'cast(100*[YTD] as decimal(18,0)) [YTD],'+isnull(@VartoPrevPeriod,' NULL ')+'    [VartoPrevPeriod],cast(100*[LastYear] as decimal(18,0)) [LastYear]'  ;
 
----------------ID	Scale
----------------1	
----------------2	BASE
----------------3	Positive
----------------4	Neutral
----------------5	Negative

 if @kpi>0
 begin
	  select  @form2=@form2+ ',  ['+cast(Position as nvarchar )+'1]'  + concat(', [',Position,'3] , [',Position,'4] , [',Position,'5],[',Position,'2]')
	        , @form_1= @form_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight] else 0.0  end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as ['+cast(Position as nvarchar)+'1]',

			 @form5_1= @form5_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'3]') +
				      ',sum(case when '+quotename([Variable name])+' in('+mid3box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'4]')+
			          ',sum(case when '+quotename([Variable name])+' in('+bot2box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight] end),0) as [',Position,'5]')+
					  ', sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight]/100.0 end)  as [',Position,'2]')
	  from [dbo].[Questionnaire](nolock) where   Trend=1 and   L3_order=  @kpi ;
  end
  else
  begin

	  select  @form2=@form2+ ',  ['+cast(Position as nvarchar )+'1]'  + concat(', [',Position,'3] , [',Position,'4] , [',Position,'5],[',Position,'2]')
	        , @form_1= @form_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight] else 0.0  end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as ['+cast(Position as nvarchar)+'1]',

			 @form5_1= @form5_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'3]') +
				      ',sum(case when '+quotename([Variable name])+' in('+mid3box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'4]')+
			          ',sum(case when '+quotename([Variable name])+' in('+bot2box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight] end),0) as [',Position,'5]')+
					  ', sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight]/100.0 end)  as [',Position,'2]')
	  from [dbo].[Questionnaire](nolock) where   Trend=1    ;

  end

   set @form2=stuff(@form2,1,1,'') ; 
	set @groupby= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						   case when  @district  is null then null else ',[Group],[Region],District' end ,
						   case when  @region is null then null else ',[Group],[Region]' end,
						   case when  @group  is null then null else ',[Group]' end, ''		 );

	set @hierarchy	=coalesce(' and Store='+cast(@store as nvarchar)  ,
							 ' and District='+cast(@district as nvarchar)  ,
							 ' and [Region]='+cast(@region as nvarchar)  ,
							 ' and [Group]='+cast(@group as nvarchar)  ,
							 ''		 ); 
					 	  
	set @sql=@raw+'  
			,trend as (    
					select  case when YEAR_NEW='+cast( @YEAR_NEW as nvarchar)+' then ''YTD'' when YEAR_NEW='+cast(( @YEAR_NEW-1  ) as nvarchar)+' then  ''LastYear'' end as TP 
					'+@groupby+@form_1+@form5_1+'
					from  rawdata  where YEAR_NEW  >= '+cast(( @YEAR_NEW-1  ) as nvarchar)+' and YEAR_NEW<= '+cast( @YEAR_NEW as nvarchar)+'   '+@hierarchy+' 
					group by YEAR_NEW '+@groupby +'
			
			union all 
		    select     ''Q''+cast( QUARTER_NEW as nvarchar) as TP  '   +@groupby+@form_1+@form5_1+'
		    from  rawdata  where YEAR_NEW= @YEAR_NEW   '+@hierarchy+' 
			group by     QUARTER_NEW   '+@groupby+' 
            '+
			case when @QUARTER_NEW%4=1 then '	union all 
						select    ''QP'' as TP  '   +@groupby+@form_1+@form5_1+'
						from  rawdata  where YEAR_NEW= '+cast(( @YEAR_NEW-1  ) as nvarchar)+'  and QUARTER_NEW='+cast( (@QUARTER_NEW-1)  as nvarchar ) +'  '+@hierarchy+' 
						   '+isnull('group by '+stuff(nullif(@groupby,''),1,1,''),'') 
			    else ' '
			 end 
			+' 	
			 )    select  
							 c.L3 as L2,c.label as Variable,c.scale as Value,
							'+@form3_1+' ,iif(c.id=2,case when  [YTD]  is null  then ''none'' else ''inline''  end,'''') as [Graph]  
					  from   trend  t 
					 unpivot(Value for Variable in( '+@form2+') ) up
					 pivot(sum(Value) for  TP  in('+@form3+') ) p
					 right join '+case when @kpi >0 then ' (select * from   [trends_head](nolock)  where L3_Order='+cast(@kpi as nvarchar) +' ) ' else '  [trends_head](nolock) ' end+'   c 
								on c.Pos_id=  Variable  
			  order by   c.L3_Order ,c.QuestionOrder, c.id  ---case when c.Position=96 then (case when c.id=3 then 5 when c.id=5 then 3 else c.id end)   else c.id end
    
			 ;' ;
			 ---  select @sql  ;
			--- print @sql
		     exec sp_executesql @sql,N'@YEAR_NEW int ',@YEAR_NEW  ;

 set nocount off ;
end

 

GO
/****** Object:  StoredProcedure [dbo].[p_get_Trend_20150810BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [p_get_Trend_base] 2,5,-1,'',-1,-1,-1,-1
 exec [p_get_Trend_base] 3,10,default,'',10,12,157,-1
 exec [p_get_Trend] 3,10,default,'',10,12,157,-1
 exec [p_get_Trend_test] 3,9,default,'',-1,-1,-1,-1
 [p_get_Trend_test] 3,10,default,'',40,19,140,-1
 [p_get_Trend_test] 3,10,default,'',40,19,145,-1
  [p_get_Trend_test] 3,10,default,'',40,19,-1,-1
   [p_get_Trend_test] 3,10,default,'',40,-1,-1,-1
     [p_get_Trend_test] 3,10,default,'',10,40,300,6199
	  exec [p_get_Trend] 3,9,default,'',-1,-1,-1,-1
	  go
	  exec [p_get_Trend_test] 2,7,default,'',-1,-1,-1,-1
*/
CREATE   procedure [dbo].[p_get_Trend_20150810BAK](
@YEAR_NEW int , 
@QUARTER_NEW int  ,
@kpi  int =-1,
@wherecondition nvarchar(max) ,
@group int  ,
@region int  ,
@district int  ,
@store  int  ,
@Age   nvarchar(100)='',
@Frequency_of_shopping  nvarchar(100)='',
@Gender  nvarchar(100)='',
@Income  nvarchar(100)='',
@Racial_background  nvarchar(100)='',
@Government_benefits  nvarchar(100)='',
@Store_Format  nvarchar(100)='',
@Store_Cluster  nvarchar(100)='',
@Shopper_Segment  nvarchar(100)='' 
)
as 
begin 

   set nocount on ; 
   declare @sql nvarchar(max) ='',   
		   @form2 nvarchar(max),
		   @form3 nvarchar(4000)='',
		   @form3_1 nvarchar(4000)='', 
		   @raw nvarchar(max)='',
		   @groupby nvarchar(max)='' ,
		   @hierarchy nvarchar(max)='',	
		   @form5_1 nvarchar(max)='',
		   @form_1 nvarchar(max)='',
		   @form5_2 nvarchar(max)='',
		   @form_2 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),@where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @VartoPrevPeriod nvarchar(1000);
			
	 
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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;

---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 '+char(10),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+char(10)+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sc+')  ',
							@where_raw +char(10),'  )   ')+char(10)  ; 

							 
     set @form2='' ;
	 
	 
	  select @form3=  @form3+ '[Q'+cast(Qrt_ID as nvarchar)+'],'
			 ,@form3_1= @form3_1+'cast(100.0*[Q'+cast(Qrt_ID as nvarchar)+'] as decimal(18,0) )   [Q'+cast(Quarter_NEW as nvarchar)+'],'
			 , @VartoPrevPeriod= case when Qrt_ID=@QUARTER_NEW then 'cast(100.0*[Q'+cast(Qrt_ID as nvarchar)+'] - 100*[Q'
			 +coalesce(( select top 1 'P'   from  [dbo].[V_Year_Quarter](nolock)  where Year_ID=t.Year_ID -1 and Qrt_ID=t.Qrt_ID-1) , cast(Qrt_ID-1 as nvarchar) )+'] as decimal(18,0))  ' else @VartoPrevPeriod end
	   from   [dbo].[V_Year_Quarter] t(nolock)  where Year_ID=@YEAR_NEW  order by Qrt_ID;
	  

	   set @form3=@form3+N'[YTD],[LastYear],[QP]'  ; 
	   set @form3_1=@form3_1+N'cast(100*[YTD] as decimal(18,0)) [YTD],'+isnull(@VartoPrevPeriod,' NULL ')+'    [VartoPrevPeriod],cast(100*[LastYear] as decimal(18,0)) [LastYear]'  ;
 
----------------ID	Scale
----------------1	
----------------2	BASE
----------------3	Positive
----------------4	Neutral
----------------5	Negative

 if @kpi>0
 begin
	  select  @form2=@form2+ ',  ['+cast(Position as nvarchar )+'1]'  + concat(', [',Position,'3] , [',Position,'4] , [',Position,'5],[',Position,'2]')
	        , @form_1= @form_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight] else 0.0  end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as ['+cast(Position as nvarchar)+'1]',

			 @form5_1= @form5_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'3]') +
				      ',sum(case when '+quotename([Variable name])+' in('+mid3box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'4]')+
			          ',sum(case when '+quotename([Variable name])+' in('+bot2box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight] end),0) as [',Position,'5]')+
					  ', sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight]/100.0 end)  as [',Position,'2]')
	  from [dbo].[Questionnaire](nolock) where   Trend=1 and   L3_order=  @kpi ;
  end
  else
  begin

	  select  @form2=@form2+ ',  ['+cast(Position as nvarchar )+'1]'  + concat(', [',Position,'3] , [',Position,'4] , [',Position,'5],[',Position,'2]')
	        , @form_1= @form_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight] else 0.0  end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as ['+cast(Position as nvarchar)+'1]',

			 @form5_1= @form5_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'3]') +
				      ',sum(case when '+quotename([Variable name])+' in('+mid3box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'4]')+
			          ',sum(case when '+quotename([Variable name])+' in('+bot2box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight] end),0) as [',Position,'5]')+
					  ', sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight]/100.0 end)  as [',Position,'2]')
	  from [dbo].[Questionnaire](nolock) where   Trend=1    ;

  end

   set @form2=stuff(@form2,1,1,'') ; 
	set @groupby= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						   case when  @district  is null then null else ',[Group],[Region],District' end ,
						   case when  @region is null then null else ',[Group],[Region]' end,
						   case when  @group  is null then null else ',[Group]' end, ''		 );

	set @hierarchy	=coalesce(' and Store='+cast(@store as nvarchar)  ,
							 ' and District='+cast(@district as nvarchar)  ,
							 ' and [Region]='+cast(@region as nvarchar)  ,
							 ' and [Group]='+cast(@group as nvarchar)  ,
							 ''		 ); 
					 	  
	set @sql=@raw+'  
			,trend as (    
					select  case when YEAR_NEW='+cast( @YEAR_NEW as nvarchar)+' then ''YTD'' when YEAR_NEW='+cast(( @YEAR_NEW-1  ) as nvarchar)+' then  ''LastYear'' end as TP 
					'+@groupby+@form_1+@form5_1+'
					from  rawdata  where YEAR_NEW  >= '+cast(( @YEAR_NEW-1  ) as nvarchar)+' and YEAR_NEW<= '+cast( @YEAR_NEW as nvarchar)+'   '+@hierarchy+' 
					group by YEAR_NEW '+@groupby +'
			
			union all 
		    select     ''Q''+cast( QUARTER_NEW as nvarchar) as TP  '   +@groupby+@form_1+@form5_1+'
		    from  rawdata  where YEAR_NEW= @YEAR_NEW   '+@hierarchy+' 
			group by     QUARTER_NEW   '+@groupby+' 
            '+
			case when @QUARTER_NEW%4=1 then '	union all 
						select    ''QP'' as TP  '   +@groupby+@form_1+@form5_1+'
						from  rawdata  where YEAR_NEW= '+cast(( @YEAR_NEW-1  ) as nvarchar)+'  and QUARTER_NEW='+cast( (@QUARTER_NEW-1)  as nvarchar ) +'  '+@hierarchy+' 
						   '+isnull('group by '+stuff(nullif(@groupby,''),1,1,''),'') 
			    else ' '
			 end 
			+' 	
			 )    select  
							 c.L3 as L2,c.label as Variable,c.scale as Value,
							'+@form3_1+' ,iif(c.id=2,case when  [YTD]  is null  then ''none'' else ''inline''  end,'''') as [Graph]  
					  from   trend  t 
					 unpivot(Value for Variable in( '+@form2+') ) up
					 pivot(sum(Value) for  TP  in('+@form3+') ) p
					 right join '+case when @kpi >0 then ' (select * from   [trends_head](nolock)  where L3_Order='+cast(@kpi as nvarchar) +' ) ' else '  [trends_head](nolock) ' end+'   c 
								on c.Pos_id=  Variable  
			  order by   c.L3_Order ,c.QuestionOrder, c.id  ---case when c.Position=96 then (case when c.id=3 then 5 when c.id=5 then 3 else c.id end)   else c.id end
    
			 ;' ;
			 ---  select @sql  ;
			--- print @sql
		     exec sp_executesql @sql,N'@YEAR_NEW int ',@YEAR_NEW  ;

 set nocount off ;
end

 

GO
/****** Object:  StoredProcedure [dbo].[p_get_Trend_RollingQrt]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [p_get_Trend_base] 2,5,-1,'',-1,-1,-1,-1
 exec [p_get_Trend_base] 3,10,default,'',10,12,157,-1
 exec [p_get_Trend] 3,10,default,'',10,12,157,-1
 exec [p_get_Trend_test] 3,9,default,'',-1,-1,-1,-1
 [p_get_Trend_test] 3,10,default,'',40,19,140,-1
 [p_get_Trend_test] 3,10,default,'',40,19,145,-1
  [p_get_Trend_test] 3,10,default,'',40,19,-1,-1
   [p_get_Trend_test] 3,10,default,'',40,-1,-1,-1
     [p_get_Trend_test] 3,10,default,'',10,40,300,6199
	  exec [p_get_Trend] 3,9,default,'',-1,-1,-1,-1
	  go
	  exec [p_get_Trend_RollingQrt] 2,7,default,'',-1,-1,-1,-1
*/
CREATE   procedure [dbo].[p_get_Trend_RollingQrt](
@YEAR_NEW int , 
@QUARTER_NEW int  ,
@kpi  int =-1,
@wherecondition nvarchar(max) ,
@group int  ,
@region int  ,
@district int  ,
@store  int   
)
as 
begin 

   set nocount on ; 
   declare @sql nvarchar(max) ='',   
		   @form2 nvarchar(max),
		   @form3 nvarchar(4000)='',
		   @form3_1 nvarchar(4000)='', 
		   @raw nvarchar(max)='',
		   @groupby nvarchar(max)='' ,
		   @hierarchy nvarchar(max)='',	
		   @form5_1 nvarchar(max)='',
		   @form_1 nvarchar(max)='',
		   @form5_2 nvarchar(max)='',
		   @form_2 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @VartoPrevPeriod nvarchar(1000);
			
	 
			set @group= case when @group<=0 then null else @group end ;
			set	@region=case when @region<=0 then null else @region end ;
			set @district=case when @district<=0 then null else @district end;
			set @store=case when @store<=0 then null else @store end  ;	

			set @where_raw=@wherecondition;
			set @pos1=charindex('and ( STOREFORMAT=',@wherecondition);
			if @pos1>0 
			begin
				set @pos2=charindex(' )',@wherecondition,@pos1);
				set @where_sf=substring(@wherecondition,@pos1,@pos2-@pos1+2);
				set @where_raw=replace(@wherecondition,@where_sf,'');
				 
			end	
			set @pos3=charindex('and ( CLUSTER_UPDATED=',@where_raw);
			if @pos3>0 
			begin
				set @pos4=charindex(' )',@where_raw,@pos3);
				set @where_sc=substring(@where_raw,@pos3,@pos4-@pos3+2);
				set @where_raw=replace(@where_raw,@where_sc,''); 
			end	;
 
	 
---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 ',
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+@where_sc+')  ',
							@where_raw ,'  )   ')+char(10)  ; 

							 
     set @form2='' ;
	 
	 
	  select @form3=  @form3+ '[Q'+cast(Qrt_ID as nvarchar)+'],'
			 ,@form3_1= @form3_1+'cast(100.0*[Q'+cast(Qrt_ID as nvarchar)+'] as decimal(18,0) )   [FY'+cast(Year_New as  nvarchar)+'Q'+cast(Quarter_NEW as nvarchar)+'],'
			 , @VartoPrevPeriod= case when Qrt_ID=@QUARTER_NEW then 'cast(100.0*[Q'+cast(Qrt_ID as nvarchar)+'] as decimal(18,0))-cast(100*[Q'
			 +coalesce(( select top 1 cast(Qrt_ID as nvarchar)  from  [dbo].[V_Year_Quarter] where Year_ID=t.Year_ID -1 and Qrt_ID=t.Qrt_ID-1) , cast(Qrt_ID-1 as nvarchar) )+'] as decimal(18,0))  ' else @VartoPrevPeriod end
	   from   [dbo].[V_Year_Quarter] t(nolock) 
	    where Qrt_ID between @QUARTER_NEW-3  and @QUARTER_NEW   ---Year_ID=@YEAR_NEW 
	    order by Qrt_ID;
	  

	   set @form3=@form3+N'[YTD],[LastYear],[QP]'  ; 
	   set @form3_1=@form3_1+N'cast(100*[YTD] as decimal(18,0)) [YTD],'+isnull(@VartoPrevPeriod,' NULL ')+'    [VartoPrevPeriod],cast(100*[LastYear] as decimal(18,0)) [LastYear]'  ;
 
----------------ID	Scale
----------------1	
----------------2	BASE
----------------3	Positive
----------------4	Neutral
----------------5	Negative

 
	  select  @form2=@form2+ ',  '+quotename(Position )  + concat(', [',Position,'!3] , [',Position,'!4] , [',Position,'!5],[',Position,'!2]')
	        , @form_1= @form_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight] else 0.0  end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as '+quotename(Position),

			 @form5_1= @form5_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'!3]') +
				      ',sum(case when '+quotename([Variable name])+' in('+mid3box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'!4]')+
			          ',sum(case when '+quotename([Variable name])+' in('+bot2box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight] end),0) as [',Position,'!5]')+
					  ', sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight]/100.0 end)  as [',Position,'!2]')
	  from [dbo].[Questionnaire] where   Trend=1 and   L3_order=(case when @kpi>0 then  @kpi else L3_order end)    ;
  

   set @form2=stuff(@form2,1,1,'') ; 
	set @groupby= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						   case when  @district  is null then null else ',[Group],[Region],District' end ,
						   case when  @region is null then null else ',[Group],[Region]' end,
						   case when  @group  is null then null else ',[Group]' end, ''		 );

	set @hierarchy	=coalesce(' and Store='+cast(@store as nvarchar)  ,
							 ' and District='+cast(@district as nvarchar)  ,
							 ' and [Region]='+cast(@region as nvarchar)  ,
							 ' and [Group]='+cast(@group as nvarchar)  ,
							 ''		 ); 
					 	  
	set @sql=@raw+'  
			,trend as (    
					select  case when YEAR_NEW='+cast( @YEAR_NEW as nvarchar)+' then ''YTD'' when YEAR_NEW='+cast(( @YEAR_NEW-1  ) as nvarchar)+' then  ''LastYear'' end as TP 
					'+@groupby+@form_1+@form5_1+'
					from  rawdata  where YEAR_NEW  between '+cast(( @YEAR_NEW-1  ) as nvarchar)+' and  '+cast( @YEAR_NEW as nvarchar)+'   '+@hierarchy+' 
					group by YEAR_NEW '+@groupby +'
			
			union all 
		    select   concat(''Q'',  QUARTER_NEW ) as TP  '   +@groupby+@form_1+@form5_1+'
		    from  rawdata  where QUARTER_NEW between '+cast( @QUARTER_NEW-3 as nvarchar)+'  and '+cast( @QUARTER_NEW  as nvarchar)+'  '+@hierarchy+' 
			group by  concat(''Q'',  QUARTER_NEW ) '+@groupby+' 
         
			 )    select  
							 c.L3 as L2,c.label as Variable,c.scale as Value,
							'+@form3_1+' ,iif(c.id=2,case when  [YTD]  is null  then ''none'' else ''inline''  end,'''') as [Graph]  
					  from   trend  t 
					 unpivot(Value for Variable in( '+@form2+') ) up
					 pivot(sum(Value) for  TP  in('+@form3+') ) p
					 right join '+case when @kpi >0 then ' (select * from   [trends_head](nolock)  where L3_Order='+cast(@kpi as nvarchar) +' ) ' else '  [trends_head](nolock) ' end+'   c 
								on c.Position=(case when charindex(''!'',Variable)>0 then  left(Variable, len(Variable)-2) else  Variable end)
							    and  c.id= (case when charindex(''!'',Variable)>0 then  right(Variable,1) else 1  end )
			 
			  order by   c.L3_Order ,c.QuestionOrder,c.id  ------case when c.Position=96 then (case when c.id=3 then 5 when c.id=5 then 3 else c.id end)   else c.id end
    
			 ;' ;
			 ---  select @sql  ;
		     exec sp_executesql @sql  ;

 set nocount off ;
end

 

GO
/****** Object:  StoredProcedure [dbo].[p_get_Trend_test]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
  ---author victor
 ---createdate 2015-01-27
 [p_get_Trend_base] 2,5,-1,'',-1,-1,-1,-1
 exec [p_get_Trend_base] 3,10,default,'',10,12,157,-1
 exec [p_get_Trend] 3,10,default,'',10,12,157,-1
 exec [p_get_Trend_test] 3,9,default,'',-1,-1,-1,-1
 [p_get_Trend_test] 3,10,default,'',40,19,140,-1
 [p_get_Trend_test] 3,10,default,'',40,19,145,-1
  [p_get_Trend_test] 3,10,default,'',40,19,-1,-1
   [p_get_Trend_test] 3,10,default,'',40,-1,-1,-1
     [p_get_Trend_test] 3,10,default,'',10,40,300,6199
	  exec [p_get_Trend] 3,9,default,'',-1,-1,-1,-1
	  go
	  exec [p_get_Trend_test] 2,7,default,'',-1,-1,-1,-1
*/
CREATE   procedure [dbo].[p_get_Trend_test](
@YEAR_NEW int , 
@QUARTER_NEW int  ,
@kpi  int =-1,
@wherecondition nvarchar(max) ,
@group int  ,
@region int  ,
@district int  ,
@store  int  ,
@Age   nvarchar(100)='',
@Frequency_of_shopping  nvarchar(100)='',
@Gender  nvarchar(100)='',
@Income  nvarchar(100)='',
@Racial_background  nvarchar(100)='',
@Government_benefits  nvarchar(100)='',
@Store_Format  nvarchar(100)='',
@Store_Cluster  nvarchar(100)='',
@Shopper_Segment  nvarchar(100)='' 
)
as 
begin 

   set nocount on ; 
   declare @sql nvarchar(max) ='',   
		   @form2 nvarchar(max),
		   @form3 nvarchar(4000)='',
		   @form3_1 nvarchar(4000)='', 
		   @raw nvarchar(max)='',
		   @groupby nvarchar(max)='' ,
		   @hierarchy nvarchar(max)='',	
		   @form5_1 nvarchar(max)='',
		   @form_1 nvarchar(max)='',
		   @form5_2 nvarchar(max)='',
		   @form_2 nvarchar(max)='',
		   @where_sf nvarchar(max),
		   @where_raw nvarchar(max),@where_con  nvarchar(max),
		   @pos1 int,
		   @pos2 int,
		   @where_sc nvarchar(max),
		   @pos3 int,
		   @pos4 int,
		   @VartoPrevPeriod nvarchar(1000);
			
	 
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
 
		  set @where_con=case when len(@Age)>0 then ' AND [AGE_GROUP] in('+ @Age +')' else '' end+
						 case when len(@Frequency_of_shopping)>0 then   ' AND  [freq_shop] in('+@Frequency_of_shopping   +')' else ''end+
						 case when len(@Gender)>0 then ' AND [Q63] in('+@Gender   +')' else ' ' end+
						 case when len(@Income)>0 then ' AND [Q64] in('+@Income    +')' else ' ' end+
						 case when len(@Racial_background)>0 then ' AND [RACE_ETH] in('+@Racial_background   +')' else '' end+
						 case when len(@gb)>0 then ' and ('+stuff(@gb,1,2,'')+')' else ' ' end+
						 case when len(@Shopper_Segment)>0 then ' AND [MRK_FDO] in('+@Shopper_Segment   +')'  else '' end;
		
			 set @where_raw=@where_con;
			 set @where_sf=case when len(@Store_Format)>0 then ' AND [STOREFORMAT] in('+@Store_Format   +')'  end;
			 set @where_sc=case when len(@Store_Cluster)>0 then ' AND [CLUSTER_UPDATED] in('+@Store_Cluster  +')'  end;

---Raw Data with filter
	set @raw=concat(N'  ;with rawdata as ( select   *  from  [dbo].[V_RawData_Hierarchy] t   where 1=1 '+char(10),
							' and exists(select * from [dbo].[StoreFormat](nolock) where  Store=t.Q2_1 '+char(10)+@where_sf+') ',
							' and exists(select * from [dbo].[Clusters](nolock)  where  Store=t.Q2_1 '+char(10)+@where_sc+')  ',
							@where_raw +char(10),'  )   ')+char(10)  ; 

							 
     set @form2='' ;
	 
	 
	  select @form3=  @form3+ '[Q'+cast(Qrt_ID as nvarchar)+'],'
			 ,@form3_1= @form3_1+'cast(100.0*[Q'+cast(Qrt_ID as nvarchar)+'] as decimal(18,0) )   [Q'+cast(Quarter_NEW as nvarchar)+'],'
			 , @VartoPrevPeriod= case when Qrt_ID=@QUARTER_NEW then 'cast(100.0*[Q'+cast(Qrt_ID as nvarchar)+'] as decimal(18,0))-cast(100*[Q'
			 +coalesce(( select top 1 'P'   from  [dbo].[V_Year_Quarter](nolock)  where Year_ID=t.Year_ID -1 and Qrt_ID=t.Qrt_ID-1) , cast(Qrt_ID-1 as nvarchar) )+'] as decimal(18,0))  ' else @VartoPrevPeriod end
	   from   [dbo].[V_Year_Quarter] t(nolock)  where Year_ID=@YEAR_NEW  order by Qrt_ID;
	  

	   set @form3=@form3+N'[YTD],[LastYear],[QP]'  ; 
	   set @form3_1=@form3_1+N'cast(100*[YTD] as decimal(18,0)) [YTD],'+isnull(@VartoPrevPeriod,' NULL ')+'    [VartoPrevPeriod],cast(100*[LastYear] as decimal(18,0)) [LastYear]'  ;
 
----------------ID	Scale
----------------1	
----------------2	BASE
----------------3	Positive
----------------4	Neutral
----------------5	Negative

 if @kpi>0
 begin
	  select  @form2=@form2+ ',  ['+cast(Position as nvarchar )+'1]'  + concat(', [',Position,'3] , [',Position,'4] , [',Position,'5],[',Position,'2]')
	        , @form_1= @form_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight] else 0.0  end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as ['+cast(Position as nvarchar)+'1]',

			 @form5_1= @form5_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'3]') +
				      ',sum(case when '+quotename([Variable name])+' in('+mid3box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'4]')+
			          ',sum(case when '+quotename([Variable name])+' in('+bot2box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight] end),0) as [',Position,'5]')+
					  ', sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight]/100.0 end)  as [',Position,'2]')
	  from [dbo].[Questionnaire](nolock) where   Trend=1 and   L3_order=  @kpi ;
  end
  else
  begin

	  select  @form2=@form2+ ',  ['+cast(Position as nvarchar )+'1]'  + concat(', [',Position,'3] , [',Position,'4] , [',Position,'5],[',Position,'2]')
	        , @form_1= @form_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight] else 0.0  end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+') then [weight] end),0) as ['+cast(Position as nvarchar)+'1]',

			 @form5_1= @form5_1+', sum(case when '+quotename([Variable name])+' in('+TopNbox+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'3]') +
				      ',sum(case when '+quotename([Variable name])+' in('+mid3box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then  [weight] end),0) as [',Position,'4]')+
			          ',sum(case when '+quotename([Variable name])+' in('+bot2box+') then [weight]  else 0.0 end)/nullif(sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight] end),0) as [',Position,'5]')+
					  ', sum(case when '+quotename([Variable name])+' in('+topnbox+','+mid3box+','+bot2box+concat(') then [weight]/100.0 end)  as [',Position,'2]')
	  from [dbo].[Questionnaire](nolock) where   Trend=1    ;

  end

   set @form2=stuff(@form2,1,1,'') ; 
	set @groupby= coalesce(case when  @store  is null then null else ',[Group],[Region],District,Store' end,
						   case when  @district  is null then null else ',[Group],[Region],District' end ,
						   case when  @region is null then null else ',[Group],[Region]' end,
						   case when  @group  is null then null else ',[Group]' end, ''		 );

	set @hierarchy	=coalesce(' and Store='+cast(@store as nvarchar)  ,
							 ' and District='+cast(@district as nvarchar)  ,
							 ' and [Region]='+cast(@region as nvarchar)  ,
							 ' and [Group]='+cast(@group as nvarchar)  ,
							 ''		 ); 
					 	  
	set @sql=@raw+'  
			,trend as (    
					select  case when YEAR_NEW='+cast( @YEAR_NEW as nvarchar)+' then ''YTD'' when YEAR_NEW='+cast(( @YEAR_NEW-1  ) as nvarchar)+' then  ''LastYear'' end as TP 
					'+@groupby+@form_1+@form5_1+'
					from  rawdata  where YEAR_NEW  >= '+cast(( @YEAR_NEW-1  ) as nvarchar)+' and YEAR_NEW<= '+cast( @YEAR_NEW as nvarchar)+'   '+@hierarchy+' 
					group by YEAR_NEW '+@groupby +'
			
			union all 
		    select     ''Q''+cast( QUARTER_NEW as nvarchar) as TP  '   +@groupby+@form_1+@form5_1+'
		    from  rawdata  where YEAR_NEW= @YEAR_NEW   '+@hierarchy+' 
			group by     QUARTER_NEW   '+@groupby+' 
            '+
			case when @QUARTER_NEW%4=1 then '	union all 
						select    ''QP'' as TP  '   +@groupby+@form_1+@form5_1+'
						from  rawdata  where YEAR_NEW= '+cast(( @YEAR_NEW-1  ) as nvarchar)+'  and QUARTER_NEW='+cast( (@QUARTER_NEW-1)  as nvarchar ) +'  '+@hierarchy+' 
						   '+isnull('group by '+stuff(nullif(@groupby,''),1,1,''),'') 
			    else ' '
			 end 
			+' 	
			 )    select  
							 c.L3 as L2,c.label as Variable,c.scale as Value,
							'+@form3_1+' ,iif(c.id=2,case when  [YTD]  is null  then ''none'' else ''inline''  end,'''') as [Graph]  
					  from   trend  t 
					 unpivot(Value for Variable in( '+@form2+') ) up
					 pivot(sum(Value) for  TP  in('+@form3+') ) p
					 right join '+case when @kpi >0 then ' (select * from   [trends_head](nolock)  where L3_Order='+cast(@kpi as nvarchar) +' ) ' else '  [trends_head](nolock) ' end+'   c 
								on c.Pos_id=  Variable  
			  order by   c.L3_Order ,c.QuestionOrder, c.id  ---case when c.Position=96 then (case when c.id=3 then 5 when c.id=5 then 3 else c.id end)   else c.id end
    
			 ;' ;
			 ---  select @sql  ;
			--- print @sql
		     exec sp_executesql @sql,N'@YEAR_NEW int ',@YEAR_NEW  ;

 set nocount off ;
end

 

GO
/****** Object:  StoredProcedure [dbo].[p_getdata_ByPage]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 /* author :victor zhang 
    create date:20150507
	function:get data  by page
	example:
exec	p_getdata_ByPage 'view_FD_VerbatimsRawData',5,0,'',''
exec	p_getdata_ByPage 'view_FD_VerbatimsRawData',20,4,null,null

exec	p_getdata_ByPage '  [dbo].[Hierarchy] ',20,1,'store','district'
 */
 CREATE proc [dbo].[p_getdata_ByPage]
 ( @tab nvarchar(max),
   @pageSize int,
   @pageIndex  int,
   @sortlist1 nvarchar(4000),
   @sortlist2  nvarchar(4000)
 )
 as
 begin
      set nocount on;
	  declare @sqltext nvarchar(max);

	  if @pageIndex>=0
	  begin
	  set @sqltext=N'
		; with rawdata as (select row_number() over(order by '+iif(len(@sortlist1)>0,@sortlist1,'(select null) ')+') rownum,* from '+@tab+' as t)
		 select *
		  from rawdata
		  WHERE rownum >='+ cast( ((@pageIndex-1)*@pageSize+1) as nvarchar)+' AND rownum<='+cast((@pageIndex*@pageSize ) as nvarchar)+char(10)
		
		  +iif(len(@sortlist2)>0, ' order by '+@sortlist2,'') 
	  end
	  else if @pageIndex<=-1
	  begin
	  set @sqltext=N'select * from '+@tab+' as t '+char(10)
			+iif(len(@sortlist2)>0, ' order by '+@sortlist2,'')  ;
	  end

	 if charindex('delete ',@sqltext)<=0  and charindex('drop ',@sqltext)<=0 and charindex('alter ',@sqltext)<=0 
	 execute sp_executesql @sqltext ;

	 set nocount off;

 end

 
  



GO
/****** Object:  StoredProcedure [dbo].[p_helptext]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[p_helptext]

@objname nvarchar(776)

,@columnname sysname = NULL

as



set nocount on



declare @dbname sysname

,@objid	int

,@BlankSpaceAdded   int

,@BasePos       int

,@CurrentPos    int

,@TextLength    int

,@LineId        int

,@AddOnLen      int

,@LFCR          int --lengths of line feed carriage return

,@DefinedLength int



/* NOTE: Length of @SyscomText is 4000 to replace the length of

** text column in syscomments.

** lengths on @Line, #CommentText Text column and

** value for @DefinedLength are all 255. These need to all have

** the same values. 255 was selected in order for the max length

** display using down level clients

*/

,@SyscomText	nvarchar(4000)

,@Line          nvarchar(255)



select @DefinedLength = 255

select @BlankSpaceAdded = 0 /*Keeps track of blank spaces at end of lines. Note Len function ignores

                             trailing blank spaces*/

CREATE TABLE #CommentText

(LineId	int

 ,Text  nvarchar(255) collate catalog_default)



/*

**  Make sure the @objname is local to the current database.

*/

select @dbname = parsename(@objname,3)

if @dbname is null

	select @dbname = db_name()

else if @dbname <> db_name()

        begin

                raiserror(15250,-1,-1)

                return (1)

        end



/*

**  See if @objname exists.

*/

select @objid = object_id(@objname)

if (@objid is null)

        begin

		raiserror(15009,-1,-1,@objname,@dbname)

		return (1)

        end



-- If second parameter was given.

if ( @columnname is not null)

    begin

        -- Check if it is a table

        if (select count(*) from sys.objects where object_id = @objid and type in ('S ','U ','TF'))=0

            begin

                raiserror(15218,-1,-1,@objname)

                return(1)

            end

        -- check if it is a correct column name

        if ((select 'count'=count(*) from sys.columns where name = @columnname and object_id = @objid) =0)

            begin

                raiserror(15645,-1,-1,@columnname)

                return(1)

            end

    if (ColumnProperty(@objid, @columnname, 'IsComputed') = 0)

		begin

			raiserror(15646,-1,-1,@columnname)

			return(1)

		end



        declare ms_crs_syscom  CURSOR LOCAL

        FOR select text from syscomments where id = @objid and encrypted = 0 and number =

                        (select column_id from sys.columns where name = @columnname and object_id = @objid)

                        order by number,colid

        FOR READ ONLY



    end

else if @objid < 0	-- Handle system-objects

	begin

		-- Check count of rows with text data

		if (select count(*) from master.sys.syscomments where id = @objid and text is not null) = 0

			begin

				raiserror(15197,-1,-1,@objname)

				return (1)

			end

			

		declare ms_crs_syscom CURSOR LOCAL FOR select text from master.sys.syscomments where id = @objid

			ORDER BY number, colid FOR READ ONLY

	end

else

    begin

        /*

        **  Find out how many lines of text are coming back,

        **  and return if there are none.

        */

        if (select count(*) from syscomments c, sysobjects o where o.xtype not in ('S', 'U')

            and o.id = c.id and o.id = @objid) = 0

                begin

                        raiserror(15197,-1,-1,@objname)

                        return (1)

                end



        if (select count(*) from syscomments where id = @objid and encrypted = 0) = 0

                begin

                        raiserror(15471,-1,-1,@objname)

                        return (0)

                end



		declare ms_crs_syscom  CURSOR LOCAL

		FOR select text from syscomments where id = @objid and encrypted = 0

				ORDER BY number, colid

		FOR READ ONLY



    end



/*

**  else get the text.

*/

select @LFCR = 1

select @LineId = 1





OPEN ms_crs_syscom



FETCH NEXT from ms_crs_syscom into @SyscomText



WHILE @@fetch_status >= 0

begin



    select  @BasePos    = 1

    select  @CurrentPos = 1

    select  @TextLength = LEN(@SyscomText)



    WHILE @CurrentPos  != 0

    begin

        --Looking for end of line followed by carriage return

        select @CurrentPos =   CHARINDEX(char(13)+char(10), @SyscomText, @BasePos)



        --If carriage return found

        IF @CurrentPos != 0

        begin

            /*If new value for @Lines length will be > then the

            **set length then insert current contents of @line

            **and proceed.

            */

            while (isnull(LEN(@Line),0) + @BlankSpaceAdded + @CurrentPos-@BasePos + @LFCR) > @DefinedLength

            begin

                select @AddOnLen = @DefinedLength-(isnull(LEN(@Line),0) + @BlankSpaceAdded)

                INSERT #CommentText VALUES

                ( @LineId,

                  isnull(@Line, N'') + isnull(SUBSTRING(@SyscomText, @BasePos, @AddOnLen), N''))

                select @Line = NULL, @LineId = @LineId + 1,

                       @BasePos = @BasePos + @AddOnLen, @BlankSpaceAdded = 0

            end

            select @Line    = isnull(@Line, N'') + isnull(SUBSTRING(@SyscomText, @BasePos, @CurrentPos-@BasePos + @LFCR), N'')

            select @BasePos = @CurrentPos+2

            INSERT #CommentText VALUES( @LineId, @Line )

            select @LineId = @LineId + 1

            select @Line = NULL

        end

        else

        --else carriage return not found

        begin

            IF @BasePos <= @TextLength

            begin

                /*If new value for @Lines length will be > then the

                **defined length

                */

                while (isnull(LEN(@Line),0) + @BlankSpaceAdded + @TextLength-@BasePos+1 ) > @DefinedLength

                begin

                    select @AddOnLen = @DefinedLength - (isnull(LEN(@Line),0) + @BlankSpaceAdded)

                    INSERT #CommentText VALUES

                    ( @LineId,

                      isnull(@Line, N'') + isnull(SUBSTRING(@SyscomText, @BasePos, @AddOnLen), N''))

                    select @Line = NULL, @LineId = @LineId + 1,

                        @BasePos = @BasePos + @AddOnLen, @BlankSpaceAdded = 0

                end

                select @Line = isnull(@Line, N'') + isnull(SUBSTRING(@SyscomText, @BasePos, @TextLength-@BasePos+1 ), N'')

                if LEN(@Line) < @DefinedLength and charindex(' ', @SyscomText, @TextLength+1 ) > 0

                begin

                    select @Line = @Line + ' ', @BlankSpaceAdded = 1

                end

            end

        end

    end



	FETCH NEXT from ms_crs_syscom into @SyscomText

end



IF @Line is NOT NULL

    INSERT #CommentText VALUES( @LineId, @Line )



--select Text from #CommentText order by LineId

select Text = replace(Text, char(13),'' ) from #CommentText order by LineId



CLOSE  ms_crs_syscom

DEALLOCATE 	ms_crs_syscom



DROP TABLE 	#CommentText



return (0) -- sp_helptext


GO
/****** Object:  StoredProcedure [dbo].[p_prepare_data]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	/* 
	 --victor zhang
 -- create date 2015-01-29 
 */
 CREATE    proc [dbo].[p_prepare_data] 
 as  
 begin 
  set nocount on; 
  
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



set nocount off ;



 end







GO
/****** Object:  StoredProcedure [dbo].[p_prepare_data_20150623BAK]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	/* 
	 --victor zhang
 -- create date 2015-01-29 
 */
 CREATE    proc [dbo].[p_prepare_data_20150623BAK] 
 as  
 begin 
  set nocount on; 
  
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



set nocount off ;



 end







GO
/****** Object:  StoredProcedure [dbo].[P_Split_String_2_Words]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 author:victor zhang
 date:20150817
 function :split text to words
 -- select * from nonsense_char
*/
CREATE proc [dbo].[P_Split_String_2_Words]
(
 @Col2Split varchar(100)
 )
as
begin
set nocount  on;

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

	set @sql=N'select  ID, ['+@Col2Split+'] into ##raw  from tb_rawdata where ['+@Col2Split+']>'''' ';
	exec sp_executesql @sql;

	set @sql=N'
	declare @i int=1,@chr varchar(5);

	while  exists(select * from nonsense_char where code>=@i)
	begin 
	   select top 1 @chr= chr,@i=code+1 from nonsense_char where code>=@i order by code ;
	   if  @chr is  not null and  @chr!='' '' 
	   	   update  ##raw set  ['+@Col2Split+']= Replace( ['+@Col2Split+'],@chr,'' '') ; 
	   
	 end ';
	exec sp_executesql @sql;
	 
	 
	set @sql=N' set  @max_len=( select max(len( ['+@Col2Split+'])) from tb_rawdata ) ;
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
	   
 

set nocount off ;
end ;

GO
/****** Object:  View [dbo].[view_FD_VerbatimsRawData]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  view [dbo].[view_FD_VerbatimsRawData] as  
select 
Q4_GRID_0_Q4 as 'v_Q4_GRID_0_Q4'
,Q6 as 'v_Q6'
, case when Q92_INS01 = 1 then '<br />'+(select Label from Variables where Variable='Q92_INS01') else '' end
+ case when Q92_INS02 = 1 then '<br />'+(select Label from Variables where Variable='Q92_INS02') else '' end
+ case when Q92_INS03 = 1 then '<br />'+(select Label from Variables where Variable='Q92_INS03') else '' end
+ case when Q92_INS04 = 1 then '<br />'+(select Label from Variables where Variable='Q92_INS04') else '' end
+ case when Q92_INS05 = 1 then '<br />'+(select Label from Variables where Variable='Q92_INS05') else '' end
+ case when Q92_INS06 = 1 then '<br />'+(select Label from Variables where Variable='Q92_INS06') else '' end
+ case when Q92_INS07 = 1 then '<br />'+(select Label from Variables where Variable='Q92_INS07') else '' end
+ case when Q92_INS08 = 1 then '<br />'+(select Label from Variables where Variable='Q92_INS08') else '' end
+ case when Q92_INS09 = 1 then '<br />'+(select Label from Variables where Variable='Q92_INS09') else '' end
+ case when Q92_INS10 = 1 then '<br />'+(select Label from Variables where Variable='Q92_INS10') else '' end
+ case when Q92_INS11 = 1 then '<br />'+(select Label from Variables where Variable='Q92_INS11') else '' end
+ case when Q92_INS12 = 1 then '<br />'+(select Label from Variables where Variable='Q92_INS12') else '' end
+ case when Q92_INS13 = 1 then '<br />'+(select Label from Variables where Variable='Q92_INS13') else '' end
+ case when Q92_INS14 = 1 then '<br />'+(select Label from Variables where Variable='Q92_INS14') else '' end
+ case when Q92_INS15 = 1 then '<br />'+(select Label from Variables where Variable='Q92_INS15') else '' end as 'v_Q92_INS'

, case when Q93_INS01 = 1 then '<br />'+(select Label from Variables where Variable='Q93_INS01') else '' end
+ case when Q93_INS02 = 1 then '<br />'+(select Label from Variables where Variable='Q93_INS02') else '' end
+ case when Q93_INS03 = 1 then '<br />'+(select Label from Variables where Variable='Q93_INS03') else '' end
+ case when Q93_INS04 = 1 then '<br />'+(select Label from Variables where Variable='Q93_INS04') else '' end
+ case when Q93_INS05 = 1 then '<br />'+(select Label from Variables where Variable='Q93_INS05') else '' end
+ case when Q93_INS06 = 1 then '<br />'+(select Label from Variables where Variable='Q93_INS06') else '' end
+ case when Q93_INS07 = 1 then '<br />'+(select Label from Variables where Variable='Q93_INS07') else '' end
+ case when Q93_INS08 = 1 then '<br />'+(select Label from Variables where Variable='Q93_INS08') else '' end
+ case when Q93_INS09 = 1 then '<br />'+(select Label from Variables where Variable='Q93_INS09') else '' end
+ case when Q93_INS10 = 1 then '<br />'+(select Label from Variables where Variable='Q93_INS10') else '' end
+ case when Q93_INS11 = 1 then '<br />'+(select Label from Variables where Variable='Q93_INS11') else '' end
+ case when Q93_INS12 = 1 then '<br />'+(select Label from Variables where Variable='Q93_INS12') else '' end
+ case when Q93_INS13 = 1 then '<br />'+(select Label from Variables where Variable='Q93_INS13') else '' end
+ case when Q93_INS14 = 1 then '<br />'+(select Label from Variables where Variable='Q93_INS14') else '' end
+ case when Q93_INS15 = 1 then '<br />'+(select Label from Variables where Variable='Q93_INS15') else '' end as 'v_Q93_INS'

, Q92 as 'v_Q92'
, Q93 as 'v_Q93'
, case when Q7201 = 1 then '<br />'+'Cleaning/Laundry Products (detergent, bleach, ammonia, toilet bowl cleaners, air fresheners, etc.)' else '' end
+ case when Q7202 = 1 then '<br />'+'Pet Products (pet food, accessories, toys, etc.)' else '' end 
+ case when Q7203 = 1 then '<br />'+'Paper Products (toilet paper, paper towels, napkins, paper plates, etc.)' else '' end 
+ case when Q7204 = 1 then '<br />'+'Health Products (pain relievers, first aid, vitamins)' else '' end 
+ case when Q7205 = 1 then '<br />'+'Personal Care and Beauty Products (shampoo, make up, deodorant, baby care)' else '' end 
+ case when Q7206 = 1 then '<br />'+'Refrigerated Food' else '' end 
+ case when Q7207 = 1 then '<br />'+'Non-refrigerated Food, beverages, snacks and candy' else '' end 
+ case when Q7208 = 1 then '<br />'+'Home (bedding, lamps, towels, cookware, small appliances, glassware, foil pans, mixing bowls, etc.)' else '' end 
+ case when Q7209 = 1 then '<br />'+'Clothing (girls and boys clothing, ladies'' clothing, men''s clothing, baby clothes, etc.)' else '' end 
+ case when Q7210 = 1 then '<br />'+'Seasonal Items (holiday candy, decorations, lawn & garden etc.)' else '' end 
+ case when Q7211 = 1 then '<br />'+'Other General Merchandise products (car items, phone and electronics, toys, office supplies, party goods, hardware, etc.)' else '' end 
+ case when Q7212 = 1 then '<br />'+'Other (Please specify:)' else '' end 
+ case when Q7213 = 1 then '<br />'+'Don''t know' else '' end as 'v_Q7201_Q7213'

,case when coalesce(Replace(Q72_GRID_01_Q72A_GRID_1_0_Q72A,'NULL',''),'')=''  then '' else '<br />'+Q72_GRID_01_Q72A_GRID_1_0_Q72A end
+ case when coalesce(Replace(Q72_GRID_02_Q72A_GRID_1_0_Q72A,'NULL',''),'')=''  then '' else '<br />'+Q72_GRID_02_Q72A_GRID_1_0_Q72A end
+ case when  coalesce(Replace(Q72_GRID_03_Q72A_GRID_1_0_Q72A,'NULL',''),'')=''  then '' else '<br />'+Q72_GRID_03_Q72A_GRID_1_0_Q72A end
+ case when  coalesce(Replace(Q72_GRID_04_Q72A_GRID_1_0_Q72A,'NULL',''),'')=''  then '' else '<br />'+Q72_GRID_04_Q72A_GRID_1_0_Q72A end
+ case when  coalesce(Replace(Q72_GRID_05_Q72A_GRID_1_0_Q72A,'NULL',''),'')=''  then '' else '<br />'+Q72_GRID_05_Q72A_GRID_1_0_Q72A end
+ case when  coalesce(Replace(Q72_GRID_06_Q72A_GRID_1_0_Q72A,'NULL',''),'')=''   then '' else '<br />'+Q72_GRID_06_Q72A_GRID_1_0_Q72A end
+ case when  coalesce(Replace(Q72_GRID_07_Q72A_GRID_1_0_Q72A,'NULL',''),'')=''  then '' else '<br />'+Q72_GRID_07_Q72A_GRID_1_0_Q72A end
+ case when  coalesce(Replace(Q72_GRID_08_Q72A_GRID_1_0_Q72A,'NULL',''),'')=''   then '' else '<br />'+Q72_GRID_08_Q72A_GRID_1_0_Q72A end
+ case when  coalesce(Replace(Q72_GRID_09_Q72A_GRID_1_0_Q72A,'NULL',''),'')=''   then '' else '<br />'+Q72_GRID_09_Q72A_GRID_1_0_Q72A end
+ case when  coalesce(Replace(Q72_GRID_10_Q72A_GRID_1_0_Q72A,'NULL',''),'')=''   then '' else '<br />'+Q72_GRID_10_Q72A_GRID_1_0_Q72A end
+ case when  coalesce(Replace(Q72_GRID_11_Q72A_GRID_1_0_Q72A,'NULL',''),'')=''   then '' else '<br />'+Q72_GRID_11_Q72A_GRID_1_0_Q72A end
+ case when  coalesce(Replace(Q72_GRID_12_Q72A_GRID_1_0_Q72A,'NULL',''),'')=''   then '' else '<br />'+Q72_GRID_12_Q72A_GRID_1_0_Q72A end
+ case when  coalesce(Replace(Q72_GRID_13_Q72A_GRID_1_0_Q72A,'NULL',''),'')=''  then '' else '<br />'+Q72_GRID_13_Q72A_GRID_1_0_Q72A end as 'v_Q72_GRID'

,case when Q109=1 then 'Yes' else '' end as 'v_Q109'
, case when isnull(Q110,'NULL') = 'NULL' then '' else Q110 end as 'v_Q110'
,(select Value_Label from Variable_Values where Variable='MRK_FDO' and Value=MRK_FDO) as 'v_MRK_FDO'
,Q2_1 as 'v_STORE'
,(select District from Hierarchy where STORE=Q2_1) as 'v_District'
,(select Region from Hierarchy where STORE=Q2_1) as 'v_Region'
,(select [Group] from Hierarchy where STORE=Q2_1) as 'v_Group'
,(select Value_Label from Variable_Values where Variable='Q63' and Value=Q63) as 'v_Gender'
,Q3 as 'v_Age'
,(select Value_Label from Variable_Values where Variable='Q13' and Value=Q13) as 'v_Shopping_Frquency'
,(select Value_Label from Variable_Values where Variable='Q64' and Value=Q64) as 'v_Income'
,(select Value_Label from Variable_Values where Variable='QCB4' and Value=QCB4) as 'v_Racial_Background'

, case when Q72_A01 = 1 then '<br />'+(select Label from Variables where Variable='Q72_A01') else '' end
+ case when Q72_A02 = 1 then '<br />'+(select Label from Variables where Variable='Q72_A02') else '' end 
+ case when Q72_A03 = 1 then '<br />'+(select Label from Variables where Variable='Q72_A03') else '' end 
+ case when Q72_A04 = 1 then '<br />'+(select Label from Variables where Variable='Q72_A04') else '' end 
+ case when Q72_A05 = 1 then '<br />'+(select Label from Variables where Variable='Q72_A05') else '' end 
+ case when Q72_A06 = 1 then '<br />'+(select Label from Variables where Variable='Q72_A06') else '' end 
+ case when Q72_A07 = 1 then '<br />'+(select Label from Variables where Variable='Q72_A07') else '' end 
+ case when Q72_A08 = 1 then '<br />'+(select Label from Variables where Variable='Q72_A08') else '' end 
+ case when Q72_A09 = 1 then '<br />'+(select Label from Variables where Variable='Q72_A09') else '' end 
+ case when Q72_A10 = 1 then '<br />'+(select Label from Variables where Variable='Q72_A10') else '' end 
+ case when Q72_A11 = 1 then '<br />'+(select Label from Variables where Variable='Q72_A11') else '' end  as 'v_G_Benefits'

, case when Q1401 = 1 then '<br />You found where the item was supposed to be and the shelf was empty' else '' end
+ case when Q1402 = 1 then '<br />The item was no longer where it was the last time you saw it in the store' else '' end 
+ case when Q1403 = 1 then '<br />You didn''t know where to look for the item' else '' end 
+ case when Q1404 = 1 then '<br />The store does not carry the item at all' else '' end 
+ case when Q1405 = 1 then '<br />The only one(s) they had in stock were damaged or opened' else '' end 
+ case when Q1406 = 1 then '<br />Other' else '' end 
+ case when Q1407 = 1 then '<br />None of the above'  else '' end  as 'v_Q141_Q147'
,*
 from tb_RawData




GO
/****** Object:  View [dbo].[view_FD_VerbatimsRawData_Q92Q93]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[view_FD_VerbatimsRawData_Q92Q93] as  
select vid=ROW_NUMBER() over(order by id),* from 
(select v_Q92_INS as 'v_Q92_INS_v_Q93_INS',Q92 as 'v_Q92_v_Q93',* from view_FD_VerbatimsRawData where Q92 <>''
 union all
 select v_Q93_INS,Q93,* from view_FD_VerbatimsRawData where Q93 <>'')[a]

GO
/****** Object:  View [dbo].[v_dashboard_scoring_trending_CASH_var]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  	  /*author :victor
			   create date:20150203
			  */
	CREATE view [dbo].[v_dashboard_scoring_trending_CASH_var]
	as   
	 select   dashboard.variable,q.Label,q.[TopNBox],q.[Mid3Box],q.[Bot2Box]
	   from  dbo.dashboard_TopNBot as dashboard (nolock) 
						 inner join [dbo].[Variables]  vr(nolock) on vr.Position=dashboard.Position
						 inner join [dbo].[Questionnaire] q(nolock) on  dashboard.Position=q.Position
GO
/****** Object:  View [dbo].[V_KPI]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





  /* 
 author :victor zhang 
 date:2015 02 09 
 */
CREATE View  [dbo].[V_KPI] 
 as  
  select Title as kpi,  -1* KPI_ID as KPI_ID
   from [dbo].[Headline_Variable] 
   union  all
   select  kpi, KPI_ID  from [dbo].[KPICalcs]


    


GO
/****** Object:  View [dbo].[v_Questions]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*author :victor 
  date:20150625
  */
CREATE view  [dbo].[v_Questions]
as 
select   Quest,coalesce(max(quest_label),Quest) as Quest_Label from Variable_Layered(nolock) where used=1
group by Quest
GO
/****** Object:  View [dbo].[v_RawData_Hierarchy]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
author :victor zhang
date :201501
*/
CREATE view   [dbo].[v_RawData_Hierarchy] 
  as
   select Q2_1 as Store,* from  [dbo].[tb_RawData]  (nolock)  




GO
/****** Object:  View [dbo].[v_RawData_Hierarchy_SC]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/*
author :victor zhang
date :201501
*/
CREATE view   [dbo].[v_RawData_Hierarchy_SC]

  as
  select  b.Store,b.[CLUSTER_UPDATED],a.*  
  from [dbo].[tb_RawData] a inner join [dbo].[Clusters]  b
   on a.[Q2_1]=b.[Store]  ;
   




GO
/****** Object:  View [dbo].[v_RawData_Hierarchy_SCSF]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*
author :victor zhang
date :201501
*/
CREATE view   [dbo].[v_RawData_Hierarchy_SCSF]

  as
  select  b.Store,c.[STOREFORMAT],b.CLUSTER_UPDATED,a.*  
   from [dbo].[tb_RawData] a left join [dbo].[Clusters]  b
   on a.[Q2_1]=b.[Store]  
   left join [dbo].[StoreFormat] c
      on a.[Q2_1]=c.[Store]  



GO
/****** Object:  View [dbo].[v_RawData_Hierarchy_SF]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









/*

author :victor zhang

date :201501

*/

CREATE view   [dbo].[v_RawData_Hierarchy_SF] 
  as

  select  b.Store,b.[STOREFORMAT],a.*  
   from [dbo].[tb_RawData] a inner join [dbo].[StoreFormat] b
   on a.[Q2_1]=b.[Store]  ;

   





GO
/****** Object:  View [dbo].[v_tb_FamilyDollar_RawData]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- drop table tb_FamilyDollar_RawData_v
-- select * into tb_FamilyDollar_RawData_v from v_tb_FamilyDollar_RawData
-- select distinct AGE_GROUP from tb_FamilyDollar_RawData_v
CREATE view [dbo].[v_tb_FamilyDollar_RawData]
as
select Respondent_ID
      ,Q2_1
      ,Q3
      ,AGE_GROUP
      ,RACE_ETH
      ,Q13
      ,freq_shop
      ,Q1401
      ,Q1402
      ,Q1403
      ,Q1404
      ,Q1405
      ,Q1406
      ,Q1407
      ,Q7201
      ,Q7202
      ,Q7203
      ,Q7204
      ,Q7205
      ,Q7206
      ,Q7207
      ,Q7208
      ,Q7209
      ,Q7210
      ,Q7211
      ,Q7212
      ,Q7213
      ,Q15
      ,Q16
      ,Q63
      ,Q64
      ,QCB3
      ,QCB4
      ,Q72_A01
      ,Q72_A02
      ,Q72_A03
      ,Q72_A04
      ,Q72_A05
      ,Q72_A06
      ,Q72_A07
      ,Q72_A08
      ,Q72_A09
      ,Q72_A10
      ,Q72_A11
      ,MRK_FDO
      ,Q4_GRID_0_Q4
      ,Q5_GRID_01_Q5
      ,Q5_GRID_02_Q5
      ,Q5_GRID_03_Q5
      ,Q7_GRID_01_Q7
      ,case Q7_GRID_02_Q7 when 97 then null else Q7_GRID_02_Q7 end as 'Q7_GRID_02_Q7'
      ,Q7_GRID_03_Q7
      ,Q7_GRID_04_Q7
      ,Q7_GRID_05_Q7
      ,Q8_GRID_01_Q8
      ,Q8_GRID_02_Q8
      ,Q8_GRID_03_Q8
      ,Q8_GRID_04_Q8
      ,Q9_GRID_01_Q9
      ,Q12A
      ,Q12C
      ,Q12D
      ,Q10_GRID_01_Q10
      ,Q6
      ,Q92
      ,Q93
      ,Q72_GRID_01_Q72A_GRID_1_0_Q72A
      ,Q72_GRID_02_Q72A_GRID_1_0_Q72A
      ,Q72_GRID_03_Q72A_GRID_1_0_Q72A
      ,Q72_GRID_04_Q72A_GRID_1_0_Q72A
      ,Q72_GRID_05_Q72A_GRID_1_0_Q72A
      ,Q72_GRID_06_Q72A_GRID_1_0_Q72A
      ,Q72_GRID_07_Q72A_GRID_1_0_Q72A
      ,Q72_GRID_08_Q72A_GRID_1_0_Q72A
      ,Q72_GRID_09_Q72A_GRID_1_0_Q72A
      ,Q72_GRID_10_Q72A_GRID_1_0_Q72A
      ,Q72_GRID_11_Q72A_GRID_1_0_Q72A
      ,Q72_GRID_12_Q72A_GRID_1_0_Q72A
      ,Q72_GRID_13_Q72A_GRID_1_0_Q72A
      ,Q110
      --,Q91A_GRID_01_Q91A
      --,Q91A_GRID_02_Q91A
      --,Q91A_GRID_03_Q91A
      --,Q91A_GRID_04_Q91A
      --,Q91A_GRID_05_Q91A
      --,Q91B_GRID_06_Q91B
      --,Q91B_GRID_07_Q91B
      --,Q91B_GRID_08_Q91B
      --,Q91B_GRID_10_Q91B
      --,Q91B_GRID_11_Q91B
      --,Q91C_GRID_09_Q91C
      --,Q91C_GRID_12_Q91C
      --,Q91C_GRID_13_Q91C
      --,Q91C_GRID_14_Q91C
      --,Q91D_GRID_15_Q91D
	  ----------------------------------------------------------------------
	   ,case Q91A_GRID_01_Q91A when 98 then null else Q91A_GRID_01_Q91A end as 'Q91A_GRID_01_Q91A'
	   ,case Q91A_GRID_02_Q91A when 98 then null else Q91A_GRID_02_Q91A end as 'Q91A_GRID_02_Q91A'
	   ,case Q91A_GRID_03_Q91A when 98 then null else Q91A_GRID_03_Q91A end as 'Q91A_GRID_03_Q91A'
	   ,case Q91A_GRID_04_Q91A when 98 then null else Q91A_GRID_04_Q91A end as 'Q91A_GRID_04_Q91A'
	   ,case Q91A_GRID_05_Q91A when 98 then null else Q91A_GRID_05_Q91A end as 'Q91A_GRID_05_Q91A'
	   ,case Q91B_GRID_06_Q91B when 98 then null else Q91B_GRID_06_Q91B end as 'Q91B_GRID_06_Q91B'
	   ,case Q91B_GRID_07_Q91B when 98 then null else Q91B_GRID_07_Q91B end as 'Q91B_GRID_07_Q91B'
	   ,case Q91B_GRID_08_Q91B when 98 then null else Q91B_GRID_08_Q91B end as 'Q91B_GRID_08_Q91B'
	   ,case Q91B_GRID_10_Q91B when 98 then null else Q91B_GRID_10_Q91B end as 'Q91B_GRID_10_Q91B'
	   ,case Q91B_GRID_11_Q91B when 98 then null else Q91B_GRID_11_Q91B end as 'Q91B_GRID_11_Q91B'
	   ,case Q91C_GRID_09_Q91C when 98 then null else Q91C_GRID_09_Q91C end as 'Q91C_GRID_09_Q91C'
	   ,case Q91C_GRID_12_Q91C when 98 then null else Q91C_GRID_12_Q91C end as 'Q91C_GRID_12_Q91C'
	   ,case Q91C_GRID_13_Q91C when 98 then null else Q91C_GRID_13_Q91C end as 'Q91C_GRID_13_Q91C'
	   ,case Q91C_GRID_14_Q91C when 98 then null else Q91C_GRID_14_Q91C end as 'Q91C_GRID_14_Q91C'
	   ,case Q91D_GRID_15_Q91D when 98 then null else Q91D_GRID_15_Q91D end as 'Q91D_GRID_15_Q91D'
	  ----------------------------------------------------------------------
      ,Q100
      ,Q101_GRID_01_Q101
      ,Q101_GRID_02_Q101
      ,Q101_GRID_03_Q101
      ,Q102
  ,Q105
      ,Q106
      ,Q107
      ,Q108
      ,Q109
      ,Q115_GRID_01_Q115
      ,Q115_GRID_02_Q115
      ,Q116_GRID_01_Q116
      ,Q116_GRID_02_Q116
      ,Q116_GRID_03_Q116
      ,Q117_GRID_01_Q117
      ,Q117_GRID_02_Q117
      ,Q117_GRID_03_Q117
      ,Q117_GRID_04_Q117
      ,Q117_GRID_05_Q117
      ,Q117_GRID_06_Q117
      ,Q117_GRID_07_Q117
      ,Q118
      ,DATE_NUM
      ,MRK_SEG1
      ,InterviewLength
      ,MONTHX
      ,FDO_FISCAL_2015
      ,QUARTER_NEW
      ,YEAR_NEW
      ,[weight]
      ,RECEIPTNUM
      ,[Group]
      ,Region
      ,District
      ,id
	  ,(SELECT top 1 [CLUSTER_UPDATED] FROM [Clusters] where [STORE]=Q2_1) as 'CLUSTER_UPDATED'
	  ,(SELECT top 1 [STOREFORMAT] FROM [StoreFormat] where [STORE]=Q2_1) as 'STOREFORMAT'
  FROM tb_RawData
GO
/****** Object:  View [dbo].[V_Year_Quarter]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		 /* 
		   author victor zhang
		   date  20150403
		 */
		 CREATE  View  [dbo].[V_Year_Quarter]
		 as 
			  select * from dbo.Year_Quarter
GO
/****** Object:  View [dbo].[vw_LiveUserList]    Script Date: 27/10/2015 10:33:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_LiveUserList]
AS
SELECT        top 5000 ROW_NUMBER() OVER(ORDER BY [UID] asc) AS RowNumber, [UID], Username, FirstName, LastName, Permission_level, [Group], Region, District, EMPLOYEE_NUMBER, case when username like '%familydollar.com' then 1 else 0 end as ClientUser
FROM            dbo.tb_Userlist
where username like '%familydollar.com'
order by [uid] asc


GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tb_Userlist"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_LiveUserList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_LiveUserList'
GO
