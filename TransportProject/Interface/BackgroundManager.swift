//
//  BackgroundManager.swift
//  TransportProject
//
//  Created by 양승완 on 7/3/24.
//

import Foundation
import CoreLocation
import UserNotifications
import BackgroundTasks


class BackgroundManager {
    static let shared = BackgroundManager()
    
    func scheduleNotification(currentLocation: CLLocation) {
        let content = UNMutableNotificationContent()
        content.title = "Local Notification\(String(describing: currentLocation.coordinate.latitude))"
        content.body = ""
        content.sound = .default
        
        
        // Create a trigger for the notification (every 2 minutes)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        // Create a request with a unique identifier
        
        let request = UNNotificationRequest(identifier: "com.yourapp.notification", content: content, trigger: trigger)
        
        // Add the request to the notification center
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleApiFetch() {
        let request = BGAppRefreshTaskRequest(identifier: "com.TransportProject.ApiFetch") // 설정한 identifier
           request.earliestBeginDate = Date(timeIntervalSinceNow: 60 * 60) // 호출할 timeInterval을 1시간으로 설정

           do {
               try BGTaskScheduler.shared.submit(request)
           } catch {
               print("Could not schedule app refresh: \(error)")
           }
    }
    
    
}
