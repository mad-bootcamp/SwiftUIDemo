//
//  Maximizer.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/17/26.
//

struct Maximizer {
    
    func findMax(x: Int, y: Int, z: Int) -> Int {
        var max = x
        if y > max {
            max = y
        }
        if z > max {
            max = z
        }
        
        return max
    }
    
}
