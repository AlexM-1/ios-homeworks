

import Foundation
import Firebase

final class LogInViewModel {
    
    
    var delegate: LoginInspectorProtocol?
    
    private let coordinator: ProfileCoordinator
    
    private var timer: Timer?
    private var user: User
    
    var login: String = ""
    var pswd: String = ""

    private var timeCounter = 0
    var logInButtonText = Dynamic("Log In".localizable)
    
    
    enum Action {
        case logInButtonTap
        case signUpButtonTap
        case chekForAutorized
    }


    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
        self.user = User()
    }



    func changeState(_ action: Action) {
        switch action {
        case .logInButtonTap:

            guard !login.isEmpty && !pswd.isEmpty else {
                coordinator.showAlert(title: "Failure".localizable, message: "Missing field data".localizable)
                return
            }


            delegate?.authorization(login: login,
                                    pswd: pswd,
                                    completionGood: {
                self.stopTimer()
                self.user.name = self.login
                LoginManager.default.addUser(login: self.login, pswd: self.pswd)
                self.coordinator.showScreenAfterLogIn(coordinator: self.coordinator, user: self.user)
            }, completionBad: {
                self.handle(error: .userNotFound)
            })



        case .signUpButtonTap:
            delegate?.signUp(login: login,
                             pswd: pswd,
                             completionGood: {
                self.stopTimer()
                self.user.name = self.login
                LoginManager.default.addUser(login: self.login, pswd: self.pswd)
                self.coordinator.showScreenAfterLogIn(coordinator: self.coordinator, user: self.user)
                self.handle(error: .userCreated)
            }, completionBad: {
                self.handle(error: .userNotCreated)
            })

        case .chekForAutorized:
            if let user = LoginManager.default.users.first {
                delegate?.authorization(login: user.login,
                                        pswd: user.pswd,
                                        completionGood: {
                    self.stopTimer()
                    self.user.name = user.login
                    self.coordinator.showScreenAfterLogIn(coordinator: self.coordinator, user: self.user)
                }, completionBad: {
                
                })
            }


        }
    }

    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.timeCounter += 1




                self.logInButtonText.value = "Log In".localizable + " \(self.timeCounter) " + "seconds".localizable
            }
        }
    }

    private func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }

    private func handle(error: UserServiceError) {
        switch error {
        case .userNotFound:
            coordinator.showAlert(title: "Authorization error".localizable, message: "Incorrect user name or password".localizable)

        case .userNotCreated:
            coordinator.showAlert(title: "User creation error".localizable, message: "Check the spelling of the email and password".localizable)

        case .userCreated:
            coordinator.showAlert(title: "Successfully".localizable, message: "нa new user has been created".localizable)

        case .unowned:
            coordinator.showAlert(title: "Authorization error".localizable, message: "Unknown error".localizable)
        }
    }
}

protocol LoginInspectorProtocol: AnyObject {
    func authorization(login: String, pswd: String, completionGood: @escaping ()->Void, completionBad: @escaping ()->Void)
    func signUp(login: String, pswd: String, completionGood: @escaping ()->Void, completionBad: @escaping ()->Void)
}
