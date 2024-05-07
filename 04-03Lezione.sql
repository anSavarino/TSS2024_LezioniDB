select * from corsi;

select * from autore;
select * from editore;
select * from libro;

create table if not exists biblioteca(
	id int auto_increment primary key,
    autore varchar(100),
    titolo varchar(100),
    editore varchar(50),
    classificazione varchar(30)
);

select * from biblioteca;

select libro.titolo, b.autore, a.id from libro
left join biblioteca b on b.titolo = libro.titolo
left join autore a on b.autore = a.nome;

select b.autore, a.id from biblioteca b
join autore a on b.autore = a.nome;

update libro
set autore_id = (
	select distinct a.id from biblioteca b 
	left join autore a on b.autore = a.nome
     where b.titolo = libro.titolo
);

select * from libro;

-- -----assenza
use gestionale;

CREATE TABLE IF NOT EXISTS uffici (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    tel VARCHAR(50),
    indirizzo VARCHAR(100),
    citta VARCHAR(100),
    regione VARCHAR(50)
);

create table if not exists clienti(
id int auto_increment primary key,
nome varchar(50),
cognome varchar(100),
telefono varchar(15),
email varchar (100),
indirizzo varchar(100),
citta varchar(100),
provincia char(2),
regione varchar(50),
credito int default '0',
unique key (email)
);

create table if not exists impiegati(
id int auto_increment primary key,
nome varchar(50),
cognome varchar(50),
ruolo varchar(100),
rif_to int,
stipendio decimal(6,2),
ufficio_id int
);

create table if not exists ordini(
id int auto_increment primary key,
cliente_id int,
data date,
consegna enum('consegnato','da spedire','spedito')
);
drop table ordini;

create table if not exists articoli(
id int auto_increment primary key,
descrizione varchar(255),
prezzo decimal(6,2),
categoria enum ('hardware','software'),
rimanenza tinyint unsigned
);

create table if not exists ordini_dettaglio(
ordine_id int,
articolo_id int,
quantita tinyint unsigned,
prezzo decimal(6,2),
primary key (ordine_id, articolo_id)
); 
drop table ordini_dettaglio;


select cognome, o.id
from clienti c
join ordini o on c.id = o.cliente_id
order by cognome;

select cognome, i.nome, u.nome
from impiegati i
join ufficci u
on i.ufficio_id = u.id
order by u.nome;

select descrizione, categoria, ordine_id
from articoli a
join ordini_dettaglio od on a.id = od.articolo_id

where ordine_id = 5
order by ordine_id;

select * from impiegati;

select stipendio from impiegati where id = 6;

select * from impiegati
where stipendio > (select stipendio from impiegati where id = 6)
order by cognome;

-- per avere lo stipendio medio
select nome, cognome, stipendio
from impiegati
where stipendio < (select avg(stipendio) from impiegati)
order by cognome;

