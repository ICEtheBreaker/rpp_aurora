/////////////////////////////////////////////////////
//
// Copyright (c) 2017-2023 Darkside Interactive, Ltd. All rights reserved.
//
////////////////////////////////////////////////////

#include "../../defines/macroses.inc" //! подключение инклуда для доступа к нативке SEND_CM

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

stock ProxDetector(Float:radi, playerid, const string[], col1,col2,col3,col4,col5)
{
 	if(IsPlayerConnected(playerid))
 	{
    	new Float:posx;new Float:posy;new Float:posz;new Float:oldposx;new Float:oldposy;new Float:oldposz;new Float:tempposx;new Float:tempposy;new Float:tempposz;
       	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
     	foreach(new i:Player)
     	{
        	if(IsPlayerConnected(i))
        	{
            	if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
            	{
            	    GetPlayerPos(i, posx, posy, posz);
            	    tempposx = (oldposx - posx);
            	    tempposy = (oldposy - posy);
            	    tempposz = (oldposz - posz);
            	    if(((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < -radi/16) && (tempposy > -radi/16)) && ((tempposz < -radi/16) && (tempposz > -radi/16))) SEND_CM(i, col1, string);
            	    else if(((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < -radi/8) && (tempposy > -radi/8)) && ((tempposz < -radi/8) && (tempposz > -radi/8))) SEND_CM(i, col2, string);
            	    else if(((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < -radi/4) && (tempposy > -radi/4)) && ((tempposz < -radi/4) && (tempposz > -radi/4))) SEND_CM(i, col3, string);
            	    else if(((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < -radi/2) && (tempposy > -radi/2)) && ((tempposz < -radi/2) && (tempposz > -radi/2))) SEND_CM(i, col4, string);
            	    else if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < -radi) && (tempposy > -radi)) && ((tempposz < -radi) && (tempposz > -radi))) SEND_CM(i, col5, string);
            	}
         	}
     	}
	}
}