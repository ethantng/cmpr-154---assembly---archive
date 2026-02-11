;PART 1:
;1 Declare a 32-bit signed integer variable and initialize it to the smallest possible negative decimal value
    ;.data
    ;myVar DWORD -2147483648
;2 Declare an initialized array of 50 16-bit unsigned integer
    ;.data
    ;myArray WORD 0, 1, 2, 3, ...
;3. Add 2 to the content of the ecx register
    ;add ecx, 2
;4. Declare a string variable containing the word “Santiago Canyon College” repeated 10 times, and terminated with a null terminator
    ;.data
    ;myString db "Satiago Canyon College",0
;5. Write a constant expression that divides 10 by 3 and returns the remainder. Store the remainder in eax
    ;mov eax, 10
    ;mov ecx, 3   
    ;xor edx, edx     
    ;div ecx 
    
;Part 2:
;SCC DWORD 12345678h
    ;0004 -> 12h
    ;0003 -> 34h
    ;0002 -> 56h
    ;0001 -> 78h
;Memory Address 0001 has the least signficant bytes and 0004 has the most.

;Part 3:
    ;a)
        ;EAX: 00000002h
        ;AX: 0002h
        ;AL: 02h
    ;b)
        ;EAX: 00000009h 
        ;AX: 0009h
        ;AL: 09h
    ;c)
        ;EAX:00000058h
        ;AX: 0058h
        ;AL: 58h
    ;d)
        ;EAX: 404004h
        ;AX: 404004h
        ;AL:404004h
    ;e)
        ;EAX:40400h
        ;AX:40400h
        ;AL:40400h
    ;f)
        ;EAX: 40400h
        ;AX: 40400h
        ;AL: 40400h
    ;g)
        ;EAX: 302010h
        ;AX:2010h
        ;AL:10h
    ;h)
        ;EAX: N/A
        ;AX: N/A
        ;AL: ABh
    ;i)
        ;EAX: N/A
        ;AX: wval
        ;AL: wval
    ;j)
        ;EAX: dval
        ;AX:dval
        ;AL:dval
        
;Part 4:

section .data
    welcome_msg db "Welcome to this Calculator written in x86.", 10
                db "In this program we will help you add three integers.", 10, 10
                db "Please Enter your first integer: ", 0
    prompt1 db "Please Enter your second integer: ", 0
    prompt2 db "Please Enter your third integer: ", 0
    result_msg db "The total of these three integers is: ", 0
    exit_msg db "Thank you for using our program.", 10
             db "The program is now exiting ...", 10
             db "Good bye!", 10, 0

section .bss
    num1 resd 1
    num2 resd 1
    num3 resd 1
    sum resd 1

section .text
    global _start

_start:
 
    mov eax, 4
    mov ebx, 1
    mov ecx, welcome_msg
    mov edx, 100
    int 80h

input_loop:
 
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt1
    mov edx, 100
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 16
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, 100
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 16
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, prompt3
    mov edx, 100
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, num3
    mov edx, 16
    int 80h

    mov eax, [num1]
    add eax, [num2]
    add eax, [num3]
    mov [sum], eax

    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, 100
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, sum
    mov edx, 16
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, exit_msg
    mov edx, 100
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h
