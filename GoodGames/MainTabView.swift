//
//  MainTabView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/31/23.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var userVM: UserViewModel
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.secondaryBackground)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.white)
    }
    
    var body: some View {
        TabView(selection: $userVM.tabSelection) {
            Group {
                NavigationStack {
                    HomeView()
                }
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(1)
                
                NavigationStack {
                    DiscoverView()
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Discover")
                }.tag(2)
                
                NavigationStack {
                    ShelfView()
                }
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("My Shelf")
                }.tag(3)
                
                NavigationStack {
                    UserProfileView()
                }
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }.tag(4)
            }
//            .fontDesign(.monospaced)
        }
        .accentColor(.primaryAccent)
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
