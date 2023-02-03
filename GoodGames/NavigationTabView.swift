//
//  NavigationTabView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/31/23.
//

import SwiftUI

struct NavigationTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            DiscoverView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Discover")
                }
            
            ShelfView()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("My Shelf")
                }
            
            UserProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
            
            DataTestView()
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Test Page")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTabView().environmentObject(FirestoreManager())
    }
}
