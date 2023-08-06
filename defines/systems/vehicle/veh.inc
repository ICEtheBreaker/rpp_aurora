//!============>> Copyright (c) 2017-2023 Darkside Interactive, Ltd. All rights reserved. <<============//
//
//? Цель: точка входа в систему автомобиля
//
//!=====================================================================================================//

#include "YSI_Coding\y_hooks"
#include "YSI_Coding\y_timers"
//--
#define   FlipVeh(%0)						new Float:A;GetVehicleZAngle(%0,A);SetVehicleZAngle(%0,A);
new bool: nitroHype[MAX_PLAYERS];
new bool: autoRepairCar[MAX_PLAYERS];
//--
ptask RepairVeh[4000](playerid) {RepairCar(playerid);}
stock RepairCar(playerid) {
	fADM(playerid, ADM_FOUNDER);
	new 
		vehID = GetPlayerVehicleID(playerid);

	if (autoRepairCar[playerid] && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
		RepairVehicle(vehID);
		SetVehicleHealth(vehID, 1000.0);
	}

	return 1;
}

CMD:nh(playerid) {
	fADM(playerid, ADM_FOUNDER);
	if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid)) return 1;
	nitroHype[playerid] ^= true ^ false;autoRepairCar[playerid] ^= true ^ false;
	return SEND_CM(playerid, format_white, nitroHype[playerid] ? "~g~nh activated & mode autoRepair done" : "~g~nh disabled & mode autoRepair disabled");
}