%{
#include <stdlib.h>
#include <string.h>
#include "Arbre.tab.h"
%}

%option noinput nounput
%x TEXT


%%
"exit" { return EOL; }
([a-zA-Z]|_[a-zA-Z0-9'\._])[a-zA-Z0-9'\._]* {
	yylval.txt = strdup(yytext);
        printf("__LABEL\n");
        return LABEL;
}

\" {
    printf("__TexteDébut\n");
	BEGIN TEXT;
}

\/ { printf("__Slash\n"); return '/'; }
\[ {printf("__CrochetOuvrant\n");return '[';}
\] {printf("__CrochetFermant\n");return ']';}
\{ {return '{';}
\} {return '}';}
\= {return '='; }

<TEXT>[:space:]* {
	return SPACE;
}

<TEXT>(([^\"|[:^space:]])|\\\")* {
	yylval.txt = strdup(yytext);
	return TXT; /* [[^\"[: space:]]|\\\"]* */
}


<TEXT>\" {
    printf("__TexteFin\n");
	BEGIN INITIAL;
}

