CREATE DATABASE  IF NOT EXISTS `apikes` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
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
INSERT INTO `detailmahasiswa` VALUES ('1113464002',1,NULL),('1113464003',1,NULL),('1113464004',1,NULL),('1113464005',1,NULL),('1113464006',1,NULL),('1113464007',1,NULL),('1113464008',1,NULL),('1113464009',1,NULL),('1113464011',1,NULL),('1113464012',1,NULL),('1113464013',1,NULL),('1113464014',1,NULL),('1113464015',1,NULL),('1113464016',1,NULL),('1113464017',1,NULL),('1113464018',1,NULL),('1113464019',1,NULL),('1113464020',1,NULL),('1113464021',1,NULL),('1113464022',1,NULL),('1113464023',1,NULL),('1113464024',1,NULL),('1113464025',1,NULL),('1113464026',1,NULL),('1113464027',1,NULL),('1113464028',1,NULL),('1113464029',1,NULL),('1113464030',1,NULL),('1113464031',1,NULL),('1113464032',1,NULL),('1113464033',1,NULL),('1113464034',1,NULL),('1113464035',1,NULL),('1113464036',1,NULL),('1113464037',1,NULL),('1113464038',1,NULL),('1113464039',1,NULL),('1113464040',1,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detailmatakuliah`
--

LOCK TABLES `detailmatakuliah` WRITE;
/*!40000 ALTER TABLE `detailmatakuliah` DISABLE KEYS */;
INSERT INTO `detailmatakuliah` VALUES (12,'PK105',4),(13,'PK105',5),(14,'PK102',4),(15,'PK102',5);
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
INSERT INTO `dosen` VALUES (4,'0106127903','Parmen, SKM, M.Kes','2016-08-10','Assisten Ahli','-','S2','Universitas Sumatera Utara','Manajemen kesehatan bencana','2016-08-10 03:37:34','2016-08-16 08:26:44'),(5,'0104088601','Ali sabela Hasibuan, S.Kep, Ns','2016-08-11','Lektor','','S1','Sari Mutiara','Manajemen Keperawatan','2016-08-11 08:44:29','2016-08-11 08:44:29');
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
  `iddosen` int(10) DEFAULT NULL,
  PRIMARY KEY (`idkelas`),
  KEY `fk_kelas_iddosen_idx` (`iddosen`),
  CONSTRAINT `fk_kelas_iddosen` FOREIGN KEY (`iddosen`) REFERENCES `dosen` (`iddosen`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kelas`
--

LOCK TABLES `kelas` WRITE;
/*!40000 ALTER TABLE `kelas` DISABLE KEYS */;
INSERT INTO `kelas` VALUES (1,'KL01','Kelas A',4),(3,'KL02','Kelas B',5),(4,'KL03','Kelas C',4);
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kelas_mahasiswa`
--

LOCK TABLES `kelas_mahasiswa` WRITE;
/*!40000 ALTER TABLE `kelas_mahasiswa` DISABLE KEYS */;
INSERT INTO `kelas_mahasiswa` VALUES (17,1,'1113464002',2015,3),(18,1,'1113464003',2015,3),(19,1,'1113464004',2015,3),(20,1,'1113464005',2015,3),(21,1,'1113464006',2015,3),(22,1,'1113464007',2015,3),(23,1,'1113464008',2015,3),(24,1,'1113464009',2015,3),(25,1,'1113464011',2015,3);
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
  `keterangan` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `iddosen` int(10) NOT NULL,
  `idkelas` int(2) NOT NULL,
  `semester` int(2) NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idkhs`),
  KEY `fk_khs_kodemk_idx` (`kodemk`),
  KEY `fk_khs_nim_idx` (`nim`),
  KEY `fk_khs_iddosen_idx` (`iddosen`),
  KEY `fk_khs_idkelas_idx` (`idkelas`),
  CONSTRAINT `fk_khs_iddosen` FOREIGN KEY (`iddosen`) REFERENCES `dosen` (`iddosen`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_khs_idkelas` FOREIGN KEY (`idkelas`) REFERENCES `kelas` (`idkelas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_khs_kodemk` FOREIGN KEY (`kodemk`) REFERENCES `matakuliah` (`kodemk`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_khs_nim` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khs`
--

LOCK TABLES `khs` WRITE;
/*!40000 ALTER TABLE `khs` DISABLE KEYS */;
INSERT INTO `khs` VALUES (19,'1113464002','PK102',50,60,70,80,90,'',5,1,1,'2016-08-18 04:27:20'),(20,'1113464003','PK102',50,60,70,80,90,'',5,1,1,'2016-08-18 04:27:20'),(21,'1113464004','PK102',50,60,70,80,90,'',5,1,1,'2016-08-18 04:27:20'),(22,'1113464005','PK102',50,60,70,80,90,'',5,1,1,'2016-08-18 04:27:20'),(23,'1113464006','PK102',50,60,70,80,90,'',5,1,1,'2016-08-18 04:27:20'),(24,'1113464007','PK102',50,60,70,80,90,'',5,1,1,'2016-08-18 04:27:20'),(25,'1113464008','PK102',50,60,70,80,90,'',5,1,1,'2016-08-18 04:27:20'),(26,'1113464009','PK102',50,60,70,80,90,'',5,1,1,'2016-08-18 04:27:20'),(27,'1113464011','PK102',50,60,70,80,90,'',5,1,1,'2016-08-18 04:27:20');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `krs`
--

LOCK TABLES `krs` WRITE;
/*!40000 ALTER TABLE `krs` DISABLE KEYS */;
INSERT INTO `krs` VALUES (1,'1113464002','ko12','2016-08-16 09:29:37',''),(2,'1113464002','PK101','2016-08-16 09:29:37',''),(3,'1113464002','PK102','2016-08-16 09:29:37',''),(4,'1113464002','PK105','2016-08-16 09:29:37','');
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
INSERT INTO `mahasiswa` VALUES ('1113464002','APRIANA BR SEBAYANG','MEDAN','1992-04-17','-','SMA SWASTA KATOLIK BUDI MURNI 2','DIRGA BUANA SEBAYANG',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464003','ARIE RANTO PUTRA','JAYANTRI','1993-04-16','','SMK KARYA AGUNG ','JAMIKSAN',1,'0000-00-00 00:00:00','2016-08-16 02:34:55'),('1113464004','ARTIKA NAOMI REMINISCERE FELICIA','MEDAN','1993-10-28','-','SMA SWASTA HARAPAN MANDIRI MEDAN','IR DARIAMAN SINAGA',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464005','AVEN ASWADI PASARIBU','PADANGMANDAILING','1992-11-06','-','SMA NEGERI 1 ARSE','ZULKIFLI PASARIBU',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464006','AYUB','KOTA PARI','1993-09-05','-','SMA NEGERI 1 PERBAUNGAN ','SAMAN HADI',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464007','AZIZAH REZEKIAH HASIBUAN','MEDAN','1992-12-02','-','SMA NEGERI 1 HAMPARAN PERAK','DRS ALI MUKTI HASIBUAN',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464008','DAMAN TAKWA RAMBE','GAROGA','1993-08-17','-','SMA NEGERI 2 PADANGBOLAH','SUTAN PORANG',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464009','DEFRIDA ','MEDAN','1992-11-06','-','SMA SWASTA PRIMBANA MEDAN','BUCHARI FARID',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464011','DESMA KRISTINA SITUMORANG','BUKIT SELAMAT','1992-12-12','-','SMA NEGERI 1 BESITANG ','J SITUMORANG',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464012','DEVI PRANITA ','STABAT','1991-12-28','','SMA NEGERI 1 BANDAR KHALIPAH','SUPRIONO',2,'0000-00-00 00:00:00','2016-08-15 19:12:08'),('1113464013','DINI ERLINA PRAMITHA MATONDANG','PADANG SIDIMPUAN','1993-06-18','-','SMA SWASTA KESUMA INDAH PADANGSIDIMPUAN','DAULAT MATONDANG',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464014','DONI SYAPUTRA','TEBING TINGGI','1993-12-18','-','SMK NEGERI 1 TEBING TINGGI','SAPIRUDDIN',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464015','DWIKA WULANDARI MARBUN ','CINTA RAKYAT','1993-01-23','-','MADRASAH ALIYAH AL-WASHLIYAH 22 TEMBUNG','ALI NAFYAH MARBUN',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464016','EKA OKTAFIANITA ','TEBING TINGGI','1993-10-26','-','SMK NEGERI 2 TEBING TINGGI','SOFIAN',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464017','ERWIN EFENDI SIANTURI','KALANGBAR','1992-08-01','-','SMA NEGERI 1 SIDIKALANG','ALDER SIANTURI',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464018','ESRA BR GINTING','AJI NEMBAH','1992-04-13','-','SMK SWASTA PHARMACA MEDAN','SODER GINTING',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464019','GERTI MAIFA SARAH','ACEH','1991-05-28','-','SMA NEGERI 18 MEDAN','TAMBAH HASIBUAN',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464020','HERI ASWINARDI NASUTION','MEDAN','1993-02-27','-','SMA NEGERI 3 PADANGSIDIMPUAN','HIFNI NASUTION',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464021','ICHSAN SYAMTARA SITEPU','BINJAI','1993-07-10','-','SMA SWASTA TUNAS PELITA BINJAI','OMAR BATARA SITEPU',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464022','IRMAYANTI JULITA SIMANIHURUK ','MEDAN','1993-07-13','-','SMA SWASTA ST YOSEPH MEDAN','OLOAN SIMANIHURUK',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464023','IRVANNY','MEDAN','1993-07-05','-','SMA NEGERI 6 MEDAN','BAMBANG IRIANO',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464024','KHAIRINA ','BINJAI','1993-05-04','-','SMA NEGERI 5 BINJAI ','IRIANTO',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464025','KHAIRUN NISA ','PANTAI CERMIN KIRI','1993-03-26','-','SMA NEGERI 1 PANTAI CERMIN','HASRAT',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464026','LISNAWATI LIMBONG','LIMBONG','1993-02-28','-','SMA NEGERI 1 SIANJUR MULAMULA','PINTAR LIMBONG',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464027','LOLITA FIERDA GUSTIARA SILALAHI','RANTAU PRAPAT','1993-08-10','-','SMA NEGERI 1 RANTAU UTARA ','J SILALAHI',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464028','LORINA CLAUDIA BR SEMBIRING ','BERASTAGI','1993-01-24','-','SMA SWASTA ADVENT 1 KOTA MEDAN','BERSAMA SEMBIRING',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464029','M HANAFI','PASAR LARU','1991-10-10','-','SMA NEGERI 1 TAMBANGAN MANDAILING NATAL','HOLLAD LUBIS',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464030','MARTA ULINA PURBA','BAH SIDUA - DUA','1993-02-23','-','SMA NEGERI 1 SERBAJADI SERDANG BEDAGAI','NAJIM PURBA',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464031','MELINA TIODORA SITANGGANG','MEDAN','1993-02-16','-','SMA SWASTA KATOLIK BUDI MURNI 3 MEDAN','N SITANGGANG',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464032','MITA YUSWITA SARI ','MEDAN','1991-08-14','-','SMK SWASTA AMIR HAMZAH MEDAN','M YUSUF',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464033','MORGAN HARRY PARNINGOTAN M','MEDAN','1993-11-10','-','SMA SWASTA ST YOSEPH MEDAN','FREDDY PARNINGOTAN MANULLANG',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464034','MUHAMMAD LUTHFI SISKANDAR ','MEDAN','1993-11-21','-','SMA NEGERI 15 MEDAN','SISWO PURNOMO',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464035','NAZLI HASWANI SARAGIH ','BERAMPU','1992-03-08','-','SMA NEGERI 1 SIDIKALANG ','KAMLOR SARAGAIH',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464036','NELLY HERIYANTI PURBA','TORNAULI','1993-09-13','-','SMA SWASTA SANTA MARIA TARUTUNG','SIMON PURBA',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464037','NOVA FRASETIA NINGSIH SARAGIH','SIMP RAJANI HUTA','1991-11-08','-','SMA SWASTA SANTA MARIA MEDAN','PARULIAN SARAGIH',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464038','PEDDAH IMOY CIBRO','SIDIKALANG','1993-05-11','-','SMA NEGERI 1 SIDIKALANG','PITTOR HADOMUAN CIBRO',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464039','PIARDIARON LAOLI','EHOSAKHOZI','1991-10-29','-','SMK SWASTA KRISTEN HARAPAN SEJAHTERA GUNUNG SITOLI I DANOI','AMINUDIN LAOLI',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),('1113464040','PUTRI FACHRUNNISA ','TANJUNG PURA','1994-03-02','-','SMA NEGERI 1 HINAI KABUPATEN LANGKAT','ANDI SYAHPUTRA',1,'0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `mahasiswa` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
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
  `klinik` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
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
INSERT INTO `matakuliah` VALUES ('ko12','fisika',2,1,1,NULL,'testin','1',12),('PK101','Pendidikan Agama',2,2,0,NULL,'Kristen:Esraida, SKM, Islam: Ali Sabela,S.Kep.Ns','1',0),('PK102','Pendidikan Pancasila',2,2,0,'','Erlinday, M.Kes','1',0),('PK105','Bahasa Inggris I',2,1,1,'','Parmen, SKM, M.Kes','1',0),('PK106','Bahasa Jawa',2,2,0,NULL,'Leo Sardo, S.S','2',0),('PK204','Biomedik IV ( Patologi )',2,1,1,NULL,'Erikson, SKM','2',0),('RK01','biologi',2,1,1,NULL,'testing','2',12);
/*!40000 ALTER TABLE `matakuliah` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nilaihuruf`
--

DROP TABLE IF EXISTS `nilaihuruf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nilaihuruf` (
  `idnilaihuruf` int(2) NOT NULL AUTO_INCREMENT,
  `batasbawah` float(5,2) NOT NULL,
  `batasatas` float(5,2) NOT NULL,
  `nilai` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idnilaihuruf`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nilaihuruf`
--

LOCK TABLES `nilaihuruf` WRITE;
/*!40000 ALTER TABLE `nilaihuruf` DISABLE KEYS */;
INSERT INTO `nilaihuruf` VALUES (1,85.00,100.00,'A'),(2,75.00,84.00,'B'),(3,60.00,74.00,'C'),(4,50.00,59.00,'D'),(5,0.00,49.00,'E');
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
INSERT INTO `periode` VALUES (4,'KRS','2016-08-01','2016-08-03');
/*!40000 ALTER TABLE `periode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persenmk`
--

DROP TABLE IF EXISTS `persenmk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persenmk` (
  `idpersen` int(2) NOT NULL AUTO_INCREMENT,
  `absensi` float NOT NULL,
  `seminar` float NOT NULL,
  `tugas` float NOT NULL,
  `midsm` float NOT NULL,
  `nsem` float NOT NULL,
  PRIMARY KEY (`idpersen`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persenmk`
--

LOCK TABLES `persenmk` WRITE;
/*!40000 ALTER TABLE `persenmk` DISABLE KEYS */;
INSERT INTO `persenmk` VALUES (1,10,5,20,30,35);
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
  `iddosen` int(11) NOT NULL,
  `nama` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `imageuser` longblob,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_dosen_nim_unique` (`iddosen`),
  UNIQUE KEY `users_dosen_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_dosens`
--

LOCK TABLES `user_dosens` WRITE;
/*!40000 ALTER TABLE `user_dosens` DISABLE KEYS */;
INSERT INTO `user_dosens` VALUES (4,5,'Ali sabela Hasibuan, S.Kep, Ns','ali@gmail.com','$2y$10$zandq0UGHlkU6gneISXddeNGvW/6rfqSLKSOAnnJKFNXrndAgi3N6','9qM9YrhEk9K1R6FqApmtX3tmCxQ3fJMkNTCe5XaHeiHglP8EO6nt4HEVEPQO','2016-08-15 08:00:05','2016-08-17 21:44:29',NULL);
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
  `image_user` longblob,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usermahasiswas_nim_unique` (`nim`),
  UNIQUE KEY `usermahasiswas_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_mahasiswas`
--

LOCK TABLES `user_mahasiswas` WRITE;
/*!40000 ALTER TABLE `user_mahasiswas` DISABLE KEYS */;
INSERT INTO `user_mahasiswas` VALUES (62,'APRIANA BR SEBAYANG','1113464002','APRIANA@gmail.com','$2y$10$Ks1cDu/7GkHH.h0qax5hz.CNJdNIjuv.SC0yTfW8U8wux3dvvMb72','AoUw3BdyLJDWbEH24ThaTK24CmUEjosbT6VCIub1gnRFQGtFhWv2m9kitXDG','2016-08-16 02:07:42','2016-08-17 22:02:59'),(63,'ARIE RANTO PUTRA','1113464003','ARIE@gmail.com','$2y$10$wtdYIA3LAZ/EoOvtHPOf0.z8otd23CHeamGqjtqD0Tpy1Jr6W9xIC','MYF15VootnS5EUcrqhtjtSLbJndy3pQ59jOCtG9Sp2wrj4hiltOPFPC1nTye','2016-08-16 02:07:42','2016-08-16 02:36:11'),(64,'ARTIKA NAOMI REMINISCERE FELICIA','1113464004','ARTIKA@gmail.com','$2y$10$pUvGlJKYyrLn5Y04e035hOI6Ttv76621OPLU0Mz3TjjDBkIcOgT3S','EpU6ZD7J2WbXvYyEYStFT2UvMKFEBkLEht1SCH1v','2016-08-16 02:07:42','2016-08-16 02:27:35'),(65,'AVEN ASWADI PASARIBU','1113464005','AVEN@gmail.com','$2y$10$c0sp5nzhpqURpECKAkyoRuzPgV7RgUkTu4TT9Tzx5T/u7bIA2ikr.','EpU6ZD7J2WbXvYyEYStFT2UvMKFEBkLEht1SCH1v','2016-08-16 02:07:42','2016-08-16 02:27:37'),(66,'AYUB','1113464006','AYUB@gmail.com','$2y$10$UtczmNHLgXgdrLcfboPFNuU4LvYT20ofXHui3FujE70ZrbphUODy6','EpU6ZD7J2WbXvYyEYStFT2UvMKFEBkLEht1SCH1v','2016-08-16 02:07:42','2016-08-16 02:27:37'),(67,'AZIZAH REZEKIAH HASIBUAN','1113464007','AZIZAH@gmail.com','$2y$10$SAnuDmqljn9LO/SECsQTBe6Pwc/HX7irV41AZUTVtNpigZQ7F6lMO','EpU6ZD7J2WbXvYyEYStFT2UvMKFEBkLEht1SCH1v','2016-08-16 02:07:42','2016-08-16 02:27:50'),(68,'DAMAN TAKWA RAMBE','1113464008','DAMAN@gmail.com','$2y$10$c8.M0oYHPrFhM73jXfHdxOYgO6oAdaOAwufz3CXGQd5OdO5q.EOhm','EpU6ZD7J2WbXvYyEYStFT2UvMKFEBkLEht1SCH1v','2016-08-16 02:07:42','2016-08-16 02:27:51'),(69,'DEFRIDA ','1113464009','DEFRIDA@gmail.com','$2y$10$cdurynXQnlbQAQq3fHNJPe4yaEs48dVdGmwNQUKd1R5UFay.cULI6','EpU6ZD7J2WbXvYyEYStFT2UvMKFEBkLEht1SCH1v','2016-08-16 02:07:42','2016-08-16 02:27:52'),(70,'DESMA KRISTINA SITUMORANG','1113464011','DESMA@gmail.com','$2y$10$B9r4lYgx6cLJMR.tW.J14uLOvoOXPNC3P6obnl1JKCg/Ht8wuzh1O','EpU6ZD7J2WbXvYyEYStFT2UvMKFEBkLEht1SCH1v','2016-08-16 02:07:42','2016-08-16 02:27:53'),(71,'DEVI PRANITA ','1113464012','DEVI@gmail.com','$2y$10$Elny7sD6HmC1pQ9fW84fsucWcKUw29YOmvFbjaxXVWJm0VFpB4w.q','EpU6ZD7J2WbXvYyEYStFT2UvMKFEBkLEht1SCH1v','2016-08-16 02:07:42','2016-08-16 02:27:53'),(72,'DINI ERLINA PRAMITHA MATONDANG','1113464013','DINI@gmail.com','$2y$10$42iUmpV.btsFukkdbsIbd.ZjduNo5HRwIuc6PPEbMfIp2CNVrvVSu','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:30'),(73,'DONI SYAPUTRA','1113464014','DONI@gmail.com','$2y$10$kXUMewtXd7h5cJEqVO/ZkOiFGL9k7/vFQ3CrJKErUutvX7j13u4re','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:31'),(74,'DWIKA WULANDARI MARBUN ','1113464015','DWIKA@gmail.com','$2y$10$g770U1tRarryJZuBwxgDiuqtHqfE.Jb/7HbrM1L4t/TQzgNCDbP/2','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:31'),(75,'EKA OKTAFIANITA ','1113464016','EKA@gmail.com','$2y$10$EOoJETG.3xggIdBY0mVrtO7FXwazIPYwGJRm9.56ogMEO0zEvKjqq','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:35'),(76,'ERWIN EFENDI SIANTURI','1113464017','ERWIN@gmail.com','$2y$10$xSJKCSm4toePneCK2Bvpa.GXGUwa9AIC6VsFadjMFunsU9S.zn1mm','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:35'),(77,'ESRA BR GINTING','1113464018','ESRA@gmail.com','$2y$10$rK.mrAd8qNaBwnaeMPV.JOLU9Mz3Jym13mhVweb5hQc.KnM34YY0G','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:37'),(78,'GERTI MAIFA SARAH','1113464019','GERTI@gmail.com','$2y$10$8ZksJOFSXOVy2e1gEHYcPuHnNdPAIW6IbdIR6j2cXc9OP4fZ.2Djm','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:38'),(79,'HERI ASWINARDI NASUTION','1113464020','HERI@gmail.com','$2y$10$ZaZdrNYebFwpmMIoTqUiJOCGIvC/SXtqH2yvatDDivngQomrdqule','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:38'),(80,'ICHSAN SYAMTARA SITEPU','1113464021','ICHSAN@gmail.com','$2y$10$wlMJlBS/JKSgKqfSOSVtC.9wJ.zHO6a9IqceVCVH1vWFdo6/JnjXG','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:39'),(81,'IRMAYANTI JULITA SIMANIHURUK ','1113464022','IRMAYANTI@gmail.com','$2y$10$CmwII0Ryad6rCJ9jWUG3W.NkoGJDuazfJlWaJl4BirT2yupNmhYii','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:40'),(82,'IRVANNY','1113464023','IRVANNY@gmail.com','$2y$10$ZPnCx6n7vGzlk8U8xRg/lOUCj/yXmkAXSMZx6Yih5VsWlOyO0SobO','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:41'),(83,'KHAIRINA ','1113464024','KHAIRINA@gmail.com','$2y$10$UUVI5/1fvjUstUyA.IjL9.estmln5nRQ9z.MFkYucNplScevp9Lla','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:42'),(84,'KHAIRUN NISA ','1113464025','KHAIRUN@gmail.com','$2y$10$VJmUl7vUzqvPAh5It5/PDOPHGPcH1RWcMogDOFZ8SIDul1c5H6xT.','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:45'),(85,'LISNAWATI LIMBONG','1113464026','LISNAWATI@gmail.com','$2y$10$sdUHrgELWJD6wxhW4pVe..VIsNSXUS.HJ8MEHP2ZpbmiGp4drtDRC','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:46'),(86,'LOLITA FIERDA GUSTIARA SILALAHI','1113464027','LOLITA@gmail.com','$2y$10$5a0oCKklzYC/Y6CmOHhTi.LssbcSryW34pj9AlupU0.ITfKa.kVK.','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:47'),(87,'LORINA CLAUDIA BR SEMBIRING ','1113464028','LORINA@gmail.com','$2y$10$E/UP8bVbtbvYUl4Ed.fUeulgHdEFSGkk0gLq1oghSLwrcmFtPBo0y','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:48'),(88,'M HANAFI','1113464029','M@gmail.com','$2y$10$Sb3lvUSyk3gQ6wx8zGZamO1iD/Bhk/4oV0h09ws9Nm/inlaCwP6gS','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:49'),(89,'MARTA ULINA PURBA','1113464030','MARTA@gmail.com','$2y$10$qxt7QRSgDBz9JKf.4PpmQOEoTJRBz2ZVqapDcuZR8CEEUHSj0jVlC','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:49'),(90,'MELINA TIODORA SITANGGANG','1113464031','MELINA@gmail.com','$2y$10$3G0xkEc6DCuRsI.JFaBLzOVdWyJrDf9mN0qF2lAhU2AGX5zzgiiyK','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:50'),(91,'MITA YUSWITA SARI ','1113464032','MITA@gmail.com','$2y$10$.D3me66dORx11AeBFaQXGObrftMVgLhhVitTQ0vV3/adO0dahsbGy','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:51'),(92,'MORGAN HARRY PARNINGOTAN M','1113464033','MORGAN@gmail.com','$2y$10$3KVHw7jfpqeVTFCoyNUJIeenH9QQmepZkhkahyk4scGKk74Wm5Q62','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:51'),(93,'MUHAMMAD LUTHFI SISKANDAR ','1113464034','MUHAMMAD@gmail.com','$2y$10$uIgjr8Qd7PJA/hE2i2AioubUPqpj5vOYyxMA0Fj5Wz9OTSFtRMzbC','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:56'),(94,'NAZLI HASWANI SARAGIH ','1113464035','NAZLI@gmail.com','$2y$10$RAYNEYTGt.qIs0vrtqg6ZOm3IzdAjViHmTsk2ATb66ISj1clJW/x2','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:57'),(95,'NELLY HERIYANTI PURBA','1113464036','NELLY@gmail.com','$2y$10$W8YDLwwE79aWyRgHop/NkuipcD/y5aln3h7jdE9bwg4CPj5stDyVC','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:58'),(96,'NOVA FRASETIA NINGSIH SARAGIH','1113464037','NOVA@gmail.com','$2y$10$DrHcBlk8ZXISzSQ41UDr0eQdEOzYjOxlhBcEONe7mQp1Qs39v5/w6','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:10:59'),(97,'PEDDAH IMOY CIBRO','1113464038','PEDDAH@gmail.com','$2y$10$I8/2dOpGsv2V7QJv3p4G.OpdUPY8Tx8VuTbGYOV8EmU72aZ5R4diu','ulzXyriSMspVwog4rg0UO3rqtG1rZZzTKgADolQECEoWy7emPWwzzwJI2ZrT','2016-08-16 02:07:42','2016-08-15 19:11:38'),(98,'PIARDIARON LAOLI','1113464039','PIARDIARON@gmail.com','$2y$10$8F3Rv4Ggpkii1Cl7NkqBn.3NDsy1E1Zfg2rk6rNmyaR/rP5Lwvh6e','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:11:01'),(99,'PUTRI FACHRUNNISA ','1113464040','PUTRI@gmail.com','$2y$10$d8EOq/oBgDkb4xAEdY7dn.W.vrwVfBuGcC3L8vThwk/xVvMdUUexO','ljRx7Jbd8rViR6lOMA8lLV5RPG4vj1rUPGTNZ6LT','2016-08-16 02:07:42','2016-08-15 19:11:02');
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
  `imageuser` longblob,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'basri','muhammadbasri444@gmail.com','$2y$10$FJMZkrHVUlVammIA.hvgDeGf7OKxs1tHspY5/jS7WDI4mTjSpxLWS','V2O5a52bdh3mNBb5KyHqQkx2ud0Nae5nZyFcAniPG2UdFegJTel3Z0QlUCIG','2016-07-29 01:30:58','2016-08-17 21:54:48',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'apikes'
--

--
-- Dumping routines for database 'apikes'
--
/*!50003 DROP FUNCTION IF EXISTS `fhitungakhir` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fhitungakhir`(nilaiabsensi float(5,2), nilaiseminar float(5,2), nilaitugas float(5,2), nilaimidsm float(5,2), nilaiuas float(5,2)) RETURNS float(5,2)
BEGIN
	declare hasil float(5,2);
    declare persenabsensi float(5,2);
    declare persenseminar float(5,2);
    declare persentugas float(5,2);
    declare persenmidsm float(5,2);
    declare persenuas float(5,2);
    
    declare habsensi float(5,2);
    declare hseminar float(5,2);
    declare htugas float(5,2);
    declare hmidsm float(5,2);
    declare huas float(5,2);
    
    select absensi, seminar, tugas, midsm, nsem into persenabsensi, persenseminar, persentugas, persenmidsm, persenuas from persenmk where idpersen=1;
    
    set habsensi 	= (nilaiabsensi * persenabsensi) / 100;
    set hseminar 	= (nilaiseminar * persenseminar) / 100;
    set htugas 		= (nilaitugas * persentugas) / 100;
    set hmidsm 		= (nilaimidsm * persenmidsm) / 100;
    set huas 		= (nilaiuas * persenuas) / 100;
    
    set hasil = (habsensi + hseminar + htugas + hmidsm + huas);
    
RETURN hasil;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fnilaihuruf` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fnilaihuruf`(n float(5,2)) RETURNS varchar(2) CHARSET utf8
BEGIN
	declare nf varchar(2);
    
	set nf = (select nilai from nilaihuruf where n >= batasbawah  and n <= batasatas);
    
RETURN nf;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fnilaimutu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fnilaimutu`(nilaihuruf varchar(2)) RETURNS float(3,2)
BEGIN
	declare hasil float(3,2);
    
    if nilaihuruf = "A" then
		set hasil = 4.00;
	elseif nilaihuruf = "B" then
		set hasil = 3.00;
	elseif nilaihuruf = "C" then
		set hasil = 2.00;
    elseif nilaihuruf = "D" then
		set hasil = 1.00;
	else 
		set hasil = 0.00;
	end if;
RETURN hasil;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fromRoman` */;
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
/*!50003 DROP FUNCTION IF EXISTS `ftanggal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `ftanggal`(tanggal date) RETURNS varchar(20) CHARSET utf8
BEGIN
	declare hasil varchar(20);
    declare namabulan varchar(100) default 'Januari|Februari|Maret|April|Mei|Juni|Juli|Agustus|September|Oktober|November|Desember';
	declare nbulan int(2);
    declare tahun varchar(4);
    declare bulan varchar(10);
    declare tgl varchar(2);
    
    set tahun  = splitstr(tanggal, '-', 1);
    set nbulan = splitstr(tanggal, '-', 2);
    set bulan  = splitstr(namabulan, '|', (nbulan));
    set tgl    = splitstr(tanggal, '-', 3);
    set hasil  = concat(tgl, " ", bulan, " ", tahun);
    
RETURN hasil;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `splitstr` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `splitstr`(`x` VARCHAR(255), `delim` VARCHAR(12), `pos` INT) RETURNS varchar(255) CHARSET latin1
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
CHAR_LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
delim, '') ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `toRoman` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `toRoman`(`inArabic` INT UNSIGNED) RETURNS varchar(15) CHARSET latin1
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-08-18 14:43:53
