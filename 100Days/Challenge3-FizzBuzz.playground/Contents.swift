import Cocoa

for num in 1...100{
    if num%3==0{
        if num%5==0{
            print("FizzBuzz")
            continue
        }
        print("Fizz")
    }
    else if num%5==0{
        print("Buzz")
    }
    else{
        print(num)
    }
    
        
}
