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

//Functions can be renamed
func greetUser() {
    print("Hi there!")
}

greetUser()

var greetCopy = greetUser//Only put parentheesis when calling function
greetCopy()


//Closure expression:(Function without parameters, just calls code)(Can access variables form outside the expression)
let sayHello = {
    print("Hi there!")
}
sayHello()


//If you would like to add parameters to a closure expression
let sayHi = { (name: String) -> String in//in marks the end or parameters
    "Hi \(name)!"
}

func getUserData(for id: Int) -> String {
    if id == 1989 {
        return "Taylor Swift"
    } else {
        return "Anonymous"
    }
}

let data: (Int) -> String = getUserData //redeclaring a function using a closure statement removes the need for variable names
let user2 = data(1989)//no variable name declaration needed //(for: 1989) is not needed
print(user)


let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
//THis closure checks if an array is sorted
let captainFirstTeam = team.sorted { name1, name2 in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
}
//$0 and $1 anre use to represent the first 2 variables entered in the function
let reverseTeam = team.sorted {
    return $0 > $1
}

//.filter allows for sending back a differnt sized array
//Each time the fuction checks an entry in the matrix it checks for 2
let tOnly = team.filter { $0.hasPrefix("T") }
print(tOnly)

//.map lets me transform the items in the array to a new type
let uppercaseTeam = team.map { $0.uppercased() }
print(uppercaseTeam)
