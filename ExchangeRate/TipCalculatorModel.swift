//
//  TipCalculatorModel.swift
//  TipCalculator
//
//  Created by HyunWindows on 2016. 4. 5..
//  Copyright © 2016년 HyunWindows. All rights reserved.
//

import Foundation

class TipCalculatorModel {
    
    var total: Double
    var taxPct: Double
    var onedollar: Double
    var reonedollar: Double
    var realDollar:Double
    var subtotal: Double {
        get {
            return total / (taxPct + 1)
        }
    }
    
    init(total: Double, taxPct: Double) {
        self.total = total
        self.taxPct = taxPct
        self.onedollar = 0
        self.reonedollar = 0
        self.realDollar = 0
    }
    
    func calcTipWithTipPct(tipPct: Double) -> Double {
        realDollar = onedollar - reonedollar * tipPct
        return total / realDollar
    }
    
    func returnPossibleTips() -> [Int: Double] {
        
        let possibleTipsInferred = [0.30, 0.50, 0.70, 0]
        
        var retval = [Int: Double]()
        for possibleTip in possibleTipsInferred {
            let intPct = Int(possibleTip*100)
            retval[intPct] = calcTipWithTipPct(possibleTip)
        }
        return retval
        
    }
    
}