-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 06, 2026 at 08:26 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `scheduling_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL,
  `reference_no` varchar(30) NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `slot_id` int(11) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `notes` varchar(500) DEFAULT NULL,
  `status` enum('pending','confirmed','completed','cancelled','no_show') NOT NULL DEFAULT 'pending',
  `cancel_reason` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`id`, `reference_no`, `user_id`, `course_id`, `service_id`, `slot_id`, `appointment_date`, `appointment_time`, `notes`, `status`, `cancel_reason`, `created_at`, `updated_at`) VALUES
(1, 'NCST-20261006-00001', 3, 1, 1, 266, '2026-10-30', '15:30:00', 'Enrllment for 2nd sem', 'confirmed', NULL, '2026-10-05 20:54:23', '2026-10-05 20:54:44');

-- --------------------------------------------------------

--
-- Table structure for table `appointment_history`
--

CREATE TABLE `appointment_history` (
  `id` int(11) NOT NULL,
  `appointment_id` int(11) NOT NULL,
  `old_status` varchar(20) DEFAULT NULL,
  `new_status` varchar(20) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointment_history`
--

INSERT INTO `appointment_history` (`id`, `appointment_id`, `old_status`, `new_status`, `changed_by`, `note`, `created_at`) VALUES
(1, 1, NULL, 'pending', 3, 'Appointment booked', '2026-10-05 20:54:23'),
(2, 1, 'pending', 'confirmed', 4, '', '2026-10-05 20:54:44');

-- --------------------------------------------------------

--
-- Table structure for table `blocked_dates`
--

CREATE TABLE `blocked_dates` (
  `id` int(11) NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `blocked_date` date NOT NULL,
  `reason` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `code` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `code`, `name`, `description`, `is_active`, `created_at`) VALUES
(1, 'BSCpE', 'Computer Engineering', '', 1, '2026-10-05 20:09:43'),
(2, 'BSIT', 'Information Technology', NULL, 1, '2026-10-05 20:09:43'),
(3, 'BSCS', 'Computer Science', NULL, 1, '2026-10-05 20:09:43'),
(4, 'BSBA', 'Business Administration', NULL, 1, '2026-10-05 20:09:43'),
(5, 'BSA', 'Accountancy', NULL, 1, '2026-10-05 20:09:43'),
(6, 'BSED', 'Education', NULL, 1, '2026-10-05 20:09:43'),
(7, 'BSHM', 'Hospitality Management', NULL, 1, '2026-10-05 20:09:43'),
(8, 'BSTM', 'Tourism Management', NULL, 1, '2026-10-05 20:09:43'),
(9, 'BSCrim', 'Criminology', NULL, 1, '2026-10-05 20:09:43'),
(10, 'BSPsy', 'Psychology', NULL, 1, '2026-10-05 20:09:43'),
(12, 'OTHER', 'Other Programs', NULL, 1, '2026-10-05 20:09:43');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `message`, `is_read`, `created_at`) VALUES
(1, 3, 'Your appointment NCST-20261006-00001 has been booked and is waiting for confirmation.', 0, '2026-10-05 20:54:23'),
(2, 3, 'Your appointment NCST-20261006-00001 is now Confirmed.', 0, '2026-10-05 20:54:44');

-- --------------------------------------------------------

--
-- Table structure for table `schedules`
--

CREATE TABLE `schedules` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `schedule_date` date NOT NULL,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedules`
--

INSERT INTO `schedules` (`id`, `course_id`, `service_id`, `schedule_date`, `is_open`, `created_at`) VALUES
(1, 1, 1, '2026-10-06', 1, '2026-10-05 20:52:31'),
(2, 1, 1, '2026-10-07', 1, '2026-10-05 20:52:31'),
(3, 1, 1, '2026-10-08', 1, '2026-10-05 20:52:31'),
(4, 1, 1, '2026-10-09', 1, '2026-10-05 20:52:31'),
(5, 1, 1, '2026-10-12', 1, '2026-10-05 20:52:31'),
(6, 1, 1, '2026-10-13', 1, '2026-10-05 20:52:31'),
(7, 1, 1, '2026-10-14', 1, '2026-10-05 20:52:31'),
(8, 1, 1, '2026-10-15', 1, '2026-10-05 20:52:31'),
(9, 1, 1, '2026-10-16', 1, '2026-10-05 20:52:31'),
(10, 1, 1, '2026-10-19', 1, '2026-10-05 20:52:31'),
(11, 1, 1, '2026-10-20', 1, '2026-10-05 20:52:31'),
(12, 1, 1, '2026-10-21', 1, '2026-10-05 20:52:31'),
(13, 1, 1, '2026-10-22', 1, '2026-10-05 20:52:31'),
(14, 1, 1, '2026-10-23', 1, '2026-10-05 20:52:31'),
(15, 1, 1, '2026-10-26', 1, '2026-10-05 20:52:31'),
(16, 1, 1, '2026-10-27', 1, '2026-10-05 20:52:31'),
(17, 1, 1, '2026-10-28', 1, '2026-10-05 20:52:31'),
(18, 1, 1, '2026-10-29', 1, '2026-10-05 20:52:31'),
(19, 1, 1, '2026-10-30', 1, '2026-10-05 20:52:31');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `course_id`, `name`, `description`, `is_active`, `created_at`) VALUES
(1, NULL, 'Enrollment', 'Enrollment and re-enrollment assistance', 1, '2026-10-05 20:09:43'),
(2, NULL, 'Academic Advising', 'Subject load and academic planning', 1, '2026-10-05 20:09:43'),
(3, NULL, 'Course Registration', 'Adding, dropping or changing subjects', 1, '2026-10-05 20:09:43'),
(4, NULL, 'Document Request', 'Certificates and other school documents', 1, '2026-10-05 20:09:43'),
(5, NULL, 'Transcript Request', 'Transcript of Records processing', 1, '2026-10-05 20:09:43'),
(6, NULL, 'Student Records', 'Updating or verifying student records', 1, '2026-10-05 20:09:43'),
(7, NULL, 'Clearance', 'Student clearance signing', 1, '2026-10-05 20:09:43'),
(8, NULL, 'Consultation', 'One-on-one consultation', 1, '2026-10-05 20:09:43'),
(9, NULL, 'Department Inquiry', 'General department concerns', 1, '2026-10-05 20:09:43'),
(10, NULL, 'Other', 'Other concerns', 1, '2026-10-05 20:09:43');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `setting_key` varchar(50) NOT NULL,
  `setting_value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`setting_key`, `setting_value`) VALUES
('allow_reschedule', '1'),
('booking_window_days', '60'),
('cancel_cutoff_hours', '24'),
('max_active_appointments', '3');

-- --------------------------------------------------------

--
-- Table structure for table `supervisors`
--

CREATE TABLE `supervisors` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supervisors`
--

INSERT INTO `supervisors` (`id`, `user_id`, `course_id`) VALUES
(1, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `time_slots`
--

CREATE TABLE `time_slots` (
  `id` int(11) NOT NULL,
  `schedule_id` int(11) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `capacity` int(11) NOT NULL DEFAULT 5,
  `current_bookings` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `time_slots`
--

INSERT INTO `time_slots` (`id`, `schedule_id`, `start_time`, `end_time`, `capacity`, `current_bookings`, `is_active`) VALUES
(1, 1, '09:00:00', '09:30:00', 5, 0, 1),
(2, 1, '09:30:00', '10:00:00', 5, 0, 1),
(3, 1, '10:00:00', '10:30:00', 5, 0, 1),
(4, 1, '10:30:00', '11:00:00', 5, 0, 1),
(5, 1, '11:00:00', '11:30:00', 5, 0, 1),
(6, 1, '11:30:00', '12:00:00', 5, 0, 1),
(7, 1, '12:00:00', '12:30:00', 5, 0, 1),
(8, 1, '12:30:00', '13:00:00', 5, 0, 1),
(9, 1, '13:00:00', '13:30:00', 5, 0, 1),
(10, 1, '13:30:00', '14:00:00', 5, 0, 1),
(11, 1, '14:00:00', '14:30:00', 5, 0, 1),
(12, 1, '14:30:00', '15:00:00', 5, 0, 1),
(13, 1, '15:00:00', '15:30:00', 5, 0, 1),
(14, 1, '15:30:00', '16:00:00', 5, 0, 1),
(15, 2, '09:00:00', '09:30:00', 5, 0, 1),
(16, 2, '09:30:00', '10:00:00', 5, 0, 1),
(17, 2, '10:00:00', '10:30:00', 5, 0, 1),
(18, 2, '10:30:00', '11:00:00', 5, 0, 1),
(19, 2, '11:00:00', '11:30:00', 5, 0, 1),
(20, 2, '11:30:00', '12:00:00', 5, 0, 1),
(21, 2, '12:00:00', '12:30:00', 5, 0, 1),
(22, 2, '12:30:00', '13:00:00', 5, 0, 1),
(23, 2, '13:00:00', '13:30:00', 5, 0, 1),
(24, 2, '13:30:00', '14:00:00', 5, 0, 1),
(25, 2, '14:00:00', '14:30:00', 5, 0, 1),
(26, 2, '14:30:00', '15:00:00', 5, 0, 1),
(27, 2, '15:00:00', '15:30:00', 5, 0, 1),
(28, 2, '15:30:00', '16:00:00', 5, 0, 1),
(29, 3, '09:00:00', '09:30:00', 5, 0, 1),
(30, 3, '09:30:00', '10:00:00', 5, 0, 1),
(31, 3, '10:00:00', '10:30:00', 5, 0, 1),
(32, 3, '10:30:00', '11:00:00', 5, 0, 1),
(33, 3, '11:00:00', '11:30:00', 5, 0, 1),
(34, 3, '11:30:00', '12:00:00', 5, 0, 1),
(35, 3, '12:00:00', '12:30:00', 5, 0, 1),
(36, 3, '12:30:00', '13:00:00', 5, 0, 1),
(37, 3, '13:00:00', '13:30:00', 5, 0, 1),
(38, 3, '13:30:00', '14:00:00', 5, 0, 1),
(39, 3, '14:00:00', '14:30:00', 5, 0, 1),
(40, 3, '14:30:00', '15:00:00', 5, 0, 1),
(41, 3, '15:00:00', '15:30:00', 5, 0, 1),
(42, 3, '15:30:00', '16:00:00', 5, 0, 1),
(43, 4, '09:00:00', '09:30:00', 5, 0, 1),
(44, 4, '09:30:00', '10:00:00', 5, 0, 1),
(45, 4, '10:00:00', '10:30:00', 5, 0, 1),
(46, 4, '10:30:00', '11:00:00', 5, 0, 1),
(47, 4, '11:00:00', '11:30:00', 5, 0, 1),
(48, 4, '11:30:00', '12:00:00', 5, 0, 1),
(49, 4, '12:00:00', '12:30:00', 5, 0, 1),
(50, 4, '12:30:00', '13:00:00', 5, 0, 1),
(51, 4, '13:00:00', '13:30:00', 5, 0, 1),
(52, 4, '13:30:00', '14:00:00', 5, 0, 1),
(53, 4, '14:00:00', '14:30:00', 5, 0, 1),
(54, 4, '14:30:00', '15:00:00', 5, 0, 1),
(55, 4, '15:00:00', '15:30:00', 5, 0, 1),
(56, 4, '15:30:00', '16:00:00', 5, 0, 1),
(57, 5, '09:00:00', '09:30:00', 5, 0, 1),
(58, 5, '09:30:00', '10:00:00', 5, 0, 1),
(59, 5, '10:00:00', '10:30:00', 5, 0, 1),
(60, 5, '10:30:00', '11:00:00', 5, 0, 1),
(61, 5, '11:00:00', '11:30:00', 5, 0, 1),
(62, 5, '11:30:00', '12:00:00', 5, 0, 1),
(63, 5, '12:00:00', '12:30:00', 5, 0, 1),
(64, 5, '12:30:00', '13:00:00', 5, 0, 1),
(65, 5, '13:00:00', '13:30:00', 5, 0, 1),
(66, 5, '13:30:00', '14:00:00', 5, 0, 1),
(67, 5, '14:00:00', '14:30:00', 5, 0, 1),
(68, 5, '14:30:00', '15:00:00', 5, 0, 1),
(69, 5, '15:00:00', '15:30:00', 5, 0, 1),
(70, 5, '15:30:00', '16:00:00', 5, 0, 1),
(71, 6, '09:00:00', '09:30:00', 5, 0, 1),
(72, 6, '09:30:00', '10:00:00', 5, 0, 1),
(73, 6, '10:00:00', '10:30:00', 5, 0, 1),
(74, 6, '10:30:00', '11:00:00', 5, 0, 1),
(75, 6, '11:00:00', '11:30:00', 5, 0, 1),
(76, 6, '11:30:00', '12:00:00', 5, 0, 1),
(77, 6, '12:00:00', '12:30:00', 5, 0, 1),
(78, 6, '12:30:00', '13:00:00', 5, 0, 1),
(79, 6, '13:00:00', '13:30:00', 5, 0, 1),
(80, 6, '13:30:00', '14:00:00', 5, 0, 1),
(81, 6, '14:00:00', '14:30:00', 5, 0, 1),
(82, 6, '14:30:00', '15:00:00', 5, 0, 1),
(83, 6, '15:00:00', '15:30:00', 5, 0, 1),
(84, 6, '15:30:00', '16:00:00', 5, 0, 1),
(85, 7, '09:00:00', '09:30:00', 5, 0, 1),
(86, 7, '09:30:00', '10:00:00', 5, 0, 1),
(87, 7, '10:00:00', '10:30:00', 5, 0, 1),
(88, 7, '10:30:00', '11:00:00', 5, 0, 1),
(89, 7, '11:00:00', '11:30:00', 5, 0, 1),
(90, 7, '11:30:00', '12:00:00', 5, 0, 1),
(91, 7, '12:00:00', '12:30:00', 5, 0, 1),
(92, 7, '12:30:00', '13:00:00', 5, 0, 1),
(93, 7, '13:00:00', '13:30:00', 5, 0, 1),
(94, 7, '13:30:00', '14:00:00', 5, 0, 1),
(95, 7, '14:00:00', '14:30:00', 5, 0, 1),
(96, 7, '14:30:00', '15:00:00', 5, 0, 1),
(97, 7, '15:00:00', '15:30:00', 5, 0, 1),
(98, 7, '15:30:00', '16:00:00', 5, 0, 1),
(99, 8, '09:00:00', '09:30:00', 5, 0, 1),
(100, 8, '09:30:00', '10:00:00', 5, 0, 1),
(101, 8, '10:00:00', '10:30:00', 5, 0, 1),
(102, 8, '10:30:00', '11:00:00', 5, 0, 1),
(103, 8, '11:00:00', '11:30:00', 5, 0, 1),
(104, 8, '11:30:00', '12:00:00', 5, 0, 1),
(105, 8, '12:00:00', '12:30:00', 5, 0, 1),
(106, 8, '12:30:00', '13:00:00', 5, 0, 1),
(107, 8, '13:00:00', '13:30:00', 5, 0, 1),
(108, 8, '13:30:00', '14:00:00', 5, 0, 1),
(109, 8, '14:00:00', '14:30:00', 5, 0, 1),
(110, 8, '14:30:00', '15:00:00', 5, 0, 1),
(111, 8, '15:00:00', '15:30:00', 5, 0, 1),
(112, 8, '15:30:00', '16:00:00', 5, 0, 1),
(113, 9, '09:00:00', '09:30:00', 5, 0, 1),
(114, 9, '09:30:00', '10:00:00', 5, 0, 1),
(115, 9, '10:00:00', '10:30:00', 5, 0, 1),
(116, 9, '10:30:00', '11:00:00', 5, 0, 1),
(117, 9, '11:00:00', '11:30:00', 5, 0, 1),
(118, 9, '11:30:00', '12:00:00', 5, 0, 1),
(119, 9, '12:00:00', '12:30:00', 5, 0, 1),
(120, 9, '12:30:00', '13:00:00', 5, 0, 1),
(121, 9, '13:00:00', '13:30:00', 5, 0, 1),
(122, 9, '13:30:00', '14:00:00', 5, 0, 1),
(123, 9, '14:00:00', '14:30:00', 5, 0, 1),
(124, 9, '14:30:00', '15:00:00', 5, 0, 1),
(125, 9, '15:00:00', '15:30:00', 5, 0, 1),
(126, 9, '15:30:00', '16:00:00', 5, 0, 1),
(127, 10, '09:00:00', '09:30:00', 5, 0, 1),
(128, 10, '09:30:00', '10:00:00', 5, 0, 1),
(129, 10, '10:00:00', '10:30:00', 5, 0, 1),
(130, 10, '10:30:00', '11:00:00', 5, 0, 1),
(131, 10, '11:00:00', '11:30:00', 5, 0, 1),
(132, 10, '11:30:00', '12:00:00', 5, 0, 1),
(133, 10, '12:00:00', '12:30:00', 5, 0, 1),
(134, 10, '12:30:00', '13:00:00', 5, 0, 1),
(135, 10, '13:00:00', '13:30:00', 5, 0, 1),
(136, 10, '13:30:00', '14:00:00', 5, 0, 1),
(137, 10, '14:00:00', '14:30:00', 5, 0, 1),
(138, 10, '14:30:00', '15:00:00', 5, 0, 1),
(139, 10, '15:00:00', '15:30:00', 5, 0, 1),
(140, 10, '15:30:00', '16:00:00', 5, 0, 1),
(141, 11, '09:00:00', '09:30:00', 5, 0, 1),
(142, 11, '09:30:00', '10:00:00', 5, 0, 1),
(143, 11, '10:00:00', '10:30:00', 5, 0, 1),
(144, 11, '10:30:00', '11:00:00', 5, 0, 1),
(145, 11, '11:00:00', '11:30:00', 5, 0, 1),
(146, 11, '11:30:00', '12:00:00', 5, 0, 1),
(147, 11, '12:00:00', '12:30:00', 5, 0, 1),
(148, 11, '12:30:00', '13:00:00', 5, 0, 1),
(149, 11, '13:00:00', '13:30:00', 5, 0, 1),
(150, 11, '13:30:00', '14:00:00', 5, 0, 1),
(151, 11, '14:00:00', '14:30:00', 5, 0, 1),
(152, 11, '14:30:00', '15:00:00', 5, 0, 1),
(153, 11, '15:00:00', '15:30:00', 5, 0, 1),
(154, 11, '15:30:00', '16:00:00', 5, 0, 1),
(155, 12, '09:00:00', '09:30:00', 5, 0, 1),
(156, 12, '09:30:00', '10:00:00', 5, 0, 1),
(157, 12, '10:00:00', '10:30:00', 5, 0, 1),
(158, 12, '10:30:00', '11:00:00', 5, 0, 1),
(159, 12, '11:00:00', '11:30:00', 5, 0, 1),
(160, 12, '11:30:00', '12:00:00', 5, 0, 1),
(161, 12, '12:00:00', '12:30:00', 5, 0, 1),
(162, 12, '12:30:00', '13:00:00', 5, 0, 1),
(163, 12, '13:00:00', '13:30:00', 5, 0, 1),
(164, 12, '13:30:00', '14:00:00', 5, 0, 1),
(165, 12, '14:00:00', '14:30:00', 5, 0, 1),
(166, 12, '14:30:00', '15:00:00', 5, 0, 1),
(167, 12, '15:00:00', '15:30:00', 5, 0, 1),
(168, 12, '15:30:00', '16:00:00', 5, 0, 1),
(169, 13, '09:00:00', '09:30:00', 5, 0, 1),
(170, 13, '09:30:00', '10:00:00', 5, 0, 1),
(171, 13, '10:00:00', '10:30:00', 5, 0, 1),
(172, 13, '10:30:00', '11:00:00', 5, 0, 1),
(173, 13, '11:00:00', '11:30:00', 5, 0, 1),
(174, 13, '11:30:00', '12:00:00', 5, 0, 1),
(175, 13, '12:00:00', '12:30:00', 5, 0, 1),
(176, 13, '12:30:00', '13:00:00', 5, 0, 1),
(177, 13, '13:00:00', '13:30:00', 5, 0, 1),
(178, 13, '13:30:00', '14:00:00', 5, 0, 1),
(179, 13, '14:00:00', '14:30:00', 5, 0, 1),
(180, 13, '14:30:00', '15:00:00', 5, 0, 1),
(181, 13, '15:00:00', '15:30:00', 5, 0, 1),
(182, 13, '15:30:00', '16:00:00', 5, 0, 1),
(183, 14, '09:00:00', '09:30:00', 5, 0, 1),
(184, 14, '09:30:00', '10:00:00', 5, 0, 1),
(185, 14, '10:00:00', '10:30:00', 5, 0, 1),
(186, 14, '10:30:00', '11:00:00', 5, 0, 1),
(187, 14, '11:00:00', '11:30:00', 5, 0, 1),
(188, 14, '11:30:00', '12:00:00', 5, 0, 1),
(189, 14, '12:00:00', '12:30:00', 5, 0, 1),
(190, 14, '12:30:00', '13:00:00', 5, 0, 1),
(191, 14, '13:00:00', '13:30:00', 5, 0, 1),
(192, 14, '13:30:00', '14:00:00', 5, 0, 1),
(193, 14, '14:00:00', '14:30:00', 5, 0, 1),
(194, 14, '14:30:00', '15:00:00', 5, 0, 1),
(195, 14, '15:00:00', '15:30:00', 5, 0, 1),
(196, 14, '15:30:00', '16:00:00', 5, 0, 1),
(197, 15, '09:00:00', '09:30:00', 5, 0, 1),
(198, 15, '09:30:00', '10:00:00', 5, 0, 1),
(199, 15, '10:00:00', '10:30:00', 5, 0, 1),
(200, 15, '10:30:00', '11:00:00', 5, 0, 1),
(201, 15, '11:00:00', '11:30:00', 5, 0, 1),
(202, 15, '11:30:00', '12:00:00', 5, 0, 1),
(203, 15, '12:00:00', '12:30:00', 5, 0, 1),
(204, 15, '12:30:00', '13:00:00', 5, 0, 1),
(205, 15, '13:00:00', '13:30:00', 5, 0, 1),
(206, 15, '13:30:00', '14:00:00', 5, 0, 1),
(207, 15, '14:00:00', '14:30:00', 5, 0, 1),
(208, 15, '14:30:00', '15:00:00', 5, 0, 1),
(209, 15, '15:00:00', '15:30:00', 5, 0, 1),
(210, 15, '15:30:00', '16:00:00', 5, 0, 1),
(211, 16, '09:00:00', '09:30:00', 5, 0, 1),
(212, 16, '09:30:00', '10:00:00', 5, 0, 1),
(213, 16, '10:00:00', '10:30:00', 5, 0, 1),
(214, 16, '10:30:00', '11:00:00', 5, 0, 1),
(215, 16, '11:00:00', '11:30:00', 5, 0, 1),
(216, 16, '11:30:00', '12:00:00', 5, 0, 1),
(217, 16, '12:00:00', '12:30:00', 5, 0, 1),
(218, 16, '12:30:00', '13:00:00', 5, 0, 1),
(219, 16, '13:00:00', '13:30:00', 5, 0, 1),
(220, 16, '13:30:00', '14:00:00', 5, 0, 1),
(221, 16, '14:00:00', '14:30:00', 5, 0, 1),
(222, 16, '14:30:00', '15:00:00', 5, 0, 1),
(223, 16, '15:00:00', '15:30:00', 5, 0, 1),
(224, 16, '15:30:00', '16:00:00', 5, 0, 1),
(225, 17, '09:00:00', '09:30:00', 5, 0, 1),
(226, 17, '09:30:00', '10:00:00', 5, 0, 1),
(227, 17, '10:00:00', '10:30:00', 5, 0, 1),
(228, 17, '10:30:00', '11:00:00', 5, 0, 1),
(229, 17, '11:00:00', '11:30:00', 5, 0, 1),
(230, 17, '11:30:00', '12:00:00', 5, 0, 1),
(231, 17, '12:00:00', '12:30:00', 5, 0, 1),
(232, 17, '12:30:00', '13:00:00', 5, 0, 1),
(233, 17, '13:00:00', '13:30:00', 5, 0, 1),
(234, 17, '13:30:00', '14:00:00', 5, 0, 1),
(235, 17, '14:00:00', '14:30:00', 5, 0, 1),
(236, 17, '14:30:00', '15:00:00', 5, 0, 1),
(237, 17, '15:00:00', '15:30:00', 5, 0, 1),
(238, 17, '15:30:00', '16:00:00', 5, 0, 1),
(239, 18, '09:00:00', '09:30:00', 5, 0, 1),
(240, 18, '09:30:00', '10:00:00', 5, 0, 1),
(241, 18, '10:00:00', '10:30:00', 5, 0, 1),
(242, 18, '10:30:00', '11:00:00', 5, 0, 1),
(243, 18, '11:00:00', '11:30:00', 5, 0, 1),
(244, 18, '11:30:00', '12:00:00', 5, 0, 1),
(245, 18, '12:00:00', '12:30:00', 5, 0, 1),
(246, 18, '12:30:00', '13:00:00', 5, 0, 1),
(247, 18, '13:00:00', '13:30:00', 5, 0, 1),
(248, 18, '13:30:00', '14:00:00', 5, 0, 1),
(249, 18, '14:00:00', '14:30:00', 5, 0, 1),
(250, 18, '14:30:00', '15:00:00', 5, 0, 1),
(251, 18, '15:00:00', '15:30:00', 5, 0, 1),
(252, 18, '15:30:00', '16:00:00', 5, 0, 1),
(253, 19, '09:00:00', '09:30:00', 5, 0, 1),
(254, 19, '09:30:00', '10:00:00', 5, 0, 1),
(255, 19, '10:00:00', '10:30:00', 5, 0, 1),
(256, 19, '10:30:00', '11:00:00', 5, 0, 1),
(257, 19, '11:00:00', '11:30:00', 5, 0, 1),
(258, 19, '11:30:00', '12:00:00', 5, 0, 1),
(259, 19, '12:00:00', '12:30:00', 5, 0, 1),
(260, 19, '12:30:00', '13:00:00', 5, 0, 1),
(261, 19, '13:00:00', '13:30:00', 5, 0, 1),
(262, 19, '13:30:00', '14:00:00', 5, 0, 1),
(263, 19, '14:00:00', '14:30:00', 5, 0, 1),
(264, 19, '14:30:00', '15:00:00', 5, 0, 1),
(265, 19, '15:00:00', '15:30:00', 5, 0, 1),
(266, 19, '15:30:00', '16:00:00', 5, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(255) NOT NULL,
  `student_id` varchar(10) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','supervisor','admin') NOT NULL DEFAULT 'student',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('active','disabled') NOT NULL DEFAULT 'active',
  `course_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `student_id`, `full_name`, `email`, `phone`, `password`, `role`, `created_at`, `status`, `course_id`) VALUES
(1, '2023-54855', 'Mark PJ Handig', 'handig.markpj@ncst.edu.ph', '09611485874', '$2y$10$pifrUDYZV1ti.df9aL63POQijtHrrd.13ApkVDBNtuwFMlEDqcAqe', 'student', '2026-09-30 03:37:11', 'active', NULL),
(2, '2023-54853', 'Megatron', 'jhescelhandig@gmail.com', '09218402034', '$2y$10$JUuBq.T338KG5NyhtqR7UOGJJ1XFuNK8oBVazVVdNQw7IciEAEBmG', 'student', '2026-09-30 03:50:01', 'active', NULL),
(3, '2023-54854', 'Jhescel Ann Padilla handig', 'padilla.jhescelann@ncst.edu.ph', '09218402034', '$2y$10$iFVCqxQvm5oo/KCgc6XSuu0fK3pa1BSCRWBWDevd2B1DOoo9IzlrG', 'student', '2026-09-30 04:05:33', 'active', NULL),
(4, 'ADMIN-2023', 'MARK PJ HANDIG', 'markpjhandig10@gmail.com', '00000000000', '$2y$10$Xky.YLOIbT0xH3JO7LIOY.4q1u7cT.94ihm8zhg1ctFEXgrdNGYEK', 'admin', '2026-10-05 20:21:09', 'active', NULL),
(5, 'SUP-001', 'PIKA', 'jhescelpadilla@gmail.com', '09910506343', '$2y$10$Eu8lUH/IE0kSgTirSDzPiueYLVRsTyH.KPzs5Y/55DZvbzbXCuWse', 'supervisor', '2026-10-05 20:58:08', 'active', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reference_no` (`reference_no`),
  ADD KEY `idx_appt_date` (`appointment_date`),
  ADD KEY `idx_appt_user` (`user_id`,`appointment_date`),
  ADD KEY `fk_appt_course` (`course_id`),
  ADD KEY `fk_appt_service` (`service_id`),
  ADD KEY `fk_appt_slot` (`slot_id`);

--
-- Indexes for table `appointment_history`
--
ALTER TABLE `appointment_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_hist_appt` (`appointment_id`);

--
-- Indexes for table `blocked_dates`
--
ALTER TABLE `blocked_dates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_block_course` (`course_id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_notif_user` (`user_id`,`is_read`);

--
-- Indexes for table `schedules`
--
ALTER TABLE `schedules`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_schedule` (`course_id`,`service_id`,`schedule_date`),
  ADD KEY `fk_sch_service` (`service_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_services_course` (`course_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`setting_key`);

--
-- Indexes for table `supervisors`
--
ALTER TABLE `supervisors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `fk_sup_course` (`course_id`);

--
-- Indexes for table `time_slots`
--
ALTER TABLE `time_slots`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_slot` (`schedule_id`,`start_time`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_id` (`student_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `appointment_history`
--
ALTER TABLE `appointment_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `blocked_dates`
--
ALTER TABLE `blocked_dates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `schedules`
--
ALTER TABLE `schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `supervisors`
--
ALTER TABLE `supervisors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `time_slots`
--
ALTER TABLE `time_slots`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=267;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `fk_appt_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`),
  ADD CONSTRAINT `fk_appt_service` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`),
  ADD CONSTRAINT `fk_appt_slot` FOREIGN KEY (`slot_id`) REFERENCES `time_slots` (`id`),
  ADD CONSTRAINT `fk_appt_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `appointment_history`
--
ALTER TABLE `appointment_history`
  ADD CONSTRAINT `fk_hist_appt` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `blocked_dates`
--
ALTER TABLE `blocked_dates`
  ADD CONSTRAINT `fk_block_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notif_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `schedules`
--
ALTER TABLE `schedules`
  ADD CONSTRAINT `fk_sch_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`),
  ADD CONSTRAINT `fk_sch_service` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`);

--
-- Constraints for table `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `fk_services_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `supervisors`
--
ALTER TABLE `supervisors`
  ADD CONSTRAINT `fk_sup_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`),
  ADD CONSTRAINT `fk_sup_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `time_slots`
--
ALTER TABLE `time_slots`
  ADD CONSTRAINT `fk_slot_schedule` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
