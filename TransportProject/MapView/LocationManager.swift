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
import ComposableArchitecture
import Combine


protocol LocationManaging {
    func getResult() async throws -> [CLLocationCoordinate2D]
    func startLocation(positions: [CLLocationCoordinate2D])
    var updateHandler: (([CLLocationCoordinate2D]) -> Void)? { get set }
}


extension DependencyValues {
    var locationManaging: LocationManaging {
        get { self[LocationManageKey.self] }
        set { self[LocationManageKey.self] = newValue }
    }
    private enum LocationManageKey: DependencyKey {
        static var liveValue: LocationManaging = LocationManager()
    }
}
class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject, LocationManaging {
    var updateHandler: (([CLLocationCoordinate2D]) -> Void)?
    
    func getResult() async throws -> [CLLocationCoordinate2D] {
        return resultPositions
    }
    
    
   
    
    private var locationManager: CLLocationManager
    @Published var currentLocation: CLLocation?
    @Published var alarm: Bool = false
    @Published var resultPositions = [CLLocationCoordinate2D(), CLLocationCoordinate2D()]
    
    private var destination: CLLocationCoordinate2D?
    private var positions: [CLLocationCoordinate2D]?
    override init() {
        
        locationManager = CLLocationManager()
        super.init()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, let destination = self.destination, locations.last?.coordinate != nil, let positions = self.positions else { return }
        currentLocation = location
        
        self.alarm.toggle()
        var lowest = Double.infinity
        for i in 1..<positions.count {
            let firstvalue = positions[i-1]
            let secondvalue = positions[i]
            let distance = self.calDist(x1: firstvalue.latitude, y1: firstvalue.longitude, x2: secondvalue.latitude, y2: secondvalue.longitude, a: location.coordinate.latitude, b: location.coordinate.longitude  )
            if lowest > distance {
                lowest = distance
                
                print("\(distance) distance")
                self.resultPositions[0] = firstvalue
                self.resultPositions[1] = secondvalue
                
            }
        }
        
        if destination.distance(from: location.coordinate) < 50 {
            
            scheduleNotification()
            
            
        }
        updateHandler?(self.resultPositions)

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
    func startLocation(positions: [CLLocationCoordinate2D]) {
        self.destination = positions.last
        self.positions = positions
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
    
    func calDist(x1: Double, y1: Double, x2: Double, y2: Double, a: Double, b: Double) -> Double {
        let area = abs((x1-a) * (y2-b) - (y1-b) * (x2-a))
        let AB = sqrt((x1-x2) * (x1-x2) + (y1-y2) * (y1-y2))
        let distance = area / AB
        return distance
    }
}
