//
//  LocationManager.swift
//  TransportProject
//
//  Created by 양승완 on 6/25/24.
//

import Foundation
import CoreLocation
import UserNotifications
import BackgroundTasks
class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private var locationManager: CLLocationManager
    @Published var currentLocation: CLLocation?
    @Published var alarm: Bool = false
    private var destination: CLLocationCoordinate2D?
    override init() {

        locationManager = CLLocationManager()
        super.init()

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        

       
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, let destination = self.destination, locations.last?.coordinate != nil else { return }
        currentLocation = location
      
        self.alarm = true
        if destination.distance(from: location.coordinate) < 50 {
            
            scheduleNotification()
         
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
    func startLocation(destination: CLLocationCoordinate2D) {
        self.destination = destination
        print("startLocation")
        locationManager.startUpdatingLocation()
    }
    func stopLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    
    
    
    
    
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Local Notification\(String(describing: self.currentLocation?.coordinate.latitude))"
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
    private func registerBackgroundTasks() {
   
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.yourapp.notification", using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
        
        
    }
    
    
    
    
    private func handleAppRefresh(task: BGAppRefreshTask) {
        
        //         scheduleAppRefresh()
        
        // 백그라운드 작업을 수행하는 코드
        task.setTaskCompleted(success: true)
        
        
        task.expirationHandler = {
            // 작업이 만료된 경우 수행할 작업
            print("App refresh task expired")
        }
    }
}
