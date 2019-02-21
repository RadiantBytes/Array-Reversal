# CS 270 Assignment 5

# This program creates an array of ints from user input. 
# The array is then reversed.
#
# @author: Thomas Lynaugh
#
# Last modified: December 1, 2017
			

		.data

reverse:	.asciiz "Reverse:"
		.align 2

maximum:	.asciiz "Maximum:"
		.align 2

newLine:	.asciiz "\n"
		.align 2

space:		.asciiz " "
		.align 2
			
arr: 		.space 400	

		.text
main:		addi $v0, $zero, 5		# Prepare to read int
 		syscall
 		add  $s0, $v0, $zero		# Set $s0 = user input (len)
 	
 		add  $s1, $zero, $zero 		# i = 0
 		la   $s3, arr			# $s3 = arr
 	
 Loop:  	slt  $t0, $s1, $s0 		# $t0 = (i < len) ? 1:0
 		beq  $t0, $zero, LoopEnd 	# !(i < len) -> LoopEnd
		addi $v0, $zero, 5		# Prepare to read int
 		syscall
 		add  $s2, $v0, $zero		# Set $s2 = user input (array int)
 		
 		sll  $t0, $s1, 2		# $t0 = i * 4
 		add  $t0, $s3, $t0		# $t0 = arr + (i * 4)]
 		sw   $s2, 0($t0)		# arr[i] = $s2
 		
 		addi $s1, $s1, 1		# i = i + 1
 		j    Loop			# Repeat Loop
 		
 LoopEnd:	la   $a0, reverse 		# Set $a0 = addr of Reverse"
 		addi $v0, $zero, 4		# Prepare to print "Reverse:"
 		syscall
 		
 		add  $s1, $s0, $zero 		# i = len
 		addi $s1, $s1, -1		# i = i - 1
 
 Loop2:		la   $a0, space			# Set $a0 = addr of space
   		addi $v0, $0, 4			# Prepare to print " "
   		syscall
   		
 		slt  $t0, $s1, $zero		# $t0 = (i < 0) ? 1:0
 		beq  $t0, $zero, ContinueLoop2	# !(i < 0) -> ContinueLoop2
 		j    Loop2End			# Else, end Loop 2
 		
 ContinueLoop2:	sll  $t0, $s1, 2		# $t0 = i * 4
 		add  $t0, $s3, $t0		# $t0 = arr + i * 4
 		lw   $t1, 0($t0)		# $t1 = arr[i]
 		
 		addi $v0, $zero, 1		# Prepare to print integer
 		add  $a0, $t1, $zero		# Set $a0 = arr[i] to print
 		syscall
 		
 		addi $s1, $s1, -1		# i = i - 1
 		j Loop2				# Repeat Loop2
 		
 Loop2End:	la   $a0, newLine		# Set $a0 = addr of newLine
   		addi $v0, $0, 4			# Prepare to print "\n"
   		syscall

		la   $a0, maximum		# Set $a0 = addr of Maximum"
 		addi $v0, $zero, 4		# Prepare to print "Maximum:"
 		syscall
 		
 		la   $a0, space			# Set $a0 = addr of space
   		addi $v0, $0, 4			# Prepare to print " "
   		syscall
   		
   		add $s1, $zero, $zero		# i = 0
   		la   $s3, arr			# $s3 = arr
   		lw   $s4, 0($s3)		# $s4 = arr[i]
   		add  $s5, $s4, $zero 		# currMax = first element in array
 		
 Loop3:		slt  $t0, $s1, $s0 		# $t0 = (i < len) ? 1:0
 		beq  $t0, $zero, Loop3End 	# !(i < len) -> Loop3End
 		
 		sll  $t0, $s1, 2		# $t0 = i * 4
 		add  $t0, $s3, $t0		# $t0 = arr + i * 4
 		lw   $t1, 0($t0)		# $t1 = arr[i]
 		
 		slt  $t2, $t1, $s5		# $t2 = (arr[i] < currMax) ? 1:0
 		beq  $t2, $zero, newMax 	# !(arr[i] < currMax) -> newMax
 		addi $s1, $s1, 1		# i = i + 1
 		j    Loop3			# Repeat Loop3
 		
 newMax:	add  $s5, $t1, $zero		# currMax = arr[i]
 		addi $s1, $s1, 1		# i = i + 1
 		j   Loop3			# Jump to Loop3 with new currMax
 		
 Loop3End:	addi $v0, $zero, 1		# Prepare to print integer
 		add  $a0, $s5, $zero		# Set $a0 = currMax to print
 		syscall
 		
 		la   $a0, newLine		# Set $a0 = addr of newLine
   		addi $v0, $0, 4			# Prepare to print "\n"
   		syscall
 
