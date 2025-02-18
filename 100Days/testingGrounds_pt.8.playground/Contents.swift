import Cocoa

//Optonals
let opposites = [
    "Mario": "Wario",
    "Luigi": "Waluigi"
]

let peachOpposite = opposites["Peach"]


if let marioOpposite = opposites["Mario"] {
    print("Mario's opposite is \(marioOpposite)")
}

var username: String? = nil//The ? makes the var an ptional and allows it to be nil or have a value

if let unwrappedName = username {// the if let statement lets us use one output for strings and the other for an empty optional
    print("We got a user: \(unwrappedName)")
} else {
    print("The optional was empty.")
}


func square(number: Int) -> Int {
    number * number
}

var number: Int? = nil//This wont run because a non-optional int is needed
//print(square(number: number))
if let unwrappedNumber = number {//this now works because we only run the function if the number is not nil
    print(square(number: unwrappedNumber))
}
//this also works
if let number = number {//var name can be reused
    print(square(number: number))
}

//guard let is another way to unwrap optionals
func printSquare(of number: Int?) {
    guard let number = number else {//guard let checks if there is a value in the variable
        print("Missing input")//guard let runs the code inside the braces if the optional is nil
        return//always include return to bail
    }

    print("\(number) x \(number) is \(number * number)")
}


//nil coalescing
let captains = [
    "Enterprise": "Picard",
    "Voyager": "Janeway",
    "Defiant": "Sisko"
]

let new = captains["Serenity"] ?? "N/A"//the ?? operator allows us to set a default value if the optional is nil
print(new)

let tvShows = ["Archer", "Babylon 5", "Ted Lasso"]
let favorite = tvShows.randomElement() ?? "None"//?? works with anything that can return an optional


let input = ""
let number2 = Int(input) ?? 0
print(number2)



//optional chaining
let names = ["Arya", "Bran", "Robb", "Sansa"]

let chosen = names.randomElement()?.uppercased() ?? "No one"//returns an optional if nothing found in string ? then returns code for optional ??
print("Next in line: \(chosen)")



//functon failure with optionals
enum UserError: Error {
    case badID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

if let user = try? getUser(id: 23) {//If getUser doesnot succeed in getting a string it will return nil instead of crashing
    print("User: \(user)")
}
let user = (try? getUser(id: 23)) ?? "Anonymous"//same thing but with nil coalescing
print(user)
