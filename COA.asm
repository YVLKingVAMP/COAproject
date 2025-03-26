include irvine32.inc

.data
    ; Arrays for user IDs and passwords (max 10 users, 4 digits each)
    user_ids      DWORD   10 DUP(0)    ; Array of 10 DWORDs initialized to 0
    passwords     DWORD   10 DUP(0)    ; Array of 10 DWORDs initialized to 0
    user_count    DWORD   0            ; Number of registered users
    flight_price  DWORD   0            ;price of flight
    class_price   DWORD   0            ;price of class
    date          BYTE    ?            ;

    ; Prompts for main menu
    menu_prompt    BYTE  "1. Register",0dh,0ah,
                         "2. Login",0dh,0ah,
                         "3. Exit",0dh,0ah,
                         "Choice: ",0
    reg_id_prompt  BYTE  "Enter 4-digit User ID: ",0
    reg_pw_prompt  BYTE  "Enter 4-digit Password: ",0
    login_id_prompt BYTE "Enter 4-digit User ID: ",0
    login_pw_prompt BYTE "Enter 4-digit Password: ",0
    success_msg    BYTE  "Success!",0dh,0ah,0
    fail_msg       BYTE  "Failure!",0dh,0ah,0
    exists_msg     BYTE  "User ID already exists!",0dh,0ah,0
    invalid_msg    BYTE  "Must be 4 digits!",0dh,0ah,0
    invalid_choice BYTE  "Invalid choice",0dh,0ah,0

    ; Prompts for user submenu after login
    user_menu      BYTE  "1. Flight Booking",0dh,0ah,
                         "2. View Receipt",0dh,0ah,
                         "3. Make Payment",0dh,0ah,
                         "4. Exit",0dh,0ah,
                         "Choice: ",0
    booking_menu   BYTE  "Please select a flight: ",0dh,0ah,
                         "1. Kuala Lumpur - Beijing    RM1000",0dh,0ah,
                         "2.Kuala Lumpur - Los Angeles RM5000",0dh,0ah,
                         "3.Kuala Lumpur - Sarawak     RM100",0dh,0ah,
                         "4. Kuala Lumpur - Paris      RM2500",0dh,0ah,
                         "Choice: ",0
    class_menu     BYTE  "PLease select a class: ",0dh,0ah,
                         "Economy           RM0",0dh,0ah,
                         "Premium Economy   RM50",0dh,0ah,
                         "Business          RM100",0dh,0ah,
                         "First             RM1000",0dh,0ah,
                         "Choice: ",0
    date_menu      BYTE  "Please select a date: ",0dh,0ah,
                         "30 May 2025",0dh,0ah,
                         "2 August 2025",0dh,0ah,
                         "22 November 2025",0dh,0ah,
                         "2 December 2025",0dh,0ah,
                         "Choice: ",0

    receipt_msg    BYTE  "View Receipt Selected - Feature Under Development!",0dh,0ah,0
    payment_msg    BYTE  "Make Payment Selected - Feature Under Development!",0dh,0ah,0

.code
main proc
menu_loop:
    ; Display main menu
    mov edx, OFFSET menu_prompt 
    call WriteString
    
    ; Get choice
    call ReadDec
    cmp eax, 1
    je register
    cmp eax, 2
    je login
    cmp eax, 3
    je exit_program
    mov edx, OFFSET invalid_choice
    call WriteString
    jmp menu_loop

register:
    ; Get User ID
    mov edx, OFFSET reg_id_prompt
    call WriteString
    call ReadDec
    
    ; Check if 4 digits (1000-9999)
    cmp eax, 1000
    jl invalid_input
    cmp eax, 9999
    jg invalid_input
    
    ; Check if ID exists
    mov ecx, user_count
    mov esi, 0
check_existing:
    cmp ecx, 0
    je id_ok
    cmp eax, user_ids[esi*4]
    je id_exists
    inc esi
    dec ecx
    jmp check_existing
    
id_exists:
    mov edx, OFFSET exists_msg
    call WriteString
    jmp menu_loop
    
invalid_input:
    mov edx, OFFSET invalid_msg
    call WriteString
    jmp menu_loop
    
id_ok:
    ; Store User ID
    mov ebx, user_count
    mov user_ids[ebx*4], eax
    
    ; Get Password
    mov edx, OFFSET reg_pw_prompt
    call WriteString
    call ReadDec
    
    ; Check if 4 digits
    cmp eax, 1000
    jl invalid_input
    cmp eax, 9999
    jg invalid_input
    
    ; Store Password
    mov passwords[ebx*4], eax
    inc user_count
    
    mov edx, OFFSET success_msg
    call WriteString
    jmp menu_loop

login:
    ; Get User ID
    mov edx, OFFSET login_id_prompt
    call WriteString
    call ReadDec
    mov ebx, eax    ; Save ID for comparison
    
    ; Get Password
    mov edx, OFFSET login_pw_prompt
    call WriteString
    call ReadDec
    
    ; Search for match
    mov ecx, user_count
    mov esi, 0
search_loop:
    cmp ecx, 0
    je login_fail
    cmp ebx, user_ids[esi*4]
    jne next_user
    cmp eax, passwords[esi*4]
    je login_success
    
next_user:
    inc esi
    dec ecx
    jmp search_loop
    
login_success:
    mov edx, OFFSET success_msg
    call WriteString
    
    ; After successful login, show user menu
user_menu_loop:
    mov edx, OFFSET user_menu
    call WriteString
    
    ; Get user choice
    call ReadDec
    cmp eax, 1
    je flight_selection_loop
    cmp eax, 2
    je view_receipt
    cmp eax, 3
    je make_payment
    cmp eax, 4
    je menu_loop  ; Return to main menu

flight_selection_loop:
    mov edx, OFFSET booking_menu
    call WriteString

    ;Get user choice
    call ReadDec
    cmp eax,1
    je flightprice1
    cmp eax,2
    je flightprice2
    cmp eax,3
    je flightprice3
    cmp eax,4
    je flightprice4
    jmp flight_booking_loop

flightprice1:
    mov eax,OFFSET flight_price
    mov eax,1000
    jmp class_booking

flightprice2:
    mov eax,OFFSET flight_price
    mov eax,5000
    jmp class_booking

flightprice3:
    mov eax,OFFSET flight_price
    mov eax,100
    jmp class_booking

flightprice4:
    mov eax,OFFSET flight_price
    mov eax,2500
    jmp class_booking

class_selection_loop:
    mov edx, OFFSET class_menu
    call WriteString
    
    ;Get user choice
    call ReadDec
    cmp eax,1
    je classprice1
    cmp eax,2
    je classprice2
    cmp eax,3
    je classprice3
    cmp eax,4
    je classprice4
    jmp class_booking_loop

classprice1:
    mov eax,OFFSET class_price
    mov eax,1000
    jmp date_selection_loop

classprice2:
    mov eax,OFFSET class_price
    mov eax,5000
    jmp date_selection_loop

classprice3:
    mov eax,OFFSET class_price
    mov eax,100
    jmp date_selection_loop

classprice4:
    mov eax,OFFSET class_price
    mov eax,2500
    jmp date_selection_loop

date_selection_loop:
    mov edx, OFFSET date_menu
    call WriteString
    
    ;Get user choice
    call ReadDec
    cmp eax,1
    je classprice1
    cmp eax,2
    je classprice2
    cmp eax,3
    je classprice3
    cmp eax,4
    je classprice4
    jmp class_booking_loop

date1:
    mov eax,OFFSET class_price
    mov eax,1000
    jmp date_selection_loop

date2:
    mov eax,OFFSET class_price
    mov eax,5000
    jmp date_selection_loop

date3:
    mov eax,OFFSET class_price
    mov eax,100
    jmp date_selection_loop

date4:
    mov eax,OFFSET class_price
    mov eax,2500
    jmp date_selection_loop
    

view_receipt:
    mov edx, OFFSET receipt_msg
    call WriteString
    jmp user_menu_loop

make_payment:
    mov edx, OFFSET payment_msg
    call WriteString
    jmp user_menu_loop

login_fail:
    mov edx, OFFSET fail_msg
    call WriteString
    jmp menu_loop

exit_program:
    exit
    
main endp
end main