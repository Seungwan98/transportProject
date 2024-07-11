import ComposableArchitecture
import CoreLocation
import BackgroundTasks
import SwiftUI
import UserNotifications


@main
struct MyApp: App {
    let center = UNUserNotificationCenter.current()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate 
    // @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    static let store = Store(initialState: RootFeature.State() ) {
        RootFeature()
        //            ._printChanges()
    }
    
    init() {
        requestAuthNotification()
        getNotificationSettings()
        registerBackgroundTasks()
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
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.yourapp.notification", using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        } 
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.TransportProject.ApiFetch", using: nil) { task in
            self.handleAppRefreshToApi(task: task as! BGAppRefreshTask)
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
    private func handleAppRefreshToApi(task: BGAppRefreshTask) {
        
        
        // 백그라운드 작업을 수행하는 코드
        task.setTaskCompleted(success: true)
        
        
        task.expirationHandler = {
            // 작업이 만료된 경우 수행할 작업
            print("App refresh task expired")
        }
    }
    func requestAuthNotification() {
        let notificationAuthOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        center.requestAuthorization(options: notificationAuthOptions) { _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
}
