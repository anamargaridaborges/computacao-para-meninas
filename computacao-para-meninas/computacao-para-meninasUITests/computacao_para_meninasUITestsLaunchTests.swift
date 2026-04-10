//
//  computacao_para_meninasUITestsLaunchTests.swift
//  computacao-para-meninasUITests
//
//  Created by Ana Margarida Diniz Silva Borges on 07/04/26.
//

import XCTest

final class computacao_para_meninasUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        
        print(app.debugDescription)
        
        //checar o botão continuar desativado
        let continueButton = app.buttons["Continuar"]
        XCTAssertFalse(continueButton.isEnabled)
        
        //simulando um acerto
        let card1 = app.buttons["card_1"]
        card1.tap()
        let card3 = app.buttons["card_3"]
        card3.tap()
        XCTAssertFalse(card1.isEnabled)
        XCTAssertFalse(card3.isEnabled)
        
        //simulando um erro
        let card0 = app.buttons["card_0"]
        card0.tap()
        let card4 = app.buttons["card_4"]
        card4.tap()
        XCTAssert(card0.isEnabled)
        XCTAssert(card4.isEnabled)
        
        let predicate = NSPredicate(format: "isEnabled == true")
        expectation(for: predicate, evaluatedWith: card0)
        
        waitForExpectations(timeout: 2)
        
        //simulando todos os acertos
        card0.tap()
        let card5 = app.buttons["card_5"]
        card5.tap()
        XCTAssertFalse(card0.isEnabled)
        XCTAssertFalse(card5.isEnabled)
        
        let card2 = app.buttons["card_2"]
        card2.tap()
        card4.tap()
        XCTAssertFalse(card2.isEnabled)
        XCTAssertFalse(card4.isEnabled)
        
        XCTAssert(continueButton.isEnabled)
        continueButton.tap() //vai para proximo exercicio
        
        
        

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
