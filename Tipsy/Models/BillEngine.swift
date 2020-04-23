//
//  BillEngine.swift
//  Tipsy
//
//  Created by Ubonvan Chuenkamon on 4/21/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

public class BillEngine : BillEngineInterface {
    private var _billInfo : BillInfo
    public static var defaultTax: Float = 0.0825
    
    public var splitNumber: Int {
        get { splitNum }
        set {
            if newValue >= 1 {
                splitNum = newValue
            }
        }
    }
    
    public var splitDisplay : String {
        return String(format: "%d", splitNumber)
    }
    
    public var amountPreTax: Float {
        return self.billInfo.amountPreTax
    }
    
    public var amountPreTaxDisplay: String {
        return ""
    }
    
    public var taxDisplay: String {
        return String(format: "%.2f", billInfo.taxPercent * 100.0)
    }
    
    public var tipDisplay: String {
        return ""
    }
    
    public var tipsPercent: Float {
        return self.billInfo.tipPercent
    }
    
    public func getSplitAmount() -> Float {
        return 0.0
    }
    
    public var splitAmountDisplay: String {
        return ""
    }
    
    public var billInfo : BillInfo {
        return _billInfo
    }
    private var splitNum: Int
    
    init(billInfo : BillInfo, split : Int) {
        self._billInfo = billInfo
        self.splitNum = split
    }
}
