-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 16, 2020 at 01:24 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `urms`
--

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `dept_id` varchar(30) NOT NULL,
  `dept_name` varchar(30) NOT NULL,
  `hod` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`dept_id`, `dept_name`, `hod`) VALUES
('CS2016', 'Computer Science', 'Dr. Pradeep Kalansooriya'),
('SE2018', 'Computational Mathematics', 'Dr. Ajith De Mel');

-- --------------------------------------------------------

--
-- Table structure for table `lecturer`
--

CREATE TABLE `lecturer` (
  `lec_id` varchar(30) NOT NULL,
  `dept_id` varchar(30) NOT NULL,
  `lec_name` varchar(30) NOT NULL,
  `lec_email` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `lecturer`
--

INSERT INTO `lecturer` (`lec_id`, `dept_id`, `lec_name`, `lec_email`) VALUES
('zZun0os4YkRStobl6BnYjdLDTgU2', 'SE2018', 'Pramudhi Perera', 'ppramudhi@ymail.com');

-- --------------------------------------------------------

--
-- Table structure for table `lecturer_result`
--

CREATE TABLE `lecturer_result` (
  `lec_id` varchar(30) NOT NULL,
  `mod_id` varchar(30) NOT NULL,
  `submit_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `lecturer_result`
--

INSERT INTO `lecturer_result` (`lec_id`, `mod_id`, `submit_date`) VALUES
('ji6JL2yD70YnW5dCWdIKUKu3nQB2', 'CS2012', '2020-09-29 15:03:52'),
('ji6JL2yD70YnW5dCWdIKUKu3nQB2', 'CS2432', '2020-10-15 10:07:43'),
('zZun0os4YkRStobl6BnYjdLDTgU2', 'CS2012', '2020-09-29 15:20:26'),
('zZun0os4YkRStobl6BnYjdLDTgU2', 'CS2013', '2020-09-28 16:49:37'),
('zZun0os4YkRStobl6BnYjdLDTgU2', 'CS2432', '2020-10-15 10:42:05'),
('zZun0os4YkRStobl6BnYjdLDTgU2', 'CS2912', '2020-09-29 13:38:46');

-- --------------------------------------------------------

--
-- Table structure for table `module`
--

CREATE TABLE `module` (
  `mod_id` varchar(30) NOT NULL,
  `dep_id` varchar(30) NOT NULL,
  `lec_id` varchar(30) NOT NULL,
  `mod_name` varchar(30) NOT NULL,
  `mod_credit` int(1) NOT NULL,
  `semester` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `module`
--

INSERT INTO `module` (`mod_id`, `dep_id`, `lec_id`, `mod_name`, `mod_credit`, `semester`) VALUES
('CS2012', 'CS2016', '32inUy62tVywo9nH', 'Web Development', 2, 1),
('CS2013', 'SE2018', 'j2u1iP4hfjriEowp', 'Object Oriented Programming I', 3, 1),
('CS2432', 'SE2018', 'ji6JL2yD70YnW5dCWdIKUKu3nQB2', 'Object Oriented Programming I', 3, 3),
('CS2912', 'SE2018', 'zZun0os4YkRStobl6BnYjdLDTgU2', 'AI', 2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `result`
--

CREATE TABLE `result` (
  `st_id` varchar(30) NOT NULL,
  `mod_id` varchar(30) NOT NULL,
  `cas` varchar(30) NOT NULL,
  `es_1` varchar(30) NOT NULL,
  `es_2` varchar(30) NOT NULL,
  `final` varchar(30) NOT NULL,
  `mark` varchar(30) NOT NULL,
  `lastUpdate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `result`
--

INSERT INTO `result` (`st_id`, `mod_id`, `cas`, `es_1`, `es_2`, `final`, `mark`, `lastUpdate`) VALUES
('D/BCE/19/0002', 'CS2012', '', '', '42.75', '', '12,4,11,9,8,13', '2020-10-15 10:05:40'),
('D/BCE/19/0002', 'CS2432', '', '', '42.75', '', '12,4,11,9,8,13', '2020-10-15 10:07:43'),
('D/BCE/19/0002', 'CS2912', '', '', '42.75', '', '12,4,11,9,8,13', '2020-10-15 10:04:10'),
('D/BCE/19/0003', 'CS2012', '', '', '32.25', '', '14,0,3,10,5,11', '2020-10-15 10:05:40'),
('D/BCE/19/0003', 'CS2432', '', '', '32.25', '', '14,0,3,10,5,11', '2020-10-15 10:07:43'),
('D/BCE/19/0003', 'CS2912', '', '', '32.25', '', '14,0,3,10,5,11', '2020-10-15 10:04:10'),
('D/BCE/19/0004', 'CS2012', '', '45', '45', '45', '', '2020-09-29 15:08:20'),
('D/BCE/19/0004', 'CS2432', '', '', '32.25', '', '14,14,2,1,1,11', '2020-10-15 10:07:43'),
('D/BCE/19/0004', 'CS2912', '', '', '32.25', '', '14,14,2,1,1,11', '2020-10-15 10:04:10'),
('D/BCE/19/0005', 'CS2012', '', '', '41.25', '', '8,11,12,4,16,4', '2020-10-15 10:05:40'),
('D/BCE/19/0005', 'CS2432', '', '', '41.25', '', '8,11,12,4,16,4', '2020-10-15 10:07:43'),
('D/BCE/19/0005', 'CS2912', '', '', '41.25', '', '8,11,12,4,16,4', '2020-10-15 10:04:10'),
('D/BCE/19/0006', 'CS2012', '', '', '37.5', '', '3,9,11,14,8,5', '2020-10-15 10:05:40'),
('D/BCE/19/0006', 'CS2432', '', '', '37.5', '', '3,9,11,14,8,5', '2020-10-15 10:07:43'),
('D/BCE/19/0006', 'CS2912', '', '', '37.5', '', '3,9,11,14,8,5', '2020-10-15 10:04:10'),
('D/BCE/19/0007', 'CS2012', '', '', '39', '', '11,7,14,14,1,5', '2020-10-15 10:05:40'),
('D/BCE/19/0007', 'CS2432', '', '', '39', '', '11,7,14,14,1,5', '2020-10-15 10:07:43'),
('D/BCE/19/0007', 'CS2912', '', '', '39', '', '11,7,14,14,1,5', '2020-10-15 10:04:10'),
('D/BCE/19/0008', 'CS2012', '', '', '19.5', '', '4,1,5,2,12,2', '2020-10-15 10:05:40'),
('D/BCE/19/0008', 'CS2432', '', '', '19.5', '', '4,1,5,2,12,2', '2020-10-15 10:07:43'),
('D/BCE/19/0008', 'CS2912', '', '', '19.5', '', '4,1,5,2,12,2', '2020-10-15 10:04:10'),
('D/BCE/19/0009', 'CS2012', '', '', '33', '', '1,11,1,8,9,14', '2020-10-15 10:05:40'),
('D/BCE/19/0009', 'CS2432', '', '', '33', '', '1,11,1,8,9,14', '2020-10-15 10:07:43'),
('D/BCE/19/0009', 'CS2912', '', '', '33', '', '1,11,1,8,9,14', '2020-10-15 10:04:10'),
('D/BCE/19/0010', 'CS2012', '', '', '21', '', '11,1,2,3,0,11', '2020-10-15 10:05:40'),
('D/BCE/19/0010', 'CS2432', '', '', '21', '', '11,1,2,3,0,11', '2020-10-15 10:07:43'),
('D/BCE/19/0010', 'CS2912', '', '', '21', '', '11,1,2,3,0,11', '2020-10-15 10:04:10'),
('D/BCE/19/0011', 'CS2012', '', '', '40.5', '', '14,9,10,0,5,16', '2020-10-15 10:05:40'),
('D/BCE/19/0011', 'CS2432', '', '', '40.5', '', '14,9,10,0,5,16', '2020-10-15 10:07:43'),
('D/BCE/19/0011', 'CS2912', '', '', '40.5', '', '14,9,10,0,5,16', '2020-10-15 10:04:10'),
('D/BCE/19/0012', 'CS2012', '', '', '21.75', '', '4,0,4,1,4,16', '2020-10-15 10:05:40'),
('D/BCE/19/0012', 'CS2432', '', '', '21.75', '', '4,0,4,1,4,16', '2020-10-15 10:07:43'),
('D/BCE/19/0012', 'CS2912', '', '', '21.75', '', '4,0,4,1,4,16', '2020-10-15 10:04:10'),
('D/BCE/19/0013', 'CS2012', '', '', '24.75', '', '14,10,1,8,0,0', '2020-10-15 10:05:40'),
('D/BCE/19/0013', 'CS2432', '', '', '24.75', '', '14,10,1,8,0,0', '2020-10-15 10:07:43'),
('D/BCE/19/0013', 'CS2912', '', '', '24.75', '', '14,10,1,8,0,0', '2020-10-15 10:04:10'),
('D/BCS/19/0002', 'CS2012', '', '', '35.25', '', '2,10,15,4,2,14', '2020-10-15 10:05:40'),
('D/BCS/19/0002', 'CS2432', '', '', '35.25', '', '2,10,15,4,2,14', '2020-10-15 10:07:43'),
('D/BCS/19/0002', 'CS2912', '', '', '35.25', '', '2,10,15,4,2,14', '2020-10-15 10:04:10'),
('D/BCS/19/0003', 'CS2012', '', '', '39.75', '', '16,15,13,7,1,1', '2020-10-15 10:05:40'),
('D/BCS/19/0003', 'CS2432', '', '', '39.75', '', '16,15,13,7,1,1', '2020-10-15 10:07:43'),
('D/BCS/19/0003', 'CS2912', '', '', '39.75', '', '16,15,13,7,1,1', '2020-10-15 10:04:10'),
('D/BCS/19/0004', 'CS2012', '', '', '24', '', '5,2,0,12,7,6', '2020-10-15 10:05:40'),
('D/BCS/19/0004', 'CS2432', '', '', '24', '', '5,2,0,12,7,6', '2020-10-15 10:07:43'),
('D/BCS/19/0004', 'CS2912', '', '', '24', '', '5,2,0,12,7,6', '2020-10-15 10:04:10'),
('D/BCS/19/0005', 'CS2012', '', '', '37.5', '', '10,12,16,3,2,7', '2020-10-15 10:05:40'),
('D/BCS/19/0005', 'CS2432', '', '', '37.5', '', '10,12,16,3,2,7', '2020-10-15 10:07:43'),
('D/BCS/19/0005', 'CS2912', '', '', '37.5', '', '10,12,16,3,2,7', '2020-10-15 10:04:10'),
('D/BCS/19/0006', 'CS2012', '', '', '44.25', '', '16,3,7,16,4,13', '2020-10-15 10:05:40'),
('D/BCS/19/0006', 'CS2432', '', '', '44.25', '', '16,3,7,16,4,13', '2020-10-15 10:07:43'),
('D/BCS/19/0006', 'CS2912', '', '', '44.25', '', '16,3,7,16,4,13', '2020-10-15 10:04:10'),
('D/BCS/19/0007', 'CS2012', '', '', '27.75', '', '5,4,0,7,7,14', '2020-10-15 10:05:40'),
('D/BCS/19/0007', 'CS2432', '', '', '27.75', '', '5,4,0,7,7,14', '2020-10-15 10:07:43'),
('D/BCS/19/0007', 'CS2912', '', '', '27.75', '', '5,4,0,7,7,14', '2020-10-15 10:04:10'),
('D/BCS/19/0008', 'CS2012', '', '', '31.5', '', '5,14,5,0,11,7', '2020-10-15 10:05:40'),
('D/BCS/19/0008', 'CS2432', '', '', '31.5', '', '5,14,5,0,11,7', '2020-10-15 10:07:43'),
('D/BCS/19/0008', 'CS2912', '', '', '31.5', '', '5,14,5,0,11,7', '2020-10-15 10:04:10'),
('D/BCS/19/0009', 'CS2012', '', '', '30', '', '9,5,14,3,6,3', '2020-10-15 10:05:40'),
('D/BCS/19/0009', 'CS2432', '', '', '30', '', '9,5,14,3,6,3', '2020-10-15 10:07:43'),
('D/BCS/19/0009', 'CS2912', '', '', '30', '', '9,5,14,3,6,3', '2020-10-15 10:04:10'),
('D/BCS/19/0010', 'CS2012', '', '', '22.5', '', '8,5,5,5,7,0', '2020-10-15 10:05:40'),
('D/BCS/19/0010', 'CS2432', '', '', '22.5', '', '8,5,5,5,7,0', '2020-10-15 10:07:43'),
('D/BCS/19/0010', 'CS2912', '', '', '22.5', '', '8,5,5,5,7,0', '2020-10-15 10:04:10'),
('D/BCS/19/0011', 'CS2012', '', '', '30.75', '', '1,1,11,13,5,10', '2020-10-15 10:05:40'),
('D/BCS/19/0011', 'CS2432', '', '', '30.75', '', '1,1,11,13,5,10', '2020-10-15 10:07:43'),
('D/BCS/19/0011', 'CS2912', '', '', '30.75', '', '1,1,11,13,5,10', '2020-10-15 10:04:10'),
('D/BSE/18/0001', 'CS2012', '', '', '41.25', '', '11,16,12,11,0,3', '2020-09-29 15:08:20'),
('D/BSE/19/0001', 'CS2012', '', '', '62.25', '', '8,3,16,16,10,6', '2020-10-15 10:05:38'),
('D/BSE/19/0001', 'CS2013', '', '', '53', '', '6,7,4,15,13,2', '2020-10-06 06:40:05'),
('D/BSE/19/0001', 'CS2432', '', '', '62.25', '', '8,3,16,16,10,6', '2020-10-15 10:07:42'),
('D/BSE/19/0001', 'CS2912', '', '', '62.25', '', '8,3,16,16,10,6', '2020-10-14 16:28:15'),
('D/BSE/19/0004', 'CS2012', '', '', '47.25', '', '8,5,11,16,1,10', '2020-10-15 10:05:38'),
('D/BSE/19/0004', 'CS2013', '', '34', '34', '34', '', '2020-10-06 06:40:05'),
('D/BSE/19/0004', 'CS2432', '', '', '47.25', '', '8,5,11,16,1,10', '2020-10-15 10:07:42'),
('D/BSE/19/0004', 'CS2912', '', '', '47.25', '', '8,5,11,16,1,10', '2020-10-14 16:28:15'),
('D/BSE/19/0007', 'CS2012', '', '52', '52', '52', '', '2020-09-29 15:08:20'),
('D/BSE/19/0007', 'CS2013', '', '', '53', '', '6,3,4,15,10,4', '2020-10-06 06:40:05'),
('D/BSE/19/0007', 'CS2432', '', '', '51', '', '15,10,3,0,3,9', '2020-10-15 10:07:43'),
('D/BSE/19/0007', 'CS2912', '', '56', '56', '56', '', '2020-10-14 16:28:15'),
('D/BSE/19/0010', 'CS2012', '', '45', '45', '45', '', '2020-09-29 15:08:20'),
('D/BSE/19/0010', 'CS2013', '', '', '57', '', '16,0,2,14,2,15', '2020-10-06 06:40:05'),
('D/BSE/19/0010', 'CS2432', '', '', '58.75', '', '5,16,2,5,16,7', '2020-10-15 10:07:43'),
('D/BSE/19/0010', 'CS2912', '', '', '58.75', '', '5,16,2,5,16,7', '2020-10-14 16:28:15'),
('D/BSE/19/0013', 'CS2012', '', '52', '52', '52', '', '2020-09-29 15:08:21'),
('D/BSE/19/0013', 'CS2013', '', '30.75', '31', '', '2,2,9,15,3,1', '2020-10-06 06:40:05'),
('D/BSE/19/0013', 'CS2432', '', '32.25', '32.25', '32.25', '', '2020-10-15 10:07:43'),
('D/BSE/19/0013', 'CS2912', '', '', '32.25', '', '12,13,1,0,1,7', '2020-10-14 16:28:15'),
('D/BSE/19/0016', 'CS2012', '', '34', '34', '34', '', '2020-09-29 15:08:20'),
('D/BSE/19/0016', 'CS2013', '', '', '52', '', '13,13,0,16,12,13', '2020-10-06 06:40:05'),
('D/BSE/19/0016', 'CS2432', '', '', '30.5', '', '7,2,1,9,15,4', '2020-10-15 10:07:43'),
('D/BSE/19/0016', 'CS2912', '', '', '30.5', '', '7,2,1,9,15,4', '2020-10-14 16:28:15'),
('D/BSE/19/0019', 'CS2012', '', '35', '43.5', '', '7,7,13,13,3,15', '2020-09-29 15:08:20'),
('D/BSE/19/0019', 'CS2013', '', '', '32', '', '2,12,1,9,8,10', '2020-10-06 06:40:05'),
('D/BSE/19/0019', 'CS2432', '', '', '43.5', '', '7,7,13,13,3,15', '2020-10-15 10:07:43'),
('D/BSE/19/0019', 'CS2912', '', '', '43.5', '', '7,7,13,13,3,15', '2020-10-14 16:28:15'),
('D/BSE/19/0022', 'CS2012', '', '38', '54.75', '', '14,12,15,5,14,1', '2020-09-29 15:08:21'),
('D/BSE/19/0022', 'CS2013', '', '45', '45', '45', '', '2020-10-06 06:40:05'),
('D/BSE/19/0022', 'CS2432', '', '', '54.75', '', '14,12,15,5,14,1', '2020-10-15 10:07:43'),
('D/BSE/19/0022', 'CS2912', '', '', '54.75', '', '14,12,15,5,14,1', '2020-10-14 16:28:15'),
('D/BSE/19/0025', 'CS2012', '', '54.5', '60.5', '', '16,1,15,2,14,16', '2020-09-29 15:08:21'),
('D/BSE/19/0025', 'CS2013', '', '50', '50', '50', '', '2020-10-06 06:40:05'),
('D/BSE/19/0025', 'CS2432', '', '', '60.5', '', '16,1,15,2,14,16', '2020-10-15 10:07:43'),
('D/BSE/19/0025', 'CS2912', '', '', '60.5', '', '16,1,15,2,14,16', '2020-10-14 16:28:15'),
('D/BSE/19/0028', 'CS2012', '', '53.5', '62.5', '', '12,12,11,10,2,9', '2020-09-29 15:08:21'),
('D/BSE/19/0028', 'CS2013', '', '51', '51.25', '', '0,15,8,3,5,10', '2020-10-06 06:40:05'),
('D/BSE/19/0028', 'CS2432', '', '', '62.5', '', '12,12,11,10,2,9', '2020-10-15 10:07:43'),
('D/BSE/19/0028', 'CS2912', '', '53.5', '62.5', '', '12,12,11,10,2,9', '2020-10-14 16:28:15'),
('D/BSE/19/0031', 'CS2012', '', '66.75', '31.5', '', '7,0,6,3,0,6', '2020-09-29 15:08:21'),
('D/BSE/19/0031', 'CS2013', '', '52', '51.75', '', '5,14,0,13,4,13', '2020-10-06 06:40:05'),
('D/BSE/19/0031', 'CS2432', '', '', '31.5', '', '7,0,6,3,0,6', '2020-10-15 10:07:43'),
('D/BSE/19/0031', 'CS2912', '', '66.75', '31.5', '', '7,0,6,3,0,6', '2020-10-14 16:28:15'),
('D/BSE/19/0034', 'CS2012', '', '40', '58.75', '', '4,15,11,5,10,7', '2020-09-29 15:08:21'),
('D/BSE/19/0034', 'CS2013', '', '', '63', '', '8,3,9,16,15,7', '2020-10-06 06:40:05'),
('D/BSE/19/0034', 'CS2432', '', '', '58.75', '', '4,15,11,5,10,7', '2020-10-15 10:07:42'),
('D/BSE/19/0034', 'CS2912', '', '40', '58.75', '', '4,15,11,5,10,7', '2020-10-14 16:28:15'),
('D/BSE/19/0037', 'CS2012', '', '49.25', '52.25', '', '13,7,11,7,0,15', '2020-09-29 15:08:21'),
('D/BSE/19/0037', 'CS2013', '', '', '61', '', '9,16,15,9,16,0', '2020-10-06 06:40:05'),
('D/BSE/19/0037', 'CS2432', '', '', '52.25', '', '13,7,11,7,0,15', '2020-10-15 10:07:42'),
('D/BSE/19/0037', 'CS2912', '', '', '52.25', '', '13,7,11,7,0,15', '2020-10-14 16:28:15'),
('D/BSE/19/0040', 'CS2012', '', '44.5', '47.5', '', '5,15,6,0,16,13', '2020-09-29 15:08:21'),
('D/BSE/19/0040', 'CS2013', '', '', '46', '', '3,5,14,10,12,9', '2020-10-06 06:40:05'),
('D/BSE/19/0040', 'CS2432', '', '', '47.5', '', '5,15,6,0,16,13', '2020-10-15 10:07:42'),
('D/BSE/19/0040', 'CS2912', '', '', '47.5', '', '5,15,6,0,16,13', '2020-10-14 16:28:15'),
('D/BSE/19/0043', 'CS2012', '', '52.25', '55.25', '', '8,0,7,13,15,6', '2020-09-29 15:08:22'),
('D/BSE/19/0043', 'CS2013', '', '', '40', '', '7,7,5,3,5,2', '2020-10-06 06:40:05'),
('D/BSE/19/0043', 'CS2432', '', '', '55.25', '', '8,0,7,13,15,6', '2020-10-15 10:07:42'),
('D/BSE/19/0043', 'CS2912', '', '', '55.25', '', '8,0,7,13,15,6', '2020-10-14 16:28:15'),
('D/BSE/19/0046', 'CS2012', '', '46', '43.75', '', '16,6,2,5,8,13', '2020-09-29 15:08:21'),
('D/BSE/19/0046', 'CS2013', '', '', '49', '', '13,1,12,8,12,11', '2020-10-06 06:40:05'),
('D/BSE/19/0046', 'CS2432', '', '', '43.75', '', '16,6,2,5,8,13', '2020-10-15 10:07:43'),
('D/BSE/19/0046', 'CS2912', '', '', '43.75', '', '16,6,2,5,8,13', '2020-10-14 16:28:15'),
('D/BSE/19/0049', 'CS2012', '', '36.25', '54.25', '', '9,8,16,6,5,11', '2020-09-29 15:08:22'),
('D/BSE/19/0049', 'CS2013', '', '', '35', '', '1,11,8,7,1,1', '2020-10-06 06:40:05'),
('D/BSE/19/0049', 'CS2432', '', '', '54.25', '', '9,8,16,6,5,11', '2020-10-15 10:07:43'),
('D/BSE/19/0049', 'CS2912', '', '', '54.25', '', '9,8,16,6,5,11', '2020-10-14 16:28:15'),
('D/BSE/19/0052', 'CS2012', '', '66.5', '56', '', '14,16,6,1,5,15', '2020-09-29 15:08:21'),
('D/BSE/19/0052', 'CS2013', '', '', '49', '', '2,3,16,8,7,11', '2020-10-06 06:40:05'),
('D/BSE/19/0052', 'CS2432', '', '', '56', '', '14,16,6,1,5,15', '2020-10-15 10:07:43'),
('D/BSE/19/0052', 'CS2912', '', '', '56', '', '14,16,6,1,5,15', '2020-10-14 16:28:15'),
('D/BSE/19/0055', 'CS2012', '', '40', '34', '', '4,2,9,3,10,2', '2020-09-29 15:08:22'),
('D/BSE/19/0055', 'CS2013', '', '', '53', '', '7,15,10,3,13,7', '2020-10-06 06:40:05'),
('D/BSE/19/0055', 'CS2432', '', '', '34', '', '4,2,9,3,10,2', '2020-10-15 10:07:43'),
('D/BSE/19/0055', 'CS2912', '', '', '34', '', '4,2,9,3,10,2', '2020-10-14 16:28:15'),
('D/BSE/19/0058', 'CS2012', '', '42.75', '42', '', '9,1,5,3,15,10', '2020-09-29 15:08:22'),
('D/BSE/19/0058', 'CS2013', '', '', '35', '', '2,9,4,6,10,2', '2020-10-06 06:40:05'),
('D/BSE/19/0058', 'CS2432', '', '', '42', '', '9,1,5,3,15,10', '2020-10-15 10:07:43'),
('D/BSE/19/0058', 'CS2912', '', '', '42', '', '9,1,5,3,15,10', '2020-10-14 16:28:15'),
('D/BSE/19/0061', 'CS2012', '', '51.75', '45.75', '', '4,4,12,6,7,2', '2020-09-29 15:08:22'),
('D/BSE/19/0061', 'CS2013', '', '', '54', '', '14,15,1,5,7,4', '2020-10-06 06:40:05'),
('D/BSE/19/0061', 'CS2432', '', '', '45.75', '', '4,4,12,6,7,2', '2020-10-15 10:07:43'),
('D/BSE/19/0061', 'CS2912', '', '', '45.75', '', '4,4,12,6,7,2', '2020-10-14 16:28:15'),
('D/BSE/19/0064', 'CS2012', '', '37.5', '66', '', '13,10,12,5,9,12', '2020-09-29 15:08:22'),
('D/BSE/19/0064', 'CS2013', '', '', '55', '', '3,10,2,13,8,10', '2020-10-06 06:40:05'),
('D/BSE/19/0064', 'CS2432', '', '', '66', '', '13,10,12,5,9,12', '2020-10-15 10:07:43'),
('D/BSE/19/0064', 'CS2912', '', '', '66', '', '13,10,12,5,9,12', '2020-10-14 16:28:15'),
('D/BSE/19/0067', 'CS2012', '', '37', '28', '', '4,8,6,3,5,8', '2020-09-29 15:08:22'),
('D/BSE/19/0067', 'CS2013', '', '', '30', '', '11,3,10,11,0,2', '2020-10-06 06:40:05'),
('D/BSE/19/0067', 'CS2432', '', '', '28', '', '4,8,6,3,5,8', '2020-10-15 10:07:43'),
('D/BSE/19/0067', 'CS2912', '', '', '28', '', '4,8,6,3,5,8', '2020-10-14 16:28:15'),
('D/BSE/19/0070', 'CS2012', '', '64.25', '66.5', '', '13,12,6,6,11,13', '2020-09-29 15:08:22'),
('D/BSE/19/0070', 'CS2013', '', '', '67', '', '7,0,8,16,15,16', '2020-10-06 06:40:05'),
('D/BSE/19/0070', 'CS2432', '', '', '66.5', '', '13,12,6,6,11,13', '2020-10-15 10:07:43'),
('D/BSE/19/0070', 'CS2912', '', '', '66.5', '', '13,12,6,6,11,13', '2020-10-14 16:28:15'),
('D/BSE/19/0073', 'CS2012', '', '62.5', '46.75', '', '13,7,6,0,0,5', '2020-09-29 15:08:22'),
('D/BSE/19/0073', 'CS2013', '', '', '70', '', '16,11,6,16,3,10', '2020-10-06 06:40:05'),
('D/BSE/19/0073', 'CS2432', '', '', '46.75', '', '13,7,6,0,0,5', '2020-10-15 10:07:43'),
('D/BSE/19/0073', 'CS2912', '', '', '46.75', '', '13,7,6,0,0,5', '2020-10-14 16:28:15'),
('D/BSE/19/0076', 'CS2012', '', '32.5', '23.5', '', '16,1,1,9,1,3', '2020-09-29 15:08:22'),
('D/BSE/19/0076', 'CS2013', '', '', '53', '', '8,6,15,16,16,9', '2020-10-06 06:40:05'),
('D/BSE/19/0076', 'CS2432', '', '', '23.5', '', '16,1,1,9,1,3', '2020-10-15 10:07:43'),
('D/BSE/19/0076', 'CS2912', '', '', '23.5', '', '16,1,1,9,1,3', '2020-10-14 16:28:15'),
('D/BSE/19/0079', 'CS2012', '', '41.5', '31.75', '', '1,16,0,8,4,8', '2020-09-29 15:08:22'),
('D/BSE/19/0079', 'CS2013', '', '', '47', '', '16,4,9,15,4,9', '2020-10-06 06:40:05'),
('D/BSE/19/0079', 'CS2432', '', '', '31.75', '', '1,16,0,8,4,8', '2020-10-15 10:07:43'),
('D/BSE/19/0079', 'CS2912', '', '', '31.75', '', '1,16,0,8,4,8', '2020-10-14 16:28:15'),
('D/BSE/19/0082', 'CS2012', '', '63', '52.5', '', '6,0,8,13,11,4', '2020-09-29 15:08:22'),
('D/BSE/19/0082', 'CS2013', '', '', '65', '', '6,12,11,10,6,13', '2020-10-06 06:40:05'),
('D/BSE/19/0082', 'CS2432', '', '', '52.5', '', '6,0,8,13,11,4', '2020-10-15 10:07:43'),
('D/BSE/19/0082', 'CS2912', '', '', '52.5', '', '6,0,8,13,11,4', '2020-10-14 16:28:15'),
('D/BSE/19/0085', 'CS2012', '', '', '33.75', '', '15,5,4,2,4,15', '2020-10-15 10:05:40'),
('D/BSE/19/0085', 'CS2432', '', '', '33.75', '', '15,5,4,2,4,15', '2020-10-15 10:07:43'),
('D/BSE/19/0085', 'CS2912', '', '', '33.75', '', '15,5,4,2,4,15', '2020-10-15 10:04:10');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `uid` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `role` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`uid`, `email`, `role`) VALUES
('zZun0os4YkRStobl6BnYjdLDTgU2', 'ppramudhi@ymail.com', 2);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `std_id` varchar(30) NOT NULL,
  `std_name` varchar(30) NOT NULL,
  `std_email` varchar(30) NOT NULL,
  `std_phone` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `uid` varchar(30) NOT NULL,
  `displayName` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `photoURL` varchar(60) NOT NULL,
  `lastUpdate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`uid`, `displayName`, `email`, `photoURL`, `lastUpdate`) VALUES
('ji6JL2yD70YnW5dCWdIKUKu3nQB2', 'Tharindi Hansika', 'cgtharindi@gmail.com', 'https://lh3.googleusercontent.com/a-/AOh14GgB4KKQakFd5pul5pn', '2020-10-15 10:17:01'),
('Ls5DlM7fntRwWwYffxbTeWAw1HI3', 'Chamath Wanigasooriya', 'chamathwanigasooriya@gmail.com', 'https://lh3.googleusercontent.com/a-/AOh14Gimey8V7t-lkpis_Lc', '2020-10-15 11:03:47'),
('mJtVUbjnQGW8Fkvtmhdk3iqtj932', '', 'aceghost360@gmail.com', '', '2020-09-28 16:52:40'),
('zZun0os4YkRStobl6BnYjdLDTgU2', '', 'ppramudhi@ymail.com', '', '2020-10-15 10:41:48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`dept_id`);

--
-- Indexes for table `lecturer`
--
ALTER TABLE `lecturer`
  ADD PRIMARY KEY (`lec_id`);

--
-- Indexes for table `lecturer_result`
--
ALTER TABLE `lecturer_result`
  ADD PRIMARY KEY (`lec_id`,`mod_id`);

--
-- Indexes for table `module`
--
ALTER TABLE `module`
  ADD PRIMARY KEY (`mod_id`,`lec_id`);

--
-- Indexes for table `result`
--
ALTER TABLE `result`
  ADD PRIMARY KEY (`st_id`,`mod_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`uid`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`std_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`uid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
