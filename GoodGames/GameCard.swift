//
//  GameCard.swift
//  GoodGames
//
//  Created by Jackson Secrist on 2/22/23.
//

import SwiftUI
import FirebaseFirestore

struct GameCard: View {
    @EnvironmentObject var gameVM: GameViewModel
    var game: Game
    var body: some View {
        NavigationLink {
            GameProfileView()
        } label: {
            AsyncImage(url: URL(string: game.cardImage)) { image in
                image.resizable()
            } placeholder: {
                Text(game.name)
                    .foregroundColor(.white)
                    .frame(width: 100, height: 150)
                    .background(.gray)
            }
            .frame(width: 100, height: 150)
        }
        .simultaneousGesture(TapGesture().onEnded({
            gameVM.selectGame(game)
        }))
    }
}

//struct GameCard_Previews: PreviewProvider {
//    static var previews: some View {
//        let fm = FirestoreManager()
//        NavigationStack {
//            GameCard(game: GameViewModel.previewVM.game)
//        }
//    }
//}
