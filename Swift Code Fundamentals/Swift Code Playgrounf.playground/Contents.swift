import UIKit

//var greeting:String = "Hello, playground"
//print(greeting)

//var myInt:Int = 5
//print(myInt)
//
//var myDouble:Double = 0.5
//print(myDouble)
//
//var myBool:Bool = false
//print(myBool)

func sayHello(msg:String) {
    print(msg)
}

func doAdd(a:Int, b:Int) -> Int {
    var sum = a + a + b + b
    return sum
}
doAdd(a: 1, b: 1)

func doAdd(_ a:Int, _ b:Int) -> Int {
    var sum = a + b
    return sum
}
doAdd(1, 1)

//
//// You can create code and then call back to it instead of repeating code e.g:

//doAdd(a: 2, b: 3)

//// prints out 5

//doAdd(a: 4, b: 6)

//// prints out 10


//let result = doAdd(a: 2, b: 3)
//print(result)

let result = doAdd( 2, 3)
print(result)
// prints out 5


// If statements:

var a = 4
var b = 2
var c = 10

if a > b {
    //Some code here
    print("Bang!")
}

else if b > c {
    print("Shoot!")
}



