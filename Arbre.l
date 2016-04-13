%{
#include <stdlib.h>
#include <string.h>
#include "Arbre.tab.h"
%}

%option noinput nounput
%x TEXT ECHAP


%%
"exit" { return EOL; }
([a-zA-Z]|_[a-zA-Z0-9'\._])[a-zA-Z0-9'\._]*/[\=\{\[\/] {
	yylval.txt = strdup(yytext);
        printf("__LABEL\n");
        return LABEL;
}

\" {
    printf("__TexteDébut\n");
	BEGIN TEXT;
}

\/ { printf("__Slash\n");           return '/';}
\[ {printf("__CrochetOuvrant\n");   return '[';}
\] {printf("__CrochetFermant\n");   return ']';}
\{ {printf("__AccoladeOuvrante\n"); return '{';}
\} {printf("__AccoladeFermante\n"); return '}';}
\= {printf("__Egale\n");            return '=';}

<TEXT>[[:space:]]+ {
    printf("__Space\n");
	return SPACE;
}
<TEXT>\\ {
    printf("__Echappement\n");
    REJECT;
    BEGIN ECHAP;
}
<ECHAP>. { yymore(); BEGIN TEXT; }
<TEXT>[^\"\\]* {
    printf("__Texte %s\n", yytext);
    yymore();
	
}
<TEXT>\" {
    yylval.txt = strdup(yytext);	
    printf("__TexteFin %s\n", yytext);
	BEGIN INITIAL;
    return TXT; 
}

