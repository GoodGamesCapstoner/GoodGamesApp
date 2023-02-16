//
//  UserProfileView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/31/23.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        VStack {
            Text("Deep Rock Galactic")
                .foregroundColor(.black)
                .font(.largeTitle)
                .background(.white)
                .padding(3)
                .border(.black, width: 3)
            HStack {
                Text("{profile pic}")
                VStack {
                    Text("@AtomicBlonde")
                    Text("Party")
                    Text("Ranking")
                }
            }
            HStack {
                VStack {
                    Text("Followers")
                    Text("14")
                }
                VStack {
                    Text("Following")
                    Text("10")
                }
                VStack {
                    Text("Hours played/Games owned")
                    Text("420")
                }
            }
            ScrollView {
                VStack(alignment: .leading) {
                    HorizontalCarousel(label: "Recently Played", color: .blue)
                    
                    HorizontalCarousel(label: "My Reviews", color: .green)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
