;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Silke Behn	
;* Version            : V1.0
;* Date               : 03.01.2022
;* Description        : This is a simple main.
;					  :
;					  : Replace this main with yours.
;
;*******************************************************************************
    EXTERN initITSboard
    EXTERN lcdPrintS            ;Display ausgabe
    EXTERN GUI_init
	EXTERN TP_Init

;********************************************
; Data section, aligned on 4-byte boundery
;********************************************
	
	AREA MyData, DATA, align = 2
	
DEFAULT_BRIGHTNESS DCW  800

           EXPORT namen
namen      DCB "gerlinde  "
           DCB "gottfried "
		   DCB "gunhild   "
           DCB "gustav    "
		   DCB "horst     "
		   DCB "roderich  "
           DCB "roswitha  "
		   DCB "thusnelda "
		   DCB "tymoteusz ",0

key1       DCB "horst",0
key2       DCB "gerlinde",0
key3       DCB "tymoteusz",0

nKey1      DCB "gerhilde",0
nKey2      DCB "tussi",0
nKey3      DCB "vincent",0



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

        ;--- macht aus allen Blanks eine 0, so das echte Strings entstehen
        ldr r0,=namen
        bl removeBlank

        ;--- Lineare Suche ----------------------------------------------------   
        ; horst ist drin
        ldr r1,=namen  ; Adresse der Liste
        ldr r0,=key1   ; Adresse von "horst"
        mov r2,#9      ; 9 Elemente
        mov r3,#10     ; jedes 10 byte gross
        bl linsrch 

        ; gerlinde ist drin
        ldr r1,=namen  ; Adresse der Liste
        ldr r0,=key2  
        mov r2,#9      ; 9 Elemente
        mov r3,#10     ; jedes 10 byte gross
        bl linsrch 

        ; tymoteusz ist drin
        ldr r1,=namen  ; Adresse der Liste
        ldr r0,=key3  
        mov r2,#9      ; 9 Elemente
        mov r3,#10     ; jedes 10 byte gross
        bl linsrch 

        ; gerhilde ist nicht drin
        ldr r1,=namen  ; Adresse der Liste
        ldr r0,=nKey1  
        mov r2,#9      ; 9 Elemente
        mov r3,#10     ; jedes 10 byte gross
        bl linsrch 

        ; tussi ist nicht drin
        ldr r1,=namen  ; Adresse der Liste
        ldr r0,=nKey2  
        mov r2,#9      ; 9 Elemente
        mov r3,#10     ; jedes 10 byte gross
        bl linsrch 

        ; vincent ist drin
        ldr r1,=namen  ; Adresse der Liste
        ldr r0,=nKey3  
        mov r2,#9      ; 9 Elemente
        mov r3,#10     ; jedes 10 byte gross
        bl linsrch 



        ;--- Binaere Suche ----------------------------------------------------   
        ; horst ist drin
        ldr r1,=namen  ; Adresse der Liste
        ldr r0,=key1   ; Adresse von "horst"
        mov r2,#9      ; 9 Elemente
        mov r3,#10     ; jedes 10 byte gross
        bl bsrch 

        ; gerlinde ist drin
        ldr r1,=namen  ; Adresse der Liste
        ldr r0,=key2  
        mov r2,#9      ; 9 Elemente
        mov r3,#10     ; jedes 10 byte gross
        bl bsrch 

        ; tymoteusz ist drin
        ldr r1,=namen  ; Adresse der Liste
        ldr r0,=key3  
        mov r2,#9      ; 9 Elemente
        mov r3,#10     ; jedes 10 byte gross
        bl bsrch 

        ; gerhilde ist nicht drin
        ldr r1,=namen  ; Adresse der Liste
        ldr r0,=nKey1  
        mov r2,#9      ; 9 Elemente
        mov r3,#10     ; jedes 10 byte gross
        bl bsrch 

        ; tussi ist nicht drin
        ldr r1,=namen  ; Adresse der Liste
        ldr r0,=nKey2  
        mov r2,#9      ; 9 Elemente
        mov r3,#10     ; jedes 10 byte gross
        bl bsrch 

        ; vincent ist drin
        ldr r1,=namen  ; Adresse der Liste
        ldr r0,=nKey3  
        mov r2,#9      ; 9 Elemente
        mov r3,#10     ; jedes 10 byte gross
        bl bsrch 





forever	b	forever		; nowhere to retun if main ends		
		ENDP

; -------------------------------------------------------------
;   sucht binaer
;   Parameter     r0: Adresse des Suchschlüssels
;                 r1: Adresse des Arrays
;                 r2: Anzahl Elemente im Array
;                 r3: Groesse eines Elements
;   Return        : 0 fuer nicht gefunden
;                 : Adresse des gefundenen Elements sonst
; -------------------------------------------------------------
linsrch   PROC

; Variablen       
;    r4: Adresse des Suchschluessels
;    r5: Adresse des Arrays
;    r6: Anzahl der Elemente
;    r7: Groesse eines Elements
;    r8: Mitte des Arrays



          str r4,[sp,#-4]! ; Variablenregister
          str r5,[sp,#-4]! ; und linkregister retten
          str r6,[sp,#-4]!
          str r7,[sp,#-4]!
          str r8,[sp,#-4]!
          str lr,[sp,#-4]!


          cmp r2,#0 ; Liste leer?
          beq notfound
        
		  ; Parameter in Variablenregister kopieren
		  mov r4,r0 ; Adresse Suchschluessel 
		  mov r5,r1 ; Adresse des Arrays
		  mov r6,r2 ; Anzahl Elemente
          mov r7,r3 ; Groesse Element
          
          

; --------------- ToDo -------------------




;-----------------------------------------

notfound  mov r0,#0 ; nicht gefunden , daher 0 zurueckgeben

ende      ldr lr,[sp],#4 ; alles restaurieren
          ldr r8,[sp],#4
          ldr r7,[sp],#4
          ldr r6,[sp],#4
          ldr r5,[sp],#4
          ldr r4,[sp],#4
          bx lr
		  ENDP
			  


; -------------------------------------------------------------
;   sucht binaer
;   Parameter     r0: Adresse des Suchschlüssels
;                 r1: Adresse des Arrays
;                 r2: Anzahl Elemente im Array
;                 r3: Groesse eines Elements
;   Return        : 0 fuer nicht gefunden
;                 : Adresse des gefundenen Elements sonst
; -------------------------------------------------------------
bsrch   PROC

; Variablen       
;    r4: Adresse des Suchschluessels
;    r5: Adresse des Arrays
;    r6: Anzahl der Elemente
;    r7: Groesse eines Elements
;    r8: Mitte des Arrays



          str r4,[sp,#-4]! ; Variablenregister
          str r5,[sp,#-4]! ; und linkregister retten
          str r6,[sp,#-4]!
          str r7,[sp,#-4]!
          str r8,[sp,#-4]!
          str lr,[sp,#-4]!


          cmp r2,#0 ; Liste leer?
          beq notfound2
        
		  ; Parameter in Variablenregister kopieren
		  mov r4,r0 ; Adresse Suchschluessel 
		  mov r5,r1 ; Adresse des Arrays
		  mov r6,r2 ; Anzahl Elemente
          mov r7,r3 ; Groesse Element
          
          

; --------------- ToDo -------------------




;-----------------------------------------

notfound2  mov r0,#0 ; nicht gefunden , daher 0 zurueckgeben

ende2      ldr lr,[sp],#4 ; alles restaurieren
          ldr r8,[sp],#4
          ldr r7,[sp],#4
          ldr r6,[sp],#4
          ldr r5,[sp],#4
          ldr r4,[sp],#4
          bx lr
		  ENDP
			  
			  
;-------------------------------------------------
; Wandelt Blanks aus String in Nullen
; Parameter r0: Adresse des Strings
; Return      : void
;-------------------------------------------------
removeBlank  PROC
          mov r2,#0 ; initialisieren zum Nullen schreiben

while_rb  
          ldrb r3,[r0],#1 ; 1. Buchstaben holen
          cmp r3,#0 ; Stringende?
          beq endwhile_rb
do_rb
          cmp r3,#0x20       ; Leerzeichen ?
          streqb r2,[r0,#-1] ; Wenn ja dann durch 0 ersetzen
          b while_rb  
endwhile_rb

          bx lr
		  ENDP
			  
			  
;----------------------------------------------------
; Vergleicht zwei Strings, wird von Bsrch benoetigt
; Parameter   r0: Adresse des ersten Strings
;             r1: Adresse des zweiten Strings
; Return      r0: 0 wenn gleich 
;                 1 wenn r0 > r1
;                -1 wenn r0 < r1
;----------------------------------------------------
stcmp    PROC
       ; ToDo ---------------------
	   
	   
	   
	   
	   
fin       bx lr
          ENDP
			  
          ALIGN
          END
			  
