-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: plataformamedica
-- ------------------------------------------------------
-- Server version	8.0.40

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
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(100) NOT NULL,
  `contrasena` text,
  `correo_electronico` varchar(255) NOT NULL,
  `rol` enum('superadmin','editor') NOT NULL,
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administradores`
--

LOCK TABLES `administradores` WRITE;
/*!40000 ALTER TABLE `administradores` DISABLE KEYS */;
INSERT INTO `administradores` VALUES (1,'SuperAdminUser','123','superadmin@example.com','superadmin','2024-11-27 19:16:42'),(2,'EditorUser','123','editor@example.com','editor','2024-11-27 19:16:52');
/*!40000 ALTER TABLE `administradores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compatibilidadmedicamentos`
--

DROP TABLE IF EXISTS `compatibilidadmedicamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compatibilidadmedicamentos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `medicamento_principal` varchar(100) NOT NULL,
  `medicamento_compatible` varchar(100) NOT NULL,
  `tipo_compatibilidad` varchar(100) DEFAULT NULL,
  `comentarios` text,
  PRIMARY KEY (`id`),
  KEY `medicamento_principal` (`medicamento_principal`),
  KEY `medicamento_compatible` (`medicamento_compatible`),
  CONSTRAINT `compatibilidadmedicamentos_ibfk_1` FOREIGN KEY (`medicamento_principal`) REFERENCES `medicamentos` (`nombre`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `compatibilidadmedicamentos_ibfk_2` FOREIGN KEY (`medicamento_compatible`) REFERENCES `medicamentos` (`nombre`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compatibilidadmedicamentos`
--

LOCK TABLES `compatibilidadmedicamentos` WRITE;
/*!40000 ALTER TABLE `compatibilidadmedicamentos` DISABLE KEYS */;
INSERT INTO `compatibilidadmedicamentos` VALUES (1,'Tamoxifeno','Letrozol','Complementario','Ambos medicamentos son útiles en el tratamiento hormonal del cáncer de mama.'),(2,'Cisplatino','Erlotinib','Secuencial','Erlotinib puede ser administrado después de Cisplatino en ciertos tratamientos.'),(3,'Fluorouracilo','Oxaliplatino','Sinérgico','Combinación común para el tratamiento de cáncer colorrectal.'),(4,'Paclitaxel','Bevacizumab','Sinérgico','Paclitaxel mejora los efectos de Bevacizumab en terapias avanzadas.'),(5,'Gemcitabina','Doxorrubicina','Secuencial','La administración secuencial puede ser efectiva en terapias paliativas.');
/*!40000 ALTER TABLE `compatibilidadmedicamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicamentos`
--

DROP TABLE IF EXISTS `medicamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicamentos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `tipo_medicamento` varchar(100) DEFAULT NULL,
  `ingrediente_activo` varchar(150) DEFAULT NULL,
  `tipo_cancer_nombre` varchar(100) DEFAULT NULL,
  `laboratorio` varchar(100) DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `tipo_cancer_nombre` (`tipo_cancer_nombre`),
  CONSTRAINT `medicamentos_ibfk_1` FOREIGN KEY (`tipo_cancer_nombre`) REFERENCES `tiposcancer` (`nombre`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicamentos`
--

LOCK TABLES `medicamentos` WRITE;
/*!40000 ALTER TABLE `medicamentos` DISABLE KEYS */;
INSERT INTO `medicamentos` VALUES (1,'Tamoxifeno','Antiestrógeno','Tamoxifeno','Cáncer de Mama','PharmaCorp','imagenes/tamoxifeno.jpg',50.00),(2,'Cisplatino','Quimioterapia','Cisplatino','Cáncer de Pulmón','MedLife','imagenes/cisplatino.jpg',120.00),(3,'Erlotinib','Inhibidor de Tirosina Quinasa','Erlotinib','Cáncer de Pulmón','GenPharma','imagenes/erlotinib.jpg',180.00),(4,'Trastuzumab','Anticuerpo Monoclonal','Trastuzumab','Cáncer de Mama','OncoBiotech','imagenes/trastuzumab.jpg',250.00),(5,'Fluorouracilo','Antimetabolito','5-FU','Cáncer de Colon','ChemoCare','imagenes/fluorouracilo.jpg',80.00),(6,'Doxorrubicina','Antraciclina','Doxorrubicina','Cáncer de Hígado','OncoGen','imagenes/doxorrubicina.jpg',200.00),(7,'Paclitaxel','Taxano','Paclitaxel','Cáncer de Ovario','PharmaCorp','imagenes/paclitaxel.jpg',220.00),(8,'Bevacizumab','Anticuerpo Monoclonal','Bevacizumab','Cáncer de Colon','BioTechLab','imagenes/bevacizumab.jpg',300.00),(9,'Gemcitabina','Antimetabolito','Gemcitabina','Cáncer de Páncreas','MedLife','imagenes/gemcitabina.jpg',150.00),(10,'Imatinib','Inhibidor de Tirosina Quinasa','Imatinib','Cáncer de Sangre (Leucemia)','GenPharma','imagenes/imatinib.jpg',500.00),(11,'Letrozol','Inhibidor de Aromatasa','Letrozol','Cáncer de Mama','OncoBiotech','imagenes/letrozol.jpg',60.00),(12,'Sorafenib','Multiquinasa','Sorafenib','Cáncer de Hígado','ChemoCare','imagenes/sorafenib.jpg',220.00),(13,'Irinotecán','Inhibidor de Topoisomerasa','Irinotecán','Cáncer de Colon','PharmaCorp','imagenes/irinotecan.jpg',130.00),(14,'Pembrolizumab','Inmunoterapia','Pembrolizumab','Cáncer de Piel','OncoGen','imagenes/pembrolizumab.jpg',400.00),(15,'Capecitabina','Antimetabolito','Capecitabina','Cáncer de Colon','BioTechLab','imagenes/capecitabina.jpg',100.00),(16,'Oxaliplatino','Quimioterapia','Oxaliplatino','Cáncer de Colon','GenPharma','imagenes/oxaliplatino.jpg',140.00),(17,'Abiraterona','Antiandrógeno','Abiraterona','Cáncer de Próstata','OncoBiotech','imagenes/abiraterona.jpg',280.00),(18,'Vemurafenib','Inhibidor de BRAF','Vemurafenib','Cáncer de Piel','MedLife','imagenes/vemurafenib.jpg',350.00),(19,'Rituximab','Anticuerpo Monoclonal','Rituximab','Cáncer de Sangre (Leucemia)','ChemoCare','imagenes/rituximab.jpg',450.00),(20,'Enzalutamida','Antiandrógeno','Enzalutamida','Cáncer de Próstata','PharmaCorp','imagenes/enzalutamida.jpg',300.00);
/*!40000 ALTER TABLE `medicamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tiposcancer`
--

DROP TABLE IF EXISTS `tiposcancer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tiposcancer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `sintomas` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiposcancer`
--

LOCK TABLES `tiposcancer` WRITE;
/*!40000 ALTER TABLE `tiposcancer` DISABLE KEYS */;
INSERT INTO `tiposcancer` VALUES (1,'Cáncer de Mama','Cáncer que se forma en las células de los senos.','Bultos en el seno, cambios en el tamaño o forma, secreción inusual.'),(2,'Cáncer de Pulmón','Cáncer que afecta los pulmones, asociado con el tabaquismo.','Tos persistente, dificultad para respirar, dolor en el pecho.'),(3,'Cáncer de Piel','Cáncer que comienza en las células de la piel.','Lunares irregulares, cambios en la piel, llagas que no sanan.'),(4,'Cáncer de Próstata','Cáncer que afecta la glándula prostática en hombres.','Dificultad para orinar, sangre en la orina, dolor óseo.'),(5,'Cáncer de Colon','Cáncer que afecta el colon o el recto.','Cambio en los hábitos intestinales, sangrado rectal, pérdida de peso inexplicada.'),(6,'Cáncer de Hígado','Cáncer que se origina en el hígado.','Dolor abdominal, ictericia, fatiga.'),(7,'Cáncer de Estómago','Cáncer que afecta el estómago.','Indigestión persistente, pérdida de apetito, vómitos.'),(8,'Cáncer de Ovario','Cáncer que afecta los ovarios.','Dolor abdominal, hinchazón, fatiga.'),(9,'Cáncer de Páncreas','Cáncer que comienza en el páncreas.','Dolor abdominal, pérdida de peso, piel amarilla.'),(10,'Cáncer de Sangre (Leucemia)','Cáncer que afecta la sangre y la médula ósea.','Fatiga, infecciones frecuentes, sangrado o hematomas.');
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

-- Dump completed on 2024-11-27 19:22:12
