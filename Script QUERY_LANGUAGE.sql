/****QUERY LANGUAGE****/

select * from radnik;
select * from projekat;
select * from radproj;

select ime, prz
from radnik;

select ime, prz
from radnik
where plt<=10000;

select distinct ime 
from radnik;

select mbr, ime, prz
from radnik
where plt>25000;

select mbr, ime, prz, plt*12
from radnik;

select mbr, ime, prz
from radnik
where sef is null;

select mbr, plt+NULL from radnik; /* svi su NULL! */

select mbr, plt+pre from radnik;

select mbr, plt + ISNULL(pre, 0)
from radnik;

select mbr, ime, prz 
from radnik
where plt between 20000 and 24000;

select ime, prz, god
from radnik
where god between '01-jan-1953' and '31-dec-1975';

alter table radnik
	alter column god date
	
select ime, prz, god
from radnik
where god not between '01-jan-1953' and '31-dec-1975';

select mbr, ime, prz 
from radnik
where prz like 'M%';

select mbr, ime, prz
from radnik
where ime not like 'A%';

select mbr, ime, prz
from radnik
where ime like '_a%';

select distinct ime
from radnik
where ime like 'E%';

select mbr, ime, prz
from radnik
where prz like '%e%';

select mbr
from radproj
where spr in (10, 20, 30);

select mbr
from radproj
where spr=10 or brc in (2,4,6); 

select mbr, ime, prz
from radnik
where ime in ('Ana', 'Sanja');

select mbr, ime, prz
from radnik
where ime not in ('Ana', 'Sanja');

select mbr, ime, prz, plt
from radnik
where sef is not null
order by prz asc, ime desc;

select mbr, ime, prz, plt
from radnik
order by ime, prz;

select mbr, ime, prz
from radnik
order by 1;

select mbr, ime, prz
from radnik
order by plt*1.17;

select mbr, ime, prz, plt Plata
from radnik
order by Plata desc;

select mbr, ime + ' ' + prz "Ime i prezime", plt*1.17 Plata
from radnik;

select COUNT(*)
from radnik;

select COUNT(distinct sef)
from radnik;

select MIN(plt) "Min plata", MAX(plt) "Max plata"
from radnik;

select COUNT(*) "Broj radnika", SUM(plt) "Uk.mesecna plata"
from radnik;

select COUNT(*) "Broj radnika", AVG(plt) "Prosecna plata", 12*SUM(plt) "Uk.godisnja plata"
from radnik;

select round(AVG(plt),1)
from radnik;

select spr, COUNT(mbr), SUM(brc)
from radproj
group by spr;

select mbr, COUNT(spr)
from radproj
group by mbr
having COUNT(spr)>2;

select radnik.mbr, prz, ime, plt, SUM(brc)
from radnik, radproj
where radnik.Mbr=radproj.Mbr
group by radnik.Mbr, Prz, Ime, plt;

select r.mbr, r.prz, r.ime, r.plt, rp.brc
from radnik r, radproj rp
where r.Mbr=rp.mbr and rp.Spr=10;

select distinct mbr, ime, prz, plt
from radnik, projekat
where Mbr=Ruk;

select ime, prz, count(spr)
from radnik, projekat
where Mbr=Ruk
group by Ime, prz;

select r.mbr, r.ime, r.prz, r.plt
from radnik r, radnik r1
where r.plt>r1.plt and r1.Mbr=170;

select ime, prz, Spr
from radnik r, radproj rp
where r.Mbr=rp.Mbr and Spr=30;

select ime, prz, spr
from radnik r inner join radproj rp on r.Mbr=rp.Mbr
where Spr=30;

select r.Mbr, ime, prz, spr
from radnik r left join radproj rp on r.Mbr=rp.Mbr;

select p.nap, ISNULL(rp.mbr, 0) "Mbr radnika"
from radproj rp right outer join projekat p on rp.Spr=p.Spr;

select p.nap, ISNULL(rp.mbr, 0) "Mbr radnika"
from radproj rp full outer join projekat p on rp.Spr=p.Spr;

select mbr, ime, prz, plt
from radnik
where Plt>(select AVG(plt) from radnik)
order by Plt asc;

select ime, prz
from radnik
where Mbr in (select Mbr from radproj where Spr=30);

/*
delete from radproj
where Brc<(select AVG(brc) from radproj)
*/

update radnik
set Pre=ISNULL(Pre,0) + 500
where Mbr in (select Mbr from radproj where Spr=10);

select mbr, ime, prz, god
from radnik
where God <= all(select God from radnik);

select mbr, ime, prz, god
from radnik
where God = (select MIN(god) from radnik);

select mbr, ime, prz
from radnik
where Mbr not in (select ruk from projekat where Mbr=ruk); /*moze i bez where*/

select mbr, ime, prz
from radnik
where exists(select * from projekat where mbr=ruk);

select mbr, ime, prz
from radnik
where mbr in (select ruk from projekat where mbr=ruk);

select nap "Naziv projekta", SUBSTRING(nap, 1, 3), LEN(nap),
	   CHARINDEX(' ', nap), REPLACE(nap, ' ', '')
from projekat;

select mbr, DAY(god) Dan, MONTH(god) Mesec, DATENAME(YEAR,god) Godina, 
       DATENAME(WEEKDAY, god) "Dan u nedelji", GETDATE() "Trenutno vreme"
from radnik;

CREATE VIEW rukovodioci(Mbr, Ime, Prezime, Projekat) AS
select r.mbr, ime, prz, nap
from radnik r, projekat p
where r.Mbr=p.Ruk;

select Ime, Prezime, Projekat
from rukovodioci;




