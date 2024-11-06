-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 06, 2024 at 05:29 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_attendance`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `fullname` varchar(25) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `fullname`, `email`, `password`) VALUES
(1, 'Charls Opiso', 'vargas02@gmail.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `attendance_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `check_in_time` time DEFAULT NULL,
  `check_out_time` time DEFAULT NULL,
  `status` enum('on-time','late','early departure') DEFAULT 'on-time',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `event_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`attendance_id`, `student_id`, `check_in_time`, `check_out_time`, `status`, `created_at`, `event_id`) VALUES
(1, 2, '10:02:00', '10:02:05', 'on-time', '2024-09-07 02:02:00', 3);

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `event_id` int(11) NOT NULL,
  `event_name` varchar(100) NOT NULL,
  `event_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `event_start_time` datetime NOT NULL,
  `event_end_time` datetime NOT NULL,
  `isActive` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`event_id`, `event_name`, `event_date`, `created_at`, `event_start_time`, `event_end_time`, `isActive`) VALUES
(1, 'Dance event', '0000-00-00', '2024-09-06 15:25:28', '2024-09-06 08:00:00', '2024-09-06 17:00:00', 1),
(2, 'Programming event', '0000-00-00', '2024-09-07 01:25:18', '2024-09-07 08:00:00', '2024-09-07 17:00:00', 1),
(3, 'Singing event', '0000-00-00', '2024-09-07 02:01:38', '2024-09-07 09:00:00', '2024-09-07 17:00:00', 1),
(4, 'Speed typing event', '0000-00-00', '2024-09-07 12:13:58', '2024-09-07 08:00:00', '2024-09-07 22:00:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `student_number` varchar(20) NOT NULL,
  `contact_information` varchar(50) DEFAULT NULL,
  `tribu_id` int(11) DEFAULT NULL,
  `year_level` tinyint(4) DEFAULT NULL CHECK (`year_level` between 1 and 4),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `name`, `student_number`, `contact_information`, `tribu_id`, `year_level`, `created_at`, `password`) VALUES
(1, 'Kenneth Pacaldo', '02-1928-02191', 'pacaldo@gmail.com', 2, 4, '2024-09-06 15:23:22', ''),
(2, 'Nhor Binasing', '02-1920-02888', 'binasing@gmail.com', 4, 4, '2024-09-06 16:30:03', ''),
(3, 'Pitok Batolata', '02-1920-02999', 'pitok@gmail.com', 3, 3, '2024-09-07 12:15:12', '');

-- --------------------------------------------------------

--
-- Table structure for table `tribus`
--

CREATE TABLE `tribus` (
  `tribu_id` int(11) NOT NULL,
  `tribu_name` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tribus`
--

INSERT INTO `tribus` (`tribu_id`, `tribu_name`, `created_at`) VALUES
(1, 'Magic', '2024-09-03 14:23:50'),
(2, 'Mage', '2024-09-03 14:24:03'),
(3, 'Tank', '2024-09-03 14:24:03'),
(4, 'Assasin', '2024-09-04 02:31:01');

-- --------------------------------------------------------

--
-- Table structure for table `year_levels`
--

CREATE TABLE `year_levels` (
  `year_level` tinyint(4) NOT NULL,
  `description` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `year_levels`
--

INSERT INTO `year_levels` (`year_level`, `description`) VALUES
(1, 'First Year'),
(2, 'Second Year'),
(3, 'Third Year'),
(4, 'Fourth Year');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`attendance_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`event_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `student_number` (`student_number`),
  ADD KEY `year_level` (`year_level`),
  ADD KEY `tribu_id` (`tribu_id`);

--
-- Indexes for table `tribus`
--
ALTER TABLE `tribus`
  ADD PRIMARY KEY (`tribu_id`),
  ADD UNIQUE KEY `tribu_name` (`tribu_name`);

--
-- Indexes for table `year_levels`
--
ALTER TABLE `year_levels`
  ADD PRIMARY KEY (`year_level`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `attendance_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tribus`
--
ALTER TABLE `tribus`
  MODIFY `tribu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`);

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`year_level`) REFERENCES `year_levels` (`year_level`),
  ADD CONSTRAINT `students_ibfk_2` FOREIGN KEY (`tribu_id`) REFERENCES `tribus` (`tribu_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
