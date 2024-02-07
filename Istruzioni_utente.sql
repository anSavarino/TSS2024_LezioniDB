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