import Cocoa

var greeting = "Hello, playground"
greeting = "I am a swift dev now :)"
print(greeting)

//Constant variable
let character="Scooby"
//character='Bobby'
print(character)

//Can use emojis
let result = "⭐️ You win! ⭐️"

//Multiline strings
var movie = """
A day in
the life of an
Apple engineer
"""
var num = movie.count
print(num)
print(movie.hasPrefix("A day"))

let score = 10*3
let bigNum=100_1000_220
print(bigNum)
print(score)

let number = 120
print(number.isMultiple(of: 3))

let numbr = 0.1 + 0.2
print(numbr)

let a = 1
let b = 2.0
var c = Double(a) + b
c = Double(a + Int(b))


var rating = 5.0
rating *= 2

var bool = true
print(bool)
print(!bool)

//Revereses the boolean
bool.toggle()
print(bool)

print("Hello"+" World")

let name="bobby"
print("Hello my name is \(name)!")

//Arrays
var beatles = ["John", "Paul", "George", "Ringo"]
let numbers = [4, 8, 15, 16, 23, 42]
var temperatures = [25.3, 28.2, 26.4]
print(beatles[0])
print(numbers[1])
print(temperatures[2])

beatles.append("Adrian")

//Appends to the end of a matrix
var scores = Array<Int>()
scores.append(100)
scores.append(80)
scores.append(85)
print(scores[0])

print(scores.count)
print(scores.sorted())

//dictionary
let employee2 = ["name": "Taylor Swift",
                 "job": "Singer",
                 "location": "Nashville"]
print(employee2["name", default: "Unknown"])
print(employee2["job", default: "Unknown"])
print(employee2["location", default: "Unknown"])


var heights = [String: Int]()
heights["Yao Ming"] = 229
heights["Shaquille O'Neal"] = 216
heights["LeBron James"] = 206

//Set(No duplicates
var people = Set(["Denzel Washington", "Tom Cruise", "Nicolas Cage", "Samuel L Jackson"])
people.insert("Samuel L Jackson")
print(people)
print(people.count)

//enums
//Makes sure you only set avar to something in the list
/*enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}

var day = Weekday.monday
day = Weekday.tuesday
day = Weekday.friday
//day = Weekday.bob //Doesnt work
*/

//The same thing but more efficient
enum Weekday {
    case monday, tuesday, wednesday, thursday, friday
}
var day = Weekday.monday
day = .tuesday
day = .friday

//Manually assign data types
let surname: String = "Lasso"
var scored: Int = 0
