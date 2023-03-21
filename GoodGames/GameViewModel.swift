//
//  GameDataViewModel.swift
//  GoodGames
//
//  Created by Jackson Secrist on 2/25/23.
//

import Foundation

class GameViewModel: ObservableObject {
    //MARK: - Infrastructure Properties
    @Published var viewModelReady: Bool = false {
        didSet {
            print("** View model is ready **")
        }
    }
    @Published var tabSelection: TabSelection = .home
    
    //MARK: Game Profile Presentation
    @Published var currentGameAppid: Int?

    //MARK: Review
    @Published var reviewSavedSuccessfully = false
    
    //MARK: - Game Lists
    @Published var gameOfTheDay: Game?
    @Published var newReleases: [Game] = []
    @Published var topRated: [Game] = []
    @Published var mostReviewed: [Game] = []
    @Published var userShelf: [Game] = []
    @Published var recommendedGames: [Game] = []
    
    //MARK: Caches
    @Published var cachedGames: [Int: Game] = [:]
    @Published var cachedRelatedGames: [Int : [Game]] = [:]
    @Published var cachedReviews: [Int: [Review]] = [:]
    
    private let functionsManager = FunctionsManager()
    private var timeoutGenerator: NumberGenerator
    
    //MARK: - Computed Properties
    
    var isInShelf: Bool {
        if let currentGameAppid, let game = cachedGames[currentGameAppid] {
            return userShelf.contains(game)
        } else {
            return false
        }
    }
    
    //MARK: - Initializer
    init() {
        timeoutGenerator = NumberGenerator(maximum: 20.0, withIncrement: 5.0)
    }
    
    //MARK: - Initialization Helpers
    func initializeAppData(with user: User) {
        // start data fetch methods
        self.getNewReleases()
        self.getTopRated()
        self.getMostReviewed()
        self.getGameOfTheDay()
        self.getRecommendedGames(for: user)
        self.getShelfListener(for: user)
        
        // start timeout loop to check for data readiness
        checkForReadyStateTimeout()
    }
    
    func checkForReadyStateTimeout() {
        let timeout = 5.0
        print("Checking ready state in \(timeout) seconds...")
        DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
            let dataReady = self.checkForReadyState()
            if dataReady {
                self.viewModelReady = true
            } else {
                self.checkForReadyStateTimeout()
            }
        }
    }
    
    func checkForReadyState() -> Bool {
        let newReleasesReady = !self.newReleases.isEmpty
        let topRatedReady = !self.topRated.isEmpty
        let mostReviewedReady = !self.mostReviewed.isEmpty
        let gameOfTheDayReady = self.gameOfTheDay != nil
        let recommendedGamesReady = !self.recommendedGames.isEmpty
        let shelfReady = FirestoreManager.shared.isShelfListenerOpen()
        
        return newReleasesReady && topRatedReady && mostReviewedReady && gameOfTheDayReady && recommendedGamesReady && shelfReady
    }
    
    //MARK: - User Intents
    func selectGame(_ game: Game) {
        cacheGame(game) //stick the game in the cache
        fetchAndCacheRelatedGames(for: game.appid) //fetch the related games and cache them
        fetchAndCacheReviews(for: game.appid) //fetch the reviews and cache them
    }
    
    func addCurrentGameToShelf(for user: User) {
        if let currentGameAppid, let game = cachedGames[currentGameAppid] {
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
        if let currentGameAppid, let game = cachedGames[currentGameAppid] {
            if let shelfGame = userShelf.first(where: { $0 == game }) {
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
    }
    
    func saveReview(_ review: Review){
        FirestoreManager.shared.createReview(review) { result in
            switch result {
            case .failure(let error):
                print("Review not saved with error: \(error.localizedDescription)")
            case .success(let saved):
                self.reviewSavedSuccessfully = saved
                print("Review saved.")
            }
        }
    }

    //MARK: - Cache Methods
    func cacheGame(_ game: Game) {
        self.cachedGames[game.appid] = game
    }
    
    func fetchAndCacheGame(with appid: Int) {
        FirestoreManager.shared.retrieveGame(by: appid) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let game):
                self.cachedGames[appid] = game
            }
        }
    }
    
    func fetchAndCacheRelatedGames(for appid: Int) {
        functionsManager.getGamesRelated(to: appid) { result in
            self.handleGameListResult(result: result) { games in
                self.cachedRelatedGames[appid] = games
            }
        }
    }
    
    func fetchAndCacheReviews(for appid: Int){
        FirestoreManager.shared.subscribeToReviews(for: appid) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let reviews):
                self.cachedReviews[appid] = reviews
            }
        }
    }

    //MARK: - Shelf Listener
    
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
    
    //MARK: - Initial Data Fetch Methods
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
                self.gameOfTheDay = games[dateIndex-1]
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
}
