//
//  FilterGamesView.swift
//  GoodGames
//
//  Created by Adriana Cottle on 3/23/23.
//

import SwiftUI

struct FilterGamesByGenreView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @EnvironmentObject var userVM: UserViewModel
    
    let columns: [GridItem] = [
            GridItem(.fixed(100), spacing: 16),
            GridItem(.fixed(100), spacing: 16),
            GridItem(.fixed(100), spacing: 16)
        ]
    
    var genre: [String]
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                
                VStack {
                    Text("\(genre[0])")
                    if gameVM.filteredGamesGenres.count > 0 {
                        ScrollView {
                            LazyVGrid(columns: columns, alignment: .center, spacing: 16) {
                                ForEach(gameVM.filteredGamesGenres, id: \.id) { game in
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
                .onAppear {
                    gameVM.getFilteredGamesByGenresWith(matching: genre)
                }
                
                Spacer()
            }
        }
        .background(Color.primaryBackground)
    }
}

struct FilterGamesView_Previews: PreviewProvider {
    static var previews: some View {
        FilterGamesByGenreView(genre: ["Action"])
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
            .environmentObject(GamesLookupViewModel())
            .environment(\.colorScheme, .dark)
    }
}
