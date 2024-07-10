import UIKit
import BackgroundTasks
import CoreLocation

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var locationManager: LocationManager?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 앱 실행 시 사용자에게 알림 허용 권한을 받음
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound] // 필요한 알림 권한을 설정
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        return true
    }
    
    
    // Foreground(앱 켜진 상태)에서도 알림 오는 설정
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .sound])
    }
    //    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    //        registerBackgroundTasks()
    //
    //        return true
    //    }
    //
    //
    //
    //
    //
    //    func registerBackgroundTasks() {
    //        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.yourapp.locationUpdate", using: nil) { task in
    //            self.handleAppRefresh(task: task as! BGAppRefreshTask)
    //        }
    //    }
    //
    //    func scheduleAppRefresh() {
    //        let request = BGAppRefreshTaskRequest(identifier: "com.yourapp.locationUpdate")
    //        request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60) // 15분 후
    //        do {
    //            try BGTaskScheduler.shared.submit(request)
    //        } catch {
    //            print("Could not schedule app refresh: \(error)")
    //        }
    //    }
    //
    //    func handleAppRefresh(task: BGAppRefreshTask) {
    //        // 다음 작업을 예약합니다.
    //        print("refresh")
    //        //scheduleAppRefresh()
    //
    //        // 위치 업데이트 코드를 여기에 추가합니다.
    //        // locationManager?.startLocation()
    //
    //        task.expirationHandler = {
    //            task.setTaskCompleted(success: false)
    //            // self.locationManager?.stopLocation()
    //        }
    //        task.setTaskCompleted(success: true)
    //    }
}


