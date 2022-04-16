
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
        
        UITabBar.appearance().backgroundColor = .systemGray4
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}

