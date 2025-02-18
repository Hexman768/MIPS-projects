.data
	prompt: .asciiz "Type characters: "
	complete: .asciiz "done\n"
	nil: .ascii "\n"
.text

print_string:
	# load address of prompt string into argument register a0
	# load call code 4 into system register v0
	la $a0, prompt
	li $v0, 4
	syscall

read_chars:
	li $v0, 12
	syscall
	j check_char

print_char:
	move $a0, $v0
	li $v0, 11
	syscall
	j read_chars

check_char:
	# branch to print_char if $v0 isn't a newline char
	li $t1, '\n'
	bne $t1, $v0, print_char

exit:
	la $a0, complete
	li $v0, 4
	syscall
