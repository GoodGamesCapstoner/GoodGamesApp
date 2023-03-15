//
//  StarRatingInteractive.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/13/23.
//

import SwiftUI

struct StarRatingInteractive: View {
    @Binding var rating: Int

    var label = ""

    var maximumRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }
}

struct StarRatingInteractive_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingInteractive(rating: .constant(4))
    }
}
