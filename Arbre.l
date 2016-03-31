%{
#include <stdlib.h>
#include "Arbre.tab.h"
%}

%option noinput nounput
%x TEXT


%%
([a-zA-Z]|_[a-zA-Z0-9'\._])[a-zA-Z0-9'\._]*
{
	yyval.txt = strdup(yytext);
	return LABEL;
}

\"
{
	BEGIN TEXT;
}

<TEXT>[[^"[:space:]]|\\\"]*
{
	yyval.txt = strdup(yytext);
	return TXT;
}

<TEXT>[:space:]*
{
	return SPACE;
}

<TEXT>\"
{
	BEGIN INITIAL;
}
