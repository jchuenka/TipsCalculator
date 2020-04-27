//
//  BillEngineInterface.swift
//  Tipsy
//
//  Created by Ubonvan Chuenkamon on 4/22/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

public protocol BillEngineInterface {
    var splitNumber : Int { get set }
    var splitDisplay : String { get }
    var amountPreTax : Float { get set }
    var amountPreTaxDisplay : String { get }
    var taxDisplay : String { get }
    var taxPercent : Float { get set}
    var tipDisplay : String { get }
    var tipsPercent : Float { get set }
    func getSplitAmount() -> Float
    var splitAmountDisplay : String { get }
    var totalAmount : Float { get }
    var totalAmountDisplay : String { get }
}
