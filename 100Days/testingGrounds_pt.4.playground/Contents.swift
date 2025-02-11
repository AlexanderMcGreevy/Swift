import Cocoa

//private vars stop variables from being accessed outside of a struct
struct BankAccount {
    private var funds = 0

    mutating func deposit(amount: Int) {
        funds += amount
    }

    mutating func withdraw(amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account = BankAccount()
account.deposit(amount: 100)
let success = account.withdraw(amount: 200)

if success {
    print("Withdrew money successfully")
} else {
    print("Failed to get the money")
}

//account.funds -= 1000 ///This will no longer work
// private = nothing outside the struct
// file private = nothing outside the file
// public = anyone can use

@MainActor //static allows only the structs to edit a variable shared by all instances(MainActor prevents datarace error)
struct School {
    static var studentCount = 0

    static func add(student: String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}

School.add(student: "Julian Casablancas")
print(School.studentCount)
