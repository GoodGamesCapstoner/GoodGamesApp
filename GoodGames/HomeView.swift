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
                        .font(.title2)
                    
                    ExtendedGameCard()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
                
                HorizontalCarousel(label: "Your Squad") {
                    ForEach(0..<10) {_ in
                        UserCard()
                    }
                }
                .padding(.bottom)
                
                HorizontalCarousel(label: "Top Games for You") {
                    ForEach(0..<10) {
                        Text("Item \($0)")
                            .foregroundColor(.white)
                            .frame(width: 100, height: 150)
                            .background(.red)
                    }
                }
                
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
