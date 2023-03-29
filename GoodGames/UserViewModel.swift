import SwiftUI
import FirebaseStorage
import FirebaseAuth

class UserViewModel: ObservableObject {
    public enum AuthState {
        case undefined, signedOut, signedIn
    }
    
    //MARK: - User Properties
    @Published var user: User?
    @Published var isUserAuthenticated: AuthState
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var username: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var image:UIImage?
    
    //MARK: - Login/Nav state vars
    @Published var showSheet = false
    @Published var newAccount = false
    @Published var showDeletion = false
    
    //MARK: - Warnings & Error States
    @Published var userMissingFromFirestore: Bool = false
    @Published var authFailed: Bool = false
    @Published var authFailedWarning: String?
    
    //MARK: - Other users
    @Published var cachedUsers: [String: User] = [:]
    @Published var cachedUserImages: [String: UIImage] = [:]
    
    //MARK: - User Search
    @Published var queriedUsers: [User] = []
    
    
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    public init(isUserAuthenticated: Published<AuthState> = Published<AuthState>.init(wrappedValue: .undefined)) {
        self._isUserAuthenticated  = isUserAuthenticated
        
        configureFirebaseStateDidChange()
    }
    /// Handles the change of authentication state
    func configureFirebaseStateDidChange() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ (_, user) in
            guard let user else {
                self.isUserAuthenticated = .signedOut
                self.clearUserData()
                return
            }
            
            self.isUserAuthenticated = .signedIn
            self.userMissingFromFirestore = false //set to false until we know we can't find them
            
            FirestoreManager.shared.retrieveFBUser(uid: user.uid) { (result) in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                    self.logOut()
                    self.userMissingFromFirestore = true //cant find user in DB
                case .success(let user):
                    self.user = user
                    self.getProfileImage()
                }
            }
           
        })
    }
    
    func login() {
        self.authFailed = false
        self.authFailedWarning = nil
        AuthManager().signIn(withEmail: email, password: password) { result in
            switch result {
            case .success:
                print("Logged in")
            case .failure(let error):
                self.authFailed = true
                self.authFailedWarning = error.localizedDescription
                print(error.localizedDescription)
            }
        }
    }
    
    func logOut() {
        AuthManager().logout { result in
            print("Logged Out")
        }
    }
    
    func getProfileImage() {
        let storageManager = StorageManager()
        if let userID = user?.uid {
            storageManager.getImage(for: "Profiles", named: userID) { result in
                switch result {
                case .success(let url):
                    URLSession.shared.dataTask(with: url) { data, response, error in
                        if let imageData = data {
                            DispatchQueue.main.async {
                                self.image = UIImage(data: imageData)
                            }
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }.resume()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func saveProfileImage() {
        let storageManager = StorageManager()
        if let userID = user?.uid {
            if let image = image {
                storageManager.upload(image: image, for: "Profiles", named: userID)
            }
        }
    }
    
    func clearUserData() {
        self.user = nil
        self.image = nil
        self.email = ""
        self.password = ""
        self.username = ""
        self.firstName = ""
        self.lastName = ""
    }
    
    
    func fetchUsers(matching keyword: String) {
        if keyword != "" {
            let loweredInput = keyword.lowercased()
            FirestoreManager.shared.searchUsers(input: loweredInput) { result in
                switch result {
                case .failure(let error):
                    print("User search failed with error: \(error.localizedDescription)")
                case .success(let users):
                    let filteredUsers = users.filter { filterUser in
                        filterUser.uid != self.user?.uid
                    }
                    self.queriedUsers = filteredUsers
                }
            }
        } else {
            self.queriedUsers = []
        }
    }
    
    func fetchAndCacheImage(for user: User) {
        let storageManager = StorageManager()
        
        storageManager.getImage(for: "Profiles", named: user.uid) { result in
            switch result {
            case .success(let url):
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let imageData = data {
                        DispatchQueue.main.async {
                            self.cachedUserImages[user.uid] = UIImage(data: imageData)
                        }
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }.resume()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func selectUser(_ user: User){
        cacheUser(user)
        fetchAndCacheImage(for: user)
    }
    
    func cacheUser(_ user: User) {
        self.cachedUsers[user.uid] = user
    }
    
    func fetchAndCacheUser(with uid: String) {
        FirestoreManager.shared.retrieveFBUser(uid: uid) { result in
            switch result {
            case .failure(let error):
                print("Fetching user for cache failed with error: \(error.localizedDescription)")
            case .success(let user):
                self.cachedUsers[user.uid] = user
            }
        }
    }
}
