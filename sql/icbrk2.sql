-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Май 28 2023 г., 23:24
-- Версия сервера: 5.7.33-log
-- Версия PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `icbrk2`
--

-- --------------------------------------------------------

--
-- Структура таблицы `accounts`
--

CREATE TABLE `accounts` (
  `id` int(8) NOT NULL,
  `names` varchar(24) DEFAULT NULL,
  `password` varchar(65) NOT NULL,
  `salt` varchar(11) NOT NULL,
  `regIP` varchar(16) DEFAULT NULL,
  `regData` varchar(12) DEFAULT NULL,
  `lastIP` varchar(16) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `sex` int(2) NOT NULL,
  `admin` int(1) NOT NULL,
  `currentskin` int(3) NOT NULL,
  `money` int(11) NOT NULL,
  `level` int(4) NOT NULL,
  `wanted_level` int(2) UNSIGNED NOT NULL DEFAULT '0',
  `email_confirmed` int(1) NOT NULL DEFAULT '0',
  `licenses` text
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

--
-- Дамп данных таблицы `accounts`
--

INSERT INTO `accounts` (`id`, `names`, `password`, `salt`, `regIP`, `regData`, `lastIP`, `email`, `sex`, `admin`, `currentskin`, `money`, `level`, `wanted_level`, `email_confirmed`, `licenses`) VALUES
(49, 'kilo_joiii', '8A37C7F03A5A083CAAD0B11F063C4416C6E5241183035D0AB63BE899AE926956', '\\^|t|X[PM<', '127.0.0.1', '20.04.2023', '	', 'per.dan@gmail.com', 1, 8, 102, 250, 1, 0, 0, '0,0,0,0,0'),
(50, 'Jei_Kilo', '0A5BD12C6F3A590762A0C2DC8CD49533E5B793BEBD9562BA714414955D77D5FB', '/Rp:v2<fuP', '127.0.0.1', '15.05.2023', '	', 'per.dan@gmail.com', 1, 8, 102, 250, 1, 0, 0, '0,0,0,0,0');

-- --------------------------------------------------------

--
-- Структура таблицы `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `name` varchar(24) NOT NULL,
  `securitycode` int(4) NOT NULL,
  `level` int(1) NOT NULL,
  `last_connect` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT для таблицы `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
