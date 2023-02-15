//
//  StarRating.swift
//  GoodGames
//
//  Created by Jackson Secrist on 2/14/23.
//

import SwiftUI

struct StarRating: View {
    var rating: Int
    var maxRating: Int
    var displayType: RatingDisplayType
    
    init(rating: Int, outOf maxRating: Int, _ displayType: RatingDisplayType = .normal) {
        self.rating = rating <= maxRating ? rating : maxRating
        self.maxRating = maxRating
        self.displayType = displayType
    }
    
    var body: some View {
        HStack {
            ForEach(0..<rating, id: \.self) {_ in
                Text("★").foregroundColor(.yellow)
            }
            ForEach(rating..<maxRating, id: \.self) {_ in
                Text("☆").foregroundColor(.black)
            }
            if displayType == .normal {
                Text("\(rating) / \(maxRating)")
            }
            
        }
    }
}

enum RatingDisplayType {
    case normal
    case starsOnly
}

struct StarRating_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StarRating(rating: 4, outOf: 5)
            Divider()
            StarRating(rating: 2, outOf: 5, .starsOnly)
        }
    }
}
