; Author : Matthew Romleski
; Tech ID: 12676184
; Program to add together all the odd numbers from 1 to 100 (essentially 1 to 99).

		.include <atxmega128A1Udef.inc>
		
		.dseg
		.def	oddNumber = r16		; Naming registers to be more convenient.
		.def	sumLowBit = r17		; ^^
		.def	sumHighBit = r18	; ^^
		.def	zeroRegister = r19	; ^^

		.cseg
		.org	0x00
		rjmp	start
		.org	0xF6

start:	ldi		oddNumber, 1	; Set starting values
		ldi		sumLowBit, 1	; ^^
		ldi		sumHighBit, 0	; ^^
		ldi		zeroRegister, 0	; ^^

loop:	inc		oddNumber
		inc		oddNumber ; These two "inc"s add 2 to the current odd number (1->3, 3->5, etc).
		add		sumLowBit, oddNumber
		brcc	loopCon ; Jumps to the loop condition if there's no carrying to be done.
carry:	adc		sumHighBit, zeroRegister ; Adds sumHighBit + 0 + carry
		clc

loopCon:cpi		oddNumber, 99 ; Compares the current oddNumber to see if it's reached the 
                             // loop condition (oddNumber >= 99). If it has, Z=1 in the SREG.
		brne	loop ; Continues the loop if Z=0 in the SREG. 
		jmp		done

done:	rjmp	done