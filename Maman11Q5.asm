#################### Data Segment ##################
.data
base: .asciiz "In what base to print 2-10?"
array: .word 0,2,-25,56,-5,6,-7,12,127,-3

try: .asciiz "HERE"
msgB: .asciiz "print_array_sign"
msgC: .asciiz "print_array_unsign"
msgC2: .asciiz "sum_sign"
msgD: .asciiz "sum_unsign"
msgE: .asciiz "print_dif_sign"
msgF: .asciiz "print_sum_unsign"
#################### Code Segment ##################

.text

main:

############################### A #####################################
 
    # --------- Print Original Message ---------
    la $a0, base      # Load address of input message to $a0
    li $v0, 4              # Syscall to print the string
    syscall
    
    # --------- Print New Line ---------
    li $v0, 11             # Syscall to print a single character
    li $a0, 10             # ASCII code for newline 
    syscall

    # --------- Read An Input ---------
    li $v0, 5              
    syscall	          # Syscall to read a integer
    blt $v0, 0x2, main        # If lower than 2
    bgt $v0, 0xA, main        # If upper than 10
    move $a1, $v0
    addi $sp, $sp, -4
    sw $a1, 0($sp)

############################### B #####################################
    # --------- Print Original Message ---------
    la $a0, msgB      # Load address of input message to $a0
    li $v0, 4              # Syscall to print the string
    syscall
    
    # --------- Print New Line ---------
    li $v0, 11             # Syscall to print a single character
    li $a0, 10             # ASCII code for newline 
    syscall
    
    # --------- TRY ---------
    la $a2, array 	          #array address
    jal print_array_sign
    
    # --------- Print New Line ---------
    li $v0, 11             # Syscall to print a single character
    li $a0, 10             # ASCII code for newline 
    syscall


############################### C #####################################
  
    # --------- Print Original Message ---------
    la $a0, msgC      # Load address of input message to $a0
    li $v0, 4              # Syscall to print the string
    syscall
    
    # --------- Print New Line ---------
    li $v0, 11             # Syscall to print a single character
    li $a0, 10             # ASCII code for newline 
    syscall
    
    # --------- TRY ---------
    la $a2, array 	          #array address
    jal print_array_unsign
    
    # --------- Print New Line ---------
    li $v0, 11             # Syscall to print a single character
    li $a0, 10             # ASCII code for newline 
    syscall

############################### C2 #####################################
  
    # --------- Print Original Message ---------
    la $a0, msgC2      # Load address of input message to $a0
    li $v0, 4              # Syscall to print the string
    syscall
    
    # --------- Print New Line ---------
    li $v0, 11             # Syscall to print a single character
    li $a0, 10             # ASCII code for newline 
    syscall
    
    # --------- TRY ---------
    la $a2, array 	          #array address
    jal sum_sign
    
    # --------- Print New Line ---------
    li $v0, 11             # Syscall to print a single character
    li $a0, 10             # ASCII code for newline 
    syscall
    
############################### D #####################################
  
    # --------- Print Original Message ---------
    la $a0, msgD           # Load address of input message to $a0
    li $v0, 4              # Syscall to print the string
    syscall
    
    # --------- Print New Line ---------
    li $v0, 11             # Syscall to print a single character
    li $a0, 10             # ASCII code for newline 
    syscall
    
    # --------- TRY ---------
    la $a2, array 	          #array address
    li $a3, 0	          #unsign
    jal sum_unsign
    
    # --------- Print New Line ---------
    li $v0, 11             # Syscall to print a single character
    li $a0, 10             # ASCII code for newline 
    syscall

############################### E #####################################
  
    # --------- Print Original Message ---------
    la $a0, msgE           # Load address of input message to $a0
    li $v0, 4              # Syscall to print the string
    syscall
    
    # --------- Print New Line ---------
    li $v0, 11             # Syscall to print a single character
    li $a0, 10             # ASCII code for newline 
    syscall
    
    # --------- TRY ---------
    la $a2, array 	          #array address
    li $a3, 1	          #unsign
    jal print_dif_sign
    
    # --------- Print New Line ---------
    li $v0, 11             # Syscall to print a single character
    li $a0, 10             # ASCII code for newline 
    syscall

############################### F #####################################
  
    # --------- Print Original Message ---------
    la $a0, msgF           # Load address of input message to $a0
    li $v0, 4              # Syscall to print the string
    syscall
    
    # --------- Print New Line ---------
    li $v0, 11             # Syscall to print a single character
    li $a0, 10             # ASCII code for newline 
    syscall
    
    # --------- TRY ---------
    la $a2, array 	          #array address
    li $a3, 0	          #unsign
    jal print_sum_unsign
    
    # --------- Print New Line ---------
    li $v0, 11             # Syscall to print a single character
    li $a0, 10             # ASCII code for newline 
    syscall
    
#######################################################################    

exitProgram:    
    li $v0, 10              # System call to terminate
    syscall                 # the program


################################# PRINT BASE ###################################
 
print_base: 
    # --------- saving arguments on to the stack ---------
    addiu $sp, $sp, -16 	#making room for 4 items
    sw $ra, 12($sp) 	#Save return address 
    sw $a3, 8($sp) 		#Save sign in stack
    sw $a2, 4($sp) 		#Save number in stack
    sw $a1, 0($sp) 		#Save base in stack
    
    # --------- loading arguments ---------
    lw $a3, 8($sp) 		#loading sign to $a3
    lw $a2, 4($sp) 		#loading number to $a2
    lw $a1, 0($sp) 		#loading base to $a1
    li $t1, 0x0		#initillize reminder counter
    li $t0, 0x0		#initillize counter for base 2
    blt $a2, 0x0, negative_sign	#check if the number is negative
    beq $a2, 0x0, loop	#check if the number is zero
    bne $a1, 0x2, not_base_2	#check if the not base 2	
    j loop
    
    
    # --------- 2's Complement ---------
negative_sign:
    beq $a3, 0, negative_unsign	#a3 == 0
    xori $a2, $a2, 0xFFFFFFFF 	#change bits 0 -> 1 or 1 -> 0
    addi $a2, $a2, 1	#add one bit
    li $v0, 11  	
    li $a0, 45  		# "-" in ASCII
    syscall 		#print -
    bne $a1, 0x2, not_base_2	#check if the not base 2	  			
    j loop

negative_unsign:
    addi $a2, $a2, 0xFFFFFFFF 	#change bits 0 -> 1 or 1 -> 0
    addi $a2, $a2, 1	#add one bit
  		
not_base_2:
    beq $a2, 0x0, print_number
			    			    			  			    			    						    			    			  			    			    				    			    			  			    			    						    			    			  			    			    					    			    			  			    			    						    			    			  			    			    				    			    			  			    			    						    			    			  			    			    			
    # --------- divide number by base ---------
loop:     
    beq $t0, 31, print_number	#loop for 32 bits
    divu $a2, $a1		#divide number in base 
    mflo $a2 		#saving the diveded number
    mfhi $t2		#saving the reminder number
    addiu $sp, $sp, -4	#making room for the new reminder
    sw $t2, 0($sp)		#pushing to stack the new reminder
    addi $t1, $t1, 0x1	#counter ++
    addi $t0, $t0, 0x1	#counter ++
    bne $a1, 0x2, not_base_2
    j loop
    
print_number:
    beq $t1, 0x0, return_to_caller	#if counter is not zero
    lw $a0, 0($sp)		#load the top reminder
    li $v0, 1		
    sub $t1, $t1, 1		#decrease counter
    syscall		#print integer
    addiu $sp, $sp, 4	#pop the top number
    j print_number
    
    # --------- return to the caller ---------
return_to_caller:
    lw $a1, 0($sp) 		#Restore base
    lw $a2, 4($sp) 		#Restore number
    lw $a3, 8($sp) 		#Restore sign 
    lw $ra, 12($sp) 	#Restore function address 
    addiu $sp, $sp,16 	#pop the stack
    jr $ra 		#return from caller
    
################################# STORE & LOAD ###################################
    # --------- return to the caller ---------
load:
    lw $a1, 0($sp) 		#Restore base
    lw $a2, 4($sp) 		#Restore number
    lw $ra, 8($sp) 		#Restore function address 
    addiu $sp, $sp,12 	#pop the stack
    jr $ra 		#return from caller
    
################################# PRINT ARRAY SIGN ###################################

print_array_sign:
    # --------- saving arguments on to the stack ---------
    addiu $sp, $sp, -12 	#making room for 4 items
    sw $ra, 8($sp) 		#Save return address 
    sw $a2, 4($sp) 		#Save number in stack
    sw $a1, 0($sp) 		#Save base in stack
    
    # --------- initillize variables ---------
    lw $t2, 4($sp) 		#loading array address to $t2
    lw $a1, 0($sp) 		#loading base to $a1
    li $t3, 0		#initillize array index $t3=0
    li $t1, 10		#initillize array length $t4=10

pas_loop:
    beq $t3, $t1, pas_end	#loop untill $t3=10
    lw $a2, 0($t2)		#initillize a2=t2[i]
    addiu $sp, $sp, -12	#makking room for the current index 
    sw $t2, 0($sp)		#saving array index
    sw $t1, 4($sp)		#saving the loop index
    li $a3, 1
    sw $a3, 8($sp)
    
    jal print_base
    
    lw $a3, 8($sp)
    lw $t1, 4($sp)		#restore loop index into $t1
    lw $t2, 0($sp)		#restore array index into $t2
    addiu $sp, $sp, 12	#poping the value
    addi $t3, $t3, 1	#increasing loop index
    addi $t2, $t2, 4	#increasing array index
    
    la $a0, 0x20		#loading space in ASCII
    li $v0, 11
    syscall		#making space
    
    j pas_loop
    
pas_end:
    j load

################################# PRINT ARRAY UNSIGN ###################################

print_array_unsign:
    # --------- saving arguments on to the stack ---------
    addiu $sp, $sp, -12 	#making room for 4 items
    sw $ra, 8($sp) 		#Save return address 
    sw $a2, 4($sp) 		#Save number in stack
    sw $a1, 0($sp) 		#Save base in stack
    
    # --------- initillize variables ---------
    lw $t2, 4($sp) 		#loading array address to $t2
    lw $a1, 0($sp) 		#loading base to $a1
    li $t3, 0		#initillize array index $t3=0
    li $t1, 10		#initillize array length $t4=10

pau_loop:
    beq $t3, $t1, pau_end	#loop untill $t3=10
    lw $a2, 0($t2)		#initillize a2=t2[i]
    addiu $sp, $sp, -12	#makking room for the current index 
    sw $t2, 0($sp)		#saving array index
    sw $t1, 4($sp)		#saving the loop index
    li $a3, 0
    sw $a3, 8($sp)
    
    jal print_base
    
    lw $a3, 8($sp)
    lw $t1, 4($sp)		#restore loop index into $t1
    lw $t2, 0($sp)		#restore array index into $t2
    addiu $sp, $sp, 12	#poping the value
    addi $t3, $t3, 1	#increasing loop index
    addi $t2, $t2, 4	#increasing array index
    
    la $a0, 0x20		#loading space in ASCII
    li $v0, 11
    syscall		#making space
    
    j pau_loop
    
pau_end:
    j load

################################# SUM SIGN ###################################

sum_sign:
    # --------- saving arguments on to the stack ---------
    addiu $sp, $sp, -12 	#making room for 4 items
    sw $ra, 8($sp) 		#Save return address 
    sw $a2, 4($sp) 		#Save array address in stack
    sw $a1, 0($sp) 		#Save base in stack
    
    # --------- initillize variables ---------
    lw $t2, 4($sp) 		#loading array address to $t2
    lw $a1, 0($sp) 		#loading base to $a1
    li $t3, 0		#initillize array index $t3=0
    li $t1, 10		#initillize array length $t4=10
    li $a3, 0		#initillize array index $a2=0

ss_loop:
    beq $t3, $t1, ss_end	#loop untill $t3=10
    lw $a2, 0($t2)		#initillize a2=t2[i]
    add $a3, $a3, $a2
    addiu $sp, $sp, -8	#makking room for the current index 
    sw $t2, 0($sp)		#saving array index
    sw $t1, 4($sp)		#saving the loop index


    lw $t1, 4($sp)		#restore loop index into $t1
    lw $t2, 0($sp)		#restore array index into $t2
    addiu $sp, $sp, 8	#poping the value
    addi $t3, $t3, 1	#increasing loop index
    addi $t2, $t2, 4	#increasing array index

    j ss_loop
        

ss_end:
    move $a2, $a3
    li $a3, 1
    jal print_base
    j load
    
    
################################# SUM UNSIGN ###################################

sum_unsign:
    # --------- saving arguments on to the stack ---------
    addiu $sp, $sp, -12 	#making room for 4 items
    sw $ra, 8($sp) 	                    #Save return address 
    sw $a2, 4($sp) 		#Save number in stack
    sw $a1, 0($sp) 		#Save base in stack
    
    # --------- initillize variables ---------
    lw $t2, 4($sp) 		#loading array address to $t2
    lw $a1, 0($sp) 		#loading base to $a1
    li $t3, 0		#initillize array index $t3=0
    li $t1, 10		#initillize array length $t4=10
    li $a3, 0		#initillize array index $a2=0

su_loop:
    beq $t3, $t1, su_end	#loop untill $t3=10
    lw $a2, 0($t2)		#initillize a2=t2[i]
    addu $a3, $a3, $a2	#a3+=a2 as unsign numbers
    addiu $sp, $sp, -8	#makking room for the current index 
    sw $t2, 0($sp)		#saving array index
    sw $t1, 4($sp)		#saving the loop index


    lw $t1, 4($sp)		#restore loop index into $t1
    lw $t2, 0($sp)		#restore array index into $t2
    addiu $sp, $sp, 8	#poping the value
    addi $t3, $t3, 1	#increasing loop index
    addi $t2, $t2, 4	#increasing array index

    j su_loop

su_end:
    move $a2, $a3
    li $a3, 0
    jal print_base
    j load

################################# PRINT DIF SIGN ###################################

print_dif_sign:
    # --------- saving arguments on to the stack ---------
    addiu $sp, $sp, -12 	#making room for 4 items
    sw $ra, 8($sp) 		#Save return address 
    sw $a2, 4($sp) 		#Save array address in stack
    sw $a1, 0($sp) 		#Save base in stack
    
    # --------- initillize variables ---------
    lw $t2, 4($sp) 		#loading array address to $t2
    lw $a1, 0($sp) 		#loading base to $a1
    li $t3, 0		#initillize array index $t3=0
    li $t1, 9		#initillize array length $t4=8
    li $a3, 1		#initillize dif $a3=0

pds_loop:
    beq $t3, $t1, pds_end	#loop untill $t3=10
    lw $a2, 0($t2)		#initillize a2=t2[i]
    lw $a0, 4($t2)
    sub $a2, $a2, $a0	#a2-=t2[i] as unsign numbers
    addiu $sp, $sp, -8	#makking room for the current index 
    sw $t2, 0($sp)		#saving array index
    sw $t1, 4($sp)		#saving the loop index

    li $a3, 1
    jal print_base
    
    la $a0, 0x20		#loading space in ASCII
    li $v0, 11
    syscall		#making space

    lw $t1, 4($sp)		#restore loop index into $t1
    lw $t2, 0($sp)		#restore array index into $t2
    addiu $sp, $sp, 8	#poping the value
    addi $t3, $t3, 1	#increasing loop index
    addi $t2, $t2, 4	#increasing array index
    
    j pds_loop
    
pds_end:
    j load

################################# PRINT SUM UNSIGN ###################################

print_sum_unsign:
    # --------- saving arguments on to the stack ---------
    addiu $sp, $sp, -12 	#making room for 4 items
    sw $ra, 8($sp) 		#Save return address 
    sw $a2, 4($sp) 		#Save array address in stack
    sw $a1, 0($sp) 		#Save base in stack
    
    # --------- initillize variables ---------
    lw $t2, 4($sp) 		#loading array address to $t2
    lw $a1, 0($sp) 		#loading base to $a1
    li $t3, 0		#initillize array index $t3=0
    li $t1, 9		#initillize array length $t4=8
    li $a3, 0		#initillize dif $a3=0

psu_loop:
    beq $t3, $t1, psu_end	#loop untill $t3=10
    lw $a2, 0($t2)		#initillize a2=t2[i]
    lw $a0, 4($t2)
    addu $a2, $a2, $a0	#a2-=t2[i] as unsign numbers
    addiu $sp, $sp, -8	#makking room for the current index 
    sw $t2, 0($sp)		#saving array index
    sw $t1, 4($sp)		#saving the loop index

    li $a3, 0
    jal print_base
    
    la $a0, 0x20		#loading space in ASCII
    li $v0, 11
    syscall		#making space

    lw $t1, 4($sp)		#restore loop index into $t1
    lw $t2, 0($sp)		#restore array index into $t2
    addiu $sp, $sp, 8	#poping the value
    addi $t3, $t3, 1	#increasing loop index
    addi $t2, $t2, 4	#increasing array index
    
    j psu_loop
    
psu_end:
    j load
