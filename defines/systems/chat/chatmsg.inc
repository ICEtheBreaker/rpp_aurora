//!============>> Copyright (c) 2017-2023 Darkside Interactive, Ltd. All rights reserved. <<============//
//
//? Цель: системы чата с локализацией
//
//!=====================================================================================================//

enum {
	T_NONE = 0,
	T_WARN = 1,
	T_ERROR = 2,
	T_NOTIF = 3,
	T_SUCCESS = 4,
	T_DEBUG = 5,
}

#define LANG_RU			1
#define LANG_USA 		2
#define LANG_BELARUS	3

// new languagesTypes[5][][] = {
// 	{"Ошибка", "Error", "Памылка"},
// 	{"Предупреждение", "Warning", "Папярэджанне"},
// 	{"Информация", "Information", "Інфармацыя"},
// 	{"Успешно", "Success", "Паспяхова"},
// 	{"Уведомление", "Notification", "Паведамленне"}
// };

stock getLanguage(playerid) {
	// print("inizio della GetLanguage");
	new language = pi[playerid][pLanguage];
	if (!(LANG_RU <= language <= LANG_BELARUS)) return 0;

	printf("%s ebat getLanguage", ((language == 1) ? ("Русский") : (language == 2) ? ("USA") : (language == 3) ? ("Беларусский") : ("test getLanguage")));

	// print("per`o finisce gi`a");

	return ((language == 1) ? 1 : ((language == 2) ? 2 : (language == 3) ? 3 : 0));
}
stock setLanguage(player, &lang) {
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

	UpdateINTData(player, "language", lang); //! тоже к фиксу пытается сохранить не сохраняет

	return lang;
}

stock setLocalization(player, type) {
	new 
		language = getLanguage(player);

	new languagesTypes[][][] = {
		{"Ошибка", "Error", "Памылка"},
		{"Предупреждение", "Warning", "Папярэджанне"},
		{"Информация", "Information", "Інфармацыя"},
		{"Успешно", "Success", "Паспяхова"},
		{"Уведомление", "Notification", "Паведамленне"}
	};

	// printf("%s - 1 element; %s - 2 element; %s - 3 element; ", languagesTypes[0][0], languagesTypes[0][1], languagesTypes[0][2]);

	// printf("(%s) test 1 element; 2 element = (%s); 3 elem = (%s)",
	// languagesTypes[0][0], languagesTypes[0][1], languagesTypes[0][2]	);

	// printf("znacit potom blyat: %s = 1; %s = 2; %s = 3;",
	// languagesTypes[1][0], languagesTypes[1][1], languagesTypes[1][2]);

	// printf("%s ;; %s ;; %s", languagesTypes[3][0], languagesTypes[3][1], languagesTypes[3][2]);

	static 
		text[sizeof(languagesTypes)];

	// for (new i=sizeof(languagesTypes); --i >= 0;) {
	// 	if (language) strcat(languagesTypes[i][0], text);
	// 	else if (language == 2) strcat(languagesTypes[i][1], text);
	// 	else strcat(languagesTypes[i][2], text);

	// 	printf("%d", i);		
	// }

	// printf("%s", text);

	switch(type) {
		case T_WARN: {
			// if (language) text = languagesTypes[1][0];
			// else if (language == 2) text = languagesTypes[1][1];
			// else text = languagesTypes[1][2];
			if (language) strcat(languagesTypes[1][0], text, sizeof(languagesTypes)); //! Rus
			else if (language == 2) strcat(languagesTypes[1][1], text, sizeof(languagesTypes)); //! English
			else strcat(languagesTypes[1][2], text, sizeof(languagesTypes)); //! Belarus
		}
		case T_ERROR: {
			if (language) strcat(languagesTypes[0][0], text, sizeof(languagesTypes)); //! Rus
			else if (language == 2) strcat(languagesTypes[0][1], text, sizeof(languagesTypes)); //! English
			else strcat(languagesTypes[0][2], text, sizeof(languagesTypes)); //! Belarus
		}
		case T_NOTIF: {
			if (language) strcat(languagesTypes[4][0], text, sizeof(languagesTypes)); //! Rus
			else if (language == 2) strcat(languagesTypes[4][1], text, sizeof(languagesTypes)); //! English
			else strcat(languagesTypes[4][2], text, sizeof(languagesTypes)); //! Belarus
		}
		case T_SUCCESS: {
			if (language) strcat(languagesTypes[3][0], text, sizeof(languagesTypes)); //! Rus
			else if (language == 2) strcat(languagesTypes[3][1], text, sizeof(languagesTypes)); //! English
			else strcat(languagesTypes[3][2], text, sizeof(languagesTypes)); //! Belarus
		}
		default: text = "None", (printf("test %s", getLanguage(player)));
	}

	// return text;
	return text;
}

stock SendMess(playerid, t_message=T_WARN, const text[]) {
	if (!IsRangeValid(text, 64) && isempty(text)) return 0;

	switch(t_message) {
		case T_WARN: {
			fstring[0] = 0;
			format(fstring, (30 + (-2+17) + (-2+66)), ""Warn_color"[%s]"Default": %s", 
			setLocalization(playerid, getLanguage(playerid)), text);
			SEND_CM(playerid, format_white, fstring);
		}
		case T_ERROR: {
			fstring[0] = 0;
			format(fstring, (29 + (-2+10) + (-2+66)), ""Err_color"[%s]"Default": %s", 
			setLocalization(playerid, getLanguage(playerid)), text);
			SEND_CM(playerid, format_white, fstring);
		}
		case T_NOTIF: {
			fstring[0] = 0;
			format(fstring, (29 + (-2+14) + (-2+66)), ""Log_color"[%s]"Default": %s", 
			setLocalization(playerid, getLanguage(playerid)), text);
			SEND_CM(playerid, format_white, fstring);
		}
		case T_SUCCESS: {
			fstring[0] = 0;
			format(fstring, (30 + (-2+12) + (-2+66)), ""Done_color"[%s]"Default": %s", 
			setLocalization(playerid, getLanguage(playerid)), text);
			SEND_CM(playerid, format_white, fstring);
			
		}
		case T_DEBUG: {}
	}
	
	return 1;
}

// #define Warn 			SendWarning 
// #define Err 			SendError
// #define Inform 			SendInfo
// #define Success 		SendSuccess
// #define Notification	SendNotification
// #define Console			SendLog

// /*
//  * Отправить информационное сообщение в чат игроку.
//  *
//  * Параметры:
//  *   text[] = " " - текст, который будет показан игроку.
//  *
//  * Возвраты кода:
//  *   Истина если пусто, иначе ложь.
//  */
// stock SendInfo(playerid, const text[] = "") {
// 	if (IsRangeValid(text, 64) && isempty(text)) return false;
// 	fstring[0] = 0;
// 	format(fstring, (29 + (-2+13) + (-2+66)), ""Inf_color"[%s]"Default": %s",
// 	((pi[playerid][pLanguage]) ? ("Информация") : (pi[playerid][pLanguage]) ? ("Information") : ("Інфармацыя")), text);
// 	return SEND_CM(playerid, format_white, fstring);
// }

// /*
//  * Отправить ошибку в чат игроку.
//  *
//  * Параметры:
//  *   text[] = " " - текст, который будет показан игроку.
//  *
//  * Возвраты кода:
//  *   Истина если пусто, иначе ложь.
//  */
// stock SendError(playerid, const text[] = "") {
// 	if (IsRangeValid(text, 64) && isempty(text)) return false;
// 	fstring[0] = 0;
// 	format(fstring, (29 + (-2+10) + (-2+66)), ""Err_color"[%s]"Default": %s", 
// 	((pi[playerid][pLanguage]) ? ("Ошибка") : (pi[playerid][pLanguage]) ? ("Error") : ("Памылка")), text);
// 	return SEND_CM(playerid, format_white, fstring);
// }

// /*
//  * Отправить сообщение об успехе в чат игроку.
//  *
//  * Параметры:
//  *   text[] = " " - текст, который будет показан игроку.
//  *
//  * Возвраты кода:
//  *   Истина если пусто, иначе ложь.
//  */
// stock SendSuccess(playerid, const text[] = "") {
// 	if (IsRangeValid(text, 64) && isempty(text)) return false;
// 	fstring[0] = 0;
// 	format(fstring, (30 + (-2+12) + (-2+66)), ""Done_color"[%s]"Default": %s", 
// 	((pi[playerid][pLanguage]) ? ("Успешно") : (pi[playerid][pLanguage]) ? ("Success") : ("Паспяхова")), text);
// 	return SEND_CM(playerid, format_white, fstring);
// }

// /*
//  * Отправить предупреждение в чат игроку.
//  *
//  * Параметры:
//  *   text[] = " " - текст, который будет показан игроку.
//  *
//  * Возвраты кода:
//  *   Истина если пусто, иначе ложь.
//  */
// stock SendWarning(playerid, const text[] = "") {
// 	if (IsRangeValid(text, 64) && isempty(text)) return false;
// 	fstring[0] = 0;
// 	format(fstring, (30 + (-2+17) + (-2+66)), ""Warn_color"[%s]"Default": %s", 
// 	((pi[playerid][pLanguage]) ? ("Предупреждение") : (pi[playerid][pLanguage]) ? ("Warning") : ("Папярэджанне")), text);
// 	return SEND_CM(playerid, format_white, fstring);
// }

// /*
//  * Отправить уведомление в чат игроку.
//  *
//  * Параметры:
//  *   text[] = " " - текст, который будет показан игроку.
//  *
//  * Возвраты кода:
//  *   Истина если пусто, иначе ложь.
//  */
// stock SendNotification(playerid, const text[] = "") {
// 	if (IsRangeValid(text, 64) && isempty(text)) return false;
// 	fstring[0] = 0;
// 	format(fstring, (29 + (-2+14) + (-2+66)), ""Log_color"[%s]"Default": %s", 
// 	((pi[playerid][pLanguage]) ? ("Уведомление") : (pi[playerid][pLanguage]) ? ("Notification") : ("Паведамленне")), text);
// 	return SEND_CM(playerid, format_white, fstring);
// }

/*
 * Отправить лог в дебаг разработчику.
 *
 * Параметры:
 *   text[] = " " - текст, который будет показан разработчику.
 *
 * Возвраты кода:
 *   Истина если пусто, иначе ложь.
 */
stock SendLog(playerid, const text[] = "") { //! только для 9 уровня
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