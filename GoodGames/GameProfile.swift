//
//  GameProfile.swift
//  GoodGames
//
//  Created by Jackson Secrist on 2/3/23.
//

import SwiftUI

struct GameProfile: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                AsyncImage(url: URL(string: Constants.hero_url)) { image in
                    image.resizable()
                } placeholder: {
                    //nothin yet
                }
                .edgesIgnoringSafeArea(.top)
                .frame(width: geometry.size.width, height: geometry.size.width/2.75)
                
                Text("Deep Rock Galactic")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(3)
                
                VStack(alignment: .leading) {
                    HStack {
                        ForEach(0..<4) {_ in
                            Text("★").foregroundColor(.yellow)
                        }
                        Text("☆").foregroundColor(.black)
                        Text("4 / 5")
                    }
                    .font(.title2)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    
                    Divider()
                    
                    let columns = [GridItem(.flexible()), GridItem(.flexible())]
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                        Text("Genre: FPS, Looter/Shooter")
                        Text("Developer: Ghost Ship Games")
                        Text("Modes: Single-player, Co-op")
                        Text("Series: N/A")
                        Text("Platforms: ALL")
                        Text("Release Date: May 13, 2020")
                    }
                    
                    Text("Deep Rock Galactic is a 1-4 player co-op FPS featuring badass space Dwarves, 100% destructible environments, procedurally-generated caves, and endless hordes of alien monsters.")
                }.padding(.horizontal)
                Spacer()
            }
        }
        
    }
}

fileprivate struct Constants {
    static let hero_url: String = "https://cdn.cloudflare.steamstatic.com/steam/apps/548430/header.jpg"
    
    //"https://cdn2.steamgriddb.com/file/sgdb-cdn/thumb/e5520e0a26c349b166bb72c155a54d21.jpg"
}

struct GameProfile_Previews: PreviewProvider {
    static var previews: some View {
        GameProfile()
    }
}
