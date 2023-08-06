-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Авг 04 2023 г., 13:22
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
  `licenses` text,
  `gugle_auth` int(2) DEFAULT NULL,
  `gugle_settings` varchar(50) DEFAULT NULL,
  `gugle_enabled` int(2) DEFAULT NULL,
  `idPassportInRegister` int(11) DEFAULT NULL,
  `fio` varchar(64) DEFAULT NULL,
  `language` int(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

--
-- Дамп данных таблицы `accounts`
--

INSERT INTO `accounts` (`id`, `names`, `password`, `salt`, `regIP`, `regData`, `lastIP`, `email`, `sex`, `admin`, `currentskin`, `money`, `level`, `wanted_level`, `email_confirmed`, `licenses`, `gugle_auth`, `gugle_settings`, `gugle_enabled`, `idPassportInRegister`, `fio`, `language`) VALUES
(49, 'kilo_joiii', '8A37C7F03A5A083CAAD0B11F063C4416C6E5241183035D0AB63BE899AE926956', '\\^|t|X[PM<', '127.0.0.1', '20.04.2023', '	', 'gord.s@gmail.com', 1, 0, 102, 250, 16, 0, 0, '0,0,0,0,0', 0, NULL, NULL, 49, NULL, 1),
(50, 'Jei_Kilo', '0A5BD12C6F3A590762A0C2DC8CD49533E5B793BEBD9562BA714414955D77D5FB', '/Rp:v2<fuP', '127.0.0.1', '15.05.2023', '	', 'gord.s@gmail.com', 1, 9, 102, 250, 16, 0, 0, '0,0,0,0,0', 0, NULL, NULL, 42, NULL, 1),
(51, 'None', 'B1FAE78490BCF7A5CEC75A5D898FEE35B67C35C27D316450165F1FF5227A201A', 'E=Zm6fR4jF', '127.0.0.1', '13.06.2023', '	', 'gord.s@gmail.com', 1, 0, 102, 250, 16, 0, 0, '0,0,0,0,0', NULL, NULL, NULL, NULL, NULL, 1),
(52, 'Jei_Kilos', 'F917F12EC0BB9FEE0A3AAB8C9CDF07A99AEE168842B47703252D98E39219FDC6', '{0VrgWDgm>', '127.0.0.1', '25.07.2023', '', 'gord.dan@gmail.com', 1, 0, 102, 250, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, '', 1),
(53, 'Rayan_Michell', '52E6E43C000B2F3E61AF50309BF3F5AD2F5F5C32270FD69D06241ACEE483070C', 'XD@rBwfT/`', '127.0.0.1', '02.08.2023', '', 'gord.dan998@gmail.com', 1, 0, 102, 250, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, '', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `name` varchar(24) NOT NULL,
  `securitycode` int(4) DEFAULT '123',
  `level` int(1) NOT NULL DEFAULT '1',
  `last_connect` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

--
-- Дамп данных таблицы `admin`
--

INSERT INTO `admin` (`id`, `name`, `securitycode`, `level`, `last_connect`) VALUES
(1, 'Jei_Kilo', 123, 9, '2023-06-13 22:31:27');

-- --------------------------------------------------------

--
-- Структура таблицы `documents`
--

CREATE TABLE `documents` (
  `id` tinyint(4) NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'PASSPORT,DRIVE',
  `player_name` varchar(24) COLLATE utf8mb4_unicode_ci DEFAULT 'Nick_Name'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `documents`
--

INSERT INTO `documents` (`id`, `type`, `player_name`) VALUES
(2, '2', 'Jei_Kilo'),
(1, '1', 'Jei_Kilo');

-- --------------------------------------------------------

--
-- Структура таблицы `passports`
--

CREATE TABLE `passports` (
  `idRegister` int(5) NOT NULL,
  `player_id` int(4) DEFAULT NULL,
  `p_nomer` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'YYYYYY',
  `p_serial` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'XX XX',
  `p_fio` varchar(64) CHARACTER SET cp1251 NOT NULL DEFAULT 'Surname Name Given',
  `p_propiska` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'viale None',
  `p_sex` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `p_ifchangedsex` int(4) NOT NULL DEFAULT '0',
  `p_issued` date DEFAULT NULL,
  `p_issuedbywhom` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'MVD',
  `p_dateofbirthday` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `passports`
--

INSERT INTO `passports` (`idRegister`, `player_id`, `p_nomer`, `p_serial`, `p_fio`, `p_propiska`, `p_sex`, `p_ifchangedsex`, `p_issued`, `p_issuedbywhom`, `p_dateofbirthday`) VALUES
(49, 49, '492812', '22 33', 'Авдеев Виктор Авдiйович', 'улица Марабушты 43а', 'Муж', 0, '2021-06-23', 'МВД г. Донецк ДНР', '2000-06-23'),
(42, 50, '492812', '22 33', 'Микропов Виктор Авдiйович', 'улица Марабушты 43а', 'Муж', 0, '2021-06-23', 'МВД г. Донецк ДНР', '2000-06-23');

-- --------------------------------------------------------

--
-- Структура таблицы `types_documents`
--

CREATE TABLE `types_documents` (
  `id` int(11) NOT NULL,
  `type_document` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `types_documents`
--

INSERT INTO `types_documents` (`id`, `type_document`, `description`) VALUES
(1, 'PASSPORT', 'паспорт'),
(2, 'DRIVING', 'водительское'),
(3, 'PERMISSION', 'разрешение');

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
-- Индексы таблицы `documents`
--
ALTER TABLE `documents`
  ADD KEY `id` (`id`);

--
-- Индексы таблицы `passports`
--
ALTER TABLE `passports`
  ADD KEY `Столбец 1` (`idRegister`) USING BTREE;

--
-- Индексы таблицы `types_documents`
--
ALTER TABLE `types_documents`
  ADD KEY `id` (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT для таблицы `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `documents`
--
ALTER TABLE `documents`
  MODIFY `id` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `passports`
--
ALTER TABLE `passports`
  MODIFY `idRegister` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT для таблицы `types_documents`
--
ALTER TABLE `types_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
