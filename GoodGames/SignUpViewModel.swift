import Foundation

struct signUpViewModel {
    var email = ""
    var password = ""
    var fullname = ""
    
    func createUser(completion: @escaping (Bool) -> Void) {
        AuthManager().createUser(withEmail: self.email, password: self.password, fullname: fullname) { result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
