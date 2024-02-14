use corsi;
create table if not exists docenti(
id int primary key auto_increment,
nome varchar(50) not null,
cognome varchar(50) not null,
email varchar(100) unique not null 
);

create table if not exists corsi(
id int primary key auto_increment,
titolo varchar(100) not null,
prezzo decimal(6,2),
docente_id int
);

create table if not exists iscrizioni(
id int primary key auto_increment,
studente_id int not null,
corso_id int not null,
prezzo decimal(6,2),
data_isc timestamp not null default current_timestamp
);

create table corsi.studenti like tss2024.studenti;

select * from studenti;
select * from corsi;
select * from docenti;

select cognome, nome, titolo, docenti.id, corsi.docente_id
from docenti, corsi
where docenti.id = corsi.docente_id
order by cognome;

select nome, cognome, titolo 
from studenti, corsi, iscrizioni
where iscrizioni.studente_id = studenti.id 
and iscrizioni.corso_id = corsi.id
order by cognome; 

select s.nome `Nome Studente`, s.cognome `Cognome Studente`, titolo `Corso`, d.cognome `Docente` 
from studenti s, corsi c, iscrizioni i, docenti d
where i.studente_id = s.id 
and i.corso_id = c.id
and d.id = c.docente_id
order by s.cognome; 