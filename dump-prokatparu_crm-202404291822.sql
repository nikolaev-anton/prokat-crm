-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: VH294.spaceweb.ru    Database: prokatparu_crm
-- ------------------------------------------------------
-- Server version	5.7.27-30-log

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
-- Table structure for table `ACCOUNTS`
--

DROP TABLE IF EXISTS `ACCOUNTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ACCOUNTS` (
  `ID` int(11) NOT NULL,
  `COMMENT` text NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `CREATED` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AMMOUNT` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACCOUNTS`
--

LOCK TABLES `ACCOUNTS` WRITE;
/*!40000 ALTER TABLE `ACCOUNTS` DISABLE KEYS */;
/*!40000 ALTER TABLE `ACCOUNTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CHANNELS`
--

DROP TABLE IF EXISTS `CHANNELS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CHANNELS` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) NOT NULL,
  `CREATED` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `COMMENT` text NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CHANNELS`
--

LOCK TABLES `CHANNELS` WRITE;
/*!40000 ALTER TABLE `CHANNELS` DISABLE KEYS */;
INSERT INTO `CHANNELS` VALUES (1,'сайт','2020-06-21 21:57:44','prokat-palatok.ru'),(2,'брали ранее','2020-06-21 21:58:26','для повторных заказов одного клиента');
/*!40000 ALTER TABLE `CHANNELS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENTS`
--

DROP TABLE IF EXISTS `CLIENTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENTS` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `COMMENT` text,
  `NAME` varchar(255) DEFAULT NULL,
  `PHONE1` varchar(255) NOT NULL,
  `PHONE2` varchar(255) DEFAULT NULL,
  `PHONE3` varchar(255) DEFAULT NULL,
  `CREATED` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DISCOUNT` float DEFAULT NULL,
  `HISTORY` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENTS`
--

LOCK TABLES `CLIENTS` WRITE;
/*!40000 ALTER TABLE `CLIENTS` DISABLE KEYS */;
INSERT INTO `CLIENTS` VALUES (1,'autocreate','Anton','8999-123-45-67','','','2018-04-11 14:56:13',NULL,NULL),(2,'autocreate','Антон Николаев','89163457726','','','2024-04-26 22:46:24',NULL,NULL),(3,'autocreate','Антон Николаев','89163457727','','','2024-04-26 22:47:06',NULL,NULL),(4,'autocreate','',' 7 (888) 999-99-99','','','2024-04-26 22:58:09',NULL,NULL),(5,'autocreate','Антон Николаев',' 7 (891) 634-57-72','','','2024-04-27 00:20:41',NULL,NULL),(6,'autocreate','Антон Николаев',' 7 (916) 345-77-25','','','2024-04-27 00:27:42',NULL,NULL),(7,'autocreate','',' 7 (495) 777-77-77','','','2024-04-27 01:12:19',NULL,NULL),(8,'autocreate','апрель',' 7 (495) 777-77-78','',' 7 (999) 222-33-33','2024-04-28 02:58:01',NULL,NULL);
/*!40000 ALTER TABLE `CLIENTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EMPLOYEES`
--

DROP TABLE IF EXISTS `EMPLOYEES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EMPLOYEES` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `COMMENT` text,
  `NAME` varchar(255) DEFAULT NULL,
  `PHONE1` varchar(255) DEFAULT NULL,
  `PHONE2` varchar(255) DEFAULT NULL,
  `PHONE3` varchar(255) DEFAULT NULL,
  `CREATED` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LOGIN` varchar(255) NOT NULL,
  `PASSWORD` varchar(255) NOT NULL COMMENT 'hash пароля',
  `STATUS` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EMPLOYEES`
--

LOCK TABLES `EMPLOYEES` WRITE;
/*!40000 ALTER TABLE `EMPLOYEES` DISABLE KEYS */;
INSERT INTO `EMPLOYEES` VALUES (1,NULL,'Антон','8916-345-77-25',NULL,NULL,'2018-04-11 14:55:55','anton','12345','работает'),(2,NULL,'Лариса','8915-095-54-01',NULL,NULL,'2021-06-08 22:47:06','larisa','12345','работает'),(3,'виртуальный сотрудник - для заказов, где не выбран сотрудник','не выбран',NULL,NULL,NULL,'2024-04-29 15:59:21','не выбран','несуществующий hash пароля, чтобы невозможно было под ним логиниться','работает');
/*!40000 ALTER TABLE `EMPLOYEES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ITEMS`
--

DROP TABLE IF EXISTS `ITEMS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ITEMS` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `COMMENT` varchar(255) NOT NULL,
  `MODEL_ID` int(11) NOT NULL,
  `PHOTO1` varchar(255) NOT NULL,
  `PHOTO2` varchar(255) NOT NULL,
  `PHOTO3` varchar(255) NOT NULL,
  `STATUS` varchar(255) NOT NULL,
  `CREATED` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `STOCK_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `MODEL_ID` (`MODEL_ID`),
  KEY `STOCK_ID` (`STOCK_ID`),
  CONSTRAINT `ITEMS_ibfk_1` FOREIGN KEY (`MODEL_ID`) REFERENCES `MODELS` (`ID`),
  CONSTRAINT `ITEMS_ibfk_2` FOREIGN KEY (`STOCK_ID`) REFERENCES `STOCKS` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ITEMS`
--

LOCK TABLES `ITEMS` WRITE;
/*!40000 ALTER TABLE `ITEMS` DISABLE KEYS */;
INSERT INTO `ITEMS` VALUES (1,'',1,'','','','','2018-04-11 14:55:55',2),(2,'',1,'','','','','2018-04-11 14:55:55',1),(3,'',1,'','','','','2018-04-11 14:55:55',1),(4,'',2,'','','','','2018-04-11 14:55:55',1),(5,'',2,'','','','','2018-04-11 14:55:55',1),(6,'',2,'','','','','2018-04-11 14:55:55',1),(7,'',3,'','','','','2018-04-11 14:55:55',2),(8,'',3,'','','','','2018-04-11 14:55:55',2),(9,'',3,'','','','','2018-04-11 14:55:55',1);
/*!40000 ALTER TABLE `ITEMS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ITEMS_TO_ORDERS`
--

DROP TABLE IF EXISTS `ITEMS_TO_ORDERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ITEMS_TO_ORDERS` (
  `ORDER_ID` int(11) NOT NULL,
  `ITEM_ID` int(11) NOT NULL,
  KEY `ITEM_ID` (`ITEM_ID`),
  KEY `ORDER_ID` (`ORDER_ID`),
  CONSTRAINT `ITEMS_TO_ORDERS_ibfk_1` FOREIGN KEY (`ITEM_ID`) REFERENCES `ITEMS` (`ID`),
  CONSTRAINT `ITEMS_TO_ORDERS_ibfk_2` FOREIGN KEY (`ORDER_ID`) REFERENCES `ORDERS` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ITEMS_TO_ORDERS`
--

LOCK TABLES `ITEMS_TO_ORDERS` WRITE;
/*!40000 ALTER TABLE `ITEMS_TO_ORDERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `ITEMS_TO_ORDERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MODELS`
--

DROP TABLE IF EXISTS `MODELS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MODELS` (
  `ID` int(11) NOT NULL,
  `COMMENT` varchar(255) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `TYPE` varchar(255) NOT NULL,
  `PHOTO1` varchar(255) NOT NULL,
  `PHOTO2` varchar(255) NOT NULL,
  `PHOTO3` varchar(255) NOT NULL,
  `VIDEO1` varchar(255) NOT NULL,
  `VIDEO2` varchar(255) NOT NULL,
  `VIDEO3` varchar(255) NOT NULL,
  `DESCRIPTION1` text NOT NULL,
  `DESCRIPTION2` text NOT NULL,
  `DESCRIPTION3` text NOT NULL,
  `CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MODELS`
--

LOCK TABLES `MODELS` WRITE;
/*!40000 ALTER TABLE `MODELS` DISABLE KEYS */;
INSERT INTO `MODELS` VALUES (1,'','Quechua T4','палатка','http://prokat-palatok.ru/user/tovar//t8.jpg','','','','','','Четырехместная туристическая палатка Quechua T4 - просторная кемпинговая палатка с большим тамбуром. Простая в установке и сделана из плотной ткани - надежно защитит от непогоды и поможет комфортно отдохнуть!','','','2018-04-11 11:55:55'),(2,'','Green Glade Nida4','палатка','http://prokat-palatok.ru/user/tovar//t9.jpg','','','','','','Синяя палатка','','','2018-04-11 11:55:55'),(3,'','Спальник','спальный мешок','http://prokat-palatok.ru/user/tovar//t10.jpg','','','','','','до +5С','','','2018-04-11 11:55:55'),(4,'fresh&black','Arpenaz 3XL','спальный мешок','http://prokat-palatok.ru/user/tovar//t10.jpg','','','','','','до +5С','','','2024-04-26 21:00:31');
/*!40000 ALTER TABLE `MODELS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MODELS_TO_ORDERS`
--

DROP TABLE IF EXISTS `MODELS_TO_ORDERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MODELS_TO_ORDERS` (
  `ORDER_ID` int(11) NOT NULL,
  `MODEL_ID` int(11) NOT NULL,
  `COUNT` int(11) NOT NULL,
  `PRICE` float NOT NULL,
  `DEPOSIT` float NOT NULL,
  KEY `MODEL_ID` (`MODEL_ID`),
  KEY `ORDER_ID` (`ORDER_ID`),
  CONSTRAINT `MODELS_TO_ORDERS_ibfk_1` FOREIGN KEY (`MODEL_ID`) REFERENCES `MODELS` (`ID`),
  CONSTRAINT `MODELS_TO_ORDERS_ibfk_2` FOREIGN KEY (`ORDER_ID`) REFERENCES `ORDERS` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MODELS_TO_ORDERS`
--

LOCK TABLES `MODELS_TO_ORDERS` WRITE;
/*!40000 ALTER TABLE `MODELS_TO_ORDERS` DISABLE KEYS */;
INSERT INTO `MODELS_TO_ORDERS` VALUES (1,1,1,1000,2000),(1,3,2,300,500),(2,1,1,1000,2000),(2,3,2,300,500),(7,2,1,1000,2000),(7,3,2,300,500),(18,1,1,1000,2000),(18,2,2,300,500),(19,1,1,1000,2000),(20,1,1,1000,2000),(20,2,2,300,500),(22,1,1,1000,2000),(22,2,2,300,500),(23,1,1,1000,2000),(23,2,2,300,500),(74,2,1,1000,2000),(75,1,1,1000,3000),(76,2,100,111,222),(78,1,1,100,300),(83,1,1,2,5),(85,1,1,2,5),(85,2,3,111,333),(87,1,1,2,2),(88,1,1,1,2),(89,2,1,100,200),(90,1,1,2,2),(91,1,1,2,2),(119,1,1,1,2),(120,1,1,1,2),(121,1,1,1,2),(128,1,1,1,1),(129,1,1,1,1),(130,1,1,1,2),(131,1,1,1,1),(132,2,1,1,1),(133,1,1,1,-2),(134,2,1,1,1);
/*!40000 ALTER TABLE `MODELS_TO_ORDERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MONEY_MOVEMENTS`
--

DROP TABLE IF EXISTS `MONEY_MOVEMENTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MONEY_MOVEMENTS` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FROM_ACCOUNT_ID` int(11) NOT NULL,
  `TO_ACCOUNT_ID` int(11) NOT NULL,
  `AMMOUNT` float NOT NULL,
  `CREATED` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `COMMENT` text,
  PRIMARY KEY (`ID`),
  KEY `ITEM_ID` (`AMMOUNT`),
  KEY `FROM_STOCK_ID` (`FROM_ACCOUNT_ID`),
  KEY `TO_STOCK_ID` (`TO_ACCOUNT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MONEY_MOVEMENTS`
--

LOCK TABLES `MONEY_MOVEMENTS` WRITE;
/*!40000 ALTER TABLE `MONEY_MOVEMENTS` DISABLE KEYS */;
/*!40000 ALTER TABLE `MONEY_MOVEMENTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MOVEMENTS`
--

DROP TABLE IF EXISTS `MOVEMENTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MOVEMENTS` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FROM_STOCK_ID` int(11) NOT NULL,
  `TO_STOCK_ID` int(11) NOT NULL,
  `ITEM_ID` int(11) NOT NULL,
  `CREATED` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `COMMENT` text,
  PRIMARY KEY (`ID`),
  KEY `ITEM_ID` (`ITEM_ID`),
  KEY `FROM_STOCK_ID` (`FROM_STOCK_ID`),
  KEY `TO_STOCK_ID` (`TO_STOCK_ID`),
  CONSTRAINT `MOVEMENTS_ibfk_1` FOREIGN KEY (`ITEM_ID`) REFERENCES `ITEMS` (`ID`),
  CONSTRAINT `MOVEMENTS_ibfk_2` FOREIGN KEY (`FROM_STOCK_ID`) REFERENCES `STOCKS` (`ID`),
  CONSTRAINT `MOVEMENTS_ibfk_3` FOREIGN KEY (`TO_STOCK_ID`) REFERENCES `STOCKS` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MOVEMENTS`
--

LOCK TABLES `MOVEMENTS` WRITE;
/*!40000 ALTER TABLE `MOVEMENTS` DISABLE KEYS */;
INSERT INTO `MOVEMENTS` VALUES (1,1,3,1,'2018-04-12 12:40:43','giving order # 1'),(2,1,3,8,'2018-04-12 12:40:43','giving order # 1'),(3,1,3,7,'2018-04-12 12:40:43','giving order # 1'),(4,3,2,1,'2018-04-12 12:40:51','giving order # 1'),(5,3,2,8,'2018-04-12 12:40:51','giving order # 1'),(6,3,2,7,'2018-04-12 12:40:51','giving order # 1');
/*!40000 ALTER TABLE `MOVEMENTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORDERS`
--

DROP TABLE IF EXISTS `ORDERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORDERS` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `STATUS_ID` int(11) NOT NULL,
  `COMMENT` text,
  `CLIENT_ID` int(11) NOT NULL,
  `CREATED` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `BEGIN` datetime NOT NULL,
  `END` datetime NOT NULL,
  `DELIVERY_ADDRESS_TO` varchar(1000) DEFAULT NULL,
  `DELIVERY_ADDRESS_FROM` varchar(1000) DEFAULT NULL,
  `TOTAL_AMOUNT` float NOT NULL,
  `TOTAL_DEPOSIT` float NOT NULL,
  `GIVER_ID` int(11) NOT NULL,
  `TAKER_ID` int(11) NOT NULL,
  `GIVE_STOCK_ID` int(11) NOT NULL,
  `TAKE_STOCK_ID` int(11) NOT NULL,
  `CHANNEL_ID` int(11) NOT NULL COMMENT 'откуда поступил заказ - от этого зависит цена',
  PRIMARY KEY (`ID`),
  KEY `CLIENT_ID` (`CLIENT_ID`),
  KEY `GIVER_ID` (`GIVER_ID`),
  KEY `TAKER_ID` (`TAKER_ID`),
  KEY `GIVE_STOCK_ID` (`GIVE_STOCK_ID`),
  KEY `TAKE_STOCK_ID` (`TAKE_STOCK_ID`),
  KEY `STATUS_ID` (`STATUS_ID`),
  KEY `CHANNEL_ID` (`CHANNEL_ID`),
  CONSTRAINT `ORDERS_ibfk_1` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENTS` (`ID`),
  CONSTRAINT `ORDERS_ibfk_2` FOREIGN KEY (`GIVER_ID`) REFERENCES `EMPLOYEES` (`ID`),
  CONSTRAINT `ORDERS_ibfk_3` FOREIGN KEY (`TAKER_ID`) REFERENCES `EMPLOYEES` (`ID`),
  CONSTRAINT `ORDERS_ibfk_4` FOREIGN KEY (`GIVE_STOCK_ID`) REFERENCES `STOCKS` (`ID`),
  CONSTRAINT `ORDERS_ibfk_5` FOREIGN KEY (`TAKE_STOCK_ID`) REFERENCES `STOCKS` (`ID`),
  CONSTRAINT `ORDERS_ibfk_6` FOREIGN KEY (`STATUS_ID`) REFERENCES `STATUS` (`ID`),
  CONSTRAINT `ORDERS_ibfk_7` FOREIGN KEY (`CHANNEL_ID`) REFERENCES `CHANNELS` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8 COMMENT='Таблица заказов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORDERS`
--

LOCK TABLES `ORDERS` WRITE;
/*!40000 ALTER TABLE `ORDERS` DISABLE KEYS */;
INSERT INTO `ORDERS` VALUES (1,2,'заказ с моделями',1,'2018-04-11 14:56:13','2018-04-12 12:40:43','2019-01-02 10:00:00','sdl,sl;d','sdfsd',1300,2500,1,1,1,2,1),(2,0,'заказ с моделями',1,'2018-04-11 14:56:18','2019-01-01 09:00:00','2019-01-02 10:00:00','sdl,sl;d','sdfsd',1300,2500,1,1,1,2,1),(6,0,'заказ1',1,'2021-06-08 22:49:30','2022-01-01 09:00:00','2022-01-02 10:00:00','sdl,sl;d','sdfsd',1300,2500,1,2,1,3,1),(7,0,'заказ1',1,'2021-06-08 22:49:59','2022-01-01 09:00:00','2022-01-02 10:00:00','sdl,sl;d','sdfsd',1300,2500,1,2,1,3,1),(17,0,'заказ1',1,'2024-04-26 18:14:53','2019-01-01 09:00:00','2019-01-02 10:00:00','sdl,sl;d','sdfsd',1300,2500,1,2,1,2,1),(18,0,'заказ1',1,'2024-04-26 18:15:10','2019-01-01 09:00:00','2019-01-02 10:00:00','sdl,sl;d','sdfsd',1300,2500,1,2,1,2,1),(19,0,'заказ1',1,'2024-04-26 18:15:27','2019-01-01 09:00:00','2019-01-02 10:00:00','sdl,sl;d','sdfsd',1300,2500,1,2,1,2,1),(20,0,'заказ1',1,'2024-04-26 18:16:40','2019-01-01 09:00:00','2019-01-02 10:00:00','sdl,sl;d','sdfsd',1300,2500,1,2,1,2,1),(22,0,'заказ1',1,'2024-04-26 19:10:09','0000-00-00 00:00:00','0000-00-00 00:00:00','sdl,sl;d','sdfsd',1300,2500,1,2,1,2,1),(23,0,'заказ1',1,'2024-04-26 19:10:15','0000-00-00 00:00:00','0000-00-00 00:00:00','sdl,sl;d','sdfsd',1300,2500,1,2,1,2,1),(26,0,NULL,1,'2024-04-26 22:13:45','0000-00-00 00:00:00','0000-00-00 00:00:00','Твардовского,18-4-123','Твардовского,18-4-123',0,0,1,1,1,1,1),(27,0,NULL,1,'2024-04-26 22:13:51','0000-00-00 00:00:00','0000-00-00 00:00:00','Твардовского,18-4-123','Твардовского,18-4-123',0,0,1,1,1,1,1),(28,0,NULL,1,'2024-04-26 22:14:54','0000-00-00 00:00:00','0000-00-00 00:00:00','Твардовского,18-4-123','Твардовского,18-4-123',0,0,1,1,1,1,1),(29,0,NULL,1,'2024-04-26 22:34:23','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(30,0,NULL,1,'2024-04-26 22:36:43','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(31,0,NULL,1,'2024-04-26 22:37:26','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(32,0,NULL,1,'2024-04-26 22:42:02','0000-00-00 00:00:00','0000-00-00 00:00:00','Твардовского,18-4-123','Твардовского,18-4-123',0,0,1,1,1,1,1),(33,0,NULL,1,'2024-04-26 22:42:25','0000-00-00 00:00:00','0000-00-00 00:00:00','Твардовского,18-4-123','Твардовского,18-4-123',0,0,1,1,1,1,1),(34,0,NULL,1,'2024-04-26 22:43:28','0000-00-00 00:00:00','0000-00-00 00:00:00','Твардовского,18-4-123','Твардовского,18-4-123',0,0,1,1,1,1,1),(35,0,NULL,2,'2024-04-26 22:46:24','0000-00-00 00:00:00','0000-00-00 00:00:00','Твардовского,18-4-123','Твардовского,18-4-123',0,0,1,1,1,1,1),(36,0,NULL,2,'2024-04-26 22:46:26','0000-00-00 00:00:00','0000-00-00 00:00:00','Твардовского,18-4-123','Твардовского,18-4-123',0,0,1,1,1,1,1),(37,0,NULL,2,'2024-04-26 22:46:28','0000-00-00 00:00:00','0000-00-00 00:00:00','Твардовского,18-4-123','Твардовского,18-4-123',0,0,1,1,1,1,1),(38,0,NULL,2,'2024-04-26 22:46:28','0000-00-00 00:00:00','0000-00-00 00:00:00','Твардовского,18-4-123','Твардовского,18-4-123',0,0,1,1,1,1,1),(39,0,NULL,3,'2024-04-26 22:47:06','0000-00-00 00:00:00','0000-00-00 00:00:00','Твардовского,18-4-123','Твардовского,18-4-123',0,0,1,1,1,1,1),(40,0,NULL,4,'2024-04-26 22:58:09','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(41,0,NULL,5,'2024-04-27 00:20:41','0000-00-00 00:00:00','0000-00-00 00:00:00','Твардовского,18-4-123','Твардовского,18-4-123',0,0,1,1,1,1,1),(42,0,NULL,6,'2024-04-27 00:27:42','0000-00-00 00:00:00','0000-00-00 00:00:00','Верхнелихоборская улица, 4а','Верхнелихоборская улица, 4а',0,0,1,1,1,1,1),(43,0,NULL,6,'2024-04-27 00:29:07','0000-00-00 00:00:00','0000-00-00 00:00:00','Верхнелихоборская улица, 4а','Верхнелихоборская улица, 4а',0,0,1,1,1,1,1),(44,0,NULL,6,'2024-04-27 00:29:52','0000-00-00 00:00:00','0000-00-00 00:00:00','Верхнелихоборская улица, 4а','Верхнелихоборская улица, 4а',0,0,1,1,1,1,1),(45,0,NULL,6,'2024-04-27 00:30:35','0000-00-00 00:00:00','0000-00-00 00:00:00','Верхнелихоборская улица, 4а','Верхнелихоборская улица, 4а',0,0,1,1,1,1,1),(46,0,NULL,6,'2024-04-27 00:30:56','0000-00-00 00:00:00','0000-00-00 00:00:00','Верхнелихоборская улица, 4а','Верхнелихоборская улица, 4а',0,0,1,1,1,1,1),(47,0,NULL,6,'2024-04-27 00:31:37','0000-00-00 00:00:00','0000-00-00 00:00:00','Верхнелихоборская улица, 4а','Верхнелихоборская улица, 4а',0,0,1,1,1,1,1),(48,0,NULL,6,'2024-04-27 00:33:43','0000-00-00 00:00:00','0000-00-00 00:00:00','Верхнелихоборская улица, 4а','Верхнелихоборская улица, 4а',0,0,1,1,1,1,1),(49,0,NULL,5,'2024-04-27 01:02:04','0000-00-00 00:00:00','0000-00-00 00:00:00','Твардовского,18-4-123','Твардовского,18-4-123',0,0,1,1,1,1,1),(50,0,NULL,6,'2024-04-27 01:03:05','0000-00-00 00:00:00','0000-00-00 00:00:00','Верхнелихоборская улица, 4а','Верхнелихоборская улица, 4а',0,0,1,1,1,1,1),(51,0,NULL,6,'2024-04-27 01:05:53','0000-00-00 00:00:00','0000-00-00 00:00:00','Верхнелихоборская улица, 4а','Верхнелихоборская улица, 4а',0,0,1,1,1,1,1),(52,0,NULL,6,'2024-04-27 01:07:01','0000-00-00 00:00:00','0000-00-00 00:00:00','Верхнелихоборская улица, 4а','Верхнелихоборская улица, 4а',0,0,1,1,1,1,1),(53,0,NULL,5,'2024-04-27 01:10:51','0000-00-00 00:00:00','0000-00-00 00:00:00','Твардовского,18-4-123','Твардовского,18-4-123',0,0,1,1,1,1,1),(54,0,NULL,7,'2024-04-27 01:12:19','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(55,0,NULL,7,'2024-04-27 01:14:01','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(56,0,NULL,7,'2024-04-27 01:15:24','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(57,0,NULL,7,'2024-04-27 01:17:21','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(58,0,NULL,7,'2024-04-27 01:24:21','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(59,0,NULL,7,'2024-04-27 01:24:45','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(60,0,NULL,7,'2024-04-27 01:29:08','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(61,0,NULL,7,'2024-04-27 01:29:49','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(62,0,NULL,7,'2024-04-27 01:31:09','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(63,0,NULL,7,'2024-04-27 01:31:57','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(64,0,NULL,5,'2024-04-27 13:22:18','2024-04-11 00:00:00','2024-04-24 00:00:00','Твардовского,18-4-123','Твардовского,18-4-123',0,0,1,1,1,1,1),(65,0,NULL,7,'2024-04-27 19:54:38','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(66,0,NULL,7,'2024-04-27 19:59:51','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(67,0,NULL,7,'2024-04-27 20:23:55','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(68,0,NULL,7,'2024-04-27 20:30:21','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(69,0,NULL,7,'2024-04-27 20:32:01','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(70,0,NULL,7,'2024-04-27 20:35:21','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(71,0,NULL,7,'2024-04-27 20:36:11','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(72,0,NULL,7,'2024-04-27 20:44:23','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(73,0,NULL,7,'2024-04-27 20:45:24','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(74,0,NULL,7,'2024-04-27 20:47:35','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(75,0,NULL,5,'2024-04-27 21:19:00','0000-00-00 00:00:00','0000-00-00 00:00:00','Твардовского,18-4-123','Твардовского,18-4-123',0,0,1,1,1,1,1),(76,0,NULL,7,'2024-04-27 23:01:40','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(77,0,NULL,7,'2024-04-27 23:04:43','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(78,0,NULL,7,'2024-04-27 23:08:00','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(79,0,NULL,7,'2024-04-27 23:26:12','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(80,0,NULL,7,'2024-04-28 00:18:07','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(81,0,NULL,7,'2024-04-28 00:18:59','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(82,0,NULL,7,'2024-04-28 00:20:52','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(83,0,NULL,7,'2024-04-28 00:25:32','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(84,0,NULL,7,'2024-04-28 00:26:07','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(85,0,NULL,7,'2024-04-28 00:39:13','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(86,0,NULL,7,'2024-04-28 02:20:32','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(87,0,NULL,7,'2024-04-28 02:38:08','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(88,0,NULL,7,'2024-04-28 02:41:07','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(89,0,NULL,8,'2024-04-28 02:58:01','2024-04-30 00:00:00','2024-05-01 00:00:00','','',0,0,1,2,1,2,1),(90,0,NULL,5,'2024-04-28 03:18:43','2024-04-09 00:00:00','2024-04-18 00:00:00','Твардовского,18-4-123','Твардовского,18-4-123',0,0,1,1,2,1,1),(91,0,NULL,5,'2024-04-28 03:20:16','2024-04-09 00:00:00','2024-04-18 00:00:00','Твардовского,18-4-123','Твардовского,18-4-123',0,0,1,1,2,1,1),(92,0,NULL,7,'2024-04-28 03:20:32','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(93,0,NULL,7,'2024-04-28 03:22:09','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(94,0,NULL,7,'2024-04-28 03:27:52','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(95,0,NULL,7,'2024-04-28 03:29:33','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(96,0,NULL,7,'2024-04-28 03:30:26','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(97,0,NULL,7,'2024-04-28 03:31:54','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(98,0,NULL,7,'2024-04-28 03:32:49','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(99,0,NULL,7,'2024-04-28 03:35:26','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(100,0,NULL,7,'2024-04-28 03:42:15','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(101,0,NULL,7,'2024-04-28 03:43:37','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(102,0,NULL,7,'2024-04-28 03:44:10','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(103,0,NULL,7,'2024-04-29 13:07:09','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(104,0,NULL,7,'2024-04-29 13:08:01','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(105,0,NULL,7,'2024-04-29 13:08:26','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(106,0,NULL,7,'2024-04-29 13:09:51','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(107,0,NULL,7,'2024-04-29 13:11:41','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(108,0,NULL,7,'2024-04-29 13:14:43','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(109,0,NULL,7,'2024-04-29 13:18:40','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(110,0,NULL,7,'2024-04-29 13:25:53','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(111,0,NULL,7,'2024-04-29 13:26:56','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(112,0,NULL,7,'2024-04-29 13:29:19','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(113,0,NULL,7,'2024-04-29 13:30:49','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(114,0,NULL,7,'2024-04-29 13:31:49','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(115,0,NULL,7,'2024-04-29 13:31:59','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(116,0,NULL,7,'2024-04-29 13:32:51','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(117,0,NULL,7,'2024-04-29 13:32:58','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(118,0,NULL,7,'2024-04-29 13:53:15','0000-00-00 00:00:00','0000-00-00 00:00:00','','',0,0,1,1,1,1,1),(119,0,NULL,7,'2024-04-29 14:14:39','2024-04-29 00:00:00','2024-04-27 00:00:00','','',0,0,1,1,1,1,1),(120,0,NULL,7,'2024-04-29 14:16:31','2024-04-29 00:00:00','2024-04-27 00:00:00','','',0,0,1,1,1,1,1),(121,0,NULL,7,'2024-04-29 14:17:27','2024-04-29 00:00:00','2024-04-27 00:00:00','','',0,0,1,1,1,1,1),(128,0,NULL,7,'2024-04-29 15:44:38','2024-04-02 00:00:00','2024-04-26 00:00:00','','',0,0,1,1,2,0,1),(129,0,NULL,7,'2024-04-29 16:00:23','2024-04-02 00:00:00','2024-04-26 00:00:00','','',0,0,1,1,2,0,1),(130,0,NULL,7,'2024-04-29 17:23:48','2024-04-13 00:00:00','2024-04-16 00:00:00','','',0,0,1,1,1,0,1),(131,0,NULL,7,'2024-04-29 17:34:30','2024-04-05 00:00:00','2024-04-20 00:00:00','','',0,0,1,1,1,0,1),(132,0,NULL,7,'2024-04-29 17:36:55','2024-04-12 00:00:00','2024-04-18 00:00:00','','',0,0,1,1,2,0,1),(133,0,NULL,7,'2024-04-29 17:39:27','2024-04-24 00:00:00','2024-04-26 00:00:00','','',0,0,1,1,2,0,1),(134,0,NULL,7,'2024-04-29 18:10:09','2024-04-20 00:00:00','2024-04-20 00:00:00','','',0,0,2,1,1,0,1);
/*!40000 ALTER TABLE `ORDERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PARAMETERS`
--

DROP TABLE IF EXISTS `PARAMETERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PARAMETERS` (
  `ID` int(11) NOT NULL,
  `COMMENT` text NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  `CREATED` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PARAMETERS`
--

LOCK TABLES `PARAMETERS` WRITE;
/*!40000 ALTER TABLE `PARAMETERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `PARAMETERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRICELIST`
--

DROP TABLE IF EXISTS `PRICELIST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRICELIST` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MODEL_ID` int(11) NOT NULL,
  `CHANNEL_ID` int(11) NOT NULL,
  `PRICE_FOR_PERIOD` float NOT NULL,
  `DEPOSIT_FOR_PERIOD` float NOT NULL,
  `FULL_PRICE_FOR_PERIOD` float NOT NULL,
  `PERIOD_MIN` float NOT NULL,
  `PERIOD_MAX` float NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRICELIST`
--

LOCK TABLES `PRICELIST` WRITE;
/*!40000 ALTER TABLE `PRICELIST` DISABLE KEYS */;
INSERT INTO `PRICELIST` VALUES (1,1,1,1000,2000,3000,0,4),(2,1,1,1300,2000,3300,5,6),(3,1,1,1500,2000,3500,7,13),(4,1,1,2000,2000,4000,14,999);
/*!40000 ALTER TABLE `PRICELIST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `STATUS`
--

DROP TABLE IF EXISTS `STATUS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `STATUS` (
  `ID` int(11) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STATUS`
--

LOCK TABLES `STATUS` WRITE;
/*!40000 ALTER TABLE `STATUS` DISABLE KEYS */;
INSERT INTO `STATUS` VALUES (0,'ожидает'),(1,'забрали'),(2,'вернули'),(3,'отказали'),(4,'отказались'),(5,'перезвонить'),(6,'пропущен'),(7,'купили'),(8,'дубль');
/*!40000 ALTER TABLE `STATUS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `STOCKS`
--

DROP TABLE IF EXISTS `STOCKS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `STOCKS` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ADDRESS` varchar(1000) NOT NULL,
  `NAME` varchar(1000) NOT NULL,
  `CREATED` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `COMMENT` varchar(1000) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Таблица складов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STOCKS`
--

LOCK TABLES `STOCKS` WRITE;
/*!40000 ALTER TABLE `STOCKS` DISABLE KEYS */;
INSERT INTO `STOCKS` VALUES (0,'виртуальный','не выбран','2024-04-29 15:33:03','виртуальный склад - для заказов, где не выбран склад'),(1,'Ленинградский проспект, 74к4','Сокол','2018-04-11 14:55:55','Газель у Юниаструма'),(2,'Верхнелихоборская, 4а','Склад Верхнелихоборская','2018-04-11 14:55:55','основная комната большого склада'),(3,'в прокате','в прокате','2018-04-11 14:55:55','виртуальный склад - то, что находится у клиентов'),(4,'Завидово','Нашествие','2020-06-21 22:33:28','');
/*!40000 ALTER TABLE `STOCKS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bot`
--

DROP TABLE IF EXISTS `bot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bot` (
  `message_id` int(11) NOT NULL,
  `chat_id` int(11) NOT NULL,
  `last_level` int(11) NOT NULL,
  `full_post` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bot`
--

LOCK TABLES `bot` WRITE;
/*!40000 ALTER TABLE `bot` DISABLE KEYS */;
/*!40000 ALTER TABLE `bot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'prokatparu_crm'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-29 18:22:18
