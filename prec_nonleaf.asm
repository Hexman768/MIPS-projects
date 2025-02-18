.data
	gnum: .word 30
	fnum: .word 20
       
.text
main:					# Non-leaf procedure example, compare it with prec_leaf.asm
	lw $a0, gnum			# initialize $a0, $a1 using global data
	lw $a1, fnum
	li $a2, 10			# initialize $a2, $a3 using immediate 
	li $a3, 5
	     
	move $s0, $a0			# $s0 = 30
	     
	jal nonleafp	
	
	li, $v0, 10    	 		# exit the program 
	syscall
	
	
nonleafp:				# change to a non-leaf (nested) procedure
	addi $sp, $sp, -8		# save $ra and Ss0 on stack
	sw $ra, 4($sp)			# need to save return address and any other registers needed after the call on the stack 
	sw $s0, 0($sp)			# save $s0 on stack
	
	add $t0,$a0, $a1
	add $t1, $a2, $a3
	sub $s0, $t0, $t1
	
	add $a0, $s0, $zero		# store the parameter, an integer, to $a0 for printing
	jal printInt
	
	
	lw $s0, 0($sp)			# restore $s0 for caller
	lw $ra, 4($sp)			# restore $ra from stack after calling printInt 
	addi $sp, $sp, 8
	
	jr $ra				# return to caller, main


printInt:				# Change print integer to a procedure
					# $a0 store the integer for display
	li, $v0, 1			# display an integer
	syscall		

	jr $ra				# return to caller, nonleafp