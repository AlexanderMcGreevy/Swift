import Cocoa

class Animal {
    var legs = 0
    
    init(legs: Int = 0) {
        self.legs = legs
    }
}
class Dog : Animal {
    func speak() {
        print("Woof!")
    }
}

class Cat : Animal {
    var isTame = false
    
    init(isTame: Bool, legs: Int) {
        self.isTame = isTame
        super.init(legs: legs)
    }
    
    func speak() {
        print("Meow!")
    }
}

var cat = Cat(isTame: true, legs:3)
cat.speak()
print(cat.legs)
