import FirebaseFirestore
import FirebaseFirestoreSwift


import Foundation

// MARK: - Firestore errors
enum FireStoreError: Error {
    case noAuthDataResult
    case noCurrentUser
    case noDocumentSnapshot
    case noSnapshotData
    case noUser
    case unknownError
}

extension FireStoreError: LocalizedError {
    // This will provide me with a specific localized description for the FireStoreError
    var errorDescription: String? {
        switch self {
        case .noAuthDataResult:
            return NSLocalizedString("No Auth Data Result", comment: "")
        case .noCurrentUser:
            return NSLocalizedString("No Current User", comment: "")
        case .noDocumentSnapshot:
            return NSLocalizedString("No Document Snapshot", comment: "")
        case .noSnapshotData:
            return NSLocalizedString("No Snapshot Data", comment: "")
        case .noUser:
            return NSLocalizedString("No User", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown Firestore error", comment: "")
        }
    }
}

class FirestoreManager: ObservableObject {
    //MARK: - User Management Methods
    func retrieveFBUser(uid: String, completion: @escaping (Result<User, Error>) -> Void) {
        let reference = Firestore
            .firestore()
            .collection("users")
            .document(uid)
        getDocument(for: reference) { result in
            switch result {
            case .success(let document):
                do {
                    // Added question mark because of an error, not sure if this is correct or not
                    guard let user = try document.data(as: User?.self) else {
                        completion(.failure(FireStoreError.noUser))
                        return
                    }
                    completion(.success(user))
                } catch {
                    completion(.failure(FireStoreError.noUser))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
   
    func mergeFBUser(user: User, uid: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        if user.name != "" {
            let reference = Firestore
                .firestore()
                .collection("users")
                .document(uid)
            do {
                _ =  try reference.setData(from: user, merge: true)
                completion(.success(true))
            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(FireStoreError.unknownError))
        }
        
    }
    
    /// Deletes the user account
    /// - Parameters:
    ///   - uid: the unique user ID
    ///   - completion: a completion result of a success or an error
    func deleteUserData(uid: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let reference = Firestore
            .firestore()
            .collection("users")
            .document(uid)
        reference.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    //MARK: - GET Methods for Firestore Documents
    
    /// retrieves a document snapshot
    /// - Parameters:
    ///   - reference: the document reference
    ///   - completion: a completion handler providing the resulting data or an error
    func getDocument(for reference: DocumentReference, completion: @escaping (Result<DocumentSnapshot, Error>) -> Void) {
        reference.getDocument { (documentSnapshot, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            guard let documentSnapshot = documentSnapshot else {
                completion(.failure(FireStoreError.noDocumentSnapshot))
                return
            }
            completion(.success(documentSnapshot))
        }
    }
    
    func getDocuments(matching query: Query, completion: @escaping (Result<[DocumentSnapshot], Error>) -> Void) {
        query.getDocuments { (querySnapshot, err) in
            if let err {
                completion(.failure(err))
                return
            }
            guard let documents = querySnapshot?.documents else {
                completion(.failure(FireStoreError.noSnapshotData))
                return
            }
            completion(.success(documents))
        }
    }
    
    //NOTE: this function works in theory. I haven't tested it as reading all documents might be 1000+ reads charged to our account from Firebase :/
    func getAllDocuments(for collection: CollectionReference, completion: @escaping (Result<[DocumentSnapshot], Error>) -> Void) {
        collection.getDocuments { (querySnapshot, err) in
            if let err {
                completion(.failure(err))
                return
            }
            guard let documents = querySnapshot?.documents else {
                completion(.failure(FireStoreError.noSnapshotData))
                return
            }
            completion(.success(documents))
        }
    }
    
    //MARK: - Get Methods for Game Data
    func retrieveGame(forID uid: String, completion: @escaping (Result<Game, Error>) -> Void) {
        let reference = Firestore.firestore().collection("games").document(uid)
        
        getDocument(for: reference) { result in
            switch result {
            case .success(let document):
                do {
                    // Added question mark because of an error, not sure if this is correct or not
                    guard let game = try document.data(as: Game?.self) else {
                        completion(.failure(FireStoreError.noDocumentSnapshot))
                        return
                    }
                    completion(.success(game))
                } catch {
                    completion(.failure(FireStoreError.unknownError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func retrieveGames(matching query: Query, completion: @escaping (Result<[Game], Error>) -> Void) {
        print("Attempting to get documents matching query...")
        getDocuments(matching: query) { result in
            switch result {
            case .success(let documents):
                print("Documents retrieved. Attempting to map to game objects...")
                let games = documents.compactMap({ docSnapshot -> Game? in
                    guard let game = try? docSnapshot.data(as: Game?.self) else {
                        print("Failed to convert document snapshot to Game object. Missing values may be present in document: \(docSnapshot.documentID)")
                        return nil
                    }
                    return game
                })
                
                print("Game objects mapped. Calling completion...")
                completion(.success(games))
            case .failure(let error):
                print("Failed to retrieve documents.")
                completion(.failure(error))
            }
        }
    }
    
    func retrieveNewReleases(completion: @escaping (Result<[Game], Error>) -> Void) {
        let collection = Firestore.firestore().collection("games")
        let query = collection.order(by: "release_date", descending: true).limit(to: 20)
        print("Query set, attemtpting to retrieve newly released games...")
        retrieveGames(matching: query, completion: completion)
    }
    
    func retrieveTopRated(completion: @escaping (Result<[Game], Error>) -> Void) {
        let collection = Firestore.firestore().collection("games")
        let query = collection.order(by: Game.CodingKeys.reviewScore.rawValue, descending: true).limit(to: 20)
        print("Query set, attemtpting to retrieve top rated games...")
        retrieveGames(matching: query, completion: completion)
    }
    
    func retrieveMostReviewed(completion: @escaping (Result<[Game], Error>) -> Void) {
        let collection = Firestore.firestore().collection("games")
        let query = collection.order(by: Game.CodingKeys.totalReviews.rawValue, descending: true).limit(to: 20)
        print("Query set, attemtpting to retrieve most reviewed games...")
        retrieveGames(matching: query, completion: completion)
    }
    
    //MARK: - Read/Write methods for shelf data
    func retrieveShelf(for user: User, completion: @escaping (Result<[Game], Error>) -> Void) {
        let collection = Firestore.firestore().collection("users/\(user.uid)/shelf")
        let query = collection.order(by: Game.CodingKeys.name.rawValue)
        
        retrieveGames(matching: query, completion: completion)
    }
    
    func addToShelf(for user: User, game: Game, completion: @escaping (Result<Game, Error>) -> Void) {
        let collection = Firestore.firestore().collection("users").document(user.uid).collection("shelf")
        
        var ref: DocumentReference? = nil
        
        do {
            ref = try collection.addDocument(from: game, completion: { error in
                if let error {
                    print("Error writing document: \(error)")
                    completion(.failure(FireStoreError.unknownError))
                    return
                }
                
                guard let ref = ref else {
                    print("Document reference is nil")
                    completion(.failure(FireStoreError.unknownError))
                    return
                }
                
                print("Document added with ID: \(ref.documentID)")
                
                self.getDocument(for: ref) { result in
                    switch result {
                    case .success(let document):
                        do {
                            // Added question mark because of an error, not sure if this is correct or not
                            guard let game = try document.data(as: Game?.self) else {
                                completion(.failure(FireStoreError.noDocumentSnapshot))
                                return
                            }
                            completion(.success(game))
                        } catch {
                            completion(.failure(FireStoreError.unknownError))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            })
        }
        catch {
            print("Error writing document: \(error)")
        }
    }
    
    func callRecommender() {
        let urlString = "https://us-central1-good-games-378421.cloudfunctions.net/gg-recommender-model"
        
        guard let url = URL(string: urlString) else {
            print("invalid url")
            return
        }
        
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
                print("Invalid response")
                return
            }
            
            // Check that the response contains data
            guard let data = data else {
                print("No data received")
                return
            }
            
            // Parse the JSON data
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("JSON data: \(json)")
            } catch {
                print("Error parsing JSON: \(error)")
            }
            
        }
        // Start the data task
        print("Starting fetch...")
        dataTask.resume()
    }
}
