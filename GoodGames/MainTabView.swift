//
//  MainTabView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/31/23.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var gameVM: GameViewModel
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.grayGG)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.white)
    }
    
    var body: some View {
        TabView(selection: $gameVM.tabSelection) {
            Group {
                NavigationStack {
                    HomeView()
                }
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(TabSelection.home)
                
                NavigationStack {
                    DiscoverView()
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Discover")
                }.tag(TabSelection.discover)
                
                NavigationStack {
                    ShelfView()
                }
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("My Shelf")
                }.tag(TabSelection.shelf)
                
                NavigationStack {
                    UserProfileView()
                }
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }.tag(TabSelection.user)
            }
        }
        .accentColor(.purpleGG)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(UserViewModel())
            .environmentObject(GameViewModel())
            .environmentObject(GamesLookupViewModel())
            .environment(\.colorScheme, .dark)
    }
}
