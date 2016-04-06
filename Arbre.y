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
    struct tree * tree;
    char* txt;
}


%type  <attribut>attr
%type  <tree>		balise contenu texte
%token <txt>TXT LABEL EOL

%token SPACE

%start start

%%
start : balise EOL { printf("something\n"); return 0;
                }

balise:     LABEL '[' attr ']' '{' contenu '}'
            {
                $$ = new_balise($1, false);
                $$->attr = $3;
                $$->daughters = $6;
		printf("label avec attribut et contenu\n");
            }
        |   LABEL '{' contenu '}'
            {
                $$ = new_balise($1, false);
                $$->attr = NULL;
                $$->daughters = $3;
		printf("label sans attribut mais contenu\n");
            }
        |   LABEL '/'
            {
		$$ = new_balise($1, false);
		printf("label sans attribut ni contenu\n");
            }
        |   LABEL '[' attr ']' '/'
            {
		$$ = new_balise($1, false);
                $$->attr = $3;
                printf("label avec attribut sans contenu\n");
            }
        ;

attr :      attr LABEL '=' TXT
            {
                $$ = new_attributes($2, $4);
                $$->next = $1;
            }
        |   %empty
            {
                $$ = NULL;
            }
        ;
        
contenu:    '"' texte '"' contenu
            {

            }
        |   balise contenu
            {

            }
        |   %empty
            {

            }
        ;

texte:      TXT texte
            {
                $$ = new_word($1, false);
                $$->right = $2;
            }
        |   texte SPACE
            {
                $$ = $1;
                $$->space = true;
            }
        |   %empty
            {
                $$ = NULL;
            }
        ;
