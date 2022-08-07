

final class LoginInspector: LoginViewControllerDelegate {
    
    func authorization(login: String, pswd: String) -> Bool {
        
        let checker = Checker.shared
        return checker.checkPassword(login: login, pswd: pswd)
        
    }
    
}



protocol LoginFactory {
    func login() -> LoginInspector
}



final class MyLoginFactory: LoginFactory {
    
    func login() -> LoginInspector {
        return LoginInspector()
    }
    
    
}


