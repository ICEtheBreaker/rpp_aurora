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
#define SEND_EM(%0,%1)				    SendClientMessage(%0,format_red,%1)
#define SEND_WM(%0,%1)					SendClientMessage(%0,format_red,%1)

#define BONUS_MONEY						250
#define START_LEVEL						1
#define DEFAULT_SKIN                    102