//
//  File.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/26/24.
//

import Foundation
import UserNotifications

@Observable
class NotificationsModel {
    
    var journalID = "journalID"
    var nextDate = Date()
    var dateFromUser = Date()
//    var isEnabled = false
    
    func enableNotifications()  {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Nofications Enabled")
            } else if let error = error {
                print("Notification Error: \(error)")
            }
        }
    }
    
    @MainActor func sendDailyNotifications() async {
        let content = UNMutableNotificationContent()
        content.title = "Journal Reminder 📓"
        content.body = "Make sure to journal today!"
        content.sound = .default
        
//        guard let dateFromUser else { return }
        
        let hour = Calendar.current.component(.hour, from: dateFromUser)
        let minute = Calendar.current.component(.minute, from: dateFromUser)
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: journalID, content: content, trigger: trigger)
        
        print("Got request!")
        
        // Schedule the request with the system
        let notificationCenter = UNUserNotificationCenter.current()
        do {
            try await notificationCenter.add(request)
            print("Added request!")
            print("Next day to be triggered \(trigger.nextTriggerDate()!)")
            nextDate = trigger.nextTriggerDate()!
            
//            getPendingRequests()
        } catch {
            print("Error adding request: \(error)")
        }
        
    }
    
    func cancelDailyNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("Canceled all daily notifications!")
        
        // To check if all notifications are cancelled
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            print("Request count after cancelling: \(requests.count)")
        }
    }
    
    @MainActor func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Notification was triggered, schedule the next one
        print("Notification triggered, scheduling next one...")
        Task {
            await self.sendDailyNotifications()
        }
        completionHandler()
    }
    
    func getPendingRequests() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            for request in requests {
                print("Notifications ID: \(request.identifier), Notification Title: \(request.content.title)")
            }
        }
        print("After!")
    }

}

