//
//  CheckoutCoordinator.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/10/26.
//
import SwiftUI

@Observable
class CheckoutCoordinator {
    
    var path: [CheckoutRoute] = []
    
    private(set) var address: ShippingAddress?
    private(set) var paymentMethod: PaymentMethod?
    private(set) var discountCode: String?
    
    func start() {
        
        path = [.address]
    }
    
    func didEnterAddress(_ address: ShippingAddress) {
        self.address = address
        path.append(.discount)
    }
    
    func didEnterPayment(_ paymentMethod: PaymentMethod) {
        self.paymentMethod = paymentMethod
        path.append(.review)
    }
    
    func didCompleteReview() {
        path.append(.confirmation)
    }
    
    func didEnterDiscountCode(_ code: String?) {
        self.discountCode = code
        path.append(.payment)
    }
    
}
