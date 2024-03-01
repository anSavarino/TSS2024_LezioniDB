-- funzioni
select * from corsi;

select avg(prezzo) `Prezzo medio`
from corsi;
use corsi;
select * from libro.libri;

select avg(prezzo) from libro.libri;

select count(*) from corsi.studenti;
select count(pagine) from libro.libri;

select count(genere) from corsi.studenti
where genere = 'f';

select count(data_nascita) `Senza data di nascita` from studenti 
where data_nascita is null;

select 
	max(prezzo) `Più caro`, 
	min(prezzo) `Meno caro` 
from libro.libri;

select 
	sum(prezzo) `Valore catalogo` 
from libro.libri;

select round(avg(prezzo), 2) from libro.libri;

select prezzo, floor(prezzo), ceiling(prezzo)
from libro.libri;

select cognome, length(cognome)
from corsi.studenti;

select 
	cognome, 
    nome, 
    concat(cognome,' ',nome) fullname
from corsi.studenti;

select 
	cognome, 
    nome, 
    concat_ws(', ',cognome, nome, genere) fullname
from corsi.studenti;

select cognome, substring(cognome,2,3) from studenti;

select cognome, left(cognome, 1) from studenti;

select round(avg(length(cognome) + length(nome)),2) from studenti;

-- funzioni informative
-- last_insert_id
select * from corsi;
insert into corsi(titolo, prezzo) values('sinfony', 300.00);

select last_insert_id();

select count(distinct cognome) from studenti;

select sum(distinct prezzo) from libro.libri;

select * from docenti;
insert into docenti(nome, cognome, email)
values('Gimmi', 'Ghione','gimmig@gmail.com');

insert into corsi(titolo, prezzo, docente_id) 
values('Cloud', 400.00, last_insert_id());

insert into docenti(nome, cognome, email)
values('Pippo', 'Pippa','pp@gmail.com'),
('Donald', 'Duck', 'notPK@gmail.com');

select last_insert_id();

select * from studenti;

update studenti
set email = replace(email, 'gmail.it', 'gmail.com');

select now();
select curdate();
select curtime();

select 
	data_nascita, 
    dayofweek(data_nascita),
    dayname(data_nascita)
from studenti;

select monthname('1969-10-05');
select @@lc_time_names;
set lc_time_names = 'it_IT';

select 
	cognome, 
    data_nascita, 
    date_format(data_nascita, '%d-%m-%Y') `Data ITA`
from studenti;

select time_format(curtime(), 'Sono le ore %h:%i %p');

insert into studenti(cognome, email,data_nascita)
values('Cagnasso','cgs@gmail.com',str_to_date('01-01-2002','%d-%m-%Y'));

select * from studenti;

insert into studenti(cognome, nome, email,data_nascita)
values('Rossi','Pasquale','rossipas@gmail.com',
str_to_date(concat_ws('/','05','10','1998'),'%d/%m/%Y'));

select adddate('2024-03-01', 7);
select adddate('2024-03-01', interval 1 month);
select adddate('2024-03-01', interval 1 year);
select subdate('2024-03-01', interval 1 year);

select datediff(curdate(), '2024-10-05');

select 
	cognome,
	data_nascita,
    timestampdiff(year, data_nascita, curdate()) `Età`
from studenti
order by `Età`;

desc studenti;

select 
	cognome, 
    nome,
    data_nascita,
    dayofyear(curdate())-dayofyear(data_nascita) `Quanti giorni al compleanno`
from studenti
where dayofyear(curdate())-dayofyear(data_nascita) between -7 and 0;

select 
	cognome, 
    nome,
    data_nascita,
    dayofyear(curdate())-dayofyear(data_nascita) `Quanti giorni al compleanno`
from studenti
having `Quanti giorni al compleanno` between -7 and 0;


create table if not exists articoli(
	id int auto_increment primary key,
    descrizione varchar(100),
    specifiche json
);

insert into articoli(descrizione, specifiche) 
	values(
		'Televisore Samsung 32" Smart-TV',
        '{
			"marca":"Samsung",
            "pesoKg":5.12,
            "schermo":"OLED",
            "pollici":32,
            "uscite":["hdmi","usb"]
            }'
	);
    
insert into articoli(descrizione, specifiche) 
	values(
		'Televisore Sony 32" Smart-TV',
        JSON_OBJECT(
			"marca","Sony",
			"pesoKg",5.12,
			"schermo","OLED",
			"pollici",32, 
			"uscite","hdmi"
        )
	);
insert into articoli(descrizione, specifiche) 
	values(
		'Televisore PHILIPS 55" Smart-TV',
        JSON_OBJECT(
			"marca","Philips",
			"pesoKg",9.5,
			"schermo","LED",
			"pollici",55, 
			"uscite", json_array('hdmi','rca','usb','coaxial','scart')
        )
	);

select * from articoli;

select descrizione, json_extract(specifiche, '$.uscite', '$.pesoKg')
from articoli;

select descrizione, specifiche -> '$.uscite'
from articoli;

select descrizione, specifiche -> '$.uscite[1]'
from articoli;
--
select json_extract('[10,20,[30,40]]','$[1]');
select json_extract('[10,20,[30,40]]','$[2][1]');

update articoli 
set
	descrizione = 'TV LG 32" SMART TV',
    specifiche = JSON_SET(specifiche,"$.marca","LG",
				'$.uscite', json_array("hdmi","scart", "spdif"),
                '$.ingressi', json_array("ethernet", "USB")
    )
where id = 1;

select * from articoli;

update articoli
set specifiche = json_insert(specifiche,'$.uscite[3]','RGB')
where id = 1;

update articoli
set 
	descrizione = 'TV SAMSUNG 32" SMART TV',
	specifiche = json_replace(specifiche, '$.marca', 'Samsung')
where id = 1;

update articoli
set
	specifiche = json_replace(specifiche, '$.risoluzione', '720p')
where id = 1;


update articoli
set 
	specifiche = json_replace(specifiche, '$.uscite[1]', 'hdmi2')
where id = 1;

update articoli
set specifiche = json_remove(specifiche, '$.ingressi')
where id = 1;

select * from articoli;

-- control flow function
select if(1 > 2, 'vero', 'falso');

select cognome,
if(provincia = 'to', 'in sede', 'fuori sede') Sede
from studenti
order by cognome;

select provincia,
case provincia	
	when 'to' then 'torino'
	when 'at' then 'asti'
	when 'cn' then 'cuneo'
	when 'vc' then 'vercelli'
	when 'al' then 'alessandria'
    else 'fuori zona'
end Zona
from studenti;

select titolo, prezzo,
	case
		when prezzo < 5 then 'economico'
		when prezzo >= 5 and prezzo <= 10 then 'medio'
		when prezzo > 10 then 'costoso'
	end `valutazione`
from libro.libri; 

select 
	cognome,
    data_nascita,
    case
		when year(data_nascita) <= 1980 then 'X' 
		when year(data_nascita) > 1980 
			and year(data_nascita) < 1997 then 'Millennials' 
		when year(data_nascita) >= 1997 then 'Z' 
		when year(data_nascita) is null then 'No Data' 
	end `Generazione`
from corsi.studenti
order by data_nascita;