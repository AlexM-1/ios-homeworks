

import UIKit

final class ProfileCoordinator {

    var navController: UINavigationController?

    func showScreenAfterLogIn(coordinator: ProfileCoordinator, user: User) {

        user.image = UIImage(named: "foto")



        let viewModel = ProfileViewModel(coordinator: coordinator, user: user, state: .profile)

        let controller = ProfileViewController(viewModel: viewModel)

            self.navController?.viewControllers.removeLast()
            self.navController?.pushViewController(controller, animated: true)


    }


    func showDetails() {
        let controller = PhotosViewController()
        navController?.pushViewController(controller, animated: true)
    }

    func showAlert(title: String, message: String) {

        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "ОК", style: .cancel))

        if navController?.presentedViewController == nil {
            navController?.present(alert, animated: true) }
    }
    
}

