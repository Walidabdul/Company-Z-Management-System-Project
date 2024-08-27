-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: employeedata
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `empid` int NOT NULL,
  `addressLine1` varchar(50) NOT NULL,
  `addressLine2` varchar(50) DEFAULT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `e` date DEFAULT NULL,
  `mp` int DEFAULT NULL,
  `epp` int DEFAULT NULL,
  `ep` int DEFAULT NULL,
  PRIMARY KEY (`empid`),
  KEY `city_IDX` (`city`),
  KEY `state_IDX` (`state`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`empid`) REFERENCES `employees` (`empid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (33,'909 Drive','Backroads','Atlanta','',NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `demographics`
--

DROP TABLE IF EXISTS `demographics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `demographics` (
  `gender` enum('M','F','X') NOT NULL DEFAULT 'X',
  `pronouns` varchar(6) NOT NULL,
  `race` varchar(100) NOT NULL,
  `dateOfBirth` int NOT NULL,
  `phoneNum` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `demographics`
--

LOCK TABLES `demographics` WRITE;
/*!40000 ALTER TABLE `demographics` DISABLE KEYS */;
/*!40000 ALTER TABLE `demographics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `division`
--

DROP TABLE IF EXISTS `division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `division` (
  `ID` int NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `city` varchar(50) NOT NULL,
  `addressLine1` varchar(50) NOT NULL,
  `addressLine2` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `country` varchar(50) NOT NULL,
  `postalCode` varchar(15) NOT NULL,
  KEY `ID_IDX` (`ID`),
  CONSTRAINT `division_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `employee_division` (`div_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='company divisions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `division`
--

LOCK TABLES `division` WRITE;
/*!40000 ALTER TABLE `division` DISABLE KEYS */;
/*!40000 ALTER TABLE `division` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_division`
--

DROP TABLE IF EXISTS `employee_division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_division` (
  `empid` int NOT NULL,
  `div_ID` int NOT NULL,
  PRIMARY KEY (`empid`),
  KEY `div_ID_IDX` (`div_ID`),
  CONSTRAINT `employee_division_ibfk_1` FOREIGN KEY (`empid`) REFERENCES `employees` (`empid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='links employee to a division';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_division`
--

LOCK TABLES `employee_division` WRITE;
/*!40000 ALTER TABLE `employee_division` DISABLE KEYS */;
INSERT INTO `employee_division` VALUES (7,1),(10,1),(1,999),(2,999),(3,999);
/*!40000 ALTER TABLE `employee_division` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_job_titles`
--

DROP TABLE IF EXISTS `employee_job_titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_job_titles` (
  `empid` int NOT NULL,
  `job_title_id` int NOT NULL,
  PRIMARY KEY (`empid`),
  KEY `job_title_IDX` (`job_title_id`),
  CONSTRAINT `employee_job_titles_ibfk_1` FOREIGN KEY (`empid`) REFERENCES `employees` (`empid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_job_titles`
--

LOCK TABLES `employee_job_titles` WRITE;
/*!40000 ALTER TABLE `employee_job_titles` DISABLE KEYS */;
INSERT INTO `employee_job_titles` VALUES (7,100),(5,101),(4,102),(8,102),(9,102),(10,102),(14,103),(15,103),(11,200),(6,201),(12,201),(13,202),(2,900),(3,901),(1,902);
/*!40000 ALTER TABLE `employee_job_titles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `empid` int NOT NULL AUTO_INCREMENT,
  `Fname` varchar(65) NOT NULL,
  `Lname` varchar(65) NOT NULL,
  `email` varchar(65) NOT NULL,
  `HireDate` date DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `newSalary` int DEFAULT NULL,
  `newSSS` int DEFAULT NULL,
  `SSN` int DEFAULT NULL,
  PRIMARY KEY (`empid`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Snoopy','Snicjer','Snoopy@example.com','2022-08-01',67890.00,53490,NULL,NULL),(2,'Charlie','Brown','Charlie@example.com','2022-07-01',67890.00,34200,NULL,NULL),(3,'Lucy','Doctor','Lucy@example.com','2022-07-03',67890.00,NULL,NULL,NULL),(4,'Pepermint','Patti','Peppermint@example.com','2022-08-02',67890.00,53490,3000,NULL),(5,'Linus','Blanket','Linus@example.com','2022-09-01',67890.00,53490,NULL,NULL),(6,'PigPin','Dusty','PigPin@example.com','2022-10-01',67890.00,53490,NULL,NULL),(7,'Scooby','Doo','Scooby@example.com','1973-07-03',67890.00,53490,NULL,NULL),(8,'Shaggy','Rodgers','Shaggy@example.com','1973-07-11',67890.00,53490,NULL,NULL),(9,'Velma','Dinkley','Velma@example.com','1973-07-21',67890.00,53490,NULL,NULL),(10,'Daphne','Blake','Daphne@example.com','1973-07-30',67890.00,53490,NULL,NULL),(11,'Bugs','Bunny','Bugs@example.com','1934-07-01',67890.00,53490,NULL,NULL),(12,'Daffy','Duck','Daffy@example.com','1935-04-01',67890.00,53490,NULL,NULL),(13,'Porky','Pig','Porky@example.com','1935-08-12',67890.00,53490,NULL,NULL),(14,'Elmer','Fudd','Elmer@example.com','1934-08-01',67890.00,53490,NULL,NULL),(15,'Marvin','Martian','Marvin@example.com','1937-05-01',67890.00,53490,NULL,NULL),(16,'Snoopy','Beagle','Snoopy@example.com','2022-08-01',67890.00,53490,NULL,NULL),(17,'Charlie','Brown','Charlie@example.com','2022-07-01',67890.00,53490,NULL,NULL),(18,'Lucy','Doctor','Lucy@example.com','2022-07-03',67890.00,53490,NULL,NULL),(19,'Pepermint','Patti','Peppermint@example.com','2022-08-02',67890.00,53490,NULL,NULL),(20,'Linus','Blanket','Linus@example.com','2022-09-01',67890.00,53490,NULL,NULL),(21,'PigPin','Dusty','PigPin@example.com','2022-10-01',67890.00,53490,NULL,NULL),(22,'Scooby','Doo','Scooby@example.com','1973-07-03',67890.00,58723,NULL,NULL),(23,'Shaggy','Rodgers','Shaggy@example.com','1973-07-11',67890.00,53490,NULL,NULL),(24,'Velma','Dinkley','Velma@example.com','1973-07-21',67890.00,53490,NULL,NULL),(25,'Daphne','Blake','Daphne@example.com','1973-07-30',67890.00,53490,NULL,NULL),(26,'Bugs','Bunny','Bugs@example.com','1934-07-01',67890.00,53490,NULL,NULL),(27,'Daffy','Duck','Daffy@example.com','1935-04-01',67890.00,53490,NULL,NULL),(28,'Porky','Pig','Porky@example.com','1935-08-12',67890.00,53490,NULL,NULL),(29,'Elmer','Fudd','Elmer@example.com','1934-08-01',67890.00,53490,NULL,NULL),(30,'Marvin','Martian','Marvin@example.com','1937-05-01',67890.00,53490,NULL,NULL),(33,'John','Doe','johndoe@example.com','2024-04-30',NULL,NULL,NULL,NULL),(34,'Chris','Brown','chrisbrown@email.com',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_titles`
--

DROP TABLE IF EXISTS `job_titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_titles` (
  `job_title_id` int NOT NULL,
  `job_title` varchar(125) NOT NULL,
  PRIMARY KEY (`job_title_id`),
  CONSTRAINT `job_titles_ibfk_1` FOREIGN KEY (`job_title_id`) REFERENCES `employee_job_titles` (`job_title_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_titles`
--

LOCK TABLES `job_titles` WRITE;
/*!40000 ALTER TABLE `job_titles` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_titles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payroll`
--

DROP TABLE IF EXISTS `payroll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payroll` (
  `payID` int DEFAULT NULL,
  `pay_date` date DEFAULT NULL,
  `earnings` decimal(8,2) DEFAULT NULL,
  `fed_tax` decimal(7,2) DEFAULT NULL,
  `fed_med` decimal(7,2) DEFAULT NULL,
  `fed_SS` decimal(7,2) DEFAULT NULL,
  `state_tax` decimal(7,2) DEFAULT NULL,
  `retire_401k` decimal(7,2) DEFAULT NULL,
  `health_care` decimal(7,2) DEFAULT NULL,
  `empid` int DEFAULT NULL,
  KEY `payID_IDX` (`payID`),
  KEY `emp_indx` (`empid`),
  CONSTRAINT `payroll_ibfk_1` FOREIGN KEY (`empid`) REFERENCES `employees` (`empid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payroll`
--

LOCK TABLES `payroll` WRITE;
/*!40000 ALTER TABLE `payroll` DISABLE KEYS */;
INSERT INTO `payroll` VALUES (1,'2023-11-30',865.38,276.92,12.55,53.65,103.85,3.46,26.83,1),(1,'2023-11-30',923.08,295.38,13.38,57.23,110.77,3.69,28.62,2),(1,'2023-11-30',1057.69,338.46,15.34,65.58,126.92,4.23,32.79,3),(1,'2023-11-30',1884.62,603.08,27.33,116.85,226.15,7.54,58.42,4),(1,'2023-11-30',826.92,264.62,11.99,51.27,99.23,3.31,25.63,5),(1,'2023-11-30',634.62,203.08,9.20,39.35,76.15,2.54,19.67,6),(1,'2023-11-30',1500.00,480.00,21.75,93.00,180.00,6.00,46.50,7),(1,'2023-11-30',1480.77,473.85,21.47,91.81,177.69,5.92,45.90,8),(1,'2023-11-30',1576.92,504.62,22.87,97.77,189.23,6.31,48.88,9),(1,'2023-11-30',1134.62,363.08,16.45,70.35,136.15,4.54,35.17,10),(1,'2023-11-30',346.15,110.77,5.02,21.46,41.54,1.38,10.73,11),(1,'2023-11-30',307.69,98.46,4.46,19.08,36.92,1.23,9.54,12),(1,'2023-11-30',318.27,101.85,4.61,19.73,38.19,1.27,9.87,13),(1,'2023-11-30',298.08,95.38,4.32,18.48,35.77,1.19,9.24,14),(1,'2023-11-30',538.46,172.31,7.81,33.38,64.62,2.15,16.69,15),(1,'2023-11-30',865.38,276.92,12.55,53.65,103.85,3.46,26.83,16),(1,'2023-11-30',923.08,295.38,13.38,57.23,110.77,3.69,28.62,17),(1,'2023-11-30',1057.69,338.46,15.34,65.58,126.92,4.23,32.79,18),(1,'2023-11-30',1884.62,603.08,27.33,116.85,226.15,7.54,58.42,19),(1,'2023-11-30',826.92,264.62,11.99,51.27,99.23,3.31,25.63,20),(1,'2023-11-30',634.62,203.08,9.20,39.35,76.15,2.54,19.67,21),(1,'2023-11-30',1500.00,480.00,21.75,93.00,180.00,6.00,46.50,22),(1,'2023-11-30',1480.77,473.85,21.47,91.81,177.69,5.92,45.90,23),(1,'2023-11-30',1576.92,504.62,22.87,97.77,189.23,6.31,48.88,24),(1,'2023-11-30',1134.62,363.08,16.45,70.35,136.15,4.54,35.17,25),(1,'2023-11-30',346.15,110.77,5.02,21.46,41.54,1.38,10.73,26),(1,'2023-11-30',307.69,98.46,4.46,19.08,36.92,1.23,9.54,27),(1,'2023-11-30',318.27,101.85,4.61,19.73,38.19,1.27,9.87,28),(1,'2023-11-30',298.08,95.38,4.32,18.48,35.77,1.19,9.24,29),(1,'2023-11-30',538.46,172.31,7.81,33.38,64.62,2.15,16.69,30),(2,'2023-12-31',865.38,276.92,12.55,53.65,103.85,3.46,26.83,1),(2,'2023-12-31',923.08,295.38,13.38,57.23,110.77,3.69,28.62,2),(2,'2023-12-31',1057.69,338.46,15.34,65.58,126.92,4.23,32.79,3),(2,'2023-12-31',1884.62,603.08,27.33,116.85,226.15,7.54,58.42,4),(2,'2023-12-31',826.92,264.62,11.99,51.27,99.23,3.31,25.63,5),(2,'2023-12-31',634.62,203.08,9.20,39.35,76.15,2.54,19.67,6),(2,'2023-12-31',1500.00,480.00,21.75,93.00,180.00,6.00,46.50,7),(2,'2023-12-31',1480.77,473.85,21.47,91.81,177.69,5.92,45.90,8),(2,'2023-12-31',1576.92,504.62,22.87,97.77,189.23,6.31,48.88,9),(2,'2023-12-31',1134.62,363.08,16.45,70.35,136.15,4.54,35.17,10),(2,'2023-12-31',346.15,110.77,5.02,21.46,41.54,1.38,10.73,11),(2,'2023-12-31',307.69,98.46,4.46,19.08,36.92,1.23,9.54,12),(2,'2023-12-31',318.27,101.85,4.61,19.73,38.19,1.27,9.87,13),(2,'2023-12-31',298.08,95.38,4.32,18.48,35.77,1.19,9.24,14),(2,'2023-12-31',538.46,172.31,7.81,33.38,64.62,2.15,16.69,15),(2,'2023-12-31',865.38,276.92,12.55,53.65,103.85,3.46,26.83,16),(2,'2023-12-31',923.08,295.38,13.38,57.23,110.77,3.69,28.62,17),(2,'2023-12-31',1057.69,338.46,15.34,65.58,126.92,4.23,32.79,18),(2,'2023-12-31',1884.62,603.08,27.33,116.85,226.15,7.54,58.42,19),(2,'2023-12-31',826.92,264.62,11.99,51.27,99.23,3.31,25.63,20),(2,'2023-12-31',634.62,203.08,9.20,39.35,76.15,2.54,19.67,21),(2,'2023-12-31',1500.00,480.00,21.75,93.00,180.00,6.00,46.50,22),(2,'2023-12-31',1480.77,473.85,21.47,91.81,177.69,5.92,45.90,23),(2,'2023-12-31',1576.92,504.62,22.87,97.77,189.23,6.31,48.88,24),(2,'2023-12-31',1134.62,363.08,16.45,70.35,136.15,4.54,35.17,25),(2,'2023-12-31',346.15,110.77,5.02,21.46,41.54,1.38,10.73,26),(2,'2023-12-31',307.69,98.46,4.46,19.08,36.92,1.23,9.54,27),(2,'2023-12-31',318.27,101.85,4.61,19.73,38.19,1.27,9.87,28),(2,'2023-12-31',298.08,95.38,4.32,18.48,35.77,1.19,9.24,29),(2,'2023-12-31',538.46,172.31,7.81,33.38,64.62,2.15,16.69,30);
/*!40000 ALTER TABLE `payroll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'employeedata'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-27 15:24:12
