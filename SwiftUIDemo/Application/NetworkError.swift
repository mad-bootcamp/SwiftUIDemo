//
//  NetworkError.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/14/26.
//

enum NetworkError: Error {
    case invalidURL
    case noConnection
    case badResponse(statusCode: Int)
    case encodingFailed(underlying: Error)
    case decoding(underlying: Error)
    case unauthorized
    case missingAuthToken
}
