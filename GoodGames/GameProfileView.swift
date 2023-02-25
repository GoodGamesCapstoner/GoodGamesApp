//
//  GameProfile.swift
//  GoodGames
//
//  Created by Jackson Secrist on 2/3/23.
//

import SwiftUI

struct GameProfileView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                if let game = viewModel.game {
                    VStack(alignment: .leading, spacing: 0) {
                        //MARK: - Hero Image
                        AsyncImage(url: URL(string: game.headerImage)) { image in
                            image.resizable()
                        } placeholder: {
                            //nothin yet
                        }
                        .edgesIgnoringSafeArea(.top)
                        .frame(width: geometry.size.width, height: geometry.size.width/2.1)
                        
                        //MARK: - Game Title
                        Text("\(game.nameX)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                            .padding(.top, 5)
                        
                        //MARK: - Main Page Content
                        VStack(alignment: .leading) {
                            //MARK: - Overall Rating
                            StarRating(rating: game.reviewScore, outOf: 10)
                            .font(.title2)
                            .padding(.vertical, 5)
                            
                            Divider()
                            
                            //MARK: - Game Specs
                            let columns = [GridItem(.flexible()), GridItem(.flexible())]
                            LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                                Text("Genre: \(game.genre)")
                                Text("Developer: \(game.developer)")
                                Text("Modes: Single-player, Co-op")
                                    .foregroundColor(.red)
                                Text("Series: N/A")
                                    .foregroundColor(.red)
                                Text("Platforms: \(game.platform)")
                                Text("Release Date: ") //NEEDS WORK (DATE FORMATTER)
                                    .foregroundColor(.blue)
                            }
                            Divider()
                            
                            //MARK: - Description
                            Text(game.shortDescription)
                            Divider()
                            
                            //MARK: - Add to shelf button
                            HStack {
                                Spacer()
                                Button("Add to my shelf") {
                                    viewModel.tabSelection = 3
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(.purple)
                                
                                Spacer()
                            }
                            Divider()
                            //MARK: - Reviews
                            Group {
                                Text("Top Reviews: (\(game.totalReviews))")
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
                }
            }.edgesIgnoringSafeArea(.top)
        }
        .onAppear {
            viewModel.getGame(forID: "mbbWBhgLflnfTLrJIWhv")
        }
        
    }
}

fileprivate struct Constants {
    static let hero_url: String = "https://cdn.cloudflare.steamstatic.com/steam/apps/548430/header.jpg"
    
    //"https://cdn2.steamgriddb.com/file/sgdb-cdn/thumb/e5520e0a26c349b166bb72c155a54d21.jpg"
}

struct GameProfileView_Previews: PreviewProvider {
    static var previews: some View {
        GameProfileView().environmentObject(ViewModel())
    }
}
