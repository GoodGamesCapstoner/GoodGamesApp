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
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .center, spacing: 16) {
                    ForEach(gameVM.newReleases, id: \.id) { game in
                        GameCard(game: game)
                    }
                }
                .padding(.horizontal)
            }
            Spacer()
        }
        .background(Color.primaryBackground)
        .foregroundColor(.white)
    }
}

struct FilterGamesView_Previews: PreviewProvider {
    static var previews: some View {
        FilterGamesView()
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
            .environmentObject(GamesLookupViewModel())
            .environment(\.colorScheme, .dark)
    }
}
