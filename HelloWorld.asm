.data
	message: .asciiz "Hello, World"

.text

print:
	la $a0, message
	li $v0, 4
	syscall
