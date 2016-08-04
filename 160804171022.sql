/*
MySQL Backup
Source Server Version: 5.5.5
Source Database: apikes
Date: 8/4/2016 17:10:24
*/


-- ----------------------------
--  Table structure for `admins`
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
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

-- ----------------------------
--  Table structure for `angkatan`
-- ----------------------------
DROP TABLE IF EXISTS `angkatan`;
CREATE TABLE `angkatan` (
  `idangkatan` int(3) NOT NULL AUTO_INCREMENT,
  `angkatan` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `tahun` int(4) NOT NULL,
  PRIMARY KEY (`idangkatan`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `bidang`
-- ----------------------------
DROP TABLE IF EXISTS `bidang`;
CREATE TABLE `bidang` (
  `idbidang` int(2) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`idbidang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `bidangkeahlian`
-- ----------------------------
DROP TABLE IF EXISTS `bidangkeahlian`;
CREATE TABLE `bidangkeahlian` (
  `idbidangkeahlian` int(2) NOT NULL,
  `nama` varchar(50) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`idbidangkeahlian`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `detailmahasiswa`
-- ----------------------------
DROP TABLE IF EXISTS `detailmahasiswa`;
CREATE TABLE `detailmahasiswa` (
  `nim` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `idangkatan` int(3) NOT NULL,
  `statuskrs` int(1) DEFAULT NULL COMMENT '1 = boleh\nnull = tidak boleh',
  PRIMARY KEY (`nim`),
  KEY `fk_detailmhs_idangkatan_idx` (`idangkatan`),
  CONSTRAINT `fk_detailmhs_idangkatan` FOREIGN KEY (`idangkatan`) REFERENCES `angkatan` (`idangkatan`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_detailmhs_nim` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `dosen`
-- ----------------------------
DROP TABLE IF EXISTS `dosen`;
CREATE TABLE `dosen` (
  `nidn` int(10) unsigned zerofill NOT NULL,
  `nama` varchar(100) CHARACTER SET latin1 NOT NULL,
  `tanggallahir` date NOT NULL,
  `idjabatan` int(2) DEFAULT NULL,
  `sertifikat` int(1) DEFAULT NULL COMMENT '1 = Ada\nnull = Tidak Ada',
  `idpendidikan` int(2) NOT NULL,
  `idbidang` int(2) NOT NULL,
  `asalpt` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `idbidangkeahlian` int(2) NOT NULL,
  `status` int(1) NOT NULL COMMENT '1 = Tetap\n2 = Tidak Tetap',
  PRIMARY KEY (`nidn`),
  KEY `fk_dosen_idjabatan_idx` (`idjabatan`),
  KEY `fk_dosen_idpendidikan_idx` (`idpendidikan`),
  KEY `fk_dosem_idbidang_idx` (`idbidang`),
  KEY `fk_dosen_idbidangkeahlian_idx` (`idbidangkeahlian`),
  CONSTRAINT `fk_dosen_idbidang` FOREIGN KEY (`idbidang`) REFERENCES `bidang` (`idbidang`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_dosen_idbidangkeahlian` FOREIGN KEY (`idbidangkeahlian`) REFERENCES `bidangkeahlian` (`idbidangkeahlian`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_dosen_idjabatan` FOREIGN KEY (`idjabatan`) REFERENCES `jabatan` (`idjabatan`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_dosen_idpendidikan` FOREIGN KEY (`idpendidikan`) REFERENCES `pendidikan` (`idpendidikan`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `jabatan`
-- ----------------------------
DROP TABLE IF EXISTS `jabatan`;
CREATE TABLE `jabatan` (
  `idjabatan` int(2) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`idjabatan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `kelas`
-- ----------------------------
DROP TABLE IF EXISTS `kelas`;
CREATE TABLE `kelas` (
  `idkelas` int(2) NOT NULL AUTO_INCREMENT,
  `nama` varchar(10) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`idkelas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `khs`
-- ----------------------------
DROP TABLE IF EXISTS `khs`;
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
  `nidn` int(10) unsigned zerofill NOT NULL,
  `semester` varchar(2) CHARACTER SET latin1 NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idkhs`),
  KEY `fk_khs_kodemk_idx` (`kodemk`),
  KEY `fk_khs_nim_idx` (`nim`),
  CONSTRAINT `fk_khs_kodemk` FOREIGN KEY (`kodemk`) REFERENCES `matakuliah` (`kodemk`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_khs_nim` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `krs`
-- ----------------------------
DROP TABLE IF EXISTS `krs`;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `mahasiswa`
-- ----------------------------
DROP TABLE IF EXISTS `mahasiswa`;
CREATE TABLE `mahasiswa` (
  `nim` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `nama` varchar(100) CHARACTER SET latin1 NOT NULL,
  `tempatlahir` varchar(50) CHARACTER SET latin1 NOT NULL,
  `tanggallahir` date NOT NULL,
  `asalsekolah` varchar(100) CHARACTER SET latin1 NOT NULL,
  `namaortu` varchar(100) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`nim`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `matakuliah`
-- ----------------------------
DROP TABLE IF EXISTS `matakuliah`;
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

-- ----------------------------
--  Table structure for `migrations`
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `nilaihuruf`
-- ----------------------------
DROP TABLE IF EXISTS `nilaihuruf`;
CREATE TABLE `nilaihuruf` (
  `idnilaihuruf` int(2) NOT NULL,
  `batasbawah` double NOT NULL,
  `batasatas` double NOT NULL,
  PRIMARY KEY (`idnilaihuruf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `password_resets`
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `pendidikan`
-- ----------------------------
DROP TABLE IF EXISTS `pendidikan`;
CREATE TABLE `pendidikan` (
  `idpendidikan` int(2) NOT NULL,
  `gelar` varchar(2) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`idpendidikan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `periode`
-- ----------------------------
DROP TABLE IF EXISTS `periode`;
CREATE TABLE `periode` (
  `idperiode` int(11) NOT NULL AUTO_INCREMENT,
  `sistem` varchar(100) CHARACTER SET latin1 NOT NULL,
  `tglawal` date NOT NULL,
  `tglakhir` date NOT NULL,
  PRIMARY KEY (`idperiode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `persenmk`
-- ----------------------------
DROP TABLE IF EXISTS `persenmk`;
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

-- ----------------------------
--  Table structure for `tahunajaran`
-- ----------------------------
DROP TABLE IF EXISTS `tahunajaran`;
CREATE TABLE `tahunajaran` (
  `idtahunajaran` int(2) NOT NULL,
  `tahun` varchar(15) CHARACTER SET latin1 NOT NULL,
  `semester` varchar(6) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`idtahunajaran`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `user_mahasiswas`
-- ----------------------------
DROP TABLE IF EXISTS `user_mahasiswas`;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
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

-- ----------------------------
--  Procedure definition for `fromRoman`
-- ----------------------------
DROP FUNCTION IF EXISTS `fromRoman`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fromRoman`(inRoman varchar(15)) RETURNS int(11)
    DETERMINISTIC
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
END;;
DELIMITER ;

-- ----------------------------
--  Records 
-- ----------------------------
INSERT INTO `angkatan` VALUES ('1','4','2011'),  ('2','5','2012'),  ('3','6','2013'),  ('4','7','2014'),  ('5','8','2015'),  ('6','1','2009');
INSERT INTO `detailmahasiswa` VALUES ('1100000001','1',NULL);
INSERT INTO `krs` VALUES ('1','1100000001','PK105','2016-07-27 10:51:12',NULL),  ('2','1100000001','PK102','2016-07-27 15:09:29',NULL);
INSERT INTO `mahasiswa` VALUES ('1100000001','Jokowi','Medan','2016-07-27','Medan','Sutisna');
INSERT INTO `matakuliah` VALUES ('PK102','Pendidikan Pancasila','2','1','1','Erlinday, M.Kes','1','6'),  ('PK105','Bahasa Inggris I','2','1','1','Parmen, SKM, M.Kes','1','6'),  ('PK106','Bahasa Inggris II','2','1','1','Leo Sardo, S.S','2','3'),  ('PK204','Biomedik IV ( Patologi )','2','1','1','Erikson, SKM','2','3');
INSERT INTO `migrations` VALUES ('2014_10_12_000000_create_users_table','1'),  ('2014_10_12_100000_create_password_resets_table','1'),  ('2016_07_29_175124_create_users_mahasiswa_table','2'),  ('2016_07_29_175436_create_users_dosen_table','2'),  ('2016_08_01_123557_create_table_usermahasiswa','3'),  ('2016_08_01_123620_create_table_admins','3'),  ('2016_08_02_094712_create_table_user_mahasiswa','4');
INSERT INTO `password_resets` VALUES ('muhammadbasri444@gmail.com','6d2da2135895f1b0bee6810db990f7c4dc9e5564da07bf81423ec76a061a098b','2016-08-01 12:15:53');
INSERT INTO `user_mahasiswas` VALUES ('1','Jokowi','1100000001','jokowi@gmail.com','$2y$10$QmdCsR9S0be5jRGRsyJaMOiNNRN7cY/OtB9Kx1eZskUq12h/iYL.S','cpxM8uM4Kc9tzgMw3j2eA2KfnwBspUGKaVyXnB2E','2016-08-02 09:58:49','2016-08-02 09:58:49');
INSERT INTO `users` VALUES ('1','basri','muhammadbasri444@gmail.com','$2y$10$FJMZkrHVUlVammIA.hvgDeGf7OKxs1tHspY5/jS7WDI4mTjSpxLWS','cXMD7jga8u2sYKK7xJXrRJ3YjS0asQqW6HXXzM6XwipLH6E4YA4ydimI1aVL','2016-07-29 08:30:58','2016-08-02 10:56:14','1');

-- ----------------------------
--  Trigger definition for `mahasiswa`
-- ----------------------------
DELIMITER ;;
CREATE TRIGGER `tggr_insdetailmhs` AFTER INSERT ON `mahasiswa` FOR EACH ROW BEGIN
		
        declare nim varchar(10);
        declare vidangkatan int(3);
        declare vtahun varchar(4);
        
        set vtahun = concat('20', substr(new.nim, 1,2));
        
        select idangkatan into vidangkatan from angkatan where tahun=vtahun;
        
        insert into detailmahasiswa (nim, idangkatan) values(new.nim, vidangkatan);
        
    END;;
DELIMITER ;
