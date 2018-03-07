# Data section of the program 
.data 

string : .asciiz "Sum = "		# String for printing Sum =  
sum : .word 0				# Variable for storing the total 
sumptr : .word sum 			# Address of the sum variable 
array : .word				# Allocate space for the array  

# Text section of the program 
.text 

# Global symbol main 
.globl main 

# main iteration begins 
main : 
lw $a0,sumptr			# Storing the address of the variable sum 
la $s3,array			# Storing the starting address of the array 
li $s0,0			# Iterator 

loop: 
addi $s1,$s0,1			# t1 = t0 + 1 
sll $s1,$s1,1			# t1 = 2 * t1
sll $s2,$s0,2			# Multiply iterator to get offset t2(offset)
add $a1,$s3,$s2			# Get the address of the array element a1 (address of the array element )
sw  $s1,($a1) 			# Store the array element 
jal UpdateSum			# Make the function call
addi $s0,$s0,1			# Incrementing the iterator 
blt $s0,10,loop			# Checking if ( i < 10 )

# Print string 
li $v0,4 			# Load the syscall number for printing a string 
la $a0,string 			# Load the address of the string 
syscall 			# Print the string 

# print sum 
li $v0,1			# Loading the register with the required syscall number for PRINT INTEGER 
lw $a0,sum			# Passing the argument 
syscall 			# Printing the integer 			

# exit 
li $v0,10			# Loading the syscall number for EXIT 
syscall

# "UpdateSum" routine 
UpdateSum : 
lw $t0,($a0)			# Loading the sum value 
lw $t1,($a1)			# Loading the address of the element 
add $t0,$t0,$t1			# Updating the sum ( sum += element ) 
sw $t0,($a0)			# Store the sum in the given address       "---try to use $v0 reg for return value--after that store in ($a0)"
jr $ra				# Return to the calling function 

