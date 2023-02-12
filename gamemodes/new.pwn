main () {}
#pragma tabsize 0

#include <a_samp> // надо поиграться с ограничениями, дабы в дальнейшем полностью отказаться от streamer
#include <a_mysql>
#include <sscanf2>
#include <foreach>
#include <streamer>
#include <fix>
#include <crashdetect>
#include <dc_cmd>
#include <Pawn.Regex>

#include "../../defines/name" // макрос касаемый названия проекта и прочего
#include "../../defines/db_conn" // подключение к бд (конфиг)
#include "../../defines/colors" // цвета

#include "../../defines/systems/capture_natives/natives" // перехват нативок
#include "../../defines/macroses" // прочие макросы

// дефайны

#define function%0(%1)	forward%0(%1); public%0(%1)
#define pi 				PlayerInfo
#define f%0%1			format(%0,sizeof(%0), %1

#undef MAX_PLAYERS
#define MAX_PLAYERS (2)

// после инклудов желательно начать регистрировать переменные
//  * следить за количеством и не регистрировать лишние, иначе будут лететь варнинги

new query_string[256]; // ??? в дальнейшем убрать вследствие оптимизации стека

enum pInfo {
	pID,
	pNames[MAX_PLAYER_NAME+1],
	pPassword[64], // пароль может состоять из 64 символов, при необходимости можно изменить значение
	pSalt[11],
	pEmail[65],
	pAge, // возраст персонажа, ни на что не влияет
	pSex, // SEX????
}
new PlayerInfo[MAX_PLAYERS][pInfo];
new 
	bool: playerLoggedStatus[MAX_PLAYERS];

enum {
	dNull = 0, 
	dLogin = 1, dReg1 = 2,dReg2 = 3,dReg3 = 4,dReg4 = 5,
}


/* 	потом уберу. надо определиться с дизайном проекта (дабы была единая цветограмма). 
	перво наперво поработать с системой сохранения и безопасности пользователя. */

public OnGameModeInit()
{
	ConnectSQL();
	SetGameModeText(""#mode_name""); 
	SendRconCommand("hostname "#name_proj"");
	SendRconCommand("mapname "#map_proj"");
	// printf("Loaded success "#mode_name"");
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
	GetPlayerName(playerid, PlayerInfo[playerid][pNames], MAX_PLAYER_NAME);

	SendClientMessage(playerid, format_white, !"Добро пожаловать на "color_white""name_proj"!");
	PlayerPlaySound(playerid, 162, 0, 0, 0);
	
	SetTimerEx("@_mysqlPlayerAccountGet", 1000, 0, "i", playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(playerLoggedStatus[playerid] == false)
		return KickEx(playerid);

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
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
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

CMD:plvh(pl) {
	new Float: X,
		Float: Y,
		Float: Z; 
	GetPlayerPos(pl, X, Y, Z);
	new veh = CreateVehicle(451, X, Y, Z, 0.0, 0, 2, 0);
	OnVehicleSpawn(veh);
	return PutPlayerInVehicle(pl, veh, 0);
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case dReg1: 
		{
			if (response == 0)
				return KickEx(playerid);

			if(!(6 <= strlen(inputtext) <= 22)) {
				SendClientMessage(playerid, format_white, "Длина пароля должна состоять от 6 до 22 символов");

				return ShowPlayerDialog(playerid, dReg1, DIALOG_STYLE_INPUT, "{FFA500}Регистрация", 
					""color_white""name_proj"\nВаш псевдоним: {FFA500}%s\n\nИмя не найдено в базе данных\nПридумайте и введите пароль в поле ниже:","Далее","Отмена");
				
			}

			for (new i = 0; i < strlen(inputtext); i ++) 
			{
				switch (inputtext[i]) {
					case 'a'..'z', 'A'..'Z', '0'..'9':
						continue;

					default: {
						SendClientMessage(playerid, format_white, "Пароль должен состоять из кириллицы и не содержать в себе цифр!");

						return ShowPlayerDialog(playerid, dReg1, DIALOG_STYLE_INPUT, "{FFA500}Регистрация", 
							""color_white""name_proj"\nВаш псевдоним: {FFA500}%s\n\nИмя не найдено в базе данных\nПридумайте и введите пароль в поле ниже:","Далее","Отмена");

					}
				}
			}
			PlayerInfo[playerid][pPassword][0] = EOS;
			strins(PlayerInfo[playerid][pPassword], inputtext, 0);
		}
		case dReg2: {
			if(response == 0)
				return KickEx(playerid);

			query_string[0] = EOS;
			format(query_string, sizeof query_string, "SELECT * FROM `accounts` WHERE `names` = '%s' AND `password` = MD5('%s')",PlayerInfo[playerid][pNames], inputtext);
			mysql_tquery(db, query_string, "@_mysqlUploadPlayerAccount", "i", playerid);
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

function @_mysqlPlayerAccountGet(playerid) {
	query_string[0] = EOS;
	format(query_string, sizeof query_string, "SELECT * FROM `accounts` WHERE `names` = '%s'", PlayerInfo[playerid][pNames]);
	mysql_tquery(db, query_string, "@_mysqlGetPlayerAccount", "i", playerid);
}

function @_mysqlGetPlayerAccount(playerid) {
	SetPlayerColor(playerid, 0xFF);

	if(cache_num_rows() == 0) {
		ShowPlayerDialog(playerid, dReg1, DIALOG_STYLE_INPUT, "{FFA500}Регистрация", 
		""color_white""name_proj"\nВаш псевдоним: {FFA500}%s\n\nИмя не найдено в базе данных\nПридумайте и введите пароль в поле ниже:","Далее","Отмена");
	}
	else {
		ShowPlayerDialog(playerid, dReg2, DIALOG_STYLE_INPUT, "{FFA500}Авторизация", 
		""color_white""name_proj"!\nВаш псевдоним: {FFA500}%s\n\nИмя найдено в базе данных\nВведите свой пароль в поле ниже:","Далее","Отмена");
	}
}
@_mysqlUploadPlayerAccount(playerid);
@_mysqlUploadPlayerAccount(playerid)
{
		if(cache_num_rows() == 0)
		{
			SendClientMessage(playerid, 0xFF0000FF, "Введён неправильный пароль.");

			return ShowPlayerDialog(playerid, dReg2, DIALOG_STYLE_INPUT, "{FFA500}Авторизация", 
					""color_white""name_proj"!\nВаш псевдоним: {FFA500}%s\n\nИмя найдено в базе данных\nВведите свой пароль в поле ниже:","Далее","Отмена");

		}

		playerLoggedStatus[playerid] = true;
		SetPlayerColor(playerid, 0xFFFFFF33);

		cache_get_value_name(0, "id", PlayerInfo[playerid][pID]);
		
		SetCameraBehindPlayer(playerid);
		SpawnPlayer(playerid);

		return 1;
}

function OnPlayerKick(playerid) return Kick(playerid);
stock KickEx(playerid) return SetTimerEx("OnPlayerKick",50,false,"d",playerid);

stock ConnectSQL()
{
	db = mysql_connect(m_host, m_user, m_db, m_pass);
    if(mysql_errno() == 1) {
		print("[mysql] couldn't connect to database!");
	}
	else {
		print("[mysql] database connected successfully");
	}
	mysql_log(ERROR | WARNING);
}