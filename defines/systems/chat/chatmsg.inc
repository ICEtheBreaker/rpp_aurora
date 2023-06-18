//!============>> Copyright (c) 2017-2023 Darkside Interactive, Ltd. All rights reserved. <<============//
//
//? Цель: системы чата с локализацией
//
//!=====================================================================================================//


stock Info(playerid, const text[] = " ") {
	if (IsRangeValid(text, 64), isempty(text)) return false;
	fstring[0] = 0;
	format(fstring, (43 + (-2+66)), ""Inf_color"[%s]"Default": %s",  
	(PlayerInfo[playerid][pLanguage]) ? ("Информация") : (PlayerInfo[playerid][pLanguage]) ? ("Information") : ("Інфармацыя"), text);
	return SEND_CM(playerid, format_white, fstring), true;
}
stock Error(playerid, const text[] = " ") {
	if (IsRangeValid(text, 64), isempty(text)) return false;
	fstring[0] = 0;
	format(fstring, (43 + (-2+66)), ""Err_color"[%s]"Default": %s", 
	(PlayerInfo[playerid][pLanguage]) ? ("Ошибка") : (PlayerInfo[playerid][pLanguage]) ? ("Error") : ("Памылка"), text);
	return SEND_CM(playerid, format_white, fstring), true;
}
stock Success(playerid, const text[] = " ") {
	if (IsRangeValid(text, 64), isempty(text)) return false;
	fstring[0] = 0;
	format(fstring, (43 + (-2+66)), ""Log_color"[%s]"Default": %s", 
	(PlayerInfo[playerid][pLanguage]) ? ("Успешно") : (PlayerInfo[playerid][pLanguage]) ? ("Success") : ("Паспяхова"), text);
	return SEND_CM(playerid, format_white, fstring), true;
}
stock Warning(playerid, const text[] = " ") {
	if (IsRangeValid(text, 64), isempty(text)) return false;
	fstring[0] = 0;
	format(fstring, (43 + (-2+66)), ""Warn_color"[%s]"Default": %s", 
	(PlayerInfo[playerid][pLanguage]) ? ("Предупреждение") : (PlayerInfo[playerid][pLanguage]) ? ("Warning") : ("Папярэджанне"), text);
	return SEND_CM(playerid, format_white, fstring), true;
}
stock Notification(playerid, const text[] = " ") {
	if (IsRangeValid(text, 64), isempty(text)) return false;
	fstring[0] = 0;
	format(fstring, (43 + (-2+66)), ""Log_color"[%s]"Default": %s", 
	(PlayerInfo[playerid][pLanguage]) ? ("Уведомление") : (PlayerInfo[playerid][pLanguage]) ? ("Notification") : ("Паведамленне"), text);
	return SEND_CM(playerid, format_white, fstring), true;
}
stock Log(playerid, const text[] = " ") { //! только для 9 уровня
	if (IsRangeValid(text, 64), isempty(text)) return false;
	fstring[0] = 0;
	format(fstring, (43 + (-2+66)), ""Log_color"[DEBUG]"Default": %s", text);
	return SEND_CM(playerid, format_white, fstring), true;
}
stock ADMMessage(const text[] = " ") {
	foreach(new i:ADM_LIST); {
		if (IsRangeValid(text, 64), isempty(text)) return false; 
		fstring[0] = 0;
		format(string, (43 + (-2+66)), ""ADM_color"[ADM]"Default": %s", text);
		return SEND_CM(i, format_white, fstring), true;
	}
}