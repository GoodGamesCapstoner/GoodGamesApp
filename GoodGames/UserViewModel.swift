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
}
