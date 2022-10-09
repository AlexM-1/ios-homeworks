

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
    var logInButtonText = Dynamic("Log In")
    
    
    enum Action {
        case logInButtonTap
        case signUpButtonTap
    }
    
    
    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
        self.user = User()
    }
    
    func changeState(_ action: Action) {
        switch action {
        case .logInButtonTap:

            guard !login.isEmpty && !pswd.isEmpty else {
                coordinator.showAlert(title: "Failure", message: "Missing field data")
                return
            }


            delegate?.authorization(login: login,
                                    pswd: pswd,
                                    completionGood: {
                self.stopTimer()
                self.user.name = self.login
                self.coordinator.showScreenAfterLogIn(coordinator: self.coordinator, user: self.user)
            }, completionBad: {
                self.handle(error: .userNotFound)
            })



        case .signUpButtonTap:
            delegate?.signUp(login: login,
                             pswd: pswd,
                             completionGood: {
                self.handle(error: .userCreated)
            }, completionBad: {
                self.handle(error: .userNotCreated)
            })
        }
    }

    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.timeCounter += 1
                self.logInButtonText.value = "Log In \(self.timeCounter) sec."
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
            coordinator.showAlert(title: "Ошибка авторизации", message: "Неправильное имя пользвателя или пароль")

        case .userNotCreated:
            coordinator.showAlert(title: "Ошибка создания пользователя", message: "Проверьте правильность написания эл. почты и пароля")

        case .userCreated:
            coordinator.showAlert(title: "Успешно", message: "новый пользователь создан")

        case .unowned:
            coordinator.showAlert(title: "Ошибка авторизации", message: "Неизвестная ошибка")
        }
    }
}

protocol LoginInspectorProtocol: AnyObject {
    func authorization(login: String, pswd: String, completionGood: @escaping ()->Void, completionBad: @escaping ()->Void)
    func signUp(login: String, pswd: String, completionGood: @escaping ()->Void, completionBad: @escaping ()->Void)
}
