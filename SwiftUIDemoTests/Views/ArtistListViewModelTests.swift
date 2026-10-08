//
//  ArtistListViewModelTests.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/17/26.
//

import Testing
@testable import SwiftUIDemo

struct ArtistListViewModelTests {
    
    
    @MainActor // run on main thread not background thread
    @Test func loadDataPopulatesArtistListFromRepository() async {
        
        let repo =  MockArtistRepository()
        let viewModel = ArtistList.ViewModel(repository: repo)
        
        await viewModel.loadArtists()
        
        #expect(viewModel.artists.count == 6)
    }
    
}
