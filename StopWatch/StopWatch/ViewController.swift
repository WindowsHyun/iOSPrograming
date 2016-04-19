//
//  ViewController.swift
//  StopWatch
//
//  Created by HyunWindows on 2016. 3. 18..
//  Copyright © 2016년 HyunWindows. All rights reserved.
//1

import UIKit

class ViewController: UIViewController {
    @IBOutlet var timewatch: UILabel!
    
    var sss = 00
    var ss = 00
    var m = 00
    var timering = false
    
    var timer = NSTimer()
    
    func StartTimer(){
        /*
        if (sss == 0 && ss == 0 && m == 0){
        //timewatch.text = "Init Start"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("subtractTime"), userInfo:  nil, repeats: true)
        }else{
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("subtractTime"), userInfo:  nil, repeats: true)
        }
*/
        if(timering == false){
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("subtractTime"), userInfo:  nil, repeats: true)
            timering = true
        }
        
    }
    
    func subtractTime(){
        sss++
        if ( sss >= 10){
            ss++
            sss = 0
        }
        if ( ss >= 60){
            m++
            ss = 0
        }
        
        timewatch.text = "\(m) : \(ss) : \(sss)"
    }
    
    
    @IBAction func stopBtnPressed(){
        timering = false
        timer.invalidate()
        //timewatch.text = "Stop Button"
        
    }
    
    @IBAction func startBtnPressed(){
        StartTimer()
        //timewatch.text = "Start Button"
        
    }
    
    @IBAction func resetBtnPressed(){
        sss = 0
        ss = 0
        m = 0
        timewatch.text = "\(m) : \(ss) : \(sss)"
        //timewatch.text = "Reset Button"
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

