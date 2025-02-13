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
