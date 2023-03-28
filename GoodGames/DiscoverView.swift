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
    
    @State var filterSheetPresented = false

    var appID: Int

    var body: some View {
        VStack {
            Text("Discovery")
                .font(.largeTitle)
                .padding(.top)

            ScrollView {
                
                HStack {
                    NavigationLink {
                        SearchView()
                    } label: {
                        FakeSearchBar()
                            .padding(.leading, 15)
                    }
                    filterButton
                        .padding(.trailing, 15)
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
            filterSheetPresented.toggle()
        } label: {
            HStack{
                Image(systemName: "slider.horizontal.3")
                    .padding(.vertical, 5)
            }
        }
        .buttonStyle(.borderedProminent)
        .tint(Color.primaryAccent)
        .sheet(isPresented: $filterSheetPresented) {
        } content: {
            SetFilterSheet(sheetIsPresented: $filterSheetPresented)
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
