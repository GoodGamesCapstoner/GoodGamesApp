//
//  TimeoutGenerator.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/9/23.
//

import Foundation


struct TimeoutGenerator {
    private let timeout: Double
    private let repetitions: Int
    private var currentIteration: Int = 0
    
    init(timeout: Double, repeat repetitions: Int) {
        self.timeout = timeout
        self.repetitions = repetitions
    }
    
    mutating func next() -> Double? {
        currentIteration += 1
        
        return currentIteration < repetitions ? timeout : nil
    }
    
    mutating func reset() {
        currentIteration = 0
    }
}
