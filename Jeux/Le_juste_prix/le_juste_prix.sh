#!/bin/bash

#Choix du niveau de difficulté
function diff_choice()
{
    echo -e "Choisissez le niveau de difficulté \n 1 - Facile \n 2 - Moyen \n 3 - Difficile"
    read choix_nb
    case $choix_nb in
        "1" | "facile" | "Facile" | "f" | "F")
            echo "Niveau de difficulté choisi : Facile"
            diff="f";;
        "2" | "moyen" | "Moyen" | "m" | "M" )
            echo "Niveau de difficulté choisi : Moyen"
            diff="m";;
        "3" | "difficile" | "Difficile" | "d" | "D" )
            echo "Niveau de difficulté choisi : Difficile"
            diff="d";;
    esac
}

#Générer un nombre entre 1 et 100
function random_number_funct()
{
    diff_choice
    if [[ "$diff" == "f" ]]; then
        random_number=$((1 + RANDOM % 50))
        nb_tentatives=15
        echo "Vous avez $nb_tentatives tentatives"
    elif [[ "$diff" == "m" ]]; then
        random_number=$((1 + RANDOM % 100))
        nb_tentatives=10
        echo "Vous avez $nb_tentatives tentatives"
    elif [[ "$diff" == "d" ]]; then
        random_number=$((1 + RANDOM % 500))
        nb_tentatives=7
        echo "Vous avez $nb_tentatives tentatives"
    fi
}


function get_number()
{
    read entered_number
}

function le_juste_prix()
{
    #Initialisation
    cpt=0
    worked=false
    nb_tentatives=0

    echo "Bienvenu dans notre jeu 'Le juste prix', vous avez 5 chances pour trouver le bon nombre. Aurez-vous le juste prix ?"

    #Nombre des tentatives en fct du niveau de diff
    random_number_funct

    for((i=1;i<=$nb_tentatives;i++)); 
    do
        echo "Entrez un nombre"
        get_number
        regex_number="^[0-9]+$"
        if  [[ $entered_number =~ $regex_number ]]; then
            if (($entered_number == $random_number)); then
                echo "Félicitation ! vous avez trouver le juste prix *$random_number* en *$cpt* coups"
                worked=true
                exit
            elif (($entered_number > $random_number)); then
                echo "Trop haut!"
            elif (($entered_number < $random_number)); then
                echo "Trop bas!"
            fi
            cpt=$(($cpt+1))
        else 
            echo "N'est pas un nombre"
        fi
    done

    #Si pas trouvé le juste prix
    if [ "$worked" = false ]; then
        echo "Perdu..."
    fi 
}

le_juste_prix
