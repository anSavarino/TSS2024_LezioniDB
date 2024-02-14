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

create table studenti_bk like studenti;
drop table studenti_bk;

create table studenti_bk like studenti;
create table studenti_bk2 like studenti;
drop table studenti_bk, studenti_bk2;

-- DML

insert into studenti(nome, citta, email)
value('oscar', 'torino', 'oscar@gmail.com');
alter table studenti modify cognome varchar(50) not null;
select * from studenti;
delete from studenti where id = 1;

insert into studenti(nome, cognome, citta, email)
value('oscar','vecchione', 'torino', 'oscar@gmail.com');

insert into studenti
set cognome = 'de rossi', nome = 'andrea', genere = 'f', email='derossi@gmail';

insert into studenti(nome, cognome, genere, email)
values('paolo','raviola','m','pr@gmail.com'),
('Maria','Luce','f','marialuce@gmail.com'),
('franco','spagnolo','m','fspagnolo@icloud.com');

alter table studenti drop eta;

insert into studenti
values(7, 'Pippo', 'Fava', 'm', 'via marche 3', 'Monza', 'mi', 'Lombardia', 'pfava@iclod.com', '1999-02-14', '2024-02-07 17:47:00');

insert into studenti
values(default,'anna','rossi','f',null,'torino',default,default,'annarossi@gmail.com',null,default);
desc studenti;

-- Creare tabella amici
create table if not exists amici(
	id int auto_increment primary key,
    nome varchar(30),
    cognome varchar(50),
    genere enum('m','f','nb')
);

-- id, nome, cognome, generestudenti
insert into amici(nome, cognome, genere) select nome, cognome, genere from studenti;

create table if not exists parenti(
	id int auto_increment primary key,
    nome varchar(30),
    cognome varchar(50),
    genere enum('m','f','nb')
)select nome, cognome, genere from studenti;

select * from parenti;

create table studenti_bk like studenti; -- conserva la struttura della tabella
insert into studenti_bk select * from studenti;

create table studenti_bk2 as select * from studenti; -- non copia la struttura della tabella
select * from studenti_bk2;

desc studenti_bk2;

-- UPDATE
select*from studenti;

update studenti set indirizzo = 'via roma 20', citta = 'torino'  where id = 3;

select @@sql_mode;

use tss2024;
update studenti set provincia = 'mi' where id = 7;

update studenti set provincia = 'to';

update studenti set data_nascita = '2024-02-09';

-- delete
delete from studenti where id = 2;
select * from studenti;

delete from studenti where provincia = 'to';

delete from studenti;

insert into studenti(cognome, email) values ('vecchio', 'vecio@gmail.com');
truncate studenti; -- drop table e ricrea

select table_name, auto_increment 
from information_schema.tables 
where table_schema = 'tss2024';

show table status like 'studenti';
select * from studenti;

truncate studenti;
select * from studenti_bk;

delete from studenti_bk;
select * from studenti_bk;
show table status like 'studenti_bk';
alter table studenti_bk auto_increment = 1;
insert into studenti_bk(cognome, email) values ('vecchio','vechio@gmail.com');

-- ORDER BY
select *
from studenti
order by cognome desc, nome desc;

-- LIMIT
SELECT 
    *
FROM
    studenti
ORDER BY cognome
LIMIT 10 , 10; -- due parametri indice di partenza e numero di record

SELECT 
    nome,
    cognome,
    genere,
    indirizzo,
    citta,
    provincia,
    regione,
    data_nascita
FROM
    studenti
WHERE
    genere = 'f'
ORDER BY cognome;

-- select -> from -> where -> order by -> limit

-- ? != <>
select * from studenti where provincia <> 'to';

select * from studenti where data_nascita < '2000-01-01';
-- and, or, not
select * from studenti where genere = 'f' and provincia = 'to';
select * from studenti where genere = 'f' or provincia = 'to';
select * from studenti where not provincia != 'to';

select * from studenti where provincia = 'to' or provincia = 'mi' or provincia = 'cn' or provincia = 'al';

select * from studenti where cognome = 'verdi' or cognome = 'rossi' and provincia = 'to';
SELECT 
    *
FROM
    studenti
WHERE
    (cognome = 'rossi'
        OR cognome = 'verdi') AND (provincia = 'to'
        OR provincia = 'al');
        
-- in, not
select * from studenti where provincia in ('mi','to','al','cn');

-- between, not between

SELECT 
    *
FROM
    studenti
WHERE
    data_nascita NOT BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY data_nascita;

select * from studenti where cognome between 'a' and 'mz' order by cognome;

-- is null, is not null

select * from studenti where data_nascita is not null;

-- like, not like
select * from studenti where cognome like 'v%' order by cognome;
select * from studenti where nome like '%a' order by nome;
select * from studenti where nome like 'pao__' order by nome;
select * from studenti where nome like '%ara%' order by nome;
select * from studenti where email like '%gmail.com' order by cognome;
select * from studenti where indirizzo like 'via %' order by cognome;

-- Regular expression
select * from studenti where nome regexp '^mar';
select * from studenti where nome regexp 'co$';
select * from studenti where nome regexp 'mar|ara|ola';
select * from studentlibrolibroi where nome regexp '^mar|ara|ola$';
select * from studenti where nome regexp '[mcp]a';
select * from studenti where nome regexp 'l[ao]$';

select * from studenti where cognome regexp '^[a-m]' order by cognome;

select titolo, prezzo, prezzo * 1.10 from libro;

select titolo, prezzo, prezzo * 1.10 from libro;
drop table libro;
desc libro;
CREATE TABLE `libro` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titolo` varchar(100) DEFAULT NULL,
  `prezzo` decimal(6,2) DEFAULT NULL,
  `prezzo_iva` decimal(6,2) as (prezzo*1.10),  -- Stored 
  `pagine` smallint DEFAULT NULL,
  `id_editore` smallint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select prezzo, prezzo_iva from libro;

insert into libro(titolo, prezzo, pagine, id_editore) values('Marcovaldo', 15, 214, 2);

desc libro;
show create table libro;

desc studenti;