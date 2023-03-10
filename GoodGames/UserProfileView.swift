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
                    Text("\(userVM.user?.username ?? "Null")")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top, 5)
                    
                    //MARK: - Profile Image & Details
                    HStack {
                        
//                        Spacer()
                        
//                        VStack(alignment: .leading, spacing: 10) {
//                            VStack(alignment: .leading) {
//                                Text("Name:")
//                                    .font(.subheadline)
//                                Text("\(userVM.user?.firstName ?? "No user found") \(userVM.user?.lastName ?? "")")
//                                    .font(.title3)
//                            }
//                            VStack(alignment: .leading) {
//                                Text("Email:")
//                                    .font(.subheadline)
//                                Text(userVM.user?.email ?? "No user found")
//                                    .font(.title3)
//                                    .lineLimit(1)
//                            }
//
//                        }
                    }
                    .padding(.horizontal)
                    //MARK: - Followers, Following, and Shelf Ribbon
                    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
                    
                    HStack {
                        if userVM.isUserAuthenticated == .signedIn {
                            Button {
                                userVM.showSheet = true
                            } label: {
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
                            Text("Followers")
                                .font(.subheadline)
                            Text("Following")
                                .font(.subheadline)
                            Text("Shelf")
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
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "282828"))
                        .foregroundColor(.white)
                    }
                    
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
//                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                .padding(.horizontal, 10)
            }
        }
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

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
    }
}
