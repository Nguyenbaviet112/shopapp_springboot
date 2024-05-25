-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 25, 2024 at 10:26 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shopapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT 'Tên danh mục, vd: đồ điện tử'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Laptop'),
(2, 'Dien thoai'),
(3, 'Tivi'),
(4, 'Tu Lanh'),
(5, 'May giat');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `fullname` varchar(100) DEFAULT '',
  `email` varchar(100) DEFAULT '',
  `phone_number` varchar(20) NOT NULL,
  `address` varchar(200) NOT NULL,
  `note` varchar(100) DEFAULT '',
  `order_date` datetime DEFAULT current_timestamp(),
  `status` enum('pending','processing','shipped','delivered','cancelled') DEFAULT NULL COMMENT 'Trạng thái đơn hàng',
  `total_money` float DEFAULT NULL CHECK (`total_money` >= 0),
  `shipping_method` varchar(100) DEFAULT NULL,
  `shipping_address` varchar(200) DEFAULT NULL,
  `shipping_date` date DEFAULT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `payment_method` varchar(100) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `fullname`, `email`, `phone_number`, `address`, `note`, `order_date`, `status`, `total_money`, `shipping_method`, `shipping_address`, `shipping_date`, `tracking_number`, `payment_method`, `active`) VALUES
(1, 1, 'nguyen van a', 'abc@gmail.com', '123456', 'Nha a, ngo b', 'hang de vo', '2024-04-19 13:52:31', 'pending', 123, NULL, NULL, '2024-04-19', NULL, 'cod', 1),
(2, 1, 'nguyen van a', 'abc@gmail.com', '123456', 'Nha a, ngo b', 'hang de vo', '2024-04-19 13:53:18', 'pending', 123, NULL, NULL, '2024-04-19', NULL, 'cod', 1),
(3, 1, 'new customer', 'abc@gmail.com', '123456', 'new address', 'new order', '2024-04-19 13:55:01', 'pending', 4567, 'express', 'abc, xyz', '2024-04-19', NULL, 'cod', 0);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `price` float DEFAULT NULL CHECK (`price` >= 0),
  `number_of_products` int(11) DEFAULT NULL CHECK (`number_of_products` > 0),
  `total_money` float DEFAULT NULL CHECK (`total_money` >= 0),
  `color` varchar(20) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `price`, `number_of_products`, `total_money`, `color`) VALUES
(1, 1, 2, 123.45, 1, 100, 'yeloow'),
(2, 1, 2, 123.45, 10, 1000, 'blue');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(350) DEFAULT NULL COMMENT 'Tên sản phẩm',
  `price` float NOT NULL CHECK (`price` >= 0),
  `thumbnail` varchar(300) DEFAULT '',
  `description` longtext DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `thumbnail`, `description`, `created_at`, `updated_at`, `category_id`) VALUES
(1, 'Synergistic Bronze Knife', 39731, '', 'Ab omnis soluta porro.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(2, 'Fantastic Granite Bench', 22488, '', 'Ipsam dolores fuga et saepe nostrum et dolore.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(3, 'Sleek Copper Knife', 40007, '', 'Quos voluptatibus quia nobis qui.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(4, 'Sleek Iron Hat', 10115, '', 'Incidunt aperiam doloremque voluptate consectetur.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(5, 'Fantastic Linen Plate', 24886, '', 'Voluptas dolor repellendus eius.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(6, 'Practical Paper Lamp', 14846, '', 'Corrupti qui vel molestias eveniet nemo.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(7, 'Gorgeous Aluminum Shirt', 36157, '', 'Beatae nulla et possimus exercitationem nobis.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(8, 'Intelligent Silk Bench', 48941, '', 'Rerum cupiditate ratione.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(9, 'Small Plastic Watch', 17957, '', 'Reprehenderit iure facere facere.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(10, 'Mediocre Wool Wallet', 37011, '', 'Et repudiandae ab in eaque nihil quidem voluptates.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(11, 'Enormous Marble Computer', 3186, '', 'Odio adipisci voluptatem quasi vero.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(12, 'Practical Paper Table', 31680, '', 'Facere eveniet consequatur debitis autem neque aut.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(13, 'Practical Concrete Plate', 18381, '', 'Voluptatem eum magni est delectus qui.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(14, 'Incredible Aluminum Chair', 16667, '', 'Quod maxime ipsam error consequuntur nihil facilis voluptas.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(15, 'Enormous Marble Shirt', 46320, '', 'Rerum veritatis voluptatem earum perferendis perferendis ad sit.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(16, 'Small Wool Plate', 28177, '', 'Vitae voluptas repudiandae qui.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(17, 'Rustic Wooden Bag', 40734, '', 'A consequatur ratione voluptatem qui quasi ullam consequuntur.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(18, 'Awesome Marble Bottle', 44097, '', 'Assumenda deleniti rem in impedit est quia.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(19, 'Lightweight Marble Lamp', 15077, '', 'Distinctio veritatis enim voluptatibus.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(20, 'Fantastic Linen Gloves', 17090, '', 'Consequuntur rem ut et quam sed illum ipsum.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(21, 'Small Concrete Bottle', 35409, '', 'Laborum omnis fugiat et.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(22, 'Ergonomic Bronze Shirt', 2098, '', 'Maxime aut velit quia.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(23, 'Rustic Steel Pants', 16680, '', 'Quia voluptatum ullam aut.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(24, 'Practical Granite Knife', 35970, '', 'Reprehenderit laboriosam distinctio rerum.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(25, 'Awesome Wool Watch', 27197, '', 'Labore iste in odit quam assumenda alias.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(26, 'Awesome Marble Bag', 21561, '', 'Corrupti ipsum perferendis quia eaque sequi consequuntur.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(27, 'Heavy Duty Iron Hat', 28500, '', 'Similique aut sunt nisi quae blanditiis aliquid.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(28, 'Gorgeous Marble Computer', 46986, '', 'Pariatur voluptas voluptas.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(29, 'Incredible Cotton Knife', 41846, '', 'Voluptatem quod qui enim aperiam consequatur optio.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(30, 'Synergistic Rubber Shoes', 40867, '', 'Omnis dolorem in.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(31, 'Mediocre Bronze Gloves', 49308, '', 'Quis saepe sint quia.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(32, 'Synergistic Silk Bottle', 13998, '', 'Dolorem impedit quos libero illum odio.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(33, 'Enormous Leather Coat', 17214, '', 'Expedita non minus nostrum.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(34, 'Durable Plastic Shirt', 41421, '', 'Corrupti culpa error est quisquam magni.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(35, 'Enormous Leather Knife', 41496, '', 'Dolor dolores atque modi omnis aspernatur et.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(36, 'Mediocre Wool Clock', 35457, '', 'Pariatur omnis nobis in et voluptatem adipisci adipisci.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(37, 'Fantastic Steel Bench', 35448, '', 'Nobis quisquam dolore nihil itaque beatae.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(38, 'Durable Granite Table', 8353, '', 'Debitis repellat ipsum ratione repellendus.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(39, 'Intelligent Paper Bench', 22107, '', 'Nulla quasi unde laboriosam ut sunt.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(40, 'Fantastic Iron Wallet', 26912, '', 'Maxime quae placeat.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(41, 'Synergistic Aluminum Coat', 48713, '', 'Iste commodi ratione expedita maiores.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(42, 'Durable Granite Bench', 21026, '', 'Placeat nostrum modi eos sunt sint pariatur at.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(43, 'Mediocre Iron Computer', 18831, '', 'Sit quos quaerat consectetur qui.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(44, 'Heavy Duty Bronze Hat', 44440, '', 'Quasi dolorem non et eius eaque molestias laudantium.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(45, 'Durable Wooden Table', 6228, '', 'Autem qui quaerat velit est aliquam dolor.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(46, 'Enormous Plastic Plate', 3718, '', 'Vel incidunt aliquid.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(47, 'Incredible Silk Lamp', 27775, '', 'Et rem fugiat numquam cumque.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(48, 'Ergonomic Aluminum Plate', 20538, '', 'Error commodi blanditiis ab quis et sit.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(49, 'Ergonomic Cotton Knife', 32271, '', 'Quo velit rerum deleniti.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(50, 'Practical Rubber Shirt', 7755, '', 'Cum odit cumque.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(51, 'Practical Wooden Pants', 21347, '', 'Recusandae occaecati deserunt.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(52, 'Mediocre Wooden Shirt', 34754, '', 'Qui eveniet non magnam possimus sint molestias perspiciatis.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(53, 'Small Wooden Table', 45793, '', 'Ut sit quisquam corrupti soluta est similique maxime.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(54, 'Synergistic Steel Bag', 49570, '', 'Veniam delectus aut.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(55, 'Small Paper Coat', 49308, '', 'Ipsam ut aut fugit omnis.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(56, 'Incredible Concrete Bag', 34538, '', 'Hic praesentium culpa maiores labore placeat est.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(57, 'Small Aluminum Table', 38466, '', 'Aut ipsam adipisci officiis impedit excepturi quaerat.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(58, 'Ergonomic Wool Car', 1578, '', 'Qui sed consectetur possimus laudantium.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(59, 'Ergonomic Paper Bottle', 16649, '', 'Saepe nobis voluptate voluptatem enim.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(60, 'Incredible Rubber Computer', 46979, '', 'Debitis explicabo cumque.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(61, 'Gorgeous Bronze Coat', 6913, '', 'Quibusdam dolores occaecati facilis voluptates.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(62, 'Heavy Duty Linen Plate', 23448, '', 'Modi nihil autem.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(63, 'Incredible Copper Bottle', 32055, '', 'Fugiat id odit magnam voluptate.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(64, 'Aerodynamic Plastic Plate', 36943, '', 'Non qui est omnis molestiae non.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(65, 'Enormous Plastic Keyboard', 26618, '', 'Ea nihil quia id ipsum aut.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(66, 'Incredible Marble Lamp', 9388, '', 'Laudantium itaque natus rerum in nostrum quo dicta.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(67, 'Aerodynamic Iron Bag', 28160, '', 'Vitae cupiditate possimus.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(68, 'Durable Marble Clock', 33360, '', 'Architecto illum repellendus libero eligendi pariatur et.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(69, 'Lightweight Plastic Bag', 28997, '', 'Amet illum exercitationem omnis.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(70, 'Enormous Wool Shirt', 4627, '', 'Blanditiis illo asperiores veniam exercitationem harum officiis.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(71, 'Enormous Steel Gloves', 28370, '', 'Voluptatum repellendus est aperiam autem ex.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(72, 'Durable Copper Wallet', 47199, '', 'Dicta quos voluptatum est et mollitia.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(73, 'Enormous Copper Car', 1601, '', 'Ut ut dolor laborum dignissimos libero consequatur molestiae.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(74, 'Incredible Aluminum Watch', 30658, '', 'Provident repudiandae voluptatem non repellat ullam.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(75, 'Incredible Leather Knife', 36556, '', 'Sed sit nulla voluptas sit nostrum.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(76, 'Synergistic Wool Clock', 41847, '', 'Vitae eum velit necessitatibus.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(77, 'Small Rubber Lamp', 5057, '', 'Omnis aut dolorum aliquam quam sit nesciunt impedit.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(78, 'Gorgeous Plastic Pants', 19216, '', 'Quis recusandae qui cupiditate aut labore.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(79, 'Sleek Wooden Chair', 23970, '', 'Sint vel natus temporibus ut nam labore.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(80, 'Small Linen Shirt', 19870, '', 'Sit ad quae.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(81, 'Incredible Marble Clock', 11862, '', 'Repudiandae a ut sed.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(82, 'Practical Rubber Table', 46763, '', 'Dignissimos molestias qui aperiam.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(83, 'Heavy Duty Paper Keyboard', 7587, '', 'Placeat eius sed ex id sed est.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(84, 'Ergonomic Paper Keyboard', 3006, '', 'Vel atque officia.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(85, 'Synergistic Paper Coat', 46577, '', 'Porro deleniti porro iure excepturi.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(86, 'Practical Rubber Plate', 24825, '', 'Est et dolorum repellendus perspiciatis.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(87, 'Synergistic Steel Knife', 44668, '', 'Voluptas doloremque recusandae praesentium.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(88, 'Durable Marble Coat', 41746, '', 'Consequatur magnam quis voluptates.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(89, 'Enormous Wool Clock', 28097, '', 'Assumenda et harum rerum voluptatem officiis.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(90, 'Synergistic Marble Car', 5018, '', 'Repellat exercitationem delectus dolor.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(91, 'Mediocre Paper Shoes', 18874, '', 'Culpa exercitationem aut doloribus qui facilis et voluptatem.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(92, 'Sleek Concrete Computer', 35670, '', 'Voluptates corporis velit hic.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(93, 'Lightweight Rubber Plate', 38323, '', 'Quis consequatur voluptatem aut odit ut dolores exercitationem.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(94, 'Incredible Concrete Clock', 9292, '', 'Recusandae vitae minus quod suscipit ut quis minus.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(95, 'Small Wooden Hat', 35862, '', 'Illum pariatur et cum animi minus mollitia temporibus.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(96, 'Incredible Linen Watch', 22194, '', 'Labore reprehenderit eos mollitia ipsam laborum.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(97, 'Awesome Wool Lamp', 22888, '', 'Quisquam excepturi iste.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(98, 'Durable Wool Shirt', 27971, '', 'Sunt laboriosam ex error.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(99, 'Durable Aluminum Bench', 9791, '', 'Rem nisi eos quo aut molestiae.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(100, 'Mediocre Paper Wallet', 42863, '', 'Ut quasi eum qui dolor.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(101, 'Sleek Silk Chair', 23567, '', 'Quam deleniti at.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(102, 'Awesome Wool Wallet', 36214, '', 'Voluptas voluptas dicta.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(103, 'Synergistic Steel Clock', 43916, '', 'Omnis dolores quia sunt.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(104, 'Mediocre Copper Bench', 9900, '', 'Quia voluptatum et.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(105, 'Heavy Duty Bronze Clock', 28317, '', 'Alias ex aut.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(106, 'Gorgeous Wool Watch', 38510, '', 'Dolor culpa libero quasi eos.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(107, 'Practical Wooden Lamp', 43519, '', 'Ut iusto laborum et.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(108, 'Synergistic Iron Table', 48099, '', 'Inventore reprehenderit fugiat necessitatibus nesciunt.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(109, 'Fantastic Iron Keyboard', 19268, '', 'Quae est dicta qui in consectetur.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(110, 'Awesome Iron Chair', 37272, '', 'Iste placeat sunt fugit voluptatum minus sed enim.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(111, 'Sleek Steel Gloves', 5737, '', 'Omnis id ipsa.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(112, 'Incredible Plastic Shoes', 48310, '', 'Nesciunt vitae natus architecto voluptas maxime doloribus.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(113, 'Mediocre Bronze Keyboard', 1426, '', 'Voluptas ut doloremque architecto ea.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(114, 'Heavy Duty Bronze Plate', 34161, '', 'At non facilis fugiat.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(115, 'Rustic Silk Lamp', 33311, '', 'Similique saepe ab quia.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(116, 'Awesome Steel Clock', 37337, '', 'Veniam assumenda cum.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(117, 'Awesome Aluminum Shoes', 1276, '', 'Neque nihil et error qui.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(118, 'Gorgeous Granite Bottle', 49324, '', 'Consectetur blanditiis ullam est unde non.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(119, 'Durable Granite Plate', 39034, '', 'Maxime excepturi fuga tenetur deleniti aut.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(120, 'Fantastic Wool Coat', 11604, '', 'Rerum et aliquam veritatis sint est.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(121, 'Small Linen Pants', 46575, '', 'Autem voluptatem quidem officia expedita id rerum.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(122, 'Sleek Plastic Computer', 19077, '', 'Est consequatur sint.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(123, 'Heavy Duty Wooden Gloves', 42907, '', 'Et iste exercitationem dolorum id.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(124, 'Rustic Leather Bottle', 16662, '', 'Rerum fuga facilis officia consequatur eum omnis officia.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(125, 'Small Wool Shoes', 14827, '', 'Nihil sed voluptatem debitis quasi ipsa eveniet.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(126, 'Heavy Duty Silk Wallet', 25788, '', 'Fugiat harum magni nisi consequatur.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(127, 'Ergonomic Steel Keyboard', 22484, '', 'Nihil sequi sed sed inventore veniam.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(128, 'Rustic Wooden Chair', 23636, '', 'Praesentium vero rerum ut ut ratione.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(129, 'Durable Aluminum Hat', 20999, '', 'Quas molestiae architecto dolor id voluptates sint aut.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(130, 'Enormous Steel Bench', 47696, '', 'Sit optio quo.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(131, 'Awesome Wooden Watch', 24578, '', 'Quisquam autem aut fugiat cum quia similique quia.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(132, 'Durable Wool Wallet', 2943, '', 'Omnis in sed reiciendis ea.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(133, 'Rustic Marble Shoes', 24818, '', 'Error eius et sapiente.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(134, 'Practical Rubber Chair', 34213, '', 'Assumenda adipisci quae ipsa.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(135, 'Rustic Silk Coat', 38827, '', 'Odit aut explicabo corrupti repudiandae.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(136, 'Ergonomic Leather Pants', 47123, '', 'Exercitationem nisi saepe.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(137, 'Rustic Paper Coat', 29672, '', 'Facere sequi autem inventore facilis architecto voluptatem pariatur.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(138, 'Intelligent Granite Wallet', 17566, '', 'Id voluptatum fugiat.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(139, 'Gorgeous Linen Shoes', 30020, '', 'Inventore ullam delectus cumque ut perferendis facere odio.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(140, 'Practical Bronze Shirt', 43663, '', 'Facere corrupti illo aperiam.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(141, 'Mediocre Rubber Computer', 30226, '', 'Ratione molestias incidunt est maiores omnis dolorem ipsa.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(142, 'Rustic Plastic Knife', 45804, '', 'Eligendi praesentium nam eum et quaerat quis voluptas.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(143, 'Heavy Duty Bronze Coat', 17748, '', 'Omnis debitis ex aut.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(144, 'Awesome Leather Lamp', 25107, '', 'Odio ut doloremque blanditiis ea rerum.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(145, 'Synergistic Iron Hat', 42312, '', 'Reiciendis ipsam qui occaecati neque in cum modi.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(146, 'Mediocre Wooden Chair', 15704, '', 'Nisi nulla omnis quis ratione.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(147, 'Mediocre Steel Chair', 34128, '', 'Dolore autem eius esse.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(148, 'Intelligent Wooden Shoes', 39177, '', 'Necessitatibus iusto non et.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(149, 'Aerodynamic Steel Gloves', 7285, '', 'Excepturi doloremque voluptate nulla voluptates.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(150, 'Durable Paper Shirt', 38750, '', 'Excepturi cupiditate repellendus maiores eum dolore.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(151, 'Fantastic Wooden Coat', 34827, '', 'Porro excepturi velit.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(152, 'Rustic Bronze Chair', 42072, '', 'Labore quos repellendus necessitatibus neque aut.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(153, 'Durable Aluminum Table', 16620, '', 'Earum aut eos consequatur iusto et.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(154, 'Practical Cotton Keyboard', 49233, '', 'Eum et velit voluptatum odit est error.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(155, 'Intelligent Silk Shirt', 2360, '', 'Cumque modi modi voluptatem repellat et.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(156, 'Mediocre Wool Pants', 17748, '', 'Cupiditate suscipit ad.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(157, 'Awesome Bronze Bench', 36383, '', 'Pariatur ratione reprehenderit molestiae eveniet illo nemo.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(158, 'Small Iron Chair', 44227, '', 'Doloremque quibusdam dicta nisi.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(159, 'Mediocre Wooden Gloves', 9868, '', 'Sunt neque voluptatibus sint quae.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(160, 'Gorgeous Linen Gloves', 16438, '', 'Reprehenderit magni aliquid et laboriosam et molestiae.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(161, 'Synergistic Paper Car', 48052, '', 'Nostrum qui aliquid.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(162, 'Gorgeous Cotton Chair', 23367, '', 'Ea reprehenderit repellat placeat et accusamus aliquid.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(163, 'Enormous Aluminum Bag', 13609, '', 'Perspiciatis facilis nemo ut voluptatem.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(164, 'Rustic Iron Car', 8680, '', 'Ea sit repudiandae.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(165, 'Incredible Rubber Clock', 1625, '', 'Pariatur repellendus a quasi perspiciatis nisi.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(166, 'Incredible Plastic Coat', 24556, '', 'Laborum consectetur repellat non suscipit.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(167, 'Enormous Silk Watch', 3938, '', 'A dolores facilis voluptas ea nobis tenetur cum.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(168, 'Sleek Plastic Keyboard', 22394, '', 'Quia doloribus sit explicabo.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(169, 'Ergonomic Paper Coat', 9514, '', 'Aut vel at qui in.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(170, 'Incredible Marble Watch', 21339, '', 'Qui illo repellendus quas voluptatem omnis id.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(171, 'Fantastic Granite Watch', 42370, '', 'In fugiat nihil tempora quibusdam soluta aut recusandae.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(172, 'Ergonomic Bronze Gloves', 1455, '', 'In impedit quibusdam consequatur qui.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(173, 'Sleek Bronze Watch', 17759, '', 'Cumque facere iste corrupti qui facere.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(174, 'Fantastic Silk Plate', 8451, '', 'Rem distinctio tempore at.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(175, 'Fantastic Steel Shoes', 13691, '', 'Ex earum doloremque eius minima tenetur impedit.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(176, 'Rustic Rubber Bag', 34024, '', 'Quia iste illum repudiandae ab reprehenderit vel.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(177, 'Gorgeous Cotton Keyboard', 8040, '', 'Commodi commodi minus.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(178, 'Incredible Wool Wallet', 38244, '', 'Aliquid omnis eligendi aut ut placeat sed.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(179, 'Awesome Bronze Bag', 20108, '', 'Modi qui nihil eos ullam eius.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(180, 'Incredible Copper Clock', 48662, '', 'Repellat ut ducimus corporis.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(181, 'Durable Copper Keyboard', 23510, '', 'A esse amet.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(182, 'Gorgeous Linen Coat', 36243, '', 'Harum est dolores vel ut et molestiae.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(183, 'Durable Iron Chair', 32035, '', 'Numquam ipsa sint placeat sunt deserunt sed ducimus.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(184, 'Ergonomic Copper Computer', 23645, '', 'Non fuga autem numquam.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(185, 'Mediocre Silk Watch', 46046, '', 'Sed autem et.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(186, 'Aerodynamic Iron Car', 3983, '', 'Nulla tempora consequatur rem.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(187, 'Practical Granite Clock', 21637, '', 'Nulla et atque assumenda non voluptatem dolore placeat.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(188, 'Intelligent Silk Car', 49061, '', 'Aut ratione quisquam delectus facilis ad.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(189, 'Awesome Paper Bottle', 34267, '', 'Cum non sit rem.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(190, 'Sleek Cotton Gloves', 48704, '', 'Nisi corporis rerum non aperiam ut.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(191, 'Rustic Concrete Pants', 30235, '', 'Mollitia eius impedit quia rerum laboriosam ullam.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(192, 'Enormous Paper Hat', 18414, '', 'Voluptas accusamus illum aut molestiae repellat aut dignissimos.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(193, 'Gorgeous Marble Lamp', 34197, '', 'Quis pariatur veniam quo sequi aliquam in nihil.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(194, 'Enormous Concrete Wallet', 46399, '', 'Commodi architecto sint qui voluptatem voluptas tempora.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(195, 'Practical Leather Gloves', 8350, '', 'Aut quas dolore dolor.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(196, 'Enormous Aluminum Knife', 31941, '', 'Necessitatibus omnis omnis nihil dolorem et ea.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(197, 'Heavy Duty Rubber Chair', 32409, '', 'Illo voluptatem ducimus quis ut molestiae aut explicabo.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(198, 'Lightweight Granite Lamp', 32535, '', 'Quidem omnis qui beatae amet occaecati et expedita.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(199, 'Gorgeous Silk Hat', 1537, '', 'Animi aliquam est eveniet ut.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(200, 'Gorgeous Wool Lamp', 12050, '', 'Aut repudiandae officiis.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(201, 'Synergistic Silk Knife', 17559, '', 'Fuga animi autem.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(202, 'Synergistic Iron Coat', 39066, '', 'Fugit quia neque facilis molestiae nihil ipsam tempore.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(203, 'Intelligent Rubber Hat', 39138, '', 'Harum incidunt et eligendi quis dolor in et.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(204, 'Rustic Bronze Table', 3174, '', 'Eos voluptatem ratione perspiciatis natus.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(205, 'Ergonomic Marble Bottle', 26464, '', 'Inventore sequi commodi eos aliquam assumenda.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(206, 'Durable Marble Shoes', 10621, '', 'Eos hic sequi ullam.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(207, 'Fantastic Aluminum Pants', 46230, '', 'Et aut culpa sapiente.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(208, 'Awesome Concrete Shirt', 44958, '', 'Necessitatibus voluptates minima amet quasi.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(209, 'Rustic Rubber Bottle', 4576, '', 'Voluptatem ut quisquam quia quia repellendus.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(210, 'Gorgeous Granite Table', 5701, '', 'Labore vitae omnis nam ut optio illum.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(211, 'Small Wool Knife', 43534, '', 'Possimus vitae praesentium qui quasi quibusdam.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(212, 'Enormous Silk Chair', 36309, '', 'Quod doloribus possimus quisquam assumenda id.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(213, 'Durable Rubber Hat', 21568, '', 'Quo ad perferendis eaque sint nam molestias.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(214, 'Incredible Copper Bench', 1417, '', 'Quisquam cumque alias iusto nihil sit commodi.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(215, 'Heavy Duty Cotton Shirt', 1593, '', 'Adipisci perferendis incidunt architecto nulla omnis est.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(216, 'Synergistic Bronze Shirt', 16958, '', 'Neque incidunt et minus maiores.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(217, 'Ergonomic Linen Keyboard', 32178, '', 'Quos et corporis provident.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(218, 'Aerodynamic Steel Wallet', 39687, '', 'Quia quisquam dignissimos sit officia voluptas nemo.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(219, 'Aerodynamic Linen Pants', 31978, '', 'Optio autem minima dicta sit aperiam.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(220, 'Gorgeous Paper Hat', 24339, '', 'Eum aliquam rerum.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(221, 'Gorgeous Marble Bench', 44961, '', 'Voluptatem quibusdam dignissimos voluptas excepturi quisquam.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(222, 'Enormous Rubber Knife', 30900, '', 'Sit ducimus assumenda iusto minus iusto autem a.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(223, 'Heavy Duty Copper Watch', 35278, '', 'Deleniti laborum voluptas.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(224, 'Enormous Iron Car', 45661, '', 'Dolorum facilis totam et asperiores veniam ducimus.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(225, 'Awesome Linen Table', 34098, '', 'Facilis ut doloremque.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(226, 'Enormous Steel Pants', 22754, '', 'Et debitis odio recusandae adipisci aut.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(227, 'Small Plastic Pants', 32669, '', 'Odio eius excepturi nesciunt impedit.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(228, 'Durable Silk Keyboard', 4606, '', 'Consequatur in autem facere debitis expedita rerum et.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(229, 'Sleek Silk Clock', 17747, '', 'Blanditiis itaque dolor temporibus.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(230, 'Intelligent Iron Watch', 7808, '', 'Quam aut repellendus.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(231, 'Awesome Linen Keyboard', 36914, '', 'Quod sit occaecati in aut.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(232, 'Fantastic Copper Wallet', 12023, '', 'Placeat facere corporis eum inventore nisi sit et.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(233, 'Small Wool Hat', 26897, '', 'Consequatur delectus rerum vero.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(234, 'Practical Bronze Pants', 10742, '', 'Doloremque aut qui ea perferendis laboriosam maxime quas.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(235, 'Heavy Duty Silk Knife', 40697, '', 'Delectus autem dolor aliquid.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(236, 'Aerodynamic Linen Wallet', 35541, '', 'Est et neque ipsum cum fuga.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(237, 'Awesome Cotton Bench', 8571, '', 'Sunt qui soluta rem.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(238, 'Heavy Duty Paper Bottle', 23996, '', 'Qui impedit error reiciendis natus nihil dolores.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(239, 'Intelligent Rubber Bag', 28990, '', 'Rerum eum ut.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(240, 'Enormous Leather Car', 11459, '', 'Excepturi corrupti corrupti minima.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(241, 'Rustic Marble Clock', 18047, '', 'Earum voluptatem fugit qui nulla voluptates tempora.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(242, 'Synergistic Marble Gloves', 36277, '', 'Neque est cumque aut est.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(243, 'Heavy Duty Rubber Knife', 42725, '', 'Reprehenderit voluptas exercitationem hic dolores omnis sed.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(244, 'Practical Granite Keyboard', 44228, '', 'Quasi quae sed iusto consequatur fugiat sit.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(245, 'Small Rubber Plate', 22534, '', 'Quo laudantium natus sint placeat.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(246, 'Mediocre Copper Pants', 40503, '', 'Vel voluptatem quo recusandae quis saepe soluta veritatis.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(247, 'Lightweight Concrete Knife', 4341, '', 'Omnis ea dolore molestiae dolorum perspiciatis est ea.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 1),
(248, 'Lightweight Rubber Computer', 9644, '', 'Blanditiis non non impedit nostrum vitae.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(249, 'Mediocre Rubber Plate', 19755, '', 'Veritatis architecto sit.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(250, 'Aerodynamic Iron Keyboard', 2414, '', 'Molestiae ut eaque amet.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(251, 'Awesome Leather Computer', 11041, '', 'Ab perspiciatis quas quaerat deserunt labore natus.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(252, 'Aerodynamic Plastic Bag', 38772, '', 'Laudantium culpa molestiae distinctio atque quasi.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 1),
(253, 'Incredible Silk Hat', 29765, '', 'Quae culpa cum sit ipsum quo iure.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(254, 'Fantastic Bronze Plate', 22746, '', 'Ut reiciendis dolores quae.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(255, 'Mediocre Cotton Watch', 38805, '', 'Corrupti ut voluptas hic ad occaecati ipsam.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(256, 'Ergonomic Linen Bottle', 48062, '', 'Molestias voluptatem saepe placeat amet id et fugit.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(257, 'Gorgeous Steel Lamp', 26317, '', 'Ea tenetur ad a vero.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(258, 'Heavy Duty Granite Hat', 34519, '', 'Illum voluptas doloremque.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(259, 'Awesome Cotton Chair', 3325, '', 'Suscipit voluptates saepe facere.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(260, 'Awesome Rubber Car', 10031, '', 'Libero eligendi animi quis eligendi voluptatum illo magni.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(261, 'Sleek Paper Shoes', 25324, '', 'Est laboriosam non et dolorem iusto.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(262, 'Sleek Wooden Plate', 2325, '', 'Pariatur aut est quaerat.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(263, 'Small Wooden Keyboard', 12792, '', 'Totam mollitia qui reprehenderit eaque.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(264, 'Gorgeous Copper Bottle', 24041, '', 'Eveniet maiores laudantium velit.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(265, 'Aerodynamic Granite Table', 12300, '', 'Fuga quisquam perferendis totam non voluptatibus.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(266, 'Small Rubber Pants', 1566, '', 'Dolorum suscipit cupiditate corrupti porro incidunt ut earum.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(267, 'Awesome Steel Pants', 5881, '', 'Quam aut ut sit.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(268, 'Lightweight Leather Hat', 34071, '', 'Enim exercitationem delectus natus sed id quia.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(269, 'Sleek Copper Watch', 41239, '', 'Voluptas ut nesciunt minus sed consequuntur eos.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(270, 'Mediocre Marble Hat', 14365, '', 'Dolorem ratione unde mollitia et.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 1),
(271, 'Small Granite Lamp', 35516, '', 'Nam dignissimos perferendis.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(272, 'Durable Bronze Lamp', 3550, '', 'Beatae saepe rerum dolor voluptatem dolore dolorum libero.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 1),
(273, 'Enormous Aluminum Bench', 22090, '', 'Tempora nostrum qui dolor.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(274, 'Lightweight Rubber Table', 2752, '', 'Autem unde eum ipsa minus et ratione magnam.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(275, 'Durable Wooden Wallet', 20918, '', 'Excepturi velit sit dignissimos.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(276, 'Practical Silk Watch', 3919, '', 'Sit nostrum voluptatem soluta suscipit id odit.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(277, 'Mediocre Bronze Watch', 25916, '', 'Accusantium rerum sit expedita sed dolor error.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(278, 'Intelligent Bronze Bench', 22197, '', 'Commodi aut eum iusto ex consequuntur.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(279, 'Durable Rubber Pants', 41091, '', 'Voluptate laboriosam repellat id sit corrupti.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(280, 'Mediocre Paper Chair', 1947, '', 'Rerum aut consequatur minus exercitationem hic et et.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(281, 'Mediocre Bronze Bag', 26698, '', 'Excepturi et ex nesciunt quia fuga placeat.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(282, 'Fantastic Paper Bottle', 10566, '', 'Expedita eos consectetur consequatur animi velit tempore reiciendis.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(283, 'Heavy Duty Silk Bag', 28744, '', 'Omnis quas velit.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(284, 'Durable Paper Hat', 22197, '', 'Placeat vel ipsum.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(285, 'Lightweight Linen Wallet', 49354, '', 'Velit fugit et totam aut temporibus.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(286, 'Fantastic Granite Pants', 2972, '', 'Eum rerum non quia eum ea.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(287, 'Durable Paper Clock', 23096, '', 'Laboriosam ex iure.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(288, 'Fantastic Concrete Knife', 18458, '', 'Repellat possimus maxime sed qui omnis numquam.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(289, 'Awesome Wooden Knife', 31657, '', 'Et totam cum ab veritatis.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(290, 'Mediocre Rubber Bag', 25243, '', 'Reiciendis expedita ab corporis.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(291, 'Heavy Duty Silk Shoes', 40916, '', 'Dolor voluptas exercitationem.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(292, 'Incredible Paper Bag', 6599, '', 'Omnis consequatur in consequatur.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(293, 'Ergonomic Wool Bag', 16291, '', 'Eos recusandae ut velit sint iure non.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(294, 'Awesome Plastic Keyboard', 17744, '', 'Id vel sit ratione.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4);

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `image_url` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'user'),
(2, 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `social_accounts`
--

CREATE TABLE `social_accounts` (
  `id` int(11) NOT NULL,
  `provider` varchar(20) NOT NULL COMMENT 'Tên nhà social network',
  `provider_id` varchar(50) NOT NULL,
  `email` varchar(150) NOT NULL COMMENT 'Email tài khoản',
  `name` varchar(100) NOT NULL COMMENT 'Tên người dùng',
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tokens`
--

CREATE TABLE `tokens` (
  `id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `token_type` varchar(50) NOT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expired` tinyint(1) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fullname` varchar(100) DEFAULT '',
  `phone_number` varchar(10) NOT NULL,
  `address` varchar(200) DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `date_of_birth` date DEFAULT NULL,
  `facebook_account_id` int(11) DEFAULT 0,
  `google_account_id` int(11) DEFAULT 0,
  `role_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullname`, `phone_number`, `address`, `password`, `created_at`, `updated_at`, `is_active`, `date_of_birth`, `facebook_account_id`, `google_account_id`, `role_id`) VALUES
(1, 'john wick', '11344567', 'America, New York', 'hashpassword', NULL, NULL, 1, '2000-03-03', 0, 0, NULL),
(2, 'nguyen van a', '1213456', 'Đồng Nai', '$2a$10$M8wgM2uS.bYn7GYCGCwGeeqt.j66M0xC33J8Vt4JaNnQIs2eX1CNe', '2024-05-11 13:12:30', '2024-05-11 13:12:30', 0, '2000-03-05', 0, 0, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_product_images_product_id` (`product_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_accounts`
--
ALTER TABLE `social_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=295;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `social_accounts`
--
ALTER TABLE `social_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `fk_product_images_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `social_accounts`
--
ALTER TABLE `social_accounts`
  ADD CONSTRAINT `social_accounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `tokens`
--
ALTER TABLE `tokens`
  ADD CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
