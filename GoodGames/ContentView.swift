//
//  ContentView.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/20/23.
//

import SwiftUI

struct ContentView: View {
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
        }
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(FirestoreManager())
    }
}
