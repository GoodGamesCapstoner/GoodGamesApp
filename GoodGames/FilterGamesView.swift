//
//  FilterGamesView.swift
//  GoodGames
//
//  Created by Adriana Cottle on 3/23/23.
//

import SwiftUI

struct FilterGamesView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @EnvironmentObject var userVM: UserViewModel
    
    let columns: [GridItem] = [
            GridItem(.fixed(100), spacing: 16),
            GridItem(.fixed(100), spacing: 16),
            GridItem(.fixed(100), spacing: 16)
        ]
    
    var genre: [String]
    
    var body: some View {
        VStack {
            Text("\(genre[0])")
            if gameVM.filteredGames.count > 0 {
                ScrollView {
                    LazyVGrid(columns: columns, alignment: .center, spacing: 16) {
                        ForEach(gameVM.filteredGames, id: \.id) { game in
                            GameCard(game: game)
                        }
                    }
                    .padding(.horizontal)
                }
            } else {
                LoadingSpinner()
            }
            Spacer()
        }
        .background(Color.primaryBackground)
        .foregroundColor(.white)
    }
}

struct FilterGamesView_Previews: PreviewProvider {
    static var previews: some View {
        FilterGamesView(genre: ["Action"])
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
            .environmentObject(GamesLookupViewModel())
            .environment(\.colorScheme, .dark)
    }
}
