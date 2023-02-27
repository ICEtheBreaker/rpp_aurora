stock ex_ShowPlayerDialog(playerid, dialogid, style, caption[], info[], button1[], button2[]) {
    return ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);
}
#if defined _ALS_ShowPlayerDialogEx
    #undef ShowPlayerDialogEx
#else
    #define _ALS_ShowPlayerDialogEx
#endif
#define ShowPlayerDialogEx ex_ShowPlayerDialog

stock ValidChar(mailchar)
{
	if((mailchar >= 'A' && mailchar <= 'Z') || (mailchar >= 'a' && mailchar <= 'z')
	|| (mailchar >= '0' && mailchar <= '9') || (mailchar == '-') || (mailchar == '_')
	|| (mailchar == '@') || (mailchar == '.')) return 1;
	return 0;
}
stock TextFind(const text[],const findtext[]) return strfind(text, findtext) != -1;
stock IsValidEmail(const email[])
{
	new bool:Succes = true;
	new bool:Good;
	for(new i; i < strlen(email); i++)
	{
	    if(email[i] == '@') {
		    if(!Good) Good = true;
		    else{
				Good = false;
		    	break;
			}
		}
	    if(!ValidChar(email[i])) Succes = false;
	}
	if(!Good) Succes = false;
	if(!TextFind(email,".ru") && !TextFind(email,".com") && !TextFind(email,".ua") && !TextFind(email,".su")) Succes = false;
	if(!TextFind(email,"@")) Succes = false;
  	return Succes;
}
