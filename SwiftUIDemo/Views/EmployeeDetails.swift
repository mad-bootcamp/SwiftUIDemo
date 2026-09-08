//
//  EmployeeDetails.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/8/26.
//

import SwiftUI

struct EmployeeDetails: View {
    
    @State private var employee: Employee?
    
    var body: some View {
        VStack {
            Text("\(employee?.id ?? 0)")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("\(employee?.firstName ?? "") \(employee?.lastName ?? "")")
                .font(.title)
            if let empBinding = Binding($employee) {
                TextField("First Name", text: empBinding.firstName)
                    .font(Font.title)
                    .textFieldStyle(.roundedBorder)
                    .padding(20)
                TextField("Last Name", text: empBinding.lastName)
                    .font(Font.title)
                    .textFieldStyle(.roundedBorder)
                    .padding(20)
            }
        }
        .padding()
        .task {
            loadData()
        }
    }
    
    func loadData() {
        employee = Employee(id: 572, firstName: "Antonio", lastName: "Banderas")
    }
}

#Preview {
    EmployeeDetails()
}
