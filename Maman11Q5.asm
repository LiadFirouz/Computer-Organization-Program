# Title:        Maman 11 Question 5
# Filename:     Maman11Q5.asm
# Author:       Liad Firouz
# Date:         8.12.24
# Description:  
#               This MIPS assembly program performs various operations on an array 
#               of integers, including printing elements in different bases, 
#               computing the sum of signed and unsigned elements, and calculating
#               differences between consecutive elements. 
# Input:        
#               - A user-specified base (integer between 2 and 10) for number printing.
# Output:       
#               - The array elements printed in the specified base as signed or 
#                 unsigned integers.
#               - The sum of array elements printed as signed or unsigned integers.
#               - Differences between consecutive array elements (signed).

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

############################### Section A: Input Validation ###############################
 
    # --------- Print the Prompt Message ---------
    la $a0, base              # Load the address of the input message into $a0
    li $v0, 4                 # System call to print a string
    syscall
    
    # --------- Print a New Line ---------
    li $v0, 11                # System call to print a single character
    li $a0, 10                # ASCII code for a newline 
    syscall

    # --------- Read an Integer Input ---------
    li $v0, 5                 # System call to read an integer
    syscall                   # Execute system call
    blt $v0, 0x2, main        # If input is less than 2, go back to main
    bgt $v0, 0xA, main        # If input is greater than 10, go back to main
    move $a1, $v0             # Store the valid input in $a1
    addi $sp, $sp, -4         # Allocate space on the stack
    sw $a1, 0($sp)            # Save the input onto the stack

############################### Section B: Print Array Sign ###############################

    # --------- Print the Prompt Message ---------
    la $a0, msgB              # Load the address of the message into $a0
    li $v0, 4                 # System call to print a string
    syscall
    
    # --------- Print a New Line ---------
    li $v0, 11                # System call to print a single character
    li $a0, 10                # ASCII code for a newline
    syscall
    
    # --------- Call Subroutine to Process Array ---------
    la $a2, array             # Load the array's base address into $a2
    jal print_array_sign       # Jump to the 'print_array_sign' subroutine
    
    # --------- Print a New Line ---------
    li $v0, 11                # System call to print a single character
    li $a0, 10                # ASCII code for a newline
    syscall

############################### Section C: Print Array Unsigned ############################
  
    # --------- Print the Prompt Message ---------
    la $a0, msgC              # Load the address of the message into $a0
    li $v0, 4                 # System call to print a string
    syscall
    
    # --------- Print a New Line ---------
    li $v0, 11                # System call to print a single character
    li $a0, 10                # ASCII code for a newline
    syscall
    
    # --------- Call Subroutine to Process Array ---------
    la $a2, array             # Load the array's base address into $a2
    jal print_array_unsign     # Jump to the 'print_array_unsign' subroutine
    
    # --------- Print a New Line ---------
    li $v0, 11                # System call to print a single character
    li $a0, 10                # ASCII code for a newline
    syscall

############################### Section C2: Sum Array Signed ##############################
  
    # --------- Print the Prompt Message ---------
    la $a0, msgC2             # Load the address of the message into $a0
    li $v0, 4                 # System call to print a string
    syscall
    
    # --------- Print a New Line ---------
    li $v0, 11                # System call to print a single character
    li $a0, 10                # ASCII code for a newline
    syscall
    
    # --------- Call Subroutine to Calculate Sum ---------
    la $a2, array             # Load the array's base address into $a2
    jal sum_sign               # Jump to the 'sum_sign' subroutine
    
    # --------- Print a New Line ---------
    li $v0, 11                # System call to print a single character
    li $a0, 10                # ASCII code for a newline
    syscall

############################### Section D: Sum Array Unsigned #############################
  
    # --------- Print the Prompt Message ---------
    la $a0, msgD              # Load the address of the message into $a0
    li $v0, 4                 # System call to print a string
    syscall
    
    # --------- Print a New Line ---------
    li $v0, 11                # System call to print a single character
    li $a0, 10                # ASCII code for a newline
    syscall
    
    # --------- Call Subroutine to Calculate Sum ---------
    la $a2, array             # Load the array's base address into $a2
    li $a3, 0                 # Specify unsigned operation mode
    jal sum_unsign             # Jump to the 'sum_unsign' subroutine
    
    # --------- Print a New Line ---------
    li $v0, 11                # System call to print a single character
    li $a0, 10                # ASCII code for a newline
    syscall

############################### Section E: Print Differences #############################
  
    # --------- Print the Prompt Message ---------
    la $a0, msgE              # Load the address of the message into $a0
    li $v0, 4                 # System call to print a string
    syscall
    
    # --------- Print a New Line ---------
    li $v0, 11                # System call to print a single character
    li $a0, 10                # ASCII code for a newline
    syscall
    
    # --------- Call Subroutine to Print Differences ---------
    la $a2, array             # Load the array's base address into $a2
    li $a3, 1                 # Specify signed operation mode
    jal print_dif_sign         # Jump to the 'print_dif_sign' subroutine
    
    # --------- Print a New Line ---------
    li $v0, 11                # System call to print a single character
    li $a0, 10                # ASCII code for a newline
    syscall

############################### Section F: Print Sum Unsigned ############################
  
    # --------- Print the Prompt Message ---------
    la $a0, msgF              # Load the address of the message into $a0
    li $v0, 4                 # System call to print a string
    syscall
    
    # --------- Print a New Line ---------
    li $v0, 11                # System call to print a single character
    li $a0, 10                # ASCII code for a newline
    syscall
    
    # --------- Call Subroutine to Print Sum ---------
    la $a2, array             # Load the array's base address into $a2
    li $a3, 0                 # Specify unsigned operation mode
    jal print_sum_unsign       # Jump to the 'print_sum_unsign' subroutine
    
    # --------- Print a New Line ---------
    li $v0, 11                # System call to print a single character
    li $a0, 10                # ASCII code for a newline
    syscall
    
############################### Exit Program ##############################################

exitProgram:    
    li $v0, 10                # System call to terminate the program
    syscall                   # Execute system call

################################# PRINT BASE ###################################
# Function: print_base
# Purpose: Print a number (`$a2`) in a specified base (`$a1`) with support for signed/unsigned representation (`$a3`).
# Registers:
#   $a1 - Base (e.g., 2, 10)
#   $a2 - Number to convert and print
#   $a3 - Sign indicator (1 = signed, 0 = unsigned)
# Stack Usage:
#   - Save $ra, $a3, $a2, and $a1 for function integrity.
#   - Push remainders for reverse printing of digits.

print_base: 
    # --------- Save caller state ---------
    addiu $sp, $sp, -16        # Make room for 4 items on the stack
    sw $ra, 12($sp)            # Save return address
    sw $a3, 8($sp)             # Save sign flag
    sw $a2, 4($sp)             # Save number
    sw $a1, 0($sp)             # Save base

    # --------- Restore arguments ---------
    lw $a3, 8($sp)             # Load sign flag
    lw $a2, 4($sp)             # Load number
    lw $a1, 0($sp)             # Load base
    li $t1, 0x0                # Initialize reminder counter
    li $t0, 0x0                # Initialize loop counter
    blt $a2, 0x0, negative_sign # If the number is negative, handle sign
    beq $a2, 0x0, loop          # If the number is 0, go to main loop
    bne $a1, 0x2, not_base_2    # If not base 2, skip to general case
    j loop                      # Jump to main loop
    
# --------- Handle negative numbers (two's complement) ---------
negative_sign:
    beq $a3, 0, negative_unsign # If unsigned, handle without printing '-'
    xori $a2, $a2, 0xFFFFFFFF   # Flip bits (1's complement)
    addi $a2, $a2, 1            # Add 1 (2's complement)
    li $v0, 11                  # Syscall to print character
    li $a0, 45                  # ASCII for '-'
    syscall                     # Print '-'
    bne $a1, 0x2, not_base_2    # If not base 2, skip to general case
    j loop                      # Jump to main loop

negative_unsign:
    addi $a2, $a2, 0xFFFFFFFF   # Flip bits (1's complement)
    addi $a2, $a2, 1            # Add 1 (2's complement)
    # Fall through to `not_base_2`

# --------- General case for non-binary bases ---------
not_base_2:
    beq $a2, 0x0, print_number  # If number is 0, print it
    # Fall through to the main loop

# --------- Main loop: Divide number by base ---------
loop:
    beq $t0, 31, print_number   # Exit if all 32 bits are processed
    divu $a2, $a1               # Divide number by base
    mflo $a2                    # Save quotient (number / base)
    mfhi $t2                    # Save remainder (number % base)
    addiu $sp, $sp, -4          # Make room on the stack for the remainder
    sw $t2, 0($sp)              # Push remainder to stack
    addi $t1, $t1, 1            # Increment remainder counter
    addi $t0, $t0, 1            # Increment loop counter
    bne $a1, 0x2, not_base_2    # If not base 2, repeat general case
    j loop                      # Continue loop

# --------- Print digits from stack ---------
print_number:
    beq $t1, 0x0, return_to_caller # If no more digits, return
    lw $a0, 0($sp)                # Load the topmost digit
    li $v0, 1                     # Syscall to print integer
    sub $t1, $t1, 1               # Decrement digit counter
    syscall                       # Print the digit
    addiu $sp, $sp, 4             # Pop the top number from the stack
    j print_number                # Continue printing digits

# --------- Restore caller state and return ---------
return_to_caller:
    lw $a1, 0($sp)                # Restore base
    lw $a2, 4($sp)                # Restore number
    lw $a3, 8($sp)                # Restore sign flag
    lw $ra, 12($sp)               # Restore return address
    addiu $sp, $sp, 16            # Adjust stack pointer to original state
    jr $ra                        # Return to caller

################################# LOAD ###################################
# Function: load
# Purpose:
#   Restore saved registers (base, number, return address) from the stack
#   and return control to the calling function.
# Stack Usage:
#   - The function assumes that `$a1` (base), `$a2` (number), and `$ra`
#     (return address) were saved in this order on the stack.
#   - Frees the stack space used for these values upon returning.
#
# Registers:
#   $a1 - Base to restore
#   $a2 - Number to restore
#   $ra - Return address to restore
#   $sp - Stack pointer for managing the stack

load:
    lw $a1, 0($sp)        # Restore base from the stack
    lw $a2, 4($sp)        # Restore number from the stack
    lw $ra, 8($sp)        # Restore return address from the stack
    addiu $sp, $sp, 12    # Adjust stack pointer (pop 3 words: 12 bytes)
    jr $ra                # Return to the caller

################################# PRINT ARRAY SIGN ###################################
# Function: print_array_sign
# Purpose:
#   Iterates through an array of integers, prints each integer in a specified base,
#   and handles signed numbers. Adds a space after each number.
#
# Registers:
#   $a1 - Base for printing
#   $a2 - Current integer from the array
#   $t2 - Address of the array (iterator)
#   $t3 - Current index in the array
#   $t1 - Array length (constant 10 in this case)
#
# Stack Usage:
#   - Saves the return address, array base address, and loop variables.
#   - Handles temporary values when calling `print_base`.

print_array_sign:
    # --------- Save caller state ---------
    addiu $sp, $sp, -12        # Make room for 3 items on the stack
    sw $ra, 8($sp)             # Save return address
    sw $a2, 4($sp)             # Save array base address
    sw $a1, 0($sp)             # Save base for printing

    # --------- Initialize variables ---------
    lw $t2, 4($sp)             # Load array address into $t2
    lw $a1, 0($sp)             # Load base into $a1
    li $t3, 0                  # Initialize array index $t3 = 0
    li $t1, 10                 # Initialize array length $t1 = 10

# --------- Loop through array ---------
pas_loop:
    beq $t3, $t1, pas_end      # Exit loop if $t3 == $t1 (end of array)
    lw $a2, 0($t2)             # Load current array element into $a2
    addiu $sp, $sp, -12        # Make room on stack for temporary values
    sw $t2, 0($sp)             # Save array address (iterator)
    sw $t1, 4($sp)             # Save array length
    li $a3, 1                  # Set sign flag ($a3 = 1 for signed)
    sw $a3, 8($sp)             # Save sign flag

    jal print_base             # Call `print_base` to print the current element

    # --------- Restore state after `print_base` ---------
    lw $a3, 8($sp)             # Restore sign flag
    lw $t1, 4($sp)             # Restore array length
    lw $t2, 0($sp)             # Restore array address (iterator)
    addiu $sp, $sp, 12         # Restore stack pointer
    addi $t3, $t3, 1           # Increment array index
    addi $t2, $t2, 4           # Move to the next array element (word = 4 bytes)

    # --------- Print space ---------
    la $a0, 0x20               # Load ASCII value for space (' ')
    li $v0, 11                 # Syscall for printing a character
    syscall                    # Print space

    j pas_loop                 # Repeat loop for next array element

# --------- End of loop ---------
pas_end:
    jal load                   # Call `load` to restore caller state and return


################################# PRINT ARRAY UNSIGN ###################################
# Function: print_array_unsign
# Purpose:
#   Iterates through an array of unsigned integers, prints each integer in a specified base,
#   and adds a space after each number.
#
# Registers:
#   $a1 - Base for printing
#   $a2 - Current integer from the array
#   $t2 - Address of the array (iterator)
#   $t3 - Current index in the array
#   $t1 - Array length (constant 10 in this case)
#
# Stack Usage:
#   - Saves the return address, array base address, and loop variables.
#   - Handles temporary values when calling `print_base`.

print_array_unsign:
    # --------- Save caller state ---------
    addiu $sp, $sp, -12        # Make room for 3 items on the stack
    sw $ra, 8($sp)             # Save return address
    sw $a2, 4($sp)             # Save array base address
    sw $a1, 0($sp)             # Save base for printing

    # --------- Initialize variables ---------
    lw $t2, 4($sp)             # Load array address into $t2
    lw $a1, 0($sp)             # Load base into $a1
    li $t3, 0                  # Initialize array index $t3 = 0
    li $t1, 10                 # Initialize array length $t1 = 10

# --------- Loop through array ---------
pau_loop:
    beq $t3, $t1, pau_end      # Exit loop if $t3 == $t1 (end of array)
    lw $a2, 0($t2)             # Load current array element into $a2
    addiu $sp, $sp, -12        # Make room on stack for temporary values
    sw $t2, 0($sp)             # Save array address (iterator)
    sw $t1, 4($sp)             # Save array length
    li $a3, 0                  # Set sign flag ($a3 = 0 for unsigned)
    sw $a3, 8($sp)             # Save sign flag

    jal print_base             # Call `print_base` to print the current element

    # --------- Restore state after `print_base` ---------
    lw $a3, 8($sp)             # Restore sign flag
    lw $t1, 4($sp)             # Restore array length
    lw $t2, 0($sp)             # Restore array address (iterator)
    addiu $sp, $sp, 12         # Restore stack pointer
    addi $t3, $t3, 1           # Increment array index
    addi $t2, $t2, 4           # Move to the next array element (word = 4 bytes)

    # --------- Print space ---------
    la $a0, 0x20               # Load ASCII value for space (' ')
    li $v0, 11                 # Syscall for printing a character
    syscall                    # Print space

    j pau_loop                 # Repeat loop for next array element

# --------- End of loop ---------
pau_end:
    jal load                   # Call `load` to restore caller state and return

################################# SUM SIGN ###################################
# Function: sum_sign
# Purpose:
#   Computes the sum of all signed integers in an array, then prints the sum
#   in the specified base using the `print_base` function.
#
# Registers:
#   $a1 - Base for printing
#   $a2 - Current integer from the array (used temporarily for summation)
#   $a3 - Running sum of the array elements
#   $t2 - Address of the array (iterator)
#   $t3 - Current index in the array
#   $t1 - Array length (constant 10 in this case)
#
# Stack Usage:
#   - Saves the return address, base, and array address.
#   - Temporarily handles loop state when necessary.

sum_sign:
    # --------- Save caller state ---------
    addiu $sp, $sp, -12        # Make room for 3 items on the stack
    sw $ra, 8($sp)             # Save return address
    sw $a2, 4($sp)             # Save array address
    sw $a1, 0($sp)             # Save base

    # --------- Initialize variables ---------
    lw $t2, 4($sp)             # Load array address into $t2
    lw $a1, 0($sp)             # Load base into $a1
    li $t3, 0                  # Initialize array index $t3 = 0
    li $t1, 10                 # Set array length $t1 = 10
    li $a3, 0                  # Initialize running sum $a3 = 0

# --------- Loop through array ---------
ss_loop:
    beq $t3, $t1, ss_end       # Exit loop if $t3 == $t1 (end of array)
    lw $a2, 0($t2)             # Load current array element into $a2
    add $a3, $a3, $a2          # Add current element to the running sum
    addi $t3, $t3, 1           # Increment array index
    addi $t2, $t2, 4           # Move to the next array element (word = 4 bytes)
    j ss_loop                  # Repeat loop for next array element

# --------- End of loop ---------
ss_end:
    move $a2, $a3              # Move the sum into $a2 for printing
    li $a3, 1                  # Set sign flag ($a3 = 1 for signed)
    jal print_base             # Print the sum using `print_base`
    jal load                   # Restore caller state and return
    
################################# SUM UNSIGN ###################################
# Function: sum_unsign
# Purpose:
#   Computes the sum of all unsigned integers in an array, then prints the sum
#   in the specified base using the `print_base` function.
#
# Registers:
#   $a1 - Base for printing
#   $a2 - Current integer from the array (used temporarily for summation)
#   $a3 - Running sum of the array elements
#   $t2 - Address of the array (iterator)
#   $t3 - Current index in the array
#   $t1 - Array length (constant 10 in this case)
#
# Stack Usage:
#   - Saves the return address, base, and array address.
#   - Temporarily handles loop state when necessary.

sum_unsign:
    # --------- Save caller state ---------
    addiu $sp, $sp, -12        # Make room for 3 items on the stack
    sw $ra, 8($sp)             # Save return address
    sw $a2, 4($sp)             # Save array address
    sw $a1, 0($sp)             # Save base

    # --------- Initialize variables ---------
    lw $t2, 4($sp)             # Load array address into $t2
    lw $a1, 0($sp)             # Load base into $a1
    li $t3, 0                  # Initialize array index $t3 = 0
    li $t1, 10                 # Set array length $t1 = 10
    li $a3, 0                  # Initialize running sum $a3 = 0

# --------- Loop through array ---------
su_loop:
    beq $t3, $t1, su_end       # Exit loop if $t3 == $t1 (end of array)
    lw $a2, 0($t2)             # Load current array element into $a2
    addu $a3, $a3, $a2         # Add current element to the running sum (unsigned)
    addi $t3, $t3, 1           # Increment array index
    addi $t2, $t2, 4           # Move to the next array element (word = 4 bytes)
    j su_loop                  # Repeat loop for next array element

# --------- End of loop ---------
su_end:
    move $a2, $a3              # Move the sum into $a2 for printing
    li $a3, 0                  # Set sign flag ($a3 = 0 for unsigned)
    jal print_base             # Print the sum using `print_base`
    jal load                   # Restore caller state and return

################################# PRINT DIF SIGN ###################################
# Function: print_dif_sign
# Purpose:
#   Computes the difference between consecutive signed integers in an array
#   and prints each difference in the specified base using the `print_base` function.
#
# Registers:
#   $a1 - Base for printing
#   $a2 - Current difference between consecutive integers
#   $a3 - Sign flag (1 for signed numbers)
#   $a0 - Next array element (used for difference calculation)
#   $t2 - Address of the current array element
#   $t3 - Current index in the array
#   $t1 - Array length (set to 9 for differences in a 10-element array)
#
# Stack Usage:
#   - Saves the return address, base, and array address.
#   - Temporarily handles loop state when necessary.

print_dif_sign:
    # --------- Save caller state ---------
    addiu $sp, $sp, -12        # Make room for 3 items on the stack
    sw $ra, 8($sp)             # Save return address
    sw $a2, 4($sp)             # Save array address
    sw $a1, 0($sp)             # Save base

    # --------- Initialize variables ---------
    lw $t2, 4($sp)             # Load array address into $t2
    lw $a1, 0($sp)             # Load base into $a1
    li $t3, 0                  # Initialize array index $t3 = 0
    li $t1, 9                  # Set loop limit to 9 (10 elements - 1 differences)
    li $a3, 1                  # Set sign flag ($a3 = 1 for signed differences)

# --------- Loop through array ---------
pds_loop:
    beq $t3, $t1, pds_end      # Exit loop if $t3 == $t1 (processed all differences)
    lw $a2, 0($t2)             # Load current element into $a2
    lw $a0, 4($t2)             # Load next element into $a0
    sub $a2, $a2, $a0          # Compute difference: $a2 = $a2 - $a0

    # --------- Save loop state ---------
    addiu $sp, $sp, -8         # Make room for loop state
    sw $t2, 0($sp)             # Save current array pointer
    sw $t1, 4($sp)             # Save loop limit

    # --------- Print the difference ---------
    li $a3, 1                  # Ensure the sign flag is set
    jal print_base             # Call print_base to print the difference

    # --------- Print a space ---------
    la $a0, 0x20               # Load ASCII value for space (' ')
    li $v0, 11                 # Print character syscall
    syscall

    # --------- Restore loop state ---------
    lw $t1, 4($sp)             # Restore loop limit
    lw $t2, 0($sp)             # Restore current array pointer
    addiu $sp, $sp, 8          # Pop loop state from the stack

    # --------- Advance to the next pair ---------
    addi $t3, $t3, 1           # Increment array index
    addi $t2, $t2, 4           # Move to the next array element
    j pds_loop                 # Repeat loop for the next difference

# --------- End of loop ---------
pds_end:
    jal load                   # Restore caller state and return

################################# PRINT SUM UNSIGN ###################################
# Function: print_sum_unsign
# Purpose:
#   Computes the sum of consecutive unsigned integers in an array
#   and prints each sum in the specified base using the `print_base` function.
#
# Registers:
#   $a1 - Base for printing
#   $a2 - Current sum of consecutive integers
#   $a3 - Sign flag (0 for unsigned numbers)
#   $a0 - Next array element (used for sum calculation)
#   $t2 - Address of the current array element
#   $t3 - Current index in the array
#   $t1 - Array length (set to 9 for sums in a 10-element array)
#
# Stack Usage:
#   - Saves the return address, base, and array address.
#   - Temporarily handles loop state when necessary.

print_sum_unsign:
    # --------- Save caller state ---------
    addiu $sp, $sp, -12        # Make room for 3 items on the stack
    sw $ra, 8($sp)             # Save return address
    sw $a2, 4($sp)             # Save array address
    sw $a1, 0($sp)             # Save base

    # --------- Initialize variables ---------
    lw $t2, 4($sp)             # Load array address into $t2
    lw $a1, 0($sp)             # Load base into $a1
    li $t3, 0                  # Initialize array index $t3 = 0
    li $t1, 9                  # Set loop limit to 9 (10 elements - 1 sums)
    li $a3, 0                  # Set unsigned flag ($a3 = 0 for unsigned sums)

# --------- Loop through array ---------
psu_loop:
    beq $t3, $t1, psu_end      # Exit loop if $t3 == $t1 (processed all sums)
    lw $a2, 0($t2)             # Load current element into $a2
    lw $a0, 4($t2)             # Load next element into $a0
    addu $a2, $a2, $a0         # Compute unsigned sum: $a2 = $a2 + $a0

    # --------- Save loop state ---------
    addiu $sp, $sp, -8         # Make room for loop state
    sw $t2, 0($sp)             # Save current array pointer
    sw $t1, 4($sp)             # Save loop limit

    # --------- Print the sum ---------
    li $a3, 0                  # Ensure the unsigned flag is set
    jal print_base             # Call print_base to print the sum

    # --------- Print a space ---------
    la $a0, 0x20               # Load ASCII value for space (' ')
    li $v0, 11                 # Print character syscall
    syscall

    # --------- Restore loop state ---------
    lw $t1, 4($sp)             # Restore loop limit
    lw $t2, 0($sp)             # Restore current array pointer
    addiu $sp, $sp, 8          # Pop loop state from the stack

    # --------- Advance to the next pair ---------
    addi $t3, $t3, 1           # Increment array index
    addi $t2, $t2, 4           # Move to the next array element
    j psu_loop                 # Repeat loop for the next sum

# --------- End of loop ---------
psu_end:
    jal load                   # Restore caller state and return
