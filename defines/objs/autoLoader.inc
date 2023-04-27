//========= Copyright (c) 2017-2023 Darkside Interactive, Ltd. All rights reserved. ============//
//
// Цель: loadobj.inc
//
//=============================================================================//
#include a_samp
#include "../../defines/objs/mapping/loadobj.inc" //? loadobj.inc

public OnGameModeInit() {
    _loadObjects();
    #if defined obj_OnGameModeInit
        return obj_OnGameModeInit();
    #else
        return true;
    #endif
}
#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit obj_OnGameModeInit
#if defined obj_OnGameModeInit
    forward obj_OnGameModeInit();
#endif
