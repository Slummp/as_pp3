%{
#include <stdlib.h>
#include "Arbre.tab.h"
%}

%option noinput nounput

%%
[a-z0-9]+ { yylval.txt = strdup(yytext); return TXT; }
([a-zA-Z]|_[a-zA-Z0-9'\._])[a-zA-Z0-9'\._]* {ECHO;printf("\n");}
