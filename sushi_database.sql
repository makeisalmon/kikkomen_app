-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: sushi
-- ------------------------------------------------------
-- Server version	8.0.40-0ubuntu0.24.04.1

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
-- Table structure for table `cus_order`
--

DROP TABLE IF EXISTS `cus_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cus_order` (
  `order_num` smallint unsigned NOT NULL,
  `table_num` tinyint unsigned NOT NULL,
  `date` datetime NOT NULL,
  `order_total` decimal(6,2) DEFAULT NULL,
  `tip` decimal(6,2) DEFAULT NULL,
  `status` enum('OPEN','PENDING','CLOSED') NOT NULL,
  `emp_id` char(5) NOT NULL,
  PRIMARY KEY (`order_num`),
  KEY `emp_id` (`emp_id`),
  KEY `table_num` (`table_num`),
  CONSTRAINT `cus_order_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`),
  CONSTRAINT `cus_order_ibfk_2` FOREIGN KEY (`table_num`) REFERENCES `res_table` (`table_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cus_order`
--

LOCK TABLES `cus_order` WRITE;
/*!40000 ALTER TABLE `cus_order` DISABLE KEYS */;
INSERT INTO `cus_order` VALUES (1,3,'2024-11-25 18:00:47',43.94,6.38,'CLOSED','E001'),(2,4,'2024-11-25 18:03:40',40.95,6.00,'CLOSED','E002'),(3,5,'2024-11-25 18:28:23',31.97,5.00,'CLOSED','E001'),(4,6,'2024-11-25 18:31:09',37.97,7.59,'CLOSED','E002'),(5,7,'2024-11-25 18:39:28',51.93,7.65,'CLOSED','E001'),(6,8,'2024-11-25 18:47:54',39.95,5.05,'CLOSED','E002'),(7,3,'2024-11-25 19:04:41',NULL,NULL,'OPEN','E001'),(8,4,'2024-11-25 19:17:13',NULL,NULL,'OPEN','E002');
/*!40000 ALTER TABLE `cus_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dish`
--

DROP TABLE IF EXISTS `dish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dish` (
  `dish_name` varchar(30) NOT NULL,
  `price` decimal(5,2) NOT NULL,
  PRIMARY KEY (`dish_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dish`
--

LOCK TABLES `dish` WRITE;
/*!40000 ALTER TABLE `dish` DISABLE KEYS */;
INSERT INTO `dish` VALUES ('Bubba Gump Roll',11.99),('California Roll',9.99),('Clear Soup',3.99),('Dragon Roll',12.99),('Godzilla Roll',10.99),('Little Tokyo Roll',12.99),('Miso Soup',3.99),('Philly Roll',11.99),('Phoenix Roll',10.99),('Rainbow Roll',12.99),('Spicy Tuna Roll',9.99),('Tiger Roll',11.99);
/*!40000 ALTER TABLE `dish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp_shift`
--

DROP TABLE IF EXISTS `emp_shift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emp_shift` (
  `emp_id` char(4) NOT NULL,
  `shift_id` char(4) NOT NULL,
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
INSERT INTO `emp_shift` VALUES ('E001','S001','Server'),('E001','S002','Server'),('E001','S003','Host'),('E001','S005','Server'),('E001','S006','Server'),('E001','S007','Server'),('E001','S010','Server'),('E001','S011','Server'),('E001','S012','Host'),('E002','S001','Server'),('E002','S002','Server'),('E002','S003','Busser'),('E002','S004','Server'),('E002','S005','Host'),('E002','S006','Server'),('E002','S007','Server'),('E002','S008','Server'),('E002','S009','Server'),('E002','S010','Server'),('E002','S011','Server'),('E002','S012','Server'),('E002','S013','Busser'),('E002','S014','Busser'),('E003','S001','Host'),('E003','S002','Host'),('E003','S004','Host'),('E003','S007','Host'),('E003','S008','Host'),('E003','S009','Host'),('E003','S011','Host'),('E003','S013','Host'),('E003','S014','Host'),('E004','S003','Server'),('E004','S004','Server'),('E004','S005','Server'),('E004','S006','Host'),('E004','S008','Server'),('E004','S009','Server'),('E004','S010','Host'),('E004','S012','Server'),('E004','S013','Server'),('E004','S014','Server'),('E005','S002','Cook'),('E005','S004','Cook'),('E005','S005','Cook'),('E005','S006','Cook'),('E005','S008','Cook'),('E005','S009','Cook'),('E005','S011','Cook'),('E005','S012','Cook'),('E005','S014','Cook'),('E006','S001','Cook'),('E006','S003','Expo'),('E006','S004','Cook'),('E006','S005','Expo'),('E006','S007','Expo'),('E006','S008','Cook'),('E006','S009','Expo'),('E006','S010','Cook'),('E006','S011','Expo'),('E006','S012','Cook'),('E006','S013','Cook'),('E006','S014','Cook'),('E007','S002','Expo'),('E007','S003','Cook'),('E007','S004','Expo'),('E007','S006','Expo'),('E007','S007','Cook'),('E007','S008','Expo'),('E007','S010','Expo'),('E007','S011','Cook'),('E007','S012','Expo'),('E007','S013','Cook'),('E007','S014','Expo'),('E008','S001','Cook'),('E008','S002','Cook'),('E008','S003','Cook'),('E008','S005','Cook'),('E008','S006','Cook'),('E008','S007','Cook'),('E008','S009','Cook'),('E008','S010','Cook'),('E009','S004','Dish'),('E009','S008','Dish'),('E009','S010','Dish'),('E009','S012','Dish'),('E009','S014','Dish'),('E010','S001','Dish'),('E010','S003','Dish'),('E010','S005','Dish'),('E010','S007','Dish'),('E010','S009','Dish'),('E010','S011','Dish'),('E010','S013','Dish'),('M001','S001','Manager'),('M001','S002','Manager'),('M001','S003','Manager'),('M001','S004','Manager'),('M001','S009','Manager'),('M001','S010','Manager'),('M001','S011','Manager'),('M001','S012','Manager'),('M001','S013','Manager'),('M001','S014','Manager'),('M002','S005','Manager'),('M002','S006','Manager'),('M002','S007','Manager'),('M002','S008','Manager'),('M002','S009','Manager'),('M002','S010','Manager'),('M002','S011','Manager'),('M002','S012','Manager'),('M002','S013','Manager'),('M002','S014','Manager');
/*!40000 ALTER TABLE `emp_shift` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `emp_id` char(4) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `salary` decimal(8,2) DEFAULT NULL,
  `hourly_rate` decimal(4,2) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `status` enum('On Shift','Off Shift','Inactive') NOT NULL,
  `emp_type` enum('Hourly','Salaried') NOT NULL,
  PRIMARY KEY (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('E001','John','Doe',NULL,11.25,'2020-10-01','On Shift','Hourly'),('E002','Jane','Smith',NULL,11.25,'2021-07-15','On Shift','Hourly'),('E003','Paul','Jones',NULL,10.00,'2022-01-20','On Shift','Hourly'),('E004','Emily','Davis',NULL,12.50,'2019-05-10','Off Shift','Hourly'),('E005','Chris','Brown',NULL,12.00,'2017-12-05','On Shift','Hourly'),('E006','Kim','Wilson',NULL,13.25,'2023-02-01','Off Shift','Hourly'),('E007','James','Taylor',NULL,13.25,'2021-11-11','On Shift','Hourly'),('E008','Sarah','Lee',NULL,12.00,'2020-03-22','On Shift','Hourly'),('E009','Tony','Johnson',NULL,10.00,'2023-02-01','Off Shift','Hourly'),('E010','Michael','Carter',NULL,11.25,'2021-11-11','Off Shift','Hourly'),('M001','Alice','Kim',85000.00,NULL,'2015-06-15','On Shift','Salaried'),('M002','Bob','Lee',55000.00,NULL,'2018-03-12','Off Shift','Salaried');
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
  `quantity` decimal(7,2) DEFAULT NULL,
  `unit` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ing_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient`
--

LOCK TABLES `ingredient` WRITE;
/*!40000 ALTER TABLE `ingredient` DISABLE KEYS */;
INSERT INTO `ingredient` VALUES ('Avocado','2024-12-03',30.00,'pcs'),('Beef Broth','2024-12-31',20.00,'L'),('Chicken Broth','2024-12-31',20.00,'L'),('Cream Cheese','2024-12-10',15.00,'kg'),('Cucumber','2024-12-05',30.00,'pcs'),('Eel','2024-12-05',10.00,'kg'),('Eel Sauce','2024-12-20',2.00,'L'),('Miso Paste','2025-03-01',20.00,'kg'),('Mushrooms','2024-12-15',25.00,'kg'),('Nori','2024-12-15',50.00,'sheets'),('Red Snapper','2024-12-08',10.00,'kg'),('Rice','2024-12-31',100.00,'kg'),('Salmon','2024-11-30',25.00,'kg'),('Scallion','2024-12-07',15.00,'pcs'),('Shrimp','2024-11-30',15.00,'kg'),('Shrimp Tempura','2024-12-05',10.00,'pcs'),('Snow Crab','2024-12-03',12.00,'kg'),('Soy Sauce','2025-01-15',5.00,'L'),('Spicy Mayo','2024-12-12',2.00,'L'),('Tofu','2024-12-25',18.00,'kg'),('Tuna','2024-11-30',20.00,'kg');
/*!40000 ALTER TABLE `ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `position`
--

DROP TABLE IF EXISTS `position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `position` (
  `emp_id` char(4) NOT NULL,
  `position` enum('Server','Busser','Cook','Dish','Expo','Host','Manager') NOT NULL,
  PRIMARY KEY (`emp_id`,`position`),
  CONSTRAINT `position_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `position`
--

LOCK TABLES `position` WRITE;
/*!40000 ALTER TABLE `position` DISABLE KEYS */;
INSERT INTO `position` VALUES ('E001','Server'),('E001','Host'),('E002','Server'),('E002','Busser'),('E003','Host'),('E004','Server'),('E004','Busser'),('E004','Host'),('E005','Cook'),('E006','Cook'),('E006','Expo'),('E007','Cook'),('E007','Expo'),('E008','Cook'),('E009','Dish'),('E010','Busser'),('E010','Dish');
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
INSERT INTO `recipe` VALUES ('Bubba Gump Roll','Avocado'),('California Roll','Avocado'),('Godzilla Roll','Avocado'),('Little Tokyo Roll','Avocado'),('Philly Roll','Avocado'),('Phoenix Roll','Avocado'),('Clear Soup','Beef Broth'),('Clear Soup','Chicken Broth'),('Little Tokyo Roll','Cream Cheese'),('Philly Roll','Cream Cheese'),('California Roll','Cucumber'),('Dragon Roll','Cucumber'),('Godzilla Roll','Cucumber'),('Philly Roll','Cucumber'),('Phoenix Roll','Cucumber'),('Rainbow Roll','Cucumber'),('Spicy Tuna Roll','Cucumber'),('Tiger Roll','Cucumber'),('Dragon Roll','Eel'),('Dragon Roll','Eel Sauce'),('Godzilla Roll','Eel Sauce'),('Little Tokyo Roll','Eel Sauce'),('Rainbow Roll','Eel Sauce'),('Miso Soup','Miso Paste'),('Clear Soup','Mushrooms'),('Bubba Gump Roll','Nori'),('California Roll','Nori'),('Godzilla Roll','Nori'),('Phoenix Roll','Nori'),('Spicy Tuna Roll','Nori'),('Rainbow Roll','Red Snapper'),('Bubba Gump Roll','Rice'),('California Roll','Rice'),('Dragon Roll','Rice'),('Godzilla Roll','Rice'),('Little Tokyo Roll','Rice'),('Philly Roll','Rice'),('Phoenix Roll','Rice'),('Rainbow Roll','Rice'),('Spicy Tuna Roll','Rice'),('Tiger Roll','Rice'),('Philly Roll','Salmon'),('Phoenix Roll','Salmon'),('Rainbow Roll','Salmon'),('Clear Soup','Scallion'),('Miso Soup','Scallion'),('Bubba Gump Roll','Shrimp Tempura'),('Tiger Roll','Shrimp Tempura'),('Bubba Gump Roll','Snow Crab'),('California Roll','Snow Crab'),('Little Tokyo Roll','Snow Crab'),('Rainbow Roll','Snow Crab'),('Miso Soup','Soy Sauce'),('Godzilla Roll','Spicy Mayo'),('Little Tokyo Roll','Spicy Mayo'),('Phoenix Roll','Spicy Mayo'),('Spicy Tuna Roll','Spicy Mayo'),('Tiger Roll','Spicy Mayo'),('Miso Soup','Tofu'),('Godzilla Roll','Tuna'),('Rainbow Roll','Tuna'),('Spicy Tuna Roll','Tuna'),('Tiger Roll','Tuna');
/*!40000 ALTER TABLE `recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `res_table`
--

DROP TABLE IF EXISTS `res_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `res_table` (
  `table_num` tinyint unsigned NOT NULL,
  `status` enum('Occupied','Open','Need Cleaning') NOT NULL,
  `max_capa` tinyint unsigned NOT NULL,
  PRIMARY KEY (`table_num`),
  CONSTRAINT `res_table_chk_1` CHECK ((`max_capa` >= 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `res_table`
--

LOCK TABLES `res_table` WRITE;
/*!40000 ALTER TABLE `res_table` DISABLE KEYS */;
INSERT INTO `res_table` VALUES (1,'Open',2),(2,'Open',2),(3,'Occupied',4),(4,'Occupied',4),(5,'Open',4),(6,'Open',4),(7,'Open',4),(8,'Need Cleaning',4),(9,'Open',6),(10,'Open',6);
/*!40000 ALTER TABLE `res_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shift`
--

DROP TABLE IF EXISTS `shift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shift` (
  `shift_id` char(4) NOT NULL,
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
INSERT INTO `shift` VALUES ('S001','2024-11-25','12:00:00','16:30:00'),('S002','2024-11-25','16:30:00','21:00:00'),('S003','2024-11-26','12:00:00','16:30:00'),('S004','2024-11-26','16:30:00','21:00:00'),('S005','2024-11-27','12:00:00','16:30:00'),('S006','2024-11-27','16:30:00','21:00:00'),('S007','2024-11-28','12:00:00','16:30:00'),('S008','2024-11-28','16:30:00','21:00:00'),('S009','2024-11-29','12:00:00','16:30:00'),('S010','2024-11-29','16:30:00','21:00:00'),('S011','2024-11-30','12:00:00','16:30:00'),('S012','2024-11-30','16:30:00','21:00:00'),('S013','2024-12-31','12:00:00','16:30:00'),('S014','2024-12-31','16:30:00','21:00:00');
/*!40000 ALTER TABLE `shift` ENABLE KEYS */;
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
  `description` varchar(255) NOT NULL DEFAULT '',
  `quantity` smallint unsigned NOT NULL,
  PRIMARY KEY (`order_num`,`dish_name`,`description`),
  KEY `dish_name` (`dish_name`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`order_num`) REFERENCES `cus_order` (`order_num`) ON DELETE CASCADE,
  CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`dish_name`) REFERENCES `dish` (`dish_name`),
  CONSTRAINT `ticket_chk_1` CHECK ((`quantity` >= 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (1,'California Roll','',1),(1,'Clear Soup','',3),(1,'Philly Roll','No Cream Cheese',1),(1,'Spicy Tuna Roll','',1),(2,'Clear Soup','',1),(2,'Miso Soup','',1),(2,'Rainbow Roll','',1),(2,'Spicy Tuna Roll','No Spicy Mayo',2),(3,'California Roll','',2),(3,'Tiger Roll','',1),(4,'Bubba Gump Roll','',1),(4,'Little Tokyo Roll','',1),(4,'Rainbow Roll','',1),(5,'Clear Soup','',3),(5,'Dragon Roll','',1),(5,'Miso Soup','',1),(5,'Rainbow Roll','',1),(5,'Spicy Tuna Roll','',1),(6,'California Roll','No Avocado',1),(6,'Miso Soup','',2),(6,'Philly Roll','No Cream Cheese',1),(6,'Spicy Tuna Roll','',1),(7,'California Roll','',1),(7,'Little Tokyo Roll','No Cream Cheese',1),(7,'Rainbow Roll','',1),(8,'Bubba Gump Roll','',1),(8,'Clear Soup','',2),(8,'Godzilla Roll','',1);
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

-- Dump completed on 2024-12-04 19:35:55
