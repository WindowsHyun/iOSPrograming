//: Playground - noun: a place where people can play

import UIKit

func randomIntBetwwen(low:Int, high:Int) -> Int {
    let range = high - (low - 1)
    return (Int(arc4random()) % range)+(low-1)
    
}

let answer = randomIntBetwwen(1, high: 100)

print("Enter a name between 1 and 100.")
var guess = 7

if(guess>answer){
    print("Lower!")
}else if(guess < answer){
    print("Higher!")
}else{
    print("Correct! The answer was \(answer).")
}