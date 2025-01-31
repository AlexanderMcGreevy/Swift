import Cocoa

var array = ["1234","Bob","Fred", "Joe", "Bob"]
print("Array: \(array)")
print("Items in the Array: \(array.count)")

var unique = Set(array)
print("Unique Array: \(unique)")
print("Unique in the Array: \(unique.count)")


