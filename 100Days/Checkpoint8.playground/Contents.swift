import Cocoa

protocol building{
    var rooms: Int { get }
    var cost: Int { get }
    var agent: String { get }
    
    func salesSummary()
    
}

struct House: building{
    var rooms = 4
    var cost = 500000
    var agent = "John Doe"
    
    func salesSummary(){
        print("Agent: \(agent)\nRooms: \(rooms)\nCost: $\(cost)")
    }
}
struct Office: building{
    var rooms = 10
    var cost = 1000000
    var agent = "Jane Doe"
    
    func salesSummary(){
        print("Agent: \(agent)\nRooms: \(rooms)\nCost: $\(cost)")
    }
}

var home = House(rooms: 6, cost: 1000000, agent: "Bobby Lee")
home.salesSummary()
