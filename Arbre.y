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

balise:     TXT '[' attr ']' '{' contenu '}' {$$ = new_balise($1, false); $$->attr = $3; $$->daughters = $6;}
        |   TXT '{' contenu '}' {$$ = new_balise($1, false); $$->attr = NULL; $$->daughters = $3;}
        ;

attr :     attr TXT '=' '"' TXT  '"' { $$ = new_attributes($2, $5); $$->next = $1; }
        |  %empty           { $$ = NULL; }
        ;
        
contenu:  '"' texte '"' contenu {  }
        | balise contenu {}
        | %empty
        ;

texte : TXT texte {$$ = new_word($1, false); $$->right = $2;}
        | texte SPACE {$$ = $1; $$->space = true;}
        | %empty {$$ = NULL;}
        ;