YACC= bison -d -v
LEX=flex
CC=gcc
LDLIBS= -lfl  -ly -lm

all : arbre

arbre: Arbre.tab.c lex.yy.c tree.c
	$(CC) -o $@ $^ $(LDLIBS)

Arbre.tab.c: Arbre.y
	$(YACC) -o $@ $<
lex.yy.c: Arbre.l
	$(LEX) $<
