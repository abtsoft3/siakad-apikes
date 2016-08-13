CREATE DATABASE  IF NOT EXISTS `apikes` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `apikes`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: apikes
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.13-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admins_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `angkatan`
--

DROP TABLE IF EXISTS `angkatan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `angkatan` (
  `idangkatan` int(3) NOT NULL AUTO_INCREMENT,
  `angkatan` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `tahun` int(4) NOT NULL,
  PRIMARY KEY (`idangkatan`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `angkatan`
--

LOCK TABLES `angkatan` WRITE;
/*!40000 ALTER TABLE `angkatan` DISABLE KEYS */;
INSERT INTO `angkatan` VALUES (1,'4',2011),(2,'5',2012),(3,'6',2013),(4,'7',2014),(5,'8',2015),(6,'1',2009);
/*!40000 ALTER TABLE `angkatan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bidang`
--

DROP TABLE IF EXISTS `bidang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bidang` (
  `idbidang` int(2) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`idbidang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bidang`
--

LOCK TABLES `bidang` WRITE;
/*!40000 ALTER TABLE `bidang` DISABLE KEYS */;
/*!40000 ALTER TABLE `bidang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bidangkeahlian`
--

DROP TABLE IF EXISTS `bidangkeahlian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bidangkeahlian` (
  `idbidangkeahlian` int(2) NOT NULL,
  `nama` varchar(50) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`idbidangkeahlian`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bidangkeahlian`
--

LOCK TABLES `bidangkeahlian` WRITE;
/*!40000 ALTER TABLE `bidangkeahlian` DISABLE KEYS */;
/*!40000 ALTER TABLE `bidangkeahlian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detailmahasiswa`
--

DROP TABLE IF EXISTS `detailmahasiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detailmahasiswa` (
  `nim` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `idangkatan` int(3) NOT NULL,
  `statuskrs` int(1) DEFAULT NULL COMMENT '1 = boleh\nnull = tidak boleh',
  PRIMARY KEY (`nim`),
  KEY `fk_detailmhs_idangkatan_idx` (`idangkatan`),
  CONSTRAINT `fk_detailmhs_idangkatan` FOREIGN KEY (`idangkatan`) REFERENCES `angkatan` (`idangkatan`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_detailmhs_nim` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detailmahasiswa`
--

LOCK TABLES `detailmahasiswa` WRITE;
/*!40000 ALTER TABLE `detailmahasiswa` DISABLE KEYS */;
INSERT INTO `detailmahasiswa` VALUES ('1100000001',1,NULL),('1113464002',1,NULL),('1113464003',1,NULL),('1113464004',1,NULL),('1113464005',1,NULL),('1113464009',1,NULL),('1113464050',1,NULL),('1113464059',1,NULL);
/*!40000 ALTER TABLE `detailmahasiswa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detailmatakuliah`
--

DROP TABLE IF EXISTS `detailmatakuliah`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detailmatakuliah` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kodemk` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `iddosen` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detailmatakuliah`
--

LOCK TABLES `detailmatakuliah` WRITE;
/*!40000 ALTER TABLE `detailmatakuliah` DISABLE KEYS */;
INSERT INTO `detailmatakuliah` VALUES (1,'PK109',4),(3,'PK109',5),(6,'PK109',6),(7,'PK102',4),(9,'PK105',4),(10,'PK105',5),(11,'PK102',6);
/*!40000 ALTER TABLE `detailmatakuliah` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dosen`
--

DROP TABLE IF EXISTS `dosen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dosen` (
  `iddosen` int(10) NOT NULL AUTO_INCREMENT,
  `nidn` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `nama` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `tgllahir` date NOT NULL,
  `jabatanakademik` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `sertifikat` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `pendidikan` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `asalpt` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `bidang` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`iddosen`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dosen`
--

LOCK TABLES `dosen` WRITE;
/*!40000 ALTER TABLE `dosen` DISABLE KEYS */;
INSERT INTO `dosen` VALUES (4,'0106127903','Parmen, SKM, M.Kes','2016-08-10','Assisten Ahli','-','S1','Universitas Sumatera Utara','Manajemen kesehatan bencana','2016-08-10 03:37:34','2016-08-10 06:06:35'),(5,'0104088601','Ali sabela Hasibuan, S.Kep, Ns','2016-08-11','Lektor','','S1','Sari Mutiara','Manajemen Keperawatan','2016-08-11 08:44:29','2016-08-11 08:44:29');
/*!40000 ALTER TABLE `dosen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jabatan`
--

DROP TABLE IF EXISTS `jabatan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jabatan` (
  `idjabatan` int(2) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`idjabatan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jabatan`
--

LOCK TABLES `jabatan` WRITE;
/*!40000 ALTER TABLE `jabatan` DISABLE KEYS */;
/*!40000 ALTER TABLE `jabatan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kelas`
--

DROP TABLE IF EXISTS `kelas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kelas` (
  `idkelas` int(2) NOT NULL AUTO_INCREMENT,
  `kodekelas` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `namakelas` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idkelas`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kelas`
--

LOCK TABLES `kelas` WRITE;
/*!40000 ALTER TABLE `kelas` DISABLE KEYS */;
INSERT INTO `kelas` VALUES (1,'KL01','Kelas A'),(3,'KL02','Kelas B');
/*!40000 ALTER TABLE `kelas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kelas_mahasiswa`
--

DROP TABLE IF EXISTS `kelas_mahasiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kelas_mahasiswa` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `idkelas` int(2) NOT NULL,
  `nim` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `tahun_ajaran` year(4) DEFAULT NULL,
  `semester` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_kelasmhs_idkelas_idx` (`idkelas`),
  CONSTRAINT `fk_kelasmhs_idkelas` FOREIGN KEY (`idkelas`) REFERENCES `kelas` (`idkelas`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kelas_mahasiswa`
--

LOCK TABLES `kelas_mahasiswa` WRITE;
/*!40000 ALTER TABLE `kelas_mahasiswa` DISABLE KEYS */;
INSERT INTO `kelas_mahasiswa` VALUES (14,1,'1100000001',2016,1),(15,1,'1113464002',2016,1),(16,3,'1113464003',2016,1);
/*!40000 ALTER TABLE `kelas_mahasiswa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kelasdosen`
--

DROP TABLE IF EXISTS `kelasdosen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kelasdosen` (
  `idkelasdosen` int(10) NOT NULL AUTO_INCREMENT,
  `iddosen` int(10) NOT NULL,
  `idkelas` int(2) NOT NULL,
  PRIMARY KEY (`idkelasdosen`),
  KEY `fk_kelasdosen_iddosen_idx` (`iddosen`),
  KEY `fk_kelasdosen_idkelas_idx` (`idkelas`),
  CONSTRAINT `fk_kelasdosen_iddosen` FOREIGN KEY (`iddosen`) REFERENCES `dosen` (`iddosen`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_kelasdosen_idkelas` FOREIGN KEY (`idkelas`) REFERENCES `kelas` (`idkelas`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kelasdosen`
--

LOCK TABLES `kelasdosen` WRITE;
/*!40000 ALTER TABLE `kelasdosen` DISABLE KEYS */;
INSERT INTO `kelasdosen` VALUES (14,4,1),(15,5,1);
/*!40000 ALTER TABLE `kelasdosen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khs`
--

DROP TABLE IF EXISTS `khs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `khs` (
  `idkhs` int(20) NOT NULL AUTO_INCREMENT,
  `nim` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `kodemk` varchar(6) CHARACTER SET latin1 NOT NULL,
  `absensi` double NOT NULL,
  `seminar` double NOT NULL,
  `tugas` double NOT NULL,
  `midsm` double NOT NULL,
  `nsem` double NOT NULL,
  `akhir` double NOT NULL,
  `iddosen` int(10) NOT NULL,
  `idkelas` int(2) NOT NULL,
  `semester` varchar(2) CHARACTER SET latin1 NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idkhs`),
  KEY `fk_khs_kodemk_idx` (`kodemk`),
  KEY `fk_khs_nim_idx` (`nim`),
  KEY `fk_khs_iddosen_idx` (`iddosen`),
  CONSTRAINT `fk_khs_iddosen` FOREIGN KEY (`iddosen`) REFERENCES `dosen` (`iddosen`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_khs_kodemk` FOREIGN KEY (`kodemk`) REFERENCES `matakuliah` (`kodemk`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_khs_nim` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khs`
--

LOCK TABLES `khs` WRITE;
/*!40000 ALTER TABLE `khs` DISABLE KEYS */;
/*!40000 ALTER TABLE `khs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `krs`
--

DROP TABLE IF EXISTS `krs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `krs` (
  `idkrs` int(20) NOT NULL AUTO_INCREMENT,
  `nim` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `kodemk` varchar(6) CHARACTER SET latin1 NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `keterangan` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idkrs`),
  KEY `fk_krs_kodemk_idx` (`kodemk`),
  KEY `fk_krs_nim_idx` (`nim`),
  CONSTRAINT `fk_krs_kodemk` FOREIGN KEY (`kodemk`) REFERENCES `matakuliah` (`kodemk`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_krs_nim` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `krs`
--

LOCK TABLES `krs` WRITE;
/*!40000 ALTER TABLE `krs` DISABLE KEYS */;
INSERT INTO `krs` VALUES (6,'1113464003','PK101','2016-08-08 08:22:23',''),(7,'1113464003','PK102','2016-08-08 08:22:23',''),(8,'1113464003','PK105','2016-08-08 08:22:23',''),(9,'1100000001','PK101','2016-08-08 08:39:00',''),(10,'1100000001','PK102','2016-08-08 08:39:00',''),(11,'1100000001','PK105','2016-08-08 08:39:00',''),(12,'1113464009','PK101','2016-08-08 09:51:11',''),(13,'1113464009','PK102','2016-08-08 09:51:11',''),(14,'1113464009','PK105','2016-08-08 09:51:11',''),(15,'1113464002','ko12','2016-08-09 02:43:52',''),(16,'1113464002','PK101','2016-08-09 02:43:52',''),(17,'1113464002','PK102','2016-08-09 02:43:52',''),(18,'1113464002','PK105','2016-08-09 02:43:52',''),(19,'1113464002','P001','2016-08-09 15:50:18',''),(20,'1113464002','PK106','2016-08-09 15:50:18',''),(21,'1113464002','PK204','2016-08-09 15:50:18',''),(22,'1113464002','RK01','2016-08-09 15:50:18','');
/*!40000 ALTER TABLE `krs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mahasiswa`
--

DROP TABLE IF EXISTS `mahasiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mahasiswa` (
  `nim` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `nama` varchar(100) CHARACTER SET latin1 NOT NULL,
  `tempatlahir` varchar(50) CHARACTER SET latin1 NOT NULL,
  `tanggallahir` date NOT NULL,
  `agama` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `asalsekolah` varchar(100) CHARACTER SET latin1 NOT NULL,
  `namaortu` varchar(100) CHARACTER SET latin1 NOT NULL,
  `status` int(1) NOT NULL COMMENT '1 = berhak\n2 = tidak berhak',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`nim`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mahasiswa`
--

LOCK TABLES `mahasiswa` WRITE;
/*!40000 ALTER TABLE `mahasiswa` DISABLE KEYS */;
INSERT INTO `mahasiswa` VALUES ('1100000001','Andi','Yogya','1996-01-01','Islam','Sultan','Mitu',2,NULL,'2016-08-09 03:07:45'),('1113464002','APRIANA BR SEBAYANG','Medan','1992-01-01','Islam','SMA SWASTA KATOLIK BUDI MURNI 2','DIRGA BUANA SEBAYANG',1,NULL,NULL),('1113464003','ARIE RANTO PUTRA','JAYANTRI','1993-01-01','Islam','SMK KARYA AGUNG','JAMIKSAN',1,NULL,NULL),('1113464004','ARTIKA NAOMI REMINISCERE FELICIA','Medan','1993-01-01','Islam','SMA SWASTA HARAPAN MANDIRI MEDAN','IR DARIAMAN SINAGA',1,NULL,NULL),('1113464005','AVEN ASWADI PASARIBU','PADANGMANDAILING','1992-11-06','Islam','SMA NEGERI 1 ARSE','ZULKIFLI PASARIBU',1,NULL,NULL),('1113464009','DEFRIDA','Medan','1992-11-06','Islam','SMA SWASTA PRIMBANA MEDAN','BUCHARI FARID',1,NULL,NULL),('1113464050','AFRISA ZAHARA','TG PURA SUMUT','1993-04-02','Islam','SMA SWASTA IT MUTIARA DURI BENGKALIS','SYAMSUL BAHRI',1,'2016-08-08 20:34:17','2016-08-08 20:34:17'),('1113464059','ENNI SIMBOLON','TP DALAM','2016-08-10','Islam','SMA SWASTA ST YOSEPH MEDAN','LINTON SIMBOLON',1,'2016-08-09 07:44:09','2016-08-09 07:44:09');
/*!40000 ALTER TABLE `mahasiswa` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `apikes` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tggr_insdetailmhs` AFTER INSERT ON `mahasiswa` FOR EACH ROW BEGIN
		
        declare nim         varchar(10);
        declare vidangkatan int(3);
        declare vtahun      varchar(4);
        declare snama 		varchar(30);
        
        set vtahun 	= concat('20', substr(new.nim, 1,2));
        set snama 	= splitstr(new.nama, ' ', 1);
        
        select idangkatan into vidangkatan from angkatan where tahun=vtahun;
        
        insert into detailmahasiswa (nim, idangkatan) values(new.nim, vidangkatan);
        
        insert into user_mahasiswas (nama, nim, email, password, created_at, updated_at) 
							 values (new.nama, new.nim, concat(snama,'@gmail.com'), md5('12345'), now(), now());
        
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `apikes` CHARACTER SET utf8 COLLATE utf8_general_ci ;

--
-- Table structure for table `matakuliah`
--

DROP TABLE IF EXISTS `matakuliah`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matakuliah` (
  `kodemk` varchar(6) CHARACTER SET latin1 NOT NULL,
  `matakuliah` varchar(100) CHARACTER SET latin1 NOT NULL,
  `bobot` int(1) NOT NULL,
  `teori` int(1) DEFAULT NULL,
  `praktek` int(1) DEFAULT NULL,
  `kadep` varchar(100) CHARACTER SET latin1 NOT NULL,
  `semester` varchar(2) CHARACTER SET latin1 NOT NULL COMMENT 'I-IV',
  `bobotnilai` double NOT NULL,
  PRIMARY KEY (`kodemk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matakuliah`
--

LOCK TABLES `matakuliah` WRITE;
/*!40000 ALTER TABLE `matakuliah` DISABLE KEYS */;
INSERT INTO `matakuliah` VALUES ('ko12','fisika',2,1,1,'testin','1',12),('P001','Bahasawa1',2,1,1,'Andi','2',1),('PK101','Pendidikan Agama',2,2,0,'Kristen:Esraida, SKM, Islam: Ali Sabela,S.Kep.Ns','1',0),('PK102','Pendidikan Pancasila',2,2,0,'Erlinday, M.Kes','1',0),('PK105','Bahasa Inggris I',2,1,1,'Parmen, SKM, M.Kes','1',0),('PK106','Bahasa Jawa',2,2,0,'Leo Sardo, S.S','2',0),('PK204','Biomedik IV ( Patologi )',2,1,1,'Erikson, SKM','2',0),('RK01','biologi',2,1,1,'testing','2',12);
/*!40000 ALTER TABLE `matakuliah` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nilaihuruf`
--

DROP TABLE IF EXISTS `nilaihuruf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nilaihuruf` (
  `idnilaihuruf` int(2) NOT NULL,
  `batasbawah` double NOT NULL,
  `batasatas` double NOT NULL,
  PRIMARY KEY (`idnilaihuruf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nilaihuruf`
--

LOCK TABLES `nilaihuruf` WRITE;
/*!40000 ALTER TABLE `nilaihuruf` DISABLE KEYS */;
/*!40000 ALTER TABLE `nilaihuruf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pendidikan`
--

DROP TABLE IF EXISTS `pendidikan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pendidikan` (
  `idpendidikan` int(2) NOT NULL,
  `gelar` varchar(2) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`idpendidikan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pendidikan`
--

LOCK TABLES `pendidikan` WRITE;
/*!40000 ALTER TABLE `pendidikan` DISABLE KEYS */;
/*!40000 ALTER TABLE `pendidikan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `periode`
--

DROP TABLE IF EXISTS `periode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `periode` (
  `idperiode` int(11) NOT NULL AUTO_INCREMENT,
  `sistem` varchar(100) CHARACTER SET latin1 NOT NULL,
  `tglawal` date NOT NULL,
  `tglakhir` date NOT NULL,
  PRIMARY KEY (`idperiode`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periode`
--

LOCK TABLES `periode` WRITE;
/*!40000 ALTER TABLE `periode` DISABLE KEYS */;
INSERT INTO `periode` VALUES (3,'KHS','2016-08-01','2016-08-03'),(4,'KRS','2016-08-08','2016-09-10');
/*!40000 ALTER TABLE `periode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persenmk`
--

DROP TABLE IF EXISTS `persenmk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persenmk` (
  `idpersen` int(2) NOT NULL,
  `absensi` double NOT NULL,
  `seminar` double NOT NULL,
  `tugas` double NOT NULL,
  `midsm` double NOT NULL,
  `nsem` double NOT NULL,
  `akhir` double NOT NULL,
  PRIMARY KEY (`idpersen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persenmk`
--

LOCK TABLES `persenmk` WRITE;
/*!40000 ALTER TABLE `persenmk` DISABLE KEYS */;
/*!40000 ALTER TABLE `persenmk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tahunajaran`
--

DROP TABLE IF EXISTS `tahunajaran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tahunajaran` (
  `idtahunajaran` int(2) NOT NULL,
  `tahun` varchar(15) CHARACTER SET latin1 NOT NULL,
  `semester` varchar(6) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`idtahunajaran`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tahunajaran`
--

LOCK TABLES `tahunajaran` WRITE;
/*!40000 ALTER TABLE `tahunajaran` DISABLE KEYS */;
/*!40000 ALTER TABLE `tahunajaran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_dosens`
--

DROP TABLE IF EXISTS `user_dosens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_dosens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nidn` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `imageuser` longblob,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_dosen_nim_unique` (`nidn`),
  UNIQUE KEY `users_dosen_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_dosens`
--

LOCK TABLES `user_dosens` WRITE;
/*!40000 ALTER TABLE `user_dosens` DISABLE KEYS */;
INSERT INTO `user_dosens` VALUES (3,'0106127903','Parmen, SKM, M.Kes','sungetamiang@yahoo.co.id','$2y$10$4c.O8r60yvXkkdVHPFlKheJZV2gfddrUf02V9S.XkXHN4ADMRMje2',NULL,'2016-08-11 03:17:14','2016-08-11 03:17:14',NULL);
/*!40000 ALTER TABLE `user_dosens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_mahasiswas`
--

DROP TABLE IF EXISTS `user_mahasiswas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_mahasiswas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nim` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usermahasiswas_nim_unique` (`nim`),
  UNIQUE KEY `usermahasiswas_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_mahasiswas`
--

LOCK TABLES `user_mahasiswas` WRITE;
/*!40000 ALTER TABLE `user_mahasiswas` DISABLE KEYS */;
INSERT INTO `user_mahasiswas` VALUES (1,'andi','1100000001','andi@gmail.com','$2y$10$QmdCsR9S0be5jRGRsyJaMOiNNRN7cY/OtB9Kx1eZskUq12h/iYL.S','9YheF10bvAzuvfoUxe1LzPaLWpQAdTiPFyDB67drXCOOChdFPeaxA0GRBEhb','2016-08-02 02:58:49','2016-08-08 19:42:34'),(2,'APRIANA BR SEBAYANG','1113464002','APRIANA@gmail.com','$2y$10$.nieeFY6Yt1bZo70JZWcvuqSgM4Irt/Q8XrwV62Tl54fO0RoOPvAG','6UqLDxeAL76NzdfdngHDpmMorkpFG1aiAUY6isuD1RZsFzGY0CQJm7DN21YF','2016-08-08 01:07:35','2016-08-11 07:32:51'),(3,'ARIE RANTO PUTRA','1113464003','ARIE@gmail.com','$2y$10$fU.HriwNAscUesdqCZnMyeGQ0MSefFTnrz0VR8rX/H3WR06ILyq8y','jHkI8aTORYzzJtxBC37k2GuIVL1WCdyy9EQWo3MU1oG4VpAsnkBe9977S3Yf','2016-08-08 01:21:14','2016-08-08 01:24:02'),(4,'DEFRIDA','1113464009','defrida@gmail.com','$2y$10$dnRGfcky6uBdRe2Gz/x4BuaiqcuO3mumRP04dwPvQhf6NCr4PGFJC','7TP7Z91KxLdOqs2QplTUYYRDCDdHLiFi3Q38Lodkzc5XvvuFqjUvStBeotBS','2016-08-08 02:49:25','2016-08-08 03:05:56'),(5,'AGUS CHRISTOFEL PANJAITAN','1113464051','AGUS CHRISTOFEL PANJAITAN@gmail.com','827ccb0eea8a706c4c34a16891f84e7b',NULL,'2016-08-09 14:13:55','2016-08-09 14:13:55'),(9,'ENNI SIMBOLON','1113464059','ENNI@gmail.com','827ccb0eea8a706c4c34a16891f84e7b',NULL,'2016-08-09 14:44:09','2016-08-09 14:44:09');
/*!40000 ALTER TABLE `user_mahasiswas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `admin` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'basri','muhammadbasri444@gmail.com','$2y$10$FJMZkrHVUlVammIA.hvgDeGf7OKxs1tHspY5/jS7WDI4mTjSpxLWS','vBE7gkDLpUHQVzJWNyd7bex1sjqeGgwsDPR2OXVruZfG8gYibTHxjJacRC5i','2016-07-29 01:30:58','2016-08-11 07:31:19',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'apikes'
--

--
-- Dumping routines for database 'apikes'
--
/*!50003 DROP FUNCTION IF EXISTS `fromRoman` */;
ALTER DATABASE `apikes` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fromRoman`(`inRoman` VARCHAR(15)) RETURNS int(11)
BEGIN

    DECLARE numeral CHAR(7) DEFAULT 'IVXLCDM';

    DECLARE digit TINYINT;
    DECLARE previous INT DEFAULT 0;
    DECLARE current INT;
    DECLARE sum INT DEFAULT 0;

    SET inRoman = UPPER(inRoman);

    WHILE LENGTH(inRoman) > 0 DO
        SET digit := LOCATE(RIGHT(inRoman, 1), numeral) - 1;
        SET current := POW(10, FLOOR(digit / 2)) * POW(5, MOD(digit, 2));
        SET sum := sum + POW(-1, current < previous) * current;
        SET previous := current;
        SET inRoman = LEFT(inRoman, LENGTH(inRoman) - 1);
    END WHILE;

    RETURN sum;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `apikes` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP FUNCTION IF EXISTS `splitstr` */;
ALTER DATABASE `apikes` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `splitstr`(
x VARCHAR(255),
delim VARCHAR(12),
pos INT
) RETURNS varchar(255) CHARSET latin1
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
CHAR_LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
delim, '') ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `apikes` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!50003 DROP FUNCTION IF EXISTS `toRoman` */;
ALTER DATABASE `apikes` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `toRoman`(inArabic int unsigned) RETURNS varchar(15) CHARSET latin1
    DETERMINISTIC
BEGIN
    DECLARE numeral CHAR(7) DEFAULT 'IVXLCDM';

    DECLARE stringInUse CHAR(3);
    DECLARE position tinyint DEFAULT 1;
    DECLARE currentDigit tinyint;

    DECLARE returnValue VARCHAR(15) DEFAULT '';

    IF(inArabic > 3999) THEN RETURN 'overflow'; END IF;
    IF(inArabic = 0) THEN RETURN 'N'; END IF;

    WHILE position <= CEIL(LOG10(inArabic + .1)) DO
        SET currentDigit := MOD(FLOOR(inArabic / POW(10, position - 1)), 10);

        SET returnValue := CONCAT(
            CASE currentDigit 
                WHEN 4 THEN CONCAT(SUBSTRING(numeral, position * 2 - 1, 1), SUBSTRING(numeral, position * 2, 1))
                WHEN 9 THEN CONCAT(SUBSTRING(numeral, position * 2 - 1, 1), SUBSTRING(numeral, position * 2 + 1, 1))
                ELSE CONCAT(
                    REPEAT(SUBSTRING(numeral, position * 2, 1), currentDigit >= 5),
                    REPEAT(SUBSTRING(numeral, position * 2 - 1, 1), MOD(currentDigit, 5))
                )
            END,
            returnValue);

        SET position := position + 1;
    END WHILE;
    RETURN returnValue;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `apikes` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-08-13 19:17:43
