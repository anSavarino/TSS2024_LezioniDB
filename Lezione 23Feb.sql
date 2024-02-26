-- id, nome,cognome,ruolo, id_responsabile, stipendi

create table if not exists impiegati(
	id int auto_increment,
    nome varchar(30),
    cognome varchar(50),
    ruolo varchar(50),
	id_responsabile int,
    stipendio decimal(6,2),
    primary key(id),
    constraint fk_impiegati_self
    foreign key(id_responsabile) references impiegati(id)
    on update cascade 
    on delete set null
);

show create table impiegati;

select table_name, column_name, constraint_name, referenced_table_name, referenced_column_name
from information_schema.key_column_usage
where table_schema = 'corsi'
and referenced_column_name is not null;

truncate docenti;
truncate corsi;
truncate studenti;
truncate iscrizioni;

select @@foreign_key_checks;
set foreign_key_checks = 1;

alter table studenti
add eta tinytext check(eta>=18)
after data_nascita;
desc studenti;
show create table studenti;

alter table studenti add check(eta>=18);
alter table studenti drop constraint studenti_chk_2;

select * from studenti;
update studenti
set eta = 18 
where id = 1;

-- aggiungere check con espressione con prezzo > 0

alter table libri add check(prezzo>0);
show create table libri;
insert into libri(titolo, prezzo, pagine, editore_id) values ('fratelli kamazov',10.50,'1000',3);
select * from libri;

-- union
select cognome, titolo
from corsi, docenti
where corsi.docente_id = docenti.id
order by cognome;

select cognome, data_nascita, 'X' Generazione
from studenti
where data_nascita <= '1980-12-31'
union all
select cognome, data_nascita, 'Millennials' Generazione
from studenti
where data_nascita between '1981-01-01' and '1996-12-31'
union all
select cognome, data_nascita, 'Z' Generazione
from studenti
where data_nascita >= '1997-01-01'
order by data_nascita;

select stato, capitale
from africa
union all
select stato, capitale
from americhe
union all
select stato, capitale
from europa
order by stato;

-- Intersect, except

select id from docenti
intersect
select docente_id from corsi;

select id from docenti
except
select docente_id from corsi;

select corso_id from corsi
except
select id from docenti;

select * from corsi;

-- equijoin o join semplice
select cognome, titolo
from corsi, docenti
where corsi.docente_id = docenti.id
order by cognome;

select cognome, titolo
from corsi
inner join docenti
on corsi.docente_id = docenti.id
order by cognome;

select cognome,titolo
from studenti, iscrizioni, corsi
where studenti.id = iscrizioni.studente_id
and corsi.id = iscrizioni.corso_id
order by titolo, cognome;

select cognome,nome,titolo
from studenti
inner join iscrizioni
on studenti.id = iscrizioni.studente_id
inner join corsi
on corsi.id = iscrizioni.corso_id
order by titolo, cognome;

-- left join
select cognome, titolo
from docenti
left join corsi
on corsi.docente_id = docenti.id
order by cognome;
-- right join
select cognome, titolo
from docenti
right join corsi
on corsi.docente_id = docenti.id
order by cognome; 

select cognome, titolo
from docenti
left join corsi
on corsi.docente_id = docenti.id
where docente_id is null
order by cognome;

select cognome, titolo
from docenti
right join corsi
on corsi.docente_id = docenti.id
where docenti.id is null
order by cognome; 

-- ISCRIZIONI

select cognome,nome, titolo
from studenti
left join iscrizioni
on studenti.id = iscrizioni.studente_id
left join corsi
on corsi.id = iscrizioni.corso_id
order by titolo, cognome;

select cognome,nome, titolo
from studenti
right join iscrizioni
on studenti.id = iscrizioni.studente_id
right join corsi
on corsi.id = iscrizioni.corso_id
order by titolo, cognome;

select cognome,nome, titolo
from studenti
left join iscrizioni
on studenti.id = iscrizioni.studente_id
left join corsi
on corsi.id = iscrizioni.corso_id
where corsi.id is null
order by titolo, cognome;

select cognome,nome, titolo
from studenti
right join iscrizioni
on studenti.id = iscrizioni.studente_id
right join corsi
on corsi.id = iscrizioni.corso_id
where studenti.id is null
order by titolo, cognome;


-- full outer join
select cognome,nome, titolo
from studenti
left join iscrizioni
on studenti.id = iscrizioni.studente_id
left join corsi
on corsi.id = iscrizioni.corso_id
where corsi.id is null
union all
select cognome,nome, titolo
from studenti
right join iscrizioni
on studenti.id = iscrizioni.studente_id
right join corsi
on corsi.id = iscrizioni.corso_id
where studenti.id is null
order by titolo, cognome;


-- elenco libri e relativo editore
select titolo, nome
from libri
inner join editori
on libri.editore_id = editori.editore_id
order by titolo;

select titolo, nome, cognome 
from libri 
inner join autori_libri
on libri.libro_id = autori_libri.libro_id
inner join autori
on autori.autore_id = autori_libri. autore_id
order by cognome;

-- editori per i quali non ci sono libri a catalogo
select nome
from libri
right join editori 
on libri.editore_id = editori.editore_id
where libri.editore_id is null
order by nome;

select titolo, nome
from libri
inner join editori
-- on libri.editore_id = editori.editore_id;
using (editore_id);

select * from impiegati;

-- self join

select i.cognome, i.nome, r.cognome Capo, r.nome
from impiegati i
left join impiegati r 
on i.id_responsabile = r.id
order by Capo;
