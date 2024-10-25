#!/bin/bash

#Générer un nombre entre 1 et 100
function random_number()
{
     is_not_nb=true
    regex_number="^[0-9]+$"
    while (($is_not_nb==true)); do
        echo "Quel intervalle souhaitez vous pour le nombre cible ?"
        read rnd_nb_range
        if ! [[ $rnd_nb_range =~ $regex_number ]]; then
            echo "Veuillez entrer un nombre"
        else 
            is_not_nb=false
            break
        fi
    done
    random_number=$((1 + RANDOM % $rnd_nb_range))
}


#Générer un tableau de 5 nombres entre 1 et 20
function random_number_tab()
{
    is_not_nb=true
    regex_number="^[0-9]+$"
    while (($is_not_nb==true)); do
        echo "Quel intervalle souhaitez vous pour les nombres ?"
        read rnd_nb_tab_range
        if ! [[ $rnd_nb_tab_range =~ $regex_number ]]; then
            echo "Veuillez entrer un nombre"
        else 
            is_not_nb=false
            break
        fi
    done
    for ((i=1; i<=5; i++)) do
            random_number_tab[${#random_number_tab[*]}]=$((1 + RANDOM % $rnd_nb_tab_range))
    done
}


#Fonction pour calculer les opérations
function operation()
{
    #Initialisation
    random_number
    random_number_tab
    compteur=1
    resultat=0

    echo "Bienvenu dans notre jeu 'Le compte est bon', vous avez 5 chances pour trouver le bon nombre. Aurez-vous le bon compte ?"

    while (($compteur <= 5 && $resultat != $random_number));
    do
        worked=false

        if (($resultat == 0)); then
            echo "coup $compteur : vos nombres : ${random_number_tab[*]}"
        fi
        if (($resultat != 0)); then
            echo "coup $compteur : vos nombres : ${random_number_tab[*]}, resultat : $resultat"
        fi
        
        #Récupérer les nombres et opération entrée par l'utilisateur
        read nb1 op nb2

        #Opérations valides
        case $op in
            "+" | "-")
                for i in ${!random_number_tab[@]}; 
                do
                    #Nombre 1 dans liste ou résultat
                    if (($nb1 == ${random_number_tab[$i]} || $nb1 == $resultat )); then
                        for j in ${!random_number_tab[@]}; 
                        do
                            #Nombre 2 dans liste ou résultat
                            if (($nb2 == ${random_number_tab[$j]} || $nb2 == $resultat)); then
                                resultat=$(($nb1 $op $nb2))   
                                compteur=$(($compteur+1))    
                                worked=true               
                                break 2 
                            fi
                        done                 
                    fi
                done   
            ;;
            "/")
            #Si division
            for i in ${!random_number_tab[@]}; 
            do
                #Nombre 1 dans liste ou résultat
                if (($nb1 == ${random_number_tab[$i]} || $nb1 == $resultat )); then
                    for j in ${!random_number_tab[@]}; 
                    do
                        #Nombre 2 dans liste ou résultat
                        if ((($nb2 == ${random_number_tab[$j]} || $nb2 == $resultat) && $nb2 != 0)); then
                            resultat=$(($nb1 $op $nb2))   
                            compteur=$(($compteur+1))
                            worked=true              
                            break 2                                     
                        fi
                    done                 
                fi
            done
            ;;   
            "*")
                for i in ${!random_number_tab[@]}; 
                do
                    #Nombre 1 dans liste ou résultat
                    if (($nb1 == ${random_number_tab[$i]} || $nb1 == $resultat )); then
                        for j in ${!random_number_tab[@]}; 
                        do
                            #Nombre 2 dans liste ou résultat
                            if (($nb2 == ${random_number_tab[$j]} || $nb2 == $resultat)); then
                                resultat=$(($nb1 $op $nb2))   
                                compteur=$(($compteur+1))    
                                worked=true               
                                break 2 
                            fi
                        done                 
                    fi
                done   
            ;;
            *) 
            echo "Mauvaise opération, veuillez réessayer." 
            ;;

        esac   
            
            if [ "$worked" = false ]; then
                echo "Mauvais nombres, veuillez réessayer."
            fi           
        
    done

    #Fin du jeu : Affichage du message de victoire ou d'échec
    nb_round=$(($compteur-1))

    if (($resultat == $random_number)); then
        echo "Le compte est bon ! vous avez trouvé *$random_number* en *$nb_round* coups."
    else
        echo "Perdu..."
    fi
}
operation