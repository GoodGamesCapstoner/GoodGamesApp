//
//  UserCard.swift
//  GoodGames
//
//  Created by Jackson Secrist on 2/16/23.
//

import SwiftUI

struct UserCard: View {
    var body: some View {
        NavigationLink {
            UserProfileView()
        } label: {
            card
        }

    }
    
    var card: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: 75, height: 75)
                Circle()
                    .frame(width: 10)
                    .offset(CGSize(width: 0.0, height: 75.0/2))
                    .foregroundColor(.green)
            }
            
            Text("Username")
                .padding(.vertical, 5)
            Text("Current Game")
                .font(.footnote)
                .multilineTextAlignment(.center)
        }
        .foregroundColor(.black)
        .frame(maxWidth: 125, maxHeight: 150)
        .padding()
        .background(.gray)
        .cornerRadius(5)
    }
}

struct UserCard_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            UserCard()
        }
    }
}
