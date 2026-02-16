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
c22adc8e-0591-11f1-a096-02d523e35be7:1-341,
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
  `nombre_guichets` int NOT NULL DEFAULT '3',
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
INSERT INTO `agence` VALUES (8,'Agence BIAT Aïn Zaghouan','RDC IMMEUBLE SOUKRA MEDICAL RUE CHEIKH MOHAMED ENNEIFER 2073','+216 31 372 229','agaz@biat.tn','Lundi à Vendredi : 09h00 -> 16h00\nSamedi & Dimanche : Fermé',5,3),(10,'Agence BIAT Sfax Medina','104 RUE MONGI SLIM SFAX EL MEDINA 3001','+216 31 372 046','agsfx@biat.tn','Lundi à Vendredi : 09h00 -> 17h00\nSamedi (Particuliers uniquement) : Jusqu\'à midi\nDimanche : Fermé',5,3),(11,'Agence BIAT Medenine','AVENUE 2 MAI 1966 MEDENINE 4100','+216 31 372 109','agmed@biat.tn','Lundi à Vendredi : 09:00 à 16:00',5,3),(12,'Agence BIAT Megrine','51 AVENUE HABIB BOURGUIBA 2033','+216 31 372 052','agmegr@biat.tn','Lundi à Vendredi : 08h30 -> 16h00',5,3),(20,'Agence BIAT Borj Louzir','AVENUE MUSTAPHA MOHSEN BORJ LOUZIR 2073, TUNIS','+216 31 372 288','agborjlouzir@biat.com.tn','Lundi - Vendredi : de 09h00 à 16h30',5,3),(22,'Agence BH Kheireddine Pacha','21 Av Khereddine Pacha Belvedere, Tunis 1002 Tunisie','+216 71 126 034','succursale1@bhbank.tn','Lundi-Vendredi : 09h00 -> 16h00',11,3),(24,'Agence BH Manouba','50 Avenue Habib Bourguiba, Manouba 2010, Tunis, Tunisie','+216 73 922 014','agmanouba@bhbank.tn','Lundi - Vendredi : 09:00 -> 16:00',11,3),(25,'Agence BH Centre Ville','29 Rue Hedi Nouira Tunis , Tunis 1002 Tunisie','+216 71 126 611','succursalecommercialekp@bhbank.tn','Lundi - Vendredi : 09h30 -> 16h30',11,3),(26,'Agence BH La Marsa','24 Avenue Taieb Mhiri, Marsa 2070, Tunis, Tunisie','+216 98 371 102','agmarsa@bhbank.tn','Lundi - Vendredi : 09:00 -> 16:00',11,3),(27,'Agence BH Borj Louzir','Rue des industries artisanales, 2035 La Charguia 2, Tunis, Tunisie','+216 73 162 333','agborjlouzir@bhbank.tn','Lundi - Vendredi : 08:00 -> 16:00',11,3),(28,'Agence BH El Manar 1','58, Rue Malaga, 2092, Tunis, Tunisie','+216 93 112 013','agmanar1@bhbank.tn','Lundi - Vendredi : 09:00 -> 16:00\nSamedi & Dimanche : Fermé',11,3),(31,'Agence BIAT Centre Urbain Nord','IMM ICC BLV MOHAMED BOUAZIZI CENTRE URBAIN NORD 1082, TUNIS, TUNISIE','+216 31 372 131','agcentreurbain@biat.tn','Lun-Ven : 09h00 -> 16h00',5,3),(32,'Agence Zitouna Centre Ville','2 Rue de l\'artisanat, 21560 Couternon, Tunis, Tunisie','+216 73 919 033','agcentre@zitouna.com.tn','Lun-Ven : 09:00 -> 16:00',18,3);
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
  `duree_max` int DEFAULT NULL,
  `taux_special` double DEFAULT NULL,
  `montant_seuil` decimal(15,2) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `offre_id` int NOT NULL,
  `condit_num` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E35D62644CC8505A` (`offre_id`),
  CONSTRAINT `FK_E35D62644CC8505A` FOREIGN KEY (`offre_id`) REFERENCES `offre` (`id_offre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  CONSTRAINT `FK_59895F564CC8505A` FOREIGN KEY (`offre_id`) REFERENCES `offre` (`id_offre`)
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
  `id_offre` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `description` longtext,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  `montant_max` decimal(15,2) DEFAULT NULL,
  `montant_min` decimal(15,2) DEFAULT NULL,
  `id_banque` int NOT NULL,
  `taux_interet` decimal(5,2) DEFAULT NULL,
  `type_f` varchar(100) DEFAULT NULL,
  `statut` varchar(20) NOT NULL,
  PRIMARY KEY (`id_offre`),
  KEY `IDX_AF86866F97C17ED1` (`id_banque`),
  CONSTRAINT `offre_ibfk_1` FOREIGN KEY (`id_banque`) REFERENCES `banque` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offre`
--

LOCK TABLES `offre` WRITE;
/*!40000 ALTER TABLE `offre` DISABLE KEYS */;
INSERT INTO `offre` VALUES (2,'Offre BIAT','Description test','2026-03-01','2027-03-01',300000.00,50000.00,5,3.50,'Taux Réduit','active');
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
  `preferences` json DEFAULT NULL,
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
  `numero_guichet` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_65E8AA0A34999359` (`ticket_reference`),
  KEY `IDX_65E8AA0A19EB6921` (`client_id`),
  KEY `IDX_65E8AA0A37E080D9` (`banque_id`),
  KEY `IDX_65E8AA0AD725330D` (`agence_id`),
  KEY `IDX_65E8AA0AED5CA9E6` (`service_id`),
  CONSTRAINT `FK_65E8AA0A19EB6921` FOREIGN KEY (`client_id`) REFERENCES `utilisateur` (`id`),
  CONSTRAINT `FK_65E8AA0A37E080D9` FOREIGN KEY (`banque_id`) REFERENCES `banque` (`id`),
  CONSTRAINT `FK_65E8AA0AD725330D` FOREIGN KEY (`agence_id`) REFERENCES `agence` (`id`),
  CONSTRAINT `FK_65E8AA0AED5CA9E6` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rendez_vous`
--

LOCK TABLES `rendez_vous` WRITE;
/*!40000 ALTER TABLE `rendez_vous` DISABLE KEYS */;
INSERT INTO `rendez_vous` VALUES (1,'2026-02-14','15:00:00','pending','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAACx0lEQVRoge2ZQY7sIAxEYZVj5KYBbppjsMIfV5mE0Z/FrEtBo0jdeb3xuOyySfbHkz7wAz9QEqxpntP62cxGOuth47D5cT5b93dZEZzvSdXjvg4+78vf36WfAeiBPeUZjBkHIs56HozDwZpOYdD4RF54aszncWd1EC8T4oF0MOSFMBhS8Iwo+Dh/Wqb0UQZ+0YwEyLLX+q9//9dHEZCnot4PfF1RA/yb5yiCM0JXWhSkgHrv4SkuC0GwQe7zn395nfMsKN1DZascSoLWo7RP0V+RCDfVX1kLFcFK47bs20yEK6SQ0OfvrAhalLcTCJr5McPjCRINXxEcngh3RidPaOboct7qqYamCHpLdymw+Pm5kCCgZEG2sorqXtffOOLXTRSEZfMUwEt6N3+2HjVPEjTM3BXFPm/2rUAQW3ikQPq1muDZE6161IMM1iRBuLYEQXAebUiK4S3O4siBjZMKGzjcHHwc51FESBFEOnjJR3+jZz+RCzeSYpvihMBV0d3CFCj+sXVP5RMEEZ66rVjY6mnf5i+aImgYyFzxsOf4sO2P9+FMCMT87T6dNc+6B4bhYZPPqiDaGjcNUH+KFofxxRRBcztzr7zAKrGHoUM92Kc4HXDElYj7uLyuDmDeoYmkCXJMaQYKq7W8RvALfrYogm2xTAdjIvCyKO1SkAKr+1OqfwrCNy7FuH5w67r7HiXwjccaRs2evNilIAVWWPVmyHqukPFlgXVVBS0Gbld/iTi5h0VSRN/TAyMAPZaIHMrpaLz17R5XCESZPw2xoXXN73XBz9lVCORZ0xhH0lQ4ocZyQhCkbanH8jUxoq3x9HikIAU2i3qfov5xLHvH0ywJhu7fe7AUtweUgjIINYT6M3pdfraM0iDzggXv7fPcp+qBkMJ4boRibbzuvV/rKgVG7mPZcKEGDGhiDStPUkiBfzof+IEfqAf+A/KLNG7KjBq/AAAAAElFTkSuQmCC','RDV-698F014A6FCDB','2026-02-13 11:47:38',8,5,20,9,30,'medium',1),(2,'2026-02-20','15:00:00','pending','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAACz0lEQVRoge2aMXLDMAwEyYrP0E9F8qd6hioixB1ge5wUqW+k8XhkeeUCAQ4HKMX+eZQHfMAHlARH2ccx/eSYt5/vi/vkbIaPpSqCG7HbkX6X6q9jNI/Iale/jwD0QHxpdu14DMQpEX/nFVUwU8PxHa1VdlJcVR702BTEY+f+1fcdpSiDKIXRroIKmH6rZ0TF9V81IwJGOtx/vv7QRw2Qx9oan1HZ8UCOHK9vFUGXt9WMgldKhGSnya6J0q4qCXoP32zK3paBEH6eaIKDlAfGwepB8rv3le769xYAJfDzS5d5+prodah+RXCX/n4NGtVmdHD+0a6QQ0Vwso0nsjXgpJfx6oehUwTNQtc9Tm7cKHzu4zpiMxVB/Nld4/v9yg5/X+1VH4qg0aEfSIcjNS9+oH+7PRUwuroPJYxTTdlbMO9VESTr7R0RKgjSwIzCRicJosRD15kdlrE5IXuSoOUUPuhY8U6c+meKIAPgOueTilMsDvR2WDxFkOsHiF8uWtDoakjCh+wJgVEN7++RF4xTmB1BcCHhvcoxgBZumGjiKH6K4DQ6lyu6GT5O+FZ2eE3w9pUSqRWdza9gSosluiQ4Glcs6PBG+Q9PZ/d7OFMCjcM3t0oeGGzNS/S9VV6GXQqc6GMlH3/1fDbiwtDwM4qgZTwm+3mJCmCyzI8WpwRy+qT4DR9JEY8Y19D2FcGV9g3p/6qDg7Y9JEEPxMrBUuo6tZ/NDcLQFUGDe8U0hl0LutxK7R/lQ+yFwNwx+JOB0zNihyQHlK84CoFYtyALoO7e2Zrf1GM8/ZjYhcDMC98znanuEIAYUyRB2hYL585/ZECE0PTGe/0gBXp93wek3XO/oumB/RpJtUCsH9DZohRq+JpYLk5dMEzNHQ9GjM+FsFkUBhc1nnWQRw1hUASjFMK3npy8MbGduWjUAyl7K2dxQ15wJhtME0XwX8cDPuAD6oE/aE6b/48Bh4kAAAAASUVORK5CYII=','RDV-698F01C40DC0D','2026-02-13 11:49:40',8,5,8,9,30,'medium',1),(3,'2026-02-14','14:00:00','pending','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAC6ElEQVRoge2aTW7rMAyEqZWP4Zta0k19DK+kkjNU7LzXRdcDC2mgyJ8LlCWHP47NPy57wRd8QUmwma99mB3bHNvsl+/3eVmZvo9rRRHs/hMXrcYVR/a2+d17n2f1jwT0QLdEHJwBztO2s8zz2PxjgLhDFnR3CMOEC5x0hOF3qINwgYiGiIztPBAcyiBCwSM+3IFxP+kXOP83ZkRAyp6H/m+v//VRBOTq6fup8WGb59IDL6vhEeEC/aEBfjIYB5rgznfPbCEDUIIKd/DgqNdHAMRAc5FrhpQem4gM1/5I76F/dygogf7X+4EBnBC8VD6a7UsfdcABGxgKt0b3R54fyymmItiXGRqkDpoXpdxhGQ1FEeTFAi+Im/Byp2B8tK8UJwSG4PHYUMdFIUMjlYl2TREc6/9PmbcQA4sMz5tu80iBjbqOfF7RnEWSv2UvmjY9EOVMFuzQubjjwDRiQv+6IsgUV2dKfs+TCQ2ApyiCbbWhYSR24dhUdDAeEJogqvJ4v9I8Df2KQfYyAcqBHCUulp0Ki/fZr2eKkwJRrk6Ub4boR12DKr6zhlUER4YCRQ6h8Mh75W7OpEAOG+D+O/SASp96cDzEXgkcMUEMG6A1Qa4zJr2dqlBVwS1KmMHqdRU4FIZxtylSINNaxSOCI4fl6M+yNb/rHiUQJkEcwPdxHY+J8rnBxzxSIHTdV1oloh+hwAlEhQH1wOX46MyyMf304pH0qiLYZ3YqqOYwPYV31LuWVwQvXrdj6dyRw9QIBd9PRZDsQJFeYR4kOjrF/lXtCYHDVudt7MXRjKJ6rd+lqxIY26zjMGwzjJOR4lpOYgRBroZatWV7iqKG+00TbMhvfX21gXpQ6CxXlnV6IMQ+In5gqNbZknIIgV9TJMGLs6VPbs/5MVf5aknVwIaz6FTwuGBS9bc0lSrYsal3lmMVj4JOEsxQyMF5QVg07I/M9oIgZW9gdm7GGpZWwRT5dgop8E/rBV/wBfXAH781IqMc/DZCAAAAAElFTkSuQmCC','RDV-698F023867E6D','2026-02-13 11:51:36',8,5,20,7,60,'low',1),(4,'2026-02-19','10:00:00','cancelled','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAC3UlEQVRoge2ZTXakMAyExYpjcFPAN+1jsLLGVSU3zEwWWdfDr9PPwR+LKFLpx5G/XPGCL/iCluAZY23je48tr1iu8b21sckc32MtjmAbP9d2ruPx1tfsEQct0tfPMV4S4AfSJDDS+lmwj30dNtsEjo0xmPyccIGPHKHjPXOw64HsFNvDbKZghcLngEnw6wiLZBDkjzFjAcoe7frx878+moBawzzA87Pg1U0GW77HfiBdviEahuAh+gOaV/ntuG7zOIGnchrtsfPkyCHzwqH3zRGUAGRC2lP7wfIJCpyEMPiBPXQuF4AxKrmtiI/ldgovkI+T0TAO5Qiq5mLWcX7g+LePBztSHLygB5O5sj1l4HAEJfMn2hSEvurWdpWn7Oud2J3ALMEDe2hPq+xMcd0UPOHvDH15AQ/nq9tD9qzALEuUVQ64Q8le+2YAO7BHdWadtcyBpIcMv0MCqYKOIIwB5UNMNP7eskYRnEk8CnYjUFZRAj9DLWk1qSc3aQmy1S6Bp4UYEJzB0E6WoGzQNGHimK3NyMDzhz5agXPkIK9vFIDlERPNEUSgR83Yas/42GdMWIKPxcNVo6ai8g4FK7CHFrweNWw138jzOeXfDzw5Zgh0YzU6heQzq38LWD9Q5UxfS/U774g6/WKpCYQh2FjLMOI3iZyUL9i15C0AVmCycumxze5EA7aaQBx3KFiBfQ5a8qr54jRYMiDuUPACUbb0OTqVVb5PnjHjBDZJO+O+XXUoBwndfjuCk8VCuuPQpZdTUAYcwa4rryzXaFXMYtAYf10XWIFtjliY1tiSrvescXneKxiB5ReykK4B6yV2Lf8W7CYg7FGaxyEETUXhl9mevasPiL/+Qn5TSl80iuCQVfu0BMskuPvaqyXlnUmFxW0eP7DNwi3nfWCvy6IwBuEIeoNIyEFqju4I5l2zNwbEIoSd2XmXrlZgyR4zW5+Jrk3q4RRW4K/WC77gC/qBfwBexIZ7Jed4hAAAAABJRU5ErkJggg==','RDV-698F02F407717','2026-02-13 11:54:44',8,5,8,9,30,'medium',1),(5,'2026-02-26','10:00:00','cancelled','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAACzElEQVRoge2aTXKsMAyEzcrH4KaMfVOOwcp67m6ZIZW3yLoLF6E88Hmjklo/pMQfV3nBF3xBS7CVufZWz8+1z/28x7WPUo4a/cK7zRHs809v5rO5qTj6ifPg0QT8wAvvyeI+fx44tPeQwXZjcD4ufNbK7RTn5g5O22iDyKhwhFGKM6hQqNog3EHNOODz3zHjAUr2+vXf67c+moBa0zyDQb8xGqZ5pmt8lx9If2/0ArzXqjzKqzuCrdLxlxdQ7ZDVoX9MdJsjCEeYFqqwUw+VMDjUpPfhC673g2kN6Q6hMN3kLPWhj0bgjHtd1Hg87vSUTPXXbgnO0D8Y/czh54Ganbmd6a7VW/aswMxmiHUcYlhk+Ra+4NMqBzNbpx5I6VXg+IEqWo/0fTQoIcmnvzxkzwqcGh/4xWhArlMoQPYk9h9HkN0Jpw4sZ1ZWZ5/K7BeeILat8uLQRUWNtFDabwiGjCEBUNei1jyNZAmGajcq3/ZtU5TbGRyOYFs1C5sVKn12qDmM2RzByLJFSp/7D9Tu1ntDcND3C8oWZHWFBS5mvIfsWYGqzdmR3Hc6iAr5Ryg4gcEs96H+jWxM6REwTOq9HzhS5FLwUgnYhR/KeI4glkSOnUqnX2yPZsUS5BuN1nYZadQMhaaBhCMYLFv4BUwIHEFZrq1phB/Y0xcCQ0Ta454spr84gkNf//i0Xzk87nwyyjMU3MBGjW8MiIPuEDwRSAJ3irMCaZX1vZeTclU3/VJuv4cuViC3/EKC9xohR9Oc6cfnAisQjQhrVRWqTedY4LTVrvmB6RfpDrvUfaxCRsLgBzbYBRpf6AWb2tBlrf6cuhqBMABj/XZ8xX1ZWb1bgldGwHfOJAdZw0VjUPZYtSrAQ5+Cv6FgCKbCZQRg+kI7ZV1jCEb+206oolGHysiA8pmCkr3gYElVTKgr5Sff9i1nrMA/rRd8wRf0A/8BzUElu0z7484AAAAASUVORK5CYII=','RDV-698F0558DD72E','2026-02-13 12:04:56',8,5,8,9,30,'medium',1),(6,'2026-02-21','15:00:00','pending','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAC1UlEQVRoge2ZS5KkMAxE5RXH4Kb+3JRjeGWNlJKBjulFrzMgqArAz7VQSakPon885AM/8AMpwS52nP3QoVeZ0rCwRKo9mb5WGMFhn2ng1Yyap93api7n8idnAnzglIIHtr5gqo34t+0gBs084s+AwBfqcRV2cPgzgT3g+3pVEWZwhwLW/XbAIwqe6y8xwwCG7I356/m/PpKAcSyLe5xhnlC+e5UR9KA3qbOIrwJ7TDdJJD0JZ6EDOxTO8pscCIIpFVnd9UB9NyvYIsvZafYA5Xpvu81yPwSABxwwTI9yZmu8iz3w8oQCFWhBj0y+yzd4wYo4CDlkBAf++fUgZqHIeBb9ftsYwYV2pISd0KlICn/W74MRjL8dMuDr0HgU7weCYD7NGROo0wUvJN9OiWYFwg+9v81DBa7oSLBjIKfh9pE9StDvkNByZftIcR+Rd93DBC503oJCNapX3U15jWhgBDWMkbnO3R/HGaWNPGJPBXb87cNr9lR9BIRu/eMEMU3E1GHmoAWjF9sR16+OnQi8tW05hbZsC+HYxQ4fuOD5rm2o2kLw4B0eCnatjOC4baNX+dGc7W9GUJHKwvFTA2Cehjl6JwVXtmUId3eBvIh+Ree7i+MBIXsSk4aFHrRHf4ZEt+Sp7JlAzXHaFQm9ZbsWFZyrQuMET42EtmWg7oly5PbBCHa8Eao5epES7z/Rnt4FDh+4jqzZm+4BapbtXspBEhhBjBwULtCBD7hJpLj2LmeIQPUVT+ZrFy9jZifq0fC8BqQCM6unCyCfB7KHyo0RRIpzL6hQ9x4aALznbxCCt1+U/SII1Q0e7oaVD9xly9l3NAx9Jbr4HTrQL2eIPd4LwSThICPlnxFEX6LZg6JixdS8S8wknoKdD4Tep/JVVKwCI9VDicEVtXnWcdmjYPXkBBEKqvn2r+4dDVldn9KVCnzJHnQ9pw6uBxKpnhH80/GBH/iBfOA/YkKDq6s/oasAAAAASUVORK5CYII=','RDV-698F06CE68CE9','2026-02-13 12:11:10',8,5,20,5,30,'high',1),(7,'2026-02-14','14:00:00','pending','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAACzklEQVRoge2aQZbcIAxEYeVjcFMDN+1jsEJBVcJuz2Qx63r2cyZu+L2IIhUleZL98Uov+IIvKAm2tK7Sjs/6K49io6yVc92H9eF7WRHs688o8/icxyf7Tpn+jQV+6voeAT1weFSmB6Osux02PTylm4PNH2TBtczNjI+eFx4tcdBGqsadlA5PBKSGLniVAosAK+tjxfp/a0YApOyxDn7dv/VRBOQF2UOCrK8e5tp/2H3pgcj3BmpVQ0K0lgpOx/1nVwSbLy9dvylqwFo3w7mnCFL2mi+sRPDUmKiM0HvTBKFwuPfB3uFlEtbTnRRaoGeBO9buSVHmrn5+dPFTBA2xOUMAXPsrlO+SQFME3bCg+s/w7B4PlEIxXRDp4Jatfjl3yvy6bdwHuxKIYLjIZ/fsLvY2KHjWnvqoBBq0zcMDsc9b81z4U/qSPSmQsdmnekoIDLo09+/pcbDrgGb0a74AA4uzHQ+hf4rgWkNUYFS3g6MqtN2r6YEMQI/qj2ONbr1DA6oqSOt6KT3dzR7GZEXQ7NL1yIJ20NTc63rgxDIjkVAWS+8TuxasmyJIm0aqUuYxYmyYPJ2PUtABO92rsSMP2z5RGdztkiAHDyF+6MItTM0ZTZsiCJmvrnb+c8seqmE8R8hCIHIh6mDSwY0YNXErK4Iz3DqSYuzxAwYPc2eKHtijFfNR09wGto4teI+a0QG3eSl4TgwM9zmFkgS94unQvRsr4V8GbXvCxFEQJGt+p8vCtO1hJ2ydHohH1EGi0iMvIAzP1wVSII/xiiFEWFfbXTieJcErLybeD+Qws3h78DBxUiCzIDrvqw3loHGgMVUE/V+PzToiBbbBgZf/GitKgTsk59WGcsR4/Bg1CYKG///bu7mdga9hpYiCnR3JoPBjAoFXQ/3h9oRAlMLEL6M1zFPxRmhToiBlzzhLhouxa9KGiXJWBP90veALvqAe+A9Y+/raq4zIOgAAAABJRU5ErkJggg==','RDV-698F07772BC99','2026-02-13 12:13:59',8,5,20,7,60,'low',2),(8,'2026-02-26','11:00:00','cancelled','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAACzUlEQVRoge2ZQY6lMAxEnVWOwU1JclOOwYqMXeUA+r2ZdQlEtyLy2PiXy46x+Z+XfeAHfqAk2M2vrdejzLjbuV1mu991jjP2iiI4/O/c5umb/n/rto3TbwfjpQT0wNOKh6ROIlc9Ija+RqjioS7oojBslpNBivAUdfCq6w0Xfw0heEIog0gFisITouCJS6MxRX5zRgSk7SHp/95//VEE5OXhiQiF5bs6wgZcGs+lB0LvgcDgIyCgrnUPSZDCP63F8gB17MyMeewImB5It4uChlynH4zb76cq6Ipwa98ggYiNv9FzcdgjCinwoudFYPAYa2TAYWtLD+wIAxQRC+/gGgI2UO46zU8PRD1vyHU26aA2GIAsOKmCiMrdzSE5cLPB0QMH2xY4nGv/QrTo8f3X9nRADw9+d+6gp6tZ6Gh7UxHscRyJqk6zL6hyeBhxsqewa4HvpjWHLtHT7fX2QkEwGjfDMTSCkYFhZWPkiiLYK3s3tKsrSFhDHfUdRy3wzKHLU9zghQUtbVEEl+FBGma3+bX1XBK8CFTkRKbCXfFgfoog2jRWM46XPELewIY0LpzPmiJ4pQRmX71Mw9Ecgclzqh448LP3HDIZC/tYE/T2HM60QOw3TBD3ZfaZ+ufPCFkHnHB0u4flUAecD9nw8kctME/eaFQntMD58bZqviBI1TccRhGe6GVGnM/mCp4geGXzsuElz4eNngeNvFNBDewckNPqOGSCQDiMaYpg6iK/hsWZzPLbftb2oghS/i2nquzoaHi++f5cIAVGQUOJ220dSWd+M+FaEkxdoHVFVV/NLDygv2ZSSmA3Wh1myZOGd1AbBUfVogiGl2OT0ihsZyAQVPXb9rTA5zNgdOiWZ/HneFp0wTtCVnN+vK/J4tQFx0sXaYFoZMa721MCJ78Y5Kewi8UtnoASBZftwerqOpfb4wS//igB/tf1gR/4gXrgP4SZcRsMvHGDAAAAAElFTkSuQmCC','RDV-698F07EE44340','2026-02-13 12:15:58',8,5,20,5,30,'high',1),(9,'2026-02-13','17:00:00','cancelled','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAC1klEQVRoge2aQXaDMAxEzcrHyE2xfVOOwcqqNSMRkpdF1/PIa3kFPl2o0mgkWuyfn/KAD/iAkmAv6/MaZ9nrsZnN8prVhh37Op5+b1MEx/o+Xzza6Zd7PUq1WY+2rhDQA9fN00Oy7qw4dQ8PET+uU2EwUgO5sIK0F+SIPFi9JhCPlRerJo7FKoMogo5g8HQgIzYWx3fNiIApez+/fumjBMgPNZ7BWImAHHlddxVBl7eZSeGlEJLvtwr6nh7Ys5ut446oTNc86IGroChY0M+R9etOAbWurMCs03YXACFwQOkHUgNH1/ir123vUpACJyyMnTQyUQE7Hg05VAT9Au4j970swstYGlhF0E0rPMuEnWFb2yEDSJOrFKRAY+LjspvWii5X8QuuatADUfS7N3OX9p3zis+j0INbeJRAKJzr+hayhyYPDZhwcKrghmlsgRNexkOFUzQ6RFAOZDBKWldLIYSpOW6GXQrMWYSpEda1uFsHtYKkCBoUvXOdBqPa6WFD/64WJwUOTJ80sDsXLRVWLiThbl11wAxPbE834/YlBI96rwfOUjLlfQAtMZJSFe6lIAWyDtDNMH2mYy3cL967ghBo7GzQ+/Xzutk4nuIHYdBQCgX9vHFco6FLz64HXuMIGjsHcce7x4iREwTDvOCP37MgBoWBjyqCzH3MoFg/xEsD73uz2keLEwJ7jJ5o7NixNQ4r2LSN90gqBc7KrfnRcrPIUFm89XV5EATxcsByNmVIGseyk9ESBA2Tyo7e3niezp2WdiiCaWRi3bLX3DIiTT7iKAQOjiO5gehf4ymdnRx45UXLdVrPuv+aZ5TAsC25PR3ne4vMUjBF0Ov7fGV7j5G0wMt8hkcLPLlBRDWs6i/Xf3bEcnHogj3XS8Zo8X1RibcHquDESrXhiVK5k8Ce6Ts8KuAVj5hEjU/TxdvbukqBIXug/FoqQcsNa1ME//V5wAd8QD3wD1HTlPduyJLxAAAAAElFTkSuQmCC','RDV-698F08A99D80B','2026-02-13 12:19:05',8,5,20,7,60,'low',1),(10,'2026-02-25','15:00:00','pending','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAC0ElEQVRoge2aMZKlMAxE5YhjcFOwb+pjOELrbglDbf1g4i6oCQw8Eo3Uasvf/I+XfeAHfqAkWG1ee/N+jn2uy9ivzX2uN28D74oi2ByPr60fZme8nx+5zyfzNgE9cDAkNmOzN4DzC9zeAduFwfmeqeETcebCsfWiDiIeWAAx5MX8wpTBLIWpBAhMwZNuG6rBf9aMBJiyN37+/dBHDTCuGR5oANOhUQVnajyXHsh8r8iCXhitgqTwYK9tJYUUeFHhTsrADAzSZOp9VIZ3iJ8iOMsdCBtaA4WANVobUqLgsEwBpkaBl4HsUfm6PUkhBdLIhH3DY9aEh5VLOVQEayQ7Sh+pEQb2olsvkSOKYBiZk7V+WBq6Qi10XdCj7hEVxIOBQa+7AhlPY1cCw7Gmws0F9ihxG3nRRcH5z4fCnan0oEL2uHjpoxDouU1BYJzCH/2t3FZOEqTa+dJ7KIFxGhFrUdAjGCz9tV6qUJ4WJwVerHV0dbPw7I01wd6efV4PXA2tQu1QB5CEEdMItPqiCObIgRpgFhaGpsYzbJLgeu/h05n+/PpeK4J0LtHNODm23KhVdnh7l4IWSOtKUaejKfc+lQ3/6QpK4JXGvOf7UL7XAYIkiNjQvZ6+dqKcJd9yKAruHCk9A+OWQxdWw2vUpATCrlocDdkRhp0hARuzVUWwMdmbh2lFghycMh65Jd0lQQgA767I/S2PPVtOoWTBGDbU3J2wOLhLcw5jTkXQ08EhSBw84IuaG1M8KYogl2FkYtp0ZwRK4b9zBR0wnEu7D3srv6Nhz7UkmHmRjia3pCgCBqm+hqlKYLVocXjj71BZjJMfj6sEMhjo6udY4wckhcX44WXipMCRYQgjUyMyW8+yGMog9mF5VJJT5CMni6sUBEEqXOzJkCMX66PdFk8Q9HxzxtmvPb/jACUKLtkzy7MCpwAUVn997IwU+KfrAz/wA/XAf+GhQTlB557CAAAAAElFTkSuQmCC','RDV-698F0A13088C0','2026-02-13 12:25:07',8,5,31,5,30,'high',1),(11,'2026-02-14','15:00:00','pending','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAACx0lEQVRoge2ZS7KrMAxE5RHLYKdg75RlMLKe1C0n5FUGd9wVF6EMHCaKPi1h/sdlP/AH/kBJsFusfdx733zc1tyHX+22A5exmiI44nfvc/MAY4P9dfp1xDkuCeiBYZJ4aHl2mGfa3sNgniA2smC4xlEPLT0iLrerqYNhnhMRkGvLmKfBZMEKhXB/PEQCOHDpX2NGAnylvW/H1/yoAHLN7R3ucfTtomvU0gPxvK/bHaEwcXSchyhI20QE2HZlPc9NvLE7YqIpghAv6QvxJN44kO0G039SmuC00jLM+qznM0MhRY29nUIN9BKqOxwho79cg+lQEYS/M9zz/++o8LbEeyUGOTAMAMWaeGyYCdrbVJrgNEZ/IqxsA40a8z0lvB7oS6HTQr0iAw7ykfa0QIoXFLQG9Xog5620pwmOJWEoVG1p9oYQeSR7KbA/JAzd4cQ04j2EUAQdyqWxysFUDTfLbI82RQkciICBvL72kK5b9SunItg5XEGOnzgPmmdpuqYI8v8fK+e1Co6Mg5XvBcGUb1aWyBzP+WJSr70g2OH1yPeoaajwp6NXq5ua4Hi1pOhL3MtgjjeGIgj3r9YzFSsT/F1N+fns4oTAbM6shohxG0qWQua/wbkUOJHYaqKW/egqcfhUMp9pTwlMJ0Bbli5AUYPhEyveRyjogAOOQdFqS7eWhvUqgHogetC8yqGaUddU3E97hoIUONawgb7fkQUb2rKcwfhb4yqBZP3G1AH9SlsalrW9KYIscRkByATjId7943OBFIgkx6+7WdYo4hj95SCK4Msvct5wc+KSNjsf7Yse2OELE0e3ZSesxsZUEcxcTvend6ANTe9YVX1IgvfDDGuymGursZMw6KXNKWGo5jhFxhIFOwr74HNoWKNtHmpPCkQoUK+lruEXYHwNS0oU7GmImpQbSrqvjm1pOkHwT+sH/sAfqAf+A5TIKu+XnP9BAAAAAElFTkSuQmCC','RDV-698F116B1F846','2026-02-13 12:56:27',8,5,20,10,30,'medium',2),(12,'2026-02-25','16:00:00','pending','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAC3ElEQVRoge2aQZKrMAxE7RXH4KaAb8oxWNlf3S1DUvmLWXdBMVUJPDYaqdUSKeOPR3nBF3xBS/AocaxHnMtZxxmf42IvZVtGu3CvOoIt/q614Sz1WuPzwef6cu7XmoAfqPvj3JZzY6g6AoMrOx8yBpUaDfhghCIpzmoPLqgJxiNyHzURoXIGWQpR/UgHlns8uoPF9Z+aMQEzHa7/nr/6aALq6AWCF2cEAwmCHFnvu44g5K0v2dwQLfQ6sKEH+uwH9ruboQLwVeLH8KADWIIH1D1CQtmDnQHOK2d83T8EwAmMKt+QESHtkHlSCgzw+pSCFdip8erqhaWPi6oDyaEj2NjG1dsbkGjpKI7K51AljuCRRjX1nm1tVcx2xqY5gtK5Ige3ICTqcp1nVoMdeKRDB4UxZaogi+BHH41AhEGjGCtgl2FfhpzssARLzt+D1R8B2sqaF7/sjBXI6g/Zo5dRSNj0Nu5dDlNwaArnYqnm1FJoYxGqstxJYQV22XMIwJgjKfYuR+rf3eKswLl+mAJACaTG4/NHi7MC1cQYkmCfvKhEpPd+YJ+Xh6wrBY/ZgVKg+BmC+rfrjs7COBU1/EcArMD4psSXY21zybRfsnWeYKfgqfQbU6DPdctWcvnkB0rwmhZOsO3o6nvKQK5XLcFC96pEqHNcgzDI0jqCY8iv0aFzRtk0o1w5mjdH8Mh1C8LQ4daxZmOC6M3YkxROIE06iyDHcbBbblJzM2EIllR0OZq8mS2OoXIEiRSO3Wt2+CvfGLTr8zWgFXgbGbL5BKcWmJqvOBqBjVN4nYMpO5tkgDZ2PBO7EzjzQr19tjhdHF/rBydQtoWNjuaFvrXyaz7tCCIS1zrmi4ImPWCCtDtUfiDr4KaY/uh7h5aLHzXjB9KuIj1qRgsGp+jnab5gz9ValoKOmsLgCDIefXlsO+1b/iptPNbVCpyyN3U9tw54VVI0sTmCfzpe8AVf0A/8B4OIJl1yq7u2AAAAAElFTkSuQmCC','RDV-698F167722E27','2026-02-13 13:17:59',8,5,12,7,60,'low',1),(13,'2026-02-20','10:00:00','cancelled','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAACyklEQVRoge2ZTW7rMAyEqZWP4ZtG5k19DK2kR85QMZq+RdeDGG6h2J8KlCGHP7L1x8u+4Bf8gpLgZXGda5w+zuu427p73OOMVz7yXVMEPX7y8f068gZlL+4gLgkOa2EYs57r3BFsWCU35fNTGTxWWii9wyzXYZW7qYPT+DvtFGDuK7OJggyFoML9R4Z7UPF+HgyRz5jRACl7Pv57/9ZHEXBfsA3M41C+kIH2fikIJtLTTtselevSHSI4JEE+g+ytScGDO+ytmmA8e0HbPHM7KKi+Y9/En9EDZ6l7UpT2MNWkg+TCJMEF80RAGAq3HQfx8aN0lQJnZjNUbbjbQCZHkmdud0UQtVt8/1mozifdWX18QkEOPJZXFWPsUTrT3S5j9cDJKOeXjx4FmpduYj9lTwpEiIfgXdWNhXlK9hr8oiuCjuo1nqX+HVxXk7pTnyKYDUp++VZtyv0WPwfeFEHGPXJ4+oXBPP0x1bkUwcXWBDnNYRWKX9/PXRGkDbLztnIEXzQVnOKRPS0Q+Y2ZvNap9OdbDl0RXIPjJaZ3ZDZMXCpEHrGXAifmpg2hgHUGR0eI2FGBIgk2uMO1+7O5czv84u6KIEK8qvUXPAKyRwnMvCcJLnYkR/XfvNfao5cfWUEHdAyP4wGqdcg8g4PRYJog7XFBA977oHfWaiYhCK7qQdPxOTa+MJDAAAYqKAnWaWf2pg4LrV26LmS8rgj652lnLpjobA8a9UC6fxkJxqDsXQiI9iR2KZAl6twz4wuH/GWqH+aRAv19oD1qwtRgsxK/Y0mCvOACCTa2LHuHj1MSvNIIJwWelTt9YY0qaZcimP/92CcDMIbXQ9umUgT3SYivEvtM6cjq5RfC4MB5SC2g99z9yzxK4EQ5cyEm2Lj42FNGSbBC4aRTOHyhg+o4Av0UAAmQssf0Hi9fWBumTch4pyT4p+sLfsEvqAf+A8IEsKyG8/n+AAAAAElFTkSuQmCC','RDV-698F175E43B85','2026-02-13 13:21:50',8,5,10,8,30,'medium',1),(14,'2026-02-14','14:00:00','cancelled','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAACzElEQVRoge2aPbKkMAyE5cjH4KZg35RjEKF1t2Q/2H3Bxl24qCnG/kg0UuuHMf/PZR/4gR8oCTYba7tt82vr2Dz36rdZce8XzooiiEMgZ7m2Zts4HCd3PQ8/j2tLQA8cJwMcezTGEc+N+woQj0qDcbiPy7Djy2C6YKvnCIiGazpF7KuCMxQsDock1JMs9n+LGQUwZK9fv17/6qMIOBciILaHqY75mUsPvDYmNIZChbUKfeSgm6QQyoHjlx+3SOxxfy3Ns5Hh/ZXidMAldbipOD8iAoAPMRAFKxQOF3WdiS6tcoM6iyLomcoi+uH7xnN8vmVPCVxmCAHwlx4M21D89EDYgAhXm0aiAEiD+P3Rn92Q9jO84+C1v6o9HdD5+0cn2uj+O4WfHvGUPSmQmsccjguSz8hYIcIlBz5CHxmeJ9GWGT1iib0U2PjNYJUzChljQByrRVMEfUY8gn7mtKEE8BGKnygIR4jk1lGqR+jH9QwFKbDzfDj+gVBgENAwxj71IXtSYFasnlOWELyled01Qb+iTUGK61G6WgyfYjLx7F11wD7HDDQJp+Y5WRxusvkjFJTARo2/s0rl6KVGhrd4qEiCTGiFTxDBFJll3WpZFMGs1s04Qr7jLQGjv71SnBTYeds9B8n5uoCjprLKOjnwnqFgeAnGDD/FLyaLRRFs2YrlE8NBfE4ZU/8UQUcPisW4D0dI8WOqlwXLPCk0ic22bGd76pKg57w8pg6o6fiozdzeFcFIYqHxPUvXEAOUNv6scYXAPocNtAStQpuFd1jVBGM1Kv0yzz7/w9J+xF4KbDDC1qYX9GxQ8q1ve1V7OiB+c2ywgvtpT+Egb/Nogey/wwV6lKt0k77aU13Q81UJW7QQeK67Pl+SqIFRqq9OBTvXLHAkQc+/59AvTo7Zogv/2ymUwIYvm6fS43DnYBUOMkdueuB/rQ/8wA/UA/8AyGkrJcWI9hwAAAAASUVORK5CYII=','RDV-698F1A309D148','2026-02-13 13:33:52',8,5,10,11,30,'high',1);
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
  `admin_feedback` longtext COLLATE utf8mb4_unicode_ci,
  `frais` decimal(10,2) DEFAULT NULL,
  `documents_requis` longtext COLLATE utf8mb4_unicode_ci,
  `categorie` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E19D9AD237E080D9` (`banque_id`),
  CONSTRAINT `FK_E19D9AD237E080D9` FOREIGN KEY (`banque_id`) REFERENCES `banque` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (4,'ZAAZ','SDVVSDVS',30,0,5,'medium','AAA',21.00,'DSQDSQD','Epargne'),(5,'Compte Courant','Ouverture de compte courant avec chéquier et carte bancaire.',30,1,5,'high',NULL,0.00,'CIN, Justificatif de domicile, Fiche de paie','Compte'),(6,'Crédit Consommation','Demande de crédit personnel pour vos projets.',45,1,5,'medium',NULL,50.00,'CIN, 3 dernières fiches de paie, Relevés bancaires 3 mois','Crédit'),(7,'Assurance Vie','Souscription à une assurance vie pour protéger vos proches.',60,1,5,'low',NULL,20.00,'CIN, Questionnaire médical','Assurance'),(8,'Epargne Logement','Plan d\'épargne pour votre futur logement.',30,1,5,'medium',NULL,10.00,'CIN','Epargne'),(9,'A','A',30,1,5,'medium','boubouboubsdfjklnfojisdnvsioqdnvjosdnvidsnfjknsdiofnsdionfjsdnfjksdqnfkjdqsnfdsqfqds',0.14,'CC','Crédit'),(10,'AZAZA','RADFIJDFGJDFG\r\ndfGFDGDF\r\nDFGFDGDFGDFGDF',30,1,5,'medium',NULL,1.00,'C','Assurance'),(11,'MMMMMMMMNEW','SDHIGBQIULYFBSIUFBNQSDIUFBUIDFQBVIUSQDFBVIUYLDFQBVIUBVDFUIBVNQSFDVEDFVDWQ',30,1,5,'high','please change the name',1.00,'CIN','Crédit');
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
  `roles` json NOT NULL,
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

-- Dump completed on 2026-02-13 13:38:09
