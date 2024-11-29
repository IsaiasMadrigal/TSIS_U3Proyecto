CREATE DATABASE  IF NOT EXISTS `plataformamedica` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `plataformamedica`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: plataformamedica
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

-- Creación de usuario para acceso a la base de datos
CREATE USER 'db_user'@'localhost' IDENTIFIED BY 'SecurePassword123!';
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON `plataformamedica`.* TO 'db_user'@'localhost';
FLUSH PRIVILEGES;

-- Procedimiento simplificado para registrar respaldos (sin comandos del sistema)
DELIMITER $$

CREATE PROCEDURE `log_backup`()
BEGIN
    INSERT INTO backup_logs (backup_name, backup_date)
    VALUES (CONCAT('plataformamedica_backup_', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'), '.sql'), NOW());
END$$

DELIMITER ;

-- Creación de tabla para registrar los respaldos
CREATE TABLE IF NOT EXISTS `backup_logs` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `backup_name` VARCHAR(255) NOT NULL,
    `backup_date` DATETIME NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Evento programado para ejecutar respaldos y registrar logs
CREATE EVENT IF NOT EXISTS `daily_backup_event`
ON SCHEDULE EVERY 1 DAY STARTS CURRENT_TIMESTAMP
DO
CALL log_backup();

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
-- Table structure for table `administradores`
--

DROP TABLE IF EXISTS `administradores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administradores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(50) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `correo_electronico` varchar(100) NOT NULL,
  `rol` enum('superadmin','editor') DEFAULT 'editor',
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  UNIQUE KEY `correo_electronico` (`correo_electronico`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administradores`
--

LOCK TABLES `administradores` WRITE;
/*!40000 ALTER TABLE `administradores` DISABLE KEYS */;
INSERT INTO `administradores` VALUES (1,'admin_master','$2y$10$EjemploDeContraseñaEncriptada1234abcd','admin@plataformamedica.com','superadmin','2024-11-26 16:32:40'),(2,'editor_jose','$2y$10$OtraContraseñaEncriptada5678efgh','editor@plataformamedica.com','editor','2024-11-26 16:32:40');
/*!40000 ALTER TABLE `administradores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compatibilidadmedicamentos`
--

DROP TABLE IF EXISTS `compatibilidadmedicamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compatibilidadmedicamentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medicamento_principal_id` int(11) NOT NULL,
  `medicamento_compatible_id` int(11) NOT NULL,
  `tipo_compatibilidad` varchar(100) NOT NULL,
  `comentarios` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_compatibilidad` (`medicamento_principal_id`,`medicamento_compatible_id`),
  KEY `medicamento_compatible_id` (`medicamento_compatible_id`),
  CONSTRAINT `compatibilidadmedicamentos_ibfk_1` FOREIGN KEY (`medicamento_principal_id`) REFERENCES `medicamentos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `compatibilidadmedicamentos_ibfk_2` FOREIGN KEY (`medicamento_compatible_id`) REFERENCES `medicamentos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compatibilidadmedicamentos`
--

LOCK TABLES `compatibilidadmedicamentos` WRITE;
/*!40000 ALTER TABLE `compatibilidadmedicamentos` DISABLE KEYS */;
INSERT INTO `compatibilidadmedicamentos` VALUES (40,1,2,'Complementario','Trastuzumab se usa con Tamoxifeno en ciertos subtipos de cáncer de mama.'),(41,1,3,'Alternativo','Anastrozol puede ser una alternativa al Trastuzumab en algunos casos.'),(42,2,3,'Complementario','Tamoxifeno y Anastrozol pueden administrarse en fases diferentes del tratamiento.'),(43,4,5,'Complementario','Erlotinib y Crizotinib pueden usarse secuencialmente para mejorar la respuesta.'),(44,4,6,'Alternativo','Pembrolizumab es una opción en casos con resistencia a Erlotinib.');
/*!40000 ALTER TABLE `compatibilidadmedicamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicamentos`
--

DROP TABLE IF EXISTS `medicamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicamentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `tipo_medicamento` varchar(100) NOT NULL,
  `ingrediente_activo` varchar(150) NOT NULL,
  `tipo_cancer_id` int(11) NOT NULL,
  `laboratorio` varchar(100) NOT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tipo_cancer_id` (`tipo_cancer_id`),
  CONSTRAINT `medicamentos_ibfk_1` FOREIGN KEY (`tipo_cancer_id`) REFERENCES `tiposcancer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicamentos`
--

LOCK TABLES `medicamentos` WRITE;
/*!40000 ALTER TABLE `medicamentos` DISABLE KEYS */;
INSERT INTO `medicamentos` VALUES (1,'Trastuzumab','Anticuerpo monoclonal','Trastuzumab',1,'Roche',NULL,NULL),(2,'Tamoxifeno','Modulador selectivo de los receptores de estrógeno','Tamoxifeno',1,'AstraZeneca',NULL,NULL),(3,'Anastrozol','Inhibidor de la aromatasa','Anastrozol',1,'Teva Pharmaceuticals',NULL,NULL),(4,'Erlotinib','Inhibidor de tirosina quinasa','Erlotinib',2,'Roche',NULL,NULL),(5,'Crizotinib','Inhibidor de ALK','Crizotinib',2,'Pfizer',NULL,NULL),(6,'Pembrolizumab','Inmunoterapia','Pembrolizumab',2,'Merck & Co.',NULL,NULL),(7,'Bevacizumab','Anticuerpo monoclonal','Bevacizumab',3,'Roche',NULL,NULL),(8,'Cetuximab','Anticuerpo monoclonal','Cetuximab',3,'Eli Lilly',NULL,NULL),(9,'Oxaliplatino','Quimioterapia','Oxaliplatino',3,'Sanofi',NULL,NULL),(10,'Abiraterona','Inhibidor de la biosíntesis de andrógenos','Abiraterona',4,'Janssen',NULL,NULL),(11,'Enzalutamida','Antagonista de los receptores de andrógenos','Enzalutamida',4,'Pfizer',NULL,NULL),(12,'Docetaxel','Quimioterapia','Docetaxel',4,'Sanofi',NULL,NULL),(13,'Vemurafenib','Inhibidor de BRAF','Vemurafenib',5,'Roche',NULL,NULL),(14,'Ipilimumab','Anticuerpo monoclonal','Ipilimumab',5,'Bristol-Myers Squibb',NULL,NULL),(15,'Dabrafenib','Inhibidor de BRAF','Dabrafenib',5,'Novartis',NULL,NULL),(16,'Ramucirumab','Anticuerpo monoclonal','Ramucirumab',6,'Eli Lilly',NULL,NULL),(17,'Capecitabina','Quimioterapia','Capecitabina',6,'Roche',NULL,NULL),(18,'Sunitinib','Inhibidor de tirosina quinasa','Sunitinib',6,'Pfizer',NULL,NULL),(19,'Imatinib','Inhibidor de tirosina quinasa','Imatinib',7,'Novartis',NULL,NULL),(20,'Dasatinib','Inhibidor de tirosina quinasa','Dasatinib',7,'Bristol-Myers Squibb',NULL,NULL),(21,'Nilotinib','Inhibidor de tirosina quinasa','Nilotinib',7,'Novartis',NULL,NULL),(22,'Sorafenib','Inhibidor de tirosina quinasa','Sorafenib',8,'Bayer',NULL,NULL),(23,'Regorafenib','Inhibidor de tirosina quinasa','Regorafenib',8,'Bayer',NULL,NULL),(24,'Lenvatinib','Inhibidor de tirosina quinasa','Lenvatinib',8,'Eisai',NULL,NULL),(25,'Gemcitabina','Quimioterapia','Gemcitabina',9,'Eli Lilly',NULL,NULL),(26,'Erlotinib','Inhibidor de tirosina quinasa','Erlotinib',9,'Roche',NULL,NULL),(27,'Nab-paclitaxel','Quimioterapia','Paclitaxel unido a albúmina',9,'Celgene',NULL,NULL),(28,'Carboplatino','Quimioterapia','Carboplatino',10,'Bristol-Myers Squibb',NULL,NULL),(29,'Olaparib','Inhibidor de PARP','Olaparib',10,'AstraZeneca',NULL,NULL),(30,'Bevacizumab','Anticuerpo monoclonal','Bevacizumab',10,'Roche',NULL,NULL);
/*!40000 ALTER TABLE `medicamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tiposcancer`
--

DROP TABLE IF EXISTS `tiposcancer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tiposcancer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `sintomas_principales` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiposcancer`
--

LOCK TABLES `tiposcancer` WRITE;
/*!40000 ALTER TABLE `tiposcancer` DISABLE KEYS */;
INSERT INTO `tiposcancer` VALUES (1,'Cáncer de mama','Un tipo de cáncer que se forma en las células de los senos.','Bulto en el seno, cambio en el tamaño o forma, secreción del pezón.'),(2,'Cáncer de pulmón','Cáncer que comienza en los pulmones, frecuentemente asociado al tabaquismo.','Tos persistente, dificultad para respirar, dolor en el pecho.'),(3,'Cáncer de colon','Cáncer que afecta el colon o el recto, parte del sistema digestivo.','Cambios en los hábitos intestinales, sangre en las heces, fatiga.'),(4,'Cáncer de próstata','Cáncer que afecta la glándula prostática en hombres.','Problemas para orinar, sangre en la orina, dolor en la pelvis.'),(5,'Cáncer de piel (melanoma)','Un tipo de cáncer de piel que se desarrolla a partir de los melanocitos.','Cambio en un lunar existente, aparición de un nuevo crecimiento inusual.'),(6,'Cáncer de estómago','Cáncer que se forma en el revestimiento del estómago.','Indigestión persistente, pérdida de apetito, dolor abdominal.'),(7,'Leucemia','Cáncer de la sangre que afecta la médula ósea y los glóbulos blancos.','Fatiga extrema, infecciones frecuentes, hematomas o sangrado fácil.'),(8,'Cáncer de hígado','Cáncer que comienza en el hígado, órgano responsable de muchas funciones vitales.','Dolor en el abdomen superior derecho, pérdida de peso, ictericia.'),(9,'Cáncer de páncreas','Cáncer que afecta el páncreas, que produce enzimas digestivas y hormonas.','Dolor abdominal, pérdida de peso, ictericia.'),(10,'Cáncer de ovario','Cáncer que comienza en los ovarios, parte del sistema reproductivo femenino.','Hinchazón abdominal, dolor pélvico, dificultad para comer o sensación de llenura rápida.');
/*!40000 ALTER TABLE `tiposcancer` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-27  0:40:20