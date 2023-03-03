//
//  UserProfileView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/31/23.
//

import SwiftUI
import FirebaseAuth

struct UserProfileView: View {
//    @StateObject var vm = ViewModel()
    @EnvironmentObject var userVM: UserViewModel
    var body: some View {
        NavigationView {
            VStack {
                Text("Adriana Cottle")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top, 5)
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
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            if let user = userVM.user {
                                Text("\(user.name)")
                                    .font(.title2)
                            } else {
                                Text("No user found")
                                    .font(.title2)
                            }
                            
                            Text("Active 3hr ago")
                                .font(.subheadline)
                        }
                        VStack(alignment: .leading) {
                            Text("Party")
                                .font(.title2)
                            Text("the bois")
                                .font(.subheadline)
                        }
                        VStack(alignment: .leading) {
                            Text("Ranking")
                                .font(.title2)
                            Text("n00b")
                                .font(.subheadline)
                        }
                    }
                }
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
                }
                HStack {
                    VStack {
                        Text("144")
                            .font(.title3)
                        Text("Followers")
                            .font(.title3)
                    }
                    .padding()
                    VStack {
                        Text("69")
                            .font(.title3)
                        Text("Following")
                            .font(.title3)
                    }
                    .padding()
                    VStack {
                        Text("420")
                            .font(.title3)
                        Text("Games owned")
                            .font(.title3)
                    }
                    .padding([.top, .bottom], 20)
                }
                .frame(maxWidth: .infinity)
                .background(.black)
                .foregroundColor(.white)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        HorizontalCarousel(label: "Recently Played") {
                            ForEach(0..<10) {
                                Text("Item \($0)")
                                    .foregroundColor(.white)
                                    .frame(width: 100, height: 150)
                                    .background(.blue)
                            }
                        }
                        
                        HorizontalCarousel(label: "My Reviews" ) {
                            ForEach(0..<10) {
                                Text("Item \($0)")
                                    .foregroundColor(.white)
                                    .frame(width: 100, height: 150)
                                    .background(.green)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Spacer()
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView().environmentObject(UserViewModel())
    }
}
