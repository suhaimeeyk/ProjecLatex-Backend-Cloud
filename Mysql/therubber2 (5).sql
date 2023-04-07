-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Apr 07, 2023 at 06:57 AM
-- Server version: 5.7.39
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `therubber2`
--

-- --------------------------------------------------------

--
-- Table structure for table `db_catusers`
--

CREATE TABLE `db_catusers` (
  `catusers_id` int(11) NOT NULL,
  `catusers_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `db_catusers`
--

INSERT INTO `db_catusers` (`catusers_id`, `catusers_name`) VALUES
(1, 'เจ้าของสวน'),
(2, 'ลูกจ้าง'),
(3, 'พนักงานรายวัน');

-- --------------------------------------------------------

--
-- Table structure for table `db_catwithdraw`
--

CREATE TABLE `db_catwithdraw` (
  `catwithdraw_id` int(11) NOT NULL,
  `catwithdraw_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `db_catwithdraw`
--

INSERT INTO `db_catwithdraw` (`catwithdraw_id`, `catwithdraw_name`) VALUES
(1, 'ฝากทั้งหมด'),
(2, 'เบิกทั้งหมด');

-- --------------------------------------------------------

--
-- Table structure for table `db_customer`
--

CREATE TABLE `db_customer` (
  `customer_id` int(11) NOT NULL,
  `customer_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `customer_tel` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `catcustomer_id` int(11) NOT NULL,
  `db_users_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `db_customer`
--

INSERT INTO `db_customer` (`customer_id`, `customer_name`, `customer_tel`, `catcustomer_id`, `db_users_id`) VALUES
(1, 'ลูกค้า ทดสอบ', '0845213659', 1, '1'),
(2, 'ชาลิสา รอดเลย', '0745213659', 2, '2'),
(7, 'นายมูฮำหมัด ปูติ', '0123456789', 3, '1'),
(8, 'อารีฟ ลูดิง', '1234567890', 3, '1'),
(9, 'สมพงค์ นะจะ', '0123456789', 3, '2');

-- --------------------------------------------------------

--
-- Table structure for table `db_data`
--

CREATE TABLE `db_data` (
  `data_id` int(11) NOT NULL,
  `data_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `data_usersid` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `data_totalgallon` float NOT NULL,
  `data_wgallon` float NOT NULL,
  `data_disgallon` float NOT NULL,
  `data_percent` int(11) NOT NULL,
  `data_dryrubber` float NOT NULL,
  `data_price` float NOT NULL,
  `data_pricetotal` float NOT NULL,
  `data_shareprice` int(11) NOT NULL,
  `data_depositprice` int(11) NOT NULL,
  `status_id` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `db_data`
--

INSERT INTO `db_data` (`data_id`, `data_date`, `data_usersid`, `cat_id`, `data_totalgallon`, `data_wgallon`, `data_disgallon`, `data_percent`, `data_dryrubber`, `data_price`, `data_pricetotal`, `data_shareprice`, `data_depositprice`, `status_id`) VALUES
(14, '2022-03-21 17:40:53', 1, 1, 500, 20, 480, 0, 124.8, 40, 4992, 4992, 4992, 1),
(15, '2023-02-22 08:51:24', 7, 2, 600, 30, 570, 0, 131.1, 20, 2622, 1180, 1442, 3),
(16, '2023-02-22 08:51:15', 7, 2, 400, 50, 350, 0, 87.5, 30, 2625, 1313, 1313, 2),
(17, '2023-04-06 14:22:06', 2, 2, 600, 30, 570, 0, 123.4, 20, 2468, 1111, 1357, 3),
(18, '2023-02-23 08:20:33', 8, 2, 450, 50, 400, 0, 92, 20, 1840, 1840, 1840, 1),
(19, '2023-04-06 14:21:27', 8, 2, 1500, 500, 1000, 0, 270, 40, 10800, 10800, 10800, 1),
(20, '2023-03-31 18:46:24', 9, 1, 50, 20, 30, 0, 7.5, 30, 225, 225, 225, 1);

-- --------------------------------------------------------

--
-- Table structure for table `db_income`
--

CREATE TABLE `db_income` (
  `db_income_id` int(11) NOT NULL,
  `Datedb_income` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Manuredb_income` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Revealdb_income` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pay_for_all_latex_db_income` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `total_price` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `note` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `users_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `db_income`
--

INSERT INTO `db_income` (`db_income_id`, `Datedb_income`, `Manuredb_income`, `Revealdb_income`, `pay_for_all_latex_db_income`, `total_price`, `note`, `users_id`) VALUES
(9, '2023-03-30 16:50:06', '300', '350', '20000', '20650', 'ผลร่วมรายรับวันที่ 28/03/2023	', 1),
(11, '2023-03-30 16:50:08', '200', '2200', '300', '2700', 'ผลร่วมรายรับวันที่ 21/02/2023	', 1),
(12, '2023-03-30 16:50:10', '0', '4000', '6000', '10000', 'ผลร่วมรายการวันที่ 23/02/2023', 1),
(13, '2023-03-30 16:50:11', '0', '0', '10300', '10300', 'ผลร่วมรายการจ่ายวันที่ 22/03/2022	', 1),
(14, '2023-03-30 19:03:15', '200', '0', '800', '1000', 'ผลร่วมรายการรับวันที่ 31/03/2023', 1),
(15, '2023-03-31 19:54:22', '150', '301', '2500', '2951', 'ผลร่วมรายการรับวันที่ 01/04/2023', 2),
(16, '2023-03-31 19:59:13', '0', '0', '3000', '3000', 'ผลร่วมรายการรับวันที่ 22/02/2023', 2);

-- --------------------------------------------------------

--
-- Table structure for table `db_level`
--

CREATE TABLE `db_level` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `db_level`
--

INSERT INTO `db_level` (`id`, `name`) VALUES
(1, 'ผู้ดูแลระบบ'),
(2, 'ผู้ใช้ระบบ');

-- --------------------------------------------------------

--
-- Table structure for table `db_manure`
--

CREATE TABLE `db_manure` (
  `manure_id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  `manure_total` int(11) NOT NULL,
  `db_manure_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `db_manure`
--

INSERT INTO `db_manure` (`manure_id`, `users_id`, `manure_total`, `db_manure_date`) VALUES
(2, 2, 15300, '2023-02-20 17:32:12'),
(14, 7, 500, '2023-03-28 16:06:54'),
(15, 8, 600, '2023-03-30 18:59:32'),
(16, 9, 750, '2023-03-31 19:03:54');

-- --------------------------------------------------------

--
-- Table structure for table `db_manure_detail`
--

CREATE TABLE `db_manure_detail` (
  `manure_id` int(11) NOT NULL,
  `manure_detail_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `manure_sumtotal` varchar(255) DEFAULT NULL,
  `manure_pay` varchar(255) DEFAULT NULL,
  `manure_total` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `db_manure_detail`
--

INSERT INTO `db_manure_detail` (`manure_id`, `manure_detail_date`, `manure_sumtotal`, `manure_pay`, `manure_total`) VALUES
(1, '2023-02-07 08:28:50', '14500', '500', '15000'),
(2, '2023-02-07 08:29:08', '15000', '300', '15300'),
(4, '2023-02-07 08:29:31', '17500', '500', '18000'),
(4, '2023-02-07 09:08:23', '17000', '500', '18000'),
(1, '2023-02-07 14:56:18', '14000', '500', '15000'),
(2, '2023-02-07 15:06:23', '10000', '5000', '15300'),
(1, '2023-02-11 09:40:46', '14300', '200', '15000'),
(5, '2023-02-16 07:05:43', '480', '20', '500'),
(6, '2023-02-17 01:25:08', '600', '330', '930'),
(6, '2023-02-17 01:26:36', '500', '100', '930'),
(5, '2023-02-17 01:27:40', '450', '30', '500'),
(5, '2023-02-17 01:29:42', '400', '50', '500'),
(7, '2023-02-17 04:16:29', '4000', '1000', '5000'),
(9, '2023-02-19 12:56:04', '6000', '3000', '9000'),
(1, '2023-02-22 03:20:14', '14000', '300', '15000'),
(10, '2023-02-25 08:30:24', '3700', '300', '4000'),
(11, '2023-03-20 17:34:21', '1800', '200', '2000'),
(12, '2023-03-28 15:59:31', 'ยอดทั้งหมด - ยอดที่จ่าย', '200', '500'),
(14, '2023-03-28 16:06:59', '400', '100', '500'),
(15, '2023-03-30 18:59:38', '400', '200', '600'),
(16, '2023-03-31 19:10:50', '700', '50', '750'),
(16, '2023-03-31 19:13:29', '600', '100', '750');

-- --------------------------------------------------------

--
-- Table structure for table `db_paydaily`
--

CREATE TABLE `db_paydaily` (
  `paydaily_id` int(11) NOT NULL,
  `DateProfit` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ManureProfit` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `RevealProfit` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pay_for_all_latex_Profit` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pay_subordinates_wages` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `total_price` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `note` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `users_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `db_paydaily`
--

INSERT INTO `db_paydaily` (`paydaily_id`, `DateProfit`, `ManureProfit`, `RevealProfit`, `pay_for_all_latex_Profit`, `pay_subordinates_wages`, `total_price`, `note`, `users_id`) VALUES
(5, '2023-03-30 16:27:56', '15300', '0', '0', '300', '15600', 'ผลร่วมรายจ่ายวันที่ 21/02/2023', 1),
(8, '2023-03-30 16:27:58', '500', '600', '10800', '500', '12400', 'ผลร่วมรายการจ่ายวันที่ 28/03/2023', 1),
(9, '2023-03-30 16:28:00', '0', '0', '1840', '200', '2040', 'ผลร่วมรายการจ่ายวันที่ 23/02/2023', 1),
(10, '2023-03-30 16:28:01', '0', '0', '4992', '0', '4992', 'ผลร่วมรายการจ่ายวันที่ 22/03/2022', 1),
(11, '2023-03-30 19:02:26', '600', '0', '0', '200', '800', 'ผลร่วมรายการจ่ายวันที่ 31/03/2023', 1),
(12, '2023-03-31 19:51:29', '750', '750', '225', '200', '1925', 'ผลร่วมรายการจ่ายวันที่ 01/04/2023', 2),
(13, '2023-03-31 19:58:44', '0', '0', '2468', '100', '17868', 'ผลร่วมรายการจ่ายวันที่ 22/02/2023', 2);

-- --------------------------------------------------------

--
-- Table structure for table `db_pricerubbers`
--

CREATE TABLE `db_pricerubbers` (
  `pricerubbers_id` int(11) NOT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `percent` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `db_pricerubbers`
--

INSERT INTO `db_pricerubbers` (`pricerubbers_id`, `date_create`, `percent`, `price`) VALUES
(3, '2021-06-12 06:27:44', '24to25', 30),
(4, '2021-06-12 06:27:44', '26to27', 40),
(5, '2021-06-12 06:27:44', '28to29', 50),
(6, '2021-06-12 06:27:44', '30to31', 60),
(7, '2021-06-12 06:27:44', '32to33', 70),
(8, '2021-06-12 06:27:44', '34to35', 80),
(9, '2021-06-12 07:32:45', '36to37', 90),
(10, '2021-06-12 06:27:44', '38to39', 100),
(11, '2021-06-12 06:27:44', '40to41', 110),
(12, '2021-06-12 07:33:34', '42to43', 120),
(13, '2021-06-12 06:27:44', '44to45', 130),
(15, '2023-02-01 14:49:28', '22to23', 20);

-- --------------------------------------------------------

--
-- Table structure for table `db_profitmonth`
--

CREATE TABLE `db_profitmonth` (
  `profittoday_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `paydaily` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `income` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `totalprofittoday` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `note` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `db_profittoday`
--

CREATE TABLE `db_profittoday` (
  `profittoday_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `paydaily` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `income` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `totalprofittoday` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `note` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `users_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `db_profittoday`
--

INSERT INTO `db_profittoday` (`profittoday_id`, `date`, `paydaily`, `income`, `totalprofittoday`, `note`, `users_id`) VALUES
(10, '2023-03-30 16:19:22', '12400', '20650', '8250', '2023-03-28', 1),
(12, '2023-03-30 16:19:25', '15600', '2700', '-13100', '2023-02-21', 1),
(13, '2023-03-30 16:19:26', '2040', '10000', '7760', '2023-02-23', 1),
(14, '2023-03-30 16:19:28', '4992', '10300', '5308', '2022-03-22', 1),
(15, '2023-03-30 19:03:41', '800', '1000', '200', '2023-03-31', 1),
(16, '2023-03-31 19:57:49', '1925', '2951', '1026', '2023-04-01', 2),
(17, '2023-03-31 19:59:41', '17868', '3000', '-14868', '2023-02-22', 2);

-- --------------------------------------------------------

--
-- Table structure for table `db_reveal`
--

CREATE TABLE `db_reveal` (
  `reveal_id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  `reveal_total` int(11) NOT NULL,
  `db_reveal_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `db_reveal`
--

INSERT INTO `db_reveal` (`reveal_id`, `users_id`, `reveal_total`, `db_reveal_date`) VALUES
(11, 7, 600, '2023-03-28 16:07:11'),
(13, 2, 300, '2023-03-31 19:32:34'),
(14, 9, 450, '2023-03-31 19:42:03'),
(15, 8, 300, '2023-04-06 09:48:23');

-- --------------------------------------------------------

--
-- Table structure for table `db_reveal_detail`
--

CREATE TABLE `db_reveal_detail` (
  `reveal_id` int(11) NOT NULL,
  `reveal_detail_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `reveal_sumtotal` varchar(255) DEFAULT NULL,
  `reveal_pay` varchar(255) DEFAULT NULL,
  `reveal_total` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `db_reveal_detail`
--

INSERT INTO `db_reveal_detail` (`reveal_id`, `reveal_detail_date`, `reveal_sumtotal`, `reveal_pay`, `reveal_total`) VALUES
(4, '2023-02-19 13:35:48', '2800', '200', '3000'),
(7, '2023-02-21 01:33:10', '4000', '2000', '6000'),
(4, '2023-02-21 07:00:16', '2600', '200', '3000'),
(8, '2023-02-22 18:30:59', '2000', '4000', '6000'),
(10, '2023-03-28 16:02:28', '150', '50', '200'),
(11, '2023-03-28 16:07:17', '300', '300', '600'),
(13, '2023-03-31 19:41:17', '200', '100', '300'),
(13, '2023-03-31 19:41:49', '150', '50', '300'),
(14, '2023-03-31 19:42:09', '299', '151', '450'),
(15, '2023-04-06 09:53:59', '200', '100', '300');

-- --------------------------------------------------------

--
-- Table structure for table `db_users`
--

CREATE TABLE `db_users` (
  `users_id` int(11) NOT NULL,
  `users_name` varchar(144) COLLATE utf8_unicode_ci NOT NULL,
  `users_tel` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `users_usersname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `users_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `level` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `db_users`
--

INSERT INTO `db_users` (`users_id`, `users_name`, `users_tel`, `users_usersname`, `users_password`, `level`) VALUES
(1, 'นายซูไฮมี ยะโกะ', '1234567890', 'sam@gmail.com', '$2b$10$h/bpDzPrywQbo/oNBKJKXOkJEbZOGaLjCqYMEv2DzSb3x4FgioAJC', '1'),
(2, 'นุชฟารีนา ปาลายา', '123456789', 'nuchfarinapalaya@gmail.com', '$2b$10$eSa7tF929VuqUwze1LxqmO/R4kLtj7hYiaWdyt6hugIG7hxdCaYbS', '2'),
(3, 'test', '0123456789', 'test@gmail.com', '$2b$10$sMBdFBsQPhdGs6I9IhSBV.pA8lytYGyWBO9w52xAU.FePSHaEGYN6', '1'),
(4, 'นายมูฮำหมัด ปูตีล่า', '0123456789', 'mad@gmail.com', '$2b$10$UzplXDhVLKDzNOEGMDZp2.PpKK4FrBlTPdKDsFDbNm7bCXgpAypZ6', '2');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `db_catusers`
--
ALTER TABLE `db_catusers`
  ADD PRIMARY KEY (`catusers_id`);

--
-- Indexes for table `db_catwithdraw`
--
ALTER TABLE `db_catwithdraw`
  ADD PRIMARY KEY (`catwithdraw_id`);

--
-- Indexes for table `db_customer`
--
ALTER TABLE `db_customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `db_data`
--
ALTER TABLE `db_data`
  ADD PRIMARY KEY (`data_id`);

--
-- Indexes for table `db_income`
--
ALTER TABLE `db_income`
  ADD PRIMARY KEY (`db_income_id`);

--
-- Indexes for table `db_manure`
--
ALTER TABLE `db_manure`
  ADD PRIMARY KEY (`manure_id`);

--
-- Indexes for table `db_paydaily`
--
ALTER TABLE `db_paydaily`
  ADD PRIMARY KEY (`paydaily_id`);

--
-- Indexes for table `db_pricerubbers`
--
ALTER TABLE `db_pricerubbers`
  ADD PRIMARY KEY (`pricerubbers_id`);

--
-- Indexes for table `db_profitmonth`
--
ALTER TABLE `db_profitmonth`
  ADD PRIMARY KEY (`profittoday_id`);

--
-- Indexes for table `db_profittoday`
--
ALTER TABLE `db_profittoday`
  ADD PRIMARY KEY (`profittoday_id`);

--
-- Indexes for table `db_reveal`
--
ALTER TABLE `db_reveal`
  ADD PRIMARY KEY (`reveal_id`);

--
-- Indexes for table `db_users`
--
ALTER TABLE `db_users`
  ADD PRIMARY KEY (`users_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `db_catusers`
--
ALTER TABLE `db_catusers`
  MODIFY `catusers_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `db_catwithdraw`
--
ALTER TABLE `db_catwithdraw`
  MODIFY `catwithdraw_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `db_customer`
--
ALTER TABLE `db_customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `db_data`
--
ALTER TABLE `db_data`
  MODIFY `data_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `db_income`
--
ALTER TABLE `db_income`
  MODIFY `db_income_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `db_manure`
--
ALTER TABLE `db_manure`
  MODIFY `manure_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `db_paydaily`
--
ALTER TABLE `db_paydaily`
  MODIFY `paydaily_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `db_pricerubbers`
--
ALTER TABLE `db_pricerubbers`
  MODIFY `pricerubbers_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `db_profitmonth`
--
ALTER TABLE `db_profitmonth`
  MODIFY `profittoday_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `db_profittoday`
--
ALTER TABLE `db_profittoday`
  MODIFY `profittoday_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `db_reveal`
--
ALTER TABLE `db_reveal`
  MODIFY `reveal_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `db_users`
--
ALTER TABLE `db_users`
  MODIFY `users_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
