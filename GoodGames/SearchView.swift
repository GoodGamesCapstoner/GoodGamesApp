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
enum SearchType {
    case games, users
    
    var tabImageName: String {
        switch self {
        case .games:
            return "gamecontroller.fill"
        case .users:
            return "person"
        }
    }
    
    var tabDisplayText: String {
        switch self {
        case .games:
            return "Games"
        case .users:
            return "Users"
        }
    }
}

struct SearchView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var lookupVM: GamesLookupViewModel
    
    @FocusState private var focus: FocusableField?
    
    @State private var searchType: SearchType = .games
    
    @State var searchString: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Search")
                    .font(.title)
                    .padding(.top, 5)
                
                SearchBar(searchString: $searchString)
                    .focused($focus, equals: .search)
                    .padding(.horizontal, 15)
                    .onChange(of: searchString) { input in
                        performSearch(input)
                    }
                
                HStack(spacing: 0) {
                    SearchTab(selectedTab: $searchType, type: .games, width: geometry.size.width/2.0)
                    SearchTab(selectedTab: $searchType, type: .users, width: geometry.size.width/2.0)
                }
                .onChange(of: searchType) { _ in
                    self.searchString = ""
                }
                
                ScrollView {
                    if searchType == .games {
                        if searchString != "" && lookupVM.queriedGames.count > 0 {
                            ForEach(lookupVM.queriedGames, id: \.id) { game in
                                GameSearchResult(game: game)
                                
                                if game != lookupVM.queriedGames.last {
                                    Divider()
                                }
                            }
                        } else {
                            Text("No game results yet.")
                                .font(.title2)
                                .padding(.top)
                        }
                    } else {
                        if searchString != "" && userVM.queriedUsers.count > 0 {
                            ForEach(userVM.queriedUsers, id: \.uid) { user in
                                UserSearchResult(user: user)
                            }
                        } else {
                            Text("No user results yet.")
                                .font(.title2)
                                .padding(.top)
                        }
                    }
                }
            }
            .background(Color.primaryBackground)
            .onAppear {
                self.focus = .search
                
                performSearch(searchString)
            }
        }
    }
    
    func performSearch(_ input: String) {
        if searchType == .games {
            print("Searching GAMES for: \(input)")
            lookupVM.fetchGames(from: input)
        } else {
            print("Searching USERS for: \(input)")
            userVM.fetchUsers(matching: input)
        }
    }
}

struct SearchTab: View {
    @Binding var selectedTab: SearchType
    var type: SearchType
    var width: CGFloat
    
    var selected: Bool {
        return selectedTab == type
    }
    
    var body: some View {
        Button {
            selectedTab = type
        } label: {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: type.tabImageName)
                        .foregroundColor(.white)
                    
                    Text(type.tabDisplayText)
                        .font(Font.system(size: 18, weight: .semibold))
                        .foregroundColor(Color.white)
                }
                .frame(width: width, height: 40)
                Rectangle().fill(selected ? Color.white : Color.clear)
                    .frame(height: 3)
            }
            .fixedSize()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
            .environmentObject(GamesLookupViewModel())
            .environment(\.colorScheme, .dark)
    }
}
