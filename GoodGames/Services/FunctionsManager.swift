//
//  FunctionsManager.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/1/23.
//

import Foundation
import FirebaseFirestore

enum FunctionsError: Error {
    case invalidResponseCode
    case noDataReceieved
    case errorWhenParsingJSONData
}
extension FunctionsError: LocalizedError {
    // This will provide me with a specific localized description for the FireStoreError
    var errorDescription: String? {
        switch self {
        case .invalidResponseCode:
            return NSLocalizedString("Invalid Response Code from data source", comment: "")
        case .noDataReceieved:
            return NSLocalizedString("No data received from data source", comment: "")
        case .errorWhenParsingJSONData:
            return NSLocalizedString("Error when parsing JSON data to integer array", comment: "")
        }
    }
}

class FunctionsManager {
    
    //MARK: - Private Methods
    private func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 240.0
        sessionConfig.timeoutIntervalForResource = 300.0
        let session = URLSession(configuration: sessionConfig)
        
//        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
            
            // Check the response status code
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(FunctionsError.invalidResponseCode))
                print("Invalid response code")
                return
            }
            
            // Check that the response contains data
            guard let data = data else {
                completion(.failure(FunctionsError.noDataReceieved))
                print("No data received")
                return
            }
            
            completion(.success(data))
            
        }
        // Start the data task
        print("Starting fetch...")
        dataTask.resume()
    }
    
    private func fetchRecommendedApps(from url: URL, completion: @escaping (Result<[Int], Error>) -> Void) {
        fetchData(from: url) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let appids = try JSONDecoder().decode([Int].self, from: data)
                    completion(.success(appids))
                } catch {
                    completion(.failure(FunctionsError.errorWhenParsingJSONData))
                }
            }
        }
    }
    
    
    //MARK: - Public Methods
    func getGamesRelated(to appid: Int, completion: @escaping (Result<[Game], Error>) -> Void) {
        let urlString = URLBuilder.recommenderForAppID(appid)
        
        guard let url = URL(string: urlString) else {
            print("invalid url")
            return
        }
        
        fetchRecommendedApps(from: url) { result in
            switch result {
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            case .success(let appids):
                print("Games recommended: \(appids.count)")
                FirestoreManager.shared.retrieveGamesWith(matching: appids, completion: completion)
            }
        }
    }

    func getRecommendedGames(for user: User, completion: @escaping (Result<[Game], Error>) -> Void) {
        let urlString = URLBuilder.recommenderForUser(user.uid)
        
        guard let url = URL(string: urlString) else {
            print("invalid url")
            return
        }
        
        fetchRecommendedApps(from: url) { result in
            switch result {
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            case .success(let appids):
                print("Games recommended: \(appids.count)")
                FirestoreManager.shared.retrieveGamesWith(matching: appids, completion: completion)
            }
        }
    }

    //MARK: - Private URL Helper
    private struct URLBuilder {
        static let baseURL = "https://us-central1-good-games-378421.cloudfunctions.net"
        static func recommenderForAppID(_ appid: Int) -> String {
            let relPath = "/gg-recommender-by-app-id?appid=\(appid)"
            
            return baseURL + relPath
        }
        
        static func recommenderForUser(_ userID: String) -> String {
            let relPath = "/gg-recommender-user-item-rating?userid=\(userID)"
            //original: 76561198149460992
            return baseURL + relPath
        }
    }
    
}
