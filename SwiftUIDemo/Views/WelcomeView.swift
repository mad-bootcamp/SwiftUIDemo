//
//  WelcomeView.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/14/26.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack{
            Text("Welcome to SwiftUI Demo")
                .fontDesign(Font.Design.rounded)
                .font(.largeTitle.bold())
                .padding()
                .multilineTextAlignment(.center)
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
                .background(Color.pink.opacity(0.1))
                .shadow(color: .red, radius: 10)
        }
    }
}
