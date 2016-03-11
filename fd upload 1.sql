 

USE [FamilyDollar]
GO
exec sp_rename '[FamilyDollar].dbo.tb_rawdata','tb_rawdata_20151125BAK'
go
select * into FamilyDollar..tb_rawdata from [FamilyDollar_test].dbo.tb_rawdata
 
 alter table tb_rawdata add constraint pk_id20151125 primary key(id)

USE [FamilyDollar_test]
GO
  
  
  --exec sp_rename 'tb_rawdata.DT_QUARTER','QUARTER_NEW','Column'
  --exec sp_rename 'tb_rawdata.dt_weight','weight','Column'
  --exec sp_rename 'tb_rawdata.[monthnew]','MONTHX','Column'
  --alter table tb_rawdata_victor add YEAR_NEW smallint

 ---------
  select * from [dbo].[Variable_Values] where Variable ='quarter_new'
 select  (substring(value_label,6,4)-2010)%3+1, * from  [dbo].[Variable_Values$](nolock) where variable ='QUARTER_NEW'

update a   set year_new = (substring(b.value_label,6,4)-2010)%3+1
from [dbo].[tb_rawdata_victor] a inner join  [dbo].[Variable_Values$] b
 on b.variable ='QUARTER_NEW' and a.Quarter_new=b.Value

 select distinct year_new,quarter_new  from [dbo].[tb_rawdata_victor]

 select from [tb_rawdata_victor]
[dbo].[Year_Quarter]
select * from [dbo].[V_Year_Quarter]


-----------------------------------
---------------------------------------

		 update tb_rawdata set [Group]= '-9999' ,  [Region]= '-9999' , district= '-9999' 
		  --update rd
		  --set rd.[group] = -9999,
		  --rd.[region] = -9999,
		  --rd.[district] = -9999 
		  --from [dbo].[tb_rawdata_victor] rd inner join [dbo].[Hierarchy] h on h.store = rd.q2_1 
		  update rd
		  set rd.[group] = h.[group],
		  rd.[region] = h.[region],
		  rd.[district] = h.[district] 
		  from [dbo].tb_rawdata rd inner join [dbo].[Hierarchy] h on h.store = rd.q2_1
  
		  update tb_rawdata set [Group]=isnull([Group],'-9999'),  [Region]=isnull(region,'-9999'), district=isnull(district,'-9999') 
   	go
 --- select count(*),count([Group]),count([REgion]),count(District)  from tb_rawdata where [group]>-9999
			---alter table  [dbo].[tb_rawdata]    add  ID bigint not null identity(1,1) primary key
			--alter table  [dbo].[tb_rawdata]   alter column id bigint not null  
			-- alter table  [dbo].[tb_rawdata]   add constraint pk_id2 primary key(ID)
			CREATE NONCLUSTERED INDEX [ix_nc_tb_rawdata_1] ON [dbo].tb_rawdata
			(
				[YEAR_NEW] ASC,QUARTER_NEW	 ASC,	[Group] ASC,[Region] ASC,[District] ASC,[Q2_1] ASC	)
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
  
			CREATE NONCLUSTERED INDEX [ix_nc_tb_rawdata_2] ON [dbo].tb_rawdata
			(
				QUARTER_NEW ASC,[Group] ASC,	[Region] ASC,[District] ASC,[Q2_1] ASC  )
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

	  CREATE NONCLUSTERED INDEX [ix_nc_tb_rawdata_3] ON [dbo].tb_rawdata
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
 
  CREATE NONCLUSTERED INDEX [ix_nc_tb_rawdata_4] ON [dbo].tb_rawdata
			(
				 [District] ASC,[Q2_1] ASC	)
			INCLUDE ( YEAR_NEW,QUARTER_NEW ,[Group] ,[Region] ,
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

  		CREATE NONCLUSTERED INDEX [ix_nc_tb_rawdata_8] ON [dbo].tb_rawdata
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

	CREATE NONCLUSTERED INDEX [ix_nc_tb_rawdata_10] ON [dbo].tb_rawdata
			(  
				 QUARTER_NEW,     [Group]
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
ON [dbo].tb_rawdata ([YEAR_NEW],[Group])
INCLUDE ([Q4_GRID_0_Q4],[Q5_GRID_01_Q5],[Q5_GRID_02_Q5],[Q5_GRID_03_Q5],[Q7_GRID_01_Q7],[Q7_GRID_02_Q7],[Q7_GRID_03_Q7],[Q7_GRID_04_Q7],[Q7_GRID_05_Q7],[Q8_GRID_01_Q8],[Q8_GRID_02_Q8],[Q8_GRID_03_Q8],[Q8_GRID_04_Q8],[Q9_GRID_01_Q9],[Q12A],[Q12C],[Q12D],[Q10_GRID_01_Q10],[Q91A_GRID_01_Q91A],[Q91A_GRID_02_Q91A],[Q91A_GRID_03_Q91A],[Q91A_GRID_04_Q91A],[Q91A_GRID_05_Q91A],[Q91B_GRID_06_Q91B],[Q91B_GRID_07_Q91B],[Q91B_GRID_08_Q91B],[Q91B_GRID_10_Q91B],[Q91B_GRID_11_Q91B],[Q91C_GRID_09_Q91C],[Q91C_GRID_12_Q91C],[Q91C_GRID_13_Q91C],[Q91C_GRID_14_Q91C],[Q100],[Q101_GRID_01_Q101],[Q101_GRID_02_Q101],[Q101_GRID_03_Q101],[Q102],QUARTER_NEW,[weight]);
 
CREATE NONCLUSTERED INDEX [ix_nc_tb_rawdata_13]
ON [dbo].tb_rawdata ([District],[YEAR_NEW])
INCLUDE ([Q4_GRID_0_Q4],[Q5_GRID_01_Q5],[Q5_GRID_02_Q5],[Q5_GRID_03_Q5],[Q7_GRID_01_Q7],[Q7_GRID_02_Q7],[Q7_GRID_03_Q7],[Q7_GRID_04_Q7],[Q7_GRID_05_Q7],[Q8_GRID_01_Q8],[Q8_GRID_02_Q8],[Q8_GRID_03_Q8],[Q8_GRID_04_Q8],[Q9_GRID_01_Q9],[Q12A],[Q12C],[Q12D],[Q10_GRID_01_Q10],[Q91A_GRID_01_Q91A],[Q91A_GRID_02_Q91A],[Q91A_GRID_03_Q91A],[Q91A_GRID_04_Q91A],[Q91A_GRID_05_Q91A],[Q91B_GRID_06_Q91B],[Q91B_GRID_07_Q91B],[Q91B_GRID_08_Q91B],[Q91B_GRID_10_Q91B],[Q91B_GRID_11_Q91B],[Q91C_GRID_09_Q91C],[Q91C_GRID_12_Q91C],[Q91C_GRID_13_Q91C],[Q91C_GRID_14_Q91C],[Q100],[Q101_GRID_01_Q101],[Q101_GRID_02_Q101],[Q101_GRID_03_Q101],[Q102],[weight],[Group],[Region]) ;

CREATE NONCLUSTERED INDEX [ix_nc_tb_rawdata_14]
ON [dbo].tb_rawdata ([YEAR_NEW],[Group],[District])
INCLUDE ([Q7_GRID_01_Q7],[Q7_GRID_02_Q7],[Q7_GRID_03_Q7],[Q7_GRID_04_Q7],[Q7_GRID_05_Q7],[Q8_GRID_01_Q8],[Q8_GRID_02_Q8],[Q8_GRID_03_Q8],[Q8_GRID_04_Q8],[Q9_GRID_01_Q9],[Q12A],[Q12C],[Q10_GRID_01_Q10],QUARTER_NEW,[weight],[Region]);

 
CREATE NONCLUSTERED INDEX ix_nc_tb_rawdata_15   ON [dbo].tb_rawdata (QUARTER_NEW,[District])  INCLUDE ([Q2_1],[Group],[Region])
 

 go
/*
author :victor zhang
date :201501
*/
ALTER view   [dbo].[v_RawData_Hierarchy] 
  as
   select Q2_1 as Store,* from  [dbo].[tb_RawData]  (nolock)  

  
GO

		 /* 
		   author victor zhang
		   date  20150403
		 */
		 alter  View  V_Year_Quarter
		 as 
			  select * from dbo.Year_Quarter
go

 
 


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


		select count(*) from  [dbo].[Store_DENSITY_CLASS]

 
update a set a.[DENSITY_CLASS]=b.[DENSITY_CLASS]
from tb_rawdata a inner join [dbo].[Store_DENSITY_CLASS] b
on a.Q2_1=b.Store

select distinct [DENSITY_CLASS] from tb_rawdata

alter index all on tb_rawdata rebuild


 


