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
                                            ZStack {
                                                Circle()
                                                    .foregroundColor(.white)
                                                    .frame(width: 29, height: 29)
                                                Image(systemName: "square.and.pencil.circle.fill")
                                                    .resizable()
                                                    .foregroundColor(Color.primaryAccent)
                                                    .frame(width: 30, height: 30)
                                            }
                                            
//                                            .cornerRadius(100)
                                            .offset(CGSize(width: 40.0, height: 0))
                                            
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
                        VStack(spacing: 5) {
                            Text("\(userVM.user?.firstName ?? "No user found") \(userVM.user?.lastName ?? "")")
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
                        if gameVM.recommendedGames.count > 0{
                            HorizontalCarousel(label: "Recommended Games for You") {
                                ForEach(gameVM.recommendedGames) { game in
                                    GameCard(game: game)
                                }
                            }
                        } else {
                            VStack {
                                HStack {
                                    Text("Recommended Games for You")
                                        .font(.title2)
                                    Spacer()
                                }
                                LoadingSpinner()
                            }
                        }
                        
                        HorizontalCarousel(label: "My Shelf" ) {
                            ForEach(gameVM.userShelf) { game in
                                GameCard(game: game)
                            }
                        }
                        
                        if let user = userVM.user, let reviews = gameVM.cachedUserReviews[user.uid] {
                            Text("My Reviews")
                                .font(.title2)
                                .multilineTextAlignment(.leading)
                                .padding(.top, 10)
                            ScrollView {
                                ForEach(reviews) { review in
                                    IndividualReview(review: review, limitSize: true, displayGameName: true)
                                }
                            }
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
                    Text("@\(userVM.user?.username ?? "NULL")")
                        .font(.title)
                        .fontWeight(.bold)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    menuButton
                }
            }
        }
    }
}

//MARK: - Button that takes the user to the settings page
var menuButton: some View {
    NavigationLink(destination: SettingsView()) {
        Image(systemName: "gearshape.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 25)
            .foregroundColor(.primaryAccent)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
            .environment(\.colorScheme, .dark)
    }
}
