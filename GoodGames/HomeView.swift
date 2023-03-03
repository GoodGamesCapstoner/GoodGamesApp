//
//  HomeView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/31/23.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @EnvironmentObject var gdvm: GameViewModel
    @EnvironmentObject var userVM: UserViewModel

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    Text("GoodGames Home")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    
                    Text("Welcome, \(userVM.user?.name ?? "USER")!")
                        .font(.title3)
                        .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        Text("Game of the Day")
                            .font(.title2)
                        
                        if let game = gdvm.gameOfTheDay {
                            ExtendedGameCard(game:game)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                    
                    HorizontalCarousel(label: "Your Squad") {
                        ForEach(0..<10) {_ in
                            NavigationLink {
                                UserProfileView()
                            } label: {
                                UserCard()
                            }
                        }
                    }
                    .padding(.bottom)
                    
                    HorizontalCarousel(label: "Top Games for You") {
                        ForEach(0..<10) { num in
                            //GameCard(text: "Item \(num)", color: .blue)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .onAppear {
            gdvm.getGameOfTheDay()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
    }
}
