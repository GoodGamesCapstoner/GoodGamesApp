//
//  AllReviewsView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/14/23.
//

import SwiftUI

struct AllReviewsView: View {
    @EnvironmentObject var gameVM: GameViewModel
    var appid: Int
    
    var body: some View {
        ZStack {
            ScrollView {
                if let game = gameVM.cachedGames[appid], let reviews = gameVM.cachedReviews[appid] {
                    VStack(alignment: .leading) {
                        ForEach(reviews) { review in
                            IndividualReview(review: review)
                        }
                    }
                    .navigationTitle(Text("\(reviews.count) \(reviews.count <= 1 ? "review": "reviews") for \(game.name)"))
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .padding(.horizontal)
        }
        .background(Color.grayGG)
        
    }
}

//struct AllReviewsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllReviewsView()
//            .environment(\.colorScheme, .dark)
//    }
//}
