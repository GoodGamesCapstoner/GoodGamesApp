//
//  IndividualRating.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/14/23.
//

import SwiftUI

struct IndividualReview: View {
    var review: Review
    var body: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: 5)
//                .foregroundColor(.purple)
            VStack(alignment: .leading) {
                HStack {
                    Text("@\(review.username) said...").padding(.trailing, 5)
                    Spacer()
                    StarRating(rating: CGFloat(review.rating), outOf: 5, .starsOnly)
                }
                .padding(.bottom, 5)
                Text("\"\(review.text)\"")
                    .padding(.horizontal, 15)
                    .padding(.vertical, 1)
                HStack {
                    Spacer()
                    Text("...on \(review.formattedDate) with \(review.hoursPlayed) hours played")
                        .font(.footnote)
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 5)
        }
    }
}

struct IndividualRating_Previews: PreviewProvider {
    static var previews: some View {
        IndividualReview( review:
            Review(
                appid: 0,
                creationDate: Date(),
                hoursPlayed: 17,
                inApp: true,
                rating: 4,
                ratingBool: 0,
                text: "I dug a tunnel and fell down a hole and died. My friends followed me and also died. 10/10",
                userid: "0", username: "Blackstone"
            )
        )
            .padding(.horizontal)
    }
}
