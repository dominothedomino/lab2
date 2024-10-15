    .ORIG x3000
    
; Name: Lonoehu Wacasey
; Date: 10/14/2024
; Lab #2
;

; BLOCK 1
; Register R0 is loaded with x7500.
; Register R1 is loaded with the address of the location where the number is located.
; 

	LD R0,PTR
	LDR R1, R0, #0
; 
; The two 8-bit numbers are now loaded into R1.

    LDR R1, R1, #0

    
    
; BLOCK 2
; In this block, the two unsigned numbers in bits [15:8] and [7:0] on register R1, are first isolated by using masks.
; Mask1 is loaded into R4. The mask is then used to isolate Number 1, which is then loaded into R2.
; Mask2 is loaded into R4. The mask is then used to isolate Number 2, which is then loaded into R3.
; 
; 
	LD R4, MASK1
	AND R2, R1, R4  ;masks and loads number 1 into R2

	LD R4, MASK2
	AND R3, R1, R4  ;masks and loads number 2 into R3, but into bits [15:8]

; BLOCK 3
; In this block Number 2 is rotated so that the bits are in R3[7:0].

    AND R7, R7, #0
    ADD R7, R7, #8  ;clears r7 so that it can be designated as a counter to count the shifts we need to make
    
    AND R4, R4, #0
    LD R4, OFCHK    ;clears r4 and loads in a number which we can use to detect overflow

RGHTSHFT
    AND R5, R5, #0
    AND R5, R4, R3  ;clears r5 and then checks if rightmost value of number 2 is a 1
    BRZ NOONE
    BR  HAYONE
    
NOONE
    ADD R3, R3, R3  ;if no 1 in the MSB, we shift the values of number 2 to the right, causing a 0 in the LSB
    BR COUNTER
    
HAYONE
    ADD R3, R3, R3  ;if there is a 1 in the MSB, we shift number 2 to the right and then add 1
    ADD R3, R3, #1
    BR COUNTER

COUNTER
    ADD R7, R7, #-1 ;negates counter by 1, if we are down to zero, we have fully shifted the number, otherwise restart
    BRZ BLK4
    BR RGHTSHFT





; BLOCK 4
; The numbers are added. The result is stored at the location whose address is in x750A.

BLK4
    AND R4, R4, #0  ;clears r4 and then stores the addition of the two numbers there
    ADD R4, R2, R3
    LD R6, PTR2
    LDR R6, R6, #0  ;loads r6 with the address location in x750A
    STR R4, R6, #0  ;stores the addition of numbers in that location
    HALT
    
    
PTR     .FILL   x7500
MASK1	.FILL	x00FF
MASK2	.FILL	xFF00
OFCHK   .FILL   x8000
PTR2    .FILL   x750A

    .END