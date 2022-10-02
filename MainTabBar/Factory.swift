

import Foundation
import UIKit

final class Factory {

    enum Flow {
        case profile
        case feed
    }

    let navigationController: UINavigationController = UINavigationController()
    let flow: Flow

    init(flow: Flow) {
        self.flow = flow
        startModule()
    }

    func startModule() {
        switch flow {
        case .profile:
            let profileCoordinator = ProfileCoordinator()
            let viewModel = LogInViewModel(coordinator: profileCoordinator)
            let myLoginFactory = MyLoginFactory()
            viewModel.delegate = myLoginFactory.login()
            let controller = LogInViewController(viewModel: viewModel)
            profileCoordinator.navController = navigationController
            navigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), selectedImage: nil)
            navigationController.setViewControllers([controller], animated: true)

        case .feed:
            let feedCoordinator = FeedCoordinator()
            let controller = FeedViewController(coordinator: feedCoordinator)

            feedCoordinator.navController = navigationController
           //controller.coordinator = feedCoordinator

            navigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "feed"), selectedImage: nil)
            navigationController.setViewControllers([controller], animated: true)

        }
    }
}

