#include <xc.inc>
    
GLOBAL _pass_variable_between_C_and_ASM, _var_global  ;we must declare the global variable
    
    
PSECT text3, local, class=CODE, reloc=2
 
#define temp_variable 3
 
; this function does 2 things:
 
; 1 - receives an input, adds 5 and returns the result
 ; 2- adds 1 to the global variable
 
 ; the argument we give the function (in this example, 3) when we call it in C is stored in the working register W
 
 ; When  the function ends, it returns the value of W to the variable 'result' in C
 
 
 _pass_variable_between_C_and_ASM:
    
    ; the argument (3) is stored in W whe we call the function  ;> argumento 3 esta no W
    
    ADDLW 0x05   ;Now we add "5" to W. -> sumamos 5 ao W -> w = 8
    
    
    ; incrementar uma variavel global -> NUMERO DE CICLOS FEITOS -> para isso precisamos do w, logo vamos guardar o valor de w numa variavel temp
    ;now we are going to add a value to the global variable var_global, and we will need to use the W register. Since the function returns the value of W,
    ;we must save it.
    MOVWF temp_variable 
    
    ;store W in a variable ; variavel temp para guardar W ; temp = 8
    
    ;add 1 to the global variable
    
    BANKSEL _var_global 
    
    MOVLW 0x01
    ADDWF _var_global, 1
    
     ;the "1" in this instruction tells the compiler to save the result of the ADD to _var_global. If it was "0" it would be saved in "W".
                          ; adicionamos o w � var global ; var = var + 1 
			  ; ,1 pq o valor ta a ser guardado em var
			  
    ;now we need to recover the W to return the result of adding (3) with (5).
    
    ANDLW 0x00   ; w = 0 para juntar 0 � temp = 8 
    ADDWF  temp_variable, 0   ;put the variable value back into W for the return. Here it is "0" so that the ADD is saved into W.
                             ; ,0 esta a ser guardado no w
			     ; temp + w = 8 + 0 = 8 = w
   
			
			     
    RETURN      ;when the function returns, the _var_global value is already updated and it will return the W value back to C for it to put in "result"

            ; no final w = 8 
    


