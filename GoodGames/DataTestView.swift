//
//  DataTestView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/20/23.
//

import SwiftUI

struct DataTestView: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    var body: some View {
        VStack {
            Text("Games")
            List {
                ForEach(firestoreManager.games) { game in
                    Text(game.name)
                }
            }
            Button {
                firestoreManager.fetchGames()
            } label: {
                Text("Fetch Games")
            }
            Spacer()
            if let user = firestoreManager.user {
                Text("User Fetched: \(user.firstName) \(user.lastName)")
                Text("Gamertag: \(user.username)")
            } else {
                Text("No user found.")
            }
            
        }
        

    }
}

struct DataTestView_Previews: PreviewProvider {
    static var previews: some View {
        DataTestView().environmentObject(FirestoreManager())
    }
}
