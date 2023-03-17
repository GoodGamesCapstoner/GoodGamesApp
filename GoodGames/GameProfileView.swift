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
    
    @State var shelfActionLoading = false
    
    @State var reviewSheetPresented = false
    
    var addRemoveShelfButtons: some View {
        HStack {
            Spacer()
            if !gameVM.isInShelf {
                if !shelfActionLoading {
                    Button {
                        if let user = userVM.user {
                            self.shelfActionLoading = true
                            gameVM.addCurrentGameToShelf(for: user)
                        }
                    } label: {
                        HStack {
                            Text("Add to my shelf")
                            Image(systemName: "bookmark.fill")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.primaryAccent)
                } else{
                    Text("Adding to shelf...")
                        .fontWeight(.bold)
                        .onDisappear {
                            self.shelfActionLoading = false
                        }
                }
            } else {
                if !shelfActionLoading {
                    Button {
                        if let user = userVM.user {
                            self.shelfActionLoading = true
                            gameVM.removeCurrentGameFromShelf(for: user)
                        }
                    } label: {
                        HStack {
                            Text("Remove from my shelf")
                            Image(systemName: "bookmark.slash.fill")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.primaryAccent)
                } else {
                    Text("Removing from shelf...")
                        .fontWeight(.bold)
                        .onDisappear {
                            self.shelfActionLoading = false
                        }
                }
            }
            

            Spacer()
        }
    }
    
    var reviewButton: some View {
        Button {
            gameVM.reviewSavedSuccessfully = false
            reviewSheetPresented.toggle()
        } label: {
            HStack {
                Text("Write a Review")
                Image(systemName: "star.bubble.fill")
            }
        }
        .buttonStyle(.borderedProminent)
        .tint(Color.primaryAccent)
        .sheet(isPresented: $reviewSheetPresented) {
            //nothin
        } content: {
            AddReviewSheet(sheetIsPresented: $reviewSheetPresented)
                .environment(\.colorScheme, .dark)
        }
    }

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
                            
                            Group {
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
                            }

                            

                            //MARK: - Add to shelf button
                            addRemoveShelfButtons
                            Divider()
                            
                            //MARK: - Reviews
                            Group {
                                Text("Top Reviews for \(game.name):")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .padding(.vertical, 5)
                                
                                if gameVM.reviewsForGame.count > 0 {
                                    VStack(alignment: .leading) {
                                        ForEach(gameVM.reviewsForGame.prefix(3)) { review in
                                            IndividualReview(review: review)
                                        }
                                    }
                                    
                                    HStack {
                                        reviewButton
                                        
                                        Spacer()
                                        
                                        NavigationLink {
                                            AllReviewsView()
                                        } label: {
                                            HStack {
                                                Text("All reviews (\(gameVM.reviewsForGame.count))")
                                                Image(systemName: "arrowshape.right.fill")
                                            }
                                        }
                                    }
                                } else {
                                    VStack {
                                        Text("There are no reviews yet.")
                                    }
                                    
                                    HStack {
                                        Spacer()
                                        reviewButton
                                        Spacer()
                                    }
                                }
                                
                                Divider()
                            }

                            //MARK: - Similar Games
                            Group {
                                HorizontalCarousel(label: "Similar Games to \(game.name)") {
                                    ForEach(gameVM.relatedGames) { game in
                                        GameCard(game: game)
                                    }
                                }
                            }
                        }.padding(.horizontal)
                        Spacer()
                    }
                }
                .edgesIgnoringSafeArea(.top)
            }
        }
        .background(Color.primaryBackground)
        .onAppear {
            if isPreview{
                gameVM.getGame(forID: "mbbWBhgLflnfTLrJIWhv")
            }
        }
    }
}


struct GameProfileView_Previews: PreviewProvider {
    static var previews: some View {
        GameProfileView()
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
            .environment(\.isPreview, true)
            .environment(\.colorScheme, .dark)
    }
}
