//
//  StarRating.swift
//  GoodGames
//
//  Created by Jackson Secrist on 2/14/23.
//

import SwiftUI

struct StarRating: View {
    var rating: CGFloat
    var maxRating: CGFloat
    var displayType: RatingDisplayType
    
    init(rating: CGFloat, outOf maxRating: CGFloat, _ displayType: RatingDisplayType = .normal) {
        self.rating = rating <= maxRating ? rating : maxRating
        self.maxRating = maxRating
        self.displayType = displayType
    }
    
    var numFullStars: Int {
        floor(rating).toInt()
    }
    var renderHalfStar: Bool {
        floor(rating) != rating
    }
    var numEmptyStars: Int {
        let diff = maxRating - (ceil(rating))
        return diff.toInt()
    }
    
    var ratingString: String {
        if renderHalfStar {
            return String(format: "%.1f", rating)
        } else {
            return String(format: "%.f", rating)
        }
        
    }
    var maxRatingString: String {
        String(format: "%.f", maxRating)
    }
    
    
    var body: some View {
        HStack {
            ForEach(0..<numFullStars, id: \.self) {_ in
                fullStar
            }
            if renderHalfStar {
                halfStar
            }
            ForEach(0..<numEmptyStars, id: \.self) {_ in
                emptyStar
            }
            
            
            if displayType == .normal {
                Text("\(ratingString) / \(maxRatingString)")
            }
            
        }
    }
    
    var fullStar: some View {
        Image(systemName: "star.fill")
            .foregroundColor(.yellow)
    }
    var halfStar: some View {
        Image(systemName: "star.leadinghalf.filled")
            .foregroundColor(.yellow)
    }
    var emptyStar: some View {
        Image(systemName: "star")
            .foregroundColor(.yellow)
    }
}

enum RatingDisplayType {
    case normal
    case starsOnly
}

struct StarRating_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StarRating(rating: 4.5, outOf: 5)
            Divider()
            StarRating(rating: 2.5, outOf: 5, .starsOnly)
        }
    }
}
