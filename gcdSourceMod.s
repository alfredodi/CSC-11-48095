// In this assignment, I want you to implement a function finding the Greatest Common Divisor.
//
// I have provided you with this skeleton Assembly Language source file for
// you to use (I want you to focus on implementing this function rather
// than focusing on writing an entire program from scratch).
// I will penalize points from your assignment if you modify any code or sections
// that I have provided. Only section where I comment that you may modify is the
// section you are to do your work.

.text
.global main

gcd:
// Implement your gcd function between here and "end of gcd function" comment
// Usage of the function: gcd(x,y), with the gcd returned in R0.
// Parameters: Register R0 must contain x, and register R1 must contain y.

	push {lr}    // push the link registor on to the stack

	push {R1}    // push R1 onto stack to save it for after the mod is called
	bl mod       // branch with link mod
	cmp R0, #0   // compare R0, with the value of 0
	beq _return  // if the if the compare is zeros then it will branch into _return
	pop {R1}     // contains R1 that was push beforehand.

	             // Containts of Registors
	             // R0 holding mod result need to store into R1
	             // R1 nonsense results do not matter as it will be replaced.
	             // R2 will be used for holding our temp values.

	mov R2, R1   // mov our b into R2 (temp registor) in order to preserve it
	mov R1, R0   // mov our mod result back into r1
	mov R0, R2   // mov our temp val bavk into r0

	bl gcd       // calls gcd recusively

	pop {pc}     // pops lr into pc to exit program

                     // if true _return will return back our "y or b"
_return:
	pop {R0}     // returns our b if test was true.
	pop {pc}     // pops our recursive call nth push of lr of stack and back into pc


// end of gcd function

// DO NOT MODIFY ANY PART OF THIS SOURCE FILE FROM THIS LINE TO THE END OF FILE
// POINTS WILL BE DEDUCTED IF YOU DO SO!!!

// Utility modulus function for you to use in your gcd function:
// Usage: mod(x,y), returns the modulus of x and y in register R0.
// Parameters: Register R0 must contain x, and register R1 must contain y.
mod:	push {LR}
	mov R3, R1
	mov R1, #0
	mov R2, #1
	//Shift the denominator left until greater than numerator, then shift back 
_shift_left:
        //R3<<=1; //Denominator shift left
	mov r3, r3, asl #1
        //R2<<=1; //Division shift left
	mov r2, r2, asl #1
    	//if(R0>R3)goto _shift_left;//Shift Left until Decrement/Division Greater than Numerator
    	cmp r0, r3 // compare r0 to r3
	bgt _shift_left // branch if greater than to _shift_left label
    	//R3>>=1; //Shift Denominator right
    	mov r3, r3, asr #1
    	//R2>>=1; //Shift Division right
    	mov r2, r2, asr #1
    	//Loop and keep subtracting off the shifted Denominator 
_subtract: //if(R0<R3)goto _done;
    	cmp r0, r3 // compare r0 to r3
    	blt _done // branch if less than to _done
        //R1+=R2; //Increment division by the increment
	adds r1, r2
        //R0-=R3; //Subtract shifted Denominator with remainder of Numerator
	subs r0, r3 //Shift right until denominator is less than numerator
_shift_right:
        //if(R2==1) goto _subtract;
	cmp r2, #1 // compare r2 to #1
	beq _subtract // branch if equal to _subtract
        //if(R3<=R0)goto _subtract;
	cmp r3, r0 // compare r3 to r0
	ble _subtract // branch if less than or equal to _subtract
        //R2>>=1; //Shift Increment left
	mov r2, r2, asr #1
        //R3>>=1; //Shift Denominator left
	mov r3, r3, asr #1
        //goto _shift_right; //Shift Denominator until less than Numerator
	bal _shift_right
    	//goto _subtract; //Keep Looping until the division is complete
    	bal _subtract
_done:	pop {PC}
// end of mod function

main:
	push {LR}
	ldr R0, =welcome
	bl printf

	ldr R0, =prompt_a
	bl printf

	ldr R0, =scan_pat
	ldr R1, =a
	bl scanf

	ldr r0, =prompt_b
	bl printf

	ldr r0, =scan_pat
	ldr r1, =b
	bl scanf

	ldr r0, =a
	ldr r0, [r0]
	ldr r1, =b
	ldr r1, [r1]
	bl gcd
	ldr r1, =gcd_result
	str r0, [r1]

	ldr r0, =gcd_msg
	ldr r1, =a
	ldr r1, [r1]
	ldr r2, =b
	ldr r2, [r2]
	ldr r3, =gcd_result
	ldr r3, [r3]
	bl printf

	mov r0, #0
	pop {PC}
// end of main function

.data
welcome: .asciz "Welcome to the GCD Program!\n"
prompt_a: .asciz "Enter a value for A: "
prompt_b: .asciz "Enter a value for B: "
gcd_msg: .asciz "gcd(%d,%d) = %d\n"
scan_pat: .asciz "%d"

a: .word 0
b: .word 0
gcd_result: .word 0
