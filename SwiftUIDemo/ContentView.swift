//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/8/26.
//

import SwiftUI


struct ContentView: View {
    
    @Environment(\.artistRepository) private var artistRepository
    @Environment(\.boardMember) private var boardMemberRepository
    @EnvironmentObject var authStatus: AuthStatus
    
    @State private var current: String = ""
    
    
    var body: some View {
        NavigationStack{
            VStack{
                switch current {
                case "artists":
                    ArtistList(repository: artistRepository)
                        .accessibilityIdentifier("artistView")
                case "board":
                    BoardMembersView(repository: boardMemberRepository)
                        .accessibilityIdentifier("boardView")
                case "employees":
                    EmployeeList()
                        .accessibilityIdentifier("employeeView")
                case "to do":
                    ToDoList()
                        .accessibilityIdentifier("toDoView")
                case "checkout":
                    CheckoutContainerView()
                        .accessibilityIdentifier("checkoutView")
                case "cats":
                    UrlDemo()
                        .accessibilityIdentifier("catsView")
                case "products":
                    ProductList()
                        .accessibilityIdentifier("productView")
                case "main":
                    WelcomeView()
                        .accessibilityIdentifier("welcomeView")
                default:
                    WelcomeView()
                        .accessibilityIdentifier("welcomeView")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Menu {
                        Button("Artists"){
                            current = "artists"
                        }
                        .accessibilityIdentifier("artistsViewButton")
                        
                        Button("Board Members"){
                            current = "board"
                        }
                        .accessibilityIdentifier("boardMemberViewButton")
                        Button("Employees"){
                            current = "employees"
                        }
                        .accessibilityIdentifier("employeeViewButton")
                        Button("To do list"){
                            current = "to do"
                        }
                        .accessibilityIdentifier("toDoViewButton")
                        Divider()
                        Button("Checkout"){
                            current = "checkout"
                        }
                        .accessibilityIdentifier("checkoutViewButton")
                        Divider()
                        Button("Cats"){
                            current = "cats"
                        }
                        .accessibilityIdentifier("catsViewButton")
                        Divider()
                        Button("Main"){
                        current = "main"
                        }
                        .accessibilityIdentifier("mainViewButton")
                        Divider()
                        Button("Products"){
                            current = "products"
                        }
                        .accessibilityIdentifier("productsViewButton")
                        Divider()
                        Button("Log Out"){
                            authStatus.updateLoginStatus(success: false)
                        }
                        .accessibilityIdentifier("logOutViewButton")
                    }
                    label: {
                        Label("View", systemImage: "line.3.horizontal")
                    }
                    .accessibilityIdentifier("mainMenuButton")
                }
            }
        }



    }
}

#Preview {
    ContentView()
}
