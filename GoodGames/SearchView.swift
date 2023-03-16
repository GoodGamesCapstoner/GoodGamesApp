//
//  SearchView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/15/23.
//

import SwiftUI

enum FocusableField: Hashable {
    case search
}

struct SearchView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @EnvironmentObject var lookupVM: GamesLookupViewModel
    
    @FocusState private var focus: FocusableField?
    
    @State var searchString: String = "" 
    var body: some View {
        VStack {
            Text("Search")
                .font(.title)
                .padding(.top, 5)
            
            SearchBar(searchString: $searchString)
                .focused($focus, equals: .search)
                .padding(.horizontal, 15)
                .onChange(of: searchString) { newValue in
                    print("Search term is: \(newValue)")
                    lookupVM.fetchGames(from: newValue)
                }
            
            ScrollView {
                if lookupVM.queriedGames.count > 0 {
                    ForEach(lookupVM.queriedGames, id: \.id) { game in
                        SearchResult(game: game)
                        
                        if game != lookupVM.queriedGames.last {
                            Divider()
                        }
                    }
                } else {
                    Text("No results yet.")
                        .font(.title2)
                        .padding(.top)
                }
            }
        }
        .background(Color.grayGG)
        .onAppear {
            self.focus = .search
            
//            lookupVM.fetchGames(from: searchString)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(GameViewModel())
            .environmentObject(GamesLookupViewModel())
            .environment(\.colorScheme, .dark)
    }
}
