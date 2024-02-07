show grants for current_user;

-- nome, cognome, genere, indirizzo, citta, provincia, regione, email, data nascita,
use tss2024;
create table if not exists studenti(
	id int auto_increment primary key, 
    nome varchar(30),
    cognome varchar(30) not null,
    genere enum('m','f','nb'),
    indirizzo varchar(100),
    citta varchar(30),
    provincia char(2) default 'pa',
    regione varchar(20) default 'sicilia',
    email varchar(100) not null unique, 
    data_nascita date,
    ins timestamp default current_timestamp on update current_timestamp
    -- primary key(id)
);
-- istruzioni informative
show tables;
show create table studenti;
desc studenti;
show full columns from studenti;

-- istruzioni di modifica
alter table studenti rename to studente;
rename table studente to studenti;

alter table studenti modify cognome varchar(30) comment 'indice';
alter table studenti comment 'anagrafica';

alter table studenti
modify cognome varchar(50);
desc studenti;

alter table studenti
change nome nomes varchar(40);

alter table studenti
rename column nomes to nome;

alter table studenti
add eta tinyint unsigned;

alter table studenti 
modify eta tinyint after data_nascita;
desc studenti;

alter table studenti
drop eta;

alter table studenti
add nazionalita char(3) first;

alter table studenti
modify nome varchar(30), add eta tinyint after data_nascita, drop nazionalita;

