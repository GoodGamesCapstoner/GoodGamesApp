//
//  FilterGamesByCategory.swift
//  GoodGames
//
//  Created by Adriana Cottle on 3/31/23.
//

import SwiftUI

struct FilterGamesByCategory: View {
    @EnvironmentObject var gameVM: GameViewModel
    @EnvironmentObject var userVM: UserViewModel
    
    let columns: [GridItem] = [
            GridItem(.fixed(100), spacing: 16),
            GridItem(.fixed(100), spacing: 16),
            GridItem(.fixed(100), spacing: 16)
        ]
    
    var category: [String]
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                
                VStack {
                    Text("\(category[0])")
                    if gameVM.filteredGamesCategories.count > 0 {
                        ScrollView {
                            LazyVGrid(columns: columns, alignment: .center, spacing: 16) {
                                ForEach(gameVM.filteredGamesCategories, id: \.id) { game in
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
                    gameVM.getFilteredGamesByCategoryWith(matching: category)
                }
                
                Spacer()
            }
        }
        .background(Color.primaryBackground)
    }
}

struct FilterGamesByCategory_Previews: PreviewProvider {
    static var previews: some View {
        FilterGamesByCategory(category: ["PvP"])
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
            .environmentObject(GamesLookupViewModel())
            .environment(\.colorScheme, .dark)
    }
}
