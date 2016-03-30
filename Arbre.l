%{
#include <stdlib.h>
#include "Arbre.tab.h"
%}

%option noinput nounput

%%
[a-z0-9]+ { yylval.txt = strdup(yytext); return TXT; }

