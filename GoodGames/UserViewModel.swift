import SwiftUI
import FirebaseStorage
import FirebaseAuth

class UserViewModel: ObservableObject {
    public enum AuthState {
        case undefined, signedOut, signedIn
    }
    
    //MARK: - Published Vars -> Auth
    @Published var user: User?
    @Published var isUserAuthenticated: AuthState
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var username: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var image:UIImage?
    @Published var showSheet = false
    @Published var newAccount = false
    @Published var showDeletion = false
//    @Published var userID: String?  /
    
    //MARK: - Published Vars -> Navigation
    @Published var tabSelection: Int = 1
    
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    public init(isUserAuthenticated: Published<AuthState>
                = Published<AuthState>.init(wrappedValue: .undefined)) {
        self._isUserAuthenticated  = isUserAuthenticated
        
        configureFirebaseStateDidChange()
    }
    /// Handles the change of authentication state
    func configureFirebaseStateDidChange() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ (_, user) in
            guard user != nil else {
                self.isUserAuthenticated = .signedOut
                self.user = nil
                self.image = nil
                self.email = ""
                self.password = ""
                self.username = ""
                self.firstName = ""
                self.lastName = ""
                return
            }
            self.isUserAuthenticated = .signedIn
            FirestoreManager.shared.retrieveFBUser(uid: user!.uid) { (result) in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let user):
                    self.user = user
                    self.getProfileImage()
                }
            }
           
        })
    }
    
    func login() {
        AuthManager().signIn(withEmail: email, password: password) { result in
            switch result {
            case .success:
                print("Logged in")
            case .failure(let error):
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
    
    
}
