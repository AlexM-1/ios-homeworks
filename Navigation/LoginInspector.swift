
final class LoginInspector: LoginInspectorProtocol {

    func authorization(login: String,
                       pswd: String,
                       completionGood: @escaping ()->Void,
                       completionBad: @escaping ()->Void) {
        let checkerService = CheckerService()
        checkerService.checkCredentials(login: login,
                                        pswd: pswd,
                                        completionGood: completionGood,
                                        completionBad: completionBad)
    }

    func signUp(login: String,
                pswd: String,
                completionGood: @escaping ()->Void,
                completionBad: @escaping ()->Void) {
        let checkerService = CheckerService()
        checkerService.signUp(login: login,
                              pswd: pswd,
                              completionGood: completionGood,
                              completionBad: completionBad)

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


