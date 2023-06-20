//!============>> Copyright (c) 2017-2023 Darkside Interactive, Ltd. All rights reserved. <<============//
//
//? Цель: системы и проверки
//
//!=====================================================================================================//

#include "../../defines/macroses.inc"

stock ex_ShowPlayerDialog(playerid, dialogid, style, caption[], info[], button1[], button2[]) {
    return ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);
}
#if defined _ALS_ShowPlayerDialogEx
    #undef ShowPlayerDialogEx
#else
    #define _ALS_ShowPlayerDialogEx
#endif
#define ShowPlayerDialogEx ex_ShowPlayerDialog

stock ValidChar(mailchar)
{
	if((mailchar >= 'A' && mailchar <= 'Z') || (mailchar >= 'a' && mailchar <= 'z')
	|| (mailchar >= '0' && mailchar <= '9') || (mailchar == '-') || (mailchar == '_')
	|| (mailchar == '@') || (mailchar == '.')) return 1;
	return 0;
}

stock TextFind(const text[],const findtext[]) return strfind(text, findtext) != -1;
stock IsValidEmail(const email[])
{
	new bool:Success = true;
	new bool:Good;
	for(new i; i < strlen(email); i++)
	{
	    if(email[i] == '@') {
		    if(!Good) Good = true;
		    else{
				Good = false;
		    	break;
			}
		}
	    if(!ValidChar(email[i])) Success = false;
	}
	if(!Good) Success = false;
	if(!TextFind(email,".ru") && !TextFind(email,".com") && !TextFind(email,".ua") && !TextFind(email,".su")) Success = false;
	if(!TextFind(email,"@")) Success = false;
  	return Success;
}
/*
 * Функция дебагера. 
 * Позволяет проводить дебаг конкретной функции. 
 *
 * Параметры:
 *   func[] - имя функции, которой необходим дебаг
 *   
 *
 * Возвраты кода:
 *   без возвратов
 */
stock debugger(const func[], iter_count_start = 1, iter_count_end = 1000, step = 1, {_,Float,bool}:...) {
	// func(...) ... - параметры

	new	
		_counter = GetTickCount(),
		i = iter_count_start, // по умолч. = 1, указать своё любое другое значение
		idx_start = 4, // начать поиск параметров после парам step
		params = numargs();

	for (;i<iter_count_end;i+=step) {
		for (new idx = idx_start;++idx<params;) {
			CallLocalFunction(func, "sfdc", getarg(idx, 0));
		}
	}

	return 
		(GetTickCount() - _counter);
}
//? afk system
stock AFKSystemUpdates(playerid) {
	foreach(new i:Player) {
		PlayerAFK[i]++;
		if(++PlayerAFK[i] > 3) {
			new string[] = "{FFFFFF}AFK: ";
			if(PlayerAFK[i] < 60) format(string, sizeof(string),"%s%d сек.", string, PlayerAFK[i]);

		}else{
			new minute = floatround(PlayerAFK[i]/60, floatround_floor);
			new second = PlayerAFK[i] % 60;
			string[0] = EOS;
			format(string, sizeof(string),"%s%d мин. %d сек.", string, minute, second);
		}
		SetPlayerChatBubble(i, string, -1, 20, 1000)
	}
	return 1;
}

stock ProxDetector(Float:range, playerid, const string[], c1 = -1,c2 = -1,c3 = -1,c4 = -1,c5 = -1) {
    new
        Float: x,
        Float: y,
        Float: z,
        i = GetMaxPlayers(),
        world = GetPlayerVirtualWorld(playerid);

    GetPlayerPos(playerid, x, y, z);

    do {
        if(0 == IsPlayerConnected(--i)
        || world != GetPlayerVirtualWorld(i)
        || GetPlayerDistanceFromPoint(i, x, y, z) > range)
            continue;
        
		else if(((x < range/16) && (x > -range/16)) && ((y < -range/16) && (y > -range/16)) && ((z < -range/16) && (z > -range/16))) SEND_CM(i, c1, string);
		else if(((x < range/8) && (x > -range/8)) && ((y < -range/8) && (y > -range/8)) && ((z < -range/8) && (z > -range/8))) SEND_CM(i, c2, string);
		else if(((x < range/4) && (x > -range/4)) && ((y < -range/4) && (y > -range/4)) && ((z < -range/4) && (z > -range/4))) SEND_CM(i, c3, string);
		else if(((x < range/2) && (x > -range/2)) && ((y < -range/2) && (y > -range/2)) && ((z < -range/2) && (z > -range/2))) SEND_CM(i, c4, string);
		else if(((x < range) && (x > -range)) && ((y < -range) && (y > -range)) && ((z < -range) && (z > -range))) SEND_CM(i, c5, string);
    	else SEND_CM(i, c1, string);
    } while(i > 0);
    return 1;
}