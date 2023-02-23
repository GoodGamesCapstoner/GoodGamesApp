//
//  NavigationTabView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/31/23.
//

import SwiftUI

struct NavigationTabView: View {
    @State private var tabSelection: Int = 1
    
    var body: some View {
//        NavigationStack {
            TabView(selection: $tabSelection) {
                HomeView(tabSelection: $tabSelection)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }.tag(1)
                
                DiscoverView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Discover")
                    }.tag(2)
                
                ShelfView()
                    .tabItem {
                        Image(systemName: "books.vertical")
                        Text("My Shelf")
                    }.tag(3)
                
                UserProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }.tag(4)
                
    //            DataTestView()
    //                .tabItem {
    //                    Image(systemName: "gamecontroller")
    //                    Text("Test Page")
    //                }
            }
//        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTabView().environmentObject(FirestoreManager())
    }
}
