.data
intro1: .asciiz "Elements of Computing Systems - 2"
intro2: .asciiz "Batch-B Team -3"
intro3: .asciiz "Welcome to Tic Tac Toe"
msg1: .asciiz "Read the instructions carefully before you start the game."
turn1: .asciiz "Player 1's turn: "
turn2: .asciiz "Player 2's turn: "
win1: .asciiz "Player 1 wins."
win2: .asciiz "Player 2 wins."
lastdraw: .asciiz "It's a draw."
line1: .asciiz "1 2 3"
line2: .asciiz "4 5 6"
line3: .asciiz "7 8 9"
guide: .asciiz "Enter the location[1-9] to play the game."
guide1: .asciiz "Player 1: X and Player 2: O."
grid: .space 9

.text

main:
	li $s3, 0
	li $s4, 0
	la $a0, intro1
	li $v0, 4
	syscall
	jal newline
	la $a0, intro2
	li $v0, 4
	syscall
	jal newline
	la $a0, intro3
	li $v0, 4
	syscall
	jal newline
	la $a0, msg1
	li $v0, 4
	syscall
	jal newline
	jal newline
	jal displaysample

turn:
	jal newline
	beq $s3, 0, play1 #0 for player 1
	beq $s3, 1, play2 #1 for player 2

play1:
	la $a0, turn1
	li $v0, 4
	syscall
	jal newline
	j play

play2:
	la $a0, turn2
	li $v0, 4
	syscall
	jal newline
	j play

play:
	jal newline
	beq $s4, 9, draw
	jal getinput
	jal checkinput
	j storeinput

displaysample:
	la $a0, line1
	li $v0, 4
	syscall
	jal newline
	la $a0, line2
	li $v0, 4
	syscall
	jal newline
	la $a0, line3
	li $v0, 4
	syscall
	jal newline
	la $a0, guide
	li $v0, 4
	syscall
	jal newline
	la $a0, guide1
	li $v0, 4
	syscall
	j turn

display:
	li $s0, 0 
	li $s1, 0 
	j displayline 

displayline:
	addi $s1, $s1, 3 
	jal newline
	j displaygrid 

displaygrid:
	beq $s0, 9, checkwinall 
	beq $s0, $s1, displayline
	addi $s0, $s0, 1 
	la $t2, grid 
	add $t2, $t2, $s0  
	lb $t3, ($t2) 
	jal addspace 
	beq $t3, 0, displayspace 
	beq $t3, 1, displayx 
	beq $t3, 2, displayo 

displayx:
	li $a0, 88 
	li $v0, 11 
	syscall
	j displaygrid

displayo:
	li $a0, 79 
	li $v0, 11 
	syscall
	j displaygrid

displayspace:
	li $a0, 63 
	li $v0, 11 
	syscall
	j displaygrid 

getinput:
	li $v0, 5 
	syscall
	li $s2, 0
	add $s2, $s2, $v0 
	jr $ra 

checkinput:
	la $t1, grid  
	add $t1, $t1, $s2 
	lb $t2, ($t1) 
	bne $t2, 0, turn 
	bge $s2, 10, turn 
	ble $s2, 0, turn 
	jr $ra 

storeinput:
	addi $s4, $s4, 1 
	beq $s3, 0, storex 
	beq $s3, 1, storeo 

storex:
	la $t1, grid
	add $t1, $t1, $s2 
	li $t2, 1 
	sb $t2, ($t1)
	li $s3, 1 
	j display
	
storeo:
	la $t1, grid
	add $t1, $t1, $s2
	li $t2, 2
	sb $t2, ($t1)
	li $s3, 0 
	j display

checkwinall:
	bge $s4, 5, wincondition1 
	j turn 

wincondition1:
	li $s6, 0
	li $s5, 1 
	la $t1, grid 
	add $t1, $t1, $s5 
	lb $t2, ($t1) 
	addi $t1, $t1, 1 
	lb $t3, ($t1) 
	addi $t1, $t1, 1 
	lb $t4, ($t1) 
	add $s6, $s6, $t2 
	bne $t2, $t3, wincondition2 
	bne $t3, $t4, wincondition2 
	beq $t2, 0, wincondition2 
	j win 

wincondition2:
	li $s6, 0
	li $s5, 1
	la $t1, grid
	add $t1, $t1, $s5
	lb $t2, ($t1)
	addi $t1, $t1, 3
	lb $t3, ($t1)
	addi $t1, $t1, 3
	lb $t4, ($t1)
	add $s6, $s6, $t2
	bne $t2, $t3, wincondition3
	bne $t3, $t4, wincondition3
	beq $t2, 0, wincondition3
	j win

wincondition3:
	li $s6, 0
	li $s5, 1
	la $t1, grid
	add $t1, $t1, $s5
	lb $t2, ($t1)
	addi $t1, $t1, 4
	lb $t3, ($t1)
	addi $t1, $t1, 4
	lb $t4, ($t1)
	add $s6, $s6, $t2
	bne $t2, $t3, wincondition4
	bne $t3, $t4, wincondition4
	beq $t2, 0, wincondition4
	j win

wincondition4:
	li $s6, 0
	li $s5, 2
	la $t1, grid
	add $t1, $t1, $s5
	lb $t2, ($t1)
	addi $t1, $t1, 3
	lb $t3, ($t1)
	addi $t1, $t1, 3
	lb $t4, ($t1)
	add $s6, $s6, $t2
	bne $t2, $t3, wincondition5
	bne $t3, $t4, wincondition5
	beq $t2, 0, wincondition5
	j win

wincondition5:
	li $s6, 0
	li $s5, 4
	la $t1, grid
	add $t1, $t1, $s5
	lb $t2, ($t1)
	addi $t1, $t1, 1
	lb $t3, ($t1)
	addi $t1, $t1, 1
	lb $t4, ($t1)
	add $s6, $s6, $t2
	bne $t2, $t3, wincondition6
	bne $t3, $t4, wincondition6
	beq $t2, 0, wincondition6
	j win

wincondition6:
	li $s6, 0
	li $s5, 3
	la $t1, grid
	add $t1, $t1, $s5
	lb $t2, ($t1)
	addi $t1, $t1, 2
	lb $t3, ($t1)
	addi $t1, $t1, 2
	lb $t4, ($t1)
	add $s6, $s6, $t2
	bne $t2, $t3, wincondition7
	bne $t3, $t4, wincondition7
	beq $t2, 0, wincondition7
	j win

wincondition7:
	li $s6, 0
	li $s5, 3
	la $t1, grid
	add $t1, $t1, $s5
	lb $t2, ($t1)
	addi $t1, $t1, 3
	lb $t3, ($t1)
	addi $t1, $t1, 3
	lb $t4, ($t1)
	add $s6, $s6, $t2
	bne $t2, $t3, wincondition8
	bne $t3, $t4, wincondition8
	beq $t2, 0, wincondition8
	j win

wincondition8:
	li $s6, 0
	li $s5, 7
	la $t1, grid
	add $t1, $t1, $s5
	lb $t2, ($t1)
	addi $t1, $t1, 1
	lb $t3, ($t1)
	addi $t1, $t1, 1
	lb $t4, ($t1)
	add $s6, $s6, $t2
	bne $t2, $t3, turn 
	bne $t3, $t4, turn 
	beq $t2, 0, turn 
	j win 

newline:
	li $a0, 10 
	li $v0, 11 
	syscall
	jr $ra

addspace:
	li $a0, 32 
	li $v0, 11 
	syscall
	jr $ra

win:
	beq $s6, 1, player1win 
	beq $s6, 2, player2win 

player1win:
	jal newline
	la $a0, win1
	li $v0, 4
	syscall
	j end
	
player2win:
	jal newline
	la $a0, win2
	li $v0, 4
	syscall
	j end

draw:
	jal newline
	la $a0, lastdraw
	li $v0, 4
	syscall
	j end
	
end:
	li $v0, 10
	syscall
