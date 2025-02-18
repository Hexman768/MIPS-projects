.data
	gnum: .word 30
	hnum: .word 20

.text
main:
	lw $a0, gnum		# a0 = 30
	lw $a1, hnum		# a1 = 20
	li $a2, 10
	li $a3, 5
	
	move $s0, $a0 # set s0 equal to a0
	
	jal leaf_example
	
	move $a0, $v0 # a0 = v0
	li $v0, 1
	syscall
	
	li $v0, 10 	# Exit program opcode.
	syscall

leaf_example:
	addi $sp, $sp, -4		# Prepare stack for one item (word)
	sw $s0, 0($sp)			# This writes $s0 into memory (Stack)
	
	add $t0, $a0, $a1		# add 30 + 20
	add $t1, $a2, $a3		# add 10 + 5
	sub $s0, $t0, $t1		# sub 50 - 15
	
	add $v0, $s0, $zero		# set $v0 to 35
	
	lw $s0, 0($sp)		# restore $s0 for caller, added as in slide 4
	addi $sp, $sp, 4
	
	jr $ra
	