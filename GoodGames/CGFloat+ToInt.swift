//
//  CGFloat+ToInt.swift
//  GoodGames
//
//  Created by Jackson Secrist on 2/27/23.
//

import Foundation

extension CGFloat {
    func toInt() -> Int {
        if self >= CGFloat(Int.min) && self < CGFloat(Int.max) {
            return Int(self)
        } else {
            return 0
        }
    }
}
