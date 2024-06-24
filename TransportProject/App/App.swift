import ComposableArchitecture
import SwiftUI


@main
struct MyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    static let store = Store(initialState: RootFeature.State() ) {
        RootFeature()
        // ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(store: MyApp.store ).environmentObject(appDelegate.locationManager!)
        }
    }
}
