/* 1
Seleziona cognome, nome, email dei docenti
e titolo corso che insegnano
e ordina per cognome e nome
*/
SELECT 
    cognome, nome, email, titolo
FROM
    docenti,
    corsi
WHERE
    docenti.id = corsi.docente_id
ORDER BY cognome , nome; 

/* 2
Seleziona cognome, nome, email dei docenti
e titolo corso che costa meno di 200€(esclusi)
e ordina per cognome e nome
*/
SELECT 
    cognome, nome, email, titolo
FROM
    docenti,
    corsi
WHERE
    corsi.prezzo < 200
ORDER BY cognome , nome;

/* 3
Seleziona cognome, nome, email del docente
che insegna nel corso HTML
*/
SELECT 
    cognome, nome, email
FROM
    docenti,
    corsi
WHERE
    docenti.id = corsi.docente_id
        AND corsi.titolo = 'HTML'; 

/* 4
Seleziona titolo corso/i insegnati dal docente il cui cognome è Verdi
e ordina per titolo corsi
*/
SELECT 
    titolo, cognome
FROM
    corsi,
    docenti
WHERE
    docenti.id = corsi.docente_id
        AND docenti.cognome = 'Verdi'
ORDER BY titolo;

/* 5
Seleziona cognome, nome, email del/dei docente/i
che insegnano nei corsi il cui titolo comincia per 'Introduzione'
e ordina per titolo, cognome e nome
*/
SELECT 
    cognome, nome, email
FROM
    docenti,
    corsi
WHERE
    docenti.id = corsi.docente_id
        AND corsi.titolo REGEXP '^Introduzione'
ORDER BY titolo , cognome , nome;

/* 6
Seleziona cognome, nome, email, degli studenti 
e titolo del corso a cui sono iscritti
e ordina per cognome e nome
*/
SELECT 
    cognome, nome, email, titolo
FROM
    studenti,
    iscrizioni,
    corsi
WHERE
    (studenti.id = iscrizioni.studente_id)
        AND (corsi.id = corso_id)
ORDER BY cognome , nome;

/* 7
Seleziona cognome, nome, email, degli studenti FEMMINA
e titolo corso a cui sono iscritte
e ordina per cognome e nome
*/
SELECT 
    cognome, nome, email, titolo
FROM
    studenti,
    iscrizioni,
    corsi
WHERE
    (studenti.id = iscrizioni.studente_id)
        AND (corsi.id = corso_id)
        AND genere = 'f'
ORDER BY cognome , nome;

/* 8
Seleziona cognome, nome, email, degli studenti
iscritti al corso di Java
e ordina per cognome e nome
*/
SELECT 
    cognome, nome, email
FROM
    studenti,
    corsi,
    iscrizioni
WHERE
    (studenti.id = iscrizioni.studente_id)
        AND (corsi.id = corso_id)
        AND titolo = 'Java'
ORDER BY cognome , nome;

/* 9
Seleziona cognome, nome, email, degli studenti MASCHI
iscritti al corso di Basi di dati
e ordina per cognome e nome
*/
SELECT 
    cognome, nome, email
FROM
    studenti,
    corsi,
    iscrizioni
WHERE
    (studenti.id = iscrizioni.studente_id)
        AND (corsi.id = corso_id)
        AND titolo = 'Basi di dati'
        AND genere = 'm'
ORDER BY cognome , nome;

/* 10
Seleziona cognome, nome, email, degli studenti
iscritti a corsi per i quali hanno pagato più di 200€(compresi)
e ordina per cognome e nome
*/
SELECT 
    cognome, nome, email, titolo, iscrizioni.prezzo
FROM
    studenti,
    corsi,
    iscrizioni
WHERE
    (studenti.id = iscrizioni.studente_id)
        AND (corsi.id = corso_id
        AND corsi.prezzo >= 200)
ORDER BY cognome , nome;