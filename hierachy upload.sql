use [FamilyDollar_TEST]
go
select * from [Hierarchy]
exec sp_rename '[Hierarchy]','Hierarchy_20160210BAK'
 go
CREATE TABLE [dbo].[Hierarchy](
	[Group] [int] NULL,
	[Region] [int] NULL,
	[District] [int] NULL,
	[Store] [int] NOT NULL  PRIMARY KEY  
) ON [PRIMARY]
go

--truncate table [Hierarchy]
insert into [Hierarchy]([Store],[District],[Region],[Group])
select distinct Store,District,Region,[Group] from  [dbo].[hierachydata_20160216$]

alter index all on  [Hierarchy] rebuild

insert into [Hierarchy]([Store],[District],[Region],[Group])
select [Store],[District],[Region],[Group]
from (values
)t([Store],[District],[Region],[Group])
go
	
 CREATE NONCLUSTERED INDEX [ix_Hierarchy_district] ON [dbo].[Hierarchy]
(
	[District] ASC,
	[Region] ASC,
	[Group] ASC
) 
 CREATE NONCLUSTERED INDEX [ix_Hierarchy_group] ON [dbo].[Hierarchy]
(
	[Group] ASC
) 
 CREATE NONCLUSTERED INDEX [ix_Hierarchy_Region] ON [dbo].[Hierarchy]
(
	[Region] ASC,
	[Group] ASC
) 
go

		   
--select *  into [Hierarchy_20151111BAK] from [Hierarchy]
---truncate table [Hierarchy]
---insert into [Hierarchy] ([Store],[District],[Region],[Group])
 select [Store],[District],[Region],[Group]
 from hierachy_20151110

	alter  INDEX all on  [dbo].[Hierarchy] rebuild ;


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

		  alter index all on tb_rawdata rebuild ;
		  
		 

--use [FamilyDollar]
--go
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


 select * from Hierarchy where store=9200 and region=10 and district=200
 select * from [tb_userlist] where store=9200 

 select a.username,a.Store,a.District,a.Region,a.[Group]
  from 	[tb_userlist] a left join Hierarchy b on a.Store=b.store 
 where b.Store is null	and a.Store is not null 

 select a.username,a.Store,a.District,a.Region,a.[Group]
  from 	[tb_userlist] a left join Hierarchy b on  a.District=b.District 
 where b.District is null	--and a.Store is  null
  and a.District is not null 

 select a.username,a.Store,a.District,a.Region,a.[Group]
  from 	[tb_userlist] a left join Hierarchy b on    a.Region=b.Region 
 where b.Region is null	 --and a.Store is  null 
 and a.District is   null and a.Region is not null 

 select a.username,a.Store,a.District,a.Region,a.[Group]
  from 	[tb_userlist] a left join Hierarchy b on  a.[Group]=b.[Group]
 where b.Region is null	 ---and a.Store is  null and a.District is   null and a.Region is   null
  and a.[Group]  is not null 
