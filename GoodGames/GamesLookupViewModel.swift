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
    @Published var queriedGames: [Game] =  [] {
        didSet {
            print(queriedGames.count)
        }
    }
    
    private let db = Firestore.firestore()
    
    func fetchGames(from keyword: String) {
        if keyword != "" && keyword.count > 2 {
            let loweredInput = keyword.lowercased()
            let query = db.collection("games")
                .whereField(Game.CodingKeys.searchList.rawValue, arrayContains: loweredInput)
            
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
    }
}
