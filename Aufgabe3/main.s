;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Silke Behn	
;* Version            : V1.0
;* Date               : 01.06.2021
;* Description        : This is a simple main.
;					  :
;					  : Replace this main with yours.
;
;*******************************************************************************
    EXTERN initITSboard
	EXTERN GUI_init
	EXTERN TP_Init
    
	EXTERN lcdPrintS            ;Display Text Ausgabe
	EXTERN lcdPrintInt	        ;Display Ganzzahl Ausgabe
    

;********************************************
; Data section, aligned on 4-byte boundery
;********************************************
	
	AREA MyData, DATA, align = 2
	
	    GLOBAL text
DEFAULT_BRIGHTNESS DCW  800

;--- Testausgabe kann geloescht werden 	
text	DCB	"Hallo TI-Labor",0
;--- Ende kann geloescht werden

;--- Start eigene Variablen ----------------

;--- Ende eigene Variablen

;********************************************
; Code section, aligned on 8-byte boundery
;********************************************
	AREA |.text|, CODE, READONLY, ALIGN = 3

;--------------------------------------------
; main subroutine
;--------------------------------------------
	EXPORT main [CODE]
	
main	PROC
        BL initITSboard
		ldr r1, =DEFAULT_BRIGHTNESS
		ldrh r0, [r1]
		bl GUI_init
		mov r0, #0x00
		bl TP_Init
		
		
        ; ----Start eigener Code -------- 		
		
		
		;-----Ende eigener Code ----
		
		;---- Testausgabe kann geloescht werden
		LDR	r0,=text
        BL  lcdPrintS
		;---- Ende kann geloescht werden

forever	b	forever		; nowhere to retun if main ends		
		ENDP
	
	
	    ;------ Start eigene Funktionen --------------
		
	
	
	    
	    
		;----- Ende eigene Funktionen -----------
		ALIGN
       
		END