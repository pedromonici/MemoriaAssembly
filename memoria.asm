jmp main


tela0Linha1  : string "*--0--*--1--*--2--*--3--*--4--*         "
tela0Linha2  : string "|     |     |     |     |     |         "
tela0Linha3  : string "|     |     |     |     |     |         "
tela0Linha4  : string "|     |     |     |     |     |         "
tela0Linha5  : string "*--5--*--6--*--7--*--8--*--9--*         "
tela0Linha6  : string "|     |     |     |     |     |         "
tela0Linha7  : string "|     |     |     |     |     |         "
tela0Linha8  : string "|     |     |     |     |     |         "
tela0Linha9  : string "*--10-*--11-*--12-*--13-*--14-*         "
tela0Linha10 : string "|     |     |     |     |     |         "
tela0Linha11 : string "|     |     |     |     |     |         "
tela0Linha12 : string "|     |     |     |     |     |         "
tela0Linha13 : string "*--15-*--16-*--17-*--18-*--19-*         "
tela0Linha14 : string "|     |     |     |     |     |         "
tela0Linha15 : string "|     |     |     |     |     |         "
tela0Linha16 : string "|     |     |     |     |     |         "
tela0Linha17 : string "*-----*-----*-----*-----*-----*         "
tela0Linha18 : string "                                        "
tela0Linha19 : string "                                        "
tela0Linha20 : string "                                        "
tela0Linha21 : string "                                        "
tela0Linha22 : string "                                        "
tela0Linha23 : string "                                        "
tela0Linha24 : string "                                        "
tela0Linha25 : string "                                        "
tela0Linha26 : string "                                        "
tela0Linha27 : string "                                        "
tela0Linha28 : string "                                        "
tela0Linha29 : string "                                        "

test : var #20
static test + #0, #0
static test + #1, #1
static test + #2, #2
static test + #3, #3
static test + #4, #4
static test + #5, #5
static test + #6, #6
static test + #7, #7
static test + #8, #8
static test + #9, #9
static test + #10, #0
static test + #11, #1
static test + #12, #2
static test + #13, #3
static test + #14, #4
static test + #15, #5
static test + #16, #6
static test + #17, #7
static test + #18, #8
static test + #19, #9

error_label : string "INVALID CARD TYPE ENTER TO TRY AGAIN    "
empty_card_error: string "INVALID POSITION TYPE ENTER TO TRY AGAIN"

cards: var #20       ; int rand
empty: var #20       ; booleano
user_input: var #3   ; input do numero do usuario + ENTER

players_points: var #2 ; pontos dos jogadores
user_input_num: var #1 ; pontos do jogador2 -> int

; num_pair:          var #1 ; numero de pares totais no tabuleiro
; num_visible_pairs: var #1 ; numero de pares visíveis no tabuleiro

cur_player_idx:  var #1 ; indice do jogador que esta jogando atualmente
cur_player_pair: var #2 ; par de cartas escolhidas na jogada atualmente

type_a_card: string " Digite uma carta:                                                              "
rand : string "01234567890123456789                    "

main:
    push r0
    push r1
    push r2
    loadn r0, #tela0Linha1  ; endereço onde começa a primeira linha do tabuleiro
    call print_board

    call rand_cards_init
    call empty_init

    loadn r1, #10 ; quantidade total de pares
    loadn r2, #0  ; quantidade atual de pares visiveis
    loadn r3, #0  ; indice do jogador que esta jogando atualmente
    loadn r4, #0  ; indice da escolha desse jogador
    loop_main:
        choice_one: ; cur_player_pair[r4] = input()
            call get_input
            call play
        inc r4

        choice_two: ; cur_player_pair[r4] = input()
            call get_input
            call play
        loadn r4, #0

        call check_cur_pair ; checar se o conteudo do label cur_player_pair sao igual
        pair_is_equals:
            inc players_points[r3]
            inc r2
            update empty
        pair_is_not_equals:
            pass

        cmp r1, r2
        jne loop_main

    pop r2
    pop r1
    pop r0
    halt

print_board:
    push fr  ; registrador de flags

    loadn r0, #tela0Linha1 ; endereço onde começa a primeira linha do tabuleiro
    loadn r1, #0           ; posicao inicial, começo da tela
    loadn r2, #40          ; incremento da posicao da tela
    loadn r3, #41          ; incremento do ponteiro das linhas da tela
    loadn r4, #1200        ; tamanho maximo da tela

    print_board_loop:
        call print_str
        add  r1, r1, r2  ; incrementa a posicao para a segunda linha
        add  r0, r0, r3  ; incrementa o ponteiro para o começo da segunda linha
        cmp  r1, r4      ; compara r1 com 1200
        jne  print_board_loop

    pop fr
    rts

print_str:
    push fr
    push r0     ; endereço do inicio da string a ser printada
    push r1     ; posiçao inicial da tela
    push r4     ; tamanho maximo da tela

    loadn r6, #0    ; cor da string
    loadn r4, #'\0' ; criterio de parada
    print_str_loop:
        loadi   r5, r0
        cmp     r5, r4
        jeq     print_str_exit
        add     r5, r5, r6
        outchar r5, r1
        inc     r1
        inc     r0
        jmp     print_str_loop

    print_str_exit:
        pop r4
        pop r1
        pop r0
        pop fr
        rts

rand_cards_init:
    push fr
    push r0
    push r2
    push r3
    push r4
    push r5

    loadn r0, #rand  ; carregar o primeiro numero rand
    loadn r3, #cards ; vetor de cards
    loadn r2, #0     ; contador do loop
    loadn r4, #20    ; numero de cards a serem randomizadas
    rand_cards_loop:
        loadi  r5, r0      ; pegar o endereço do vetor de rand
        storei r3, r5      ; colocar em cards o valor do vetor de rand
        inc    r0          ; incremento do ponteiro do array de rands
        inc    r3          ; incremento do ponteiro do array de cards
        inc    r2          ; counter++
        cmp    r2, r4      ; if counter == 20, exit call
        jne   rand_cards_loop

    pop r5
    pop r0
    pop r4
    pop r3
    pop r2
    pop fr
    rts

empty_init:
    push fr
    push r0
    push r1
    push r2
    push r3

    loadn r0, #0          ; valor false para todos
    loadn r1, #empty      ; endereço do vetor empty
    loadn r2, #0          ; counter
    loadn r3, #20         ; criterio de parada
    empty_init_loop:
        storei r1, r0     ; colocar em empty o valor false
        inc    r1         ; incremento do ponteiro do vetor empty
        inc    r2         ; counter++
        cmp    r2, r3     ; if counter == 20, exit call
        jne    empty_init_loop

    pop r3
    pop r2
    pop r1
    pop r0
    pop fr
    rts


get_input:
    ;breakp
    push fr
    push r0
    push r1
    push r4

    loadn r1, #720           ; posição da tela a ser impressa a string
    loadn r0, #type_a_card   ; endereço da string a ser impressa
    loadn r4, #1200          ; tamanho maximo da tela
    call print_str
    ;breakp

    jmp typing_a_card

    get_input_final:
        pop r4
        pop r1
        pop r0
        pop fr
        ;breakp
        rts

typing_a_card:
    push fr
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7

    loadn r1, #742   ; posicao para colocar o char
    loadn r4, #1200  ; tamanho maximo da tela
    loadn r2, #255   ; valor padrao do inchar
    loadn r3, #13    ; codigo ascii do enter
    loadn r5, #user_input ; vetor do input do usuario
    loadn r6, #0     ; counter do input
    loadn r7, #4     ; numero de caracteres maximo do input (ENTER INCLUSO)
    typing_a_card_loop_ext:
        typing_a_card_loop_int:
            inchar r0       ; leitura do char
            cmp    r0, r2   ; compara com o valor padrao pra ver se tem q sair
            jeq    typing_a_card_loop_int

        outchar r0, r1 ; printa o char na tela
        inc     r6     ; counter++
        cmp     r6, r7
        jeq     typing_a_card_error
        storei  r5, r0 ; guarda o valor do input no vetor de input
        inc     r5     ; incrementa o endereço do vetor de input
        inc     r1     ; incrementa a posicao da tela
        cmp     r0, r3 ; if char==enter, go out
        jne     typing_a_card_loop_ext

    ;breakp
    jmp verify_number

    verify_number_return:
        pop r7
        pop r6
        pop r5
        pop r4
        pop r3
        pop r2
        pop r1
        pop r0
        pop fr
        ;breakp
        ;rts
        jmp get_input_final

    verify_number_return_error:
        pop r7
        pop r6
        pop r5
        pop r4
        pop r3
        pop r2
        pop r1
        pop r0
        pop fr
        pop r4
        pop r1
        pop r0
        pop fr
        ;breakp
        jmp get_input

typing_a_card_error:
    push fr
    push r0
    push r1
    push r2
    push r3

    loadn r0, #error_label
    loadn r1, #760          ; posicao da tela
    loadn r2, #13           ; codigo ascii do enter

    typing_a_card_error_loop:
        call print_str
        inchar r3               ; pega o enter
        cmp    r3, r2           ; if char == enter, go out
        jne    typing_a_card_error_loop

    pop r3
    pop r2
    pop r1
    pop r0
    pop fr
    jmp verify_number_return_error

verify_number:
    push fr
    push r0
    push r2
    push r3
    push r5

    loadn r0, #user_input
    loadn r1, #0   ; counter
    loadn r2, #13  ; codigo ascii do enter
    verify_number_loop:
        loadi r3, r0
        inc   r0        ; incrementar o ponteiro do vetor e input
        inc   r1        ; counter++
        cmp   r3, r2    ; if char == enter, go out
        jne   verify_number_loop

    loadn r3, #2
    cmp r1, r3
    jeq verify_number_one_digit
    jne verify_number_two_digits

    verify_number_exit:
        cmp r1, r3
        jeq verify_if_number_is_open_one_digit
        jne verify_if_number_is_open_two_digits
        verify_number_exit_two:
            pop r5
            pop r3
            pop r2
            pop r0
            pop fr
            jmp verify_number_return

typing_a_card_error_version_two:
    push fr
    push r0
    push r1
    push r2
    push r3

    loadn r0, #error_label
    loadn r1, #760          ; posicao da tela
    loadn r2, #13           ; codigo ascii do enter

    call print_str
    ;breakp
    typing_a_card_error_loop_yey:
        inchar r3               ; pega o enter
        cmp    r3, r2           ; if char == enter, go out
        jne    typing_a_card_error_loop_yey
        jeq    continue

    continue:
        pop r3
        pop r2
        pop r1
        pop r0
        pop fr

        ;breakp

        pop r5
        pop r3
        pop r2
        pop r0
        pop fr

        pop r5
        pop r3
        pop r2
        pop r0
        pop fr

        jmp verify_number_return_error

verify_number_one_digit:
    push fr
    push r0
    push r2
    push r3
    push r5

    ; verificao de todos os numeros 0..9
    loadn r0, #user_input
    loadi r5, r0

    loadn r2, #48
    loadn r3, #57
    cmp   r5, r2        ; r5 < r2
    jle   typing_a_card_error_version_two
    cmp   r5, r3
    jgr   typing_a_card_error_version_two

    pop r5
    pop r3
    pop r2
    pop r0
    pop fr
    jmp   verify_number_exit

verify_number_two_digits:
    push fr
    push r0
    push r2
    push r3
    push r5

    ; verificao de todos os numeros 0..9(primeiro numero)
    loadn r0, #user_input
    loadi r5, r0

    loadn r2, #48
    loadn r3, #49
    cmp   r5, r2        ; r5 < '0'
    jle   typing_a_card_error_version_two
    cmp   r5, r3        ; r5 > '1'
    jgr   typing_a_card_error_version_two

    ; verificao de todos os numeros 0..9(segundo numero)
    inc r0
    loadi r5, r0

    loadn r3, #57
    cmp r5, r2
    jle typing_a_card_error_version_two
    cmp r5, r3
    jgr typing_a_card_error_version_two

    pop r5
    pop r3
    pop r2
    pop r0
    pop fr
    jmp verify_number_exit

typing_a_card_error_version_third:
    push fr
    push r0
    push r1
    push r2
    push r3

    loadn r0, #error_label
    loadn r1, #760          ; posicao da tela
    loadn r2, #13           ; codigo ascii do enter

    call print_str
    typing_a_card_error_loop_maneiro:
        inchar r3               ; pega o enter
        cmp    r3, r2           ; if char == enter, go out
        jne    typing_a_card_error_loop_maneiro

    pop r3
    pop r2
    pop r1
    pop r0
    pop fr

    pop r7
    pop r6
    pop r5
    pop r3
    pop r1
    pop r0
    pop fr

    pop r5
    pop r3
    pop r2
    pop r0
    pop fr

    jmp verify_number_return_error

verify_if_number_is_open_one_digit:
    push fr
    push r0
    push r1
    push r3
    push r5
    push r6
    push r7

    loadn r0, #user_input   ; endereço do vetor de inputs
    loadi r5, r0            ; carrego o char do input
    loadn r1, #empty        ; endereço do vetor de vazios
    loadn r3, #0            ; valor de CARTA NAO ABERTA

    loadn r7, #48             ; #48 - #48 = #0    #49 - #48 = #1
    sub   r5, r5, r7          ; transformo o char em int
    add   r1, r1, r5          ; incremento o endereço o tanto q tem q incrementar
    loadi r6, r1              ; carrego o valor do vetor de CARTAS NAO ABERTAS
    cmp   r6, r3              ; if valor != 0, error
    jne   typing_a_card_error_version_third

    pop r7
    pop r6
    pop r5
    pop r3
    pop r1
    pop r0
    pop fr
    jmp verify_number_exit_two

verify_if_number_is_open_two_digits:
    push fr
    push r0
    push r1
    push r3
    push r5
    push r6
    push r7

    loadn r0, #user_input  ; endereço do vetor de inputs
    inc   r0               ; pega o segundo char
    loadi r5, r0           ; carrego o char do input
    loadn r1, #empty       ; endereço do vetor de vazios
    loadn r3, #0           ; valor de CARTA NAO ABERTA
    loadn r2, #10

    loadn r7, #48          ; $48 - #48 = #0     #49 - #48 = #1
    sub   r5, r5, r7       ; transformo o char em int
    add   r1, r1, r5       ; incremento o endereço o tanto que tem q incrementar
    add   r1, r1, r2       ; r1 += 10
    loadi r6, r1           ; carrego o valor do vetor de CARTAS NAO ABERTAS
    cmp   r6, r3           ; if valor != 0, error
    jne   typing_a_card_error_version_third

    pop r7
    pop r6
    pop r5
    pop r3
    pop r1
    pop r0
    pop fr
    jmp verify_number_exit_two

play:
    push fr
    push r0

    loadn r0, #user_input
    call str_to_int
    call update_table

    pop r0
    pop fr
    rts

str_to_int:
    push fr
    push r0
    push r1
    push r2
    push r3

    loadn r0, #user_input

    loadn r1, #0  ;counter
    loadn r2, #13 ;enter
    str_to_int_loop:
        loadi r3, r0
        inc r1
        inc r0
        cmp r3, r2
        jne str_to_int_loop

    loadn r3, #2
    cmp r1, r3
    ceq str_to_int_one_char
    cne str_to_int_two_char

    pop r3
    pop r2
    pop r1
    pop r0
    pop fr
    rts

str_to_int_one_char:
    push fr
    push r0
    push r4
    push r2
    push r3

    loadn  r4, #48
    loadn  r0, #user_input
    loadi  r2, r0
    sub    r2, r2, r4
    store  user_input_num, r2

    pop r3
    pop r2
    pop r4
    pop r0
    pop fr
    rts

str_to_int_two_char:
    push fr
    push r0
    push r2
    push r4
    push r6
    push r3

    loadn  r6, #10
    loadn  r4, #48
    loadn  r0, #user_input
    inc    r0
    loadi  r2, r0
    sub    r2, r2, r4
    add    r2, r2, r6
    store  user_input_num, r2

    pop r3
    pop r6
    pop r4
    pop r2
    pop r0
    pop fr
    rts

update_table:
    push fr
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5

    ;jmp verify_card_is_empty

    card_is_empty:
        loadn r0, #83
        loadn r1, #user_input_num
        loadi r1, r1
        loadn r2, #160
        loadn r3, #5
        loadn r4, #6

        div r5, r1, r3
        mul r5, r5, r2
        add r0, r0, r5

        mod r1, r1, r3
        mul r1, r1, r4
        add r0, r0, r1   ; r0 -> pos pra printar

        ; deixar a carta como vista
        loadn  r1, #user_input_num
        loadi  r1, r1
        loadn  r6, #empty
        add    r6, r6, r1
        loadn  r2, #1
        storei r6, r2

        ;breakp
        loadn r2, #cards
        add   r2, r2, r1
        loadi r2, r2
        loadn r3, #2304
        add   r2, r2, r3 ; cor vermelho

        ; PRINT RAND NUM
        outchar r2, r0



        pop r5
        pop r4
        pop r3
        pop r2
        pop r1
        pop r0
        pop fr
        rts

;verify_card_is_empty:
    ;push fr
    ;push r0
    ;push r1
    ;push r2

    ;loadn r0, #user_input_num
    ;loadi r0, r0

    ;loadn r1, #empty
    ;add   r1, r1, r0
    ;loadi r1, r1
    ;loadn r2, #1
    ;cmp   r1, r2
    ;jeq   card_is_empty_error

    ;pop r2
    ;pop r1
    ;pop r0
    ;pop fr
    ;jmp card_is_empty

    ;verify_card_is_empty_final:
        ;pop r2
        ;pop r1
        ;pop r0
        ;pop fr
        ;jmp loop_main

;card_is_empty_error:
    ;push fr
    ;push r0
    ;push r1
    ;push r2
    ;push r3

    ;loadn r0, #empty_card_error
    ;loadn r1, #760
    ;loadn r2, #13

    ;card_is_empty_error_loop:
        ;call print_str
        ;inchar r3
        ;cmp r3, r2
        ;jne typing_a_card_error_loop

    ;pop r3
    ;pop r2
    ;pop r1
    ;pop r0
    ;pop fr
    ;jmp verify_card_is_empty_final

