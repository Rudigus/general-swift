#!/usr/bin/swift

// Closures - Part 1

// Creating basic closures

// anonymous function. The variable is basically holding the body of the function.
let anon = { print("ok booma") }
anon()

// Accepting parameters in a closure

let sum = { (a: Int, b: Int) in
    print(a + b)
}
sum(5, 4)

// Returning values from a closure

let product = { (a: Int, b: Int) -> Int in
    return a * b
}
print(product(3, 5))

// Closures as parameters

let difference = { (a: Int, b: Int) -> Int in
    return a - b
}

func numericalExpression(FirstOperand a: Int, SecondOperand b: Int, ThirdOperand c: Int, FirstOperation op1: (Int, Int) -> Int, SecondOperation op2: (Int, Int) -> Int) -> Int {
    return op2(op1(a, b), c)
}

print(numericalExpression(FirstOperand: 2, SecondOperand: 3, ThirdOperand: 5, FirstOperation: product, SecondOperation: difference))

// Trailing closure syntax

func customOperation(a: Int, b: Int, operation: (Int, Int) -> Int) -> Int {
    let c = operation(a, b)
    let d = operation(b, c)
    return d
}

print(customOperation(a: 5, b: 4) { (a: Int, b: Int) in a + b })


// Closures - Part 2 - Nothing here yet



// Bonus - Syntaxes of closure

// No parameter no return

let a = { () -> Void in print("ok") }

let b = { () in print("ok") }

let c = { print("ok") }

// Parameter no return

let d = { (number: Int) -> Void in print(number) }

let e = { (number: Int) in print(number) }

let f = { (number) in print(number) }

// Return no parameter

let g = { () -> Int in return 5 }

let h = { () -> Int in 5 }

let i = { () in return 5 }

let j = { () in 5 }

let k = { return 5 }

let l = { 5 }

// Parameter and return

let m = { (number: Int) -> Int in return number }

let n = { (number: Int) -> Int in number }

let o = { (number: Int) in return number }

let p = { (number: Int) in number }

