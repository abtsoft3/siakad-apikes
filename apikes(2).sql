-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Sep 05, 2016 at 05:24 PM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 5.5.37

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `apikes`
--
CREATE DATABASE IF NOT EXISTS `siakadapikes` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `siakadapikes`;

DELIMITER $$
--
-- Functions
--
DROP FUNCTION IF EXISTS `fhitungakhir`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fhitungakhir` (`nilaiabsensi` FLOAT(5,2), `nilaiseminar` FLOAT(5,2), `nilaitugas` FLOAT(5,2), `nilaimidsm` FLOAT(5,2), `nilaiuas` FLOAT(5,2)) RETURNS FLOAT(5,2) BEGIN
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
END$$

DROP FUNCTION IF EXISTS `fnilaihuruf`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fnilaihuruf` (`n` FLOAT(5,2)) RETURNS VARCHAR(2) CHARSET utf8 BEGIN
	declare nf varchar(2);
    
	set nf = (select nilai from nilaihuruf where n >= batasbawah  and n <= batasatas);
    
RETURN nf;
END$$

DROP FUNCTION IF EXISTS `fnilaimutu`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fnilaimutu` (`nilaihuruf` VARCHAR(2)) RETURNS FLOAT(3,2) BEGIN
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
END$$

DROP FUNCTION IF EXISTS `fromRoman`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fromRoman` (`inRoman` VARCHAR(15)) RETURNS INT(11) BEGIN

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
END$$

DROP FUNCTION IF EXISTS `ftanggal`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ftanggal` (`tanggal` DATE) RETURNS VARCHAR(20) CHARSET utf8 BEGIN
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
END$$

DROP FUNCTION IF EXISTS `splitstr`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `splitstr` (`x` VARCHAR(255), `delim` VARCHAR(12), `pos` INT) RETURNS VARCHAR(255) CHARSET latin1 RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
CHAR_LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
delim, '')$$

DROP FUNCTION IF EXISTS `toRoman`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `toRoman` (`inArabic` INT UNSIGNED) RETURNS VARCHAR(15) CHARSET latin1 BEGIN
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
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `angkatan`
--

DROP TABLE IF EXISTS `angkatan`;
CREATE TABLE `angkatan` (
  `idangkatan` int(3) NOT NULL,
  `angkatan` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `tahun` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `angkatan`
--

INSERT INTO `angkatan` (`idangkatan`, `angkatan`, `tahun`) VALUES
(1, '4', 2011),
(2, '5', 2012),
(3, '6', 2013),
(4, '7', 2014),
(5, '8', 2015),
(6, '1', 2009);

-- --------------------------------------------------------

--
-- Table structure for table `bidang`
--

DROP TABLE IF EXISTS `bidang`;
CREATE TABLE `bidang` (
  `idbidang` int(2) NOT NULL,
  `nama` varchar(100) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bidangkeahlian`
--

DROP TABLE IF EXISTS `bidangkeahlian`;
CREATE TABLE `bidangkeahlian` (
  `idbidangkeahlian` int(2) NOT NULL,
  `nama` varchar(50) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `detailmahasiswa`
--

DROP TABLE IF EXISTS `detailmahasiswa`;
CREATE TABLE `detailmahasiswa` (
  `nim` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `idangkatan` int(3) NOT NULL,
  `statuskrs` int(1) DEFAULT NULL COMMENT '1 = boleh\nnull = tidak boleh'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `detailmahasiswa`
--

INSERT INTO `detailmahasiswa` (`nim`, `idangkatan`, `statuskrs`) VALUES
('1313466001', 3, NULL),
('1313466002', 3, NULL),
('1313466003', 3, NULL),
('1313466004', 3, NULL),
('1313466005', 3, NULL),
('1313466006', 3, NULL),
('1313466007', 3, NULL),
('1313466008', 3, NULL),
('1313466009', 3, NULL),
('1313466010', 3, NULL),
('1313466011', 3, NULL),
('1313466013', 3, NULL),
('1313466014', 3, NULL),
('1313466017', 3, NULL),
('1313466018', 3, NULL),
('1313466019', 3, NULL),
('1313466020', 3, NULL),
('1313466021', 3, NULL),
('1313466022', 3, NULL),
('1313466023', 3, NULL),
('1313466024', 3, NULL),
('1313466025', 3, NULL),
('1313466026', 3, NULL),
('1313466027', 3, NULL),
('1313466028', 3, NULL),
('1313466029', 3, NULL),
('1313466030', 3, NULL),
('1313466031', 3, NULL),
('1313466032', 3, NULL),
('1313466033', 3, NULL),
('1313466034', 3, NULL),
('1313466035', 3, NULL),
('1313466036', 3, NULL),
('1313466037', 3, NULL),
('1313466039', 3, NULL),
('1313466040', 3, NULL),
('1313466078', 3, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `detailmatakuliah`
--

DROP TABLE IF EXISTS `detailmatakuliah`;
CREATE TABLE `detailmatakuliah` (
  `id` int(11) NOT NULL,
  `kodemk` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `iddosen` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `detailmatakuliah`
--

INSERT INTO `detailmatakuliah` (`id`, `kodemk`, `iddosen`) VALUES
(1, 'RMIK 2', 26),
(7, 'RMIK24', 10),
(8, 'RMIK24', 30),
(9, 'RMIK24', 31),
(10, 'RMIK24', 32),
(11, 'RMIK24', 33),
(17, 'RMIK 3', 27),
(18, 'RRMIK ', 25),
(19, 'RRMIK ', 35),
(20, 'RMIK 1', 23),
(21, 'RMIK10', 23),
(22, 'RMIK10', 36),
(23, 'RMIK10', 36),
(24, 'RMIK1', 24),
(25, 'RMIK3', 24),
(26, 'RMIK3', 26),
(27, 'RMIK2', 38),
(28, 'RMIK36', 38),
(29, 'RMIK36', 27),
(30, 'RMIK34', 27),
(31, 'RMIK34', 10),
(32, 'RMIK34', 32),
(33, 'RMIK34', 33),
(34, 'RMIK34', 31),
(35, 'RMIK34', 39),
(36, 'RMIK21', 27),
(37, 'RMIK21', 10),
(38, 'RMIK21', 32),
(39, 'RMIK21', 33),
(40, 'RMIK21', 31),
(41, 'RMIK21', 39),
(42, 'RMIK21', 40),
(43, 'RMIK15', 27),
(44, 'RMIK15', 10),
(45, 'RMIK15', 32),
(46, 'RMIK15', 33),
(47, 'RMIK15', 31),
(48, 'RMIK15', 39),
(49, 'RMIK15', 40),
(50, 'RMIK15', 36),
(59, 'RMIK31', 38),
(60, 'RMIK 4', 38),
(61, 'RMIK 4', 32),
(62, 'RMIK22', 38),
(63, 'RMIK22', 32),
(64, 'RMIK22', 7),
(65, 'RMIK', 38),
(66, 'RMIK', 32),
(67, 'RMIK', 7),
(68, 'RMIK', 27),
(69, 'RMIK4', 38),
(70, 'RMIK4', 32),
(71, 'RMIK4', 7),
(72, 'RMIK4', 27),
(73, 'RMIK4', 30),
(74, 'RMIK20', 38),
(75, 'RMIK20', 32),
(76, 'RMIK20', 7),
(77, 'RMIK20', 27),
(78, 'RMIK20', 30),
(79, 'RMIK20', 42),
(80, 'RMIK23', 38),
(81, 'RMIK23', 32),
(82, 'RMIK23', 7),
(83, 'RMIK23', 27),
(84, 'RMIK23', 30),
(85, 'RMIK23', 42),
(86, 'RMIK23', 38),
(94, 'RMIK42', 38),
(95, 'RMIK42', 32),
(96, 'RMIK42', 7),
(97, 'RMIK42', 27),
(98, 'RMIK42', 30),
(99, 'RMIK42', 42),
(100, 'RMIK42', 38),
(101, 'RMIK42', 7),
(102, 'RMIK54', 38),
(103, 'RMIK54', 32),
(104, 'RMIK54', 7),
(105, 'RMIK54', 27),
(106, 'RMIK54', 30),
(107, 'RMIK54', 42),
(108, 'RMIK54', 38),
(109, 'RMIK54', 7),
(110, 'RMIK54', 43),
(111, 'RMIK44', 38),
(112, 'RMIK44', 32),
(115, 'RMIK44', 30),
(122, '3324', 38),
(134, '2434', 11),
(135, '2434', 18),
(138, '3074', 44),
(139, '2111', 26),
(143, '2411', 10),
(144, '2411', 30),
(145, '2411', 31),
(146, '2411', 32),
(147, '2411', 33),
(155, '1011', 34),
(156, '1011', 35),
(176, '1041', 36),
(188, '1031', 37),
(189, '3122', 26),
(191, '2622', 38),
(192, '3632', 27),
(194, '3422', 32),
(195, '3422', 31),
(196, '3422', 39),
(197, '3422', 10),
(203, '2412', 40),
(204, '1052', 27),
(205, '1052', 32),
(206, '1052', 31),
(207, '1052', 39),
(208, '1052', 10),
(209, '1052', 40),
(210, '1052', 36),
(218, '3133', 38),
(219, '4423', 32),
(221, '2213', 7),
(224, '3643', 27),
(228, '3433', 30),
(229, '3433', 32),
(230, '3433', 39),
(231, '3433', 41),
(239, '2063', 42),
(248, '2313', 38),
(251, '4224', 7),
(254, '3654', 43),
(258, '3444', 42),
(268, '5144', 45),
(274, '4225', 48),
(277, '3335', 26),
(281, '3155', 38),
(282, '3665', 8),
(284, '3455', 32),
(285, '3455', 31),
(286, '3455', 39),
(287, '3455', 10),
(293, '3465', 30),
(295, '3465', 42),
(297, '3475', 32),
(332, 'PK404', 33),
(343, 'IEU108', 41),
(344, '3611', 27),
(345, '1021', 23),
(346, 'mk0000', 32);

-- --------------------------------------------------------

--
-- Table structure for table `dosen`
--

DROP TABLE IF EXISTS `dosen`;
CREATE TABLE `dosen` (
  `iddosen` int(10) NOT NULL,
  `nidn` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `nama` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `tgllahir` date NOT NULL,
  `jabatanakademik` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `sertifikat` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `pendidikan` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `asalpt` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `bidang` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `dosen`
--

INSERT INTO `dosen` (`iddosen`, `nidn`, `nama`, `tgllahir`, `jabatanakademik`, `sertifikat`, `pendidikan`, `asalpt`, `bidang`, `created_at`, `updated_at`) VALUES
(6, '0121067004', 'dr.  Suheri Parulian Gultom, M.Kes', '1970-06-21', 'Lektor', '-', 'S2', 'usu', 'Administrasi Rumah Sakit', '2016-08-27 20:50:55', '2016-08-27 20:50:55'),
(7, '0106127903', 'Parmen, SKM, M.Kes', '1979-08-12', 'Proses', '-', 'S2', 'usu', 'Manajemen kesehatan bencana', '2016-08-27 20:54:02', '2016-08-27 20:54:02'),
(8, '0', 'Rani Robetty, M.Kom', '1968-06-16', 'Proses', '-', 'S2', 'Universitas Putra Indonesia', 'Sistem Informasi', '2016-08-27 20:57:52', '2016-08-27 20:57:52'),
(9, '0', 'Ary Syahputra Wiguna, M.Kom', '1989-10-17', 'Proses', '-', 'S2', 'Universitas Putra Indonesia', 'Sistem Informasi', '2016-08-27 21:05:34', '2016-08-27 21:05:34'),
(10, '0104088601', 'Ali sabela Hasibuan, S.Kep, Ns', '1986-08-04', 'Proses', '-', 'S1', 'Sari Mutiara', 'Manajemen Keperawatan', '2016-08-27 21:07:14', '2016-08-27 21:07:14'),
(11, '0125038601', 'Esraida Simanjuntak, SKM', '1986-03-25', 'Proses', '-', 'S1', 'Universitas Sumatera Utara', 'Gizi Kesehatan Masyarakat', '2016-08-27 21:08:37', '2016-08-27 21:08:37'),
(12, '0117078503', 'Zulhamdani Napitupulu, M.Kom', '1985-07-17', 'Assisten Ahli', '-', 'S2', 'Universitas Putra Indonesia', 'Teknologi Informasi', '2016-08-27 21:11:05', '2016-08-27 21:11:05'),
(13, '0', 'Erlindai, M.Kes', '1987-10-04', 'Proses', '-', 'S2', 'STIKes Deli Husada', 'Kesehatan Reproduksi', '2016-08-27 21:12:39', '2016-08-27 21:12:39'),
(14, '0', 'Siti Permata Sari Lubis, M.Kes', '1990-01-20', 'Proses', '-', 'S2', 'Universitas Sumatera Utara', 'Epidemiologi', '2016-08-27 21:14:12', '2016-08-27 21:14:12'),
(15, '0', 'Fitriyani Lubis, SST.RMIK', '1992-04-09', 'Proses', '-', 'DIV', 'Politeknik Piksi Ganesha', 'Manajemen Informatika', '2016-08-27 21:16:03', '2016-08-27 21:16:03'),
(16, '0', 'Marta Simanjuntak, SST RMIK', '1992-02-27', 'Proses', '-', 'DIV', 'Politeknik Piksi Ganesha', 'Manajemen Informatika', '2016-08-27 21:17:35', '2016-08-27 21:17:35'),
(17, '0', 'Rizca Annur Hadya, SST', '1991-06-14', 'Proses', '-', 'DIV', 'Universitas Sumatera Utara', 'Administrasi Rumah Sakit', '2016-08-27 21:19:16', '2016-08-27 21:19:16'),
(18, '0', 'Zulham Andi Ritonga,SKM', '1980-07-16', 'Proses', '-', 'S1', 'Universitas Sumatera Utara', 'Administrasi Rumah Sakit', '2016-08-27 21:20:36', '2016-08-27 21:20:36'),
(19, '0', 'Valentina, M.Kes', '1989-04-06', 'Proses', '-', 'S2', 'Universitas Sumatera Utara', 'Epidemiologi', '2016-08-27 21:22:08', '2016-08-27 21:22:08'),
(20, '0', 'Chitra Latiffani, M.Hum', '1986-04-08', 'Proses', '-', 'S2', 'Universitas Negeri Medan', 'Bahasa  Inggris', '2016-08-27 21:23:26', '2016-08-27 21:23:26'),
(21, '0', 'Parlaungan Hsb, S.Ag ', '1964-12-30', 'Proses', '-', 'S1', 'UISU', 'Agama Islam', '2016-08-27 21:31:34', '2016-08-27 21:31:34'),
(22, '0', 'dr. Yanda Ardanta, M.Kes', '1979-04-16', 'Proses', '-', 'S2', '-', 'KKPMT – I, KKPMT – V', '2016-08-27 21:35:26', '2016-08-27 21:35:26'),
(23, '0', 'Ris Arta Lina S.Sos, M.Pd', '1970-11-22', 'Proses', '-', 'S2', 'Universitas Darma Agung', 'Pendidikan Kewarganegaraan', '2016-08-27 21:37:18', '2016-08-27 21:37:18'),
(24, '0', 'Ratna Lamria, S.Pd', '1974-05-12', 'Proses', '-', 'S1', 'Perguruan Tinggi Teladan STKIP Medan', 'Bahasa Indonesia', '2016-08-27 21:39:20', '2016-08-27 21:39:20'),
(25, '0', 'Daulat L. Gaol S.Th', '1981-12-25', 'Proses', '-', 'S1', 'Sekolah Tinggi Agama Kristen Protestan Negeri Taru', 'Pendidikan Agama Kristen', '2016-08-27 21:40:47', '2016-08-27 21:40:47'),
(26, '0', 'Sri Agustina, SKM', '1995-01-01', 'Proses', '-', 'S1', '-', '-', '2016-08-27 21:44:52', '2016-08-27 21:44:52'),
(27, '0', 'Marganda, S.Si', '1995-01-01', 'Proses', '-', 'S1', '-', '-', '2016-08-27 21:46:10', '2016-08-27 21:46:10'),
(30, '0', 'Ns Dj. Saragi, M.Kes', '0000-00-00', 'Proses', '-', 'S2', '-', '-', '2016-08-27 21:52:53', '2016-08-27 21:52:53'),
(31, '0', 'dr. Yanda M.Kes', '0000-00-00', 'Proses', '-', 'S2', '-', '-', '2016-08-27 21:53:29', '2016-08-27 21:53:29'),
(32, '0', 'Welly SST.RMIK', '0000-00-00', 'Proses', '-', 'S1', '-', '-', '2016-08-27 21:54:00', '2016-08-27 21:54:00'),
(33, '0', 'Marta, SST.RMIK ', '0000-00-00', 'Proses', '-', 'S1', '-', '-', '2016-08-27 21:54:42', '2016-08-27 21:54:42'),
(34, '0', 'Daulat, S.Th, M.Th', '0000-00-00', 'Proses', '-', 'S2', '-', '-', '2016-08-27 21:55:20', '2016-08-27 21:55:20'),
(35, '0', 'Drs. Parlaungan Henny, MA', '0000-00-00', 'Proses', '-', 'S2', '-', '-', '2016-08-27 21:55:51', '2016-08-27 21:55:51'),
(36, '0', 'Leo Sardo, S.S', '1995-01-01', 'Proses', '-', 'S1', '-', '-', '2016-08-27 22:00:08', '2016-08-27 22:00:08'),
(37, '0', 'Ratna, S.Pd', '0000-00-00', 'Proses', '-', 'S1', '-', '-', '2016-08-27 22:00:46', '2016-08-27 22:00:46'),
(38, '0', 'Giyatno, Amd.PK S,Kom', '0000-00-00', 'Proses', '-', 'S1', '-', '-', '2016-08-27 22:01:29', '2016-08-27 22:01:29'),
(39, '0', 'Meriani', '0000-00-00', 'Proses', '-', 'S1', '-', '-', '2016-08-27 22:02:27', '2016-08-27 22:02:27'),
(40, '0', 'Yuda Mucti, M.Kes', '0000-00-00', 'Proses', '-', 'S2', '-', '-', '2016-08-27 22:03:35', '2016-08-27 22:03:35'),
(41, '0', 'Fitri', '0000-00-00', 'Proses', '-', 'S1', '-', '-', '2016-08-27 22:04:47', '2016-08-27 22:04:47'),
(42, '0', 'Noradina,M.Biomed', '0000-00-00', 'Proses', '-', 'S2', '-', '-', '2016-08-27 22:05:20', '2016-08-27 22:05:20'),
(43, '0', 'Yusuf Ramadhan, M.Kom', '1995-01-01', 'Proses', '-', 'S2', '-', '-', '2016-08-27 22:07:43', '2016-08-27 22:07:43'),
(44, '0', 'Roy Gun Edwin, M.Pd', '0000-00-00', 'Proses', '-', 'S2', '-', '-', '2016-08-27 22:08:15', '2016-08-27 22:08:15'),
(45, '0', 'S. Panggabean, SH', '0000-00-00', 'Proses', '-', 'S1', '-', '-', '2016-08-27 22:08:46', '2016-08-27 22:08:46'),
(47, '0', 'Zulham, SKM', '1995-01-01', 'Proses', '-', 'S1', '-', '-', '2016-08-27 22:19:43', '2016-08-27 22:19:43'),
(48, '0', 'Jhon Refelino, SE.Ak', '0000-00-00', 'Proses', '-', 'S1', '-', '-', '2016-08-27 22:20:44', '2016-08-27 22:20:44');

-- --------------------------------------------------------

--
-- Table structure for table `jabatan`
--

DROP TABLE IF EXISTS `jabatan`;
CREATE TABLE `jabatan` (
  `idjabatan` int(2) NOT NULL,
  `nama` varchar(50) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

DROP TABLE IF EXISTS `kelas`;
CREATE TABLE `kelas` (
  `idkelas` int(2) NOT NULL,
  `kodekelas` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `namakelas` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `iddosen` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kelasdosen`
--

DROP TABLE IF EXISTS `kelasdosen`;
CREATE TABLE `kelasdosen` (
  `idkelasdosen` int(10) NOT NULL,
  `iddosen` int(10) NOT NULL,
  `idkelas` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kelas_mahasiswa`
--

DROP TABLE IF EXISTS `kelas_mahasiswa`;
CREATE TABLE `kelas_mahasiswa` (
  `id` int(10) NOT NULL,
  `idkelas` int(2) NOT NULL,
  `nim` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `tahun_ajaran` year(4) DEFAULT NULL,
  `semester` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `khs`
--

DROP TABLE IF EXISTS `khs`;
CREATE TABLE `khs` (
  `idkhs` int(20) NOT NULL,
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
  `tanggal` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `krs`
--

DROP TABLE IF EXISTS `krs`;
CREATE TABLE `krs` (
  `idkrs` int(20) NOT NULL,
  `nim` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `kodemk` varchar(6) CHARACTER SET latin1 NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `keterangan` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

DROP TABLE IF EXISTS `mahasiswa`;
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
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `mahasiswa`
--

INSERT INTO `mahasiswa` (`nim`, `nama`, `tempatlahir`, `tanggallahir`, `agama`, `asalsekolah`, `namaortu`, `status`, `created_at`, `updated_at`) VALUES
('1313466001', 'Ade Nurmayanti', 'Sidomakmur', '1995-05-05', 'Islam', 'SMA Negeri 2 Rantau Utara, Kab. Labuhan Batu', 'Rahman', 1, '0000-00-00 00:00:00', '2016-08-19 23:58:36'),
('1313466002', 'Ahadeli Fatalis Daeli', 'Lolowa''u', '1995-05-28', 'Islam', ' SMA Negeri 1 Lolowa''u, Kabupaten Nias Selatan', 'Yaredi Daeli', 1, '0000-00-00 00:00:00', '2016-08-19 23:58:24'),
('1313466003', 'Aisyah Fita Sumi', 'TJ. Rejo', '1996-03-09', 'ISLAM', 'SMA Negeri 1 Percut Sei Tuan, Kabupaten Deli Serdang', 'Selamat', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466004', 'Assyifa Rahmi', 'Pematang Siantar', '1995-10-09', 'ISLAM', 'SMA Negeri 1 Bandar Kabupaten simalunggun', 'Seniman', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466005', 'Atika Sahroni Rangkuti', 'Lumut', '1995-03-31', 'ISLAM', 'SMAN 1 Sibabangun, Kab. Tapanuli Tengah', 'Darwis Rangkuti', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466006', 'Aulia Budi Pratama', 'Aceh Tengah', '1995-08-26', 'ISLAM', 'SMA 4 Takengon, Kabupaten Aceh Tengah', 'Mahdi', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466007', 'Chi chiliade Agustina', 'Bekasi', '1996-08-05', 'ISLAM', 'SMK Swasta Kampus Padangsidimpuan', 'Usuluddin', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466008', 'Desi Damayanti', 'Sei Rotan', '1994-12-17', 'ISLAM', 'SMK Negerin 1 Percut Sei Tuan Kabupaten Deli Serdang', 'Julianto', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466009', 'Dia Mardiana', 'Jepara', '1995-07-02', 'ISLAM', 'SMA Swasta Pencawan Medan', 'Rustaman', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466010', 'Dina Aulya', 'Bale Atu', '1994-11-22', 'ISLAM', 'Madrasah Aliyah Negeri 1 Takengon', 'Ruhaman Suhada', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466011', 'Ega Fitriyani Ritonga', 'Sigabu', '1993-11-08', 'ISLAM', 'Madrasah Aliyah Negeri Rantau Prapat', 'Tuani Ritonga', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466013', 'Gita Medina  Bangun', 'Batu Karang', '1995-10-12', 'KRISTEN', 'SMA Swasta Cahaya Kota Medan', 'Sidang Bangun', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466014', 'Haijah Manullang', 'Tanjung Pura', '1995-10-27', 'KRISTEN', 'SMK Negeri 1Tanjung Pura Kabupaten Langkat', 'Hotman Manullang', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466017', 'Iradat Suryani Zebua', 'Fodo', '1995-10-23', 'KRISTEN', 'SMA Negeri 3 Gunungsitoli, Kota Gunungsitoli', 'Amoliga Zebua', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466018', 'Iriani', 'Bandar Baru', '1995-08-26', 'KRISTEN', 'SMA Nrgeri 1 Sibolangit', 'peresen Sitepu', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466019', 'Ita jurliana Tanjung', 'Surodingin', '1995-07-17', 'ISLAM', 'SMK Swasta Ki Hajar Dewantara Kotapinang, Kab. Selatan', 'Madjuni Tanjung', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466020', 'Jhon Iskandar', 'Bandar Baru', '1995-04-20', 'KRISTEN', 'SMA Swasta Katolik Budi Murni 2 Medan, Kota Medan', 'Nuah Karo-Karo', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466021', 'Kenan Natan Imanuel Zebua', 'Siantar', '1996-04-04', 'KRISTEN', 'SMK Swasta Pemda Nias, Kota Gunung Sitoli', 'Yulius Zebua', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466022', 'Leo Fernando ', 'jakarta', '1995-11-17', 'KRISTEN', 'SMA Swasta Methodist 8 Medan', 'Polismen Sibarani', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466023', 'Madina An Nur Syahputri', 'Medan', '1995-07-15', 'ISLAM', 'SMA Swasta Kesatria Medan, Medan', 'Marwansyah', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466024', 'Marjeki', 'Seri Muda', '1994-05-27', 'ISLAM', 'SMA Negeri 1 Badar, Kabupaten Aceh Tenggara', 'Abdul Wahab', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466025', 'Mei Diantari Sitompul', 'Padangsidimpuan', '1995-05-19', 'ISLAM', 'SMK Negeri 1Padangsidimpuan', 'Polim Sitompul', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466026', 'Nazra Farhany', 'Medan', '1996-02-23', 'ISLAM', 'SMA Negeri 11 Medan,  Kota Medan', 'Puji Muliono', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466027', 'Nia Kurnia', 'TJ. Rejo', '1995-06-03', 'ISLAM', 'SMA Negeri 1 Percut Sei Tuan, Kabupaten Deli Serdang', 'Junaidi', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466028', 'Nova Susanti', 'Bies Penantanan', '1995-03-28', 'ISLAM', 'Madrasah Aliyah Negeri 1 Takengon', 'Suwito. WZ', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466029', 'Novi Yanti', 'Bandar Baru', '1995-11-20', 'KRISTEN', 'SMA Negeri 1 Sibolangit', 'Firman Barus', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466030', 'Nurhayati Siagian', 'Belawan', '1995-11-26', 'KRISTEN', 'SMA Negeri 20 Medan', 'Robin Siagian', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466031', 'Nur Hikmah Sitorus', 'Adian Kulim', '1995-05-02', 'ISLAM', ' SMA Negeri 1 Kuduh Selatan Kab labuhan Batu Utara', 'Hasnan Sitorus', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466032', 'Nurul Azara', 'Cot Keh', '1996-11-12', 'ISLAM', 'SMA Negeri 1 Peureulak, Kab. Aceh Timur', 'Rasyid', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466033', 'R. Indah Kesuma Sitorus', 'Siraituruk', '1995-07-22', 'KRISTEN', 'SMA Negeri 1 Lumbanjulu', '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466034', 'Riki Ardiansyah', 'Kampung Baru', '1994-05-25', 'ISLAM', 'SMA Negeri 1 Badar, Kabupaten Aceh Tenggara', 'Hamudin', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466035', 'Rini Maharani Hutasuhut', 'Hutasuhut', '1995-11-11', 'ISLAM', 'SMA Negeri 1 Sipirok, Tapanuli Selatan', 'Muhammdad Siddik Hutasuhut', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466036', 'Ruth Destri Eliana Ginting', 'Pandan', '1995-12-03', 'KRISTEN', 'SMA Negeri 2 kec. Siantar Utara', 'Serano Firdaus Ginting', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466037', 'Safdalimin', 'Jamat', '1994-10-20', 'ISLAM', 'SMA Negeri 2 Takengon, Kab  Aceh Tengah', 'Genap', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466039', 'TosiDani Yoga Meliala', 'Bengkulu', '1995-01-26', 'KRISTEN', 'SMA Swasta Immanuel Medan', 'Sari Nembah Metiala', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466040', 'Winsi Iman Ria Zebua', 'Hilina''a', '1995-09-03', 'KRISTEN', 'SMA Negeri 1 Gunungsitoli, Kota Gunungsitoli', 'Sochinafao Zebua', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1313466078', 'Eric Sopyan Sihombing', '', '0000-00-00', 'KRISTEN', '', '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

--
-- Triggers `mahasiswa`
--
DROP TRIGGER IF EXISTS `tggr_insdetailmhs`;
DELIMITER $$
CREATE TRIGGER `tggr_insdetailmhs` AFTER INSERT ON `mahasiswa` FOR EACH ROW BEGIN
		
        declare nim         varchar(10);
        declare vidangkatan int(3);
        declare vtahun      varchar(4);
        declare snama 		varchar(30);
        
        set vtahun 	= concat('20', substr(new.nim, 1,2));
        set snama 	=replace(new.nama,' ','');       
        select idangkatan into vidangkatan from angkatan where tahun=vtahun;
        
        insert into detailmahasiswa (nim, idangkatan) values(new.nim, vidangkatan);
        
        insert into user_mahasiswas (nama, nim, email, password, created_at, updated_at) 
							 values (new.nama, new.nim, concat(snama,'@gmail.com'), md5('12345'), now(), now());
        
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `matakuliah`
--

DROP TABLE IF EXISTS `matakuliah`;
CREATE TABLE `matakuliah` (
  `kodemk` varchar(10) CHARACTER SET latin1 NOT NULL,
  `matakuliah` varchar(100) CHARACTER SET latin1 NOT NULL,
  `bobot` double NOT NULL,
  `teori` double DEFAULT NULL,
  `praktek` double DEFAULT NULL,
  `klinik` double DEFAULT NULL,
  `kadep` varchar(100) CHARACTER SET latin1 NOT NULL,
  `semester` varchar(2) CHARACTER SET latin1 NOT NULL COMMENT 'I-IV',
  `bobotnilai` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `matakuliah`
--

INSERT INTO `matakuliah` (`kodemk`, `matakuliah`, `bobot`, `teori`, `praktek`, `klinik`, `kadep`, `semester`, `bobotnilai`) VALUES
('IEU108', 'Kewirausahaan', 3, 2, 1, 0, 'RizcaAnnurHadya, SST', '6', 3),
('PK404', 'Public Relation/ Customer Service', 2, 1, 1, 0, 'Siti, M.Kes', '6', 2),
('PKL I', 'PKL I', 3, 0, 0, 3, 'Ali Sabela, S.Kep, Ns', '2', 2),
('PKL II', 'PKL II', 3, 0, 0, 3, 'Ali Sabela, S.Kep, Ns', '3', 3),
('PKL III', 'PKL III', 3, 0, 0, 3, 'Ali Sabela, S.Kep, Ns', '4', 3),
('PKL IV', 'PKL IV', 3, 0, 0, 3, 'Ali Sabela, S.Kep, Ns', '5', 3),
('RMIK1011', 'Pendidikan Agama', 2, 2, 0, 0, 'Esraida, SKM (Kristen) Ali Sabela, S.Kep, Ns (Islam)', '1', 2),
('RMIK1021', 'Pendidikan Kewarganegaraan', 3, 3, 0, 0, 'Ris Artalina, S.Sos', '1', 3),
('RMIK1031', 'Bahasa Indonesia', 2, 1, 1, 0, 'RizcaA.Hadya, SST', '1', 2),
('RMIK1041', 'Bahasa Inggris', 2, 1, 1, 0, 'Leo Sardo, S.S', '1', 2),
('RMIK1052', 'BAHASA INGGRIS', 2, 1, 1, 0, 'Leo Sardo, S.S', '2', 2),
('RMIK2063', 'FARMOKOLOGI', 2, 2, 0, 0, 'Noradina,M.Biomed', '3', 2),
('RMIK2111', 'Manajemen Informasi Kesehatan I (MIK- I)', 2, 1, 1, 0, 'Zulham, SKM', '1', 2),
('RMIK2213', 'MUK-I', 3, 2, 1, 0, 'Parmen, M.Kes', '3', 3),
('RMIK2313', 'MMIK-I', 2, 1, 1, 0, 'Esraida, SKM', '3', 2),
('RMIK2411', 'Klasifikasi dan kodefikasi penyakit dan masalah terkait kesehatan serta tindakan (KKPMT)-I', 6, 3, 3, 0, 'Ali Sabela, S.Kep, Ns', '1', 6),
('RMIK2412', 'SIK-I', 3, 2, 1, 0, 'Erikson, SKM', '2', 3),
('RMIK2434', 'SIK-III', 2, 1, 1, 0, 'Zulham, SKM', '4', 2),
('RMIK2622', 'TIK-II (Aplikasi Lunak di Sarana Yankes', 2, 1, 1, 0, 'Zulham Dhani, M.Kom', '2', 2),
('RMIK3074', 'METODOLOGI PENELITIAN KESEHATAN', 3, 2, 1, 0, 'Erikson, SKM', '4', 3),
('RMIK3122', 'Manajemen infomasi Kesehatan (MIK II)', 4, 2, 1, 1, 'Zulham, SKM', '2', 4),
('RMIK3133', 'MIK-III', 3, 1, 1, 1, 'Erlinday, M.Kes', '3', 3),
('RMIK3155', 'MIK-V', 3, 1, 2, 1, 'Rizca Annur Hadya, SST', '5', 3),
('RMIK3324', 'MMIK-II', 2, 1, 1, 1, 'Marta, SST.RMIK', '4', 2),
('RMIK3335', 'MMIK-III', 2, 1, 1, 1, 'Zulham, SKM', '5', 2),
('RMIK3422', 'KKPMT II', 5, 2, 1, 2, 'Meriani ,M.Biomed', '2', 5),
('RMIK3433', 'KKPMT-III', 5, 2, 3, 1, 'Fitri Lubis, SST.RMIK', '3', 5),
('RMIK3444', 'KKPMT -IV', 6, 2, 2, 2, 'Noradina,M.Biomed', '4', 6),
('RMIK3455', 'KKPMT-V', 2, 1, 1, 1, 'dr. Yanda', '5', 2),
('RMIK3465', 'KKPMT-VI', 3, 1, 1, 1, 'Noradina, M.Biomed', '5', 3),
('RMIK3475', 'KKPMT-VII', 2, 1, 1, 0, 'RizcaA.Hadya, SST', '5', 2),
('RMIK3611', 'TIK-I (Aplikasi Komputer Dasar)', 3, 1, 2, 0, 'ZulhamDhani, M.Kom', '1', 3),
('RMIK3632', 'TIK-III (Algoritma dan Pemrograman)', 2, 1, 1, 0, 'ZulhamDhani, M.Kom', '2', 2),
('RMIK3643', 'TIK-IV(BASIS DATA)', 2, 1, 1, 0, 'ZulhamDhani, M.Kom', '3', 2),
('RMIK3654', 'TIK- V (Jaringan Komputer)', 2, 1, 1, 0, 'ZulhamDhani, M.Kom', '4', 2),
('RMIK3665', 'TIK-VI (Analisis dan PerencanaanSistemInformasiKesehatan)', 2, 1, 1, 0, 'ZulhamDhani, M.Kom', '5', 2),
('RMIK4224', 'MUK-II', 3, 1, 2, 1, 'Parmen, M.Kes', '4', 3),
('RMIK4225', 'MUK-III', 3, 2, 1, 0, 'RizcaAnnurHadya, SST', '5', 3),
('RMIK4423', 'SIK-II', 3, 2, 2, 1, 'Marta, SST.RMIK', '3', 3),
('RMIK5086', 'Karya Tulis Ilmiah', 4, 0, 0, 4, 'Esraida, SKM', '6', 4),
('RMIK5144', 'MIK-IV', 2, 1, 1, 0, 'Erlinday, M.Kes', '4', 2);

-- --------------------------------------------------------

--
-- Table structure for table `nilaihuruf`
--

DROP TABLE IF EXISTS `nilaihuruf`;
CREATE TABLE `nilaihuruf` (
  `idnilaihuruf` int(2) NOT NULL,
  `batasbawah` float(5,2) NOT NULL,
  `batasatas` float(5,2) NOT NULL,
  `nilai` varchar(2) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `nilaihuruf`
--

INSERT INTO `nilaihuruf` (`idnilaihuruf`, `batasbawah`, `batasatas`, `nilai`) VALUES
(1, 85.00, 100.00, 'A'),
(2, 75.00, 84.00, 'B'),
(3, 60.00, 74.00, 'C'),
(4, 50.00, 59.00, 'D'),
(5, 0.00, 49.00, 'E');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pendidikan`
--

DROP TABLE IF EXISTS `pendidikan`;
CREATE TABLE `pendidikan` (
  `idpendidikan` int(2) NOT NULL,
  `gelar` varchar(2) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `periode`
--

DROP TABLE IF EXISTS `periode`;
CREATE TABLE `periode` (
  `idperiode` int(11) NOT NULL,
  `sistem` varchar(100) CHARACTER SET latin1 NOT NULL,
  `tglawal` date NOT NULL,
  `tglakhir` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `periode`
--

INSERT INTO `periode` (`idperiode`, `sistem`, `tglawal`, `tglakhir`) VALUES
(4, 'KRS', '2016-09-01', '2016-08-10');

-- --------------------------------------------------------

--
-- Table structure for table `persenmk`
--

DROP TABLE IF EXISTS `persenmk`;
CREATE TABLE `persenmk` (
  `idpersen` int(2) NOT NULL,
  `absensi` float NOT NULL,
  `seminar` float NOT NULL,
  `tugas` float NOT NULL,
  `midsm` float NOT NULL,
  `nsem` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `persenmk`
--

INSERT INTO `persenmk` (`idpersen`, `absensi`, `seminar`, `tugas`, `midsm`, `nsem`) VALUES
(1, 10, 5, 20, 30, 35);

-- --------------------------------------------------------

--
-- Table structure for table `tahunajaran`
--

DROP TABLE IF EXISTS `tahunajaran`;
CREATE TABLE `tahunajaran` (
  `idtahunajaran` int(2) NOT NULL,
  `tahun` varchar(15) CHARACTER SET latin1 NOT NULL,
  `semester` varchar(6) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `admin` tinyint(1) DEFAULT '0',
  `imageuser` longblob
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`, `admin`, `imageuser`) VALUES
(1, 'basri', 'muhammadbasri444@gmail.com', '$2y$10$FJMZkrHVUlVammIA.hvgDeGf7OKxs1tHspY5/jS7WDI4mTjSpxLWS', 'Db3f5Sqcc6bFEUvrwCRcXHFkAwtaxjy2r0oJpR9h3RnTMrS0BUZby5w6G9Wj', '2016-07-28 18:30:58', '2016-09-05 07:44:40', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_dosens`
--

DROP TABLE IF EXISTS `user_dosens`;
CREATE TABLE `user_dosens` (
  `id` int(10) UNSIGNED NOT NULL,
  `iddosen` int(11) NOT NULL,
  `nama` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `imageuser` longblob
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_mahasiswas`
--

DROP TABLE IF EXISTS `user_mahasiswas`;
CREATE TABLE `user_mahasiswas` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nim` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `image_user` longblob
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_mahasiswas`
--

INSERT INTO `user_mahasiswas` (`id`, `nama`, `nim`, `email`, `password`, `remember_token`, `created_at`, `updated_at`, `image_user`) VALUES
(54, 'Ade Nurmayanti', '1313466001', 'AdeNurmayanti@gmail.com', '$2y$10$6GphOQXWk6UpnxsgeGzAX.2AOZcaJ6.Tvk189ELXe6lLBJXYQDWcy', 'Jh2aGcdPu5gXd5pfysc72E5qnA6hrlgLCUIOBex8ptiak0A8j8CLt1Nunh3p', '2016-08-19 04:40:49', '2016-09-05 07:47:08', NULL),
(55, 'Ahadeli Fatalis Daeli', '1313466002', 'AhadeliFatalisDaeli@gmail.com', '$2y$10$SYNkT5U0IU7a3CnbO0gHTOS9gY1pgv9owCf02f.j2qTXpU48wJxCm', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:45', NULL),
(56, 'Aisyah Fita Sumi', '1313466003', 'AisyahFitaSumi@gmail.com', '$2y$10$v3euqE1aenzfdV5oRGGerujo/CFB5i4lsNpC/9oNSRS7NS0PsKoZe', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:46', NULL),
(57, 'Assyifa Rahmi', '1313466004', 'AssyifaRahmi@gmail.com', '$2y$10$fcWatPhHzkf721S2Bjng6./7RivST00iWJ.oRAZyfQDV1pO4pK6ji', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:31', NULL),
(58, 'Atika Sahroni Rangkuti', '1313466005', 'AtikaSahroniRangkuti@gmail.com', '$2y$10$zrSIkOOxrbVCLiHis94hx.XM5GMD4n4bJmsKCk0LGFTYRsubnNb26', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:31', NULL),
(59, 'Aulia Budi Pratama', '1313466006', 'AuliaBudiPratama@gmail.com', '$2y$10$yScnybzAW4/a3BxBww4nRePGVk/yPCbQyjZOU7hQVZkPAe2fR1jV.', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:31', NULL),
(60, 'Chi chiliade Agustina', '1313466007', 'ChichiliadeAgustina@gmail.com', '$2y$10$hdqvZvaNM53wyuArjzT8JONf4xcxnt7RGppBpymvBLgNP/hCEAA9W', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:32', NULL),
(61, 'Desi Damayanti', '1313466008', 'DesiDamayanti@gmail.com', '$2y$10$KkW1UHjPRrpbQlcMcAJKveuu98lQ0KJs6pgZM7EgS18ZTF7wFCi2e', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:32', NULL),
(62, 'Dia Mardiana', '1313466009', 'DiaMardiana@gmail.com', '$2y$10$HFHrfXaI7RL3lKa5J2pOz.cn/8KbydVYXZ8w4lK3aErtYk4bTk7ZG', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:33', NULL),
(63, 'Dina Aulya', '1313466010', 'DinaAulya@gmail.com', '$2y$10$xZ7AiHlCfNlILayK1JNuku8yTZltuu620O0qtQlaJ29czkUOn2J8C', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:33', NULL),
(64, 'Ega Fitriyani Ritonga', '1313466011', 'EgaFitriyaniRitonga@gmail.com', '$2y$10$4usRRjOX.c0PdVpNQjUi3ehtoF12lrP1EiOu/gJvW6yiEIAMDObhq', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:33', NULL),
(65, 'Gita Medina  Bangun', '1313466013', 'GitaMedinaBangun@gmail.com', '$2y$10$c4HO5.1JlAtCWU3Yja3.a.z6rrjLTqj5A3dMXiHdvWq43336JmvY.', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:34', NULL),
(66, 'Haijah Manullang', '1313466014', 'HaijahManullang@gmail.com', '$2y$10$N9Kobfz6SsjGGkWTPlh7V.RJcE6q0qqBKWANKt00L1staKvqZqHLC', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:34', NULL),
(67, 'Iradat Suryani Zebua', '1313466017', 'IradatSuryaniZebua@gmail.com', '$2y$10$5jbeeJcA6O4BaoJ4t3srP.mdcPwpZ9qOXRdc4H2hhAMnEEETylvi.', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:34', NULL),
(68, 'Iriani', '1313466018', 'Iriani@gmail.com', '$2y$10$fR1Uyu.BLCrheDvRotqZmelxqYCl9Oa.blLa7.GKAISGbTzlHNYdS', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:35', NULL),
(69, 'Ita jurliana Tanjung', '1313466019', 'ItajurlianaTanjung@gmail.com', '$2y$10$kAnivbOwYefgBMd7ZpiPj.4QI461uwVjXyrp/uQjeCIVa.O5IyVlK', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:35', NULL),
(70, 'Jhon Iskandar', '1313466020', 'JhonIskandar@gmail.com', '$2y$10$HJVZjImzTictu.JsRvAXfuQV.CEXG7/kFeeAtFJ25e5aYq6hp3YGy', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:36', NULL),
(71, 'Kenan Natan Imanuel Zebua', '1313466021', 'KenanNatanImanuelZebua@gmail.com', '$2y$10$MnK6batCXtLyoqUwlUfO/OamY2u7tRUkAyhdN6cz0CU.cGdGmRazK', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:36', NULL),
(72, 'Leo Fernando ', '1313466022', 'LeoFernando@gmail.com', '$2y$10$gSaS9o3AaDIdx3.5fJftd.fYGA4wguTnRahhLpXcmNM8uol0IscwC', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:36', NULL),
(73, 'Madina An Nur Syahputri', '1313466023', 'MadinaAnNurSyahputri@gmail.com', '$2y$10$b6Tdq6XPJNM4IganHLd8N.okURgAYq7Sl3nK6PeGA0OIGS6nqmpnC', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:37', NULL),
(74, 'Marjeki', '1313466024', 'Marjeki@gmail.com', '$2y$10$bSIRL/DoY9S2RM2GNMo/2OJlxc1OEEYMCq//6PpBIQzOar0.4hSzK', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:37', NULL),
(75, 'Mei Diantari Sitompul', '1313466025', 'MeiDiantariSitompul@gmail.com', '$2y$10$A9d4lz7w/KsjJWTU4baN7e/home6c/.uTS67lJsV2YXu.74ciH2dC', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:38', NULL),
(76, 'Nazra Farhany', '1313466026', 'NazraFarhany@gmail.com', '$2y$10$z6YNhY4hgGpfQ1SvaT7M1.2ZDb8vAdmzKP.8fNPaENYbEC/Lbp9Gq', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:38', NULL),
(77, 'Nia Kurnia', '1313466027', 'NiaKurnia@gmail.com', '$2y$10$sSih0tdAIST4eCmw.pLlA.RhugLznVzPWVMAPd68DAKr3dc4Vf.tS', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:38', NULL),
(78, 'Nova Susanti', '1313466028', 'NovaSusanti@gmail.com', '$2y$10$jIf5obk6TCeXoEQRQudL2OH2wd0rS45ujYynIcMD2ra.f.mkqB78u', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:39', NULL),
(79, 'Novi Yanti', '1313466029', 'NoviYanti@gmail.com', '$2y$10$iQB9yAMYtfLK0BMxZ9lp0u22drT5RL/Yr6jlok9am1mDO8f0qooSq', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:39', NULL),
(80, 'Nurhayati Siagian', '1313466030', 'NurhayatiSiagian@gmail.com', '$2y$10$HoEeQsKTB0FDcsU3IBZUMeea/ILeix41ihVN9q54L77xwu10Xpufi', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:40', NULL),
(81, 'Nur Hikmah Sitorus', '1313466031', 'NurHikmahSitorus@gmail.com', '$2y$10$zNCceFjqvnGq1pdrkgEUW.NFCbwP0defwn.qw2mH.5snpwwIhS/D6', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:40', NULL),
(82, 'Nurul Azara', '1313466032', 'NurulAzara@gmail.com', '$2y$10$p/eD4tRt2h3peJrtFSg74OI.Bzv9jti58umCe6FMaFTnfGwWM0PWe', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:41', NULL),
(83, 'R. Indah Kesuma Sitorus', '1313466033', 'R.IndahKesumaSitorus@gmail.com', '$2y$10$l2KKVjEv0fHaRZjUy.zz/uIBOdFs..yjJ5Zlup0.K1oNZ7xGE087S', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:41', NULL),
(84, 'Riki Ardiansyah', '1313466034', 'RikiArdiansyah@gmail.com', '$2y$10$4x/0e1hEo4e6PCi4x592rejRkPAYCFHIRP.TkD75IQ7dxt1XEbCZW', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:42', NULL),
(85, 'Rini Maharani Hutasuhut', '1313466035', 'RiniMaharaniHutasuhut@gmail.com', '$2y$10$5Itm361AWsVW5ig/BM2N1u46V85xUl5Cws3DajXnkkGH02pezOyxe', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:42', NULL),
(86, 'Ruth Destri Eliana Ginting', '1313466036', 'RuthDestriElianaGinting@gmail.com', '$2y$10$QC2csRYslnOqedFwzZkkAeVX/AISNUJpguV3ca78gQ25dYwggnwcu', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:42', NULL),
(87, 'Safdalimin', '1313466037', 'Safdalimin@gmail.com', '$2y$10$5MzyFU1E7CDZcYrauptcM.7PGs5UCtiDdnwjyfy4kCQgiQTiUvsiG', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:49', '2016-08-20 00:13:43', NULL),
(88, 'TosiDani Yoga Meliala', '1313466039', 'TosiDaniYogaMeliala@gmail.com', '$2y$10$7K82YXvsAFwzL/SQUV1vL.n/J7WGNbvEv6n7ZHQoEuyshKStFcWXq', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:50', '2016-08-20 00:13:43', NULL),
(89, 'Winsi Iman Ria Zebua', '1313466040', 'WinsiImanRiaZebua@gmail.com', '$2y$10$jSGeqmTN1YpgcETPFsaI6edkOF79ZWYlrFWt5EmwkSKj9svPfko7e', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:50', '2016-08-20 00:13:44', NULL),
(90, 'Eric Sopyan Sihombing', '1313466078', 'EricSopyanSihombing@gmail.com', '$2y$10$MZ2dsl5Sl1SLtSEQPcNxoe.dA3abCxi/wI0c6ZfnYjMnU4AV8J3Wm', 'XmfrZcc6yGKZIbTTjlFMMpkvt8iPlaryVT00QjdL', '2016-08-19 04:40:50', '2016-08-20 00:13:44', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

--
-- Indexes for table `angkatan`
--
ALTER TABLE `angkatan`
  ADD PRIMARY KEY (`idangkatan`);

--
-- Indexes for table `bidang`
--
ALTER TABLE `bidang`
  ADD PRIMARY KEY (`idbidang`);

--
-- Indexes for table `bidangkeahlian`
--
ALTER TABLE `bidangkeahlian`
  ADD PRIMARY KEY (`idbidangkeahlian`);

--
-- Indexes for table `detailmahasiswa`
--
ALTER TABLE `detailmahasiswa`
  ADD PRIMARY KEY (`nim`),
  ADD KEY `fk_detailmhs_idangkatan_idx` (`idangkatan`);

--
-- Indexes for table `detailmatakuliah`
--
ALTER TABLE `detailmatakuliah`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`iddosen`);

--
-- Indexes for table `jabatan`
--
ALTER TABLE `jabatan`
  ADD PRIMARY KEY (`idjabatan`);

--
-- Indexes for table `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`idkelas`),
  ADD KEY `fk_kelas_iddosen_idx` (`iddosen`);

--
-- Indexes for table `kelasdosen`
--
ALTER TABLE `kelasdosen`
  ADD PRIMARY KEY (`idkelasdosen`),
  ADD KEY `fk_kelasdosen_iddosen_idx` (`iddosen`),
  ADD KEY `fk_kelasdosen_idkelas_idx` (`idkelas`);

--
-- Indexes for table `kelas_mahasiswa`
--
ALTER TABLE `kelas_mahasiswa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_kelasmhs_idkelas_idx` (`idkelas`);

--
-- Indexes for table `khs`
--
ALTER TABLE `khs`
  ADD PRIMARY KEY (`idkhs`),
  ADD KEY `fk_khs_kodemk_idx` (`kodemk`),
  ADD KEY `fk_khs_nim_idx` (`nim`),
  ADD KEY `fk_khs_iddosen_idx` (`iddosen`),
  ADD KEY `fk_khs_idkelas_idx` (`idkelas`);

--
-- Indexes for table `krs`
--
ALTER TABLE `krs`
  ADD PRIMARY KEY (`idkrs`),
  ADD KEY `fk_krs_kodemk_idx` (`kodemk`),
  ADD KEY `fk_krs_nim_idx` (`nim`);

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`nim`);

--
-- Indexes for table `matakuliah`
--
ALTER TABLE `matakuliah`
  ADD PRIMARY KEY (`kodemk`);

--
-- Indexes for table `nilaihuruf`
--
ALTER TABLE `nilaihuruf`
  ADD PRIMARY KEY (`idnilaihuruf`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Indexes for table `pendidikan`
--
ALTER TABLE `pendidikan`
  ADD PRIMARY KEY (`idpendidikan`);

--
-- Indexes for table `periode`
--
ALTER TABLE `periode`
  ADD PRIMARY KEY (`idperiode`);

--
-- Indexes for table `persenmk`
--
ALTER TABLE `persenmk`
  ADD PRIMARY KEY (`idpersen`);

--
-- Indexes for table `tahunajaran`
--
ALTER TABLE `tahunajaran`
  ADD PRIMARY KEY (`idtahunajaran`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_dosens`
--
ALTER TABLE `user_dosens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_dosen_nim_unique` (`iddosen`),
  ADD UNIQUE KEY `users_dosen_email_unique` (`email`);

--
-- Indexes for table `user_mahasiswas`
--
ALTER TABLE `user_mahasiswas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usermahasiswas_nim_unique` (`nim`),
  ADD UNIQUE KEY `usermahasiswas_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `angkatan`
--
ALTER TABLE `angkatan`
  MODIFY `idangkatan` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `bidang`
--
ALTER TABLE `bidang`
  MODIFY `idbidang` int(2) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `detailmatakuliah`
--
ALTER TABLE `detailmatakuliah`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=347;
--
-- AUTO_INCREMENT for table `dosen`
--
ALTER TABLE `dosen`
  MODIFY `iddosen` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
--
-- AUTO_INCREMENT for table `jabatan`
--
ALTER TABLE `jabatan`
  MODIFY `idjabatan` int(2) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `kelas`
--
ALTER TABLE `kelas`
  MODIFY `idkelas` int(2) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `kelasdosen`
--
ALTER TABLE `kelasdosen`
  MODIFY `idkelasdosen` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `kelas_mahasiswa`
--
ALTER TABLE `kelas_mahasiswa`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `khs`
--
ALTER TABLE `khs`
  MODIFY `idkhs` int(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `krs`
--
ALTER TABLE `krs`
  MODIFY `idkrs` int(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nilaihuruf`
--
ALTER TABLE `nilaihuruf`
  MODIFY `idnilaihuruf` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `periode`
--
ALTER TABLE `periode`
  MODIFY `idperiode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `persenmk`
--
ALTER TABLE `persenmk`
  MODIFY `idpersen` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `user_dosens`
--
ALTER TABLE `user_dosens`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_mahasiswas`
--
ALTER TABLE `user_mahasiswas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `detailmahasiswa`
--
ALTER TABLE `detailmahasiswa`
  ADD CONSTRAINT `fk_detailmhs_idangkatan` FOREIGN KEY (`idangkatan`) REFERENCES `angkatan` (`idangkatan`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_detailmhs_nim` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kelas`
--
ALTER TABLE `kelas`
  ADD CONSTRAINT `fk_kelas_iddosen` FOREIGN KEY (`iddosen`) REFERENCES `dosen` (`iddosen`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kelasdosen`
--
ALTER TABLE `kelasdosen`
  ADD CONSTRAINT `fk_kelasdosen_iddosen` FOREIGN KEY (`iddosen`) REFERENCES `dosen` (`iddosen`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_kelasdosen_idkelas` FOREIGN KEY (`idkelas`) REFERENCES `kelas` (`idkelas`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `kelas_mahasiswa`
--
ALTER TABLE `kelas_mahasiswa`
  ADD CONSTRAINT `fk_kelasmhs_idkelas` FOREIGN KEY (`idkelas`) REFERENCES `kelas` (`idkelas`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `khs`
--
ALTER TABLE `khs`
  ADD CONSTRAINT `fk_khs_iddosen` FOREIGN KEY (`iddosen`) REFERENCES `dosen` (`iddosen`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_khs_idkelas` FOREIGN KEY (`idkelas`) REFERENCES `kelas` (`idkelas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_khs_kodemk` FOREIGN KEY (`kodemk`) REFERENCES `matakuliah` (`kodemk`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_khs_nim` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `krs`
--
ALTER TABLE `krs`
  ADD CONSTRAINT `fk_krs_kodemk` FOREIGN KEY (`kodemk`) REFERENCES `matakuliah` (`kodemk`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_krs_nim` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`) ON DELETE NO ACTION ON UPDATE NO ACTION;


--
-- Metadata
--
USE `phpmyadmin`;

--
-- Metadata for admins
--

--
-- Metadata for angkatan
--

--
-- Metadata for bidang
--

--
-- Metadata for bidangkeahlian
--

--
-- Metadata for detailmahasiswa
--

--
-- Metadata for detailmatakuliah
--

--
-- Metadata for dosen
--

--
-- Metadata for jabatan
--

--
-- Metadata for kelas
--

--
-- Metadata for kelasdosen
--

--
-- Metadata for kelas_mahasiswa
--

--
-- Metadata for khs
--

--
-- Metadata for krs
--

--
-- Metadata for mahasiswa
--

--
-- Metadata for matakuliah
--

--
-- Metadata for nilaihuruf
--

--
-- Metadata for password_resets
--

--
-- Metadata for pendidikan
--

--
-- Metadata for periode
--

--
-- Metadata for persenmk
--

--
-- Metadata for tahunajaran
--

--
-- Metadata for users
--

--
-- Metadata for user_dosens
--

--
-- Metadata for user_mahasiswas
--

--
-- Metadata for apikes
--
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
