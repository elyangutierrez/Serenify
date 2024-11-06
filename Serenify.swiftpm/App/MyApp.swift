import SwiftUI
import SwiftData

@main
struct MyApp: App {
    
    init() {
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .white
    }
    
    var body: some Scene {
        
        WindowGroup {
            ViewNavigator()
        }
        .modelContainer(for: Entry.self)
    }
}
