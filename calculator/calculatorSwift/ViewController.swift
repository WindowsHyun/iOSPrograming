//
//  ViewController.swift
//  calculator
//
//  Created by HyunWindows on 2016. 3. 27..
//  Copyright © 2016년 HyunWindows. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var Content: UILabel!
    @IBOutlet var Result: UILabel!
    
    var ContentNum:String = "0"
    var ResultNum:String = ""
    var ResultInt:Int = 0
    var ResultDou:Double = 0
    var WhatKey:String = ""
    var firstIn:Bool = true
    var firstDot:Bool = true
    
    @IBAction func BtnNumber(sender: UIButton){
        
        if firstIn == true{
            ContentNum = sender.currentTitle!
            if sender.currentTitle != "0" && sender.currentTitle != "." {
            firstIn = false
            }else{
                if ( sender.currentTitle == "."){
                    ContentNum = "0."
                    firstDot = false
                    firstIn = false
                }
            
            }
        }else{
            if sender.currentTitle == "."{
                if firstDot == true {
                    ContentNum = "\(ContentNum)\(sender.currentTitle!)"
                    firstDot = false
                }
            }else{
            ContentNum = "\(ContentNum)\(sender.currentTitle!)"
            }
        }
        
        Content.text = "\(ContentNum)"
    }
    
    @IBAction func BtnAC(){
        firstIn=true
        firstDot=true
        ContentNum = "0"
        ResultInt = 0
        ResultDou = 0
        WhatKey = ""
        Content.text = "\(ContentNum)"
        Result.text = ""
    }
    
    
    @IBAction func BtnOperatorTwo(sender: UIButton){
        let BtnContent = sender.currentTitle!
        if ( BtnContent == "+/-" && ContentNum != "0"){
            if ( Double(ContentNum)! > 0.0){
                ContentNum = "-\(ContentNum)"
                Content.text = ContentNum
            }else{
                let replaced = (ContentNum as NSString).stringByReplacingOccurrencesOfString("-", withString: "")
                ContentNum = replaced
                Content.text = ContentNum
            }
        }
        
        if ( BtnContent == "%" && ContentNum != "0"){
            ResultDou = Double(ContentNum)! / 100
            ContentNum = "\(ResultDou)"
            ResultDou = 0
            Content.text = ContentNum
        }
        
    }
    
    @IBAction func BtnOperator(sender: UIButton){
        let BtnContent = sender.currentTitle!
        
        if BtnContent == "=" {
            let range = ContentNum.rangeOfString(".")   // .이 있는지 판단을 한다
            let rangeRe = ResultNum.rangeOfString(".")   // .이 있는지 판단을 한다
            
            if range != nil || rangeRe != nil {
                // .이 있을경우
                if WhatKey == "+"{
                ResultDou = Double(ResultNum)! + Double(ContentNum)!
                }
                if WhatKey == "-"{
                    ResultDou = Double(ResultNum)! - Double(ContentNum)!
                }
                if WhatKey == "X"{
                    ResultDou = Double(ResultNum)! * Double(ContentNum)!
                }
                if WhatKey == "/"{
                    ResultDou = Double(ResultNum)! / Double(ContentNum)!
                }
                ContentNum = String(ResultDou)
                firstIn=true
                firstDot=true
                Content.text = ""
                Result.text = "\(ResultDou)"
                ResultNum = String(ResultDou)
                
            }else{
                if WhatKey == "+"{
                ResultInt = Int(ResultNum)! + Int(ContentNum)!
                }
                if WhatKey == "-"{
                    ResultInt = Int(ResultNum)! - Int(ContentNum)!
                }
                if WhatKey == "X"{
                    ResultInt = Int(ResultNum)! * Int(ContentNum)!
                }
                if WhatKey == "/"{
                    ResultDou = Double(ResultNum)! / Double(ContentNum)!
                    ContentNum = String(ResultDou)
                    firstIn=true
                    firstDot=true
                    Content.text = ""
                    Result.text = "\(ResultDou)"
                    ResultNum = String(ResultDou)
                }else{
                    // 나누기는 인트형이 아닌 더블형으로 나타내야 해서 바꾼다.
                ContentNum = String(ResultInt)
                firstIn=true
                firstDot=true
                Content.text = ""
                Result.text = "\(ResultInt)"
                ResultNum = String(ResultInt)
                }
            }
        }else{
            WhatKey = "\(BtnContent)"
            ResultNum = ContentNum
            ContentNum = "0"
            firstIn=true
            firstDot=true
            Content.text = ""
            Result.text = "\(ResultNum) \(BtnContent) "
            
        }
    }
    
       override func viewDidLoad() {
        super.viewDidLoad()
        Content.text = "\(ContentNum)"
        Result.text = ""
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

