

import UIKit

final class ProfileCoordinator {

    var navController: UINavigationController?

    func showScreenAfterLogIn(coordinator: ProfileCoordinator, name: String) {

#if DEBUG
        let currentUserService = TestUserService()
        let viewModel = ProfileViewModel(coordinator: coordinator, userService: currentUserService, name: "Test name")


#else
        let currentUserService = CurrentUserService()
        currentUserService.user.name = name
        let viewModel = ProfileViewModel(coordinator: coordinator, userService: currentUserService, name: name)

#endif


        let controller = ProfileViewController(viewModel: viewModel)
        navController?.pushViewController(controller, animated: true)

    }


    func showDetails() {

        let controller = PhotosViewController()
        navController?.pushViewController(controller, animated: true)


    }


}

