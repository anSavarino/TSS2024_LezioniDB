-- no action (default)
alter table corsi add constraint fk_corsi_docenti foreign key(docente_id) references docenti(id);
-- on delete no action on update cascade;
select * from corsi;

show create table corsi;

delete from docenti where id = 9;

select * from docenti;

alter table iscrizioni add constraint fk_iscrizioni_corsi foreign key(corso_id) references corsi(id),
add constraint fk_iscrizioni_studenti foreign key(studente_id) references studenti(id);

show create table iscrizioni;

select * from iscrizioni;
select * from corsi
;
delete from corsi where id = 9;

delete from studenti where id = 50;

alter table corsi drop foreign key fk_corsi_docenti;
alter table iscrizioni drop foreign key fk_iscrizioni_corsi;
alter table iscrizioni drop foreign key fk_iscrizioni_studenti;
show create table corsi;
alter table corsi drop index fk_corsi_docenti;
alter table iscrizioni drop index fk_iscrizioni_corsi;
alter table iscrizioni drop index fk_iscrizioni_studenti;

-- cascade
alter table corsi
add constraint fk_corsi_docenti
foreign key (docente_id) references docenti(id)
on update cascade on delete cascade;
-- tabella iscrizioni
alter table iscrizioni 
add constraint fk_iscrizioni_corsi 
foreign key(corso_id) references corsi(id)
on update cascade on delete cascade,
add constraint fk_iscrizioni_studenti 
foreign key(studente_id) references studenti(id)
on update cascade on delete cascade;

select * from iscrizioni;
select *from corsi;

delete from docenti where id = 1;
select * from docenti;

-- set null
alter table corsi 
add constraint fk_corsi_docenti
foreign key(docente_id) references docenti(id)
on update cascade on delete set null;

desc corsi;

select * from docenti;
select * from corsi;
