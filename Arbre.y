%{
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include "ast.h"
int yylex(void);
void yyerror(char *);
%}

%union{
    struct attributes *attribut;
    struct  ast * ast;
    char* txt;
}


%type  <attribut>attr
%type  <ast>		balise contenu texte
%token <txt>TXT LABEL EOL

%token SPACE

%start start

%%
start : balise start EOL { printf("- Balise -\n"); 
                }
                | %empty { printf(" - FIN - \n"); return 0; }

balise:     LABEL '[' attr ']' '{' contenu '}'
            {
	   $$ =  mk_tree($1, false,false, false,$3,$6);
            
		        printf("-- Label avec attribut et contenu\n");
            }
        |   LABEL '{' contenu '}'
            {
             $$ =  mk_tree($1, false,false, false,NULL,$3);
		        printf("-- Label sans attribut mais contenu\n");
            }
        |   LABEL '/'
            {
		       $$ =  mk_tree($1, false,false, false,NULL,NULL);
		        printf("-- Label sans attribut ni contenu\n"); 
            }
        |   LABEL '[' attr ']' '/'
            {
                printf("-- Label avec attribut sans contenu\n");
		       $$ =  mk_tree($1, false,false, false,$3,NULL);
            }
        ;

attr :      attr LABEL '=' TXT
            {
                printf("-- Attribut\n");
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
                printf("-- Texte - Contenu\n");
            }
        |   balise contenu
            {
                printf("-- Balise - Contenu\n");
            }
        |   %empty
            {
                printf("-- Contenu vide\n");
            }
        ;

texte:      TXT texte
            {
                printf("-- Texte\n");
                $$ =  mk_word($1);
              
            }
        |   texte SPACE
            {
                printf("-- Texte SPACE\n");
                $$ = $1;
              
            }
        |   %empty
            {
                printf("-- Texte VIDE\n");
                $$ = NULL;
            }
        ;
%%
int main(void) {
    fflush(stdout);
	yyparse();
	return 0;
}
