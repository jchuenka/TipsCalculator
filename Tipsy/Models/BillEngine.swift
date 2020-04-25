//
//  BillEngine.swift
//  Tipsy
//
//  Created by Ubonvan Chuenkamon on 4/21/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

public class BillEngine : BillEngineInterface {
    private var billInfo : BillInfo
    public static var defaultTax: Float = 0.0825
    
    public var splitNumber: Int {
        get { splitNum }
        set {
            if newValue > 1 {
                splitNum = newValue
            }
        }
    }
    
    public var splitDisplay : String {
        return String(format: "%d", splitNumber)
    }
    
    public var amountPreTax: Float {
        get {
            return self.billInfo.amountPreTax
        }
        set {
            self.billInfo.amountPreTax = newValue
        }
    }
    
    public var amountPreTaxDisplay: String {
        return String(format: "%.2f", amountPreTax)
    }
    
    public var taxDisplay: String {
        return String(format: "%.2f", billInfo.taxPercent * 100.0)
    }
    
    public var tipDisplay: String {
        return "\(Int(tipsPercent * 100))%"
    }
    
    public var tipsPercent: Float {
        get {
            return self.billInfo.tipPercent
        }
        set {
            self.billInfo.tipPercent = newValue
        }
    }
    
    public var taxPercent: Float {
        get {
            self.billInfo.taxPercent
            
        }
        set {
            self.billInfo.taxPercent = newValue
        }
    }
    public func getSplitAmount() -> Float {
        let tips = amountPreTax * tipsPercent
        let tax = amountPreTax * taxPercent
        return (amountPreTax + tips + tax) / Float(splitNumber)
    }
    
    public var splitAmountDisplay: String {
        return String(format: "%.2f", getSplitAmount())
    }
    
    private var splitNum: Int
    
    init(billInfo : BillInfo, split : Int) {
        self.billInfo = billInfo
        self.splitNum = split
    }
}
