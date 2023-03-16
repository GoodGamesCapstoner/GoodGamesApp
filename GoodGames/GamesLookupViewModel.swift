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
        if keyword != "" && keyword.count > 2 {
            let query = db.collection("games")
                .whereField(Game.CodingKeys.name.rawValue, isGreaterThanOrEqualTo: keyword)
                .whereField(Game.CodingKeys.name.rawValue, isLessThanOrEqualTo: keyword + "\u{f7ff}")
            
            FirestoreManager.shared.retrieveGames(matching: query) { result in
                switch result {
                case .failure(let error):
                    print("Fetching games matching search query returned error: \(error.localizedDescription)")
                case .success(let games):
                    self.queriedGames = games
                }
            }
        } else {
            queriedGames = []
        }
//        db.collection("games").whereField("keywordsForLookup", arrayContains: keyword).getDocuments { querySnapshot, error in
//            guard let documents = querySnapshot?.documents, error == nil else { return }
//            self.queriedGames = documents.compactMap {
//                QueryDocumentSnapshot in
//                try? QueryDocumentSnapshot.data(as: Game.self)
//            }
//        }
    }
}
