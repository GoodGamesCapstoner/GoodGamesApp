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
    @Published var user: User?
    var firestore: Firestore
    
    //MARK: - Initializer
    init() {
        self.firestore = Firestore.firestore()
        
        fetchGames() //fetches all games
        
        let userID = "EHsWEoPGamqAOTNzug0W"
        fetchUser(by: userID) { self.user = $0 } //fetches user with success/callback convention
    }
    
    func fetchGames() {
        let collection = firestore.collection("games_test")
        print("We got the collection")
        collection.getDocuments { snapshot, error in
            guard error == nil else {
                print(error as Any)
                return
            }
            
            guard let documents = snapshot?.documents else {
                  print("No documents")
                  return
            }
                  
            self.games = documents.compactMap { docSnapshot in
                print(docSnapshot.data())
                return try? docSnapshot.data(as: Game.self)
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
    
    func fetchUser(by documentID: String, success callback: @escaping(User) -> Void ){
        let collection = firestore.collection("users_test")
        let docRef = collection.document(documentID)
        
        docRef.getDocument { document, error in
            if let error {
                print(error)
            } else {
                if let document {
                    if let user = try? document.data(as: User.self) {
                        callback(user)
                    }
                }
            }
            
            
        }
    }
    
}
