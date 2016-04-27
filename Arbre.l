%{
#include <stdlib.h>
#include <string.h>
#include "Arbre.tab.h"
%}

%option noinput nounput
%x TEXT ECHAP FINTEXTE


%%

([a-zA-Z]|_[a-zA-Z0-9'\._])[a-zA-Z0-9'\._]*/[\=\{\[\/] {
	yylval.txt = strdup(yytext);
    printf("__LABEL %s\n", yylval.txt);
    return LABEL;
}

[[:space:]]+ {
    printf("__Space rejected\n");
}

\" {
    printf("__TexteDébut\n");
    BEGIN TEXT;
    return '"';
}

\/ {printf(
    "__Slash\n");
    return '/';
}

\[ {
    printf("__CrochetOuvrant\n");
    return '[';
}

\] {
    printf("__CrochetFermant\n");
    return ']';
}

\{ {
    printf("__AccoladeOuvrante\n");
    return '{';
}

\} {
    printf("__AccoladeFermante\n");
    return '}';
}

\= {
    printf("__Egal\n");
    return '=';
}

<TEXT>[[:space:]]+ {
    printf("    __Space\n");
	return SPACE;
}

<TEXT>\\ {
    BEGIN ECHAP;
}

<ECHAP>. { 
    yymore();
    BEGIN TEXT;
}

<TEXT>[^\\\" ]* {
    printf("    __Texte %s\n", yytext);
    yylval.txt = strdup(yytext);
    return TXT;
}

<TEXT>\" {	
    printf("__TexteFin\n");
	BEGIN INITIAL;
    return '"';
}
