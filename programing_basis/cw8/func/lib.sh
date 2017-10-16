#!/usr/bin/env bash

function printAuthor() {
    echo "Author: Łukasz Piłatowski (VanDavv)"
}

function sum() {
    bc <<< "$1 + $2"
}

function matchAndCount() {
    echo "$1" | grep -o "$2" | wc -l
}

function createTable() {
    read -p "n: " n

    let counter=0
    table=()

    while(( $counter < $n ));
    do
        read -p "Dodaj: " a
        let table[counter]=a
        let counter=counter+1
    done
}

function tableAvg() {
    let result=0
    for i in "${table[@]}"
    do
        let result+=i
    done
    bc <<< "scale=2; $result / ${#table[@]}"
}

function tableMultiplyByScalar() {
    read -p "a: " a
    let counter=0
    result=()
    for i in "${table[@]}"
    do
        let result[counter]=i*a
        let counter+=1
    done
    echo "${result[@]}"
}

function tablesMultiply() {
    result=()
    if [ "${#table1[@]}" != "${#table2[@]}" ]; then
        echo "wektory nie są tych samych rozmiarów"
    else
        for i in "${!table1[@]}"
	do
	    let result[i]=table1[i]*table2[i]
	done
	echo "${result[@]}"
    fi

}
