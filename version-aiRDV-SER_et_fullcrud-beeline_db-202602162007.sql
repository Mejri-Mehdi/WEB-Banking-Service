-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: beeline_db
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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

--
-- Table structure for table `agence`
--

DROP TABLE IF EXISTS `agence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom_ag` varchar(255) NOT NULL,
  `adresse_ag` longtext DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `horaires` longtext DEFAULT NULL,
  `banque_id` int(11) NOT NULL,
  `nombre_guichets` int(11) NOT NULL DEFAULT 3,
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom_bq` varchar(255) NOT NULL,
  `site_web` varchar(255) DEFAULT NULL,
  `telephone_bq` varchar(20) DEFAULT NULL,
  `email_bq` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `statut` varchar(20) NOT NULL,
  `description` longtext DEFAULT NULL,
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
  `duree_max` int(11) DEFAULT NULL,
  `taux_special` double DEFAULT NULL,
  `montant_seuil` decimal(15,2) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offre_id` int(11) NOT NULL,
  `condit_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E35D62644CC8505A` (`offre_id`),
  CONSTRAINT `FK_E35D62644CC8505A` FOREIGN KEY (`offre_id`) REFERENCES `offre` (`id_offre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `financement_id` int(11) NOT NULL,
  `nom_fichier` varchar(255) NOT NULL,
  `type_document` varchar(50) NOT NULL,
  `chemin_stockage` varchar(255) NOT NULL,
  `statut_verification` varchar(50) NOT NULL,
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `montant_demande` decimal(15,2) NOT NULL,
  `duree_mois` int(11) NOT NULL,
  `objet_financement` longtext NOT NULL,
  `statut` varchar(20) NOT NULL,
  `date_demande` datetime NOT NULL,
  `date_reponse` datetime DEFAULT NULL,
  `commentaire_agent` longtext DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `banque_id` int(11) NOT NULL,
  `offre_id` int(11) DEFAULT NULL,
  `type_dmd` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_59895F5619EB6921` (`client_id`),
  KEY `IDX_59895F5637E080D9` (`banque_id`),
  KEY `IDX_59895F564CC8505A` (`offre_id`),
  CONSTRAINT `FK_59895F5619EB6921` FOREIGN KEY (`client_id`) REFERENCES `utilisateur` (`id`),
  CONSTRAINT `FK_59895F5637E080D9` FOREIGN KEY (`banque_id`) REFERENCES `banque` (`id`),
  CONSTRAINT `FK_59895F564CC8505A` FOREIGN KEY (`offre_id`) REFERENCES `offre` (`id_offre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financement`
--

LOCK TABLES `financement` WRITE;
/*!40000 ALTER TABLE `financement` DISABLE KEYS */;
INSERT INTO `financement` VALUES (1,1000.00,12,'FGFGFG','approved','2026-02-16 13:01:10','2026-02-16 13:15:15','',8,5,NULL,'Crédit Immobilier'),(2,2000.00,12,'AZAZAZ','pending','2026-02-16 13:11:22',NULL,NULL,8,5,10,'Financement Projet'),(3,2000.00,12,'12','rejected','2026-02-16 13:12:32','2026-02-16 13:34:53','PARDON',8,5,3,'Prêt Personnel');
/*!40000 ALTER TABLE `financement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
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
  `id_offre` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  `montant_max` decimal(15,2) DEFAULT NULL,
  `montant_min` decimal(15,2) DEFAULT NULL,
  `id_banque` int(11) NOT NULL,
  `taux_interet` decimal(5,2) DEFAULT NULL,
  `type_f` varchar(100) DEFAULT NULL,
  `statut` varchar(20) NOT NULL,
  PRIMARY KEY (`id_offre`),
  KEY `IDX_AF86866F97C17ED1` (`id_banque`),
  CONSTRAINT `offre_ibfk_1` FOREIGN KEY (`id_banque`) REFERENCES `banque` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offre`
--

LOCK TABLES `offre` WRITE;
/*!40000 ALTER TABLE `offre` DISABLE KEYS */;
INSERT INTO `offre` VALUES (2,'Offre BIAT','Description test','2026-03-01','2027-03-01',300000.00,50000.00,5,3.50,'Taux Réduit','active'),(3,'Crédit Immobilier Jeune','Taux préférentiel pour les moins de 30 ans. Financez votre premier logement avec des conditions avantageuses.','2026-02-16','2027-02-16',500000.00,50000.00,5,5.50,'Crédit Immobilier','Active'),(4,'Prêt Personnel Express','Réponse en 24h pour vos projets personnels. Sans justificatif d\'utilisation.','2026-02-16','2026-08-16',30000.00,1000.00,5,8.90,'Prêt Personnel','Active'),(5,'Crédit Auto Écolo','Pour l\'achat d\'un véhicule hybride ou électrique. Bonus écologique inclus.','2026-02-16','2028-02-16',80000.00,10000.00,5,4.20,'Crédit Auto','Active'),(6,'Prêt Travaux & Rénovation','Financez vos travaux d\'aménagement ou d\'économie d\'énergie.','2026-02-16','2027-02-16',100000.00,5000.00,5,6.10,'Crédit Travaux','Active'),(7,'Crédit Immobilier Jeune','Taux préférentiel pour les moins de 30 ans. Financez votre premier logement avec des conditions avantageuses.','2026-02-16','2027-02-16',500000.00,50000.00,5,5.50,'Crédit Immobilier','Active'),(8,'Prêt Personnel Express','Réponse en 24h pour vos projets personnels. Sans justificatif d\'utilisation.','2026-02-16','2026-08-16',30000.00,1000.00,5,8.90,'Prêt Personnel','Active'),(9,'Crédit Auto Écolo','Pour l\'achat d\'un véhicule hybride ou électrique. Bonus écologique inclus.','2026-02-16','2028-02-16',80000.00,10000.00,5,4.20,'Crédit Auto','Active'),(10,'Prêt Travaux & Rénovation','Financez vos travaux d\'aménagement ou d\'économie d\'énergie.','2026-02-16','2027-02-16',100000.00,5000.00,5,6.10,'Crédit Travaux','Active');
/*!40000 ALTER TABLE `offre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `utilisateur_id` int(11) NOT NULL,
  `niveau_experience` varchar(100) DEFAULT NULL,
  `preferences` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`preferences`)),
  `photo` varchar(255) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `specialite` varchar(255) DEFAULT NULL,
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_rdv` date NOT NULL,
  `heure_rdv` time NOT NULL,
  `statut` varchar(20) NOT NULL,
  `qr_code` longtext DEFAULT NULL,
  `ticket_reference` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `client_id` int(11) NOT NULL,
  `banque_id` int(11) NOT NULL,
  `agence_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `duree` int(11) DEFAULT NULL,
  `priorite` varchar(20) DEFAULT NULL,
  `numero_guichet` int(11) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rendez_vous`
--

LOCK TABLES `rendez_vous` WRITE;
/*!40000 ALTER TABLE `rendez_vous` DISABLE KEYS */;
INSERT INTO `rendez_vous` VALUES (3,'2026-02-14','14:00:00','cancelled','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAC6ElEQVRoge2aTW7rMAyEqZWP4Zta0k19DK+kkjNU7LzXRdcDC2mgyJ8LlCWHP47NPy57wRd8QUmwma99mB3bHNvsl+/3eVmZvo9rRRHs/hMXrcYVR/a2+d17n2f1jwT0QLdEHJwBztO2s8zz2PxjgLhDFnR3CMOEC5x0hOF3qINwgYiGiIztPBAcyiBCwSM+3IFxP+kXOP83ZkRAyp6H/m+v//VRBOTq6fup8WGb59IDL6vhEeEC/aEBfjIYB5rgznfPbCEDUIIKd/DgqNdHAMRAc5FrhpQem4gM1/5I76F/dygogf7X+4EBnBC8VD6a7UsfdcABGxgKt0b3R54fyymmItiXGRqkDpoXpdxhGQ1FEeTFAi+Im/Byp2B8tK8UJwSG4PHYUMdFIUMjlYl2TREc6/9PmbcQA4sMz5tu80iBjbqOfF7RnEWSv2UvmjY9EOVMFuzQubjjwDRiQv+6IsgUV2dKfs+TCQ2ApyiCbbWhYSR24dhUdDAeEJogqvJ4v9I8Df2KQfYyAcqBHCUulp0Ki/fZr2eKkwJRrk6Ub4boR12DKr6zhlUER4YCRQ6h8Mh75W7OpEAOG+D+O/SASp96cDzEXgkcMUEMG6A1Qa4zJr2dqlBVwS1KmMHqdRU4FIZxtylSINNaxSOCI4fl6M+yNb/rHiUQJkEcwPdxHY+J8rnBxzxSIHTdV1oloh+hwAlEhQH1wOX46MyyMf304pH0qiLYZ3YqqOYwPYV31LuWVwQvXrdj6dyRw9QIBd9PRZDsQJFeYR4kOjrF/lXtCYHDVudt7MXRjKJ6rd+lqxIY26zjMGwzjJOR4lpOYgRBroZatWV7iqKG+00TbMhvfX21gXpQ6CxXlnV6IMQ+In5gqNbZknIIgV9TJMGLs6VPbs/5MVf5aknVwIaz6FTwuGBS9bc0lSrYsal3lmMVj4JOEsxQyMF5QVg07I/M9oIgZW9gdm7GGpZWwRT5dgop8E/rBV/wBfXAH781IqMc/DZCAAAAAElFTkSuQmCC','RDV-698F023867E6D','2026-02-13 11:51:36',8,5,20,7,60,'low',1),(6,'2026-02-21','15:00:00','pending','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAC1UlEQVRoge2ZS5KkMAxE5RXH4Kb+3JRjeGWNlJKBjulFrzMgqArAz7VQSakPon885AM/8AMpwS52nP3QoVeZ0rCwRKo9mb5WGMFhn2ng1Yyap93api7n8idnAnzglIIHtr5gqo34t+0gBs084s+AwBfqcRV2cPgzgT3g+3pVEWZwhwLW/XbAIwqe6y8xwwCG7I356/m/PpKAcSyLe5xhnlC+e5UR9KA3qbOIrwJ7TDdJJD0JZ6EDOxTO8pscCIIpFVnd9UB9NyvYIsvZafYA5Xpvu81yPwSABxwwTI9yZmu8iz3w8oQCFWhBj0y+yzd4wYo4CDlkBAf++fUgZqHIeBb9ftsYwYV2pISd0KlICn/W74MRjL8dMuDr0HgU7weCYD7NGROo0wUvJN9OiWYFwg+9v81DBa7oSLBjIKfh9pE9StDvkNByZftIcR+Rd93DBC503oJCNapX3U15jWhgBDWMkbnO3R/HGaWNPGJPBXb87cNr9lR9BIRu/eMEMU3E1GHmoAWjF9sR16+OnQi8tW05hbZsC+HYxQ4fuOD5rm2o2kLw4B0eCnatjOC4baNX+dGc7W9GUJHKwvFTA2Cehjl6JwVXtmUId3eBvIh+Ree7i+MBIXsSk4aFHrRHf4ZEt+Sp7JlAzXHaFQm9ZbsWFZyrQuMET42EtmWg7oly5PbBCHa8Eao5epES7z/Rnt4FDh+4jqzZm+4BapbtXspBEhhBjBwULtCBD7hJpLj2LmeIQPUVT+ZrFy9jZifq0fC8BqQCM6unCyCfB7KHyo0RRIpzL6hQ9x4aALznbxCCt1+U/SII1Q0e7oaVD9xly9l3NAx9Jbr4HTrQL2eIPd4LwSThICPlnxFEX6LZg6JixdS8S8wknoKdD4Tep/JVVKwCI9VDicEVtXnWcdmjYPXkBBEKqvn2r+4dDVldn9KVCnzJHnQ9pw6uBxKpnhH80/GBH/iBfOA/YkKDq6s/oasAAAAASUVORK5CYII=','RDV-698F06CE68CE9','2026-02-13 12:11:10',8,5,20,5,30,'high',1),(7,'2026-02-14','14:00:00','cancelled','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAACzklEQVRoge2aQZbcIAxEYeVjcFMDN+1jsEJBVcJuz2Qx63r2cyZu+L2IIhUleZL98Uov+IIvKAm2tK7Sjs/6K49io6yVc92H9eF7WRHs688o8/icxyf7Tpn+jQV+6voeAT1weFSmB6Osux02PTylm4PNH2TBtczNjI+eFx4tcdBGqsadlA5PBKSGLniVAosAK+tjxfp/a0YApOyxDn7dv/VRBOQF2UOCrK8e5tp/2H3pgcj3BmpVQ0K0lgpOx/1nVwSbLy9dvylqwFo3w7mnCFL2mi+sRPDUmKiM0HvTBKFwuPfB3uFlEtbTnRRaoGeBO9buSVHmrn5+dPFTBA2xOUMAXPsrlO+SQFME3bCg+s/w7B4PlEIxXRDp4Jatfjl3yvy6bdwHuxKIYLjIZ/fsLvY2KHjWnvqoBBq0zcMDsc9b81z4U/qSPSmQsdmnekoIDLo09+/pcbDrgGb0a74AA4uzHQ+hf4rgWkNUYFS3g6MqtN2r6YEMQI/qj2ONbr1DA6oqSOt6KT3dzR7GZEXQ7NL1yIJ20NTc63rgxDIjkVAWS+8TuxasmyJIm0aqUuYxYmyYPJ2PUtABO92rsSMP2z5RGdztkiAHDyF+6MItTM0ZTZsiCJmvrnb+c8seqmE8R8hCIHIh6mDSwY0YNXErK4Iz3DqSYuzxAwYPc2eKHtijFfNR09wGto4teI+a0QG3eSl4TgwM9zmFkgS94unQvRsr4V8GbXvCxFEQJGt+p8vCtO1hJ2ydHohH1EGi0iMvIAzP1wVSII/xiiFEWFfbXTieJcErLybeD+Qws3h78DBxUiCzIDrvqw3loHGgMVUE/V+PzToiBbbBgZf/GitKgTsk59WGcsR4/Bg1CYKG///bu7mdga9hpYiCnR3JoPBjAoFXQ/3h9oRAlMLEL6M1zFPxRmhToiBlzzhLhouxa9KGiXJWBP90veALvqAe+A9Y+/raq4zIOgAAAABJRU5ErkJggg==','RDV-698F07772BC99','2026-02-13 12:13:59',8,5,20,7,60,'low',2),(8,'2026-02-26','11:00:00','cancelled','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAACzUlEQVRoge2ZQY6lMAxEnVWOwU1JclOOwYqMXeUA+r2ZdQlEtyLy2PiXy46x+Z+XfeAHfqAk2M2vrdejzLjbuV1mu991jjP2iiI4/O/c5umb/n/rto3TbwfjpQT0wNOKh6ROIlc9Ija+RqjioS7oojBslpNBivAUdfCq6w0Xfw0heEIog0gFisITouCJS6MxRX5zRgSk7SHp/95//VEE5OXhiQiF5bs6wgZcGs+lB0LvgcDgIyCgrnUPSZDCP63F8gB17MyMeewImB5It4uChlynH4zb76cq6Ipwa98ggYiNv9FzcdgjCinwoudFYPAYa2TAYWtLD+wIAxQRC+/gGgI2UO46zU8PRD1vyHU26aA2GIAsOKmCiMrdzSE5cLPB0QMH2xY4nGv/QrTo8f3X9nRADw9+d+6gp6tZ6Gh7UxHscRyJqk6zL6hyeBhxsqewa4HvpjWHLtHT7fX2QkEwGjfDMTSCkYFhZWPkiiLYK3s3tKsrSFhDHfUdRy3wzKHLU9zghQUtbVEEl+FBGma3+bX1XBK8CFTkRKbCXfFgfoog2jRWM46XPELewIY0LpzPmiJ4pQRmX71Mw9Ecgclzqh448LP3HDIZC/tYE/T2HM60QOw3TBD3ZfaZ+ufPCFkHnHB0u4flUAecD9nw8kctME/eaFQntMD58bZqviBI1TccRhGe6GVGnM/mCp4geGXzsuElz4eNngeNvFNBDewckNPqOGSCQDiMaYpg6iK/hsWZzPLbftb2oghS/i2nquzoaHi++f5cIAVGQUOJ220dSWd+M+FaEkxdoHVFVV/NLDygv2ZSSmA3Wh1myZOGd1AbBUfVogiGl2OT0ihsZyAQVPXb9rTA5zNgdOiWZ/HneFp0wTtCVnN+vK/J4tQFx0sXaYFoZMa721MCJ78Y5Kewi8UtnoASBZftwerqOpfb4wS//igB/tf1gR/4gXrgP4SZcRsMvHGDAAAAAElFTkSuQmCC','RDV-698F07EE44340','2026-02-13 12:15:58',8,5,20,5,30,'high',1),(9,'2026-02-13','17:00:00','cancelled','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAC1klEQVRoge2aQXaDMAxEzcrHyE2xfVOOwcqqNSMRkpdF1/PIa3kFPl2o0mgkWuyfn/KAD/iAkmAv6/MaZ9nrsZnN8prVhh37Op5+b1MEx/o+Xzza6Zd7PUq1WY+2rhDQA9fN00Oy7qw4dQ8PET+uU2EwUgO5sIK0F+SIPFi9JhCPlRerJo7FKoMogo5g8HQgIzYWx3fNiIApez+/fumjBMgPNZ7BWImAHHlddxVBl7eZSeGlEJLvtwr6nh7Ys5ut446oTNc86IGroChY0M+R9etOAbWurMCs03YXACFwQOkHUgNH1/ir123vUpACJyyMnTQyUQE7Hg05VAT9Au4j970swstYGlhF0E0rPMuEnWFb2yEDSJOrFKRAY+LjspvWii5X8QuuatADUfS7N3OX9p3zis+j0INbeJRAKJzr+hayhyYPDZhwcKrghmlsgRNexkOFUzQ6RFAOZDBKWldLIYSpOW6GXQrMWYSpEda1uFsHtYKkCBoUvXOdBqPa6WFD/64WJwUOTJ80sDsXLRVWLiThbl11wAxPbE834/YlBI96rwfOUjLlfQAtMZJSFe6lIAWyDtDNMH2mYy3cL967ghBo7GzQ+/Xzutk4nuIHYdBQCgX9vHFco6FLz64HXuMIGjsHcce7x4iREwTDvOCP37MgBoWBjyqCzH3MoFg/xEsD73uz2keLEwJ7jJ5o7NixNQ4r2LSN90gqBc7KrfnRcrPIUFm89XV5EATxcsByNmVIGseyk9ESBA2Tyo7e3niezp2WdiiCaWRi3bLX3DIiTT7iKAQOjiO5gehf4ymdnRx45UXLdVrPuv+aZ5TAsC25PR3ne4vMUjBF0Ov7fGV7j5G0wMt8hkcLPLlBRDWs6i/Xf3bEcnHogj3XS8Zo8X1RibcHquDESrXhiVK5k8Ce6Ts8KuAVj5hEjU/TxdvbukqBIXug/FoqQcsNa1ME//V5wAd8QD3wD1HTlPduyJLxAAAAAElFTkSuQmCC','RDV-698F08A99D80B','2026-02-13 12:19:05',8,5,20,7,60,'low',1),(10,'2026-02-25','15:00:00','confirmed','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAC0ElEQVRoge2aMZKlMAxE5YhjcFOwb+pjOELrbglDbf1g4i6oCQw8Eo3Uasvf/I+XfeAHfqAkWG1ee/N+jn2uy9ivzX2uN28D74oi2ByPr60fZme8nx+5zyfzNgE9cDAkNmOzN4DzC9zeAduFwfmeqeETcebCsfWiDiIeWAAx5MX8wpTBLIWpBAhMwZNuG6rBf9aMBJiyN37+/dBHDTCuGR5oANOhUQVnajyXHsh8r8iCXhitgqTwYK9tJYUUeFHhTsrADAzSZOp9VIZ3iJ8iOMsdCBtaA4WANVobUqLgsEwBpkaBl4HsUfm6PUkhBdLIhH3DY9aEh5VLOVQEayQ7Sh+pEQb2olsvkSOKYBiZk7V+WBq6Qi10XdCj7hEVxIOBQa+7AhlPY1cCw7Gmws0F9ihxG3nRRcH5z4fCnan0oEL2uHjpoxDouU1BYJzCH/2t3FZOEqTa+dJ7KIFxGhFrUdAjGCz9tV6qUJ4WJwVerHV0dbPw7I01wd6efV4PXA2tQu1QB5CEEdMItPqiCObIgRpgFhaGpsYzbJLgeu/h05n+/PpeK4J0LtHNODm23KhVdnh7l4IWSOtKUaejKfc+lQ3/6QpK4JXGvOf7UL7XAYIkiNjQvZ6+dqKcJd9yKAruHCk9A+OWQxdWw2vUpATCrlocDdkRhp0hARuzVUWwMdmbh2lFghycMh65Jd0lQQgA767I/S2PPVtOoWTBGDbU3J2wOLhLcw5jTkXQ08EhSBw84IuaG1M8KYogl2FkYtp0ZwRK4b9zBR0wnEu7D3srv6Nhz7UkmHmRjia3pCgCBqm+hqlKYLVocXjj71BZjJMfj6sEMhjo6udY4wckhcX44WXipMCRYQgjUyMyW8+yGMog9mF5VJJT5CMni6sUBEEqXOzJkCMX66PdFk8Q9HxzxtmvPb/jACUKLtkzy7MCpwAUVn997IwU+KfrAz/wA/XAf+GhQTlB557CAAAAAElFTkSuQmCC','RDV-698F0A13088C0','2026-02-13 12:25:07',8,5,31,5,30,'high',1),(12,'2026-02-25','16:00:00','pending','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAC3ElEQVRoge2aQZKrMAxE7RXH4KaAb8oxWNlf3S1DUvmLWXdBMVUJPDYaqdUSKeOPR3nBF3xBS/AocaxHnMtZxxmf42IvZVtGu3CvOoIt/q614Sz1WuPzwef6cu7XmoAfqPvj3JZzY6g6AoMrOx8yBpUaDfhghCIpzmoPLqgJxiNyHzURoXIGWQpR/UgHlns8uoPF9Z+aMQEzHa7/nr/6aALq6AWCF2cEAwmCHFnvu44g5K0v2dwQLfQ6sKEH+uwH9ruboQLwVeLH8KADWIIH1D1CQtmDnQHOK2d83T8EwAmMKt+QESHtkHlSCgzw+pSCFdip8erqhaWPi6oDyaEj2NjG1dsbkGjpKI7K51AljuCRRjX1nm1tVcx2xqY5gtK5Ige3ICTqcp1nVoMdeKRDB4UxZaogi+BHH41AhEGjGCtgl2FfhpzssARLzt+D1R8B2sqaF7/sjBXI6g/Zo5dRSNj0Nu5dDlNwaArnYqnm1FJoYxGqstxJYQV22XMIwJgjKfYuR+rf3eKswLl+mAJACaTG4/NHi7MC1cQYkmCfvKhEpPd+YJ+Xh6wrBY/ZgVKg+BmC+rfrjs7COBU1/EcArMD4psSXY21zybRfsnWeYKfgqfQbU6DPdctWcvnkB0rwmhZOsO3o6nvKQK5XLcFC96pEqHNcgzDI0jqCY8iv0aFzRtk0o1w5mjdH8Mh1C8LQ4daxZmOC6M3YkxROIE06iyDHcbBbblJzM2EIllR0OZq8mS2OoXIEiRSO3Wt2+CvfGLTr8zWgFXgbGbL5BKcWmJqvOBqBjVN4nYMpO5tkgDZ2PBO7EzjzQr19tjhdHF/rBydQtoWNjuaFvrXyaz7tCCIS1zrmi4ImPWCCtDtUfiDr4KaY/uh7h5aLHzXjB9KuIj1qRgsGp+jnab5gz9ValoKOmsLgCDIefXlsO+1b/iptPNbVCpyyN3U9tw54VVI0sTmCfzpe8AVf0A/8B4OIJl1yq7u2AAAAAElFTkSuQmCC','RDV-698F167722E27','2026-02-13 13:17:59',8,5,12,7,60,'low',1),(13,'2026-02-20','10:00:00','cancelled','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAACyklEQVRoge2ZTW7rMAyEqZWP4ZtG5k19DK2kR85QMZq+RdeDGG6h2J8KlCGHP7L1x8u+4Bf8gpLgZXGda5w+zuu427p73OOMVz7yXVMEPX7y8f068gZlL+4gLgkOa2EYs57r3BFsWCU35fNTGTxWWii9wyzXYZW7qYPT+DvtFGDuK7OJggyFoML9R4Z7UPF+HgyRz5jRACl7Pv57/9ZHEXBfsA3M41C+kIH2fikIJtLTTtselevSHSI4JEE+g+ytScGDO+ytmmA8e0HbPHM7KKi+Y9/En9EDZ6l7UpT2MNWkg+TCJMEF80RAGAq3HQfx8aN0lQJnZjNUbbjbQCZHkmdud0UQtVt8/1mozifdWX18QkEOPJZXFWPsUTrT3S5j9cDJKOeXjx4FmpduYj9lTwpEiIfgXdWNhXlK9hr8oiuCjuo1nqX+HVxXk7pTnyKYDUp++VZtyv0WPwfeFEHGPXJ4+oXBPP0x1bkUwcXWBDnNYRWKX9/PXRGkDbLztnIEXzQVnOKRPS0Q+Y2ZvNap9OdbDl0RXIPjJaZ3ZDZMXCpEHrGXAifmpg2hgHUGR0eI2FGBIgk2uMO1+7O5czv84u6KIEK8qvUXPAKyRwnMvCcJLnYkR/XfvNfao5cfWUEHdAyP4wGqdcg8g4PRYJog7XFBA977oHfWaiYhCK7qQdPxOTa+MJDAAAYqKAnWaWf2pg4LrV26LmS8rgj652lnLpjobA8a9UC6fxkJxqDsXQiI9iR2KZAl6twz4wuH/GWqH+aRAv19oD1qwtRgsxK/Y0mCvOACCTa2LHuHj1MSvNIIJwWelTt9YY0qaZcimP/92CcDMIbXQ9umUgT3SYivEvtM6cjq5RfC4MB5SC2g99z9yzxK4EQ5cyEm2Lj42FNGSbBC4aRTOHyhg+o4Av0UAAmQssf0Hi9fWBumTch4pyT4p+sLfsEvqAf+A8IEsKyG8/n+AAAAAElFTkSuQmCC','RDV-698F175E43B85','2026-02-13 13:21:50',8,5,10,8,30,'medium',1),(15,'2026-02-18','11:00:00','cancelled','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAACvUlEQVRoge2ZMXKFMAxERcUxuKmxb8oxqKxYu9JnkvlF6h2YXxD70WyklWSb//OxF3zBF5QEu63nGO7Dr/Uy12+Pxbb7uGNvUwQX4ndsTrPzjv34dL/afp33kYAeeNsWYGizvlgiNTt6CBYgXmRB/P8PSuWIhSXPpg462A2I7ZHzK0aUwUqFQRwrfeUBpfqSMwpg2t799ffFHzVAPkueJcZSZQttPPxg9+fRAxHviAIaHhIiWH7xCQox0FjNwgA8MqBHfYtgWX82CKYH0vaY8ZX9YQadfu+yYENVH5UKA6oYwsSeoJACZyAW2gRIhbifX0uCHUpYIS0aWFY8owW6IjhTg0j6CSfo1b65Lsg2rWNG2TzdnTZPU9wUQbaoWE5V5p4eT/uXBD3K2sXiRsOD26XtcV0RDMObCHxKxfq2XijY0AQj9YdnFFCbxuOHygw9sNcpCxOCvdtGp1/rz0gqBQ42bmjVDaPYCFWoWc2mcmDP9i3yoLFpjUIXwwry4GN7UqB7tasLtGxhRnphyCMJTuMTJmdMhZtfXJbmJwiic3nmkoYKbzhPnTCGUxEcUOjMQocMcKbC4VntBUFH9vcdEVF968BROkcWSXBGccMCNiPdcyz7c3AuB3LyjrxPdx9Z9OpTOXAFhd+cVNC+IRCKyrKvB+YI/rh7Xnu2ujGQBCdu/3pdfhoDAfvTfqWCGNhx0jCes2TcBMYFQkwtpyLon5EUyw03/PR71vZNEWQSnDmF5wEMs99/XRdIgYNnDHd16+hjTxwqd46nimDGBZXI+fuY1cgMbsuBnTMKsiEND/MoZ5QwA0UwBMDw3erIAX4Qtkd5hiSIpO/VwHYMZGzeOxXSBefnuAVNjeUtN+qbLtjZqqOdgTCxgt2/OoqA/vTsaOVSqqREwbS9igUgV5W7oz/tjBT4r+cFX/AF9cAfG+M+w8PZoN4AAAAASUVORK5CYII=','RDV-6992D490AD9F9','2026-02-16 09:25:52',8,5,11,5,30,'high',1),(16,'2026-02-17','10:00:00','pending','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAACs0lEQVRoge2aPY6kQAyFC00wYR+hjsLR4GgcpY/QYQctvH4/RdPaDSZajWQqAYqPxCrbzzYtfrjaBV7gfwEb19K+nq3Nsed9zxcv7voyFQYnmGlLMB7dn8003X2O6fWNu9Jg2qon2L4fNNnzlkQkcYcdsblc4LLnMcP5AkgeT9MFvsE04Bo8WCsOW25e4PDCvDz61vKzW2yJ4Zgt8Q93LQY6hsNkttz58newLwZ60YARO0L5tiC39Vin43VdUF6IsKR1kxdmrFr4tA07lgTTcoFXGaRgRxBziFgQ0Q8vrAlSBGEvcNkRneaV7jfn18FYVRi0oLa8DhE7CQqkfhi8JojztTUeMzlj96GjVZH3ojBIJQ0Dphaa1+F+Vk0AGcrLgvK05j1d6Jrpfj5tlcHJcdoO93KK49OHHWuC8jR1PhCunzhfCOhHCXvE8IqgTQYCwVuSyAnPm6VBhev25ZYHhSPz3sm4dUHF8FWpXwmPXphvVquDqTCokoN9MzZAqBhV4buEbVEYnIZiRHRqqlbljDQgYnhlMF6O4TYgW0FNJay05VIZnCQcxTfw7puFOtVvqVAS1F47Ban7iFWhOUdpUM36Q1erOIt3F03zn7KghxhxEFwk1PkYAqkmqBhOZRRH636XM350PmqCo7vBYr5JULNN1EeL2gqgJqgsj4XZ11CMsuoxRCwMvjxm5sHy9FCjHpUkp/ZsRTDOVRkHhfnkyCV1MBUHR9cVyf6c4mDMvp3sWA/0YlLTCOzOWgTGhYe2dy6sCCrjL+5NWy65YvPQuTKo6OT5MqeHmBe6VKMe+PyVoxo4/pPi+UJu87yw28Zn/VgWdJNDY0PX9O2tDsqD+nnD/SE363e5aGlQXsifFPjT6k1e+OiW10eZUhJ0DN81jLceGH0QemFEYfBn6wIv8DeBfwC/ZXpwhmZo/gAAAABJRU5ErkJggg==','RDV-6992E78044364','2026-02-16 10:46:40',8,5,8,7,60,'low',1),(17,'2026-02-17','10:00:00','pending','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAACq0lEQVRoge2aMXLrMAxEwUnh0kfQUXg08mg+io+QMkVG+MAuKCv5KVL9+TMrNbKpp2YHABegzH952QVe4D8BDdewtw+z7nv83uLBJ1br1oTBljI9AvT3rV7rkO7ZvX3e8pc0GFptAdrtHZJ93IPwIJ6pYy6OCxx7hNmWkgUIHv8u8AXesxhZCNhnBlssXuDKQiTcA2WJAkaYDf8hXcXAquEpWSl3vv1d7MXAuvjIGGaMPZ/teKwLMguzOrlPBtbMkpW2wOwesdeEwf0tdZqhHPc2PMLiYzjedmWQ1SnXwhmlgLHFQcAs5cFnrRIGy1BzzeCT+ste39JUNmUQEUXjaHDZBgcQ0TZ2Q+VyYbDSL7QCkT6JQbcRjMUmDGbTyr0tImpCucMgrQImDFIrOgCqGo/4mvM1afDY1LDnV3ylfKuF7e7CYOZd7GZri6MlymevfU8ZrOkGeaia6WcchyxxdcEs3ptzz+/ODj+z0NNlwx1MZdAgmeERpovs6eEAqoVVBtG+Iwsz/YzjM4BL46kMOrXCUDpsJHa6SRC9iC8dNUGMDvtaqyzcK+jODkATZPqtwx2OFeeaweKcQxrksL6ycM1ZKwt3tGruwqDzECN/PDtfq3FrTT4OgyQJtmPrLzk5ZHTG3mnyoQnSKhoiyuo26kCMqpoLg5zLT5byeo0j6qzo9JbKIPoNq8Cq00Me9bAleY1nRUGeEBqn0dXMs3LxGKgpg470Mzojpl/5R3Ymp3gUBOsyVifjWcbORp+jWG/CIGwjz92fx05XDqDOWF0YZHUa9ZHCDktU5z8Dvevj66ccauD6Tgrx5dXo8zVIfPaPsmA7jlNPc5A1U7vAijZYovosiN7SzKTBIwu/jzwO//g9XZXArzV8dfg8e4aO3X8q9irg764LvMD/CfwDrZnl0fCb7IwAAAAASUVORK5CYII=','RDV-6992EB0C3DA81','2026-02-16 11:01:48',8,5,8,5,30,'high',2),(18,'2026-02-17','10:00:00','pending','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAACpUlEQVRoge2aQW7rMAxEaWSRZY+Qo/ho0tFyFB8hSy8CseIMZbktCnT18YGxN4qi5ywIkhqSMf/jYxd4gf8ENDzF32YP93bzl61crCxvHC7C4BJmepbFd75iH+619WVbq7/vcSoNhgGfJS3X7P6CVe+vhwcIc15gt1x3s2p2923tlts/tnCzCzzb0fou/Mv67vG03w2uAzIK+xFy9XCzzsdrP8NVDMwcHh7Vzfl9+ZnsxcB8wmSbjafddtjxrABkwReO4hOTVN8yJsPb+pfKIEy21rQjUxayU1/sMKcs6FRGKZBCGSFl7X1JnyvKYCTvuNQs0nVl+EEnhUDqQuCIQk0QEnpaLl6zksEIgbRKg4i01cel5ofK7lGY+lEZbJSK81Lrlqv4sp8xDJVBfAxBDXPiUoPYDm9r9D1lsEV2is0efHpb3nsZjMqgsclBbyuZ0dtIWTv0gDCYdRiqstUPA8bbbrTxIgxmMQ+BhFQeR+wPQXPjTBj0LDTQETp52+RdGwwCrSDUYbGwD1Kz1ygNoiorhm60j270qEWGapIFs/88yo7bQdgKbTl7AJIgA65kknLoR4RmOt2X2lUP5CQsLjUsuPrRT+w78CcFIAhmz54GHP2hc+fjdBcKgpwJ1oZRT13emavybvve+dAD4Upl9BN9SCLMf7CTBpmnabljvpwCaYgnYdB9DAoN4Fji7ZAF22zPaoJoeXCAWqiya+Zw/MyR7CVBdjcKq3iCYxLGe08bzGehybLJyOyUCqAog7zmUz/WLO3ZXbTZqZYFacAAo9Dg+L1kU/qLHUVB6sf57wQkbxb6jMILfI72fNZo7FSPfwddYGlznBp+x0kYJxuz66oIMgobtVAOV1NXN3aLXBjMHB47jpkza5//2CEM/u25wAv8n8BPpxdIrIBzUCUAAAAASUVORK5CYII=','RDV-6992EB754A89B','2026-02-16 11:03:33',6,5,8,7,60,'low',3),(19,'2026-02-17','14:00:00','pending','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAACr0lEQVRoge2aO47DMAxEKWyRMkfwUXw062g+io+QMoVhrmaGcrw/YKvFApQaI/JLQ4jDEWnzXy4b4AD/BDSu5Xh72tR2duuPtuJREoMFYVoX9+fdV2zft7mW3e7Y3G94mxpE5NYWR50nvWL4Zvx6tBgPMOLY9trDa/uF01YGGCD35mrGOLaoPn6IYzZQWQiRwqsWQLyCOs31u3RNBoaGI44Rzuvjq9gnA2MxnC39dmq44ZjZxR/kBVnNzKDhEqkGKguRk48pN4iQTV67VjmJQ1pFYT+zMCVYVNvs7XkJJ+I4rUbJalqVGETIlHeNsLO20SDBNW25QazN7LCroVZUlwNZiHDmBcNJQ49YzWgElIwwT/etG6Sc4KHzFQnHY2aL/l3pH+fQ8JygqZphb/J4+GHno70riUHJNY4S9AjJ2HIyrvaI5pmFOUEkXAsgCaYf+MK7KzebqSyJQZigjS0ygO2OBlliF4224Hr7yAjGnV6OsXpvEz112m4QsMxg5J3E+0w/eW64pleJSwnGfcPPx2mQaL2RjJ4dRBay2Kut6Gqf1RCwzCATLm4fVG2KN0XKpOieGWTIVg13ztrmH5Kx5AbpEdlItBIDsX4JUfnLDMo/evdJN6g2fXW0Yj90kPKB9IicXqD081q28LSt5gOMPdMcNc5XXGGl4e6JwYPFvr4sUbjJuMnqLpIXhIXeImTRNwtFt0WTjcUTg84qX+OYqcTFTL6a3V72OifYvZDa0D2AardyXc5jQjBWHLOieaFMZW++emLQoqjt3VdfmvWfHUBCEDcMzjJ6FnKyoRZ1v7hlBqMVxImPaYhh8bFdZOEA9SEQQhafS6lFrRnrAJcYp/rJq1nf/5YXVBZGA+ToX3RQ0Tnu+CRSycDQ8GjWv76Tcv3CJNoTg79bAxzgfwLfAaiW9o3tOj4BAAAAAElFTkSuQmCC','RDV-69930DF299D4C','2026-02-16 13:30:42',8,5,8,13,30,'medium',1),(20,'2026-02-17','13:00:00','pending','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAACrklEQVRoge2aPY6kUAyE/dRBh30EjsLReEfjKBxhwg5a7XW56gGt2ZUmGq1kSJDgIynZ5Z+H+Q8vu8AL/BXQ8lrcn7j7647n75t/xcP2ypetMNjwYo1n969pjacEzR7b3PVZaTC0mtblfXs+NjMQ7j0/c4Ap5wW+Q8DN4hbXHNrhsxT3Ag8d41kk49yRhRF0/xa8DrhnIXT015ATQdf+nq6VQHk4Terb7bvZFwNHiUdghS1lpQOROp47gLJgZFqYN1wbpd/l4dkPpKNXBtOkSET6IargTp6qGuteKw2mTzvzLokVVv7w1UaGFgYZSuFVwUdtwxvc7srJx5GFRcHUkWFmOx+1bbXUeC4NvncBIZlKf+oocIRZURCuvS7wI5g3szBzMj/D5YXB5n4kXDf21WMWuaVXVQa15PCD3zjCxmhvTMbKoHy6sXH0U2cUJe72RD/QCoPaCHHXgVmEAuKGuufbuVUoCPp+xSuOHRl0AbPZdi8NslXUcMY9SL5clYylQRFsiXLlkQUPb/thYGVBBRZ4LszGdpFfcxapC47pQ5JxG63GUV2TFwaVhZzwuw5+3nvpP29dK4LqpNlGZrs0jS7bdPPCoHSMThpnGXCnLP22bz7m3iqDWDzPro4RbeSkbdHcPzYfNUGOY9qULZ5behQ1RZt/dgDlwDzqUWCNzccyFkP+tCMLS4JUznwcGzKsjl3jNA7EqoLQsY/ZlaO9ZzJmFuKXhcIgxvedyGSMoNPBD03cKoO61F7LvHNvNvfPVqEkSKkWyamCp33iOHQuDObmI6ZV/iDFVZCxjfSjjawL0rwh5pQHHIgvddn58KiFhUE//byRrp17kBxoLxCbMk7xLP3OoVWHiK0yKMn49yG9ytRU6hDRC4PycG3KOLuOfzSpsVUGf3Zd4AX+T+AfU8PLS1mQY+YAAAAASUVORK5CYII=','RDV-69930E45E79D6','2026-02-16 13:32:05',8,5,8,7,60,'low',1),(21,'2026-02-17','11:00:00','pending','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAACmklEQVRoge2aO27kMBBESUzg0EfQUeZo0tF0FB/B4QQDtVkfSWN4sXC0WKDERBD1lDS6qz9kq1+udoEX+E/AxjX359vntOJRH61tt8d74Y0fezDYYaZ1rgFy79Em7DzeP+6F34pILjhsJQN+yqQgSubU3/MFzhuI4V9A70vJgBe4g62NvUFUIRjr1bjZoKPQcYcHJAtWnetP4ZoF/tDwb4+/iX0EuKf4EYU02chtJW+rpZ+fk8HhUduN4QeRchS+GDcY5KdhuRF3terHVQWSjcvNYJA6Lccqa1VTpms32jgZVG4r6ZEyHctI1QNvDsZYsJTNLNcAp7Xt6/aAOaPB4gtECg/5V0mdWD/eKxlsEm8Aw6OaMp26Dwj7WEs0qHZMKa6pcIR/qR4oC1gsOLIZuw+42ehW0dor07mFZekdDFrDGYyWLPAYDG0UqerZIAMOD46CrFU/UlwmyEgbJZGyGQlURmpC0OHD5XLBTbm+9pEHLFcvU9fpjMJE0CYTP0udllKxTTfbm7NMULWQA+7o8KVVNmcFg5YlDDlYEnFm7961y+l6OsghR1mW2LSCX84IjQVZOB57TQX13n1Q35dksI4uHm7GTIdptDPdLlmxoCernSkOJz6WJYzP1Li1ZPA4GqTlNk3K4HATXbAqG7QreYJoNzuOgRih4SCb1rPtQLnE1M/QrONALBL0fQS3Y/IvWK6kXOfcLBVEh+FDjGW/yvFsPtJgvx8MeqlUXHQg9mJATYtyQbmWB6ylSwpNY6JF54XRoOXa3uZptO8qdPf7yaAvAjnTWbVdPzZdeLnAzQeFT03wwa+qH/cKIBo8tMojDzX6CtFoUFGoSpr1I53unHys0aA1vE7Vdu9auvdyVACZ4O/WBV7g/wR+ASY8VtZzZGOnAAAAAElFTkSuQmCC','RDV-699360D7CBF52','2026-02-16 19:24:23',8,5,8,7,60,'low',1),(22,'2026-02-17','09:00:00','pending','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAUAAAAFAAQMAAAD3XjfpAAAABlBMVEUEAgT8/vxJvsdeAAAACXBIWXMAAA7EAAAOxAGVKw4bAAACnUlEQVRoge2aMXKDQAxFxaRwyRE4CkdbjsZROIJLFx4U6X8txnGTKpOZzxZxgEejkf5+aTH/5bILvMA/AQ2rmd3u09qG5819tf3rMXpe4eEgDA4ZprXFn3ve/HqYzXHxGLfZ8RoQXTBilQFMcF4CHDdrHsRmFj/xdrvAtptF5ApMAsV3gQX2ACLpAmRwL7BXYT7Ca6P7MviRbR/lqgWWhmfIKnLnn0+xFwNrIYCrlZSnZE0Zzr6kwcioFKn8F3yLLe4cXGGQxJKWKDR8hwNYEpyQghVcWbC2MViiyK+n0RnVhocYK4O7hRfCo5NxjJtZjPnDYpQGWXdJROSi7uAADrMtDXplFCLX8HhG7k1pCzKOrgyGSNFepxcCP6E0IeyoQlMGsZtRvF/5hdYeAaSA6YJm1X3UPfKxNmSbc8mCpeE18kALa30wdPgBXbCGHLXZw1ev1vnzFqcJZgBx0atwxGtZhQsbWmkQCxqeVbhXONmEcCrS7bUkaNV20CehF8nyy961m6dBGOwjMjTzTDqo00mrXBisaXQZgYHjszTbnuOQk38UBrHGKkbUHZRr5wMXBnNvo1znkIPnYlbF6D3GuiBMEAsuO3w6gIFJB1ugDRrlemA7BkNN4xh8b/SFweN8mdPo18gjt7gLRFc218kGtGpLvk+LUqukQT7C8DV5dKuw19AqO7Y4TZCnOvCP29GO5S1cdfOkC75GZDhHdc7NcP5jVnZJF6yFc/f5sERMuh8DNkWQTxrTjHsbG32Y7dtJwyVBVCE+5TAYR4hUfatAu9Skwf4hEIxAJZ3VZ0HvIqUM8vSizjLQkqz0j90BSIPlhThd7OOz9yZXE2QVIoCQJWd+HZOPVRosDedRT6vDVTa0rfyjMvi7dYEX+J/Ab9addWiwn9CNAAAAAElFTkSuQmCC','RDV-6993632CB148D','2026-02-16 19:34:20',8,5,31,12,60,'medium',1);
/*!40000 ALTER TABLE `rendez_vous` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom_service` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `duree_estimee` int(11) DEFAULT NULL,
  `disponible` tinyint(4) NOT NULL,
  `banque_id` int(11) NOT NULL,
  `priorite_defaut` varchar(20) DEFAULT NULL,
  `admin_feedback` longtext DEFAULT NULL,
  `frais` decimal(10,2) DEFAULT NULL,
  `documents_requis` longtext DEFAULT NULL,
  `categorie` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E19D9AD237E080D9` (`banque_id`),
  CONSTRAINT `FK_E19D9AD237E080D9` FOREIGN KEY (`banque_id`) REFERENCES `banque` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (4,'ZAAZ','SDVVSDVS',30,0,5,'medium','AAA',21.00,'DSQDSQD','Epargne'),(5,'Compte Courant','Ouverture de compte courant avec chéquier et carte bancaire.',30,1,5,'high',NULL,0.00,'CIN, Justificatif de domicile, Fiche de paie','Compte'),(6,'Crédit Consommation','Demande de crédit personnel pour vos projets.',45,1,5,'medium',NULL,50.00,'CIN, 3 dernières fiches de paie, Relevés bancaires 3 mois','Crédit'),(7,'Assurance Vie','Souscription à une assurance vie pour protéger vos proches.',60,1,5,'low',NULL,20.00,'CIN, Questionnaire médical','Assurance'),(8,'Epargne Logement','Plan d\'épargne pour votre futur logement.',30,1,5,'medium',NULL,10.00,'CIN','Epargne'),(12,'Crédit Consommation / Immobilier','Solution de financement flexible. Inclut l\'étude de solvabilité, la simulation de tableau d\'amortissement et la validation du dossier.',60,1,5,'medium',NULL,150.00,'CIN, 3 dernières fiches de paie, Relevés bancaires (3 mois), Promesse de vente (si immo).','Crédit'),(13,'Logement.','Service bancaire standard adapté aux besoins des clients.',30,1,5,'medium',NULL,0.00,'Aucun','Autre'),(14,'Crédit Loisirs & Voyage','Prêt personnel pour financer vos voyages et loisirs. Réponse rapide et déblocage express.',30,1,5,'medium',NULL,50.00,'CIN, Dernière fiche de paie, Devis agence de voyage (optionnel).','Crédit'),(15,'Crédit Immobilier / Logement','Financement pour l\'acquisition, la construction ou la rénovation de votre logement. Taux avantageux et durée flexible.',60,0,5,'medium',NULL,150.00,'CIN, Fiches de paie (3 mois), Relevés bancaires, Promesse de vente, Titre de propriété.','Crédit');
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilisateur` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(180) NOT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`roles`)),
  `password` varchar(255) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `statut_compte` varchar(20) NOT NULL,
  `banque_id` int(11) DEFAULT NULL,
  `cin` varchar(20) DEFAULT NULL,
  `adresse` longtext DEFAULT NULL,
  `code_postal` varchar(10) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
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
INSERT INTO `utilisateur` VALUES (1,'mehdimejri15@gmail.com','[\"ROLE_CLIENT\"]','$2y$13$PJD740RyCkbFOeeEjviTxegyWKYxLlsUpKUwS6/9NGAGP/8m29x4C','Mejri','Mehdi','321412','active',NULL,NULL,NULL,NULL,NULL),(4,'az@gmail.com','[\"ROLE_AGENT\"]','$2y$13$InHeMSVrR7MaOh0APjDVouG0AIhQrsTpRZqKZpFiyoS8AGHUCX0He','Mejri','Mehdi','321412','active',NULL,NULL,NULL,NULL,NULL),(5,'admin@beeline.com','[\"ROLE_ADMIN\"]','$2y$13$F8JjZoIYEM4jhMNa.xd4F.XNrrtNQgUxV6M.3R7C8VgfCD9bgKwTq','Admin','System','+216 00 000 000','active',NULL,NULL,NULL,NULL,NULL),(6,'ag@gmail.com','[\"ROLE_AGENT\"]','$2y$13$DQgU0BSsNfBZa6PfwSALoux.LJkOp92ebMSqOXYV4Bwlp1nPg02Za','Mehdi','Mejri','+216 73 091 222','active',5,NULL,NULL,NULL,NULL),(8,'cl@gmail.com','[\"ROLE_CLIENT\"]','$2y$13$u9XrsiJiRse2eqrGcH7j6u5HsBjqcXy9CO2BbNIDMGLVLXHHJm1Cu','Mejri','Mehdi','+216 73 934 033','active',5,NULL,NULL,NULL,NULL),(9,'mariemhamdi@gmail.com','[\"ROLE_AGENT\"]','$2y$13$dm2IBpbrMOWBtfhauUFWLeij.mvqGLNik3U/meFGbzxt5GFqEH8wm','Hamdi','Mariem','+216 73 913 344','active',18,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `utilisateur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'beeline_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-16 20:07:16
