#include <stdbool.h>
#include "chemin.h"
#include "pattern.h"

enum ast_type {
    INTEGER,  // L'expression est un entier
    BINOP,    // L'expression est un opérateur (addition, multiplication, comparaison,
              // opérateur logique ...)
    UNARYOP,  // L'expression est un opérateur unaire (ici, nous n'avons que la
              // négation logique)
    VAR,      // L'expression est une variable
    IMPORT,   // L'expression est correspond à une importation de fichier
    APP,      // L'expression est une application de fonction
    WORD,     // L'expression est un mot
    TREE,     // L'expression est un arbre
    FOREST,   // L'expression est une forêt
    FUN,      // L'expression est une fonction
    MATCH,    // L'expression est un filtre
    COND,      // L'expression est une conditionnelle 
    DECLREC   // Déclarations récursives (let rec ... where rec ...)
};

enum binop{PLUS, MINUS, MULT, DIV, LEQ, LE, GEQ, GE, EQ, OR, AND};

enum unaryop {NOT};


struct ast;


struct app{
    struct ast *fun;
    struct ast *arg;
};

struct attributes{
    struct ast * key;
    struct ast * value;
    struct attributes * next;
};

struct tree{
    char * label;
    bool is_value;
    bool nullary;
    bool space;
    struct attributes * attributes;
    struct ast * daughters;
};

struct forest{
    bool is_value;
    struct ast * head;
    struct ast * tail;
};

struct fun{
    char *id;
    struct ast *body;
};

struct patterns{
    struct pattern * pattern; //filtre
    struct ast * res;         //résultat si le filtre accepte
    struct patterns * next;   //filtres suivants si ce filtre échoue
};

struct match {
    struct ast * ast; // expression filtrée
    struct patterns * patterns; // liste des filtres 
};

struct cond{
    struct ast *cond;
    struct ast *then_br;
    struct ast *else_br;
};

struct declrec{
    char * id;
  struct ast * body;
};


union node{
    int num;
    enum binop binop;
    enum unaryop unaryop;
    char * str;  // peut représenter ou bien une variable ou encore un mot
    struct path * chemin; 
    struct app * app;
    struct tree * tree;
    struct forest * forest;
    struct fun * fun;
    struct match * match;
    struct cond * cond;
};

struct ast{
    enum  ast_type type;
    union node * node;
};

struct ast * mk_node(void);
struct ast * mk_integer(int n);
struct ast * mk_binop(enum binop binop);
struct ast * mk_unaryop(enum unaryop unaryop);
struct ast * mk_var(char * var);
struct ast * mk_import(struct path * chemin);
struct ast * mk_app(struct ast * fun, struct ast * arg);
struct ast * mk_word(char * str);
struct ast * mk_tree(char * label, bool is_value, bool nullary, bool space, 
                     struct attributes * att, struct ast * daughters);
struct ast * mk_forest(bool is_value, struct ast * head, struct ast * tail);
struct ast * mk_fun(char * id, struct ast * body);
struct ast * mk_match(struct ast * ast, struct patterns * patterns);
struct ast * mk_cond(struct ast * cond, struct ast * then_br, struct ast * else_br);
struct ast * mk_declrec(char * id, struct ast * body);
struct attributes * new_attributes (char* key, char* value);
