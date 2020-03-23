#!/usr/bin/swift

// For loops



// For loops over arrays and ranges. Looks like python syntax. Also, if you aren't gonna use each element in their respective iterations,
// you should use _ to denote that the loop won't keep track of the elements. As well, iterating over tuples is tricky.

let range = 1...5

print("Players gonna ")

for _ in range {
    print("play")
}



// While loops



let number = 5

// Remember, Swift is very type-safe, so you must use while(true), not while(1) if you want an infinite loop. 1 is an Int and
// will not be implicitly converted to a Boolean true.

/*
while(1)
{
	print("I'm wasting your resources haha!")
} */

// The while loop is very useful with user input, since you can't predict what the user will type, 
// and the for loop will not always be a great choice.

// Something interesting about the code below is that I don't need to unwrap the message, which is an optional String. The reason for that is
// because the String literal "exit" was not explicitly marked as a String (either by storing the literal in a constant or variable
// and letting the type inference kick in, or by storing the literal in a constant or variable using type annotation), so Swift can
// convert the literal depending on the context. In this situation, the "exit" literal is converted to Optional("exit"), thus making
// the comparison possible. 

var message = readLine()
//print(type(of:message))
//print(message) // this causes some warnings
while(message != "exit")
{
	print("Type exit or we'll keep at this forever.")
	message = readLine()
}



// Repeat loops



// So, repeat while is basically do while from other languages. Check the condition in the end of each iteration. You have the guarantee that
// the loop will be iterated at least once.

// Using a repeat loop with a Boolean false in the while section will run the code inside exactly one time. This has no real use besides
// obfuscating (lol), but it's interesting nonetheless.

repeat {
    print("This is false")
} while false



// Exiting loops



// break is used to stop the execution of the loop, as expected. The compiler is smart, so it gives me a warning that code after break
// will never be executed. Very good.

let letras = ["a", "b", "c"]
for letra in letras
{
	break
	print(type(of:letra))
}



// Exiting multiple loops



// So, this is a nice feature I hadn't seen before. You can name your loops, and then use break + the name of the loop to exit more than 1 level
// of looping. This is not very common, but it's still useful.

outerLoop: for i in 1...5 {
    for j in 1...5 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")

        if product == 15 {
            print("It isn't a bullseye!")
            break outerLoop
        }
    }
}



// Skipping items



// The same as break, but instead of exiting the loop, it jumps to the next iteration. Like break, you can name the loops and use continue on them.
// If only continue is used, the effect is applied to the current innermost loop, the same as break. Not much to say here.

outerLoop: for i in 1...5 {
    for j in 1...5 {
        let product = i * j

        if product % 2 == 1 {
            print("No odds allowed!")
            continue outerLoop
        }
		print(product)
    }
}



// Infinite loops



// It's an infinite loop, which never ends. You can also test for a condition inside the loop and break whenever you feel like so.
//while true
//{
//	print(" ")
//}



// Looping summary



// Well, that's it! I don't have anything else to add :/
