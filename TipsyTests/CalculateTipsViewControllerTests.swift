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
        beforeEach {
            mockEngine = mock(BillEngineInterface.self)
            storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            guard let view = storyboard.instantiateInitialViewController() as? TipCalculatorViewController else {
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
    }

}
