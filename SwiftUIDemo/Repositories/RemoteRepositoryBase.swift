//
//  RemoteRepositoryBase.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/14/26.
//

import Foundation
internal import CoreData

class RemoteRepositoryBase<Item: Codable> {
    
    private var authStatus: AuthStatus
    
    var implicitContext: NSManagedObjectContext? = nil
    
    init(authStatus: AuthStatus){
        self.authStatus = authStatus
    }
    
    func fetchAll(_ urlString: String) async throws -> [Item] {
        let request = try createRequest(urlString)
        //ultimately we will add authorization to this request
        let data = try await executeRequest(request)
        
        do {
            let decoder = JSONDecoder()
            if let context = implicitContext {
                decoder.userInfo[CodingUserInfoKey.managedObjectContext] = context
            }
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([Item].self, from: data)
        }
        catch {
            throw NetworkError.decoding(underlying: error)
        }
        
    }
    
    func fetchOne(_ urlString: String) async throws -> Item {
        
        let request = try createRequest(urlString)
        //ultimately we will add authorization to this request
        
        let data = try await executeRequest(request)
        
        do {
            let decoder = JSONDecoder()
            if let context = implicitContext {
                decoder.userInfo[CodingUserInfoKey.managedObjectContext] = context
            }
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Item.self, from: data)
        }
        catch {
            throw NetworkError.decoding(underlying: error)
        }
    }
    
    func post(_ urlString: String, send item: Item) async throws -> Item {
        
        var request = try createRequest(urlString)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //ultimately we will add authorization to this request
        
        do {
            request.httpBody = try JSONEncoder().encode(item)
        }
        catch{
            throw NetworkError.encodingFailed(underlying: error)
        }
            
        
        let data = try await executeRequest(request)
        
        do {
            let decoder = JSONDecoder()
            if let context = implicitContext {
                decoder.userInfo[CodingUserInfoKey.managedObjectContext] = context
            }
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Item.self, from: data)
        }
        catch {
            throw NetworkError.decoding(underlying: error)
        }
    }
    
    func put(_ urlString: String, send item: Item) async throws {
        
        var request = try createRequest(urlString)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //ultimately we will add authorization to this request
        
        do {
            request.httpBody = try JSONEncoder().encode(item)
        }
        catch{
            throw NetworkError.encodingFailed(underlying: error)
        }
            
        
        let _ = try await executeRequest(request)
        
    }
    
    func del(_ urlString: String) async throws {
        
        var request = try createRequest(urlString)
        request.httpMethod = "DELETE"
        
        let _ = try await executeRequest(request)
    }
    
    // MARK: - utility methods
    private func createRequest(_ urlString: String) throws -> URLRequest {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        guard let auth = authStatus.authToken, !auth.isEmpty else {
            throw NetworkError.missingAuthToken
        }
        
        request.setValue("Bearer \(auth)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    private func executeRequest(_ request: URLRequest, isRetry: Bool = false) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse else{
            throw NetworkError.badResponse(statusCode: -1)
        }
        
        guard (200...299).contains(http.statusCode) else {
            if http.statusCode == 401{
                //try to refresh authToken
                
                guard !isRetry, let refresh = authStatus.refreshToken, !refresh.isEmpty,let auth = authStatus.authToken, !auth.isEmpty else {
                    throw NetworkError.unauthorized
                }
                
                let refreshResult = try await AuthService.shared.refreshToken(authToken: auth, refreshToken: refresh)
                
                guard refreshResult.success else {
                    throw NetworkError.unauthorized
                }
                
                authStatus.updateLoginStatus(success: refreshResult.success, authToken: refreshResult.accessToken, refreshToken: refreshResult.refreshToken)
                
                //need to create a copy of the original request as it is a constant
                var newRerequest = request
                newRerequest.setValue("Bearer \(authStatus.authToken!)", forHTTPHeaderField: "Authorization")
                
                return try await executeRequest(newRerequest, isRetry: true)
            }
            throw NetworkError.badResponse(statusCode: http.statusCode)
        }
        
        return data
    }
    
}
