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
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    //MARK: - Hero Image
                    AsyncImage(url: URL(string: Constants.hero_url)) { image in
                        image.resizable()
                    } placeholder: {
                        //nothin yet
                    }
                    .edgesIgnoringSafeArea(.top)
                    .frame(width: geometry.size.width, height: geometry.size.width/2.1)
                    
                    //MARK: - Game Title
                    Text("Deep Rock Galactic")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top, 5)
                    
                    //MARK: - Main Page Content
                    VStack(alignment: .leading) {
                        //MARK: - Overall Rating
                        StarRating(rating: 4, outOf: 5)
                        .font(.title2)
                        .padding(.vertical, 5)
    //                    .padding(.horizontal, 10)
                        
                        Divider()
                        
                        //MARK: - Game Specs
                        let columns = [GridItem(.flexible()), GridItem(.flexible())]
                        LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                            Text("Genre: FPS, Looter/Shooter")
                            Text("Developer: Ghost Ship Games")
                            Text("Modes: Single-player, Co-op")
                            Text("Series: N/A")
                            Text("Platforms: ALL")
                            Text("Release Date: May 13, 2020")
                        }
                        Divider()
                        
                        //MARK: - Description
                        Text("Deep Rock Galactic is a 1-4 player co-op FPS featuring badass space Dwarves, 100% destructible environments, procedurally-generated caves, and endless hordes of alien monsters.")
                        Divider()
                        
                        //MARK: - Add to shelf button
                        HStack {
                            Spacer()
                            Button("Add to my shelf") {
                                
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.purple)
                            Spacer()
                        }
                        Divider()
                        //MARK: - Reviews
                        Group {
                            Text("Top Reviews: (536)")
                                .padding(.bottom, 5)
                            
                            //MARK: - Individual Review (Make Component?)
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Blackstone")
                                    StarRating(rating: 5, outOf: 5, .starsOnly)
                                }
                                Text("\"I dug a tunnel and fell down a hole and died. My friends followed me and also died. 10/10\"")
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 1)
                            }
                            .padding(.vertical, 10)
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Crash McDesktop")
                                    StarRating(rating: 5, outOf: 5, .starsOnly)
                                }
                                Text("\"DIG THE HOLE, HOLE DIGGER.\"")
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 1)
                            }
                            .padding(.vertical, 10)
                            
                        }
                        

                    }.padding(.horizontal)
                    Spacer()
                }
            }.edgesIgnoringSafeArea(.top)
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
