//
//  DiscoverView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/31/23.
//

import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        VStack {
            Text("Discovery")
                .font(.largeTitle)
                .padding(.top)

            ScrollView {
                NavigationLink {
                    SearchView()
                } label: {
                    FakeSearchBar()
                        .padding(.horizontal, 15)
                }
                
                VStack(alignment: .leading) {
                    HorizontalCarousel(label: "Recommended Games for You") {
                        ForEach(gameVM.recommendedGames, id: \.id) { game in
                            GameCard(game: game)
                        }
                    }
                    
                    HorizontalCarousel(label: "Top Rated") {
                        ForEach(gameVM.topRated, id: \.id) { game in
                            GameCard(game: game)
                        }
                    }
                    
                    HorizontalCarousel(label: "New Releases") {
                        ForEach(gameVM.newReleases, id: \.id) { game in
                            GameCard(game: game)
                        }
                    }
                    
                    HorizontalCarousel(label: "Most Reviewed") {
                        ForEach(gameVM.mostReviewed, id: \.id) { game in
                            GameCard(game: game)
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
        }
        .background(Color.grayGG)
        .foregroundColor(.white)
    }
}



struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
            .environmentObject(GamesLookupViewModel())
            .environment(\.colorScheme, .dark)
    }
}
