//
//  ArtistList.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/10/26.
//

import SwiftUI

struct ArtistList: View{
    
    @State private var viewModel: ViewModel
    
    init(repository: any RepositoryProtocol<Artist>){
        viewModel = ViewModel(repository: repository)
    }
    
    var body: some View {
        VStack {
            BannerError(model: viewModel)
            HStack {
                Text("Filter")
                TextField("Genre", text: $viewModel.filter)
            }
            .padding()
            List(viewModel.matchingArtists) { artist in
                HStack{
                    Text(artist.name)
                    Text(" - ")
                    Text(artist.genre)
                }
                .onTapGesture {
                    self.viewModel.selectedArtist = artist
                }
            }
            if let selected = viewModel.selectedArtist{
                Text(selected.name)
                    .font(Font.largeTitle)
                AsyncImage(url: URL(string: "https://kazoopromotions.com/\(selected.imageUrl)")) { image in
                    image.resizable().scaledToFit()
                    
                } placeholder: {
                    ProgressView()
                }
            }
            
        }
        .task{
            await viewModel.loadArtists()
        }
    }
    
}

extension ArtistList {
    
    @Observable
    class ViewModel: Failable {
        
        private let repository: any RepositoryProtocol<Artist>
        
        init(repository: any RepositoryProtocol<Artist>) {
            self.repository = repository
        }
        var errorMessage: String = ""
         
        var artists: [Artist] = [] {
            didSet {
                filter = ""
                selectedArtist = nil
                
            }
        }
        var filter: String = "" {
            didSet{
                matchingArtists = artists.filter { artist in
                    filter == "" ||
                    artist.genre.lowercased().contains(filter.lowercased())
                }
            }
        } //when filter changes add side effect
        var matchingArtists: [Artist] = [] {
            didSet{
                if let selected = selectedArtist, !matchingArtists.contains(selected){
                    selectedArtist = nil
                }
            }
        }
        
        var selectedArtist: Artist? = nil
        
        func loadArtists() async {
            errorMessage = ""
            do{
                artists = try await repository.getAll()
            }
            catch {
                //handle error
                errorMessage = "\(error)"
            }
        }
        
    }
}


#Preview {
    ArtistList(repository: MockArtistRepository())
}
