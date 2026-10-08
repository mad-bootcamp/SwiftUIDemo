//
//  EmployeeDetails.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/8/26.
//

import SwiftUI

struct EmployeeDetails: View {
    
    
    @State var employee: Employee
    
    @State private var colorIndex = 0
    
    @State private var scale = 1.0
    
    private let colors = [Color.blue, .red, .yellow, .orange, .green]
    
    var body: some View {
        @Bindable var empBinding = employee
        
        VStack {
            Text("\(employee.id)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .font(.title)
                .onTapGesture {
                    colorIndex = Int.random(in: 0..<colors.count)
                }
            TextField("First Name", text: $empBinding.firstName)
                    .font(Font.title)
                    .textFieldStyle(.roundedBorder)
                    .padding(20)
            TextField("Last Name", text: $empBinding.lastName)
                    .font(Font.title)
                    .textFieldStyle(.roundedBorder)
                    .padding(20)
            Image(systemName: "volleyball.fill")
                .foregroundColor(.blue)
                .frame(width: 80, height: 80)
                .scaleEffect(scale)
                .onAppear {
                    let baseAnimation = Animation.linear(duration: 1.3)
                    let repeatingAnimation = baseAnimation.repeatForever(autoreverses: true)
                    withAnimation(repeatingAnimation) {
                        scale = 2.0
                    }
                }
            }
        .padding()
        .background(colors[colorIndex].opacity(0.1))
        }
        
    }
    //no longer needed to load data since it will be handed to us 

#Preview {
    ContentView()
}
