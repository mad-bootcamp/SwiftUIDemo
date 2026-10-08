//
//  ProductList.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/18/26.
//

import SwiftUI

struct ProductList: View {
    
    @State private var viewModel = ViewModel()
    @Environment(\.productRepository) private var repository
    
    var body: some View {
        if !viewModel.errorMessage.isEmpty {
            Text("\(viewModel.errorMessage)")
                .font(.title)
        }
        switch viewModel.source {
        case .memory:
            Text("cached in memory")
        case .disk:
            Text("local disk cache")
        case .notcached:
            Text("fresh from API")
        }
        List(viewModel.items) { item in
            HStack {
                Text(item.name ?? "--")
                Spacer()
                Text("\(item.listPrice)")
            }
        }.task {
            await viewModel.loadData(repository: repository)
        }
    }
}

extension ProductList {
    
    @Observable
    class ViewModel {
        
        var items: [Product] = []
        var errorMessage: String = ""
        var source: CachedDataSource = .notcached
        
        func loadData(repository: (any TieredCachedRepositoryProtocol<Product>)?) async {
            guard let repository = repository else {
            errorMessage = "no repo"
                return }
            
            do{
                (items, source) = try await repository.getAll()
            }
            catch{
                errorMessage = "\(error)"
            }
            
        }
    }
}
