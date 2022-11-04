CREATE DATABASE  IF NOT EXISTS `ap26` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ap26`;
-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: ifsp.mysql.database.azure.com    Database: ap26
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `invoice_line_items`
--

DROP TABLE IF EXISTS `invoice_line_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_line_items` (
  `invoice_id` int NOT NULL,
  `invoice_sequence` int NOT NULL,
  `account_number` int NOT NULL,
  `line_item_amount` decimal(9,2) NOT NULL,
  `line_item_description` varchar(100) NOT NULL,
  PRIMARY KEY (`invoice_id`,`invoice_sequence`),
  KEY `line_items_fk_acounts` (`account_number`),
  CONSTRAINT `line_items_fk_acounts` FOREIGN KEY (`account_number`) REFERENCES `general_ledger_accounts` (`account_number`),
  CONSTRAINT `line_items_fk_invoices` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_line_items`
--

LOCK TABLES `invoice_line_items` WRITE;
/*!40000 ALTER TABLE `invoice_line_items` DISABLE KEYS */;
INSERT INTO `invoice_line_items` VALUES (1,1,553,3813.33,'Freight'),(2,1,553,40.20,'Freight'),(3,1,553,138.75,'Freight'),(4,1,553,144.70,'Int\'l shipment'),(5,1,553,15.50,'Freight'),(6,1,553,42.75,'Freight'),(7,1,553,172.50,'Freight'),(8,1,522,95.00,'Telephone service'),(9,1,403,601.95,'Cover design'),(10,1,553,42.67,'Freight'),(11,1,553,42.50,'Freight'),(12,1,580,50.00,'DiCicco\'s'),(12,2,570,75.60,'Kinko\'s'),(12,3,570,58.40,'Office Max'),(12,4,540,478.00,'Publishers Marketing'),(13,1,522,16.33,'Telephone (line 5)'),(14,1,553,6.00,'Freight out'),(15,1,574,856.92,'Property Taxes'),(16,1,572,9.95,'Monthly access fee'),(17,1,553,10.00,'Address correction'),(18,1,553,104.00,'Freight'),(19,1,160,116.54,'MVS Online Library'),(20,1,553,6.00,'Freight out'),(21,1,589,4901.26,'Office lease'),(22,1,553,108.25,'Freight'),(23,1,572,9.95,'Monthly access fee'),(24,1,520,1750.00,'Warehouse lease'),(25,1,553,129.00,'Freight'),(26,1,553,10.00,'Freight'),(27,1,540,207.78,'Prospect list'),(28,1,553,109.50,'Freight'),(29,1,523,450.00,'Back office additions'),(30,1,553,63.40,'Freight'),(31,1,589,7125.34,'Web site design'),(32,1,403,953.10,'Crash Course revision'),(33,1,591,220.00,'Form 571-L'),(34,1,553,127.75,'Freight'),(35,1,507,1600.00,'Income Tax'),(36,1,403,565.15,'Crash Course Ad'),(37,1,553,36.00,'Freight'),(38,1,553,61.50,'Freight'),(39,1,400,37966.19,'CICS Desk Reference'),(40,1,403,639.77,'Card deck'),(41,1,553,53.75,'Freight'),(42,1,553,400.00,'Freight'),(43,1,400,21842.00,'Book repro'),(44,1,522,19.67,'Telephone (Line 3)'),(45,1,553,2765.36,'Freight'),(46,1,510,224.00,'Health Insurance'),(47,1,572,1575.00,'Catalog ad'),(48,1,553,33.00,'Freight'),(49,1,522,16.33,'Telephone (line 6)'),(50,1,510,116.00,'Health Insurance'),(51,1,553,2184.11,'Freight'),(52,1,160,1083.58,'MSDN'),(53,1,522,46.21,'Telephone (Line 1)'),(54,1,403,313.55,'Card revision'),(55,1,553,40.75,'Freight'),(56,1,572,2433.00,'Card deck'),(57,1,589,1367.50,'401K Contributions'),(58,1,553,53.25,'Freight'),(59,1,553,13.75,'Freight'),(60,1,553,2312.20,'Freight'),(61,1,553,25.67,'Freight out'),(62,1,553,26.75,'Freight'),(63,1,553,2115.81,'Freight'),(64,1,553,23.50,'Freight'),(65,1,400,6940.25,'OS Utilities'),(66,1,553,31.95,'Freight'),(67,1,553,1927.54,'Freight'),(68,1,160,936.93,'Quarterly Maintenance'),(69,1,540,175.00,'Card deck advertising'),(70,1,553,6.00,'Freight'),(71,1,553,108.50,'Freight'),(72,1,553,10.00,'Address correction'),(73,1,552,290.00,'International pkg.'),(74,1,570,41.80,'Coffee'),(75,1,553,27.00,'Freight'),(76,1,553,241.00,'Int\'l shipment'),(77,1,403,904.14,'Cover design'),(78,1,403,1197.00,'Cover design'),(78,2,540,765.13,'Catalog design'),(79,1,540,2184.50,'PC card deck'),(80,1,553,2318.03,'Freight'),(81,1,553,26.25,'Freight'),(82,1,150,17.50,'Supplies'),(83,1,522,39.77,'Telephone (Line 2)'),(84,1,553,111.00,'Freight'),(85,1,553,158.00,'Int\'l shipment'),(86,1,553,739.20,'Freight'),(87,1,553,60.00,'Freight'),(88,1,553,147.25,'Freight'),(89,1,400,85.31,'Book copy'),(90,1,553,38.75,'Freight'),(91,1,522,32.70,'Telephone (line 4)'),(92,1,521,16.62,'Propane-forklift'),(93,1,553,162.75,'International shipment'),(94,1,553,52.25,'Freight'),(95,1,572,600.00,'Books for research'),(96,1,400,26881.40,'MVS JCL'),(97,1,170,356.48,'Network wiring'),(98,1,572,579.42,'Catalog ad'),(99,1,553,59.97,'Freight'),(100,1,553,67.92,'Freight'),(101,1,553,30.75,'Freight'),(102,1,400,20551.18,'CICS book printing'),(103,1,553,2051.59,'Freight'),(104,1,553,44.44,'Freight'),(105,1,582,503.20,'Bronco lease'),(106,1,400,23517.58,'DB2 book printing'),(107,1,553,3689.99,'Freight'),(108,1,553,67.00,'Freight'),(109,1,403,1000.46,'Crash Course covers'),(110,1,540,90.36,'Card deck advertising'),(111,1,553,22.57,'Freight'),(112,1,400,10976.06,'VSAM book printing'),(113,1,510,224.00,'Health Insurance'),(114,1,553,127.75,'Freight');
/*!40000 ALTER TABLE `invoice_line_items` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-03 20:41:33
