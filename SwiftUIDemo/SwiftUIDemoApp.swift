//
//  SwiftUIDemoApp.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/8/26.
//

import SwiftUI
internal import CoreData

@main
struct SwiftUIDemoApp: App {
    
    let kazooAPIURL = "https://kazoopromotions.com/api"
    let awAPIURL = "https://api.bootcampcentral.com/api"
    @StateObject var authStatus = AuthStatus()
    
    let persistenceController = PersistenceController.shared
    
    
    var body: some Scene {
        WindowGroup {
            if authStatus.isLoggedIn {
                ContentView()
                
                //configure custom dependency injection
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environment(\.artistRepository, RemoteArtistRepository(urlBase: kazooAPIURL, authStatus: authStatus))
                    .environment(\.boardMember, RemoteBoardMemberRepository(urlBase: kazooAPIURL, authStatus: authStatus))
                    .environment(\.productRepository, TieredCachedProductRepository(authStatus: authStatus, urlBase: awAPIURL, context: persistenceController.container.viewContext))
                    .environmentObject(authStatus)
            }else {
                LoginView()
                    .environmentObject(authStatus)
            }
        }
    }
}
