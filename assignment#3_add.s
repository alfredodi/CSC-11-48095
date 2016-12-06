.data
intro: .asciz "Enter a positive integer for N:"
output: .asciz "The sum of 1 to %d is %d\n"
pattern: .asciz "%d"

sum: .word 0
counter: .word 0
num: .word 0

.text

.global main

main:
	push {lr}

	//loads r0 with our intro msg. then branches with a link to printf.
	ldr r0, =intro
	bl printf

	//loads r0 with our scan pattern and inputs the scan into num.
	ldr r0, =pattern
	ldr r1, =num
	bl scanf

	//loads r0 with num then it derefrences it and places it into r0
	ldr r0, =num
	ldr r0, [r0]

	//branches with link into add_funtion
	bl add_function

	mov r0, #1
	ldr r1, =num
	ldr r1, [r1]

	//loads r0 with our output msg and prints it.
	ldr r0, =output
	bl printf

	//pop our pc
	pop {pc}

/*
will move a 0 into r2 which is our running sum
will move the contants of r0 into r1 is our upper bound
will then move a 1 into r0 which is our counter
*/
add_function:
	mov R2, #0
	mov R1, R0
	mov R0, #1
/*
compares our counter and upper bound if counter is greater then upper bound
it will branch to done. else it will add the counter to the sum and increase
the counter by 1, and then branch to loop.
*/
loop:
	cmp r0, r1
	bgt done
	add r2, r0
	add r0, #1 // counter +1
	bal loop

// moves our sum into r0 
done:
	mov r0, r2
	mov pc, lr
