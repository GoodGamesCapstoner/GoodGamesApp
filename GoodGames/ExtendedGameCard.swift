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
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
                Text(AttributedString(stringLiteral: game.shortDescription))
                    .font(.footnote)
                Spacer()
            }
            
            Spacer()
            
            GameCard(game:game)
        }
        .frame(maxWidth: 350, maxHeight: 150)
        .padding()
        .background(Color.secondaryBackground)
        .cornerRadius(5)
    }
}

//struct ExtendedGameCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ExtendedGameCard()
//            .padding()
//    }
//}
