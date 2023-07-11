-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Июн 28 2023 г., 09:44
-- Версия сервера: 8.0.30
-- Версия PHP: 8.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `mydb`
--

-- --------------------------------------------------------

--
-- Структура таблицы `Клиенты`
--

CREATE TABLE `Клиенты` (
  `idКлиенты` int NOT NULL,
  `phone_number` varchar(45) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `Талоны_ticket_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `Клиенты`
--

INSERT INTO `Клиенты` (`idКлиенты`, `phone_number`, `email`, `Талоны_ticket_id`) VALUES
(4, '89996091029', 'vanya708090@mail.ru', 'А2123'),
(10, '84445674565', 'vanya706069@mail.ru', 'Б1001'),
(14, '84445674560', 'vanya706069@mail.ru', 'Б1002'),
(16, '79994652111', 'vanya10@yandex.ru', 'Б1002');

-- --------------------------------------------------------

--
-- Структура таблицы `Окна обслуживания`
--

CREATE TABLE `Окна обслуживания` (
  `window_id` varchar(1) NOT NULL,
  `employee_name` varchar(45) DEFAULT NULL,
  `department` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `Окна обслуживания`
--

INSERT INTO `Окна обслуживания` (`window_id`, `employee_name`, `department`) VALUES
('А', 'Егоров Иван Петрович', 'ДПО'),
('Б', 'Степанов Иван Егорьевич', 'ПО');

-- --------------------------------------------------------

--
-- Структура таблицы `Отзывы`
--

CREATE TABLE `Отзывы` (
  `review_id` int NOT NULL,
  `evaluation` tinyint DEFAULT NULL,
  `fk_client_id` int NOT NULL,
  `fk_window_id` varchar(1) NOT NULL,
  `fk_ticket_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `Отзывы`
--

INSERT INTO `Отзывы` (`review_id`, `evaluation`, `fk_client_id`, `fk_window_id`, `fk_ticket_id`) VALUES
(26, 4, 10, 'Б', 'Б1002'),
(27, 4, 10, 'Б', 'Б1002'),
(28, 5, 10, 'А', 'А2123'),
(29, 5, 10, 'А', 'А2123'),
(30, 5, 10, 'А', 'А2123'),
(31, 5, 10, 'А', 'А2123'),
(32, 3, 10, 'Б', 'Б1002'),
(33, 3, 10, 'Б', 'Б1002'),
(34, 3, 10, 'Б', 'Б1002'),
(35, 3, 10, 'Б', 'Б1002'),
(36, 5, 10, 'Б', 'Б1002'),
(37, 5, 10, 'Б', 'Б1002'),
(38, 4, 10, 'Б', 'Б1002'),
(39, 2, 10, 'Б', 'Б1002'),
(40, 2, 10, 'Б', 'Б1002'),
(41, 2, 10, 'Б', 'Б1002'),
(42, 2, 10, 'Б', 'Б1002'),
(43, 1, 10, 'Б', 'Б1002'),
(44, 3, 10, 'Б', 'Б1002'),
(45, 3, 10, 'Б', 'Б1002'),
(46, 3, 10, 'Б', 'Б1002'),
(47, 4, 10, 'Б', 'Б1002'),
(48, 5, 10, 'Б', 'Б1002'),
(49, 5, 10, 'Б', 'Б1002'),
(50, 5, 14, 'Б', 'Б1002'),
(51, 4, 10, 'Б', 'Б1002'),
(52, 4, 10, 'Б', 'Б1002'),
(53, 5, 10, 'Б', 'Б1002'),
(54, 3, 10, 'Б', 'Б1002'),
(55, 5, 10, 'А', 'А2123'),
(56, 4, 10, 'Б', 'Б1002'),
(57, 3, 16, 'Б', 'Б1002');

-- --------------------------------------------------------

--
-- Структура таблицы `Параметры`
--

CREATE TABLE `Параметры` (
  `parameter_id` int NOT NULL,
  `total_evaluations` varchar(100) DEFAULT NULL,
  `quality_score` varchar(100) DEFAULT NULL,
  `total_reviews` varchar(100) DEFAULT NULL,
  `average_rating` varchar(45) DEFAULT NULL,
  `total_points` varchar(100) DEFAULT NULL,
  `Окна_обслуживания_window_id` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `name_employer` varchar(50) NOT NULL,
  `department` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `Параметры`
--

INSERT INTO `Параметры` (`parameter_id`, `total_evaluations`, `quality_score`, `total_reviews`, `average_rating`, `total_points`, `Окна_обслуживания_window_id`, `name_employer`, `department`) VALUES
(36, '5', '25', '5', '5.0000', '25', 'А', 'Егоров Иван Петрович', 'ДПО'),
(37, '27', '94', '27', '3.4815', '94', 'Б', 'Степанов Иван Егорьевич', 'ПО');

-- --------------------------------------------------------

--
-- Структура таблицы `Талоны`
--

CREATE TABLE `Талоны` (
  `ticket_id` varchar(10) NOT NULL,
  `fk_window_id` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `Талоны`
--

INSERT INTO `Талоны` (`ticket_id`, `fk_window_id`) VALUES
('А2123', 'А'),
('Б1001', 'Б'),
('Б1002', 'Б');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Клиенты`
--
ALTER TABLE `Клиенты`
  ADD PRIMARY KEY (`idКлиенты`),
  ADD KEY `fk_Клиенты_Талоны1_idx` (`Талоны_ticket_id`);

--
-- Индексы таблицы `Окна обслуживания`
--
ALTER TABLE `Окна обслуживания`
  ADD PRIMARY KEY (`window_id`);

--
-- Индексы таблицы `Отзывы`
--
ALTER TABLE `Отзывы`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `fk_client_id` (`fk_client_id`),
  ADD KEY `fk_window_id` (`fk_window_id`),
  ADD KEY `fk_ticket_id` (`fk_ticket_id`);

--
-- Индексы таблицы `Параметры`
--
ALTER TABLE `Параметры`
  ADD PRIMARY KEY (`parameter_id`),
  ADD KEY `fk_Параметры_Окна обслуживания1_idx` (`Окна_обслуживания_window_id`);

--
-- Индексы таблицы `Талоны`
--
ALTER TABLE `Талоны`
  ADD PRIMARY KEY (`ticket_id`),
  ADD KEY `fk_window_id` (`fk_window_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Клиенты`
--
ALTER TABLE `Клиенты`
  MODIFY `idКлиенты` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `Отзывы`
--
ALTER TABLE `Отзывы`
  MODIFY `review_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT для таблицы `Параметры`
--
ALTER TABLE `Параметры`
  MODIFY `parameter_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `Клиенты`
--
ALTER TABLE `Клиенты`
  ADD CONSTRAINT `fk_Клиенты_Талоны1` FOREIGN KEY (`Талоны_ticket_id`) REFERENCES `Талоны` (`ticket_id`);

--
-- Ограничения внешнего ключа таблицы `Отзывы`
--
ALTER TABLE `Отзывы`
  ADD CONSTRAINT `отзывы_ibfk_1` FOREIGN KEY (`fk_client_id`) REFERENCES `Клиенты` (`idКлиенты`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `отзывы_ibfk_2` FOREIGN KEY (`fk_window_id`) REFERENCES `Окна обслуживания` (`window_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `отзывы_ibfk_3` FOREIGN KEY (`fk_ticket_id`) REFERENCES `Талоны` (`ticket_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `Параметры`
--
ALTER TABLE `Параметры`
  ADD CONSTRAINT `Окна обслуживания_fk` FOREIGN KEY (`Окна_обслуживания_window_id`) REFERENCES `Окна обслуживания` (`window_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `Талоны`
--
ALTER TABLE `Талоны`
  ADD CONSTRAINT `талоны_ibfk_2` FOREIGN KEY (`fk_window_id`) REFERENCES `Окна обслуживания` (`window_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
