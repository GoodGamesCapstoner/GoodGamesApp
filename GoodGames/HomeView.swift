//
//  HomeView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/31/23.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @EnvironmentObject var userVM: UserViewModel

    var body: some View {
        VStack {
            ScrollView {
                Text("GoodGames Home")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                Text("Welcome, \(userVM.user?.username ?? "USERNAME NOT SET/FOUND")!")
                    .font(.title3)
                    .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("Game of the Day")
                        .font(.title2)
                    
                    if let game = gameVM.gameOfTheDay {
                        ExtendedGameCard(game:game)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
                
                HStack {
                    Text("Your Squad (Coming Soon)")
                        .font(.title2)
                    Spacer()
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.secondaryBackground)
                        .opacity(1)
                    Text("These awesome features will be here soon!")
                        .font(.title3)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                if gameVM.recommendedGames.count > 0{
                    HorizontalCarousel(label: "Recommended Games for You") {
                        ForEach(gameVM.recommendedGames) { game in
                            GameCard(game: game)
                        }
                    }
                } else {
                    VStack {
                        HStack {
                            Text("Recommended Games for You")
                                .font(.title2)
                            Spacer()
                        }
                        LoadingSpinner()
                    }
                }
            }

        }
        .padding()
        .background(Color.primaryBackground)
    }
        
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
            .environment(\.colorScheme, .dark)
            
    }
}
