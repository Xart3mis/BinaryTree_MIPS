.data
A1: .word 4, 9, 10, 10, 15, 2, 3
A2: .word 4, 9, 10, 15, 10, 2, 3
O: .word 0, 0, 0, 0, 0, 0, 0

.text
  la $a0, A1 # arr
  li $a1, 7 # arr.len()
  la $a2, O # output
  li $a3, 0 # idx
  li $s0, 0 # position/i

  jal proc1
  
  la $a0, O
  jal print_arr
  
  la $a0, A2 # arr
  li $a1, 7 # arr.len()
  la $a2, O # output
  li $a3, 0 # idx
  li $s0, 0 # position/i
  
  jal proc2
  
  la $a0, O
  jal print_arr
  
  la $a0, A1
  li $a1, 9
  li $a2, 7
  li $a3, 0
  jal proc3
  
  move $a0, $v0
 	li $v0, 1
 	syscall
 	
	li $v0, 11
 	li $a0, '\n'
 	syscall
  
  la $a0, A2
  li $a1, 9
  li $a2, 7
  li $a3, 0
  li $s0, 1
  jal proc4
  
  move $a0, $v0
 	li $v0, 1
 	syscall
 	
 	li $v0, 11
 	li $a0, '\n'
 	syscall
  
  li $v0, 10
  syscall

proc1:
  addi $sp, $sp, -20
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp)
  sw $a2, 12($sp)
  sw $a3, 16($sp)

	bge $a3, $a1, exit1

  sll $t0, $a3, 2
  add $t1, $a0, $t0
  lw $t0, 0($t1)

  sll $t1, $s0, 2
  add $t2, $a2, $t1
  sw $t0, 0($t2)
  	addi $s0, $s0, 1
  

  lw $a3, 16($sp)
  sll $a3, $a3, 1
  addi $a3, $a3, 1

  jal proc1

  lw $a3, 16($sp)
  sll $a3, $a3, 1
  addi $a3, $a3, 2
  
  jal proc1
  
exit1:
  lw $ra, 0($sp)
  lw $a0, 4($sp)
  lw $a1, 8($sp)
  lw $a2, 12($sp)
  lw $a3, 16($sp)

  addi $sp, $sp, 20

  jr $ra

proc2:
  addi $sp, $sp, -20
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp)
  sw $a2, 12($sp)
  sw $a3, 16($sp)

	bge $a3, $a1, exit2

	sll $t0, $s0, 2
	add $t1, $a0, $t0
	lw $t0, 0($t1)
	
	sll $t1, $a3, 2
	add $t2, $a2, $t1
	sw $t0, 0($t2)
	addi $s0, $s0, 1

  lw $a3, 16($sp)
  sll $a3, $a3, 1
  addi $a3, $a3, 1

  jal proc2

  lw $a3, 16($sp)
  sll $a3, $a3, 1
  addi $a3, $a3, 2
  
  jal proc2
  
exit2:
  lw $ra, 0($sp)
  lw $a0, 4($sp)
  lw $a1, 8($sp)
  lw $a2, 12($sp)
  lw $a3, 16($sp)

  addi $sp, $sp, 20

  jr $ra

proc3:
  addi $sp, $sp, -20
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp) 
  sw $a2, 12($sp)
  sw $a3, 16($sp)

	bge $a3, $a2, rn1
	
	sll $t0, $a3, 2
	add $t1, $a0, $t0
	
	lw $t0, 0($t1)
	
	beq $t0, $a1, rlevel
	
	addi $a3, $a3, 1
	jal proc3

exit3:
  lw $ra, 0($sp)
  lw $a0, 4($sp)
  lw $a1, 8($sp) 
  lw $a2, 12($sp)
  lw $a3, 16($sp)
  
  addi $sp, $sp, 20

  jr $ra

rn1:
  li $v0, -1
  j exit3

r1:
  li $v0, 1
  j exit3

rlevel:
	li $v0, 1
	li $t1, 1
	addi $t0, $a3, 1
	
	ble $t0, $t1, exit3
	
	loop:
		srl $t0, $t0, 1
		addi $v0, $v0, 1
		
		ble $t0, $t1, exit3
		j loop
	
  j exit3


proc4:
  addi $sp, $sp, -24
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp)
  sw $a2, 12($sp)
  sw $a3, 16($sp)
  sw $s0, 20($sp)
  
  bge $a3, $a2, rn12
  
  sll $t1, $a3, 2
  add $t0, $a0, $t1
  
  lw $t1, 0($t0)
  beq $t1, $a1, rnlevel4
  
	lw $a3, 16($sp)
  sll $s1, $a3, 1
  li $s2, -1
  addi $t2, $s1, 1
  move $a3, $t2 
  
  lw $s0, 20($sp)
  addi $s0, $s0, 1
  
  jal proc4
  bne $v0, $s2, exit4

	lw $a3, 16($sp)
  sll $s1, $a3, 1
  li $s2, -1
  addi $t2, $s1, 2
  move $a3, $t2
  
  lw $s0, 20($sp)
  addi $s0, $s0, 1
  
  jal proc4
	
  bne $t1, $zero, exit4
  
  #li $v0, -1
  j exit4

rn12:
  li $v0, -1
  j exit4
  
rnlevel4:
	move $v0, $s0
	j exit4

exit4:
  lw $ra, 0($sp)
  lw $a0, 4($sp)
  lw $a1, 8($sp)
  lw $a2, 12($sp)
  lw $a3, 16($sp)
  lw $s0, 20($sp)
  
  addi $sp, $sp, 24
  
  jr $ra
#a0 -> array address
#a1 -> array size
print_arr:
	move $t0, $a0
	addi $t2, $a1, -1
	
	li $t1, 0
	
print_loop:
	bge $t1, $a1, exit_print
  
	lw $a0, 0($t0)
    
	li $v0, 1
	syscall
    
	bge $t1, $t2, skip_sep
    
  li $v0, 11
  li $a0, ','
  syscall
  li $a0, ' '
  syscall
    
  skip_sep:  
  addi $t1, $t1, 1
  addi $t0, $t0, 4
  j print_loop
 
 exit_print:
 	li $v0, 11
 	li $a0, '\n'
 	syscall
 
  jr $ra
