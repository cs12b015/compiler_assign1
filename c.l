%{
#include <stdio.h>
#include "y.tab.h"
#define YYSTYPE char *
#include <stdlib.h>
%}

%%
[ \n\t\f\r]   		;
"friendof"  	   	{yylval.strng=strdup(yytext);return RELATIONSHIP;}
"roommateof"	   	{yylval.strng=strdup(yytext);return RELATIONSHIP;}
"classmateof"      	{yylval.strng=strdup(yytext);return RELATIONSHIP;}

"if"			   	{yylval.strng=strdup(yytext);return IF;}
"endif"		       	{yylval.strng=strdup(yytext);return ENDIF;}
"foreach"          	{yylval.strng=strdup(yytext);return FOREACH;}
"endforeach"       	{yylval.strng=strdup(yytext);return ENDFOREACH;} 

$[a-zA-Z]+			{yylval.strng=strdup(yytext);return VARIABLE;}
[a-zA-z]+			{yylval.strng=strdup(yytext);return NAME;}
.					{printf("ERROR\n"); exit(0);}


%%

int yywrap(void) {
    return 1;
}
