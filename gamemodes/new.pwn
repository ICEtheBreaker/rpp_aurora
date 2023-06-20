//!============>> Copyright (c) 2017-2023 Darkside Interactive, Ltd. All rights reserved. <<============//
//*
//? Цель: игровой мод Авроры. Подгружает в себя все колонтитульные файлы из `defines`, содержит все
//? системы, настройки экономики, систему ADM || ICBRK(для уровня DEV) и остальное.
//*
//!=====================================================================================================//




/*
           _ _ _ _ _ _		_ _ _ _ _ _ _		__ 					   __
		 _|	 _ _ _ _ _|    |  _ _ _ _ _  |	   |_ |_   			 	 _|  |
	   _|  _|		  	   | |		   | |		 |_ |_             _| _|
	  |	 _|                | |         | |		   |_ |_ 		 _| _|
      |	|	 _ _ _ _ _     | |_ _ _ _ _| | 		     |_ |_     _| _| 
	  |	|	| _ _ _   |    |  _ _ _ _ _  |			   |_ |___| _|
	  |	|			| |	   | | 		   | |			     |_   _|
	  |	|_			| |	   | |		   | |		     	   | |
	  |_  |_ _ _ _ _| |    | |         | |                 | |				//! не удивляйтесь это логотип авроры
		|_ _ _ _ _ _ _|	   |_|         |_|			       |_|

		 _ _ _ _ _ _ _ 	    _ _ _ _ _ _ _ 
		|  _ _ _ _ _ _|    |  _ _ _ _ _  |
		| | 			   | |		   | | 	
		| |_ _ _ _ _ _	   | |		   | |
		|  _ _ _ _ _ _|	   | |_ _ _ _ _| |
		| |				   |  _ _ _ _ _  |
		| |_ _ _ _ _ _	   | |		   | |
		|_ _ _ _ _ _ _|	   |_|		   |_|
*/	








//? насчёт id игрока нет, не уверен. потому что если связать игрока, который зашел под id = 0, и в бд рандомный чел с id = 0,

//? то я думаю что это было совсем не верно.

//! даня смс для тебя:
//! если в команде имеется ввод ид игрока то это всегда будет playerid
//! ничего другое
//! стереть после прочтения

//=================================[ANTIDEMAMX PROC]==================================//
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


//=============================[PREPROCESSOR DIRECTIVES]==============================//
#include "../../defines/macroses" 
#if !defined IsValidVehicle
     native IsValidVehicle(vehicleid);
#endif
#include <a_samp>

#if MYSQL_IS_LOCAL == true
	#include "../../defines/sql/local_sql_conn"
	#include <a_mysql>
#else
	#tryinclude "../../defines/sql/sql_conn"
	#include <a_mysql>
#endif

#undef MAX_PLAYERS
#define MAX_PLAYERS (6)

#pragma tabsize 0
#define STREAMER_USAGE 
//#define MAILER_PHP_SCRIPT

#if defined MAILER_PHP_SCRIPT
	#define MAILER_URL "dimamins.beget.tech/mailer.php"
	#define MAILER_MAX_MAIL_SIZE (1024) 
	#include "mailer"
#endif


// #define MALLOC_MEMORY (32768)
// #define YSI_YES_HEAP_MALLOC //! усы да хеап малок

//! появились ошибки при запуске сервака с библиотекой y_asi
//! ну и хуй с ними 

#if defined YSI_YES_HEAP_MALLOC
	#define jitter_use
	#include "YSI_Coding\y_malloc"
#endif //! а тут он просто напросто не нужен

#if defined jitter_use
	#if defined YSI_NO_HEAP_MALLOC
		#undef jitter_use
		#include "YSI_Coding\y_malloc"
		#tryinclude "YSI\jit.inc"
	#endif
#endif //! без __no_heap_mal. не работает jitter.inc
#if defined STREAMER_USAGE 
	#tryinclude <streamer> 
#endif	
//=================================[THIS IS INCLUDES]=================================//

#include <sscanf2>
#include <foreach>
#include <fix>
#include <crashdetect> 
#include <dc_cmd>
#include <Pawn.Regex>
#include <TOTP>
#include <YALP>
#include <strlib> //! очень полезная штука

//==========================[DIRECTORY | SYSTEMS | INCLUDES]==========================//

#include "../../defines/colors" 
#include "../../defines/systems/capture_natives/natives" 
#include "../../defines/objs/autoLoader.inc" //! начать вскоре работу
// #include "../../defines/systems/autoschool/main"

//===================================[NATIVE CONFIG]==================================//
#define function%0(%1)					forward%0(%1); public%0(%1)
#define pi 								PlayerInfo

#define f(%0,							format(%0,
//! f(%0(str),%1(ДЛИНА),%2(всё ост.))

#define fADM(%0) 						if(PlayerInfo[playerid][pAdmin] < %0) return 1
#define GetName(%0)						pi[%0][pNames]
#define RandomEx(%0,%1) 				(random(%1-%0)+%0)
#define CheckConnection(%0)				(!IsPlayerConnected(%0))
#define IsLicenseValid(%0)				(!(1 <= (%0) <= 5))

#define IsRangeValid(%0,%1)				(strlen(%0) > %1)
//! IsRangeValid 
//! первый параметр %0 - строка, %1 - длина

//===================================[SERVER CONFIG]==================================//
#define SERVER_NAME 					"Aurora RolePlay"
#define SERVER_VERSION 					"Aurora [v."MODE_VERS"]"
#define MODE_VERS						"0.1.1.8"
#define SERVER_MAP                      "South Ural"
#define SERVER_WEBSITE 					"rpp-aurora.ru/"
#define PRIME_HOST_PAGE 				"prime-host.pro/"
#define SERVER_FORUM                    "/"
#define SERVER_GROUP                    "vk.com/rpp_aurora"
#define SERVER_FREE_GROUP               "vk.com/rpp_aurora"
#define SERVER_LANGUAGE                 "Russian/English/Belarussian"
#define SERVER_MAIL_ADDRESS				"support@rpp-aurora"
#define TEST_EMAIL						"dimamironov1337228@gmail.com"

//=================================[FULL ACCESS CONFIG]===============================//
#define NAME_FULL_ACCESS_1				"Jei_Kilo"
#define NAME_FULL_ACCESS_2				"I]C[E_the_Bre]a[ker"
#define NAME_FULL_ACCESS_3				"Name_Subname"
#define NAME_FULL_ACCESS_4				"Name_Subname"


//==================================[ADM | ICBRK CONFIG]==============================//
#define ADMIN_NOT_LOGGED       		    "{0093ff}[ADM]: {FFFFFF}Вы не в системе. Используйте {33CCFF}/alog"
#define ADMIN_ALREADY_LOGGED 	        "{FFFFFF}Вы уже в системе!"
#define PLAYER_INVALID 					"{FFFFFF}Игрок не активен."
#define PLAYER_NOT_LOGGED 				"{FFFFFF}Игрок не авторизован."
#define LICENSE_INVALID					"{FFFFFF}Диапазон лицензий: не меньше 0 не больше 5"

//====================================[PLAYER CONFIG]=================================//
#define NOT_AVAILABLE 					"Вам недоступна данная возможность!"
#define NOT_ENOUGH_MONEY                "У вас недостаточно средств на счету."
#define SERVER_CLOSED 					"{F04245}Сервер закрыл соединение! Для выхода из игры, введите {0093ff}/q(uit)"
#define LOG_TIMED_OUT					"{F04245}Время на авторизацию истекло! Для выхода из игры, введите {0093ff}/q(uit)"

main(){
	printf("\t| RPP_"#SERVER_VERSION" | %s", __date);
	printf("\t|--------------------------------");
	printf("\t| Creators and maintainers: "#NAME_FULL_ACCESS_2"| "#NAME_FULL_ACCESS_1"");
	printf("\t| Project managed by Darkside Interactive, Ltd. All rights reserved. ");
	printf("");
	printf("");
	printf("");
	printf("\t| Compiled: %s at %s", __date, __time);
	printf("\t|--------------------------------------------------------------");
	printf("\t| Repository: https://github.com/ICEtheBreaker/rpp_aurora");
}

new 
	query_string[800], // mysql string
	fstring[4097]; // format string
	//GlobalTime;
	//AuthSymbols[32][] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "2", "3", "4", "5", "6", "7"};

// система лицензий


//

// enum lICS {
// 	CARL = 0,
// 	TRUCKL = 1,
// 	TRAINL = 2,
// 	AEROL = 3
// }
//! этот енум нужно допилить поск. нужно сделать прямую зависимость от нужной категории прав

enum pInfo {
	pID,
	pNames[MAX_PLAYER_NAME+1],
	pPassword[65], 
	pSalt[11],
	pIP[16],
	pRegData[13],
	pLastIP[16],
	pEmail[32],
	pEmailConfirmed,
	pAdmin,
	pSex,
	pSkin,
	pMoney,
	pLevel,
	pShowName,
	pHungryBar,
	pShowDocuments,
	sdTrade,
	pEmailAuth,
	pGugleAuth[17],
	pGugleSettings,
	pGugleEnabled,
	pVkontakte,
	pLanguage,
	pWantedLevel,
	pPassport,
	pDriveLic[5], // согласно спецификации 0 id -авто, 1 -судоходства, 2 -воздушные, 3-грузовой транспорт \ средн. 4 - оружие, 5 - бизнес
	pDriveLics[20], // хранит в себе массив информации о лицензиях (внутри контекста и запросы бд)

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
//						[BOOLEANS]
new 
	bool:playerLoggedStatus[MAX_PLAYERS char]; 


new inadmcar[MAX_PLAYERS char];
new PlayerBadAttempt[MAX_PLAYERS char];
new PlayerAFK[MAX_PLAYERS char];
//new oldhour; //? переменная реального времени
new timedata[5]; //? переменные времени и даты

new Iterator:ADM_LIST<MAX_PLAYERS>; //! ахуеная вещь слюшай
#include "../../defines/systems/chat/chatmsg.inc"
enum {
	dNull = 0, 
	dLogin = 1, dReg1 = 2, dReg2 = 3, dReg3 = 4, d_Log = 5,
	dMM = 6, dSECURE_SETTINGS = 7, d_PLAYER_SETTINGS = 8,
	Gugle = 9, Gugle_Settings = 10, GugleInfo = 11, 
	GugleInfo2 = 12, GugleInfo3 = 13, GugleInfo4 = 14, GugleInfo5 = 15,
	Gugle_Delete = 16, Gugle_Confirm = 17, PASS_CHANGE = 18,
}

public OnGameModeInit()
{
	ConnectSQL();
	AntiDeAMX();

	new MySQLOpt: option_id = mysql_init_options();
 	new currenttime = GetTickCount();
	new Lua:test = lua_newstate();

	mysql_set_option(option_id, AUTO_RECONNECT, true);
	SetGameModeText(""#SERVER_VERSION""); 
	SendRconCommand("hostname "#SERVER_NAME"");
	SendRconCommand("mapname "#SERVER_MAP"");

	if(lua_loadfile(test, "../../lua/test.lua")) return lua_stackdump(test);
	lua_bind(test);
	lua_stackdump(test);

	printf("OnGameModeInit загрузился за %i ms", GetTickCount() - currenttime);
	gettime(timedata[0], timedata[1]);
	// oldhour = timedata[0]; //! установка реального времени | p.s. закоммал с целью убрать ворн (надо заюзать)

	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0); 

	//? timers
	SetTimer("AFKSystemUpdates", 1000, true); 
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
	SetTimerEx("@_mysqlPlayerAccountGet", 1000, 0, "i", playerid); //! временно отключено

	GetPlayerName(playerid, PlayerInfo[playerid][pNames], MAX_PLAYER_NAME);
	GetPlayerIp(playerid, PlayerInfo[playerid][pIP], 16);

	if(IsLoginInvalid(GetName(playerid))) {
		Error(playerid, !"Ваше имя содержит запрещенные символы или цифры. Используйте формат: [Имя_Фамилия]");
		return Kick(playerid);
	}
	SEND_CM(playerid, COLOR_DBLUE, !"Добро пожаловать на "SERVER_NAME"!");
	SEND_CM(playerid, COLOR_WHITE, !"Development build "MODE_VERS"");
	ResetVariables(playerid);
	/*new code = 999 + random(9000);
	format(fstring, sizeof(fstring), "Код для подтверждения: %d", code);
	SendMail(TEST_EMAIL, SERVER_MAIL_ADDRESS, SERVER_NAME, "Код для подтверждения регистрации", fstring);
	printf("22:%s", (SHA256_PassHash("AB00ABF5809A496150A22AF43047C1E3D8CAD4CC2B7336E471953BD9D5AF6FA1", "1wv2d<A^_5")));*/
	return 1;
}

public OnPlayerDisconnect(playerid, reason) {
	if(!playerLoggedStatus{playerid}) return 1; 
	else SavePlayer(playerid);

	PlayerAFK{playerid} 			= -2;
	PlayerBadAttempt{playerid} 		= 0;

	if(inadmcar{playerid} != -1) return DestroyVehicle(inadmcar{playerid}), inadmcar{playerid} = 0;
	return 1;
}

public OnPlayerSpawn(playerid) {
	if(!playerLoggedStatus{playerid}) return Error(playerid, SERVER_CLOSED), Kick(playerid);

	SetPlayerSkin(playerid, pi[playerid][pSkin]);
	SetPlayerScore(playerid, pi[playerid][pLevel]);
	SetPlayerWantedLevel(playerid, pi[playerid][pWantedLevel]);

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

public OnPlayerText(playerid, text[]) {
    if(!playerLoggedStatus{playerid}) return 0;
	
	fstring[0] = 0;
	if(strlen(text) < 64) {
		format(fstring, (20 + (-2+66) + (-2+4) + (-2+66)), "%s [%d] говорит: %s", GetName(playerid), playerid, text);
		ProxDetector(20.00, playerid, fstring, format_white, format_white, format_white, format_white, format_white);
	 	SetPlayerChatBubble(playerid, text, format_white, 20.0, 7500);
		
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) ApplyAnimation(playerid, "PED", "IDLE_chat", 4.1, 0, 1, 1, 1, 1), SetTimerEx("@StopAnimation", 3200, false, "d", playerid);
	} else Warning(playerid, "Слишком длинное сообщение!");
	return 0;
}
public OnPlayerCommandText(playerid, cmdtext[]) return 0;
public OnPlayerCommandReceived(playerid, cmdtext[], params[], flags) {
	if(!playerLoggedStatus{playerid}) return 0;
	return 1;
}
public OnPlayerCommandPerformed(playerid, cmdtext[], success) {
	if (!success || success == -1) 
		Error(playerid, !"{941000}Введена неверная команда. Для справки используйте \"'/help'\"");
	return 1;
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
	if(oldstate == PLAYER_STATE_DRIVER) {
		if(inadmcar{playerid} != -1) {
			DestroyVehicle(inadmcar{playerid});
			inadmcar{playerid} = 0;
		}
	}
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
	PlayerAFK{playerid} = 0;
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

CMD:editplayer(playerid) {
	//! тут проверка на адм и дальнейшая хня
	return 1;
}

CMD:agivelic(playerid, params[]) {
	fADM(ADM_MODER);
	if(sscanf(params, "ii", params[0], params[1])) Info(playerid, !"/agivelic (playerid) (licid)");
	if(CheckConnection(params[0])) return Error(playerid, PLAYER_INVALID);
	if(!(1 <= params[1] <= 5)) return Error(playerid, LICENSE_INVALID);
	if(!strlen(params[0])) return Error(playerid, !"Вы не указали ID игрока");
	if(!strlen(params[1])) return Error(playerid, !"Вы не указали ID лицензии");
	if(!strlen(params[0]) && !strlen(params[1])) return Error(playerid, !"Вы ничего не указали");

	fstring[0] = 0;
	format(fstring, sizeof(fstring), "Вы успешно выдали игроку %s (%d) лицензию (LicID: %d)",GetName(params[0]),params[0],params[1],LicType(params[1]));
	Info(playerid, fstring);

	GiveLic(params[0], params[1]);

	return 1;
}
/*CMD:a(playerid, params[])
{
    if(sscanf(params, "s[150]", params[0])) return Error(playerid, !"/a [текст]");
    return ADMLog("%s[%d]: %s", GetName(playerid), playerid, params[0]);
	return 1;
}*///! ADMMessage нужно доработать, чтобы он мог получать имя игрока и его ид. а так он получает только текст

CMD:giveweap(playerid, params[]) {
	new weaponID, ammoValue;
	fADM(ADM_CHIEF);
	if(sscanf(params, "iii", params[0], weaponID, ammoValue)) Info(playerid, !"/giveweap [playerid] [weaponid] [ammoValue (0-999)]");
	if(!(0 <= (weaponID) <= 46)) return Info(playerid, !"Диапазон weaponID: < 0 либо > 46!");
	if(!(0 <= (ammoValue) <= 999)) return Info(playerid, !"Диапазон ammoValue: < 0 либо > 999!");
	GivePlayerWeapon(params[0], weaponID, ammoValue);
	return 1;
}

CMD:plvh(playerid, params[]) {
	fstring[0] = 0;
	fADM(ADM_OLDER_MODER);
	if(sscanf(params, "dddd", params[0], params[1], params[2], params[3]))  return Info(playerid, !"/plvh [playerid] [vehicleid] [1 color] [2 color]");
	if(!playerLoggedStatus[params[0]]) return Error(playerid, PLAYER_NOT_LOGGED);
	if(GetPlayerInterior(params[0]) != 0) {
		format(fstring,sizeof(fstring), !"Игрок находится в интерьере (%d)", GetPlayerInterior(playerid)),Error(playerid, fstring); 
		fstring[0] = 0;
	}
	if(GetPlayerVirtualWorld(params[0]) != 0)  {
		format(fstring,sizeof(fstring), !"Игрок находится в виртуальном мире (%d)", GetPlayerVirtualWorld(playerid)),Error(playerid, fstring); 
		fstring[0] = 0;
	}
	if(!(400 <= params[1] <= 611)) return Error(playerid, !"Диапазон ID автомобилей: не меньше 400 не больше 611");
	if(!(0 <= params[2] <= 255)) return Error(playerid, !"Диапазон первого цвета: не меньше 0 не больше 255");
	if(!(0 <= params[3] <= 255)) return Error(playerid, !"Диапазон второго цвета: не меньше 0 не больше 255");
	new Float:x,
		Float:y,
		Float:z;
	new Float:Angle;
	GetPlayerPos(params[0], x, y, z);
	GetPlayerFacingAngle(params[0], Angle);
	inadmcar{params[0]} = CreateVehicle(params[1], x, y, z, Angle, params[2], params[3], -1);
	PutPlayerInVehicle(params[0], inadmcar{params[0]}, 0);
	return 1;
}
CMD:makeadmin(playerid, params[]) {
	new playername[24], adm_level;
	fADM(ADM_FOUNDER);
	if(sscanf(params, "s[24]i", playername, adm_level)) Info(playerid, !"Введите: /makeadmin [ник игрока] [степень доступа]");
	else if(CheckExceptionName(playername)) return 0;
	else if(!(ADM_NONE <= adm_level <= ADM_DEPUTY_CHIEF)) Info(playerid, !"Диапазон доступа к системе: не меньше 1 не больше 6");
	query_string[0] = 0;
	mysql_format(db, query_string, sizeof(query_string), "SELECT * FROM `admin` WHERE name = '%e'", playername);
	mysql_tquery(db, query_string , "@MakeAdmin", "isi", playerid, playername, adm_level);
	return true;
}

//? /me /todo /do /try /n /s /b /ame
CMD:me(playerid, params[]) {
	if(sscanf(params, "s[118]", params[0])) Info(playerid, !"/me [действие]");
	if(strlen(params[0]) > 32) Error(playerid, !"Диапазон длины текста: не меньше 0 не больше 32!");
	if(!strlen(params[0])) return Warning(playerid, !"Вы ничего не ввели!");
	fstring[0] = 0;
	format(fstring, sizeof(fstring), "%s %s", PlayerInfo[playerid][pNames], params[0]);
	ProxDetector(20.00, playerid, fstring, 0x00F76193, 0x00F76193, 0x00F76193, 0x00F76193, 0x00F76193);
	SetPlayerChatBubble(playerid, params[0], 0x00F76193, 20, 7500);
	return 1;
}
CMD:ame(playerid, params[]) {
	if(sscanf(params, "s[144]", params[0])) Info(playerid, !"/ame [действие]");
	if(strlen(params[0]) > 32) Error(playerid, !"Диапазон длины текста: не меньше 0 не больше 32!");
	if(!strlen(params[0])) return Warning(playerid, !"Вы ничего не ввели!");
	SetPlayerChatBubble(playerid, params[0], 0x00F76193, 20, 7500);
	return 1;
}
CMD:do(playerid, params[]) {
	if(sscanf(params, "s[116]", params[0])) Info(playerid, !"/do [текст]");
	if(strlen(params[0]) > 32) Error(playerid, !"Диапазон длины текста: не меньше 0 не больше 32!");
	if(!strlen(params[0])) return Warning(playerid, !"Вы ничего не ввели!");
	fstring[0] = 0;
	format(fstring, sizeof(fstring), "%s (%s)", params[0], PlayerInfo[playerid][pNames]);
	ProxDetector(20.00, playerid, fstring, 0x00F76193, 0x00F76193, 0x00F76193, 0x00F76193, 0x00F76193);
	SetPlayerChatBubble(playerid, params[0], 0x00F76193, 20, 7500);
	return 1;
}
CMD:try(playerid, params[]) {
	if(sscanf(params, "s[99]", params[0])) Info(playerid, !"/try [текст]");
	if(strlen(params[0]) > 32) Error(playerid, !"Диапазон длины текста: не меньше 0 не больше 32!");
	if(!strlen(params[0])) return Warning(playerid, !"Вы ничего не ввели!");
	fstring[0] = 0;
	format(fstring, sizeof(fstring), "%s %s | %s", PlayerInfo[playerid][pNames], params[0], (!random(2)) ? ("{FF0000}Неудачно") : ("{32CD32}Удачно"));
	ProxDetector(20.00, playerid, fstring, 0x00F76193, 0x00F76193, 0x00F76193, 0x00F76193, 0x00F76193);
	return 1;
}
CMD:todo(playerid, params[]) {
	if(sscanf(params, "s[95]", params[0])) Info(playerid, !"/todo [текст*действие]");
	if(strlen(params[0]) > 95) Error(playerid, !"Диапазон длины текста: не меньше 0 не больше 95!");
	new message[96];
	strmid(message, params, 0, sizeof(message));
	new Regex:rg_todocheck = Regex_New("^[a-zA-Za-яА-Я.-_,\\s]{2,48}\\*[a-zA-Za-яА-Я.-_,\\s]{2,48}$");
	if(Regex_Check(message, rg_todocheck)) {
		new star = strfind(message, "*");
		new action[50];
		strmid(action, message, star+1, sizeof(message));
		strdel(message, star, sizeof(message));
		fstring[0] = 0;
		format(fstring, sizeof(fstring), "- '%s' - {DE92FF}сказал%s %s, %s", message, (PlayerInfo[playerid][pSex] == 1) ? ("") : ("а"), PlayerInfo[playerid][pNames], action);
		ProxDetector(20.00, playerid, fstring, format_white, format_white, format_white, format_white, format_white);
	} else return Error(playerid, !"Текст должен состоять из кириллицы и не содержать другие символы.");
	return 1;
}
CMD:s(playerid, params[]) {
	if(sscanf(params, "s[105]", params[0])) Info(playerid, !"/s [текст]");
	if(!(0 <= strlen(params[0]) <= 105)) return Warning(playerid, !"Диапазон длины текста: не меньше 0 не больше 105");
	if(!strlen(params[0])) return Warning(playerid, !"Вы ничего не ввели!");
	fstring[0] = 0;
	format(fstring, sizeof(fstring), "%s [%d] крикнул%s: %s", PlayerInfo[playerid][pNames], playerid, (PlayerInfo[playerid][pSex] == 1) ? ("") : ("а"), params[0]);
	ProxDetector(20.00, playerid, fstring, 0xCCCC99FF, 0xCCCC99FF, 0xCCCC99FF, 0xCCCC99FF, 0xCCCC99FF);
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) ApplyAnimation(playerid, "ON_LOOKERS", "shout_01", 4.1,0,0,0,0,0);
	SetPlayerChatBubble(playerid, params[0], format_white, 25, 7500);
	return 1;
}
CMD:menu(playerid) {
	fstring[0] = 0;
	gettime(timedata[0], timedata[1]);
	format(fstring, sizeof(fstring), "{0093ff} Игровое меню | Точное время: %02d.%02d", timedata[0], timedata[1]);
	ShowPlayerDialog(playerid, dMM, DIALOG_L, fstring, "{B03131}[1]{FFFFFF} Действие персонажа\n\
		{B03131}[2]{FFFFFF} Навыки персонажа\n\
		{B03131}[3]{FFFFFF} Связь с администрацией\n\
		{B03131}[4]{FFFFFF} Помощь по серверу\n\
		{B03131}[5]{FFFFFF} Настройки персонажа\n\
		{B03131}[6]{FFFFFF} Телефон\n\
		{B03131}[7]{FFFFFF} История ников\n\
		{B03131}[8]{FFFFFF} История наказаний\n\
		{B03131}[9]{FFFFFF} Промокод: {0093FF}\n\
		{B03131}[10]{FFFFFF} Система промокодов", "Выбор","Отмена");
	return 1;
}
CMD:mn(playerid) return cmd_menu(playerid);
CMD:mm(playerid) return cmd_menu(playerid);

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case dReg1: 
		{
			if(response) {
				if(!strlen(inputtext)) return Error(playerid, !"Вы ничего не ввели."), ShowRegDialog(playerid);
				if(!(6 <= strlen(inputtext) <= 22)) return Warning(playerid, !"Диапазон длины пароля: от 6 до 22 символов."), ShowRegDialog(playerid);
				new Regex:rg_passwordcheck = Regex_New("^[a-zA-Z0-9]{1,}$");

				if(Regex_Check(inputtext, rg_passwordcheck)){ 
					new salt[11];
					for(new i = 11; i--; ) salt[i] = random(79) + 47;
                	salt[10] = 0;
					SHA256_PassHash(inputtext, salt, PlayerInfo[playerid][pPassword], 65);
					// printf("salt::%s;pass:%s", salt, PlayerInfo[playerid][pPassword]);
					strmid(PlayerInfo[playerid][pSalt], salt, 0, 11, 11);
					fstring[0] = 0;
					format(fstring, sizeof(fstring), "{FFFFFF}Введите Ваш {FFA500}e-mail{FFFFFF} адрес, за которым будет закреплён данный аккаунт.\nЕсли Вы потеряете доступ к своему аккаунту, то с помощью {FFA500}e-mail{FFFFFF} Вы сможете восстановить его.");
					SHOW_PD(playerid, dReg2, DIALOG_I, !"{FFFFFF}[2/4]{FFA500} Почта", fstring, !"Далее", !"Отмена");	
				} else {
					ShowRegDialog(playerid), Error(playerid, !"Пароль может состоять только из чисел и латинских символов любого регистра.");
				}
				Regex_Delete(rg_passwordcheck);
			} else {
				Error(playerid, SERVER_CLOSED);
				return Kick(playerid);
			}
		}
		case dReg2:
		{
			if(!response){
				Error(playerid, SERVER_CLOSED);
				return Kick(playerid);
			}
			else {
				if(!IsValidEmail(inputtext)) {
					Error(playerid, !"Неверный тип электронной почты. Примеры: [@gmail.com, @yandex.ru, @mail.ru, @vk.ru]");
					SHOW_PD(playerid, dReg2, DIALOG_I, !"{FFFFFF}[2/4]{FFA500} Почта", fstring, !"Далее", !"Отмена");	
				}
				if(!strlen(inputtext)) {
					Error(playerid, !"Вы не указали почту.");
					SHOW_PD(playerid, dReg2, DIALOG_I, !"{FFFFFF}[2/4]{FFA500} Почта", fstring, !"Далее", !"Отмена");	
				}
				else if(IsValidEmail(inputtext) && strlen(inputtext)) {
					strmid(PlayerInfo[playerid][pEmail],inputtext,0,strlen(inputtext), 32);
					SHOW_PD(playerid, dReg3, DIALOG_L, !"{FFFFFF}[3/4]{FFA500} Пол","{FFA500}1.{FFFFFF} Мужской\n{FFA500}2.{FFFFFF} women", !"Выбрать", !"Отмена");
				}
			}
		}
		case dReg3: 
		{
			if(!response) {
				Error(playerid, SERVER_CLOSED);
				return Kick(playerid);
			}
			else {
				switch listitem do {
					case 0: PlayerInfo[playerid][pSex] = 1; // 1 - мужской
					case 1: PlayerInfo[playerid][pSex] = 2; // 2 - женский
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
					mysql_format(db, query_string, (68 + (-2+64) + (-2+65)), "SELECT * FROM `accounts` WHERE `names` = '%e' AND `password` = '%e'", GetName(playerid), PlayerInfo[playerid][pPassword]);
					mysql_tquery(db, query_string, "LoginPlayer", "d", playerid);
				} else @_IncorrectPassword(playerid);
			}
		}
		case dMM: {
			if(response) {
				switch listitem do {
					case 0: ShowStats(playerid);
					case 1: return 1;
					case 2: return 1;
					case 3: return 1;
					case 4: ShowUpdateSettings(playerid);
				}
			}
		}
		case d_PLAYER_SETTINGS: { //! нужно закончить
			if(response) {
				switch listitem do {
					case 0: {
						PlayerInfo[playerid][pShowName] = !PlayerInfo[playerid][pShowName];
						foreach(new i: Player) ShowPlayerNameTagForPlayer(playerid, i, PlayerInfo[playerid][pShowName]);
					} 
					case 1: return Warning(playerid, "В разработке");
					case 2: {
						if(PlayerInfo[playerid][pGugleEnabled] == 1) {
							SHOW_PD(playerid, PASS_CHANGE, DIALOG_STYLE_INPUT, "Google Authenticator", 
							"\n\n{FFFFFF}К этому аккаунту подключено подтверждение {F1FC4C}Google Authenticator.\n\
							{FFFFFF}Введите код подтверждения для входа в игру.\n\n{FC4C4C}Если вы потеряли телефон/удалили приложение или потеряли\n\
							идентификационный код, то при условии того что у вас\nправильно привязана почта, вы можете\n\
							отключить Google Authenticator на сайте:\n\n{FFFFFF}"SERVER_WEBSITE"/profile/in\n", !"Принять", !"Отмена");
						}
					}
					case 3: return Warning(playerid, "В разработке");
					case 4: return Warning(playerid, "В разработке");
					case 5: return Warning(playerid, "В разработке");
					case 6: return Warning(playerid, "В разработке");
					case 7: {
						if(PlayerInfo[playerid][pLevel] < 2) return Error(playerid, " Установить Google Authenticator могут только игроки старше первого уровня!");
						fstring[0] = 0;
						format(fstring, sizeof(fstring), "Настройки Google Authenticator\nОтключение Google Authenticator");
						SHOW_PD(playerid, Gugle, DIALOG_STYLE_LIST, !"{0093ff}Google Authenticator", fstring, !"Выбрать", "Назад");
					}
				}
			}
		}
		case PASS_CHANGE: {
			if(response) {
				new getcode = GoogleAuthenticatorCode(PlayerInfo[playerid][pGugleAuth], gettime());
				if(strval(inputtext) == getcode && !isempty(inputtext)) {
					
				}
			}
		}
		//![===========================================[GUGLE AUTHENTICATOR by ICBRK[ICEtheBreaker]]===========================================]
		case Gugle: {			
			if(response) {
				switch listitem do {
					case 0: {
						fstring[0] = 0;
						new fstring2[256];
						format(fstring, sizeof(fstring), "Состояние Google Authenticator\t\t| %s", (PlayerInfo[playerid][pGugleEnabled] == 0) ? ("{F04245}[Неактивен]") : ("{8FC248}[Функционирует]"));
						format(fstring2, sizeof(fstring2), 
						"Установить Google Authenticator\n\
						Спрашивать Google Authenticator\t\t| %s", 
						(PlayerInfo[playerid][pGugleSettings] == 0) ? ("{0093ff}[При смене IP]") : ("{0089ff}[Всегда]"));
						SHOW_PD(playerid, Gugle_Settings, DIALOG_STYLE_LIST, fstring, fstring2, !"Выбрать", !"Назад");
						fstring2[0] = 0;
					}
					case 1: {
						if(PlayerInfo[playerid][pGugleEnabled] == 0) Error(playerid, !"На данном аккаунте не установлен Google Authenticator!");
						else SHOW_PD(playerid, Gugle_Delete, DIALOG_STYLE_INPUT, !"Подтверждение Google Authenticator", !"\n{FFFFFF}Для подтверждения, введите сгенерированный код из приложения в поле ниже:", "Ввод", "Отмена");
					}
				}
			} 
			else {
				cmd::menu(playerid);
			}
		}
		case Gugle_Delete: {
			if(response) {
				new getcode = GoogleAuthenticatorCode(pi[playerid][pGugleAuth], gettime());
				if(isempty(inputtext)) 
					return false;
				else if(strval(inputtext) == getcode) {
					SHOW_PD(playerid, Gugle_Confirm, DIALOG_STYLE_MSGBOX, !"Подтверждение", "\nВы уверены, что хотите отключить Google Authenticator от своего аккаунта?\nРекомендуем оставить его, чтобы избежать дальнейших взломов.", "Да", "Нет");
				}
				else {
					Error(playerid, !"Код введён неверно!");
					SHOW_PD(playerid, Gugle_Delete, DIALOG_STYLE_INPUT, !"Подтверждение Google Authenticator", !"\n{FFFFFF}Для подтверждения, введите сгенерированный код из приложения в поле ниже:", "Ввод", "Отмена");
				}
			}
			else {
				fstring[0] = 0;
				format(fstring, sizeof(fstring), "Настройки Google Authenticator\nОтключение Google Authenticator");
				SHOW_PD(playerid, Gugle, DIALOG_STYLE_LIST, !"{0093ff}Google Authenticator", fstring, !"Выбрать", "Назад");
			}
		}
		case Gugle_Confirm: {
			if(response) {
				PlayerInfo[playerid][pGugleEnabled] = 0;
				PlayerInfo[playerid][pGugleAuth] = 0;
				Notification(playerid, !"Вы успешно отключили Google Authenticator.");
				mysql_format(db, query_string, sizeof(query_string), "UPDATE `accounts` SET `gugle_auth`, `gugle_enabled` = '%s', '%d' WHERE `names` = '%s'", 
				PlayerInfo[playerid][pGugleAuth], PlayerInfo[playerid][pGugleEnabled], PlayerInfo[playerid][pNames]);
				mysql_tquery(db, query_string);
			}
			else cmd::menu(playerid); 
		}
		case Gugle_Settings: {
			if(response) {
				switch listitem do {
					case 0: {
						if(PlayerInfo[playerid][pGugleEnabled] == 1) Error(playerid, !"Google Authenticator уже установлен на аккаунте. Действие не требуется");
						else {
							SHOW_PD(playerid, GugleInfo, DIALOG_STYLE_MSGBOX, !"1-вый шаг", !"\n\n{FFFFFF}Начнем с того, что если у вас нет приложения, то его нужно\nзагрузить. Заходим в {FDC459}Play Market или App Store{FFFFFF} и ищем\nGoogle Authenticator.\n\n{B0FD59}Нашли? Нажимаем загрузить приложение.\n\nНажмите: 'Enter', чтобы пройти к следующему этапу.\n\n", !"Дальше", !"Отмена");
						}
					}
					case 1: {
						if(PlayerInfo[playerid][pGugleSettings] == 0) {
							PlayerInfo[playerid][pGugleSettings] = 1;
							Notification(playerid, !"Код Google Auth теперь будет запрашиваться при каждом входе в игру.");
						} else {
							PlayerInfo[playerid][pGugleSettings] = 0;
							Notification(playerid, !"Код Google Auth теперь будет запрашиваться при смене Вашего IP-адреса.");
						}
					}
				}
			}
			else {
				fstring[0] = 0;
				format(fstring, sizeof(fstring), "Настройки Google Authenticator\nОтключение Google Authenticator");
				SHOW_PD(playerid, Gugle, DIALOG_STYLE_LIST, !"{0093ff}Google Authenticator", fstring, !"Выбрать", !"Назад");
			}
		}
		case GugleInfo: {
			if(response) SHOW_PD(playerid, GugleInfo2, DIALOG_STYLE_MSGBOX, !"2-ой шаг", !"\n\n{FFFFFF}Отлично! Вы загрузили приложение, теперь давайте его запустим.\nОтыщите{FDC459}+{FFFFFF} в приложении, а затем нажмите на него.\n\n{B0FD59}Нажмите: 'Enter', чтобы пройти к следующему этапу.\n\n", !"Дальше", !"Отмена");
		}
		case GugleInfo2: {
			if(response) {
				fstring[0] = 0;
				PlayerInfo[playerid][pGugleAuth] = 0;
				for(new i; i < 16; i++) {
					PlayerInfo[playerid][pGugleAuth][i] = random(25) + 65;
					//strcat(PlayerInfo[playerid][pGugleAuth], AuthSymbols[random(sizeof(symbols))]);
				}
				format(fstring, sizeof(fstring), 
				"{FFFFFF}Если на Вашем телефоне стоит ОС Android, то выберите \"Ввести ключ\"\n\
				Если на Вашем телефоне стоит IOS, то выберите \"Ввод вручную\"\n\n\
				В поле \"Аккаунт\" введите: {0093ff}%s@rppaurora\n\
				{FFFFFF}В поле \"Ключ\" введите: {0093ff}%s\n\n\
				{FFFFFF}Часовой пояс, установленный на телефоне, должен совпадать тому, что установлен на сервере ", 
				PlayerInfo[playerid][pNames], PlayerInfo[playerid][pGugleAuth]);
				SHOW_PD(playerid, GugleInfo3, DIALOG_STYLE_MSGBOX, !"3-тий шаг", fstring, !"Дальше", !"Отмена");
			}
		}
		case GugleInfo3: {
			if(response) {
				fstring[0] = 0;
				format(fstring, sizeof(fstring), 
				"{FFFFFF}Для завершения установки Google Authenticator, введите сгенерированный код из приложения\n\
				в поле ниже:");
				SHOW_PD(playerid, GugleInfo4, DIALOG_STYLE_INPUT, !"Финальный шаг", fstring, !"Дальше", !"Отмена");
			}
		}
		case GugleInfo4: {
			if(response) {
				new getcode = GoogleAuthenticatorCode(PlayerInfo[playerid][pGugleAuth], gettime());
				if(strval(inputtext) == getcode) { 
					SHOW_PD(playerid, GugleInfo5, DIALOG_STYLE_MSGBOX, !"Успех", !"{FFFFFF}Вы успешно подключили Google Authenticator к своему аккаунту.\nТеперь Вы можете выбрать, когда будет запрашиваться Auth-код.", "Выход", "");
					PlayerInfo[playerid][pGugleEnabled] = 1;
					mysql_format(db, query_string, sizeof(query_string), "UPDATE `accounts` SET `gugle_auth` = '%e', `gugle_enabled` = '%d' WHERE `names` = '%e'", 
					PlayerInfo[playerid][pGugleAuth], PlayerInfo[playerid][pGugleEnabled], PlayerInfo[playerid][pNames]);
					mysql_tquery(db, query_string);
				}
				else {
					Error(playerid, !"Код введён неверно!");
					fstring[0] = 0;
					format(fstring, sizeof(fstring), 
					"{FFFFFF}Для завершения установки Google Authenticator, введите сгенерированный код из приложения\n\
					в поле ниже:");
					SHOW_PD(playerid, GugleInfo4, DIALOG_STYLE_INPUT, !"Финальный шаг", fstring, !"Дальше", !"Отмена");
				}
			}
			else {
				PlayerInfo[playerid][pGugleAuth] = 0;
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
	query_string[0] = 0;
	// print("yesss");
	mysql_format(db, query_string, sizeof query_string, "SELECT `password`, `salt`, `lastIP`, `gugle_auth`, `gugle_settings`, `gugle_enabled` FROM `accounts` WHERE `names` = '%e'", GetName(playerid));
	mysql_tquery(db, query_string, "@_mysqlGetPlayerAccount", "i", playerid);
}

@_mysqlGetPlayerAccount(playerid);
@_mysqlGetPlayerAccount(playerid) {
	SetPlayerColor(playerid, 0xFF);

	if(cache_num_rows() != 0) {
		
		cache_get_value_name(0, "password", PlayerInfo[playerid][pPassword], 65);
		cache_get_value_name(0, "salt", PlayerInfo[playerid][pSalt], 11);
		cache_get_value_name(0, "lastIP", PlayerInfo[playerid][pLastIP], 16);
		cache_get_value_name(0, "gugle_auth", PlayerInfo[playerid][pGugleAuth], 17);
		cache_get_value_name_int(0, "gugle_settings", PlayerInfo[playerid][pGugleSettings]);
		cache_get_value_name_int(0, "gugle_enabled", PlayerInfo[playerid][pGugleEnabled]);
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
		PlayerBadAttempt{playerid} --;
		format(ssstring, (92 + (-2+4)),"\
			{FF0000}Вы ввели неверный пароль!\n\
			{FFFFFF}Попыток для ввода пароля:{0f4900} %d", PlayerBadAttempt{playerid});

		SHOW_PD(playerid, d_Log, DIALOG_P, "{FFA500}Авторизация", ssstring, "Войти", "Отмена");
		ssstring[0] = 0;
	} else {LoginPlayer(playerid);}

	if(++PlayerBadAttempt{playerid} <= 0) {
		Error(playerid, SERVER_CLOSED);
		PlayerBadAttempt{playerid} = 0;
		return Kick(playerid);
	}

	return 1; 
}

stock ShowLoginDialog(playerid)
{
	fstring[0] = 0;
	PlayerBadAttempt{playerid} --;
	format(fstring, (142 + (-2+4)),"\
		{FFFFFF}Добро пожаловать на {daa44a}"SERVER_NAME"\n\n\
		{FFFFFF}Введите свой пароль\n\
		{FFFFFF}Попыток для ввода пароля:{0f4900} %d", PlayerBadAttempt{playerid});
	SHOW_PD(playerid, d_Log, DIALOG_P, "{FFA500}Авторизация", fstring, "Войти", "Отмена");
	
	return 1;	
}
stock GetCurrentTime() //! написать систему определения часового пояса сервера и часового пояса игрока
{
	return 1;
}

stock ShowRegDialog(playerid)
{
	fstring[0] = 0;
	format(fstring, (420 + (-2+66)),"{FFFFFF}Здравствуйте, {0093ff}%s\n\n\
		{FFFFFF}Данный аккаунт {FFA500}отсутствует{FFFFFF} в базе данных.\n\
		Для продолжения, введите пароль в поле ниже.\n\
		Он будет необходим для дальнейшей авторизации на сервере.\n\n\
		\t\t{FFFFFF}Примечание для ввода пароля:\n\
		\t\t- {FFA500}Пароль должен состоять из латиницы и не содержать цифры\n\
		\t\t- {FFA500}Пароль не должен быть меньше 6 и больше 22 символов.", pi[playerid][pNames]);
	SHOW_PD(playerid, dReg1, DIALOG_P, !"{FFFFFF}[1/4]{FFA500} Пароль", fstring, !"Далее",!"Отмена");	
	return 1;
}
stock ShowUpdateSettings(playerid, vkontakte[] = " ") {
	fstring[0] = EOS;
	//! в связи с добавлением измеений в эту строку лучше оставить sizeof, чтоб в дальнейшем не заниматься подсчётом
	format(fstring, sizeof(fstring), "Система\tСостояние\n\
	{AFAFAF}Ники:\t%s\n\
	{AFAFAF}E-mail:\t%s\n\
	{AFAFAF}Сменить пароль\t{0093ff}[ Аккаунт ]\n\
	{AFAFAF}Сменить пароль\t{0093ff}[ Банковская карта ]\n\
	{AFAFAF}Показывать голод:\t%s\n\
	{AFAFAF}Изменить\t{0093ff}[ Место спавна ]\n\
	{AFAFAF}Отмена показа документов:\t%s\n\
	{AFAFAF}Google Authenticator\t{0093ff}Анти-взлом система\n\
	{AFAFAF}Вход через почту:\t%s\n\
	{AFAFAF}Язык инвентаря / интерфейса:\t{0093ff} [ %s ]\n\
	{AFAFAF}Привязка ВКонтакте:\t%s",
	PlayerInfo[playerid][pShowName] ? ("{008000}[ВКЛ]") : ("{FF0000}[ВЫКЛ]"),
	PlayerInfo[playerid][pEmail],
	!PlayerInfo[playerid][pHungryBar] ? ("{9ACD32}[ВКЛ]") : ("{B83434}[ВЫКЛ]"),
	PlayerInfo[playerid][pShowDocuments] ? ("{9ACD32}[ВКЛ]") : ("{FF0000}[ВЫКЛ]"),
	PlayerInfo[playerid][pEmailAuth] ? ("{9ACD32}[ВКЛ]") : ("{B83434}[ВЫКЛ]"),
	PlayerInfo[playerid][pLanguage] ? ("русский") : ("английский"),
	strlen(vkontakte) > 2 ? vkontakte: ("{B83434}Не привязан"));
	
	//if(PlayerInfo[playerid][pVkontakte]) && strlen(vkontakte) < 2 return GetVKName(playerid);
	return SHOW_PD(playerid, d_PLAYER_SETTINGS, DIALOG_STYLE_TABLIST_HEADERS, !"Настройки персонажа", fstring, !"Выбор", "Отмена");
}

stock ResetVariables(playerid) {
	PlayerAFK{playerid} 			=
	pi[playerid][pAdmin] 			= 
	pi[playerid][pLevel] 			=
	pi[playerid][pShowDocuments] 	=
	pi[playerid][pPassport] 		=
	pi[playerid][pSex] 				=
	pi[playerid][pSkin]				=
	pi[playerid][pMoney] 			=
	pi[playerid][pHungryBar] 		=
	pi[playerid][pWantedLevel]		=
	pi[playerid][pEmailConfirmed] 	= 0;
	PlayerBadAttempt{playerid} 		= 4;
	inadmcar{playerid}				= -1;

	printf("%d (%s) id освободил данные | thank you friend! you are gay!", playerid, GetName(playerid));

	for(new i = 5; --i > 0;) {
    	pi[playerid][pDriveLic][i] = 0;
	}

	strmid(pi[playerid][pNames], "None", 0, 5, 24);
	strmid(pi[playerid][pPassword], "", 0, strlen(pi[playerid][pPassword]), 32);
	strmid(pi[playerid][pEmail], "", 0, strlen(pi[playerid][pEmail]), 32);

	return 1;
}
stock LicType(id) {
	new type[16];
	switch(id) {
		case 1: {type="Авто";}
		case 2: {type="Судоходство";}
		case 3: {type="Грузовое";}
		case 4: {type="Оружие";}
		case 5: {type="Бизнес";}
		default: {type="None";}
	}
	return type;
}
stock GiveLic(playerid,id) {
	if (IsLicenseValid(id)) return 1;

	pi[playerid][pDriveLic][id] = 1;

	fstring[0] = 0;
	query_string[0] = 0;

	format(fstring, sizeof(fstring),"%i,%i,%i,%i,%i", pi[playerid][pDriveLic][0], pi[playerid][pDriveLic][1], pi[playerid][pDriveLic][2], pi[playerid][pDriveLic][3], pi[playerid][pDriveLic][4]);
	mysql_format(db, query_string, sizeof(query_string),"UPDATE `accounts` SET `licenses`='%s' WHERE `names`='%e'",fstring,GetName(playerid));
	mysql_tquery(db, query_string, "", "");

	printf("%s(%d) успешно получил права с licid %d и с типом %s", GetName(playerid), playerid, id, LicType(id));

	return 1;
}
stock CreateAccount(playerid)
{
	fstring[0] =
	query_string[0] = 0;

	PlayerInfo[playerid][pMoney]	 		= BONUS_MONEY;
	PlayerInfo[playerid][pLevel] 			= START_LEVEL;
	PlayerInfo[playerid][pSkin] 	 		= DEFAULT_SKIN;
	PlayerInfo[playerid][pWantedLevel] 		= 0;

	new Year, Month, Day;
	getdate(Year, Month, Day);
	new date[13];
	format(date, (13 + (-2+4) + (-2+4) + (-2+6)), "%02d.%02d.%d", Day, Month, Year);

	mysql_format(db, query_string, (217 + (-2+66) + (-2+67) + (-2+13) + (-2+18) + (-2+15) + (-2+16) + (-2+32) + (-2+4) + (-2+4) + (-2+4) + (-2+6) + (-2+6) + (-2+6) + (-2+6)), "INSERT INTO `accounts` (`names`, `password`, `salt`, `regIP`, `regData`, `lastIP`, `email`,`sex`,`admin`, `currentskin`, `money`, `level`, `wanted_level`) VALUES ('%e','%e','%e','%e','%e','%e','%e',%d,%d,%d,%d,%d,%d)", GetName(playerid), PlayerInfo[playerid][pPassword], PlayerInfo[playerid][pSalt], PlayerInfo[playerid][pIP], date, PlayerInfo[playerid][pLastIP], PlayerInfo[playerid][pEmail], PlayerInfo[playerid][pSex], PlayerInfo[playerid][pAdmin], PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pLevel], pi[playerid][pWantedLevel]);
	mysql_tquery(db, query_string, "", "");

	printf("22 (%s) %s", strlen(query_string), query_string);

	playerLoggedStatus{playerid} = true;
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

	cache_get_value_name(0, "licenses", PlayerInfo[playerid][pDriveLics]); // licenses
	sscanf(PlayerInfo[playerid][pDriveLics], "p<,>a<i>[5]",PlayerInfo[playerid][pDriveLics]);

	SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
	GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);

	PlayerInfo[playerid][pLastIP] = GetPlayerIp(playerid, getIP, 16);

	TogglePlayerSpectating(playerid, 0);

	if(PlayerInfo[playerid][pAdmin] > 0) return Iter_Add(ADM_LIST, playerid);
	// SavePlayer(playerid);

	playerLoggedStatus{playerid} = true;
	SpawnPlayer(playerid);

	return 1;
}
stock ShowStats(playerid) {
	fstring[0] = 0;

	format(fstring, sizeof(fstring), "Система\tИнфо\n\
	{AFAFAF}Ваш ID:\t {0093ff}%d\n\
	{AFAFAF}Ваш игровой псевдоним:\t {0093ff}%s\n\
	{AFAFAF}Ваша почта:\t {0093ff}%s\n\
	{AFAFAF}Уровень розыска:\t {0093ff}%d\n\
	{AFAFAF}Паспорт:\t [ {0093ff}%s ]\n\
	{AFAFAF}Вод. удостоверение:\t [ {0093ff}%s, тип: %s{ffffff} ]",
		playerid, //! pi[playerid][pID] это ид ячейки в базе
		pi[playerid][pNames],
		pi[playerid][pEmail],
		pi[playerid][pWantedLevel],
		pi[playerid][pPassport] ? ("{9ACD32}[есть]") : ("{B83434}[нет]"),
		pi[playerid][pDriveLic] ? ("{9ACD32}[есть]") : ("{B83434}[нет]"),
		pi[playerid][pDriveLics]
	);

	return SHOW_PD(playerid, dNull, DIALOG_STYLE_TABLIST_HEADERS, !"Статистика игрока", fstring, !"Выбор", "Отмена");
}

stock SavePlayer(playerid) {
	if(!playerLoggedStatus{playerid}) return 0;

	format(pi[playerid][pDriveLics],20,"%i,%i,%i,%i,%i", pi[playerid][pDriveLic][0], pi[playerid][pDriveLic][1], pi[playerid][pDriveLic][2], pi[playerid][pDriveLic][3], pi[playerid][pDriveLic][4]);

	query_string[0] = EOS;
	mysql_format(db, query_string, (192 + (-2+18) + (-2+34) + (-2+4) + (-2+6) + (-2+4) + (-2+6) + (-2+4) + (-2+4)), "UPDATE `accounts` SET `lastIP` = '%e', `email` = '%e', `sex` = %d, `admin` = %d, `currentskin` = %d, `money` = %d, `level` = %d, `wanted_level` = %d, `licenses` = '%s', `email_confirmed` = %d", PlayerInfo[playerid][pLastIP], PlayerInfo[playerid][pEmail], PlayerInfo[playerid][pSex], PlayerInfo[playerid][pAdmin], PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pLevel], PlayerInfo[playerid][pWantedLevel], PlayerInfo[playerid][pDriveLics], PlayerInfo[playerid][pEmailConfirmed]);
	mysql_tquery(db, query_string, "", "");

	return 1;
}

@MakeAdmin(playerid, const name[], level);
@MakeAdmin(playerid, const name[], level) {
	if(cache_num_rows() == 0) {
		if(!level) {
			query_string[0] = 0;
			if(GetPlayerID(name) != INVALID_PLAYER_ID) PlayerInfo[GetPlayerID(name)][pAdmin] = 0;
			mysql_format(db, query_string, (41 + (-2+66)), "DELETE FROM `admin` WHERE `names` = '%e'", name);
			mysql_tquery(db, query_string, "", "");
			query_string[0] = EOS;
			mysql_format(db, query_string, (52 + (-2+4) + (-2+66)), "UPDATE `admin` SET `level` = 0 WHERE `names` = '%e'", name);
			mysql_tquery(db, query_string, "", "");
			fstring[0] = 0;
			format(fstring, sizeof(fstring),"Администратор {0093ff}%s больше не имеет доступа к системе.", name);
			Warning(playerid, fstring);
		}
		else {
			if(GetPlayerID(name) !=INVALID_PLAYER_ID) PlayerInfo[GetPlayerID(name)][pAdmin] = level;
			query_string[0] = 0;
			mysql_format(db, query_string, sizeof(query_string), "UPDATE `admin` SET level = %d WHERE names '%e' LIMIT 1", level, name);
			mysql_tquery(db, query_string, "", "");
			mysql_format(db, query_string, sizeof(query_string), "UPDATE `accounts` SET admin = %d WHERE names = '%e'", level, name);
			mysql_tquery(db, query_string, "", "");
			fstring[0] = 0;
			format(fstring, sizeof(fstring), "Администратор {0093ff}%s получил повышение до %i уровня доступа.", name, level);
			Info(playerid, fstring);
		}
	}
	else {
		query_string[0] = 0;
		if(!level) return Error(playerid, !"Указанный игрок не имеет доступа к системе!");
		mysql_format(db, query_string, sizeof(query_string), "INSERT INTO `admin` (name,level,last_connect) VALUES ('%e', %d, CURDATE())", name, level);
		mysql_tquery(db, query_string, "", "");
		mysql_format(db, query_string, sizeof(query_string), "UPDATE `accounts` SET admin = %d WHERE names = '%e'", level, name);
		mysql_tquery(db, query_string, "", "");
		fstring[0] = 0;
		format(fstring, sizeof(fstring),"[Информация ADM]:{0093ff}%s{FFFFFF} теперь имеет доступ к системе и занесён в базу данных. Указанный уровень доступа: %i", name, level);
		Info(playerid, fstring);
		if(GetPlayerID(name) != INVALID_PLAYER_ID) {
			PlayerInfo[GetPlayerID(name)][pAdmin] = level;
			query_string[0] = 0;
			mysql_format(db, query_string, sizeof(query_string), "UPDATE `accounts` SET admin %d WHERE names = '%e'", PlayerInfo[playerid][pAdmin], name);
			mysql_tquery(db, query_string, "", "");
		}
	}
	return 1;
}

stock IsLoginInvalid(const text[]) {
	new playername[24];
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
	else if(CheckExceptionName(playername)) return 0;
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
	#if MYSQL_IS_LOCAL == true 
		db = mysql_connect(LOCAL_SQL_HOSTNAME, LOCAL_SQL_USERNAME, LOCAL_SQL_PASSWORD, LOCAL_SQL_DATABASE);
		mysql_log(ERROR | WARNING); 
	#else
		db = mysql_connect(SQL_HOSTNAME, SQL_USERNAME, SQL_PASSWORD, SQL_DATABASE);
		mysql_log(DEBUG); 
	#endif
	switch(mysql_errno()){
		case 0: print("ПОДКЛЮЧЕНИЕ УСПЕШНО [УРА ТЕПЕРЬ Я СМОГУ ЗАПИСАТЬСЯ К ВРАЧУ]");
	    case 1044: return print("ПОДКЛЮЧЕНИЕ НЕ УСПЕШНО [НЕ НРАВИТСЯ МНЕ ЭТО ИМЯ ДАВАЙ ПО-НОВОЙ МИША]");
	    case 1045: return print("ПОДКЛЮЧЕНИЕ НЕ УСПЕШНО [БЛИН ПАРОЛЬ НЕПРАВИЛЬНЫЙ ТЕПЕРЬ НЕ УКРАДУ ДЕНЬГИ(((]");
	    case 1049: return print("ПОДКЛЮЧЕНИЕ НЕ УСПЕШНО [ЧО ЗА БАЗА ТАМ НЕТУ ПАРОЛЕЙ]");
	    case 2003: return print("ПОДКЛЮЧЕНИЕ НЕ УСПЕШНО [АААА НЕТУ СЕРВЕРА БОЛЬШЕ ЕГО ВЗОРВАЛИ]");
		case 2002: return print("ПОДКЛЮЧЕНИЕ НЕ УСПЕШНО [ВКЛЮЧИ-КА СЕРВЕР А ТО Я ТУДА НЕ ЗАЙДУ]");
	    case 2005: return print("ПОДКЛЮЧЕНИЕ НЕ УСПЕШНО [ЧО ЗА АДРЕС Я ТУДА НЕ ДОЕДУ]");
	    default: return printf("ПОДКЛЮЧЕНИЕ НЕ УСПЕШНО [ААААА ОШИБКА СТОП: %d]", mysql_errno());
	}
	return 1;
}