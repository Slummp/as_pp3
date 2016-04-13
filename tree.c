#include "tree.h"



/*
    Créer un attribut
*/
struct attributes * new_attributes (char* key, char* value){
    struct attributes *attr = malloc(sizeof(*attr));
    attr->key = key;
    attr->value = value;
    attr->next = NULL;
    return attr;
}
/*
    Supprime un attribut
*/
void delete_attribute (struct attributes *attr){
    struct attributes *tmp = attr;
    while (attr != NULL) {
        free(attr->key);
        free(attr->value);
        tmp = attr;
        attr = attr->next;
        free(tmp);
    }
}
/*
    Créer un arbre de type mot
*/
struct tree * new_word (char* label, bool space){
    struct tree *t = malloc(sizeof(*t));
    t->label = label;
    t->daughters = NULL;
    t->right = NULL;
    t->space = space;
    t->nullary = true;
    return t;
}
/*
    Supprime un arbre de type mot
*/
void delete_word (struct tree *t){
    free(t->label);
    free(t);
}
/*
    Créer un arbre de type balise 
*/
struct tree * new_balise (char* label, bool space){
    struct tree *t = malloc(sizeof(*t));
    t->label = label;
    t->daughters = NULL;
    t->right = NULL;
    t->space = space;
    t->nullary = true;
    return t;
}
