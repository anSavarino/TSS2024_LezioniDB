-- SELF JOIN
-- creare tabella 'impiegati' con i seguenti attributi:
-- nome, cognome, ruolo, id_resp, stipendio
-- i record li passo io
CREATE TABLE IF NOT EXISTS impiegati (
  id int auto_increment,
  nome varchar(50),
  cognome varchar(50),
  ruolo varchar(50),
  id_responsabile int,
  stipendio decimal(6,2),
  FOREIGN KEY impiegati(id_responsabile) REFERENCES impiegati(id)
  ON UPDATE CASCADE
  ON DELETE NO ACTION,
  PRIMARY KEY(id)
);

-- ATTENZIONE per poter caricare i dati blocco temporaneamente
-- il controllo di chiave esterna
set foreign_key_checks = 0;

INSERT INTO `impiegati`
VALUES (1,'Mario','Rossi','tecnico',NULL,2500.00),
(2,'Marco','Bianchi','amministrativo',7,1600.00),
(3,'Paolo','Verdi','amministrativo',7,1600.00),
(4,'Enrico','Marrone','venditore',8,1300.00),
(5,'Nicola','Testa','venditore',8,1300.00),
(6,'Franco','Barba','tecnico',1,1500.00),
(7,'Elena','Totti','amministrativo',NULL,2600.00),
(8,'Paola','Capra','venditore',NULL,2300.00),
(9,'Mauro','Barba','venditore',8,1300.00);

-- ripristino il controllo di chiave esterna
set foreign_key_checks = 1;