//
//  EmployeeDetails.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/8/26.
//

import SwiftUI

struct EmployeeDetails: View {
    
    @State var employee: Employee
    
    var body: some View {
        @Bindable var empBinding = employee
        
        VStack {
            Text("\(employee.id)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .font(.title)
            TextField("First Name", text: $empBinding.firstName)
                    .font(Font.title)
                    .textFieldStyle(.roundedBorder)
                    .padding(20)
            TextField("Last Name", text: $empBinding.lastName)
                    .font(Font.title)
                    .textFieldStyle(.roundedBorder)
                    .padding(20)
            }
        .padding()
        }
        
    }
    //no longer needed to load data since it will be handed to us 

#Preview {
    ContentView()
}
