//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Alex M on 04.09.2022.
//

import StorageService
import Foundation

final class ProfileViewModel {

    private let coordinator: ProfileCoordinator
    
    let posts = PostModel.createModel()


    let userService: UserService
    let name: String


    enum Action {
        case cellDidTap
    }


    init(coordinator: ProfileCoordinator,
         userService: UserService,
         name: String) {

        self.userService = userService
        self.name = name
        self.coordinator = coordinator
    }

    func changeState(_ action: Action) {
        switch action {
        case .cellDidTap:
            coordinator.showDetails()

        }
    }

}

