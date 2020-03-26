#!/usr/bin/swift

// Writing functions

func testeMaluco() {
    print("A função testeMaluco foi chamada. O que deseja?")
}

testeMaluco()

// Accepting parameters

func crazy(name: String) {
    print("crazy \(name)")
}

crazy(name: "Rudigus")

// Returning values

func factorial(number: Int) -> Int {
    var result: Int = 1
    for i in 1..<(number + 1) {
        result *= i
    }
    return result
}

let result = factorial(number: 5)
print(result)

// Parameter labels

// You provide an external label to a parameter by writing two names separated by a space
// The first name will be used to call the function,
// and the second will be used inside the function.

func going(from origin: String, to destination: String) {
    print("I'm going from \(origin) to \(destination). See you later!")
}

going(from: "Brazil", to: "Japan")

// Omitting parameter labels

// print clone
func say(_ message: String) {
    print(message)
}

say("hello")

// Default parameters

// According to IEEE 754-2008, 0 to the power of 0 should be treated as 1.
func power(_ base: Int, toThePowerOf exponent: Int = 2) -> Int {
    var power: Int = 1
    for _ in 1..<(exponent + 1) {
        power *= base
    }
    return power
}

print(power(-2, toThePowerOf: 3))
print(power(-4))
/*
for i in 0...10 {
    for j in 0...10 {
        print(power(i, toThePowerOf: j), terminator: " ")
    }
    print("")
}
*/

// Variadic functions

func sum(numbers: Int...) -> Int {
    var result: Int = 0
    for number in numbers {
        result += number
    }
    return result
}

// 0 arguments
print(sum())
// 5 arguments
print(sum(numbers: 1,2,3,4,5))

// Writing throwing functions & Running throwing functions

enum ConnectionError: Error {
    case invalidIp
    case invalidPort
}

func isValidIp(_ ip: String) -> Bool {
    // Good luck on implementing this
    return ip != ""
}

func isValidPort(_ port: Int) -> Bool {
    // This one is easier
    return port >= 0 && port <= 65_535
}

func establishConnection(toIpAddress ip: String, withPortNumber port: Int) throws {
    if !isValidIp(ip) {
        throw ConnectionError.invalidIp
        // code after throw will never be executed
    }
    if !isValidPort(port) {
        throw ConnectionError.invalidPort
    }
    print("Connection to \(ip):\(port) established.")
}

func joinServer(withIpAddress ip: String, andPortNumber port: Int) {
    do {
        try establishConnection(toIpAddress: ip, withPortNumber: port)
        print("Joined server succesfully.")
    } catch ConnectionError.invalidIp {
        print("Invalid IP.")
    } catch ConnectionError.invalidPort {
        print("Invalid Port.")
    } catch {
        print("Unexpected error: \(error).")
    }
}

joinServer(withIpAddress: "192.168.15.29", andPortNumber: 9090)
joinServer(withIpAddress: "127.0.0.1", andPortNumber: 100_000)
joinServer(withIpAddress: "", andPortNumber: 80)

// inout parameters

// inout changes the variable outside the function too, like a pointer / reference
func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10
// Gotta pass the variable with & (ampersand) before it if the parameter is marked with inout
doubleInPlace(number: &myNum)
print(myNum)

// That's all!
