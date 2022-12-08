declare -a emberek
declare -a azonosito
declare -a menu

help() {
   echo "Lekérdezés funkciói"
   echo
   echo "Lehetőségek:"
   echo "------------------------------------"
   echo "-e     Kilépés a lekérdezésből"
   echo "an     Anyja neve"
   echo "ap     Apja neve"
   echo "sz     Születési idő/hely"
   echo "l      Lakcím"
   echo "fn     Felesége(i)/férje(i) neve"
   echo "gy     Gyerekei"
   echo "h      Halálozási idő"
   echo "------------------------------------"
}

lekerdezes() {
    i=1
    while [ $i -eq 10000 ]
            do
                read -p "${menu[$1-1]} hozzátartozóinak lekérdezése!: " valasztas

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
                        menu
                fi   
                if [ $valasztas == "ap" ]
                    then
                        menu
                fi    
                if [ $valasztas == "sz" ]
                    then
                        menu
                fi    
                if [ $valasztas == "l" ]
                    then
                        menu
                fi      
                if [ $valasztas == "fn" ]
                    then
                        menu
                fi      
                if [ $valasztas == "gy" ]
                    then
                        menu
                fi      
                if [ $valasztas == "h" ]
                    then
                        menu
                fi   
        done
    
    

    for z in ${!emberek[@]}
        do 
            ell=$(echo "${emberek[$z]}" | cut -d ":" -f 1)
            if [ $ell == "n" ]
                then
                azonosito+=("$(echo "${emberek[($z-1)]}" | cut -d ":" -f 2)")
                menu+=("$(echo "${emberek[$z]}" | cut -d ":" -f 2)")
            fi
    done
    
}

menu() {
    unset emberek
    readarray -t emberek < emberek.txt

    for z in ${!emberek[@]}
        do 
            ell=$(echo "${emberek[$z]}" | cut -d ":" -f 1)
            if [ $ell == "n" ]
                then
                azonosito+=("$(echo "${emberek[($z-1)]}" | cut -d ":" -f 2)")
                menu+=("$(echo "${emberek[$z]}" | cut -d ":" -f 2)")
            fi
    done
    
    y=1
    for z in ${!menu[@]}
        do 
            echo "$y. ${menu[$z]}"
            echo "$y. ${azonosito[$z]}"
            ((y++))
        done
    echo "$y. Kilépés"
    read -p "Kérjük válasszon!: " valasztas
    if [ $valasztas -eq $y]
        then
        exit
    fi
    lekerdezes "$valasztas"
}











menu
