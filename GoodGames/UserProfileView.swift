//
//  UserProfileView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/31/23.
//

import SwiftUI
import FirebaseAuth

struct UserProfileView: View {
    @StateObject var vm = ViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Text("Adriana Cottle")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top, 5)
                HStack {
                    if vm.isUserAuthenticated == .signedIn {
                        Button {
                            vm.showSheet = true
                        } label: {
                            if let image = vm.image {
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
                        if let image = vm.image {
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
                        .onChange(of: vm.image, perform: { image in
                            vm.image = image
                            vm.saveProfileImage()
                        })
                        .sheet(isPresented: $vm.showSheet) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$vm.image)
                        }
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("@AtomicBlonde14")
                                .font(.title2)
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
            // Not working yet
//            .navigationTitle("User account")
            .toolbar {
                // Add log out button on the right
                ToolbarItem(placement: .navigationBarTrailing) {
                    // Changed this to match the deletion, but I'm not sure if that's right
                    // Its possible that the commented out one is just to check the user of the current
                    // profile and the one I'm using is to check who's logged in
                    if vm.isUserAuthenticated != .signedIn {
//                    if vm.user == nil {
                        Button {
                            vm.logOut()
                        } label: {
                            Text("Log Out")
                        }
                        .bold()
                        .buttonStyle(.bordered)
                    } else {
                        EmptyView()
                    }
                }
                // Add delete account button on the left
                ToolbarItem(placement: .navigationBarLeading) {
                    if vm.isUserAuthenticated != .signedIn {
                        Button {
                            vm.showDeletion.toggle()
                        } label: {
                            Text("Delete Account")
                                .foregroundColor(.red)
                                .buttonStyle(.borderless)
                        }
                        .buttonStyle(.bordered)
                        .sheet(isPresented: $vm.showDeletion) {
                            DeleteView(user: vm.user!)
                        }
                    }
                }

            }
            .onAppear {
                vm.configureFirebaseStateDidChange()
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
