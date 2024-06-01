-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 01, 2024 at 05:35 AM
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
(1, 'Synergistic Bronze Knife', 39.7, '0a523cb9-48e3-45cf-bf35-b7ad3847dae2_001.jpg', 'Ab omnis soluta porro.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(2, 'Fantastic Granite Bench', 22.5, '4934cefb-ddc6-4f60-93d4-1f2e141bcba9_006.jpg', 'Ipsam dolores fuga et saepe nostrum et dolore.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(3, 'Sleek Copper Knife', 40, 'dafdd66c-548e-4c18-a0be-42e059bdb1f2_011.jpg', 'Quos voluptatibus quia nobis qui.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(4, 'Sleek Iron Hat', 10.1, 'da4cf553-663a-49cf-9e0d-996cf128ce1c_016.jpg', 'Incidunt aperiam doloremque voluptate consectetur.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(5, 'Fantastic Linen Plate', 24.9, '161359d9-548a-4a04-8b56-1469fc786847_021.jpg', 'Voluptas dolor repellendus eius.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(6, 'Practical Paper Lamp', 14.8, 'd6e500b5-9ade-4b81-b03e-eabdf6481979_026.jpg', 'Corrupti qui vel molestias eveniet nemo.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(7, 'Gorgeous Aluminum Shirt', 36.2, '4fe6d3c9-bacb-478d-b23e-ddd728cb04c8_031.jpg', 'Beatae nulla et possimus exercitationem nobis.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(8, 'Intelligent Silk Bench', 48.9, '9bb8b1b0-a034-4ee3-93b4-c16ced6d4a68_036.jpg', 'Rerum cupiditate ratione.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(9, 'Small Plastic Watch', 18, 'a1bc55f3-5140-43c7-bd7e-771a5000f070_041.jpg', 'Reprehenderit iure facere facere.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(10, 'Mediocre Wool Wallet', 37, '243d9116-7fd6-4b24-8b3c-a4aa1867e0a0_046.jpg', 'Et repudiandae ab in eaque nihil quidem voluptates.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(11, 'Enormous Marble Computer', 3.2, '6851e4f4-6ca4-478a-8761-d1ee872e0c48_051.jpg', 'Odio adipisci voluptatem quasi vero.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(12, 'Practical Paper Table', 31.7, '88161195-628b-4b13-96b3-d5cf2569a772_056.jpg', 'Facere eveniet consequatur debitis autem neque aut.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(13, 'Practical Concrete Plate', 18.4, 'ed842bc4-de54-464d-bc62-c919d1cb7f6a_061.jpg', 'Voluptatem eum magni est delectus qui.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(14, 'Incredible Aluminum Chair', 16.7, '2ab42510-c030-4f21-91a0-72ff43f530e0_066.jpg', 'Quod maxime ipsam error consequuntur nihil facilis voluptas.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(15, 'Enormous Marble Shirt', 46.3, 'af4f0d73-d19b-44d3-86b8-5dcd1855f385_080.jpg', 'Rerum veritatis voluptatem earum perferendis perferendis ad sit.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(16, 'Small Wool Plate', 28.2, 'deaf2e92-b3cb-4297-958b-91d79704a645_085.jpg', 'Vitae voluptas repudiandae qui.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(17, 'Rustic Wooden Bag', 40.7, '49c70356-9db7-49f4-949e-0d27c2ef3273_090.jpg', 'A consequatur ratione voluptatem qui quasi ullam consequuntur.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(18, 'Awesome Marble Bottle', 44.1, '00710447-b10e-4812-a865-0ad3afe17cfe_095.jpg', 'Assumenda deleniti rem in impedit est quia.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(19, 'Lightweight Marble Lamp', 15.1, '313b2672-2d71-47f2-95c2-8a05e9ba1d76_100.jpg', 'Distinctio veritatis enim voluptatibus.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(20, 'Fantastic Linen Gloves', 17.1, 'c0e73ab0-91cb-4a90-a473-afd8e18428bd_105.jpg', 'Consequuntur rem ut et quam sed illum ipsum.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(21, 'Small Concrete Bottle', 35.4, '16851a28-3d00-47d6-a805-a814366e7d06_111.jpg', 'Laborum omnis fugiat et.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(22, 'Ergonomic Bronze Shirt', 2.1, '216359d3-ee99-4bd1-96ae-47bf05073982_116.jpg', 'Maxime aut velit quia.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(23, 'Rustic Steel Pants', 16.7, 'db57e982-627a-4dac-94b4-f657b620146f_121.jpg', 'Quia voluptatum ullam aut.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(24, 'Practical Granite Knife', 36, '51cc354a-31fb-4756-858c-975d871f1379_126.jpg', 'Reprehenderit laboriosam distinctio rerum.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(25, 'Awesome Wool Watch', 27.2, '6fe024fc-ddf4-4640-9b26-a65f5b775ed4_131.jpg', 'Labore iste in odit quam assumenda alias.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(26, 'Awesome Marble Bag', 21.6, NULL, 'Corrupti ipsum perferendis quia eaque sequi consequuntur.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(27, 'Heavy Duty Iron Hat', 28.5, NULL, 'Similique aut sunt nisi quae blanditiis aliquid.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(28, 'Gorgeous Marble Computer', 47, NULL, 'Pariatur voluptas voluptas.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(29, 'Incredible Cotton Knife', 41.8, NULL, 'Voluptatem quod qui enim aperiam consequatur optio.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(30, 'Synergistic Rubber Shoes', 40.9, NULL, 'Omnis dolorem in.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(31, 'Mediocre Bronze Gloves', 49.3, NULL, 'Quis saepe sint quia.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(32, 'Synergistic Silk Bottle', 14, NULL, 'Dolorem impedit quos libero illum odio.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(33, 'Enormous Leather Coat', 17.2, NULL, 'Expedita non minus nostrum.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(34, 'Durable Plastic Shirt', 41.4, NULL, 'Corrupti culpa error est quisquam magni.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(35, 'Enormous Leather Knife', 41.5, NULL, 'Dolor dolores atque modi omnis aspernatur et.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(36, 'Mediocre Wool Clock', 35.5, NULL, 'Pariatur omnis nobis in et voluptatem adipisci adipisci.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(37, 'Fantastic Steel Bench', 35.4, NULL, 'Nobis quisquam dolore nihil itaque beatae.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(38, 'Durable Granite Table', 8.4, NULL, 'Debitis repellat ipsum ratione repellendus.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(39, 'Intelligent Paper Bench', 22.1, NULL, 'Nulla quasi unde laboriosam ut sunt.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(40, 'Fantastic Iron Wallet', 26.9, NULL, 'Maxime quae placeat.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(41, 'Synergistic Aluminum Coat', 48.7, NULL, 'Iste commodi ratione expedita maiores.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(42, 'Durable Granite Bench', 21, NULL, 'Placeat nostrum modi eos sunt sint pariatur at.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(43, 'Mediocre Iron Computer', 18.8, NULL, 'Sit quos quaerat consectetur qui.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(44, 'Heavy Duty Bronze Hat', 44.4, NULL, 'Quasi dolorem non et eius eaque molestias laudantium.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(45, 'Durable Wooden Table', 6.2, NULL, 'Autem qui quaerat velit est aliquam dolor.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(46, 'Enormous Plastic Plate', 3.7, NULL, 'Vel incidunt aliquid.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(47, 'Incredible Silk Lamp', 27.8, NULL, 'Et rem fugiat numquam cumque.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(48, 'Ergonomic Aluminum Plate', 20.5, NULL, 'Error commodi blanditiis ab quis et sit.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(49, 'Ergonomic Cotton Knife', 32.3, NULL, 'Quo velit rerum deleniti.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(50, 'Practical Rubber Shirt', 7.8, NULL, 'Cum odit cumque.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(51, 'Practical Wooden Pants', 21.3, NULL, 'Recusandae occaecati deserunt.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(52, 'Mediocre Wooden Shirt', 34.8, NULL, 'Qui eveniet non magnam possimus sint molestias perspiciatis.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(53, 'Small Wooden Table', 45.8, NULL, 'Ut sit quisquam corrupti soluta est similique maxime.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(54, 'Synergistic Steel Bag', 49.6, NULL, 'Veniam delectus aut.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(55, 'Small Paper Coat', 49.3, NULL, 'Ipsam ut aut fugit omnis.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(56, 'Incredible Concrete Bag', 34.5, NULL, 'Hic praesentium culpa maiores labore placeat est.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(57, 'Small Aluminum Table', 38.5, NULL, 'Aut ipsam adipisci officiis impedit excepturi quaerat.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(58, 'Ergonomic Wool Car', 1.6, NULL, 'Qui sed consectetur possimus laudantium.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(59, 'Ergonomic Paper Bottle', 16.6, NULL, 'Saepe nobis voluptate voluptatem enim.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(60, 'Incredible Rubber Computer', 47, NULL, 'Debitis explicabo cumque.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(61, 'Gorgeous Bronze Coat', 6.9, NULL, 'Quibusdam dolores occaecati facilis voluptates.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(62, 'Heavy Duty Linen Plate', 23.4, NULL, 'Modi nihil autem.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(63, 'Incredible Copper Bottle', 32.1, NULL, 'Fugiat id odit magnam voluptate.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(64, 'Aerodynamic Plastic Plate', 36.9, NULL, 'Non qui est omnis molestiae non.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(65, 'Enormous Plastic Keyboard', 26.6, NULL, 'Ea nihil quia id ipsum aut.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(66, 'Incredible Marble Lamp', 9.4, NULL, 'Laudantium itaque natus rerum in nostrum quo dicta.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(67, 'Aerodynamic Iron Bag', 28.2, NULL, 'Vitae cupiditate possimus.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(68, 'Durable Marble Clock', 33.4, NULL, 'Architecto illum repellendus libero eligendi pariatur et.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(69, 'Lightweight Plastic Bag', 29, NULL, 'Amet illum exercitationem omnis.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(70, 'Enormous Wool Shirt', 4.6, NULL, 'Blanditiis illo asperiores veniam exercitationem harum officiis.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(71, 'Enormous Steel Gloves', 28.4, NULL, 'Voluptatum repellendus est aperiam autem ex.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(72, 'Durable Copper Wallet', 47.2, NULL, 'Dicta quos voluptatum est et mollitia.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(73, 'Enormous Copper Car', 1.6, NULL, 'Ut ut dolor laborum dignissimos libero consequatur molestiae.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 1),
(74, 'Incredible Aluminum Watch', 30.7, NULL, 'Provident repudiandae voluptatem non repellat ullam.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(75, 'Incredible Leather Knife', 36.6, NULL, 'Sed sit nulla voluptas sit nostrum.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 3),
(76, 'Synergistic Wool Clock', 41.8, NULL, 'Vitae eum velit necessitatibus.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(77, 'Small Rubber Lamp', 5.1, NULL, 'Omnis aut dolorum aliquam quam sit nesciunt impedit.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 4),
(78, 'Gorgeous Plastic Pants', 19.2, NULL, 'Quis recusandae qui cupiditate aut labore.', '2024-04-19 13:27:46', '2024-04-19 13:27:46', 2),
(79, 'Sleek Wooden Chair', 24, NULL, 'Sint vel natus temporibus ut nam labore.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(80, 'Small Linen Shirt', 19.9, NULL, 'Sit ad quae.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(81, 'Incredible Marble Clock', 11.9, NULL, 'Repudiandae a ut sed.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(82, 'Practical Rubber Table', 46.8, NULL, 'Dignissimos molestias qui aperiam.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(83, 'Heavy Duty Paper Keyboard', 7.6, NULL, 'Placeat eius sed ex id sed est.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(84, 'Ergonomic Paper Keyboard', 3, NULL, 'Vel atque officia.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(85, 'Synergistic Paper Coat', 46.6, NULL, 'Porro deleniti porro iure excepturi.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(86, 'Practical Rubber Plate', 24.8, NULL, 'Est et dolorum repellendus perspiciatis.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(87, 'Synergistic Steel Knife', 44.7, NULL, 'Voluptas doloremque recusandae praesentium.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(88, 'Durable Marble Coat', 41.7, NULL, 'Consequatur magnam quis voluptates.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(89, 'Enormous Wool Clock', 28.1, NULL, 'Assumenda et harum rerum voluptatem officiis.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(90, 'Synergistic Marble Car', 5, NULL, 'Repellat exercitationem delectus dolor.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(91, 'Mediocre Paper Shoes', 18.9, NULL, 'Culpa exercitationem aut doloribus qui facilis et voluptatem.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(92, 'Sleek Concrete Computer', 35.7, NULL, 'Voluptates corporis velit hic.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(93, 'Lightweight Rubber Plate', 38.3, NULL, 'Quis consequatur voluptatem aut odit ut dolores exercitationem.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(94, 'Incredible Concrete Clock', 9.3, NULL, 'Recusandae vitae minus quod suscipit ut quis minus.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(95, 'Small Wooden Hat', 35.9, NULL, 'Illum pariatur et cum animi minus mollitia temporibus.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(96, 'Incredible Linen Watch', 22.2, NULL, 'Labore reprehenderit eos mollitia ipsam laborum.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(97, 'Awesome Wool Lamp', 22.9, NULL, 'Quisquam excepturi iste.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(98, 'Durable Wool Shirt', 28, NULL, 'Sunt laboriosam ex error.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(99, 'Durable Aluminum Bench', 9.8, NULL, 'Rem nisi eos quo aut molestiae.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(100, 'Mediocre Paper Wallet', 42.9, NULL, 'Ut quasi eum qui dolor.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(101, 'Sleek Silk Chair', 23.6, NULL, 'Quam deleniti at.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(102, 'Awesome Wool Wallet', 36.2, NULL, 'Voluptas voluptas dicta.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(103, 'Synergistic Steel Clock', 43.9, NULL, 'Omnis dolores quia sunt.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(104, 'Mediocre Copper Bench', 9.9, NULL, 'Quia voluptatum et.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(105, 'Heavy Duty Bronze Clock', 28.3, NULL, 'Alias ex aut.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(106, 'Gorgeous Wool Watch', 38.5, NULL, 'Dolor culpa libero quasi eos.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(107, 'Practical Wooden Lamp', 43.5, NULL, 'Ut iusto laborum et.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(108, 'Synergistic Iron Table', 48.1, NULL, 'Inventore reprehenderit fugiat necessitatibus nesciunt.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(109, 'Fantastic Iron Keyboard', 19.3, NULL, 'Quae est dicta qui in consectetur.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(110, 'Awesome Iron Chair', 37.3, NULL, 'Iste placeat sunt fugit voluptatum minus sed enim.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(111, 'Sleek Steel Gloves', 5.7, NULL, 'Omnis id ipsa.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(112, 'Incredible Plastic Shoes', 48.3, NULL, 'Nesciunt vitae natus architecto voluptas maxime doloribus.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(113, 'Mediocre Bronze Keyboard', 1.4, NULL, 'Voluptas ut doloremque architecto ea.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(114, 'Heavy Duty Bronze Plate', 34.2, NULL, 'At non facilis fugiat.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(115, 'Rustic Silk Lamp', 33.3, NULL, 'Similique saepe ab quia.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(116, 'Awesome Steel Clock', 37.3, NULL, 'Veniam assumenda cum.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(117, 'Awesome Aluminum Shoes', 1.3, NULL, 'Neque nihil et error qui.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(118, 'Gorgeous Granite Bottle', 49.3, NULL, 'Consectetur blanditiis ullam est unde non.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(119, 'Durable Granite Plate', 39, NULL, 'Maxime excepturi fuga tenetur deleniti aut.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(120, 'Fantastic Wool Coat', 11.6, NULL, 'Rerum et aliquam veritatis sint est.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(121, 'Small Linen Pants', 46.6, NULL, 'Autem voluptatem quidem officia expedita id rerum.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(122, 'Sleek Plastic Computer', 19.1, NULL, 'Est consequatur sint.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(123, 'Heavy Duty Wooden Gloves', 42.9, NULL, 'Et iste exercitationem dolorum id.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(124, 'Rustic Leather Bottle', 16.7, NULL, 'Rerum fuga facilis officia consequatur eum omnis officia.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(125, 'Small Wool Shoes', 14.8, NULL, 'Nihil sed voluptatem debitis quasi ipsa eveniet.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(126, 'Heavy Duty Silk Wallet', 25.8, NULL, 'Fugiat harum magni nisi consequatur.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(127, 'Ergonomic Steel Keyboard', 22.5, NULL, 'Nihil sequi sed sed inventore veniam.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(128, 'Rustic Wooden Chair', 23.6, NULL, 'Praesentium vero rerum ut ut ratione.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(129, 'Durable Aluminum Hat', 21, NULL, 'Quas molestiae architecto dolor id voluptates sint aut.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(130, 'Enormous Steel Bench', 47.7, NULL, 'Sit optio quo.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(131, 'Awesome Wooden Watch', 24.6, NULL, 'Quisquam autem aut fugiat cum quia similique quia.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(132, 'Durable Wool Wallet', 2.9, NULL, 'Omnis in sed reiciendis ea.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(133, 'Rustic Marble Shoes', 24.8, NULL, 'Error eius et sapiente.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(134, 'Practical Rubber Chair', 34.2, NULL, 'Assumenda adipisci quae ipsa.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(135, 'Rustic Silk Coat', 38.8, NULL, 'Odit aut explicabo corrupti repudiandae.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(136, 'Ergonomic Leather Pants', 47.1, NULL, 'Exercitationem nisi saepe.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(137, 'Rustic Paper Coat', 29.7, NULL, 'Facere sequi autem inventore facilis architecto voluptatem pariatur.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(138, 'Intelligent Granite Wallet', 17.6, NULL, 'Id voluptatum fugiat.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(139, 'Gorgeous Linen Shoes', 30, NULL, 'Inventore ullam delectus cumque ut perferendis facere odio.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(140, 'Practical Bronze Shirt', 43.7, NULL, 'Facere corrupti illo aperiam.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(141, 'Mediocre Rubber Computer', 30.2, NULL, 'Ratione molestias incidunt est maiores omnis dolorem ipsa.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(142, 'Rustic Plastic Knife', 45.8, NULL, 'Eligendi praesentium nam eum et quaerat quis voluptas.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(143, 'Heavy Duty Bronze Coat', 17.7, NULL, 'Omnis debitis ex aut.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(144, 'Awesome Leather Lamp', 25.1, NULL, 'Odio ut doloremque blanditiis ea rerum.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(145, 'Synergistic Iron Hat', 42.3, NULL, 'Reiciendis ipsam qui occaecati neque in cum modi.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(146, 'Mediocre Wooden Chair', 15.7, NULL, 'Nisi nulla omnis quis ratione.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(147, 'Mediocre Steel Chair', 34.1, NULL, 'Dolore autem eius esse.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(148, 'Intelligent Wooden Shoes', 39.2, NULL, 'Necessitatibus iusto non et.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(149, 'Aerodynamic Steel Gloves', 7.3, NULL, 'Excepturi doloremque voluptate nulla voluptates.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(150, 'Durable Paper Shirt', 38.8, NULL, 'Excepturi cupiditate repellendus maiores eum dolore.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(151, 'Fantastic Wooden Coat', 34.8, NULL, 'Porro excepturi velit.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(152, 'Rustic Bronze Chair', 42.1, NULL, 'Labore quos repellendus necessitatibus neque aut.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(153, 'Durable Aluminum Table', 16.6, NULL, 'Earum aut eos consequatur iusto et.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(154, 'Practical Cotton Keyboard', 49.2, NULL, 'Eum et velit voluptatum odit est error.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(155, 'Intelligent Silk Shirt', 2.4, NULL, 'Cumque modi modi voluptatem repellat et.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(156, 'Mediocre Wool Pants', 17.7, NULL, 'Cupiditate suscipit ad.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 1),
(157, 'Awesome Bronze Bench', 36.4, NULL, 'Pariatur ratione reprehenderit molestiae eveniet illo nemo.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 4),
(158, 'Small Iron Chair', 44.2, NULL, 'Doloremque quibusdam dicta nisi.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(159, 'Mediocre Wooden Gloves', 9.9, NULL, 'Sunt neque voluptatibus sint quae.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 3),
(160, 'Gorgeous Linen Gloves', 16.4, NULL, 'Reprehenderit magni aliquid et laboriosam et molestiae.', '2024-04-19 13:27:47', '2024-04-19 13:27:47', 2),
(161, 'Synergistic Paper Car', 48.1, NULL, 'Nostrum qui aliquid.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(162, 'Gorgeous Cotton Chair', 23.4, NULL, 'Ea reprehenderit repellat placeat et accusamus aliquid.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(163, 'Enormous Aluminum Bag', 13.6, NULL, 'Perspiciatis facilis nemo ut voluptatem.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(164, 'Rustic Iron Car', 8.7, NULL, 'Ea sit repudiandae.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(165, 'Incredible Rubber Clock', 1.6, NULL, 'Pariatur repellendus a quasi perspiciatis nisi.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(166, 'Incredible Plastic Coat', 24.6, NULL, 'Laborum consectetur repellat non suscipit.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(167, 'Enormous Silk Watch', 3.9, NULL, 'A dolores facilis voluptas ea nobis tenetur cum.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(168, 'Sleek Plastic Keyboard', 22.4, NULL, 'Quia doloribus sit explicabo.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(169, 'Ergonomic Paper Coat', 9.5, NULL, 'Aut vel at qui in.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(170, 'Incredible Marble Watch', 21.3, NULL, 'Qui illo repellendus quas voluptatem omnis id.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(171, 'Fantastic Granite Watch', 42.4, NULL, 'In fugiat nihil tempora quibusdam soluta aut recusandae.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(172, 'Ergonomic Bronze Gloves', 1.5, NULL, 'In impedit quibusdam consequatur qui.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(173, 'Sleek Bronze Watch', 17.8, NULL, 'Cumque facere iste corrupti qui facere.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(174, 'Fantastic Silk Plate', 8.5, NULL, 'Rem distinctio tempore at.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(175, 'Fantastic Steel Shoes', 13.7, NULL, 'Ex earum doloremque eius minima tenetur impedit.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(176, 'Rustic Rubber Bag', 34, NULL, 'Quia iste illum repudiandae ab reprehenderit vel.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(177, 'Gorgeous Cotton Keyboard', 8, NULL, 'Commodi commodi minus.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(178, 'Incredible Wool Wallet', 38.2, NULL, 'Aliquid omnis eligendi aut ut placeat sed.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(179, 'Awesome Bronze Bag', 20.1, NULL, 'Modi qui nihil eos ullam eius.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(180, 'Incredible Copper Clock', 48.7, NULL, 'Repellat ut ducimus corporis.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(181, 'Durable Copper Keyboard', 23.5, NULL, 'A esse amet.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(182, 'Gorgeous Linen Coat', 36.2, NULL, 'Harum est dolores vel ut et molestiae.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(183, 'Durable Iron Chair', 32, NULL, 'Numquam ipsa sint placeat sunt deserunt sed ducimus.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(184, 'Ergonomic Copper Computer', 23.6, NULL, 'Non fuga autem numquam.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(185, 'Mediocre Silk Watch', 46, NULL, 'Sed autem et.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(186, 'Aerodynamic Iron Car', 4, NULL, 'Nulla tempora consequatur rem.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(187, 'Practical Granite Clock', 21.6, NULL, 'Nulla et atque assumenda non voluptatem dolore placeat.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(188, 'Intelligent Silk Car', 49.1, NULL, 'Aut ratione quisquam delectus facilis ad.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(189, 'Awesome Paper Bottle', 34.3, NULL, 'Cum non sit rem.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(190, 'Sleek Cotton Gloves', 48.7, NULL, 'Nisi corporis rerum non aperiam ut.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(191, 'Rustic Concrete Pants', 30.2, NULL, 'Mollitia eius impedit quia rerum laboriosam ullam.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(192, 'Enormous Paper Hat', 18.4, NULL, 'Voluptas accusamus illum aut molestiae repellat aut dignissimos.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(193, 'Gorgeous Marble Lamp', 34.2, NULL, 'Quis pariatur veniam quo sequi aliquam in nihil.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(194, 'Enormous Concrete Wallet', 46.4, NULL, 'Commodi architecto sint qui voluptatem voluptas tempora.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(195, 'Practical Leather Gloves', 8.4, NULL, 'Aut quas dolore dolor.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(196, 'Enormous Aluminum Knife', 31.9, NULL, 'Necessitatibus omnis omnis nihil dolorem et ea.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(197, 'Heavy Duty Rubber Chair', 32.4, NULL, 'Illo voluptatem ducimus quis ut molestiae aut explicabo.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(198, 'Lightweight Granite Lamp', 32.5, NULL, 'Quidem omnis qui beatae amet occaecati et expedita.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(199, 'Gorgeous Silk Hat', 1.5, NULL, 'Animi aliquam est eveniet ut.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(200, 'Gorgeous Wool Lamp', 12, NULL, 'Aut repudiandae officiis.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(201, 'Synergistic Silk Knife', 17.6, NULL, 'Fuga animi autem.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(202, 'Synergistic Iron Coat', 39.1, NULL, 'Fugit quia neque facilis molestiae nihil ipsam tempore.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(203, 'Intelligent Rubber Hat', 39.1, NULL, 'Harum incidunt et eligendi quis dolor in et.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(204, 'Rustic Bronze Table', 3.2, NULL, 'Eos voluptatem ratione perspiciatis natus.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(205, 'Ergonomic Marble Bottle', 26.5, NULL, 'Inventore sequi commodi eos aliquam assumenda.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(206, 'Durable Marble Shoes', 10.6, NULL, 'Eos hic sequi ullam.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(207, 'Fantastic Aluminum Pants', 46.2, NULL, 'Et aut culpa sapiente.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(208, 'Awesome Concrete Shirt', 45, NULL, 'Necessitatibus voluptates minima amet quasi.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(209, 'Rustic Rubber Bottle', 4.6, NULL, 'Voluptatem ut quisquam quia quia repellendus.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(210, 'Gorgeous Granite Table', 5.7, NULL, 'Labore vitae omnis nam ut optio illum.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(211, 'Small Wool Knife', 43.5, NULL, 'Possimus vitae praesentium qui quasi quibusdam.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(212, 'Enormous Silk Chair', 36.3, NULL, 'Quod doloribus possimus quisquam assumenda id.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(213, 'Durable Rubber Hat', 21.6, NULL, 'Quo ad perferendis eaque sint nam molestias.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(214, 'Incredible Copper Bench', 1.4, NULL, 'Quisquam cumque alias iusto nihil sit commodi.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(215, 'Heavy Duty Cotton Shirt', 1.6, NULL, 'Adipisci perferendis incidunt architecto nulla omnis est.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(216, 'Synergistic Bronze Shirt', 17, NULL, 'Neque incidunt et minus maiores.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(217, 'Ergonomic Linen Keyboard', 32.2, NULL, 'Quos et corporis provident.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(218, 'Aerodynamic Steel Wallet', 39.7, NULL, 'Quia quisquam dignissimos sit officia voluptas nemo.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(219, 'Aerodynamic Linen Pants', 32, NULL, 'Optio autem minima dicta sit aperiam.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(220, 'Gorgeous Paper Hat', 24.3, NULL, 'Eum aliquam rerum.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(221, 'Gorgeous Marble Bench', 45, NULL, 'Voluptatem quibusdam dignissimos voluptas excepturi quisquam.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(222, 'Enormous Rubber Knife', 30.9, NULL, 'Sit ducimus assumenda iusto minus iusto autem a.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(223, 'Heavy Duty Copper Watch', 35.3, NULL, 'Deleniti laborum voluptas.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(224, 'Enormous Iron Car', 45.7, NULL, 'Dolorum facilis totam et asperiores veniam ducimus.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(225, 'Awesome Linen Table', 34.1, NULL, 'Facilis ut doloremque.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(226, 'Enormous Steel Pants', 22.8, NULL, 'Et debitis odio recusandae adipisci aut.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(227, 'Small Plastic Pants', 32.7, NULL, 'Odio eius excepturi nesciunt impedit.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(228, 'Durable Silk Keyboard', 4.6, NULL, 'Consequatur in autem facere debitis expedita rerum et.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(229, 'Sleek Silk Clock', 17.7, NULL, 'Blanditiis itaque dolor temporibus.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(230, 'Intelligent Iron Watch', 7.8, NULL, 'Quam aut repellendus.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(231, 'Awesome Linen Keyboard', 36.9, NULL, 'Quod sit occaecati in aut.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(232, 'Fantastic Copper Wallet', 12, NULL, 'Placeat facere corporis eum inventore nisi sit et.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(233, 'Small Wool Hat', 26.9, NULL, 'Consequatur delectus rerum vero.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(234, 'Practical Bronze Pants', 10.7, NULL, 'Doloremque aut qui ea perferendis laboriosam maxime quas.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(235, 'Heavy Duty Silk Knife', 40.7, NULL, 'Delectus autem dolor aliquid.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(236, 'Aerodynamic Linen Wallet', 35.5, NULL, 'Est et neque ipsum cum fuga.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 1),
(237, 'Awesome Cotton Bench', 8.6, NULL, 'Sunt qui soluta rem.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 2),
(238, 'Heavy Duty Paper Bottle', 24, NULL, 'Qui impedit error reiciendis natus nihil dolores.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 4),
(239, 'Intelligent Rubber Bag', 29, NULL, 'Rerum eum ut.', '2024-04-19 13:27:48', '2024-04-19 13:27:48', 3),
(240, 'Enormous Leather Car', 11.5, NULL, 'Excepturi corrupti corrupti minima.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(241, 'Rustic Marble Clock', 18, NULL, 'Earum voluptatem fugit qui nulla voluptates tempora.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(242, 'Synergistic Marble Gloves', 36.3, NULL, 'Neque est cumque aut est.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(243, 'Heavy Duty Rubber Knife', 42.7, NULL, 'Reprehenderit voluptas exercitationem hic dolores omnis sed.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(244, 'Practical Granite Keyboard', 44.2, NULL, 'Quasi quae sed iusto consequatur fugiat sit.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(245, 'Small Rubber Plate', 22.5, NULL, 'Quo laudantium natus sint placeat.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(246, 'Mediocre Copper Pants', 40.5, NULL, 'Vel voluptatem quo recusandae quis saepe soluta veritatis.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(247, 'Lightweight Concrete Knife', 4.3, NULL, 'Omnis ea dolore molestiae dolorum perspiciatis est ea.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 1),
(248, 'Lightweight Rubber Computer', 9.6, NULL, 'Blanditiis non non impedit nostrum vitae.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(249, 'Mediocre Rubber Plate', 19.8, NULL, 'Veritatis architecto sit.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(250, 'Aerodynamic Iron Keyboard', 2.4, NULL, 'Molestiae ut eaque amet.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(251, 'Awesome Leather Computer', 11, NULL, 'Ab perspiciatis quas quaerat deserunt labore natus.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(252, 'Aerodynamic Plastic Bag', 38.8, NULL, 'Laudantium culpa molestiae distinctio atque quasi.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 1),
(253, 'Incredible Silk Hat', 29.8, NULL, 'Quae culpa cum sit ipsum quo iure.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(254, 'Fantastic Bronze Plate', 22.7, NULL, 'Ut reiciendis dolores quae.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(255, 'Mediocre Cotton Watch', 38.8, NULL, 'Corrupti ut voluptas hic ad occaecati ipsam.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(256, 'Ergonomic Linen Bottle', 48.1, NULL, 'Molestias voluptatem saepe placeat amet id et fugit.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(257, 'Gorgeous Steel Lamp', 26.3, NULL, 'Ea tenetur ad a vero.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(258, 'Heavy Duty Granite Hat', 34.5, NULL, 'Illum voluptas doloremque.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(259, 'Awesome Cotton Chair', 3.3, NULL, 'Suscipit voluptates saepe facere.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(260, 'Awesome Rubber Car', 10, NULL, 'Libero eligendi animi quis eligendi voluptatum illo magni.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(261, 'Sleek Paper Shoes', 25.3, NULL, 'Est laboriosam non et dolorem iusto.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(262, 'Sleek Wooden Plate', 2.3, NULL, 'Pariatur aut est quaerat.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(263, 'Small Wooden Keyboard', 12.8, NULL, 'Totam mollitia qui reprehenderit eaque.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(264, 'Gorgeous Copper Bottle', 24, NULL, 'Eveniet maiores laudantium velit.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(265, 'Aerodynamic Granite Table', 12.3, NULL, 'Fuga quisquam perferendis totam non voluptatibus.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(266, 'Small Rubber Pants', 1.6, NULL, 'Dolorum suscipit cupiditate corrupti porro incidunt ut earum.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(267, 'Awesome Steel Pants', 5.9, NULL, 'Quam aut ut sit.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(268, 'Lightweight Leather Hat', 34.1, NULL, 'Enim exercitationem delectus natus sed id quia.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(269, 'Sleek Copper Watch', 41.2, NULL, 'Voluptas ut nesciunt minus sed consequuntur eos.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(270, 'Mediocre Marble Hat', 14.4, NULL, 'Dolorem ratione unde mollitia et.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 1),
(271, 'Small Granite Lamp', 35.5, NULL, 'Nam dignissimos perferendis.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(272, 'Durable Bronze Lamp', 3.6, NULL, 'Beatae saepe rerum dolor voluptatem dolore dolorum libero.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 1),
(273, 'Enormous Aluminum Bench', 22.1, NULL, 'Tempora nostrum qui dolor.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(274, 'Lightweight Rubber Table', 2.8, NULL, 'Autem unde eum ipsa minus et ratione magnam.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(275, 'Durable Wooden Wallet', 20.9, NULL, 'Excepturi velit sit dignissimos.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(276, 'Practical Silk Watch', 3.9, NULL, 'Sit nostrum voluptatem soluta suscipit id odit.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(277, 'Mediocre Bronze Watch', 25.9, NULL, 'Accusantium rerum sit expedita sed dolor error.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(278, 'Intelligent Bronze Bench', 22.2, NULL, 'Commodi aut eum iusto ex consequuntur.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(279, 'Durable Rubber Pants', 41.1, NULL, 'Voluptate laboriosam repellat id sit corrupti.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(280, 'Mediocre Paper Chair', 1.9, NULL, 'Rerum aut consequatur minus exercitationem hic et et.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(281, 'Mediocre Bronze Bag', 26.7, NULL, 'Excepturi et ex nesciunt quia fuga placeat.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(282, 'Fantastic Paper Bottle', 10.6, NULL, 'Expedita eos consectetur consequatur animi velit tempore reiciendis.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(283, 'Heavy Duty Silk Bag', 28.7, NULL, 'Omnis quas velit.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(284, 'Durable Paper Hat', 22.2, NULL, 'Placeat vel ipsum.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(285, 'Lightweight Linen Wallet', 49.4, NULL, 'Velit fugit et totam aut temporibus.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(286, 'Fantastic Granite Pants', 3, NULL, 'Eum rerum non quia eum ea.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(287, 'Durable Paper Clock', 23.1, NULL, 'Laboriosam ex iure.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(288, 'Fantastic Concrete Knife', 18.5, NULL, 'Repellat possimus maxime sed qui omnis numquam.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(289, 'Awesome Wooden Knife', 31.7, NULL, 'Et totam cum ab veritatis.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 3),
(290, 'Mediocre Rubber Bag', 25.2, NULL, 'Reiciendis expedita ab corporis.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(291, 'Heavy Duty Silk Shoes', 40.9, NULL, 'Dolor voluptas exercitationem.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(292, 'Incredible Paper Bag', 6.6, NULL, 'Omnis consequatur in consequatur.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4),
(293, 'Ergonomic Wool Bag', 16.3, NULL, 'Eos recusandae ut velit sint iure non.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 2),
(294, 'Awesome Plastic Keyboard', 17.7, NULL, 'Id vel sit ratione.', '2024-04-19 13:27:49', '2024-04-19 13:27:49', 4);

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `image_url` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `image_url`) VALUES
(1, 1, '0a523cb9-48e3-45cf-bf35-b7ad3847dae2_001.jpg'),
(2, 1, '22229315-d24c-41de-9ea3-7d995d7debcd_002.jpg'),
(3, 1, 'd249c7d0-b901-4045-afa1-0c074dd6dfa4_003.jpg'),
(4, 1, '768ffb70-fd0f-4831-97a7-1d008bb6dd6b_004.jpg'),
(5, 1, '6734db3d-f398-48c9-818f-065fef8ccf6c_005.jpg'),
(6, 2, '4934cefb-ddc6-4f60-93d4-1f2e141bcba9_006.jpg'),
(7, 2, '61c4211e-6627-4b4f-ba7e-ee56ef6e3bd6_007.jpg'),
(8, 2, '50601005-0d07-41a0-bfc5-2d3d0070ce88_008.jpg'),
(9, 2, '15ce52d2-8b0c-43c5-b971-369dc3670798_009.jpg'),
(10, 2, 'de7d7cdb-7e4d-49c9-9614-a4f2d40210bc_010.jpg'),
(11, 3, 'dafdd66c-548e-4c18-a0be-42e059bdb1f2_011.jpg'),
(12, 3, 'e6ddd870-cfe3-4850-a1ae-b44e6258b905_012.jpg'),
(13, 3, 'da50311d-fc93-44df-9fb9-2825eb4a2d08_013.jpg'),
(14, 3, '5afcdeb7-2d77-4f4f-804b-41f3df45ecc2_014.jpg'),
(15, 3, 'f7332971-a2fe-4f3b-a91b-2a3c4e82a4d9_015.jpg'),
(16, 4, 'da4cf553-663a-49cf-9e0d-996cf128ce1c_016.jpg'),
(17, 4, 'eeb9f0ef-9fe2-4ed2-bf13-4fbaf4620df1_017.jpg'),
(18, 4, '0724fc24-6485-45cb-802d-308fff6b2013_016.jpg'),
(19, 4, '6d30a23d-cc56-455d-9b48-7f8f09ffbdd6_017.jpg'),
(20, 4, 'f00e3d84-18cb-43f5-a35a-9b3a589e8cc3_019.jpg'),
(21, 4, '76cf0fd1-ca0c-4e30-a538-6ba497c043b6_020.jpg'),
(22, 5, '161359d9-548a-4a04-8b56-1469fc786847_021.jpg'),
(23, 5, 'c065bb7e-d9d9-4842-bb6f-bda27b40cd2a_022.jpg'),
(24, 5, 'a2968e70-911f-4697-ac45-1f2fc94e9be8_023.jpg'),
(25, 5, 'edc0b547-6fbe-4282-9929-a1a2d9c02028_024.jpg'),
(26, 5, '94e1edda-272b-4c74-91d6-de26d6a7dfba_025.jpg'),
(27, 6, 'd6e500b5-9ade-4b81-b03e-eabdf6481979_026.jpg'),
(28, 6, '07f5669a-6a69-4070-a3c6-5a00f7e190e4_027.jpg'),
(29, 6, '8b81567e-399c-4c86-8f97-9a9b301baccc_028.jpg'),
(30, 6, '6564a150-bc77-4402-828f-a587a3924140_029.jpg'),
(31, 6, '6830cc24-f7cc-4243-8019-051d72b232a7_030.jpg'),
(32, 7, '4fe6d3c9-bacb-478d-b23e-ddd728cb04c8_031.jpg'),
(33, 7, '80f70d80-ca70-40c9-90cd-41aa6da7563b_032.jpg'),
(34, 7, 'fd778ad0-f536-4819-9463-82bb2ab851ae_033.jpg'),
(35, 7, 'aa9c00e1-8de2-4a89-8e54-56c5a92542bd_034.jpg'),
(36, 7, '2ce61ec0-8848-4336-95ce-732bfde70474_035.jpg'),
(37, 8, '9bb8b1b0-a034-4ee3-93b4-c16ced6d4a68_036.jpg'),
(38, 8, '93d07426-425d-4b96-9317-2de4c259f25a_037.jpg'),
(39, 8, '4d3ea491-50cb-4bab-8b36-6c16f68fc1a3_038.jpg'),
(40, 8, '0e895a4a-f729-4d7f-9b22-240577e87b0a_039.jpg'),
(41, 8, '4537c831-bb02-4ade-a1d5-48dd92f561f8_040.jpg'),
(42, 9, 'a1bc55f3-5140-43c7-bd7e-771a5000f070_041.jpg'),
(43, 9, 'cdbc424b-ae05-4341-8af5-ffbe2761133c_042.jpg'),
(44, 9, 'f29b7e3c-169b-4bce-91bd-aef0ec6992fd_043.jpg'),
(45, 9, '558dbce5-6aad-4f99-a615-b1c19fad4179_044.jpg'),
(46, 9, '9cb79988-a1b6-47a7-9787-42d3beb2ed20_045.jpg'),
(47, 10, '243d9116-7fd6-4b24-8b3c-a4aa1867e0a0_046.jpg'),
(48, 10, 'b2613f1b-b704-4f49-b28b-c9293c720d84_047.jpg'),
(49, 10, '8857e2b9-1b3f-44e3-8140-bcc0b1f2857c_048.jpg'),
(50, 10, '12ef6f80-5ef8-4adc-8dc1-f9972b719cea_049.jpg'),
(51, 10, 'adc11605-092c-4012-9663-420d795c6217_050.jpg'),
(52, 11, '6851e4f4-6ca4-478a-8761-d1ee872e0c48_051.jpg'),
(53, 11, 'ea1d5d0e-94b5-4201-b34f-bb942db20ce0_052.jpg'),
(54, 11, '6adcba3b-4d47-4bd2-bc2b-33b68257ccd1_053.jpg'),
(55, 11, '439604db-f39f-48ed-977d-968b84aecfac_054.jpg'),
(56, 11, '7fb8bf2b-95a4-49cf-9210-aa5731c7df26_055.jpg'),
(57, 12, '88161195-628b-4b13-96b3-d5cf2569a772_056.jpg'),
(58, 12, 'cf660486-54c3-462c-913f-9ddf9bcfacee_057.jpg'),
(59, 12, '3806dfe5-3410-4f46-a0c5-d56c38e99ce6_058.jpg'),
(60, 12, '32634bbb-c33d-4f0d-b3dc-c2159ab8d3d7_059.jpg'),
(61, 12, 'ac24c9d7-86b9-4710-8c34-4bbab0e68081_060.jpg'),
(62, 13, 'ed842bc4-de54-464d-bc62-c919d1cb7f6a_061.jpg'),
(63, 13, '436ab82f-8f75-485c-bdd2-127dbc24a334_062.jpg'),
(64, 13, 'd6e8b622-f83b-4868-ad3e-305d44d52617_063.jpg'),
(65, 13, '3d5d5b29-4303-4ac9-b7e7-64aec1969cd2_064.jpg'),
(66, 13, '124afcb8-e372-44f4-a83f-8c8eb9ee9f35_065.jpg'),
(67, 14, '2ab42510-c030-4f21-91a0-72ff43f530e0_066.jpg'),
(68, 14, 'bb6c35f6-c0a0-493d-866e-0c7aabeec62e_067.jpg'),
(69, 14, '7a0e1fb9-ea87-4b2c-b6f2-87f4cd5cb4ed_068.jpg'),
(70, 14, '4b393bb0-4750-42eb-9ec4-7852c131986f_069.jpg'),
(71, 14, '28b0b1a6-cf21-47f9-b8d9-e2f23e1033fd_070.jpg'),
(72, 15, 'af4f0d73-d19b-44d3-86b8-5dcd1855f385_080.jpg'),
(73, 15, '5ae2fab8-c79f-4435-837f-7c34fdf57224_081.jpg'),
(74, 15, 'cec96ce7-4488-4a1e-acc3-71e4876d6e5d_082.jpg'),
(75, 15, 'ed1d92cc-89b6-4a57-bb34-cdc92934e4d1_083.jpg'),
(76, 15, '9f440669-d5a8-4aec-b7a3-27b51a12cee9_084.jpg'),
(77, 16, 'deaf2e92-b3cb-4297-958b-91d79704a645_085.jpg'),
(78, 16, 'f2ffa184-d76c-4eae-93eb-049e680286ba_086.jpg'),
(79, 16, '0fd3e262-12e6-4e51-877c-dcd406ec931b_087.jpg'),
(80, 16, 'd226712d-bd0d-4c00-a1e9-b7d4d3fad204_088.jpg'),
(81, 16, '65f8a1c1-a7dd-447b-97f7-053d9a3dd7e0_089.jpg'),
(82, 17, '49c70356-9db7-49f4-949e-0d27c2ef3273_090.jpg'),
(83, 17, 'b22aee7d-d3de-42bf-b547-66b7c98a648a_091.jpg'),
(84, 17, '32913a71-c792-4ad8-b046-b85b26e52b61_092.jpg'),
(85, 17, '903e2d46-259a-4e03-9a30-1b444acf0ff1_093.jpg'),
(86, 17, '18266fa4-16e4-4050-a15c-1ba7bb068730_094.jpg'),
(87, 18, '00710447-b10e-4812-a865-0ad3afe17cfe_095.jpg'),
(88, 18, '8a872286-ec11-4245-a5b0-753bcc367b8a_096.jpg'),
(89, 18, 'a1b79303-1664-4cb2-9500-f4d82664a74d_097.jpg'),
(90, 18, 'c063e464-6b5a-46e2-8860-e28744fe21ff_098.jpg'),
(91, 18, 'c8d218c6-6b6f-4ba9-a1e8-de5fd036f1be_099.jpg'),
(92, 19, '313b2672-2d71-47f2-95c2-8a05e9ba1d76_100.jpg'),
(93, 19, '8185cf1f-7fb3-493f-877b-f56917ad25d3_101.jpg'),
(94, 19, '5492df39-442d-4984-bb17-5ec53e8574d1_102.jpg'),
(95, 19, '9ebb58e1-2b76-4f2b-a33e-8d3a5686826b_103.jpg'),
(96, 19, 'e9f46f39-bc96-41a3-8559-c002ee8b9278_104.jpg'),
(97, 20, 'c0e73ab0-91cb-4a90-a473-afd8e18428bd_105.jpg'),
(98, 20, '0ec92ad8-d49f-40ef-81d1-0e9088330c8e_106.jpg'),
(99, 20, '6c24b776-8909-47a3-b69c-1a0f36247ead_108.jpg'),
(100, 20, '7bd36446-17c4-4850-a3f9-84072fb3f454_109.jpg'),
(101, 20, '0be2d506-0db2-497a-98a8-aa6c5c8f7745_110.jpg'),
(102, 21, '16851a28-3d00-47d6-a805-a814366e7d06_111.jpg'),
(103, 21, 'f157c187-9026-415d-8691-058a6e99c96d_112.jpg'),
(104, 21, '44ebc125-fd2f-441c-8615-1aecea9ef133_113.jpg'),
(105, 21, 'ff452f3a-ca13-4b32-88c4-5f780d597105_114.jpg'),
(106, 21, 'ac6f5395-25b2-45f4-a835-cd8a90b84990_115.jpg'),
(107, 22, '216359d3-ee99-4bd1-96ae-47bf05073982_116.jpg'),
(108, 22, 'bb26daaa-4bae-4ada-b764-afdbd52dc2b5_117.jpg'),
(109, 22, 'af6deb3b-e6a1-4e34-ab21-84f3dea85859_118.jpg'),
(110, 22, 'b7e05da9-5ee2-457d-82ec-fb94b090fc15_119.jpg'),
(111, 22, '68859cf7-a34e-4ca3-a3bd-9dff1f52bd1d_120.jpg'),
(112, 23, 'db57e982-627a-4dac-94b4-f657b620146f_121.jpg'),
(113, 23, '5ce1d2d1-9bf6-4546-b3de-adc6ab71ac4a_122.jpg'),
(114, 23, 'f590b7aa-e58e-4686-93da-6ff66f05bcdd_123.jpg'),
(115, 23, 'a5680c6a-7e9f-49ec-b041-299cd92c232c_124.jpg'),
(116, 23, '0d8b9abd-2354-4e5d-a016-f362b41ed5cd_125.jpg'),
(117, 24, '51cc354a-31fb-4756-858c-975d871f1379_126.jpg'),
(118, 24, '0b08e776-3b11-4ff7-ae8a-7ca1a2fb3439_127.jpg'),
(119, 24, '1175a426-29e9-4b4a-b778-10ecb7435e96_128.jpg'),
(120, 24, '5d80e48f-3bf7-4572-be92-ff22d2e2f69a_129.jpg'),
(121, 24, '2d5b654b-7c48-4bf4-a75f-c37478455b10_130.jpg'),
(122, 25, '6fe024fc-ddf4-4640-9b26-a65f5b775ed4_131.jpg'),
(123, 25, 'fb2d3ab6-e985-4a5d-bd11-035d74f92ceb_132.jpg'),
(124, 25, '7decea35-af41-45ed-8e1a-5da159e3cab2_133.jpg');

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
(2, 'nguyen van a', '1213456', 'Đồng Nai', '$2a$10$M8wgM2uS.bYn7GYCGCwGeeqt.j66M0xC33J8Vt4JaNnQIs2eX1CNe', '2024-05-11 13:12:30', '2024-05-11 13:12:30', 0, '2000-03-05', 0, 0, 1),
(3, 'nguyen van a', '0339705277', 'Đồng Nai', '$2a$10$Y50d3sz5PEbYIyQGHM7rL.OYAFyEiHLtTaTw3rjHrSGyN5sW8TaUO', '2024-05-30 03:36:37', '2024-05-30 03:36:37', 0, '2000-03-05', 0, 0, 1),
(4, 'nguyen van a', '0339705279', 'Đồng Nai', '$2a$10$ouvxcRXA3.zpKW7UHVKMr.FnJlyUe.8ycB91EiFG8MHDDXX4Ala32', '2024-05-30 06:35:06', '2024-05-30 06:35:06', 0, '2000-03-05', 0, 0, 1),
(5, 'Nguyen Ba Viet', '0339705298', 'DongNai', '$2a$10$QMVeHD1t6vDTHNMLbPdtLeWs8gzS8UKrbgl3hHI4FbIfBDhM3VpmW', '2024-05-30 09:08:04', '2024-05-30 09:08:04', 0, '2000-07-30', 0, 0, 1);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
