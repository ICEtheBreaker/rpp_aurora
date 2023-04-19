--========= Copyright (c) 2017-2023 Darkside Interactive, Ltd. All rights reserved. ============--
--
-- ����: ���� ������ SQL ��� ������� � phpMyAdmin
--
--=============================================================================--


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
  `names` varchar(24) NOT NULL,
  `password` varchar(64) NOT NULL,
  `regIP` varchar(16) NOT NULL,
  `regData` varchar(12) NOT NULL,
  `lastIP` varchar(16) NOT NULL,
  `email` varchar(64) NOT NULL,
  `sex` int(2) NOT NULL,
  `admin` int(1) NOT NULL,
  `currentskin` int(3) NOT NULL,
  `money` int(11) NOT NULL,
  `level` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

--
-- Дамп данных таблицы `accounts`
--

INSERT INTO `accounts` (`id`, `names`, `password`, `regIP`, `regData`, `lastIP`, `email`, `sex`, `admin`, `currentskin`, `money`, `level`) VALUES
(37, 'jopaxui', 'jopaxui', '26.87.224.43', '09.03.2023', '26.87.224.43', 'dimamironov1337228@gmail.com', 2, 0, 102, 250, 1);

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
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT для таблицы `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
