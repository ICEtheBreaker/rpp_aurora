//========= Copyright (c) 2017-2023 Darkside Interactive, Ltd. All rights reserved. ============//
//
// Цель: игровой мод Авроры
//
//=============================================================================//


// main(){} обязательно должен быть в начале!!!
main(){}
@___If_u_can_read_this_u_r_nerd();
@___If_u_can_read_this_u_r_nerd() {
	#emit stack 0x7FFFFFFF
	#emit inc.s cellmax
	static const ___[][] = {"AntiDeAMX"};
	#emit retn
	#emit load.s.pri ___
	#emit proc
	#emit proc
	#emit fill cellmax
	#emit proc
	#emit stor.alt ___
	#emit strb.i 2
	#emit switch 4
	#emit retn

	L1:
		#emit jump L1
		#emit zero cellmin
}
AntiDeAMX()
{
	new a[][] = {
		"Unarmed (Fist)",
		"Brass K"
	};

	new b;
	#emit load.pri b
	#emit stor.pri b

 	#pragma unused a
  	#pragma dynamic 1003
  	#pragma warning disable 219
   	//#pragma disablerecursion
}
#pragma tabsize 0

#include <a_samp> //! ���� ���������� � �������������, ���� � ���������� ��������� ���������� �� streamer

//! ysi ������ �������� ���� �� � ������������ ���
// #define YSI_YES_HEAP_MALLOC //? ���� ��� ������� YSI_YES_HEAP_MALLOC; YSI_NO_HEAP_MALLOC; -- � ������������� ��� �������
// #include "YSI_Coding\y_malloc"
// #include "YSI_Coding/y_hooks"

#include <a_mysql>
#include <sscanf2>
#include <foreach>
#include <streamer>
#include <fix>
#include <crashdetect> //? ����� ���� ������ ����� ���� ���� �� ���
#include <dc_cmd>
#include <Pawn.Regex>
#include "../../defines/name" // ������ �������� �������� ������� � �������
#include "../../defines/db_conn" // ����������� � �� (������)
#include "../../defines/colors" // �����
#include "../../defines/systems/capture_natives/natives" // �������� �������
#include "../../defines/macroses" // ������ �������
#include "../../defines/objs/autoLoader.inc" //! ����� ���������� �.�. "�����������" ����������� "������������" � ����� ������ ��������� ������� ����
// �������
#define function%0(%1)	forward%0(%1); public%0(%1)
#define pi 				PlayerInfo
#define f%0%1			format(%0,sizeof(%0), %1
#define IsAdmin(%0) 	if(PlayerInfo[playerid][pAdmin] < %0) return 1

//������ � ���
#define NAME_FULL_ACCESS_1				""
#define NAME_FULL_ACCESS_2				""
#define NAME_FULL_ACCESS_3				""
#define NAME_FULL_ACCESS_4				""

#undef MAX_PLAYERS
#define MAX_PLAYERS (3)

#define GetName(%0)						pi[%0][pNames]

//! ����� �������� ���������� ������ �������������� ����������
//!  * ������� �� ����������� � �� �������������� ������, ����� ����� ������ ��������

new query_string[356];

enum pInfo {
	pID,
	pNames[MAX_PLAYER_NAME+1],
	pPassword[65], //? pPassword = 65 ��� ��� �������
	pSalt[11],
	pIP[16],
	pRegData[13],
	pLastIP[16],
	pEmail[32],
	pAdmin,
	pSex,
	pSkin,
	pMoney,
	pLevel,
}
new PlayerInfo[MAX_PLAYERS][pInfo];

enum  {
    ADM_NONE = 0,
    ADM_HELPER = 1,
    ADM_MODER = 2,
    ADM_OLDER_MODER = 3,
    ADM_ADMIN = 4,
    ADM_OLDER_ADMIN = 5,
    ADM_DEPUTY_CHIEF = 6,
    ADM_CHIEF = 7,
	ADM_FOUNDER = 8,
	ADM_DEV = 9
}
new 
	bool: playerLoggedStatus[MAX_PLAYERS]; 

new sstring[512]; // ����� ����� ����� ������ � ���������� � ����� �����
new PlayerAFK[MAX_PLAYERS];
enum {
	dNull = 0, 
	dLogin = 1, dReg1 = 2, dReg2 = 3, dReg3 = 4, d_Log = 5,
	dMM = 6, 
}

public OnGameModeInit()
{
	ConnectSQL();
	AntiDeAMX();

	//? ��� �-� ���� ������ � ��������� ��������, ��������, ������ � ��. ����� ����� _ (������ �������������)
	_loadObjects(); //! [_loadObjects] ��������� � defines/objs/mapping/loadobj.inc

	//! ��� ������� �������, ������������ � ������� �� ������ ���������� streamer � �.�. � ��������������� �����������

	new MySQLOpt: option_id = mysql_init_options();
	new currenttime = GetTickCount();

	mysql_set_option(option_id, AUTO_RECONNECT, true);
	SetGameModeText(""#mode_name""); 
	SendRconCommand("hostname "#name_proj"");
	SendRconCommand("mapname "#map_proj"");

	printf("OnGameModeInit ���������� �� %i ms", GetTickCount() - currenttime);

	//? timers
	SetTimer("AFKSystemUpdates", 1000, true); //! [AFKSystemUpdates] - ��� ��������� � natives.inc
	return 1;
}

public OnGameModeExit()
{
	mysql_close(db);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	SetTimerEx("@_mysqlPlayerAccountGet", 1000, 0, "i", playerid); //! �������� ���������

	GetPlayerName(playerid, PlayerInfo[playerid][pNames], MAX_PLAYER_NAME);
	GetPlayerIp(playerid, PlayerInfo[playerid][pIP], 16);

	if(IsLoginInvalid(GetName(playerid))) {
		SEND_CM(playerid, format_red, !"���� ��� �������� ����������� ������� ��� �����. ����������� ������: [���_�������]");
		Kick(playerid);
	}
	SEND_CM(playerid, format_black, !"����� ���������� �� "color_white""name_proj"!");

	// printf("22:%s", (SHA256_PassHash("AB00ABF5809A496150A22AF43047C1E3D8CAD4CC2B7336E471953BD9D5AF6FA1", "1wv2d<A^_5")));

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(!playerLoggedStatus[playerid]) return 1; 
	else SavePlayer(playerid);
	PlayerAFK[playerid] = -2;
	return 1;
}

public OnPlayerSpawn(playerid) {
	if(!playerLoggedStatus[playerid]) return SEND_CM(playerid, -1, "�� �� ��������������!"), Kick(playerid);
	SetPlayerSkin(playerid, pi[playerid][pSkin]);
	SetCameraBehindPlayer(playerid);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
    if(!playerLoggedStatus[playerid]) return 0;
	
	sstring[0] = EOS;
	if(strlen(text) < 64) {
		format(sstring, sizeof(sstring), "%s[%d] �������: %s", PlayerInfo[playerid][pNames], playerid, text);
		ProxDetector(20.0, playerid, sstring, format_white, format_white, format_white, format_white, format_white);
	 	SetPlayerChatBubble(playerid, text, format_white, 20, 7500);

		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) ApplyAnimation(playerid, "PED", "IDLE_chat", 4.1, 0, 1, 1, 1, 1), SetTimerEx("@StopAnimation", 3200, false, "d", playerid);
	} else SEND_CM(playerid, format_red, "[������]: ������� ������� ���������!");
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	SetSpawnInfo(playerid, 0, 0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}	
public OnPlayerUpdate(playerid)
{
	PlayerAFK[playerid] = 0;
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}


//! ��������� ����������� ����� �����
CMD:plvh(pl) {
	new Float: X,
		Float: Y,
		Float: Z; 
	GetPlayerPos(pl, X, Y, Z);
	new veh = CreateVehicle(422, X, Y, Z, 0.0, 0, 2, 0);
	OnVehicleSpawn(veh);
	return PutPlayerInVehicle(pl, veh, 0);
}
CMD:makeadmin(playerid, params[]) {
	new playername[24], adm_level;
	IsAdmin(ADM_FOUNDER);
	if(sscanf(params, "s[24]i", playername, adm_level)) SEND_CM(playerid, format_white, !"�������: /makeadmin [��� ������] [������� ��������������]");
	else if(CheckExceptionName(playername)) return 0;
	else if(!(ADM_NONE <= adm_level <= ADM_DEPUTY_CHIEF)) SEND_CM(playerid, format_white, "������� ����������������� �� 1 �� 6");
	query_string[0] = EOS;
	mysql_format(db, query_string, sizeof(query_string), "SELECT * FROM `admin` WHERE name = '%e'", playername);
	mysql_tquery(db, query_string , "@MakeAdmin", "isi", playerid, playername, adm_level);
	return true;
}

//? /me /todo /do /try /n /s /b /ame
CMD:me(playerid, params[]) {
	if(sscanf(params, "s[118]", params[0])) SEND_CM(playerid, format_white, "[����������]: /me [��������]");
	sstring[0] = EOS;
	format(sstring, sizeof(sstring), "%s %s", PlayerInfo[playerid][pNames], params[0]);
	ProxDetector(20.0, playerid, sstring, 0x00F76193, 0x00F76193, 0x00F76193, 0x00F76193, 0x00F76193);
	SetPlayerChatBubble(playerid, params[0], 0x00F76193, 20, 7500);
	return 1;
}
CMD:ame(playerid, params[]) {
	if(sscanf(params, "s[144]", params[0])) SEND_CM(playerid, format_white, "[����������]: /ame [��������]");
	SetPlayerChatBubble(playerid, params[0], 0x00F76193, 20, 7500);
	return 1;
}
CMD:do(playerid, params[]) {
	if(sscanf(params, "s[116]", params[0])) SEND_CM(playerid, format_white, "[����������]: /do [�����]");
	sstring[0] = EOS;
	format(sstring, sizeof(sstring), "%s (%s)", params[0], PlayerInfo[playerid][pNames]);
	ProxDetector(20.0, playerid, sstring, 0x00F76193, 0x00F76193, 0x00F76193, 0x00F76193, 0x00F76193);
	SetPlayerChatBubble(playerid, params[0], 0x00F76193, 20, 7500);
	return 1;
}
CMD:try(playerid, params[]) {
	if(sscanf(params, "s[99]", params[0])) SEND_CM(playerid, format_white, "[����������]: /try [�����]");
	sstring[0] = EOS;
	format(sstring, sizeof(sstring), "%s %s | %s", PlayerInfo[playerid][pNames], params[0], (!random(2)) ? ("{FF0000}��������") : ("{32CD32}������"));
	ProxDetector(20.0, playerid, sstring, 0x00F76193, 0x00F76193, 0x00F76193, 0x00F76193, 0x00F76193);
	return 1;
}
CMD:todo(playerid, params[]) {
	if(sscanf(params, "s[95]", params[0])) SEND_CM(playerid, format_white, "[����������]: /todo [�����*��������]");
	if(strlen(params) > 95) SEND_CM(playerid, format_white, "[������]: ������� ������� �����!");
	new message[96];
	strmid(message, params, 0, sizeof(message));
	new Regex:rg_todocheck = Regex_New("^[a-zA-Za-��-�.-_,\\s]{2,48}\\*[a-zA-Za-��-�.-_,\\s]{2,48}$");
	if(Regex_Check(message, rg_todocheck)) {
		new star = strfind(message, "*");
		new action[50];
		strmid(action, message, star+1, sizeof(message));
		strdel(message, star, sizeof(message));
		sstring[0] = EOS;
		format(sstring, sizeof(sstring), "- '%e' - {DE92FF}������%s %s, %s", message, (PlayerInfo[playerid][pSex] == 1) ? ("") : ("�"), PlayerInfo[playerid][pNames], action);
		ProxDetector(20.0, playerid, sstring, format_white, format_white, format_white, format_white, format_white);
	} else return SEND_CM(playerid, format_white, "[����������]: /todo [�����*��������]");
	return 1;
}
CMD:s(playerid, params[]) {
	if(sscanf(params, "s[105]", params[0])) SEND_CM(playerid, format_white, "[����������]: /s [�����]");
	sstring[0] = EOS;
	format(sstring, sizeof(sstring), "%s[%d] �������%s: %s", PlayerInfo[playerid][pNames], playerid, (PlayerInfo[playerid][pSex] == 1) ? ("") : ("�"), params[0]);
	ProxDetector(20.0, playerid, sstring, 0xCCCC99FF, 0xCCCC99FF, 0xCCCC99FF, 0xCCCC99FF, 0xCCCC99FF);
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) ApplyAnimation(playerid, "ON_LOOKERS", "shout_01", 4.1,0,0,0,0,0);
	SetPlayerChatBubble(playerid, params[0], format_white, 25, 7500);
	return 1;
}
CMD:menu(playerid) {

	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case dReg1: 
		{
			if(response) {
				if(!strlen(inputtext)) return SEND_CM(playerid, format_red, "�� ������ �� �����."), ShowRegDialog(playerid);
				if(!(6 <= strlen(inputtext) <= 22)) return SEND_CM(playerid, format_red, "����� ������ ������ ���� �� 6 �� 22 ��������."), ShowRegDialog(playerid);
				new Regex:rg_passwordcheck = Regex_New("^[a-zA-Z0-9]{1,}$");

				if(Regex_Check(inputtext, rg_passwordcheck)){ 
					new salt[11];
					for(new i = 11; i--; ) salt[i] = random(79) + 47;
                	salt[10] = 0;
					SHA256_PassHash(inputtext, salt, PlayerInfo[playerid][pPassword], 65);
					// printf("salt::%s;pass:%s", salt, PlayerInfo[playerid][pPassword]);
					strmid(PlayerInfo[playerid][pSalt], salt, 0, 11, 11);
					sstring[0] = 0;
					format(sstring, sizeof(sstring), "{FFFFFF}������� ��� {FFA500}e-mail{FFFFFF} �����, �� ������� ����� �������� ������ �������.\n���� �� ��������� ������ � ������ ��������, �� � ������� {FFA500}e-mail{FFFFFF} �� ������� ������������ ���.");
					SHOW_PD(playerid, dReg2, DIALOG_I, !"{FFFFFF}[2/4]{FFA500} �����", sstring, !"�����", !"������");	
				} else {
					ShowRegDialog(playerid), SEND_CM(playerid, format_red, "������ ����� �������� ������ �� ����� � ��������� �������� ������ ��������.");
				}
				Regex_Delete(rg_passwordcheck);
			} else {
				SEND_CM(playerid, format_red, !"�� ���������� �� �����������.");
				SHOW_PD(playerid, -1, 0, " ", " ", " ", "");
				return Kick(playerid);
			}
		}
		case dReg2:
		{
			if(!response){
				SEND_CM(playerid, format_red, !"�� ���������� �� �����������.");
				SHOW_PD(playerid, -1, 0, " ", " ", " ", "");
				return Kick(playerid);
			}
			else {
				if(!IsValidEmail(inputtext)) {
					SEND_CM(playerid, format_red, !"������������ ����� ����������� �����.");
					SHOW_PD(playerid, dReg2, DIALOG_I, !"{FFFFFF}[2/4]{FFA500} �����", sstring, !"�����", !"������");	
				}
				if(!strlen(inputtext)) {
					SEND_CM(playerid, format_red, !"�� �� ������� �����.");
					SHOW_PD(playerid, dReg2, DIALOG_I, !"{FFFFFF}[2/4]{FFA500} �����", sstring, !"�����", !"������");	
				}
				else if(IsValidEmail(inputtext) && strlen(inputtext)) {
					strmid(PlayerInfo[playerid][pEmail],inputtext,0,strlen(inputtext), 32);
					SHOW_PD(playerid, dReg3, DIALOG_L, !"{FFFFFF}[3/4]{FFA500} ���","{FFA500}1.{FFFFFF} �������\n{FFA500}2.{FFFFFF} women", !"�������", !"������");
				}
			}
		}
		case dReg3: 
		{
			if(!response) {
				SEND_CM(playerid, format_red, !"�� ���������� �� �����������.");
				SHOW_PD(playerid, -1, 0, " ", " ", " ", "");
				return Kick(playerid);
			}
			else {
				switch(listitem) {
					case 0: PlayerInfo[playerid][pSex] = 1; // 1 - �������
					case 1: PlayerInfo[playerid][pSex] = 2; // 2 - �������
				}
			}
			CreateAccount(playerid);
		}
		case d_Log: {
			if(response) {
				new checkpass[65];

				// printf("salt:%s\t salt+pass:%s\n", PlayerInfo[playerid][pSalt], (SHA256_PassHash(inputtext, PlayerInfo[playerid][pSalt], checkpass, 65)));
				// printf("pass:%s", PlayerInfo[playerid][pPassword]);
				// printf("salt:%s", PlayerInfo[playerid][pSalt]);
				// printf("input:%s", inputtext);
				
			   	SHA256_PassHash(inputtext, PlayerInfo[playerid][pSalt], checkpass, 65);

				// printf("%d", strcmp(PlayerInfo[playerid][pPassword], checkpass));

				// printf("checkpass:%s", checkpass);

			   	if(!strcmp(PlayerInfo[playerid][pPassword], checkpass)) {
					query_string[0] = 0;
					// print("12345:vishel pizdu pochesat");
					mysql_format(db, query_string, sizeof(query_string), "SELECT * FROM `accounts` WHERE `names` = '%e' AND `password` = '%e'", GetName(playerid), PlayerInfo[playerid][pPassword]);
					mysql_tquery(db, query_string, "LoginPlayer", "d", playerid);
				} else @_IncorrectPassword(playerid);
			}
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

@_mysqlPlayerAccountGet(playerid);
@_mysqlPlayerAccountGet(playerid) {
	query_string[0] = EOS;
	// print("yesss");
	mysql_format(db, query_string, sizeof query_string, "SELECT `password`, `salt` FROM `accounts` WHERE `names` = '%e'", GetName(playerid));
	mysql_tquery(db, query_string, "@_mysqlGetPlayerAccount", "i", playerid);
}

@_mysqlGetPlayerAccount(playerid);
@_mysqlGetPlayerAccount(playerid) {
	SetPlayerColor(playerid, 0xFF);

	if(cache_num_rows() != 0) {
		// print("yesss 2");
		cache_get_value_name(0, "password", PlayerInfo[playerid][pPassword], 65);
		cache_get_value_name(0, "salt", PlayerInfo[playerid][pSalt], 11);
		// printf("salt1:%s", PlayerInfo[playerid][pSalt]);	
		ShowLoginDialog(playerid);
	}
	else ShowRegDialog(playerid);

	return 1;		
}
@StopAnimation(playerid);
@StopAnimation(playerid) return ApplyAnimation(playerid, "PED", "facanger", 4.1, 0, 1, 1, 1, 1);

@_IncorrectPassword(playerid);
@_IncorrectPassword(playerid) {
	if(cache_num_rows() == 0) {
		new ssstring[80];
		// print("yesss 3");
		format(ssstring,sizeof(ssstring),"\
			{FF0000}�� ����� �������� ������!\n\
			{FFFFFF}������� ��� ����� ������:{0f4900} %d", 2 - GetPVarInt(playerid, "BadAttempt"));

		SHOW_PD(playerid, d_Log, DIALOG_I, "{FFA500}�����������", ssstring, "�����", "������");
		SetPVarInt(playerid, "BadAttempt", GetPVarInt(playerid, "BadAttempt") + 1);
		ssstring[0] = EOS;
	} else {LoginPlayer(playerid);}

	if(GetPVarInt(playerid, "BadAttempt") >= 3) {
		// print("yesss 444");
		SEND_CM(playerid, format_red, !"�� ��������� ������� �� �����������.");
		SHOW_PD(playerid, -1, 0, " ", " ", " ", "");
		return Kick(playerid);
	}

	return 1; 
}

stock ShowLoginDialog(playerid)
{
	sstring[0] = 0;
	format(sstring, sizeof(sstring),"\
		{FFFFFF}����� ���������� �� {daa44a}"mode_name"\n\n\
		{FFFFFF}������� ���� ������\n\
		{FFFFFF}������� ��� ����� ������:{0f4900} %d", 3 - GetPVarInt(playerid, "BadAttempt"));
	SHOW_PD(playerid, d_Log, DIALOG_I, "{FFA500}�����������", sstring, "�����", "������");
	
	return 1;	
}
stock ShowRegDialog(playerid)
{
	sstring[0] = 0;
	format(sstring, sizeof(sstring),"{FFFFFF}������������, {0093ff}%s\n\n\
		{FFFFFF}������ ������� {FFA500}�����������{FFFFFF} � ���� ������.\n\
		��� �����������, ������� ������ � ���� ����.\n\
		�� ����� ��������� ��� ���������� ����������� �� �������.\n\n\
		\t\t{FFFFFF}���������� ��� ����� ������:\n\
		\t\t- {FFA500}������ ������ �������� �� �������� � �� ��������� �����\n\
		\t\t- {FFA500}������ �� ������ ���� ������ 6 � ������ 24 ��������.", pi[playerid][pNames]);
	SHOW_PD(playerid, dReg1, DIALOG_I, !"{FFFFFF}[1/4]{FFA500} ������", sstring, !"�����",!"������");	
	return 1;
}

stock CreateAccount(playerid)
{
	sstring[0] =
	query_string[0] = EOS;

	PlayerInfo[playerid][pMoney]	 = BONUS_MONEY;
	PlayerInfo[playerid][pLevel] 	 = START_LEVEL;
	PlayerInfo[playerid][pSkin] 	 = DEFAULT_SKIN;

	new Year, Month, Day;
	getdate(Year, Month, Day);
	new date[13];
	format(date, sizeof(date), "%02d.%02d.%d", Day, Month, Year);

	mysql_format(db, query_string, sizeof(query_string),"INSERT INTO `accounts` (`names`, `password`, `salt`, `regIP`, `regData`, `lastIP`, `email`,`sex`,`admin`, `currentskin`, `money`, `level`) VALUES ('%e','%e','%e','%e','%e','%e','%e',%d,%d,%d,%d,%d)", GetName(playerid), PlayerInfo[playerid][pPassword], PlayerInfo[playerid][pSalt], PlayerInfo[playerid][pIP], date, PlayerInfo[playerid][pLastIP], PlayerInfo[playerid][pEmail], PlayerInfo[playerid][pSex], PlayerInfo[playerid][pAdmin], PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pLevel]);
	mysql_tquery(db, query_string, "", "");

	printf("22 (%s) %s", strlen(query_string), query_string);

	playerLoggedStatus[playerid] = true;
	SpawnPlayer(playerid);
	return 1;
}
function LoginPlayer(playerid) {
	new getIP[16];

	cache_get_value_name(0, "email", PlayerInfo[playerid][pEmail], 32);
	cache_get_value_name_int(0, "sex", PlayerInfo[playerid][pSex]);
	cache_get_value_name_int(0, "admin", PlayerInfo[playerid][pAdmin]);
	cache_get_value_name_int(0, "currentskin", PlayerInfo[playerid][pSkin]);
	cache_get_value_name_int(0, "money", PlayerInfo[playerid][pMoney]);
	cache_get_value_name_int(0, "level", PlayerInfo[playerid][pLevel]);

	SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
	GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);

	PlayerInfo[playerid][pLastIP] = GetPlayerIp(playerid, getIP, 16);

	TogglePlayerSpectating(playerid, 0);

	if(PlayerInfo[playerid][pAdmin] > 0) SEND_CM(playerid, format_white, !"[A] �� �� ������������. ������� /alogin");
	
	// SavePlayer(playerid);

	playerLoggedStatus[playerid] = true;
	SpawnPlayer(playerid);

	return 1;
}
stock SavePlayer(playerid) {
	if(!playerLoggedStatus[playerid]) return 0;

	query_string[0] = EOS;
	mysql_format(db, query_string, sizeof(query_string), "UPDATE `accounts` SET `lastIP` = '%e', `email` = '%e', `sex` = %d, `admin` = %d, `currentskin` = %d, `money` = %d, `level` = %d", PlayerInfo[playerid][pLastIP], PlayerInfo[playerid][pEmail], PlayerInfo[playerid][pSex], PlayerInfo[playerid][pAdmin], PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pLevel]);
	mysql_tquery(db, query_string, "", "");

	//! ��������� ������� �������������� ������� � ����� �� ���� ����������� ��������� ���� �� ������� �� �������

	return 1;
}

@MakeAdmin(playerid, const name[], level);
@MakeAdmin(playerid, const name[], level) {
	if(cache_num_rows() == 0) {
		if(!level) {
			query_string[0] = EOS;
			if(GetPlayerID(name) != INVALID_PLAYER_ID) PlayerInfo[GetPlayerID(name)][pAdmin] = 0;
			mysql_format(db, query_string, sizeof(query_string), "DELETE FROM `admin` WHERE names = '%e'", name);
			mysql_tquery(db, query_string, "", "");
			mysql_format(db, query_string, sizeof(query_string), "UPDATE `admin` SET level = 0 WHERE names = '%e'", name);
			mysql_tquery(db, query_string, "", "");
			sstring[0] = EOS;
			format(sstring, sizeof(sstring),"������������� %s ��� ���� � ���������.", name);
			SEND_CM(playerid, format_red, sstring);
		}
		else {
			if(GetPlayerID(name) !=INVALID_PLAYER_ID) PlayerInfo[GetPlayerID(name)][pAdmin] = level;
			query_string[0] = EOS;
			mysql_format(db, query_string, sizeof(query_string), "UPDATE `admin` SET level = %d WHERE names '%e' LIMIT 1", level, name);
			mysql_tquery(db, query_string, "", "");
			mysql_format(db, query_string, sizeof(query_string), "UPDATE `accounts` SET admin = %d WHERE names = '%e'", level, name);
			mysql_tquery(db, query_string, "", "");
			sstring[0] = EOS;
			format(sstring, sizeof(sstring), "������������� %s ������ ����� %i ������� �������.", name, level);
			SEND_CM(playerid, format_white, sstring);
		}
	}
	else {
		query_string[0] = EOS;
		if(!level) return SEND_CM(playerid, format_white, "����� �� �������������");
		mysql_format(db, query_string, sizeof(query_string), "INSERT INTO `admin` (name,level,last_connect) VALUES ('%e', %d, CURDATE())", name, level);
		mysql_tquery(db, query_string, "", "");
		mysql_format(db, query_string, sizeof(query_string), "UPDATE `accounts` SET admin = %d WHERE names = '%e'", level, name);
		mysql_tquery(db, query_string, "", "");
		sstring[0] = EOS;
		format(sstring, sizeof(sstring),"%s �������� � ���� ������ ��� �������������. ������� �������: %i", name, level);
		SEND_CM(playerid, format_white, sstring);
		if(GetPlayerID(name) != INVALID_PLAYER_ID) {
			PlayerInfo[GetPlayerID(name)][pAdmin] = level;
			query_string[0] = EOS;
			mysql_format(db, query_string, sizeof(query_string), "UPDATE `accounts` SET admin %d WHERE names = '%e'", PlayerInfo[playerid][pAdmin], name);
			mysql_tquery(db, query_string, "", "");
		}
	}
	return 1;
}

stock IsLoginInvalid(const text[]) {
	if(strfind(text, "none", false) != -1) return 1;
	if(strfind(text, "'", true) != -1) return 1;
	if(strfind(text, "/", true) != -1) return 1;
	if(strfind(text, "%", true) != -1) return 1;
	if(strfind(text, "&", true) != -1) return 1;
	if(strfind(text, "*", true) != -1) return 1;
	if(strfind(text, "(", true) != -1) return 1;
	if(strfind(text, ")", true) != -1) return 1;
	if(strfind(text, "1", true) != -1) return 1;
	if(strfind(text, "2", true) != -1) return 1;
	if(strfind(text, "3", true) != -1) return 1;
	if(strfind(text, "4", true) != -1) return 1;
	if(strfind(text, "5", true) != -1) return 1;
	if(strfind(text, "6", true) != -1) return 1;
	if(strfind(text, "7", true) != -1) return 1;
	if(strfind(text, "8", true) != -1) return 1;
	if(strfind(text, "9", true) != -1) return 1;
	return 0;
}
// GetString(const p1[], const p2[]) return !strcmp(p1, p2);
stock CheckExceptionName(const string[]) {
	static const NameList[][] = {
		NAME_FULL_ACCESS_1,
		NAME_FULL_ACCESS_2,
		NAME_FULL_ACCESS_3,
	 	NAME_FULL_ACCESS_4
	};
	for(new i = sizeof(NameList); i--; ) {
		if (!strcmp(string, NameList[i])) return 1;
		// if(!GetString(string, NameList[i])) return 1;
	}
	return 0;
}

stock GetPlayerID(const string[]) {
    new testname[MAX_PLAYER_NAME];
	foreach(new i:Player) {
		GetPlayerName(i, testname, sizeof(testname));
		if(!strcmp(testname, string, true)) return i;
	}
	return INVALID_PLAYER_ID;
}

stock ConnectSQL()
{
	db = mysql_connect(m_host, m_user, m_pass, m_db);
   	switch(mysql_errno()){
		case 0: print("�������� �����");
	    case 1044: return print("�� �������� ����� [�� ���� � ������������ ������??? � �� ���� ���]");
	    case 1045: return print("�� �������� ����� [������������ ������ �����]");
	    case 1049: return print("�� �������� ����� [�� ����� ����� ���� ������]");
	    case 2003: return print("�� �������� ����� [������ ���������� ���]");
		case 2002: return print("�� �������� ����� [�� ������ �� ������� �����]");
	    case 2005: return print("�� �������� ����� [�� ���� ���� �����]");
	    default: return printf("�� �������� ����� [��� ��� �����. ������: %d]", mysql_errno());
	}
	mysql_log(DEBUG); 
	return 1;
}