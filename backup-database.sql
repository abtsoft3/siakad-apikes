/*
MySQL Backup
Source Server Version: 5.5.5
Source Database: apikes
Date: 8/9/2016 17:18:07
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
--  Table structure for `detail_matakuliah`
-- ----------------------------
DROP TABLE IF EXISTS `detail_matakuliah`;
CREATE TABLE `detail_matakuliah` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `kodemk` varchar(6) NOT NULL,
  `nidn` int(11) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nidn` int(10) unsigned zerofill NOT NULL,
  `nama` varchar(100) CHARACTER SET latin1 NOT NULL,
  `jeniskelamin` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `tempatlahir` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `tanggallahir` date NOT NULL,
  `idjabatanstruktural` int(2) DEFAULT NULL,
  `idjabatanfungsional` int(2) DEFAULT NULL,
  `pendidikanakhir` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `agama` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '1 = Tetap\n2 = Tidak Tetap',
  PRIMARY KEY (`id`),
  KEY `fk_jabatanstruktural_dosen` (`idjabatanstruktural`),
  KEY `fk_jabatanfungsional_dosen` (`idjabatanfungsional`),
  CONSTRAINT `fk_jabatanfungsional_dosen` FOREIGN KEY (`idjabatanfungsional`) REFERENCES `jabatan` (`idjabatan`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_jabatanstruktural_dosen` FOREIGN KEY (`idjabatanstruktural`) REFERENCES `jabatan` (`idjabatan`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `jabatan`
-- ----------------------------
DROP TABLE IF EXISTS `jabatan`;
CREATE TABLE `jabatan` (
  `idjabatan` int(2) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`idjabatan`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `kelas`
-- ----------------------------
DROP TABLE IF EXISTS `kelas`;
CREATE TABLE `kelas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kode_kelas` varchar(6) NOT NULL,
  `nama_kelas` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `kelas_mahasiswa`
-- ----------------------------
DROP TABLE IF EXISTS `kelas_mahasiswa`;
CREATE TABLE `kelas_mahasiswa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kode_kelas` varchar(6) NOT NULL,
  `nim` varchar(10) NOT NULL,
  `tahun_ajaran` year(4) DEFAULT NULL,
  `semester` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `kodemk` varchar(11) CHARACTER SET latin1 NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `keterangan` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idkrs`),
  KEY `fk_krs_kodemk_idx` (`kodemk`),
  KEY `fk_krs_nim_idx` (`nim`),
  CONSTRAINT `fk_krs_kodemk` FOREIGN KEY (`kodemk`) REFERENCES `matakuliah` (`kodemk`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_krs_nim` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
  `kodemk` varchar(11) CHARACTER SET latin1 NOT NULL,
  `matakuliah` varchar(100) CHARACTER SET latin1 NOT NULL,
  `bobot` int(1) NOT NULL,
  `teori` int(1) DEFAULT NULL,
  `klinik` int(1) DEFAULT NULL,
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tahun` year(4) NOT NULL,
  `semester` varchar(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `image_user` longblob,
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
INSERT INTO `detailmahasiswa` VALUES ('1100000001','1',NULL),  ('1100000002','1',NULL);
INSERT INTO `jabatan` VALUES ('1','LEKTOR'),  ('2','DIREKTUR'),  ('3','WAKIL DIREKTUR I');
INSERT INTO `kelas` VALUES ('1','KL102','Kelas A'),  ('2','KL103','Kelas B');
INSERT INTO `krs` VALUES ('1','1100000001','PK105','2016-07-27 10:51:12',NULL),  ('2','1100000001','PK102','2016-07-27 15:09:29',NULL),  ('3','1100000001','PK106','2016-08-05 18:32:09',''),  ('4','1100000001','PK204','2016-08-05 18:32:09',''),  ('5','1100000001','PK301','2016-08-08 11:27:21','mantap'),  ('6','1100000001','PK304','2016-08-08 11:27:21','mantap'),  ('7','1100000001','PK305','2016-08-08 11:27:21','mantap');
INSERT INTO `mahasiswa` VALUES ('1100000001','Jokowi','Medan','1995-08-02','Medan','Sutisna'),  ('1100000002','Muhammad Basri','Medan','1995-12-06','sultan iskandar muda','Abdullah');
INSERT INTO `matakuliah` VALUES ('PK102','Pendidikan Pancasila','2','1','0','1','Erlinday, M.Kes','1','6'),  ('PK105','Bahasa Inggris I','2','1','0','1','Parmen, SKM, M.Kes','1','6'),  ('PK106','Bahasa Inggris II','2','1','0','1','Leo Sardo, S.S','2','3'),  ('PK204','Biomedik IV ( Patologi )','2','1','0','1','Erikson, SKM','2','3'),  ('PK301','Sosiologi','2','1','0','1','Tommy Situmorang','3','11'),  ('PK304','Biologi','2','1','0','1','Tommy Suindra','3','2'),  ('PK305','Fisika','2','1','0','1','Tomy Suindra','3','11');
INSERT INTO `migrations` VALUES ('2014_10_12_000000_create_users_table','1'),  ('2014_10_12_100000_create_password_resets_table','1'),  ('2016_07_29_175124_create_users_mahasiswa_table','2'),  ('2016_07_29_175436_create_users_dosen_table','2'),  ('2016_08_01_123557_create_table_usermahasiswa','3'),  ('2016_08_01_123620_create_table_admins','3'),  ('2016_08_02_094712_create_table_user_mahasiswa','4');
INSERT INTO `password_resets` VALUES ('muhammadbasri444@gmail.com','6d2da2135895f1b0bee6810db990f7c4dc9e5564da07bf81423ec76a061a098b','2016-08-01 12:15:53');
INSERT INTO `user_mahasiswas` VALUES ('1','Jokowi','1100000001','jokowi@gmail.com','$2y$10$Wv/WnYUDziQXCZz5xog4Su5hDKMl6rp0zUablW7mF.MQvMxeV0rUK','W0xEyVf6hkxEz4y1RUFoEeyl639GMK2awd86favvxNey0Tgy1DlJ0YX9oGit','2016-08-02 09:58:49','2016-08-08 08:08:59','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');
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
