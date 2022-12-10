
final class Checker {
    
    private let login = "Alex"
    private let pswd = "123"
    
    static let shared = Checker()
    
    private init() {}
    
    func checkPassword (login: String, pswd: String) -> Bool {
        
        //        if login == self.login && pswd == self.pswd {
        //            return true
        //        } else {
        //            return false
        //        }
        
        
        if login.hash == self.login.hash && pswd.hash == self.pswd.hash {
            return true
        } else {
            return false

        }
        
        
    }
}




