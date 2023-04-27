//========= Copyright (c) 2017-2023 Darkside Interactive, Ltd. All rights reserved. ============//
//
// Цель: макросы, сокращающие основные нативы. Упрощает написание кода
//
//=============================================================================//


#define DIALOG_M						DIALOG_STYLE_MSGBOX
#define DIALOG_L    					DIALOG_STYLE_LIST
#define DIALOG_I          				DIALOG_STYLE_INPUT
#define SHOW_PD							ShowPlayerDialog
#define SEND_CM							SendClientMessage

#define Error(%0,%1)                    SendClientMessage(%0, error_color, %1)
#define Log(%0,%1)                      SendClientMessage(%0, log_color, %1)
#define Warning(%0,%1)                  SendClientMessage(%0, warning_color, %1)
#define Info(%0,%1)                     SendClientMessage(%0, info_color, %1)

#define BONUS_MONEY						250
#define START_LEVEL						1
#define DEFAULT_SKIN                    102