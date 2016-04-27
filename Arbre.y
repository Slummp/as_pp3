%{
    #include <stdlib.h>
    #include <stdio.h>
    #include <stdbool.h>
    #include <string.h>
    #include "tree.h"

    int yylex(void);
    void yyerror(char *);
%}

%union
{
    struct attributes *attribut;
    struct tree * tree;
    char* txt;
}


%type  <attribut>attr
%type  <tree>balise contenu texte

%token <txt>TXT LABEL FINTEXTE
%token SPACE

%start start

%%

start :     balise start
            {
                printf("- Balise -\n"); 
            }
        |   %empty
            {
                printf(" - FIN - \n");
                return 0;
            }
        ;

balise:     LABEL '[' attr ']' '{' contenu '}'
            {
                $$ = new_balise($1, false);
                $$->attr = $3;
                $$->daughters = $6;
		        printf("-- Label avec attribut et contenu\n");
            }
        |   LABEL '{' contenu '}'
            {
                $$ = new_balise($1, false);
                $$->attr = NULL;
                $$->daughters = $3;
		        printf("-- Label sans attribut mais contenu\n");
            }
        |   LABEL '/'
            {
		        $$ = new_balise($1, false);
		        printf("-- Label sans attribut ni contenu\n"); 
            }
        |   LABEL '[' attr ']' '/'
            {
                printf("-- Label avec attribut sans contenu\n");
		        $$ = new_balise($1, false);
                $$->attr = $3;
            }
        |   '{' contenu '}'
            {
                $$ = $2;
                printf("-- Foret\n");
            }
        ;

attr :      attr LABEL '=' '"' TXT '"'
            {
                printf("-- Attribut\n");
                $$ = new_attributes($2, $5);
                $$->next = $1;
            }
        |   %empty
            {
                $$ = NULL;
            }
        ;
    
contenu:    '"' texte '"' contenu
            {
                printf("-- Texte");
                if ($2 != NULL) 
                {
                    while($2->right != NULL)
                    {
                        printf("- %s", $2->label);
                        $2 = $2->right;
                    }

                    printf("2 %s", $2->label);

                    if($2->space)
                        printf(" ");
                }
                printf("\n");
            }
        |   balise contenu
            {
                printf("-- Balise - Contenu\n");
            }
        |   balise '"' SPACE texte '"' contenu
            {
                printf("-- Balise - Contenu\n");
            }
        |   %empty
            {
                printf("-- Contenu vide\n");
            }
        ;

texte:      TXT SPACE texte
            {
                $$ = new_word($1,true);
                $$->right = $3;
                //$$->space = true;
                //printf("-- Texte %s SPACE arbre\n", $1);
            }
        |   TXT TXT texte
            {
                $$ = new_word(strncat($1, $2, strlen($2)),true);
                $$->right = $3;
                //$$->space = true;
                //printf("-- Texte %s SPACE arbre\n", $1);
            }
        |   TXT
            {
                $$ = new_word($1,false);
                $$->right = NULL;
                //printf("-- TEXTE %s /// %s\n", $1, $2);
            }
        |   %empty
            {
                //printf("-- Texte FIN\n");
                $$ = NULL;
            }
        ;

%%

int main(void) {
    fflush(stdout);
	yyparse();
	return 0;
}
