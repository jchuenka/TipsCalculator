//
//  BillEngineTest.swift
//  BillEngineTest
//
//  Created by Ubonvan Chuenkamon on 4/22/20.
//

import Mockingbird
import Quick
import Nimble

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
                        let settingValue : Float = 8.15
                        let expectedValue : Float = settingValue / 100.0
                        sut.taxPercent = settingValue
                        verify(infoMock.setTaxPercent(expectedValue)).wasCalled()
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
                        expect(result) == 2
                    }
                    it("should set new split number") {
                        let expected = 6
                        sut.splitNumber = expected
                        expect(sut.splitNumber) == expected
                    }
                    it("should not set split number less than 2") {
                        sut.splitNumber = 3
                        assert(sut.splitNumber == 3, "Failed to set split number greater than min")
                        sut.splitNumber = 1
                        expect(sut.splitNumber) == 3
                    }
                    
                    it("should return string format for split number") {
                        let displayString: String = sut.splitDisplay
                        expect(displayString) == "2"
                    }
                    
                    it("should return string format for pretax amount") {
                        let displayString = sut.amountPreTaxDisplay
                        expect(displayString) == "28.20"
                    }
                    it("should return string format for tax percent") {
                        let displayString = sut.taxDisplay
                        expect(displayString) == "8.25"
                    }
                    it("should return string format for tips percent") {
                        let displayString = sut.tipDisplay
                        expect(displayString) == "15%"
                    }
                    it("should return string format for split amount") {
                        let displayString = sut.splitAmountDisplay
                        expect(displayString) == "17.38"
                    }
                    it("should return total amount") {
                        let expectedTotal : Float = 34.7565
                        
                        expect(sut.totalAmount) == expectedTotal
                    }
                    it("should return total amount string") {
                        let expectedStr = "34.76"
                        expect(sut.totalAmountDisplay) == expectedStr
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
                        expect(amount) == 5.0
                    }
                    it("should return correct split amount for 10% tip") {
                        given(infoMock.getTipPercent()) ~> 0.10
                        let amount = sut.getSplitAmount()
                        expect(amount) == 5.5
                    }
                    it("should return correct split for 20% tip") {
                        given(infoMock.getTipPercent()) ~> 0.20
                        let amount = sut.getSplitAmount()
                        expect(amount) == 6.0
                    }
                }
                context("with 10% tax") {
                    beforeEach {
                        given(infoMock.getTaxPercent()) ~> 0.10
                    }
                    it("should return correct split amount for no tip") {
                        given(infoMock.getTipPercent()) ~> 0.0
                        let amount = sut.getSplitAmount()
                        expect(amount) == 5.5
                    }
                    it("should return correct split amount for 10% tip") {
                        given(infoMock.getTipPercent()) ~> 0.10
                        let amount = sut.getSplitAmount()
                        expect(amount) == 6.0
                    }
                    it("should return correct split for 20% tip") {
                        given(infoMock.getTipPercent()) ~> 0.20
                        let amount = sut.getSplitAmount()
                        expect(amount) == 6.5
                    }

                }
                
            }
        }
    }
}
