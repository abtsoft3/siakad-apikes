/*
MySQL Backup
Source Server Version: 5.5.5
Source Database: apikes
Date: 8/2/2016 18:11:34
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


