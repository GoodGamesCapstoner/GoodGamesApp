import Foundation

struct signUpViewModel {
    var email = ""
    var password = ""
    var username = ""
    var firstName = ""
    var lastName = ""
    
    func createUser(completion: @escaping (Result<Bool, Error>) -> Void) {
        AuthManager().createUser(withEmail: self.email, password: self.password, username: username, firstName: firstName, lastName: lastName) { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
    }
}
