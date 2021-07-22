.data

msg1: .asciiz "\nEnter a number: "
msg2: .asciiz "\nThe square root is : "
msg3: .asciiz "\n\nThe array of numbers is : \n"
msg4: .asciiz "\n\nThe sieve of Eratosthenes gives :\n"
msg5: .asciiz "  "
msg6: .asciiz "\n"

.align 4
arr: .space 8000

.text

li $v0, 4		#print enter message
la $a0, msg1
syscall

li $v0,5
syscall
move $t0, $v0		#get n

addi $t9, $t0, 0	#n stored in $t9

li $t1,1
li $t2,0
			#calculate the sqrt of n
loop:
	sub $t0,$t0,$t1
	addi $t2,$t2,1
	addi $t1,$t1,2
	beq $t0,0,c1
	blt $t0,0,c2
	bne $t0,0,loop

c1:
	subi $t1,$t1,1
	j next
	
c2:
	subi $t1,$t1,2
	j next			#sqrt stored in $t1

next:
	div $t1,$t1,2
	
	li $v0,4
	la $a0,msg2
	syscall
	
	li $v0,1
	la $a0, ($t1)
	syscall
	
	li $t8,0
	add $t2,$zero,0
	add $t3,$zero,2
	
	while:
		bgt $t3,$t9,next1
		sw $t3,arr($t2)
		addi $t2,$t2,4
		sw $t8, arr($t2)
		addi $t2,$t2,4
		addi $t3,$t3,1
		j while

next1:
	add $t2,$zero,0
	add $t3,$zero,2
	li $v0,4
	la $a0,msg3
	syscall
	while1:
		bgt $t3,$t9,sieve
		lw $t4,arr($t2)
		addi $t2,$t2,8
		addi $t3,$t3,1
		li $v0,1
		la $a0, ($t4)
		syscall
		li $v0,4
		la $a0,msg5
		syscall
		j while1

sieve:
# $t0 - outerloop idx
# $t1 - sqrt(n)
# $t2 - starting offset of array (number)
# $t3 - address of flag
# $t4 - value of flag
# $t5 - value of cell
# $t6 - constant(1) to indicate comosite
# $t7 - max array size
# $t8 - available
# $t9 - n

  addi $t1, $t1, 1
  addi $t4,$zero,0
  li $t6,1   # constant to mark flag as comosite
  mul $t7, $t9,8
  subi $t7, $t7, 8 
 
  li $t0,1       # $t0 is outerloop index set to 1
  li $t2, 0      # starting offset of array
  addi $t3,$t2,4 # starting address of flag 

outerloop:
  addi $t0, $t0, 1	#increment idx by 1; initial value will now be 2
  bgt $t0, $t1, print   #exit_outerloop

innerloop:
  lw $t5, arr($t2)  # get the value of n
  lw $t4, arr($t3)  # get the value of flag
  beq $t4,1,skip2next # if it is already marked as composite, move to next number
  mul $t5, $t5,8    # multily by 8 to get offset 
  
markascomposite:
  add $t2,$t2,$t5   # move pointer to next multiple of n 
  add $t3,$t3,$t5   # move to corresponding flag
  bgt $t3, $t7, exitinnerloop # if pointer is outside range; exit loop
  lw $t6, arr($t3)
  addi $t6, $t6, 1
  sw $t6, arr($t3)
  j markascomposite

skip2next:
  addi $t0, $t0, 1	#increment idx by 1
  bgt $t0, $t1, print   #exit_outerloop
  add $t2, $t2, 8
  add $t3, $t3, 8
  j innerloop
  
exitinnerloop:
  mul  $t2, $t0, 8
  subi $t2, $t2, 8
  addi $t3, $t2, 4
  j outerloop
   
print:
	addi $t2,$zero,0
	addi $t3,$zero,0 # number
	addi $t4,$zero,0
	add $t4,$t3,4 #flag
	li $v0,4
	la $a0,msg4
	syscall
	
	loop1:
		lw $t5,arr($t4)
		bge $t5,1,loop2
		lw $t6,arr($t3)
		li $v0,1
		la $a0,($t6)
		syscall
		li $v0,4
		la $a0,msg5
		syscall
		beq $t6,$t9,exit
	loop2:
		lw $t6,arr($t3)
		beq $t6,$t9,exit
		addi $t3,$t3,8
		addi $t4,$t4,8
		addi $t2,$t2,1
		j loop1

exit:

	li $v0,4
	la $a0,msg6
	syscall

	li $v0,10
	syscall
