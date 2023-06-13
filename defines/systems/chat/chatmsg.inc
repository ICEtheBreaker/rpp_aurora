//!============>> Copyright (c) 2017-2023 Darkside Interactive, Ltd. All rights reserved. <<============//
//
//? Цель: системы чата
//
//!=====================================================================================================//


stock SendInfoMessage(player, const text[] = " ") {
	if (IsRangeValid(text, 64), isempty(text)) return false;
	fstring[0] = 0;
	format(fstring, (43 + (-2+66)), ""Inf_color"[Информация]"Default": %s", text);
	return SEND_CM(player, format_white, fstring), true;
}
stock SendErrorMessage(player, const text[] = " ") {
	if (IsRangeValid(text, 64), isempty(text)) return false;
	fstring[0] = 0;
	format(fstring, (43 + (-2+66)), ""Err_color"[Ошибка]"Default": %s", text);
	return SEND_CM(player, format_white, fstring), true;
}
stock SendDoneMessage(player, const text[] = " ") {
	if (IsRangeValid(text, 64), isempty(text)) return false;
	fstring[0] = 0;
	format(fstring, (43 + (-2+66)), ""Log_color"[Успех]"Default": %s", text);
	return SEND_CM(player, format_white, fstring), true;
}
stock SendWarningMessage(player, const text[] = " ") {
	if (IsRangeValid(text, 64), isempty(text)) return false;
	fstring[0] = 0;
	format(fstring, (43 + (-2+66)), ""Warn_color"[Ворнинг]"Default": %s", text);
	return SEND_CM(player, format_white, fstring), true;
}
