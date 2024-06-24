//import UIKit
//import BackgroundTasks
//import CoreLocation
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//    var locationManager: LocationManager?
//    
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
//}
//

