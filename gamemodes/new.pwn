main () {}

#include <a_samp> // надо поиграться с ограничениями, дабы в дальнейшем полностью отказаться от streamer
#include <a_mysql>
#include <sscanf2>
#include <foreach>
#include <streamer>
#include <fix>
#include <crashdetect>
#include <dc_cmd>
#include <Pawn.Regex>

#include "../../defines/name"
#include "../../defines/db_conn"
#include "../../defines/colors"

// дефайны

#define function%0(%1)	forward%0(%1); public%0(%1) 

#define MYSQL_HOST			"127.0.0.1"
#define MYSQL_USER			"root"
#define MYSQL_DB			"DATABASE_NAME"
#define MYSQL_PASS			""

// после инклудов желательно начать регистрировать переменные
//  * следить за количеством и не регистрировать лишние, иначе будут лететь варнинги

new MySQL:connects;
new query_string[256];

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
enum {
	dNull = 0, dLogin,dReg1,dReg2,dReg3,dReg4,
}


/* 	потом уберу. надо определиться с дизайном проекта (дабы была единая цветограмма). 
	перво наперво поработать с системой сохранения и безопасности пользователя. */

public OnGameModeInit()
{
	connects = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB); // хостинг отсутствует, поэтому используем локальное подключение
	if(mysql_errno() == 0) {
		printf("Подключение к MySQL = успешно."); // логи можно поменять
	} 
	else {
		printf("Подключение к MySQL не удалось. Код ошибки: "#mysql_error"");	
	} 

	SetGameModeText(""#mode_name""); 
	SendRconCommand("hostname "#name_proj"");
	SendRconCommand("mapname "#map_proj"");
	// printf("Loaded success "#mode_name"");
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetTimerEx("OnPlayerJoin",350,false,"d",playerid);
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
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

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid) 
	{
		case dReg1: 
		{
			if(!response)
			{
				SendClientMessage(playerid, 0xFF0000FF,!"Вы отказались от регистрации.");
				KickEx(playerid);
				return false;
			}
			if(strlen(inputtext) < 6 || strlen(inputtext) > 24)
			{
				SendClientMessage(playerid, 0xFF0000FF,!"Пароль должен состоять из 6-ти символов и не должен быть больше 24-х");
				query_string[0] = 0;
				format(query_string,sizeof(query_string),"{FFFFFF}Хуй хуй хуй хуй хуй\nВаш псевдоним: {ffa500}%s\n\n{FFFFFF}Данный псевдоним незарегистрирован на данном проекте\nПридумайте и введите свой пароль в поле ниже.",PlayerInfo[playerid][pNames]); // сообщение о входе на сервер, можно заменить :)
				ShowPlayerDialog(playerid, dReg1, DIALOG_STYLE_INPUT,"{FFA500}Регистрация",query_string,"Далее","Отмена");
				return false;
			}
			/*for(new i = 1; i < strlen(inputtext); --i) функция не работает
			{
				switch(inputtext[i])
				{
					case 'А'..'Я','а'..'я','-','=','!',',','.','@','#','$','%': //тут кириллица
					{
						SendClientMessage(playerid, 0xFF0000FF,!"Пароль должен состоять из латинских букв и не содержать запретных символов!");
						query_string[0] = 0;
						format(query_string,sizeof(query_string),"{FFFFFF}Хуй хуй хуй хуй хуй\nВаш псевдоним: {ffa500}%s\n\n{FFFFFF}Данный псевдоним незарегистрирован на данном проекте\nПридумайте и введите свой пароль в поле ниже.",PlayerInfo[playerid][pNames]); // сообщение о входе на сервер, можно заменить :)
						ShowPlayerDialog(playerid, dReg1, DIALOG_STYLE_INPUT,"{FFA500}Регистрация",query_string,"Далее","Отмена");
						return true;
					}
				}
			}*/
			for(new d; d < 10; d++) PlayerInfo[playerid][pSalt][d] = random(79) + 47;
			PlayerInfo[playerid][pSalt][10] = 0;
			SHA256_PassHash(inputtext,PlayerInfo[playerid][pSalt],PlayerInfo[playerid][pPassword],65);
			printf("Password hashed: %s", PlayerInfo[playerid][pPassword]);
			SetPVarString(playerid,"PlayerPassword",inputtext);
			printf("Пароль принят");
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

function OnPlayerJoin(playerid) //отдельная функция для регистрации. объявляется при выборе скина в паблике OnPlayerRequestClass. если аккаунт уже зарегистрирован, то его пустит по авто-входу, поскольку диалога с авторизацией еще нету
{
	GetPlayerName(playerid, PlayerInfo[playerid][pNames],MAX_PLAYER_NAME);
	query_string[0] = 0;
	mysql_format(connects,query_string,sizeof(query_string),"SELECT `password` , `salt` FROM `accounts` WHERE `names` = '%s' LIMIT 1",PlayerInfo[playerid][pNames]);
	new Cache:result = mysql_query(connects,query_string,true);
	new rows = cache_num_rows();
	if(rows)
	{
		cache_get_value_name(0,"password",PlayerInfo[playerid][pPassword]);
		cache_get_value_name(0,"salt",PlayerInfo[playerid][pSalt]);
	}
	else {
		format(query_string,sizeof(query_string),"{FFFFFF}Хуй хуй хуй хуй хуй\nВаш псевдоним: {ffa500}%s\n\n{FFFFFF}Данный псевдоним незарегистрирован на данном проекте\nПридумайте и введите свой пароль в поле ниже.",PlayerInfo[playerid][pNames]); // сообщение о входе на сервер, можно заменить :)
		ShowPlayerDialog(playerid, dReg1, DIALOG_STYLE_INPUT,"{FFA500}Регистрация",query_string,"Далее","Отмена");
	}
	cache_delete(result);
	return true;
}
function OnPlayerKick(playerid) return Kick(playerid);
stock KickEx(playerid) return SetTimerEx("OnPlayerKick",50,false,"d",playerid);