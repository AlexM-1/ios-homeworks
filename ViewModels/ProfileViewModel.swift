
import StorageService
import Foundation

final class ProfileViewModel {

    enum State {
        case profile
        case favorite
    }

    var state: State

    private let coordinator: ProfileCoordinator
    
    let posts = PostModel.createModel()

    let user: User

    enum Action {
        case cellDidTap
    }


    init(coordinator: ProfileCoordinator,
         user: User, state: State) {
        self.user = user
        self.coordinator = coordinator
        self.state = state
    }

    func changeState(_ action: Action) {
        switch action {
        case .cellDidTap:
            coordinator.showDetails()

        }
    }

}

