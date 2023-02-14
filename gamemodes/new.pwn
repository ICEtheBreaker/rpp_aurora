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

#define GetName(%0)						pi[%0][pNames]


// после инклудов желательно начать регистрировать переменные
//  * следить за количеством и не регистрировать лишние, иначе будут лететь варнинги

new query_string[256]; // ??? в дальнейшем убрать вследствие оптимизации стека

enum pInfo {
	pID,
	pNames[MAX_PLAYER_NAME+1],
	pPassword[64+1], // пароль может состоять из 64 символов, при необходимости можно изменить значение
	pSalt[11],
	pIP[16],
	pEmail[64],
	pSex,
	pSkin,
	pMoney,
	pLevel,
	pExp,
}
new PlayerInfo[MAX_PLAYERS][pInfo];
new 
	bool: playerLoggedStatus[MAX_PLAYERS];

new sstring[256]; // позже нужно будет убрать и переделать в угоду стека


enum {
	dNull = 0, 
	dLogin = 1, dReg1 = 2,dReg2 = 3,dReg3 = 4,dReg4 = 5,
}


/* 	потом уберу. надо определиться с дизайном проекта (дабы была единая цветограмма). 
	перво наперво поработать с системой сохранения и безопасности пользователя. */

public OnGameModeInit()
{
	ConnectSQL();

	new MySQLOpt: option_id = mysql_init_options();
	mysql_set_option(option_id, AUTO_RECONNECT, true);
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
	SetTimerEx("@_mysqlPlayerAccountGet", 1000, 0, "i", playerid);

	GetPlayerName(playerid, PlayerInfo[playerid][pNames], MAX_PLAYER_NAME);
	GetPlayerIp(playerid, PlayerInfo[playerid][pIP], 16);

	if(IsLoginInvalid(GetName(playerid))) {
		SEND_CM(playerid, format_red, !"Ваше имя содержит запрещенные символы или цифры. Используйте формат: [Имя_Фамилия]");
		KickEx(playerid);
	}
	SEND_CM(playerid, format_black, !"Добро пожаловать на "color_white""name_proj"!");
	PlayerPlaySound(playerid, 162, 0, 0, 0);
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

	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
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
			if (!response) {
				SEND_CM(playerid, format_red, !"Вы отказались от регистрации.");
				KickEx(playerid);
			}

			if(!(6 <= strlen(inputtext) <= 22)) {
				SEND_CM(playerid, format_white, !"Длина пароля должна состоять от 6 до 22 символов");

				sstring[0] = EOS;
				format(sstring, sizeof(sstring),"{FFFFFF}Здравствуйте, {0093ff}%s\n\n{FFFFFF}Данный аккаунт {FFA500}отсутствует{FFFFFF} в базе данных.\nДля продолжения, введите пароль в поле ниже.\nОн будет необходим для дальнейшей авторизации на сервере.", pi[playerid][pNames]);
				ShowPlayerDialog(playerid, dReg1, DIALOG_I, !"{FFFFFF}[1/4]{FFA500} Пароль", sstring, !"Далее",!"Отмена");												
				
			}
			for (new i = 0; i < strlen(inputtext); i ++) 
			{
				switch (inputtext[i]) {
					case 'a'..'z', 'A'..'Z', '0'..'9':
						continue;

					default: {
						SEND_CM(playerid, format_white, !"Пароль не должен состоять из кириллицы и других запретных символов!");

						sstring[0] = EOS;
						format(sstring, sizeof(sstring),"{FFFFFF}Здравствуйте, {0093ff}%s\n\n{FFFFFF}Данный аккаунт {FFA500}отсутствует{FFFFFF} в базе данных.\nДля продолжения, введите пароль в поле ниже.\nОн будет необходим для дальнейшей авторизации на сервере.", pi[playerid][pNames]);
						ShowPlayerDialog(playerid, dReg1, DIALOG_I, !"{FFFFFF}[1/4]{FFA500} Пароль", sstring, !"Далее",!"Отмена");			

					}
				}
			}
			for(new d; d < 11; d++) PlayerInfo[playerid][pSalt][d] = random(79) + 47;
			PlayerInfo[playerid][pSalt][10] = 0;
			SHA256_PassHash(inputtext,PlayerInfo[playerid][pSalt], PlayerInfo[playerid][pPassword], 65);

			if(response) {
				sstring[0] = 0;
				format(sstring, sizeof(sstring), "{FFFFFF}Введите Ваш {FFA500}e-mail{FFFFFF} адрес, за которым будет закреплён данный аккаунт.\nЕсли Вы потеряете доступ к своему аккаунту, то с помощью {FFA500}e-mail{FFFFFF} Вы сможете восстановить его.");
				ShowPlayerDialog(playerid, dReg2, DIALOG_I, !"{FFFFFF}[2/4]{FFA500} Почта", sstring, !"Далее", !"Отмена");	
			}
		}
		case dReg2:
		{
			if(!response){
				SEND_CM(playerid, format_red, !"Вы отказались от регистрации.");
				KickEx(playerid);
			}
			if(response) {
				if(!IsValidEmail(inputtext)) {
					SEND_CM(playerid, format_red, !"Неккоректный адрес электронной почты.");
					ShowPlayerDialog(playerid, dReg2, DIALOG_I, !"{FFFFFF}[2/4]{FFA500} Почта", sstring, !"Далее", !"Отмена");	
				}
				if(!strlen(inputtext)) {
					SEND_CM(playerid, format_red, !"Вы не указали почту.");
					ShowPlayerDialog(playerid, dReg2, DIALOG_I, !"{FFFFFF}[2/4]{FFA500} Почта", sstring, !"Далее", !"Отмена");	
				}
				else if(IsValidEmail(inputtext) && strlen(inputtext)) {
					strmid(PlayerInfo[playerid][pEmail],inputtext,0,strlen(inputtext), 32);
					ShowPlayerDialog(playerid, dReg3, DIALOG_L, !"{FFFFFF}[3/4]{FFA500} Пол","{FFA500}1.{FFFFFF} Мужской\n{FFA500}2.{FFFFFF} women", !"Выбрать", !"Отмена");
				}
			}
		}
		case dReg3: 
		{
			if(!response) {
				SEND_CM(playerid, format_red, !"Вы отказались от регистрации.");
				KickEx(playerid);
			}
			if(response) {
				PlayerInfo[playerid][pSex] = listitem;
				CreateAccount(playerid);

			}
		}
		case dReg4:
		{
			if(!response) {
				SEND_CM(playerid, format_red, !"Вы отказались от авторизации.");
				KickEx(playerid);
			}
			
			if(!(6 <= strlen(inputtext) <= 22)) {
				SEND_CM(playerid, format_red, !"Длина пароля должна состоять от 6 до 22 символов");	
				ShowPlayerDialog(playerid, dReg4, DIALOG_STYLE_INPUT, "{FFA500}Авторизация", sstring, "Войти","Отмена");
			} 
			if(!strcmp(PlayerInfo[playerid][pSalt], PlayerInfo[playerid][pPassword]))
			{
				format(query_string, sizeof(query_string), "SELECT * FROM `accounts` WHERE `names` = '%s'", PlayerInfo[playerid][pNames]);
				mysql_tquery(db, query_string, "LoginPlayer", "i", playerid);
			}
			else return @_mysqlUploadPlayerAccount(playerid);
			query_string[0] = EOS;
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
	format(query_string, sizeof query_string, "SELECT 'password' , 'salt' FROM `accounts` WHERE `names` = '%s'", PlayerInfo[playerid][pNames]);
	mysql_tquery(db, query_string, "@_mysqlGetPlayerAccount", "i", playerid);
}

@_mysqlGetPlayerAccount(playerid);
@_mysqlGetPlayerAccount(playerid) {
	SetPlayerColor(playerid, 0xFF);

	if(cache_num_rows() == 0) {
		sstring[0] = EOS;
		format(sstring, sizeof(sstring),"{FFFFFF}Здравствуйте, {0093ff}%s\n\n{FFFFFF}Данный аккаунт {FFA500}отсутствует{FFFFFF} в базе данных.\nДля продолжения, введите пароль в поле ниже.\nОн будет необходим для дальнейшей авторизации на сервере.", pi[playerid][pNames]);
		ShowPlayerDialog(playerid, dReg1, DIALOG_I, !"{FFFFFF}[1/4]{FFA500} Пароль", sstring, !"Далее",!"Отмена");	
	}
	else {
		sstring[0] = EOS;
		cache_get_value_name(0, "password", PlayerInfo[playerid][pPassword], 65);		
		format(sstring, sizeof(sstring),"\
			{FFFFFF}Добро пожаловать на {daa44a}"mode_name"\n\n\
			{FFFFFF}Введите свой пароль\n\
			{FFFFFF}Попыток для ввода пароля:{0f4900} %d", 3 - GetPVarInt(playerid, "BadAttempt"));
		ShowPlayerDialog(playerid, dReg4, DIALOG_I, "{FFA500}Авторизация", sstring, "Войти", "Отмена");		
	}
	return 1;		
}
@_mysqlUploadPlayerAccount(playerid);
@_mysqlUploadPlayerAccount(playerid)
{
		if(cache_num_rows() == 0) {
		 	new ssstring[80];
			format(ssstring,sizeof(ssstring),"\
				{FF0000}Вы ввели неверный пароль!\n\
				{FFFFFF}Попыток для ввода пароля:{0f4900} %d", 2 - GetPVarInt(playerid, "BadAttempt"));
			ShowPlayerDialog(playerid, dReg4, DIALOG_I, "{FFA500}Авторизация", ssstring, "Войти", "Отмена");
			SetPVarInt(playerid, "BadAttempt", GetPVarInt(playerid, "BadAttempt") +1);
			ssstring[0] = EOS;
		} 
		if(GetPVarInt(playerid, "BadAttempt") >= 3) {
			Kick(playerid);
			SEND_CM(playerid, format_red, !"Вы истратили попытки на авторизацию.");
			return true;
		}
		return 1; 
}
stock CreateAccount(playerid)
{
	sstring[0] = EOS;
	query_string[0] = EOS;
	PlayerInfo[playerid][pMoney] = BONUS_MONEY;
	PlayerInfo[playerid][pLevel] = START_LEVEL;
	mysql_format(db, query_string, 350,"INSERT INTO `accounts` (`names`,`password`,`salt`,`email`,`sex`,`currentskin`,`money`,`level`) VALUES ('%s','%s','%e','%s',%d,%d,%i,%i)", PlayerInfo[playerid][pNames], PlayerInfo[playerid][pPassword], PlayerInfo[playerid][pSalt], PlayerInfo[playerid][pEmail], PlayerInfo[playerid][pSex], PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pLevel]);
	mysql_tquery(db, query_string);
	printf("(%s) %s", strlen(query_string), query_string);

	playerLoggedStatus[playerid] = true;
	SetCameraBehindPlayer(playerid);
	SpawnPlayer(playerid);
	return 1;
}
stock LoginPlayer(playerid) {
	cache_get_value_name_int(0, "id", PlayerInfo[playerid][pID]);
	SpawnPlayer(playerid);
	playerLoggedStatus[playerid] = true;
}

stock IsLoginInvalid(const text[]) // проверка ника при входе на сервер, если содержит запрещенные символы будет кикать
{
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

function OnPlayerKick(playerid) return Kick(playerid);
stock KickEx(playerid) return SetTimerEx("OnPlayerKick",50,false,"d",playerid);

stock ConnectSQL()
{
	db = mysql_connect(m_host, m_user, m_pass, m_db);
    if(mysql_errno() == 0)  {
		print("[mysql] database connected successfully");
	}
	else {
		print("[mysql] couldn't connect to database!");
	}
	mysql_log(ERROR | WARNING);
}