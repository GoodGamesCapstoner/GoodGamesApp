//
//  SearchResult.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/15/23.
//

import SwiftUI

struct GameSearchResult: View {
    @EnvironmentObject var gameVM: GameViewModel
    var game: Game
    var body: some View {
        NavigationLink {
            GameProfileView(appID: game.appid)
        } label: {
            HStack {
                AsyncImage(url: URL(string: game.headerImage)) { image in
                    image.resizable()
                } placeholder: {
                    //nothin yet
                }
                .scaledToFit()
                .frame(width: 150)
                
                Text(game.name)
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.horizontal)
        }
        .simultaneousGesture(TapGesture().onEnded({
            gameVM.selectGame(game)
        }))
        
    }
}

//struct GameSearchResult_Previews: PreviewProvider {
//    static var previews: some View {
//        GameSearchResult(game: Game(aboutTheGame: "", appid: 1, categories: "", detailedDescription: "", developer: "", dlc: true, genre: "", headerImage: "https://cdn.akamai.steamstatic.com/steam/apps/203160/header.jpg?t=1675712321", languages: "", name: "The Elder Scrolls V: Skyrim", platform: "", priceAdj: "", publisher: "", releaseDate: Date(), reviewScore: 1,searchList: "", screenshots: "", shortDescription: "", tags: "", totalReviews: 1))
//            .padding()
//            .environmentObject(GameViewModel())
//            .environment(\.colorScheme, .dark)
//    }
//}
