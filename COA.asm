include irvine32.inc

.data
    ; Arrays for user IDs and passwords (max 10 users, 4 digits each)
    user_ids       DWORD   10 DUP(0)    ; Array of 10 DWORDs initialized to 0
    passwords      DWORD   10 DUP(0)    ; Array of 10 DWORDs initialized to 0
    user_count     DWORD   0            ; Number of registered users
    flight_price   DWORD   0            ;price of flight
    class_price    DWORD   0            ;price of class
    date_input     DWORD   0			;date of flight 
    ticket_input   DWORD   0            ;number of tickets
    name_input     BYTE    10 DUP(256 DUP(0))    ;Array of name of passengers
    passport_input DWORD   10 DUP(0)    ;Array of passport number of passengers
    discount_rate  DWORD   0            ;discount rate
    tax_rate       DWORD   0            ;tax rate
    total_price    DWORD   0            ;total price (flight price + class price) * number of tickets)
    discount_price DWORD   0            ;discount price (total price * discount rate)
    tax_price      DWORD   0            ;tax price (total price * tax rate)
    final_price    DWORD   0            ;final price (total price + tax rate - discount rate)
    floating_point DWORD   0            ;floating point number
    

    ; Prompts for main menu
    main_menu        BYTE   "1. Register",0dh,0ah,
                            "2. Login",0dh,0ah,
                            "3. Exit",0dh,0ah,
                            "Choice:[1-3] ",0

    reg_id_prompt    BYTE  "Enter 4-digit User ID: ",0
    reg_pw_prompt    BYTE  "Enter 4-digit Password: ",0
    login_id_prompt  BYTE "Enter 4-digit User ID: ",0
    login_pw_prompt  BYTE "Enter 4-digit Password: ",0
    success_msg      BYTE  "Success!",0dh,0ah,0
    fail_msg         BYTE  "Failure!",0dh,0ah,0
    exists_msg       BYTE  "User ID already exists!",0dh,0ah,0
    invalid_msg      BYTE  "Must be 4 digits!",0dh,0ah,0
    invalid_choice   BYTE  "Invalid choice",0dh,0ah,0

    ;Usermenu after logging in
    user_menu        BYTE  "1. Flight Booking",0dh,0ah,
                           "2. View Receipt",0dh,0ah,
                           "3. Make Payment",0dh,0ah,
                           "4. Exit",0dh,0ah,
                           "Choice[1-4]: ",0

    booking_menu     BYTE  "Please select a flight: ",0dh,0ah,
                           "1. Kuala Lumpur - Beijing    RM1000",0dh,0ah,
                           "2.Kuala Lumpur - Los Angeles RM5000",0dh,0ah,
                           "3.Kuala Lumpur - Sarawak     RM100",0dh,0ah,
                           "4. Kuala Lumpur - Paris      RM2500",0dh,0ah,
                           "Choice[1-4]: ",0

    class_menu       BYTE  "PLease select a class: ",0dh,0ah,
                           "1. Economy           RM0",0dh,0ah,
                           "2. Premium Economy   RM50",0dh,0ah,
                           "3. Business          RM100",0dh,0ah,
                           "4. First             RM1000",0dh,0ah,
                           "Choice[1-4]: ",0

    date_menu        BYTE  "Please select a date: ",0dh,0ah,
                           "1. 30 May 2025",0dh,0ah,
                           "2. 2 August 2025",0dh,0ah,
                           "3. 22 November 2025",0dh,0ah,
                           "4. 2 December 2025",0dh,0ah,
                           "Choice[1-4]: ",0

    ticket_menu      BYTE  "Please enter number of tickets: ",0

    name_menu        BYTE  "Please enter name: ",0

    passport_menu    BYTE  "Please enter passportID: ",0

    membership_menu  BYTE  "Do you have membership? ",0dh,0ah,
                           "1. Yes",0dh,0ah,
                           "2. No",0dh,0ah,
                           "Choice[1-2]: ",0
    
    book_another_menu   BYTE  "Do you want to book another flight? ",0dh,0ah,
                               "1. Yes",0dh,0ah,
                               "2. No",0dh,0ah,
                               "Choice[1-2]: ",0

    receipt_msg      BYTE  "View Receipt Selected - Feature Under Development!",0dh,0ah,0
    payment_msg      BYTE  "Make Payment Selected - Feature Under Development!",0dh,0ah,0

.code
main proc
menu_loop:
    ; Display main menu
    mov edx, OFFSET main_menu 
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

login_fail:
    mov edx, OFFSET fail_msg
    call WriteString
    jmp menu_loop
    
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
    je flight_selection
    cmp eax, 2
    je view_receipt
    cmp eax, 3
    je make_payment
    cmp eax, 4
    je menu_loop  ; Return to main menu
    mov edx, OFFSET invalid_choice
    call WriteString
    jmp user_menu_loop

flight_selection:
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
    mov edx, OFFSET invalid_choice
    call WriteString
    jmp flight_selection

flightprice1:
    mov eax,1000
    mov flight_price,eax
    jmp class_selection

flightprice2:
    mov eax,5000
    mov flight_price,eax
    jmp class_selection

;domestic flight 
flightprice3:
    mov eax,100
    mov flight_price,eax
    mov eax,8
    mov tax_rate,eax
    jmp class_selection

flightprice4:
    mov eax,2500
    mov flight_price,eax
    jmp class_selection

class_selection:
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
    mov edx, OFFSET invalid_choice
    call WriteString
    jmp class_selection

classprice1:
    mov eax,0
    mov class_price,eax
    jmp date_selection

classprice2:
    mov eax,50
    mov class_price,eax
    jmp date_selection

classprice3:
    mov eax,100
    mov class_price,eax
    jmp date_selection

classprice4:
    mov eax,1000
    mov class_price,eax
    jmp date_selection

date_selection:
    mov edx, OFFSET date_menu
    call WriteString
    
    ;Get user choice
    call ReadDec
    mov date_input,eax
    cmp eax,4
    jg error_msg
    jmp number_of_tickets

error_msg:
    mov edx, OFFSET invalid_choice
    call WriteString
    jmp date_selection

number_of_tickets:
    mov edx, OFFSET ticket_menu
    call WriteString
    
    ;Get user choice
    call ReadDec
    mov ticket_input,eax
    mov esi,0
    jmp enter_name

enter_name:
    cmp esi,ticket_input
    jge passportesi

    mov edx, OFFSET name_menu
    call WriteString

    ;Get user input
    mov edx,OFFSET name_input
    call ReadString
    inc esi
    jmp enter_name

passportID:
    cmp esi,ticket_input
    jge membership_validation
    
    mov edx, OFFSET passport_menu
    call WriteString
    
    ;Get user input
    mov edx,OFFSET passport_input
    call ReadString
    inc esi
    jmp passportID

passportesi:
    mov esi,0
    jmp passportID

membership_validation:
    mov edx, OFFSET membership_menu
    call WriteString
    
    ;Get user choice
    call ReadDec
    cmp eax,1
    je membership_yes
    cmp eax,2
    je membership_no
    mov edx, OFFSET invalid_choice
    call WriteString
    jmp membership_validation

membership_yes:
    mov eax, 5
    mov discount_rate,eax
    jmp calc_total_price

membership_no:
    mov eax, 0
    mov discount_rate,eax
    jmp calc_total_price

book_another:
    mov edx, OFFSET book_another_menu
    call WriteString

    ;Get user choice
    call ReadDec
    cmp eax,1
    je flight_selection
    cmp eax,2
    je user_menu_loop
    mov edx, OFFSET invalid_choice
    call WriteString
    jmp book_another

calc_total_price:
    mov eax, OFFSET total_price         ;eax = total price
    mov eax, flight_price               ;eax = flight price
    add eax, class_price                ;eax = flight price + class price
    mul ticket_input                    ;eax = (flight price + class price) * number of tickets
    mov total_price,eax                 ;total price = (flight price + class price) * number of tickets
    jmp calc_tax_price

calc_tax_price:
    mov eax, tax_rate                   ;eax = taxrate
    mul total_price                     ;eax = taxrate * ((flight price + class price) * number of tickets)
    mov ebx,100
    div ebx                             
    mov floating_point,edx
    mov tax_price,eax                   ;tax price = taxrate * ((flight price + class price) * number of tickets)
    add eax,total_price                 ;eax = tax price + total price
    mov total_price,eax                 ;total price = tax price + total price
    jmp calc_discount_price

calc_discount_price:
    mov eax, discount_rate              ;eax = discountrate
    mul total_price                     ;eax = discountrate * (((flight price + class price) * number of tickets)+tax price)
    mov ebx,100
    div ebx                             
    mov floating_point,edx
    mov discount_price,eax              ;discount price = discountrate * ((flight price + class price) * number of tickets)
    jmp calc_final_price

calc_final_price:
    mov eax, total_price                ;eax = total price + tax price
    sub eax, discount_price             ;eax = total price + tax price - discount price
    mov final_price, eax                ;final price = total price + tax price - discount price
    cmp floating_point,0
    ja adjust_floating_point

adjust_floating_point:
    mov eax, 100
    sub eax,floating_point
    mov floating_point,eax
    jmp adjust_final_price
    
adjust_final_price:
    mov eax, final_price
    sub eax, 1
    mov final_price, eax
    jmp book_another


view_receipt:
    mov eax, final_price
    call WriteDec
    mov al,'.'
    call WriteChar
    mov eax, floating_point             ;eax = floating point number
    call writeDec
    mov edx, OFFSET receipt_msg
    call WriteString
    jmp user_menu_loop

make_payment:
    mov edx, OFFSET payment_msg
    call WriteString
    jmp user_menu_loop



exit_program:
    exit
    
main endp
end main