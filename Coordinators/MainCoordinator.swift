//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Alex M on 28.08.2022.
//


import UIKit

protocol MainCoordinatorProtocol {
    func startApplication() -> UIViewController
}

final class MainCoordinator: MainCoordinatorProtocol {


    func startApplication() -> UIViewController {
        return MainTabBarViewController()
    }




    
}


