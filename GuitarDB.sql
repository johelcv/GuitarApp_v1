use master
GO

create database GuitarDB
GO

use GuitarDB

create table Body
(
	Id int primary key identity(1,1),
	Name nvarchar(100),
	Description nvarchar(500)
)
GO
create table Neck
(
	Id int primary key identity(1,1),
	Name nvarchar(100),
	Description nvarchar(500)
)
GO
create table Bridge
(
	Id int primary key identity(1,1),
	Name nvarchar(100),
	Description nvarchar(500)
)
GO
create table Pickup
(
	Id int primary key identity(1,1),
	Name nvarchar(100),
	Description nvarchar(500)
)
GO
create table Guitar
(
	Id int primary key identity(1,1),
	Name nvarchar(100),
	Description nvarchar(500),
	BodyId int references Body(Id),
	NeckId int references Neck(Id),
	BridgeId int references Bridge(Id),
	PickupId int references Pickup(Id),
	StartDate Date,
	PaintDate Date,
	TestDate Date,
	FinishDate Date

)
GO
create table Project
(
	Id int primary key identity(1,1),
	Name nvarchar(100),
	Description nvarchar(500),
	BodyId int references Body(Id),
	NeckId int references Neck(Id),
	BridgeId int references Bridge(Id),
	PickupId int references Pickup(Id),
	ImgProject varchar(512)

)
GO

create table Reviews 
(
	Id int primary key identity(1,1),  
	Comment nvarchar(2056), 
	Score int , 
	GuitarId int references  Guitar(Id)
)
GO

create procedure [dbo].[GetOne]
	@xId int
AS
Select P.Name,P.Description,B.Id as BodyId,B.Name as Body,Br.Id as BridgeId,Br.Name as Bridge,N.Id as NeckId,N.Name as Neck,Pu.Id PickupId,Pu.Name as Pickup,IsNull(P.ImgProject,'') as ImgProject
from Project P 
inner join Body B on P.BodyId = B.Id
inner join Bridge Br on P.BridgeId = Br.Id
inner join Neck N on N.Id = P.NeckId
inner join Pickup Pu on Pu.Id = P.PickupId
where P.Id = @xId
GO

create procedure GetOneGuitar
	@xId Int
as
Select G.Name,G.Description,G.StartDate,G.PaintDate,G.TestDate,G.FinishDate,B.Id as BodyId,B.Name as Body,Br.Id as BridgeId,Br.Name as Bridge,N.Id as NeckId,N.Name as Neck,Pu.Id PickupId,Pu.Name as Pickup
from Guitar G 
inner join Body B on G.BodyId = B.Id
inner join Bridge Br on G.BridgeId = Br.Id
inner join Neck N on N.Id = G.NeckId
inner join Pickup Pu on Pu.Id = G.PickupId
where G.Id = @xId
GO

create procedure [dbo].[usp_obtener_proyectos]
as
select P.Id,P.Name,P.Description from Project P
inner join Body B on P.BodyId = B.Id
inner join Neck N on P.NeckId = N.Id
inner join Bridge Br on P.BridgeId = Br.Id
inner join Pickup Pu on P.PickupId = Pu.Id
GO

create procedure usp_obtener_body
as
select id,Name,Description from Body
GO

create procedure usp_obtener_neck
as
select id,Name,Description from Neck
GO

create procedure usp_obtener_bridge
as
select id,Name,Description from Bridge
GO

create procedure usp_obtener_pickup
as
select id,Name,Description from Pickup
GO

insert into Body values('Solid','')
insert into Body values('Hollow','')
insert into Body values('Semi-Hollow','')
GO

insert into Neck values('Maple','')
insert into Neck values('Mahogamy','')
insert into Neck values('Rosewood','')
insert into Neck values('Pau ferro','')
insert into Neck values('Basswood','')
GO

insert into Bridge values('Floyd Rose','')
insert into Bridge values('Tremolo','')
insert into Bridge values('Traditional','')
GO

insert into Pickup values('Single Coil','')
insert into Pickup values('Humbucker','')
insert into Pickup values('Active','')
GO