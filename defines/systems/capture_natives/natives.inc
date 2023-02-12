stock ex_ShowPlayerDialog(playerid, dialogid, style, caption[], info[], button1[], button2[]) {
    return ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);
}
#if defined _ALS_ShowPlayerDialogEx
    #undef ShowPlayerDialogEx
#else
    #define _ALS_ShowPlayerDialogEx
#endif
#define ShowPlayerDialogEx ex_ShowPlayerDialog