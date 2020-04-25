//
//  BillEngineTest.swift
//  BillEngineTest
//
//  Created by Ubonvan Chuenkamon on 4/22/20.
//

import Mockingbird
import Quick
@testable import Tipsy


class BillEngineTest: QuickSpec {
    override func spec() {
        describe("BillEngine") {
            var sut : BillEngine!
            var infoMock : BillInfoMock!
            beforeEach {
                infoMock = mock(BillInfo.self).initialize()
                sut = BillEngine(billInfo: infoMock, split: 2) // default setting
            }
            
            describe("property") {
                context("billInfo") {
                    it("should set amount pre tax") {
                        let expected : Float = 45.50
                        sut.amountPreTax = expected
                        verify(infoMock.setAmountPreTax(expected)).wasCalled()
                    }
                    it("should set taxPercent") {
                        let expected : Float = 0.0815
                        sut.taxPercent = expected
                        verify(infoMock.setTaxPercent(expected)).wasCalled()
                    }
                    it("should set tipPercent") {
                        let expected : Float = 0.10
                        sut.tipsPercent = expected
                        verify(infoMock.setTipPercent(expected)).wasCalled()
                    }
                }
                context("Computed") {
                    beforeEach {
                        given(infoMock.getAmountPreTax()) ~> 28.20
                        given(infoMock.getTipPercent()) ~> 0.15
                        given(infoMock.getTaxPercent()) ~> 0.0825
                    }
                    it("should return split number") {
                        let result = sut.splitNumber
                        assert(result == 2, "Should return 2 as the default")
                    }
                    it("should set new split number") {
                        let expected = 6
                        sut.splitNumber = expected
                        assert(sut.splitNumber == expected, "Failed split number return not equal number settingl ")
                    }
                    it("should not set split number less than 2") {
                        sut.splitNumber = 3
                        assert(sut.splitNumber == 3, "Failed to set split number greater than min")
                        sut.splitNumber = 1
                        assert(sut.splitNumber == 3, "Failed split number should not be less than 2.")
                    }
                    
                    it("should return string format for split number") {
                        let displayString: String = sut.splitDisplay
                        assert(displayString == "2", "Error! actual string is \(displayString)")
                    }
                    
                    it("should return string format for pretax amount") {
                        let displayString = sut.amountPreTaxDisplay
                        assert(displayString == "28.20", "Error: actual display string is \(displayString)")
                    }
                    it("should return string format for tax percent") {
                        let displayString = sut.taxDisplay
                        assert(displayString == "8.25", "Error: actual display string is \(displayString)")
                    }
                    it("should return string format for tips percent") {
                        let displayString = sut.tipDisplay
                        assert(displayString == "15%", "Error: actual display string is \(displayString)")
                    }
                    it("should return string format for split amount") {
                        let displayString = sut.splitAmountDisplay
                        assert(displayString == "17.38", "Error: actual display string is \(displayString)")
                    }
                }
            }
            describe("function") {
                beforeEach {
                    given(infoMock.getAmountPreTax()) ~> 10.0
                }
                context("No tax") {
                    beforeEach {
                        given(infoMock.getTaxPercent()) ~> 0.0
                    }
                    it("should return correct split amount for no tip") {
                        given(infoMock.getTipPercent()) ~> 0.0
                        let amount = sut.getSplitAmount()
                        assert(amount == 5.0, "\(amount) is incorrect amount")
                    }
                    it("should return correct split amount for 10% tip") {
                        given(infoMock.getTipPercent()) ~> 0.10
                        let amount = sut.getSplitAmount()
                        assert(amount == 5.5, "\(amount) is incorrect amount")
                    }
                    it("should return correct split for 20% tip") {
                        given(infoMock.getTipPercent()) ~> 0.20
                        let amount = sut.getSplitAmount()
                        assert(amount == 6.0, "\(amount) is incorrect amount")
                    }
                }
                context("with 10% tax") {
                    beforeEach {
                        given(infoMock.getTaxPercent()) ~> 0.10
                    }
                    it("should return correct split amount for no tip") {
                        given(infoMock.getTipPercent()) ~> 0.0
                        let amount = sut.getSplitAmount()
                        assert(amount == 5.5, "\(amount) is incorrect amount")
                    }
                    it("should return correct split amount for 10% tip") {
                        given(infoMock.getTipPercent()) ~> 0.10
                        let amount = sut.getSplitAmount()
                        assert(amount == 6.0, "\(amount) is incorrect amount")
                    }
                    it("should return correct split for 20% tip") {
                        given(infoMock.getTipPercent()) ~> 0.20
                        let amount = sut.getSplitAmount()
                        assert(amount == 6.5, "\(amount) is incorrect amount")
                    }

                }
                
            }
        }
    }
}
