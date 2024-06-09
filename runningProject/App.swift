import ComposableArchitecture
import SwiftUI


@main
struct MyApp: App {
    static let store = Store(initialState: BusFeature.State() ) {
        BusFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            BusView(store: MyApp.store )
        }
    }
}
