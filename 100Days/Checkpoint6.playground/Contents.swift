import Cocoa

struct car{
    var name: String
    var seats: Int
    var gear = 1
    
    func carInfo(){
        print("Car name: \(name)")
        print("Car seats: \(seats)")
        print("Car gear: \(gear)")
    }
    
    mutating func gearUp(){
        gear += 1
        carInfo()
        return
    }
    mutating func gearDown(){
        if gear >= 1 {
            gear -= 1
        }
        carInfo()
        return
    }
}

var lambo = car(name: "Lamborghini", seats: 2)
lambo.gearUp()
   
    

