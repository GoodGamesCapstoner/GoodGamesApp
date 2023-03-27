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
    
    @State var reviewSheetPresented = false

    var appID: Int

    var body: some View {
        VStack {
            HStack {
                Text("Discovery")
                    .font(.largeTitle)
                    .padding(.top)
                filterButton
                    .padding(.top)
            }

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
        .background(Color.primaryBackground)
        .foregroundColor(.white)
    }
    
    var filterButton: some View {
        Button {
            reviewSheetPresented.toggle()
        } label: {
            HStack{
                Text("Filter")
                Image(systemName: "line.3.horizontal.decrease.circle")
            }
        }
        .buttonStyle(.borderedProminent)
        .tint(Color.primaryAccent)
        .sheet(isPresented: $reviewSheetPresented) {
            //nothin
        } content: {
            SetFilterSheet(sheetIsPresented: $reviewSheetPresented)
                .environment(\.colorScheme, .dark)
        }
    }

}


struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView(appID: 251570)
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
            .environmentObject(GamesLookupViewModel())
            .environment(\.colorScheme, .dark)
    }
}
