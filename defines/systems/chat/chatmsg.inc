//!============>> Copyright (c) 2017-2023 Darkside Interactive, Ltd. All rights reserved. <<============//
//
//? Цель: системы чата с локализацией
//
//!=====================================================================================================//

//! warning не может быть применен он зарегистрирован => warning -> warn
//! none -> non
//! error -> err
//! info -> inf
//! не знаю что за фигня но название стока Log выдавало ерроры, а добавил еще букву в конец - норм. значит тоже зарегана где-то

enum {
	NON = 0,
	WARN = 1,
	ERR = 2,
	NOTIFICATION = 3,
	SUCCESS = 4,
	INF = 5
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

	printf("%d", language);

	if (!(LANG_RU <= language <= LANG_BELARUS)) return 0;

	print("прошёл проверку на длину language");

	printf("%s ebat GetLanguage", ((language == 1) ? ("Русский") : (language == 2) ? ("Английский") : (language == 3) ? ("Белорусский") : ("test GetLanguage")));
	return ((language == 1) ? 1 : ((language == 2) ? 2 : (language == 3) ? 3 : 0));
}
/*
 * Установить язык для игрока.
 *
 * Параметры:
 *	 playerid = player id
 *   language = язык для установки.
 *
 * LANG_RU
 * LANG_USA 
 * LANG_BELARUS 
 *
 * Возвраты кода:
 * Вернёт язык, установленный игроку
 */
stock SetLanguage(playerid, &language) {
	new lang = pi[playerid][pLanguage];

	switch (lang) {
		case LANG_RU: {
			language = LANG_USA;
		}
		case LANG_USA: {
			language = LANG_BELARUS;
		}
		case LANG_BELARUS: {
			language = LANG_RU;
		}
		default: return 0;
	}

	UpdateINTData(playerid, "language", language); //! тоже к фиксу пытается сохранить не сохраняет

	return language;
}
/*
 * Установить локализацию для игрока.
 *
 * Параметры:
 *   playerid = id игрока
 *   type = язык для установки.
 *
 * Русский = 1 | LANG_RU
 * Английский = 2 LANG_USA
 * Белорусский = 3 | LANG_BELARUS \
 *										macroses
 *
 * Возвраты кода:
 * Вернёт текст, который будет отправлен в чат.
 */
// stock SetLocalization(playerid, type) {
// 	new 
// 		language = GetLanguage(playerid);

// 	new languagesTypes[][][] = {
// 		{"Ошибка", "Error", "Памылка"},
// 		{"Предупреждение", "Warning", "Папярэджанне"},
// 		{"Информация", "Information", "Інфармацыя"},
// 		{"Успешно", "Success", "Паспяхова"},
// 		{"Уведомление", "Notification", "Паведамленне"}
// 	};
// 	static 
// 		text[sizeof(languagesTypes)];

// 	switch(type) {
// 		case WARN: {
// 			if (language) strcat(languagesTypes[1][0], text, sizeof(languagesTypes)); //! Rus
// 			else if (language == 2) strcat(languagesTypes[1][1], text, sizeof(languagesTypes)); //! English
// 			else strcat(languagesTypes[1][2], text, sizeof(languagesTypes)); //! Belarus
// 		}
// 		case ERR: {
// 			if (language) strcat(languagesTypes[0][0], text, sizeof(languagesTypes)); //! Rus
// 			else if (language == 2) strcat(languagesTypes[0][1], text, sizeof(languagesTypes)); //! English
// 			else strcat(languagesTypes[0][2], text, sizeof(languagesTypes)); //! Belarus
// 		}
// 		case NOTIFICATION: {
// 			if (language) strcat(languagesTypes[4][0], text, sizeof(languagesTypes)); //! Rus
// 			else if (language == 2) strcat(languagesTypes[4][1], text, sizeof(languagesTypes)); //! English
// 			else strcat(languagesTypes[4][2], text, sizeof(languagesTypes)); //! Belarus
// 		}
// 		case SUCCESS: {
// 			if (language) strcat(languagesTypes[3][0], text, sizeof(languagesTypes)); //! Rus
// 			else if (language == 2) strcat(languagesTypes[3][1], text, sizeof(languagesTypes)); //! English
// 			else strcat(languagesTypes[3][2], text, sizeof(languagesTypes)); //! Belarus
// 		}
// 		case INF: {
// 			if (language) strcat(languagesTypes[3][0], text, sizeof(languagesTypes)); //! Rus
// 			else if (language == 2) strcat(languagesTypes[3][1], text, sizeof(languagesTypes)); //! English
// 			else strcat(languagesTypes[3][2], text, sizeof(languagesTypes)); //! Belarus			
// 		}
// 		default: text = "None", (printf("test %s", GetLanguage(playerid)));
// 	}
// 	return text;
// }
/*
 * Отправить текст в чат игроку.
 *
 * Параметры:
 *   text[] = текст, который будет показан игроку.
 *  message = тип сообщения.
 *
 * Типы message:
 * ERR = отправит ошибку в чат игроку
 * WARN = отправит предупреждение в чат игроку
 * INF = отправит информацию в чат игроку
 * NOTIFICATION = отправит уведомление в чат игроку
 * SUCCESS = отправит сообщение об успехе в чат игроку
 *
 * Возвраты кода:
 *   Истина если пусто, иначе ложь.
 */
stock Msg(playerid, message=NON, const text[]) {
	if (!IsRangeValid(text, 64) && isempty(text)) return false;

	fstring[0] = 0;
	// new localization[] = SetLocalization(playerid, GetLanguage(playerid));

	printf("%s - text с локалей\ntext = %s", SetLocalization(playerid, GetLanguage(playerid)), text);

	switch(message) {
		case WARN: {
			format(fstring, (30 + (-2+17) + (-2+66)), ""Warn_color"[%s]"Default": %s", SetLocalization(playerid, WARN), text);
			SEND_CM(playerid, format_white, fstring);

			printf("%s -- warn", fstring);
		}
		case ERR: {
			format(fstring, (29 + (-2+10) + (-2+66)), ""Err_color"[%s]"Default": %s", SetLocalization(playerid, ERR), text);
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
			SEND_CM(playerid, format_white, fstring);
			
			printf("%s -- err", fstring);
		}
		case NOTIFICATION: {
			format(fstring, (29 + (-2+14) + (-2+66)), ""Log_color"[%s]"Default": %s", SetLocalization(playerid, NOTIFICATION), text);
			PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			SEND_CM(playerid, format_white, fstring);
			
			printf("%s -- notif", fstring);
		}
		case SUCCESS: {
			format(fstring, (30 + (-2+12) + (-2+66)), ""Done_color"[%s]"Default": %s", SetLocalization(playerid, SUCCESS), text);
			SEND_CM(playerid, format_white, fstring);
			
			printf("%s -- succ", fstring);
		}
		case INF: {
			format(fstring, (30 + (-2+12) + (-2+66)), ""Inf_color"[%s]"Default": %s", SetLocalization(playerid, INF), text);
			SEND_CM(playerid, format_white, fstring);
			
			printf("%s -- info", fstring);
			
		}
	}
	
	return fstring[0] = EOS, 1;
}

cmd:test1234(playerid) {

	printf("%s", SetLocalization(playerid, GetLanguage(playerid));
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
stock Logg(playerid, const text[] = "") { //! только для 9 уровня
	if (IsRangeValid(text, 64) && isempty(text)) return false;
	fstring[0] = 0;
	format(fstring, (32 + (-2+66)), ""Log_color"[DEBUG]"Default": %s", text);
	return SendClientMessage(playerid, format_white, fstring);
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