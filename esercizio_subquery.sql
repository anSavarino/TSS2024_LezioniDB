-- SUBQUERY
-- Scrivete le query richieste usando le subquery
-- DB libri
-- 01) selezionate titolo, prezzo dei libri editi da "Einaudi"
use libro;
select titolo, prezzo
from libri where libri.editore_id = (
select editore_id from editori where nome = 'Einaudi');

-- DB gestionale
-- 02) Selezionate cognome, nome, email del cliente che ha eseguito l’ultimo ordine
-- aiuto: join + subquery
use gestionale;
select cognome, nome, email 
from clienti c
join ordini o on c.id = o.cliente_id where o.id = (select max(id)  from ordini);


-- 03) Selezionate nome, cognome, ruolo degli impiegati che lavorano nella città di Milano
select nome,cognome, ruolo
from impiegati i
where ufficio_id in (
	select id from uffici where citta = 'Milano'
); 

-- DB corsi
-- 04) contate gli studenti non iscritti
use corsi;
select count(id) Non_Iscritti
from iscrizioni where not exists (
	select studente_id from iscrizioni);

-- DB tss_2024
-- 05) Selezionate nome, cognome, genere, indirizzo, citta, provincia, regione 
-- dello/della studente/ssa presente nella tabella amici
-- aiuto: 2 subquery nidificate
use tss2024;
select nome,cognome, genere,indirizzo,citta,provincia,regione
from studenti
where row(nome, cognome) = 
(select nome, cognome from amici where id = (select id from amici where nome = 'sara' and cognome = 'rossi'));


-- 06) selezionate le capitali che cominciano per "R"
-- aiuto: ricordatevi che avete tre tabelle relative ai tre contineti: africa, americhe ed europa
select capitale from africa where capitale like 'R%'
union all
select capitale from americhe where capitale like 'R%' 
union all
select capitale from europa where capitale like 'R%';

-- DB gestionale
-- 07) aggiornate il credito dei clienti sulla base di quanto hanno speso
-- il valore del credito è un intero che corrisponde alla cifra spesa in totale dal cliente
use gestionale;
update clienti c set credito = (
	select sum(prezzo*quantita)
	from ordini o
	join ordini_dettaglio od on o.id=od.ordine_id
	and c.id = o.cliente_id
	group by c.id);
select * from clienti;
-- da fare 4