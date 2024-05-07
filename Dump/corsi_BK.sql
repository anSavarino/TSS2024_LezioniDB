-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: corsi
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `corsi`
--

DROP TABLE IF EXISTS `corsi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `corsi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titolo` varchar(100) NOT NULL,
  `prezzo` decimal(6,2) DEFAULT NULL,
  `docente_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_corsi_docenti` (`docente_id`),
  CONSTRAINT `fk_corsi_docenti` FOREIGN KEY (`docente_id`) REFERENCES `docenti` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corsi`
--

LOCK TABLES `corsi` WRITE;
/*!40000 ALTER TABLE `corsi` DISABLE KEYS */;
INSERT INTO `corsi` VALUES (1,'Introduzione alla programmazione',200.00,1),(2,'Basi di dati',150.00,2),(3,'java',250.00,1),(4,'CSS',150.00,5),(5,'HTML',120.00,5),(6,'Wordpress',100.00,6),(7,'PHP',220.00,1),(8,'React',250.00,7),(9,'Angular',250.00,NULL),(10,'Introduzione UI/UX',180.00,5);
/*!40000 ALTER TABLE `corsi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `docenti`
--

DROP TABLE IF EXISTS `docenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docenti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `docenti`
--

LOCK TABLES `docenti` WRITE;
/*!40000 ALTER TABLE `docenti` DISABLE KEYS */;
INSERT INTO `docenti` VALUES (1,'Paolo','Verdi','paolo.verdi@email.com'),(2,'Maria','Neri','maria.neri@email.com'),(5,'Paolo','Rossi','pr@icloud.com'),(6,'Marco','Bruni','mr@icloud.com'),(7,'Emilio','Re','aemiluis@gmail.com'),(8,'Dario','Vecchio','dvecchio@icloud.com'),(9,'Mauro','Brusa','mbrusa@gmail.com');
/*!40000 ALTER TABLE `docenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `iscritti`
--

DROP TABLE IF EXISTS `iscritti`;
/*!50001 DROP VIEW IF EXISTS `iscritti`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `iscritti` AS SELECT 
 1 AS `cognome`,
 1 AS `nome`,
 1 AS `titolo`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `iscrizioni`
--

DROP TABLE IF EXISTS `iscrizioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `iscrizioni` (
  `id` int NOT NULL AUTO_INCREMENT,
  `studente_id` int NOT NULL,
  `corso_id` int NOT NULL,
  `prezzo` decimal(6,2) DEFAULT NULL,
  `data_isc` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_iscrizioni_corsi` (`corso_id`),
  KEY `fk_iscrizioni_studenti` (`studente_id`),
  CONSTRAINT `fk_iscrizioni_corsi` FOREIGN KEY (`corso_id`) REFERENCES `corsi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_iscrizioni_studenti` FOREIGN KEY (`studente_id`) REFERENCES `studenti` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iscrizioni`
--

LOCK TABLES `iscrizioni` WRITE;
/*!40000 ALTER TABLE `iscrizioni` DISABLE KEYS */;
INSERT INTO `iscrizioni` VALUES (1,1,1,200.00,'2022-01-19 22:00:00'),(2,1,2,150.00,'2022-02-04 22:00:00'),(3,2,1,200.00,'2022-02-09 22:00:00'),(4,3,1,200.00,'2022-01-19 22:00:00'),(5,4,1,200.00,'2022-01-19 22:00:00'),(6,5,1,200.00,'2022-01-19 22:00:00'),(7,6,1,200.00,'2022-01-19 22:00:00'),(8,7,1,200.00,'2022-01-19 22:00:00'),(9,8,1,200.00,'2022-01-19 22:00:00'),(10,9,2,150.00,'2022-01-19 22:00:00'),(11,10,2,150.00,'2022-01-19 22:00:00'),(12,11,2,150.00,'2022-01-19 22:00:00'),(13,12,2,150.00,'2022-01-19 22:00:00'),(14,13,2,150.00,'2022-01-19 22:00:00'),(15,14,2,150.00,'2022-01-19 22:00:00'),(16,4,2,150.00,'2022-01-19 22:00:00'),(17,5,2,150.00,'2022-01-19 22:00:00'),(18,6,2,150.00,'2022-01-19 22:00:00'),(19,1,3,250.00,'2022-01-19 22:00:00'),(20,2,3,250.00,'2022-01-19 22:00:00'),(21,3,3,250.00,'2022-01-19 22:00:00'),(22,15,3,250.00,'2022-01-19 22:00:00'),(23,16,3,250.00,'2022-01-19 22:00:00'),(24,17,3,250.00,'2022-01-19 22:00:00'),(25,18,3,250.00,'2022-01-19 22:00:00'),(26,19,3,250.00,'2022-01-19 22:00:00'),(27,20,3,250.00,'2022-01-19 22:00:00'),(28,8,3,250.00,'2022-01-19 22:00:00'),(29,21,4,150.00,'2022-01-19 22:00:00'),(30,22,4,150.00,'2022-01-19 22:00:00'),(31,23,4,150.00,'2022-01-19 22:00:00'),(32,24,4,150.00,'2022-01-19 22:00:00'),(33,25,4,150.00,'2022-01-19 22:00:00'),(34,10,5,120.00,'2022-01-19 22:00:00'),(35,11,5,120.00,'2022-01-19 22:00:00'),(36,13,5,120.00,'2022-01-19 22:00:00'),(37,14,5,120.00,'2022-01-19 22:00:00'),(38,15,5,120.00,'2022-01-19 22:00:00'),(39,26,5,120.00,'2022-01-19 22:00:00');
/*!40000 ALTER TABLE `iscrizioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `stud_ok`
--

DROP TABLE IF EXISTS `stud_ok`;
/*!50001 DROP VIEW IF EXISTS `stud_ok`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `stud_ok` AS SELECT 
 1 AS `nome`,
 1 AS `cognome`,
 1 AS `genere`,
 1 AS `indirizzo`,
 1 AS `citta`,
 1 AS `provincia`,
 1 AS `regione`,
 1 AS `email`,
 1 AS `data_nascita`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `studenti`
--

DROP TABLE IF EXISTS `studenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studenti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) DEFAULT NULL,
  `cognome` varchar(50) NOT NULL,
  `genere` enum('m','f','nb') DEFAULT NULL,
  `indirizzo` varchar(100) DEFAULT NULL,
  `citta` varchar(30) DEFAULT NULL,
  `provincia` char(2) DEFAULT 'To',
  `regione` varchar(20) DEFAULT 'Piemonte',
  `email` varchar(100) NOT NULL,
  `data_nascita` date DEFAULT NULL,
  `eta` tinytext,
  `ins` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `studenti_chk_1` CHECK ((`eta` >= 18))
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='anagrafica';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studenti`
--

LOCK TABLES `studenti` WRITE;
/*!40000 ALTER TABLE `studenti` DISABLE KEYS */;
INSERT INTO `studenti` VALUES (1,'franco','rossi','m','via Tripoli 10','torino','TO','piemonte','franco.rossi@gmail.com','1978-10-01','18','2024-02-23 10:41:03'),(2,'mario','verdi','m','via Vicenza 17','asti','AT','piemonte','mario.verdi@gmail.com','1981-10-01',NULL,'2024-02-07 08:25:15'),(3,'paolo','bianchi','m','via Volvera 47','asti','AT','piemonte','paolo.bianchi@gmail.com','1983-10-01',NULL,'2024-02-07 08:25:15'),(4,'sara','rossi','f','corso Vigevano 301','cuneo','CN','piemonte','sara.rossi@gmail.com','1983-10-01',NULL,'2024-02-07 08:25:15'),(5,'elisa','verdi','f','corso Francia 18','alessandria','AL','piemonte','elisa.verdi@gmail.com','1987-10-01',NULL,'2024-02-07 08:25:15'),(6,'marco','bianchi','m','via Siccardi 3','novara','NO','piemonte','marcob@gmail.com','1993-10-01',NULL,'2024-02-07 08:25:15'),(7,'franca','verdi','f','via MIlano 33','torino','TO','piemonte','fv@icloud.com','1993-10-01',NULL,'2024-02-07 08:25:15'),(8,'mauro','bruni','m','via Roma 72','torino','TO','piemonte','mb@icloud.com','1988-10-01',NULL,'2024-02-07 08:25:15'),(9,'osvaldo','rossi','m','via Firenze 5','torino','TO','piemonte','or@icloud.com','1987-01-02',NULL,'2024-02-07 08:25:15'),(10,'oscar','verdi','m','lungo Dora Siena 34','torino','TO','piemonte','ov@icloud.com','1990-02-03',NULL,'2024-02-07 08:25:15'),(11,'paola','bianchi','f','Corso Regina 300','torino','TO','piemonte','paolab@icloud.com','1985-03-04',NULL,'2024-02-07 08:25:15'),(12,'franca','verdi','f','Corso Mortara 231','torino','TO','piemonte','francaverdi@icloud.com','1989-11-05',NULL,'2024-02-07 08:25:15'),(13,'eleonora','verdi','f','via Bardonecchia 121','torino','TO','piemonte','ele@icloud.com','1989-12-06',NULL,'2024-02-07 08:25:15'),(14,'enrico','macello','m','via Grosseto 125','asti','AT','piemonte','emacello@gmail.com','1983-10-01',NULL,'2024-02-07 08:25:15'),(15,'fabio','baggio','m','via Dogliani 7','cuneo','CN','piemonte','fbaggio@gmail.com','1983-10-01',NULL,'2024-02-07 08:25:15'),(16,'francesco','gamba','m','via Torino 1','alessandria','AL','piemonte','gamba@gmail.com','1987-10-01',NULL,'2024-02-07 08:25:15'),(17,'marco','demarchi','m','via Napoli 10','novara','NO','piemonte','marcodem@gmail.com','1993-10-01',NULL,'2024-02-07 08:25:15'),(18,'franca','verdone','f','via Parma 9','torino','TO','piemonte','fverdone@gmail.com','1994-09-01',NULL,'2024-02-07 08:25:15'),(19,'marco','zippo','m','via Palermo 19','torino','TO','piemonte','zippo@gmail.com','1995-11-01',NULL,'2024-02-07 08:25:15'),(20,'giorgio','galvani','m','via Reggio 9','cuneo','cn','piemonte','ggalv@icloud.com','1996-02-01',NULL,'2024-02-07 08:25:15'),(21,'alex','porro','m','via Verona 13','asti','at','piemonte','porroale@gmail.com','1989-10-01',NULL,'2024-02-07 08:25:15'),(22,'andrea','giorgio','f','via Bava 9','torino','TO','piemonte','giorgia@icloud.com','1998-02-01',NULL,'2024-02-07 08:25:15'),(23,'paola','valeri','f','via Balbo 65','novara','no','piemonte','valerip@gamil.com','1992-10-09',NULL,'2024-02-07 08:25:15'),(24,'federico','rossi','m','via Venezia 3','alessandria','al','piemonte','federoss@icloud.com','1994-08-08',NULL,'2024-02-07 08:25:15'),(25,'irene','storti','f','corso vittorio 30','torino','TO','piemonte','stortii@gmail.com','1999-09-09',NULL,'2024-02-07 08:25:15'),(26,'samuele','borsa','m','via Pio 9','torino','TO','piemonte','borsamu@gmail.com','1992-02-02',NULL,'2024-02-07 08:25:15'),(27,'Luigi','Verdi','m','Via Garibaldi 2','Asti','AT','Piemonte','luigi.verdi@example.com','1999-06-03',NULL,'2024-02-07 08:25:15'),(28,'Martina','Bianchi','f','Via Dante 3','Cuneo','CN','Piemonte','martina.bianchi@example.com','2001-01-23',NULL,'2024-02-07 08:25:15'),(29,'Giulia','Neri','f','Via Mazzini 4','Alessandria','AL','Piemonte','giulia.neri@example.com','1996-07-15',NULL,'2024-02-07 08:25:15'),(30,'Giovanni','Russo','m','Via Montegrappa 5','Novara','NO','Piemonte','giovanni.russo@example.com','1997-09-27',NULL,'2024-02-07 08:25:15'),(31,'Luisa','Ferrari','f','Via Garibaldi 6','Vercelli','VC','Piemonte','luisa.ferrari@example.com','1998-04-10',NULL,'2024-02-07 08:25:15'),(32,'Simone','Rossi','m','Via Roma 7','Torino','TO','Piemonte','simone.rossi@example.com','1992-11-02',NULL,'2024-02-07 08:25:15'),(33,'Francesca','Verdi','f','Via Garibaldi 8','Asti','AT','Piemonte','francesca.verdi@example.com','1994-12-18',NULL,'2024-02-07 08:25:15'),(34,'Alessandro','Bianchi','m','Via Dante 9','Cuneo','CN','Piemonte','alessandro.bianchi@example.com','1990-05-25',NULL,'2024-02-07 08:25:15'),(35,'Sara','Neri','f','Via Mazzini 10','Alessandria','AL','Piemonte','sara.neri@example.com','1993-08-30',NULL,'2024-02-07 08:25:15'),(36,'Fabio','Russo','m','Via Montegrappa 11','Novara','NO','Piemonte','fabio.russo@example.com','1989-03-12',NULL,'2024-02-07 08:25:15'),(37,'Laura','Ferrari','f','Via Garibaldi 12','Vercelli','VC','Piemonte','laura.ferrari@example.com','1991-12-01',NULL,'2024-02-07 08:25:15'),(38,'Antonio','Rossi','m','Via Roma 13','Torino','TO','Piemonte','antonio.rossi@example.com','1998-05-09',NULL,'2024-02-07 08:25:15'),(39,'Mario','Rossi','m','Via Roma 1','Torino','TO','Piemonte','mario.rossi@esempio.com','1990-05-15',NULL,'2024-02-07 08:25:15'),(40,'Giulia','Verdi','f','Via Garibaldi 2','Asti','AT','Piemonte','giulia.verdi@esempio.com','1995-06-12',NULL,'2024-02-07 08:25:15'),(41,'Lorenzo','Bianchi','m','Corso Italia 3','Cuneo','CN','Piemonte','lorenzo.bianchi@esempio.com','1999-07-18',NULL,'2024-02-07 08:25:15'),(42,'Alessia','Neri','f','Via Mazzini 4','Alessandria','AL','Piemonte','alessia.neri@esempio.com','1994-08-20',NULL,'2024-02-07 08:25:15'),(43,'Paolo','Rizzo','m','Via Garibaldi 5','Novara','NO','Piemonte','paolo.rizzo@esempio.com','1998-09-27',NULL,'2024-02-07 08:25:15'),(44,'Laura','Conti','f','Piazza Vittorio Emanuele II 6','Vercelli','VC','Piemonte','laura.conti@esempio.com','1992-10-08',NULL,'2024-02-07 08:25:15'),(45,'Federico','Galli','m','Via Monte Napoleone 7','Milano','MI','Lombardia','federico.galli@esempio.com','1997-11-11',NULL,'2024-02-07 08:25:15'),(46,'Martina','Ferrari','f','Via Manzoni 8','Monza','MB','Lombardia','martina.ferrari@esempio.com','1993-12-19',NULL,'2024-02-07 08:25:15'),(47,'Simone','Marini','m','Via XX Settembre 9','Bergamo','BG','Lombardia','simone.marini@esempio.com','1991-01-24',NULL,'2024-02-07 08:25:15'),(48,'carlo','Riva','m','Via po 3','torino','to','Piemonte','valentina.riva@esempio.com','1996-02-21',NULL,'2024-03-08 11:39:23'),(49,'Andrea','Costa','m','Piazza del Popolo 11','Como','CO','Lombardia','andrea.costa@esempio.com','2000-03-30',NULL,'2024-02-07 08:25:15'),(50,'Sara','Santoro','f','Via Sempione 12','Torino','TO','Piemonte','sara.santoro@esempio.com','1998-10-05',NULL,'2024-02-07 08:25:15'),(51,'numero uno','vecchionis',NULL,NULL,NULL,'To','Piemonte','vecchinis@gmail.com',NULL,NULL,'2024-03-08 11:50:11');
/*!40000 ALTER TABLE `studenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `studenti_info`
--

DROP TABLE IF EXISTS `studenti_info`;
/*!50001 DROP VIEW IF EXISTS `studenti_info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `studenti_info` AS SELECT 
 1 AS `cognome`,
 1 AS `nome`,
 1 AS `email`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `studenti_v`
--

DROP TABLE IF EXISTS `studenti_v`;
/*!50001 DROP VIEW IF EXISTS `studenti_v`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `studenti_v` AS SELECT 
 1 AS `cognome`,
 1 AS `nome`,
 1 AS `genere`,
 1 AS `email`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `iscritti`
--

/*!50001 DROP VIEW IF EXISTS `iscritti`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`app_tss`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `iscritti` AS select `s`.`cognome` AS `cognome`,`s`.`nome` AS `nome`,`c`.`titolo` AS `titolo` from ((`studenti` `s` join `iscrizioni` `i` on((`s`.`id` = `i`.`studente_id`))) join `corsi` `c` on((`c`.`id` = `i`.`corso_id`))) order by `c`.`titolo` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `stud_ok`
--

/*!50001 DROP VIEW IF EXISTS `stud_ok`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`app_tss`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `stud_ok` AS select `studenti`.`nome` AS `nome`,`studenti`.`cognome` AS `cognome`,`studenti`.`genere` AS `genere`,`studenti`.`indirizzo` AS `indirizzo`,`studenti`.`citta` AS `citta`,`studenti`.`provincia` AS `provincia`,`studenti`.`regione` AS `regione`,`studenti`.`email` AS `email`,`studenti`.`data_nascita` AS `data_nascita` from `studenti` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `studenti_info`
--

/*!50001 DROP VIEW IF EXISTS `studenti_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`app_tss`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `studenti_info` AS select `studenti`.`cognome` AS `cognome`,`studenti`.`nome` AS `nome`,`studenti`.`email` AS `email` from `studenti` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `studenti_v`
--

/*!50001 DROP VIEW IF EXISTS `studenti_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`app_tss`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `studenti_v` AS select `studenti`.`cognome` AS `cognome`,`studenti`.`nome` AS `nome`,`studenti`.`genere` AS `genere`,`studenti`.`email` AS `email` from `studenti` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-03 14:21:00
