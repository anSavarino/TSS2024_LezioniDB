-- VISTE
-- VIEWS sono delle querry memorizzate 

create or replace view studenti_info as 
select cognome, nome, email
from studenti ;

show tables;

-- mostrami tutti i conttati degli studenti
select * from 
(select cognome, nome, email 
from studenti) test;

select cognome, nome, titolo
from studenti s join iscrizioni i on s.id = i.studente_id
join corsi c on c.id = i.corso_id
order by titolo;

select titolo, count(*)
from studenti s join iscrizioni i on s.id = i.studente_id
join corsi c on c.id = i.corso_id
order by titolo;

create or replace view iscritti as 
select cognome, nome, titolo
from studenti s
join iscrizioni i on s.id = i.studente_id
join corsi c on c.id = i.corso_id
order by titolo;

select *
from iscritti
where titolo = 'java';

create or replace view studenti_v as
select cognome, nome, genere, email from studenti;

alter table studenti rename column genere to gen;

select cognome, nome, genere, email from studenti_v;

alter table stud rename to studenti;

select * from studente_info;

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

select * from stud_ok;

update stud_ok
set nome= 'carlo', genere ='m', indirizzo = 'via po 3', citta = 'torino'
where cognome = 'cagnasso';

select * from studenti;

insert into stud_ok(cognome, nome, email)
values('vecchionsis', 'numero uno','vecchionis@gmail.com');

select * from stud_ok;

-- check option
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
from studenti
where provincia = 'to'
with check option;

-- Tabella Temporanea
-- rimangono solo il tempo di una sessione e poi si cancellano

create temporary table studenti_giovani
select cognome, nome, genere, timestampdiff(year, data_nascita,curdate())eta
from studenti where timestampdiff(year, data_nascita,curdate()) <= 30;
show tables;

select* from studenti_giovani where genere = 'f';







