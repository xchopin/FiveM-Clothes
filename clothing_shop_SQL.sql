-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.13 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for gta5_gamemode_essential
CREATE DATABASE IF NOT EXISTS `gta5_gamemode_essential` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `gta5_gamemode_essential`;

-- Dumping structure for table gta5_gamemode_essential.user_clothes
CREATE TABLE IF NOT EXISTS `user_clothes` (
  `identifier` varchar(255) NOT NULL,
  `skin` varchar(255) NOT NULL DEFAULT 'mp_m_freemode_01',
  `face` varchar(255) NOT NULL DEFAULT '0',
  `face_texture` varchar(255) NOT NULL DEFAULT '0',
  `hair` varchar(255) NOT NULL DEFAULT '11',
  `hair_texture` varchar(255) NOT NULL DEFAULT '4',
  `shirt` varchar(255) NOT NULL DEFAULT '0',
  `shirt_texture` varchar(255) NOT NULL DEFAULT '0',
  `pants` varchar(255) NOT NULL DEFAULT '8',
  `pants_texture` varchar(255) NOT NULL DEFAULT '0',
  `shoes` varchar(255) NOT NULL DEFAULT '1',
  `shoes_texture` varchar(255) NOT NULL DEFAULT '0',
  `vest` varchar(255) NOT NULL DEFAULT '0',
  `vest_texture` varchar(255) NOT NULL DEFAULT '0',
  `bag` varchar(255) NOT NULL DEFAULT '40',
  `bag_texture` varchar(255) NOT NULL DEFAULT '0',
  `hat` varchar(255) NOT NULL DEFAULT '1',
  `hat_texture` varchar(255) NOT NULL DEFAULT '1',
  `mask` varchar(255) NOT NULL DEFAULT '0',
  `mask_texture` varchar(255) NOT NULL DEFAULT '0',
  `glasses` varchar(255) NOT NULL DEFAULT '6',
  `glasses_texture` varchar(255) NOT NULL DEFAULT '0',
  `gloves` varchar(255) NOT NULL DEFAULT '2',
  `gloves_texture` varchar(255) NOT NULL DEFAULT '0',
  `jacket` varchar(255) NOT NULL DEFAULT '7',
  `jacket_texture` varchar(255) NOT NULL DEFAULT '2',
  `ears` varchar(255) NOT NULL DEFAULT '1',
  `ears_texture` varchar(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- Dumping data for table gta5_gamemode_essential.user_clothes: ~1 rows (approximately)
/*!40000 ALTER TABLE `user_clothes` DISABLE KEYS */;
INSERT INTO `user_clothes` (`identifier`, `skin`, `face`, `face_texture`, `hair`, `hair_texture`, `shirt`, `shirt_texture`, `pants`, `pants_texture`, `shoes`, `shoes_texture`, `vest`, `vest_texture`, `bag`, `bag_texture`, `hat`, `hat_texture`, `mask`, `mask_texture`, `glasses`, `glasses_texture`, `gloves`, `gloves_texture`, `jacket`, `jacket_texture`, `ears`, `ears_texture`) VALUES
	('steam:110000107111111', 'mp_m_freemode_01', '0', '0', '11', '4', '0', '0', '8', '0', '1', '0', '0', '0', '40', '0', '1', '0', '0', '0', '6', '0', '2', '0', '7', '2', '1', '0');
/*!40000 ALTER TABLE `user_clothes` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
