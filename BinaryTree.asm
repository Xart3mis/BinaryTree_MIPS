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
  
  li $t0, 0
  li $t1, 1
  la $a0, A1
  li $a1, 9
  li $a2, 7
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
  addi $sp, $sp, -16
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp) 
  sw $a2, 12($sp)

  slt $t2, $t0, $a2
  beq $t2, $zero, exit3

  sll $t3, $t0, 2
  add $t6, $a0, $t3

  lw $t3, 0($t6)

  beq $t3, $a1, rlevel

  sll $t3, $t0, 1
  addi $t4, $t3, 1 # left idx
  addi $t5, $t3, 2 # right idx

  addi $t1, $t1, 1
  move $t0, $t4
  
  jal proc3

  bgt $v0, $zero, exit3

  move $t0, $t5
  jal proc3

  bgt $v0, $zero, exit3

  li $v0, -1

  j exit3

exit3:
  lw $a2, 12($sp)
  lw $a1, 8($sp)
  lw $a0, 4($sp)
  lw $ra, 0($sp)

  addi $sp, $sp, 16

  jr $ra

rn1:
  li $v0, -1
  j exit3

r1:
  li $v0, 1
  j exit3

rlevel:
  beqz $t0, r1

  move $v0, $t1
  j exit3

proc4:
  addi $sp, $sp, -20
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp)
  sw $a2, 12($sp)
  sw $a3, 16($sp)
  
  slt $t1, $a2, $a3
  bne $t1, $zero, rn12
  
  sll $t1, $a3, 2
  add $t0, $a0, $t1
  
  lw $t1, 0($t0)
  beq $t1, $a1, rnlevel4
  
	lw $a3, 16($sp)
  sll $s1, $a3, 1
  li $s2, -1
  addi $t2, $s1, 1
  move $a3, $t2 
  
  jal proc4
  bne $v0, $s2, exit4

	lw $a3, 16($sp)
  sll $s1, $a3, 1
  li $s2, -1
  addi $t2, $s1, 2
  move $a3, $t2 
  
  jal proc4
	
  bne $t1, $zero, exit4
  
  #li $v0, -1
  j exit4

exit4:
  lw $ra, 0($sp)
  lw $a0, 4($sp)
  lw $a1, 8($sp)
  lw $a2, 12($sp)
  lw $a3, 16($sp)
  
  addi $sp, $sp, 20
  
  jr $ra

loop:
  srl $t1, $t1, 1
  addi $v0, $v0, 1

  ble $t1, $t0, exit4
	j loop

rnlevel4:
  li $v0, 1
  addi $t1, $a3, 1
  li $t0, 1
  
  ble $t1, $t0, exit4
	j loop

rn12:
  li $v0, -1
  j exit4

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
