//
//  main.swift
//  My First Project
//
//  Created by HyunWindows on 2016. 4. 7..
//  Copyright © 2016년 HyunWindows. All rights reserved.
//

import Foundation

func randomIntBetwwen(low:Int, high:Int) -> Int {
    let range = high - (low - 1)
    return (Int(arc4random()) % range)+(low-1)
    
}

let answer = randomIntBetwwen(1, high: 100)



var turn = 1
while(true){
print("Guess #\(turn): Enter a number betwwen 1 and 100.")
let userInput = input()
let inputAsInt = Int(userInput)

if let guess = inputAsInt{
    
    if(guess > answer){
    print("Lower!")
}else if(guess < answer){
    print("Higher!")
}else{
    print("Correct! The answer was \(answer).")
        break
}
}else{
    print("Invalid input! Please enter a number.")
    continue
    }
    turn = turn + 1
}
print("It took you \(turn) tries.")