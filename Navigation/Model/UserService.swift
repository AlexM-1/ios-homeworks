

import UIKit

protocol UserService {
    func getUser(name: String) -> User?
}



final class CurrentUserService: UserService {

    var user = User()

    func getUser(name: String) -> User? {
        guard name == self.user.name else { return nil }
        return self.user
    }

}


final class TestUserService: UserService {

    var user = User()

    init() {
        user.name = "Test name"
        user.status = "Test status"
        user.image = UIImage(named: "foto")
    }

    func getUser(name: String) -> User? {
        guard name == self.user.name else { return nil }
        return self.user
    }


}
