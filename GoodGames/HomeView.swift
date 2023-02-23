//
//  HomeView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/31/23.
//

import SwiftUI

struct HomeView: View {
    @Binding var tabSelection: Int
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    Text("GoodGames Home")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    
                    Text("Welcome, rocketboy1244!")
                        .font(.title3)
                        .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        Text("Game of the Day")
                            .font(.title2)
                        
                        ExtendedGameCard()
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
                            GameCard(tabSelection: $tabSelection, text: "Item \(num)", color: .blue)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(tabSelection: .constant(1))
    }
}
