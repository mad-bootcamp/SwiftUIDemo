//
//  cachedRemoteRepositoryBase.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/17/26.
//

import Foundation
class CachedRemoteRepositoryBase<Item: Codable>: RemoteRepositoryBase<Item> {
    
    private let memoryCache = NSCache<NSString, CacheBox>()
    private let cacheKeyPrefix = String(describing: Item.self)
    private let maxAge: TimeInterval = 15 * 60.0
    
    var hits = 0
    var misses = 0
    
    override init(authStatus: AuthStatus) {
        memoryCache.countLimit = 100
        memoryCache.totalCostLimit = 20 * 1024 * 1024 //20mb
        
        super.init(authStatus: authStatus)
    }
    
    //MARK: - fetchAll override
    override func fetchAll(_ urlString: String) async throws -> [Item] {
        
        let now = Date()
        let key = NSString(string: cacheKeyPrefix + urlString)
        
        //try to satisfy the request from cache
        if let  box = memoryCache.object(forKey: key) {
            
            let age = now.timeIntervalSince(box.timestamp)
            if age <= maxAge, let decoded = try? JSONDecoder().decode([Item].self, from: box.payload) {
                // we can satisfy this request from cache
                print("we had a cache hit \(urlString), age: \(age.rounded()) min")
                hits += 1
                return decoded
            }
        }
        //could not satisfy the request from memory cache so make actual api call
        let result = try await super.fetchAll(urlString)
        
        let payload = try JSONEncoder().encode(result)
        let box = CacheBox(payload: payload, timestamp: now)
        memoryCache.setObject(box, forKey: key, cost: payload.count)
        
        print("[CACHE MISS] \(urlString)")
        misses += 1
        
        return result
        
    }
    
}
