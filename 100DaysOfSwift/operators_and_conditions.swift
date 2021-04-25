#!/usr/bin/swift

// Arithmetic operators



var a = 5
var b = 10
var c = a + b
/* Looks like C# division. If both operands are integers, then the result is an integer. But if one of the operands are floating-point types,
 the result is that type too. It looks like always infer Double from floating-point numbers*/
print("\(c) % 4 is \(c%4) and \(c) / 4 is \(c/4). 16 % 5 is \(16%5) and 16 / 5 is \(16/5)")
print("16.0 / 5 is \(16.0 / 5)")
print("\(type(of: Float(5) / 2))")



// Operator overloading



// I like this feature.
let bigArray = [5, 4, 3] + [7, 8, 9]
print(bigArray)



// Compound assignment operators



var frase = "vamos contar! "
for i in 1...5 { frase += "\(i).. " }
print(frase)



// Comparison operators



// It follows the Lexicographical order. Basically, alphabetical ordering. The unicode values are compared.
// So "A" has a lower unicode value than "B".
print("A > B = \("A">"B")")
let str1 = "ok"
let str2 = "ok"
// Strings are value type in Swift. That's really cool.
print(str1 == str2)



// Conditions



// Just the regular.

let password = "112233"

if password == "123456"
{
	print("Not a really safe one eh")
}
else if password == "654321"
{
	print("Trying to fool the password checker, huh?")
}
else if password != password
{
	print("This text is useless, it will never be printed. So I can say whatever I want!")
}
else
{
	print("Your password is secure, I think")
}

let aInt = 1
let aDouble = 1.5
// Swift is very type-safe. You can't compare ints with doubles :(
//print(aDouble > aInt)
// But you can compare a Double literal with an Int literal. The Int literal has no explicit type, so, because of the comparison context, it is
// inferred as a Double.
//print(1.5 > 1)
// Also, it seems like some part of what is called typecasting in other languages is done through initializing here
// The explicit conversion below is basically just calling the String initializer whose parameter type is the same
// as the provided argument type (in this case, a Double)
//print(String(1.5))



// Combining conditions



// So, it seems like Swift applies short-circuit evaluation. That's very nice

let anotherInt = 1
//print(type(of: type(of: anotherInt))) // type(of:) return is of type Int.Type
// print(type(of:anotherInt) == Int.self) // This is a way to check if anotherInt is of type Int. but it is damn ugly.
// I can just do that:
//print(anotherInt is Int)

// With short-circuiting, the if statement is more efficient and can be used to prevent errors
let zero = 0
// if I do this, I get an error:
// print(5/0)
// and if I do this, I get a fatal error (scary)
// print(5/zero)
// But if I use the if statement below, I don't get any errors, since only the first condition will be evaluated. If I changed the
// conditional operator || to &&, I would get a fatal error. It's very useful.
if zero == 0 || 5 / zero < 5
{
	print("All went well")
}



// The ternary operator



// Not much to say here, it's the same as other languages. Still, I'd like to oppose hacking with swift website - it says ternary operator is
// rather hard to read. Well, it can be rather hard to read, but if the whole if statement is small, it looks really cool!

// Prints the greatest number
let n1 = 5
let n2 = 4
print(n1 > n2 ? n1 : n2)



// Switch statements



// So, Swift doesn't need the ugly break at the end of every case, and if you need to fallthrough, you have a fallthrough keyword. Splendid!
// Also, Swift's overprotectiveness once again makes its appearance: you gotta cover ALL the cases in a switch case. 
// It is said switch statements in Swift are exhaustive. The default case cover everything that isn't covered by the other cases.
// You can cover all the cases and not need a default case too (for example, using switch on an enum). Very cool

let weather = "sunny"
switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day!")
}

// What to do if you don't want to treat all the cases? Just leave the default case empty!
// Also, cases in Swift are generally at the same indentation level as the switch statement. I'm not used to that but it's understandable.

switch weather
{
case "rain":
	print("It's raining")
default: ()
}
// with "default: ()" you can ignore the cases you don't want.



// Range operators



var array1: [Int] = []
for i in 1...5 { array1.append(i) }
var array2: [Int] = []
for i in 1..<5 { array2.append(i) }
print(array1, array2) 

// n1...n2 includes n2, and n1..<n2 excludes n2. Pretty self-explanatory.
var array3: [Int] = []
for i in 5...5 { array3.append(i) }
// Even if the start and the end are the same, the start is appended. array3 will be [5]
print(array3)
// if it was 5..<5, the end would be lower than the start, so no element would be appended. array3 still would be [].



// Operators and conditions summary



// Nothing to say here.

// The code below is correct, but will generate a warning, since the result of the comparison is unused.
// 5 < 4
