ORG 0
JMP 100
ORG 100
	
MOV R6, #0FEh			; setting mask (1110) for the beacons
calc:
    MOV R5, #002h		; setting counter for loop_C = 2
    loop_C:
        MOV R4, #0D1h		; setting counter for loop_B = 209
        loop_B:
            MOV R3, #0FFh	; setting counter for loop_A = 255 (total loops count = 2 * 209 * 255 = 106590)
            loop_A:
                DEC R3		; step in loop_A
                MOV A, R3
            JNZ loop_a		; if counter for loop_A > 0, repeat
            DEC R4		; step in loop_B
            MOV A, R4
        JNZ loop_B		; if counter for loop_B > 0, repeat
        DEC R5			; step in loop_C
        MOV A, R5
    JNZ loop_C			; if counter for loop_C > 0, repeat
MOV P2, R6			; light up the diodes using mask (P2 registry holds information of which diode to light up)
MOV A, R6			; rotation can be only made on A registry, so move current mask there
RR A				; rotate right (e.x. mask 1110 will become 0111)
MOV R6, A			; transfer calculated mask back to registry
JMP calc			; repeat program with updated mask
END
