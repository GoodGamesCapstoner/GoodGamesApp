//
//  GameProfile.swift
//  GoodGames
//
//  Created by Jackson Secrist on 2/3/23.
//

import SwiftUI

struct GameProfileView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @EnvironmentObject var userVM: UserViewModel
    @Environment(\.isPreview) var isPreview

    var body: some View {
        GeometryReader { geometry in
            if let game = gameVM.game {
                ScrollView {
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
                        Text("\(game.name)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                            .padding(.top, 5)

                        //MARK: - Main Page Content
                        VStack(alignment: .leading) {
                            //MARK: - Overall Rating
                            StarRating(rating: game.calculatedRating, outOf: game.maxRating)
                            .font(.title2)
                            .padding(.vertical, 10)

                            Divider()

                            //MARK: - Description
                            Text(game.shortDescription)
                            
                            Divider()
                            //MARK: - Game Specs
                            let columns = [GridItem(.fixed(geometry.size.width/3), alignment: .topLeading), GridItem(.flexible(), alignment: .topLeading)]
                            LazyVGrid(columns: columns, spacing: 10) {
                                Text("Genres:").fontWeight(.bold)
                                Text(game.formattedGenres)
                                Text("Developer:").fontWeight(.bold)
                                Text(game.developer)
                                Text("Publisher:").fontWeight(.bold)
                                Text(game.publisher)
                                Text("Platforms:").fontWeight(.bold)
                                Text(game.platform)
                                Text("Release Date: ").fontWeight(.bold) //NEEDS WORK (DATE FORMATTER)
                                Text(game.formattedReleaseDate)
                            }
                            Divider()

                            

                            //MARK: - Add to shelf button
                            HStack {
                                Spacer()
                                Button("Add to my shelf") {
                                    if let user = userVM.user {
                                        gameVM.addCurrentGameToShelf(for: user)
                                    }
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
                .edgesIgnoringSafeArea(.top)
            }
        }
        .onAppear {
            if isPreview{
                gameVM.getGame(forID: "mbbWBhgLflnfTLrJIWhv")
            }
        }

    }
}

//fileprivate struct Constants {
//    static let hero_url: String = "https://cdn.cloudflare.steamstatic.com/steam/apps/548430/header.jpg"
//
//    //"https://cdn2.steamgriddb.com/file/sgdb-cdn/thumb/e5520e0a26c349b166bb72c155a54d21.jpg"
//}

struct GameProfileView_Previews: PreviewProvider {
    static var previews: some View {
        GameProfileView()
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
            .environment(\.isPreview, true)
    }
}
