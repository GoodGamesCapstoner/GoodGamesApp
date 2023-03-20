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
    
    var size: CardSize = .normal
    var body: some View {
        NavigationLink {
            GameProfileView(appID: game.appid)
        } label: {
            cardView
        }
        .simultaneousGesture(TapGesture().onEnded({
            gameVM.selectGame(game)
        }))
        
//        NavigationLink(value: "GameProfile \(game.appid)") {
//            cardView
//        }
//        .simultaneousGesture(TapGesture().onEnded({
//            gameVM.selectGame(game)
//        }))
    }
    
    var cardView: some View {
        AsyncImage(url: URL(string: game.cardImage)) { image in
            image.resizable()
        } placeholder: {
            PlaceholderCard(label: game.name)
        }
        .frame(width: size.getWidth(), height: size.getHeight())
        .cornerRadius(5)
    }
}

enum CardSize {
    case normal
    case larger
    
    func getWidth() -> CGFloat {
        switch self {
        case .normal:
            return 100
        case .larger:
            return 120
        }
    }
    
    func getHeight() -> CGFloat {
        return (self.getWidth() * CardAspect.ratio)
    }
}

struct CardAspect {
    static var ratio: CGFloat = 3.0/2.0
}
