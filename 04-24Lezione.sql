-- SUBQUERY CON ANY
select 'lombardia', count(*) quanti from impiegati where ufficio_id = ANY -- = Any è alias di IN
(select id from uffici where regione = 'piemonte');

-- in
select cognome, telefono, citta
from clienti c
join ordini o
on c.id = o.cliente_id;

select cognome, telefono, citta
from clienti 
where  id IN (select cliente_id from ordini);

select cognome, telefono, citta
from clienti crossleft join ordini o
on c.id = o.cliente_id
where o.id is null;


select cognome, telefono, citta
from clienti
where id NOT IN (select cliente_id from ordini);

-- row(col1, col2, ...)

select nome, cognome from amici where id = 4;

select nome, cognome, genere,email
from studenti
where row(nome, cognome) = 
(select nome, cognome from amici where cognome = 'rossi');

-- subquery correlate
select * from articoli;
update articoli
set rimanenza = 100;

select sum(quantita)
from ordini_dettaglio
group by articolo_id;

-- uso con funzione IF
-- if(test, se vero, se falso)
update articoli a 
set rimanenza = rimanenza -
(select sum(quantita)
	from ordini_dettaglio od
    where od.articolo_id = a.id
    group by a.id
);

update articoli set rimanenza = 100 where rimanenza is null;

update articoli a
set rimanenza = if (
(select sum(quantita)
	from ordini_dettaglio od
    where od.articolo_id = a.id
    group by a.id
)>0,rimanenza - (select sum(quantita)
	from ordini_dettaglio od
    where od.articolo_id = a.id
    group by a.id
),
rimanenza); 

update articoli set rimanenza = 100;

select * from articoli;

select * from clienti;
update clienti set credito = 0;

select * from ordini;
select c.id,sum(prezzo*quantita) credito
from ordini o
join ordini_dettaglio od on o.id=od.ordine_id
join clienti c on c.id = o.cliente_id
group by c.id;

select * from clienti;

update clienti c
set credito = if(
	(select sum(prezzo*quantita)
	from ordini o
	join ordini_dettaglio od on o.id=od.ordine_id
	and c.id = o.cliente_id
	group by c.id)>0,
    (select sum(prezzo*quantita)
	from ordini o
	join ordini_dettaglio od on o.id=od.ordine_id
	and c.id = o.cliente_id
	group by c.id), 
    credito
);

-- exists, not exist (si usa nelle query correlate)
select cognome, nome
from clienti c where exists -- not exists
	(select cliente_id from ordini o where o.cliente_id = c.id);


-- subquery in FROM

select cognome,nome,titolo
from studenti s
join iscrizioni i on s.id = i.studente_id
join corsi c on c.id = i.corso_id;

select * from iscritti;
select * from (
	select cognome,nome,titolo
	from studenti s
	join iscrizioni i on s.id = i.studente_id
	join corsi c on c.id = i.corso_id
) tbl
where titolo='java';

select max(quanti),min(quanti),avg(quanti)
from(
	select sum(quantita) quanti
	from ordini_dettaglio
	group by ordine_id
)tbl;


-- indici
desc clienti;

explain
select cognome, nome, email
from clienti
where cognome = 'rossi';


drop index k_cogn on clienti;
create index k_cogn on clienti(cognome);

create index k_prov on clienti(provincia);
explain
select cognome, nome, email
from clienti use index(k_prov_credit)
where provincia = 'to';

explain
select cognome, nome, email
from clienti
where provincia = 'to'
and credito > 100;

create index k_prov_credit on clienti(provincia, credito);
create index k_credit_prov on clienti(credito, provincia);

drop index k_prov on clienti;
show index from clienti;

explain
select cognome, nome, email
from clienti use index(k_credit_prov)
where provincia = 'to'
and credito > 100;

explain format=tree
select cognome, nome, email
from clienti 
where provincia = 'to'
and credito > 100;

-- corsi
use corsi;
desc studenti;
explain
select cognome, nome, email
from studenti
where cognome = 'verdi';

create index k_cogn on studenti(cognome);