//
//  EnvironmentExtensions.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/11/26.
//

import SwiftUI

extension EnvironmentValues {
    
    

        var artistRepository: any RepositoryProtocol<Artist> {
            
            get{self[ArtistRepositoryKey.self]}
            
            set{self[ArtistRepositoryKey.self] = newValue}
            
        }
    
    var boardMember: any RepositoryProtocol<BoardMember> {
        
            get{self[BoardMemberRepositoryKey.self]}
            
            set{self[BoardMemberRepositoryKey.self] = newValue}
    }
    
    var productRepository: (any TieredCachedRepositoryProtocol<Product>)? {
        
        get{self[ProductRepositoryKey.self]}
            
        set{self[ProductRepositoryKey.self] = newValue}
    }
    
    
}
