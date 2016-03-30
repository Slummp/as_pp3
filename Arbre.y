%{
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include "tree.h"
int yylex(void);
void yyerror(char *);


%}

%union{
    struct attributes *attribut;
    char* txt;
}


%type  <attribut>attr

%token <txt>TXT

%start start

%%
start : balise {//tree_dump();
                }

balise:     TXT '[' attr ']' '{' contenu '}' {}
        |   TXT '{' contenu '}' {}
        ;

attr :     attr TXT '=' TXT { $$ = new_attributes($2, $4); $$->next = $1; }
        |  %empty           { $$ = NULL; }
        ;
        
contenu:  '"' TXT '"' contenu {}
        | balise contenu {}
        | %empty
        ;
