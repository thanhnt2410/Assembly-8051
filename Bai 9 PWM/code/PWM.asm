;=================================
; tao xung vuong
;=================================
;tan so thach anh 11.0592MHz
;=================================
; su dung timer0 mode 2 de tao tan so xung vuong f=5kHz
;=================================
; org 0

;ljmp main
;org 0bh
;ljmp interupt_timer0
;org 800h
;main:
;mov tmod,#2
;mov tl0,#0Cah
;mov th0,#0Cah
;setb tr0		   ;
;setb et0			;
;setb ea				; 
;sjmp $
;interupt_timer0:
;cpl p0.5 ;dao chan p2.0
;reti
;end
	
;================================= 
; tao xung vuong voi nut nhan
;=================================
; tan so thach anh 11.0592MHz
;=================================
; su dung timer0 mode 2 de tao tan so xung vuong f=5kHz
;=================================

org 0
ljmp main

org 0bh
ljmp interupt_timer0

org 800h

main:
    mov tmod,#2          ; Timer0 mode 2
    mov tl0,#0cah
    mov th0,#0cah
    mov p2,#0            ; Kh?i t?o P2 = 0
    setb ea              ; Enable global interrupt
    setb et0             ; Enable Timer0 interrupt
    clr tr0              ; Kh?i d?u: Timer0 t?t

loop:
    jb p3.2, $           ; Ð?i nút nh?n
    call delay_debounce  ; Ch? ch?ng d?i
    jb p3.2, loop        ; N?u v?n cao, quay l?i d?i
    cpl tr0              ; Ð?o tr?ng thái Timer0 (b?t/t?t)
    jnb p3.2, $          ; Ð?i nh? nút
    call delay_debounce  ; Ch? ch?ng d?i
    sjmp loop

interupt_timer0:
    cpl p0.5             ; Ð?o tr?ng thái P2.0
    reti

delay_debounce:
    mov r7, #50
delay_loop:
    mov r6, #200
    djnz r6, $
    djnz r7, delay_loop
    ret

end