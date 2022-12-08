declare -a emberek

beolvasas(){
    unset emberek
    readarray -t emberek < emberek.txt
}





menu() {
    declare -a menu

    for z in ${!emberek[@]}
        do 
            echo ${emberek[$z]}
            ell=$(echo "${emberek[$z]}" | cut -d ":" -f 1)
            if [ $ell == "n" ]
                then
                menu+=$(echo "${emberek[$z]}" | cut -d ":" -f 2)
            fi
    done
    
    j=1
    for z in ${menu[@]}
        do 
            echo "$j. $z"
            ((j++))
        done
    echo "$j. Kilepes"
}

#születési idő/hely), halálozási idő, lakcím, anyja, apja, gyerekei neve, felesége(i)/férje(i) neve
