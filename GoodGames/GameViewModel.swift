//
//  GameDataViewModel.swift
//  GoodGames
//
//  Created by Jackson Secrist on 2/25/23.
//

import Foundation

class GameViewModel: ObservableObject {
    //MARK: Single Game
    @Published var game: Game?
    @Published var gameOfTheDay: Game?
    
    var isInShelf: Bool {
        if let game {
            return userShelf.contains(game)
        } else {
            return false
        }
    }
    
    //MARK: - Game Lists
    @Published var newReleases: [Game] = []
    @Published var topRated: [Game] = []
    @Published var mostReviewed: [Game] = []
    @Published var userShelf: [Game] = []
    @Published var relatedGames: [Game] = []
    @Published var recommendedGames: [Game] = []
    
    private let functionsManager = FunctionsManager()
    
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
    func selectGame(_ game: Game) {
        clearGameProfileCache()
        
        self.game = game
        getRelatedGames(for: game.appid)
    }
    
    func addCurrentGameToShelf(for user: User) {
        if let game = self.game {
            FirestoreManager.shared.addToShelf(for: user, game: game) { result in
                switch result {
                case .failure(let error):
                    print("Game not added to shelf with error: \(error.localizedDescription)")
                case .success(_):
                    print("Game added to shelf")
                }
            }
        }
    }
    
    func removeCurrentGameFromShelf(for user: User) {
        if let shelfGame = userShelf.first(where: { $0 == self.game }) {
            FirestoreManager.shared.removeFromShelf(for: user, game: shelfGame) { result in
                switch result {
                case .failure(let error):
                    print("Game not removed from shelf with error: \(error.localizedDescription)")
                case .success(_):
                    print("Game removed from shelf")
                }
            }
        }
    }
    
    //MARK: - Data Fetch Methods
    func getGame(forID uid: String) {
        FirestoreManager.shared.retrieveGame(forID: uid) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let game):
                self.game = game
            }
        }
    }
    
    func getNewReleases() {
        FirestoreManager.shared.retrieveNewReleases { (result) in
            self.handleGameListResult(result: result) { games in
                self.newReleases = games
            }
        }
    }
    
    func getTopRated() {
        FirestoreManager.shared.retrieveTopRated { (result) in
            self.handleGameListResult(result: result) { games in
                self.topRated = games
            }
        }
    }
    
    func getMostReviewed() {
        FirestoreManager.shared.retrieveMostReviewed(limit:20) { (result) in
            self.handleGameListResult(result: result) { games in
                self.mostReviewed = games
            }
        }
    }
    
    func getGameOfTheDay() {
        FirestoreManager.shared.retrieveMostReviewed(limit: 31) { (result) in
            self.handleGameListResult(result: result) { games in
                let today = Date()
                let calendar = Calendar.current
                let dateIndex =  calendar.component(.day, from: today)
                self.gameOfTheDay = games[dateIndex]
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
    
    func getShelfListener(for user: User) {
        FirestoreManager.shared.shelfListener(for: user) { (result) in
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
    }
}
