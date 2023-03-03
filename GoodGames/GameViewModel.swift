//
//  GameDataViewModel.swift
//  GoodGames
//
//  Created by Jackson Secrist on 2/25/23.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var game: Game?
    @Published var newReleases: [Game] = []
    @Published var topRated: [Game] = []
    @Published var mostReviewed: [Game] = []
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
        self.game = game
    }
    
    func addCurrentGameToShelf(for user: User) {
        if let game = self.game {
            firestoreManager.addToShelf(for: user, game: game)
        }
    }
    
    func testRecommender() {
        functionsManager.testRecommender()
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
    
    //MARK: - Error Handler
    func handleGameListResult(result: Result<[Game], Error>, onSuccess: @escaping ([Game]) -> Void ) {
        switch result {
        case .failure(let error):
            print(error.localizedDescription)
        case .success(let games):
            onSuccess(games)
        }
    }
}
