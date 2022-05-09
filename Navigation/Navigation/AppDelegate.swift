
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds )
        let tabBarController = UITabBarController()
        
        let feedViewController = FeedViewController()
        let profileViewController = ProfileViewController()
        
        
        let feedNavigationController = UINavigationController(rootViewController: feedViewController)
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        
        
        feedNavigationController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(named: "feed"), selectedImage: nil)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "profile"), selectedImage: nil)
        
        
        tabBarController.setViewControllers([feedNavigationController,
                                             profileNavigationController],
                                            animated: true)
        

        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance


        let navBarAppearance: UINavigationBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithDefaultBackground()
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance

        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}

