//
//  JSONDecoderExtensions.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/15/26.
//
//any time you come across an object you wish had a certain behavior you can add an extension with that behavior!!
import Foundation

extension JSONDecoder {
    
    func useStringDecoderForDate() {
        
        self.dateDecodingStrategy = .custom { decoder in
            
            let container = try decoder.singleValueContainer()
            
            
            guard let stringValue = try? container.decode(String.self) else {
                return Date.distantPast
            }
            
            
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            
            guard let date = dateFormatter.date(from: stringValue) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid ISO 8601 date: \(stringValue)")
            
            }
            return date
        }
        
    }
    
}
