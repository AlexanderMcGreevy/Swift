import Cocoa

func randomInt(array: [Int]?) -> Int{
    return array?.randomElement() ?? Int.random(in: 1...100)
}
print(randomInt(array: [1,2,3,4,5,6,7,8,9,10]))

print(randomInt(array: nil))
print(randomInt(array: nil))
