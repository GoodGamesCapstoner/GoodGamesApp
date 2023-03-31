//
//  UserSearchResult.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/28/23.
//

import SwiftUI

struct UserSearchResult: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var gameVM: GameViewModel
    
    var user: User
    
    var body: some View {
        NavigationLink {
            OtherUserProfileView(userID: user.uid)
        } label: {
            HStack {
                Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50)
                
                VStack(alignment: .leading) {
                    Text(user.username)
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                    Text("\(user.firstName) \(user.lastName)")
                        .font(.body)
                        .multilineTextAlignment(.leading)
//                        .foregroundColor(.white)
                }
                .padding(.leading, 10)
                Spacer()
            }
            .padding(.horizontal)
        }
        .simultaneousGesture(TapGesture().onEnded({
            userVM.selectUser(user)
            gameVM.fetchAndCacheShelf(for: user)
        }))
    }
}

struct UserSearchResult_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchResult(user: User(uid: "userid", email: "email@email.com", username: "myusername", firstName: "Firstname", lastName: "Lastname"))
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
            .environment(\.colorScheme, .dark)
    }
}
