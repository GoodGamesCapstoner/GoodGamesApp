//
//  GameDataViewModel.swift
//  GoodGames
//
//  Created by Jackson Secrist on 2/25/23.
//

import SwiftUI

class GameViewModel: ObservableObject {
    //MARK: Single Game
    @Published var game: Game?
    @Published var isInShelf: Bool = false
    
    //MARK: - Game Lists
    @Published var newReleases: [Game] = []
    @Published var topRated: [Game] = []
    @Published var mostReviewed: [Game] = []
    @Published var userShelf: [Game] = []
    @Published var relatedGames: [Game] = []
    @Published var recommendedGames: [Game] = []
    private let firestoreManager = FirestoreManager()
    private let functionsManager = FunctionsManager()
    
//    public static let previewVM = GameViewModel()
    
    //MARK: - Initializer
    init() {
        if newReleases.isEmpty {
            self.getNewReleases()
        }
        if topRated.isEmpty {
            self.getTopRated()
        }
        if mostReviewed.isEmpty {
            self.getMostReviewed()
        }
    }
    
    //MARK: - User Intents
    //not sure if this method should re-fetch from the database for data to be refreshed? we'll see
    func selectGame(_ game: Game) {
        clearGameProfileCache()
        
        self.game = game
        self.isInShelf = userShelf.contains(game)
        print("Is game in shelf? \(self.isInShelf)")
        getRelatedGames(for: game.appid)
    }
    
    func addCurrentGameToShelf(for user: User) {
        if let game = self.game {
            firestoreManager.addToShelf(for: user, game: game) { result in
                switch result {
                case .failure(let error):
                    print("Game not added to shelf with error: \(error.localizedDescription)")
                case .success(let game):
                    print("Game added to shelf")
                    self.userShelf.append(game)
                    self.isInShelf = true
                }
            }
        }
    }
    
    //MARK: - Data Fetch Methods
    func getGame(forID uid: String) {
        firestoreManager.retrieveGame(forID: uid) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let game):
                self.game = game
            }
        }
    }
    
    func getNewReleases() {
        firestoreManager.retrieveNewReleases { (result) in
            self.handleGameListResult(result: result) { games in
                self.newReleases = games
            }
        }
    }
    
    func getTopRated() {
        firestoreManager.retrieveTopRated { (result) in
            self.handleGameListResult(result: result) { games in
                self.topRated = games
            }
        }
    }
    
    func getMostReviewed() {
        firestoreManager.retrieveMostReviewed { (result) in
            self.handleGameListResult(result: result) { games in
                self.mostReviewed = games
            }
        }
    }
    
    func getRelatedGames(for appid: Int) {
        functionsManager.getGamesRelated(to: appid) { result in
            self.handleGameListResult(result: result) { games in
                self.relatedGames = games
            }
        }
    }
    
    func getRecommendedGames(for user: User) {
        functionsManager.getRecommendedGames(for: user) { result in
            self.handleGameListResult(result: result) { games in
                self.recommendedGames = games
            }
        }
    }
    
    //MARK: - Shelf Methods
    
    func getShelf(for user: User) {
        firestoreManager.retrieveShelf(for: user) { (result) in
            self.handleGameListResult(result: result) { games in
                self.userShelf = games
            }
        }
    }
    
    //MARK: - Error Handler
    private func handleGameListResult(result: Result<[Game], Error>, onSuccess: @escaping ([Game]) -> Void ) {
        switch result {
        case .failure(let error):
            print(error.localizedDescription)
        case .success(let games):
            onSuccess(games)
        }
    }
    
    //MARK: - Cleanup Methods
    
    func clearGameProfileCache() {
        self.game = nil
        self.relatedGames = []
        self.isInShelf = false
    }
}
