#!/bin/bash
if [ -z "$1" ] ; then
    read -p "a = " a;
else
    a=$1;
fi

re='^-?[0-9]+([.][0-9]+)?$'
if ! [[ $a =~ $re ]] ; then
   echo "$a nie jest liczbą" >&2; exit 1
fi

if [ -z "$2" ] ; then
    read -p "b = " b
else
    b=$2;
fi

if ! [[ $b =~ $re ]] ; then
   echo "$b nie jest liczbą" >&2; exit 1
fi

if [ -z "$3" ] ; then
    read -p "znak = " z
else
    z=$3;
fi

re='^(\+|\-|\*{1,2}|\/)$'
if ! [[ $z =~ $re ]] ; then
    if [[ "./$z" == "$0" ]] ; then
        echo "Pamiętaj żeby użyć \* zamiast *" >&2; exit 1
    else
        echo "$z nie jest obsługiwanym znakiem działania" >&2; exit 1
    fi
fi

case $z in
    \+ )
        echo "Suma dwóch liczb";
        echo "$a + $b" | bc | awk '{printf "a + b = %.2f \n", $0}';
        exit 0;
        ;;
    \- )
        echo "Różnica dwóch liczb";
        echo "$a - $b" | bc | awk '{printf "a - b = %.2f \n", $0}';
        exit 0;
        ;;
    \* )
        echo "Iloczyn dwóch liczb";
        echo "$a * $b" | bc | awk '{printf "a * b = %.2f \n", $0}';
        exit 0;
        ;;
    \/ )
        if [[ $b == 0 ]] ; then
            echo "Ja ci dam dzielić przez 0!" >&2; exit 1;
        else
            echo "Iloraz dwóch liczb";
            echo "scale=2; $a / $b" | bc | awk '{printf "a / b = %.2f \n", $0}';
            exit 0;
        fi
        ;;
    \*\* )
        echo "Potęgowanie dwóch liczb"
        echo "$a ^ $b" | bc | awk '{printf "a ** b = %.2f \n", $0}';
        exit 0;
        ;;
esac
exit 0
