org 7C00h
bits 16
mov ax,7bB0h
mov ss,ax
mov sp,0xffff

mov bx,ver
call print
jmp command

ver:
	db "badasmOS 0.0",0
sys_prompt:
	db "sys:",0
newline:
	db 0dh,0ah,0
wrong_command:
	db "Commands not added yet!",0

command:
	mov bx,newline
	call print
	mov bx,wrong_command
	call print
	mov bx,newline
	call print
	mov bx,sys_prompt
	call print
	jmp main
main:
	call input_char
	cmp al,0dh
	je command
	mov ah,0eh
	int 10h
	jmp main
input_char:
	mov ah,0
	int 16h
	ret 
print:
	mov ah,0eh
	mov al,[bx]
	int 10h
	inc bx
	mov al,[bx]
	or al,al
	jnz print
	ret

times 510-($-$$) db 0 
dw 0xAA55  
