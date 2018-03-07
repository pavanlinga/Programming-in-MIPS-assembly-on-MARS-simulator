.data
	u: .word 0		#declare & intialize the variable u to 0
	v: .word 0		#declare & intialize the variable v to 0
	message1: .asciiz "Enter the value of U:\n"
	message2: .asciiz "Enter the value of V:\n"
	message3: .asciiz "The resultant value of the expression is:\n"

.text
#********************main***************************#
.globl main
main:
	li $v0, 4		#to display the string -message1
	la $a0, message1	#load the starting addr of the string
	syscall			#system call to initiate the process
	li $v0, 5		#to read the interger value U from the user
	syscall			#system call to initiate the process
	sw $v0, u		#store the value from reg to variable U
	li $v0, 4		#to display the sting -message2
	la $a0, message2	#load the starting addr of the string
	syscall			#system call to initiate the process
	li $v0, 5		#to read the interger value V
	syscall			#system call to initiate the process
	sw $v0, v		#store the value from reg to variable V
	lw $a0, u		#load U value in $a0
	jal Square		#call Square subroutine -> U2
	move $s1, $v0		#move the U2 value into $s1
	lw $a1, v		#multiply UxV
	jal Multiply 		#call multiply subroutine
	move $s2, $v0		#store the UxV value in $s2 reg
	move $a0, $s2
	li $a1, 5		#multiply (UxV)x5
	jal Multiply		#call multiply subroutine
	move $s2, $v0		#store the value in $s2 reg
	add $s1, $s1, $s2	#add u2 + 5x(UxV) -> store in $s1
	lw $a0, v		#load V value in $a0
	jal Square		#call Square subroutine
	move $s2, $v0		#move the value into $s2
	move $a0, $s2
	li $a1, 3		#multiply (V2)x3
	jal Multiply		#call multiply subroutine - jump and link
	move $s2, $v0		#store the value in $s2 reg
	sub $s1, $s1, $s2	#subtract (U2+ 5x(UxV)) - (3xV2)
	add $s1, $s1, 7		#add the result with 7 and store in $s1
	li $v0, 4		#to display the string -message3
	la $a0, message3	#load the starting addr of the string
	syscall			#system call to initiate the process
	li $v0, 1		#to display the resulant value of the expression
	add $a0, $zero, $s1	#add the value with zero
	syscall			#system call to initiate the process
	li $v0, 10		#to exit the program
	syscall			#system call to initiate the process
	
#****************Square Subroutine*******************#
Square:				
	mul $t0, $a0, $a0	#multiply $a0 with $a0 to get square of the num
	move $v0, $t0		#move the value into $v0 reg
	jr $ra			#jump to the caller PC 
	
#**************Multiply Subroutine*******************#
Multiply:
	mul $t0, $a0, $a1	#multiply $a0 with $a1 to get square of the num
	move $v0, $t0		#move the value into $v0 reg
	jr $ra			#jump to the caller PC
	
