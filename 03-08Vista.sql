-- VISTE
create or replace view studenti_info as
select cognome, nome, email
from studenti;

show tables;

select * from studenti_info;

select cognome, nome, titolo
from studenti s
join iscrizioni i on s.id = i.studente_id
join corsi c on c.id = i.corso_id
order by titolo; 

select titolo, count(*)
from studenti s
join iscrizioni i on s.id = i.studente_id
join corsi c on c.id = i.corso_id
group by titolo
order by titolo;

create or replace view iscritti as
select cognome, nome, titolo
from studenti s
join iscrizioni i on s.id = i.studente_id
join corsi c on c.id = i.corso_id
order by titolo;  

select titolo, count(*)
from iscritti
where titolo = "java"
group by titolo;

select * 
from iscritti where titolo = "java";

create or replace view studenti_v as
select cognome, nome, genere, email from studenti;

select * from studenti;
select * from studenti_v;
alter table studenti rename column gen to genere;

create or replace view studenti_v as 
select cognome, nome, gen genere, email from studenti_v;

alter table studenti rename to stud;

create or replace view stud_ok as
select 
	nome, 
    cognome,
    genere,
    indirizzo,
    citta,
    provincia,
    regione,
    email,
    data_nascita
from studenti;
-- stud ok èuna vista semplice perciò posso fare update ed insert
select * from stud_ok;

update stud_ok 
set nome = "carlo", genere = "m", indirizzo = "Via po 3", citta = "torino", provincia = "to", regione = "Piemonte"
where cognome = "riva";

insert into stud_ok(cognome, nome, email)
values('vecchionis', 'numero uno', 'vecchinis@gmail.com');

select * from stud_ok;

create or replace view stud_to as
select 
	nome, 
    cognome,
    genere,
    indirizzo,
    citta,
    provincia,
    regione,
    email,
    data_nascita
from studenti
where provincia = "to"
with check option; -- non permette insert con altre province

select table_name, table_type
from information_schema.tables
where table_schema = "corsi"
order by table_name;

-- Tabelle temporanee 
create temporary table studenti_giovani
select cognome, nome, genere, timestampdiff(year, data_nascita, curdate()) eta
from studenti where timestampdiff(year, data_nascita, curdate()) <= 30; 

show tables;
select * from studenti_giovani where genere = "f";

create temporary table generazioni
SELECT
cognome,
data_nascita `Data di nascita`,
CASE WHEN year(data_nascita) <= '1980' THEN 'X'
WHEN year(data_nascita) > '1980'
AND year(data_nascita) < '1997' THEN 'millenials'
WHEN year(data_nascita) >= '1997' THEN 'Z'
WHEN year(data_nascita) IS NULL THEN 'Manca data nascita'
END Generazione
FROM studenti
ORDER BY Generazione;

select * from generazioni where Generazione = "millenials";
