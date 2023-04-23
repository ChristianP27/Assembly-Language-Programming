#########################################
# Name: Christian Perry                 #
# ID: 800657821                         #
# Project 2                             #
#########################################


.data
prompt: .asciiz "Enter a number: "
part1: .asciiz "\nmove a disk: "
part2: .asciiz " peg "
part3: .asciiz " --> peg "
Exit: .asciiz "\n\nThe end of the process..."

.text
.globl main
main:
    li $v0,  4          # print string
    la $a0,  prompt
    syscall
    li $v0,  5          # read integer
    syscall

    
    add $a0, $v0, $zero # move to $a0
    li $a1, '1'
    li $a2, '2'
    li $a3, '3'

    jal hanoi           # call hanoi jump

    li $v0, 4          # print final message
    la $a0, Exit
    syscall


    li $v0, 10
    
   

   

hanoi:

    #save in stack
    addi $sp, $sp, -20 
    sw   $ra, 0($sp)
    sw   $s0, 4($sp)
    sw   $s1, 8($sp)
    sw   $s2, 12($sp)
    sw   $s3, 16($sp)

    add $s0, $a0, $zero
    add $s1, $a1, $zero
    add $s2, $a2, $zero
    add $s3, $a3, $zero

    addi $t1, $zero, 1
    beq $s0, $t1, output

    recur1:

        addi $a0, $s0, -1
        add $a1, $s1, $zero
        add $a2, $s3, $zero
        add $a3, $s2, $zero
        jal hanoi

        j output

    recur2:

        addi $a0, $s0, -1
        add $a1, $s3, $zero
        add $a2, $s2, $zero
        add $a3, $s1, $zero
        jal hanoi

    exithanoi:

        lw   $ra, 0($sp)        # restore registers from stack
        lw   $s0, 4($sp)
        lw   $s1, 8($sp)
        lw   $s2, 12($sp)
        lw   $s3, 16($sp)

        addi $sp, $sp, 20       # restore stack pointer

        jr $ra

    output:

        li $v0,  4              # print string
        la $a0,  part1
        syscall
        li $v0,  4              # print string
        la $a0,  part2
        syscall
        li $v0,  11             # print character
        add $a0, $s1, $zero
        syscall
        li $v0,  4              # print string
        la $a0,  part3
        syscall
        li $v0,  11             # print character
        add $a0, $s2, $zero
        syscall

        beq $s0, $t1, exithanoi
        j recur2