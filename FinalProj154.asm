;------------------------------------------------------------
; CMPR 154 - Fall 2023
; CHAR-izard
; Ethan Nguyen, Dawson Pham
; CMPR - 154 - Fall 2023
; November 13, 2023
; Collaboration : None
;----------------------------------------------------------

INCLUDE Irvine32.inc

.data
    userMsg BYTE "Please enter your username: ", 0

    userStatName BYTE "Player Name: ", 0

    Pname BYTE 15 DUP(?)

    balance DWORD 0
    MAX_ALLOWED DWORD 20
    amount DWORD 0
    correctGuesses DWORD 0
    missedGuesses DWORD 0
    gamesPlayed DWORD 0
    profit DWORD 0
    earn DWORD 0
    loss DWORD 0
    name BYTE 16 DUP(?)
    randomNum DWORD ?
    teamNameMsg BYTE "*** CHAR-izard ***", 0
    menuMsg BYTE "*** MAIN MENU  ***", 0
    selectMsg BYTE "PLEASE SELECT ONE OF THE FOLLOWING:", 0
    option1Msg BYTE "   1: DISPLAY MY AVAILABLE CREDIT", 0
    option2Msg BYTE "   2: ADD CREDIT TO MY ACCOUNT", 0
    option3Msg BYTE "   3: PLAY THE GUESSING GAME", 0
    option4Msg BYTE "   4: DISPLAY MY STATISTICS", 0
    option5Msg BYTE "   5: TO EXIT", 0

    guessMsg BYTE "Guess a number between 1 and 10: ", 0
    correctGuessMsg BYTE "Congratulations! You guessed correctly.", 0
    wrongGuessMsg BYTE "Sorry, wrong guess. The correct number was ", 0
    playAgainMsg BYTE "Do you want to play again? (y/n): ", 0ah, 0
    maxAllowedMsg BYTE "Amount exceeds the maximum allowed.", 0
    statsMsg BYTE "Statistics", 0
    statsMsg2 BYTE "**********************", 0
    balMsg BYTE "Balance: ", 0
    gamesPlayedMsg BYTE "Games Played: ", 0
    corMsg BYTE "Correct Guesses: ", 0
    incorMsg BYTE "Incorrect Guesses: ", 0
    availBal BYTE "Available Balance: $", 0
    moneyWonMsg BYTE "Money Won: $", 0
    moneyLostMsg BYTE "Money Lost: -$", 0

    insufficientFundsMsg BYTE "Insufficient funds. Please add more credits to balance.", 0

    pressEnterMsg BYTE "Press Enter to continue...", 0ah, 0

    exitMsg BYTE "Press any key to exit...", 0

    invalidChoiceMsg BYTE "Invalid choice. Please enter a number between 1 and 5.", 0
    invalidGuessMsg Byte "Invalid input. Please enter a number 1 through 10.", 0
    invalidYorNMsg BYTE "Invalid input. Please enter either 'y' or 'n'.", 0

    playerGuess DWORD ?
    creditsToAdd DWORD ?

    invalidAmountMsg BYTE "Invalid amount of credits entered.", 0

    seed dd 0   ; seed for the random number generator

    inputPrompt BYTE "Enter the amount to add: ", 0
    creditsAddedMsg BYTE "Credits added successfully.", 0

.code

main PROC
    ;Initialize Irvine32 library
    ;call Clrscr
    ;mov balance, 0
    ;mov MAX_ALLOWED, 20

    mov edx, OFFSET userMsg
    call WriteString

    mov edx, OFFSET Pname
    mov ecx, SIZEOF Pname
    call ReadString

    call Clrscr
main ENDP

mainLoop:
    ; Display team name and main menu
    mov edx, OFFSET teamNameMsg
    call WriteString
    call Crlf
    call Crlf
    mov edx, OFFSET menuMsg
    call WriteString
    call Crlf
    call Crlf
    mov edx, OFFSET selectMsg
    call WriteString
    call Crlf
    call Crlf
    mov edx, OFFSET option1Msg
    call WriteString
    call Crlf
    mov edx, OFFSET option2Msg
    call WriteString
    call Crlf
    mov edx, OFFSET option3Msg
    call WriteString
    call Crlf
    mov edx, OFFSET option4Msg
    call WriteString
    call Crlf
    mov edx, OFFSET option5Msg
    call WriteString
    call Crlf
    call Crlf

    ; Read the user's choice
    call ReadInt
    mov amount, eax

    cmp amount, 1
    je displayBalance
    cmp amount, 2
    je addCredits
    cmp amount, 3
    je playGame
    cmp amount, 4
    je displayStatistics
    cmp amount, 5
    je exitProgram

    ; If none of the options are selected, display an error message
    mov edx, OFFSET invalidChoiceMsg
    call WriteString
    call Crlf
    jmp mainLoop

displayBalance:
    ; Display available balance
    call Crlf
    mov edx, OFFSET availBal
    call WriteString
    mov eax, balance
    call WriteDec
    call Crlf
    call Crlf
    jmp mainLoop

addCredits:
    ; Add credits to the account
    call Crlf
    mov edx, OFFSET option2Msg
    call WriteString
    call Crlf

    ; Read the credits to be added
    mov edx, OFFSET inputPrompt
    call WriteString
    call ReadInt
    mov creditsToAdd, eax

    ; Check if the entered value is less than 1
    cmp creditsToAdd, 1
    jl invalidAmount

    ; Check if the total credits exceed the maximum allowed
    mov eax, creditsToAdd
    add eax, balance
    cmp eax, MAX_ALLOWED
    ja amountExceeded

    ; Update the balance
    mov eax, creditsToAdd
    add balance, eax

    ; Display a success message
    mov edx, OFFSET creditsAddedMsg
    call WriteString
    call Crlf
    call Crlf
    jmp mainLoop

amountExceeded:
    mov edx, OFFSET maxAllowedMsg
    call WriteString
    call Crlf
    jmp mainLoop

invalidAmount:
    ; Display an error message for invalid amount
    mov edx, OFFSET invalidAmountMsg
    call WriteString
    call Crlf
    call Crlf
    jmp addCredits ; Jump back to the addCredits section to allow the user to enter a valid amount

playGame:
    ; Play the game
    sub balance, 1 ; lose $1 due to cost of playing

    mov eax, balance
    cmp eax, 0
    jl  InsufficientFunds
    jmp PlayGuessingGame

    ;call PlayGuessingGame

InsufficientFunds:
    ; Display a message indicating insufficient funds
    add balance, 1
    mov edx, OFFSET insufficientFundsMsg
    call WriteString
    call Crlf
    jmp addCredits  ; Return to the main loop

displayStatistics:
    ; Display user statistics
    ;call Crlf
    call Crlf
    mov edx, OFFSET statsMsg
    call WriteString
    call Crlf
    mov edx, OFFSET statsMsg2
    call WriteString
    call Crlf

    mov edx, OFFSET userStatName
    call WriteString
    mov edx, OFFSET Pname
    call WriteString
    call Crlf

    mov edx, OFFSET balMsg
    call WriteString
    mov eax, balance
    call WriteDec
    call Crlf

    mov edx, OFFSET gamesPlayedMsg
    call WriteString
    mov eax, correctGuesses
    mov ebx, missedGuesses
    add eax, ebx
    mov gamesPlayed, eax
    call WriteDec
    call Crlf

    mov edx, OFFSET corMsg
    call WriteString
    mov eax, correctGuesses
    call WriteDec
    call Crlf

    mov edx, OFFSET incorMSg
    call WriteString
    mov eax, missedGuesses
    call WriteDec
    call Crlf

    ; Display money won and lost
    ; ...
    mov edx, OFFSET moneyWonMsg
    call WriteString
    mov eax, earn
    call WriteDec
    call Crlf

    mov edx, OFFSET moneyLostMsg
    call WriteString
    mov eax, loss
    call WriteDec
    call Crlf

    ; Wait for the user to press Enter
    mov edx, OFFSET pressEnterMsg
    call WriteString
    call Crlf
    call ReadChar
    call Crlf
    jmp mainLoop

exitProgram:
    ; Exit the program
    call Crlf
    mov edx, OFFSET exitMsg
    call WriteString
    call ReadChar
    ret

PlayGuessingGame PROC
    ; Implementation of the game logic
    call Crlf
    mov edx, OFFSET guessMsg
    call WriteString

    ; Loop for input validation
    InputLoop:
        call ReadInt
        mov playerGuess, eax

        ; Check if the guess is within the valid range (1 to 10)
        cmp playerGuess, 1
        jl  InvalidGuess   ; Jump to InvalidGuess if less than 1
        cmp playerGuess, 10
        jg  InvalidGuess   ; Jump to InvalidGuess if greater than 10

        ; If the guess is valid, exit the loop
        jmp InputValid


    InvalidGuess:
        ; Display an error message
        mov edx, OFFSET invalidGuessMsg
        call WriteString
        call Crlf
        jmp PlayGuessingGame  ; Repeat the input loop

    InputValid:
        ; Create a random number between 1 and 10
        ; Set up the seed for the random number generator
        call GetTickCount    ; Get current tick count for seeding
        mov seed, eax

        ; Generate a random number between 1 and 10
        call generateRandom
        add eax, 1           ; adjust the range to 1-10

        ; Store the random number in the DWORD variable
        mov randomNum, eax

        ; Check if the guess is correct
        mov eax, playerGuess
        cmp eax, randomNum
        je  CorrectGuess
        jmp WrongGuess

generateRandom:
    ; This function generates a random number between 1 and 10 and returns it in the EAX register

    ; Get the current system time as a seed
    invoke GetTickCount
    mov seed, eax

    ; Use the seed value to generate a new random number
    mov eax, seed
    imul eax, 1103515245
    add eax, 12345
    mov seed, eax

    ; Initialize edx to 0 before the division
    xor edx, edx

    ; Load divisor (10) into ecx
    mov ecx, 10

    ; Take the remainder when divided by 10
    div ecx     ; Divide by 10

    ; Add 1 to adjust the range to 1-10
    add eax, 1

    ; Use the result modulo 10 to ensure the final number is in the range 1-10
    mov edx, 0
    mov ebx, eax
    mov eax, ebx
    div ecx

    ; The result is in edx after the division
    mov eax, edx

    ret

CorrectGuess:
    ; Update for correct guess
    add correctGuesses, 1
    add earn, 2
    add balance, 2  ; Credit the user account $2
    mov edx, OFFSET correctGuessMsg
    call WriteString
    call Crlf
    jmp playAgain  ; Jump to PlayAgain

WrongGuess:
    ; Update for wrong guess
    add missedGuesses, 1
    add loss, 1
    mov edx, OFFSET wrongGuessMsg
    call WriteString
   
    mov eax, randomNum
    call WriteDec
    call Crlf

PlayAgain:
    ; Ask the user if they want to play again
    mov edx, OFFSET playAgainMsg
    call WriteString
    call ReadChar
    cmp al, 'y'
    je  playGame  ; Jump back to playGame if 'y'
    cmp al, 'n'
    je  mainLoop   ; Jump to mainLoop if 'n'
    jmp WrongInput ; If neither 'y' nor 'n', ask again

WrongInput:
    ; redirects to PlayAgain if input is neither 'y' or 'n'
    mov edx, OFFSET invalidYorNMsg
    call WriteString
    ;call ReadString
    call Crlf
    call Crlf
    jmp PlayAgain

PlayGuessingGame ENDP

END main