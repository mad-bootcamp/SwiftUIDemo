//
//  EmployeeList.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/8/26.
//

import SwiftUI

struct EmployeeList: View {
    
    @State private var employees: [Employee] = []
    
    var body: some View {
        NavigationStack {
            List(employees){ emp in
                NavigationLink(emp.lastName, value: emp)
            }
            .navigationTitle("Employees")
            .navigationDestination(for: Employee.self) {
                selectedItem in
                EmployeeDetails(employee: selectedItem)
            }
            .toolbar{
                Button(action: { }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("Add new employee")
            }
            
        }
        .task{
            loadData()
        }
    }
        
        func loadData() {
            employees = [
                Employee(id: 101, firstName: "Antonio", lastName: "Banderas"),
                Employee(id: 102, firstName: "Olivia", lastName: "Rodrigo"),
                Employee(id: 103, firstName: "Cleo", lastName: "Guerrero"),
                Employee(id: 104, firstName: "Daisy", lastName: "Arteaga"),
                Employee(id: 105, firstName: "Nana", lastName: "Garcia")
            ]
        }
    }

    
    #Preview {
        EmployeeList()
    }

