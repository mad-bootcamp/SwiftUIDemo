//
//  ReviewOrderView.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/10/26.
//

import SwiftUI

struct ReviewOrderView: View {
    
    let address: ShippingAddress
    let payment: PaymentMethod
    let done: () -> Void
    
    init(address: ShippingAddress, payment: PaymentMethod, done: @escaping () -> Void) {
        self.address = address
        self.payment = payment
        self.done = done
    }
    
 
        
    var body: some View {
        VStack {
            Text("Review your order")
                .font(Font.largeTitle.bold())
            
            //display address and payment details
            Text("Shipping Adress")
                .font(.title)
            
            Text(address.street)
            Text(address.city)
            Text(address.state)
            Text(address.zip)
            
            Text("Payment Method")
                .font(.title)
            Text(payment.cardNumber)
            Text(payment.expDate)
            
            Button("Confirm"){
                done()
            }
        }
        
    }
}
