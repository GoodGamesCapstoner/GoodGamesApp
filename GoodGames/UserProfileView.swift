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
                VStack {
                    Text("\(userVM.user?.name ?? "No User Found")'s Profile")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top, 5)
                    
                    //MARK: - Profile Image & Details
                    HStack {
                        if userVM.isUserAuthenticated == .signedIn {
                            Button {
                                userVM.showSheet = true
                            } label: {
                                if let image = userVM.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .cornerRadius(50)
                                        .frame(width: 180, height: 180)
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                } else {
                                    Circle()
                                        .frame(width: 180, height: 180)
                                        .foregroundColor(.black)
                                }
                            }
                            // The idea is that if you're visiting someone else's profile page you won't be able
                            // to update their image but you can still see it. Not sure if it works or not.
                        } else {
                            if let image = userVM.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .cornerRadius(50)
                                    .frame(width: 180, height: 180)
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                            } else {
                                Circle()
                                    .frame(width: 180, height: 180)
                                    .foregroundColor(.black)
                            }
                        }
                        Spacer()
                            .frame(width: 15, height: 1)
                        //                    .ignoresSafeArea()
                        //                    .padding(.horizontal, 20)
                            .onChange(of: userVM.image, perform: { image in
                                userVM.image = image
                                userVM.saveProfileImage()
                            })
                            .sheet(isPresented: $userVM.showSheet) {
                                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$userVM.image)
                            }
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 10) {
                            VStack(alignment: .leading) {
                                Text("Name:")
                                    .font(.subheadline)
                                Text(userVM.user?.name ?? "No user found")
                                    .font(.title3)
                            }
                            VStack(alignment: .leading) {
                                Text("Email:")
                                    .font(.subheadline)
                                Text(userVM.user?.email ?? "No user found")
                                    .font(.title3)
                                    .lineLimit(1)
                            }
                            
                        }
                    }
                    .padding(.horizontal)
                    //MARK: - Followers Ribbon
                    let columns = [GridItem(.flexible()), GridItem(.flexible())]
                    
                    LazyVGrid(columns: columns) {
                        Text("Followers")
                            .font(.title3)
                        Text("Following")
                            .font(.title3)
                        Text("Coming soon")
                            .font(.subheadline)
                            .opacity(0.5)
                        Text("Coming Soon")
                            .font(.subheadline)
                            .opacity(0.5)
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "282828"))
                    .foregroundColor(.white)
                    
                    //MARK: - Logout/Delete Account Buttons
                    HStack {
                        if userVM.isUserAuthenticated == .signedIn {
    //                    if vm.user == nil {
                            Button {
                                userVM.logOut()
                            } label: {
                                Text("Log out")
                            }
                            .bold()
                            .buttonStyle(.bordered)
                        }
                        if userVM.isUserAuthenticated == .signedIn {
                            Button {
                                userVM.showDeletion.toggle()
                            } label: {
                                Text("Delete Account")
                                    .foregroundColor(.red)
                                    .buttonStyle(.borderless)
                            }
                            .buttonStyle(.bordered)
                            .sheet(isPresented: $userVM.showDeletion) {
                                DeleteView(user: userVM.user!)
                            }
                        }
                    }.padding(.vertical, 5)
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
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
            }
        }
        .onAppear {
            if gameVM.recommendedGames.isEmpty {
                if let user = userVM.user {
                    gameVM.getRecommendedGames(for: user)
                }
            }
            
            if let user = userVM.user {
                if gameVM.userShelf.isEmpty {
                    gameVM.getShelfListener(for: user)
                }
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
    }
}
