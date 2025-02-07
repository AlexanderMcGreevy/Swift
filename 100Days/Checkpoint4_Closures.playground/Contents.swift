import Cocoa

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

func manipulate(using list: [Int]) -> [String]{
    var odd = list.filter{$0 % 2 == 1}
    var sortedOdd = odd.sorted()
    return sortedOdd.map{"\($0) is a lucky number"}
}

print(manipulate(using: luckyNumbers))
