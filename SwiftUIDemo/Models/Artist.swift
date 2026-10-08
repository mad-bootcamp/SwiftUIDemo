//
//  Artist.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/10/26.
//

import SwiftUI

class Artist: Identifiable, Hashable, Codable {
    let id: Int
    var name: String
    var genre: String
    var location: String
    var imageUrl: String
    var description: String
    var tags: String
    
    init(id: Int, name: String, genre: String, location: String, imageUrl: String, description: String, tags: String) {
        self.id = id
        self.name = name
        self.genre = genre
        self.location = location
        self.imageUrl = imageUrl
        self.description = description
        self.tags = tags
    }
    
    static func == (lhs: Artist, rhs: Artist) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
