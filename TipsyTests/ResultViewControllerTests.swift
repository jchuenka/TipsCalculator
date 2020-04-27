//
//  ResultViewControllerTests.swift
//  TipsyTests
//
//  Created by Ubonvan Chuenkamon on 4/27/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import Mockingbird

@testable import Tipsy

class ResultViewControllerTests: QuickSpec {
    override func spec() {
        var storyboard : UIStoryboard!
        var mockEngine : BillEngineInterfaceMock!
        var vut : ResultViewController!
        beforeSuite {
            storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        }
        
        beforeEach {
            guard let view = storyboard.instantiateViewController(withIdentifier: String(describing: ResultViewController.self)) as? ResultViewController else {
                assertionFailure("Cannot initialize ResultViewController")
                return
            }
            vut = view
            mockEngine = mock(BillEngineInterface.self)
            vut.initilize(mockEngine)
        }
        describe("ResultViewController") {
            context("viewDidLoad") {
                beforeEach {
                    given(mockEngine.getSplitAmountDisplay()) ~> "15.30"
                    given(mockEngine.getSplitNumber()) ~> 4
                    given(mockEngine.getTipDisplay()) ~> "15%"
                }
                it("should display result view in portrait") {
                    let view = vut.view
                    
                    expect(view) == snapshot("iPhone 11 viewDidLoad portrait")
                }
                it("should display result view in landscape") {
                    XCUIDevice.shared.orientation = .landscapeLeft
                    let view = vut.view
                    
                    expect(view) == snapshot("iPhone 11 viewDidLoad landscape")
                }
            }
        }
        afterEach {
            XCUIDevice.shared.orientation = .portrait
        }
    }
}
