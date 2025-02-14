import Cocoa

//A protocal is a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. This is much easier than making a subclass for each different type of vehicle
protocol Vehicle {
    var name: String { get }//must be declared and can be found with a getter
    var currentPassengers: Int { get set }//must be declared and can be found with a getter and setter
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}
//the struct now knows the bare minimum of time and travel must be present
struct Car: Vehicle {//the : means that the struct is following the Vehicle protocol
    let name = "Car"
    var currentPassengers = 1
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }

    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }

    func openSunroof() {
        print("It's a nice day!")
    }
}
struct Bicycle: Vehicle {
    let name = "Bicycle"
    var currentPassengers = 1
    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }

    func travel(distance: Int) {
        print("I'm cycling \(distance)km.")
    }
}

func commute(distance: Int, using vehicle: Vehicle) {//Now any struct with the Vehicle protocol can be used
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

let car = Car()
commute(distance: 100, using: car)
let bike = Bicycle()
commute(distance: 50, using: bike)

//protocols also come in handy when needing to accept an array of different types of structs as long as they follow the protocol
func getTravelEstimates(using vehicles: [Vehicle], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print("\(vehicle.name): \(estimate) hours to travel \(distance)km")
    }
}

getTravelEstimates(using: [car, bike], distance: 150)


//Opaque Return types
func getRandomNumber() -> some Equatable {//some Equatable means that the return type will be some type as long as it's equatable(== >= <=)
    Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}

print(getRandomNumber() == getRandomNumber())


//Extensions
extension String {//This extension adds functionality to the string variable that  trimms the whitespace and newlines from a string everytime it is called
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)//self is used because we already know that we are in a string
    }
}
var quote = "   The truth is rarely pure and never simple   "
let trimmed = quote.trimmed()//extensins are much simpler to use

//another example of an extension
extension String {
    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
}
let lyrics = """
But I keep cruising
Can't stop, won't stop moving
It's like I got this music in my mind
Saying it's gonna be alright
"""

print(lyrics.lines.count)

//Protocol extensions
protocol Person {
    var name: String { get }
    func sayHello()
}
extension Person {//This extension ereses the need for someone to make thir own custom sayHello function
    func sayHello() {
        print("Hi, I'm \(name)")
    }
}

struct Employee: Person {
    let name: String
}

let joe = Employee(name: "Joe Mama")
joe.sayHello()
