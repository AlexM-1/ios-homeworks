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

    private let favoriteViewController = Factory(flow: .favorite)

    private let banner = Banner()
    
    private let networkService: NetworkServiceProtocol = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setControllers()
        banner.vc = self
        banner.show()
        fetchUsers()
        fetchModelWithDecoder()
        
    }
    
    private func fetchUsers() {
        
        if let appConfig = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.appConfiguration {
            
            let strURL = appConfig.rawValue
            guard let url = URL(string: strURL) else { return }
            
            self.networkService.request(url: url) { [weak self] result in
                switch result {
                case .success(let data):
                    // print("🍏", String(data: data, encoding: .utf8))
                    
                    do {
                        let object = try JSONSerialization.jsonObject(with: data, options: [])
                        //print("🍏 🍏", object)
                        
                        if let dictionary = object as? [[String: Any]] {
                            
                            for element in dictionary {
                                if let userId = element["userId"] as? Int,
                                   let title = element["title"] as? String,
                                   let id = element["id"] as? Int,
                                   let completed = element["completed"] as? Bool {
                                    let user = UserFromJSON(userId: userId, id: id, title: title, completed: completed)
                                    userArray.append(user)
                                }
                            }
                        }
                    }
                    catch let error {
                        print("🍎", error)
                    }
                case .failure(let error):
                    print("🍎", error)
                }
            }
        }
    }
    
    
    private func fetchModelWithDecoder() {
        
        let strURL = "https://swapi.dev/api/planets/1"
        guard let url = URL(string: strURL) else { return }
        
        
        self.networkService.request(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let planet = try decoder.decode(PlanetInstance.self, from: data)
                    
                    //  print("🍏", dump(planet))
                    orbitalPeriod = planet.orbitalPeriod
                    
                } catch let error {
                    print("🍎", error)
                }
            case .failure(let error):
                print("🍎", error)
            }
        }
    }
    
    private func setControllers() {
        viewControllers = [
            feedViewController.navigationController,
            logInViewController.navigationController,
            favoriteViewController.navigationController
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

