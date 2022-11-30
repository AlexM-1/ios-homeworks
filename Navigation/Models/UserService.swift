

import UIKit
import RealmSwift


enum UserServiceError: Error {
    case userNotFound
    case userNotCreated
    case userCreated
    case `unowned`
}

protocol UserService {
    func getUser(name: String) throws -> User
}


final class CurrentUserService: UserService {

    var user = User()

    func getUser(name: String) throws -> User {


        if name == "Alex" {
            user.name = "Alex"
            user.status = "Alex status"
            user.image = UIImage(named: "foto2-medvedy-grizli")

        } else {
            throw UserServiceError.userNotFound

        }

        return self.user
    }


    func getUser (name: String, completion: @escaping (Result<User, UserServiceError>) -> Void) {
        if name == "Alex" {
            user.name = "Alex"
            user.status = "Alex status"
            user.image = UIImage(named: "foto2-medvedy-grizli")
            completion(.success(user))

        } else {
            completion(.failure(.userNotFound))
        }

    }




}


final class TestUserService: UserService {

    var user = User()

    init() {
        user.name = "Test name"
        user.status = "Test status"
        user.image = UIImage(named: "foto")
    }

    func getUser(name: String) throws -> User {
        return self.user
    }
}
