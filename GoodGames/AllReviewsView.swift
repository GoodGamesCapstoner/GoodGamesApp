//
//  AllReviewsView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/14/23.
//

import SwiftUI

struct AllReviewsView: View {
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        ScrollView {
            if let game = gameVM.game {
                VStack(alignment: .leading) {
                    ForEach(gameVM.reviewsForGame) { review in
                        IndividualRating(review: review)
                    }
                }
                .navigationTitle(Text("\(gameVM.reviewsForGame.count) \(gameVM.reviewsForGame.count <= 1 ? "review": "reviews") for \(game.name)"))
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .padding(.horizontal)
    }
}

struct AllReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        AllReviewsView()
    }
}
