//
//  TieredCachedRepository.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/18/26.
//


enum CachedDataSource {
    case memory
    case disk
    case notcached
}

protocol TieredCachedRepositoryProtocol<Item> {
    
    associatedtype Item: Identifiable, Codable
    
    func getAll() async throws -> ([Item], CachedDataSource)
    
    
}
