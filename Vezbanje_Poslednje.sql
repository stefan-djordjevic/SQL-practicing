select ime, prz
from radnik;

select distinct ime
from radnik;

select mbr, ime, prz
from radnik
where Plt>25000;

select mbr, ime, prz, plt*12 "Godisnja plata"
from radnik;

select mbr, ime, prz
from radnik 
where Sef is null;

select mbr, plt+ISNULL(pre, 0)
from radnik;

select mbr, ime, prz
from radnik
where Plt between 20000 and 24000;

select ime, prz, god
from radnik
where God not between '01-jan-53' and '31-dec-75';

select mbr, ime, prz
from radnik
where Prz like 'M%';

select mbr, ime, prz
from radnik
where ime like '_a%';

select distinct ime
from radnik
where Ime like 'E%'

select mbr
from radproj
where Spr = 10 or Brc in (2,4,6);

select mbr
from radnik
where Ime not in ('Ana', 'Sanja');

select mbr, ime, prz, plt
from radnik
where Sef is not null
order by plt desc;

select mbr, ime, prz, plt Plata
from radnik
order by Plt desc;

select mbr, ime+' ' + prz "Ime i prezime", plt*1.17 Plata
from radnik;

select COUNT(*) "Broj radnika"
from radnik;

select COUNT(distinct sef) "Broj sefova"
from radnik;


select MAX(plt) "Max plata", MIN(plt) "Min plata"
from radnik;

select COUNT(*) "Broj radnika", round(avg(plt), 1) "Prosecna plata", 12*SUM(plt) "Ukupna godisnja plata"
from radnik;

select mbr, ime, prz, round(plt*12, 1) "Godisnja plata"
from radnik;

select round(AVG(plt), 1) "Prosecna plata"
from radnik;

select spr Projekat, COUNT(mbr) "Broj radnika", SUM(brc) "Ukupno anagazovanje"
from radproj
group by Spr;

select mbr Radnik, COUNT(spr) "Broj projekata"
from radproj
group by Mbr
having COUNT(spr)>2;

select r.mbr, ime, prz, plt, brc, spr
from radnik r, radproj rp
where r.Mbr = rp.Mbr
and Spr = 10;

select distinct mbr, ime, prz, plt
from radnik, projekat
where Mbr=ruk;

select ime, prz, COUNT(spr) "Broj projekata"
from radnik, projekat
where ruk = Mbr
group by Ime, prz;

select r.mbr, prz, ime, COUNT(*) "Broj projekata", SUM(brc) "Ukupno sati"
from radnik r, radproj rp
where r.Mbr = rp.Mbr
group by r.Mbr, Prz, Ime;

select nap
from radproj rp, projekat p
where p.Spr=rp.Spr
group by Nap
having SUM(brc)>15;

select p.spr, nap, COUNT(rp.mbr) "Broj radnika"
from projekat p, radproj rp
where p.Spr = rp.Spr
group by p.Spr, nap
having COUNT(rp.mbr)>2;

select mbr, ime, prz, plt
from radnik
where Plt > all(select Plt from radnik where Mbr=40);

select r.mbr, r.ime, r.prz, r.plt
from radnik r, radnik r1
where r.Plt > r1.plt and r1.Mbr =40;

select r1.ime, r1.prz, r1.plt, p.nap
from radnik r1, radnik r2, radproj rp, projekat p
where r1.Mbr=rp.mbr and rp.Spr = p.spr and p.Ruk = r2.mbr and
r1.Plt+1000 < r2.Plt;

select mbr, ime, prz, plt
from radnik
where Plt>(select avg(Plt) from radnik)
order by plt asc;

select ime, prz
from radnik
where Mbr in (select Mbr from radproj where Spr=30);

select ime, prz
from radnik r, radproj rp
where r.Mbr=rp.Mbr and Spr=30;

select mbr, ime, prz
from radnik
where Mbr in 
(select Mbr from radproj where Spr=20)
and Mbr not in 
(select Mbr from radproj where Spr=10);

select ime, prz
from radnik
where Mbr != (select ruk from projekat where Spr = 10);

select nap
from projekat
where Spr in (select Spr from radproj 
where Mbr in (select Mbr from radproj 
where Spr=60))

select r.ime, r.prz, COUNT(distinct rp.spr) "Broj projekata"
from radnik r, radproj rp
where r.Mbr = rp.Mbr and
r.Mbr in (select ruk from projekat)
group by r.Ime, r.Prz;

select p.nap, p.spr
from projekat p, radproj rp
where p.Spr = rp.Spr
group by p.Spr, p.nap
having AVG(brc) > (select AVG(brc) from radproj);

select mbr, ime, prz, god
from radnik
where God <= all(select God from radnik);

select mbr, ime, prz, god
from radnik
where God = (select min(God) from radnik);

select mbr, ime, prz
from radnik
where Mbr not in (select ruk from projekat where Mbr=ruk);

select r.mbr, ime, prz, plt
from radnik r, radproj rp
where r.Mbr = rp.Mbr 
and rp.Brc > (select AVG(brc) from radproj rp1 where rp.Spr=rp1.spr);

select mbr, ime, prz
from radnik
where exists (select * from projekat where Mbr=ruk);

select mbr, ime, prz
from radnik r
where mbr in (select ruk from projekat where Mbr=ruk);

select GETDATE();

SELECT DAY(god) Dan, DATENAME(MONTH, god) Mesec,
DATENAME(year, god) Godina,
DATENAME(weekday, god) "Dan u nedelji",
GETDATE() "Trenutno vreme i datum" FROM radnik;