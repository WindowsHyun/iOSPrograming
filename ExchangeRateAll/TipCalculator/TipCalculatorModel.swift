//
//  TipCalculatorModel.swift
//  TipCalculator
//
//  Created by Main Account on 9/15/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import Foundation

class TipCalculatorModel {
 
  var total: Double
  //-------------------------
  // 국가 표시를 위해서 사용한다
  var usdString : String
  var jpyString : String
  var cnyString : String
  var eurString : String
  //-------------------------
  // 수수료를 포함한 실제 금액
  var realusd: Double
  var realjpy: Double
  var realcny: Double
  var realeur: Double
  // 수수료를 포함한 실제 금액
  var pusd: Int
  var pjpy: Int
  var pcny: Int
  var peur: Int
  //-------------------------
  // 국가 표시를 위해서 사용한다
  var usdMoney : String
  var jpyMoney : String
  var cnyMoney : String
  var eurMoney : String
    //-------------------------
    
    init(total: Double, usdPct: Double, jpyPct: Double, cnyPct: Double, eurPct:Double) {
    self.total = total
    self.pusd = 0
    self.pjpy = 0
    self.pcny = 0
    self.peur = 0
    self.realusd = 0
    self.realjpy = 0
    self.realcny = 0
    self.realeur = 0
    self.usdString = "USD"
    self.jpyString = "JPY"
    self.cnyString = "CNY"
    self.eurString = "EUR"
    self.usdMoney = "달러"
    self.jpyMoney = "엔"
    self.cnyMoney = "위안"
    self.eurMoney = "유로"
  }
 
    func calcTipWithTipPct(index:Int) -> (countryMoney:String, country:String, total:Double, taxTotal:Double) {
    var finalTotal = Double(0)
    var taxfinalTotal = Double(0)
    var country = ""
    var countryMoney = ""
    if index == 1{
        country = usdString
        countryMoney = usdMoney
        taxfinalTotal = total / realusd
        finalTotal = total / Double(pusd)
    }
    if index == 2{
        country = jpyString
        countryMoney = jpyMoney
        taxfinalTotal = (total / realjpy) * 100
        finalTotal = (total / Double(pjpy)) * 100
    }
    if index == 3{
        country = cnyString
        countryMoney = cnyMoney
        taxfinalTotal = total / realcny
        finalTotal = total / Double(pcny)
    }
    if index == 4{
        country = eurString
        countryMoney = eurMoney
        taxfinalTotal = total / realeur
        finalTotal = total / Double(peur)
    }
    return (countryMoney, country, finalTotal, taxfinalTotal)
  }
 
    func returnPossibleTips() -> [Int: (countryMoney:String, country:String, total:Double, taxTotal:Double)] {
 
    var retval = [Int: (countryMoney:String, country:String, total:Double, taxTotal:Double)]()
    for index in 1...4{
            retval[index] = calcTipWithTipPct(index)
    }
        
        
        
        
    return retval
 
  }
 
}