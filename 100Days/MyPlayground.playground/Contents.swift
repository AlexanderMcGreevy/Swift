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
