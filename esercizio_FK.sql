-- STEP 1
-- Creare database libro
-- assegnare i privilegi all'utente app_tss
-- esegiure lo script di creazione tabelle e popolamento dei record fornito su classroom

create database if not exists libro;
grant all on libro.* to 'app_tss'@'localhost';

-- STEP 2
-- individuare le FOREIGN KEY
-- aggiungere le FOREIGN KEY in modo che:
-- quando voglio eliminare un editore se ci sono righe della tabella libri che lo contengono blocco l'operazione
-- se aggiorno l'identifcativo dell'editore aggiorno le chiavi esterne corrispondenti nella tabella libri

select table_name, column_name, constraint_name, referenced_table_name, referenced_column_name
from information_schema.key_column_usage
where table_schema = 'libro'
and referenced_column_name is not null;

alter table libri 
add constraint fk_libri_editori
foreign key(editore_id) references editori(editore_id)
on update cascade on delete no action;

-- quando voglio eliminare un libro se ci sono righe della tabella autori_libri che lo contengono elimino a cascata
-- se aggiorno l'identifcativo del libro aggiorno le chiavi esterne corrispondenti nella tabella autore_libri
-- quando voglio eliminare un autore se ci sono righe della tabella autori_libro che lo contengono blocco l'operazione
-- se aggiorno l'identifcativo dell'autore aggiorno le chiavi esterne corrispondenti nella tabella autore_libri
-- scrivere di seguito l'SQL

alter table autori_libri
add constraint fk_autoriL_libri
foreign key(libro_id) references libri(libro_id)
on delete cascade on update cascade;

alter table autori_libri
add constraint fk_autoriL_autori
foreign key(autore_id) references autori(autore_id)
on delete no action on update cascade; 

-- provate ad eliminare un editore per il quale ci sono libri a catalogo (esiste editore_id in tabella libri)
-- provate con editore_id = 1
delete from editori where editore_id = 1;
-- se avete implementato correttamente le foreign key l'operazione viene bloccata

-- se proprio volete eliminare quell'editore devo eliminare prima i record figli nella tabella libri
-- eliminate i record con editore_id = 1 dalla tabella libri
delete from libri where editore_id = 1;

-- provate ad eleiminare un editore per il quale NON ci sono libri a catalogo (NON esiste editore_id in tabella libri)
-- provate con editore_id = 11
delete from editori where editore_id = 11;
-- il record viene eliminato

-- provate ad eliminare un libro a cui sono asssociati gli autori
-- provate con libro_id = 14
delete from libri where libro_id = 14;
-- il record viene eliminato e a cascata vengono eliminate le righe nella tabella autori_libri che contengono libro_id eliminato

-- provate ad eliminare un autore a cui sono asssociati dei libri
-- provate con autore_id = 15
delete from autore where autore_id = 15;
-- se avete implementato correttamente le foreign key l'operazione viene bloccata
