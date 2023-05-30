//!============>> Copyright (c) 2017-2023 Darkside Interactive, Ltd. All rights reserved. <<============//
//
//? Цель: соединение с SQL-хостинга
//
//!=====================================================================================================//

#define LOCAL_SQL_HOSTNAME       ""     //! вписать адрес базы на хостинге
#define LOCAL_SQL_USERNAME       ""     //! вписать имя юзера на хостинге
#define LOCAL_SQL_DATABASE       ""     //! вписать имя базы на хостинге
#define LOCAL_SQL_PASSWORD       ""     //! вписать пароль базы на хостинге


// enter point of the db and used the synt db->mysql_close(...) for example;
new MySQL:db;