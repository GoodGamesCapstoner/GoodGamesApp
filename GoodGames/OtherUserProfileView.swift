//
//  OtherUserProfileView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/28/23.
//

import SwiftUI

struct OtherUserProfileView: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var gameVM: GameViewModel
    @Environment(\.isPreview) var isPreview : Bool
    
    var userID: String
    
    var body: some View {
        NavigationStack {
            if let user = userVM.cachedUsers[userID] {
                ScrollView {
                    VStack {
                        //MARK: - PFP, Followers, Following, and Shelf Ribbon
                        let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
                        HStack {
                            if let image = userVM.cachedUserImages[userID] {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                
                            } else {
                                Circle()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.black)
                            }
                            Spacer()
                                .frame(width: 15, height: 1)
                            
                            VStack(spacing: 5) {
                                Text("\(user.firstName) \(user.lastName)")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                LazyVGrid(columns: columns) {
                                    Group {
                                        Text("Shelf")
                                        Text("Followers")
                                        Text("Following")
                                    }
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    Text("Coming Soon")
                                        .font(.footnote)
                                        .opacity(0.5)
                                    Text("Coming Soon")
                                        .font(.footnote)
                                        .opacity(0.5)
                                    Text("Coming Soon")
                                        .font(.footnote)
                                        .opacity(0.5)
                                }
                                .padding(10)
                                .background(Color.secondaryBackground)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .cornerRadius(10)
                            }
                        }
                        Spacer()
                        Divider()
                        
                        //MARK: - Shelf and Recommended Games
                        VStack(alignment: .leading) {
                            if let shelfGames = gameVM.cachedUserShelves[userID] {
                                HorizontalCarousel(label: "\(user.username)'s Shelf" ) {
                                    ForEach(shelfGames) { game in
                                        GameCard(game: game)
                                    }
                                }
                            } else {
                                Text("User has no games in their shelf.")
                                    .font(.title3)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                }
                .background(Color.primaryBackground)
                .foregroundColor(.white)
                // Add settings button
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("@\(user.username)")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
            }
        }
        .onAppear {
            if isPreview {
                userVM.fetchAndCacheUser(with: userID)
            }
        }
    }
}

struct OtherUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OtherUserProfileView(userID: "cnzI6I9Op0YYyvyUvEYk4mbrX2n2")
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
            .environment(\.isPreview, true)
            .environment(\.colorScheme, .dark)
    }
}
