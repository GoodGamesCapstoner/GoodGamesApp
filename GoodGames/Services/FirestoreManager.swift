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
    case nilDocID
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
        case .nilDocID:
            return NSLocalizedString("Document id of give object in nil", comment: "")
        }
    }
}

struct ListenerRegistry {
    var shelf: ListenerRegistration?
    var reviews: [Int: ListenerRegistration?] = [:]
}

class FirestoreManager: ObservableObject {
    //MARK: - Singleton property
    static let shared = FirestoreManager()
    
    //MARK: - Properties
    private let firestore: Firestore
    private var listeners: ListenerRegistry
    
    //MARK: - Initializer
    private init() {
        self.firestore = Firestore.firestore()
        self.listeners = ListenerRegistry()
    }
    
    //MARK: - Listener Access
    func isShelfListenerOpen() -> Bool {
        return listeners.shelf != nil
    }
    
    //MARK: - User Management Methods
    func retrieveFBUser(uid: String, completion: @escaping (Result<User, Error>) -> Void) {
        let reference = Firestore.firestore().collection("users").document(uid)
        
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
        // This was just the full name before I added first and last. I figure username will be more unique, but if
        // it causes issues maybe change it to firstName or lastName.
        if user.username != "" {
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
    
    func retrieveUsers(matching query: Query, completion: @escaping (Result<[User], Error>) -> Void) {
        getDocuments(matching: query) { result in
            switch result {
            case .success(let documents):
                let users = documents.compactMap { docSnapshot -> User? in
                    guard let user = try? docSnapshot.data(as: User?.self) else {
                        print("Failed to convert document snapshot to User object. Missing values may be present in document: \(docSnapshot.documentID)")
                        return nil
                    }
                    return user
                }
                completion(.success(users))
            case .failure(let error):
                print("Failed to retrieve documents.")
                completion(.failure(error))
            }
        }
    }
    
    func searchUsers(input keyword: String, completion: @escaping (Result<[User], Error>) -> Void) {
        let query = firestore.collection("users").whereField("usernameSearchList", arrayContains: keyword)
        retrieveUsers(matching: query, completion: completion)
    }
    
    //MARK: - GET Methods for Firestore Documents
    
    /// retrieves a document snapshot
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
    
    func retrieveGame(by appid: Int, completion:@escaping (Result<Game, Error>) -> Void) {
        let query = firestore.collection("games").whereField(Game.CodingKeys.appid.rawValue, isEqualTo: appid)
        
        retrieveGames(matching: query) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let games):
                if let game = games.first {
                    completion(.success(game))
                } else {
                    completion(.failure(FireStoreError.noSnapshotData))
                }
            }
        }
    }
    
    func retrieveGames(matching query: Query, completion: @escaping (Result<[Game], Error>) -> Void) {
        getDocuments(matching: query) { result in
            switch result {
            case .success(let documents):
                let games = documents.compactMap({ docSnapshot -> Game? in
                    guard let game = try? docSnapshot.data(as: Game?.self) else {
                        print("Failed to convert document snapshot to Game object. Missing values may be present in document: \(docSnapshot.documentID)")
                        return nil
                    }
                    return game
                })
                completion(.success(games))
            case .failure(let error):
                print("Failed to retrieve documents.")
                completion(.failure(error))
            }
        }
    }
    
    func retrieveGamesWith(matching appids: [Int], completion: @escaping (Result<[Game], Error>) -> Void) {
        let collection = Firestore.firestore().collection("games")
        let query = collection.whereField(Game.CodingKeys.appid.rawValue, in: appids)
        retrieveGames(matching: query, completion: completion)
    }
    
    func retrieveNewReleases(completion: @escaping (Result<[Game], Error>) -> Void) {
        let collection = Firestore.firestore().collection("games")
        let query = collection.order(by: "release_date", descending: true).limit(to: 20)
        retrieveGames(matching: query, completion: completion)
    }
    
    func retrieveTopRated(completion: @escaping (Result<[Game], Error>) -> Void) {
        let collection = Firestore.firestore().collection("games")
        let query = collection.order(by: Game.CodingKeys.reviewScore.rawValue, descending: true).limit(to: 20)
        retrieveGames(matching: query, completion: completion)
    }
    
    func retrieveMostReviewed(limit:Int, completion: @escaping (Result<[Game], Error>) -> Void) {
        let collection = Firestore.firestore().collection("games")
        let query = collection.order(by: Game.CodingKeys.totalReviews.rawValue, descending: true).limit(to: limit)
        retrieveGames(matching: query, completion: completion)
    }
    
    //MARK: - Read/Write methods for shelf data
    func addToShelf(for user: User, game: Game, completion: @escaping (Result<Bool, Error>) -> Void) {
        let collection = Firestore.firestore().collection("users").document(user.uid).collection("shelf")
        
        var ref: DocumentReference? = nil
        
        do {
            ref = try collection.addDocument(from: game, completion: { error in
                if let error {
                    print("Error writing document: \(error)")
                    completion(.failure(FireStoreError.unknownError))
                    return
                }
                
                guard ref != nil else {
                    print("Document reference is nil")
                    completion(.failure(FireStoreError.unknownError))
                    return
                }
                completion(.success(true))
            })
        }
        catch {
            print("Error writing document: \(error)")
        }
    }
    
    func shelfListener(for user: User, completion: @escaping (Result<[Game], Error>) -> Void) {
        let db = Firestore.firestore()
        let collection = db.collection("users/\(user.uid)/shelf").order(by: Game.CodingKeys.name.rawValue)
        print("** CREATING LISTENER FOR SHELF **")
        if listeners.shelf == nil {
            listeners.shelf = collection.addSnapshotListener({ querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    completion(.failure(FireStoreError.noSnapshotData))
                    return
                }
                
                let games = documents.compactMap({ docSnapshot -> Game? in
                    guard let game = try? docSnapshot.data(as: Game?.self) else {
                        print("Failed to convert document snapshot to Game object. Missing values may be present in document: \(docSnapshot.documentID)")
                        return nil
                    }
                    return game
                })
                
                completion(.success(games))
                print("** LISTENER INVOKED - SHELF UPDATED **")
            })
        }
    }
    
    //the game passed in HAS to be the one from the shelf collection, not the identical one from the games collection
    func removeFromShelf(for user: User, game: Game, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let docID = game.id else {
            completion(.failure(FireStoreError.nilDocID))
            return
        }
        
        let reference = self.firestore.collection("users/\(user.uid)/shelf/").document(docID)
        
        reference.delete { error in
            if let error {
                completion(.failure(FireStoreError.unknownError))
                print(error.localizedDescription)
            } else {
                completion(.success(true))
            }
        }
    }
    
    //MARK: - Read/Write methods for reviews
    
    func subscribeToReviews(for appid: Int, completion: @escaping (Result<[Review], Error>) -> Void) {
        let query = firestore.collection("reviews").whereField(Review.CodingKeys.appid.rawValue, isEqualTo: appid).order(by: Review.CodingKeys.creationDate.rawValue, descending: true)
        
        if listeners.reviews[appid] == nil {
            print("** CREATING LISTENER FOR REVIEWS FOR \(appid) **")
            listeners.reviews[appid] = query.addSnapshotListener({ querySnapshot, error in
                if let error = error {
                    print(" * Review Listener error: \(error.localizedDescription) * ")
                }
                
                guard let documents = querySnapshot?.documents else {
                    completion(.failure(FireStoreError.noSnapshotData))
                    return
                }
                
                let reviews = documents.compactMap({ docSnapshot -> Review? in
                    guard let game = try? docSnapshot.data(as: Review?.self) else {
                        print("Failed to convert document snapshot to Review. Missing values may be present in document: \(docSnapshot.documentID)")
                        return nil
                    }
                    return game
                })
                
                completion(.success(reviews))
                print("** LISTENER INVOKED - REVIEWS UPDATED **")
            })
        }
    }
    
    func createReview(_ review: Review, completion: @escaping (Result<Bool, Error>) -> Void) {
        let collection = firestore.collection("reviews")
        
        var ref: DocumentReference? = nil
        
        do {
            ref = try collection.addDocument(from: review, completion: { error in
                if let error {
                    print("Error writing document: \(error)")
                    completion(.failure(FireStoreError.unknownError))
                    return
                }
                
                guard ref != nil else {
                    print("Document reference is nil")
                    completion(.failure(FireStoreError.unknownError))
                    return
                }
                completion(.success(true))
            })
        }
        catch {
            print("Error writing document: \(error)")
        }
    }
}
