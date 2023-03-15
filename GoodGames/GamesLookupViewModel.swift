//
//  GamesLookupViewModel.swift
//  GoodGames
//
//  Created by Adriana Cottle on 3/13/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class GamesLookupViewModel: ObservableObject {
    @Published var queriedGames: [Game] =  []
    
    private let db = Firestore.firestore()
    
    func fetchGames(from keyword: String) {
        db.collection("Games").whereField("keywordsForLookup", arrayContains: keyword).getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents, error == nil else { return }
            self.queriedGames = documents.compactMap {
                QueryDocumentSnapshot in
                try? QueryDocumentSnapshot.data(as: Game.self)
            }
        }
    }
}
