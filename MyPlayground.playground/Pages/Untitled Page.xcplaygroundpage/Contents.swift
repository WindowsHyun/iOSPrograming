//: Playground - noun: a place where people can play
/*:
# welcome to Playgrounds
This is your *first* playground which is intented to demonstrate:
* The use of **Quick Look8*
* Placing results **in-line** with the code
*/


import UIKit

let myLabel = UILabel(frame:CGRectMake(0,0,200,50))
myLabel.backgroundColor = UIColor.redColor()
myLabel.text = "Hello Swift"
myLabel.textAlignment = .Center
myLabel.font = UIFont(name:"Georgia", size:24)
myLabel

let image = UIImage(named: "waterfall")


var str = "Hello, IOS Programing"

var x = 10

for index in 1...20 {
    let y = index * x--
}
