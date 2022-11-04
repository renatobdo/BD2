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
-- Table structure for table `general_ledger_accounts`
--

DROP TABLE IF EXISTS `general_ledger_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `general_ledger_accounts` (
  `account_number` int NOT NULL,
  `account_description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`account_number`),
  UNIQUE KEY `account_description` (`account_description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `general_ledger_accounts`
--

LOCK TABLES `general_ledger_accounts` WRITE;
/*!40000 ALTER TABLE `general_ledger_accounts` DISABLE KEYS */;
INSERT INTO `general_ledger_accounts` VALUES (221,'401K Employee Contributions'),(591,'Accounting'),(200,'Accounts Payable'),(110,'Accounts Receivable'),(569,'Auto Expense'),(568,'Auto License Fee'),(565,'Bank Fees'),(394,'Book Club Royalties'),(181,'Book Development'),(120,'Book Inventory'),(400,'Book Printing Costs'),(403,'Book Production Costs'),(572,'Books, Dues, and Subscriptions'),(520,'Building Lease'),(523,'Building Maintenance'),(551,'Business Forms'),(590,'Business Insurance'),(574,'Business Licenses and Taxes'),(280,'Capital Stock'),(162,'Capitalized Lease'),(536,'Card Deck Advertising'),(100,'Cash'),(610,'Charitable Contributions'),(555,'Collection Agency Fees'),(301,'College Sales'),(310,'Compositing Revenue'),(160,'Computer Equipment'),(527,'Computer Equipment Maintenance'),(306,'Consignment Sales'),(556,'Credit Card Handling'),(540,'Direct Mail Advertising'),(238,'Employee FICA Taxes Payable'),(242,'Employee SDI Taxes Payable'),(239,'Employer FICA Taxes Payable'),(241,'Employer FUTA Taxes Payable'),(243,'Employer UCI Taxes Payable'),(532,'Equipment Rental'),(546,'Exhibits and Shows'),(630,'Federal Corporation Income Taxes'),(505,'FICA'),(553,'Freight'),(150,'Furniture'),(506,'FUTA'),(510,'Group Insurance'),(251,'IBM Credit Corporation Payable'),(528,'IBM Lease'),(235,'Income Taxes Payable'),(620,'Interest Paid to Banks'),(580,'Meals'),(508,'Medicare'),(234,'Medicare Taxes Payable'),(570,'Office Supplies'),(170,'Other Equipment'),(621,'Other Interest'),(589,'Outside Services'),(550,'Packaging Materials'),(576,'PC Software'),(552,'Postage'),(611,'Profit Sharing Contributions'),(300,'Retail Sales'),(290,'Retained Earnings'),(205,'Royalties Payable'),(500,'Salaries and Wages'),(632,'Sales Tax'),(230,'Sales Taxes Payable'),(167,'Software'),(541,'Space Advertising'),(631,'State Corporation Income Taxes'),(237,'State Payroll Taxes Payable'),(522,'Telephone'),(302,'Trade Sales'),(582,'Travel and Accomodations'),(507,'UCI'),(521,'Utilities'),(548,'Web Site Production and Fees');
/*!40000 ALTER TABLE `general_ledger_accounts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-03 20:41:38
