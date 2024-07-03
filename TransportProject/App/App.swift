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
//            ._printChanges()
    }
    
    init() {
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
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "example2.com", using: nil) { task in
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
        
        //         scheduleAppRefresh()
        
        // 백그라운드 작업을 수행하는 코드
        task.setTaskCompleted(success: true)
        
        
        task.expirationHandler = {
            // 작업이 만료된 경우 수행할 작업
            print("App refresh task expired")
        }
    }
    
    
    
}
