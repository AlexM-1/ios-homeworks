//
//  LogInViewModel.swift
//  Navigation
//
//  Created by Alex M on 04.09.2022.
//

import Foundation

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
    }
    
    
    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
        self.user = User()
    }
    
    func changeState(_ action: Action) {
        switch action {
        case .logInButtonTap:


// MARK: - задача 2


//#if DEBUG
//            let currentUserService = TestUserService()
//#else
//            let currentUserService = CurrentUserService()
//#endif
//
//                        do {
//                            let user = try currentUserService.getUser(name: login)
//                            self.user = user
//
//                        } catch {
//                            if let userError = error as? UserServiceError {
//                                handle(error: userError)
//                            }
//                        }

// MARK: - задача 3
            CurrentUserService().getUser(name: login) {
                [weak self] result in
                switch result {
                case .success(let user):
                    self?.user = user
                case .failure(let error) :
                    self?.handle(error: error)
                }
            }



            if delegate?.authorization(login: login, pswd: pswd) == true {
                stopTimer()
                coordinator.showScreenAfterLogIn(coordinator: coordinator, user: user)
            } else {
                handle(error: .unauthorized)
            }

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
            coordinator.showAlert(title: "Ошибка авторизации", message: "Неправильное имя пользвателя")

        case .unauthorized:
            coordinator.showAlert(title: "Ошибка авторизации", message: "Пароль указан неверно")

        case .unowned:
            coordinator.showAlert(title: "Ошибка авторизации", message: "Неизвестная ошибка")
        }
    }
}

protocol LoginInspectorProtocol: AnyObject {
    func authorization(login: String, pswd: String) -> Bool
}
