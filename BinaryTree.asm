.data
A: .word 4, 9, 10, 10, 15, 2, 3
O: .word 0, 0, 0, 0, 0, 0, 0

.text
  # $a0 contains address of array containing representation 1 of the binary tree
  # $a1 contains size of array of representation 1
  # $a2 contains address of output array

  la $a0, A
  li $a1, 7
  la $a2, O

  li $t0, 0 # initialize $t0 with 0. (output index/count)
  li $t2, 0 # initialize $t2 with 0. (input index)

  jal proc1


proc1:
  addi $sp, $sp, -12

  sw $a0, 0($sp)
  sw $a1, 4($sp)
  sw $a2, 8($sp)


  beq $a1, $zero, exit

exit:
  sll $t1, $t0, 2
  add $sp, $sp, $t1

  lw $a2, 8($sp)
  lw $a1, 4($sp)
  lw $a0, 0($sp)

  jr $ra

l1:
  slt $t3, $t0, $a1
  beq $t3, $zero, exit

  sll $t7, $t2, 2
  add $a2, $a2, $t7
  lw $t7, 0($a2)

  sll $t3, $t0, 2
  add $a2, $a2, $t3
  sw $t7, 0($a0)

  sll $t1, $t2, 1

  addi $t5, $t1, 2 # right idx
  addi $t6, $t1, 1 # left idx

  blt $t5, $a1, pri
  blt $t6, $a1, pli

  addi $t0, $t0, 1

  lw $t5, 0($sp)
  addi $sp, $sp, 4

  move $t2, $t5

  bne $t3, $zero, l1

pri:
  addi $sp, $sp, -4
  sw $t5, 0($sp)

pli:
  addi $sp, $sp, -4
  sw $t6, 0($sp)
