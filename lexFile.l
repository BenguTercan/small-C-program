%{
	#include <stdio.h>
	#include "y.tab.h"
	#include <stdlib.h>
	int yyerror(char*);
%}

%%


[0-9]+  {
		yylval.number = atoi(yytext);
		return NUMBER;

	}

[A-Za-z]+ {
		yylval.string = strdup(yytext);
		return WORD;
	       }



"+"		return *yytext;
"-"		return *yytext;
"*"		return *yytext;
"%"		return *yytext;
"/"		return *yytext;
"("		return *yytext;
")"		return *yytext;
~if		return IF;
~else		return ELSE;
"=="		return KE;
"!="		return KED;			
"<="		return KKE;
">="		return KBE;
">"		return KB;
"<"		return KK;
~then		return THEN;
"="		return *yytext;
~while		return WHILE;
":"		return *yytext;
[\"]		return QUOTE;
[ \t\n]		;
.		;
~calculate	return CALCULATE;
~int		return INTEGER;
~string		return STRINGTYPE;
~start		return START;
~end		return END;

%%

int yywrap()
{
	return 1;
}
