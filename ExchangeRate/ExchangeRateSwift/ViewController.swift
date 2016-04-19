//
//  ViewController.swift
//  TipCalculator
//
//  Created by HyunWindows on 2016. 4. 5..
//  Copyright © 2016년 HyunWindows. All rights reserved.
//

//1
import UIKit

//2
class ViewController: UIViewController {
    @IBOutlet var totalTextField : UITextField!
    @IBOutlet var taxPctSlider : UISlider!
    @IBOutlet var taxPctLabel : UILabel!
    @IBOutlet var resultsTextView : UITextView!
    
    let tipCalc = TipCalculatorModel(total : 1000000.00, taxPct:1000)
    
    func refreshUI(){
        totalTextField.text = String(format:"%0.2f", tipCalc.total)
        taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
        taxPctLabel.text = "원/달러 : \(Int(taxPctSlider.value))"
        resultsTextView.text = ""
    }
    
    //3
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshUI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //4
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calculateTapped(sender : AnyObject) {
        tipCalc.total = Double((totalTextField.text! as NSString).doubleValue)
        tipCalc.onedollar = Double(taxPctSlider.value) + Double(taxPctSlider.value*0.02)
        tipCalc.reonedollar = Double(taxPctSlider.value*0.02)
        let possibleTips = tipCalc.returnPossibleTips()
        
        /*
        tipCalc.total = Double((totalTextField.text! as NSString).doubleValue)
        tipCalc.onedoler = Double(taxPctSlider.value) + Double(taxPctSlider.value*0.02) - Double(taxPctSlider.value*0.02*0.3)
        resultsTextView.text = results
        */
        
        var results = ""
        
        for(tipPct, tipValue) in possibleTips{
            results += "\(tipPct)% 쿠폰 : \(Int(tipValue)) 달러 환전 가능\n"
        }
        resultsTextView.text = results
    }
    @IBAction func taxPercentageChanged(sender : AnyObject) {
        tipCalc.taxPct = Double(taxPctSlider.value)/100.0
        refreshUI()
    }
    @IBAction func viewTapped(sender : AnyObject) {
        
    }


}

