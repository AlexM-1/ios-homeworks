//
//  MainTabBarViewController.swift
//  Navigation
//
//  Created by Alex M on 28.08.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

   private let feedViewController = Factory(flow: .feed)

    private let logInViewController = Factory(flow: .profile)

    private let banner = Banner()

    override func viewDidLoad() {
        super.viewDidLoad()
        setControllers()
        banner.vc = self
        banner.show()
    }

    private func setControllers() {
        viewControllers = [
            feedViewController.navigationController,
            logInViewController.navigationController
        ]


        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance


        let navBarAppearance: UINavigationBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithDefaultBackground()
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance





    }
}

