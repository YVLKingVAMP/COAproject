include irvine32.inc

.data
    ; Arrays for user IDs and passwords (max 10 users, 4 digits each)
    user_ids       DWORD   10 DUP(0)    ; Array of 10 DWORDs initialized to 0
    passwords      DWORD   10 DUP(0)    ; Array of 10 DWORDs initialized to 0
    user_count     DWORD   0            ; Number of registered users
    flight_price   DWORD   0            
    class_price    DWORD   0            
    baggage_price  DWORD   0            
    baggage_weight DWORD   0
    baggage_price_rate DWORD 10         ;extra baggage price of Rm10 per kg
    ticket_input   DWORD   0            ;number of tickets
    nameArray      BYTE 200 DUP(?)      ;200 bytes for names
    passportArray  BYTE 200 DUP(?)      ;200 bytes for passportIDs
    discount_rate  DWORD   0            
    tax_rate       DWORD   0            
    total_price    DWORD   0            ;(flight price + class price + baggage_price) * number of tickets)
    total_price_after_tax DWORD   0     ;total price + tax price
    discount_price DWORD   0            ;total price * discount rate
    tax_price      DWORD   0            ;total price * tax rate
    final_price    DWORD   0            ;total price after tax - discount rate
    discount_floating_point      DWORD   0            
    tax_floating_point           DWORD   0            
    flight_price_floating_point  DWORD   0            
    class_price_floating_point   DWORD   0            
    baggage_price_floating_point DWORD   0
    final_price_floating_point   DWORD   0            
    tabline		   BYTE    09h,0
    RM             BYTE    "RM",0
    KG             BYTE    "KG",0
    options        DWORD    4 DUP(0) ; Array to store options for flight booking  
    selection      BYTE    1
    var            DWORD   0
    user_input     DWORD   0
    memberships    BYTE   "TMURAT1",0,"TMURAT2",0,"TMURAT3",0,"!",0
    member_input   BYTE    100 DUP(?)
    member_found   DWORD   0

    logo            BYTE    "_____                 __        _____",0dh,0ah,
                            "  |   |\    /| |   | |  \   /\    |  ",0dh,0ah,
                            "  |   | \  / | |   | |__/  /__\   |  ",0dh,0ah,
                            "  |   |  \/  | \___/ |  \ /    \  |  ",0dh,0ah,
                            "-------------------------------------",0dh,0ah,0
    
    main_menu        BYTE   "1. Register",0dh,0ah,
                            "2. Login",0dh,0ah,
                            "3. Exit",0dh,0ah,
                            "Choice[1-3]: ",0

    id_prompt        BYTE  "Enter 4-digit User ID: ",0
    pw_prompt        BYTE  "Enter 4-digit Password: ",0
    success_msg      BYTE  "Success!",0dh,0ah,0
    fail_msg         BYTE  "Failure!",0dh,0ah,0
    exists_msg       BYTE  "User ID already exists!",0dh,0ah,0
    invalid_msg      BYTE  "Must be 4 digits!",0dh,0ah,0
    invalid_choice   BYTE  "Invalid choice",0dh,0ah,0

    user_menu        BYTE  "1. Flight Booking",0dh,0ah,
                           "2. View Booking Details",0dh,0ah,
                           "3. Make Payment",0dh,0ah,
                           "4. Exit",0dh,0ah,
                           "Choice[1-4]: ",0

    flight_menu     BYTE   "Please select a flight: ",0dh,0ah,0
    choice_menu     BYTE   "Choice[1-4]: ",0
                           
    class_menu       BYTE  "Please select a class: ",0dh,0ah,
                           "1. Economy           RM0",0dh,0ah,
                           "2. Premium Economy   RM50",0dh,0ah,
                           "3. Business          RM100",0dh,0ah,
                           "4. First             RM1000",0dh,0ah,
                           "Choice[1-4]: ",0

    baggage_menu     BYTE  "Please select baggage weight",0dh,0ah,
                           "1. 5kg   RM10",0dh,0ah,
                           "2. 7kg   RM20",0dh,0ah,
                           "3. 10kg  RM50",0dh,0ah,
                           "4. >10kg RM50 + (extra RM10 for every kg)",0dh,0ah,
                           "Choice[1-4]: ",0

    baggage_manual   BYTE  "Please enter extra baggage weight(max 50kg): ",0
    baggage_error    BYTE  "Invalid weight",0dh,0ah,0
    ticket_error     BYTE  "Please enter at least 1",0
    date_menu        BYTE  "Please select a date: ",0dh,0ah,0
    ticket_menu      BYTE  "Please enter number of tickets: ",0
    name_menu        BYTE  "Please enter name: ",0
    passport_menu    BYTE  "Please enter passportID: ",0

    membership_menu  BYTE  "Do you have membership? ",0dh,0ah,
                           "1. Yes",0dh,0ah,
                           "2. No",0dh,0ah,
                           "Choice[1-2]: ",0

    membership_prompt   BYTE  "Enter MembershipID: ",0
    membership_error   BYTE  "Invalid MembershipID",0dh,0ah,0
    
    book_new_menu   BYTE  "Do you want to book a new flight? ",0dh,0ah,
                               "1. Yes",0dh,0ah,
                               "2. No",0dh,0ah,
                               "Choice[1-2]: ",0

    booking_option0  BYTE  "Kuala Lumpur - Beijing    ",09h,0
    booking_option1  BYTE  "Kuala Lumpur - Los Angeles",09h,0
    booking_option2  BYTE  "Kuala Lumpur - Sarawak    ",09h,0
    booking_option3  BYTE  "Kuala Lumpur - Paris      ",09h,0
    booking_option4  BYTE  "Kuala Lumpur - London     ",09h,0
    booking_option5  BYTE  "Kuala Lumpur - New York   ",09h,0
    booking_option6  BYTE  "Kuala Lumpur - Tokyo      ",09h,0
    booking_option7  BYTE  "Kuala Lumpur - Sydney     ",09h,0
    booking_option8  BYTE  "Kuala Lumpur - Johor      ",09h,0
    booking_option9  BYTE  "Kuala Lumpur - Singapore  ",09h,0

    booking_table dword OFFSET booking_option0,OFFSET booking_option1, OFFSET booking_option2, OFFSET booking_option3, OFFSET booking_option4, OFFSET booking_option5, OFFSET booking_option6, OFFSET booking_option7, OFFSET booking_option8, OFFSET booking_option9
    flight_price_table  dword  1000, 5000, 200, 2500, 2000, 3000, 1500, 1800, 100, 500

    class_option1   BYTE  "Economy         ",09h,0
    class_option2   BYTE  "Premium Economy ",09h,0
    class_option3   BYTE  "Business        ",09h,0
    class_option4   BYTE  "First           ",09h,0

    baggage_option1   BYTE  "5kg ",0
    baggage_option2   BYTE  "7kg ",0
    baggage_option3   BYTE  "10kg ",0
    baggage_option4   BYTE  100 DUP(0)

    date_option0   BYTE  "30 May 2025 ",0
    date_option1   BYTE  "6 June 2025 ",0
    date_option2   BYTE  "22 June 2025 ",0
    date_option3   BYTE  "20 July 2025 ",0
    date_option4   BYTE  "31 July 2025 ",0
    date_option5   BYTE  "2 August 2025 ",0
    date_option6   BYTE  "11 October 2025 ",0
    date_option7   BYTE  "2 November 2025 ",0
    date_option8   BYTE  "23 November 2025 ",0
    date_option9   BYTE  "24 December 2025 ",0

    date_table  dword OFFSET date_option0,OFFSET date_option1, OFFSET date_option2, OFFSET date_option3, OFFSET date_option4, OFFSET date_option5, OFFSET date_option6, OFFSET date_option7,OFFSET date_option8, OFFSET date_option9 

    receipt_booking  BYTE  100 DUP(0) 
    receipt_class    BYTE  100 DUP(0)
    receipt_baggage  BYTE  "Baggage weight",09h,0
    receipt_date     BYTE  100 DUP(0)
    receipt_pax	     BYTE  "pax ",0
    receipt_tax      BYTE  "Tax: ",09h,0
    receipt_discount BYTE  "Discount: ",09h,0
    receipt_total    BYTE  "Total: ",09h,0
    receipt_date_msg BYTE  "Flight Date: ",0
    receipt_name     BYTE  "Name",0
    receipt_passport BYTE  "PassportID",0

    payment_menu     BYTE  "Select Payment Method:",0dh,0ah,
                           "1. Online Banking",0dh,0ah,
                           "2. Credit/Debit Card",0dh,0ah,
                           "Choice[1-2]: ",0

    online_banking_msg BYTE "Processing payment via Online Banking...",0dh,0ah,0
    credit_debit_msg   BYTE "Processing payment via Credit/Debit Card...",0dh,0ah,0
    payment_success_msg BYTE "Payment Successful!",0dh,0ah,0


.code
main proc

menu_loop:
    lea edx, logo
    call writestring
    call crlf
    lea edx, main_menu 
    call writestring
    
    call ReadDec
    cmp eax, 1
    je register
    cmp eax, 2
    je login
    cmp eax, 3
    je exit_program
    lea edx, invalid_choice
    call writestring
    jmp menu_loop

register:
    ; Get User ID
    mov edx, OFFSET id_prompt
    call writestring
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
    lea edx, exists_msg
    call writestring
    jmp menu_loop
    
invalid_input:
    lea edx, invalid_msg
    call writestring
    jmp menu_loop
    
id_ok:
    ; Store User ID
    mov ebx, user_count
    mov user_ids[ebx*4], eax
    
    ; Get Password
    lea edx, pw_prompt
    call writestring
    call ReadDec
    
    ; Check if 4 digits
    cmp eax, 1000
    jl invalid_input
    cmp eax, 9999
    jg invalid_input
    
    ; Store Password
    mov passwords[ebx*4], eax
    inc user_count
    
    lea edx, success_msg
    call WriteString
    jmp menu_loop

login:
    ; Get User ID
    lea edx, id_prompt
    call writestring
    call ReadDec
    mov ebx, eax    ; Save ID for comparison
    
    ; Get Password
    lea edx, pw_prompt
    call writestring
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
    lea edx, fail_msg
    call writestring
    jmp menu_loop
    
login_success:
    lea edx, success_msg
    call writestring

usermenu:
    lea edx, logo
    call writestring
    call crlf
    lea edx, user_menu
    call writestring
    
    call ReadDec
    cmp eax, 1
    je flight_selection
    cmp eax, 2
    je view_booking_details
    cmp eax, 3
    je make_payment
    cmp eax, 4
    je menu_loop  
    lea edx, invalid_choice
    call writestring
    jmp usermenu

flight_selection:
    lea edx, logo
    call writestring
    call crlf
    lea edx, flight_menu
    call writestring
    call randomizer
    mov esi, OFFSET options
    mov ecx, 4
    call printbookloop
    lea edx, choice_menu
    call writestring

    call ReadDec      ;1 to 4
    dec eax           ;0 to 3
    cmp eax,4
    je back_usermenu
    cmp eax,5
    ja flight_error_msg
    mov ecx,eax
    mov user_input,eax
    jmp flightprice

flight_error_msg:
    lea edx, invalid_choice
    call writestring
    jmp flight_selection
    
back_usermenu:
    jmp usermenu

flightprice:
    mov esi,OFFSET options
    movzx eax, byte ptr [esi+ecx]  ; get option number (0–9)
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

class_selection:
    lea edx, logo
    call writestring
    call crlf
    lea edx, class_menu
    call writestring
    
    call ReadDec
    cmp eax,1
    je classprice1
    cmp eax,2
    je classprice2
    cmp eax,3
    je classprice3
    cmp eax,4
    je classprice4
    cmp eax,5
    je back_flight_selection
    lea edx, invalid_choice
    call writestring
    jmp class_selection

back_flight_selection:
    jmp flight_selection

classprice1:
    mov eax,0
    mov class_price,eax
    lea esi, class_option1
    lea edi, receipt_class
    call copystring
    jmp baggage_selection

classprice2:
    mov eax,50
    mov class_price,eax
    lea esi, class_option2
    lea edi, receipt_class
    call copystring
    jmp baggage_selection

classprice3:
    mov eax,100
    mov class_price,eax
    lea esi, class_option3
    lea edi, receipt_class
    call copystring
    jmp baggage_selection

classprice4:
    mov eax,1000
    mov class_price,eax
    lea esi, class_option4
    lea edi, receipt_class
    call copystring

baggage_selection:
    lea edx, logo
    call writestring
    call crlf
    lea edx, baggage_menu
    call writestring

    call ReadDec
    cmp eax,1
    je baggageprice1
    cmp eax,2
    je baggageprice2
    cmp eax,3
    je baggageprice3
    cmp eax,4
    je baggageprice4
    cmp eax,5
    je back_class_selection
    lea edx, invalid_choice
    call writestring
    jmp baggage_selection

back_class_selection:
    jmp class_selection

baggageprice1:
    mov eax,10
    mov baggage_price,eax
    mov baggage_weight,5
    jmp date_selection
    
baggageprice2:
    mov eax,20
    mov baggage_price,eax
    mov baggage_weight,7
    jmp date_selection

baggageprice3:
    mov eax,50
    mov baggage_price,eax
    mov baggage_weight,10
    jmp date_selection

baggageprice4:
    mov eax,50
    mov baggage_price,eax
    lea edx, baggage_manual
    call writestring
    call ReadDec
    cmp eax,50
    ja baggage_error_msg
    jmp calc_baggage_price
    
calc_baggage_price:
    mov baggage_weight,eax
    mul baggage_price_rate
    add eax,baggage_price
    mov baggage_price,eax
    mov eax,baggage_price
    mov eax,baggage_weight
    add eax, 10
    mov baggage_weight,eax
    jmp date_selection

baggage_error_msg:
    lea edx,baggage_error
    call writestring
    jmp baggageprice4

date_selection:
    lea edx, logo
    call writestring
    call crlf
    lea edx, date_menu
    call WriteString
    call randomizer
    mov esi, OFFSET options
    mov ecx, 4
    call printdateloop
    lea edx, choice_menu
    call WriteString
    
    call ReadDec      ;1 to 4
    dec eax           ;0 to 3
    cmp eax,4
    je baggage_selection
    cmp eax,5
    ja date_error_msg
    mov ecx,eax
    mov user_input,eax
    jmp date   

date_error_msg:
    mov edx, OFFSET invalid_choice
    call WriteString
    jmp date_selection

back_baggage_selection:
    jmp baggage_selection

date:
    mov esi,OFFSET options
    movzx eax, byte ptr [esi+ecx]  ; get option number (0–9)
    mov user_input,eax
    mov ebx, OFFSET date_table
    mov esi,[ebx+eax*4]
    mov edi,OFFSET receipt_date
    call copystring 
    jmp number_of_tickets

number_of_tickets:
    lea edx, logo
    call writestring
    call crlf
    lea edx, ticket_menu
    call writestring
    
    call ReadDec
    cmp eax,0
    je ticket_error_msg
    mov ticket_input,eax
    mov esi,0
    jmp enter_credential

ticket_error_msg:
    lea edx, ticket_error
    jmp number_of_tickets
    
enter_credential:
    cmp esi,ticket_input        
    jge membership_selection

    lea edx, name_menu
    call writestring
    mov eax,esi
    imul eax,20
    lea edx,nameArray[eax]
    mov ecx,20
    call readstring

    lea edx, passport_menu
    call writestring
    mov eax,esi
    imul eax,20
    lea edx,passportArray[eax]
    mov ecx,20
    call readstring

    inc esi
    jmp enter_credential

membership_selection:
    lea edx, logo
    call writestring
    lea edx, membership_menu
    call writestring

    call ReadDec
    cmp eax,1
    je membership_validation
    cmp eax,2
    je membership_no
    lea edx, invalid_choice
    call writestring
    jmp membership_selection

membership_no:
    mov eax, 0
    mov discount_rate,eax
    jmp calc_total_price

membership_validation:
    lea edx, membership_prompt
    call writestring
    call membership_validation_check
    mov eax,discount_rate
    cmp eax,0
    je membership_selection
    jne calc_total_price

book_new:
    mov eax, 0
    mov discount_rate,eax
    lea edx, logo
    call writestring
    call crlf
    lea edx, book_new_menu
    call writestring

    call ReadDec
    cmp eax,1
    mov selection,1
    je flight_selection
    cmp eax,2
    je usermenu
    lea edx, invalid_choice
    call writestring
    jmp book_new

calc_total_price:
    mov eax, OFFSET total_price         ;eax = total price
    mov eax, flight_price               ;eax = flight price
    add eax, class_price                ;eax = flight price + class price
    add eax, baggage_price              ;eax = flight price + class price + baggage price
    mul ticket_input                    ;eax = (flight price + class price) * number of tickets
    mov total_price,eax                 ;total price = (flight price + class price) * number of tickets
    jmp calc_tax_price

calc_tax_price:
    mov eax, tax_rate                   ;eax = taxrate
    mul total_price                     ;eax = taxrate * ((flight price + class price + baggage price) * number of tickets)
    mov ebx,100
    div ebx                             
    mov final_price_floating_point,edx
    mov tax_price,eax                   ;tax price = taxrate * ((flight price + class price + baggage price) * number of tickets)
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
    jmp usermenu

adjust_floating_point:
    mov eax, 100
    sub eax,final_price_floating_point
    mov final_price_floating_point,eax
    jmp adjust_final_price
    
adjust_final_price:
    mov eax, final_price
    sub eax, 1
    mov final_price, eax
    jmp usermenu

view_booking_details:
    lea edx, logo
    call writestring
    call crlf
    lea edx, receipt_date_msg
    call writestring
    lea edx, receipt_date
    call writestring
    call crlf
    lea edx, receipt_booking
    call writestring
    mov eax, ticket_input
    call Writedec
    lea edx, receipt_pax
    call writestring
    lea edx,tabline
    call writestring
    lea edx,RM
    call writestring
    mov eax,flight_price
    mul ticket_input
    call writedec
    mov al,'.'
    call WriteChar
    mov eax,flight_price_floating_point             ;eax = floating point number
    call writedec
    call writedec
    call crlf
    lea edx, receipt_class
    call writestring
    lea edx,tabline
    call writestring
    mov eax, ticket_input
    call writedec
    lea edx, receipt_pax
    call writestring
    lea edx,tabline
    call writestring
    lea edx,RM
    call writestring
    mov eax,class_price
    mul ticket_input
    call writedec
    mov al,'.'
    call WriteChar
    mov eax,class_price_floating_point             ;eax = floating point number
    call writedec
    call writedec
    call crlf
    lea edx, receipt_baggage
    call writestring
    mov eax, baggage_weight
    call writedec
    lea edx,kg
    call writestring
    lea edx,tabline
    call writestring
    call writestring
    mov eax,ticket_input
    call writedec
    lea edx,receipt_pax
    call writestring
    lea edx,tabline
    call writestring
    lea edx,RM
    call writestring
    mov eax,baggage_price
    mul ticket_input
    call writedec
    mov al,'.'
    call writechar
    mov eax,baggage_price_floating_point
    call writedec
    call writedec
    call crlf
    lea edx, receipt_tax
    call writestring
    lea edx,tabline
    call writestring
    call writestring
    call WriteString
    call writestring
    lea edx,RM
    call writestring
    mov eax, tax_price
    call WriteDec
    mov al,'.'
    call writechar
    mov eax,tax_floating_point             ;eax = floating point number
    call writedec
    call writedec
    call crlf
    lea edx, receipt_discount
    call writestring
    lea edx,tabline
    call writestring
    call writestring
    call writestring
    lea edx,RM
    call writestring
    mov eax, discount_price
    call writedec
    mov al,'.'
    call writechar
    mov eax,discount_floating_point             
    call adjust_discount_floating_point
    call crlf
    lea edx, receipt_total
    call writestring
    lea edx,tabline
    call writestring
    call writestring
    call writestring
    call writestring
    lea edx,RM
    call writestring
    mov eax, final_price
    call writedec
    mov al,'.'
    call writechar
    mov eax,final_price_floating_point             
    call adjust_final_floating_point
    call crlf
    mov esi,0
    call printreceiptnameandpassport
    jmp book_new

make_payment:
    lea edx, logo
    call writestring
    call crlf
    lea edx, receipt_total
    call writestring
    lea edx,tabline
    call writestring
    call writestring
    call writestring
    call writestring
    lea edx,RM
    call writestring
    mov eax, final_price
    call writedec
    mov al,'.'
    call writechar
    mov eax,final_price_floating_point             
    call adjust_final_floating_point
    call crlf

    ; Display payment method menu
    lea edx, payment_menu
    call WriteString

    ; Get user choice
    call ReadDec
    cmp eax, 1
    je online_banking
    cmp eax, 2
    je credit_debit_card
    cmp eax, 5
    je usermenu
    lea edx, invalid_choice
    call writestring
    jmp make_payment

    online_banking:
    lea edx, online_banking_msg
    call writestring
    jmp process_payment

credit_debit_card:
    lea edx, credit_debit_msg
    call writestring
    jmp process_payment

process_payment:
    ; Simulate payment processing
    lea edx, payment_success_msg
    call writestring
    call crlf
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
    call writechar
    movzx eax, byte ptr [esi]  ; get option number (0–9)
    mov ebx, OFFSET booking_table
    mov edx, [ebx + eax*4]     ; load pointer to message
    call writestring
    lea edx,RM
    call writestring
    mov ebx, OFFSET flight_price_table
    mov eax,[ebx+eax*4]
    call writedec
    call crlf

    inc esi
    loop printbookingloop
    mov selection,1
    ret

printbookloop endp

printdateloop proc

printdatesloop:
    movzx eax,selection
    call writedec
    movzx ax,selection
    inc ax
    mov selection,al
    mov al,'.'
    call writechar
    movzx eax, byte ptr [esi]  ; get option number (0–9)
    mov ebx, OFFSET date_table
    mov edx, [ebx + eax*4]     ; load pointer to message
    call writestring
    call crlf

    inc esi
    loop printdatesloop
    ret

printdateloop endp

printreceiptnameandpassport proc

output_loop:
    cmp esi, ticket_input
    jge return

    ; Print Name
    lea edx, receipt_name
    call writestring
    mov eax, esi
    inc eax
    call writedec
    lea edx,tabline
    call writestring
    call writestring
    mov eax, esi
    imul eax, 20
    lea edx, nameArray[eax]
    call writestring
    call crlf
    
    ; Print Passport
    lea edx, receipt_passport
    call writestring
    mov eax, esi
    inc eax
    call writedec
    lea edx,tabline
    call writestring
    mov eax, esi
    imul eax, 20
    lea edx, passportArray[eax]
    call writestring
    call crlf

    inc esi
    jmp output_loop

return:
    ret

printreceiptnameandpassport endp

membership_validation_check proc

    mov member_found, 0   
    lea edx, member_input
    mov ecx, 100
    call ReadString

    mov esi, OFFSET memberships

CheckLoop:
    cmp byte ptr [esi], "!"
    je CheckResult  ; End of membership list

    mov edi, OFFSET member_input
    push esi
    call compare_strings
    pop esi

    cmp eax, 0
    jne SkipCurrent

    ; Match found
    mov member_found, 1
    jmp CheckResult

SkipCurrent:
    ; Skip to next null-terminated string
SkipToNext:
    cmp byte ptr [esi], 0
    je Advance
    inc esi
    jmp SkipToNext

Advance:
    inc esi
    jmp CheckLoop

CheckResult:
    cmp member_found, 1
    je membership_yes

    ; No match found
    lea edx, membership_error
    call writestring
    ret

membership_yes:
    mov eax,5
    mov discount_rate,eax
    ret

membership_validation_check endp

compare_strings proc

compare_loop:
    mov al, [esi]        ; load char from first string
    mov bl, [edi]        ; load char from second string
    cmp al, bl
    jne not_equal        ; chars differ
    cmp al, 0
    je strings_equal     ; both hit null terminator
    inc esi
    inc edi
    jmp compare_loop

strings_equal:
    xor eax,eax        ; return 0 = equal
    ret

not_equal:
    mov eax, 1           ; return 1 = not equal
    ret

compare_strings endp

adjust_discount_floating_point proc

    cmp eax,0
    ja adjust
    mov eax,discount_floating_point
    call writedec
    call writedec
    ret

adjust:
    mov eax,discount_floating_point
    call writedec
    ret

adjust_discount_floating_point endp

adjust_final_floating_point proc

    cmp eax,0
    ja adjust
    mov eax,final_price_floating_point
    call writedec
    call writedec
    ret

adjust:
    mov eax,final_price_floating_point
    call writedec
    ret

adjust_final_floating_point endp

end main