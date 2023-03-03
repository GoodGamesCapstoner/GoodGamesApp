//
//  FunctionsManager.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/1/23.
//

import Foundation

enum FunctionsError: Error {
    case invalidResponseCode
    case noDataReceieved
}
extension FunctionsError: LocalizedError {
    // This will provide me with a specific localized description for the FireStoreError
    var errorDescription: String? {
        switch self {
        case .invalidResponseCode:
            return NSLocalizedString("Invalid Response Code from data source", comment: "")
        case .noDataReceieved:
            return NSLocalizedString("No data received from data source", comment: "")
            
        }
    }
}

class FunctionsManager {
    
    private func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
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
    
    
    func testRecommender() {
        let urlString = "https://us-central1-good-games-378421.cloudfunctions.net/gg-recommender-model"
        
        guard let url = URL(string: urlString) else {
            print("invalid url")
            return
        }
        
        fetchData(from: url) { result in
            switch result {
            case .failure(let error):
                print("Fetching error: \(error.localizedDescription)")
            case .success(let data):
                // Parse the JSON data
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("JSON data: \(json)")
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }
        }
    }
}
