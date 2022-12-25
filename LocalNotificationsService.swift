//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Alex M on 09.12.2022.
//

import UserNotifications
import UIKit

final class LocalNotificationsService {
    
    private var delegate: UNUserNotificationCenterDelegate?
    
    init(delegate: UNUserNotificationCenterDelegate? = nil) {
        self.delegate = delegate
    }
    
    
    func registerForLatestUpdatesIfPossible() {
        
        registerUpdatesCategory()
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.sound, .badge, .provisional ]) { success, error in
            if success {
                print("Доступ есть")
                self.registerNotification()
                
            } else {
                print("Доступа нет")
            }
        }
        
    }
    
    
    private func registerNotification() {
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Приложение ВК"
        content.body = "Посмотрите последние обновления"
        content.sound = .default
        
        DispatchQueue.main.async {
            content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
        }

        content.categoryIdentifier = "updates"
        
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 00
        
        
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: "updates",
            content: content,
            trigger: trigger)
        
        center.add(request, withCompletionHandler: nil)
    }
    
    
    
    private func registerUpdatesCategory() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self.delegate
        
        let actionShow = UNNotificationAction(identifier: "show_more", title: "Показать больше", options: .foreground)
        let actionHide = UNNotificationAction(identifier: "hide", title: "Спрятать все", options: .destructive)
        
        let actions: [UNNotificationAction] = [actionShow, actionHide]
        
        let category = UNNotificationCategory(identifier: "updates", actions: actions, intentIdentifiers: [])
        
        let categories: Set<UNNotificationCategory> = [category]
        
        center.setNotificationCategories(categories)
    }
    
}

