//
//  IndividualRating.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/14/23.
//

import SwiftUI

struct IndividualReview: View {
    var review: Review
    var limitSize: Bool
    
    var maxHeight: CGFloat {
        return limitSize ? 75.0 : .infinity
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.secondaryBackground)
            VStack(alignment: .leading) {
                HStack {
                    Text("@\(review.username) said...").padding(.trailing, 5)
                    Spacer()
                    if review.inApp {
                        StarRating(rating: CGFloat(review.rating), outOf: 5, .starsOnly)
                    } else {
                        HStack {
                            Image(systemName: review.recommendedImage)
                                .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
                            Text(review.recommendedText)
                        }
                        .fixedSize(horizontal: true, vertical: false)
                        .foregroundColor(review.recommended ? Color.primaryAccent : .red)
                    }
                }
                .padding(.bottom, 5)
                Text("\"\(review.text)\"")
                    .frame(maxHeight: maxHeight)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 1)
                HStack {
                    Spacer()
                    Text("...on \(review.formattedDate) with \(review.hoursPlayed) hours played")
                        .font(.footnote)
                }
                if !review.inApp {
                    HStack {
                        Text("Review posted on Steam")
                            .font(.footnote)
                            .italic()
                            .padding(.top, 1)
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
        }
    }
}

struct IndividualRating_Previews: PreviewProvider {
    static let review = Review(
        appid: 0,
        creationDate: Date(),
        hoursPlayed: 17,
        inApp: false,
        rating: 4,
        ratingBool: 1,
        text: "I dug a tunnel and fell down a hole and died. My friends followed me and also died. I dug a tunnel and fell down a hole and died. My friends followed me and also died. I dug a tunnel and fell down a hole and died. My friends followed me and also died. I dug a tunnel and fell down a hole and died. My friends followed me and also died. I dug a tunnel and fell down a hole and died. My friends followed me and also died. 10/10",
        userid: "0", username: "rocketboy1244"
    )
    
    static var previews: some View {
        IndividualReview( review: review, limitSize: false)
        .foregroundColor(.white)
            .padding(.horizontal)
    }
}
