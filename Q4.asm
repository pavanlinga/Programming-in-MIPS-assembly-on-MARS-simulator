# Data section of the program 
.data 

enterx : .asciiz "Please enter x :"		# String for taking input x 
enteri : .asciiz "Please enter i :" 		# String for taking input i 

# Code section of the program 
.text 

# Global symbol main 
.globl main 

# Main execution begins 
main : 

# Read input i
li $v0,4			# Load syscall number for printing a string 
la $a0,enteri			# Load the address of the string to be printed 
syscall 			# Make the syscall 

li $v0,5			# Load the syscall number for reading an integer 
syscall				# Make the syscall 
move $t0,$v0			# Save the integer into the 't0' register

# read input x			
li $v0,4			# Load syscall for printing a string 
la $a0,enterx			# Load the address of the string to be printed 
syscall 			# Make the syscall 
 
li $v0,5			# Load the syscall number for reading an integer 
syscall				# Make the syscall 
move $t1,$v0 			# Store the read integer into the 't1' register 

addu $a0,$zero,$t0		# Move $t0 to $a0			# 
addu $a1,$zero,$t1		# Move $t1 to $a1

jal compute 			# Calling the function compute 

# Saving the returned value 
addu $t0,$zero,$v0		# Save the value stored in v0 to t0 

# print output 
li $v0,1			# Load the syscall number for printing an integer 
addu $a0,$zero,$t0		#  Move t0 to a0
syscall 

# exit 
li $v0,10			# Store the syscall number for exit 
syscall				# Make the syscall 
 

# "compute" routine 
compute : 

blt $a1,1,posi			#  if (x < 1) then jump to check next condition ( label 'posi')

subi $a1,$a1,1			# x = x - 1

# Push elements on the stack
subi $sp,$sp,4			# make space for pushing elements to the stack 
sw $ra,0($sp)			# Store the RETURN ADDRESS on the stack 

jal compute			# Call compute 

# Pop elements off the stack 
lw $ra,0($sp)			# Pop elemenets off the stack 
addi $sp,$sp,4			# Restore the stack pointer 

# Return += 1 
addi $v0,$v0,1			# Return compute(i,x-1) + 1

#Return 
jr $ra 				# Return to the calling function 
  
posi : blt $a0,1,cont		# if ( i < 1) then jump to the last condition ( label 'cont')
 

subi $a0,$a0,1			# i = i -1 
move $a1,$a0			# x = i-1 

# Push elements on the stack
subi $sp,$sp,4			# Make space for elements on the stack by decerementing the stack pointer 
sw $ra,0($sp)			# Save the return address on the stack 

# Compute 
jal compute			# Call compute 

# Pop elements off the stack 
lw $ra,0($sp)			# Pop the elements of the stack 
addi $sp,$sp,4			# Restore the stack pointer 

# Return += 5
addi $v0,$v0,5			# Return compute (i-1,i-1) + 5

#Return 
jr $ra 				# Return to the calling function 

cont : 
li $v0,1			# Return 1 
 
# Return 
jr $ra 				# Return to the calling function 
