//!============>> Copyright (c) 2017-2023 Darkside Interactive, Ltd. All rights reserved. <<============//
//
//? Цель: системы чата с локализацией
//
//!=====================================================================================================//

enum {
	NONE = 0,
	WARNING = 1,
	ERROR = 2,
	NOTIFICATION = 3,
	SUCCESS = 4,
	INFO = 5
}

#define LANG_RU			1
#define LANG_USA 		2
#define LANG_BELARUS	3

/*
 * Получает установленный язык игрока.
 *
 * Возвраты кода:
 * Вернёт установленный язык игрока.
 */
stock GetLanguage(playerid) {
	new language = pi[playerid][pLanguage];
	if (!(LANG_RU <= language <= LANG_BELARUS)) return 0;

	printf("%s ebat GetLanguage", ((language == 1) ? ("Русский") : (language == 2) ? ("Английский") : (language == 3) ? ("Белорусский") : ("test GetLanguage")));
	return ((language == 1) ? 1 : ((language == 2) ? 2 : (language == 3) ? 3 : 0));
}
/*
 * Установить язык для игрока.
 *
 * Параметры:
 *   lang = язык для установки.
 *
 * LANG_RU
 * LANG_USA 
 * LANG_BELARUS 
 *
 * Возвраты кода:
 * Вернёт язык, установленный игроку
 */
stock SetLanguage(playerid, &lang) {
	switch (lang) {
		case LANG_RU: {
			lang = LANG_USA;
		}
		case LANG_USA: {
			lang = LANG_BELARUS;
		}
		case LANG_BELARUS: {
			lang = LANG_RU;
		}
		default: return 0;
	}

	UpdateINTData(playerid, "language", lang); //! тоже к фиксу пытается сохранить не сохраняет

	return lang;
}
/*
 * Установить локализацию для игрока.
 *
 * Параметры:
 *   type = язык для установки.
 *
 * Русский = 1
 * Английский = 2
 * Белорусский = 3
 *
 * Возвраты кода:
 * Вернёт текст, который будет отправлен в чат.
 */
stock SetLocalization(playerid, type) {
	new 
		language = GetLanguage(playerid);

	new languagesTypes[][][] = {
		{"Ошибка", "Error", "Памылка"},
		{"Предупреждение", "Warning", "Папярэджанне"},
		{"Информация", "Information", "Інфармацыя"},
		{"Успешно", "Success", "Паспяхова"},
		{"Уведомление", "Notification", "Паведамленне"}
	};
	static 
		text[sizeof(languagesTypes)];

	switch(type) {
		case WARNING: {
			if (language) strcat(languagesTypes[1][0], text, sizeof(languagesTypes)); //! Rus
			else if (language == 2) strcat(languagesTypes[1][1], text, sizeof(languagesTypes)); //! English
			else strcat(languagesTypes[1][2], text, sizeof(languagesTypes)); //! Belarus
		}
		case ERROR: {
			if (language) strcat(languagesTypes[0][0], text, sizeof(languagesTypes)); //! Rus
			else if (language == 2) strcat(languagesTypes[0][1], text, sizeof(languagesTypes)); //! English
			else strcat(languagesTypes[0][2], text, sizeof(languagesTypes)); //! Belarus
		}
		case NOTIFICATION: {
			if (language) strcat(languagesTypes[4][0], text, sizeof(languagesTypes)); //! Rus
			else if (language == 2) strcat(languagesTypes[4][1], text, sizeof(languagesTypes)); //! English
			else strcat(languagesTypes[4][2], text, sizeof(languagesTypes)); //! Belarus
		}
		case SUCCESS: {
			if (language) strcat(languagesTypes[3][0], text, sizeof(languagesTypes)); //! Rus
			else if (language == 2) strcat(languagesTypes[3][1], text, sizeof(languagesTypes)); //! English
			else strcat(languagesTypes[3][2], text, sizeof(languagesTypes)); //! Belarus
		}
		case INFO: {
			if (language) strcat(languagesTypes[3][0], text, sizeof(languagesTypes)); //! Rus
			else if (language == 2) strcat(languagesTypes[3][1], text, sizeof(languagesTypes)); //! English
			else strcat(languagesTypes[3][2], text, sizeof(languagesTypes)); //! Belarus			
		}
		default: text = "None", (printf("test %s", GetLanguage(playerid)));
	}
	return text;
}
/*
 * Отправить текст в чат игроку.
 *
 * Параметры:
 *   text[] = текст, который будет показан игроку.
 *  message = тип сообщения.
 *
 * Типы message:
 * ERROR = отправит ошибку в чат игроку
 * WARNING = отправит предупреждение в чат игроку
 * INFO = отправит информацию в чат игроку
 * NOTIFICATION = отправит уведомление в чат игроку
 * SUCCESS = отправит сообщение об успехе в чат игроку
 *
 * Возвраты кода:
 *   Истина если пусто, иначе ложь.
 */
stock Msg(playerid, message, const text[]) {
	if (!IsRangeValid(text, 64) && isempty(text)) return 0;

	switch(message) {
		case WARNING: {
			fstring[0] = 0;
			format(fstring, (30 + (-2+17) + (-2+66)), ""Warn_color"[%s]"Default": %s", 
			SetLocalization(playerid, GetLanguage(playerid)), text);
			SEND_CM(playerid, format_white, fstring);
		}
		case ERROR: {
			fstring[0] = 0;
			format(fstring, (29 + (-2+10) + (-2+66)), ""Err_color"[%s]"Default": %s", 
			SetLocalization(playerid, GetLanguage(playerid)), text);
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
			SEND_CM(playerid, format_white, fstring);
		}
		case NOTIFICATION: {
			fstring[0] = 0;
			format(fstring, (29 + (-2+14) + (-2+66)), ""Log_color"[%s]"Default": %s", 
			SetLocalization(playerid, GetLanguage(playerid)), text);
			PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			SEND_CM(playerid, format_white, fstring);
		}
		case SUCCESS: {
			fstring[0] = 0;
			format(fstring, (30 + (-2+12) + (-2+66)), ""Done_color"[%s]"Default": %s", 
			SetLocalization(playerid, GetLanguage(playerid)), text);
			SEND_CM(playerid, format_white, fstring);
		}
		case INFO: {
			fstring[0] = 0;
			format(fstring, (30 + (-2+12) + (-2+66)), ""Done_color"[%s]"Default": %s", 
			SetLocalization(playerid, GetLanguage(playerid)), text);
			SEND_CM(playerid, format_white, fstring);
		}
	}
	
	return 1;
}
/*
 * Отправить лог в дебаг разработчику.
 *
 * Параметры:
 *   text[] = " " - текст, который будет показан разработчику.
 *
 * Возвраты кода:
 *   Истина если пусто, иначе ложь.
 */
stock Log(playerid, const text[] = "") { //! только для 9 уровня
	if (IsRangeValid(text, 64) && isempty(text)) return false;
	fstring[0] = 0;
	format(fstring, (32 + (-2+66)), ""Log_color"[DEBUG]"Default": %s", text);
	return SEND_CM(playerid, format_white, fstring);
}

/*
 * Отправить сообщение в систему ADM | ICBRK.
 *
 * Параметры:
 *   text[] = " " - текст, который будет показан админам.
 *
 * Возвраты кода:
 *   Истина если пусто, иначе ложь.
 */
stock ADMMessage(const text[] = "") {
	foreach(new i:ADM_LIST) {
		if (IsRangeValid(text, 64) && isempty(text)) return false; 
		fstring[0] = 0;
		format(string, (30 + (-2+66)), ""ADM_color"[ADM]"Default": %s", text);
		return SEND_CM(i, format_white, fstring);
	}
}