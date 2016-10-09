.global main

.text

main:
@ entry to our main program

	push {lr} 		 @ save our lator exiting our ain function
	ldr r0,=intro_msg        @ loads our label intro_msg into regestry 0
	bl printf		 @ system call for printf, used to display our intro_msg in r0

	ldr r0, =int1_msg	 @ same as  the last section we load our msg into r0 and call the printf function
	bl printf
	ldr r0, =pattern 	 @ we need to load our scan pattern into r0 in order to tell the scanf function what to look for
	ldr r1, =x		 @ we load reg 1 and make it fold the address pointer to x
	bl scanf		 @ we call scanf to scan the buffer for our x input

	ldr r0, =int2_msg	 @ agian we follow our first section in order to print our msg
	bl printf
	ldr r0, =pattern	 @ we provide the scan pattern
	ldr r1, =y		 @ load r1 -> address  of y
	bl scanf		 @ scan buffer for our y value

	ldr r1,=x 		 @ load our r1 with the pointer to x
	ldr r1,[r1]		 @ derefrence r1 in order to use the store value at that address
	ldr r2,=y		 @ load r2 with the pointer to y
	ldr r2,[r2]		 @ derefrence r2 so that it contains our store value for y
	add r3,r1,r2		 @ adds r1 and r2, then the result will be stored in r3

	ldr r0,=sum_msg		 @ load r0 with our sum_msg
	bl printf		 @ calls the printf in order to print our msg to cmd
				 @ will print %d's in order with our registors ex.) it would print
				 @ The sum of 'r1' and 'r2' is 'r3', the rX stands for our values stor there

	pop {pc}		 @ pops our program counter

.data
@ labels and any variables

intro_msg: .asciz "Hello welcome to Add Two Integers\n\n"	 @ our intro msg, string
int1_msg: .asciz "Enter an integer for the first number: "	 @ our first int msg, string
int2_msg: .asciz "Enter an integer for the second number: "	 @ our second int msg, string
sum_msg: .asciz "The sum of %d and %d is %d\n\n" 		 @ our formatted msg, string

x:.word 0							 @ var x of size word intilized to 0
y:.word 0							 @ var y of size word intilized to 0

pattern: .asciz "%d"						 @ scan pattern for scanf it is looking for an integer
