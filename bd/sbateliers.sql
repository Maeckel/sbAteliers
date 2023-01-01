drop database if exists sbateliers;
create database sbateliers;
use sbateliers;

-- MySQL dump 10.19  Distrib 10.3.34-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: sb
-- ------------------------------------------------------
-- Server version	10.3.34-MariaDB-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `atelier`
--

DROP TABLE IF EXISTS `atelier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `atelier` (
  `numero` int(11) NOT NULL AUTO_INCREMENT,
  `theme` varchar(50) NOT NULL,
  `nb_places` int(11) NOT NULL DEFAULT 10,
  `responsable` int(11) NOT NULL,
  `date_enregistrement` date NOT NULL,
  `date_heure` datetime NOT NULL,
  `duree` int(11) NOT NULL DEFAULT 1,
  `nb_participants` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`numero`),
  KEY `responsable` (`responsable`),
  CONSTRAINT `atelier_ibfk_1` FOREIGN KEY (`responsable`) REFERENCES `responsable` (`numero`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `atelier`
--

LOCK TABLES `atelier` WRITE;
/*!40000 ALTER TABLE `atelier` DISABLE KEYS */;
INSERT INTO `atelier` VALUES (1,'Liquide vaisselle',8,2,'2022-10-13','2022-10-29 10:30:00',2,0),(2,'Détachant Linge',10,1,'2022-10-13','2022-10-29 14:00:00',2,0),(3,'Crème hydratante pour homme',10,2,'2022-10-20','2022-11-03 10:00:00',3,0),(4,'Mousse à raser',8,1,'2022-10-20','2022-11-03 15:00:00',2,1),(5,'Lessive',10,1,'2022-11-25','2022-12-22 10:00:00',2,1);
/*!40000 ALTER TABLE `atelier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `numero` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(30) DEFAULT NULL,
  `mdp` varchar(30) NOT NULL,
  `email` varchar(100) NOT NULL,
  `date_naissance` date DEFAULT NULL,
  `adresse` varchar(100) DEFAULT NULL,
  `cp` char(5) DEFAULT NULL,
  `ville` varchar(30) DEFAULT NULL,
  `mobile` char(10) DEFAULT NULL,
  `civilite` varchar(4) NOT NULL,
  PRIMARY KEY (`numero`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'ONESTAS','Valentine',MD5('azerty'), 'valentine.onestas@gmail.com','1995-11-08','15, rue de la gare','94130','Nogent s/Marne','0693530293','Mlle'),(3,'HAFIDI','Nadiya',MD5('azerty'),'n.hafidi@gmail.com','2000-04-01','11, bd de Strasbourg','94120','Fontenay s/bois','0711930388','Mme'),(4,'OSARO','Clémence',MD5('azerty'),'c.osaro@orange.fr','2001-09-15','25, place de la mairie','77350','Le Mée s/Seine','0683340299','Mme'),(5,'JADOUX','Lucie',MD5('azerty'),'lucie.jadoux@gmail.com','1997-11-03','2, bd de La République','94130','Nogent s/Marne','0703740203','Mlle'),(6,'KANNY','Pauline',MD5('azerty'),'p.kanny@gmail.com','1999-01-11','1 ter, rue Paul Doumer','95000','Cergy','0730832731','Mme'),(8,'KARA','Juliette',MD5('azerty'),'juliette.kara@gmail.com','2007-05-10','21, rue de la gare','94200','Ivry s/Seine','0799720154','Mlle'),(9,'LAURY','Sophie',MD5('azerty'),'sophie.laury@gmail.com','2002-08-02','15, rue du parc','94400','Vitry s/Seine','0638304393','Mlle'),(10,'BELLIL','Rim',MD5('mehdicoeur'),'rim.bellil@gmail.com','1998-01-05','13, avenue de la République','94500','Champigny s/Marne','0629341899','Mme');
UPDATE `client` SET `email` = AES_ENCRYPT(`email`, 'azerty') WHERE 'email' is not null;
UPDATE `client` SET `nom` = AES_ENCRYPT(`nom`, 'azerty') WHERE `nom` is not null;
UPDATE `client` SET `prenom` = AES_ENCRYPT(`prenom`, 'azerty') WHERE `prenom` is not null;
UPDATE `client` SET `date_naissance` = AES_ENCRYPT(`email`, 'azerty') WHERE `date_naissance` is not null;
UPDATE `client` SET `adresse` = AES_ENCRYPT(`adresse`, 'azerty') WHERE `adresse` is not null;
UPDATE `client` SET `cp` = AES_ENCRYPT(`cp`, 'azerty') WHERE `cp` is not null;
UPDATE `client` SET `ville` = AES_ENCRYPT(`ville`, 'azerty') WHERE `ville` is not null;
UPDATE `client` SET `mobile` = AES_ENCRYPT(`mobile`, 'azerty') WHERE `mobile` is not null;
UPDATE `client` SET `civilite` = AES_ENCRYPT(`civilite`, 'azerty') WHERE `civilite` is not null;
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participer`
--

DROP TABLE IF EXISTS `participer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participer` (
  `client` int(11) NOT NULL,
  `atelier` int(11) NOT NULL,
  `date_inscription` date NOT NULL,
  PRIMARY KEY (`client`,`atelier`),
  KEY `atelier` (`atelier`),
  CONSTRAINT `participer_ibfk_1` FOREIGN KEY (`client`) REFERENCES `client` (`numero`),
  CONSTRAINT `participer_ibfk_2` FOREIGN KEY (`atelier`) REFERENCES `atelier` (`numero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participer`
--

LOCK TABLES `participer` WRITE;
/*!40000 ALTER TABLE `participer` DISABLE KEYS */;
INSERT INTO `participer` VALUES (1,3,'2022-10-25'),(3,1,'2022-10-25'),(3,3,'2022-10-25'),(5,1,'2022-10-25'),(5,4,'2022-10-25'),(5,5,'2022-11-25'),(9,1,'2022-10-25');
/*!40000 ALTER TABLE `participer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `responsable`
--

DROP TABLE IF EXISTS `responsable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `responsable` (
  `numero` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(30) NOT NULL,
  `mdp` varchar(30) NOT NULL,
  `login` varchar(30) NOT NULL,
  PRIMARY KEY (`numero`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `responsable`
--

LOCK TABLES `responsable` WRITE;
/*!40000 ALTER TABLE `responsable` DISABLE KEYS */;
INSERT INTO `responsable` VALUES (1,'DA SILVA','Maria',MD5('azerty'),'mdasilva'),(2,'JONES','Katarina',MD5('azerty'),'kjones');
UPDATE `responsable` SET `nom` = AES_ENCRYPT(`nom`, 'azerty') WHERE `nom` is not null;
UPDATE `responsable` SET `prenom` = AES_ENCRYPT(`prenom`, 'azerty') WHERE `prenom` is not null;
/*!40000 ALTER TABLE `responsable` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-25 16:56:19
