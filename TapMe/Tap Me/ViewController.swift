//
//  ViewController.swift
//  Tap Me
//
//  Created by HyunWindows on 2016. 3. 17..
//  Copyright © 2016년 HyunWindows. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var scoreLbel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    
    var count = 0
    
    var seconds = 0
    var timer = NSTimer()
    
    func setupGame(){
        seconds = 30
        count = 0
        timerLabel.text = "Time : \(seconds)"
        scoreLbel.text = "Score : \(count)"
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self, selector:Selector("subtractTime"), userInfo: nil, repeats:true)
    }
    
    func subtractTime(){
        seconds--
        timerLabel.text = "Time : \(seconds)"
        
        if(seconds == 0){
            
            timer.invalidate()
            let alert = UIAlertController(title:"Time is Up!", message: "You scored \(count) points", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title:"Play Again", style:UIAlertActionStyle.Default, handler: {
                action in self.setupGame()
            }))
            
            presentViewController(alert, animated: true, completion:nil)
        }
    }
    
    @IBAction func buttonPressed(){
        count++
        scoreLbel.text = "Score \n\(count)"
        //scoreLbel.text = "Pressed"
        //NSLog("Button Pressed")
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

