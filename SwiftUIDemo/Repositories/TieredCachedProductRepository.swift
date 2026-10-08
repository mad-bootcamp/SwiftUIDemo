//
//  TieredCachedProductRepository.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/18/26.
//

internal import CoreData

class TieredCachedProductRepository: TieredCachedRepositoryBase<Product> {
    
    override init(authStatus: AuthStatus, urlBase: String, context: NSManagedObjectContext) {
        
        let url = "\(urlBase)/product"
        
        super.init(authStatus: authStatus, urlBase: url, context: context)
    }
    
    
    
}
