//
//  ExtendedGameCard.swift
//  GoodGames
//
//  Created by Jackson Secrist on 2/15/23.
//

import SwiftUI

struct ExtendedGameCard: View {
    var game: Game
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(game.name)
                    .font(.headline)
                Spacer()
                Text(game.shortDescription)
                    .font(.footnote)
            }
            
            Spacer()
            
            GameCard(game:game)
        }
        .frame(maxWidth: 350, maxHeight: 150)
        .padding()
        .background(.gray)
        .cornerRadius(5)
    }
}

//struct ExtendedGameCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ExtendedGameCard()
//            .padding()
//    }
//}
