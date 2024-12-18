CREATE DATABASE  IF NOT EXISTS `spor_salon` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `spor_salon`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: spor_salon
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `abonelik_planlari`
--

DROP TABLE IF EXISTS `abonelik_planlari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abonelik_planlari` (
  `plan_id` int NOT NULL AUTO_INCREMENT,
  `plan_adi` varchar(50) NOT NULL,
  `fiyat` decimal(10,2) NOT NULL,
  `sure_ay` int NOT NULL,
  PRIMARY KEY (`plan_id`),
  CONSTRAINT `abonelik_planlari_chk_1` CHECK ((`sure_ay` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abonelik_planlari`
--

LOCK TABLES `abonelik_planlari` WRITE;
/*!40000 ALTER TABLE `abonelik_planlari` DISABLE KEYS */;
/*!40000 ALTER TABLE `abonelik_planlari` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `aktif_uyeler`
--

DROP TABLE IF EXISTS `aktif_uyeler`;
/*!50001 DROP VIEW IF EXISTS `aktif_uyeler`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `aktif_uyeler` AS SELECT 
 1 AS `uye_id`,
 1 AS `ad`,
 1 AS `soyad`,
 1 AS `email`,
 1 AS `kayit_tarihi`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `ders_kapasite_kontrol`
--

DROP TABLE IF EXISTS `ders_kapasite_kontrol`;
/*!50001 DROP VIEW IF EXISTS `ders_kapasite_kontrol`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ders_kapasite_kontrol` AS SELECT 
 1 AS `ders_id`,
 1 AS `ders_adi`,
 1 AS `kapasite`,
 1 AS `kalan_kapasite`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `ders_rezervasyonlari`
--

DROP TABLE IF EXISTS `ders_rezervasyonlari`;
/*!50001 DROP VIEW IF EXISTS `ders_rezervasyonlari`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ders_rezervasyonlari` AS SELECT 
 1 AS `rezervasyon_id`,
 1 AS `uye_adi`,
 1 AS `uye_soyadi`,
 1 AS `ders_adi`,
 1 AS `rezervasyon_tarihi`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `dersler`
--

DROP TABLE IF EXISTS `dersler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dersler` (
  `ders_id` int NOT NULL AUTO_INCREMENT,
  `ders_adi` varchar(50) NOT NULL,
  `personel_id` int NOT NULL,
  `kapasite` int NOT NULL,
  PRIMARY KEY (`ders_id`),
  KEY `personel_id` (`personel_id`),
  CONSTRAINT `dersler_ibfk_1` FOREIGN KEY (`personel_id`) REFERENCES `personel` (`personel_id`) ON DELETE CASCADE,
  CONSTRAINT `dersler_chk_1` CHECK ((`kapasite` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dersler`
--

LOCK TABLES `dersler` WRITE;
/*!40000 ALTER TABLE `dersler` DISABLE KEYS */;
/*!40000 ALTER TABLE `dersler` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `odeme_detaylari`
--

DROP TABLE IF EXISTS `odeme_detaylari`;
/*!50001 DROP VIEW IF EXISTS `odeme_detaylari`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `odeme_detaylari` AS SELECT 
 1 AS `odeme_id`,
 1 AS `uye_adi`,
 1 AS `uye_soyadi`,
 1 AS `plan_adi`,
 1 AS `tutar`,
 1 AS `odeme_tarihi`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `odemeler`
--

DROP TABLE IF EXISTS `odemeler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `odemeler` (
  `odeme_id` int NOT NULL AUTO_INCREMENT,
  `uye_id` int NOT NULL,
  `plan_id` int NOT NULL,
  `odeme_tarihi` date NOT NULL DEFAULT (curdate()),
  `tutar` decimal(10,2) NOT NULL,
  PRIMARY KEY (`odeme_id`),
  KEY `uye_id` (`uye_id`),
  KEY `plan_id` (`plan_id`),
  CONSTRAINT `odemeler_ibfk_1` FOREIGN KEY (`uye_id`) REFERENCES `uyeler` (`uye_id`) ON DELETE CASCADE,
  CONSTRAINT `odemeler_ibfk_2` FOREIGN KEY (`plan_id`) REFERENCES `abonelik_planlari` (`plan_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `odemeler`
--

LOCK TABLES `odemeler` WRITE;
/*!40000 ALTER TABLE `odemeler` DISABLE KEYS */;
/*!40000 ALTER TABLE `odemeler` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personel`
--

DROP TABLE IF EXISTS `personel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personel` (
  `personel_id` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(50) NOT NULL,
  `soyad` varchar(50) NOT NULL,
  `pozisyon` varchar(50) NOT NULL,
  `baslama_tarihi` date NOT NULL,
  PRIMARY KEY (`personel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personel`
--

LOCK TABLES `personel` WRITE;
/*!40000 ALTER TABLE `personel` DISABLE KEYS */;
/*!40000 ALTER TABLE `personel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rezervasyonlar`
--

DROP TABLE IF EXISTS `rezervasyonlar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rezervasyonlar` (
  `rezervasyon_id` int NOT NULL AUTO_INCREMENT,
  `uye_id` int NOT NULL,
  `ders_id` int NOT NULL,
  `rezervasyon_tarihi` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`rezervasyon_id`),
  KEY `uye_id` (`uye_id`),
  KEY `ders_id` (`ders_id`),
  CONSTRAINT `rezervasyonlar_ibfk_1` FOREIGN KEY (`uye_id`) REFERENCES `uyeler` (`uye_id`) ON DELETE CASCADE,
  CONSTRAINT `rezervasyonlar_ibfk_2` FOREIGN KEY (`ders_id`) REFERENCES `dersler` (`ders_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rezervasyonlar`
--

LOCK TABLES `rezervasyonlar` WRITE;
/*!40000 ALTER TABLE `rezervasyonlar` DISABLE KEYS */;
/*!40000 ALTER TABLE `rezervasyonlar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `toplam_odeme`
--

DROP TABLE IF EXISTS `toplam_odeme`;
/*!50001 DROP VIEW IF EXISTS `toplam_odeme`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `toplam_odeme` AS SELECT 
 1 AS `uye_id`,
 1 AS `toplam_odeme`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `uyeler`
--

DROP TABLE IF EXISTS `uyeler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uyeler` (
  `uye_id` int NOT NULL AUTO_INCREMENT,
  `ad` varchar(50) NOT NULL,
  `soyad` varchar(50) NOT NULL,
  `dogum_tarihi` date NOT NULL,
  `telefon` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `kayit_tarihi` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`uye_id`),
  UNIQUE KEY `telefon` (`telefon`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uyeler`
--

LOCK TABLES `uyeler` WRITE;
/*!40000 ALTER TABLE `uyeler` DISABLE KEYS */;
/*!40000 ALTER TABLE `uyeler` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `aktif_uyeler`
--

/*!50001 DROP VIEW IF EXISTS `aktif_uyeler`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `aktif_uyeler` AS select `uyeler`.`uye_id` AS `uye_id`,`uyeler`.`ad` AS `ad`,`uyeler`.`soyad` AS `soyad`,`uyeler`.`email` AS `email`,`uyeler`.`kayit_tarihi` AS `kayit_tarihi` from `uyeler` where (`uyeler`.`kayit_tarihi` >= (curdate() - interval 1 year)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ders_kapasite_kontrol`
--

/*!50001 DROP VIEW IF EXISTS `ders_kapasite_kontrol`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ders_kapasite_kontrol` AS select `d`.`ders_id` AS `ders_id`,`d`.`ders_adi` AS `ders_adi`,`d`.`kapasite` AS `kapasite`,(`d`.`kapasite` - count(`r`.`rezervasyon_id`)) AS `kalan_kapasite` from (`dersler` `d` left join `rezervasyonlar` `r` on((`d`.`ders_id` = `r`.`ders_id`))) group by `d`.`ders_id`,`d`.`ders_adi`,`d`.`kapasite` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ders_rezervasyonlari`
--

/*!50001 DROP VIEW IF EXISTS `ders_rezervasyonlari`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ders_rezervasyonlari` AS select `r`.`rezervasyon_id` AS `rezervasyon_id`,`u`.`ad` AS `uye_adi`,`u`.`soyad` AS `uye_soyadi`,`d`.`ders_adi` AS `ders_adi`,`r`.`rezervasyon_tarihi` AS `rezervasyon_tarihi` from ((`rezervasyonlar` `r` join `uyeler` `u` on((`r`.`uye_id` = `u`.`uye_id`))) join `dersler` `d` on((`r`.`ders_id` = `d`.`ders_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `odeme_detaylari`
--

/*!50001 DROP VIEW IF EXISTS `odeme_detaylari`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `odeme_detaylari` AS select `o`.`odeme_id` AS `odeme_id`,`u`.`ad` AS `uye_adi`,`u`.`soyad` AS `uye_soyadi`,`a`.`plan_adi` AS `plan_adi`,`o`.`tutar` AS `tutar`,`o`.`odeme_tarihi` AS `odeme_tarihi` from ((`odemeler` `o` join `uyeler` `u` on((`o`.`uye_id` = `u`.`uye_id`))) join `abonelik_planlari` `a` on((`o`.`plan_id` = `a`.`plan_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `toplam_odeme`
--

/*!50001 DROP VIEW IF EXISTS `toplam_odeme`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `toplam_odeme` AS select `odemeler`.`uye_id` AS `uye_id`,sum(`odemeler`.`tutar`) AS `toplam_odeme` from `odemeler` group by `odemeler`.`uye_id` */;
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

-- Dump completed on 2024-12-14 17:45:19
