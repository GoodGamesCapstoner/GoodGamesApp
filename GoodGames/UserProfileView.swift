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
        VStack {
            Text("Adriana Cottle")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.top, 5)
            HStack {
                AsyncImage(url: URL(string: Constants.profile_url)) { image in
                    image.resizable() }
                placeholder: {
                        //nothin yet
                    }
                .frame(width: 180.0, height: 180.0)
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
        .navigationTitle("User account")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if vm.user != nil {
                    Button {
                        vm.logOut()
                    } label: {
                        Text("Log Out")
                            .foregroundColor(.black)
                    }
                    .bold()
                    .buttonStyle(.bordered)
                } else {
                    EmptyView()
                }
            }
        }
        .onAppear {
            vm.configureFirebaseStateDidChange()
        }
    }
}

fileprivate struct Constants {
    static let profile_url: String = "https://wallpapers.com/images/hd/cute-retro-gaming-profile-xy3apbyc677bvcbl.jpg"
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
