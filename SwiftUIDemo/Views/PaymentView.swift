//
//  PaymentView.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/10/26.
//

import SwiftUI

struct PaymentView: View {
    
    @State private var payment: PaymentMethod = PaymentMethod(cardNumber: "", expDate: "", cvvCode: "")
    
    let done: (PaymentMethod) -> Void
    
    init(done: @escaping (PaymentMethod) -> Void){
        self.done = done
    }
    
    var body: some View {
        VStack {
            Text("Enter Payment Details")
                .font(.largeTitle.bold())
            
            //skip building the credit form
            TextField("Card Number", text: $payment.cardNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Expiration Date", text: $payment.expDate)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("CVV Code", text: $payment.cvvCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            
            Button("Cotninue"){
                done(payment)
            }
        }
        
    }
}
