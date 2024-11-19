import SwiftUI
import SwiftData

@main
struct MyApp: App {
    
    init() {
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .white
        
        UISegmentedControl.appearance().selectedSegmentTintColor = .white
        
        UISegmentedControl.appearance().backgroundColor = UIColor(Color("lighterGray"))
        UISegmentedControl.appearance().setTitleTextAttributes(
            [
                .font: UIFont.boldSystemFont(ofSize: 12),
                .foregroundColor: UIColor.black
            ], for: .normal)
    }
    
    var body: some Scene {
        
        WindowGroup {
            ViewNavigator()
        }
        .modelContainer(for: [Entry.self, Mood.self])
    }
}
