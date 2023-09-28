//
//  LocalNotificationService.swift
//  Navigation
//
//  Created by Слава Орлов on 03.08.2023.
//

import Foundation
import UserNotifications

class LocalNotificationService {
    
    static let shared = LocalNotificationService()
    
    private init() {}
    
    let center = UNUserNotificationCenter.current()
    
    func registerForLatestUpdatesIfPossible() {
        
        center.requestAuthorization(options: [.sound , .badge , .provisional]) { granted, error in
            
            if let error {
                print("Error with notification! - \(error.localizedDescription)")
            }
            
            if granted {
                print("доступ к уведомлениям получен")
                self.sheludeNotification()
            }
        }
    }
    
    func sheludeNotification() {
        
        let content = UNMutableNotificationContent()
        
        content.title = "Посмотрите последние уведомления"
        
        content.body = "Посмотрите последние уведомления"
        
        content.sound = .default
        
        var dateComponents = DateComponents()
        
        dateComponents.hour = 19
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
        
    }
    
}
