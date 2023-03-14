//
//  ReviewHelper.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/13/23.
//

import Foundation

struct ReviewHelper {
    var text = ""
    var rating = 0
    var hoursPlayed = "" {
        didSet {
            let filtered = hoursPlayed.filter { "0123456789".contains($0) }
            if filtered != hoursPlayed {
                hoursPlayed = filtered
            }
        }
    }
    
    var hoursPlayedInt: Int? {
        return Int(hoursPlayed)
    }
}
