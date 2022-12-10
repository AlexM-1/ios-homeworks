
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        LocalNotificationsService(delegate: self).registerForLatestUpdatesIfPossible()
        return true
    }
}



extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Push notification received in foreground.")
        completionHandler([.alert, .sound, .badge])
    }


    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {

        UIApplication.shared.applicationIconBadgeNumber -= 1

        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            print("Была нажата сама нотификация")
        case "show_more":
            print("Была нажата кнопка <Показать больше>")
        case "hide":
            print("Была нажата кнопка <Спрятать>")
        default:
            break
        }
        completionHandler()
    }

}






