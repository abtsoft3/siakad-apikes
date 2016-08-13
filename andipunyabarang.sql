-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 13, 2016 at 05:23 PM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 5.5.37

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `apikes`
--

DELIMITER $$
--
-- Functions
--
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

CREATE DEFINER=`root`@`localhost` FUNCTION `splitstr` (`x` VARCHAR(255), `delim` VARCHAR(12), `pos` INT) RETURNS VARCHAR(255) CHARSET latin1 RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
CHAR_LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
delim, '')$$

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

CREATE TABLE `bidang` (
  `idbidang` int(2) NOT NULL,
  `nama` varchar(100) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bidangkeahlian`
--

CREATE TABLE `bidangkeahlian` (
  `idbidangkeahlian` int(2) NOT NULL,
  `nama` varchar(50) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `detailmahasiswa`
--

CREATE TABLE `detailmahasiswa` (
  `nim` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `idangkatan` int(3) NOT NULL,
  `statuskrs` int(1) DEFAULT NULL COMMENT '1 = boleh\nnull = tidak boleh'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `detailmahasiswa`
--

INSERT INTO `detailmahasiswa` (`nim`, `idangkatan`, `statuskrs`) VALUES
('1113464002', 1, NULL),
('1113464003', 1, NULL),
('1113464004', 1, NULL),
('1113464005', 1, NULL),
('1113464006', 1, NULL),
('1113464007', 1, NULL),
('1113464008', 1, NULL),
('1113464009', 1, NULL),
('1113464011', 1, NULL),
('1113464012', 1, NULL),
('1113464013', 1, NULL),
('1113464014', 1, NULL),
('1113464015', 1, NULL),
('1113464016', 1, NULL),
('1113464017', 1, NULL),
('1113464018', 1, NULL),
('1113464019', 1, NULL),
('1113464020', 1, NULL),
('1113464021', 1, NULL),
('1113464022', 1, NULL),
('1113464023', 1, NULL),
('1113464024', 1, NULL),
('1113464025', 1, NULL),
('1113464026', 1, NULL),
('1113464027', 1, NULL),
('1113464028', 1, NULL),
('1113464029', 1, NULL),
('1113464030', 1, NULL),
('1113464031', 1, NULL),
('1113464032', 1, NULL),
('1113464033', 1, NULL),
('1113464034', 1, NULL),
('1113464035', 1, NULL),
('1113464036', 1, NULL),
('1113464037', 1, NULL),
('1113464038', 1, NULL),
('1113464039', 1, NULL),
('1113464040', 1, NULL),
('1113464041', 1, NULL),
('1113464042', 1, NULL),
('1113464044', 1, NULL),
('1113464045', 1, NULL),
('1113464046', 1, NULL),
('1113464047', 1, NULL),
('1113464048', 1, NULL),
('1113464049', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `detailmatakuliah`
--

CREATE TABLE `detailmatakuliah` (
  `id` int(11) NOT NULL,
  `kodemk` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `iddosen` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `detailmatakuliah`
--

INSERT INTO `detailmatakuliah` (`id`, `kodemk`, `iddosen`) VALUES
(1, 'PK109', 4),
(3, 'PK109', 5),
(6, 'PK109', 6),
(7, 'PK102', 4),
(9, 'PK105', 4),
(10, 'PK105', 5),
(11, 'PK102', 6);

-- --------------------------------------------------------

--
-- Table structure for table `dosen`
--

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
(4, '0106127903', 'Parmen, SKM, M.Kes', '2016-08-10', 'Assisten Ahli', '-', 'S1', 'Universitas Sumatera Utara', 'Manajemen kesehatan bencana', '2016-08-10 03:37:34', '2016-08-10 06:06:35'),
(5, '0104088601', 'Ali sabela Hasibuan, S.Kep, Ns', '2016-08-11', 'Lektor', '', 'S1', 'Sari Mutiara', 'Manajemen Keperawatan', '2016-08-11 08:44:29', '2016-08-11 08:44:29');

-- --------------------------------------------------------

--
-- Table structure for table `jabatan`
--

CREATE TABLE `jabatan` (
  `idjabatan` int(2) NOT NULL,
  `nama` varchar(50) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `idkelas` int(2) NOT NULL,
  `kodekelas` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `namakelas` varchar(30) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `kelas`
--

INSERT INTO `kelas` (`idkelas`, `kodekelas`, `namakelas`) VALUES
(1, 'KL01', 'Kelas A'),
(3, 'KL02', 'Kelas B');

-- --------------------------------------------------------

--
-- Table structure for table `kelasdosen`
--

CREATE TABLE `kelasdosen` (
  `idkelasdosen` int(10) NOT NULL,
  `iddosen` int(10) NOT NULL,
  `idkelas` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `kelasdosen`
--

INSERT INTO `kelasdosen` (`idkelasdosen`, `iddosen`, `idkelas`) VALUES
(14, 4, 1),
(15, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `kelas_mahasiswa`
--

CREATE TABLE `kelas_mahasiswa` (
  `id` int(10) NOT NULL,
  `idkelas` int(2) NOT NULL,
  `nim` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `tahun_ajaran` year(4) DEFAULT NULL,
  `semester` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `kelas_mahasiswa`
--

INSERT INTO `kelas_mahasiswa` (`id`, `idkelas`, `nim`, `tahun_ajaran`, `semester`) VALUES
(14, 1, '1100000001', 2016, 1),
(15, 1, '1113464002', 2016, 1),
(16, 3, '1113464003', 2016, 1);

-- --------------------------------------------------------

--
-- Table structure for table `khs`
--

CREATE TABLE `khs` (
  `idkhs` int(20) NOT NULL,
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
  `tanggal` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `krs`
--

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
('1113464002', 'APRIANA BR SEBAYANG', 'MEDAN', '1992-04-17', '-', 'SMA SWASTA KATOLIK BUDI MURNI 2', 'DIRGA BUANA SEBAYANG', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464003', 'ARIE RANTO PUTRA', 'JAYANTRI', '1993-04-16', '-', 'SMK KARYA AGUNG ', 'JAMIKSAN', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464004', 'ARTIKA NAOMI REMINISCERE FELICIA', 'MEDAN', '1993-10-28', '-', 'SMA SWASTA HARAPAN MANDIRI MEDAN', 'IR DARIAMAN SINAGA', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464005', 'AVEN ASWADI PASARIBU', 'PADANGMANDAILING', '1992-11-06', '-', 'SMA NEGERI 1 ARSE', 'ZULKIFLI PASARIBU', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464006', 'AYUB', 'KOTA PARI', '1993-09-05', '-', 'SMA NEGERI 1 PERBAUNGAN ', 'SAMAN HADI', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464007', 'AZIZAH REZEKIAH HASIBUAN', 'MEDAN', '1992-12-02', '-', 'SMA NEGERI 1 HAMPARAN PERAK', 'DRS ALI MUKTI HASIBUAN', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464008', 'DAMAN TAKWA RAMBE', 'GAROGA', '1993-08-17', '-', 'SMA NEGERI 2 PADANGBOLAH', 'SUTAN PORANG', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464009', 'DEFRIDA ', 'MEDAN', '1992-11-06', '-', 'SMA SWASTA PRIMBANA MEDAN', 'BUCHARI FARID', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464011', 'DESMA KRISTINA SITUMORANG', 'BUKIT SELAMAT', '1992-12-12', '-', 'SMA NEGERI 1 BESITANG ', 'J SITUMORANG', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464012', 'DEVI PRANITA ', 'STABAT', '1991-12-28', '-', 'SMA NEGERI 1 BANDAR KHALIPAH', 'SUPRIONO', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464013', 'DINI ERLINA PRAMITHA MATONDANG', 'PADANG SIDIMPUAN', '1993-06-18', '-', 'SMA SWASTA KESUMA INDAH PADANGSIDIMPUAN', 'DAULAT MATONDANG', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464014', 'DONI SYAPUTRA', 'TEBING TINGGI', '1993-12-18', '-', 'SMK NEGERI 1 TEBING TINGGI', 'SAPIRUDDIN', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464015', 'DWIKA WULANDARI MARBUN ', 'CINTA RAKYAT', '1993-01-23', '-', 'MADRASAH ALIYAH AL-WASHLIYAH 22 TEMBUNG', 'ALI NAFYAH MARBUN', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464016', 'EKA OKTAFIANITA ', 'TEBING TINGGI', '1993-10-26', '-', 'SMK NEGERI 2 TEBING TINGGI', 'SOFIAN', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464017', 'ERWIN EFENDI SIANTURI', 'KALANGBAR', '1992-08-01', '-', 'SMA NEGERI 1 SIDIKALANG', 'ALDER SIANTURI', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464018', 'ESRA BR GINTING', 'AJI NEMBAH', '1992-04-13', '-', 'SMK SWASTA PHARMACA MEDAN', 'SODER GINTING', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464019', 'GERTI MAIFA SARAH', 'ACEH', '1991-05-28', '-', 'SMA NEGERI 18 MEDAN', 'TAMBAH HASIBUAN', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464020', 'HERI ASWINARDI NASUTION', 'MEDAN', '1993-02-27', '-', 'SMA NEGERI 3 PADANGSIDIMPUAN', 'HIFNI NASUTION', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464021', 'ICHSAN SYAMTARA SITEPU', 'BINJAI', '1993-07-10', '-', 'SMA SWASTA TUNAS PELITA BINJAI', 'OMAR BATARA SITEPU', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464022', 'IRMAYANTI JULITA SIMANIHURUK ', 'MEDAN', '1993-07-13', '-', 'SMA SWASTA ST YOSEPH MEDAN', 'OLOAN SIMANIHURUK', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464023', 'IRVANNY', 'MEDAN', '1993-07-05', '-', 'SMA NEGERI 6 MEDAN', 'BAMBANG IRIANO', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464024', 'KHAIRINA ', 'BINJAI', '1993-05-04', '-', 'SMA NEGERI 5 BINJAI ', 'IRIANTO', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464025', 'KHAIRUN NISA ', 'PANTAI CERMIN KIRI', '1993-03-26', '-', 'SMA NEGERI 1 PANTAI CERMIN', 'HASRAT', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464026', 'LISNAWATI LIMBONG', 'LIMBONG', '1993-02-28', '-', 'SMA NEGERI 1 SIANJUR MULAMULA', 'PINTAR LIMBONG', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464027', 'LOLITA FIERDA GUSTIARA SILALAHI', 'RANTAU PRAPAT', '1993-08-10', '-', 'SMA NEGERI 1 RANTAU UTARA ', 'J SILALAHI', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464028', 'LORINA CLAUDIA BR SEMBIRING ', 'BERASTAGI', '1993-01-24', '-', 'SMA SWASTA ADVENT 1 KOTA MEDAN', 'BERSAMA SEMBIRING', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464029', 'M HANAFI', 'PASAR LARU', '1991-10-10', '-', 'SMA NEGERI 1 TAMBANGAN MANDAILING NATAL', 'HOLLAD LUBIS', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464030', 'MARTA ULINA PURBA', 'BAH SIDUA - DUA', '1993-02-23', '-', 'SMA NEGERI 1 SERBAJADI SERDANG BEDAGAI', 'NAJIM PURBA', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464031', 'MELINA TIODORA SITANGGANG', 'MEDAN', '1993-02-16', '-', 'SMA SWASTA KATOLIK BUDI MURNI 3 MEDAN', 'N SITANGGANG', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464032', 'MITA YUSWITA SARI ', 'MEDAN', '1991-08-14', '-', 'SMK SWASTA AMIR HAMZAH MEDAN', 'M YUSUF', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464033', 'MORGAN HARRY PARNINGOTAN M', 'MEDAN', '1993-11-10', '-', 'SMA SWASTA ST YOSEPH MEDAN', 'FREDDY PARNINGOTAN MANULLANG', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464034', 'MUHAMMAD LUTHFI SISKANDAR ', 'MEDAN', '1993-11-21', '-', 'SMA NEGERI 15 MEDAN', 'SISWO PURNOMO', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464035', 'NAZLI HASWANI SARAGIH ', 'BERAMPU', '1992-03-08', '-', 'SMA NEGERI 1 SIDIKALANG ', 'KAMLOR SARAGAIH', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464036', 'NELLY HERIYANTI PURBA', 'TORNAULI', '1993-09-13', '-', 'SMA SWASTA SANTA MARIA TARUTUNG', 'SIMON PURBA', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464037', 'NOVA FRASETIA NINGSIH SARAGIH', 'SIMP RAJANI HUTA', '1991-11-08', '-', 'SMA SWASTA SANTA MARIA MEDAN', 'PARULIAN SARAGIH', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464038', 'PEDDAH IMOY CIBRO', 'SIDIKALANG', '1993-05-11', '-', 'SMA NEGERI 1 SIDIKALANG', 'PITTOR HADOMUAN CIBRO', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464039', 'PIARDIARON LAOLI', 'EHOSAKHOZI', '1991-10-29', '-', 'SMK SWASTA KRISTEN HARAPAN SEJAHTERA GUNUNG SITOLI I DANOI', 'AMINUDIN LAOLI', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464040', 'PUTRI FACHRUNNISA ', 'TANJUNG PURA', '1994-03-02', '-', 'SMA NEGERI 1 HINAI KABUPATEN LANGKAT', 'ANDI SYAHPUTRA', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464041', 'PUTRI HUTAPEA', 'MEDAN', '1994-01-19', '-', 'SMA SWASTA TELADAN MEDAN', 'J HUTAPEA', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464042', 'RAHMAT HATIMBULAN HARAHAP', 'KAMPUNG SETIA', '1992-06-23', '-', 'SMA NEGERI 4 PADANGSIDIMPUAN', 'ANWAR HARAHAP', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464044', 'RICKY SUDARYANTO', 'SUKA MAKMUR', '1992-01-21', '-', 'SMK TARUNA PEKANBARU', 'SUPARMIN', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464045', 'SITI CHAIRANI', 'TANJUNGBALAI', '1993-06-02', '-', 'SMK NEGERI 3 TANJUNGBALAI', 'CHAIRUNSYAH MANURUNG', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464046', 'SUNDARI PRICILIA HASIBUAN', 'MEDAN', '1993-06-19', '-', 'SMA SWASTA TELADAN CINTA DAMAI MEDAN', 'INDRA SAKTI HASIBUAN', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464047', 'THERESIA HUTASOIT', 'MEDAN', '1993-10-20', '-', 'SMK NEGERI 3 PEMATANGSIANTAR', 'PARADA HUTASOIT, Bsc', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464048', 'YESSI MAGDALENA', 'SEI SUKA DERAS', '1990-07-18', '-', 'SMA SWASTA KATOLIK CINTA KASIH TEBING TINGGI', 'JONAR SITANGGANG', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
('1113464049', 'ZULFIRMAN HARAHAP', 'MESJID LAMA', '1993-07-31', '-', 'SMA NEGERI 1 TALAWI BATU BARA', 'GHOZALI  HARAHAP', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

--
-- Triggers `mahasiswa`
--
DELIMITER $$
CREATE TRIGGER `tggr_insdetailmhs` AFTER INSERT ON `mahasiswa` FOR EACH ROW BEGIN
		
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
        
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `matakuliah`
--

CREATE TABLE `matakuliah` (
  `kodemk` varchar(6) CHARACTER SET latin1 NOT NULL,
  `matakuliah` varchar(100) CHARACTER SET latin1 NOT NULL,
  `bobot` int(1) NOT NULL,
  `teori` int(1) DEFAULT NULL,
  `praktek` int(1) DEFAULT NULL,
  `klinik` int(1) NOT NULL,
  `kadep` varchar(100) CHARACTER SET latin1 NOT NULL,
  `semester` varchar(2) CHARACTER SET latin1 NOT NULL COMMENT 'I-IV',
  `bobotnilai` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `matakuliah`
--

INSERT INTO `matakuliah` (`kodemk`, `matakuliah`, `bobot`, `teori`, `praktek`, `klinik`, `kadep`, `semester`, `bobotnilai`) VALUES
('ko12', 'fisika', 2, 1, 1, 0, 'testin', '1', 12),
('P001', 'Bahasawa1', 2, 1, 1, 0, 'Andi', '2', 1),
('PK101', 'Pendidikan Agama', 2, 2, 0, 0, 'Kristen:Esraida, SKM, Islam: Ali Sabela,S.Kep.Ns', '1', 0),
('PK102', 'Pendidikan Pancasila', 2, 2, 0, 0, 'Erlinday, M.Kes', '1', 0),
('PK105', 'Bahasa Inggris I', 2, 1, 1, 0, 'Parmen, SKM, M.Kes', '1', 0),
('PK106', 'Bahasa Jawa', 2, 2, 0, 0, 'Leo Sardo, S.S', '2', 0),
('PK204', 'Biomedik IV ( Patologi )', 2, 1, 1, 0, 'Erikson, SKM', '2', 0),
('RK01', 'biologi', 2, 1, 1, 0, 'testing', '2', 12);

-- --------------------------------------------------------

--
-- Table structure for table `nilaihuruf`
--

CREATE TABLE `nilaihuruf` (
  `idnilaihuruf` int(2) NOT NULL,
  `batasbawah` double NOT NULL,
  `batasatas` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pendidikan`
--

CREATE TABLE `pendidikan` (
  `idpendidikan` int(2) NOT NULL,
  `gelar` varchar(2) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `periode`
--

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
(3, 'KHS', '2016-08-01', '2016-08-03'),
(4, 'KRS', '2016-08-08', '2016-09-10');

-- --------------------------------------------------------

--
-- Table structure for table `persenmk`
--

CREATE TABLE `persenmk` (
  `idpersen` int(2) NOT NULL,
  `absensi` double NOT NULL,
  `seminar` double NOT NULL,
  `tugas` double NOT NULL,
  `midsm` double NOT NULL,
  `nsem` double NOT NULL,
  `akhir` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tahunajaran`
--

CREATE TABLE `tahunajaran` (
  `idtahunajaran` int(2) NOT NULL,
  `tahun` varchar(15) CHARACTER SET latin1 NOT NULL,
  `semester` varchar(6) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `admin` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`, `admin`) VALUES
(1, 'basri', 'muhammadbasri444@gmail.com', '$2y$10$FJMZkrHVUlVammIA.hvgDeGf7OKxs1tHspY5/jS7WDI4mTjSpxLWS', 'R5P0IqhgOv1db7gX1WtLnK83XtmKe0ShQylN0j81fNSNC8eNK9s9L7nnZZue', '2016-07-29 01:30:58', '2016-08-13 08:22:16', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_dosens`
--

CREATE TABLE `user_dosens` (
  `id` int(10) UNSIGNED NOT NULL,
  `nidn` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `imageuser` longblob
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_dosens`
--

INSERT INTO `user_dosens` (`id`, `nidn`, `nama`, `email`, `password`, `remember_token`, `created_at`, `updated_at`, `imageuser`) VALUES
(3, '0106127903', 'Parmen, SKM, M.Kes', '', '$2y$10$4c.O8r60yvXkkdVHPFlKheJZV2gfddrUf02V9S.XkXHN4ADMRMje2', NULL, '2016-08-11 03:17:14', '2016-08-11 03:17:14', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_mahasiswas`
--

CREATE TABLE `user_mahasiswas` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nim` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_mahasiswas`
--

INSERT INTO `user_mahasiswas` (`id`, `nama`, `nim`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(62, 'APRIANA BR SEBAYANG', '1113464002', 'APRIANA@gmail.com', '$2y$10$A8eBBY4qk61LW0xwS36shemBL7XFdBivbJ9WXD6DCZ2bDDXh5CYWy', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:17:52'),
(63, 'ARIE RANTO PUTRA', '1113464003', 'ARIE@gmail.com', '$2y$10$WayZEvaO7p1iVC5Sy/On.eS/VnU4kNfv8LwXWcCheUbUVVDgNbOj6', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:17:55'),
(64, 'ARTIKA NAOMI REMINISCERE FELICIA', '1113464004', 'ARTIKA@gmail.com', '$2y$10$CiP8SpKm5/fFaVCVuBI4m.THl4aTy3pZy0aW0JOd/aKOJ3wX7otwe', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:17:57'),
(65, 'AVEN ASWADI PASARIBU', '1113464005', 'AVEN@gmail.com', '$2y$10$Kv6O0Ys93bbYI474/jKPguegAWXBUlS4.l2j9UN8XGT6QvySsGitC', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:17:57'),
(66, 'AYUB', '1113464006', 'AYUB@gmail.com', '$2y$10$hXq8pVL4yYby7.qohk7PMuCB2gIgCI2g5SDIfAlCyGx.hpLsQEH3e', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:17:59'),
(67, 'AZIZAH REZEKIAH HASIBUAN', '1113464007', 'AZIZAH@gmail.com', '$2y$10$xuglAM15hlkCV8Z9MxrjfO4FEz0wnL2DmNfqzLJViS79VEpKN9J0y', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:03'),
(68, 'DAMAN TAKWA RAMBE', '1113464008', 'DAMAN@gmail.com', '$2y$10$clcfysDfV9w35LRjVjQ3AOhDKLmADdoWYxWiw44vd8GB1Scz8WF2G', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:04'),
(69, 'DEFRIDA ', '1113464009', 'DEFRIDA@gmail.com', '$2y$10$khGPO4Gwqrf7Oud4oMCuGe4JOSzn0fUaGS3zGYVmEuPEBMcis9muq', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:05'),
(70, 'DESMA KRISTINA SITUMORANG', '1113464011', 'DESMA@gmail.com', '$2y$10$wJ/YtvAIHv4pQNC7IFOSvOIU7d/uIjkFtNLAI1LLoXl6umHeqinbu', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:05'),
(71, 'DEVI PRANITA ', '1113464012', 'DEVI@gmail.com', '$2y$10$EcbarrIWPaNhNnRfrqioCOtzKeBAWyTqq.uOzFxZ.jcWswQTebp0y', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:21'),
(72, 'DINI ERLINA PRAMITHA MATONDANG', '1113464013', 'DINI@gmail.com', '$2y$10$syExmwdBMlzkCUWNtvjM4eQpQUEPxJC7/2ZKdWkw3vi/bhiwaUmjW', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:23'),
(73, 'DONI SYAPUTRA', '1113464014', 'DONI@gmail.com', '$2y$10$9fMVlt5SjVPI4VTo5TJwR.IIXsROlc4SPFT.G9k72q..QaLUf9RFe', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:23'),
(74, 'DWIKA WULANDARI MARBUN ', '1113464015', 'DWIKA@gmail.com', '$2y$10$6zf.dvaRV.Z9WqDFUiBVKO1kjVCn2K9DsQ5QciyRAU6.lbkJ8qk9m', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:24'),
(75, 'EKA OKTAFIANITA ', '1113464016', 'EKA@gmail.com', '$2y$10$elbe3mRRHsu2mG6UcP8xCusGCCIMbIs4sDbPXgOjnW3WHaXWM81DC', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:26'),
(76, 'ERWIN EFENDI SIANTURI', '1113464017', 'ERWIN@gmail.com', '$2y$10$y8v5SweCIvcTuCuXuXfIROWV89t94IHk0DQmjmNt9XkQ41/1EcciG', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:26'),
(77, 'ESRA BR GINTING', '1113464018', 'ESRA@gmail.com', '$2y$10$k8RTmCXzWpdAUBmt7ieyze/bSt/oVHhrHWIDUgqi6jq43kIjutcWq', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:27'),
(78, 'GERTI MAIFA SARAH', '1113464019', 'GERTI@gmail.com', '$2y$10$9Qam3OHDbtvWg1rVqcs5xOTDfEUDWVSK2LJUYbQLKpCpGbq5bFLJu', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:27'),
(79, 'HERI ASWINARDI NASUTION', '1113464020', 'HERI@gmail.com', '$2y$10$y5V44PvHCB3UocG/.vg.Tu/q8yc2X2buJF.K4WA7I0AcSMEvHx7l2', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:28'),
(80, 'ICHSAN SYAMTARA SITEPU', '1113464021', 'ICHSAN@gmail.com', '$2y$10$ZF.7Llq41yJsDfIQCEYu0.t8lXquBqc5sMBuwoxLuHNIvkO6bDCTi', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:29'),
(81, 'IRMAYANTI JULITA SIMANIHURUK ', '1113464022', 'IRMAYANTI@gmail.com', '$2y$10$0.F1ujtRb4tC8fiHXZbQnekika0SFCCfZqKYZxN.ZO8L1Wv4n7IIq', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:31'),
(82, 'IRVANNY', '1113464023', 'IRVANNY@gmail.com', '$2y$10$0dqfDn8JnvIRw7gzBBT.9.Sc3x7Zm5fQeqRMz37WHvo7EiiG2TBh2', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:31'),
(83, 'KHAIRINA ', '1113464024', 'KHAIRINA@gmail.com', '$2y$10$MfWQG326kjRTfoWVMfPbpuQhPzuAm36LXf/EQeB3GE1muoZrO80O2', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:32'),
(84, 'KHAIRUN NISA ', '1113464025', 'KHAIRUN@gmail.com', '$2y$10$ZFfbtOBU9jmSg71h5.F42ul1raZonNH.L53I56bIVZoaeM4/iB1Re', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:33'),
(85, 'LISNAWATI LIMBONG', '1113464026', 'LISNAWATI@gmail.com', '$2y$10$VVtHr3M4NZiG/VEowqSADe/SXYAwhENkVwg1jK6NM6Fw9YVt7I/5G', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:33'),
(86, 'LOLITA FIERDA GUSTIARA SILALAHI', '1113464027', 'LOLITA@gmail.com', '$2y$10$Kc/3gXMSAufE3ashraJuFuc4P04c1pV.r9EWyeQl.EtnoNK3dyPOK', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:35'),
(87, 'LORINA CLAUDIA BR SEMBIRING ', '1113464028', 'LORINA@gmail.com', '$2y$10$3FJCbcVXeO.daGZlZFVLBOFskSq3bUyM8VQWVPEFdCcvZinkpIkxe', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:36'),
(88, 'M HANAFI', '1113464029', 'M@gmail.com', '$2y$10$Ye3H7VcRX2MAIIGL6Acx0eDB2ES2QeQKJM2eK5DYrMJWk7qrRG/WS', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:37'),
(89, 'MARTA ULINA PURBA', '1113464030', 'MARTA@gmail.com', '$2y$10$1pNf7ZKbgr13HjeUOM0z0.U5xRWPpMICMTpLNfQ2antlZKdCd5zj2', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:38'),
(90, 'MELINA TIODORA SITANGGANG', '1113464031', 'MELINA@gmail.com', '$2y$10$pmxSvmsW5y1f7YwSD.2.J.DOIH2Fj8/WQzX2.iBVMO0vfNeJhZlui', '4iAq54HO6xqbbmttQ1Bc7HAlAFI1roqmbGnEZpUHRA8hLlcS02ZwtRILzEMo', '2016-08-13 15:12:06', '2016-08-13 08:19:30'),
(91, 'MITA YUSWITA SARI ', '1113464032', 'MITA@gmail.com', '$2y$10$x3/uMg4ZBjyvaj.bblInUukj681yCv42Ww0zciU/yJ/vYouLnhwdq', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:39'),
(92, 'MORGAN HARRY PARNINGOTAN M', '1113464033', 'MORGAN@gmail.com', '$2y$10$TFzO6bvcMoTy6LrHahWGpOJNeiQXmxdKwy33sWK53s6phgSLZQ9sy', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:40'),
(93, 'MUHAMMAD LUTHFI SISKANDAR ', '1113464034', 'MUHAMMAD@gmail.com', '$2y$10$sptRwUdJ/t5e0bGLd/3MceEyUFQeeLQ1SaRxcif/rionZFIVOKFYi', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:41'),
(94, 'NAZLI HASWANI SARAGIH ', '1113464035', 'NAZLI@gmail.com', '$2y$10$olPJHFqoIEo/pBig2p.c0euAtB75jDTemh36OsDYyXZLAPDzkOLi6', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:42'),
(95, 'NELLY HERIYANTI PURBA', '1113464036', 'NELLY@gmail.com', '$2y$10$5Xy2n8pwD5uGNzFVSh.ls.rWoTImnPA8CT6ZmfOXDEm0CkCMOMaQ2', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:42'),
(96, 'NOVA FRASETIA NINGSIH SARAGIH', '1113464037', 'NOVA@gmail.com', '$2y$10$7saeglyRVHkJZAXv5bAR0Oy1R.IbImWJtdhjuXsiAS3HS3jJRmKlu', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:44'),
(97, 'PEDDAH IMOY CIBRO', '1113464038', 'PEDDAH@gmail.com', '$2y$10$ECq6zK6x9Pqk6b.zxxD4UOPczFSsl823eeWokDN5T2SHuKvHzmoTm', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:44'),
(98, 'PIARDIARON LAOLI', '1113464039', 'PIARDIARON@gmail.com', '$2y$10$08iIMA6cQWdpjDqlQkzhjOMCTT.5BXdlCAp2uIUNfGt9x8YsctfB6', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:45'),
(99, 'PUTRI FACHRUNNISA ', '1113464040', 'PUTRI@gmail.com', '$2y$10$PAMJPeYBmeUa3b08rmz61u9OvZc3xNPZbqv0ZD4kcyQgdFdSWx/Vm', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:47'),
(100, 'PUTRI HUTAPEA', '1113464041', 'PUTRI@gmail.com', '$2y$10$Cly4APBVDYiZX6RwwUKJh.1jHCITjDQLH7MViAy5/iwtDeuAW08e2', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:47'),
(101, 'RAHMAT HATIMBULAN HARAHAP', '1113464042', 'RAHMAT@gmail.com', '$2y$10$/AAtQKA/XqYHvCp05EQE6uW3AtbIMsx2MHY8qr1aZtTrBl4c8d3Gi', '9BjW3Vr5BkKi9NoOT8tu4Zv19lr4wzLFqSelwzbMjRMGW7HTmdkzFgWxOaEQ', '2016-08-13 15:12:06', '2016-08-13 08:20:00'),
(102, 'RICKY SUDARYANTO', '1113464044', 'RICKY@gmail.com', '$2y$10$fLw4P7QTW0zPUvjRfX6x2u9CmwnJPGoLsMvEhiBuNkASoZc42JXPm', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:49'),
(103, 'SITI CHAIRANI', '1113464045', 'SITI@gmail.com', '$2y$10$STft/stu5nz6y6GDSEI1QuVO7.BaYZ1wZMi5ODnKLnX9KGWpu6cE.', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:49'),
(104, 'SUNDARI PRICILIA HASIBUAN', '1113464046', 'SUNDARI@gmail.com', '$2y$10$x3qDKclItKiuOU9UAEn1j.9kOZlL/MP0jy/Qh2U6zR3twrkNwPqza', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:50'),
(105, 'THERESIA HUTASOIT', '1113464047', 'THERESIA@gmail.com', '$2y$10$YX3NCMkKX4DjVFeH0BwDMOrZG6j8PCZaE23Um/n6WWdBBSbM7Aprm', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:51'),
(106, 'YESSI MAGDALENA', '1113464048', 'YESSI@gmail.com', '$2y$10$XkB/hPwZRPzaVd10h1u3HOf8K3qxst5XDlZNTKviwj7j2PRgmPP7K', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:51'),
(107, 'ZULFIRMAN HARAHAP', '1113464049', 'ZULFIRMAN@gmail.com', '$2y$10$Siv7R.DQL.D8ZN94C.qEKekngh5B07bRJSunmjAnZOPrLUTXe1ubq', '8def3agRd3UKokdru8fGWrsvObd2LFprWaQOXg23', '2016-08-13 15:12:06', '2016-08-13 08:18:52');

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
  ADD PRIMARY KEY (`idkelas`);

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
  ADD KEY `fk_khs_iddosen_idx` (`iddosen`);

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
  ADD UNIQUE KEY `users_dosen_nim_unique` (`nidn`);

--
-- Indexes for table `user_mahasiswas`
--
ALTER TABLE `user_mahasiswas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usermahasiswas_nim_unique` (`nim`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `dosen`
--
ALTER TABLE `dosen`
  MODIFY `iddosen` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `jabatan`
--
ALTER TABLE `jabatan`
  MODIFY `idjabatan` int(2) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `kelas`
--
ALTER TABLE `kelas`
  MODIFY `idkelas` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `kelasdosen`
--
ALTER TABLE `kelasdosen`
  MODIFY `idkelasdosen` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `kelas_mahasiswa`
--
ALTER TABLE `kelas_mahasiswa`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `khs`
--
ALTER TABLE `khs`
  MODIFY `idkhs` int(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `krs`
--
ALTER TABLE `krs`
  MODIFY `idkrs` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `periode`
--
ALTER TABLE `periode`
  MODIFY `idperiode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `user_dosens`
--
ALTER TABLE `user_dosens`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `user_mahasiswas`
--
ALTER TABLE `user_mahasiswas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;
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
  ADD CONSTRAINT `fk_khs_kodemk` FOREIGN KEY (`kodemk`) REFERENCES `matakuliah` (`kodemk`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_khs_nim` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `krs`
--
ALTER TABLE `krs`
  ADD CONSTRAINT `fk_krs_kodemk` FOREIGN KEY (`kodemk`) REFERENCES `matakuliah` (`kodemk`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_krs_nim` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
