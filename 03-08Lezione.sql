-- raggruppamenti 
select distinct cognome from studenti;
select cognome 
	from studenti 
		where cognome like 'v%'
		group by cognome; -- stessa cosa della distinct
        
-- sum(), avg(), count(), min(), max()
select count(*) from studenti;

select genere, count(genere) quanti 
from studenti
group by genere;

select cognome, count(*) 
from studenti 
group by cognome;

select cognome, count(*)
from corsi c
join docenti d on c.docente_id = d.id
group by c.docente_id; 

select 
	genere,
    floor(avg(timestampdiff(year, data_nascita, curdate()))) `Età media`
from studenti
where genere is not null
group by genere;

select titolo Corso, count(*) Quanti, sum(i.prezzo) Valore
from iscrizioni i
join corsi c on c.id = i.corso_id
group by i.corso_id;

select 
	nome,
	count(*) quanti,
    sum(prezzo) somma,
    round(avg(prezzo), 2) media,
    min(prezzo) economico,
    max(prezzo) caro
from editori
join libri using (editore_id)
group by nome
order by nome;

select provincia, genere, count(*)
from studenti
group by provincia, genere
order by provincia;

-- having 
select cognome, count(*) quanti
from studenti
group by cognome
having quanti > 1; -- dopo group  by

select genere, count(genere) `Quanti a Torino`
from studenti
where provincia = 'to'
group by genere;

-- select-->from-->where-->group by-->having-->order by-->limit
-- il motore: from, join --> where --> group by-->having-->select

-- istruzione no SQL: ROLLUP
select provincia, genere, count(*)
from studenti
group by provincia, genere with rollup
order by provincia;

-- grouping()
select provincia, genere, count(*), grouping(genere), grouping(provincia)
from studenti
group by provincia, genere with rollup
order by provincia;

select 
	if(grouping(provincia),"tutte le province", provincia),  
    if(grouping(genere),"tot genere", genere),  
    count(*)
from studenti
group by provincia, genere with rollup
order by provincia;

use tss2024;
select 
	nome,
    cognome, 
    round(avg(stipendio) over(), 2) `Stipendio Medio`
from impiegati
order by stipendio desc;

select 
	nome,
    cognome, 
    round(avg(stipendio) over(), 2) `Stipendio Medio`,
    stipendio - round(avg(stipendio) over(), 2) differenza
from impiegati
order by stipendio desc;

select * from impiegati;
alter table impiegati add ufficio_id int;
update impiegati set ufficio_id = 2
where id = 2 or id = 3 or id = 7 ;
update impiegati set ufficio_id = 1
where id = 1 or id = 6;
update impiegati set ufficio_id = 3
where ufficio_id is null;

select 
	nome,
    cognome, 
    ufficio_id,
    round(avg(stipendio) over(
    partition by ufficio_id
    ), 2) `Stipendio Medio`,
    stipendio - round(avg(stipendio) over(), 2) differenza
from impiegati
order by ufficio_id desc;

create table vendite(
	id int auto_increment,
    impiegato_id int,
    anno year,
    vendita decimal(14,2),
    primary key(id)
);

insert into vendite(impiegato_id,anno, vendita)
values(9, '2016', 100.00),
	  (9, '2017', 150.00),
	  (9, '2018', 200.00),
	  (4, '2016', 150.00),
	  (4, '2017', 100.00),
	  (4, '2018', 200.00),
	  (5, '2016', 200.00),
	  (5, '2017', 150.00),
	  (5, '2018', 250.00);
      
select 
	anno, 
    nome,
    cognome,
    vendita,
    sum(vendita) over(partition by anno) `Vendite totali`
from vendite v
join impiegati i on v.impiegato_id = i.id;

select sum(vendita) from vendite;

select anno, sum(vendita) from vendite group by anno order by anno;

select 
	anno,
	impiegato_id,
    vendita,
    sum(vendita) over(
    partition by anno
    order by impiegato_id
    rows 2 preceding
    ) vendite_totali -- righe prese in considerazione per effettuare il calcolo dell'over
from vendite
order by anno;

-- lag
select 
	anno,
    cognome,
    nome,
    vendita,
    lag(vendita, 1, 0) over(
    partition by impiegato_id
    order by anno
    ) anno_precedente
from vendite v
join impiegati i
on i.id = v.impiegato_id;

-- lead
select 
	anno,
    cognome,
    nome,
    vendita,
    lead(vendita) over(
    partition by impiegato_id
    order by anno
    ) anno_successivo
from vendite v
join impiegati i
on i.id = v.impiegato_id;

create table straordinari(
	id int auto_increment primary key,
    impiegato_id int,
    ufficio_id int,
    ore int
    );
    
insert into straordinari(impiegato_id, ufficio_id, ore)
values 
	(1,1,37),
    (6,1,74),
    (2,2,58),
    (3,2,47),
    (7,2,66),
    (4,3,90),
	(5,3,88),
    (8,3,81),
    (9,3,29);
		
select * from straordinari order by ufficio_id;

select
	cognome,
    nome,
    s.ufficio_id,
    ore,
    first_value(i.cognome) over(
		partition by s.ufficio_id
        order by ore
	) meno_srtaordinari
from straordinari s
join impiegati i 
on s.impiegato_id = i.id;