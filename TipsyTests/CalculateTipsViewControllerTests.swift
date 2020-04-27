//
//  CalculateTipsViewControllerTests.swift
//  TipsyTests
//
//  Created by Ubonvan Chuenkamon on 4/24/20.
//

import Quick
import Nimble_Snapshots
import Nimble
import Mockingbird
import XCTest

@testable import Tipsy

class CalculateTipsViewControllerTests: QuickSpec {
    override func spec() {
        var vut : TipCalculatorViewController!
        var storyboard : UIStoryboard!
        var mockEngine : BillEngineInterfaceMock!
        beforeSuite {
            storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        }
        beforeEach {
            mockEngine = mock(BillEngineInterface.self)
            guard let view = storyboard.instantiateViewController(withIdentifier:    String(describing: TipCalculatorViewController.self)) as? TipCalculatorViewController else {
                assertionFailure("Cannot initialize TipCalculatorViewController")
                return
            }
            vut = view
            given(mockEngine.getTaxDisplay()) ~> "6.25"
            view.billEngine = mockEngine
            XCUIDevice.shared.orientation = .portrait
        }
        describe("TipCalculationViewController") {
            describe("viewDidLoad") {
                it("should display initial load page") {
                    let view = vut.view
                    expect(view) == snapshot("IPhone 11 viewDidLoad Portriat")
                }
                it("should display initial view on landscape") {
                    XCUIDevice.shared.orientation = .landscapeLeft
                    let view = vut.view
                    expect(view) == snapshot("IPhone 11 viewDidLoad landscape")
                }
            }
        }
        describe("Amount Pre-tax field") {
            it("should set pre tax amount when edit ended") {
                _ = vut.view
                vut.amountField.text = "34.50"
                
                vut.amountFieldEditEnded(vut.amountField)
                
                let captureFloat = ArgumentCaptor<Float>()
                verify(mockEngine.setAmountPreTax(captureFloat.matcher)).wasCalled()
                expect(captureFloat.value) == 34.50
            }
        }
        describe("Tax field") {
            it("should set tax amount when edit ended") {
                _ = vut.view
                vut.taxField.text = "6.25"
                
                vut.taxFieldEditEnded(vut.taxField)
                
                let captureFloat = ArgumentCaptor<Float>()
                verify(mockEngine.setTaxPercent(captureFloat.matcher)).wasCalled(exactly(2))
                expect(captureFloat.allValues) == [8.25, 6.25]
                
            }
        }
        afterEach {
            XCUIDevice.shared.orientation = .portrait
        }
    }

}
