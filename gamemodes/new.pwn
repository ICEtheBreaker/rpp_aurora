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
AntiDeAMX() {
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
#include "../defines/macroses" 
#if !defined IsValidVehicle
     native IsValidVehicle(vehicleid);
#endif
#include <a_samp>

#if MYSQL_IS_LOCAL == true
	#tryinclude "../defines/sql/local_sql_conn"
	#include <a_mysql>
#else
	#tryinclude "../defines/sql/sql_conn"
	#include <a_mysql>
#endif

//! еще предварительно рассчитать под квестовых персонажей 
//! и позатирать с целью оптимизации нативные макросы (с больших на разумные значения)

#undef MAX_PLAYERS
#define MAX_PLAYERS (6)
#undef MAX_VEHICLES
#define MAX_VEHICLES (1000)


#pragma tabsize 0
#define STREAMER_USAGE 
//#define MAILER_PHP_SCRIPT

#if defined MAILER_PHP_SCRIPT
	#define MAILER_URL "dimamins.beget.tech/mailer.php"
	#define MAILER_MAX_MAIL_SIZE (1024) 
	#include "mailer"
#endif

#if !defined MAX_ADMINS
	#define MAX_ADMINS 15 //! пока 15 будет потом увеличим
#endif

#define MALLOC_MEMORY (32768)
#define YSI_YES_HEAP_MALLOC
#include "YSI_Coding\y_malloc"


//! к фиксу 
// #if defined YSI_YES_HEAP_MALLOC
// 	#define jitter_use
// 	#include "YSI_Coding\y_malloc"
// #endif //! а тут он просто напросто не нужен

// #if defined jitter_use
// 	#if defined YSI_NO_HEAP_MALLOC
// 		#undef jitter_use
// 		#include "YSI_Coding\y_malloc"
// 		#tryinclude "YSI\jit.inc"
// 	#endif
// #endif //! без __no_heap_mal. не работает jitter.inc
// #if defined STREAMER_USAGE 
// 	#tryinclude <streamer> 
// #endif	


//=================================[THIS IS INCLUDES]=================================//

#include <sscanf2>
// #include <foreach>
#include "YSI_Data/y_foreach"
#include "YSI_Coding\y_timers"
#include <fix>
#include <crashdetect> 
#include <dc_cmd>
#include <Pawn.Regex>
#include <TOTP>
#include <YALP>
#include <strlib> //! очень полезная штука

//==========================[DIRECTORY | SYSTEMS | INCLUDES]==========================//

#include "../defines/colors" 
#include "../defines/systems/capture_natives/natives" 
// #include "../../defines/objs/autoLoader" //! начать вскоре работу

// #include "../../defines/systems/autoschool/main"

//===================================[NATIVE CONFIG]==================================//
#define function%0(%1)					forward%0(%1); public%0(%1)
#define pi 								PlayerInfo

// f:%0(									%0[0] = 0,format(%0,sizeof(%0),

#define fADM(%0,%1) 					if(PlayerInfo[%0][pAdmin] < %1) return 1
#define GetName(%0)						pi[%0][pNames]
#define RandomEx(%0,%1) 				(random(%1-%0)+%0)
#define CheckConnection(%0)				(!IsPlayerConnected(%0))				

//! под вынос в инклуд
//! vehicleSystem

// #define FlipVeh(%0)						new Float:A;GetVehicleZAngle(%0,A);SetVehicleZAngle(%0,A);
// new bool:nitroHype[MAX_PLAYERS];
// new bool:autoRepairCar[MAX_PLAYERS];

//! еще вынести команду к нему с перехватами _als_


//! под вынос отдельно
#define MIN_LIC_COUNT					(1)
#define MAX_LIC_COUNT					(5)
#define IsLicenseValid(%0)				(!(MIN_LIC_COUNT <= (%0) <= MAX_LIC_COUNT))
//!

#define IsRangeValid(%0,%1)				(strlen(%0) <= %1)
//! первый параметр %0 - строка, %1 - длина

//===================================[SERVER CONFIG]==================================//
#define SERVER_NAME 					"Aurora RolePlay"
#define SERVER_VERSION 					"Aurora [v."MODE_VERS"]"
#define MODE_VERS						"0.1.2.0 DEV"
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
	printf("");
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
 	printf("");
}


new 
	query_string[800], // mysql string
	fstring[4097]; // format string
	//GlobalTime;
	//AuthSymbols[32][] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "2", "3", "4", "5", "6", "7"};

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
	pShowDocuments, //! соотнести к системе документов
	sdTrade,
	pEmailAuth,
	pGugleAuth[17],
	pGugleSettings,
	pGugleEnabled,

	//!======== [соц. сети] ======
	pVkontakte,
	pDiscord,
	pTelegram,
	//!===========================

	pLanguage,
	pWantedLevel,

	pPassport,
	pFIO[64],
	pPassportID,

	 //! проверка есть ли паспорт?
	// система лицензий
	pDrivingCategories[5],
	pDrivingQuery[20],
	pDrivingLic, //! есть ли права?
	//

}
new PlayerInfo[MAX_PLAYERS][pInfo];

//! лучше юзать svar'ы, поскольку pvar'ы не указывают ошибку на введенный текст, а тут не так легко ошибиться используя имя переменной
enum tTemporaryVars {
	tFreezePlayerTime
}
new tTemp[MAX_PLAYERS][tTemporaryVars];

//! вынести в инклуд define/systems/textureLoading

#define freezePlayerOnSpawn(%0);		\
	tTemp[%0][tFreezePlayerTime] = \
		gettime() + (GetPlayerPing(%0) < 101) ? (1) : \
		((GetPlayerPing(%0) > 100 && GetPlayerPing(%0) < 201)) ? (2) : (3)\
	TogglePlayerControllable(%0, false)

//! -- mysql удобства
#include "../defines/systems/capture_natives/mysql_customs"
//! --

/*
	//! что касаемо pDriveCategories:
	1 - права на судоходства
	2 - воздушные
	3 - грузовые
	4 - оружие
	5 - бизнес

	//? pDriveQuery хранит в себе массив 
*/

//! TextDrawsInit к фиксу
#include "../defines/systems/textdraws/TextDrawsInit"	//! здесь выносим все текстдравы в стоки и подгружаем, целью не засорять код
#include "../defines/systems/chat/chatmsg"	//! система чата

//====================================================================================//

//! система паспорта
//! доработать принцип и вынести его в инклуд

enum passport {
	ID,
	FIO[64],
	ID_IN_REGISTER,
	NOMER[8],
	SERIAL[6],
	PROPISKA[64],
	SEX[8],
	IFCHANGEDSEX,
	ISSUED,
	WHOMISSUED,
	DATEOFBIRTHDAY,
	OTHER_DOCUMENTS[4] //! здесь будет массив остальных документов
}
new 
	passport_info[MAX_PLAYERS][passport];

//!

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

//!	=============== [СИСТЕМА АВТО MAIN] =================
#include "../defines/systems/vehicle/main.veh"
//! =====================================================

new inadmcar[MAX_PLAYERS char];
new PlayerBadAttempt[MAX_PLAYERS char];
new PlayerAFK[MAX_PLAYERS];

new 
	time_update,
	time_update_max;

//new oldhour; //? переменная реального времени
new timedata[5]; //? переменные времени и даты

new Iterator:ADM_LIST<MAX_ADMINS>; //! ахуеная вещь слюшай

enum {
	dNull = 0, 
	dLogin = 1, dReg1 = 2, dReg2 = 3, dReg3 = 4, d_Log = 5,
	dMM = 6, dSECURE_SETTINGS = 7, d_PLAYER_SETTINGS = 8,
	Gugle = 9, Gugle_Settings = 10, GugleInfo = 11, 
	GugleInfo2 = 12, GugleInfo3 = 13, GugleInfo4 = 14, GugleInfo5 = 15,
	Gugle_Delete = 16, Gugle_Confirm = 17, PASS_CHANGE = 18, OLD_PASS = 19, NEW_PASS = 20,
}

public OnGameModeInit()
{
	ConnectSQL();
	AntiDeAMX();

	new MySQLOpt: option_id = mysql_init_options();
 	new currenttime = GetTickCount();
	new Lua:test = lua_newstate();

	mysql_set_option(option_id, AUTO_RECONNECT, true); //! опция автореконнектится к серверу в случае потери связи или неправильной работы
	SetGameModeText(""#SERVER_VERSION""); 
	SendRconCommand("hostname "#SERVER_NAME"");
	SendRconCommand("mapname "#SERVER_MAP"");
	Iter_Clear(ADM_LIST);

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

task OnSecond[1000]() {
	// print("работает секундный таймер");
	return 1;
}
ptask OnSecondTimer[1000](playerid) {
	if(tTemp[playerid][tFreezePlayerTime] >= gettime()) {ClearAnimations(playerid),TogglePlayerControllable(playerid,true),tTemp[playerid][tFreezePlayerTime]=0;}
}
task OnMinute[1000*60]() {
	// print("работает минутный таймер");
	return 1;
}
task OnHour[1000*60*60]() {
	// print("работает часовой таймер");
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
		Msg(playerid, ERR, "Ваше имя содержит запрещенные символы или цифры. Используйте формат: [Имя_Фамилия]");
		return Kick(playerid);
	}
	SEND_CM(playerid, COLOR_DBLUE, !"Добро пожаловать на "SERVER_NAME"!");
	/*new code = 999 + random(9000);
	format(fstring, sizeof(fstring), "Код для подтверждения: %d", code);
	SendMail(TEST_EMAIL, SERVER_MAIL_ADDRESS, SERVER_NAME, "Код для подтверждения регистрации", fstring);
	printf("22:%s", (SHA256_PassHash("AB00ABF5809A496150A22AF43047C1E3D8CAD4CC2B7336E471953BD9D5AF6FA1", "1wv2d<A^_5")));*/
	return 1;
}

public OnPlayerDisconnect(playerid, reason) {
	if(!playerLoggedStatus{playerid}) return 1; 
	else SavePlayer(playerid), ResetVariables(playerid);
	if(PlayerInfo[playerid][pAdmin] > 0) Iter_Remove(ADM_LIST, playerid);

	PlayerAFK[playerid] 			= -2;

	if(inadmcar{playerid} != -1) return DestroyVehicle(inadmcar{playerid}), inadmcar{playerid} = 0;
	return 1;
}

public OnPlayerSpawn(playerid) {
	if(!playerLoggedStatus{playerid}) return Msg(playerid, ERR, SERVER_CLOSED), Kick(playerid);

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
    if(!playerLoggedStatus{playerid}) {
		Msg(playerid, ERR, "Для написания сообщений в чате вы должны авторизоваться!");
		return Kick(playerid);
	}

	fstring[0] = 0;
	if(strlen(text) < 64) {
		format(fstring, (20 + (-2+MAX_PLAYER_NAME) + (-2+4) + (-2+MAX_PLAYER_NAME)), "%s [%d] говорит: %s", GetName(playerid), playerid, text);
		ProxDetector(20.00, playerid, fstring, format_white, format_white, format_white, format_white, format_white);
	 	SetPlayerChatBubble(playerid, text, format_white, 20.0, 7500);
		
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) ApplyAnimation(playerid, "PED", "IDLE_chat", 4.1, 0, 1, 1, 1, 1), SetTimerEx("@StopAnimation", 3200, false, "d", playerid);
	} else Msg(playerid, WARN, "Слишком длинное сообщение!");
	return 0;
}
public OnPlayerCommandText(playerid, cmdtext[]) return 0;
public OnPlayerCommandReceived(playerid, cmdtext[], params[], flags) {
	if(!playerLoggedStatus{playerid}) return 0;
	return 1;
}
public OnPlayerCommandPerformed(playerid, cmdtext[], success) {
	if (!success || success == -1) 
		Msg(playerid, ERR, "Введена неверная команда. Для справки используйте \"'/help'\"");
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
	fADM(playerid, ADM_CHIEF);
	if (newkeys || newkeys == 9 || newkeys == 3 && oldkeys != 1 || oldkeys != 9 || oldkeys != 33) 
		if (nitroHype[playerid] && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
			AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);

	return 1;
}
public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

//! допилить, выводится верно но не в точной зависимости от языка в настройках
stock SetLocalization(playerid, type) {
	new 
		language = GetLanguage(playerid);

	new languagesType[][][] = {
		{"Предупреждение", "Warning", "Папярэджанне"},
		{"Ошибка", "Error", "Памылка"},
		{"Информация", "Information", "Інфармацыя"},
		{"Успешно", "Success", "Паспяхова"},
		{"Уведомление", "Notification", "Паведамленне"}
	};

	new text[15] = 0;

	// printf("%d isempty", isempty(text));

	switch(type) {
		case WARN: {
			// printf("%d - длина languages type [0][0], %s - text", strlen(languagesType[0][0]), languagesType[0][0]);
			if (language) strcat(text, languagesType[0][0]); //! Rus
			else if (language == 2) strcat(text, languagesType[0][1]); //! English
			else strcat(text, languagesType[0][2]); //! Belarus

			// printf("%s (УЖЕ ПОЛУЧЕННЫЙ strcat текст)", text);
		}
		case ERR: {
			if (language) strcat(text, languagesType[1][0]); //! Rus
			else if (language == 2) strcat(text, languagesType[1][1]); //! English
			else strcat(text, languagesType[1][2]); //! Belarus

			// printf("%s (УЖЕ ПОЛУЧЕННЫЙ strcat текст)", text);
		}
		case NOTIFICATION: {
			if (language) strcat(text, languagesType[2][0]); //! Rus
			else if (language == 2) strcat(text, languagesType[2][1]); //! English
			else strcat(text, languagesType[2][2]); //! Belarus

			// printf("%s (УЖЕ ПОЛУЧЕННЫЙ strcat текст)", text);
		}
		case SUCCESS: {
			if (language) strcat(text, languagesType[3][0]); //! Rus
			else if (language == 2) strcat(text, languagesType[3][1]); //! English
			else strcat(text, languagesType[3][2]); //! Belarus

			// printf("%s (УЖЕ ПОЛУЧЕННЫЙ strcat текст)", text);
		}
		case INF: {
			if (language) strcat(text, languagesType[4][0]); //! Rus
			else if (language == 2) strcat(text, languagesType[4][1]); //! English
			else strcat(text, languagesType[4][2]); //! Belarus

			// printf("%s (УЖЕ ПОЛУЧЕННЫЙ strcat текст)", text);			
		}
		default: text = "None", (printf("test %s", GetLanguage(playerid)));
	}
	return text;
}


// CMD:testtesttest(player, params[]) {
// 	if(sscanf(params, "s[24]", params[0])) return Msg(player, NOTIFICATION, "/testtesttest [text]");
// 	// if(!(1 <= params[0] <= 24)) return false;
// 	printf("(%s = это тип) : (%s = это текст)", (SetLocalization(player, WARN)), params[0]);
// 	return 1;
// }


public OnPlayerUpdate(playerid) {
	new tc = GetTickCount();
	if(!playerLoggedStatus{playerid}) return false;

	PlayerAFK[playerid] = 0;

	time_update = GetTickCount() - tc;
	if(time_update > time_update_max) time_update_max = time_update;

	return 1;
}
CMD:timestat(playerid) {
	fADM(playerid, ADM_DEPUTY_CHIEF || CheckExceptionName(GetName(playerid)));

	fstring[0] = 0;
	format(fstring, (85 + (-2+6) + (-2+6)),"последние данные "LightGreen_color"`OnPlayerUpdate`"Default": (%d ms). пик: (%d ms).", time_update, time_update_max);
	SHOW_PD(playerid, dNull, DIALOG_M, ""LightGreen_color"Нагрузка на мод", fstring, "Закрыть", "");

	/*
		\nПоследнее время прокрутки \"newkeys\": (%d ms). пик: (%d ms).\nПоследнее время прокрутки \"second_timer\": (%d ms). пик: (%d ms).
		,time_newkeys,time_newkeys_max,time_second,time_second_max
	*/

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

stock EditStatToPlayer() {} //! !!!!
CMD:aeditplayer(playerid) {
	//! тут проверка на адм и дальнейшая хня
	return 1;
}
CMD:agivelic(playerid, params[]) {
	fADM(playerid, ADM_MODER);
	if(sscanf(params, "ii", params[0], params[1])) Msg(playerid, NOTIFICATION, "/agivelic (playerid) (licid)");
	if(CheckConnection(params[0])) return Msg(playerid, ERR, PLAYER_INVALID);
	if(!(1 <= params[1] <= 5)) return Msg(playerid, ERR, LICENSE_INVALID);
	if(!strlen(params[0])) return Msg(playerid, ERR, "Вы не указали ID игрока");
	if(!strlen(params[1])) return Msg(playerid, ERR, "Вы не указали ID лицензии");
	if(!strlen(params[0]) && !strlen(params[1])) return Msg(playerid, ERR, "Вы ничего не указали");

	fstring[0] = 0;
	format(fstring, sizeof(fstring), "Вы успешно выдали игроку %s (%d) лицензию (LicID: %d)",GetName(params[0]),params[0],params[1],LicType(params[1]));
	Msg(playerid, NOTIFICATION, fstring);

	GiveLic(params[0], params[1]);

	return 1;
}
CMD:a(playerid, params[])
{
	fADM(playerid, ADM_HELPER);
    if(sscanf(params, "s[150]", params[0])) return Msg(playerid, ERR, "/a [текст]");
    //ADMMessage("%s[%d]: %s", GetName(playerid), playerid, params[0]);
	return 1;
}

CMD:giveweap(playerid, params[]) {
	new weaponID, ammoValue;
	fADM(playerid, ADM_CHIEF);
	if(sscanf(params, "iii", params[0], weaponID, ammoValue)) Msg(playerid, NOTIFICATION, "/giveweap [playerid] [weaponid] [ammoValue (0-999)]");
	if(!(0 <= (weaponID) <= 46)) return Msg(playerid, NOTIFICATION, "Диапазон weaponID: < 0 либо > 46!");
	if(!(0 <= (ammoValue) <= 999)) return Msg(playerid, NOTIFICATION, "Диапазон ammoValue: < 0 либо > 999!");
	GivePlayerWeapon(params[0], weaponID, ammoValue);
	return 1;
}

CMD:plvh(playerid, params[]) {
	fstring[0] = 0;
	fADM(playerid, ADM_OLDER_MODER);
	if(sscanf(params, "dddd", params[0], params[1], params[2], params[3]))  return Msg(playerid, NOTIFICATION, "/plvh [playerid] [vehicleid] [1 color] [2 color]");
	if(!playerLoggedStatus[params[0]]) return Msg(playerid, ERR, PLAYER_NOT_LOGGED);
	if(GetPlayerInterior(params[0]) != 0) {
		format(fstring,sizeof(fstring), !"Игрок находится в интерьере (%d)", GetPlayerInterior(playerid)),Msg(playerid, ERR, fstring); 
		fstring[0] = 0;
	}
	if(GetPlayerVirtualWorld(params[0]) != 0)  {
		format(fstring,sizeof(fstring), !"Игрок находится в виртуальном мире (%d)", GetPlayerVirtualWorld(playerid)),Msg(playerid, ERR, fstring); 
		fstring[0] = 0;
	}
	if(!(400 <= params[1] <= 611)) return Msg(playerid, ERR, "Диапазон ID автомобилей: не меньше 400 не больше 611");
	if(!(0 <= params[2] <= 255)) return Msg(playerid, ERR, "Диапазон первого цвета: не меньше 0 не больше 255");
	if(!(0 <= params[3] <= 255)) return Msg(playerid, ERR, "Диапазон второго цвета: не меньше 0 не больше 255");
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
	fADM(playerid, ADM_FOUNDER);
	if(sscanf(params, "s[24]i", playername, adm_level)) Msg(playerid, NOTIFICATION, "Введите: /makeadmin [ник игрока] [степень доступа]");
	else if(CheckExceptionName(playername)) return 0;
	else if(!(ADM_NONE <= adm_level <= ADM_DEPUTY_CHIEF)) Msg(playerid, NOTIFICATION, "Диапазон доступа к системе: не меньше 1 не больше 6");
	query_string[0] = 0;
	mysql_format(db, query_string, sizeof(query_string), "SELECT * FROM `admin` WHERE name = '%e'", playername);
	mysql_tquery(db, query_string , "@MakeAdmin", "isi", playerid, playername, adm_level);
	return true;
}

//? /me /todo /do /try /n /s /b /ame
CMD:me(playerid, params[]) {
	if(sscanf(params, "s[118]", params[0])) Msg(playerid, NOTIFICATION, "/me [действие]");
	if(strlen(params[0]) > 32) Msg(playerid, ERR, "Диапазон длины текста: не меньше 0 не больше 32!");
	if(!strlen(params[0])) return Msg(playerid, WARN, "Вы ничего не ввели!");
	fstring[0] = 0;
	format(fstring, sizeof(fstring), "%s %s", PlayerInfo[playerid][pNames], params[0]);
	ProxDetector(20.00, playerid, fstring, 0x00F76193, 0x00F76193, 0x00F76193, 0x00F76193, 0x00F76193);
	SetPlayerChatBubble(playerid, params[0], 0x00F76193, 20, 7500);
	return 1;
}
CMD:ame(playerid, params[]) {
	if(sscanf(params, "s[144]", params[0])) Msg(playerid, NOTIFICATION, "/ame [действие]");
	if(strlen(params[0]) > 32) Msg(playerid, ERR, "Диапазон длины текста: не меньше 0 не больше 32!");
	if(!strlen(params[0])) return Msg(playerid, WARN, "Вы ничего не ввели!");
	SetPlayerChatBubble(playerid, params[0], 0x00F76193, 20, 7500);
	return 1;
}
CMD:do(playerid, params[]) {
	if(sscanf(params, "s[116]", params[0])) Msg(playerid, NOTIFICATION, "/do [текст]");
	if(strlen(params[0]) > 32) Msg(playerid, ERR, "Диапазон длины текста: не меньше 0 не больше 32!");
	if(!strlen(params[0])) return Msg(playerid, WARN, "Вы ничего не ввели!");
	fstring[0] = 0;
	format(fstring, sizeof(fstring), "%s (%s)", params[0], PlayerInfo[playerid][pNames]);
	ProxDetector(20.00, playerid, fstring, 0x00F76193, 0x00F76193, 0x00F76193, 0x00F76193, 0x00F76193);
	SetPlayerChatBubble(playerid, params[0], 0x00F76193, 20, 7500);
	return 1;
}
CMD:try(playerid, params[]) {
	if(sscanf(params, "s[99]", params[0])) Msg(playerid, NOTIFICATION, "/try [текст]");
	if(strlen(params[0]) > 32) Msg(playerid, ERR, "Диапазон длины текста: не меньше 0 не больше 32!");
	if(!strlen(params[0])) return Msg(playerid, WARN, "Вы ничего не ввели!");
	fstring[0] = 0;
	format(fstring, sizeof(fstring), "%s %s | %s", PlayerInfo[playerid][pNames], params[0], (!random(2)) ? ("{FF0000}Неудачно") : ("{32CD32}Удачно"));
	ProxDetector(20.00, playerid, fstring, 0x00F76193, 0x00F76193, 0x00F76193, 0x00F76193, 0x00F76193);
	return 1;
}/*SENDNMSG*/
CMD:todo(playerid, params[]) {
	if(strlen(params) > 95) return Msg(playerid, NOTIFICATION, "Слишком длинный текст и действие.");
	new message[48],
		action[49];
	if(sscanf(params, "p<*>s[47]s[48]", message, action)) return Msg(playerid, NOTIFICATION, "/todo [текст*действие]");
	if(strlen(message) < 2 || strlen(action) < 2) return Msg(playerid, NOTIFICATION, "/todo [текст*действие]");
	fstring[0] = 0;
	format(fstring, sizeof(fstring), "- '%s' - {DE92FF}сказал%s %s, %s", message, (PlayerInfo[playerid][pSex] == 1) ? ("") : ("а"), PlayerInfo[playerid][pNames], action);
	ProxDetector(20.0, playerid, fstring, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE); 
	return 1;
}
CMD:n(playerid, params[]) {
	if(sscanf(params, "s[107]", params[0])) return Msg(playerid, NOTIFICATION, "/n [сообщение]");
	fstring[0] = 0;
	format(fstring, sizeof(fstring), "(( %s[%d]: %s ))", PlayerInfo[playerid][pNames], playerid, params[0]);
	ProxDetector(20.0, playerid, fstring, 0xCCCC99FF, 0xCCCC99FF, 0xCCCC99FF, 0xCCCC99FF, 0xCCCC99FF);
	return 1;
}
CMD:s(playerid, params[]) {
	if(sscanf(params, "s[105]", params[0])) Msg(playerid, NOTIFICATION, "/s [текст]");
	if(!(0 <= strlen(params[0]) <= 105)) return Msg(playerid, WARN, "Диапазон длины текста: не меньше 0 не больше 105");
	if(!strlen(params[0])) return Msg(playerid, WARN, "Вы ничего не ввели!");
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
				if(!strlen(inputtext)) return Msg(playerid, ERR, "Вы ничего не ввели."), ShowRegDialog(playerid);
				if(!(6 <= strlen(inputtext) <= 22)) return Msg(playerid, WARN, "Диапазон длины пароля: от 6 до 22 символов."), ShowRegDialog(playerid);
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
					ShowRegDialog(playerid), Msg(playerid, ERR, "Пароль может состоять только из чисел и латинских символов любого регистра.");
				}
				Regex_Delete(rg_passwordcheck);
			} else {
				Msg(playerid, ERR, SERVER_CLOSED);
				return Kick(playerid);
			}
		}
		case dReg2:
		{
			if(!response){
				Msg(playerid, ERR, SERVER_CLOSED);
				return Kick(playerid);
			}
			else {
				if(!IsValidEmail(inputtext)) {
					Msg(playerid, ERR, "Неверный тип электронной почты. Примеры: [@gmail.com, @yandex.ru, @mail.ru, @vk.ru]");
					SHOW_PD(playerid, dReg2, DIALOG_I, !"{FFFFFF}[2/4]{FFA500} Почта", fstring, !"Далее", !"Отмена");	
				}
				if(!strlen(inputtext)) {
					Msg(playerid, ERR, "Вы не указали почту.");
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
				Msg(playerid, ERR, SERVER_CLOSED);
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
					mysql_format(db, query_string, (68 + (-2+MAX_PLAYER_NAME) + (-2+67)), "SELECT * FROM "T_ACC" WHERE `names` = '%e' AND `password` = '%e'", GetName(playerid), PlayerInfo[playerid][pPassword]);
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
					case 1: return Msg(playerid, WARN, "В разработке");
					case 2: {
						if(PlayerInfo[playerid][pGugleEnabled] == 1) {
							SHOW_PD(playerid, PASS_CHANGE, DIALOG_STYLE_INPUT, "Google Authenticator", 
							"\n\n{FFFFFF}К этому аккаунту подключено подтверждение {F1FC4C}Google Authenticator.\n\
							{FFFFFF}Введите код подтверждения для входа в игру.\n\n{FC4C4C}Если вы потеряли телефон/удалили приложение или потеряли\n\
							идентификационный код, то при условии того что у вас\nправильно привязана почта, вы можете\n\
							отключить Google Authenticator на сайте:\n\n{FFFFFF}"SERVER_WEBSITE"/profile/in\n", !"Принять", !"Отмена");
						}
						else SHOW_PD(playerid, OLD_PASS, DIALOG_STYLE_INPUT, "Подтверждение пароля","\n\n{FFFFFF} Введите ваш текущий пароль в поле ниже:", !"Далее", !"Закрыть");
					}
					case 3: return Msg(playerid, WARN, "В разработке");
					case 4: return Msg(playerid, WARN, "В разработке");
					case 5: return Msg(playerid, WARN, "В разработке");
					case 6: return Msg(playerid, WARN, "В разработке");
					case 7: {
						if(PlayerInfo[playerid][pLevel] < 2) return Msg(playerid, ERR, " Установить Google Authenticator могут только игроки старше первого уровня!");
						fstring[0] = 0;
						format(fstring, sizeof(fstring), "Настройки Google Authenticator\nОтключение Google Authenticator");
						SHOW_PD(playerid, Gugle, DIALOG_STYLE_LIST, !"{0093ff}Google Authenticator", fstring, !"Выбрать", "Назад");
					}
					case 8: return Msg(playerid, NOTIFICATION, "В разработке");
					case 9: SetLanguage(playerid, pi[playerid][pLanguage]),ShowUpdateSettings(playerid);

					case 10: { //! а здесь я думаю лучше диалог какой-нибудь показать чтоб видно было что привязано
						if(!pi[playerid][pVkontakte] && !pi[playerid][pDiscord] && !pi[playerid][pTelegram]) return 0;

						//! здесь уже процесс привязки (API)
					}
				}
			}
			else {
				cmd::menu(playerid);
			}
		}
	  	case PASS_CHANGE: {
			if(response) {
				new getcode = GoogleAuthenticatorCode(PlayerInfo[playerid][pGugleAuth], gettime());
				if(strval(inputtext) == getcode && !isempty(inputtext)) SHOW_PD(playerid, OLD_PASS, DIALOG_STYLE_INPUT, "Подтверждение пароля","\n\n{FFFFFF} Введите ваш текущий пароль в поле ниже:", !"Далее", !"Закрыть");
				else {
					Msg(playerid, NOTIFICATION, "Введён неверный Auth-код");
					return SHOW_PD(playerid, PASS_CHANGE, DIALOG_STYLE_INPUT, "Google Authenticator", 
					"\n\n{FFFFFF}К этому аккаунту подключено подтверждение {F1FC4C}Google Authenticator.\n\
					{FFFFFF}Введите код подтверждения для входа в игру.\n\n{FC4C4C}Если вы потеряли телефон/удалили приложение или потеряли\n\
					идентификационный код, то при условии того что у вас\nправильно привязана почта, вы можете\n\
					отключить Google Authenticator на сайте:\n\n{FFFFFF}"SERVER_WEBSITE"/profile/in\n", !"Принять", !"Отмена");
				}
			}
		}
		case OLD_PASS: {
			new checkpass[65];
			SHA256_PassHash(inputtext, PlayerInfo[playerid][pSalt], checkpass, 65);
			if(!strlen(inputtext)) return SHOW_PD(playerid, OLD_PASS, DIALOG_STYLE_INPUT, "Подтверждение пароля","\n\n{FFFFFF} Введите ваш текущий пароль в поле ниже:", !"Далее", !"Закрыть"); 
			if(!(6 <= strlen(inputtext) <= 22)) Msg(playerid, ERR, "Диапазон длины пароля: от 6 до 22-х символов"), SHOW_PD(playerid, OLD_PASS, DIALOG_STYLE_INPUT, "Подтверждение пароля","\n\n{FFFFFF} Введите ваш текущий пароль в поле ниже:", !"Далее", !"Закрыть"); 
			if(!strcmp(PlayerInfo[playerid][pPassword], checkpass)) SHOW_PD(playerid, NEW_PASS, DIALOG_STYLE_INPUT, "Ввод нового пароля","\n\n{FFFFFF} Введите ваш новый пароль в поле ниже:", !"Далее", !"Закрыть"), Log(playerid, "password correct");
			else Msg(playerid, NOTIFICATION, "Введён неверный пароль."), SHOW_PD(playerid, OLD_PASS, DIALOG_STYLE_INPUT, "Подтверждение пароля","\n\n{FFFFFF} Введите ваш текущий пароль в поле ниже:", !"Далее", !"Закрыть");
		}
		case NEW_PASS: {
			if(!strlen(inputtext)) return Msg(playerid, NOTIFICATION, "Вы ничего не ввели.");
			if(!(6 <= strlen(inputtext) <= 22)) Msg(playerid, NOTIFICATION, "Диапазон длины пароля: от 6 до 22-х символов");
			new Regex:rg_passwordcheck = Regex_New("^[a-zA-Z0-9]{1,}$");
			if(Regex_Check(inputtext, rg_passwordcheck)){ 
				new salt[11];
				for(new i = 11; --i >= 0;) salt[i] = random(79) + 47;
            	salt[10] = 0;
				SHA256_PassHash(inputtext, salt, PlayerInfo[playerid][pPassword], 65);					
				strmid(PlayerInfo[playerid][pSalt], salt, 0, 11, 11);
				fstring[0] = 0;
				format(fstring, sizeof(fstring), "Вы успешно изменили пароль. Новый пароль: {0093ff}%s", inputtext);
				Msg(playerid, NOTIFICATION, fstring);
				Msg(playerid, NOTIFICATION, "Запишите свой новый пароль или сделайте скриншот кнопкой {0093ff}F8");
				@ChangePassword(playerid);
			}
			else return Msg(playerid, NOTIFICATION, "Пароль может состоять только из чисел и латинских символов любого регистра.");
			Regex_Delete(rg_passwordcheck); 
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
						(!PlayerInfo[playerid][pGugleSettings]) ? ("{0093ff}[При смене IP]") : ("{0089ff}[Всегда]"));
						SHOW_PD(playerid, Gugle_Settings, DIALOG_STYLE_LIST, fstring, fstring2, !"Выбрать", !"Назад");
						fstring2[0] = 0;
					}
					case 1: {
						if(!PlayerInfo[playerid][pGugleEnabled]) Msg(playerid, NOTIFICATION, "На данном аккаунте не установлен Google Authenticator!");
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
					Msg(playerid, ERR, "Код введён неверно!");
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
				Msg(playerid, NOTIFICATION, "Вы успешно отключили Google Authenticator.");
				mysql_format(db, query_string, sizeof(query_string), "UPDATE "T_ACC" SET `gugle_auth`, `gugle_enabled` = '%s', '%d' WHERE `names` = '%s'", 
				PlayerInfo[playerid][pGugleAuth], PlayerInfo[playerid][pGugleEnabled], PlayerInfo[playerid][pNames]);
				mysql_tquery(db, query_string);
			}
			else cmd::menu(playerid); 
		}
		case Gugle_Settings: {
			if(response) {
				switch listitem do {
					case 0: {
						if(PlayerInfo[playerid][pGugleEnabled]) Msg(playerid, NOTIFICATION, "Google Authenticator уже установлен на аккаунте. Действие не требуется");
						else {
							SHOW_PD(playerid, GugleInfo, DIALOG_STYLE_MSGBOX, !"1-вый шаг", !"\n\n{FFFFFF}Начнем с того, что если у вас нет приложения, то его нужно\nзагрузить. Заходим в {FDC459}Play Market или App Store{FFFFFF} и ищем\nGoogle Authenticator.\n\n{B0FD59}Нашли? Нажимаем загрузить приложение.\n\nНажмите: 'Enter', чтобы пройти к следующему этапу.\n\n", !"Дальше", !"Отмена");
						}
					}
					case 1: {
						if(!PlayerInfo[playerid][pGugleSettings]) {
							PlayerInfo[playerid][pGugleSettings] = 1;
							Msg(playerid, NOTIFICATION, "Код Google Auth теперь будет запрашиваться при каждом входе в игру.");
						} else {
							PlayerInfo[playerid][pGugleSettings] = 0;
							Msg(playerid, NOTIFICATION, "Код Google Auth теперь будет запрашиваться при смене Вашего IP-адреса.");
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
					mysql_format(db, query_string, sizeof(query_string), "UPDATE "T_ACC" SET `gugle_auth` = '%e', `gugle_enabled` = '%d' WHERE `names` = '%e'", 
					PlayerInfo[playerid][pGugleAuth], PlayerInfo[playerid][pGugleEnabled], PlayerInfo[playerid][pNames]);
					mysql_tquery(db, query_string);
				}
				else {
					Msg(playerid, ERR, "Код введён неверно!");
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
	mysql_format(db, query_string, sizeof query_string, "SELECT `password`, `salt`, `lastIP`, `gugle_auth`, `gugle_settings`, `gugle_enabled` FROM "T_ACC" WHERE `names` = '%e'", GetName(playerid));
	mysql_tquery(db, query_string, "@_mysqlGetPlayerAccount", "i", playerid);
}

@_mysqlGetPlayerAccount(playerid);
@_mysqlGetPlayerAccount(playerid) {
	SetPlayerColor(playerid, 0xFF);

	if(cache_num_rows() != 0) {
		PlayerBadAttempt{playerid} = 4;
		cache_get_value_name(0, "password", PlayerInfo[playerid][pPassword], 65);
		cache_get_value_name(0, "salt", PlayerInfo[playerid][pSalt], 11);
		cache_get_value_name(0, "lastIP", PlayerInfo[playerid][pLastIP], 16);
		cache_get_value_name(0, "gugle_auth", PlayerInfo[playerid][pGugleAuth], 17);
		cache_get_value_name_int(0, "gugle_settings", PlayerInfo[playerid][pGugleSettings]);
		cache_get_value_name_int(0, "gugle_enabled", PlayerInfo[playerid][pGugleEnabled]);
		ShowLoginDialog(playerid);
	}
	else {
		printf("isrpnick = %d ; nick = %s", IsRPNick(GetName(playerid)), GetName(playerid));
		
		if(!IsRPNick(GetName(playerid))) {
		    SHOW_PD(playerid, dNull, DIALOG_M, !""LightGreen_color"Информация", !"{FFFFFF}Ваш ник не соответствует правилам сервера.\nВведите новый ник в окошко и нажмите "LightGreen_color"Далее.\n\n{FFFFFF}Пример: "LightGreen_color"Carl_Jupiter", !"Понял", "");
		    return Kick(playerid);
	    }

		ShowRegDialog(playerid);
	}
	return 1;		
}
@StopAnimation(playerid);
@StopAnimation(playerid) return ApplyAnimation(playerid, "PED", "facanger", 4.1, 0, 1, 1, 1, 1);

@_IncorrectPassword(playerid);
@_IncorrectPassword(playerid) {
	if(!cache_num_rows()) {
		--PlayerBadAttempt{playerid};
		printf("%d attempts", PlayerBadAttempt{playerid});
		fstring[0] = 0;
		format(fstring, (92 + (-2+4)),"\
			{FF0000}Вы ввели неверный пароль!\n\
			{FFFFFF}Попыток для ввода пароля:{0f4900} %d", PlayerBadAttempt{playerid});

		SHOW_PD(playerid, d_Log, DIALOG_P, "{FFA500}Авторизация", fstring, "Войти", "Отмена");
		fstring[0] = EOS;
	} else {LoginPlayer(playerid);}

	if(++PlayerBadAttempt{playerid} <= 0) {
		Msg(playerid, NOTIFICATION, SERVER_CLOSED);
		return Kick(playerid);
	}

	return 1; 
}
@ChangePassword(playerid);
@ChangePassword(playerid) {
	query_string[0] = 0;
	mysql_format(db, query_string, sizeof(query_string), "UPDATE "T_ACC" SET `password` = '%e', `salt` = '%e' WHERE `id` = '%d'", PlayerInfo[playerid][pPassword], PlayerInfo[playerid][pSalt], PlayerInfo[playerid][pID]);
	mysql_tquery(db, query_string);
	return 1;
} 

stock SetPlayerPosEx() {
	здесь перехватить и сделать задание угла поворота как дополнение к функции
	return 1;
}

stock ShowLoginDialog(playerid)
{
	fstring[0] = 0;
	PlayerBadAttempt{playerid}--;
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

//! для выноса под vehicle_system
// stock RepairCar(playerid) {
// 	fADM(playerid, ADM_FOUNDER);
// 	new 
// 		vehID = GetPlayerVehicleID(playerid);

// 	if (autoRepairCar[playerid] && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
// 		RepairVehicle(vehID);
// 		SetVehicleHealth(vehID, 1000.0);
// 	}

// 	return 1;
// }

stock ShowRegDialog(playerid)
{
	fstring[0] = 0;
	format(fstring, (420 + (-2+MAX_PLAYER_NAME)),"{FFFFFF}Здравствуйте, {0093ff}%s\n\n\
		{FFFFFF}Данный аккаунт {FFA500}отсутствует{FFFFFF} в базе данных.\n\
		Для продолжения, введите пароль в поле ниже.\n\
		Он будет необходим для дальнейшей авторизации на сервере.\n\n\
		\t\t{FFFFFF}Примечание для ввода пароля:\n\
		\t\t- {FFA500}Пароль должен состоять из латиницы и не содержать цифры\n\
		\t\t- {FFA500}Пароль не должен быть меньше 6 и больше 22 символов.", pi[playerid][pNames]);
	SHOW_PD(playerid, dReg1, DIALOG_P, !"{FFFFFF}[1/4]{FFA500} Пароль", fstring, !"Далее",!"Отмена");	
	return 1;
}
stock ShowUpdateSettings(playerid, vkontakte[] = " ", discord[] = " ", telegram[] = " ") {
	fstring[0] = 0;

	new 
		lang = GetLanguage(playerid);

	format(fstring, sizeof(fstring), "Система\tСостояние\n\
		{AFAFAF}Показ ников:\t%s\n\
		{AFAFAF}E-mail:\t%s\n\
		{AFAFAF}Сменить пароль\t{0093ff}[ Аккаунт ]\n\
		{AFAFAF}Сменить PIN-код\t{0093ff}[ Банковская карта ]\n\
		{AFAFAF}Показывать голод:\t%s\n\
		{AFAFAF}Изменить\t{0093ff}[ Место спавна ]\n\
		{AFAFAF}Отмена показа документов:\t%s\n\
		{AFAFAF}Google Authenticator\t{0093ff}Анти-взлом система\n\
		{AFAFAF}Вход через почту:\t%s\n\
		{AFAFAF}Язык инвентаря / интерфейса:\t{0093ff} [ %s ]\n\
		{AFAFAF}Привязка ВКонтакте/Discord/TG:\t{0093ff} [ Перейти ]",
		pi[playerid][pShowName] ? ("{008000}[Вкл]") : ("{FF0000}[Выкл]"),
		pi[playerid][pEmail],
		pi[playerid][pHungryBar] ? ("{9ACD32}[Вкл]") : ("{B83434}[Выкл]"),
		pi[playerid][pShowDocuments] ? ("{9ACD32}[Вкл]") : ("{FF0000}[Выкл]"),
		pi[playerid][pEmailAuth] ? ("{9ACD32}[Вкл]") : ("{B83434}[Выкл]"),
		((lang == 1) ? ("русский") : ((lang == 2) ? ("англ") : (lang == 3) ? ("беларусский") : ("нет")))
		// ((lang == 1) ? ("{9ACD32}русский") : (lang == 2)) ? ("{9ACD32}англ")) : (lang == 3) ? ("{9ACD32}беларусский") : 0)),
		// strlen(vkontakte) > 2 ? vkontakte : ("{B83434}Не привязан")
	);
	


	// ((language == 1) ? 1 : ((language == 2) ? 2 : (language == 3) ? 3 : 0));
/*
	((PlayerInfo[playerid][pLanguage] == 1) ? ("русский") : ((PlayerInfo[playerid][pLanguage] == 2) ? ("английский")) : ((PlayerInfo[playerid][pLanguage] == 3) ? ("беларусский") : 0)))),
	*/

	//if(PlayerInfo[playerid][pVkontakte]) && strlen(vkontakte) < 2 return GetVKName(playerid);
	return SHOW_PD(playerid, d_PLAYER_SETTINGS, DIALOG_STH, !"Настройки персонажа", fstring, !"Выбор", "Отмена");
}
stock ResetVariables(playerid) {
	PlayerAFK[playerid] 			=
	pi[playerid][pAdmin] 			= 
	pi[playerid][pLevel] 			=
	pi[playerid][pShowDocuments] 	=
	pi[playerid][pPassport] 		=
	pi[playerid][pSex] 				=
	pi[playerid][pSkin]				=
	pi[playerid][pMoney] 			=
	pi[playerid][pHungryBar] 		=
	pi[playerid][pWantedLevel]		=
	pi[playerid][pEmailConfirmed] 	=
	pi[playerid][pLanguage]			=

	pi[playerid][pVkontakte]		=
	pi[playerid][pDiscord]			=
	pi[playerid][pTelegram]			=

	_:nitroHype[playerid]			=
	_:autoRepairCar[playerid]       =

	PlayerBadAttempt{playerid} 		= 0;
	inadmcar{playerid}				= -1;

	printf("(ID: %d) (NAME: %s) id освободил данные", playerid, GetName(playerid));

	for(new i = 5; --i > 0;) {
    	pi[playerid][pDrivingCategories][i] = 0;
	}

	//! обдумать как будем делать сохранение сессий после выхода 

	pi[playerid][pNames] = 0;
	pi[playerid][pPassword] = 0;
	pi[playerid][pEmail] = 0;

	return 1;
}


stock LicType(id) {
	new type[13];

	switch(id) {
		case 0: {type="Авто";}
		case 1: {type="Судоходство";}
		case 2: {type="Грузовое";}
		case 3: {type="Оружие";}
		case 4: {type="Бизнес";}
		default: {type="None";}
	}

	return type;
}
stock GiveLic(playerid, lic_id) {
	if (IsLicenseValid(lic_id)) return 1;

	pi[playerid][pDrivingCategories][lic_id] = 1;

	fstring[0] = 0;
	query_string[0] = 0;
	
	format(fstring, (15 + (-2+6) + (-2+6) + (-2+6) + (-2+6) + (-2+6)),"%i,%i,%i,%i,%i", pi[playerid][pDrivingCategories][0], pi[playerid][pDrivingCategories][1], pi[playerid][pDrivingCategories][2], pi[playerid][pDrivingCategories][3], pi[playerid][pDrivingCategories][4]);
	
	mysql_format(db, query_string, (97 + (-2+38) + (-2+MAX_PLAYER_NAME)),"UPDATE "T_ACC" SET `licenses`='%s' WHERE `names`='%e'", fstring, GetName(playerid));
	mysql_tquery(db, query_string);

	printf("%s (%d) успешно получил права с licid %d и с типом %s", GetName(playerid), playerid, lic_id, LicType(lic_id));

	return 1;
}


stock CreateAccount(playerid)
{
	PlayerInfo[playerid][pMoney]	 		= BONUS_MONEY;
	PlayerInfo[playerid][pLevel] 			= START_LEVEL;
	PlayerInfo[playerid][pSkin] 	 		= DEFAULT_SKIN;
	PlayerInfo[playerid][pWantedLevel] 		= 0;

	new Year, Month, Day;
	getdate(Year, Month, Day);
	new date[13];
	format(date, (13 + (-2+4) + (-2+4) + (-2+6)), "%02d.%02d.%d", Day, Month, Year);

	//! для системы документов
	static 
		firstName[16],
		lastName[16];

	splitName(GetName(playerid));

	fstring[0] = 0;
	format(fstring, (11 + (-2+32) + (-2+32)), "%s %s None", firstName, lastName);
	
	query_string[0] = 0;
	mysql_format(db, query_string, (217 + (-2+MAX_PLAYER_NAME) + (-2+67) + (-2+13) + (-2+18) + (-2+15) + (-2+16) + (-2+32) + (-2+4) + (-2+4) + (-2+4) + (-2+6) + (-2+6) + (-2+6) + (-2+6) + (-2+66)), "INSERT INTO "T_ACC" (`names`, `password`, `salt`, `regIP`, `regData`, `lastIP`, `email`,`sex`,`admin`, `currentskin`, `money`, `level`, `wanted_level`,`fio`) VALUES ('%e','%e','%e','%e','%e','%e','%e',%d,%d,%d,%d,%d,%d,'%e')", GetName(playerid), PlayerInfo[playerid][pPassword], PlayerInfo[playerid][pSalt], PlayerInfo[playerid][pIP], date, PlayerInfo[playerid][pLastIP], PlayerInfo[playerid][pEmail], PlayerInfo[playerid][pSex], PlayerInfo[playerid][pAdmin], PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pLevel], pi[playerid][pWantedLevel], pi[playerid][pFIO]);
	mysql_tquery(db, query_string);
	query_string[0] = EOS;
	fstring[0] = EOS;

	printf("22 (%s) %s", strlen(query_string), query_string);

	playerLoggedStatus{playerid} = true;

	SpawnPlayer(playerid);
	return 1;
}

function LoadAdmins() {
	//! здесь написать загрузку админов с под системы и связать с pi[playerid][pID] на каждого авторизованого
	return 1;
}

function LoginPlayer(playerid) {
	new getIP[16];

	cache_get_value_name(0, "email", pi[playerid][pEmail], 32);
	cache_get_value_name_int(0, "sex", pi[playerid][pSex]);
	cache_get_value_name_int(0, "admin", pi[playerid][pAdmin]);
	cache_get_value_name_int(0, "currentskin", pi[playerid][pSkin]);
	cache_get_value_name_int(0, "money", pi[playerid][pMoney]);
	cache_get_value_name_int(0, "level", pi[playerid][pLevel]);

	cache_get_value_name_int(0, "language", pi[playerid][pLanguage]);
	pi[playerid][pLanguage] ^= LANG_RU ^ ((pi[playerid][pLanguage] == 2) ? LANG_USA : LANG_BELARUS);

	//! здесь я подгружаю данные в pi и выгружаю (поскольку запрос идёт именно на эту таблицу passports) 
	//? загрузка системы документов
	cache_get_value_name_int(0, "idPassportInRegister", pi[playerid][pPassportID]);
	cache_get_value_name(0, "fio", pi[playerid][pFIO]);

	query_string[0] = 0;
	mysql_format(db, query_string, (47 + (-2+6)), "SELECT * FROM `passports` WHERE `player_id`=%d", pi[playerid][pID]);
	mysql_tquery(db, query_string, "@LoadDocumentSystem", "d", playerid);
	query_string[0] = EOS;
	// --


	cache_get_value_name(0, "licenses", pi[playerid][pDrivingQuery]); //! load licenses 1
	sscanf(pi[playerid][pDrivingQuery], "p<,>a<i>[5]", pi[playerid][pDrivingQuery]); //! load licenses 2
	printf("debug: pDriveQuery %s", pi[playerid][pDrivingQuery]); //! debug loading 3

	// --

	SetPlayerScore(playerid, pi[playerid][pLevel]);
	GivePlayerMoney(playerid, pi[playerid][pMoney]);
	SetPlayerSkin(playerid, pi[playerid][pSkin]);

	pi[playerid][pLastIP] = GetPlayerIp(playerid, getIP, 16);

	TogglePlayerSpectating(playerid, 0);

	if(pi[playerid][pAdmin] > 0) Iter_Add(ADM_LIST, playerid);
	// SavePlayer(playerid);

	playerLoggedStatus{playerid} = true;
	SpawnPlayer(playerid);

	return 1;
}
/*
enum passport {
	ID,
	FIO[64],
	ID_IN_REGISTER,
	NOMER[8],
	SERIAL[6],
	PROPISKA[64],
	SEX,
	IFCHANGEDSEX,
	ISSUED,
	WHOMISSUED,
	DATEOFBIRTHDAY,
	OTHER_DOCUMENTS[4] //! здесь будет массив остальных документов
}
new 
	passport_info[MAX_PLAYERS][passport];*/

// select * from `passports` WHERE id=%d
@LoadDocumentSystem(player);
@LoadDocumentSystem(player) {
	if(cache_num_rows() != 0) {
		if (pi[player][pPassport]) return 1;
		else {
			passport_info[player][NOMER] = GenerateRandNomerOfDocument();
			passport_info[player][SERIAL] = GenerateRandSerialOfDocument();
			@LoadDocumentSystem(player);
		}

		//! запросы будут с применением JOIN sql (связка параллельных таблиц и сверка значений)
		//! pi[playerid][pPassportID] == passport_info[player][ID_IN_REGISTER]
	
		cache_get_value_name_int(0, "idRegister", passport_info[player][ID_IN_REGISTER]);
		strcat(pi[player][pFIO], passport_info[player][FIO]);

		printf("%s fio", passport_info[player][FIO]);

		switch (pi[player][pSex]) {
			case 0: passport_info[player][SEX] = "Мужчина";
			case 1: passport_info[player][SEX] = "Женщина";
		}

		cache_get_value_name_int(0, "p_ifchangedsex", passport_info[player][IFCHANGEDSEX]); //! если была смена пола
		cache_get_value_name(0, "p_issued", passport_info[player][ISSUED]); //! выдано дата
		cache_get_value_name(0, "p_issuedbywhom", passport_info[player][WHOMISSUED]); //! кто выдал 
		cache_get_value_name(0, "p_dateofbirthday", passport_info[player][DATEOFBIRTHDAY]); //! при регистрации паспорта
	} else print("[LoadDocumentSystem]: failed!");

	return 1;
}
stock SaveDocuments() {
	//! здесь будет сохранение документов

	return 1;
}
stock GenerateRandNomerOfDocument() {
	
	return 1;
}
stock GenerateRandSerialOfDocument() {

	return 1;
}


stock ShowStats(playerid) {
	fstring[0] = 0;

	format(fstring, sizeof(fstring), "Система\tИнфо\n\
		{AFAFAF}Ваш ID:\t {0093ff} %d\n\
		{AFAFAF}Ваш игровой псевдоним:\t {0093ff} %s\n\
		{AFAFAF}Ваша почта:\t {0093ff} %s\n\
		{AFAFAF}Уровень розыска:\t {0093ff} %d\n\
		{AFAFAF}Паспорт:\t %s\n\
		{AFAFAF}Удостоверение на транспорт:\t %s",
		playerid, //! pi[playerid][pID] это ид ячейки в базе
		pi[playerid][pNames],
		pi[playerid][pEmail],
		pi[playerid][pWantedLevel],
		pi[playerid][pPassport] ? ("{9ACD32}[ЕСТЬ]") : ("{F04245}[НЕТ]"),
		pi[playerid][pDrivingLic] ? ("{9ACD32}[ЕСТЬ]") : ("{F04245}[НЕТ]")
	);

	return SHOW_PD(playerid, dNull, DIALOG_STH, !"Статистика игрока", fstring, !"Выбор", "Отмена");
}

stock SavePlayer(playerid) {
	if(!playerLoggedStatus{playerid}) return 0;

	//? обнуление и выгрузка данных для дальнейшего сохранения в бд (удостоверения)
	pi[playerid][pDrivingQuery][0] = 0;
	format(pi[playerid][pDrivingQuery], 20, "%i,%i,%i,%i,%i", pi[playerid][pDrivingCategories][0], pi[playerid][pDrivingCategories][1], pi[playerid][pDrivingCategories][2], pi[playerid][pDrivingCategories][3], pi[playerid][pDrivingCategories][4]);
	// SaveDocuments();

	query_string[0] = EOS;
	mysql_format(db, query_string, (192 + (-2+18) + (-2+34) + (-2+4) + (-2+6) + (-2+4) + (-2+6) + (-2+4) + (-2+66) + (-2+4)), "UPDATE "T_ACC" SET `lastIP` = '%e', `email` = '%e', `sex` = %d, `admin` = %d, `currentskin` = %d, `money` = %d, `level` = %d, `wanted_level` = %d, `licenses` = '%s', `email_confirmed` = %d, `fio` = '%e', `language`='%d' WHERE `id` = %d", PlayerInfo[playerid][pLastIP], PlayerInfo[playerid][pEmail], PlayerInfo[playerid][pSex], PlayerInfo[playerid][pAdmin], PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pLevel], PlayerInfo[playerid][pWantedLevel], PlayerInfo[playerid][pDrivingQuery], PlayerInfo[playerid][pEmailConfirmed], pi[playerid][pFIO], pi[playerid][pLanguage], playerid);
	mysql_tquery(db, query_string);

	return 1;
}

@MakeAdmin(playerid, const name[], level);
@MakeAdmin(playerid, const name[], level) {
	static name_of_id;
	name_of_id = GetPlayerID(name);

	if(cache_num_rows() == 0) {
		if(!level) {
			query_string[0] = 0;

			if(name_of_id != INVALID_PLAYER_ID) PlayerInfo[name_of_id][pAdmin] = 0;

			mysql_format(db, query_string, (41 + (-2+MAX_PLAYER_NAME)), "DELETE FROM `admin` WHERE `names` = '%e' LIMIT N", name);
			mysql_tquery(db, query_string);

			query_string[0] = EOS;
			mysql_format(db, query_string, (52 + (-2+MAX_PLAYER_NAME)), "UPDATE `admin` SET `level`=0 WHERE `names` = '%e' LIMIT N", name);
			mysql_tquery(db, query_string);

			fstring[0] = 0;
			format(fstring, sizeof(fstring),"Администратор {0093ff}%s"Default" больше не имеет доступа к системе.", name);
			Msg(playerid, NOTIFICATION, fstring);
		}
		else {
			if(name_of_id != INVALID_PLAYER_ID) pi[name_of_id][pAdmin] = level;

			query_string[0] = 0;
			mysql_format(db, query_string, (55 + (-2+6) + (-2+MAX_PLAYER_NAME)), "UPDATE `admin` SET `level` = '%d' WHERE `names` = '%e' LIMIT N", level, name);
			mysql_tquery(db, query_string);
			mysql_format(db, query_string, (58 + (-2+6) + (-2+MAX_PLAYER_NAME)), "UPDATE "T_ACC" SET `admin` = '%d' WHERE `names` = '%e' LIMIT N", level, name);
			mysql_tquery(db, query_string);

			fstring[0] = 0;
			format(fstring, sizeof(fstring), "Администратор {0093ff}%s"Default" получил повышение до {0093ff}%i"Default" уровня доступа.", name, level);
			Msg(playerid, NOTIFICATION, fstring);
		}
	}
	else {
		query_string[0] = 0;

		if(!level) return Msg(playerid, NOTIFICATION, "Указанный игрок не имеет доступа к системе!");

		mysql_format(db, query_string, (77 + (-2+(MAX_PLAYER_NAME)) + (-2+6)), "INSERT INTO `admin` (name,level,last_connect) VALUES ('%e', '%d', CURDATE())", name, level);
		mysql_tquery(db, query_string);
		mysql_format(db, query_string, (54 + (-2+6) + (-2+MAX_PLAYER_NAME)), "UPDATE "T_ACC" SET admin = '%d' WHERE names = '%e'", level, name);
		mysql_tquery(db, query_string);
		query_string[0] = EOS;

		fstring[0] = 0;
		format(fstring, sizeof(fstring),"{0093ff}%s"Default" теперь имеет доступ к системе и занесён в базу данных. Указанный уровень доступа: %i", name, level);
		Msg(playerid, ERR, fstring);

		if(name_of_id != INVALID_PLAYER_ID) {
			pi[name_of_id][pAdmin] = level;

			mysql_format(db, query_string, (52 + (-2+6) + (-2+MAX_PLAYER_NAME)), "UPDATE "T_ACC" SET admin '%d' WHERE names = '%e'", PlayerInfo[playerid][pAdmin], name);
			mysql_tquery(db, query_string);
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
	for(new i=sizeof(NameList); --i > 0;) {
		if (!strcmp(string, NameList[i])) return 1;
		// if(!GetString(string, NameList[i])) return 1;
	}
	return 0;
}
stock IsRPNick(const nick[]) {
    new Regex:r_str = Regex_New("([A-Z]{1})([a-z]+)_([A-Z]{1})([a-z]+)");
    new check = Regex_Check(nick, r_str);
    Regex_Delete(r_str);
    return check;
}

cmd:testimdanil(playerid) {
	if (GetName(playerid) == CheckExceptionName(GetName(playerid))) {
		SEND_CM(playerid, format_white, "АХУЕТЬ ЭТО Я БЛЯДЬЬ!!!!");
	} else {
		SEND_CM(playerid, format_white, "а может и дима");
	}

	return 1;
}

stock GetPlayerID(const string[]) {
    new testname[MAX_PLAYER_NAME];
	foreach(new i:Player) {
		GetPlayerName(i, testname, sizeof(testname));
		if(!strcmp(testname, string, true)) return i;
	}
	return INVALID_PLAYER_ID;
}

stock ConnectSQL() {
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