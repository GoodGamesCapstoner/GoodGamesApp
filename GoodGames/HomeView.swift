//
//  HomeView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/31/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            ScrollView {
                Text("GoodGames Home")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                Text("Welcome, rocketboy1244!")
                    .font(.title3)
                    .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("Game of the Day")
                        .font(.title)
                    
                    ExtendedGameCard()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("Your Squad")
                        .font(.title)
                    
                    ExtendedGameCard()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
