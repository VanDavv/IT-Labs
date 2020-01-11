kompilacja:
gcc test.c -lgomp -fopenmp -O3

testowanie opcji schedule przez wywołanie ze zmienną środowiskową OMP_SCHEDULE możliwe jak schedule(runtime) ma wpisane runtime:
env OMP_SCHEDULE="static,8" ./a.out                               //to jest rownoznaczne z wpisaniem w kodzie klauzuli: schedule(static, 8)
env OMP_SCHEDULE="dynamic,8" ./a.out 
env OMP_SCHEDULE="guided,8" ./a.out 
env OMP_SCHEDULE="auto" ./a.out 

