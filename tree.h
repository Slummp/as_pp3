#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#ifndef TREE_H
#define TREE_H
struct tree;
struct attributes;
enum type {tree, word};        //typage des nœuds: permet de savoir si un nœud construit
                               //un arbre ou s'il s'agit simplement de texte

struct attributes{
    char * key;               //nom de l'attribut
    char * value;             //valeur de l'attribut
    struct attributes * next; //attribut suivant
};

struct tree {
    char * label;              //étiquette du nœud
    bool nullary;              //nœud vide, par exemple <br/>
    bool space;                //nœud suivi d'un espace
    enum type tp;              //type du nœud. nullary doit être true si tp vaut word
    struct attributes * attr;  //attributs du nœud
    struct tree * daughters;   //fils gauche, qui doit être NULL si nullary est true
    struct tree * right;       //frère droit
};



/*
    Créer un attribut
*/
struct attributes * new_attributes (char*, char*);
/*
    Supprime un attribut
*/
void delete_attribute (struct attributes*);
/*
    Créer un arbre de type mot
*/
struct tree * new_word (char*, bool);
/*
    Supprime un arbre de type mot
*/
void delete_word (struct tree *);
/*
    Créer un arbre de type balise 
*/
struct tree * new_balise (char* label, bool space);
#endif
