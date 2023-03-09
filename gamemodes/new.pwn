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
#define IsAdmin(%0) 					if(PlayerInfo[playerid][pAdmin] < %0) return 1

//вписан в мод
#define NAME_FULL_ACCESS_1				""
#define NAME_FULL_ACCESS_2				""
#define NAME_FULL_ACCESS_3				""
#define NAME_FULL_ACCESS_4				""


#undef MAX_PLAYERS
#define MAX_PLAYERS (2)

#define GetName(%0)						pi[%0][pNames]


// после инклудов желательно начать регистрировать переменные
//  * следить за количеством и не регистрировать лишние, иначе будут лететь варнинги

new query_string[356]; // ??? в дальнейшем убрать вследствие оптимизации стека

enum pInfo {
	pID,
	pNames[MAX_PLAYER_NAME+1],
	pPassword[64+1], // пароль может состоять из 64 символов, при необходимости можно изменить значение
	pIP[16],
	pRegData[13],
	pLastIP[16],
	pEmail[64],
	pAdmin,
	pSex,
	pSkin,
	pMoney,
	pLevel,
}
new PlayerInfo[MAX_PLAYERS][pInfo];
enum {
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

new sstring[512]; // позже нужно будет убрать и переделать в угоду стека


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
	printf("s");
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
		Kick(playerid);
	}
	SEND_CM(playerid, format_black, !"Добро пожаловать на "color_white""name_proj"!");
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	SavePlayer(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(playerLoggedStatus[playerid] == false) {
		SEND_CM(playerid, -1, "Вы не авторизовались!");
		return Kick(playerid);
	}

	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
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
CMD:makeadmin(playerid, params[]) {
	new playername[24], adm_level;
	IsAdmin(ADM_FOUNDER);
	if(sscanf(params, "s[24]i", playername, adm_level)) return SEND_CM(playerid, format_white, !"Введите: /makeadmin [ник игрока] [уровень администратора]");
	else if(CheckExceptionName(playername)) return 0;
	else if(!(ADM_NONE <= adm_level <= ADM_DEPUTY_CHIEF)) return SEND_CM(playerid, format_white, "Уровень администрирования от 1 до 6");
	query_string[0] = EOS;
	format(query_string, sizeof(query_string), "SELECT * FROM `admin` WHERE name = '%s'", playername);
	mysql_tquery(db, query_string , "@MakeAdmin", "isi", playerid, playername, adm_level);
	return true;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case dReg1: 
		{
			if (!response) {
				SEND_CM(playerid, format_red, !"Вы отказались от регистрации.");
				SHOW_PD(playerid, -1, 0, " ", " ", " ", "");
				return Kick(playerid);
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
			strmid(PlayerInfo[playerid][pPassword], inputtext, 0, strlen(inputtext), 32);

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
				SHOW_PD(playerid, -1, 0, " ", " ", " ", "");
				return Kick(playerid);
			}
			else {
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
				SHOW_PD(playerid, -1, 0, " ", " ", " ", "");
				return Kick(playerid);
			}
			else {
				switch(listitem) {
					case 0: PlayerInfo[playerid][pSex] = 1; // 1 - мужской
					case 1: PlayerInfo[playerid][pSex] = 2; // 2 - женский
				}
			}
			CreateAccount(playerid);
		}
		case dReg4:
		{
			if(response) {
				if(strcmp(PlayerInfo[playerid][pPassword], inputtext, true)) {
					query_string[0] = EOS;
					format(query_string, sizeof(query_string),"SELECT * FROM `accounts` WHERE `names` = '%s' AND `password` = '%s'", PlayerInfo[playerid][pNames], PlayerInfo[playerid][pPassword]);
					mysql_tquery(db, query_string, "LoginPlayer", "i", playerid);
				}
				else {
					return @_IncorrectPassword(playerid);
				}
			}
			else {
				SEND_CM(playerid, -1, "Вы отказались от авторизации."); 
				SHOW_PD(playerid, -1, 0, " ", " ", " ", "");
				return Kick(playerid);
			}
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
	format(query_string, sizeof query_string, "SELECT 'password' FROM `accounts` WHERE `names` = '%s'", PlayerInfo[playerid][pNames]);
	mysql_tquery(db, query_string, "@_mysqlGetPlayerAccount", "i", playerid);
}

@_mysqlGetPlayerAccount(playerid);
@_mysqlGetPlayerAccount(playerid) {
	SetPlayerColor(playerid, 0xFF);

	if(cache_num_rows() != 0) {
		cache_get_value_name(0, "password", PlayerInfo[playerid][pPassword], 65);		
		ShowLoginDialog(playerid);
	}
	else {
		ShowRegDialog(playerid);
	}
	return 1;		
}
@_IncorrectPassword(playerid);
@_IncorrectPassword(playerid)
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
		else return LoginPlayer(playerid);

		if(GetPVarInt(playerid, "BadAttempt") >= 3) {
			SEND_CM(playerid, format_red, !"Вы истратили попытки на авторизацию.");
			SHOW_PD(playerid, -1, 0, " ", " ", " ", "");
			return Kick(playerid);
		}
		return 1; 
}

stock ShowLoginDialog(playerid)
{
	sstring[0] = EOS;
	format(sstring, sizeof(sstring),"\
		{FFFFFF}Добро пожаловать на {daa44a}"mode_name"\n\n\
		{FFFFFF}Введите свой пароль\n\
		{FFFFFF}Попыток для ввода пароля:{0f4900} %d", 3 - GetPVarInt(playerid, "BadAttempt"));
	ShowPlayerDialog(playerid, dReg4, DIALOG_I, "{FFA500}Авторизация", sstring, "Войти", "Отмена");	
}
stock ShowRegDialog(playerid)
{
	sstring[0] = EOS;
	format(sstring, sizeof(sstring),"{FFFFFF}Здравствуйте, {0093ff}%s\n\n\
		{FFFFFF}Данный аккаунт {FFA500}отсутствует{FFFFFF} в базе данных.\n\
		Для продолжения, введите пароль в поле ниже.\n\
		Он будет необходим для дальнейшей авторизации на сервере.\n\
		\t\t{FFFFFF}Примечание для ввода пароля:\n\
		\t\t- {FFA500}Пароль должен состоять из латиницы и не содержать цифры\n\
		\t\t- {FFA500}Пароль не должен быть меньше 6 и больше 24 символов.", pi[playerid][pNames]);
	ShowPlayerDialog(playerid, dReg1, DIALOG_I, !"{FFFFFF}[1/4]{FFA500} Пароль", sstring, !"Далее",!"Отмена");	
	return 1;
}

stock CreateAccount(playerid)
{
	sstring[0] = EOS;
	query_string[0] = EOS;
	PlayerInfo[playerid][pMoney] = BONUS_MONEY;
	PlayerInfo[playerid][pLevel] = START_LEVEL;
	PlayerInfo[playerid][pSkin] = DEFAULT_SKIN;

	new Year, Month, Day;
	getdate(Year, Month, Day);
	new date[13];
	format(date, sizeof(date), "%02d.%02d.%d", Day, Month, Year);

	mysql_format(db, query_string, sizeof(query_string),"INSERT INTO `accounts` (`names`, `password`, `regIP`, `regData`, `lastIP`, `email`,`sex`,`admin`, `currentskin`, `money`, `level`) VALUES ('%s','%s','%s','%s','%s','%s',%d,%d,%d,%d,%d)", PlayerInfo[playerid][pNames], PlayerInfo[playerid][pPassword], PlayerInfo[playerid][pIP], date, PlayerInfo[playerid][pLastIP], PlayerInfo[playerid][pEmail], PlayerInfo[playerid][pSex], PlayerInfo[playerid][pAdmin], PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pLevel]);
	mysql_tquery(db, query_string);
	printf("(%s) %s", strlen(query_string), query_string);

	playerLoggedStatus[playerid] = true;
	SpawnPlayer(playerid);
	return 1;
}
stock LoginPlayer(playerid) {

	new getIP[16];
	cache_get_value_name_int(0, "email", PlayerInfo[playerid][pEmail]);
	cache_get_value_name_int(0, "sex", PlayerInfo[playerid][pSex]);
	cache_get_value_name_int(0, "admin", PlayerInfo[playerid][pAdmin]);
	cache_get_value_name_int(0, "currentskin", PlayerInfo[playerid][pSkin]);
	cache_get_value_name_int(0, "money", PlayerInfo[playerid][pMoney]);
	cache_get_value_name_int(0, "level", PlayerInfo[playerid][pLevel]);

	SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
	GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);

	PlayerInfo[playerid][pLastIP] = GetPlayerIp(playerid, getIP, 16);

	if(PlayerInfo[playerid][pAdmin] > 0) return SEND_CM(playerid, format_white, !"[A] Вы не авторизованы. Введите /alogin");
	
	playerLoggedStatus[playerid] = true;
	return 1;
}
stock SavePlayer(playerid) {
	if(playerLoggedStatus[playerid] == false) return 0;

	query_string[0] = EOS;
	mysql_format(db, query_string, sizeof(query_string), "UPDATE `accounts` SET `regIP` = '%s', `lastIP` = '%s', `email` = '%s', `sex` = %d, `admin` = %d, `currentskin` = %d, `money` = %d, `level` = %d", PlayerInfo[playerid][pIP], PlayerInfo[playerid][pIP], PlayerInfo[playerid][pEmail], PlayerInfo[playerid][pSex], PlayerInfo[playerid][pAdmin], PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pLevel]);
	mysql_tquery(db, query_string);
	return 1;
}

@MakeAdmin(playerid, const name[], level);
@MakeAdmin(playerid, const name[], level)
{
	new rows;
	cache_get_row_count(rows);

	if(rows)
	{
		if(!level)
		{
			query_string[0] = EOS;
			if(GetPlayerID(name) != INVALID_PLAYER_ID) PlayerInfo[GetPlayerID(name)][pAdmin] = 0;
			mysql_format(db, query_string, sizeof(query_string), "DELETE FROM `admin` WHERE names = '%s'", name);
			mysql_tquery(db, query_string, "", "");
			mysql_format(db, query_string, sizeof(query_string), "UPDATE `admin` SET level = 0 WHERE names = '%s'", name);
			mysql_tquery(db, query_string, "", "");
			sstring[0] = EOS;
			format(sstring, sizeof(sstring),"Администратор %s был снят с должности.", name);
			SEND_CM(playerid, format_red, sstring);
		}
		else
		{
			if(GetPlayerID(name) !=INVALID_PLAYER_ID) PlayerInfo[GetPlayerID(name)][pAdmin] = level;
			query_string[0] = EOS;
			mysql_format(db, query_string, sizeof(query_string), "UPDATE `admin` SET level = %d WHERE names '%s' LIMIT 1", level, name);
			mysql_tquery(db, query_string, "", "");
			mysql_format(db, query_string, sizeof(query_string), "UPDATE `accounts` SET admin = %d WHERE names = '%s'", level, name);
			mysql_tquery(db, query_string, "", "");
			sstring[0] = EOS;
			format(sstring, sizeof(sstring), "Администратор %s теперь имеет %i уровень доступа.", name, level);
			SEND_CM(playerid, format_white, sstring);
		}
	}
	else
	{
		query_string[0] = EOS;
		if(!level) return SEND_CM(playerid, format_white, "Игрок не администратор");
		mysql_format(db, query_string, sizeof(query_string), "INSERT INTO `admin` (name,level,last_connect) VALUES ('%s', %d, CURDATE()", name, level);
		mysql_tquery(db, query_string, "", "");
		mysql_format(db, query_string, sizeof(query_string), "UPDATE `accounts` SET admin = %d WHERE names = '%s'", level, name);
		mysql_tquery(db, query_string, "", "");
		sstring[0] = EOS;
		format(sstring, sizeof(sstring),"%s добавлен в базу данных как администратор. Уровень доступа: %i", name, level);
		SEND_CM(playerid, format_white, sstring);
		if(GetPlayerID(name) != INVALID_PLAYER_ID) {
			PlayerInfo[GetPlayerID(name)][pAdmin] = level;
			query_string[0] = EOS;
			mysql_format(db, query_string, sizeof(query_string), "UPDATE `accounts` SET admin %d WHERE names = '%s'", PlayerInfo[playerid][pAdmin], name);
			mysql_tquery(db, query_string, "", "");
		}
	}
	return 1;
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

stock CheckExceptionName(const string[])
{
	static const NameList[][] =
	{
		NAME_FULL_ACCESS_1,
		NAME_FULL_ACCESS_2,
		NAME_FULL_ACCESS_3,
	 	NAME_FULL_ACCESS_4
	};
	for(new i = 0; i < sizeof(NameList); i++)
	{
		if(GetString(string, NameList[i])) return 1;
	}
	return 0;
}
stock GetString(const param1[],const param2[]) return !strcmp(param1, param2, false);
stock GetPlayerID(const string[])
{
    new testname[MAX_PLAYER_NAME];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i)) continue;
		GetPlayerName(i, testname, sizeof(testname));
		if(strcmp(testname, string, true, strlen(string)) == 0) return i;
	}
	return INVALID_PLAYER_ID;
}


stock ConnectSQL()
{
	db = mysql_connect(m_host, m_user, m_pass, m_db);
    if(mysql_errno() == 0)  {
		print("[mysql] НЕХУЯ ЗАРАБОТАЛО УАСЯ");
	}
	else {
		print("[mysql] НЕ РАБОТАИТ БЛЕАДЬ");
	}
	mysql_log(ERROR | WARNING);
}