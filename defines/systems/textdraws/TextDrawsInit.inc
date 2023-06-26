//!============>> Copyright (c) 2017-2023 Darkside Interactive, Ltd. All rights reserved. <<============//
//
//? ÷ель: текстдравы сервера
//
//!=====================================================================================================//

// #include "../../pawno/include/YSI_Coding/y_hooks" //! y_hooks дл€ сокращени€ перехватов _als_ на более короткие и пон€тные

//?=========================================[Variables]=================================================//
new Text: 
        buildVerTD;
//?=====================================================================================================//

//!=========================================[Captures _ALS_ code]=======================================//
// hook OnGameModeInit() {
//     //! здесь загрузка статических тдшек (без playerid)

//     return Y_HOOKS_CONTINUE_RETURN_1;
// }
// hook OnPlayerConnect(playerid) {
//     //! здесь загрузка динамических тдшек (playerid)

//     LoadBuildVersionTD(playerid);

//     return Y_HOOKS_CONTINUE_RETURN_1;
// }

// public OnGameModeInit() {
//     #if defined loadTD_OnGameModeInit
// 	    loadTD_OnGameModeInit();
// 	#endif

//     return 1;
// }
// #if defined _ALS_OnGameModeInit
// 	#undef OnGameModeInit
// #else
// 	#define _ALS_OnGameModeInit
// #endif
// #define OnGameModeInit loadTD_OnGameModeInit
// #if defined loadTD_OnGameModeInit
//     forward loadTD_OnGameModeInit();
// #endif

// public OnPlayerConnect(playerid) {
//     #if defined loadTD_OnPlayerConnect
// 		return loadTD_OnPlayerConnect(playerid);
// 	#endif
	
//     //! здесь будут стоки, в которых будет подгрузка динамических (измен€емых дл€ каждого playerid информации) td
//     LoadBuildVersionTD(playerid);
	
// 	return loadTD_OnPlayerConnect(playerid);
// }
// #if defined _ALS_OnPlayerConnect
// 	#undef OnPlayerConnect
// #else
// 	#define _ALS_OnPlayerConnect
// #endif
// #define OnPlayerConnect loadTD_OnPlayerConnect
// #if defined loadTD_OnPlayerConnect
//     forward loadTD_OnPlayerConnect(id);
// #endif



//!=====================================================================================================//

// load static TextDraws
//! все статические


// load player TextDraws
//! все динамические (те, что измен€ютс€)
static LoadBuildVersionTD(player) {
    buildVerTD = TextDrawCreate(24.000000, 320.000000, !"Development build #MODE_VERS");
    TextDrawColor(buildVerTD, -1);
    TextDrawBoxColor(buildVerTD, -1347440726);
    TextDrawSetOutline(buildVerTD, 1);
    TextDrawBackgroundColor(buildVerTD, 170);
    TextDrawFont(buildVerTD, 2);
    TextDrawSetProportional(buildVerTD, 1);
    TextDrawShowForPlayer(player, buildVerTD);
    return 1;
}