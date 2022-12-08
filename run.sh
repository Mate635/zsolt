declare -a emberek
declare -a azonosito
declare -a menu


help() {
   echo "Lekérdezés funkciói"
   echo
   echo "Lehetőségek:"
   echo "------------------------------------"
   echo "-e     Kilépés a menübe!"
   echo "an     Anyja neve."
   echo "ap     Apja neve."
   echo "sz     Születési idő/hely."
   echo "l      Lakcím."
   echo "fn     Felesége(i)/férje(i) neve."
   echo "gy     Gyerekei."
   echo "h      Halálozási idő."
   echo "------------------------------------"
}

kereso() {
echo "$1"
echo "$2"
    talalt=0
    for z in ${!emberek[@]}
        do 
            adategy=$(echo "${emberek[$z]}" | cut -d ":" -f 1)
            adatketto=$(echo "${emberek[$z]}" | cut -d ":" -f 2)
            if [[ $adategy == "a" ]] && [[ ${azonosito[($1-1)]} == $adatadatketto ]]
                then
                keresettember=1
            fi
            if [[ $adategy == "a" ]] && [[ ${azonosito[($1-1)]} != $adatketto ]]
                then
                keresettember=0
            fi
            if [[ $keresettember == "1" ]]
                then
                if [ $2 = $adatketto ]
                    then
                    ((talalt++))
                    echo "${emberek[$z]}" | cut -d ":" -f 2
                fi
            fi            
    done
    if [ $talalt -eq 0 ]
        then
        echo "Nem találtam "
    fi
    lekerdezes
}

keresot() {
echo "$1"
echo "$2"
    talalt=0
    for z in ${!emberek[@]}
        do 
            adategy=$(echo "${emberek[$z]}" | cut -d ":" -f 1)
            adatketto=$(echo "${emberek[$z]}" | cut -d ":" -f 2)
            if [ $adategy = "a" ] && [ ${azonosito[$1-1]} = $adatadatkettoegy ]
                then
                keresettember=1
            fi
            if [ $adategy = "a" ] && [ ${azonosito[$1-1]} != $adatketto ]
                then
                keresettember=0
            fi
            if [ $keresettember -eq 1 ]
                then
                if [ $2 = $adatketto ]
                    then
                    ((talalt++))
                    echo "$talalt. ${emberek[$z]}" | cut -d ":" -f 2
                fi
            fi            
    done
    if [ $talalt -eq 0 ]
        then
        echo "Nem találtam!"
    fi
    lekerdezes
}

lekerdezes() {
    i=1
    szam=$1
    while [ $i -eq 1 ]
            do
                read -p "${menu[$szam-1]} hozzátartozóinak lekérdezése!: " valasztas
                if [ $valasztas == "-e" ]
                    then
                    menu
                fi   
                if [ $valasztas == "-h" ]
                    then                        
                    help
                fi   
                if [ $valasztas == "an" ]
                    then
                    echo -n "Anyja neve: "
                    kereso "$szam" "an"
                fi   
                if [ $valasztas == "ap" ]
                    then
                    echo -n "Apja neve: "
                    kereso "$szam" "ap"
                fi    
                if [ $valasztas == "sz" ]
                    then
                    echo -n "Születési idő/hely: "
                    kereso "$szam" "sz"
                fi    
                if [ $valasztas == "l" ]
                    then
                    echo -n "Lakcím: "
                    kereso "$szam" "l"
                fi      
                if [ $valasztas == "fn" ]
                    then
                    echo "Felesége(i)/férje(i) neve: "
                    keresot "$szam" "fn"
                fi      
                if [ $valasztas == "gy" ]
                    then
                    echo "Gyereke(i): "
                    keresot "$szam" "gy"
                fi      
                if [ $valasztas == "h" ]
                    then
                    echo -n "Halálozási idő: "
                    kereso "$szam" "h"
                fi  
                echo "Ilyen parancsot nem találtam kérlek használd a '-h'-t az opciók megjelenítésére!"
        done    
}

beolvasas() {
    unset emberek
    readarray -t emberek < emberek.txt

    for z in ${!emberek[@]}
        do 
            ell=$(echo "${emberek[$z]}" | cut -d ":" -f 1)
            if [ $ell = "n" ]
                then
                azonosito+=("$(echo "${emberek[($z-1)]}" | cut -d ":" -f 2)")
                menu+=("$(echo "${emberek[$z]}" | cut -d ":" -f 2)")
            fi
    done
    menu
}

menu() {    
    y=1

    for z in ${!menu[@]}
        do 
            echo "$y. ${menu[$z]}"
            #echo "$y. ${azonosito[$z]}"
            ((y++))
    done

    echo "$y. Kilépés"
    read -p "Kérjük válasszon!: " valasztas

    if [ $valasztas -eq $y ]
        then
        echo "Köszönjük hogy használta a programot!"
        exit
    fi

    lekerdezes "$valasztas"
}

beolvasas
