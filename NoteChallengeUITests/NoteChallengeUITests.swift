//
//  NoteChallengeUITests.swift
//  NoteChallengeUITests
//
//  Created by Dai Tran on 8/10/23.
//

import XCTest

final class NoteChallengeUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLoginSuccess() {
        let username = "Jack"
        let app = XCUIApplication()
        app.launch()
        
        let timeout = 2.0
        let userNameTextField = app.textFields["Username"]
        XCTAssertTrue(userNameTextField.waitForExistence(timeout: timeout))
        
        userNameTextField.tap()
        userNameTextField.typeText(username)
        
        let loginButton = app.buttons["Login"]
        XCTAssertTrue(loginButton.waitForExistence(timeout: timeout))
        loginButton.tap()
        
        let navigationTitle = app.navigationBars.matching(identifier: username).firstMatch
        XCTAssertTrue(navigationTitle.waitForExistence(timeout: timeout))
    }
    
    func testLoginFailed() {
        let app = XCUIApplication()
        app.launch()
        
        let timeout = 2.0
        let userNameTextField = app.textFields["Username"]
        XCTAssertTrue(userNameTextField.waitForExistence(timeout: timeout))
        
        let loginButton = app.buttons["Login"]
        XCTAssertTrue(loginButton.waitForExistence(timeout: timeout))
        loginButton.tap()
        
        let navigationTitle = app.navigationBars.matching(identifier: "Log In").firstMatch
        XCTAssertTrue(navigationTitle.waitForExistence(timeout: timeout))
    }
    
    func testAddNoteSuccess() {
        let username = "Jack"
        let addedNote = "Random"
        let app = XCUIApplication()
        app.launch()
        
        // Input username
        let timeout = 2.0
        let userNameTextField = app.textFields["Username"]
        XCTAssertTrue(userNameTextField.waitForExistence(timeout: timeout))
        
        userNameTextField.tap()
        userNameTextField.typeText(username)
        
        // Login
        let loginButton = app.buttons["Login"]
        XCTAssertTrue(loginButton.waitForExistence(timeout: timeout))
        loginButton.tap()
        
        var navigationTitle = app.navigationBars.matching(identifier: username).firstMatch
        XCTAssertTrue(navigationTitle.waitForExistence(timeout: timeout))
        
        let list = app.collectionViews.element
        let noteCountBeforeAdding = list.exists ? list.cells.count : 0
        
        // Add note
        let addNoteButton = app.navigationBars.buttons["Add"].firstMatch
        
        XCTAssertTrue(addNoteButton.waitForExistence(timeout: timeout))
        addNoteButton.tap()
        
        navigationTitle = app.navigationBars.matching(identifier: "Add Notes").firstMatch
        XCTAssertTrue(navigationTitle.waitForExistence(timeout: timeout))
        
        let noteTextField = app.textFields["Note"]
        noteTextField.tap()
        noteTextField.typeText(addedNote)
        
        let doneButton = app.navigationBars.buttons["Done"].firstMatch
        XCTAssertTrue(doneButton.waitForExistence(timeout: timeout))
        doneButton.tap()
        
        // Assert added note
        XCTAssertTrue(list.waitForExistence(timeout: timeout))
        XCTAssertEqual(Int(list.cells.count), noteCountBeforeAdding + 1)
        
        let lastCell = list.cells.element(boundBy: list.cells.count - 1)
        
        XCTAssertTrue(lastCell.staticTexts[addedNote].exists)
    }
}
