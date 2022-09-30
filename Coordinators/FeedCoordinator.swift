//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Alex M on 28.08.2022.
//

import Foundation
import UIKit

final class FeedCoordinator {

    var navController: UINavigationController?


    func showPostViewController(postTitle: String) {

        let controller = PostViewController()
        controller.titlePost = postTitle
        navController?.pushViewController(controller, animated: true)
    }


}
