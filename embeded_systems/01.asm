ORG 0
JMP 100
ORG 100
MOV R6, #0FEh
calc:
    MOV R5, #002h
    loop_C:
        MOV R4, #0D1h
        loop_B:
            MOV R3, #0FFh
            loop_A:
                DEC R3
                MOV A, R3
            JNZ loop_a
            DEC R4
            MOV A, R4
        JNZ loop_B
        DEC R5
        MOV A, R5
    JNZ loop_C
MOV P2, R6
MOV A, R6
RR A
MOV R6, A
JMP calc
END
