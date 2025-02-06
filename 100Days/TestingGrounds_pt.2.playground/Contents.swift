import Cocoa

//Functions
func showWelcome() {
    print("Welcome to my app!")
    print("By default This prints out a conversion")
    print("chart from centimeters to inches, but you")
    print("can also set a custom range if you want.")
}
showWelcome()

//Variable type must be declared
func printTimesTables(number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

//Must declare name
printTimesTables(number: 5)

//the _ allows the function to be called without a variable name
func printTimesTables2(_ number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables2(5)  // No 'number:' required now!

func rollDice() -> Int {
    return Int.random(in: 1...6)
}

let result = rollDice()
print(result)

//Use tuples to return multiple data types
func getUser() -> (String, String) {//can also be firstname:string lastname:string
    ("Bob", "Marley")
}

let user = getUser()
print("Name: \(user.0) \(user.1)")//Can also be user.firstname user.lastname
let (firstName, lastName) = getUser()

//first name is used externally and second is ussed internally
func printTimesTables(for number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}
printTimesTables(for: 5)

//Errors
enum PasswordError: Error {
    case short, obvious//Enum lets us only have the two cases we want
}
func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }

    if password == "12345" {
        throw PasswordError.obvious
    }

    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}

let string = "12345"
//Error Catching example
do {
    let result = try checkPassword(string)
    print("Password rating: \(result)")
} catch PasswordError.short {
    print("Please use a longer password.")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage!")
} catch {
    print("There was an error.")
}
