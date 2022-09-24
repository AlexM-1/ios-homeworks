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
    
    var login: String = ""
    var pswd: String = ""
    private var timeCounter = 0
    var logInButtonText = Dynamic("Log In")
    
    
    enum Action {
        case logInButtonTap
    }
    
    
    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
    }
    
    func changeState(_ action: Action) {
        switch action {
        case .logInButtonTap:
            
            if delegate?.authorization(login: login, pswd: pswd) == true {
                stopTimer()
                coordinator.showScreenAfterLogIn(coordinator: coordinator, name: login)
            } else {
                print("неправильное имя пользователя или пароль")
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
}

protocol LoginInspectorProtocol: AnyObject {
    func authorization(login: String, pswd: String) -> Bool
}
