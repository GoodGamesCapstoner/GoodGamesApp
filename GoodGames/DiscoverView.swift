//
//  DiscoverView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/31/23.
//

import SwiftUI

struct DiscoverView: View {
    @State var searchString: String = ""
    @EnvironmentObject var gameVM: GameViewModel
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var gamesLookupVM: GamesLookupViewModel
    
    var body: some View {
//        let keywordBinding = Binding<String>(
//            get: {
//                searchString
//            },
//            set: { newValue in
//                searchString = newValue
//                gamesLookupVM.fetchGames(from: searchString)
//            }
//        )

        
        VStack {
            Text("Discovery")
                .font(.largeTitle)
                .padding(.top)
            
            SearchBar(searchString: $searchString)
                .padding(.leading, 15)
                .padding(.trailing, 15)
            ScrollView {
                ForEach(gamesLookupVM.queriedGames, id: \.appid) { game in
                    GameProfileBarView(game: game)
                }
            }.onChange(of: searchString) { newValue in
                gamesLookupVM.fetchGames(from: newValue)
            }
                
            Spacer()
            ScrollView {
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
        .onAppear {
//            if gameVM.recommendedGames.isEmpty {
//                if let user = userVM.user {
//                    gameVM.getRecommendedGames(for: user)
//                }
//            }
//            if gameVM.newReleases.isEmpty {
//                gameVM.getNewReleases()
//            }
//            if gameVM.topRated.isEmpty {
//                gameVM.getTopRated()
//            }
//            if gameVM.mostReviewed.isEmpty {
//                gameVM.getMostReviewed()
//            }
        }
    }
}

struct SearchBar: View {
    @Binding var searchString: String
    var body: some View {
        HStack {
                Image(systemName: "magnifyingglass").foregroundColor(.gray)
                TextField("Search", text: $searchString)
                    .font(Font.system(size: 21))
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
            }
            .padding(7)
            .background(Color(.systemGray6))
            .cornerRadius(50)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
            .environmentObject(GamesLookupViewModel())
    }
}

struct GameProfileBarView: View {
    var game: Game
    
    var body: some View {
        HStack {
            Text("\(game.name)")
        }
        .frame(maxWidth: .infinity, minHeight: .infinity)
    }
}
