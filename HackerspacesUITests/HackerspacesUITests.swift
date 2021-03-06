//
//  HackerspacesUITests.swift
//  HackerspacesUITests
//
//  Created by zephyz on 15.08.17.
//  Copyright © 2017 Fixme. All rights reserved.
//

import XCTest

class HackerspacesUITests: XCTestCase {

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        let app = XCUIApplication()
        app.launchArguments = ["UI-TESTING"]
        app.launch()
    }


    
    func testFavortieToggle() {
        let app = XCUIApplication()
        app.tabBars.buttons["Search"].tap()
        var firstChild = app.cells.element(boundBy: 0)
        if firstChild.exists {
            firstChild.tap()
        } else {
            XCTFail("no element found in collection view")
        }

        app.navigationBars["Hackerspaces.SelectedHackerspaceTableView"].children(matching: .button).element(boundBy: 1).tap()
        app.tabBars.buttons["Favorites"].tap()
        firstChild = app.cells.element(boundBy: 0)
        if firstChild.exists {
            firstChild.tap()
        }

        firstChild = app.cells.element(boundBy: 0)
        app.navigationBars["Favorites"].children(matching: .button).element(boundBy: 1).tap()
        app.navigationBars["Favorites"].buttons["Favorites"].tap()

        if firstChild.exists {
            print(firstChild)
            XCTFail("favorite list should be empty after unfavorite")
        }
    }

    func testSearchBar() {
        let app = XCUIApplication()
        app.tabBars.buttons["Search"].tap()
        app.searchFields["Search"].tap()
        app.searchFields["Search"].typeText("open")
        let firstChild = app.cells.element(boundBy: 0)
        if firstChild.exists {
            firstChild.tap()
        }
        let open = XCUIApplication().staticTexts.element(matching: .any, identifier: "hackerspace status").label
        XCTAssertEqual(open, "Open")

    }

}
