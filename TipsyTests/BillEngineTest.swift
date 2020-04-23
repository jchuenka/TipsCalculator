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
                        sut.billInfo.amountPreTax = expected
                        verify(infoMock.setAmountPreTax(expected)).wasCalled()
                    }
                }
            }
        }
    }
}
