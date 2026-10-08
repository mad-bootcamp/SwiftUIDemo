//
//  RepositoryProtocol.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/11/26.
//

protocol RepositoryProtocol<Item> {
    
    associatedtype Item: Identifiable, Codable
    
    func getAll() async throws -> [Item]
    func getById(_ id: Item.ID) async throws -> Item?   //someone could ask for any ID an we may not have that so could return nil
    func insert(_ item: Item) async throws -> Item
    func delete(_ item: Item) async throws
    func update(_ item: Item) async throws
    
    
    
}
