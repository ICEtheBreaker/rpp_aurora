//!============>> Copyright (c) 2017-2023 Darkside Interactive, Ltd. All rights reserved. <<============//
//
//? Цель: макросы, сокращающие основные нативы. Упрощает написание кода
//
//!=====================================================================================================//

#define DIALOG_M						DIALOG_STYLE_MSGBOX
#define DIALOG_P						DIALOG_STYLE_PASSWORD
#define DIALOG_L    					DIALOG_STYLE_LIST
#define DIALOG_I          				DIALOG_STYLE_INPUT
#define SHOW_PD							ShowPlayerDialog
#define SEND_CM							SendClientMessage
#define SCM_toAdm                       SendClientMessageToADM

/*#define ADMError(%0,%1)                 SCM_toAdm(%0, error_color, %1);
#define ADMLog(%0,%1)                   SCM_toAdm(%0, log_color, %1)
#define ADMWarning(%0,%1)               SCM_toAdm(%0, warning_color, %1)
#define ADMInfo(%0,%1)                  SCM_toAdm(%0, info_color, %1)
*/
//! макросы для отправки конкретного смс в ADM-систему

#define Error(%0,%1)                    SEND_CM(%0, error_color, %1)
#define Log(%0,%1)                      SEND_CM(%0,log_color,%1)
#define Warning(%0,%1)                  SEND_CM(%0, warning_color, %1)
#define Info(%0,%1)                     SEND_CM(%0, info_color, %1)

#define MYSQL_IS_LOCAL                  true

#define BONUS_MONEY						(250)
#define START_LEVEL						(1)
#define DEFAULT_SKIN                    (102)

//? таблица игрока
#define T_ACC                           "`accounts`"
#define T_ADMIN                         "`admin`"
#define T_CAR                           "`cars`"