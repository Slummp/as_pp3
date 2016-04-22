#include <stdbool.h>

enum pattern_type {
    WILDCARD,  // filtre acceptant soit un arbre quelconque, soit une chaîne 
               // quelconque, soit une forêt quelconque    
    PTREE,     // filtre acceptant un arbre
    PSTRING,   // filtre acceptant un mot particulier
    PVAR,      // filtre effectuant une affectation de variable
    PFOREST,    // filtre composé de plusieurs filtres acceptant une forêt
    ANYTREE,   // filtre acceptant un arbre quel que soit son étiquette
};

enum wildcard {
    ANY,       // filtre acceptant n'importe quel arbre: _
    ANYSTRING, // filtre acceptant n'importe quelle suite de mots *_*
    ANYFOREST, // filtre acceptant n'importe quelle suite d'arbres /_/
};

enum pvar {
    TREEVAR,   // filtre acceptant n'importe quel arbre et l'affectant à une variable
    STRINGVAR, // filtre acceptant n'importe quelle suite de mots et l'affectant
               // à une variable
    FORESTVAR  // filtre acceptant n'importe quelle suite d'arbres et l'affectant
               // à une variable 
};

struct pattern;

struct ptree {
    char * label;
    bool nullary;
    struct pattern * daughters;
};

struct anytree {
    bool nullary;
    bool space;
    struct pattern * daughters;
};

struct pforest {
    struct pattern * head;
    struct pattern * tail;
};

struct pstring {
    char * string;
};

struct pattern_var {
    char * id;
    enum pvar pvar;
};

union pnode {
    struct ptree * ptree;
    struct anytree * anytree;
    struct pforest * pforest;
    struct pstring * pstring;
    struct pattern_var * pvar;
    enum wildcard wildcard;
};

struct pattern{
    enum pattern_type ptype;
    union pnode * pnode;
};


struct pattern * mk_ptree(char * label, bool nullary, struct pattern * daughters);
struct pattern * mk_anytree(bool nullary, struct pattern * daughters);
struct pattern * mk_pforest(struct pattern * head, struct pattern * tail);
struct pattern * mk_pstring(char * string);
struct pattern * mk_pattern_var(char * var, enum pvar pvar);
struct pattern * mk_wildcard(enum wildcard wildcard);
