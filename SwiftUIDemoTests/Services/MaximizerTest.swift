//
//  MaximizerTest.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/17/26.
//

import Testing

@testable import SwiftUIDemo

struct MaximizerTest {
    
    @Test func findMax_largestIsFirst() {
        
        // Arrange 
        let maximizer = Maximizer()
        
        // Act
        let result = maximizer.findMax(x: 10, y: 2, z: 3)
        
        // Assert
        #expect(result == 10)
    }
    
    @Test func findMax_largestIsSecond() {
        
        // Arrange
        let maximizer = Maximizer()
        
        // Act
        let result = maximizer.findMax(x: 20, y: 30, z: 10)
        
        // Assert
        #expect(result == 30)
    }
    
    @Test func findMax_largestIsLast() {
        
        // Arrange
        let maximizer = Maximizer()
        
        // Act
        let result = maximizer.findMax(x: 10, y: 20, z: 30)
        
        // Assert
        #expect(result == 30)
    }
    
    @Test func findMax_AllSame() {
        
        // Arrange
        let maximizer = Maximizer()
        
        // Act
        let result = maximizer.findMax(x: 10, y: 10, z: 10)
        
        // Assert
        #expect(result == 10)
    }
    
    
    @Test func findMax_largestIsMiddle_smallestFirst() {
        
        // Arrange
        let maximizer = Maximizer()
        
        // Act
        let result = maximizer.findMax(x: 1, y: 20, z: 3)
        
        // Assert
        #expect(result == 20)
    }
    
}
