//!============>> Copyright (c) 2017-2023 Darkside Interactive, Ltd. All rights reserved. <<============//
//
//? Цель: свой функционал для удобной работы с MySQL функциями
//
//!=====================================================================================================//

stock UpdateINTData(playerid, const field[], data) {
	query_string[0] = 0;
	mysql_format(db, query_string, (60 + (-2+32) + (-2+6) + (-2+6)), "UPDATE `accounts` SET `%s` = '%d' WHERE `id` = '%d' LIMIT 1", field, data, pi[playerid][pID]);
	mysql_tquery(db, query_string);
    query_string[0] = EOS;
	return mysql_errno();
}