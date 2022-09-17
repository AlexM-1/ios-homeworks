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
    
    var login: String = ""
    var pswd: String = ""
    
    
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
                coordinator.showScreenAfterLogIn(coordinator: coordinator, name: login)
            } else {
                print("неправильное имя пользователя или пароль")
            }

        }
    }
}

protocol LoginInspectorProtocol: AnyObject {
    
    func authorization(login: String, pswd: String) -> Bool
}
