-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: mysql-pi-project-pi1.j.aivencloud.com    Database: beeline_db
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '11715713-fc3b-11f0-b7cb-56735fc3442e:1-15,
2fa31712-fc3e-11f0-9e64-06f018bb114a:1-15,
60925694-f6e5-11f0-84dd-76f7e55ee8e9:1-27,
6509f231-f7e2-11f0-bb17-bad3a57a7795:1-47,
9f959730-012f-11f1-ae8c-a65f5816a4e5:1-706,
a8ffa99d-04fa-11f1-b0f4-c2336a182a06:1-61,
b4d09a50-04e4-11f1-b217-56faa1d2a681:1-15,
c22adc8e-0591-11f1-a096-02d523e35be7:1-239,
da6bf5b7-012a-11f1-8b36-ea0debfa452a:1-17,
fe3d0ec4-04e7-11f1-8b17-da3afbdd3c2f:1-55';

--
-- Table structure for table `agence`
--

DROP TABLE IF EXISTS `agence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agence` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_ag` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adresse_ag` longtext COLLATE utf8mb4_unicode_ci,
  `telephone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `horaires` longtext COLLATE utf8mb4_unicode_ci,
  `banque_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_64C19AA937E080D9` (`banque_id`),
  CONSTRAINT `FK_64C19AA937E080D9` FOREIGN KEY (`banque_id`) REFERENCES `banque` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agence`
--

LOCK TABLES `agence` WRITE;
/*!40000 ALTER TABLE `agence` DISABLE KEYS */;
INSERT INTO `agence` VALUES (8,'Agence BIAT Aïn Zaghouan','RDC IMMEUBLE SOUKRA MEDICAL RUE CHEIKH MOHAMED ENNEIFER 2073','+216 31 372 229','agaz@biat.tn','Lundi à Vendredi : 09h00 -> 16h00\nSamedi & Dimanche : Fermé',5),(10,'Agence BIAT Sfax Medina','104 RUE MONGI SLIM SFAX EL MEDINA 3001','+216 31 372 046','agsfx@biat.tn','Lundi à Vendredi : 09h00 -> 17h00\nSamedi (Particuliers uniquement) : Jusqu\'à midi\nDimanche : Fermé',5),(11,'Agence BIAT Medenine','AVENUE 2 MAI 1966 MEDENINE 4100','+216 31 372 109','agmed@biat.tn','Lundi à Vendredi : 09:00 à 16:00',5),(12,'Agence BIAT Megrine','51 AVENUE HABIB BOURGUIBA 2033','+216 31 372 052','agmegr@biat.tn','Lundi à Vendredi : 08h30 -> 16h00',5),(20,'Agence BIAT Borj Louzir','AVENUE MUSTAPHA MOHSEN BORJ LOUZIR 2073, TUNIS','+216 31 372 288','agborjlouzir@biat.com.tn','Lundi - Vendredi : de 09h00 à 16h30',5),(22,'Agence BH Kheireddine Pacha','21 Av Khereddine Pacha Belvedere, Tunis 1002 Tunisie','+216 71 126 034','succursale1@bhbank.tn','Lundi-Vendredi : 09h00 -> 16h00',11),(24,'Agence BH Manouba','50 Avenue Habib Bourguiba, Manouba 2010, Tunis, Tunisie','+216 73 922 014','agmanouba@bhbank.tn','Lundi - Vendredi : 09:00 -> 16:00',11),(25,'Agence BH Centre Ville','29 Rue Hedi Nouira Tunis , Tunis 1002 Tunisie','+216 71 126 611','succursalecommercialekp@bhbank.tn','Lundi - Vendredi : 09h30 -> 16h30',11),(26,'Agence BH La Marsa','24 Avenue Taieb Mhiri, Marsa 2070, Tunis, Tunisie','+216 98 371 102','agmarsa@bhbank.tn','Lundi - Vendredi : 09:00 -> 16:00',11),(27,'Agence BH Borj Louzir','Rue des industries artisanales, 2035 La Charguia 2, Tunis, Tunisie','+216 73 162 333','agborjlouzir@bhbank.tn','Lundi - Vendredi : 08:00 -> 16:00',11),(28,'Agence BH El Manar 1','58, Rue Malaga, 2092, Tunis, Tunisie','+216 93 112 013','agmanar1@bhbank.tn','Lundi - Vendredi : 09:00 -> 16:00\nSamedi & Dimanche : Fermé',11),(31,'Agence BIAT Centre Urbain Nord','IMM ICC BLV MOHAMED BOUAZIZI CENTRE URBAIN NORD 1082, TUNIS, TUNISIE','+216 31 372 131','agcentreurbain@biat.tn','Lun-Ven : 09h00 -> 16h00',5),(32,'Agence Zitouna Centre Ville','2 Rue de l\'artisanat, 21560 Couternon, Tunis, Tunisie','+216 73 919 033','agcentre@zitouna.com.tn','Lun-Ven : 09:00 -> 16:00',18);
/*!40000 ALTER TABLE `agence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banque`
--

DROP TABLE IF EXISTS `banque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banque` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_bq` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `site_web` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone_bq` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_bq` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `statut` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banque`
--

LOCK TABLES `banque` WRITE;
/*!40000 ALTER TABLE `banque` DISABLE KEYS */;
INSERT INTO `banque` VALUES (5,'Banque BIAT','https://www.biat.com.tn/','+216 71 131 000','contact@biat.com.tn','uploads/banque_logos/BIAT-ee462758acfc.webp','active','La Banque Internationale Arabe de Tunisie (BIAT), fondée en 1976 et basée à Tunis, est la première banque privée de Tunisie. Banque universelle de référence, elle se distingue par un solide réseau de plus de 200 agences et une offre complète pour particuliers, PME et grandes entreprises. Elle est cotée à la Bourse de Tunis et est un pilier du paysage financier tunisien.'),(11,'BH Bank','https://www.bh-bank.tn/','+216 78 019 543','support@bhbank.tn','uploads/banque_logos/BH_BANK-98cea1327d96.png','active','La BH Bank, anciennement Banque de l\'Habitat, est une banque universelle tunisienne majeure, fondée en 1974. Acteur public de premier plan, elle est leader dans le crédit immobilier et le logement. Avec un réseau étendu, elle propose des services bancaires complets aux particuliers, PME et entreprises, se distinguant par son engagement RSE.'),(12,'QNB Bank','https://www.qnb.com.tn/sites/qnb/qnbtunisia/page/fr/fr-home.html','+216 73 983 022','contact@qnb.tn','uploads/banque_logos/qnb-dd3cc2187766.png','rejected','QNB Tunisia, filiale du géant QNB Group, est une banque universelle solide opérant en Tunisie depuis le rachat de l\'ex-Banque tuniso-qatarie en 2013. Elle cible particuliers et entreprises avec des services premium, dont QNB First, et des solutions dédiées aux Tunisiens à l\'étranger.'),(14,'STB Bank','https://www.stb.com.tn/fr/','+216 78 911 001','support@stbbank.tn','uploads/banque_logos/stb-32e0aa01f797.webp','active','La Société Tunisienne de Banque (STB), fondée en 1957 et active depuis mars 1958, est une banque publique majeure en Tunisie, acteur historique du développement économique. Société anonyme détenue majoritairement par l\'État (plus de 80% direct/indirect), elle propose des services de banque commerciale, d\'investissement et d\'affaires via un réseau de 149 agences.'),(15,'Banque de Tunisie','https://www.bt.com.tn/','+216 33 813 011','support@bt.net','uploads/banque_logos/bt-2160b9758136.jpg','active','La Banque de Tunisie (BT), fondée en 1884, est l\'une des plus anciennes et performantes institutions financières privées de Tunisie. Banque universelle, elle propose une gamme variée de services aux particuliers et entreprises, avec un réseau d\'environ 124 agences. Elle est réputée pour sa solidité financière et sa digitalisation.'),(16,'Amen Bank','https://www.amenbank.com.tn/','+216 78 991 013','contact@amenbnk.tn','uploads/banque_logos/amen-f8d9837b056b.jpg','active','Amen Bank est l\'une des principales banques privées en Tunisie, fondée en 1967 et filiale du groupe Amen (famille Ben Yedder). Basée à Tunis, elle offre des services bancaires universels (dépôts, crédits, investissements) aux particuliers et entreprises à travers un réseau de plus de 160 agences, se positionnant comme un acteur majeur de l\'innovation digitale (Amen First Bank) et du financement de la transition énergétique.'),(17,'BNA Bank','http://www.bna.tn/','+216 71 831 000','support@bnabank.tn','uploads/banque_logos/bna-9f1a432c359c.webp','rejected','La Banque Nationale Agricole (BNA) est une institution financière publique tunisienne majeure, créée le 1er juin 1959 pour soutenir le développement économique, initialement axée sur le secteur agricole. Devenue une banque universelle, elle s\'appuie sur un vaste réseau de plus de 170 agences et plus de 2700 collaborateurs pour servir environ 1 million de clients.'),(18,'Zitouna Bank','https://www.banquezitouna.com/fr/','+216 81 105 454','support@zitounabnk.tn','uploads/banque_logos/zitouna-23a9ea1a3a9c.jpg','active','La Banque Zitouna, fondée en 2009 et opérationnelle depuis 2010, est une banque commerciale de référence en Tunisie spécialisée dans la finance islamique (sans intérêts/riba). Elle propose des produits conformes à la Charia (Mourabaha, Ijara) pour particuliers et entreprises, soutenue par le groupe qatari Majda depuis 2018.');
/*!40000 ALTER TABLE `banque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `condition_offre`
--

DROP TABLE IF EXISTS `condition_offre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `condition_offre` (
  `id` int NOT NULL AUTO_INCREMENT,
  `offre_id` int NOT NULL,
  `taux_special` double DEFAULT NULL,
  `montant_seuil` decimal(15,2) DEFAULT NULL,
  `duree_max` int DEFAULT NULL,
  `condit_num` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E35D62644CC8505A` (`offre_id`),
  CONSTRAINT `FK_E35D62644CC8505A` FOREIGN KEY (`offre_id`) REFERENCES `offre` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `condition_offre`
--

LOCK TABLES `condition_offre` WRITE;
/*!40000 ALTER TABLE `condition_offre` DISABLE KEYS */;
/*!40000 ALTER TABLE `condition_offre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctrine_migration_versions`
--

LOCK TABLES `doctrine_migration_versions` WRITE;
/*!40000 ALTER TABLE `doctrine_migration_versions` DISABLE KEYS */;
INSERT INTO `doctrine_migration_versions` VALUES ('DoctrineMigrations\\Version20260210181121','2026-02-10 19:11:28',705);
/*!40000 ALTER TABLE `doctrine_migration_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document` (
  `id` int NOT NULL AUTO_INCREMENT,
  `financement_id` int NOT NULL,
  `nom_fichier` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_document` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chemin_stockage` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `statut_verification` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D8698A76A737ED74` (`financement_id`),
  CONSTRAINT `FK_D8698A76A737ED74` FOREIGN KEY (`financement_id`) REFERENCES `financement` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document`
--

LOCK TABLES `document` WRITE;
/*!40000 ALTER TABLE `document` DISABLE KEYS */;
/*!40000 ALTER TABLE `document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `establishment`
--

DROP TABLE IF EXISTS `establishment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `establishment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `establishment`
--

LOCK TABLES `establishment` WRITE;
/*!40000 ALTER TABLE `establishment` DISABLE KEYS */;
/*!40000 ALTER TABLE `establishment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `financement`
--

DROP TABLE IF EXISTS `financement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `financement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `montant_demande` decimal(15,2) NOT NULL,
  `duree_mois` int NOT NULL,
  `objet_financement` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `statut` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_demande` datetime NOT NULL,
  `date_reponse` datetime DEFAULT NULL,
  `commentaire_agent` longtext COLLATE utf8mb4_unicode_ci,
  `client_id` int NOT NULL,
  `banque_id` int NOT NULL,
  `offre_id` int DEFAULT NULL,
  `type_dmd` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_59895F5619EB6921` (`client_id`),
  KEY `IDX_59895F5637E080D9` (`banque_id`),
  KEY `IDX_59895F564CC8505A` (`offre_id`),
  CONSTRAINT `FK_59895F5619EB6921` FOREIGN KEY (`client_id`) REFERENCES `utilisateur` (`id`),
  CONSTRAINT `FK_59895F5637E080D9` FOREIGN KEY (`banque_id`) REFERENCES `banque` (`id`),
  CONSTRAINT `FK_59895F564CC8505A` FOREIGN KEY (`offre_id`) REFERENCES `offre` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financement`
--

LOCK TABLES `financement` WRITE;
/*!40000 ALTER TABLE `financement` DISABLE KEYS */;
/*!40000 ALTER TABLE `financement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0E3BD61CE16BA31DBBF396750` (`queue_name`,`available_at`,`delivered_at`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messenger_messages`
--

LOCK TABLES `messenger_messages` WRITE;
/*!40000 ALTER TABLE `messenger_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messenger_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offre`
--

DROP TABLE IF EXISTS `offre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offre` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `type_offre` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  `taux` decimal(5,2) DEFAULT NULL,
  `active` tinyint NOT NULL,
  `banque_id` int NOT NULL,
  `montant_min` decimal(15,2) DEFAULT NULL,
  `montant_max` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_AF86866F37E080D9` (`banque_id`),
  CONSTRAINT `FK_AF86866F37E080D9` FOREIGN KEY (`banque_id`) REFERENCES `banque` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offre`
--

LOCK TABLES `offre` WRITE;
/*!40000 ALTER TABLE `offre` DISABLE KEYS */;
/*!40000 ALTER TABLE `offre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile` (
  `id` int NOT NULL AUTO_INCREMENT,
  `utilisateur_id` int NOT NULL,
  `niveau_experience` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preferences` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `specialite` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8157AA0FFB88E14F` (`utilisateur_id`),
  CONSTRAINT `FK_8157AA0FFB88E14F` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur` (`id`),
  CONSTRAINT `profile_chk_1` CHECK (json_valid(`preferences`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile`
--

LOCK TABLES `profile` WRITE;
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rendez_vous`
--

DROP TABLE IF EXISTS `rendez_vous`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rendez_vous` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_rdv` date NOT NULL,
  `heure_rdv` time NOT NULL,
  `statut` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qr_code` longtext COLLATE utf8mb4_unicode_ci,
  `ticket_reference` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `client_id` int NOT NULL,
  `banque_id` int NOT NULL,
  `agence_id` int NOT NULL,
  `service_id` int NOT NULL,
  `duree` int DEFAULT NULL,
  `priorite` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_65E8AA0A34999359` (`ticket_reference`),
  KEY `IDX_65E8AA0A19EB6921` (`client_id`),
  KEY `IDX_65E8AA0A37E080D9` (`banque_id`),
  KEY `IDX_65E8AA0AD725330D` (`agence_id`),
  KEY `IDX_65E8AA0AED5CA9E6` (`service_id`),
  CONSTRAINT `FK_65E8AA0A19EB6921` FOREIGN KEY (`client_id`) REFERENCES `utilisateur` (`id`),
  CONSTRAINT `FK_65E8AA0A37E080D9` FOREIGN KEY (`banque_id`) REFERENCES `banque` (`id`),
  CONSTRAINT `FK_65E8AA0AD725330D` FOREIGN KEY (`agence_id`) REFERENCES `agence` (`id`),
  CONSTRAINT `FK_65E8AA0AED5CA9E6` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rendez_vous`
--

LOCK TABLES `rendez_vous` WRITE;
/*!40000 ALTER TABLE `rendez_vous` DISABLE KEYS */;
/*!40000 ALTER TABLE `rendez_vous` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_service` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `duree_estimee` int DEFAULT NULL,
  `disponible` tinyint NOT NULL,
  `banque_id` int NOT NULL,
  `priorite_defaut` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E19D9AD237E080D9` (`banque_id`),
  CONSTRAINT `FK_E19D9AD237E080D9` FOREIGN KEY (`banque_id`) REFERENCES `banque` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilisateur` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telephone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `statut_compte` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `banque_id` int DEFAULT NULL,
  `cin` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adresse` longtext COLLATE utf8mb4_unicode_ci,
  `code_postal` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1D1C63B3E7927C74` (`email`),
  KEY `IDX_1D1C63B337E080D9` (`banque_id`),
  CONSTRAINT `FK_1D1C63B337E080D9` FOREIGN KEY (`banque_id`) REFERENCES `banque` (`id`),
  CONSTRAINT `utilisateur_chk_1` CHECK (json_valid(`roles`))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilisateur`
--

LOCK TABLES `utilisateur` WRITE;
/*!40000 ALTER TABLE `utilisateur` DISABLE KEYS */;
INSERT INTO `utilisateur` VALUES (1,'mehdimejri15@gmail.com','[\"ROLE_CLIENT\"]','$2y$13$PJD740RyCkbFOeeEjviTxegyWKYxLlsUpKUwS6/9NGAGP/8m29x4C','Mejri','Mehdi','321412','active',NULL,NULL,NULL,NULL,NULL),(4,'az@gmail.com','[\"ROLE_AGENT\"]','$2y$13$InHeMSVrR7MaOh0APjDVouG0AIhQrsTpRZqKZpFiyoS8AGHUCX0He','Mejri','Mehdi','321412','active',NULL,NULL,NULL,NULL,NULL),(5,'admin@beeline.com','[\"ROLE_ADMIN\"]','$2y$13$F8JjZoIYEM4jhMNa.xd4F.XNrrtNQgUxV6M.3R7C8VgfCD9bgKwTq','Admin','System','+216 00 000 000','active',NULL,NULL,NULL,NULL,NULL),(6,'er@gmail.com','[\"ROLE_AGENT\"]','$2y$13$DQgU0BSsNfBZa6PfwSALoux.LJkOp92ebMSqOXYV4Bwlp1nPg02Za','Mehdi','Mejri','+216 73 091 222','active',5,NULL,NULL,NULL,NULL),(7,'cl@gmail.com','[\"ROLE_CLIENT\"]','$2y$13$47A3XrQ3HP3cN.9EkRBoReIu7aonkQeu6HaRsp8u4KokS0q0PaVbu','Mehdi','Khedher','+216 78 339 103','active',11,NULL,NULL,NULL,NULL),(8,'er1@gmail.com','[\"ROLE_CLIENT\"]','$2y$13$u9XrsiJiRse2eqrGcH7j6u5HsBjqcXy9CO2BbNIDMGLVLXHHJm1Cu','Mejri','Mehdi','+216 73 934 033','active',5,NULL,NULL,NULL,NULL),(9,'mariemhamdi@gmail.com','[\"ROLE_AGENT\"]','$2y$13$dm2IBpbrMOWBtfhauUFWLeij.mvqGLNik3U/meFGbzxt5GFqEH8wm','Hamdi','Mariem','+216 73 913 344','active',18,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `utilisateur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'beeline_db'
--
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-12 18:31:37
