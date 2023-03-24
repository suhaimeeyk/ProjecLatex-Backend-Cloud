-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Mar 21, 2023 at 07:41 PM
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
(8, 'อารีฟ ลูดิง', '0123456789', 3, '1');

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
(14, '2023-02-22 08:46:40', 1, 1, 500, 20, 480, 0, 124.8, 40, 4992, 0, 0, 0),
(15, '2023-02-22 08:51:24', 7, 2, 600, 30, 570, 0, 131.1, 20, 2622, 1180, 1442, 3),
(16, '2023-02-22 08:51:15', 7, 2, 400, 50, 350, 0, 87.5, 30, 2625, 1313, 1313, 2),
(17, '2023-02-22 08:57:32', 2, 2, 600, 30, 570, 0, 123.4, 20, 2468, 0, 0, 0),
(18, '2023-02-23 08:20:33', 8, 2, 450, 50, 400, 0, 92, 20, 1840, 1840, 1840, 1);

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
(1, 1, 15000, '2023-02-16 07:29:09'),
(2, 2, 15300, '2023-02-21 17:32:12'),
(7, 7, 5000, '2023-02-17 04:16:13'),
(9, 7, 9000, '2023-02-19 12:55:56'),
(10, 8, 4000, '2023-02-25 08:30:02'),
(11, 1, 2000, '2023-02-22 17:32:12');

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
(11, '2023-03-20 17:34:21', '1800', '200', '2000');

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
(4, 7, 3000, '2023-02-19 13:18:05'),
(7, 1, 6000, '2023-02-21 17:32:12'),
(8, 8, 6000, '2023-02-22 18:30:40');

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
(8, '2023-02-22 18:30:59', '2000', '4000', '6000');

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
(2, 'นุชฟารีนา ปาลายา', '123456789', 'nuchfarinapalaya@gmail.com', '$2b$10$XCdF/9Zalf4pWnvvFWvPQ.O38z7UuIS0SERE2GKJWWPLxe.02rwU2', '2'),
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
-- Indexes for table `db_manure`
--
ALTER TABLE `db_manure`
  ADD PRIMARY KEY (`manure_id`);

--
-- Indexes for table `db_pricerubbers`
--
ALTER TABLE `db_pricerubbers`
  ADD PRIMARY KEY (`pricerubbers_id`);

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
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `db_data`
--
ALTER TABLE `db_data`
  MODIFY `data_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `db_manure`
--
ALTER TABLE `db_manure`
  MODIFY `manure_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `db_pricerubbers`
--
ALTER TABLE `db_pricerubbers`
  MODIFY `pricerubbers_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `db_reveal`
--
ALTER TABLE `db_reveal`
  MODIFY `reveal_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `db_users`
--
ALTER TABLE `db_users`
  MODIFY `users_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
