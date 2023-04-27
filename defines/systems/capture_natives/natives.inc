//========= Copyright (c) 2017-2023 Darkside Interactive, Ltd. All rights reserved. ============//
//
// Цель: системы и проверки
//
//=============================================================================//

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
	new bool:Succes = true;
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
	    if(!ValidChar(email[i])) Succes = false;
	}
	if(!Good) Succes = false;
	if(!TextFind(email,".ru") && !TextFind(email,".com") && !TextFind(email,".ua") && !TextFind(email,".su")) Succes = false;
	if(!TextFind(email,"@")) Succes = false;
  	return Succes;
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