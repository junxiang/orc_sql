--sp_rename 'tb_rawdata','tb_rawdata_20151027BAK'
--sp_rename '[dbo].[Hierarchy]','Hierarchy_20151027BAK'

--select * into tb_rawdata from [FamilyDollar_TEST]..tb_rawdata



--select * into Hierarchy from [FamilyDollar_TEST]..Hierarchy

 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		DROP INDEX [dbo].[Hierarchy].[ix_Hierarchy_district]
		DROP INDEX [dbo].[Hierarchy].[ix_Hierarchy_group]
		DROP INDEX [dbo].[Hierarchy].[ix_Hierarchy_Region]
		alter table [dbo].[Hierarchy] DROP constraint PK_Store;

		ALTER TABLE [dbo].[Hierarchy] ADD  CONSTRAINT [PK_Store1] PRIMARY KEY CLUSTERED 	(			[Store] 		) ;
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

			alter table  [dbo].[tb_RawData]   add constraint [PK_tb_RawData_ID1]  primary key(ID) ;

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


 select * from wordcloud_question

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




