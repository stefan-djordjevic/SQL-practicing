create database TEST_DB;

create table radnik
(
	Mbr int not null,
	Ime varchar(20) not null,
	Prz varchar(25) not null,
	Sef int,
	Plt decimal(10,2),
	Pre decimal(6,2),
	God date not null,
	
	constraint radnik_pk primary key(Mbr),
	constraint radnik_fk foreign key(Sef)
		references radnik(Mbr),
	constraint radnik_ch check(Plt>500)
);

create table projekat
(
	Spr int not null,
	Ruk int not null,
	Nap varchar(30),
	Nar varchar(30),
	
	constraint proj_pk primary key(spr),
	constraint proj_fk foreign key(ruk)
		references radnik(mbr),
	constraint proj_uq unique(Nap)
);


create table radproj
(
	Spr int not null,
	Mbr int not null,
	Brc int not null,
	
	constraint radproj_pk primary key(Spr, Mbr),
	constraint radproj_rad_fk foreign key(Mbr)
		references radnik(mbr),
	constraint radproj_proj_fk foreign key(Spr)
		references projekat(Spr)
);


create table organizacija
(
	Orgid int not null,
	Orgnaziv varchar(30),
	Mestoorg varchar(30),
	
	constraint org_pk primary key(Orgid)
);


create table imenik
(
	Mbr int not null,
	Telbroj varchar(10) not null,
	constraint imenik_pk primary key(Mbr),
	constraint imenik_fk foreign key(Mbr)
		references radnik(Mbr)
);


alter table imenik
	add adresa varchar(20) null,
		mesto varchar(30) null
		

alter table radnik
	add orgid int null,
	constraint radnik_org_fk foreign key(orgid)
		references organizacija(orgid)
		
		
alter table organizacija
	drop column mestoorg
	
	
drop table imenik


/*---------------------------------------------------*/


insert into radnik
(Mbr, Ime, Prz, plt, Sef, god) values
(201, 'Ana', 'Savic', 300000, null, '18-aug-71');

insert into projekat
(Spr, Nap, ruk) values
(70, 'P1', 201);

insert into radproj
(Mbr, Spr, Brc) values
(201, 70, 5);



delete from radproj 
where Spr = 70;

delete projekat
where ruk>100;



update radnik
set Plt=Plt*1.2;

update radnik
set Plt=Plt*1.5
where mbr=201;



