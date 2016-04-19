//
//  ViewController.swift
//  TipCalculator
//
//  Created by Main Account on 9/15/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
  
  @IBOutlet var totalTextField : UITextField!
  @IBOutlet var taxPctSlider : UISlider!
  @IBOutlet var jpyPctSlider : UISlider!
  @IBOutlet var cnyPctSlider : UISlider!
  @IBOutlet var eurPctSlider : UISlider!
  @IBOutlet var taxPctLabel : UILabel!
  @IBOutlet var jpyPctLabel : UILabel!
  @IBOutlet var cnyPctLabel : UILabel!
  @IBOutlet var eurPctLabel : UILabel!
  @IBOutlet var resultsTextView : UITextView!
  @IBOutlet weak var tableView: UITableView!
  
  let tipCalc = TipCalculatorModel(total: 10000, usdPct: 1148, jpyPct: 1058,cnyPct: 176,eurPct: 1297)
    var possibleTips = Dictionary<Int, (countryMoney:String, country:String, total:Double, taxTotal:Double)>()
  var sortedKeys:[Int] = []
  
  func refreshUI() {
    totalTextField.text = String(format: "%0.2f", tipCalc.total)
    taxPctLabel.text = "원/USD \(Int(taxPctSlider.value))"
    jpyPctLabel.text = "원/JPY \(Int(jpyPctSlider.value))"
    cnyPctLabel.text = "원/CNY \(Int(cnyPctSlider.value))"
    eurPctLabel.text = "원/EUR \(Int(eurPctSlider.value))"
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    refreshUI()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func calculateTapped(sender : AnyObject) {
    tipCalc.total = Double((totalTextField.text! as NSString).doubleValue)
    tipCalc.pusd = Int(taxPctSlider.value)
    tipCalc.pjpy = Int(jpyPctSlider.value)
    tipCalc.pcny = Int(cnyPctSlider.value)
    tipCalc.peur = Int(eurPctSlider.value)
    tipCalc.realusd = Double(taxPctSlider.value) + Double(taxPctSlider.value*0.02)
    tipCalc.realjpy = Double(jpyPctSlider.value) + Double(jpyPctSlider.value*0.02)
    tipCalc.realcny = Double(cnyPctSlider.value) + Double(cnyPctSlider.value*0.02)
    tipCalc.realeur = Double(eurPctSlider.value) + Double(eurPctSlider.value*0.02)
    
    possibleTips = tipCalc.returnPossibleTips()
    sortedKeys = Array(possibleTips.keys).sort()
    tableView.reloadData()
  }

  @IBAction func taxPercentageChanged(sender : AnyObject) {
    refreshUI()
  }
  
  @IBAction func viewTapped(sender : AnyObject) {
    totalTextField.resignFirstResponder()
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sortedKeys.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
   
    let tipPct = sortedKeys[indexPath.row]
    let tcountry = possibleTips[tipPct]!.country
    let mcountry = possibleTips[tipPct]!.countryMoney
    let total = possibleTips[tipPct]!.total
    let taxtotal = possibleTips[tipPct]!.taxTotal
   
    cell.textLabel?.text = "\(tcountry) = "
    cell.detailTextLabel?.text = String(format:"환전 금액 : %0.2f\(mcountry), 세금+환전 금액 : %0.2f\(mcountry)", total, taxtotal)
    return cell
  }
  
}

