-- USARE SINTASSI JOIN
-- corsi, docenti
/* 1
Seleziona cognome, nome, email dei docenti
e titolo corso che insegnano
e ordina per cognome e nome
*/
select cognome, nome, email, titolo
from docenti
inner join corsi
order by cognome, nome;

/* 2
Seleziona cognome, nome, email dei docenti
e titolo corso che costa meno di 200€(esclusi)
e ordina per cognome e nome
*/
select cognome, nome, email, titolo
from docenti d
inner join corsi c
on c.docente_id = d.id
where prezzo < 200
order by cognome, nome;

/* 3
Seleziona cognome, nome, email del docente
che insegna nel corso HTML
*/
select cognome, nome, email
from docenti d
inner join corsi c
on c.docente_id = d.id
where titolo = "HTML";

/* 4
Seleziona cognome, nome, email dei docenti, titolo corso che insegnano
e MOSTRA ANCHE I DOCENTI CHE NON HANNO CORSI ASSEGNATI (outer join)
ordina per titolo, cognome e nome
*/
select cognome, nome, email, titolo
from docenti d
left join corsi c
on c.docente_id = d.id
order by titolo, cognome, nome;

/* 5
Seleziona cognome, nome, email dei docenti, titolo corso che insegnano
e MOSTRA ANCHE I CORSI CHE NON HANNO DOCENTI ASSEGNATI (outer join)
ordina per titolo, cognome e nome
*/
select cognome, nome, email, titolo
from docenti d
right join corsi c
on c.docente_id = d.id
order by titolo, cognome, nome;

/* 6
Seleziona cognome, nome, email
SOLO DEI DOCENTI CHE NON HANNO CORSI ASSEGNATI (outer join)
ordina per cognome e nome
*/
select cognome, nome, email
from docenti d
left join corsi c
on c.docente_id = d.id
where c.docente_id is null
order by cognome, nome;

/* 7
Seleziona titolo SOLO DEI CORSI 
CHE NON HANNO DOCENTI ASSEGNATI (outer join)
ordina per titolo
*/
select titolo
from corsi c
left join docenti d
on c.docente_id = d.id
where c.docente_id is null
order by titolo;


-- studenti, corsi, iscrizioni
/* 8
Seleziona cognome, nome, email, degli studenti 
e titolo del corso a cui sono iscritti
e ordina per titolo, cognome e nome
*/
select cognome, nome, email, titolo
from studenti s
inner join iscrizioni i
on i.studente_id = s.id
inner join corsi c
on c.id = i.corso_id
order by titolo, cognome, nome;

/* 9
Seleziona cognome, nome, email, degli studenti
iscritti al corso di Java
e ordina per cognome e nome
*/
select cognome, nome, email
from studenti s
inner join iscrizioni i 
on i.studente_id = s.id
inner join corsi c 
on c.id = i.corso_id
where c.titolo = "Java";

/* 10
Seleziona cognome, nome, email, degli studenti
iscritti a corsi per i quali hanno pagato più di 200€(compresi)
e ordina per cognome e nome
*/
select cognome, nome, email
from studenti s
inner join iscrizioni i 
on i.studente_id = s.id
inner join corsi c 
on c.id = i.corso_id
where c.prezzo >= 200
order by cognome, nome;

/* 11
Seleziona cognome, nome, email, degli studenti 
e titolo del corso a cui sono iscritti
e MOSTRA ANCHE GLI STUDENTI CHE NON SONO ISCRITTI A CORSI (outer join)
e ordina per titolo, cognome e nome
*/
select cognome, nome, email, titolo
from studenti s
left join iscrizioni i
on i.studente_id = s.id
left join corsi c 
on c.id = i.corso_id
order by titolo, cognome, nome;

/* 12
Seleziona cognome, nome, email, degli studenti 
e titolo del corso a cui sono iscritti
e MOSTRA ANCHE I CORSI CHE NON HANNO ISCRITTI(outer join)
e ordina per titolo, cognome e nome
*/
select cognome, nome, email, titolo
from studenti s 
inner join iscrizioni i
on i.studente_id = s.id
right join corsi c 
on c.id = i.corso_id
order by titolo, cognome, nome;

/* 13
Seleziona cognome, nome, email
SOLO DEGLI STUDENTI CHE NON SONO ISCRITTI A CORSI (outer join)
e ordina per cognome e nome
*/
select cognome, nome, email
from studenti s
left join iscrizioni i
on i.studente_id = s.id
left join corsi c 
on c.id = i.corso_id
where i.studente_id is null
order by cognome, nome;

/* 14
Seleziona titolo del corso
SOLO PER I CORSI CHE NON HANNO ISCRITTI(outer join)
e ordina per titolo, cognome e nome
*/
select titolo
from corsi c
left join iscrizioni i
on i.corso_id = c.id
left join studenti s 
on i.studente_id = s.id
where i.corso_id is null
order by titolo, cognome, nome;