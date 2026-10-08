//
//  CachingExtensions.swift.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/18/26.
//


enum CachingConfigurationError: Error {
    case missingManagedObjectContext
}

enum DecoderConfigurationError: Error {
    case missingManagedObjectContext
}
extension CodingUserInfoKey {
    static let managedObjectContext: CodingUserInfoKey = .init(rawValue: "managedObjectContext")!
    
}
