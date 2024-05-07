desc libri;

show status like 'last_query_cost';

explain
select titolo, prezzo, genere
from libri
where titolo like 'La%'
order by titolo desc;

drop index k_titolo on libri;
create index k_titolo on libri (titolo desc);

show index in libri;

analyze table libri;

-- index full text
create fulltext index kft_titolo_testo on posts(titolo, testo);
-- in natural language mode
select *
from posts
where match(titolo, testo) against('react redux' in natural language mode);

select *, match(titolo, testo) against('react redux' in natural language mode) peso
from posts;

select *, match(titolo, testo) against('react redux') peso
from posts
where match(titolo, testo) against('react redux');
-- "" cercare una frase
select *, match(titolo, testo) against('"gestione dello stato è un problema"') peso
from posts
where match(titolo, testo) against('"gestione dello stato è un problema"');

-- in boolean mode
select *, match(titolo, testo) against('react -redux' in boolean mode) peso
from posts
where match(titolo, testo) against('react -redux' in boolean mode);

select *, match(titolo, testo) against('react -redux +stato' in boolean mode) peso
from posts
where match(titolo, testo) against('react -redux +stato' in boolean mode);

use java;
explain
select * from province
order by totale desc;

create index k_totale on province(totale desc);
create index k_regione on province(regione);

explain
select regione, sum(totale) 
from province
where regione = "Sicilia";

desc province;

-- TRANSACTION
show variables like 'autocommit';

set autocommit = 0;

use corsi;

delete from iscrizioni;
-- chiudo e riapro workbench
select * from iscrizioni;
-- uso commit per salvare i dati

use gestionale;
select * from clienti; -- 1

start transaction;
-- istruzioni
insert into ordini(cliente_id, `data`, consegna)
values(1, '2024-05-07', 'da spedire');

insert into ordini_dettaglio(ordine_id, articolo_id, quantita, prezzo)
values(last_insert_id(), 9, 10, 120.00);

rollback; -- annullamento
commit; -- conferma
select * from ordini;

-- livelli di isolamento
show variables like 'transaction_isolation';

set transaction isolation level read uncommitted;
set session transaction isolation level read uncommitted;
set global transaction isolation level read uncommitted;

-- letture sporche
set transaction isolation level read uncommitted;
start transaction;
-- select * from clienti;
update clienti 
set credito =200
where id = 1;
rollback;

-- letture ripetute
set transaction isolation level read committed;
start transaction;
select credito from clienti where id = 1;
rollback;

select * from clienti;
-- letture fantasma
start transaction;
select * from clienti where provincia = 'to';
rollback;

set transaction isolation level serializable;
start transaction;
select * from clienti where provincia = 'mi';
update clienti set provincia = 'to' where id = 1;
commit;

-- savepoint
select * from clienti;
select * from ordini;

start transaction;
insert into clienti(nome, cognome, email, indirizzo, citta, provincia, regione)
values('Giuseppe', 'Daniele', 'giuseppe.daniele@gmail.com', 'Via Sanita 10', 'Napoli', 'na', 'Campania');

savepoint registration;

insert into ordini(cliente_id, `data`, consegna)
values(last_insert_id(), '2024-05-07', 'da spedire');

insert into ordini_dettaglio(ordine_id, articolo_id, quantita, prezzo)
values(last_insert_id(), 9, 5, 120.00);

rollback to savepoint registration;
commit;

select * from clienti;
select * from ordini_dettaglio;
