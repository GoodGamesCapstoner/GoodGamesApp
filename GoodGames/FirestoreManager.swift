//
//  FirestoreManager.swift
//  GoodGames
//
//  Created by Jackson Secrist on 1/24/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreManager: ObservableObject {
    
    //MARK: - Static Singleton
//    static let shared = FirestoreManager()
    
    //MARK: - Properties
    @Published var games: [Game] = []
    var firestore: Firestore
    
    //MARK: - Initializer
    init() {
        self.firestore = Firestore.firestore()
        
        fetchGames()
    }
    
    func fetchGames() {
        let collection = firestore.collection("games_test")
        print("We got the collection")
        collection.getDocuments { snapshot, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "Whoops! Something REALLY went wrong.")
                return
            }
            
            guard let documents = snapshot?.documents else {
                  print("No documents")
                  return
            }
                  
            self.games = documents.compactMap { queryDocumentSnapshot in
                print(queryDocumentSnapshot.data())
                return try? queryDocumentSnapshot.data(as: Game.self)
            }
            
//            if let snapshot {
//                for document in snapshot.documents {
//                    let docRef = collection.document(document.documentID)
//
//                    print("\(document.documentID) => \(document.data())")
//                    if let game = try? document.data(as: Game.self) {
//                        self.games.append(game)
//                    }
//                }
//            }
        }
    }
}
