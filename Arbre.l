%{
#include <stdlib.h>
#include <string.h>
#include "Arbre.tab.h"
%}

%option noinput nounput
%x TEXT


%%
"exit" { 
([a-zA-Z]|_[a-zA-Z0-9'\._])[a-zA-Z0-9'\._]* {
	yylval.txt = strdup(yytext);
        printf("label\n");
        return LABEL;
}

\" {
	BEGIN TEXT;
}

\/ { printf("coucou\n"); return '/'; }
\[ {return '[';}
\] {return ']';}
\{ {return '{';}
\} {return '}';}

<TEXT>[[^\"[:space:]]|\\\"]* {
	yylval.txt = strdup(yytext);
	return TXT;
}

<TEXT>[:space:]* {
	return SPACE;
}

<TEXT>\" {
	BEGIN INITIAL;
}

