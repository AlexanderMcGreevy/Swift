import Cocoa

//classes can build upon one another unlike structs
class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()
newGame.score += 10

//Inheritance allows child classes to ruse aspects of the parents
class Employee {
    let hours: Int

    init(hours: Int) {
        self.hours = hours
    }
    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}
//Both subclasses reuse the hours var but have different work methods
class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
    override func printSummary() {//override allows us to alter the parent class method
        print("I'm a developer who will sometimes work \(hours) hours a day, but other times spend hours arguing about whether code should be indented using tabs or spaces.")
    }
}

class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}
let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)
robert.work()
joseph.work()
let novall = Developer(hours: 8)
novall.printSummary()


class Vehicle {
    let isElectric: Bool

    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}
class Car: Vehicle {
    let isConvertible: Bool

    init(isElectric: Bool, isConvertible: Bool) {//When reinitializing must include the previous variables as a super.init()
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}

let teslaX = Car(isElectric: true, isConvertible: false)


class User {
    var username = "Anonymous"
}
var user1 = User()
var user2 = user1//when copying a class the soure is shared so any changes to one are made to the other
user2.username = "Taylor"
print(user1.username)
print(user2.username)
var user3 = User()//creating a new class instance will not affect other instances
print(user3.username)
//////////////////////////////////////////
///
///
class User2 {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }

    deinit {//deinit is called when a class is destroyed
        print("User \(id): I'm dead!")
    }
}

for i in 1...3 {//because this user is created inside a for statement it will be destroyed when the loop ends
    let user = User2(id: i)
    print("User \(user.id): I'm in control!")
}


class User3 {
    var name = "Paul"
}

let user4 = User3()
user4.name = "Taylor"
print(user4.name)
