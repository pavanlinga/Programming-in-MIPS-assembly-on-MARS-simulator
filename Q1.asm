# Data segment of the program 

.data 
string : .asciiz "Welcome to the Computer Architecture Class!"

# Code segment of the program 
.text 
.globl main 

main : 
la $t0,string			# Load string address 
li $t1,0			# Iterator 
 
loop: addu $t2,$t0,$t1		# Final address 
lb $t4,($t2)			# Load the value of address $t2 into reg $t4
beq $t4,'\0',end		# Check for the end of the string 
blt $t4,97,cont			# Check if it lies outside the range of small characters - Lower limit
bgt $t4,122,cont 		# Check if it lies outside the range of small characters - Upper limit
subi $t4,$t4,32			# If not convert the small letter to capital 
sb $t4,($t2)			# Store in the ram
 
cont : 
addi $t1,$t1,1			# increment the iterator 
j loop				# Loop 

end : 
# print string 
li $v0,4			#Load $v0 to 4 for printing the string
la $a0,string			#Load the address of the string
syscall 			#system call to print the string

# exit 
li $v0,10			#Load $v0=10 to terminate the program
syscall				#systemcall
