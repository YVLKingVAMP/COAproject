include irvine32.inc

.data
    ; Arrays for user IDs and passwords (max 10 users, 4 digits each)
    user_ids       DWORD   10 DUP(0)    ; Array of 10 DWORDs initialized to 0
    passwords      DWORD   10 DUP(0)    ; Array of 10 DWORDs initialized to 0
    user_count     DWORD   0            ; Number of registered users
    flight_price   DWORD   0            ;price of flight
    class_price    DWORD   0            ;price of class
    ticket_input   DWORD   0            ;number of tickets
    name_input     BYTE    10 DUP(256 DUP(0))    ;Array of name of passengers
    passport_input DWORD   10 DUP(0)    ;Array of passport number of passengers
    discount_rate  DWORD   0            ;discount rate
    tax_rate       DWORD   0            ;tax rate
    total_price    DWORD   0            ;total price (flight price + class price) * number of tickets)
    total_price_after_tax DWORD   0     ;total price after tax (total price + tax price)
    discount_price DWORD   0            ;discount price (total price * discount rate)
    tax_price      DWORD   0            ;tax price (total price * tax rate)
    final_price    DWORD   0            ;final price (total price + tax rate - discount rate)
    discount_floating_point DWORD   0            ;floating point number
    tax_floating_point DWORD   0            ;floating point number
    flight_price_floating_point DWORD   0            ;floating point number
    class_price_floating_point DWORD   0            ;floating point number
    final_price_floating_point DWORD   0            ;floating point number
    nextline       BYTE    0dh,0ah,0
    RM             BYTE    "RM",0
    options        BYTE    4 DUP(255) ; Array to store options for flight booking  
    selection      db      1
    var           DWORD  0
    user_input    DWORD  0
    

    main_menu        BYTE   "1. Register",0dh,0ah,
                            "2. Login",0dh,0ah,
                            "3. Exit",0dh,0ah,
                            "Choice[1-3]: ",0

    reg_id_prompt    BYTE  "Enter 4-digit User ID: ",0
    reg_pw_prompt    BYTE  "Enter 4-digit Password: ",0
    login_id_prompt  BYTE  "Enter 4-digit User ID: ",0
    login_pw_prompt  BYTE  "Enter 4-digit Password: ",0
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

    logo            BYTE    "_____                 __        _____",0dh,0ah,
                            "  |   |\    /| |   | |  \   /\    |  ",0dh,0ah,
                            "  |   | \  / | |   | |__/  /__\   |  ",0dh,0ah,
                            "  |   |  \/  | \___/ |  \ /    \  |  ",0dh,0ah,
                            "-------------------------------------",0dh,0ah,0

    flight_menu     BYTE   "Please select a flight: ",0dh,0ah,0
    choice_menu     BYTE   "Choice[1-4]: ",0
                           

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

    booking_option0  BYTE  "Kuala Lumpur - Beijing     ",0
    booking_option1  BYTE  "Kuala Lumpur - Los Angeles ",0
    booking_option2  BYTE  "Kuala Lumpur - Sarawak     ",0
    booking_option3  BYTE  "Kuala Lumpur - Paris       ",0
    booking_option4  BYTE  "Kuala Lumpur - London      ",0
    booking_option5  BYTE  "Kuala Lumpur - New York    ",0
    booking_option6  BYTE  "Kuala Lumpur - Tokyo       ",0
    booking_option7  BYTE  "Kuala Lumpur - Sydney      ",0
    booking_option8  BYTE  "Kuala Lumpur - Johor       ",0
    booking_option9  BYTE  "Kuala Lumpur - Singapore   ",0

    booking_table dword OFFSET booking_option0,OFFSET booking_option1, OFFSET booking_option2, OFFSET booking_option3, OFFSET booking_option4, OFFSET booking_option5, OFFSET booking_option6, OFFSET booking_option7, OFFSET booking_option8, OFFSET booking_option9
    flight_price_table  dword  1000, 5000, 200, 2500, 2000, 3000, 1500, 1800, 100, 500

    class_option1   BYTE  "Economy ",0
    class_option2   BYTE  "Premium Economy ",0
    class_option3   BYTE  "Business ",0
    class_option4   BYTE  "First ",0

    date_option1   BYTE  "30 May 2025 ",0
    date_option2   BYTE  "6 June 2025 ",0
    date_option3   BYTE  "22 June 2025 ",0
    date_option4   BYTE  "20 July 2025 ",0
    date_option5   BYTE  "31 July 2025 ",0
    date_option6   BYTE  "2 August 2025 ",0
    date_option7   BYTE  "11 October 2025 ",0
    date_option8   BYTE  "2 November 2025 ",0
    date_option9   BYTE  "23 November 2025 ",0
    date_option10  BYTE  "24 December 2025 ",0

    receipt_booking BYTE  100 DUP(0) 
    receipt_class   BYTE  100 DUP(0)
    receipt_date    BYTE  100 DUP(0)
    receipt_pax	    BYTE  "pax ",0
    receipt_tax     BYTE  "Tax: ",0
    receipt_discount BYTE  "Discount: ",0
    receipt_total   BYTE  "Total: ",0
    receipt_date_msg BYTE  "Flight Date: ",0

    payment_msg      BYTE  "Make Payment Selected - Feature Under Development!",0dh,0ah,0

.code
main proc
menu_loop:
    lea edx, logo
    call writestring
    lea edx, nextline
    call WriteString
    mov edx, OFFSET main_menu 
    call WriteString
    call randomizer
    
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
usermenu:
    lea edx, logo
    call writestring
    lea edx, nextline
    call WriteString
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
    jmp usermenu

flight_selection:
    lea edx, logo
    call writestring
    lea edx, nextline
    call WriteString
    mov edx, OFFSET flight_menu
    call WriteString
    call randomizer
    mov esi, OFFSET options
    mov ecx, 4
    call printbookloop
    lea edx, choice_menu
    call WriteString

    ;Get user choice
    call ReadDec      ;1 to 4
    dec eax           ;0 to 3
    mov ecx,eax
    mov user_input,eax
    jmp flightprice
    cmp eax,5
    je back_usermenu
    mov edx, OFFSET invalid_choice
    call WriteString
    jmp flight_selection

back_usermenu:
    jmp usermenu

flightprice:
    
    mov esi,OFFSET options
    movzx eax, byte ptr [esi+ecx]  ; get option number (0–9)
    call writeint
    mov user_input,eax
    mov ebx, OFFSET booking_table
    mov esi,[ebx+eax*4]
    mov edi,OFFSET receipt_booking
    call copystring 
    mov esi,OFFSET options
    movzx eax, byte ptr [esi+ecx]
    mov ebx, OFFSET flight_price_table
    mov eax,[ebx+eax*4]
    mov flight_price,eax
    cmp user_input,2
    je domestic
    cmp user_input,8
    je domestic
    jne nondomestic
    jmp class_selection

domestic:
    mov tax_rate,8
    jmp class_selection

nondomestic:
    mov tax_rate,0
    jmp class_selection

class_selection:
    lea edx, logo
    call writestring
    lea edx, nextline
    call WriteString
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
    cmp eax,5
    je back_flight_selection
    jmp class_selection

back_flight_selection:
    jmp flight_selection

classprice1:
    mov eax,0
    mov class_price,eax
    lea esi, class_option1
    lea edi, receipt_class
    call copystring
    jmp date_selection

classprice2:
    mov eax,50
    mov class_price,eax
    lea esi, class_option2
    lea edi, receipt_class
    call copystring
    jmp date_selection

classprice3:
    mov eax,100
    mov class_price,eax
    lea esi, class_option3
    lea edi, receipt_class
    call copystring
    jmp date_selection

classprice4:
    mov eax,1000
    mov class_price,eax
    lea esi, class_option4
    lea edi, receipt_class
    call copystring
    jmp date_selection

date_selection:
    lea edx, logo
    call writestring
    lea edx, nextline
    call WriteString
    mov edx, OFFSET date_menu
    call WriteString
    
    ;Get user choice
    call ReadDec
    cmp eax,1
    je date1
    cmp eax,2
    je date2
    cmp eax,3
    je date3
    cmp eax,4
    je date4
    mov edx, OFFSET invalid_choice
    call WriteString
    cmp eax,5
    je back_class_selection
    jmp number_of_tickets

back_class_selection:
    jmp class_selection

date1:
    lea esi, date_option1
    lea edi, receipt_date
    call copystring
    jmp number_of_tickets

date2:
    lea esi, date_option2
    lea edi, receipt_date
    call copystring
    jmp number_of_tickets

date3:
    lea esi, date_option3
    lea edi, receipt_date
    call copystring
    jmp number_of_tickets

date4:
    lea esi, date_option4
    lea edi, receipt_date
    call copystring
    jmp number_of_tickets

number_of_tickets:
    lea edx, logo
    call writestring
    lea edx, nextline
    call WriteString
    mov edx, OFFSET ticket_menu
    call WriteString
    
    ;Get user choice
    call ReadDec
    mov ticket_input,eax
    mov esi,0
    jmp membership_validation;enter_name

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
    lea edx, logo
    call writestring
    lea edx, nextline
    call WriteString
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
    lea edx, logo
    call writestring
    lea edx, nextline
    call WriteString
    mov edx, OFFSET book_another_menu
    call WriteString

    ;Get user choice
    call ReadDec
    cmp eax,1
    mov selection,1
    je flight_selection
    cmp eax,2
    je usermenu
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
    mov final_price_floating_point,edx
    mov tax_price,eax                   ;tax price = taxrate * ((flight price + class price) * number of tickets)
    add eax,total_price                 ;eax = tax price + total price
    mov total_price_after_tax,eax       ;total price = tax price + total price
    jmp calc_discount_price

calc_discount_price:
    mov eax, discount_rate              ;eax = discountrate
    mul total_price_after_tax           ;eax = discountrate * (((flight price + class price) * number of tickets)+tax price)
    mov ebx,100
    div ebx                             
    mov final_price_floating_point,edx
    mov discount_floating_point,edx
    mov discount_price,eax              ;discount price = discountrate * ((flight price + class price) * number of tickets)
    jmp calc_final_price

calc_final_price:
    mov eax, total_price_after_tax      ;eax = total price + tax price
    sub eax, discount_price             ;eax = total price + tax price - discount price
    mov final_price, eax                ;final price = total price + tax price - discount price
    cmp final_price_floating_point,0
    ja adjust_floating_point
    jmp book_another

adjust_floating_point:
    mov eax, 100
    sub eax,final_price_floating_point
    mov final_price_floating_point,eax
    jmp adjust_final_price
    
adjust_final_price:
    mov eax, final_price
    sub eax, 1
    mov final_price, eax
    jmp book_another


view_receipt:
    lea edx, logo
    call writestring
    lea edx, nextline
    call WriteString

    mov edx, OFFSET receipt_date_msg
    call WriteString
    mov edx, OFFSET receipt_date
    call WriteString
    lea edx, nextline
    call WriteString
    mov edx, OFFSET receipt_booking
    call WriteString
    mov eax, ticket_input
    call Writedec
    mov edx, OFFSET receipt_pax
    call WriteString
    mov eax,flight_price
    mul ticket_input
    call writedec
    mov al,'.'
    call WriteChar
    mov eax,flight_price_floating_point             ;eax = floating point number
    call writeDec
    lea edx,nextline
    call writeString
    mov edx, OFFSET receipt_class
    call WriteString
    mov eax, ticket_input
    call Writedec
    mov edx, OFFSET receipt_pax
    call WriteString
    mov eax,class_price
    mul ticket_input
    call writedec
    mov al,'.'
    call WriteChar
    mov eax,class_price_floating_point             ;eax = floating point number
    call writeDec
    lea edx,nextline
    call writeString
    mov edx, OFFSET receipt_tax
    call WriteString
    mov eax, tax_price
    call WriteDec
    mov al,'.'
    call WriteChar
    mov eax,tax_floating_point             ;eax = floating point number
    call writeDec
    lea edx,nextline
    call writeString
    mov edx, OFFSET receipt_discount
    call WriteString
    mov eax, discount_price
    call WriteDec
    mov al,'.'
    call WriteChar
    mov eax,discount_floating_point             ;eax = floating point number
    call writeDec
    lea edx,nextline
    call writeString
    mov edx, OFFSET receipt_total
    call WriteString
    mov eax, final_price
    call WriteDec
    mov al,'.'
    call WriteChar
    mov eax,final_price_floating_point             ;eax = floating point number
    call writeDec
    lea edx,nextline
    call writeString
    jmp book_another

    
    

make_payment:
    mov edx, OFFSET payment_msg
    call WriteString
    jmp usermenu



exit_program:
    exit
    
main endp

copystring proc
CopyLoop:
    mov al, [esi]           ; Load a byte from source
    mov [edi], al           ; Store it in destination
    inc esi                 ; Move to next character in source
    inc edi                 ; Move to next position in destination
    cmp al, 0               ; Check for null terminator
    jne CopyLoop            ; If not null, keep copying
    ret
copystring endp

randomizer proc
    call Randomize
    xor ecx, ecx                    ; counter for stored values
GenLoop:
    mov eax, 10
    call RandomRange                ; EAX = 0–9

    ; Check for duplicates
    mov esi, OFFSET options
    mov ebx, ecx                    ; check already stored numbers

CheckDup:
    cmp ebx, 0
    je StoreNum

    mov dl, [esi]
    cmp al, dl
    je GenLoop                      ; duplicate found, generate new

    inc esi
    dec ebx
    jmp CheckDup

StoreNum:
    mov esi, OFFSET options
    add esi, ecx
    mov [esi], al                   ; store number
    inc ecx
    cmp ecx, 4
    jne GenLoop
    ret
    
randomizer endp

printbookloop proc

printbookingloop:
    movzx eax,selection
    call writedec
    movzx ax,selection
    inc ax
    mov selection,al
    mov al,'.'
    call WriteChar
    movzx eax, byte ptr [esi]  ; get option number (0–9)
    mov ebx, OFFSET booking_table
    mov edx, [ebx + eax*4]     ; load pointer to message
    call WriteString
    lea edx,RM
    call writestring
    mov ebx, OFFSET flight_price_table
    mov eax,[ebx+eax*4]
    call writedec
    call Crlf

    inc esi
    loop printbookingloop
    ret
printbookloop endp


end main