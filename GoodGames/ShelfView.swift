//
//  ShelfView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/31/23.
//

import SwiftUI

struct ShelfView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Text("My Shelf")
                    .font(.largeTitle)
                    .padding(.top)
                
                let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
                LazyVGrid(columns: columns) {
                    ForEach(gameVM.userShelf) { game in
                        GameCard(game: game, size: .larger)
                    }
                }
            }
            .onAppear {
//                if let user = userVM.user {
//                    if gameVM.userShelf.isEmpty {
//                        gameVM.getShelfListener(for: user)
//                    }
//                }
            }
        }
        .background(Color.primaryBackground)
        .foregroundColor(.white)
    }
}

struct ShelfView_Previews: PreviewProvider {
    static var previews: some View {
        ShelfView()
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
    }
}
