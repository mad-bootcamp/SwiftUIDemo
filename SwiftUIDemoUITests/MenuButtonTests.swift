//
//  MenuButtonTests.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/18/26.
//

import XCTest

class MenuButtonTests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testEmployeeMenuLoadsEmployeeListView() throws {
        
        // the main menu (hamburger) button should exist
        let menuButton = app.buttons["mainMenuButton"]
        XCTAssertTrue(menuButton.waitForExistence(timeout: 2),
        "The main menu button should exist")
        
        menuButton.tap()

        // the employee view button should now exist
        let employeesButton = app.buttons["employeeViewButton"]
        XCTAssertTrue(employeesButton.waitForExistence(timeout: 2),
                      "The employee view button should exist")
        
        employeesButton.tap()
        
        //VALUAABLE line of code
//        print(app.debugDescription)
        
        //the employees view should now display
        let employeeView = app.collectionViews["employeeView"]
        XCTAssertTrue(employeeView.waitForExistence(timeout: 2),
        "The employee view should be visible")
    }
    
}

