//
//  NumberGenerator.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/9/23.
//

import Foundation


struct NumberGenerator: Sequence, IteratorProtocol {
    let maximum: Double
    let increment: Double
    var current: Double = 0.0
    
    init(maximum: Double, withIncrement increment: Double) {
        self.maximum = maximum
        self.increment = increment
    }
    
    mutating func next() -> Double? {
        current += increment
        
        return current <= maximum ? current : nil
    }
}
