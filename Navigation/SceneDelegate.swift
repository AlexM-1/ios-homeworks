
import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var appConfiguration: AppConfiguration?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()
        FirebaseApp.configure()
        let mainCoordinator = MainCoordinator()
        appConfiguration = AppConfiguration.baseHomeWokr2task1

//
//        if let user = LoginManager.default.users.first {
//            LoginManager.default.deleteUser(user: user)
//        }

//        if let user = LoginManager.default.users.first {
//            user.changePassword(newPassword: "123456")
//        }

        let users = LoginManager.default.users
        print(users)

//        LikedPostsManager.default.posts.forEach { post in
//            LikedPostsManager.default.deletePost(post: post)
//        }
//
//        print("LikedPosts", LikedPostsManager.default.posts.count)





        window?.rootViewController = mainCoordinator.startApplication()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        try? Firebase.Auth.auth().signOut()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

