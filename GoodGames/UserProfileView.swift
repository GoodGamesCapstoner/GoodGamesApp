//
//  UserProfileView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/31/23.
//

import SwiftUI
import FirebaseAuth

struct UserProfileView: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("\(userVM.user?.firstName ?? "No user found") \(userVM.user?.lastName ?? "")")
                    .navigationBarTitle("@\(userVM.user?.username ?? "NULL")", displayMode: .inline)
                // Add settings button
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            menuButton
                        }
                    }
                VStack {
                    //MARK: - PFP, Followers, Following, and Shelf Ribbon
                    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
                    
                    HStack {
                        if userVM.isUserAuthenticated == .signedIn {
                            Button {
                                userVM.showSheet = true
                            } label: {
                                ZStack {
                                    if let image = userVM.image {
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
                                    
                                    VStack {
                                            Spacer()
                                            Image(systemName: "pencil.circle.fill")
                                                .foregroundColor(.black)
                                                .offset(CGSize(width: 0.0, height: 7.5))
                                        }
                                }
                            }
                        }
                        Spacer()
                            .frame(width: 15, height: 1)
                            .onChange(of: userVM.image, perform: { image in
                                userVM.image = image
                                userVM.saveProfileImage()
                            })
                            .sheet(isPresented: $userVM.showSheet) {
                                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$userVM.image)
                            }
                        LazyVGrid(columns: columns) {
                            Text("Shelf")
                                .font(.subheadline)
                            Text("Followers")
                                .font(.subheadline)
                            Text("Following")
                                .font(.subheadline)
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
                        .background(Color(hex: "282828"))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                    }
                    Spacer()
                    Divider()
                    
                    //MARK: - Shelf and Recommended Games
                    VStack(alignment: .leading) {
                        HorizontalCarousel(label: "Recommended Games for You") {
                            ForEach(gameVM.recommendedGames) { game in
                                GameCard(game: game)
                            }
                        }
                        
                        HorizontalCarousel(label: "My Shelf" ) {
                            ForEach(gameVM.userShelf) { game in
                                GameCard(game: game)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                .padding(.horizontal, 10)
            }
        }
        .navigationBarItems(trailing: menuButton)
        .onAppear {
            if gameVM.recommendedGames.isEmpty {
                if let user = userVM.user {
                    gameVM.getRecommendedGames(for: user)
                }
            }
            
            if let user = userVM.user {
                gameVM.getShelf(for: user)
            }
        }
    }
}

//MARK: - Button that takes the user to the settings page
var menuButton: some View {
    NavigationLink(destination: SettingsView()) {
        Image(systemName: "gearshape")
            .imageScale(.large)
            .foregroundColor(.black)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
    }
}
