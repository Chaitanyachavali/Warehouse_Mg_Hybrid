-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.21 - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL Version:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for warehouse_mg
DROP DATABASE IF EXISTS `warehouse_mg`;
CREATE DATABASE IF NOT EXISTS `warehouse_mg` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `warehouse_mg`;


-- Dumping structure for table warehouse_mg.whm_events
DROP TABLE IF EXISTS `whm_events`;
CREATE TABLE IF NOT EXISTS `whm_events` (
  `user_id` varchar(50) NOT NULL,
  `ip_add` varchar(20) NOT NULL,
  `activity` varchar(80) NOT NULL,
  KEY `FK__whm_users_events` (`user_id`),
  CONSTRAINT `FK__whm_users_events` FOREIGN KEY (`user_id`) REFERENCES `whm_users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Logs of the users';

-- Dumping data for table warehouse_mg.whm_events: ~0 rows (approximately)
DELETE FROM `whm_events`;
/*!40000 ALTER TABLE `whm_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `whm_events` ENABLE KEYS */;


-- Dumping structure for table warehouse_mg.whm_products
DROP TABLE IF EXISTS `whm_products`;
CREATE TABLE IF NOT EXISTS `whm_products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(50) DEFAULT NULL,
  `product_type` varchar(50) DEFAULT NULL COMMENT 'Type of the product accordingly',
  `warehouse_id` int(5) DEFAULT NULL COMMENT 'from warehouse',
  PRIMARY KEY (`product_id`),
  KEY `FK__whg_warehouse_id_products` (`warehouse_id`),
  CONSTRAINT `FK__whg_warehouse_id_products` FOREIGN KEY (`warehouse_id`) REFERENCES `whm_warehouse` (`warehouse_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Maintains all the list of the of the products of all the warehouses.\r\nProducts in warehouse are distuinged according to warehouse id ';

-- Dumping data for table warehouse_mg.whm_products: ~0 rows (approximately)
DELETE FROM `whm_products`;
/*!40000 ALTER TABLE `whm_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `whm_products` ENABLE KEYS */;


-- Dumping structure for table warehouse_mg.whm_purchases
DROP TABLE IF EXISTS `whm_purchases`;
CREATE TABLE IF NOT EXISTS `whm_purchases` (
  `purchase_id` int(11) NOT NULL,
  `order_status` varchar(20) DEFAULT NULL,
  `payment_method` varchar(20) DEFAULT NULL,
  `date_init` date DEFAULT NULL,
  `time_init` time DEFAULT NULL,
  `date_recv` date DEFAULT NULL,
  `time_recv` time DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `purchase_from` varchar(50) DEFAULT NULL,
  `comments` varchar(100) DEFAULT NULL,
  `purchase_by` varchar(50) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`purchase_id`),
  KEY `FK_whg_prurchases_whg_warehouse_purchase` (`warehouse_id`),
  KEY `FK_whg_prurchases_whg_products_purchase` (`product_id`),
  CONSTRAINT `FK_whg_prurchases_whg_products_purchase` FOREIGN KEY (`product_id`) REFERENCES `whm_products` (`product_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK_whg_prurchases_whg_warehouse_purchase` FOREIGN KEY (`warehouse_id`) REFERENCES `whm_warehouse` (`warehouse_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='All the info about purchases.';

-- Dumping data for table warehouse_mg.whm_purchases: ~0 rows (approximately)
DELETE FROM `whm_purchases`;
/*!40000 ALTER TABLE `whm_purchases` DISABLE KEYS */;
/*!40000 ALTER TABLE `whm_purchases` ENABLE KEYS */;


-- Dumping structure for table warehouse_mg.whm_returns
DROP TABLE IF EXISTS `whm_returns`;
CREATE TABLE IF NOT EXISTS `whm_returns` (
  `return_id` int(11) NOT NULL,
  `order_status` varchar(20) DEFAULT NULL,
  `payment_method` varchar(20) DEFAULT NULL,
  `date_init` date DEFAULT NULL,
  `time_init` time DEFAULT NULL,
  `date_recv` date DEFAULT NULL,
  `time_recv` time DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `sales_id/purchase_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`return_id`),
  KEY `FK__whg_warehouse_returns` (`warehouse_id`),
  KEY `FK__whg_products_returns` (`product_id`),
  CONSTRAINT `FK__whg_products_returns` FOREIGN KEY (`product_id`) REFERENCES `whm_products` (`product_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK__whg_warehouse_returns` FOREIGN KEY (`warehouse_id`) REFERENCES `whm_warehouse` (`warehouse_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Listed with all returns to warehouse';

-- Dumping data for table warehouse_mg.whm_returns: ~0 rows (approximately)
DELETE FROM `whm_returns`;
/*!40000 ALTER TABLE `whm_returns` DISABLE KEYS */;
/*!40000 ALTER TABLE `whm_returns` ENABLE KEYS */;


-- Dumping structure for table warehouse_mg.whm_roles
DROP TABLE IF EXISTS `whm_roles`;
CREATE TABLE IF NOT EXISTS `whm_roles` (
  `role_id` int(5) NOT NULL COMMENT 'Contains Role ID',
  `role_name` varchar(50) NOT NULL COMMENT 'Coressponding name of the role',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Contains the roles of the users.\r\n';

-- Dumping data for table warehouse_mg.whm_roles: ~2 rows (approximately)
DELETE FROM `whm_roles`;
/*!40000 ALTER TABLE `whm_roles` DISABLE KEYS */;
INSERT INTO `whm_roles` (`role_id`, `role_name`) VALUES
	(1, 'Manager'),
	(2, 'Field Engineer'),
	(3, 'Dummy');
/*!40000 ALTER TABLE `whm_roles` ENABLE KEYS */;


-- Dumping structure for table warehouse_mg.whm_sales
DROP TABLE IF EXISTS `whm_sales`;
CREATE TABLE IF NOT EXISTS `whm_sales` (
  `sales_id` int(11) NOT NULL,
  `order_status` varchar(20) DEFAULT NULL,
  `payment_method` varchar(20) DEFAULT NULL,
  `date_init` date DEFAULT NULL,
  `time_init` time DEFAULT NULL,
  `date_recv` date DEFAULT NULL,
  `time_recv` time DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `purchased_by` varchar(50) DEFAULT NULL,
  `selled_by` varchar(50) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `comments` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`sales_id`),
  KEY `FK__whg_warehouse_sales` (`warehouse_id`),
  KEY `FK__whg_products_sales` (`product_id`),
  CONSTRAINT `FK__whg_products_sales` FOREIGN KEY (`product_id`) REFERENCES `whm_products` (`product_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK__whg_warehouse_sales` FOREIGN KEY (`warehouse_id`) REFERENCES `whm_warehouse` (`warehouse_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Sales of the each product is listed here.';

-- Dumping data for table warehouse_mg.whm_sales: ~0 rows (approximately)
DELETE FROM `whm_sales`;
/*!40000 ALTER TABLE `whm_sales` DISABLE KEYS */;
/*!40000 ALTER TABLE `whm_sales` ENABLE KEYS */;


-- Dumping structure for table warehouse_mg.whm_users
DROP TABLE IF EXISTS `whm_users`;
CREATE TABLE IF NOT EXISTS `whm_users` (
  `user_name` varchar(50) NOT NULL COMMENT 'Name of the user',
  `user_id` varchar(30) NOT NULL COMMENT 'entry id',
  `password` varchar(20) NOT NULL COMMENT 'entry password',
  `role_id` int(5) NOT NULL COMMENT 'from roles table',
  `contact` int(15) DEFAULT NULL,
  `working_zone` varchar(30) DEFAULT NULL COMMENT 'current zone',
  `address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `FK_whg_users_whg_roles_users` (`role_id`),
  CONSTRAINT `FK_whg_users_whg_roles_users` FOREIGN KEY (`role_id`) REFERENCES `whm_roles` (`role_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Will take care all the user details.';

-- Dumping data for table warehouse_mg.whm_users: ~4 rows (approximately)
DELETE FROM `whm_users`;
/*!40000 ALTER TABLE `whm_users` DISABLE KEYS */;
INSERT INTO `whm_users` (`user_name`, `user_id`, `password`, `role_id`, `contact`, `working_zone`, `address`) VALUES
	('User1', 'user1', '1234', 1, 88888, 'Hyderabad', 'Nizampet,Hyderbad'),
	('User2', 'user2', '1234', 1, 99999, 'Delhi', 'Karolbagh'),
	('User3', 'user3', '1234', 2, 55555, 'Aalhabad', 'alhabad'),
	('User4', 'user4', '1234', 2, 66666, 'Chennai', 'Apllo chennai'),
	('User5', 'user5', '1234', 3, 44444, 'Bengaluru', 'Vishawa Ben');
/*!40000 ALTER TABLE `whm_users` ENABLE KEYS */;


-- Dumping structure for table warehouse_mg.whm_warehouse
DROP TABLE IF EXISTS `whm_warehouse`;
CREATE TABLE IF NOT EXISTS `whm_warehouse` (
  `warehouse_id` int(11) NOT NULL COMMENT 'Just id',
  `location` varchar(50) NOT NULL COMMENT 'Like - hyd, delhi',
  `address` varchar(100) DEFAULT NULL COMMENT 'complete address of warehouse',
  PRIMARY KEY (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='All warehouses are listed here.\r\nEach will be designated with a id.';

-- Dumping data for table warehouse_mg.whm_warehouse: ~0 rows (approximately)
DELETE FROM `whm_warehouse`;
/*!40000 ALTER TABLE `whm_warehouse` DISABLE KEYS */;
/*!40000 ALTER TABLE `whm_warehouse` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
