//
//  ArtistRepositoryKey.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/11/26.
//

//this is a key for the envronment object to store an artist repository for DI
//can keep all repo keys in the same file
import SwiftUI

struct ArtistRepositoryKey: EnvironmentKey {
    static let defaultValue: any RepositoryProtocol<Artist> = MockArtistRepository()
}

struct BoardMemberRepositoryKey: EnvironmentKey{
    static let defaultValue: any RepositoryProtocol<BoardMember> = MockBoardMemberRepository()
}

struct ProductRepositoryKey: EnvironmentKey{
    static let defaultValue: (any TieredCachedRepositoryProtocol<Product>)? = nil
}
