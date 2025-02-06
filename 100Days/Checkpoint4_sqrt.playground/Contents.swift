import Cocoa


enum bad: Error{
    case outOfBounds
    case noRoot
}


func square(_ num: Int) throws -> Int{
    if (num > 10000)||(num < 1){
        throw bad.outOfBounds
    }
    for x in 1...100{
        if (x*x) == num{
            return x
        }
    }
    throw bad.noRoot
}

do{
    let result = try square(16)
    print("Result: \(result)")
} catch bad.outOfBounds{
    print("out of bounds")
} catch bad.noRoot{
    print("no root")
} catch {
    print("an unknown error occurred")
}




