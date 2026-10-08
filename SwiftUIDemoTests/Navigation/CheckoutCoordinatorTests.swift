//
//  CheckoutCoordinatorTests.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/17/26.
//
import Testing
@testable import SwiftUIDemo

class CheckoutCoordinatorTests {
    
    let cut: CheckoutCoordinator
    
    init(){
        // run before each test
        cut = CheckoutCoordinator()
    }
    
    deinit {
        // this code wil run after each test
    }
    
    
    @Test func currentScreenShouldBeDiscountAfterAdress() throws {
        // Arrange
        let address = ShippingAddress(shipTo: "", street: "", city: "", state: "", zip: "")
        
        // Act
        cut.didEnterAddress(address)
        
        // Assert
        let currentScreen = try #require(cut.path.last)
        //#require will attempt unwrapping and fail the test if nil
        #expect(currentScreen == .discount)
        
    }
    
    @Test func shouldBeAbleToMarkDiscountComplete() {
        
        let code = "SAVE10"
        
        #expect(throws: Never.self, "Marking discount code complete should not fail") {
            try cut.didEnterDiscountCode(code)
        }
    }
    
    @Test func shouldStoreDiscountCodeWhenComplete() {
        let code = "SAVE10"
        
        cut.didEnterDiscountCode(code)
        
        #expect(cut.discountCode == code)
    }
    
    @Test func currentScreenShouldBePaymentAfterDiscount() throws {
        let code = "SAVE10"
        
        cut.didEnterDiscountCode(code)
        
        // Assert
        let currentScreen = try #require(cut.path.last) // is something there
        //#require will attempt unwrapping and fail the test if nil
        #expect(currentScreen == .payment)
    }
    
    @Test func canCompleteDiscountCodeWithNilValue() throws {
        let code: String? = nil
        
        cut.didEnterDiscountCode(code)
        
        // Assert
        let currentScreen = try #require(cut.path.last) // is something there
        //#require will attempt unwrapping and fail the test if nil
        #expect(currentScreen == .payment)
    }
    
    
}
