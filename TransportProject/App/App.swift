import ComposableArchitecture
import CoreLocation
import BackgroundTasks
import SwiftUI
import UserNotifications


@main
struct MyApp: App {
    
    // @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    static let store = Store(initialState: RootFeature.State() ) {
        RootFeature()
        // ._printChanges()
    }
    
    init() {
        let locationManager = LocationManager()
        getNotificationSettings()
        registerBackgroundTasks()
        //scheduleAppRefresh()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(store: MyApp.store )
        }
    }
    private func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
        }
    }
    
    private func registerBackgroundTasks() {
        //        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.yourapp.locationUpdate", using: nil) { task in
        //            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        //        }
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
    
    
    
    //    private func scheduleAppRefresh() {
    //
    //
    //        let request = BGAppRefreshTaskRequest(identifier: "com.yourapp.locationUpdate")
    //
    //        request.earliestBeginDate = Date(timeIntervalSinceNow: 15) // 15초 후
    //
    //        do {
    //            try BGTaskScheduler.shared.submit(request)
    //            print("BGTaskScheduler")
    //
    //        } catch {
    //            print("Could not schedule app refresh: \(error)")
    //        }
    //
    //    }
  
}
class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private var locationManager: CLLocationManager
    @Published var currentLocation: CLLocation?
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation() // 위치 업데이트 시작


        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
                if currentLocation?.coordinate.latitude ?? 0 > 37.669908{
                    scheduleNotification()
                }
        print("current\(currentLocation?.coordinate.latitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
    func startLocation() {
        self.locationManager.startUpdatingLocation()
    }
    func stopLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
    

    
    
    
    
    func scheduleNotification() {
        let location = LocationManager()
        let content = UNMutableNotificationContent()
        content.title = "Local Notification\(String(describing: self.currentLocation?.coordinate.latitude))"
        content.body = ""
        content.sound = .default
        // Create a trigger for the notification (every 2 minutes)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        // Create a request with a unique identifier
        
        let request = UNNotificationRequest(identifier: "com.yourapp.notification", content: content, trigger: trigger)
        
        // Add the request to the notification center
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
}
