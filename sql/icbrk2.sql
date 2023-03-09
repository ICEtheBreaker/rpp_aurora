-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Фев 15 2023 г., 20:04
-- Версия сервера: 5.6.51
-- Версия PHP: 7.4.30

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
  `id` int(11) NOT NULL,
  `names` varchar(24) NOT NULL,
  `password` varchar(64) NOT NULL,
  `salt` varchar(11) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `lastIP` varchar(16) NOT NULL,
  `email` varchar(64) NOT NULL,
  `sex` int(2) NOT NULL,
  `admin` int(1) NOT NULL,
  `currentskin` int(3) NOT NULL,
  `money` int(11) NOT NULL,
  `level` int(4) NOT NULL,
  `exp` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

--
-- Дамп данных таблицы `accounts`
--

INSERT INTO `accounts` (`id`, `names`, `password`, `salt`, `ip`, `lastIP`, `email`, `sex`, `admin`, `currentskin`, `money`, `level`, `exp`) VALUES
(27, 'zxczxzx', 'BDDE7FD55E32908952BD7E8B02A9B8A50A8C887475A6F0A392F311803C323A61', 'gNn_WK7QcD', '\r6.127.37.174', '\r6.127.37.174', 'c', 0, 0, 0, 0, 0, 0);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT для таблицы `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
