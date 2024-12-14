.model small
.stack 100h
.data 
    KEY db 13 
    xorKey db 5   
    buffer db 50              
    entered_length db 0       
    input_area db 49 dup('$') 
    newline db 13, 10, '$'    
    result db 50 dup('$')
    a db 17
    b db 20
    m db 26
    xor_output db ?
    msg_input db "Enter a string: $"
    msg_output db "The encoded string is: $"
    msg_choice db "Choose cipher: 1. ROT 2. Affine 3. XOR : $"
    msg_invalid_choice db "Invalid choice. $"
    msg_cipher_choice db "Choice: $"
    
;--------------------------------------------------------------------------------

.code
main proc far
    mov ax, @data
    mov ds, ax
    mov ax,0000
    
     
    lea dx, msg_input
    mov ah, 09h
    int 21h

    ; Accept input string
    lea dx, buffer
    mov ah, 0Ah
    int 21h
     
    lea dx, newline
    mov ah, 09h
    int 21h    
    
    ; Display choice prompt: Choose cipher: 1. ROT 2. Affine 3. XOR
    lea dx, msg_choice
    mov ah, 09h
    int 21h
    
    ; Accept user choice for cipher
    mov ah, 01h          
    int 21h        
    
    mov bl,al
    
    lea dx, newline
    mov ah, 09h
    int 21h    
    
    mov al,bl
    
    cmp al, '1'         
    je apply_rot
    cmp al, '2'         
    je apply_affine
    cmp al, '3'         
    je apply_xor   
    


    ; If invalid input, display invalid message
    lea dx, msg_invalid_choice
    mov ah, 09h
    int 21h
    jmp end_program
    
;--------------------------------------------------------------------------------

apply_rot:
    
    lea dx, msg_output
    mov ah, 09h
    int 21h

    lea si, input_area        
    mov cl, entered_length    
    
    
loop_rot:
    mov al, [si]             
    cmp al, 0Dh              
    je done_loop_rot        
    
    call rotate_char
    

print_rot:
    mov dl, al               
    mov ah, 02h              
    int 21h

    inc si                   
    loop loop_rot
    

done_loop_rot:
    lea dx, newline
    mov ah, 09h
    int 21h
    jmp end_program
    
;-------------------------------------
    
apply_affine:
    lea dx, msg_output
    mov ah, 09h
    int 21h

    lea si, input_area        
    mov cl, entered_length   
    lea di, result
    
    
loop_affine:
    mov al, [si]             
    cmp al, 0Dh              
    je done_loop_affine   
    
    call affine_cipher;;;;;;;;;;;;;;;;affine

    
print_affine:
    mov dl, al               
    mov ah, 02h              
    int 21h

    inc si                   
    loop loop_affine        

    
done_loop_affine:
    lea dx, newline
    mov ah, 09h
    int 21h
    jmp end_program
    
;-------------------------------------

apply_xor:
    ; Display output message for XOR
    lea dx, msg_output
    mov ah, 09h
    int 21h

    ; Perform XOR operation
    lea si, input_area        
    lea di, xor_output        
    mov cl, entered_length    
    
xor_loop:
    mov al, [si]             
    cmp al, 0Dh               
    je done_xor_loop          
    
    xor al, xorKey            
    mov [di], al              
    inc si                    
    inc di                    
    loop xor_loop             

done_xor_loop:
    
    mov byte ptr [di], '$'

    
    lea dx, xor_output       
    mov ah, 09h               
    int 21h                   
    
    lea dx, newline           
    mov ah, 09h
    int 21h

    jmp end_program           
    
;--------------------------------------------------------------------------------

rotate_char proc
check_upper:
    cmp al, 'A'            
    jl final
    cmp al, 'Z'
    jg check_lower
    
    sub al, 'A'
    cmp al, KEY
    jnge upper_char_less_than_key    
    add al, KEY
    mov cl, 26
    sub al, cl
    add al, 'A'
    ret

check_lower:
    cmp al, 'a'              
    jl final
    cmp al, 'z'
    jg final
    
    sub al, 'a'
    cmp al, KEY
    jnge lower_char_less_than_key
    add al, KEY
    mov cl, 26
    sub al, cl
    add al, 'a'
    ret

upper_char_less_than_key:
    add al, KEY
    add al, 'A'
    ret

lower_char_less_than_key:
    add al, KEY
    add al, 'a'
    ret
final:
    ret
rotate_char endp

;-------------------------------------

affine_cipher proc
    cmp al, 'A'
    jl skip_affine
    cmp al, 'Z'
    jg check_lowercase

    sub al, 'A'            
    mov bl, [a]            
    mov ah, 0              
    imul bl                
    add al, [b]           
    mov bl, [m]            
    div bl                 
    mov al, ah             
    add al, 'A'            
    jmp affine_done

check_lowercase:
    cmp al, 'a'
    jl skip_affine
    cmp al, 'z'
    jg skip_affine

    ; Handle lowercase
    sub al, 'a'            
    mov bl, [a]            
    mov ah, 0              
    imul bl                
    add al, [b]           
    mov bl, [m]            
    div bl                 
    mov al, ah             
    add al, 'a'            

skip_affine:
    ret

affine_done:
    ret
affine_cipher endp

;-------------------------------------




end_program:
    mov ax, 4C00h
    int 21h
end main
