-- MySQL dump 10.13  Distrib 8.0.40, for Linux (x86_64)
--
-- Host: localhost    Database: sushi
-- ------------------------------------------------------
-- Server version	8.0.40-0ubuntu0.24.04.1

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
-- Table structure for table `customer_order`
--

DROP TABLE IF EXISTS `customer_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_order` (
  `order_num` smallint unsigned NOT NULL,
  `date` datetime NOT NULL,
  `check` decimal(10,2) NOT NULL,
  `tip` decimal(7,2) DEFAULT NULL,
  `status` enum('OPEN','PENDING','CLOSED') NOT NULL,
  `emp_id` char(5) NOT NULL,
  PRIMARY KEY (`order_num`),
  KEY `emp_id` (`emp_id`),
  CONSTRAINT `customer_order_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_order`
--

LOCK TABLES `customer_order` WRITE;
/*!40000 ALTER TABLE `customer_order` DISABLE KEYS */;
INSERT INTO `customer_order` VALUES (1,'2023-10-20 12:00:00',25.97,5.00,'CLOSED','E001'),(2,'2023-10-20 12:30:00',13.49,3.00,'PENDING','E001');
/*!40000 ALTER TABLE `customer_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dish`
--

DROP TABLE IF EXISTS `dish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dish` (
  `dish_name` varchar(30) NOT NULL,
  `price` decimal(7,2) NOT NULL,
  PRIMARY KEY (`dish_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dish`
--

LOCK TABLES `dish` WRITE;
/*!40000 ALTER TABLE `dish` DISABLE KEYS */;
INSERT INTO `dish` VALUES ('Avocado Roll',6.50),('California Roll',8.99),('Dragon Roll',12.99),('Edamame',4.50),('Miso Soup',2.99),('Salmon Nigiri',5.50),('Spicy Tuna Roll',9.99);
/*!40000 ALTER TABLE `dish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp_shift`
--

DROP TABLE IF EXISTS `emp_shift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emp_shift` (
  `emp_id` char(5) NOT NULL,
  `shift_id` char(5) NOT NULL,
  `cur_pos` enum('Server','Busser','Manager','Cook','Dish','Expo','Host') NOT NULL,
  PRIMARY KEY (`emp_id`,`shift_id`),
  KEY `shift_id` (`shift_id`),
  CONSTRAINT `emp_shift_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`),
  CONSTRAINT `emp_shift_ibfk_2` FOREIGN KEY (`shift_id`) REFERENCES `shift` (`shift_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_shift`
--

LOCK TABLES `emp_shift` WRITE;
/*!40000 ALTER TABLE `emp_shift` DISABLE KEYS */;
INSERT INTO `emp_shift` VALUES ('E001','S001','Server'),('E001','S002','Server'),('E001','S003','Host'),('E002','S001','Busser'),('E002','S003','Dish'),('E003','S001','Cook'),('E003','S003','Cook'),('E004','S001','Host'),('E004','S002','Server'),('E004','S003','Server'),('E005','S002','Expo'),('E006','S002','Cook'),('M001','S001','Manager'),('M001','S003','Manager'),('M002','S002','Manager');
/*!40000 ALTER TABLE `emp_shift` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `emp_id` char(5) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `hourly_rate` decimal(7,2) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `status` enum('On Shift','Off Shift','Inactive') NOT NULL,
  `employment_type` enum('Hourly','Salaried') NOT NULL,
  PRIMARY KEY (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('E001','Alice','Johnson',NULL,15.00,'2021-06-10','Off Shift','Hourly'),('E002','Bob','Williams',NULL,14.50,'2021-07-12','Off Shift','Hourly'),('E003','Charlie','Brown',NULL,15.50,'2022-02-15','Off Shift','Hourly'),('E004','Daisy','Miller',NULL,14.00,'2022-03-18','Off Shift','Hourly'),('E005','Evan','Davis',NULL,13.50,'2022-04-22','Off Shift','Hourly'),('E006','Fiona','Garcia',NULL,14.75,'2022-05-30','Off Shift','Hourly'),('M001','John','Smith',60000.00,NULL,'2020-01-15','Off Shift','Salaried'),('M002','Jane','Doe',65000.00,NULL,'2019-05-20','Off Shift','Salaried');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredient`
--

DROP TABLE IF EXISTS `ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredient` (
  `ing_name` varchar(30) NOT NULL,
  `exp_date` date DEFAULT NULL,
  `quantity` decimal(7,2) NOT NULL,
  `unit` varchar(10) NOT NULL,
  PRIMARY KEY (`ing_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient`
--

LOCK TABLES `ingredient` WRITE;
/*!40000 ALTER TABLE `ingredient` DISABLE KEYS */;
INSERT INTO `ingredient` VALUES ('Avocado','2023-10-22',30.00,'pcs'),('Cucumber','2023-10-22',25.00,'pcs'),('Edamame Beans','2023-10-28',20.00,'kg'),('Eel','2023-10-24',5.00,'kg'),('Green Onions','2023-10-22',5.00,'kg'),('Green Tea','2024-03-01',5.00,'kg'),('Miso Paste','2024-02-01',10.00,'kg'),('Nori','2023-12-31',50.00,'packs'),('Salmon','2023-10-23',15.00,'kg'),('Salt','2025-01-01',20.00,'kg'),('Soy Sauce','2024-05-01',10.00,'L'),('Spicy Mayo','2023-11-01',2.00,'kg'),('Sushi Rice','2023-11-15',100.00,'kg'),('Tofu','2023-10-23',10.00,'kg'),('Tuna','2023-10-25',20.00,'kg'),('Wasabi','2024-01-01',5.00,'kg');
/*!40000 ALTER TABLE `ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `position`
--

DROP TABLE IF EXISTS `position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `position` (
  `emp_id` char(5) NOT NULL,
  `position` enum('Server','Busser','Cook','Dish','Expo','Host') NOT NULL,
  PRIMARY KEY (`emp_id`,`position`),
  CONSTRAINT `position_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `position`
--

LOCK TABLES `position` WRITE;
/*!40000 ALTER TABLE `position` DISABLE KEYS */;
INSERT INTO `position` VALUES ('E001','Server'),('E001','Host'),('E002','Busser'),('E002','Dish'),('E003','Cook'),('E003','Dish'),('E004','Server'),('E004','Host'),('E005','Dish'),('E005','Expo'),('E006','Busser'),('E006','Cook');
/*!40000 ALTER TABLE `position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe`
--

DROP TABLE IF EXISTS `recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe` (
  `dish_name` varchar(30) NOT NULL,
  `ing_name` varchar(30) NOT NULL,
  PRIMARY KEY (`dish_name`,`ing_name`),
  KEY `ing_name` (`ing_name`),
  CONSTRAINT `recipe_ibfk_1` FOREIGN KEY (`dish_name`) REFERENCES `dish` (`dish_name`),
  CONSTRAINT `recipe_ibfk_2` FOREIGN KEY (`ing_name`) REFERENCES `ingredient` (`ing_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe`
--

LOCK TABLES `recipe` WRITE;
/*!40000 ALTER TABLE `recipe` DISABLE KEYS */;
INSERT INTO `recipe` VALUES ('Avocado Roll','Avocado'),('California Roll','Avocado'),('Dragon Roll','Avocado'),('California Roll','Cucumber'),('Edamame','Edamame Beans'),('Dragon Roll','Eel'),('Miso Soup','Green Onions'),('Miso Soup','Miso Paste'),('Avocado Roll','Nori'),('California Roll','Nori'),('Dragon Roll','Nori'),('Spicy Tuna Roll','Nori'),('Salmon Nigiri','Salmon'),('Edamame','Salt'),('Spicy Tuna Roll','Spicy Mayo'),('Avocado Roll','Sushi Rice'),('California Roll','Sushi Rice'),('Dragon Roll','Sushi Rice'),('Salmon Nigiri','Sushi Rice'),('Spicy Tuna Roll','Sushi Rice'),('Miso Soup','Tofu'),('Spicy Tuna Roll','Tuna');
/*!40000 ALTER TABLE `recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant_table`
--

DROP TABLE IF EXISTS `restaurant_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant_table` (
  `table_num` tinyint unsigned NOT NULL,
  `status` enum('Occupied','Open','Need Cleaning') NOT NULL,
  `max_capa` tinyint unsigned NOT NULL,
  PRIMARY KEY (`table_num`),
  CONSTRAINT `restaurant_table_chk_1` CHECK ((`max_capa` >= 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_table`
--

LOCK TABLES `restaurant_table` WRITE;
/*!40000 ALTER TABLE `restaurant_table` DISABLE KEYS */;
INSERT INTO `restaurant_table` VALUES (1,'Open',4),(2,'Open',4),(3,'Open',2),(4,'Open',2),(5,'Open',6),(6,'Open',6),(7,'Open',4),(8,'Open',4),(9,'Open',2),(10,'Open',2);
/*!40000 ALTER TABLE `restaurant_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shift`
--

DROP TABLE IF EXISTS `shift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shift` (
  `shift_id` char(5) NOT NULL,
  `date` date NOT NULL,
  `time_start` time NOT NULL,
  `time_end` time NOT NULL,
  PRIMARY KEY (`shift_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shift`
--

LOCK TABLES `shift` WRITE;
/*!40000 ALTER TABLE `shift` DISABLE KEYS */;
INSERT INTO `shift` VALUES ('S001','2023-10-20','10:00:00','16:00:00'),('S002','2023-10-20','16:00:00','22:00:00'),('S003','2023-10-21','10:00:00','16:00:00');
/*!40000 ALTER TABLE `shift` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `table_order`
--

DROP TABLE IF EXISTS `table_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `table_order` (
  `table_num` tinyint unsigned NOT NULL,
  `order_num` smallint unsigned NOT NULL,
  PRIMARY KEY (`table_num`,`order_num`),
  KEY `order_num` (`order_num`),
  CONSTRAINT `table_order_ibfk_1` FOREIGN KEY (`table_num`) REFERENCES `restaurant_table` (`table_num`),
  CONSTRAINT `table_order_ibfk_2` FOREIGN KEY (`order_num`) REFERENCES `customer_order` (`order_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `table_order`
--

LOCK TABLES `table_order` WRITE;
/*!40000 ALTER TABLE `table_order` DISABLE KEYS */;
INSERT INTO `table_order` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `table_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `order_num` smallint unsigned NOT NULL,
  `dish_name` varchar(30) NOT NULL,
  `description` varchar(255) DEFAULT '',
  `quantity` smallint unsigned NOT NULL,
  PRIMARY KEY (`order_num`,`dish_name`),
  KEY `dish_name` (`dish_name`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`order_num`) REFERENCES `customer_order` (`order_num`),
  CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`dish_name`) REFERENCES `dish` (`dish_name`),
  CONSTRAINT `ticket_chk_1` CHECK ((`quantity` >= 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (1,'Dragon Roll','',1),(1,'Miso Soup','',1),(1,'Spicy Tuna Roll','',1),(2,'California Roll','',1),(2,'Edamame','',1);
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-18 12:14:17
