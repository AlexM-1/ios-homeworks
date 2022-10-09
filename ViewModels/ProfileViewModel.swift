
import StorageService
import Foundation

final class ProfileViewModel {

    private let coordinator: ProfileCoordinator
    
    let posts = PostModel.createModel()

    let user: User

    enum Action {
        case cellDidTap
    }


    init(coordinator: ProfileCoordinator,
         user: User) {
        self.user = user
        self.coordinator = coordinator
    }

    func changeState(_ action: Action) {
        switch action {
        case .cellDidTap:
            coordinator.showDetails()

        }
    }

}

