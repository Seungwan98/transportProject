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
    
    @Published var timer = true
    
    func StartTimer() {
        self.timer = true
        _ = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { [weak self] timer in
            guard let self = self else {return}
            if !self.timer {
                timer.invalidate()
                print("invalidate")
                
                
            }
            self.scheduleNotification()
        }
    }
    
    func stopTime() {
        self.timer = false
    }
    
    func scheduleNotification() {
        
        
        let isBackground = UserDefaults.standard.bool(forKey: "isBackground")
        
        
        
        print("locaiton")
        let content = UNMutableNotificationContent()
        content.title = "Talarm"
        content.body = "목적지에 도착했습니다"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "alarm.mp3"))
        
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        var request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        if isBackground {
            request = UNNotificationRequest(identifier: "com.yourapp.notification", content: content, trigger: trigger)
            
        }
        
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleApiFetch(nowState: String) {
        print("notification")
        let content = UNMutableNotificationContent()
        content.title = "Talarm"
        content.body = "목적지에 도착했습니다"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "alarm.mp3"))
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        
        let request = UNNotificationRequest(identifier: "com.yourapp.notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    
}
